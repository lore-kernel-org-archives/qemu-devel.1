Received: from eggs.gnu.org ([2001:4830:134:3::10]:55290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fey8B-0001OQ-Dq
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fey88-0007AK-Ab
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:41:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1fey88-0007A4-0s
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:41:12 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 16 Jul 2018 10:40:36 +0300
Message-Id: <20180716074038.3364-12-yuval.shaia@oracle.com>
In-Reply-To: <20180716074038.3364-1-yuval.shaia@oracle.com>
References: <20180716074038.3364-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH 11/13] hw/rdma: Print backend QP number in hex
 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com

To be consistent with other prints throughout the code fix places that
print it as decimal number.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_rm.c           | 4 ++--
 hw/rdma/vmw/pvrdma_qp_ops.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index 1f014b4ab2..859c900003 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -389,7 +389,7 @@ int rdma_rm_modify_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
     RdmaRmQP *qp;
     int ret;
 
-    pr_dbg("qpn=%d\n", qp_handle);
+    pr_dbg("qpn=0x%x\n", qp_handle);
 
     qp = rdma_rm_get_qp(dev_res, qp_handle);
     if (!qp) {
@@ -447,7 +447,7 @@ int rdma_rm_query_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
 {
     RdmaRmQP *qp;
 
-    pr_dbg("qpn=%d\n", qp_handle);
+    pr_dbg("qpn=0x%x\n", qp_handle);
 
     qp = rdma_rm_get_qp(dev_res, qp_handle);
     if (!qp) {
diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
index a8664f40c8..c668afd0ed 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.c
+++ b/hw/rdma/vmw/pvrdma_qp_ops.c
@@ -130,7 +130,7 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
     PvrdmaSqWqe *wqe;
     PvrdmaRing *ring;
 
-    pr_dbg("qp_handle=%d\n", qp_handle);
+    pr_dbg("qp_handle=0x%x\n", qp_handle);
 
     qp = rdma_rm_get_qp(&dev->rdma_dev_res, qp_handle);
     if (unlikely(!qp)) {
@@ -174,7 +174,7 @@ int pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle)
     PvrdmaRqWqe *wqe;
     PvrdmaRing *ring;
 
-    pr_dbg("qp_handle=%d\n", qp_handle);
+    pr_dbg("qp_handle=0x%x\n", qp_handle);
 
     qp = rdma_rm_get_qp(&dev->rdma_dev_res, qp_handle);
     if (unlikely(!qp)) {
-- 
2.17.1
