Received: from eggs.gnu.org ([2001:4830:134:3::10]:43655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F90-0008Oj-Hf
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F8z-00085n-EX
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:22 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:36886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1d1F8z-00084S-78
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:21 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F8w-0006xW-Jy
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:41:18 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 17:41:01 +0100
Message-Id: <1492706470-10921-16-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
References: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 15/24] xlnx-zynqmp: Set the Cadence GEM revision
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

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 026dbe01a1d42619eee30ce3f2079741bf04bc73.1491947224.git.alistair.francis@xilinx.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-zynqmp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index bc4e66b..e41b6fe 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -30,6 +30,8 @@
 #define ARM_PHYS_TIMER_PPI  30
 #define ARM_VIRT_TIMER_PPI  27
 
+#define GEM_REVISION        0x40070106
+
 #define GIC_BASE_ADDR       0xf9000000
 #define GIC_DIST_ADDR       0xf9010000
 #define GIC_CPU_ADDR        0xf9020000
@@ -334,8 +336,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
             qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
             qdev_set_nic_properties(DEVICE(&s->gem[i]), nd);
         }
+        object_property_set_int(OBJECT(&s->gem[i]), GEM_REVISION, "revision",
+                                &error_abort);
         object_property_set_int(OBJECT(&s->gem[i]), 2, "num-priority-queues",
-                                  &error_abort);
+                                &error_abort);
         object_property_set_bool(OBJECT(&s->gem[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
-- 
2.7.4
