Received: from eggs.gnu.org ([2001:4830:134:3::10]:50752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eydyQ-0007oz-43
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eydyO-0000I0-L6
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:40:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54906 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eydyO-0000H4-Gk
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:40:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A5C3412A023
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 13:40:12 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 14:40:03 +0100
Message-Id: <20180321134005.8822-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180321134005.8822-1-marcandre.lureau@redhat.com>
References: <20180321134005.8822-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] compiler: extend QEMU_GENERIC to handle
 more arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following patch is going to use more than 10 arguments to
QEMU_GENERIC.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/compiler.h | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 9f762695d1..1c11f10ebb 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -129,12 +129,17 @@
  */
=20
 /* First, find out the number of generic cases.  */
-#define QEMU_GENERIC(x, ...) \
-    QEMU_GENERIC_(typeof(x), __VA_ARGS__, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1,=
 0)
+#define QEMU_GENERIC(x, ...)                                \
+    QEMU_GENERIC_(typeof(x), __VA_ARGS__,                   \
+                  20, 19, 18, 17, 16, 15, 14, 13, 12, 11,   \
+                  10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
=20
 /* There will be extra arguments, but they are not used.  */
-#define QEMU_GENERIC_(x, a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, count, =
...) \
-    QEMU_GENERIC##count(x, a0, a1, a2, a3, a4, a5, a6, a7, a8, a9)
+#define QEMU_GENERIC_(x, a0, a1, a2, a3, a4, a5, a6, a7, a8, a9,        =
\
+                      a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, =
\
+                      count, ...)                                       =
\
+    QEMU_GENERIC##count(x, a0, a1, a2, a3, a4, a5, a6, a7, a8, a9,      =
\
+                        a10, a11, a12, a13, a14, a15, a16, a17, a18, a19=
)
=20
 /* Two more helper macros, this time to extract items from a parenthesiz=
ed
  * list.
@@ -159,5 +164,15 @@
 #define QEMU_GENERIC8(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC7(x=
, __VA_ARGS__))
 #define QEMU_GENERIC9(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC8(x=
, __VA_ARGS__))
 #define QEMU_GENERIC10(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC9(=
x, __VA_ARGS__))
+#define QEMU_GENERIC11(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC10=
(x, __VA_ARGS__))
+#define QEMU_GENERIC12(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC11=
(x, __VA_ARGS__))
+#define QEMU_GENERIC13(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC12=
(x, __VA_ARGS__))
+#define QEMU_GENERIC14(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC13=
(x, __VA_ARGS__))
+#define QEMU_GENERIC15(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC14=
(x, __VA_ARGS__))
+#define QEMU_GENERIC16(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC15=
(x, __VA_ARGS__))
+#define QEMU_GENERIC17(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC16=
(x, __VA_ARGS__))
+#define QEMU_GENERIC18(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC17=
(x, __VA_ARGS__))
+#define QEMU_GENERIC19(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC18=
(x, __VA_ARGS__))
+#define QEMU_GENERIC20(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC19=
(x, __VA_ARGS__))
=20
 #endif /* COMPILER_H */
--=20
2.16.2.521.g9aa15f885a
