Received: from eggs.gnu.org ([209.51.188.92]:44172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1ghmFs-0008JX-6Z
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 21:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1ghmFr-0004cz-Hs
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 21:09:04 -0500
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 11 Jan 2019 10:08:47 +0800
Message-Id: <20190111020849.22674-2-liq3ea@gmail.com>
In-Reply-To: <20190111020849.22674-1-liq3ea@gmail.com>
References: <20190111020849.22674-1-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH v2 1/3] nvme: use TYPE_NVME instead of constant
 string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 hw/block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 7c8c63e8f5..f206391e8e 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1381,7 +1381,7 @@ static void nvme_instance_init(Object *obj)
 }
 
 static const TypeInfo nvme_info = {
-    .name          = "nvme",
+    .name          = TYPE_NVME,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(NvmeCtrl),
     .class_init    = nvme_class_init,
-- 
2.17.1
