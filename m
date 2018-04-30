Received: from eggs.gnu.org ([2001:4830:134:3::10]:48771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fDEzr-0003mh-Ny
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:02:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fDEzq-0005vG-Ss
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:02:03 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:39291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fDEzq-0005uk-ME
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:02:02 -0400
Received: by mail-wm0-x241.google.com with SMTP id f8so5600710wmc.4
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 13:02:02 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Mon, 30 Apr 2018 23:02:22 +0300
Message-Id: <20180430200223.4119-7-marcel.apfelbaum@gmail.com>
In-Reply-To: <20180430200223.4119-1-marcel.apfelbaum@gmail.com>
References: <20180430200223.4119-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH 6/7] hw/rdma: Delete duplicate definition of
 MAX_RM_TBL_NAME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel.apfelbaum@gmail.com, yuval.shaia@oracle.com, peter.maydell@linaro.org

From: Yuval Shaia <yuval.shaia@oracle.com>

By a mistake this constant was defined twice - remove the duplication.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_rm.c      | 2 --
 hw/rdma/rdma_rm_defs.h | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index 51a47d7292..415da15efe 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -21,8 +21,6 @@
 #include "rdma_backend.h"
 #include "rdma_rm.h"
 
-#define MAX_RM_TBL_NAME 16
-
 /* Page directory and page tables */
 #define PG_DIR_SZ { TARGET_PAGE_SIZE / sizeof(__u64) }
 #define PG_TBL_SZ { TARGET_PAGE_SIZE / sizeof(__u64) }
diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
index 4d22a20e4c..226011176d 100644
--- a/hw/rdma/rdma_rm_defs.h
+++ b/hw/rdma/rdma_rm_defs.h
@@ -34,9 +34,9 @@
 #define MAX_QP_INIT_RD_ATOM   16
 #define MAX_AH                64
 
-#define MAX_RMRESTBL_NAME_SZ 16
+#define MAX_RM_TBL_NAME 16
 typedef struct RdmaRmResTbl {
-    char name[MAX_RMRESTBL_NAME_SZ];
+    char name[MAX_RM_TBL_NAME];
     QemuMutex lock;
     unsigned long *bitmap;
     size_t tbl_sz;
-- 
2.14.3
