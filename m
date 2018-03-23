Received: from eggs.gnu.org ([2001:4830:134:3::10]:36018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ezP0K-0008En-4N
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ezP0I-0007f8-Nv
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54830 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ezP0I-0007ez-Hw
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:18 -0400
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Fri, 23 Mar 2018 18:53:01 +0300
Message-Id: <20180323155306.83812-4-marcel@redhat.com>
In-Reply-To: <20180323155306.83812-1-marcel@redhat.com>
References: <20180323155306.83812-1-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel]  [PATCH PULL 3/8] rdma: fix up include directives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, yuval.shaia@oracle.com, mst@redhat.com, marcel@redhat.com, f4bug@amsat.org, eblake@redhat.com, berrange@redhat.com, stefanha@redhat.com

From: "Michael S. Tsirkin" <mst@redhat.com>

Our rule right now is to use <> for external headers only.
RDMA code violates that, fix it up.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/rdma/rdma_backend.c        |  6 +++---
 hw/rdma/rdma_backend.h        |  2 +-
 hw/rdma/rdma_backend_defs.h   |  2 +-
 hw/rdma/rdma_rm.c             |  6 +++---
 hw/rdma/rdma_rm.h             |  2 +-
 hw/rdma/rdma_utils.h          |  6 +++---
 hw/rdma/vmw/pvrdma.h          |  8 ++++----
 hw/rdma/vmw/pvrdma_cmd.c      |  8 ++++----
 hw/rdma/vmw/pvrdma_dev_ring.c |  8 ++++----
 hw/rdma/vmw/pvrdma_dev_ring.h |  2 +-
 hw/rdma/vmw/pvrdma_main.c     | 24 ++++++++++++------------
 hw/rdma/vmw/pvrdma_qp_ops.c   |  4 ++--
 12 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 0beed77c27..57f40d99a3 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -13,9 +13,9 @@
  *
  */
=20
-#include <qemu/osdep.h>
-#include <qemu/error-report.h>
-#include <qapi/error.h>
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
=20
 #include <infiniband/verbs.h>
=20
diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index 36218d1990..505cad7e0e 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -16,7 +16,7 @@
 #ifndef RDMA_BACKEND_H
 #define RDMA_BACKEND_H
=20
-#include <qapi/error.h>
+#include "qapi/error.h"
 #include "rdma_rm_defs.h"
 #include "rdma_backend_defs.h"
=20
diff --git a/hw/rdma/rdma_backend_defs.h b/hw/rdma/rdma_backend_defs.h
index 837e32419c..ff5cfc26eb 100644
--- a/hw/rdma/rdma_backend_defs.h
+++ b/hw/rdma/rdma_backend_defs.h
@@ -17,7 +17,7 @@
 #define RDMA_BACKEND_DEFS_H
=20
 #include <infiniband/verbs.h>
-#include <qemu/thread.h>
+#include "qemu/thread.h"
=20
 typedef struct RdmaDeviceResources RdmaDeviceResources;
=20
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index 43f73adecf..6d88ac5d23 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -13,9 +13,9 @@
  *
  */
=20
-#include <qemu/osdep.h>
-#include <qapi/error.h>
-#include <cpu.h>
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "cpu.h"
=20
 #include "rdma_utils.h"
 #include "rdma_backend.h"
diff --git a/hw/rdma/rdma_rm.h b/hw/rdma/rdma_rm.h
index 0528c1972b..b4e04cc7b4 100644
--- a/hw/rdma/rdma_rm.h
+++ b/hw/rdma/rdma_rm.h
@@ -16,7 +16,7 @@
 #ifndef RDMA_RM_H
 #define RDMA_RM_H
=20
-#include <qapi/error.h>
+#include "qapi/error.h"
 #include "rdma_backend_defs.h"
 #include "rdma_rm_defs.h"
=20
diff --git a/hw/rdma/rdma_utils.h b/hw/rdma/rdma_utils.h
index cdac910e24..3dc07891bc 100644
--- a/hw/rdma/rdma_utils.h
+++ b/hw/rdma/rdma_utils.h
@@ -17,9 +17,9 @@
 #ifndef RDMA_UTILS_H
 #define RDMA_UTILS_H
