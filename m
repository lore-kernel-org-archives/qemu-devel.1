Received: from eggs.gnu.org ([2001:4830:134:3::10]:52620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangweiping@didichuxing.com>) id 1fg0cx-0005eQ-5y
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 00:33:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangweiping@didichuxing.com>) id 1fg0cs-0005Zr-J5
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 00:33:19 -0400
Received: from mx1.didichuxing.com ([111.202.154.82]:21590
	helo=bsf01.didichuxing.com) by eggs.gnu.org with smtp (Exim 4.71)
	(envelope-from <zhangweiping@didichuxing.com>) id 1fg0cs-0005Yp-2F
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 00:33:14 -0400
Date: Thu, 19 Jul 2018 12:33:00 +0800
From: Weiping Zhang <zhangweiping@didichuxing.com>
Message-ID: <20180719043239.GA22006@bogon.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] hw/block/nvme: add optional parameter
 num_namespaces for nvme device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keith.busch@intel.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

Add an optional paramter num_namespaces for device, and set it
to 1 by default.

Signed-off-by: Weiping Zhang <zhangweiping@didichuxing.com>
---
 hw/block/nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 156ecf3c41..b53be4b5c0 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -19,7 +19,7 @@
  *      -drive file=<file>,if=none,id=<drive_id>
  *      -device nvme,drive=<drive_id>,serial=<serial>,id=<id[optional]>, \
  *              cmb_size_mb=<cmb_size_mb[optional]>, \
- *              num_queues=<N[optional]>
+ *              num_queues=<N[optional]>,num_namespaces=<N[optional]>
  *
  * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
  * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
@@ -1232,7 +1232,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
     pcie_endpoint_cap_init(&n->parent_obj, 0x80);
 
-    n->num_namespaces = 1;
     n->reg_size = pow2ceil(0x1004 + 2 * (n->num_queues + 1) * 4);
     n->ns_size = bs_size / (uint64_t)n->num_namespaces;
 
@@ -1342,6 +1341,7 @@ static Property nvme_props[] = {
     DEFINE_PROP_STRING("serial", NvmeCtrl, serial),
     DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, cmb_size_mb, 0),
     DEFINE_PROP_UINT32("num_queues", NvmeCtrl, num_queues, 64),
+    DEFINE_PROP_UINT32("num_namespaces", NvmeCtrl, num_namespaces, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.14.1
