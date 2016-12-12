Received: from eggs.gnu.org ([2001:4830:134:3::10]:43122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZKz-000422-2R
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZKv-0003i6-UY
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:44:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cGZKv-0003hm-Oh
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:44:45 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA936C04B924
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 22:44:44 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Dec 2016 01:42:49 +0300
Message-Id: <20161212224325.20790-19-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-1-marcandre.lureau@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 18/54] msmouse: convert to finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
2.11.0
