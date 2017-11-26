Received: from eggs.gnu.org ([2001:4830:134:3::10]:34154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eIx6J-0000U3-3x
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 08:36:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eIx6H-0006hr-Px
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 08:36:03 -0500
Received: from chuckie.co.uk ([82.165.15.123]:48813
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eIx6H-0006gz-JG
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 08:36:01 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 26 Nov 2017 13:35:26 +0000
Message-Id: <1511703326-25325-9-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1511703326-25325-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1511703326-25325-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 8/8] sun4u_iommu: add trace event for IOMMU
 translations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc64/sun4u_iommu.c |    2 ++
 hw/sparc64/trace-events  |    1 +
 2 files changed, 3 insertions(+)

diff --git a/hw/sparc64/sun4u_iommu.c b/hw/sparc64/sun4u_iommu.c
index 51fbc39..4cf8e69 100644
--- a/hw/sparc64/sun4u_iommu.c
+++ b/hw/sparc64/sun4u_iommu.c
@@ -184,6 +184,8 @@ static IOMMUTLBEntry sun4u_translate_iommu(IOMMUMemoryRegion *iommu,
         ret.addr_mask = (IOMMU_PAGE_SIZE_8K - 1);
     }
 
+    trace_sun4u_iommu_translate(ret.iova, ret.translated_addr, tte);
+
     return ret;
 }
 
diff --git a/hw/sparc64/trace-events b/hw/sparc64/trace-events
index 052352f..2ee2d75 100644
--- a/hw/sparc64/trace-events
+++ b/hw/sparc64/trace-events
@@ -6,3 +6,4 @@ ebus_isa_irq_handler(int n, int level) "Set ISA IRQ %d level %d"
 # hw/sparc64/sun4u_iommu.c
 sun4u_iommu_mem_read(uint64_t addr, uint64_t val, int size) "addr: 0x%"PRIx64" val: 0x%"PRIx64" size: %d"
 sun4u_iommu_mem_write(uint64_t addr, uint64_t val, int size) "addr: 0x%"PRIx64" val: 0x%"PRIx64" size: %d"
+sun4u_iommu_translate(uint64_t addr, uint64_t trans_addr, uint64_t tte) "xlate 0x%"PRIx64" => pa 0x%"PRIx64" tte: 0x%"PRIx64
-- 
1.7.10.4
