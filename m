Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D1BC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277B6207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yAZKSF7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277B6207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57703 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYGGl-0008ON-9G
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 16:42:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8Z-0001EZ-4G
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8X-0004LJ-Ho
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:27 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG8X-0004Ko-BI
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:25 -0400
Received: by mail-oi1-x241.google.com with SMTP id w7so5244503oic.3
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=YlNyMLJrebyqTNe9alCGCP+GtKEH43Bwhp0Gyfzj14A=;
	b=yAZKSF7R+C/1FHcIIS5yKKRJNkEiLcI3uJYegZlcBYem+T0rBrKw7xkDvCcEkqVkT9
	d3KRe3098cxD0t3H9nJi3rV6fGFdU+Y84ae6Vg76s5+Tw5pYegaDyeAlBeaIgUS7O0w+
	QkY5G73Zz8xqmNsf7Wr2+V2rxjCtrLMJr9JJ12mC9p3L/5WvbIyw+AlBIi7Cm2SVvmga
	XIwNu1sAXKXqHl5jcES/BNVSuU1MMVr77NuoIIgwSkCEVm0JHThLfDrFRyczhQkZr989
	yWzicY2sKn6jv6zKf7Nnt4H8GaODqzPXqYWYGh0drWcdO+xlDqiPmHEK4znYqMfrCjCA
	B6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=YlNyMLJrebyqTNe9alCGCP+GtKEH43Bwhp0Gyfzj14A=;
	b=exFxd/AOtaq2VizrEGKeK6/ODTvsQM10tLoYhqZ+xd4/qVUEIJ8BeRJ+wnbogEoQ+G
	MAypM3wieRKATRwOlRR7TBcuuwp7WGwW+rg8C1AQfkGYHfgKjqw2llIaHec9KV0Z5bYv
	hEnVE8S/npAGhPSj9OgizoBbPbXkkNV1v2fn22qfEjOwFz7xJS0ZznNsiLJBIgPe+mBK
	kXDSiUVh4b9nH4C832+IR4LM1vpUVQY2bgO4y3iosg335fzl7xrxmhwzZ6HPbsPo8FvW
	Std0XR4VEHL2SjO1cu+9FwB/UozoIchoUve9SHGksUQHynofQck3Mt2/UH2P+KsiW3hZ
	OWug==
X-Gm-Message-State: APjAAAVdyFN/avyiUoZC8iBNf9eVvYokE6ro6eUnvBnssP1Hk0o10Pdy
	X1Ozo0xC1ONwops2HRjX+wEMYyxojNA6hw==
X-Google-Smtp-Source: APXvYqy69HTCo8KZ7blNxFdNd0wtDo8pxm4APYG8Nk3pO7l8jqs9UElL92MAhAbOx1sXDN3edeFzbQ==
X-Received: by 2002:aca:c695:: with SMTP id w143mr1113212oif.11.1559680464138; 
	Tue, 04 Jun 2019 13:34:24 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.34.22
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:34:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:30 -0500
Message-Id: <20190604203351.27778-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604203351.27778-1-richard.henderson@linaro.org>
References: <20190604203351.27778-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: [Qemu-devel] [PATCH v4 18/39] target/mips: Use env_cpu, env_archcpu
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

Cleanup in the boilerplate that each target must define.
Replace mips_env_get_cpu with env_archcpu.  The combination
CPU(mips_env_get_cpu) should have used ENV_GET_CPU to begin;
use env_cpu now.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/cpu.h                |  5 -----
 hw/intc/mips_gic.c               |  2 +-
 hw/mips/mips_int.c               |  2 +-
 linux-user/mips/cpu_loop.c       |  2 +-
 target/mips/helper.c             | 15 +++++----------
 target/mips/op_helper.c          | 25 +++++++++++--------------
 target/mips/translate.c          |  3 +--
 target/mips/translate_init.inc.c |  4 +---
 8 files changed, 21 insertions(+), 37 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index e684572dda..cb09425476 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1071,11 +1071,6 @@ struct MIPSCPU {
     CPUMIPSState env;
 };
 
