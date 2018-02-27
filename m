Received: from eggs.gnu.org ([2001:4830:134:3::10]:46300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqaIL-0001dd-FQ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:07:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqaIJ-0003Dv-JG
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:07:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43716 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eqaIJ-0003DD-Ep
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:07:27 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 295AE40201A5
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 08:07:27 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 27 Feb 2018 09:07:23 +0100
Message-Id: <20180227080724.13585-12-kraxel@redhat.com>
In-Reply-To: <20180227080724.13585-1-kraxel@redhat.com>
References: <20180227080724.13585-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 11/12] gtk: build as ui module
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

Also drop gtk and vte libs from libs_softmmu, so the libs are not
pulled in unless the gtk module actually gets loaded.

Shared library dependencies dropped from qemu-system-*:

libEGL.so.1 => /lib64/libEGL.so.1
libGL.so.1 => /lib64/libGL.so.1
libXcomposite.so.1 => /lib64/libXcomposite.so.1
libXcursor.so.1 => /lib64/libXcursor.so.1
libXdamage.so.1 => /lib64/libXdamage.so.1
libXfixes.so.3 => /lib64/libXfixes.so.3
libXinerama.so.1 => /lib64/libXinerama.so.1
libXrandr.so.2 => /lib64/libXrandr.so.2
libXrender.so.1 => /lib64/libXrender.so.1
libXxf86vm.so.1 => /lib64/libXxf86vm.so.1
libatk-1.0.so.0 => /lib64/libatk-1.0.so.0
libatk-bridge-2.0.so.0 => /lib64/libatk-bridge-2.0.so.0
libatspi.so.0 => /lib64/libatspi.so.0
libcairo-gobject.so.2 => /lib64/libcairo-gobject.so.2
libcairo.so.2 => /lib64/libcairo.so.2
libfontconfig.so.1 => /lib64/libfontconfig.so.1
libfreetype.so.6 => /lib64/libfreetype.so.6
libgdk-3.so.0 => /lib64/libgdk-3.so.0
libgdk_pixbuf-2.0.so.0 => /lib64/libgdk_pixbuf-2.0.so.0
libglapi.so.0 => /lib64/libglapi.so.0
libgraphite2.so.3 => /lib64/libgraphite2.so.3
libgtk-3.so.0 => /lib64/libgtk-3.so.0
libharfbuzz.so.0 => /lib64/libharfbuzz.so.0
libpango-1.0.so.0 => /lib64/libpango-1.0.so.0
libpangocairo-1.0.so.0 => /lib64/libpangocairo-1.0.so.0
libpangoft2-1.0.so.0 => /lib64/libpangoft2-1.0.so.0
libpcre2-8.so.0 => /lib64/libpcre2-8.so.0
libthai.so.0 => /lib64/libthai.so.0
libvte-2.91.so.0 => /lib64/libvte-2.91.so.0
libwayland-cursor.so.0 => /lib64/libwayland-cursor.so.0
libwayland-egl.so.1 => /lib64/libwayland-egl.so.1
libxcb-dri2.so.0 => /lib64/libxcb-dri2.so.0
libxcb-dri3.so.0 => /lib64/libxcb-dri3.so.0
libxcb-glx.so.0 => /lib64/libxcb-glx.so.0
libxcb-present.so.0 => /lib64/libxcb-present.so.0
libxcb-render.so.0 => /lib64/libxcb-render.so.0
libxcb-shm.so.0 => /lib64/libxcb-shm.so.0
libxcb-sync.so.1 => /lib64/libxcb-sync.so.1
libxcb-xfixes.so.0 => /lib64/libxcb-xfixes.so.0
libxkbcommon.so.0 => /lib64/libxkbcommon.so.0
libxshmfence.so.1 => /lib64/libxshmfence.so.1

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180221131537.31341-12-kraxel@redhat.com
---
 configure        |  5 ++---
 ui/Makefile.objs | 17 +++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index edbc568913..4cabdf8c9f 100755
