Received: from eggs.gnu.org ([2001:4830:134:3::10]:59418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cxj0x-0001dE-TQ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 19:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cxj0u-0002Tq-I1
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 19:46:31 -0400
Received: from mail-bn3nam01on0067.outbound.protection.outlook.com
	([104.47.33.67]:53600
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1cxj0u-0002TK-BP
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 19:46:28 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 10 Apr 2017 16:43:54 -0700
Message-ID: <0ff9f1a1baedd57b469f2a30a58c28b806050d86.1491865973.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1491865973.git.alistair.francis@xilinx.com>
References: <cover.1491865973.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 5/5] xlnx-zynqmp: Set the Cadence GEM
 revision
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, f4bug@amsat.org

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
2.9.3
