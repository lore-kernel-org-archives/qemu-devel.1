Received: from eggs.gnu.org ([209.51.188.92]:59505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLD-0001eq-Nq
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLC-0004fN-VB
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:19 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nLC-0004fC-Lp
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:18 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:21:06 -0800
Message-Id: <20190307072106.8288-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 05/37] multi-process: Add
 config option for multi-process QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, kraxel@redhat.com, berrange@redhat.com, philmd@redhat.com, pbonzini@redhat.com, thuth@redhat.com

From: Jagannathan Raman <jag.raman@oracle.com>

Add a configuration option to separate multi-process code

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 configure | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/configure b/configure
index cefeb8f..acdfc3c 100755
--- a/configure
+++ b/configure
@@ -488,6 +488,7 @@ docker="no"
 debug_mutex="no"
 libpmem=""
 libudev="no"
+mpqemu="no"
 
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
 cross_cc_aarch64="aarch64-linux-gnu-gcc"
@@ -1497,6 +1498,10 @@ for opt do
   ;;
   --disable-libpmem) libpmem=no
   ;;
+  --enable-mpqemu) mpqemu=yes
+  ;;
+  --disable-mpqemu) mpqemu=no
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1778,6 +1783,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   capstone        capstone disassembler support
   debug-mutex     mutex debugging support
   libpmem         libpmem support
+  mpqemu          multi-process QEMU support
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -6250,6 +6256,7 @@ echo "capstone          $capstone"
 echo "docker            $docker"
 echo "libpmem support   $libpmem"
 echo "libudev           $libudev"
+echo "multiprocess QEMU $mpqemu"
 
 if test "$supported_cpu" = "no"; then
     echo
@@ -7015,6 +7022,10 @@ if test "$libpmem" = "yes" ; then
   echo "CONFIG_LIBPMEM=y" >> $config_host_mak
 fi
 
+if test "$mpqemu" = "yes" ; then
+  echo "CONFIG_MPQEMU=y" >> $config_host_mak
+fi
+
 if test "$bochs" = "yes" ; then
   echo "CONFIG_BOCHS=y" >> $config_host_mak
 fi
-- 
1.8.3.1
