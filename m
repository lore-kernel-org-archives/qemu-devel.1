Received: from eggs.gnu.org ([2001:4830:134:3::10]:37203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGYvG-00053F-8z
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:18:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGYvD-0002g2-36
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:18:14 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Dec 2016 01:17:59 +0300
Message-Id: <20161212221759.28949-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] trace-events: spelling fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/trace-events b/trace-events
index f74e1d3d22..da5bbb3a3a 100644
--- a/trace-events
+++ b/trace-events
@@ -47,7 +47,7 @@ qemu_system_shutdown_request(void) ""
 qemu_system_powerdown_request(void) ""
=20
 # spice-qemu-char.c
-spice_vmc_write(ssize_t out, int len) "spice wrottn %zd of requested %d"
+spice_vmc_write(ssize_t out, int len) "spice wrote %zd of requested %d"
 spice_vmc_read(int bytes, int len) "spice read %d of requested %d"
 spice_vmc_register_interface(void *scd) "spice vmc registered interface =
%p"
 spice_vmc_unregister_interface(void *scd) "spice vmc unregistered interf=
ace %p"
--=20
2.11.0
