Received: from eggs.gnu.org ([2001:4830:134:3::10]:60897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gPlqi-0007ya-Nk
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:04:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gPlmq-0001V6-Ia
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:00:41 -0500
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 22 Nov 2018 02:00:25 -0800
Message-Id: <1542880825-2604-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] hw: arm: musicpal: drop TYPE_WM8750 in
 object_property_set_link()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jan.kiszka@web.de, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, maozhongyi@cmss.chinamobile.com, philmd@redhat.com, Li Qiang <liq3ea@gmail.com>

The third argument of object_property_set_link() is the name of
property, not related with the QOM type name, using the constant
string instead.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/arm/musicpal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 9648b3af44..726ae29394 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1696,7 +1696,7 @@ static void musicpal_init(MachineState *machine)
     dev = qdev_create(NULL, TYPE_MV88W8618_AUDIO);
     s = SYS_BUS_DEVICE(dev);
     object_property_set_link(OBJECT(dev), OBJECT(wm8750_dev),
-                             TYPE_WM8750, NULL);
+                             "wm8750", NULL);
     qdev_init_nofail(dev);
     sysbus_mmio_map(s, 0, MP_AUDIO_BASE);
     sysbus_connect_irq(s, 0, pic[MP_AUDIO_IRQ]);
-- 
2.11.0
