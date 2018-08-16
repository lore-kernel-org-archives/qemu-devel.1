Received: from eggs.gnu.org ([2001:4830:134:3::10]:58830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQM-0008MW-KX
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQL-0001p7-MM
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:50 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqIQL-0001mH-DZ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:49 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQE-0008Qq-6p
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:34:42 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:34:08 +0100
Message-Id: <20180816133438.17061-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/30] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Less than a day of post-3.0 code review and already enough
patches for another pullreq :-)

thanks
-- PMM

The following changes since commit c542a9f9794ec8e0bc3fcf5956d3cc8bce667789:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-tests-2018-08-16' into staging (2018-08-16 09:50:54 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180816

for you to fetch changes up to fcf13ca556f462b52956059bf8fa622bc8575edb:

  hw/arm/mps2-tz: Replace init_sysbus_child() with sysbus_init_child_obj() (2018-08-16 14:29:58 +0100)

----------------------------------------------------------------
target-arm queue:
 * Fixes for various bugs in SVE instructions
 * Add model of Freescale i.MX6 UltraLite 14x14 EVK Board
 * hw/arm: make bitbanded IO optional on ARMv7-M
 * Add model of Cortex-M0 CPU
 * Add support for loading Intel HEX files to the generic loader
 * imx_spi: Unset XCH when TX FIFO becomes empty
 * aspeed_sdmc: fix various bugs
 * Fix bugs in Arm FP16 instruction support
 * Fix aa64 FCADD and FCMLA decode
 * softfloat: Fix missing inexact for floating-point add
 * hw/arm/mps2-tz: Replace init_sysbus_child() with sysbus_init_child_obj()

----------------------------------------------------------------
Cédric Le Goater (1):
      aspeed: add a max_ram_size property to the memory controller

Jean-Christophe Dubois (3):
      i.MX6UL: Add i.MX6UL specific CCM device
      i.MX6UL: Add i.MX6UL SOC
      i.MX6UL: Add Freescale i.MX6 UltraLite 14x14 EVK Board

Joel Stanley (5):
      aspeed_sdmc: Extend number of valid registers
      aspeed_sdmc: Fix saved values
      aspeed_sdmc: Set 'cache initial sequence' always true
      aspeed_sdmc: Init status always idle
      aspeed_sdmc: Handle ECC training

Richard Henderson (13):
      target/arm: Fix typo in helper_sve_ld1hss_r
      target/arm: Fix sign-extension in sve do_ldr/do_str
      target/arm: Fix offset for LD1R instructions
      target/arm: Fix offset scaling for LD_zprr and ST_zprr
      target/arm: Reformat integer register dump
      target/arm: Dump SVE state if enabled
      target/arm: Add sve-max-vq cpu property to -cpu max
      target/arm: Adjust FPCR_MASK for FZ16
      target/arm: Ignore float_flag_input_denormal from fp_status_f16
      target/arm: Use fp_status_fp16 for do_fmpa_zpzzz_h
      target/arm: Use FZ not FZ16 for SVE FCVT single-half and double-half
      target/arm: Fix aa64 FCADD and FCMLA decode
      softfloat: Fix missing inexact for floating-point add

Stefan Hajnoczi (4):
      hw/arm: make bitbanded IO optional on ARMv7-M
      target/arm: add "cortex-m0" CPU model
      loader: extract rom_free() function
      loader: add rom transaction API

Su Hang (2):
      loader: Implement .hex file loader
      Add QTest testcase for the Intel Hexadecimal

Thomas Huth (1):
      hw/arm/mps2-tz: Replace init_sysbus_child() with sysbus_init_child_obj()

Trent Piepho (1):
      imx_spi: Unset XCH when TX FIFO becomes empty

 configure                            |   4 +
 hw/arm/Makefile.objs                 |   1 +
 hw/misc/Makefile.objs                |   1 +
 tests/Makefile.include               |   2 +
 include/hw/arm/armv7m.h              |   2 +
 include/hw/arm/fsl-imx6ul.h          | 339 ++++++++++++++
 include/hw/loader.h                  |  31 ++
 include/hw/misc/aspeed_sdmc.h        |   4 +-
 include/hw/misc/imx6ul_ccm.h         | 226 +++++++++
 target/arm/cpu.h                     |   5 +-
 fpu/softfloat.c                      |   2 +-
 hw/arm/armv7m.c                      |  37 +-
 hw/arm/aspeed.c                      |  31 ++
 hw/arm/aspeed_soc.c                  |   2 +
 hw/arm/fsl-imx6ul.c                  | 617 ++++++++++++++++++++++++
 hw/arm/mcimx6ul-evk.c                |  85 ++++
 hw/arm/mps2-tz.c                     |  32 +-
 hw/arm/mps2.c                        |   1 +
 hw/arm/msf2-soc.c                    |   1 +
 hw/arm/stellaris.c                   |   1 +
 hw/arm/stm32f205_soc.c               |   1 +
 hw/core/generic-loader.c             |   4 +
 hw/core/loader.c                     | 302 +++++++++++-
 hw/misc/aspeed_sdmc.c                |  55 ++-
 hw/misc/imx6ul_ccm.c                 | 886 +++++++++++++++++++++++++++++++++++
 hw/ssi/imx_spi.c                     |   3 +-
 linux-user/syscall.c                 |  19 +-
 target/arm/cpu.c                     |  17 +-
 target/arm/cpu64.c                   |  29 ++
 target/arm/helper.c                  |  18 +-
 target/arm/sve_helper.c              |   4 +-
 target/arm/translate-a64.c           | 120 ++++-
 target/arm/translate-sve.c           |  30 +-
 tests/hexloader-test.c               |  45 ++
 MAINTAINERS                          |   6 +
 default-configs/arm-softmmu.mak      |   1 +
 hw/misc/trace-events                 |   7 +
 tests/hex-loader-check-data/test.hex |  18 +
 38 files changed, 2863 insertions(+), 126 deletions(-)
 create mode 100644 include/hw/arm/fsl-imx6ul.h
 create mode 100644 include/hw/misc/imx6ul_ccm.h
 create mode 100644 hw/arm/fsl-imx6ul.c
 create mode 100644 hw/arm/mcimx6ul-evk.c
 create mode 100644 hw/misc/imx6ul_ccm.c
 create mode 100644 tests/hexloader-test.c
 create mode 100644 tests/hex-loader-check-data/test.hex
