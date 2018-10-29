Received: from eggs.gnu.org ([2001:4830:134:3::10]:60405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH7js-0001GF-Ra
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH7jn-0004ew-PH
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:37:52 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Oct 2018 14:37:20 +0100
Message-Id: <20181029133722.12415-3-kraxel@redhat.com>
In-Reply-To: <20181029133722.12415-1-kraxel@redhat.com>
References: <20181029133722.12415-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/4] audio: use TYPE_WM8750 instead of a
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
Cc: Jan Kiszka <jan.kiszka@web.de>, qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Cc: Jan Kiszka <jan.kiszka@web.de>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20181022074050.19638-2-maozhongyi@cmss.chinamobile.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/arm/musicpal.c          | 2 +-
 hw/audio/marvell_88w8618.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index c807010e83..3dafb41b0b 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1695,7 +1695,7 @@ static void musicpal_init(MachineState *machine)
     wm8750_dev =3D i2c_create_slave(i2c, TYPE_WM8750, MP_WM_ADDR);
     dev =3D qdev_create(NULL, "mv88w8618_audio");
     s =3D SYS_BUS_DEVICE(dev);
-    qdev_prop_set_ptr(dev, "wm8750", wm8750_dev);
+    qdev_prop_set_ptr(dev, TYPE_WM8750, wm8750_dev);
     qdev_init_nofail(dev);
     sysbus_mmio_map(s, 0, MP_AUDIO_BASE);
     sysbus_connect_irq(s, 0, pic[MP_AUDIO_IRQ]);
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index e546892d3c..cf6ce6979b 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -280,7 +280,7 @@ static const VMStateDescription mv88w8618_audio_vmsd =
=3D {
 };
=20
 static Property mv88w8618_audio_properties[] =3D {
-    DEFINE_PROP_PTR("wm8750", mv88w8618_audio_state, wm),
+    DEFINE_PROP_PTR(TYPE_WM8750, mv88w8618_audio_state, wm),
     {/* end of list */},
 };
=20
--=20
2.9.3
