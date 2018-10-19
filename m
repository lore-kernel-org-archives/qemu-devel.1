Received: from eggs.gnu.org ([2001:4830:134:3::10]:34489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gDTht-0005DL-MI
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gDThp-0002Gc-Dh
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:16:45 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:59315)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gDThp-0002FE-2L
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:16:41 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 19 Oct 2018 14:16:21 +0200
Message-Id: <20181019121623.29148-2-laurent@vivier.eu>
In-Reply-To: <20181019121623.29148-1-laurent@vivier.eu>
References: <20181019121623.29148-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [2 1/3] linux-user: Check for Linux USBFS in configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?q?Cortland=20T=C3=B6lva?= <cst@tolva.net>

From: Cortland Tölva <cst@tolva.net>

In preparation for adding user mode emulation support for the
Linux usbfs interface, check for its kernel header.

Signed-off-by: Cortland Tölva <cst@tolva.net>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20181008163521.17341-2-cst@tolva.net>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 9138af37f8..37277fd591 100755
--- a/configure
+++ b/configure
@@ -4202,7 +4202,14 @@ if compile_prog "" "" ; then
   memfd=yes
 fi
 
-
+# check for usbfs
+have_usbfs=no
+if test "$linux_user" = "yes"; then
+  if check_include linux/usbdevice_fs.h; then
+    have_usbfs=yes
+  fi
+  have_usbfs=yes
+fi
 
 # check for fallocate
 fallocate=no
@@ -6310,6 +6317,9 @@ fi
 if test "$memfd" = "yes" ; then
   echo "CONFIG_MEMFD=y" >> $config_host_mak
 fi
+if test "$have_usbfs" = "yes" ; then
+  echo "CONFIG_USBFS=y" >> $config_host_mak
+fi
 if test "$fallocate" = "yes" ; then
   echo "CONFIG_FALLOCATE=y" >> $config_host_mak
 fi
-- 
2.17.2
