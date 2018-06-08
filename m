Received: from eggs.gnu.org ([2001:4830:134:3::10]:50361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlj-0002zH-HE
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGli-0004CS-Bc
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:27 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGlh-00046X-RM
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:26 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGla-0003aW-5j
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:18 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:44:46 +0100
Message-Id: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/31] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

target-arm queue: aspeed patches from Cédric, and
cleanup and sd card patches from Philippe.

thanks
-- PMM 

The following changes since commit bac5ba3dc5da706f52c149fa6c0bd1dc96899bec:

  Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2018-06-08 10:26:16 +0100)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180608

for you to fetch changes up to 113f31c06c6bf16451892b2459d83c9b9c5e9844:

  sdcard: Disable CMD19/CMD23 for Spec v2 (2018-06-08 13:15:34 +0100)

----------------------------------------------------------------
target-arm queue:
 * arm_gicv3_kvm: fix migration of registers corresponding to
   IRQs 992 to 1020 in the KVM GIC
 * aspeed: remove ignore_memory_transaction_failures on all boards
 * aspeed: add support for the witherspoon-bmc board
 * aspeed: add an I2C RTC device and EEPROM I2C devices
 * aspeed: add the pc9552 chips to the witherspoon machine
 * ftgmac100: fix various bugs
 * hw/arm: Remove the deprecated xlnx-ep108 machine
 * hw/i2c: Add trace events
 * add missing '\n' on various qemu_log() logging strings
 * sdcard: clean up spec version support so we report the
   right spec version to the guest and only implement the
   commands that are supposed to be present in that version

----------------------------------------------------------------
Cédric Le Goater (11):
      aspeed: remove ignore_memory_transaction_failures on all boards
      aspeed: add support for the witherspoon-bmc board
      aspeed: add an I2C RTC device to all machines
      smbus: add a smbus_eeprom_init_one() routine
      aspeed: Add EEPROM I2C devices
      misc: add pca9552 LED blinker model
      aspeed: add the pc9552 chips to the witherspoon machine
      ftgmac100: compute maximum frame size depending on the protocol
      ftgmac100: add IEEE 802.1Q VLAN support
      ftgmac100: fix multicast hash routine
      ftgmac100: remove check on runt messages

Philippe Mathieu-Daudé (18):
      hw/i2c: Add trace events
      hw/sd/milkymist-memcard: Add trailing '\n' to qemu_log() call
      hw/digic: Add trailing '\n' to qemu_log() calls
      xilinx-dp: Add trailing '\n' to qemu_log() call
      ppc/pnv: Add trailing '\n' to qemu_log() calls
      hw/core/register: Add trailing '\n' to qemu_log() call
      hw/mips/boston: Add trailing '\n' to qemu_log() calls
      stellaris: Add trailing '\n' to qemu_log() calls
      target/arm: Add trailing '\n' to qemu_log() calls
      target/m68k: Add trailing '\n' to qemu_log() call
      RISC-V: Add trailing '\n' to qemu_log() calls
      target/xtensa: Add trailing '\n' to qemu_log() calls
      sdcard: Update the Configuration Register (SCR) to Spec Version 1.10
      sdcard: Allow commands valid in SPI mode
      sdcard: Add a 'spec_version' property, default to Spec v2.00
      sdcard: Disable SEND_IF_COND (CMD8) for Spec v1
      sdcard: Reflect when the Spec v3 is supported in the Config Register (SCR)
      sdcard: Disable CMD19/CMD23 for Spec v2

Shannon Zhao (1):
      arm_gicv3_kvm: kvm_dist_get/put: skip the registers banked by GICR

Thomas Huth (1):
      hw/arm: Remove the deprecated xlnx-ep108 machine

 Makefile.objs                      |   1 +
 hw/misc/Makefile.objs              |   1 +
 tests/Makefile.include             |   2 +
 include/hw/i2c/smbus.h             |   1 +
 include/hw/intc/arm_gicv3_common.h |   1 +
 include/hw/misc/pca9552.h          |  32 +++++
 include/hw/misc/pca9552_regs.h     |  32 +++++
 include/hw/net/ftgmac100.h         |   7 +-
 include/hw/sd/sd.h                 |   6 +
 tests/libqos/i2c.h                 |   2 +
 hw/arm/aspeed.c                    |  88 +++++++++++++-
 hw/arm/stellaris.c                 |  11 +-
 hw/arm/xlnx-zcu102.c               |  62 +---------
 hw/char/digic-uart.c               |   4 +-
 hw/core/register.c                 |   2 +-
 hw/display/xlnx_dp.c               |   4 +-
 hw/i2c/core.c                      |  25 ++--
 hw/i2c/smbus_eeprom.c              |  16 ++-
 hw/intc/arm_gicv3_common.c         |  79 ++++++++++++
 hw/intc/arm_gicv3_kvm.c            |  38 ++++++
 hw/mips/boston.c                   |   8 +-
 hw/misc/pca9552.c                  | 240 +++++++++++++++++++++++++++++++++++++
 hw/net/ftgmac100.c                 |  64 ++++++----
 hw/ppc/pnv_core.c                  |   4 +-
 hw/sd/milkymist-memcard.c          |   2 +-
 hw/sd/sd.c                         |  50 +++++---
 hw/timer/digic-timer.c             |   4 +-
 target/arm/helper.c                |   4 +-
 target/m68k/translate.c            |   2 +-
 target/riscv/op_helper.c           |   6 +-
 target/xtensa/translate.c          |   6 +-
 tests/pca9552-test.c               | 116 ++++++++++++++++++
 tests/tmp105-test.c                |   2 -
 default-configs/arm-softmmu.mak    |   1 +
 hw/i2c/trace-events                |   7 ++
 qemu-doc.texi                      |   5 -
 36 files changed, 788 insertions(+), 147 deletions(-)
 create mode 100644 include/hw/misc/pca9552.h
 create mode 100644 include/hw/misc/pca9552_regs.h
 create mode 100644 hw/misc/pca9552.c
 create mode 100644 tests/pca9552-test.c
 create mode 100644 hw/i2c/trace-events
