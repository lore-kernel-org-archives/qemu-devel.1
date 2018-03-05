Received: from eggs.gnu.org ([2001:4830:134:3::10]:37841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eslnn-0003rK-Lq
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eslnj-0003bA-OV
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:48:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55948 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eslnj-0003aF-IR
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:48:55 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9361240FB65E
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 08:48:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  5 Mar 2018 09:48:40 +0100
Message-Id: <20180305084844.18222-10-kraxel@redhat.com>
In-Reply-To: <20180305084844.18222-1-kraxel@redhat.com>
References: <20180305084844.18222-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 09/13] configure: opengl doesn't depend on x11
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

So remove x11 from pkg-config check and don't
add x11 cflags/libs to opengl cflags/libs.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180301100547.18962-10-kraxel@redhat.com
---
 configure | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 3d2aef95f8..fbfbb64029 100755
--- a/configure
+++ b/configure
@@ -3779,9 +3779,9 @@ libs_softmmu="$libs_softmmu $fdt_libs"
 
 if test "$opengl" != "no" ; then
   opengl_pkgs="epoxy libdrm gbm"
-  if $pkg_config $opengl_pkgs x11; then
-    opengl_cflags="$($pkg_config --cflags $opengl_pkgs) $x11_cflags"
-    opengl_libs="$($pkg_config --libs $opengl_pkgs) $x11_libs"
+  if $pkg_config $opengl_pkgs; then
+    opengl_cflags="$($pkg_config --cflags $opengl_pkgs)"
+    opengl_libs="$($pkg_config --libs $opengl_pkgs)"
     opengl=yes
     if test "$gtk" = "yes" && $pkg_config --exists "$gtkpackage >= 3.16"; then
         gtk_gl="yes"
-- 
2.9.3
