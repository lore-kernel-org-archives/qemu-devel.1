Received: from eggs.gnu.org ([208.118.235.92]:57278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gHMQa-0005hC-I6
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 01:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gHMQZ-0005R4-VH
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 01:18:56 -0400
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 29 Oct 2018 22:18:37 -0700
Message-Id: <1540876720-9574-2-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1540876720-9574-1-git-send-email-liq3ea@gmail.com>
References: <1540876720-9574-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 1/4] nvme: use TYPE_NVME instead of constant
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
---
 hw/block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index fc7dacb..676cc48 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1379,7 +1379,7 @@ static void nvme_instance_init(Object *obj)
 }
 
 static const TypeInfo nvme_info = {
-    .name          = "nvme",
+    .name          = TYPE_NVME,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(NvmeCtrl),
     .class_init    = nvme_class_init,
-- 
1.8.3.1
