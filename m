Received: from eggs.gnu.org ([2001:4830:134:3::10]:56667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e1fGu-0004Fs-Pu
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e1fGr-0006bv-Fw
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:07:32 -0400
Received: from chuckie.co.uk ([82.165.15.123]:40541
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e1fGr-0006ZM-90
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:07:29 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon,  9 Oct 2017 22:06:55 +0100
Message-Id: <1507583223-14819-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/8] sun4m : sparc32_dma tidy-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

This patchset aims to tidy-up the sparc32_dma code by improving the
modelling of the espdma/ledma devices using both QOM and the memory
API which didn't exist when the code was first written.

The result is that it is now possible to remove both the iommu_opaque
and is_ledma workarounds from the code.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Mark Cave-Ayland (8):
  sparc32_dma: rename SPARC32_DMA type to SPARC32_DMA_DEVICE
  sparc32_dma: split esp and le into separate DMA devices
  sparc32_dma: move type declarations from sparc32_dma.c to
    sparc32_dma.h
  sun4m: move DMA device wiring from sparc32_dma_init() to
    sun4m_hw_init()
  sun4m_iommu: move TYPE_SUN4M_IOMMU declaration to sun4m.h
  sparc32_dma: use object link instead of qdev property to pass IOMMU
    reference
  sparc32_dma: introduce new SPARC32_DMA type container object
  sparc32_dma: remove is_ledma hack and replace with memory region
    alias

 hw/dma/sparc32_dma.c           |  165 ++++++++++++++++++++++++++--------------
 hw/dma/sun4m_iommu.c           |   14 ----
 hw/sparc/sun4m.c               |   40 +++++-----
 include/hw/sparc/sparc32_dma.h |   49 ++++++++++++
 include/hw/sparc/sun4m.h       |   16 ++++
 5 files changed, 194 insertions(+), 90 deletions(-)

-- 
1.7.10.4
