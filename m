Received: from eggs.gnu.org ([2001:4830:134:3::10]:46301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqaIL-0001de-GY
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:07:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqaIJ-0003DY-D1
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:07:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35472 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eqaIJ-0003D7-8f
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:07:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E57D2EAEA0
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 08:07:26 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 27 Feb 2018 09:07:22 +0100
Message-Id: <20180227080724.13585-11-kraxel@redhat.com>
In-Reply-To: <20180227080724.13585-1-kraxel@redhat.com>
References: <20180227080724.13585-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 10/12] sdl: build as ui module
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

Shared library dependencies dropped from qemu-system-*:

libSDL2-2.0.so.0 => /lib64/libSDL2-2.0.so.0

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180221131537.31341-11-kraxel@redhat.com
---
 configure        | 2 +-
 Makefile.objs    | 1 +
 ui/Makefile.objs | 3 ++-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index ab1ba9c47d..edbc568913 100755
--- a/configure
+++ b/configure
@@ -6031,7 +6031,7 @@ if test "$have_x11" = "yes" -a "$need_x11" = "yes"; then
   echo "X11_LIBS=$x11_libs" >> $config_host_mak
 fi
 if test "$sdl" = "yes" ; then
-  echo "CONFIG_SDL=y" >> $config_host_mak
+  echo "CONFIG_SDL=m" >> $config_host_mak
   echo "CONFIG_SDLABI=$sdlabi" >> $config_host_mak
   echo "SDL_CFLAGS=$sdl_cflags" >> $config_host_mak
   echo "SDL_LIBS=$sdl_libs" >> $config_host_mak
diff --git a/Makefile.objs b/Makefile.objs
index 5dc134818c..57ca6d908b 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -56,6 +56,7 @@ common-obj-y += hw/
 common-obj-y += replay/
 
 common-obj-y += ui/
+common-obj-m += ui/
 common-obj-y += bt-host.o bt-vhci.o
 bt-host.o-cflags := $(BLUEZ_CFLAGS)
 
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 9b725b07aa..ef4bd83fde 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -11,7 +11,6 @@ common-obj-y += keymaps.o console.o cursor.o qemu-pixman.o
 common-obj-y += input.o input-keymap.o input-legacy.o
 common-obj-$(CONFIG_LINUX) += input-linux.o
 common-obj-$(CONFIG_SPICE) += spice-core.o spice-input.o spice-display.o
-common-obj-$(CONFIG_SDL) += sdl.mo
 common-obj-$(CONFIG_COCOA) += cocoa.o
 common-obj-$(CONFIG_CURSES) += curses.o
 common-obj-$(CONFIG_VNC) += $(vnc-obj-y)
@@ -22,6 +21,8 @@ common-obj-$(CONFIG_X11) += x_keymap.o
 x_keymap.o-cflags := $(X11_CFLAGS)
 x_keymap.o-libs := $(X11_LIBS)
 
+# ui-sdl module
+common-obj-$(CONFIG_SDL) += sdl.mo
 ifeq ($(CONFIG_SDLABI),1.2)
 sdl.mo-objs := sdl.o sdl_zoom.o
 endif
-- 
2.9.3
