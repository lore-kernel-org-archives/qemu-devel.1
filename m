Received: from eggs.gnu.org ([2001:4830:134:3::10]:60790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e83cX-0003CC-TQ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e83cT-0006hy-2f
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:20:17 -0400
Received: from chuckie.co.uk ([82.165.15.123]:33171
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e83cS-0006Xl-Ov
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:20:12 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 27 Oct 2017 13:19:45 +0100
Message-Id: <1509106789-8626-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 0/4] sun4m: implement memory region IOMMU
 translation and DMA API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

The original sun4m IOMMU/DMA code dates from before the introduction of the QEMU
memory region API (in particular IOMMU memory regions) and the DMA API.

This patchset removes these sun4m-specific implementations and replaces them with
the more up-to-date QEMU APIs instead.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Based-on: 1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk ([PATCHv4 00/13] sun4m: sparc32_dma tidy-ups)

v2:
- Rebase onto v4 sparc32_dma tidy-up patchset
- Change TYPE_SUN4M_IOMMU macro from "iommu" to "sun4m-iommu" as suggested by Philippe


Mark Cave-Ayland (4):
  sun4m: implement IOMMU translation using IOMMU memory region
  sparc32_dma: switch over to using IOMMU memory region and DMA API
  sun4m_iommu: remove legacy sparc_iommu_memory_rw() function
  sun4m: change TYPE_SUN4M_IOMMU macro from "iommu" to "sun4m-iommu"

 hw/dma/sparc32_dma.c     |   17 +++++----
 hw/dma/sun4m_iommu.c     |   87 ++++++++++++++++++++++++++++++----------------
 include/hw/sparc/sun4m.h |   23 ++++--------
 3 files changed, 75 insertions(+), 52 deletions(-)

-- 
1.7.10.4
