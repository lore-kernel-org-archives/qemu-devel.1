Received: from eggs.gnu.org ([2001:4830:134:3::10]:35423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsBj-0006rI-PQ
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsBi-0001jz-Em
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpsBi-0001jg-8q
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5726413A88
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 08:29:25 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Thu,  7 Sep 2017 16:29:10 +0800
Message-Id: <20170907082918.7299-2-famz@redhat.com>
In-Reply-To: <20170907082918.7299-1-famz@redhat.com>
References: <20170907082918.7299-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/9] buildsys: Move gtk/vte cflags/libs to per
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
 configure        | 3 +--
 ui/Makefile.objs | 4 ++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index b37cd54bda..e27a4bd683 100755
--- a/configure
+++ b/configure
@@ -2437,7 +2437,6 @@ if test "$gtk" != "no"; then
             gtk_cflags="$gtk_cflags $x11_cflags"
             gtk_libs="$gtk_libs $x11_libs"
         fi
-        libs_softmmu="$gtk_libs $libs_softmmu"
         gtk="yes"
     elif test "$gtk" = "yes"; then
         feature_not_found "gtk" "Install gtk3-devel"
@@ -2678,7 +2677,6 @@ if test "$vte" != "no"; then
         vte_cflags=$($pkg_config --cflags $vtepackage)
         vte_libs=$($pkg_config --libs $vtepackage)
         vteversion=$($pkg_config --modversion $vtepackage)
-        libs_softmmu="$vte_libs $libs_softmmu"
         vte="yes"
     elif test "$vte" = "yes"; then
         if test "$gtkabi" = "3.0"; then
@@ -5750,6 +5748,7 @@ fi
 if test "$vte" = "yes" ; then
   echo "CONFIG_VTE=y" >> $config_host_mak
   echo "VTE_CFLAGS=$vte_cflags" >> $config_host_mak
+  echo "VTE_LIBS=$vte_libs" >> $config_host_mak
 fi
 if test "$virglrenderer" = "yes" ; then
   echo "CONFIG_VIRGL=y" >> $config_host_mak
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 3369451285..146a8ce062 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -45,6 +45,10 @@ gtk.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
 gtk-egl.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
 gtk-gl-area.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
 
+gtk.o-libs := $(GTK_LIBS) $(VTE_LIBS)
+gtk-egl.o-libs := $(GTK_LIBS) $(VTE_LIBS)
+gtk-gl-area.o-libs := $(GTK_LIBS) $(VTE_LIBS)
+
 gtk-egl.o-libs += $(OPENGL_LIBS)
 shader.o-libs += $(OPENGL_LIBS)
 console-gl.o-libs += $(OPENGL_LIBS)
-- 
2.13.5
