Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D3FC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 21:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ECED2075B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 21:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uq5uNHNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECED2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58142 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYGeF-0002q2-Nz
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 17:07:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8z-0001ed-6n
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8u-0004mz-14
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:51 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG8s-0004kt-49
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:47 -0400
Received: by mail-ot1-x343.google.com with SMTP id n14so20874163otk.2
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=aRRPed9GGahppyN9nV5kay8UuYoPwEZwq6VS5FHWIs8=;
	b=uq5uNHNck/rn3lN07DCyeVrS4S3cd9dVqT2VJwL0kGtQb6HFq57mz6aeyedHtVLV+N
	p9S6bPKiL5FRXG9AeANgDJkKFr0YH+gwPtZveCEmvW8rekquD4hBcSIgxysYkf4KRe6T
	9U+l1nfNgS927oBvZKsn93BtheVjkjZsWRcvUb+YTqNTum6IPV0M3tiUUj8ikwIHodHI
	CDYO62pirFMBWSFjfKbmi8jAzAzrAoJFQVzUZ2/f+EREsAp0AKXRhhECtGm3xm4/W76k
	VF2PbwfG0BQUnAQQJqQaKb2wur2+O/1UL/e3kac2tYmVbBdbf2zrcJHEsOdeUrtssEeb
	w58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=aRRPed9GGahppyN9nV5kay8UuYoPwEZwq6VS5FHWIs8=;
	b=AzMUgZR5OAVibPCDoHrfL+snX326lL3co2s54PjsuuSQo4EIIQPgIEbOiEWNwOqU6z
	tb4JreDgo9J3FDG3QhPUTfXCBnBKorfSYTzkcUpCZvcCLasTqZ8u4C9xQp6K1hQse5T1
	CSm5cCnGWMyKSERtT4Q7xd7C9e9oy78brL93mCVblcz70mqCMIPBcAM3611txQ3zHcmY
	KEE8eyQL4MsGhCtq+Y7nIUAqmCnJCddeUxIdFjkWsdqFFRv1LuT6k7Yf1KalJe0/rl9R
	cnByot9ecjLnmOz7V6dnWvg/+Y/sWuNyZJB+8MlZpxh88gNKfRiOkbQ1U3OQxYOgpQXs
	nL9g==
X-Gm-Message-State: APjAAAWyg9+rvvY52HZA2HGvHYR+yW90YY5ucIqj6HVvILkhVc0gaaaB
	qog39Dz7QHJb4gKFBbcK5ODYJHCu3bCV9Q==
X-Google-Smtp-Source: APXvYqwDQl18IQOIxN+PmKh6NJ2bnS4vnkB8EXUiQXwPxAbV31eZwm2r0TxIfMBcbK3m2x7wzpuQNg==
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr6500527oti.122.1559680484677; 
	Tue, 04 Jun 2019 13:34:44 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.34.43
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:34:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:44 -0500
Message-Id: <20190604203351.27778-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604203351.27778-1-richard.henderson@linaro.org>
References: <20190604203351.27778-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: [Qemu-devel] [PATCH v4 32/39] cpu: Introduce
 cpu_set_cpustate_pointers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Consolidate some boilerplate from foo_cpu_initfn.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h          | 11 +++++++++++
 target/alpha/cpu.c              |  3 +--
 target/arm/cpu.c                |  3 +--
 target/cris/cpu.c               |  3 +--
 target/hppa/cpu.c               |  2 +-
 target/i386/cpu.c               |  3 +--
 target/lm32/cpu.c               |  3 +--
 target/m68k/cpu.c               |  4 +---
 target/microblaze/cpu.c         |  3 +--
 target/mips/cpu.c               |  3 +--
 target/moxie/cpu.c              |  3 +--
 target/nios2/cpu.c              |  6 ++----
 target/openrisc/cpu.c           |  3 +--
 target/ppc/translate_init.inc.c |  3 +--
 target/riscv/cpu.c              |  3 +--
 target/s390x/cpu.c              |  9 +++++----
 target/sh4/cpu.c                |  3 +--
 target/sparc/cpu.c              |  3 +--
 target/tilegx/cpu.c             |  4 +---
 target/tricore/cpu.c            |  4 +---
 target/unicore32/cpu.c          |  3 +--
 target/xtensa/cpu.c             |  3 +--
 22 files changed, 37 insertions(+), 48 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index c62f07b354..71154070a7 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -371,6 +371,17 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
 
 int cpu_exec(CPUState *cpu);
 
