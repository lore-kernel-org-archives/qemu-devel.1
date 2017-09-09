Received: from eggs.gnu.org ([2001:4830:134:3::10]:34294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqYc4-0006r2-BO
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqYc3-0006tr-Hp
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:47:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqYc3-0006tU-C0
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:47:27 -0400
From: Fam Zheng <famz@redhat.com>
Date: Sat,  9 Sep 2017 13:46:13 +0800
Message-Id: <20170909054613.19148-38-famz@redhat.com>
In-Reply-To: <20170909054613.19148-1-famz@redhat.com>
References: <20170909054613.19148-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL v2 37/37] buildsys: Move rdma libs to per object
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
Message-Id: <20170907084230.26493-1-famz@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 configure               | 2 +-
 migration/Makefile.objs | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 18f6d0bd5f..ea54d8b882 100755
--- a/configure
+++ b/configure
@@ -2805,7 +2805,6 @@ EOF
   rdma_libs="-lrdmacm -libverbs"
   if compile_prog "" "$rdma_libs" ; then
     rdma="yes"
-    libs_softmmu="$libs_softmmu $rdma_libs"
   else
     if test "$rdma" = "yes" ; then
         error_exit \
@@ -6028,6 +6027,7 @@ echo "CONFIG_TRACE_FILE=$trace_file" >> $config_host_mak
 
 if test "$rdma" = "yes" ; then
   echo "CONFIG_RDMA=y" >> $config_host_mak
+  echo "RDMA_LIBS=$rdma_libs" >> $config_host_mak
 fi
 
 if test "$have_rtnetlink" = "yes" ; then
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index 1c7770da46..99e038024d 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -11,3 +11,4 @@ common-obj-$(CONFIG_RDMA) += rdma.o
 
 common-obj-$(CONFIG_LIVE_BLOCK_MIGRATION) += block.o
 
+rdma.o-libs := $(RDMA_LIBS)
-- 
2.13.5
