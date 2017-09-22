Received: from eggs.gnu.org ([2001:4830:134:3::10]:37850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIgb-0008Ja-Be
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIga-00013T-Gw
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvIga-00013H-By
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:44 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 22 Sep 2017 15:46:44 +0800
Message-Id: <20170922074659.30097-22-famz@redhat.com>
In-Reply-To: <20170922074659.30097-1-famz@redhat.com>
References: <20170922074659.30097-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 21/36] buildsys: Move rdma libs to per object
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
index 9ffebeef2b..84cdb2b0a0 100755
--- a/configure
+++ b/configure
@@ -2800,7 +2800,6 @@ EOF
   rdma_libs="-lrdmacm -libverbs"
   if compile_prog "" "$rdma_libs" ; then
     rdma="yes"
-    libs_softmmu="$libs_softmmu $rdma_libs"
   else
     if test "$rdma" = "yes" ; then
         error_exit \
@@ -5988,6 +5987,7 @@ echo "CONFIG_TRACE_FILE=$trace_file" >> $config_host_mak
 
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
