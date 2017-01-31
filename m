Received: from eggs.gnu.org ([2001:4830:134:3::10]:45385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbBg-0007zu-Gq
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:21:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbBc-0000jX-Ft
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:21:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbBc-0000jP-9X
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:21:40 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:20:44 +0400
Message-Id: <20170131162122.29408-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/41] baum: convert to finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 backends/baum.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/backends/baum.c b/backends/baum.c
index 0f418ed358..39c9365024 100644
--- a/backends/baum.c
+++ b/backends/baum.c
@@ -616,9 +616,9 @@ static void baum_chr_read(void *opaque)
     }
 }
=20
-static void baum_chr_free(Chardev *chr)
+static void char_braille_finalize(Object *obj)
 {
-    BaumChardev *baum =3D BAUM_CHARDEV(chr);
+    BaumChardev *baum =3D BAUM_CHARDEV(obj);
=20
     timer_free(baum->cellCount_timer);
     if (baum->brlapi) {
@@ -659,13 +659,13 @@ static void char_braille_class_init(ObjectClass *oc=
, void *data)
     cc->open =3D baum_chr_open;
     cc->chr_write =3D baum_chr_write;
     cc->chr_accept_input =3D baum_chr_accept_input;
-    cc->chr_free =3D baum_chr_free;
 }
=20
 static const TypeInfo char_braille_type_info =3D {
     .name =3D TYPE_CHARDEV_BRAILLE,
     .parent =3D TYPE_CHARDEV,
     .instance_size =3D sizeof(BaumChardev),
+    .instance_finalize =3D char_braille_finalize,
     .class_init =3D char_braille_class_init,
 };
=20
--=20
2.11.0.295.gd7dffce1c.dirty
