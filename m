Received: from eggs.gnu.org ([2001:4830:134:3::10]:43174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGUSd-00048W-5k
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 12:32:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGUSc-0000zV-Ac
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 12:32:23 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 12 Dec 2016 20:31:51 +0300
Message-Id: <20161212173151.18092-3-marcandre.lureau@redhat.com>
In-Reply-To: <20161212173151.18092-1-marcandre.lureau@redhat.com>
References: <20161212173151.18092-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] object: make some funcs static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

There is no need to have those functions as public API.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qom/object.c         |  4 ++--
 include/qom/object.h | 24 ------------------------
 2 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 7a05e35ed9..eb3d0f64e4 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -351,7 +351,7 @@ static void object_post_init_with_type(Object *obj, T=
ypeImpl *ti)
     }
 }
=20
-void object_initialize_with_type(void *data, size_t size, TypeImpl *type=
)
+static void object_initialize_with_type(void *data, size_t size, TypeImp=
l *type)
 {
     Object *obj =3D data;
=20
@@ -467,7 +467,7 @@ static void object_finalize(void *data)
     }
 }
=20
-Object *object_new_with_type(Type type)
+static Object *object_new_with_type(Type type)
 {
     Object *obj;
=20
diff --git a/include/qom/object.h b/include/qom/object.h
index c5456db05d..e9791a210e 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -586,18 +586,6 @@ struct InterfaceClass
  */
 Object *object_new(const char *typename);
=20
-/**
- * object_new_with_type:
- * @type: The type of the object to instantiate.
- *
- * This function will initialize a new object using heap allocated memor=
y.
- * The returned object has a reference count of 1, and will be freed whe=
n
- * the last reference is dropped.
- *
- * Returns: The newly allocated and instantiated object.
- */
-Object *object_new_with_type(Type type);
-
 /**
  * object_new_with_props:
  * @typename:  The name of the type of the object to instantiate.
@@ -726,18 +714,6 @@ int object_set_propv(Object *obj,
                      Error **errp,
                      va_list vargs);
=20
-/**
- * object_initialize_with_type:
- * @data: A pointer to the memory to be used for the object.
- * @size: The maximum size available at @data for the object.
- * @type: The type of the object to instantiate.
- *
- * This function will initialize an object.  The memory for the object s=
hould
- * have already been allocated.  The returned object has a reference cou=
nt of 1,
- * and will be finalized when the last reference is dropped.
- */
-void object_initialize_with_type(void *data, size_t size, Type type);
-
 /**
  * object_initialize:
  * @obj: A pointer to the memory to be used for the object.
--=20
2.11.0
