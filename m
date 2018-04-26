Received: from eggs.gnu.org ([2001:4830:134:3::10]:39631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQv-0002iY-I3
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQu-0001Tr-Ky
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:25 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fBeQu-0001OF-EG
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:24 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQm-0002yn-Fo
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:47:16 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 11:46:56 +0100
Message-Id: <20180426104715.21702-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/19] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

First arm pullreq of the 2.13 cycle!

-- PMM

The following changes since commit 4743c23509a51bd4ee85cc272287a41917d1be35:

  Update version for v2.12.0 release (2018-04-24 16:44:55 +0100)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180426

for you to fetch changes up to fbf32752663878947de455ff57cb5b9318f14bec:

  xilinx_spips: Correct SNOOP_NONE state when flushing the txfifo (2018-04-26 11:04:40 +0100)

----------------------------------------------------------------
target-arm queue:
 * xilinx_spips: Correct SNOOP_NONE state when flushing the txfifo
 * timer/aspeed: fix vmstate version id
 * hw/arm/aspeed_soc: don't use vmstate_register_ram_global for SRAM
 * hw/arm/aspeed: don't make 'boot_rom' region 'nomigrate'
 * hw/arm/highbank: don't make sysram 'nomigrate'
 * hw/arm/raspi: Don't bother setting default_cpu_type
 * PMU emulation: some minor bugfixes and preparation for
   support of other events than just the cycle counter
 * target/arm: Use v7m_stack_read() for reading the frame signature
 * target/arm: Remove stale TODO comment
 * arm: always start from first_cpu when registering loader cpu reset callback
 * device_tree: Increase FDT_MAX_SIZE to 1 MiB

----------------------------------------------------------------
Aaron Lindsay (9):
      target/arm: Check PMCNTEN for whether PMCCNTR is enabled
      target/arm: Treat PMCCNTR as alias of PMCCNTR_EL0
      target/arm: Mask PMU register writes based on PMCR_EL0.N
      target/arm: Fetch GICv3 state directly from CPUARMState
      target/arm: Support multiple EL change hooks
      target/arm: Add pre-EL change hooks
      target/arm: Allow EL change hooks to do IO
      target/arm: Fix bitmask for PMCCFILTR writes
      target/arm: Make PMOVSCLR and PMUSERENR 64 bits wide

Cédric Le Goater (1):
      timer/aspeed: fix vmstate version id

Geert Uytterhoeven (1):
      device_tree: Increase FDT_MAX_SIZE to 1 MiB

Igor Mammedov (1):
      arm: always start from first_cpu when registering loader cpu reset callback

Peter Maydell (6):
      target/arm: Remove stale TODO comment
      target/arm: Use v7m_stack_read() for reading the frame signature
      hw/arm/raspi: Don't bother setting default_cpu_type
      hw/arm/highbank: don't make sysram 'nomigrate'
      hw/arm/aspeed: don't make 'boot_rom' region 'nomigrate'
      hw/arm/aspeed_soc: don't use vmstate_register_ram_global for SRAM

Sai Pavan Boddu (1):
      xilinx_spips: Correct SNOOP_NONE state when flushing the txfifo

 target/arm/cpu.h           | 48 +++++++++++++++++-------------
 target/arm/internals.h     | 14 +++++++--
 device_tree.c              |  2 +-
 hw/arm/aspeed.c            |  2 +-
 hw/arm/aspeed_soc.c        |  3 +-
 hw/arm/boot.c              |  2 +-
 hw/arm/highbank.c          |  2 +-
 hw/arm/raspi.c             |  2 --
 hw/intc/arm_gicv3_cpuif.c  | 10 ++-----
 hw/ssi/xilinx_spips.c      |  3 +-
 hw/timer/aspeed_timer.c    |  2 +-
 target/arm/cpu.c           | 37 +++++++++++++++++++----
 target/arm/helper.c        | 73 ++++++++++++++++++++++++++--------------------
 target/arm/op_helper.c     |  8 +++++
 target/arm/translate-a64.c |  6 ++++
 target/arm/translate.c     | 12 ++++++++
 16 files changed, 148 insertions(+), 78 deletions(-)
