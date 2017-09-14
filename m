Received: from eggs.gnu.org ([2001:4830:134:3::10]:46431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJY-00084n-DN
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJX-0007wf-Hh
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:36 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dsYJX-0007iP-AR
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:35 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJU-0005s4-LL
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 18:52:32 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 18:52:47 +0100
Message-Id: <1505411573-27848-13-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
References: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 12/18] xlnx-zcu102: Mark the EP108 machine as
 deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alistair Francis <alistair.francis@xilinx.com>

The EP108 is the same as the ZCU102, mark it as deprecated as we don't
need two machines.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-zcu102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 42deefd..519a16e 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -180,7 +180,7 @@ static void xlnx_ep108_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    mc->desc = "Xilinx ZynqMP EP108 board";
+    mc->desc = "Xilinx ZynqMP EP108 board (Deprecated, please use xlnx-zcu102)";
     mc->init = xlnx_ep108_init;
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
-- 
2.7.4
