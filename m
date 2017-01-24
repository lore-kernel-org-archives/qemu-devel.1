Received: from eggs.gnu.org ([2001:4830:134:3::10]:47276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVzqF-0000fP-QR
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:04:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVzqC-000068-Hv
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:04:51 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:30 +0300
Message-Id: <7bebc948e2ffaf0786c973bde6b9ea2bfe2271ed.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 26/31] Drop duplicate display option
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@gnu.org>, qemu-trivial@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Michael Tokarev <mjt@tls.msk.ru>

From: Samuel Thibault <samuel.thibault@gnu.org>

The curses and none possibilities are already documented on a separate li=
ne,
so documenting it on the sdl line was both unneeded and confusing.

Introduced in commit f04ec5afbb7d60a56863add800fd90ceee66f362
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 84b7bd9..659b88d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -926,7 +926,7 @@ ETEXI
=20
 DEF("display", HAS_ARG, QEMU_OPTION_display,
     "-display sdl[,frame=3Don|off][,alt_grab=3Don|off][,ctrl_grab=3Don|o=
ff]\n"
-    "            [,window_close=3Don|off][,gl=3Don|off]|curses|none|\n"
+    "            [,window_close=3Don|off][,gl=3Don|off]\n"
     "-display gtk[,grab_on_hover=3Don|off][,gl=3Don|off]|\n"
     "-display vnc=3D<display>[,<optargs>]\n"
     "-display curses\n"
--=20
2.1.4
