Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0EBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C8F2072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bN29/13S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C8F2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboOQ-00079B-8g
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboII-0002VL-N8
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:42 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:38180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIH-0006Xb-HL
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:42 -0400
Received: by mail-qk1-x742.google.com with SMTP id f189so7857517qkd.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6NkPzVbp7pB8hvFfdsKA9EEdR2aYnidZNgYq++P2+/c=;
 b=bN29/13S1TB+Mt2KQKrLcDbSzGXtjcu7xAuASP1uygOxNBrXG1x+JT9OvurLi1TB10
 QD9s1V9bZlJZpweuS2rFiinRWa1HgHI4zk+7NERwvi1Gonw/fFaxlbOiXdhU14H6Jmbo
 kgCmP3LsQ7H1gZe64Iq8YxjdUys6nOf3soRG9pbjrXHlLzfJgPMTq9G4f17EwwTqOndA
 LpVUct/Fz0p2g6lYVweB9yZKZwezfOHdym/hwIqZDEMDU3cyhhck/VmTj2bxlI+xKzn+
 3XJM8PYl3J/TMDeltrcgWnUXximXal1rUPscxiJRlusBER0ndCRx0CgAaTrOXEkYUAIw
 q+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6NkPzVbp7pB8hvFfdsKA9EEdR2aYnidZNgYq++P2+/c=;
 b=taNYWf+7EzXzGr/71Cr48SZXR+5BZZOD9NcyAt4agHBO9IN/rdm8UOZ/ZbWpDbgGpP
 M2dsrFMXpA89r/tBWtuzp818WGwouD8+KQ6MCzSjey/eedAwIeD/bx+OqOGBfj0cLmQC
 5GW1eCH88WvpAiKJ3r8ZOb3yzEgpiJHgEg7Beb0nVZvE/zWWn8sL+INdgMS6GA/AAaBR
 MqtS5i7dO+G5GfXkU9X9bLBLza1UXP0rLHRxrhQB+7hBX5lrzEG3gOZUJ0FbrGx4OspI
 GRFhfT7DxQRRDAUeay7ga8KQ2yV22qF6HYzbgsn5nPEldbGbwfWjrrcnxAEhXw6FIr1Q
 r6vA==
X-Gm-Message-State: AOAM533My6drMsFd3lkiuJPXBbv3+cAlN+C+4A4RaTKwiLiCr5HI39TZ
 z0+JdNgcYLgStYF6sIiSfF/oEkR/UF0xRQ==
X-Google-Smtp-Source: ABdhPJzmlzM24e5Uy8a9AdtYRd+s24yjA2O3qNjMwAtIshkIyQnWHtISZAXAjoru0dtkedjm8lw8PA==
X-Received: by 2002:a05:620a:14ac:: with SMTP id
 x12mr10388327qkj.262.1590079420064; 
 Thu, 21 May 2020 09:43:40 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:39 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 19/74] ppc: convert to cpu_halted
Date: Thu, 21 May 2020 12:39:16 -0400
Message-Id: <20200521164011.638-20-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x742.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: robert.foley@linaro.org, richard.henderson@linaro.org, cota@braap.org,
 qemu-ppc@nongnu.org, peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

In ppce500_spin.c, acquire the lock just once to update
both cpu->halted and cpu->stopped.

In hw/ppc/spapr_hcall.c, acquire the lock just once to
update cpu->halted and call cpu_has_work, since later
in the series we'll acquire the BQL (if not already held)
from cpu_has_work.

Cc: qemu-ppc@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Emilio G. Cota <cota@braap.org>
[RF: hw/ppc/spapr_hcall.c, spapr_rtas.c more conversions]
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 hw/ppc/e500.c                   |  4 ++--
 hw/ppc/ppc.c                    | 10 +++++-----
 hw/ppc/ppce500_spin.c           |  6 ++++--
 hw/ppc/spapr_cpu_core.c         |  4 ++--
 hw/ppc/spapr_hcall.c            | 14 ++++++++------
 hw/ppc/spapr_rtas.c             |  8 ++++----
 target/ppc/excp_helper.c        |  4 ++--
 target/ppc/helper_regs.h        |  2 +-
 target/ppc/kvm.c                |  4 ++--
 target/ppc/translate_init.inc.c |  8 ++++----
 10 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 2a0b66a152..5683a8576e 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -706,7 +706,7 @@ static void ppce500_cpu_reset_sec(void *opaque)
 
     /* Secondary CPU starts in halted state for now. Needs to change when
        implementing non-kernel boot. */
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     cs->exception_index = EXCP_HLT;
 }
 
@@ -720,7 +720,7 @@ static void ppce500_cpu_reset(void *opaque)
     cpu_reset(cs);
 
     /* Set initial guest state. */
