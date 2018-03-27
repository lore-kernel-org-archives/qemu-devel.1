Received: from eggs.gnu.org ([2001:4830:134:3::10]:40844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <saipava@xhdsaipava40.localdomain>)
	id 1f0lJq-0002Vt-OR
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 05:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <saipava@xhdsaipava40.localdomain>)
	id 1f0lJm-0002hI-PS
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 05:55:06 -0400
Received: from mail-by2nam03on0087.outbound.protection.outlook.com
	([104.47.42.87]:25348
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <saipava@xhdsaipava40.localdomain>)
	id 1f0lJm-0002gb-Fp
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 05:55:02 -0400
From: <saipavanboddu@gmail.com>
Date: Tue, 27 Mar 2018 12:51:12 +0530
Message-ID: <1522135274-15396-1-git-send-email-saipavanboddu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [qemu-devel][PATCH v1 1/2] ssi.c: Check if slave
 already attached to a parent bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: qemu-devel@nongnu.org

From: Sai Pavan Boddu <saipava@xilinx.com>

Skip auto-connect if already connected to a bus

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/ssi/ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index 7eaaf56..6953c92 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -152,7 +152,7 @@ static int ssi_auto_connect_slave(Object *child, void *opaque)
     SSISlave *dev = (SSISlave *)object_dynamic_cast(child, TYPE_SSI_SLAVE);
     qemu_irq cs_line;
 
-    if (!dev) {
+    if (!dev || qdev_get_parent_bus(DEVICE(dev))) {
         return 0;
     }
 
-- 
2.7.4