+/**
+ * cpu_set_cpustate_pointers(cpu)
+ * @cpu: The cpu object
+ *
+ * Set the generic pointers in CPUState into the outer object.
+ */
+static inline void cpu_set_cpustate_pointers(ArchCPU *cpu)
+{
+    cpu->parent_obj.env_ptr = &cpu->env;
+}
+
 /**
  * env_archcpu(env)
  * @env: The architecture environment
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 7c81be4111..952582567f 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -191,11 +191,10 @@ static void ev67_cpu_initfn(Object *obj)
 
 static void alpha_cpu_initfn(Object *obj)
 {
-    CPUState *cs = CPU(obj);
     AlphaCPU *cpu = ALPHA_CPU(obj);
     CPUAlphaState *env = &cpu->env;
 
-    cs->env_ptr = env;
+    cpu_set_cpustate_pointers(cpu);
 
     env->lock_addr = -1;
 #if defined(CONFIG_USER_ONLY)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9b23ac2c93..f70e07fd11 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -697,10 +697,9 @@ static void cpreg_hashtable_data_destroy(gpointer data)
 
 static void arm_cpu_initfn(Object *obj)
 {
-    CPUState *cs = CPU(obj);
     ARMCPU *cpu = ARM_CPU(obj);
 
-    cs->env_ptr = &cpu->env;
+    cpu_set_cpustate_pointers(cpu);
     cpu->cp_regs = g_hash_table_new_full(g_int_hash, g_int_equal,
                                          g_free, cpreg_hashtable_data_destroy);
 
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 4e5288ae80..1dce6d10c3 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -172,12 +172,11 @@ static void cris_disas_set_info(CPUState *cpu, disassemble_info *info)
 
 static void cris_cpu_initfn(Object *obj)
 {
-    CPUState *cs = CPU(obj);
     CRISCPU *cpu = CRIS_CPU(obj);
     CRISCPUClass *ccc = CRIS_CPU_GET_CLASS(obj);
     CPUCRISState *env = &cpu->env;
 
-    cs->env_ptr = env;
+    cpu_set_cpustate_pointers(cpu);
 
     env->pregs[PR_VR] = ccc->vr;
 
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 9717ea1798..ae494abad1 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -134,7 +134,7 @@ static void hppa_cpu_initfn(Object *obj)
     HPPACPU *cpu = HPPA_CPU(obj);
     CPUHPPAState *env = &cpu->env;
 
-    cs->env_ptr = env;
+    cpu_set_cpustate_pointers(cpu);
     cs->exception_index = -1;
     cpu_hppa_loaded_fr0(env);
     cpu_hppa_put_psw(env, PSW_W);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a461d8d92c..b21ecaac17 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5592,13 +5592,12 @@ static void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
 
 static void x86_cpu_initfn(Object *obj)
 {
-    CPUState *cs = CPU(obj);
     X86CPU *cpu = X86_CPU(obj);
     X86CPUClass *xcc = X86_CPU_GET_CLASS(obj);
     CPUX86State *env = &cpu->env;
     FeatureWord w;
 
-    cs->env_ptr = env;
+    cpu_set_cpustate_pointers(cpu);
 
     object_property_add(obj, "family", "int",
                         x86_cpuid_version_get_family,
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index 57c50c1578..a14191236f 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -142,11 +142,10 @@ static void lm32_cpu_realizefn(DeviceState *dev, Error **errp)
 
 static void lm32_cpu_initfn(Object *obj)
 {
-    CPUState *cs = CPU(obj);
     LM32CPU *cpu = LM32_CPU(obj);
     CPULM32State *env = &cpu->env;
 
-    cs->env_ptr = env;
+    cpu_set_cpustate_pointers(cpu);
 
     env->flags = 0;
 }
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index b16957934a..ea38cb46e9 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -238,11 +238,9 @@ static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
 
 static void m68k_cpu_initfn(Object *obj)
 {
-    CPUState *cs = CPU(obj);
     M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
 
-    cs->env_ptr = env;
+    cpu_set_cpustate_pointers(cpu);
 }
 
 static const VMStateDescription vmstate_m68k_cpu = {
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 0ea549910b..5c537526c0 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -221,11 +221,10 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
 
 static void mb_cpu_initfn(Object *obj)
 {
-    CPUState *cs = CPU(obj);
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(obj);
     CPUMBState *env = &cpu->env;
 
-    cs->env_ptr = env;
+    cpu_set_cpustate_pointers(cpu);
 
     set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index a33058609a..73232b80ad 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -152,12 +152,11 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
 
 static void mips_cpu_initfn(Object *obj)
 {
-    CPUState *cs = CPU(obj);
     MIPSCPU *cpu = MIPS_CPU(obj);
     CPUMIPSState *env = &cpu->env;
     MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(obj);
 
-    cs->env_ptr = env;
+    cpu_set_cpustate_pointers(cpu);
     env->cpu_model = mcc->cpu_def;
 }
 
diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 02b2b47574..4688cee8c1 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -74,10 +74,9 @@ static void moxie_cpu_realizefn(DeviceState *dev, Error **errp)
 
 static void moxie_cpu_initfn(Object *obj)
 {
-    CPUState *cs = CPU(obj);
     MoxieCPU *cpu = MOXIE_CPU(obj);
 
-    cs->env_ptr = &cpu->env;
+    cpu_set_cpustate_pointers(cpu);
 }
 
 static ObjectClass *moxie_cpu_class_by_name(const char *cpu_model)
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 186af4913d..b00223e0c7 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -66,14 +66,12 @@ static void nios2_cpu_reset(CPUState *cs)
 
 static void nios2_cpu_initfn(Object *obj)
 {
-    CPUState *cs = CPU(obj);
     Nios2CPU *cpu = NIOS2_CPU(obj);
-    CPUNios2State *env = &cpu->env;
 
-    cs->env_ptr = env;
+    cpu_set_cpustate_pointers(cpu);
 
 #if !defined(CONFIG_USER_ONLY)
-    mmu_init(env);
+    mmu_init(&cpu->env);
 #endif
 }
 
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 3816baee70..d5b0134371 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -92,10 +92,9 @@ static void openrisc_cpu_realizefn(DeviceState *dev, Error **errp)
 
 static void openrisc_cpu_initfn(Object *obj)
 {
-    CPUState *cs = CPU(obj);
     OpenRISCCPU *cpu = OPENRISC_CPU(obj);
 
-    cs->env_ptr = &cpu->env;
+    cpu_set_cpustate_pointers(cpu);
 }
 
 /* CPU models */
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index d161e95fb2..b71b7bac20 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10473,12 +10473,11 @@ static bool ppc_cpu_is_big_endian(CPUState *cs)
 
 static void ppc_cpu_instance_init(Object *obj)
 {
-    CPUState *cs = CPU(obj);
     PowerPCCPU *cpu = POWERPC_CPU(obj);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     CPUPPCState *env = &cpu->env;
 
-    cs->env_ptr = env;
+    cpu_set_cpustate_pointers(cpu);
     cpu->vcpu_id = UNASSIGNED_CPU_INDEX;
 
     env->msr_mask = pcc->msr_mask;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e29879915f..86fd8693a8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -367,10 +367,9 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 
 static void riscv_cpu_init(Object *obj)
 {
-    CPUState *cs = CPU(obj);
     RISCVCPU *cpu = RISCV_CPU(obj);
 
-    cs->env_ptr = &cpu->env;
+    cpu_set_cpustate_pointers(cpu);
 }
 
 static const VMStateDescription vmstate_riscv_cpu = {
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index b1df63d82c..9ee166d873 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -282,17 +282,18 @@ static void s390_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
     S390CPU *cpu = S390_CPU(obj);
-    CPUS390XState *env = &cpu->env;
 
-    cs->env_ptr = env;
+    cpu_set_cpustate_pointers(cpu);
     cs->halted = 1;
     cs->exception_index = EXCP_HLT;
     object_property_add(obj, "crash-information", "GuestPanicInformation",
                         s390_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL);
     s390_cpu_model_register_props(obj);
 #if !defined(CONFIG_USER_ONLY)
-    env->tod_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
-    env->cpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
+    cpu->env.tod_timer =
+        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
+    cpu->env.cpu_timer =
+        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
     s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
 #endif
 }
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index c4736a0a73..dfca03f266 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -194,11 +194,10 @@ static void superh_cpu_realizefn(DeviceState *dev, Error **errp)
 
 static void superh_cpu_initfn(Object *obj)
 {
-    CPUState *cs = CPU(obj);
     SuperHCPU *cpu = SUPERH_CPU(obj);
     CPUSH4State *env = &cpu->env;
 
-    cs->env_ptr = env;
+    cpu_set_cpustate_pointers(cpu);
 
     env->movcal_backup_tail = &(env->movcal_backup);
 }
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index f93ce72eb9..ad2c362c6a 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -774,12 +774,11 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
 
 static void sparc_cpu_initfn(Object *obj)
 {
-    CPUState *cs = CPU(obj);
     SPARCCPU *cpu = SPARC_CPU(obj);
     SPARCCPUClass *scc = SPARC_CPU_GET_CLASS(obj);
     CPUSPARCState *env = &cpu->env;
 
-    cs->env_ptr = env;
+    cpu_set_cpustate_pointers(cpu);
 
     if (scc->cpu_def) {
         env->def = *scc->cpu_def;
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index b209c55387..3567a2b664 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -100,11 +100,9 @@ static void tilegx_cpu_realizefn(DeviceState *dev, Error **errp)
 
 static void tilegx_cpu_initfn(Object *obj)
 {
-    CPUState *cs = CPU(obj);
     TileGXCPU *cpu = TILEGX_CPU(obj);
-    CPUTLGState *env = &cpu->env;
 
-    cs->env_ptr = env;
+    cpu_set_cpustate_pointers(cpu);
 }
 
 static void tilegx_cpu_do_interrupt(CPUState *cs)
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index ea1199d27e..8624103674 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -104,11 +104,9 @@ static void tricore_cpu_realizefn(DeviceState *dev, Error **errp)
 
 static void tricore_cpu_initfn(Object *obj)
 {
-    CPUState *cs = CPU(obj);
     TriCoreCPU *cpu = TRICORE_CPU(obj);
-    CPUTriCoreState *env = &cpu->env;
 
-    cs->env_ptr = env;
+    cpu_set_cpustate_pointers(cpu);
 }
 
 static ObjectClass *tricore_cpu_class_by_name(const char *cpu_model)
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index 3f57c508a0..451082bbe6 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -103,11 +103,10 @@ static void uc32_cpu_realizefn(DeviceState *dev, Error **errp)
 
 static void uc32_cpu_initfn(Object *obj)
 {
-    CPUState *cs = CPU(obj);
     UniCore32CPU *cpu = UNICORE32_CPU(obj);
     CPUUniCore32State *env = &cpu->env;
 
-    cs->env_ptr = env;
+    cpu_set_cpustate_pointers(cpu);
 
 #ifdef CONFIG_USER_ONLY
     env->uncached_asr = ASR_MODE_USER;
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index c79dc75bfe..f3ec66e242 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -138,12 +138,11 @@ static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
 
 static void xtensa_cpu_initfn(Object *obj)
 {
-    CPUState *cs = CPU(obj);
     XtensaCPU *cpu = XTENSA_CPU(obj);
     XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(obj);
     CPUXtensaState *env = &cpu->env;
 
-    cs->env_ptr = env;
+    cpu_set_cpustate_pointers(cpu);
     env->config = xcc->config;
 
 #ifndef CONFIG_USER_ONLY
-- 
2.17.1


