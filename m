Received: from eggs.gnu.org ([2001:4830:134:3::10]:38615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsIF-0003E9-QX
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsI6-0004HI-4E
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:36:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpsI5-0004Gg-VK
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:36:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A931356D0
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 08:36:01 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Thu,  7 Sep 2017 16:35:52 +0800
Message-Id: <20170907083552.17725-3-famz@redhat.com>
In-Reply-To: <20170907083552.17725-1-famz@redhat.com>
References: <20170907083552.17725-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] buildsys: Move vde libs to per object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 configure         | 3 +--
 net/Makefile.objs | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index fb7e34a901..bc09487668 100755
--- a/configure
+++ b/configure
@@ -2963,8 +2963,6 @@ int main(void)
 EOF
   if compile_prog "" "$vde_libs" ; then
     vde=yes
-    libs_softmmu="$vde_libs $libs_softmmu"
-    libs_tools="$vde_libs $libs_tools"
   else
     if test "$vde" = "yes" ; then
       feature_not_found "vde" "Install vde (Virtual Distributed Ethernet) devel"
@@ -5545,6 +5543,7 @@ if test "$slirp" = "yes" ; then
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
