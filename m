Received: from eggs.gnu.org ([2001:4830:134:3::10]:48514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fxvxl-0000CR-HM
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fxvxk-0001kd-O2
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:12:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56648 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fxvxk-0001kP-JF
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:12:52 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  6 Sep 2018 19:12:21 +0400
Message-Id: <20180906151227.25514-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180906151227.25514-1-marcandre.lureau@redhat.com>
References: <20180906151227.25514-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/10] qom/object: register 'type' property as
 class property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qom/object.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index d8666de3f2..185d1dd9f8 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2423,9 +2423,10 @@ void object_class_property_set_description(ObjectC=
lass *klass,
     op->description =3D g_strdup(description);
 }
=20
-static void object_instance_init(Object *obj)
+static void object_class_init(ObjectClass *klass, void *data)
 {
-    object_property_add_str(obj, "type", qdev_get_type, NULL, NULL);
+    object_class_property_add_str(klass, "type", qdev_get_type,
+                                  NULL, &error_abort);
 }
=20
 static void register_types(void)
@@ -2439,7 +2440,7 @@ static void register_types(void)
     static TypeInfo object_info =3D {
         .name =3D TYPE_OBJECT,
         .instance_size =3D sizeof(Object),
-        .instance_init =3D object_instance_init,
+        .class_init =3D object_class_init,
         .abstract =3D true,
     };
=20
--=20
2.19.0.rc1
