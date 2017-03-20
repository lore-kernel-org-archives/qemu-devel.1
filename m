Received: from eggs.gnu.org ([2001:4830:134:3::10]:36432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cpxuR-0008T8-Gw
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cpxuO-0005Tk-Fj
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:03:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cpxuO-0005TU-A2
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:03:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 468EF83F42
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 14:03:40 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 20 Mar 2017 15:03:27 +0100
Message-Id: <1490018607-11838-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] add opengl_cflags to QEMU_CFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure        | 2 +-
 ui/Makefile.objs | 7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index 99d8bec..89f29c1 100755
--- a/configure
+++ b/configure
@@ -3449,6 +3449,7 @@ if test "$opengl" != "no" ; then
     if test "$gtk" = "yes" && $pkg_config --exists "$gtkpackage >= 3.16"; then
         gtk_gl="yes"
     fi
+    QEMU_CFLAGS="$QEMU_CFLAGS $opengl_cflags"
   else
     if test "$opengl" = "yes" ; then
       feature_not_found "opengl" "Please install opengl (mesa) devel pkgs: $opengl_pkgs"
@@ -5503,7 +5504,6 @@ fi
 
 if test "$opengl" = "yes" ; then
   echo "CONFIG_OPENGL=y" >> $config_host_mak
-  echo "OPENGL_CFLAGS=$opengl_cflags" >> $config_host_mak
   echo "OPENGL_LIBS=$opengl_libs" >> $config_host_mak
   if test "$opengl_dmabuf" = "yes" ; then
     echo "CONFIG_OPENGL_DMABUF=y" >> $config_host_mak
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index dc936f1..27566b3 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -41,11 +41,8 @@ endif
 endif
 
 gtk.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
-gtk-egl.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS) $(OPENGL_CFLAGS)
-gtk-gl-area.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS) $(OPENGL_CFLAGS)
-shader.o-cflags += $(OPENGL_CFLAGS)
-console-gl.o-cflags += $(OPENGL_CFLAGS)
-egl-helpers.o-cflags += $(OPENGL_CFLAGS)
+gtk-egl.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
+gtk-gl-area.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
 
 gtk-egl.o-libs += $(OPENGL_LIBS)
 shader.o-libs += $(OPENGL_LIBS)
-- 
1.8.3.1
