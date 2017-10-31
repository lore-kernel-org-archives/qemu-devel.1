Received: from eggs.gnu.org ([2001:4830:134:3::10]:49540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e9ak5-0006Vm-6p
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e9ak0-0005K1-By
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:54:25 -0400
Received: from chuckie.co.uk ([82.165.15.123]:52508
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e9ak0-0005IF-5J
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:54:20 -0400
Date: Tue, 31 Oct 2017 17:50:38 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20171031175037.GB29920@kentang.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL] qemu-sparc update
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

Here are the last set of changes for 2.11 which is the tidy up of the sun4m DMA
devices along with the switch from the legacy sun4m IOMMU API to an IOMMU
memory region instead. Please pull.


ATB,

Mark.
 

The following changes since commit 7fa00e204902cee0b33a0c60de87e87319d1809f:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20171031' into staging (2017-10-31 14:28:25 +0000)

are available in the git repository at:


  https://github.com/mcayland/qemu.git tags/qemu-sparc-signed

for you to fetch changes up to badd3d62c619d24a5af62198374f42b7c510ee41:

  sun4m: change TYPE_SUN4M_IOMMU macro from "iommu" to "sun4m-iommu" (2017-10-31 17:25:37 +0000)

----------------------------------------------------------------
qemu-sparc update

----------------------------------------------------------------
Mark Cave-Ayland (17):
      sparc32_dma: rename SPARC32_DMA type to SPARC32_DMA_DEVICE
      sparc32_dma: split esp and le into separate DMA devices
      sparc32_dma: move type declarations from sparc32_dma.c to sparc32_dma.h
      sun4m: move DMA device wiring from sparc32_dma_init() to sun4m_hw_init()
      sun4m_iommu: move TYPE_SUN4M_IOMMU declaration to sun4m.h
      sparc32_dma: use object link instead of qdev property to pass IOMMU reference
      esp: move TYPE_ESP and SysBusESPState from esp.c to esp.h
      sparc32_dma: make esp device child of espdma device
      lance: move TYPE_LANCE and SysBusPCNetState from lance.c to lance.h
      sparc32_dma: make lance device child of ledma device
      sparc32_dma: introduce new SPARC32_DMA type container object
      sparc32_dma: remove is_ledma hack and replace with memory region alias
      sparc32_dma: add len to esp/le DMA memory tracing
      sun4m: implement IOMMU translation using IOMMU memory region
      sparc32_dma: switch over to using IOMMU memory region and DMA API
      sun4m_iommu: remove legacy sparc_iommu_memory_rw() function
      sun4m: change TYPE_SUN4M_IOMMU macro from "iommu" to "sun4m-iommu"

 hw/dma/sparc32_dma.c           |  252 +++++++++++++++++++++++++++++-----------
 hw/dma/sun4m_iommu.c           |  101 +++++++++-------
 hw/dma/trace-events            |    8 +-
 hw/net/lance.c                 |   11 +-
 hw/scsi/esp.c                  |   13 ---
 hw/sparc/sun4m.c               |   82 +++++--------
 include/hw/net/lance.h         |   45 +++++++
 include/hw/scsi/esp.h          |   14 +++
 include/hw/sparc/sparc32_dma.h |   55 +++++++++
 include/hw/sparc/sun4m.h       |   35 +++---
 10 files changed, 413 insertions(+), 203 deletions(-)
 create mode 100644 include/hw/net/lance.h
