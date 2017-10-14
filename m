Received: from eggs.gnu.org ([2001:4830:134:3::10]:51866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e3QsJ-0001Qm-Ti
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 14:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e3QsI-00030E-U8
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 14:09:27 -0400
Received: from chuckie.co.uk ([82.165.15.123]:36826
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e3QsI-0002zw-Nc
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 14:09:26 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat, 14 Oct 2017 19:08:59 +0100
Message-Id: <1508004545-28578-8-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1508004545-28578-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1508004545-28578-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 07/13] esp: move TYPE_ESP and SysBusESPState
 from esp.c to esp.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

This enables them to be used outside of esp.c.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/esp.c         |   13 -------------
 include/hw/scsi/esp.h |   13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 22c2d91..ee586e7 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -592,19 +592,6 @@ const VMStateDescription vmstate_esp = {
     }
 };
 
-#define TYPE_ESP "esp"
-#define ESP_STATE(obj) OBJECT_CHECK(SysBusESPState, (obj), TYPE_ESP)
-
-typedef struct {
-    /*< private >*/
-    SysBusDevice parent_obj;
-    /*< public >*/
-
-    MemoryRegion iomem;
-    uint32_t it_shift;
-    ESPState esp;
-} SysBusESPState;
-
 static void sysbus_esp_mem_write(void *opaque, hwaddr addr,
                                  uint64_t val, unsigned int size)
 {
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index d2c4886..a79d3f2 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -52,6 +52,19 @@ struct ESPState {
     void (*dma_cb)(ESPState *s);
 };
 
+#define TYPE_ESP "esp"
+#define ESP_STATE(obj) OBJECT_CHECK(SysBusESPState, (obj), TYPE_ESP)
+
+typedef struct {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion iomem;
+    uint32_t it_shift;
+    ESPState esp;
+} SysBusESPState;
+
 #define ESP_TCLO   0x0
 #define ESP_TCMID  0x1
 #define ESP_FIFO   0x2
-- 
1.7.10.4
