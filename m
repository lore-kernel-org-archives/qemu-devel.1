Received: from eggs.gnu.org ([2001:4830:134:3::10]:43902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1frjYb-0008Ss-9t
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1frjYa-0000dX-NS
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:17 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:36302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1frjYa-0000dC-Gc
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:16 -0400
Received: by mail-wr1-x435.google.com with SMTP id m27-v6so6643074wrf.3
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 05:45:16 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sun, 19 Aug 2018 23:22:50 +0300
Message-Id: <20180819202300.10590-6-marcel.apfelbaum@gmail.com>
In-Reply-To: <20180819202300.10590-1-marcel.apfelbaum@gmail.com>
References: <20180819202300.10590-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 05/15] hw/pvrdma: Make default pkey 0xFFFF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, thuth@redhat.com, marcel.apfelbaum@gmail.com

From: Yuval Shaia <yuval.shaia@oracle.com>

0x7FFF is not the default pkey - fix it.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20180805153518.2983-6-yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
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
