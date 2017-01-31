Received: from eggs.gnu.org ([2001:4830:134:3::10]:45341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbBZ-0007t0-EL
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:21:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbBY-0000iv-LD
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:21:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbBY-0000im-En
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:21:36 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:20:43 +0400
Message-Id: <20170131162122.29408-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/41] spice-qemu-char: convert to finalize
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
 spice-qemu-char.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/spice-qemu-char.c b/spice-qemu-char.c
index dd97c17fca..3902202a35 100644
--- a/spice-qemu-char.c
+++ b/spice-qemu-char.c
@@ -210,9 +210,9 @@ static int spice_chr_write(Chardev *chr, const uint8_=
t *buf, int len)
     return read_bytes;
 }
=20
-static void spice_chr_free(struct Chardev *chr)
+static void char_spice_finalize(Object *obj)
 {
-    SpiceChardev *s =3D SPICE_CHARDEV(chr);
+    SpiceChardev *s =3D SPICE_CHARDEV(obj);
=20
     vmc_unregister_interface(s);
     QLIST_REMOVE(s, next);
@@ -365,13 +365,13 @@ static void char_spice_class_init(ObjectClass *oc, =
void *data)
     cc->chr_write =3D spice_chr_write;
     cc->chr_add_watch =3D spice_chr_add_watch;
     cc->chr_accept_input =3D spice_chr_accept_input;
-    cc->chr_free =3D spice_chr_free;
 }
=20
 static const TypeInfo char_spice_type_info =3D {
     .name =3D TYPE_CHARDEV_SPICE,
     .parent =3D TYPE_CHARDEV,
     .instance_size =3D sizeof(SpiceChardev),
+    .instance_finalize =3D char_spice_finalize,
     .class_init =3D char_spice_class_init,
     .abstract =3D true,
 };
--=20
2.11.0.295.gd7dffce1c.dirty
