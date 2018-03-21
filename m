Received: from eggs.gnu.org ([2001:4830:134:3::10]:47874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyfZ6-0000Dt-1D
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyfZ1-0003am-Vw
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:22:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48096 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eyfZ1-0003Zc-QT
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:22:07 -0400
Date: Wed, 21 Mar 2018 17:22:07 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521645545-247351-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH for-2.12 1/2] rdma: fix up include directives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yuval Shaia <yuval.shaia@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>

Our rule right now is to use <> for external headers only.
RDMA code violates that, fix it up.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/rdma/rdma_backend.h        |  2 +-
 hw/rdma/rdma_backend_defs.h   |  2 +-
 hw/rdma/rdma_rm.h             |  2 +-
 hw/rdma/rdma_utils.h          |  6 +++---
 hw/rdma/vmw/pvrdma.h          |  8 ++++----
 hw/rdma/vmw/pvrdma_dev_ring.h |  2 +-
 hw/rdma/rdma_backend.c        |  6 +++---
 hw/rdma/rdma_rm.c             |  6 +++---
 hw/rdma/vmw/pvrdma_cmd.c      |  8 ++++----
 hw/rdma/vmw/pvrdma_dev_ring.c |  8 ++++----
 hw/rdma/vmw/pvrdma_main.c     | 24 ++++++++++++------------
 hw/rdma/vmw/pvrdma_qp_ops.c   |  4 ++--
 12 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index 68f2b05..abae262 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -16,7 +16,7 @@
 #ifndef RDMA_BACKEND_H
 #define RDMA_BACKEND_H
 
-#include <qapi/error.h>
+#include "qapi/error.h"
 #include "rdma_rm_defs.h"
 #include "rdma_backend_defs.h"
 
diff --git a/hw/rdma/rdma_backend_defs.h b/hw/rdma/rdma_backend_defs.h
index 837e324..ff5cfc2 100644
--- a/hw/rdma/rdma_backend_defs.h
+++ b/hw/rdma/rdma_backend_defs.h
@@ -17,7 +17,7 @@
 #define RDMA_BACKEND_DEFS_H
 
 #include <infiniband/verbs.h>
-#include <qemu/thread.h>
+#include "qemu/thread.h"
 
 typedef struct RdmaDeviceResources RdmaDeviceResources;
 
diff --git a/hw/rdma/rdma_rm.h b/hw/rdma/rdma_rm.h
index be95c1b..82c1ddd 100644
--- a/hw/rdma/rdma_rm.h
+++ b/hw/rdma/rdma_rm.h
@@ -16,7 +16,7 @@
 #ifndef RDMA_RM_H
 #define RDMA_RM_H
 
-#include <qapi/error.h>
+#include "qapi/error.h"
 #include "rdma_backend_defs.h"
 #include "rdma_rm_defs.h"
 
diff --git a/hw/rdma/rdma_utils.h b/hw/rdma/rdma_utils.h
index cdac910..3dc0789 100644
--- a/hw/rdma/rdma_utils.h
+++ b/hw/rdma/rdma_utils.h
@@ -17,9 +17,9 @@
 #ifndef RDMA_UTILS_H
 #define RDMA_UTILS_H
 
