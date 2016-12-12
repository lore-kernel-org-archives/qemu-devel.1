Received: from eggs.gnu.org ([2001:4830:134:3::10]:43044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZKq-0003u8-IK
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:44:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZKo-0003eq-S3
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:44:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cGZKo-0003ea-LQ
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:44:38 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE9688123A
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 22:44:37 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Dec 2016 01:42:47 +0300
Message-Id: <20161212224325.20790-17-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-1-marcandre.lureau@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 16/54] spice-qemu-char: convert to finalize
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
 spice-qemu-char.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/spice-qemu-char.c b/spice-qemu-char.c
index e27b86622a..af30143720 100644
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
@@ -364,13 +364,13 @@ static void char_spice_class_init(ObjectClass *oc, =
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
2.11.0
