Received: from eggs.gnu.org ([2001:4830:134:3::10]:35259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dh68E-0004zg-0m
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 23:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dh68C-0007s4-VU
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 23:33:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dh68C-0007ry-Lz
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 23:33:32 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Aug 2017 11:33:10 +0800
Message-Id: <1502681591-31362-5-git-send-email-jasowang@redhat.com>
In-Reply-To: <1502681591-31362-1-git-send-email-jasowang@redhat.com>
References: <1502681591-31362-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/5] net/rocker: Fix the unusual macro name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, jasowang@redhat.com, jiri@resnulli.us, armbru@redhat.com, f4bug@amsat.org

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

Cc: jasowang@redhat.com
Cc: jiri@resnulli.us
Cc: armbru@redhat.com
Cc: f4bug@amsat.org
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/rocker/rocker.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index bb38cba..9273473 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -69,10 +69,10 @@ struct rocker {
     QLIST_ENTRY(rocker) next;
 };
=20
-#define ROCKER "rocker"
+#define TYPE_ROCKER "rocker"
=20
-#define to_rocker(obj) \
-    OBJECT_CHECK(Rocker, (obj), ROCKER)
+#define ROCKER(obj) \
+    OBJECT_CHECK(Rocker, (obj), TYPE_ROCKER)
=20
 static QLIST_HEAD(, rocker) rockers;
=20
@@ -1285,7 +1285,7 @@ static World *rocker_world_type_by_name(Rocker *r, =
const char *name)
=20
 static void pci_rocker_realize(PCIDevice *dev, Error **errp)
 {
-    Rocker *r =3D to_rocker(dev);
+    Rocker *r =3D ROCKER(dev);
     const MACAddr zero =3D { .a =3D { 0, 0, 0, 0, 0, 0 } };
     const MACAddr dflt =3D { .a =3D { 0x52, 0x54, 0x00, 0x12, 0x35, 0x01=
 } };
     static int sw_index;
@@ -1331,7 +1331,7 @@ static void pci_rocker_realize(PCIDevice *dev, Erro=
r **errp)
     /* validate switch properties */
=20
     if (!r->name) {
-        r->name =3D g_strdup(ROCKER);
+        r->name =3D g_strdup(TYPE_ROCKER);
     }
=20
     if (rocker_find(r->name)) {
@@ -1427,7 +1427,7 @@ err_world_type_by_name:
=20
 static void pci_rocker_uninit(PCIDevice *dev)
 {
-    Rocker *r =3D to_rocker(dev);
+    Rocker *r =3D ROCKER(dev);
     int i;
=20
     QLIST_REMOVE(r, next);
@@ -1460,7 +1460,7 @@ static void pci_rocker_uninit(PCIDevice *dev)
=20
 static void rocker_reset(DeviceState *dev)
 {
-    Rocker *r =3D to_rocker(dev);
+    Rocker *r =3D ROCKER(dev);
     int i;
=20
     for (i =3D 0; i < ROCKER_WORLD_TYPE_MAX; i++) {
@@ -1498,7 +1498,7 @@ static Property rocker_properties[] =3D {
 };
=20
 static const VMStateDescription rocker_vmsd =3D {
-    .name =3D ROCKER,
+    .name =3D TYPE_ROCKER,
     .unmigratable =3D 1,
 };
=20
@@ -1521,7 +1521,7 @@ static void rocker_class_init(ObjectClass *klass, v=
oid *data)
 }
=20
 static const TypeInfo rocker_info =3D {
-    .name          =3D ROCKER,
+    .name          =3D TYPE_ROCKER,
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(Rocker),
     .class_init    =3D rocker_class_init,
--=20
2.7.4
