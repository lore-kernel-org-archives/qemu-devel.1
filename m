Received: from eggs.gnu.org ([2001:4830:134:3::10]:48966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gNJOr-0004A5-ON
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gNJOk-0003M0-EB
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:17:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40101)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1gNJOf-0003Ey-H3
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:17:33 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 32C94308AA0F
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 15:17:27 +0000 (UTC)
From: Erik Skultety <eskultet@redhat.com>
Date: Thu, 15 Nov 2018 16:15:56 +0100
Message-Id: <2e068d4e0cb5ae06aaa401a89cdcf79df7a5df7d.1542294676.git.eskultet@redhat.com>
In-Reply-To: <cover.1542294676.git.eskultet@redhat.com>
References: <cover.1542294676.git.eskultet@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] help: Provide help for egl-headless
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Erik Skultety <eskultet@redhat.com>

EGL headless has been missing from QEMU's help or man page, we should
mention that such a thing exists, especially since projects like libvirt
might rely on that. This patch also adds the newly introduced option for
egl-headless 'rendernode'.

Signed-off-by: Erik Skultety <eskultet@redhat.com>
---
 qemu-options.hx | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index ee379b32e3..f7df472f43 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1216,7 +1216,8 @@ DEF("display", HAS_ARG, QEMU_OPTION_display,
     "-display gtk[,grab_on_hover=3Don|off][,gl=3Don|off]|\n"
     "-display vnc=3D<display>[,<optargs>]\n"
     "-display curses\n"
-    "-display none"
+    "-display none\n"
+    "-display egl-headless[,rendernode=3D<file>]"
     "                select display type\n"
     "The default display is equivalent to\n"
 #if defined(CONFIG_GTK)
@@ -1258,6 +1259,9 @@ menus and other UI elements to configure and contro=
l the VM during
 runtime.
 @item vnc
 Start a VNC server on display <arg>
+@item egl-headless
+Offload all OpenGL operations to a local DRI device. For any graphical d=
isplay,
+this display needs to be paired with either VNC or SPICE displays.
 @end table
 ETEXI
=20
--=20
2.19.1
