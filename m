Received: from eggs.gnu.org ([2001:4830:134:3::10]:41583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNe1z-0005GT-1D
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNe1y-0007Q9-6D
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:47:15 -0400
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 14:47:07 +0200
Message-Id: <20180529124707.3025-3-edgar.iglesias@gmail.com>
In-Reply-To: <20180529124707.3025-1-edgar.iglesias@gmail.com>
References: <20180529124707.3025-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/2] xlnx-zynqmp: Swap Cortex-R5 for
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
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, frederic.konrad@adacore.com, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, luc.michel@greensocs.com, sstabellini@kernel.org, f4bug@amsat.org, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

The ZynqMP has Cortex-R5Fs with the optional FPU enabled.

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-zcu102.c | 2 +-
 hw/arm/xlnx-zynqmp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index b126cf148b..51906a743f 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -266,7 +266,7 @@ static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    mc->desc = "Xilinx ZynqMP ZCU102 board with 4xA53s and 2xR5s based on " \
+    mc->desc = "Xilinx ZynqMP ZCU102 board with 4xA53s and 2xR5Fs based on " \
                "the value of smp";
     mc->init = xlnx_zcu102_init;
     mc->block_default_type = IF_IDE;
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 2045b9d71e..29df35fb75 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -134,7 +134,7 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
         char *name;
 
         object_initialize(&s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
-                          "cortex-r5-" TYPE_ARM_CPU);
+                          "cortex-r5f-" TYPE_ARM_CPU);
         object_property_add_child(OBJECT(s), "rpu-cpu[*]",
                                   OBJECT(&s->rpu_cpu[i]), &error_abort);
 
-- 
2.14.1
