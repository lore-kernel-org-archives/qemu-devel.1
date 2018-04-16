Received: from eggs.gnu.org ([2001:4830:134:3::10]:56681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f88iL-0007eH-71
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 14:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f88iG-0003kP-Fe
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 14:18:51 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Apr 2018 20:18:44 +0200
Message-Id: <20180416181844.7851-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] mux: fix ctrl-a b again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-stable@nongnu.org

Commit fb5e19d2e1472e96d72d5e4d89c20033f8ab345c originally fixed the
regression, but was inadvertently broken again in merge commit
2d6752d38d8acda.

Fixes:
https://bugs.launchpad.net/qemu/+bug/1654137

Cc: qemu-stable@nongnu.org
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-mux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 1b925c8dec..6055e76293 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -304,6 +304,7 @@ void mux_set_focus(Chardev *chr, int focus)
     }
=20
     d->focus =3D focus;
+    chr->be =3D d->backends[focus];
     mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
 }
=20
--=20
2.17.0.rc1.36.gcedb63ea2f
