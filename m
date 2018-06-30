Received: from eggs.gnu.org ([2001:4830:134:3::10]:33610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fZC3a-0008Fo-EK
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 05:20:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fZC3X-0001rm-VL
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 05:20:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sat, 30 Jun 2018 10:13:43 +0100
Message-Id: <20180630091343.14391-4-stefanha@redhat.com>
In-Reply-To: <20180630091343.14391-1-stefanha@redhat.com>
References: <20180630091343.14391-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] target/arm: add "cortex-m0" CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, joel@jms.id.au, qemu-arm@nongnu.org, jim@groklearning.com, mail@steffen-goertz.de, jusual@mail.ru, Subbaraya Sundeep <sundeep.lkml@gmail.com>, ilg@livius.net, Stefan Hajnoczi <stefanha@redhat.com>

Define a "cortex-m0" ARMv6-M CPU model.

Most of the register reset values set by other CPU models are not
relevant for the cut-down ARMv6-M architecture.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 target/arm/cpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2ae4fffafb..10951fa0eb 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1233,6 +1233,15 @@ static void arm11mpcore_initfn(Object *obj)
     cpu->reset_auxcr = 1;
 }
 
+static void cortex_m0_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    set_feature(&cpu->env, ARM_FEATURE_V6);
+    set_feature(&cpu->env, ARM_FEATURE_M);
+
+    cpu->midr = 0x410cc200;
+}
+
 static void cortex_m3_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -1825,6 +1834,8 @@ static const ARMCPUInfo arm_cpus[] = {
     { .name = "arm1136",     .initfn = arm1136_initfn },
     { .name = "arm1176",     .initfn = arm1176_initfn },
     { .name = "arm11mpcore", .initfn = arm11mpcore_initfn },
+    { .name = "cortex-m0",   .initfn = cortex_m0_initfn,
+                             .class_init = arm_v7m_class_init },
     { .name = "cortex-m3",   .initfn = cortex_m3_initfn,
                              .class_init = arm_v7m_class_init },
     { .name = "cortex-m4",   .initfn = cortex_m4_initfn,
-- 
2.17.1
