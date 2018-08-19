Received: from eggs.gnu.org ([2001:4830:134:3::10]:44010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1frjYr-0000Cw-4P
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1frjYo-0000jS-JE
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:33 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:40044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1frjYj-0000ga-9c
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:27 -0400
Received: by mail-wr1-x431.google.com with SMTP id n2-v6so2405584wrw.7
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 05:45:24 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sun, 19 Aug 2018 23:22:56 +0300
Message-Id: <20180819202300.10590-12-marcel.apfelbaum@gmail.com>
In-Reply-To: <20180819202300.10590-1-marcel.apfelbaum@gmail.com>
References: <20180819202300.10590-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 11/15] hw/rdma: Print backend QP number in
 hex format
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

To be consistent with other prints throughout the code fix places that
print it as decimal number.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20180805153518.2983-12-yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
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
