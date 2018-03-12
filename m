Received: from eggs.gnu.org ([2001:4830:134:3::10]:49926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evJXA-0007CF-BI
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evJX5-0004YB-2m
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:14:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45362 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1evJX4-0004Vv-Th
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:14:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D69C68182D33
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 09:14:11 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Mar 2018 10:13:56 +0100
Message-Id: <20180312091405.19610-6-kraxel@redhat.com>
In-Reply-To: <20180312091405.19610-1-kraxel@redhat.com>
References: <20180312091405.19610-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 05/14] ui/gtk: group gtk.mo declarations in
 Makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180306090951.22932-3-kraxel@redhat.com
---
 ui/Makefile.objs | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index d1203bb80a..b560ee12c3 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -38,6 +38,13 @@ common-obj-$(CONFIG_GTK) += gtk.mo
 gtk.mo-objs := gtk.o
 gtk.mo-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
 gtk.mo-libs := $(GTK_LIBS) $(VTE_LIBS)
+ifeq ($(CONFIG_OPENGL),y)
+gtk.mo-objs += gtk-egl.o
+gtk.mo-libs += $(OPENGL_LIBS)
+ifeq ($(CONFIG_GTK_GL),y)
+gtk.mo-objs += gtk-gl-area.o
+endif
+endif
 
 common-obj-$(CONFIG_CURSES) += curses.mo
 curses.mo-objs := curses.o
@@ -50,11 +57,6 @@ common-obj-y += console-gl.o
 common-obj-y += egl-helpers.o
 common-obj-y += egl-context.o
 common-obj-$(CONFIG_OPENGL_DMABUF) += egl-headless.o
-ifeq ($(CONFIG_GTK_GL),y)
-gtk.mo-objs += gtk-gl-area.o
-endif
-gtk.mo-objs += gtk-egl.o
-gtk.mo-libs += $(OPENGL_LIBS)
 endif
 
 shader.o-libs += $(OPENGL_LIBS)
-- 
2.9.3
