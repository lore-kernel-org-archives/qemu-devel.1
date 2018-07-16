Received: from eggs.gnu.org ([2001:4830:134:3::10]:55207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fey81-0001HD-Cr
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fey7y-00071x-8e
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:41:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1fey7x-00071d-W5
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:41:02 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 16 Jul 2018 10:40:30 +0300
Message-Id: <20180716074038.3364-6-yuval.shaia@oracle.com>
In-Reply-To: <20180716074038.3364-1-yuval.shaia@oracle.com>
References: <20180716074038.3364-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel]  [PATCH 05/13] hw/pvrdma: Make default pkey 0xFFFF
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
---
 hw/rdma/vmw/pvrdma_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index e7d6589cdc..bb898265a3 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -166,7 +166,7 @@ static int query_pkey(PVRDMADev *dev, union pvrdma_cmd_req *req,
     resp->hdr.ack = PVRDMA_CMD_QUERY_PKEY_RESP;
     resp->hdr.err = 0;
 
-    resp->pkey = 0x7FFF;
+    resp->pkey = 0xFFFF;
     pr_dbg("pkey=0x%x\n", resp->pkey);
 
     return 0;
-- 
2.17.1
