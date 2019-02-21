Received: from eggs.gnu.org ([209.51.188.92]:34787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmCX-0002Av-Sj
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmCW-00070J-OL
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gwmCW-0006zR-IJ
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1D8330833C0
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 11:07:35 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 Feb 2019 12:07:01 +0100
Message-Id: <20190221110703.5775-10-marcandre.lureau@redhat.com>
In-Reply-To: <20190221110703.5775-1-marcandre.lureau@redhat.com>
References: <20190221110703.5775-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 09/11] qapi: document DisplayType enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Tested-by: Victor Toso <victortoso@redhat.com>
---
 qapi/ui.json | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/qapi/ui.json b/qapi/ui.json
index 7d9c4bddaf..7702ddf583 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1085,6 +1085,31 @@
 #
 # Display (user interface) type.
 #
+# @default: The default user interface, selecting from the first availab=
le
+#           of gtk, sdl, cocoa, and vnc.
+#
+# @none: No user interface or video output display. The guest will
+#        still see an emulated graphics card, but its output will not
+#        be displayed to the QEMU user.
+#
+# @gtk: The GTK user interface.
+#
+# @sdl: The SDL user interface.
+#
+# @egl-headless: No user interface, offload GL operations to a local
+#                DRI device. Graphical display need to be paired with
+#                VNC or Spice. (Since 3.1)
+#
+# @curses: Display video output via curses.  For graphics device
+#          models which support a text mode, QEMU can display this
+#          output using a curses/ncurses interface. Nothing is
+#          displayed when the graphics device is in graphical mode or
+#          if the graphics device does not support a text
+#          mode. Generally only the VGA device models support text
+#          mode.
+#
+# @cocoa: The Cocoa user interface.
+#
 # Since: 2.12
 #
 ##
--=20
2.21.0.rc1
