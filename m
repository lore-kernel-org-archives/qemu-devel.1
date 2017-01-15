Received: from eggs.gnu.org ([2001:4830:134:3::10]:56335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cSrRU-0000Tj-3u
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 15:30:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cSrRT-0001OE-C2
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 15:30:20 -0500
Received: from hera.aquilenet.fr ([2a01:474::1]:51856)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cSrRT-0001Nc-5U
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 15:30:19 -0500
Date: Sun, 15 Jan 2017 21:30:14 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170115203014.GA12068@var.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] Drop duplicate display option documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org

The curses and none possibilities are already documented on a separate line,
so documenting it on the sdl line was both unneeded and confusing.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff --git a/qemu-options.hx b/qemu-options.hx
index c534a2f7f9..9c81d3752d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -927,7 +927,7 @@ ETEXI
 
 DEF("display", HAS_ARG, QEMU_OPTION_display,
     "-display sdl[,frame=on|off][,alt_grab=on|off][,ctrl_grab=on|off]\n"
-    "            [,window_close=on|off][,gl=on|off]|curses|none|\n"
+    "            [,window_close=on|off][,gl=on|off]\n"
     "-display gtk[,grab_on_hover=on|off][,gl=on|off]|\n"
     "-display vnc=<display>[,<optargs>]\n"
     "-display curses\n"