=20
-#include <qemu/osdep.h>
-#include <include/hw/pci/pci.h>
-#include <include/sysemu/dma.h>
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "sysemu/dma.h"
=20
 #define pr_info(fmt, ...) \
     fprintf(stdout, "%s: %-20s (%3d): " fmt, "pvrdma",  __func__, __LINE=
__,\
diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
index b05f94a473..8c173cb824 100644
--- a/hw/rdma/vmw/pvrdma.h
+++ b/hw/rdma/vmw/pvrdma.h
@@ -16,14 +16,14 @@
 #ifndef PVRDMA_PVRDMA_H
 #define PVRDMA_PVRDMA_H
=20
-#include <hw/pci/pci.h>
-#include <hw/pci/msix.h>
+#include "hw/pci/pci.h"
+#include "hw/pci/msix.h"
=20
 #include "../rdma_backend_defs.h"
 #include "../rdma_rm_defs.h"
=20
-#include <standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.=
h>
-#include <standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_a=
pi.h>
+#include "standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.=
h"
+#include "standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_a=
pi.h"
 #include "pvrdma_dev_ring.h"
=20
 /* BARs */
diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index cf8c50af31..0646f87ff2 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -13,9 +13,9 @@
  *
  */
=20
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
=20
 #include "pvrdma.h"
-#include <standard-headers/rdma/vmw_pvrdma-abi.h>
+#include "standard-headers/rdma/vmw_pvrdma-abi.h"
=20
 static void *pvrdma_map_to_pdir(PCIDevice *pdev, uint64_t pdir_dma,
                                 uint32_t nchunks, size_t length)
diff --git a/hw/rdma/vmw/pvrdma_dev_ring.c b/hw/rdma/vmw/pvrdma_dev_ring.=
c
index ec309dad55..ff19a9ea16 100644
--- a/hw/rdma/vmw/pvrdma_dev_ring.c
+++ b/hw/rdma/vmw/pvrdma_dev_ring.c
@@ -13,12 +13,12 @@
  *
  */
=20
-#include <qemu/osdep.h>
-#include <hw/pci/pci.h>
-#include <cpu.h>
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "cpu.h"
=20
 #include "../rdma_utils.h"
-#include <standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.=
h>
+#include "standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.=
h"
 #include "pvrdma_dev_ring.h"
=20
 int pvrdma_ring_init(PvrdmaRing *ring, const char *name, PCIDevice *dev,
diff --git a/hw/rdma/vmw/pvrdma_dev_ring.h b/hw/rdma/vmw/pvrdma_dev_ring.=
h
index 02a590b86d..2d0461f367 100644
--- a/hw/rdma/vmw/pvrdma_dev_ring.h
+++ b/hw/rdma/vmw/pvrdma_dev_ring.h
@@ -16,7 +16,7 @@
 #ifndef PVRDMA_DEV_RING_H
 #define PVRDMA_DEV_RING_H
=20
-#include <qemu/typedefs.h>
+#include "qemu/typedefs.h"
=20
 #define MAX_RING_NAME_SZ 32
=20
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 99787812ba..25ea02af62 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -13,16 +13,16 @@
  *
  */
=20
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
=20
 #include "../rdma_rm.h"
@@ -31,8 +31,8 @@
=20
 #include <infiniband/verbs.h>
 #include "pvrdma.h"
-#include <standard-headers/rdma/vmw_pvrdma-abi.h>
-#include <standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_a=
pi.h>
+#include "standard-headers/rdma/vmw_pvrdma-abi.h"
+#include "standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_a=
pi.h"
 #include "pvrdma_qp_ops.h"
=20
 static Property pvrdma_dev_properties[] =3D {
diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
index f0a1f9eb02..a693c06a11 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.c
+++ b/hw/rdma/vmw/pvrdma_qp_ops.c
@@ -13,14 +13,14 @@
  *
  */
=20
-#include <qemu/osdep.h>
+#include "qemu/osdep.h"
=20
 #include "../rdma_utils.h"
 #include "../rdma_rm.h"
 #include "../rdma_backend.h"
=20
 #include "pvrdma.h"
-#include <standard-headers/rdma/vmw_pvrdma-abi.h>
+#include "standard-headers/rdma/vmw_pvrdma-abi.h"
 #include "pvrdma_qp_ops.h"
=20
 typedef struct CompHandlerCtx {
--=20
2.13.5
