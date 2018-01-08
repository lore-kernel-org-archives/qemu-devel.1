Received: from eggs.gnu.org ([2001:4830:134:3::10]:40867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eYd90-0006zF-KL
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 14:31:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eYd8x-0006qR-FA
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 14:31:38 -0500
Received: from chuckie.co.uk ([82.165.15.123]:56165
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eYd8x-0006q3-7w
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 14:31:35 -0500
Date: Mon, 8 Jan 2018 19:31:24 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20180108193124.mjei33w5wopmadmk@kentang.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL] qemu-sparc updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org

Hi Peter,

Here is the first set of SPARC updates for 2.12. Please pull.


ATB,

Mark. 


The following changes since commit 4124ea4f5bd367ca6412fb2dfe7ac4d80e1504d9:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20171229' into staging (2018-01-08 16:17:04 +0000)

are available in the git repository at:

  https://github.com/mcayland/qemu.git tags/qemu-sparc-signed

for you to fetch changes up to 6a52624720e5abc6a1f067a7e7b8239b428e0c95:

  sun4u_iommu: add trace event for IOMMU translations (2018-01-08 19:07:55 +0000)

----------------------------------------------------------------
qemu-sparc update

----------------------------------------------------------------
Jean-Christophe Dubois (1):
      target/sparc: remove MemoryRegionSection check code from sparc_cpu_get_phys_page_debug()

Mark Cave-Ayland (24):
      apb: move QOM macros and typedefs from apb.c to apb.h
      sun4u: ebus QOMify tidy-up
      sun4u: move ISABus inside of EBusState
      sun4u: remove pci_ebus_init() function
      sun4u: move initialisation of all ISABus devices into ebus_realize()
      apb: APB QOMify tidy-up
      apb: return APBState from pci_apb_init() rather than PCIBus
      apb: use gpios to wire up the apb device to the SPARC CPU IRQs
      apb: move the two secondary PCI bridges objects into APBState
      apb: remove pci_apb_init() and instantiate APB device using qdev
      apb: split pci_pbm_map_irq() into separate functions for bus A and bus B
      apb: remove busA property from PBMPCIBridge state
      ebus: wire up OBIO interrupts to APB pbm via qdev GPIOs
      apb: replace OBIO interrupt numbers in pci_pbmA_map_irq() with constants
      sparc64: introduce trace-events for hw/sparc64
      sun4u: switch from EBUS_DPRINTF() macro to trace-events
      sun4m: move sun4m_iommu.c from hw/dma to hw/sparc
      sun4m: move IOMMU declarations from sun4m.h to sun4m_iommu.h
      sun4m: remove include/hw/sparc/sun4m.h and all references to it
      apb: QOMify IOMMU
      sun4u: split IOMMU device out from apb.c to sun4u_iommu.c
      sun4u_iommu: update to reflect IOMMU is no longer part of the APB device
      sun4u_iommu: convert from IOMMU_DPRINTF to trace-events
      sun4u_iommu: add trace event for IOMMU translations

 Makefile.objs                   |   1 +
 hw/dma/Makefile.objs            |   1 -
 hw/dma/sparc32_dma.c            |   2 +-
 hw/dma/trace-events             |  10 -
 hw/intc/slavio_intctl.c         |   1 -
 hw/net/lance.c                  |   2 +-
 hw/pci-host/apb.c               | 545 ++++++++--------------------------------
 hw/sparc/Makefile.objs          |   2 +-
 hw/sparc/sun4m.c                |   2 +-
 hw/{dma => sparc}/sun4m_iommu.c |  13 +-
 hw/sparc/trace-events           |  10 +
 hw/sparc64/Makefile.objs        |   1 +
 hw/sparc64/sparc64.c            |   2 +
 hw/sparc64/sun4u.c              | 193 ++++++++------
 hw/sparc64/sun4u_iommu.c        | 342 +++++++++++++++++++++++++
 hw/sparc64/trace-events         |   9 +
 hw/timer/slavio_timer.c         |   1 -
 include/hw/pci-host/apb.h       |  54 +++-
 include/hw/sparc/sparc64.h      |   2 +
 include/hw/sparc/sun4m.h        |  35 ---
 include/hw/sparc/sun4m_iommu.h  |  51 ++++
 include/hw/sparc/sun4u_iommu.h  |  50 ++++
 target/sparc/mmu_helper.c       |   6 -
 23 files changed, 744 insertions(+), 591 deletions(-)
 rename hw/{dma => sparc}/sun4m_iommu.c (98%)
 create mode 100644 hw/sparc64/sun4u_iommu.c
 create mode 100644 hw/sparc64/trace-events
 delete mode 100644 include/hw/sparc/sun4m.h
 create mode 100644 include/hw/sparc/sun4m_iommu.h
 create mode 100644 include/hw/sparc/sun4u_iommu.h
