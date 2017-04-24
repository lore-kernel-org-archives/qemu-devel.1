Received: from eggs.gnu.org ([2001:4830:134:3::10]:42110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d2cvj-0006aa-Qa
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d2cvg-0007Om-74
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d2cvg-0007MK-0u
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2B4E80F9B
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 12:17:15 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 24 Apr 2017 14:16:56 +0200
Message-Id: <20170424121708.31953-2-kraxel@redhat.com>
In-Reply-To: <20170424121708.31953-1-kraxel@redhat.com>
References: <20170424121708.31953-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/13] console: add same surface replace
 pre-condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Catch an invalid state early, before a potential use-after-free. This is
mainly useful for documentation purposes.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20170406120513.638-2-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/console.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ui/console.c b/ui/console.c
index 419b098c11..0cbe5033dd 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1538,6 +1538,8 @@ void dpy_gfx_replace_surface(QemuConsole *con,
     DisplaySurface *old_surface =3D con->surface;
     DisplayChangeListener *dcl;
=20
+    assert(old_surface !=3D surface);
+
     con->surface =3D surface;
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (con !=3D (dcl->con ? dcl->con : active_console)) {
--=20
2.9.3
