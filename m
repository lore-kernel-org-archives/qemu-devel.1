Received: from eggs.gnu.org ([2001:4830:134:3::10]:59969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfN-0004As-Qy
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfH-0005Rm-Ud
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:17 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHfH-0005RD-Oy
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:11 -0400
Received: by mail-wm0-x241.google.com with SMTP id r136so3738282wmf.3
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:11 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:13 +0200
Message-Id: <1505824179-21541-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 24/50] scsi/esp: Rename the ESP macro to
 ESP_STATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kamil Rytarowski <n54@gmx.com>

From: Kamil Rytarowski <n54@gmx.com>

SunOS defines ESP (x86 register) in <sys/regset.h> as 7.

This fixes build on SmartOS (Joyent).

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
Message-Id: <20170909142116.26816-1-n54@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/esp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index eee831e..22c2d91 100644
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
1.8.3.1
