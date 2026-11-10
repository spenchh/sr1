-- =============================================================================
-- NEA Controller
-- Arms and executes NEA
-- =============================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use work.constPackage.all;

-- ────────────────────────────────────────────────────────────────────────────────────────────
-- dualRankSync - two-register synchronizer for single input, with synch. low reset
-- adc128       - Generates ADC's SPI transaction and returns one channel's sample one at a time
-- ADCparallel  - Starts ADC scan and collects sapmles into an eight-element array
-- constPackage - Shared types, timing constraints, and utility functions
-- ────────────────────────────────────────────────────────────────────────────────────────────

entity nea_controller is
    port(
        i_adc1_spi_sck_in    : in std_logic; -- serial clock
        i_adc1_spi_mosi_in   : in std_logic;
        i_adc1_spi_scn_in    : in std_logic; -- active low chip select
        i_adc1_spi_miso_in   : in std_logic;
        i_rst_n              : in std_logic;

        -- —— NEA —— 
        i_nea1          : in std_logic;
        i_nea2          : in std_logic;
        i_nea3          : in std_logic;
        i_nea4_1        : in std_logic;
        i_nea4_2        : in std_logic;

        -- ── ARM is default low ──
        i_arm_nea1      : in std_logic; 
        i_arm_nea2      : in std_logic;    
        i_arm_nea3      : in std_logic;    
        i_arm_nea4      : in std_logic;  

        -- ── EXECUTE is default low ──
        i_execute_nea1  : in std_logic; 
        i_execute_nea2  : in std_logic;  
        i_execute_nea3  : in std_logic;  
        i_execute_nea4  : in std_logic;

        i_pulse_nea2         : in std_logic;
        i_pulse_confirm_nea1 : in std_logic;


        i_latch_toggle1      : in std_logic;
        i_latch_toggle2      : in std_logic;


        
        -- ── ARM status + EXECUTE status

        -- ── When adc goes over threshold level and pulses nea1, status goes high ──
        o_nea1_status   : out std_logic;
        o_nea2_status   : out std_logic;
        o_nea3_status   : out std_logic;
        o_nea4_status   : out std_logic
    );
end nea_controller;

architecture rtl of nea_controller is 
    -- ── Sets threshold for what 12-bit ADC value caounts as "high" ──
    -- constant ADC_THRESH_HIGH : unsigned(11 downto 0) := x"800";

    -- ── 4-bit vector to hold high/low status of each ADC channel ──
    -- signal w_adc_high_mask : std_logic_vector(3 downto 0);

    -- ── 4-bit vector to hold execute commands ──
    -- signal w_execute_nea   : std_logic_vector(3 downto 0);
begin

    -- ── Assigns bit index of w_adc_high_mask high when nea is above threshold ──
    -- w_adc_high_mask(0) <= '1' when unsigned(i_adc_nea1) >= ADC_THRES_HIGH else '0';
    -- w_adc_high_mask(1) <= '1' when unsigned(i_adc_nea2) >= ADC_THRES_HIGH else '0';
    -- w_adc_high_mask(2) <= '1' when unsigned(i_adc_nea3) >= ADC_THRES_HIGH else '0';
    -- w_adc_high_mask(3) <= '1' when unsigned(i_adc_nea4) >= ADC_THRES_HIGH else '0';

    -- ── Concatenated execute ──
    -- w_execute_nea <= i_execute_nea4 & i_execute_nea3 & i_execute_nea2 & i_execute_nea1;

    process (i_adc1_spi_sck_in) begin
        -- ── ASYNC low reset ──
        if (i_rst_n = '0') then
            null;
        elsif rising_edge(i_adc1_spi_sck_in) then
            if (i_nea1 = '1') then
                null;
            end if;
        end if;
    end process;
end architecture rtl;
