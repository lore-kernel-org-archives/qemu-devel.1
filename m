Received: from eggs.gnu.org ([2001:4830:134:3::10]:43074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZKt-0003w2-3N
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:44:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZKs-0003gW-CP
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:44:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cGZKs-0003fl-6I
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:44:42 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DE51C05AA40
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 22:44:41 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Dec 2016 01:42:48 +0300
Message-Id: <20161212224325.20790-18-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-1-marcandre.lureau@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 17/54] baum: convert to finalize
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
 backends/baum.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/backends/baum.c b/backends/baum.c
index 80103b6098..e6758a4dbc 100644
--- a/backends/baum.c
+++ b/backends/baum.c
@@ -631,9 +631,9 @@ static void baum_chr_read(void *opaque)
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
@@ -674,13 +674,13 @@ static void char_braille_class_init(ObjectClass *oc=
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
2.11.0
