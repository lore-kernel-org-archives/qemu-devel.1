Received: from eggs.gnu.org ([2001:4830:134:3::10]:50130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu2Ct-0006sr-K7
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu2Cs-0004KO-Sf
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:27:35 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 31 Mar 2017 16:27:24 -0300
Message-Id: <20170331192724.14339-3-ehabkost@redhat.com>
In-Reply-To: <20170331192724.14339-1-ehabkost@redhat.com>
References: <20170331192724.14339-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 2/2] etsec: Use TYPE_ETSEC macro when
 registering/creating device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Scott Wood <scottwood@freescale.com>, qemu-ppc@nongnu.org, Fabien Chouteau <chouteau@adacore.com>, Jason Wang <jasowang@redhat.com>

Instead of hardcoding the class name, use the TYPE_ETSEC macro
when registering the class and creating devices.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/net/fsl_etsec/etsec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index ddefaf560c..5d2c45de6f 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -419,7 +419,7 @@ static void etsec_class_init(ObjectClass *klass, void *data)
 }
 
 static TypeInfo etsec_info = {
-    .name                  = "eTSEC",
+    .name                  = TYPE_ETSEC,
     .parent                = TYPE_SYS_BUS_DEVICE,
     .instance_size         = sizeof(eTSEC),
     .class_init            = etsec_class_init,
@@ -442,7 +442,7 @@ DeviceState *etsec_create(hwaddr         base,
 {
     DeviceState *dev;
 
-    dev = qdev_create(NULL, "eTSEC");
+    dev = qdev_create(NULL, TYPE_ETSEC);
     qdev_set_nic_properties(dev, nd);
     qdev_init_nofail(dev);
 
-- 
2.11.0.259.g40922b1
