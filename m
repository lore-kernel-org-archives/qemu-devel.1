Received: from eggs.gnu.org ([2001:4830:134:3::10]:59183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fZJ9M-0001fv-CC
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fZJ9H-0000Zs-HT
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:55:04 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:42213)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mjt@tls.msk.ru>) id 1fZJ9H-000067-9F
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:54:59 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sat, 30 Jun 2018 19:54:48 +0300
Message-Id: <20180630165448.30795-1-mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PATCH] ui: do not build-depend or link with libdrm,
 it is not needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>

Opengl support brings up libdrm. But actually nothing uses this library
or includes any of its headers. Just remove checking for it from configure.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 65548df1fc..951ff022dd 100755
--- a/configure
+++ b/configure
@@ -3865,7 +3865,7 @@ libs_softmmu="$libs_softmmu $fdt_libs"
 # opengl probe (for sdl2, gtk, milkymist-tmu2)
 
 if test "$opengl" != "no" ; then
-  opengl_pkgs="epoxy libdrm gbm"
+  opengl_pkgs="epoxy gbm"
   if $pkg_config $opengl_pkgs; then
     opengl_cflags="$($pkg_config --cflags $opengl_pkgs)"
     opengl_libs="$($pkg_config --libs $opengl_pkgs)"
-- 
2.11.0
