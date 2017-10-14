Received: from eggs.gnu.org ([2001:4830:134:3::10]:55516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e3R7b-0001ic-GM
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 14:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e3R7Y-0002ZD-Cl
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 14:25:15 -0400
Received: from chuckie.co.uk ([82.165.15.123]:36879
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e3R7Y-0002Yb-5t
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 14:25:12 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat, 14 Oct 2017 19:24:55 +0100
Message-Id: <1508005498-29037-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/3] sun4m: implement memory region IOMMU
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
Based-on: 1508004545-28578-1-git-send-email-mark.cave-ayland@ilande.co.uk ([PATCHv2 00/13] sun4m: sparc32_dma tidy-ups)

Mark Cave-Ayland (3):
  sun4m: implement IOMMU translation using IOMMU memory region
  sparc32_dma: switch over to using IOMMU memory region and DMA API
  sun4m_iommu: remove legacy sparc_iommu_memory_rw() function

 hw/dma/sparc32_dma.c     |   17 +++++----
 hw/dma/sun4m_iommu.c     |   87 ++++++++++++++++++++++++++++++----------------
 include/hw/sparc/sun4m.h |   21 +++--------
 3 files changed, 74 insertions(+), 51 deletions(-)

-- 
1.7.10.4