-static inline MIPSCPU *mips_env_get_cpu(CPUMIPSState *env)
-{
-    return container_of(env, MIPSCPU, env);
-}
-
 #define ENV_OFFSET offsetof(MIPSCPU, env)
 
 void mips_cpu_list(void);
diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index 15e6e40f9f..8f509493ea 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -44,7 +44,7 @@ static void mips_gic_set_vp_irq(MIPSGICState *gic, int vp, int pin)
                       GIC_VP_MASK_CMP_SHF;
     }
     if (kvm_enabled())  {
-        kvm_mips_set_ipi_interrupt(mips_env_get_cpu(gic->vps[vp].env),
+        kvm_mips_set_ipi_interrupt(env_archcpu(gic->vps[vp].env),
                                    pin + GIC_CPU_PIN_OFFSET,
                                    ored_level);
     } else {
diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index 5ddeb15848..f899f6ceb3 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -76,7 +76,7 @@ void cpu_mips_irq_init_cpu(MIPSCPU *cpu)
     qemu_irq *qi;
     int i;
 
-    qi = qemu_allocate_irqs(cpu_mips_irq_request, mips_env_get_cpu(env), 8);
+    qi = qemu_allocate_irqs(cpu_mips_irq_request, env_archcpu(env), 8);
     for (i = 0; i < 8; i++) {
         env->irq[i] = qi[i];
     }
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 828137cd84..ac6c6d1504 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -425,7 +425,7 @@ static int do_break(CPUMIPSState *env, target_siginfo_t *info,
 
 void cpu_loop(CPUMIPSState *env)
 {
-    CPUState *cs = CPU(mips_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     target_siginfo_t info;
     int trapnr;
     abi_long ret;
diff --git a/target/mips/helper.c b/target/mips/helper.c
index 68e44df4da..6e6a44292f 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -339,10 +339,8 @@ static int get_physical_address (CPUMIPSState *env, hwaddr *physical,
 
 void cpu_mips_tlb_flush(CPUMIPSState *env)
 {
-    MIPSCPU *cpu = mips_env_get_cpu(env);
-
     /* Flush qemu's TLB and discard all shadowed entries.  */
-    tlb_flush(CPU(cpu));
+    tlb_flush(env_cpu(env));
     env->tlb->tlb_in_use = env->tlb->nb_tlb;
 }
 
@@ -404,7 +402,7 @@ void cpu_mips_store_status(CPUMIPSState *env, target_ulong val)
 #if defined(TARGET_MIPS64)
     if ((env->CP0_Status ^ old) & (old & (7 << CP0St_UX))) {
         /* Access to at least one of the 64-bit segments has been disabled */
-        tlb_flush(CPU(mips_env_get_cpu(env)));
+        tlb_flush(env_cpu(env));
     }
 #endif
     if (env->CP0_Config3 & (1 << CP0C3_MT)) {
@@ -449,7 +447,7 @@ void cpu_mips_store_cause(CPUMIPSState *env, target_ulong val)
 static void raise_mmu_exception(CPUMIPSState *env, target_ulong address,
                                 int rw, int tlb_error)
 {
-    CPUState *cs = CPU(mips_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int exception = 0, error_code = 0;
 
     if (rw == MMU_INST_FETCH) {
@@ -1394,8 +1392,7 @@ bool mips_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 #if !defined(CONFIG_USER_ONLY)
 void r4k_invalidate_tlb (CPUMIPSState *env, int idx, int use_extra)
 {
-    MIPSCPU *cpu = mips_env_get_cpu(env);
-    CPUState *cs;
+    CPUState *cs = env_cpu(env);
     r4k_tlb_t *tlb;
     target_ulong addr;
     target_ulong end;
@@ -1421,7 +1418,6 @@ void r4k_invalidate_tlb (CPUMIPSState *env, int idx, int use_extra)
     /* 1k pages are not supported. */
     mask = tlb->PageMask | ~(TARGET_PAGE_MASK << 1);
     if (tlb->V0) {
-        cs = CPU(cpu);
         addr = tlb->VPN & ~mask;
 #if defined(TARGET_MIPS64)
         if (addr >= (0xFFFFFFFF80000000ULL & env->SEGMask)) {
@@ -1435,7 +1431,6 @@ void r4k_invalidate_tlb (CPUMIPSState *env, int idx, int use_extra)
         }
     }
     if (tlb->V1) {
-        cs = CPU(cpu);
         addr = (tlb->VPN & ~mask) | ((mask >> 1) + 1);
 #if defined(TARGET_MIPS64)
         if (addr >= (0xFFFFFFFF80000000ULL & env->SEGMask)) {
@@ -1456,7 +1451,7 @@ void QEMU_NORETURN do_raise_exception_err(CPUMIPSState *env,
                                           int error_code,
                                           uintptr_t pc)
 {
-    CPUState *cs = CPU(mips_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     qemu_log_mask(CPU_LOG_INT, "%s: %d %d\n",
                   __func__, exception, error_code);
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 39180275b5..9e2e02f858 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -350,7 +350,7 @@ static inline hwaddr do_translate_address(CPUMIPSState *env,
                                                       int rw, uintptr_t retaddr)
 {
     hwaddr paddr;
-    CPUState *cs = CPU(mips_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     paddr = cpu_mips_translate_address(env, address, rw);
 
@@ -699,7 +699,7 @@ static CPUMIPSState *mips_cpu_map_tc(CPUMIPSState *env, int *tc)
         return env;
     }
 
-    cs = CPU(mips_env_get_cpu(env));
+    cs = env_cpu(env);
     vpe_idx = tc_idx / cs->nr_threads;
     *tc = tc_idx % cs->nr_threads;
     other_cs = qemu_get_cpu(vpe_idx);
@@ -1298,7 +1298,7 @@ void helper_mttc0_tcrestart(CPUMIPSState *env, target_ulong arg1)
 
 void helper_mtc0_tchalt(CPUMIPSState *env, target_ulong arg1)
 {
-    MIPSCPU *cpu = mips_env_get_cpu(env);
+    MIPSCPU *cpu = env_archcpu(env);
 
     env->active_tc.CP0_TCHalt = arg1 & 0x1;
 
@@ -1314,7 +1314,7 @@ void helper_mttc0_tchalt(CPUMIPSState *env, target_ulong arg1)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
-    MIPSCPU *other_cpu = mips_env_get_cpu(other);
+    MIPSCPU *other_cpu = env_archcpu(other);
 
     // TODO: Halt TC / Restart (if allocated+active) TC.
 
@@ -1427,7 +1427,7 @@ void helper_mtc0_pagegrain(CPUMIPSState *env, target_ulong arg1)
 
 void helper_mtc0_segctl0(CPUMIPSState *env, target_ulong arg1)
 {
-    CPUState *cs = CPU(mips_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     env->CP0_SegCtl0 = arg1 & CP0SC0_MASK;
     tlb_flush(cs);
@@ -1435,7 +1435,7 @@ void helper_mtc0_segctl0(CPUMIPSState *env, target_ulong arg1)
 
 void helper_mtc0_segctl1(CPUMIPSState *env, target_ulong arg1)
 {
-    CPUState *cs = CPU(mips_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     env->CP0_SegCtl1 = arg1 & CP0SC1_MASK;
     tlb_flush(cs);
@@ -1443,7 +1443,7 @@ void helper_mtc0_segctl1(CPUMIPSState *env, target_ulong arg1)
 
 void helper_mtc0_segctl2(CPUMIPSState *env, target_ulong arg1)
 {
-    CPUState *cs = CPU(mips_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     env->CP0_SegCtl2 = arg1 & CP0SC2_MASK;
     tlb_flush(cs);
@@ -1666,7 +1666,7 @@ void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
     /* If the ASID changes, flush qemu's TLB.  */
     if ((old & env->CP0_EntryHi_ASID_mask) !=
         (val & env->CP0_EntryHi_ASID_mask)) {
-        tlb_flush(CPU(mips_env_get_cpu(env)));
+        tlb_flush(env_cpu(env));
     }
 }
 
@@ -1686,7 +1686,6 @@ void helper_mtc0_compare(CPUMIPSState *env, target_ulong arg1)
 
 void helper_mtc0_status(CPUMIPSState *env, target_ulong arg1)
 {
-    MIPSCPU *cpu = mips_env_get_cpu(env);
     uint32_t val, old;
 
     old = env->CP0_Status;
@@ -1706,7 +1705,7 @@ void helper_mtc0_status(CPUMIPSState *env, target_ulong arg1)
         case MIPS_HFLAG_SM: qemu_log(", SM\n"); break;
         case MIPS_HFLAG_KM: qemu_log("\n"); break;
         default:
-            cpu_abort(CPU(cpu), "Invalid MMU mode!\n");
+            cpu_abort(env_cpu(env), "Invalid MMU mode!\n");
             break;
         }
     }
@@ -2485,8 +2484,6 @@ static void debug_pre_eret(CPUMIPSState *env)
 
 static void debug_post_eret(CPUMIPSState *env)
 {
-    MIPSCPU *cpu = mips_env_get_cpu(env);
-
     if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
         qemu_log("  =>  PC " TARGET_FMT_lx " EPC " TARGET_FMT_lx,
                 env->active_tc.PC, env->CP0_EPC);
@@ -2502,7 +2499,7 @@ static void debug_post_eret(CPUMIPSState *env)
         case MIPS_HFLAG_SM: qemu_log(", SM\n"); break;
         case MIPS_HFLAG_KM: qemu_log("\n"); break;
         default:
-            cpu_abort(CPU(cpu), "Invalid MMU mode!\n");
+            cpu_abort(env_cpu(env), "Invalid MMU mode!\n");
             break;
         }
     }
@@ -2633,7 +2630,7 @@ void helper_pmon(CPUMIPSState *env, int function)
 
 void helper_wait(CPUMIPSState *env)
 {
-    CPUState *cs = CPU(mips_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->halted = 1;
     cpu_reset_interrupt(cs, CPU_INTERRUPT_WAKE);
diff --git a/target/mips/translate.c b/target/mips/translate.c
index e37722dfff..a3cf976ab6 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -30119,8 +30119,7 @@ void cpu_set_exception_base(int vp_index, target_ulong address)
 
 void cpu_state_reset(CPUMIPSState *env)
 {
-    MIPSCPU *cpu = mips_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
 
     /* Reset registers to their default values */
     env->CP0_PRid = env->cpu_model->CP0_PRid;
diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
index 1c2d017d36..6d145a905a 100644
--- a/target/mips/translate_init.inc.c
+++ b/target/mips/translate_init.inc.c
@@ -871,8 +871,6 @@ static void r4k_mmu_init (CPUMIPSState *env, const mips_def_t *def)
 
 static void mmu_init (CPUMIPSState *env, const mips_def_t *def)
 {
-    MIPSCPU *cpu = mips_env_get_cpu(env);
-
     env->tlb = g_malloc0(sizeof(CPUMIPSTLBContext));
 
     switch (def->mmu_type) {
@@ -889,7 +887,7 @@ static void mmu_init (CPUMIPSState *env, const mips_def_t *def)
         case MMU_TYPE_R6000:
         case MMU_TYPE_R8000:
         default:
-            cpu_abort(CPU(cpu), "MMU type not supported\n");
+            cpu_abort(env_cpu(env), "MMU type not supported\n");
     }
 }
 #endif /* CONFIG_USER_ONLY */
-- 
2.17.1