-    cs->halted = 0;
+    cpu_halted_set(cs, 0);
     env->gpr[1] = (16 * MiB) - 8;
     env->gpr[3] = bi->dt_base;
     env->gpr[4] = 0;
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 4a11fb1640..0e7386ff88 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -149,7 +149,7 @@ static void ppc6xx_set_irq(void *opaque, int pin, int level)
             /* XXX: Note that the only way to restart the CPU is to reset it */
             if (level) {
                 LOG_IRQ("%s: stop the CPU\n", __func__);
-                cs->halted = 1;
+                cpu_halted_set(cs, 1);
             }
             break;
         case PPC6xx_INPUT_HRESET:
@@ -228,10 +228,10 @@ static void ppc970_set_irq(void *opaque, int pin, int level)
             /* XXX: TODO: relay the signal to CKSTP_OUT pin */
             if (level) {
                 LOG_IRQ("%s: stop the CPU\n", __func__);
-                cs->halted = 1;
+                cpu_halted_set(cs, 1);
             } else {
                 LOG_IRQ("%s: restart the CPU\n", __func__);
-                cs->halted = 0;
+                cpu_halted_set(cs, 0);
                 qemu_cpu_kick(cs);
             }
             break;
@@ -445,10 +445,10 @@ static void ppc40x_set_irq(void *opaque, int pin, int level)
             /* Level sensitive - active low */
             if (level) {
                 LOG_IRQ("%s: stop the CPU\n", __func__);
-                cs->halted = 1;
+                cpu_halted_set(cs, 1);
             } else {
                 LOG_IRQ("%s: restart the CPU\n", __func__);
-                cs->halted = 0;
+                cpu_halted_set(cs, 0);
                 qemu_cpu_kick(cs);
             }
             break;
diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index 66c1065db2..79313944cf 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -107,9 +107,11 @@ static void spin_kick(CPUState *cs, run_on_cpu_data data)
     map_start = ldq_p(&curspin->addr) & ~(map_size - 1);
     mmubooke_create_initial_mapping(env, 0, map_start, map_size);
 
-    cs->halted = 0;
-    cs->exception_index = -1;
+    cpu_mutex_lock(cs);
+    cpu_halted_set(cs, 0);
     cs->stopped = false;
+    cpu_mutex_unlock(cs);
+    cs->exception_index = -1;
     qemu_cpu_kick(cs);
 }
 
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index e1f76c74f3..b5d0b06f3a 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -39,7 +39,7 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
     /* All CPUs start halted.  CPU0 is unhalted from the machine level
      * reset code and the rest are explicitly started up by the guest
      * using an RTAS call */
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
 
     env->spr[SPR_HIOR] = 0;
 
@@ -88,7 +88,7 @@ void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip,
     env->gpr[3] = r3;
     env->gpr[4] = r4;
     kvmppc_set_reg_ppc_online(cpu, 1);
-    CPU(cpu)->halted = 0;
+    cpu_halted_set(CPU(cpu), 0);
     /* Enable Power-saving mode Exit Cause exceptions */
     ppc_store_lpcr(cpu, env->spr[SPR_LPCR] | pcc->lpcr_pm);
 }
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 0f54988f2e..e678ca29a5 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1058,17 +1058,19 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
     env->msr |= (1ULL << MSR_EE);
     hreg_compute_hflags(env);
 
+    cpu_mutex_lock(cs);
     if (spapr_cpu->prod) {
         spapr_cpu->prod = false;
+        cpu_mutex_unlock(cs);
         return H_SUCCESS;
     }
 
     if (!cpu_has_work(cs)) {
-        cs->halted = 1;
+        cpu_halted_set(cs, 1);
         cs->exception_index = EXCP_HLT;
         cs->exit_request = 1;
     }
-
+    cpu_mutex_unlock(cs);
     return H_SUCCESS;
 }
 
@@ -1085,7 +1087,7 @@ static target_ulong h_confer_self(PowerPCCPU *cpu)
         spapr_cpu->prod = false;
         return H_SUCCESS;
     }
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     cs->exception_index = EXCP_HALTED;
     cs->exit_request = 1;
 
@@ -1116,7 +1118,7 @@ static target_ulong h_join(PowerPCCPU *cpu, SpaprMachineState *spapr,
         }
 
         /* Don't have a way to indicate joined, so use halted && MSR[EE]=0 */
