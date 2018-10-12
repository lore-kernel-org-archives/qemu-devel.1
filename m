Received: from eggs.gnu.org ([2001:4830:134:3::10]:54729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAsq9-00047y-2V
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAsq5-0008KM-Lk
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:30:32 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:38193)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAsq3-0008Fx-P7
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:30:28 -0400
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Fri, 12 Oct 2018 16:30:06 +0800
Message-Id: <20181012083008.29027-2-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181012083008.29027-1-maozhongyi@cmss.chinamobile.com>
References: <20181012083008.29027-1-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/3] audio: use TYPE_WM8750 instead of a
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
To: qemu-arm@nongnu.org

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
