Received: from eggs.gnu.org ([2001:4830:134:3::10]:41552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNe1x-0005GK-U2
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNe1w-0007P7-D1
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:47:13 -0400
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 14:47:06 +0200
Message-Id: <20180529124707.3025-2-edgar.iglesias@gmail.com>
In-Reply-To: <20180529124707.3025-1-edgar.iglesias@gmail.com>
References: <20180529124707.3025-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/2] target-arm: Add the Cortex-R5F
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

Add the Cortex-R5F with the optional FPU enabled.

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/arm/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5d60893a07..8ab571e84a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1343,6 +1343,14 @@ static void cortex_r5_initfn(Object *obj)
     define_arm_cp_regs(cpu, cortexr5_cp_reginfo);
 }
 
+static void cortex_r5f_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    cortex_r5_initfn(obj);
+    set_feature(&cpu->env, ARM_FEATURE_VFP3);
+}
+
 static const ARMCPRegInfo cortexa8_cp_reginfo[] = {
     { .name = "L2LOCKDOWN", .cp = 15, .crn = 9, .crm = 0, .opc1 = 1, .opc2 = 0,
       .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
@@ -1803,6 +1811,7 @@ static const ARMCPUInfo arm_cpus[] = {
     { .name = "cortex-m33",  .initfn = cortex_m33_initfn,
                              .class_init = arm_v7m_class_init },
     { .name = "cortex-r5",   .initfn = cortex_r5_initfn },
+    { .name = "cortex-r5f",  .initfn = cortex_r5f_initfn },
     { .name = "cortex-a7",   .initfn = cortex_a7_initfn },
     { .name = "cortex-a8",   .initfn = cortex_a8_initfn },
     { .name = "cortex-a9",   .initfn = cortex_a9_initfn },
-- 
2.14.1
