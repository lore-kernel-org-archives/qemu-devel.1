Received: from eggs.gnu.org ([2001:4830:134:3::10]:39788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fmL4f-00074V-EX
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 11:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fmL4c-0006R2-7Y
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 11:36:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1fmL4b-0006Qr-UC
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 11:36:02 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Sun,  5 Aug 2018 18:35:10 +0300
Message-Id: <20180805153518.2983-6-yuval.shaia@oracle.com>
In-Reply-To: <20180805153518.2983-1-yuval.shaia@oracle.com>
References: <20180805153518.2983-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v2 05/13] hw/pvrdma: Make default pkey 0xFFFF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com

0x7FFF is not the default pkey - fix it.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma.h     | 3 +++
 hw/rdma/vmw/pvrdma_cmd.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
index 81e0e0e99c..e2d9f93cdf 100644
--- a/hw/rdma/vmw/pvrdma.h
+++ b/hw/rdma/vmw/pvrdma.h
@@ -50,6 +50,9 @@
 #define PVRDMA_HW_VERSION    17
 #define PVRDMA_FW_VERSION    14
 
+/* Some defaults */
+#define PVRDMA_PKEY          0x7FFF
+
 typedef struct DSRInfo {
     dma_addr_t dma;
     struct pvrdma_device_shared_region *dsr;
diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index e7d6589cdc..4f74b29936 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -166,7 +166,7 @@ static int query_pkey(PVRDMADev *dev, union pvrdma_cmd_req *req,
     resp->hdr.ack = PVRDMA_CMD_QUERY_PKEY_RESP;
     resp->hdr.err = 0;
 
-    resp->pkey = 0x7FFF;
+    resp->pkey = PVRDMA_PKEY;
     pr_dbg("pkey=0x%x\n", resp->pkey);
 
     return 0;
-- 
2.17.1
