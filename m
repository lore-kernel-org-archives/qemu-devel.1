Received: from eggs.gnu.org ([2001:4830:134:3::10]:37382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNv-0008Bs-58
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNp-0002lV-8k
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:39 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ebRNp-0002gG-0u
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:33 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNh-0002p1-OF
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:34:25 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 13:33:55 +0000
Message-Id: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/24] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

More arm patches (mostly the SDHCI ones from Philippe)

thanks
-- PMM

The following changes since commit f521eeee3bd060b460c99e605472b7e03967db43:

  Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20180115' into staging (2018-01-15 13:17:47 +0000)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180116

for you to fetch changes up to 60765b6ceeb4998a0d4220b3a53f1f185061da77:

  sdhci: add a 'dma' property to the sysbus devices (2018-01-16 13:28:21 +0000)

----------------------------------------------------------------
target-arm queue:
 * SDHCI: cleanups and minor bug fixes
 * target/arm: minor refactor preparatory to fp16 support
 * omap_ssd, ssi-sd, pl181, milkymist-memcard: reset the SD
   card on controller reset (fixes migration failures)
 * target/arm: Handle page table walk load failures correctly
 * hw/arm/virt: Add virt-2.12 machine type
 * get_phys_addr_pmsav7: Support AP=0b111 for v7M
 * hw/intc/armv7m: Support byte and halfword accesses to CFSR

----------------------------------------------------------------
Andrey Smirnov (1):
      sdhci: Implement write method of ACMD12ERRSTS register

Peter Maydell (8):
      hw/intc/armv7m: Support byte and halfword accesses to CFSR
      get_phys_addr_pmsav7: Support AP=0b111 for v7M
      hw/arm/virt: Add virt-2.12 machine type
      target/arm: Handle page table walk load failures correctly
      hw/sd/pl181: Reset SD card on controller reset
      hw/sd/milkymist-memcard: Reset SD card on controller reset
      hw/sd/ssi-sd: Reset SD card on controller reset
      hw/sd/omap_mmc: Reset SD card on controller reset

Philippe Mathieu-Daudé (13):
      sdhci: clean up includes
      sdhci: remove dead code
      sdhci: use DEFINE_SDHCI_COMMON_PROPERTIES() for common sysbus/pci properties
      sdhci: refactor common sysbus/pci class_init() into sdhci_common_class_init()
      sdhci: refactor common sysbus/pci realize() into sdhci_common_realize()
      sdhci: refactor common sysbus/pci unrealize() into sdhci_common_unrealize()
      sdhci: use qemu_log_mask(UNIMP) instead of fprintf()
      sdhci: convert the DPRINT() calls into trace events
      sdhci: move MASK_TRNMOD with other SDHC_TRN* defines in "sd-internal.h"
      sdhci: rename the SDHC_CAPAB register
      sdhci: fix CAPAB/MAXCURR registers, both are 64bit and read-only
      sdhci: fix the PCI device, using the PCI address space for DMA
      sdhci: add a 'dma' property to the sysbus devices

Richard Henderson (2):
      target/arm: Split out vfp_expand_imm
      target/arm: Add fp16 support to vfp_expand_imm

 hw/sd/sdhci-internal.h     |   7 +-
 include/hw/sd/sdhci.h      |  19 +++-
 target/arm/internals.h     |  10 ++
 hw/arm/virt.c              |  19 +++-
 hw/intc/armv7m_nvic.c      |  38 ++++---
 hw/sd/milkymist-memcard.c  |   4 +
 hw/sd/omap_mmc.c           |  14 ++-
 hw/sd/pl181.c              |   4 +
 hw/sd/sdhci.c              | 266 +++++++++++++++++++++++++++------------------
 hw/sd/ssi-sd.c             |  25 ++++-
 target/arm/helper.c        |  53 ++++++++-
 target/arm/op_helper.c     |   7 +-
 target/arm/translate-a64.c |  49 ++++++---
 hw/sd/trace-events         |  14 +++
 14 files changed, 362 insertions(+), 167 deletions(-)
