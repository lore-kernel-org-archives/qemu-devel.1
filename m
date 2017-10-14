Received: from eggs.gnu.org ([2001:4830:134:3::10]:51801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e3QsF-0001OJ-R4
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 14:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e3QsE-0002yS-H8
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 14:09:23 -0400
Received: from chuckie.co.uk ([82.165.15.123]:36815
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e3QsE-0002xx-Ao
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 14:09:22 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat, 14 Oct 2017 19:08:55 +0100
Message-Id: <1508004545-28578-4-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1508004545-28578-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1508004545-28578-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 03/13] sparc32_dma: move type declarations
 from sparc32_dma.c to sparc32_dma.h
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
 hw/dma/sparc32_dma.c           |   34 ----------------------------------
 include/hw/sparc/sparc32_dma.h |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index e4ff4a8..ae8fa06 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -40,7 +40,6 @@
  * http://www.ibiblio.org/pub/historic-linux/early-ports/Sparc/NCR/DMA2.txt
  */
 
-#define DMA_REGS 4
 #define DMA_SIZE (4 * sizeof(uint32_t))
 /* We need the mask, because one instance of the device is not page
    aligned (ledma, start address 0x0010) */
@@ -61,39 +60,6 @@
 /* XXX SCSI and ethernet should have different read-only bit masks */
 #define DMA_CSR_RO_MASK 0xfe000007
 
-#define TYPE_SPARC32_DMA_DEVICE "sparc32-dma-device"
-#define SPARC32_DMA_DEVICE(obj) OBJECT_CHECK(DMADeviceState, (obj), \
-                                             TYPE_SPARC32_DMA_DEVICE)
-
-typedef struct DMADeviceState DMADeviceState;
-
-struct DMADeviceState {
-    SysBusDevice parent_obj;
-
-    MemoryRegion iomem;
-    uint32_t dmaregs[DMA_REGS];
-    qemu_irq irq;
-    void *iommu;
-    qemu_irq gpio[2];
-    uint32_t is_ledma;
-};
-
-#define TYPE_SPARC32_ESPDMA_DEVICE "sparc32-espdma"
-#define SPARC32_ESPDMA_DEVICE(obj) OBJECT_CHECK(ESPDMADeviceState, (obj), \
-                                                TYPE_SPARC32_ESPDMA_DEVICE)
-
-typedef struct ESPDMADeviceState {
-    DMADeviceState parent_obj;
-} ESPDMADeviceState;
-
-#define TYPE_SPARC32_LEDMA_DEVICE "sparc32-ledma"
-#define SPARC32_LEDMA_DEVICE(obj) OBJECT_CHECK(LEDMADeviceState, (obj), \
-                                               TYPE_SPARC32_LEDMA_DEVICE)
-
-typedef struct LEDMADeviceState {
-    DMADeviceState parent_obj;
-} LEDMADeviceState;
-
 enum {
     GPIO_RESET = 0,
     GPIO_DMA,
diff --git a/include/hw/sparc/sparc32_dma.h b/include/hw/sparc/sparc32_dma.h
index 9497b13..df7491d 100644
--- a/include/hw/sparc/sparc32_dma.h
+++ b/include/hw/sparc/sparc32_dma.h
@@ -1,6 +1,43 @@
 #ifndef SPARC32_DMA_H
 #define SPARC32_DMA_H
 
+#include "hw/sysbus.h"
+
+#define DMA_REGS 4
+
+#define TYPE_SPARC32_DMA_DEVICE "sparc32-dma-device"
+#define SPARC32_DMA_DEVICE(obj) OBJECT_CHECK(DMADeviceState, (obj), \
+                                             TYPE_SPARC32_DMA_DEVICE)
+
+typedef struct DMADeviceState DMADeviceState;
+
+struct DMADeviceState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint32_t dmaregs[DMA_REGS];
+    qemu_irq irq;
+    void *iommu;
+    qemu_irq gpio[2];
+    uint32_t is_ledma;
+};
+
+#define TYPE_SPARC32_ESPDMA_DEVICE "sparc32-espdma"
+#define SPARC32_ESPDMA_DEVICE(obj) OBJECT_CHECK(ESPDMADeviceState, (obj), \
+                                                TYPE_SPARC32_ESPDMA_DEVICE)
+
+typedef struct ESPDMADeviceState {
+    DMADeviceState parent_obj;
+} ESPDMADeviceState;
+
+#define TYPE_SPARC32_LEDMA_DEVICE "sparc32-ledma"
+#define SPARC32_LEDMA_DEVICE(obj) OBJECT_CHECK(LEDMADeviceState, (obj), \
+                                               TYPE_SPARC32_LEDMA_DEVICE)
+
+typedef struct LEDMADeviceState {
+    DMADeviceState parent_obj;
+} LEDMADeviceState;
+
 /* sparc32_dma.c */
 void ledma_memory_read(void *opaque, hwaddr addr,
                        uint8_t *buf, int len, int do_bswap);
-- 
1.7.10.4
