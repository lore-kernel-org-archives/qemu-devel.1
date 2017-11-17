Received: from eggs.gnu.org ([2001:4830:134:3::10]:49824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvE-0000nv-Fs
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvC-0007Nn-GT
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdvC-0007Mb-9R
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BFD3C014170
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 10:30:53 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 11:30:46 +0100
Message-Id: <20171117103046.15943-25-kraxel@redhat.com>
In-Reply-To: <20171117103046.15943-1-kraxel@redhat.com>
References: <20171117103046.15943-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 24/24] build: opengl should not need X11
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
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 67a8c2e83a..e344c0d08e 100755
--- a/configure
+++ b/configure
@@ -3685,8 +3685,8 @@ libs_softmmu="$libs_softmmu $fdt_libs"
 if test "$opengl" != "no" ; then
   opengl_pkgs="epoxy libdrm gbm"
   if $pkg_config $opengl_pkgs x11; then
-    opengl_cflags="$($pkg_config --cflags $opengl_pkgs) $x11_cflags"
-    opengl_libs="$($pkg_config --libs $opengl_pkgs) $x11_libs"
+    opengl_cflags="$($pkg_config --cflags $opengl_pkgs)"
+    opengl_libs="$($pkg_config --libs $opengl_pkgs)"
     opengl=yes
     if test "$gtk" = "yes" && $pkg_config --exists "$gtkpackage >= 3.16"; then
         gtk_gl="yes"
-- 
2.9.3
