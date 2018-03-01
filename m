Received: from eggs.gnu.org ([2001:4830:134:3::10]:42686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1erL64-0005IQ-Nh
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1erL5y-00051J-SF
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:05:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43784 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1erL5y-00050Z-Nj
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:05:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A7D98182D0C
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 10:05:50 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  1 Mar 2018 11:05:47 +0100
Message-Id: <20180301100547.18962-14-kraxel@redhat.com>
In-Reply-To: <20180301100547.18962-1-kraxel@redhat.com>
References: <20180301100547.18962-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/13] ui/sdl: build as module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure        | 2 +-
 ui/Makefile.objs | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 105f79ef3d..4b0bdef154 100755
--- a/configure
+++ b/configure
@@ -6027,7 +6027,7 @@ if test "$have_x11" = "yes" -a "$need_x11" = "yes"; then
   echo "X11_LIBS=$x11_libs" >> $config_host_mak
 fi
 if test "$sdl" = "yes" ; then
-  echo "CONFIG_SDL=y" >> $config_host_mak
+  echo "CONFIG_SDL=m" >> $config_host_mak
   echo "CONFIG_SDLABI=$sdlabi" >> $config_host_mak
   echo "SDL_CFLAGS=$sdl_cflags" >> $config_host_mak
   echo "SDL_LIBS=$sdl_libs" >> $config_host_mak
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index a37232762b..dcd54a5287 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -11,7 +11,6 @@ common-obj-y += keymaps.o console.o cursor.o qemu-pixman.o
 common-obj-y += input.o input-keymap.o input-legacy.o
 common-obj-$(CONFIG_LINUX) += input-linux.o
 common-obj-$(CONFIG_SPICE) += spice-core.o spice-input.o spice-display.o
-common-obj-$(CONFIG_SDL) += sdl.mo
 common-obj-$(CONFIG_COCOA) += cocoa.o
 common-obj-$(CONFIG_VNC) += $(vnc-obj-y)
 common-obj-$(call lnot,$(CONFIG_VNC)) += vnc-stubs.o
@@ -20,6 +19,8 @@ common-obj-$(CONFIG_X11) += x_keymap.o
 x_keymap.o-cflags := $(X11_CFLAGS)
 x_keymap.o-libs := $(X11_LIBS)
 
+# ui-sdl module
+common-obj-$(CONFIG_SDL) += sdl.mo
 ifeq ($(CONFIG_SDLABI),1.2)
 sdl.mo-objs := sdl.o sdl_zoom.o
 endif
-- 
2.9.3
