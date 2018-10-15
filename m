Received: from eggs.gnu.org ([2001:4830:134:3::10]:40938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gBtXP-0005Bo-1T
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 23:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gBtXL-0000xE-Qv
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 23:27:22 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:18809)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gBtXL-0000tu-5n
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 23:27:19 -0400
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 15 Oct 2018 11:26:40 +0800
Message-Id: <20181015032642.16411-2-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181015032642.16411-1-maozhongyi@cmss.chinamobile.com>
References: <20181015032642.16411-1-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 1/3] audio: use TYPE_WM8750 instead of a
 hardcoded string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

Cc: Jan Kiszka <jan.kiszka@web.de>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/arm/musicpal.c          | 2 +-
 hw/audio/marvell_88w8618.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index c807010e83..3dafb41b0b 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1695,7 +1695,7 @@ static void musicpal_init(MachineState *machine)
     wm8750_dev = i2c_create_slave(i2c, TYPE_WM8750, MP_WM_ADDR);
     dev = qdev_create(NULL, "mv88w8618_audio");
     s = SYS_BUS_DEVICE(dev);
-    qdev_prop_set_ptr(dev, "wm8750", wm8750_dev);
+    qdev_prop_set_ptr(dev, TYPE_WM8750, wm8750_dev);
     qdev_init_nofail(dev);
     sysbus_mmio_map(s, 0, MP_AUDIO_BASE);
     sysbus_connect_irq(s, 0, pic[MP_AUDIO_IRQ]);
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index e546892d3c..cf6ce6979b 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -280,7 +280,7 @@ static const VMStateDescription mv88w8618_audio_vmsd = {
 };
 
 static Property mv88w8618_audio_properties[] = {
-    DEFINE_PROP_PTR("wm8750", mv88w8618_audio_state, wm),
+    DEFINE_PROP_PTR(TYPE_WM8750, mv88w8618_audio_state, wm),
     {/* end of list */},
 };
 
-- 
2.17.1
