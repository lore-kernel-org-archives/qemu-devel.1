Received: from eggs.gnu.org ([2001:4830:134:3::10]:60766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e83cX-0003Bp-6X
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e83cV-0006ks-8k
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:20:17 -0400
Received: from chuckie.co.uk ([82.165.15.123]:33180
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e83cV-0006cQ-1q
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:20:15 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 27 Oct 2017 13:19:49 +0100
Message-Id: <1509106789-8626-5-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1509106789-8626-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1509106789-8626-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 4/4] sun4m: change TYPE_SUN4M_IOMMU macro
 from "iommu" to "sun4m-iommu"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

This is a legacy artifact from when the sun4m IOMMU implementation was
the only IOMMU available within QEMU.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 include/hw/sparc/sun4m.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/sparc/sun4m.h b/include/hw/sparc/sun4m.h
index c2d0448..c557b0d 100644
--- a/include/hw/sparc/sun4m.h
+++ b/include/hw/sparc/sun4m.h
@@ -9,7 +9,7 @@
 /* Devices used by sparc32 system.  */
 
 /* iommu.c */
-#define TYPE_SUN4M_IOMMU "iommu"
+#define TYPE_SUN4M_IOMMU "sun4m-iommu"
 #define SUN4M_IOMMU(obj) OBJECT_CHECK(IOMMUState, (obj), TYPE_SUN4M_IOMMU)
 
 #define TYPE_SUN4M_IOMMU_MEMORY_REGION "sun4m-iommu-memory-region"
-- 
1.7.10.4
