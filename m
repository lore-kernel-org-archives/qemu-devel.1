Received: from eggs.gnu.org ([2001:4830:134:3::10]:60323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH7jk-00014y-39
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:37:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH7jg-0004Zv-8r
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:37:43 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Oct 2018 14:37:22 +0100
Message-Id: <20181029133722.12415-5-kraxel@redhat.com>
In-Reply-To: <20181029133722.12415-1-kraxel@redhat.com>
References: <20181029133722.12415-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/4] audio: use TYPE_MV88W8618_AUDIO instead of
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
Cc: Jan Kiszka <jan.kiszka@web.de>, qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Cc: Jan Kiszka <jan.kiszka@web.de>
Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20181022074050.19638-4-maozhongyi@cmss.chinamobile.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/audio/wm8750.h  | 1 +
 hw/arm/musicpal.c          | 2 +-
 hw/audio/marvell_88w8618.c | 1 -
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/audio/wm8750.h b/include/hw/audio/wm8750.h
index 84e7a119bb..e12cb886d1 100644
--- a/include/hw/audio/wm8750.h
+++ b/include/hw/audio/wm8750.h
@@ -17,6 +17,7 @@
 #include "hw/hw.h"
=20
 #define TYPE_WM8750 "wm8750"
+#define TYPE_MV88W8618_AUDIO "mv88w8618_audio"
=20
 typedef void data_req_cb(void *opaque, int free_out, int free_in);
=20
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index ac266f9253..9648b3af44 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1693,7 +1693,7 @@ static void musicpal_init(MachineState *machine)
     }
=20
     wm8750_dev =3D i2c_create_slave(i2c, TYPE_WM8750, MP_WM_ADDR);
-    dev =3D qdev_create(NULL, "mv88w8618_audio");
+    dev =3D qdev_create(NULL, TYPE_MV88W8618_AUDIO);
     s =3D SYS_BUS_DEVICE(dev);
     object_property_set_link(OBJECT(dev), OBJECT(wm8750_dev),
                              TYPE_WM8750, NULL);
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index 1c7080e844..6600ab4851 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -39,7 +39,6 @@
 #define MP_AUDIO_CLOCK_24MHZ    (1 << 9)
 #define MP_AUDIO_MONO           (1 << 14)
=20
-#define TYPE_MV88W8618_AUDIO "mv88w8618_audio"
 #define MV88W8618_AUDIO(obj) \
     OBJECT_CHECK(mv88w8618_audio_state, (obj), TYPE_MV88W8618_AUDIO)
=20
--=20
2.9.3
