Received: from eggs.gnu.org ([2001:4830:134:3::10]:37784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eslnm-0003qo-HI
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:48:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eslnj-0003aM-A5
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:48:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39014 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eslnj-0003Yw-3F
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:48:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17728404084A
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 08:48:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  5 Mar 2018 09:48:44 +0100
Message-Id: <20180305084844.18222-14-kraxel@redhat.com>
In-Reply-To: <20180305084844.18222-1-kraxel@redhat.com>
References: <20180305084844.18222-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 13/13] ui/sdl: build as module
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
Message-id: 20180301100547.18962-14-kraxel@redhat.com
---
 configure        | 2 +-
 ui/Makefile.objs | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 269add1187..cb4fdb3573 100755
--- a/configure
+++ b/configure
@@ -6039,7 +6039,7 @@ if test "$have_x11" = "yes" -a "$need_x11" = "yes"; then
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
