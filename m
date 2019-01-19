Received: from eggs.gnu.org ([209.51.188.92]:55290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gknTa-0001MS-H9
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gknTZ-00082i-FN
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:42 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gknTZ-0007ry-3R
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:41 -0500
Received: by mail-wm1-x343.google.com with SMTP id r24so2638911wmh.0
	for <qemu-devel@nongnu.org>; Sat, 19 Jan 2019 02:03:25 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 19 Jan 2019 12:03:08 +0200
Message-Id: <20190119100315.23985-4-marcel.apfelbaum@gmail.com>
In-Reply-To: <20190119100315.23985-1-marcel.apfelbaum@gmail.com>
References: <20190119100315.23985-1-marcel.apfelbaum@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH PULL 03/10] hw/rdma: Delete unused struct member
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, kamalheib1@gmail.com, liq3ea@163.com, cohuck@redhat.com, philmd@redhat.com

From: Yuval Shaia <yuval.shaia@oracle.com>

This member is used only in init_device_caps function, make it local.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_backend.c      | 26 ++++++++++++++------------
 hw/rdma/rdma_backend_defs.h |  1 -
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 16dca69ee9..b49edaacaf 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -917,23 +917,25 @@ void rdma_backend_destroy_qp(RdmaBackendQP *qp)
 static int init_device_caps(RdmaBackendDev *backend_dev,
                             struct ibv_device_attr *dev_attr)
 {
-    if (ibv_query_device(backend_dev->context, &backend_dev->dev_attr)) {
+    struct ibv_device_attr bk_dev_attr;
+
+    if (ibv_query_device(backend_dev->context, &bk_dev_attr)) {
         return -EIO;
     }
 
     dev_attr->max_sge = MAX_SGE;
 
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_mr_size, "%" PRId64);
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_qp, "%d");
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_sge, "%d");
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_qp_wr, "%d");
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_cq, "%d");
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_cqe, "%d");
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_mr, "%d");
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_pd, "%d");
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_qp_rd_atom, "%d");
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_qp_init_rd_atom, "%d");
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_ah, "%d");
+    CHK_ATTR(dev_attr, bk_dev_attr, max_mr_size, "%" PRId64);
+    CHK_ATTR(dev_attr, bk_dev_attr, max_qp, "%d");
+    CHK_ATTR(dev_attr, bk_dev_attr, max_sge, "%d");
+    CHK_ATTR(dev_attr, bk_dev_attr, max_qp_wr, "%d");
+    CHK_ATTR(dev_attr, bk_dev_attr, max_cq, "%d");
+    CHK_ATTR(dev_attr, bk_dev_attr, max_cqe, "%d");
+    CHK_ATTR(dev_attr, bk_dev_attr, max_mr, "%d");
+    CHK_ATTR(dev_attr, bk_dev_attr, max_pd, "%d");
+    CHK_ATTR(dev_attr, bk_dev_attr, max_qp_rd_atom, "%d");
+    CHK_ATTR(dev_attr, bk_dev_attr, max_qp_init_rd_atom, "%d");
+    CHK_ATTR(dev_attr, bk_dev_attr, max_ah, "%d");
 
     return 0;
 }
diff --git a/hw/rdma/rdma_backend_defs.h b/hw/rdma/rdma_backend_defs.h
index 1e5c3dd3bf..15ae8b970e 100644
--- a/hw/rdma/rdma_backend_defs.h
+++ b/hw/rdma/rdma_backend_defs.h
@@ -41,7 +41,6 @@ typedef struct RdmaCmMux {
 } RdmaCmMux;
 
 typedef struct RdmaBackendDev {
-    struct ibv_device_attr dev_attr;
     RdmaBackendThread comp_thread;
     PCIDevice *dev;
     RdmaDeviceResources *rdma_dev_res;
-- 
2.17.1
