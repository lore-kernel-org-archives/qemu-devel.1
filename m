Received: from eggs.gnu.org ([2001:4830:134:3::10]:35697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO1-0003uf-Ip
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO0-0006yM-5i
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:49 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSNz-0006w2-SA
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:48 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSNx-0007Ex-U0
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:45 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:08 +0000
Message-Id: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/37] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

First target-arm pullreq of the 4.0 series; most of this
is Mao's cleanups that finally let us drop sysbus::init;
the most interesting user-visible feature is RTH's patches
adding some v8.1 and v8.2 architecture features.

thanks
-- PMM

The following changes since commit 6145a6d84b3bf0f25935b88543febe076c61b0f4:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20181212' into staging (2018-12-13 13:06:09 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20181213

for you to fetch changes up to 2d7137c10fafefe40a0a049ff8a7bd78b66e661f:

  target/arm: Implement the ARMv8.1-LOR extension (2018-12-13 14:41:24 +0000)

----------------------------------------------------------------
target-arm queue:
 * Convert various devices from sysbus init to instance_init
 * Remove the now unused sysbus init support entirely
 * Allow AArch64 processors to boot from a kernel placed over 4GB
 * hw: arm: musicpal: drop TYPE_WM8750 in object_property_set_link()
 * versal: minor fixes to virtio-mmio instantation
 * arm: Implement the ARMv8.1-HPD extension
 * arm: Implement the ARMv8.2-AA32HPD extension
 * arm: Implement the ARMv8.1-LOR extension (as the trivial
   "no limited ordering regions provided" minimum)

----------------------------------------------------------------
Edgar E. Iglesias (4):
      hw/arm: versal: Remove bogus virtio-mmio creation
      hw/arm: versal: Reduce number of virtio-mmio instances
      hw/arm: versal: Use IRQs 111 - 118 for virtio-mmio
      hw/arm: versal: Correct the nr of IRQs to 192

Li Qiang (1):
      hw: arm: musicpal: drop TYPE_WM8750 in object_property_set_link()

Mao Zhongyi (21):
      musicpal: Convert sysbus init function to realize function
      block/noenand: Convert sysbus init function to realize function
      char/grlib_apbuart: Convert sysbus init function to realize function
      core/empty_slot: Convert sysbus init function to realize function
      display/g364fb: Convert sysbus init function to realize function
      dma/puv3_dma: Convert sysbus init function to realize function
      gpio/puv3_gpio: Convert sysbus init function to realize function
      milkymist-softusb: Convert sysbus init function to realize function
      input/pl050: Convert sysbus init function to realize function
      intc/puv3_intc: Convert sysbus init function to realize function
      milkymist-hpdmc: Convert sysbus init function to realize function
      milkymist-pfpu: Convert sysbus init function to realize function
      puv3_pm.c: Convert sysbus init function to realize function
      nvram/ds1225y: Convert sysbus init function to realize function
      pci-bridge/dec: Convert sysbus init function to realize function
      timer/etraxfs_timer: Convert sysbus init function to realize function
      timer/grlib_gptimer: Convert sysbus init function to realize function
      timer/puv3_ost: Convert sysbus init function to realize function
      usb/tusb6010: Convert sysbus init function to realize function
      xen_backend: remove xen_sysdev_init() function
      core/sysbus: remove the SysBusDeviceClass::init path

Peter Maydell (1):
      target/arm: Move id_aa64mmfr* to ARMISARegisters

Ricardo Perez Blanco (1):
      Allow AArch64 processors to boot from a kernel placed over 4GB

Richard Henderson (9):
      target/arm: Add HCR_EL2 bits up to ARMv8.5
      target/arm: Add SCR_EL3 bits up to ARMv8.5
      target/arm: Fix HCR_EL2.TGE check in arm_phys_excp_target_el
      target/arm: Tidy scr_write
      target/arm: Implement the ARMv8.1-HPD extension
      target/arm: Implement the ARMv8.2-AA32HPD extension
      target/arm: Introduce arm_hcr_el2_eff
      target/arm: Use arm_hcr_el2_eff more places
      target/arm: Implement the ARMv8.1-LOR extension

 include/hw/arm/xlnx-versal.h |   8 +-
 include/hw/sysbus.h          |   3 -
 target/arm/cpu.h             | 141 ++++++++++++++++-----------
 target/arm/internals.h       |   3 +-
 hw/arm/boot.c                |  35 ++++---
 hw/arm/musicpal.c            |  11 +--
 hw/arm/xlnx-versal-virt.c    |   7 +-
 hw/block/onenand.c           |  16 ++--
 hw/char/grlib_apbuart.c      |  12 +--
 hw/core/empty_slot.c         |   9 +-
 hw/core/sysbus.c             |  15 +--
 hw/display/g364fb.c          |   9 +-
 hw/dma/puv3_dma.c            |  10 +-
 hw/gpio/puv3_gpio.c          |  29 +++---
 hw/input/milkymist-softusb.c |  16 ++--
 hw/input/pl050.c             |  11 +--
 hw/intc/arm_gicv3_cpuif.c    |  21 ++--
 hw/intc/puv3_intc.c          |  11 +--
 hw/misc/milkymist-hpdmc.c    |   9 +-
 hw/misc/milkymist-pfpu.c     |  12 +--
 hw/misc/puv3_pm.c            |  10 +-
 hw/nvram/ds1225y.c           |  12 +--
 hw/pci-bridge/dec.c          |  12 +--
 hw/timer/etraxfs_timer.c     |  14 +--
 hw/timer/grlib_gptimer.c     |  11 +--
 hw/timer/puv3_ost.c          |  13 ++-
 hw/usb/tusb6010.c            |   8 +-
 hw/xen/xen_backend.c         |   7 --
 target/arm/cpu.c             |   4 +
 target/arm/cpu64.c           |  11 ++-
 target/arm/helper.c          | 222 ++++++++++++++++++++++++++++++++++++-------
 target/arm/kvm64.c           |   4 +
 target/arm/op_helper.c       |  14 ++-
 target/arm/translate-a64.c   |  12 +++
 34 files changed, 456 insertions(+), 286 deletions(-)
