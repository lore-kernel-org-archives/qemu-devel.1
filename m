Received: from eggs.gnu.org ([2001:4830:134:3::10]:49822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvE-0000nt-EA
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvC-0007OC-W4
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdvC-0007Nc-Ng
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D6A9ED9659
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 10:30:53 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 11:30:43 +0100
Message-Id: <20171117103046.15943-22-kraxel@redhat.com>
In-Reply-To: <20171117103046.15943-1-kraxel@redhat.com>
References: <20171117103046.15943-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 21/24] sdl: build as module
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
 Makefile.objs    | 1 +
 ui/Makefile.objs | 6 +++---
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index 0e856bbc04..7d1e9b187d 100755
--- a/configure
+++ b/configure
@@ -5754,7 +5754,7 @@ if test "$modules" = "yes"; then
   echo "CONFIG_MODULES=y" >> $config_host_mak
 fi
 if test "$sdl" = "yes" ; then
-  echo "CONFIG_SDL=y" >> $config_host_mak
+  echo "CONFIG_SDL=m" >> $config_host_mak
   echo "CONFIG_SDLABI=$sdlabi" >> $config_host_mak
   echo "SDL_CFLAGS=$sdl_cflags" >> $config_host_mak
   echo "SDL_LIBS=$sdl_libs" >> $config_host_mak
diff --git a/Makefile.objs b/Makefile.objs
index 285c6f3c15..a567df479c 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -56,6 +56,7 @@ common-obj-y += hw/
 common-obj-y += replay/
 
 common-obj-y += ui/
+common-obj-m += ui/
 common-obj-y += bt-host.o bt-vhci.o
 bt-host.o-cflags := $(BLUEZ_CFLAGS)
 
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index ec8533d6d9..6c13d7e5ed 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -8,15 +8,15 @@ vnc-obj-y += vnc-ws.o
 vnc-obj-y += vnc-jobs.o
 
 common-obj-y += keymaps.o console.o cursor.o qemu-pixman.o
-common-obj-y += input.o input-keymap.o input-legacy.o
+common-obj-y += input.o input-keymap.o input-legacy.o x_keymap.o
 common-obj-$(CONFIG_LINUX) += input-linux.o
 common-obj-$(CONFIG_SPICE) += spice-core.o spice-input.o spice-display.o
-common-obj-$(CONFIG_SDL) += sdl.mo x_keymap.o
 common-obj-$(CONFIG_COCOA) += cocoa.o
 common-obj-$(CONFIG_CURSES) += curses.o
 common-obj-$(CONFIG_VNC) += $(vnc-obj-y)
-common-obj-$(CONFIG_GTK) += gtk.o x_keymap.o
+common-obj-$(CONFIG_GTK) += gtk.o
 
+common-obj-$(CONFIG_SDL) += sdl.mo
 ifeq ($(CONFIG_SDLABI),1.2)
 sdl.mo-objs := sdl.o sdl_zoom.o
 endif
-- 
2.9.3
