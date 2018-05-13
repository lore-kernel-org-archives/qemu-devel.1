Received: from eggs.gnu.org ([2001:4830:134:3::10]:59676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1fHmiY-00033i-Pi
	for qemu-devel@nongnu.org; Sun, 13 May 2018 04:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1fHmiU-0005C7-MY
	for qemu-devel@nongnu.org; Sun, 13 May 2018 04:50:58 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:41570
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan@weilnetz.de>) id 1fHmiU-0005BV-FO
	for qemu-devel@nongnu.org; Sun, 13 May 2018 04:50:54 -0400
From: Stefan Weil <sw@weilnetz.de>
Date: Sun, 13 May 2018 10:50:32 +0200
Message-Id: <20180513085032.27773-1-sw@weilnetz.de>
Subject: [Qemu-devel] [PATCH] configure: Use strings command from cross
 development tools
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mike Frysinger <vapier@gentoo.org>, QEMU Developer <qemu-devel@nongnu.org>
Cc: Stefan Weil <sw@weilnetz.de>

This fixes cross builds for the (rare) case where cross binutils
but no native binutils are installed.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 configure | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 24c411e346..4f6ace1ed4 100755
--- a/configure
+++ b/configure
@@ -517,6 +517,7 @@ objcopy="${OBJCOPY-${cross_prefix}objcopy}"
 ld="${LD-${cross_prefix}ld}"
 ranlib="${RANLIB-${cross_prefix}ranlib}"
 nm="${NM-${cross_prefix}nm}"
+strings="${STRINGS-${cross_prefix}strings}"
 strip="${STRIP-${cross_prefix}strip}"
 windres="${WINDRES-${cross_prefix}windres}"
 pkg_config_exe="${PKG_CONFIG-${cross_prefix}pkg-config}"
@@ -1956,9 +1957,9 @@ int main(int argc, char *argv[]) {
 EOF
 
 if compile_object ; then
-    if strings -a $TMPO | grep -q BiGeNdIaN ; then
+    if "$strings" -a $TMPO | grep -q BiGeNdIaN ; then
         bigendian="yes"
-    elif strings -a $TMPO | grep -q LiTtLeEnDiAn ; then
+    elif "$strings" -a $TMPO | grep -q LiTtLeEnDiAn ; then
         bigendian="no"
     else
         echo big/little test failed
-- 
2.11.0
