Received: from eggs.gnu.org ([2001:4830:134:3::10]:60252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGg-0004cj-F5
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGf-00047d-Mw
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:58 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:43022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g1DGf-000468-7B
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:57 -0400
Received: by mail-pg1-x52f.google.com with SMTP id v66-v6so5743051pgb.10
	for <qemu-devel@nongnu.org>; Sat, 15 Sep 2018 09:17:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 15 Sep 2018 09:17:36 -0700
Message-Id: <20180915161738.25257-12-richard.henderson@linaro.org>
In-Reply-To: <20180915161738.25257-1-richard.henderson@linaro.org>
References: <20180915161738.25257-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 11/13] target/arm: Derive id_aa64isar1 from
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1c51b9f631..a9724f3bb1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1062,6 +1062,24 @@ static uint64_t resolve_id_aa64isar0(CPUARMState *env)
     return ret;
 }
 
+static uint64_t resolve_id_aa64isar1(CPUARMState *env)
+{
+    uint64_t ret = 0;
+
+    /* DPB -- not implemented yet */
+    /* APA -- not implemented yet */
+    /* API -- not implemented yet */
+    /* JSCVT -- not implemented yet */
+    if (arm_feature(env, ARM_FEATURE_V8_FCMA)) {
+        ret = deposit64(ret, 16, 4, 1);
+    }
+    /* LRCPC -- not implemented yet */
+    /* GPA -- not implemented yet */
+    /* GPI -- not implemented yet */
+
+    return ret;
+}
+
 static void resolve_id_regs(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
@@ -1102,6 +1120,8 @@ static void resolve_id_regs(ARMCPU *cpu)
     orig = cpu->id_aa64isar0;
     cpu->id_aa64isar0 = resolve_id_aa64isar0(env);
     g_assert_cmphex(cpu->id_aa64isar0, ==, orig);
+
+    cpu->id_aa64isar1 = resolve_id_aa64isar1(env);
 }
 
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.17.1
