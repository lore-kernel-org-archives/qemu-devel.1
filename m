Received: from eggs.gnu.org ([2001:4830:134:3::10]:38422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fECqZ-0005BU-S7
	for qemu-devel@nongnu.org; Thu, 03 May 2018 07:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fECqY-0006yv-Q0
	for qemu-devel@nongnu.org; Thu, 03 May 2018 07:56:27 -0400
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu,  3 May 2018 13:56:20 +0200
Message-Id: <20180503115620.10596-3-edgar.iglesias@gmail.com>
In-Reply-To: <20180503115620.10596-1-edgar.iglesias@gmail.com>
References: <20180503115620.10596-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 2/2] xlnx-zynqmp: Swap Cortex-R5 for
 Cortex-R5F
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, frederic.konrad@adacore.com, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

The ZynqMP has Cortex-R5Fs with the optional FPU enabled.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 505253e0d2..efeb53c732 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -116,7 +116,7 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
         char *name;
 
         object_initialize(&s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
-                          "cortex-r5-" TYPE_ARM_CPU);
+                          "cortex-r5f-" TYPE_ARM_CPU);
         object_property_add_child(OBJECT(s), "rpu-cpu[*]",
                                   OBJECT(&s->rpu_cpu[i]), &error_abort);
 
-- 
2.14.1
