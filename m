Received: from eggs.gnu.org ([209.51.188.92]:34101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eB-0004Da-SH
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9e7-0006Pf-Cd
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:54 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:41680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9e4-00068b-1z
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:49 -0400
Received: by mail-wr1-x42c.google.com with SMTP id c12so17087604wrt.8
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.31
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 17:59:48 +0100
Message-Id: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/42] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

First pullreq for arm of the 4.1 series, since I'm back from
holiday now. This is mostly my M-profile FPU series and Philippe's
devices.h cleanup. I have a pile of other patchsets to work through
in my to-review folder, but 42 patches is definitely quite
big enough to send now...

thanks
-- PMM

The following changes since commit 413a99a92c13ec408dcf2adaa87918dc81e890c8:

  Add Nios II semihosting support. (2019-04-29 16:09:51 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190429

for you to fetch changes up to 437cc27ddfded3bbab6afd5ac1761e0e195edba7:

  hw/devices: Move SMSC 91C111 declaration into a new header (2019-04-29 17:57:21 +0100)

----------------------------------------------------------------
target-arm queue:
 * remove "bag of random stuff" hw/devices.h header
 * implement FPU for Cortex-M and enable it for Cortex-M4 and -M33
 * hw/dma: Compile the bcm2835_dma device as common object
 * configure: Remove --source-path option
 * hw/ssi/xilinx_spips: Avoid variable length array
 * hw/arm/smmuv3: Remove SMMUNotifierNode

----------------------------------------------------------------
Eric Auger (1):
      hw/arm/smmuv3: Remove SMMUNotifierNode

Peter Maydell (28):
      hw/ssi/xilinx_spips: Avoid variable length array
      configure: Remove --source-path option
      target/arm: Make sure M-profile FPSCR RES0 bits are not settable
      hw/intc/armv7m_nvic: Allow reading of M-profile MVFR* registers
      target/arm: Implement dummy versions of M-profile FP-related registers
      target/arm: Disable most VFP sysregs for M-profile
      target/arm: Honour M-profile FP enable bits
      target/arm: Decode FP instructions for M profile
      target/arm: Clear CONTROL_S.SFPA in SG insn if FPU present
      target/arm: Handle SFPA and FPCA bits in reads and writes of CONTROL
      target/arm/helper: don't return early for STKOF faults during stacking
      target/arm: Handle floating point registers in exception entry
      target/arm: Implement v7m_update_fpccr()
      target/arm: Clear CONTROL.SFPA in BXNS and BLXNS
      target/arm: Clean excReturn bits when tail chaining
      target/arm: Allow for floating point in callee stack integrity check
      target/arm: Handle floating point registers in exception return
      target/arm: Move NS TBFLAG from bit 19 to bit 6
      target/arm: Overlap VECSTRIDE and XSCALE_CPAR TB flags
      target/arm: Set FPCCR.S when executing M-profile floating point insns
      target/arm: Activate M-profile floating point context when FPCCR.ASPEN is set
      target/arm: New helper function arm_v7m_mmu_idx_all()
      target/arm: New function armv7m_nvic_set_pending_lazyfp()
      target/arm: Add lazy-FP-stacking support to v7m_stack_write()
      target/arm: Implement M-profile lazy FP state preservation
      target/arm: Implement VLSTM for v7M CPUs with an FPU
      target/arm: Implement VLLDM for v7M CPUs with an FPU
      target/arm: Enable FPU for Cortex-M4 and Cortex-M33

Philippe Mathieu-Daudé (13):
      hw/dma: Compile the bcm2835_dma device as common object
      hw/arm/aspeed: Use TYPE_TMP105/TYPE_PCA9552 instead of hardcoded string
      hw/arm/nseries: Use TYPE_TMP105 instead of hardcoded string
      hw/display/tc6393xb: Remove unused functions
      hw/devices: Move TC6393XB declarations into a new header
      hw/devices: Move Blizzard declarations into a new header
      hw/devices: Move CBus declarations into a new header
      hw/devices: Move Gamepad declarations into a new header
      hw/devices: Move TI touchscreen declarations into a new header
      hw/devices: Move LAN9118 declarations into a new header
      hw/net/ne2000-isa: Add guards to the header
      hw/net/lan9118: Export TYPE_LAN9118 and use it instead of hardcoded string
      hw/devices: Move SMSC 91C111 declaration into a new header

 configure                     |  10 +-
 hw/dma/Makefile.objs          |   2 +-
 include/hw/arm/omap.h         |   6 +-
 include/hw/arm/smmu-common.h  |   8 +-
 include/hw/devices.h          |  62 ---
 include/hw/display/blizzard.h |  22 ++
 include/hw/display/tc6393xb.h |  24 ++
 include/hw/input/gamepad.h    |  19 +
 include/hw/input/tsc2xxx.h    |  36 ++
 include/hw/misc/cbus.h        |  32 ++
 include/hw/net/lan9118.h      |  21 +
 include/hw/net/ne2000-isa.h   |   6 +
 include/hw/net/smc91c111.h    |  19 +
 include/qemu/typedefs.h       |   1 -
 target/arm/cpu.h              |  95 ++++-
 target/arm/helper.h           |   5 +
 target/arm/translate.h        |   3 +
 hw/arm/aspeed.c               |  13 +-
 hw/arm/exynos4_boards.c       |   3 +-
 hw/arm/gumstix.c              |   2 +-
 hw/arm/integratorcp.c         |   2 +-
 hw/arm/kzm.c                  |   2 +-
 hw/arm/mainstone.c            |   2 +-
 hw/arm/mps2-tz.c              |   3 +-
 hw/arm/mps2.c                 |   2 +-
 hw/arm/nseries.c              |   7 +-
 hw/arm/palm.c                 |   2 +-
 hw/arm/realview.c             |   3 +-
 hw/arm/smmu-common.c          |   6 +-
 hw/arm/smmuv3.c               |  28 +-
 hw/arm/stellaris.c            |   2 +-
 hw/arm/tosa.c                 |   2 +-
 hw/arm/versatilepb.c          |   2 +-
 hw/arm/vexpress.c             |   2 +-
 hw/display/blizzard.c         |   2 +-
 hw/display/tc6393xb.c         |  18 +-
 hw/input/stellaris_input.c    |   2 +-
 hw/input/tsc2005.c            |   2 +-
 hw/input/tsc210x.c            |   4 +-
 hw/intc/armv7m_nvic.c         | 261 +++++++++++++
 hw/misc/cbus.c                |   2 +-
 hw/net/lan9118.c              |   3 +-
 hw/net/smc91c111.c            |   2 +-
 hw/ssi/xilinx_spips.c         |   6 +-
 target/arm/cpu.c              |  20 +
 target/arm/helper.c           | 873 +++++++++++++++++++++++++++++++++++++++---
 target/arm/machine.c          |  16 +
 target/arm/translate.c        | 150 +++++++-
 target/arm/vfp_helper.c       |   8 +
 MAINTAINERS                   |   7 +
 50 files changed, 1595 insertions(+), 235 deletions(-)
 delete mode 100644 include/hw/devices.h
 create mode 100644 include/hw/display/blizzard.h
 create mode 100644 include/hw/display/tc6393xb.h
 create mode 100644 include/hw/input/gamepad.h
 create mode 100644 include/hw/input/tsc2xxx.h
 create mode 100644 include/hw/misc/cbus.h
 create mode 100644 include/hw/net/lan9118.h
 create mode 100644 include/hw/net/smc91c111.h
