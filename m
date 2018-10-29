Received: from eggs.gnu.org ([2001:4830:134:3::10]:60421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH7jw-0001Ou-Vy
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH7jv-0004gs-BE
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:37:56 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Oct 2018 14:37:19 +0100
Message-Id: <20181029133722.12415-2-kraxel@redhat.com>
In-Reply-To: <20181029133722.12415-1-kraxel@redhat.com>
References: <20181029133722.12415-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/4] hw: AC97: make it more QOMconventional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@web.de>, qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Li Qiang <liq3ea@163.com>

From: Li Qiang <liq3ea@163.com>

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20181013060809.52496-1-liq3ea@163.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/ac97.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 337402e9c6..d799533aa9 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -123,6 +123,10 @@ enum {
=20
 #define MUTE_SHIFT 15
=20
+#define TYPE_AC97 "AC97"
+#define AC97(obj) \
+    OBJECT_CHECK(AC97LinkState, (obj), TYPE_AC97)
+
 #define REC_MASK 7
 enum {
     REC_MIC =3D 0,
@@ -1340,7 +1344,7 @@ static void ac97_on_reset (DeviceState *dev)
=20
 static void ac97_realize(PCIDevice *dev, Error **errp)
 {
-    AC97LinkState *s =3D DO_UPCAST (AC97LinkState, dev, dev);
+    AC97LinkState *s =3D AC97(dev);
     uint8_t *c =3D s->dev.config;
=20
     /* TODO: no need to override */
@@ -1389,7 +1393,7 @@ static void ac97_realize(PCIDevice *dev, Error **er=
rp)
=20
 static void ac97_exit(PCIDevice *dev)
 {
-    AC97LinkState *s =3D DO_UPCAST(AC97LinkState, dev, dev);
+    AC97LinkState *s =3D AC97(dev);
=20
     AUD_close_in(&s->card, s->voice_pi);
     AUD_close_out(&s->card, s->voice_po);
@@ -1399,7 +1403,7 @@ static void ac97_exit(PCIDevice *dev)
=20
 static int ac97_init (PCIBus *bus)
 {
-    pci_create_simple (bus, -1, "AC97");
+    pci_create_simple(bus, -1, TYPE_AC97);
     return 0;
 }
=20
@@ -1427,7 +1431,7 @@ static void ac97_class_init (ObjectClass *klass, vo=
id *data)
 }
=20
 static const TypeInfo ac97_info =3D {
-    .name          =3D "AC97",
+    .name          =3D TYPE_AC97,
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof (AC97LinkState),
     .class_init    =3D ac97_class_init,
--=20
2.9.3