--- a/configure
+++ b/configure
@@ -2547,7 +2547,6 @@ if test "$gtk" != "no"; then
             gtk_cflags="$gtk_cflags $x11_cflags"
             gtk_libs="$gtk_libs $x11_libs"
         fi
-        libs_softmmu="$gtk_libs $libs_softmmu"
         gtk="yes"
     elif test "$gtk" = "yes"; then
         feature_not_found "gtk" "Install gtk3-devel"
@@ -2797,7 +2796,6 @@ if test "$vte" != "no"; then
         vte_cflags=$($pkg_config --cflags $vtepackage)
         vte_libs=$($pkg_config --libs $vtepackage)
         vteversion=$($pkg_config --modversion $vtepackage)
-        libs_softmmu="$vte_libs $libs_softmmu"
         vte="yes"
     elif test "$vte" = "yes"; then
         if test "$gtkabi" = "3.0"; then
@@ -6137,7 +6135,7 @@ if test "$glib_subprocess" = "yes" ; then
   echo "CONFIG_HAS_GLIB_SUBPROCESS_TESTS=y" >> $config_host_mak
 fi
 if test "$gtk" = "yes" ; then
-  echo "CONFIG_GTK=y" >> $config_host_mak
+  echo "CONFIG_GTK=m" >> $config_host_mak
   echo "CONFIG_GTKABI=$gtkabi" >> $config_host_mak
   echo "GTK_CFLAGS=$gtk_cflags" >> $config_host_mak
   echo "GTK_LIBS=$gtk_libs" >> $config_host_mak
@@ -6188,6 +6186,7 @@ fi
 if test "$vte" = "yes" ; then
   echo "CONFIG_VTE=y" >> $config_host_mak
   echo "VTE_CFLAGS=$vte_cflags" >> $config_host_mak
+  echo "VTE_LIBS=$vte_libs" >> $config_host_mak
 fi
 if test "$virglrenderer" = "yes" ; then
   echo "CONFIG_VIRGL=y" >> $config_host_mak
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index ef4bd83fde..9a0e8a94f1 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -15,7 +15,6 @@ common-obj-$(CONFIG_COCOA) += cocoa.o
 common-obj-$(CONFIG_CURSES) += curses.o
 common-obj-$(CONFIG_VNC) += $(vnc-obj-y)
 common-obj-$(call lnot,$(CONFIG_VNC)) += vnc-stubs.o
-common-obj-$(CONFIG_GTK) += gtk.o
 
 common-obj-$(CONFIG_X11) += x_keymap.o
 x_keymap.o-cflags := $(X11_CFLAGS)
@@ -35,6 +34,12 @@ endif
 sdl.mo-cflags := $(SDL_CFLAGS)
 sdl.mo-libs := $(SDL_LIBS)
 
+# ui-gtk module
+common-obj-$(CONFIG_GTK) += gtk.mo
+gtk.mo-objs := gtk.o
+gtk.mo-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
+gtk.mo-libs := $(GTK_LIBS) $(VTE_LIBS)
+
 ifeq ($(CONFIG_OPENGL),y)
 common-obj-y += shader.o
 common-obj-y += console-gl.o
@@ -42,17 +47,13 @@ common-obj-y += egl-helpers.o
 common-obj-y += egl-context.o
 common-obj-$(CONFIG_OPENGL_DMABUF) += egl-headless.o
 ifeq ($(CONFIG_GTK_GL),y)
-common-obj-$(CONFIG_GTK) += gtk-gl-area.o
+gtk.mo-objs += gtk-gl-area.o
 else
-common-obj-$(CONFIG_GTK) += gtk-egl.o
+gtk.mo-objs += gtk-egl.o
+gtk.mo-libs += $(OPENGL_LIBS)
 endif
 endif
 
-gtk.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
-gtk-egl.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
-gtk-gl-area.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
-
-gtk-egl.o-libs += $(OPENGL_LIBS)
 shader.o-libs += $(OPENGL_LIBS)
 console-gl.o-libs += $(OPENGL_LIBS)
 egl-helpers.o-libs += $(OPENGL_LIBS)
-- 
2.9.3
