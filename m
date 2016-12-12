Received: from eggs.gnu.org ([2001:4830:134:3::10]:43125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGUSY-00045Z-Us
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 12:32:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGUSY-0000vq-98
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 12:32:18 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 12 Dec 2016 20:31:50 +0300
Message-Id: <20161212173151.18092-2-marcandre.lureau@redhat.com>
In-Reply-To: <20161212173151.18092-1-marcandre.lureau@redhat.com>
References: <20161212173151.18092-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] object.h: improve OBJECT/OBJECT_CLASS doc
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index c5e6fc1f5d..c5456db05d 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -467,7 +467,7 @@ struct TypeInfo
  * OBJECT:
  * @obj: A derivative of #Object
  *
- * Converts an object to a #Object.  Since all objects are #Objects,
+ * Converts an object to a #Object.  Since all objects are #Object,
  * this function will always succeed.
  */
 #define OBJECT(obj) \
@@ -477,8 +477,8 @@ struct TypeInfo
  * OBJECT_CLASS:
  * @class: A derivative of #ObjectClass.
  *
- * Converts a class to an #ObjectClass.  Since all objects are #Objects,
- * this function will always succeed.
+ * Converts a class to an #ObjectClass.  Since all classes are
+ * #ObjectClass, this function will always succeed.
  */
 #define OBJECT_CLASS(class) \
     ((ObjectClass *)(class))
--=20
2.11.0
