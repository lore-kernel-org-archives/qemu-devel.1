Received: from eggs.gnu.org ([2001:4830:134:3::10]:37178)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dqgpU-0000Ww-Jy
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 10:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dqgpR-0000MI-HC
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 10:33:52 -0400
Received: from mout.gmx.net ([212.227.17.20]:58658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dqgpR-0000Li-8Q
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 10:33:49 -0400
From: Kamil Rytarowski <n54@gmx.com>
Date: Sat,  9 Sep 2017 16:21:16 +0200
Message-Id: <20170909142116.26816-1-n54@gmx.com>
In-Reply-To: <20170903163615.15562-1-n54@gmx.com>
References: <20170903163615.15562-1-n54@gmx.com>
Subject: [Qemu-devel] [PATCH v2] scsi/esp: Rename the ESP macro to ESP_STATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Kamil Rytarowski <n54@gmx.com>

SunOS defines ESP (x86 register) in <sys/regset.h> as 7.

This fixes build on SmartOS (Joyent).

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
---
 hw/scsi/esp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index eee831efeb..22c2d91e39 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -593,7 +593,7 @@ const VMStateDescription vmstate_esp = {
 };
 
 #define TYPE_ESP "esp"
-#define ESP(obj) OBJECT_CHECK(SysBusESPState, (obj), TYPE_ESP)
+#define ESP_STATE(obj) OBJECT_CHECK(SysBusESPState, (obj), TYPE_ESP)
 
 typedef struct {
     /*< private >*/
@@ -644,7 +644,7 @@ void esp_init(hwaddr espaddr, int it_shift,
     ESPState *esp;
 
     dev = qdev_create(NULL, TYPE_ESP);
-    sysbus = ESP(dev);
+    sysbus = ESP_STATE(dev);
     esp = &sysbus->esp;
     esp->dma_memory_read = dma_memory_read;
     esp->dma_memory_write = dma_memory_write;
@@ -672,7 +672,7 @@ static const struct SCSIBusInfo esp_scsi_info = {
 
 static void sysbus_esp_gpio_demux(void *opaque, int irq, int level)
 {
-    SysBusESPState *sysbus = ESP(opaque);
+    SysBusESPState *sysbus = ESP_STATE(opaque);
     ESPState *s = &sysbus->esp;
 
     switch (irq) {
@@ -688,7 +688,7 @@ static void sysbus_esp_gpio_demux(void *opaque, int irq, int level)
 static void sysbus_esp_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    SysBusESPState *sysbus = ESP(dev);
+    SysBusESPState *sysbus = ESP_STATE(dev);
     ESPState *s = &sysbus->esp;
 
     sysbus_init_irq(sbd, &s->irq);
@@ -706,7 +706,7 @@ static void sysbus_esp_realize(DeviceState *dev, Error **errp)
 
 static void sysbus_esp_hard_reset(DeviceState *dev)
 {
-    SysBusESPState *sysbus = ESP(dev);
+    SysBusESPState *sysbus = ESP_STATE(dev);
     esp_hard_reset(&sysbus->esp);
 }
 
-- 
2.14.1
