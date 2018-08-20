Received: from eggs.gnu.org ([2001:4830:134:3::10]:36982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhU3-0003kN-PK
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhU2-0005Tu-7m
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:27 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1frhU1-0005PL-UW
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:26 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1frhTs-00034O-4u
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:32:16 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 11:31:47 +0100
Message-Id: <20180820103212.2810-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/25] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Some more outstanding target-arm patches; nothing terribly
exciting. Mostly they're mine; I'm trying to reduce the
number of patches I still have in flight, so I've picked
out some of the reviewed patches from a couple of sets I've
sent out and will resend v2 versions of those sets with the
remaining patches with fixes for issues noted in review once
this is in master.

thanks
-- PMM


The following changes since commit adaec191bfb31e12d40af8ab1b869f5b40d61ee9:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-08-20 09:48:03 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180820

for you to fetch changes up to b85fad1588e812566f897f747e38da345a7016d6:

  hw/dma/pl080: Remove hw_error() if DMA is enabled (2018-08-20 11:24:33 +0100)

----------------------------------------------------------------
target-arm queue:
 * Fix crash on conditional instruction in an IT block
 * docs/generic-loader: mention U-Boot and Intel HEX executable formats
 * hw/intc/arm_gicv3_its: downgrade error_report to warn_report in kvm_arm_its_reset
 * imx_serial: Generate interrupt on receive data ready if enabled
 * Fix various minor bugs in AArch32 Hyp related coprocessor registers
 * Permit accesses to ELR_Hyp from Hyp mode via MSR/MRS (banked)
 * Implement AArch32 ERET instruction
 * hw/arm/virt: Add virt-3.1 machine type
 * sdhci: add i.MX SD Stable Clock bit
 * Remove now-obsolete MMIO request_ptr APIs
 * hw/timer/m48t59: Move away from old_mmio accessors
 * hw/watchdog/cmsdk_apb_watchdog: Implement CMSDK APB watchdog module
 * nvic: Expose NMI line
 * hw/dma/pl080: cleanups and new features required for use in MPS boards

----------------------------------------------------------------
Andrew Jones (1):
      hw/arm/virt: Add virt-3.1 machine type

Hans-Erik Floryd (2):
      imx_serial: Generate interrupt on receive data ready if enabled
      sdhci: add i.MX SD Stable Clock bit

Jia He (1):
      hw/intc/arm_gicv3_its: downgrade error_report to warn_report in kvm_arm_its_reset

Peter Maydell (19):
      target/arm: Correct typo in HAMAIR1 regdef name
      target/arm: Add missing .cp = 15 to HMAIR1 and HAMAIR1 regdefs
      target/arm: Implement AArch32 HVBAR
      target/arm: Implement AArch32 Hyp FARs
      target/arm: Implement ESR_EL2/HSR for AArch32 and no-EL2
      target/arm: Permit accesses to ELR_Hyp from Hyp mode via MSR/MRS (banked)
      target/arm: Implement AArch32 ERET instruction
      hw/ssi/xilinx_spips: Remove unneeded MMIO request_ptr code
      memory: Remove MMIO request_ptr APIs
      hw/misc: Remove mmio_interface device
      hw/timer/m48t59: Move away from old_mmio accessors
      hw/watchdog/cmsdk_apb_watchdog: Implement CMSDK APB watchdog module
      nvic: Expose NMI line
      hw/dma/pl080: Allow use as embedded-struct device
      hw/dma/pl080: Support all three interrupt lines
      hw/dma/pl080: Don't use CPU address space for DMA accesses
      hw/dma/pl080: Provide device reset function
      hw/dma/pl080: Correct bug in register address decode logic
      hw/dma/pl080: Remove hw_error() if DMA is enabled

Roman Kapl (1):
      target/arm: Fix crash on conditional instruction in an IT block

Stefan Hajnoczi (1):
      docs/generic-loader: mention U-Boot and Intel HEX executable formats

 docs/generic-loader.txt                  |  20 +-
 Makefile.objs                            |   1 +
 hw/misc/Makefile.objs                    |   1 -
 hw/watchdog/Makefile.objs                |   1 +
 hw/sd/sdhci-internal.h                   |   2 +
 include/exec/memory.h                    |  35 ----
 include/hw/char/imx_serial.h             |   1 +
 include/hw/dma/pl080.h                   |  71 +++++++
 include/hw/misc/mmio_interface.h         |  49 -----
 include/hw/watchdog/cmsdk-apb-watchdog.h |  59 ++++++
 hw/arm/armv7m.c                          |   1 +
 hw/arm/realview.c                        |   8 +-
 hw/arm/versatilepb.c                     |   9 +-
 hw/arm/virt.c                            |  23 ++-
 hw/char/imx_serial.c                     |   3 +-
 hw/dma/pl080.c                           | 113 ++++++-----
 hw/intc/arm_gicv3_its_kvm.c              |   2 +-
 hw/intc/armv7m_nvic.c                    |  19 ++
 hw/misc/mmio_interface.c                 | 135 -------------
 hw/sd/sdhci.c                            |   8 +
 hw/ssi/xilinx_spips.c                    |  46 -----
 hw/timer/m48t59.c                        |  59 ++----
 hw/watchdog/cmsdk-apb-watchdog.c         | 326 +++++++++++++++++++++++++++++++
 memory.c                                 | 110 -----------
 target/arm/helper.c                      |  36 +++-
 target/arm/op_helper.c                   |  22 +--
 target/arm/translate.c                   |  76 +++++--
 MAINTAINERS                              |   3 +
 default-configs/arm-softmmu.mak          |   1 +
 hw/intc/trace-events                     |   1 +
 hw/watchdog/trace-events                 |   6 +
 31 files changed, 717 insertions(+), 530 deletions(-)
 create mode 100644 include/hw/dma/pl080.h
 delete mode 100644 include/hw/misc/mmio_interface.h
 create mode 100644 include/hw/watchdog/cmsdk-apb-watchdog.h
 delete mode 100644 hw/misc/mmio_interface.c
 create mode 100644 hw/watchdog/cmsdk-apb-watchdog.c
 create mode 100644 hw/watchdog/trace-events
