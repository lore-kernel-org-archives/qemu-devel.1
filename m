Received: from eggs.gnu.org ([2001:4830:134:3::10]:48160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZie-00055a-Cb
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:31:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZid-0006Vq-OB
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:31:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gRZic-0006Uf-0U
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:31:46 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 13:27:56 +0400
Message-Id: <20181127092801.21777-24-marcandre.lureau@redhat.com>
In-Reply-To: <20181127092801.21777-1-marcandre.lureau@redhat.com>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v4 23/28] qom: add
 object_class_get_class_data()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

Add a simple function to retrieve the associated class data.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 9 +++++++++
 qom/object.c         | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 5183c587f3..d5266405da 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -916,6 +916,15 @@ ObjectClass *object_class_dynamic_cast(ObjectClass *=
klass,
  */
 ObjectClass *object_class_get_parent(ObjectClass *klass);
=20
+
+/**
+ * object_class_get_class_data:
+ * @klass: The class to obtain associated data.
+ *
+ * Returns: the class_data given when registering the type.
+ */
+void *object_class_get_class_data(ObjectClass *klass);
+
 /**
  * object_class_get_name:
  * @klass: The class to obtain the QOM typename for.
diff --git a/qom/object.c b/qom/object.c
index 8fa59026c5..036ff6da00 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -873,6 +873,11 @@ const char *object_class_get_name(ObjectClass *klass=
)
     return klass->type->name;
 }
=20
+void *object_class_get_class_data(ObjectClass *klass)
+{
+    return klass->type->class_data;
+}
+
 ObjectClass *object_class_by_name(const char *typename)
 {
     TypeImpl *type =3D type_get_by_name(typename);
--=20
2.20.0.rc1
