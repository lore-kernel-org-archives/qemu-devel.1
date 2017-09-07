Received: from eggs.gnu.org ([2001:4830:134:3::10]:35469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsBp-0006u7-2C
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsBk-0001kc-E4
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpsBk-0001kH-8A
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49F8E7E426
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 08:29:27 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Thu,  7 Sep 2017 16:29:11 +0800
Message-Id: <20170907082918.7299-3-famz@redhat.com>
In-Reply-To: <20170907082918.7299-1-famz@redhat.com>
References: <20170907082918.7299-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/9] buildsys: Move sdl cflags/libs to per
 object
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

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 audio/Makefile.objs | 1 +
 configure           | 2 +-
 ui/Makefile.objs    | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/audio/Makefile.objs b/audio/Makefile.objs
index 481d1aa30e..c20695668f 100644
--- a/audio/Makefile.objs
+++ b/audio/Makefile.objs
@@ -11,3 +11,4 @@ common-obj-$(CONFIG_AUDIO_WIN_INT) += audio_win_int.o
 common-obj-y += wavcapture.o
 
 sdlaudio.o-cflags := $(SDL_CFLAGS)
+sdlaudio.o-libs := $(SDL_LIBS)
diff --git a/configure b/configure
index e27a4bd683..812a1ce615 100755
--- a/configure
+++ b/configure
@@ -2794,7 +2794,6 @@ EOF
     sdl_cflags="$sdl_cflags $x11_cflags"
     sdl_libs="$sdl_libs $x11_libs"
   fi
-  libs_softmmu="$sdl_libs $libs_softmmu"
 fi
 
 ##########################################
@@ -5593,6 +5592,7 @@ if test "$sdl" = "yes" ; then
   echo "CONFIG_SDL=y" >> $config_host_mak
   echo "CONFIG_SDLABI=$sdlabi" >> $config_host_mak
   echo "SDL_CFLAGS=$sdl_cflags" >> $config_host_mak
+  echo "SDL_LIBS=$sdl_libs" >> $config_host_mak
 fi
 if test "$cocoa" = "yes" ; then
   echo "CONFIG_COCOA=y" >> $config_host_mak
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 146a8ce062..b3e29e21f0 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -27,6 +27,7 @@ sdl.mo-objs += sdl2-gl.o
 endif
 endif
 sdl.mo-cflags := $(SDL_CFLAGS)
+sdl.mo-libs := $(SDL_LIBS)
 
 ifeq ($(CONFIG_OPENGL),y)
 common-obj-y += shader.o
-- 
2.13.5
