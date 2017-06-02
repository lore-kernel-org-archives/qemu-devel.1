Received: from eggs.gnu.org ([2001:4830:134:3::10]:46406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGhCY-0005e7-Cr
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGhCX-00048F-Cq
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:40:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dGhCX-00047U-6g
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:40:53 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  2 Jun 2017 11:40:26 +0400
Message-Id: <20170602074040.7400-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170602074040.7400-1-marcandre.lureau@redhat.com>
References: <20170602074040.7400-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/15] char: cast ARRAY_SIZE() as signed to
 silent warning on empty array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

chardev/char.c: In function 'chardev_name_foreach':
chardev/char.c:546:19: error: comparison of unsigned expression < 0 is al=
ways false [-Werror=3Dtype-limits]
     for (i =3D 0; i < ARRAY_SIZE(chardev_alias_table); i++) {
                   ^
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20170530120919.8874-1-f4bug@amsat.org>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 4e24dc39af..26607c1c6b 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -841,7 +841,7 @@ chardev_name_foreach(void (*fn)(const char *name, voi=
d *opaque), void *opaque)
=20
     object_class_foreach(chardev_class_foreach, TYPE_CHARDEV, false, &fe=
);
=20
-    for (i =3D 0; i < ARRAY_SIZE(chardev_alias_table); i++) {
+    for (i =3D 0; i < (int)ARRAY_SIZE(chardev_alias_table); i++) {
         fn(chardev_alias_table[i].alias, opaque);
     }
 }
@@ -887,7 +887,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
         return NULL;
     }
=20
-    for (i =3D 0; i < ARRAY_SIZE(chardev_alias_table); i++) {
+    for (i =3D 0; i < (int)ARRAY_SIZE(chardev_alias_table); i++) {
         if (g_strcmp0(chardev_alias_table[i].alias, name) =3D=3D 0) {
             name =3D chardev_alias_table[i].typename;
             break;
--=20
2.13.0.91.g00982b8dd
