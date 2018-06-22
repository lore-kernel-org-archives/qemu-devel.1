Received: from eggs.gnu.org ([2001:4830:134:3::10]:49920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd1-0003SR-PN
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd0-0005HB-LA
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:27 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fWLd0-00051P-BW
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:26 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcz-0003vm-84
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:57:25 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:57:01 +0100
Message-Id: <20180622125713.15303-17-peter.maydell@linaro.org>
In-Reply-To: <20180622125713.15303-1-peter.maydell@linaro.org>
References: <20180622125713.15303-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/28] xlnx-zynqmp: Swap Cortex-R5 for Cortex-R5F
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

The ZynqMP has Cortex-R5Fs with the optional FPU enabled.

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20180529124707.3025-3-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-zcu102.c | 2 +-
 hw/arm/xlnx-zynqmp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index f26fd8eb919..b6bc6a93b89 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -208,7 +208,7 @@ static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    mc->desc = "Xilinx ZynqMP ZCU102 board with 4xA53s and 2xR5s based on " \
+    mc->desc = "Xilinx ZynqMP ZCU102 board with 4xA53s and 2xR5Fs based on " \
                "the value of smp";
     mc->init = xlnx_zcu102_init;
     mc->block_default_type = IF_IDE;
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 2045b9d71e5..29df35fb75b 100644
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
2.17.1