-#include <qemu/osdep.h>
-#include <include/hw/pci/pci.h>
-#include <include/sysemu/dma.h>
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "sysemu/dma.h"
 
 #define pr_info(fmt, ...) \
     fprintf(stdout, "%s: %-20s (%3d): " fmt, "pvrdma",  __func__, __LINE__,\
diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
index b05f94a..8c173cb 100644
--- a/hw/rdma/vmw/pvrdma.h
+++ b/hw/rdma/vmw/pvrdma.h
@@ -16,14 +16,14 @@
 #ifndef PVRDMA_PVRDMA_H
 #define PVRDMA_PVRDMA_H
 
-#include <hw/pci/pci.h>
-#include <hw/pci/msix.h>
+#include "hw/pci/pci.h"
+#include "hw/pci/msix.h"
 
 #include "../rdma_backend_defs.h"
 #include "../rdma_rm_defs.h"
 
-#include <standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h>
-#include <standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h>
+#include "standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h"
+#include "standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h"
 #include "pvrdma_dev_ring.h"
 
 /* BARs */
diff --git a/hw/rdma/vmw/pvrdma_dev_ring.h b/hw/rdma/vmw/pvrdma_dev_ring.h
index 02a590b..2d0461f 100644
--- a/hw/rdma/vmw/pvrdma_dev_ring.h
+++ b/hw/rdma/vmw/pvrdma_dev_ring.h
@@ -16,7 +16,7 @@
 #ifndef PVRDMA_DEV_RING_H
 #define PVRDMA_DEV_RING_H
 
-#include <qemu/typedefs.h>
+#include "qemu/typedefs.h"
 
 #define MAX_RING_NAME_SZ 32
 
diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index e306fba..f85c7b2 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -13,9 +13,9 @@
  *
  */
 
-#include <qemu/osdep.h>
-#include <qemu/error-report.h>
-#include <qapi/error.h>
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
 
 #include <infiniband/verbs.h>
 
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index b5fc45d..80ffc94 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -13,9 +13,9 @@
  *
  */
 
-#include <qemu/osdep.h>
-#include <qapi/error.h>
-#include <cpu.h>
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "cpu.h"
 
 #include "rdma_utils.h"
 #include "rdma_backend.h"
diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index 293dfed..a9fa1ef 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -13,9 +13,9 @@
  *
  */
 
-#include <qemu/osdep.h>
-#include <qemu/error-report.h>
-#include <cpu.h>
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "cpu.h"
 #include <linux/types.h>
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
@@ -26,7 +26,7 @@
 #include "../rdma_utils.h"
 
 #include "pvrdma.h"
-#include <standard-headers/rdma/vmw_pvrdma-abi.h>
+#include "standard-headers/rdma/vmw_pvrdma-abi.h"
 
 static void *pvrdma_map_to_pdir(PCIDevice *pdev, uint64_t pdir_dma,
                                 uint32_t nchunks, size_t length)
diff --git a/hw/rdma/vmw/pvrdma_dev_ring.c b/hw/rdma/vmw/pvrdma_dev_ring.c
index ec309da..ff19a9e 100644
--- a/hw/rdma/vmw/pvrdma_dev_ring.c
+++ b/hw/rdma/vmw/pvrdma_dev_ring.c
@@ -13,12 +13,12 @@
  *
  */
 
-#include <qemu/osdep.h>
-#include <hw/pci/pci.h>
-#include <cpu.h>
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "cpu.h"
 
 #include "../rdma_utils.h"
-#include <standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h>
+#include "standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h"
 #include "pvrdma_dev_ring.h"
 
 int pvrdma_ring_init(PvrdmaRing *ring, const char *name, PCIDevice *dev,
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 9978781..25ea02a 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -13,16 +13,16 @@
  *
  */
 
-#include <qemu/osdep.h>
-#include <qapi/error.h>
-#include <hw/hw.h>
-#include <hw/pci/pci.h>
-#include <hw/pci/pci_ids.h>
-#include <hw/pci/msi.h>
-#include <hw/pci/msix.h>
-#include <hw/qdev-core.h>
-#include <hw/qdev-properties.h>
-#include <cpu.h>
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/hw.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_ids.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
+#include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
+#include "cpu.h"
 #include "trace.h"
 
 #include "../rdma_rm.h"
@@ -31,8 +31,8 @@
 
 #include <infiniband/verbs.h>
 #include "pvrdma.h"
-#include <standard-headers/rdma/vmw_pvrdma-abi.h>
-#include <standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h>
+#include "standard-headers/rdma/vmw_pvrdma-abi.h"
+#include "standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h"
 #include "pvrdma_qp_ops.h"
 
 static Property pvrdma_dev_properties[] = {
diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
index f0a1f9e..a693c06 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.c
+++ b/hw/rdma/vmw/pvrdma_qp_ops.c
@@ -13,14 +13,14 @@
  *
  */
 
-#include <qemu/osdep.h>
+#include "qemu/osdep.h"
 
 #include "../rdma_utils.h"
 #include "../rdma_rm.h"
 #include "../rdma_backend.h"
 
 #include "pvrdma.h"
-#include <standard-headers/rdma/vmw_pvrdma-abi.h>
+#include "standard-headers/rdma/vmw_pvrdma-abi.h"
 #include "pvrdma_qp_ops.h"
 
 typedef struct CompHandlerCtx {
-- 
MST
