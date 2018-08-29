Received: from eggs.gnu.org ([2001:4830:134:3::10]:52534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fv3wh-0005Ig-AD
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fv3oW-0004Jy-JG
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:59:31 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 29 Aug 2018 17:59:05 +0100
Message-Id: <20180829165911.30106-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180829165911.30106-1-mark.cave-ayland@ilande.co.uk>
References: <20180829165911.30106-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 1/7] macio: move MACIOIDEState type
 declarations to macio.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ide/macio.c                |  1 +
 hw/ppc/mac.h                  | 26 --------------------------
 include/hw/misc/macio/macio.h | 26 ++++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index d3a85cba3b..f23961e241 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -26,6 +26,7 @@
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
 #include "hw/ppc/mac_dbdma.h"
+#include "hw/misc/macio/macio.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
 
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 41fd289e81..a741300ac9 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -86,32 +86,6 @@ typedef struct Core99MachineState {
     uint8_t via_config;
 } Core99MachineState;
 
-/* MacIO */
-#define TYPE_MACIO_IDE "macio-ide"
-#define MACIO_IDE(obj) OBJECT_CHECK(MACIOIDEState, (obj), TYPE_MACIO_IDE)
-
-typedef struct MACIOIDEState {
-    /*< private >*/
-    SysBusDevice parent_obj;
-    /*< public >*/
-    uint32_t channel;
-    qemu_irq real_ide_irq;
-    qemu_irq real_dma_irq;
-    qemu_irq ide_irq;
-    qemu_irq dma_irq;
-
-    MemoryRegion mem;
-    IDEBus bus;
-    IDEDMA dma;
-    void *dbdma;
-    bool dma_active;
-    uint32_t timing_reg;
-    uint32_t irq_reg;
-} MACIOIDEState;
-
-void macio_ide_init_drives(MACIOIDEState *ide, DriveInfo **hd_table);
-void macio_ide_register_dma(MACIOIDEState *ide);
-
 /* Grackle PCI */
 #define TYPE_GRACKLE_PCI_HOST_BRIDGE "grackle-pcihost"
 
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
index cfaa145500..0c3964ec12 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -34,6 +34,32 @@
 #include "hw/ppc/mac_dbdma.h"
 #include "hw/ppc/openpic.h"
 
+/* MacIO IDE */
+#define TYPE_MACIO_IDE "macio-ide"
+#define MACIO_IDE(obj) OBJECT_CHECK(MACIOIDEState, (obj), TYPE_MACIO_IDE)
+
+typedef struct MACIOIDEState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+    uint32_t channel;
+    qemu_irq real_ide_irq;
+    qemu_irq real_dma_irq;
+    qemu_irq ide_irq;
+    qemu_irq dma_irq;
+
+    MemoryRegion mem;
+    IDEBus bus;
+    IDEDMA dma;
+    void *dbdma;
+    bool dma_active;
+    uint32_t timing_reg;
+    uint32_t irq_reg;
+} MACIOIDEState;
+
+void macio_ide_init_drives(MACIOIDEState *ide, DriveInfo **hd_table);
+void macio_ide_register_dma(MACIOIDEState *ide);
+
 #define TYPE_MACIO "macio"
 #define MACIO(obj) OBJECT_CHECK(MacIOState, (obj), TYPE_MACIO)
 
-- 
2.11.0