-        if (!cs->halted || (e->msr & (1ULL << MSR_EE))) {
+        if (!cpu_halted(cs) || (e->msr & (1ULL << MSR_EE))) {
             last_unjoined = false;
             break;
         }
@@ -1199,7 +1201,7 @@ static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
 
     spapr_cpu = spapr_cpu_state(tcpu);
     spapr_cpu->prod = true;
-    cs->halted = 0;
+    cpu_halted_set(cs, 0);
     qemu_cpu_kick(cs);
 
     return H_SUCCESS;
@@ -1685,7 +1687,7 @@ target_ulong do_client_architecture_support(PowerPCCPU *cpu,
         if (cs == CPU(cpu)) {
             continue;
         }
-        if (!cs->halted) {
+        if (!cpu_halted(cs)) {
             warn_report("guest has multiple active vCPUs at CAS, which is not allowed");
             return H_MULTI_THREADS_ACTIVE;
         }
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index bcac0d00e7..2306f2985e 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -111,7 +111,7 @@ static void rtas_query_cpu_stopped_state(PowerPCCPU *cpu_,
     id = rtas_ld(args, 0);
     cpu = spapr_find_cpu(id);
     if (cpu != NULL) {
-        if (CPU(cpu)->halted) {
+        if (cpu_halted(CPU(cpu))) {
             rtas_st(rets, 1, 0);
         } else {
             rtas_st(rets, 1, 2);
@@ -155,7 +155,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, SpaprMachineState *spapr,
     env = &newcpu->env;
     pcc = POWERPC_CPU_GET_CLASS(newcpu);
 
-    if (!CPU(newcpu)->halted) {
+    if (!cpu_halted(CPU(newcpu))) {
         rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
         return;
     }
@@ -213,7 +213,7 @@ static void rtas_stop_self(PowerPCCPU *cpu, SpaprMachineState *spapr,
      */
     ppc_store_lpcr(cpu, env->spr[SPR_LPCR] & ~pcc->lpcr_pm);
     env->spr[SPR_PSSCR] |= PSSCR_EC;
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     kvmppc_set_reg_ppc_online(cpu, 0);
     qemu_cpu_kick(cs);
 }
@@ -238,7 +238,7 @@ static void rtas_ibm_suspend_me(PowerPCCPU *cpu, SpaprMachineState *spapr,
         }
 
         /* See h_join */
-        if (!cs->halted || (e->msr & (1ULL << MSR_EE))) {
+        if (!cpu_halted(cs) || (e->msr & (1ULL << MSR_EE))) {
             rtas_st(rets, 0, H_MULTI_THREADS_ACTIVE);
             return;
         }
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index f052979664..4c7da88682 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -293,7 +293,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
                 qemu_log("Machine check while not allowed. "
                         "Entering checkstop state\n");
             }
-            cs->halted = 1;
+            cpu_halted_set(cs, 1);
             cpu_interrupt_exittb(cs);
         }
         if (env->msr_mask & MSR_HVB) {
@@ -1095,7 +1095,7 @@ void helper_pminsn(CPUPPCState *env, powerpc_pm_insn_t insn)
     CPUState *cs;
 
     cs = env_cpu(env);
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
 
     /*
      * The architecture specifies that HDEC interrupts are discarded
diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
index d78c2af63e..f84438f639 100644
--- a/target/ppc/helper_regs.h
+++ b/target/ppc/helper_regs.h
@@ -168,7 +168,7 @@ static inline int hreg_store_msr(CPUPPCState *env, target_ulong value,
 #if !defined(CONFIG_USER_ONLY)
     if (unlikely(msr_pow == 1)) {
         if (!env->pending_interrupts && (*env->check_pow)(env)) {
-            cs->halted = 1;
+            cpu_halted_set(cs, 1);
             excp = EXCP_HALTED;
         }
     }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 2692f76130..aae2ef0ad4 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1342,7 +1342,7 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
 
 int kvm_arch_process_async_events(CPUState *cs)
 {
-    return cs->halted;
+    return cpu_halted(cs);
 }
 
 static int kvmppc_handle_halt(PowerPCCPU *cpu)
@@ -1351,7 +1351,7 @@ static int kvmppc_handle_halt(PowerPCCPU *cpu)
     CPUPPCState *env = &cpu->env;
 
     if (!(cs->interrupt_request & CPU_INTERRUPT_HARD) && (msr_ee)) {
-        cs->halted = 1;
+        cpu_halted_set(cs, 1);
         cs->exception_index = EXCP_HLT;
     }
 
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index d8adc1bd49..5838b6f7bc 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8539,7 +8539,7 @@ static bool cpu_has_work_POWER7(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
-    if (cs->halted) {
+    if (cpu_halted(cs)) {
         if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
             return false;
         }
@@ -8701,7 +8701,7 @@ static bool cpu_has_work_POWER8(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
-    if (cs->halted) {
+    if (cpu_halted(cs)) {
         if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
             return false;
         }
@@ -8901,7 +8901,7 @@ static bool cpu_has_work_POWER9(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
-    if (cs->halted) {
+    if (cpu_halted(cs)) {
         uint64_t psscr = env->spr[SPR_PSSCR];
 
         if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
@@ -9117,7 +9117,7 @@ static bool cpu_has_work_POWER10(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
-    if (cs->halted) {
+    if (cpu_halted(cs)) {
         uint64_t psscr = env->spr[SPR_PSSCR];
 
         if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
-- 
2.17.1


