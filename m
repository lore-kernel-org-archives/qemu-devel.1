Received: from eggs.gnu.org ([2001:4830:134:3::10]:35520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsBz-00071m-4l
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsBu-0001nQ-I8
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpsBu-0001nA-CD
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70940883B6
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 08:29:37 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Thu,  7 Sep 2017 16:29:14 +0800
Message-Id: <20170907082918.7299-6-famz@redhat.com>
In-Reply-To: <20170907082918.7299-1-famz@redhat.com>
References: <20170907082918.7299-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 5/9] buildsys: Move curese cflags/libs to per
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
 configure        | 6 ++++--
 ui/Makefile.objs | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 71fa9717ff..b08cb4ce02 100755
--- a/configure
+++ b/configure
@@ -3137,8 +3137,8 @@ EOF
       unset IFS
       if compile_prog "$curses_inc" "$curses_lib" ; then
         curses_found=yes
-        QEMU_CFLAGS="$curses_inc $QEMU_CFLAGS"
-        libs_softmmu="$curses_lib $libs_softmmu"
+        curses_cflags="$curses_inc $curses_cflags"
+        curses_libs="$curses_lib $curses_libs"
         break
       fi
     done
@@ -5606,6 +5606,8 @@ if test "$cocoa" = "yes" ; then
 fi
 if test "$curses" = "yes" ; then
   echo "CONFIG_CURSES=y" >> $config_host_mak
+  echo "CURSES_CFLAGS=$curses_cflags" >> $config_host_mak
+  echo "CURSES_LIBS=$curses_libs" >> $config_host_mak
 fi
 if test "$pipe2" = "yes" ; then
   echo "CONFIG_PIPE2=y" >> $config_host_mak
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index a0b3c15a28..e3403b698b 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -57,3 +57,6 @@ gtk-egl.o-libs += $(OPENGL_LIBS)
 shader.o-libs += $(OPENGL_LIBS)
 console-gl.o-libs += $(OPENGL_LIBS)
 egl-helpers.o-libs += $(OPENGL_LIBS)
+
+curses.o-cflags := $(CURSES_CFLAGS)
+curses.o-libs := $(CURSES_LIBS)
-- 
2.13.5
