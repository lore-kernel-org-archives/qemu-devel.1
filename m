Received: from eggs.gnu.org ([2001:4830:134:3::10]:45393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbBg-00080A-Ph
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:21:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbBf-0000kO-VU
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:21:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbBf-0000jy-P8
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:21:43 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:20:45 +0400
Message-Id: <20170131162122.29408-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/41] msmouse: convert to finalize
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
 backends/msmouse.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/backends/msmouse.c b/backends/msmouse.c
index 936a5476d5..55c344f0e1 100644
--- a/backends/msmouse.c
+++ b/backends/msmouse.c
@@ -139,9 +139,9 @@ static int msmouse_chr_write(struct Chardev *s, const=
 uint8_t *buf, int len)
     return len;
 }
=20
-static void msmouse_chr_free(struct Chardev *chr)
+static void char_msmouse_finalize(Object *obj)
 {
-    MouseChardev *mouse =3D MOUSE_CHARDEV(chr);
+    MouseChardev *mouse =3D MOUSE_CHARDEV(obj);
=20
     qemu_input_handler_unregister(mouse->hs);
 }
@@ -172,13 +172,13 @@ static void char_msmouse_class_init(ObjectClass *oc=
, void *data)
     cc->open =3D msmouse_chr_open;
     cc->chr_write =3D msmouse_chr_write;
     cc->chr_accept_input =3D msmouse_chr_accept_input;
-    cc->chr_free =3D msmouse_chr_free;
 }
=20
 static const TypeInfo char_msmouse_type_info =3D {
     .name =3D TYPE_CHARDEV_MSMOUSE,
     .parent =3D TYPE_CHARDEV,
     .instance_size =3D sizeof(MouseChardev),
+    .instance_finalize =3D char_msmouse_finalize,
     .class_init =3D char_msmouse_class_init,
 };
=20
--=20
2.11.0.295.gd7dffce1c.dirty
