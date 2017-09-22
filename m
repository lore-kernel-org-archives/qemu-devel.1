Received: from eggs.gnu.org ([2001:4830:134:3::10]:37743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIgR-0008BB-IS
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIgO-0000zQ-7n
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvIgO-0000yp-2B
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:32 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 22 Sep 2017 15:46:37 +0800
Message-Id: <20170922074659.30097-15-famz@redhat.com>
In-Reply-To: <20170922074659.30097-1-famz@redhat.com>
References: <20170922074659.30097-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 14/36] buildsys: Move vde libs to per object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170907083552.17725-3-famz@redhat.com>
Reviewed-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 configure         | 3 +--
 net/Makefile.objs | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index cb0f7ed0ab..956ab367dc 100755
--- a/configure
+++ b/configure
@@ -2946,8 +2946,6 @@ int main(void)
 EOF
   if compile_prog "" "$vde_libs" ; then
     vde=yes
-    libs_softmmu="$vde_libs $libs_softmmu"
-    libs_tools="$vde_libs $libs_tools"
   else
     if test "$vde" = "yes" ; then
       feature_not_found "vde" "Install vde (Virtual Distributed Ethernet) devel"
@@ -5499,6 +5497,7 @@ if test "$slirp" = "yes" ; then
 fi
 if test "$vde" = "yes" ; then
   echo "CONFIG_VDE=y" >> $config_host_mak
+  echo "VDE_LIBS=$vde_libs" >> $config_host_mak
 fi
 if test "$netmap" = "yes" ; then
   echo "CONFIG_NETMAP=y" >> $config_host_mak
diff --git a/net/Makefile.objs b/net/Makefile.objs
index 67ba5e26fb..64adf32f40 100644
--- a/net/Makefile.objs
+++ b/net/Makefile.objs
@@ -21,3 +21,5 @@ tap-obj-$(CONFIG_SOLARIS) = tap-solaris.o
 tap-obj-y ?= tap-stub.o
 common-obj-$(CONFIG_POSIX) += tap.o $(tap-obj-y)
 common-obj-$(CONFIG_WIN32) += tap-win32.o
+
+vde.o-libs = $(VDE_LIBS)
-- 
2.13.5
