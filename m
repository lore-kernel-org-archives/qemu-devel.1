Received: from eggs.gnu.org ([2001:4830:134:3::10]:35890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gZzKj-00078E-Lx
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:29:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gZz8X-00018b-Qg
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:17:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gZz8X-00018H-Kx
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:17:17 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 058D3811C0
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 14:17:17 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 20 Dec 2018 18:15:51 +0400
Message-Id: <20181220141553.24098-11-marcandre.lureau@redhat.com>
In-Reply-To: <20181220141553.24098-1-marcandre.lureau@redhat.com>
References: <20181220141553.24098-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 10/12] qapi: document DisplayType enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/ui.json | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/qapi/ui.json b/qapi/ui.json
index 5ad13248d5..3f2f662dca 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1075,6 +1075,30 @@
 #
 # Display (user interface) type.
 #
+# @default: The default user interface.
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
2.20.1.2.gb21ebb671b
