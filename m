Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AF2C004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:25:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931D6205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N7ILm7aT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931D6205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56618 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOAOb-0006Nd-MO
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:25:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7I-0007ki-UK
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7F-0007N6-9I
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:24 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:44070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA7E-00078Q-8O
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:21 -0400
Received: by mail-pl1-x635.google.com with SMTP id d3so4946816plj.11
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=PHwctSxqMKwvqp5BrGqAjPbotgsxGi7qfHQRqyykurQ=;
	b=N7ILm7aTfjl2HTnZXG+iw4ivxU219rlUZ2M5wkUr9oSg65vZMeXMf4nyyz7fWFigSs
	XAxa0EPURsp96DBzObP1CEKx/Djc8OF29RCQa/Hx1PMgKuxlWlzJ/QsRVHW677MDDKPU
	YQCu2AdI8/HdCMYK+2WfixPIGMbQtW/cc6x4kX7z5wy8xMSBQMIKDYS2ovq0yBgdTL39
	Ev0G1Wbe3dzfnEjSzwXqI7DrszdWPEiL9Kb8r1y6GtO7Pf2q2iOlmY0MNNhIR9iDCx5F
	ggCRsyYvHViiYk+0MGweBf1speKEU6dkZva1a2HaFGUE22gA1HSRTggE/2PU3GvOTxC+
	sS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=PHwctSxqMKwvqp5BrGqAjPbotgsxGi7qfHQRqyykurQ=;
	b=dwOIWh7BOhXZjFeHhi4nBXHcOdEoK8eHBzcdWKoNSTFTArnncwYtPJtyNTPySTC2Ev
	h9qAKS/uyQXd7BN0STmmQrjQJ8HWC5A5JZO09Udh88GMKFKnWuL9G1X+XrY9xCpLpmDV
	ZWhht9XNf51BtQql2NJ5d977m5imcx81Qn/3v8VuN9fhE7PegGzt/F6SEU9p5/frTiSF
	kPFJXQ49SYPJ9eNRrDvlGKj3LDyupwwj5GZWZspNOFlm4lhTw93ozdqwz+GjeEQu0/GU
	AKPIMfiNPxPmuQzRl1w5H+fgPDtm0DHtKKMniOH8AIb6FStLb5z96pAX6HGPgJ6lt0YK
	7k/g==
X-Gm-Message-State: APjAAAWTRztSeJhN/1bSqXcK956joL2wLYCZmdraAu4HuZZ/3iIQBrda
	HbG4cuJO1Co2o/e72bZuIOJd+WPNYPk=
X-Google-Smtp-Source: APXvYqwAdUCkMjFfoXIHaxFf6a/NI+pSVvUMEBi4rJ1z4FvqUTpqr8MVh5tyXBp/tkBMmQycjJiZOQ==
X-Received: by 2002:a17:902:5acb:: with SMTP id
	g11mr7382907plm.198.1557274035065; 
	Tue, 07 May 2019 17:07:15 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.07.13 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:07:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:26 -0700
Message-Id: <20190508000641.19090-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::635
Subject: [Qemu-devel] [PATCH v3 24/39] target/s390x: Use env_cpu, env_archcpu
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.h          |  5 ----
 linux-user/s390x/cpu_loop.c |  2 +-
 target/s390x/cc_helper.c    |  5 ++--
 target/s390x/diag.c         |  2 +-
 target/s390x/excp_helper.c  |  6 ++---
 target/s390x/fpu_helper.c   |  4 +--
 target/s390x/helper.c       |  7 +++---
 target/s390x/int_helper.c   |  3 +--
 target/s390x/interrupt.c    |  6 ++---
 target/s390x/mem_helper.c   | 28 ++++++++-------------
 target/s390x/misc_helper.c  | 50 ++++++++++++++++++-------------------
 target/s390x/mmu_helper.c   |  8 +++---
 target/s390x/sigp.c         |  4 +--
 13 files changed, 56 insertions(+), 74 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 9cdd831a77..eefed6f509 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -163,11 +163,6 @@ struct S390CPU {
     uint32_t irqstate_saved_size;
 };
 
-static inline S390CPU *s390_env_get_cpu(CPUS390XState *env)
-{
-    return container_of(env, S390CPU, env);
-}
-
 #define ENV_OFFSET offsetof(S390CPU, env)
 
 #ifndef CONFIG_USER_ONLY
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
index b8bd1c956c..8211022ceb 100644
--- a/linux-user/s390x/cpu_loop.c
+++ b/linux-user/s390x/cpu_loop.c
@@ -26,7 +26,7 @@
 
 void cpu_loop(CPUS390XState *env)
 {
-    CPUState *cs = CPU(s390_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int trapnr, n, sig;
     target_siginfo_t info;
     target_ulong addr;
diff --git a/target/s390x/cc_helper.c b/target/s390x/cc_helper.c
index 0e467bf2b6..e9732500ad 100644
--- a/target/s390x/cc_helper.c
+++ b/target/s390x/cc_helper.c
@@ -405,7 +405,6 @@ static uint32_t cc_calc_lcbb(uint64_t dst)
 static uint32_t do_calc_cc(CPUS390XState *env, uint32_t cc_op,
                                   uint64_t src, uint64_t dst, uint64_t vr)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
     uint32_t r = 0;
 
     switch (cc_op) {
@@ -526,7 +525,7 @@ static uint32_t do_calc_cc(CPUS390XState *env, uint32_t cc_op,
         break;
 
     default:
-        cpu_abort(CPU(cpu), "Unknown CC operation: %s\n", cc_name(cc_op));
+        cpu_abort(env_cpu(env), "Unknown CC operation: %s\n", cc_name(cc_op));
     }
 
     HELPER_LOG("%s: %15s 0x%016lx 0x%016lx 0x%016lx = %d\n", __func__,
@@ -550,7 +549,7 @@ uint32_t HELPER(calc_cc)(CPUS390XState *env, uint32_t cc_op, uint64_t src,
 void HELPER(load_psw)(CPUS390XState *env, uint64_t mask, uint64_t addr)
 {
     load_psw(env, mask, addr);
-    cpu_loop_exit(CPU(s390_env_get_cpu(env)));
+    cpu_loop_exit(env_cpu(env));
 }
 
 void HELPER(sacf)(CPUS390XState *env, uint64_t a1)
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index aafa740f61..65eabf0461 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -55,7 +55,7 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
 
 void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
-    CPUState *cs = CPU(s390_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     uint64_t addr =  env->regs[r1];
     uint64_t subcode = env->regs[r3];
     IplParameterBlock *iplb;
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index f84bfb1284..b83c1e6559 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -36,7 +36,7 @@
 void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
                                               int ilen, uintptr_t ra)
 {
-    CPUState *cs = CPU(s390_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cpu_restore_state(cs, ra, true);
     qemu_log_mask(CPU_LOG_INT, "program interrupt at %#" PRIx64 "\n",
@@ -51,7 +51,7 @@ void QEMU_NORETURN tcg_s390_data_exception(CPUS390XState *env, uint32_t dxc,
     g_assert(dxc <= 0xff);
 #if !defined(CONFIG_USER_ONLY)
     /* Store the DXC into the lowcore */
-    stl_phys(CPU(s390_env_get_cpu(env))->as,
+    stl_phys(env_cpu(env)->as,
              env->psa + offsetof(LowCore, data_exc_code), dxc);
 #endif
 
@@ -261,7 +261,7 @@ static void do_svc_interrupt(CPUS390XState *env)
 static void do_ext_interrupt(CPUS390XState *env)
 {
     QEMUS390FLICState *flic = QEMU_S390_FLIC(s390_get_flic());
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
     uint64_t mask, addr;
     uint16_t cpu_addr;
     LowCore *lowcore;
diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index 1be68bafea..906fa8ce99 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -114,8 +114,6 @@ static void handle_exceptions(CPUS390XState *env, bool XxC, uintptr_t retaddr)
 
 static inline int float_comp_to_cc(CPUS390XState *env, int float_compare)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
-
     switch (float_compare) {
     case float_relation_equal:
         return 0;
@@ -126,7 +124,7 @@ static inline int float_comp_to_cc(CPUS390XState *env, int float_compare)
     case float_relation_unordered:
         return 3;
     default:
-        cpu_abort(CPU(cpu), "unknown return value for float compare\n");
+        cpu_abort(env_cpu(env), "unknown return value for float compare\n");
     }
 }
 
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index f957a2c830..52399bf7f4 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -111,11 +111,11 @@ void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr)
     env->cc_op = (mask >> 44) & 3;
 
     if ((old_mask ^ mask) & PSW_MASK_PER) {
-        s390_cpu_recompute_watchpoints(CPU(s390_env_get_cpu(env)));
+        s390_cpu_recompute_watchpoints(env_cpu(env));
     }
 
     if (mask & PSW_MASK_WAIT) {
-        s390_handle_wait(s390_env_get_cpu(env));
+        s390_handle_wait(env_archcpu(env));
     }
 }
 
@@ -137,14 +137,13 @@ uint64_t get_psw_mask(CPUS390XState *env)
 
 LowCore *cpu_map_lowcore(CPUS390XState *env)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
     LowCore *lowcore;
     hwaddr len = sizeof(LowCore);
 
     lowcore = cpu_physical_memory_map(env->psa, &len, 1);
 
     if (len < sizeof(LowCore)) {
-        cpu_abort(CPU(cpu), "Could not map lowcore\n");
+        cpu_abort(env_cpu(env), "Could not map lowcore\n");
     }
 
     return lowcore;
diff --git a/target/s390x/int_helper.c b/target/s390x/int_helper.c
index abbbc20d9c..d13cc49be6 100644
--- a/target/s390x/int_helper.c
+++ b/target/s390x/int_helper.c
@@ -109,10 +109,9 @@ uint64_t HELPER(divu64)(CPUS390XState *env, uint64_t ah, uint64_t al,
             s390_program_interrupt(env, PGM_FIXPT_DIVIDE, ILEN_AUTO, GETPC());
         }
 #else
-        S390CPU *cpu = s390_env_get_cpu(env);
         /* 32-bit hosts would need special wrapper functionality - just abort if
            we encounter such a case; it's very unlikely anyways. */
-        cpu_abort(CPU(cpu), "128 -> 64/64 division not implemented\n");
+        cpu_abort(env_cpu(env), "128 -> 64/64 division not implemented\n");
 #endif
     }
     return ret;
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index a17eff5ebc..a8f9b38795 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -23,7 +23,7 @@
 /* Ensure to exit the TB after this call! */
 void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen)
 {
-    CPUState *cs = CPU(s390_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = EXCP_PGM;
     env->int_pgm_code = code;
@@ -33,10 +33,8 @@ void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen)
 void s390_program_interrupt(CPUS390XState *env, uint32_t code, int ilen,
                             uintptr_t ra)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
-
     if (kvm_enabled()) {
-        kvm_s390_program_interrupt(cpu, code);
+        kvm_s390_program_interrupt(env_archcpu(env), code);
     } else if (tcg_enabled()) {
         tcg_s390_program_interrupt(env, code, ilen, ra);
     } else {
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index e2992deb2f..f02eb85d30 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1633,7 +1633,6 @@ uint32_t HELPER(csst_parallel)(CPUS390XState *env, uint32_t r3, uint64_t a1,
 void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 {
     uintptr_t ra = GETPC();
-    S390CPU *cpu = s390_env_get_cpu(env);
     bool PERchanged = false;
     uint64_t src = a2;
     uint32_t i;
@@ -1658,16 +1657,15 @@ void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     }
 
     if (PERchanged && env->psw.mask & PSW_MASK_PER) {
-        s390_cpu_recompute_watchpoints(CPU(cpu));
+        s390_cpu_recompute_watchpoints(env_cpu(env));
     }
 
-    tlb_flush(CPU(cpu));
+    tlb_flush(env_cpu(env));
 }
 
 void HELPER(lctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 {
     uintptr_t ra = GETPC();
-    S390CPU *cpu = s390_env_get_cpu(env);
     bool PERchanged = false;
     uint64_t src = a2;
     uint32_t i;
@@ -1691,10 +1689,10 @@ void HELPER(lctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     }
 
     if (PERchanged && env->psw.mask & PSW_MASK_PER) {
-        s390_cpu_recompute_watchpoints(CPU(cpu));
+        s390_cpu_recompute_watchpoints(env_cpu(env));
     }
 
-    tlb_flush(CPU(cpu));
+    tlb_flush(env_cpu(env));
 }
 
 void HELPER(stctg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
@@ -1753,8 +1751,8 @@ uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
 
 uint32_t HELPER(tprot)(CPUS390XState *env, uint64_t a1, uint64_t a2)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    S390CPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
 
     /*
      * TODO: we currently don't handle all access protection types
@@ -1922,7 +1920,7 @@ uint32_t HELPER(mvcp)(CPUS390XState *env, uint64_t l, uint64_t a1, uint64_t a2)
 
 void HELPER(idte)(CPUS390XState *env, uint64_t r1, uint64_t r2, uint32_t m4)
 {
-    CPUState *cs = CPU(s390_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     const uintptr_t ra = GETPC();
     uint64_t table, entry, raddr;
     uint16_t entries, i, index = 0;
@@ -1974,7 +1972,7 @@ void HELPER(idte)(CPUS390XState *env, uint64_t r1, uint64_t r2, uint32_t m4)
 void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr,
                   uint32_t m4)
 {
-    CPUState *cs = CPU(s390_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     const uintptr_t ra = GETPC();
     uint64_t page = vaddr & TARGET_PAGE_MASK;
     uint64_t pte_addr, pte;
@@ -2014,17 +2012,13 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr,
 /* flush local tlb */
 void HELPER(ptlb)(CPUS390XState *env)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
-
-    tlb_flush(CPU(cpu));
+    tlb_flush(env_cpu(env));
 }
 
 /* flush global tlb */
 void HELPER(purge)(CPUS390XState *env)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
-
-    tlb_flush_all_cpus_synced(CPU(cpu));
+    tlb_flush_all_cpus_synced(env_cpu(env));
 }
 
 /* load using real address */
@@ -2068,7 +2062,7 @@ void HELPER(sturg)(CPUS390XState *env, uint64_t addr, uint64_t v1)
 /* load real address */
 uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
 {
-    CPUState *cs = CPU(s390_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     uint32_t cc = 0;
     uint64_t asc = env->psw.mask & PSW_MASK_ASC;
     uint64_t ret;
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index ee67c1fa0c..c806c3ec00 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -55,7 +55,7 @@
 /* Raise an exception statically from a TB.  */
 void HELPER(exception)(CPUS390XState *env, uint32_t excp)
 {
-    CPUState *cs = CPU(s390_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     HELPER_LOG("%s: exception %d\n", __func__, excp);
     cs->exception_index = excp;
@@ -150,7 +150,7 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
 /* Set Prefix */
 void HELPER(spx)(CPUS390XState *env, uint64_t a1)
 {
-    CPUState *cs = CPU(s390_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     uint32_t prefix = a1 & 0x7fffe000;
 
     env->psa = prefix;
@@ -256,7 +256,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0, uint64_t r0, uint64_t r1)
     const uint32_t sel2 = r1 & STSI_R1_SEL2_MASK;
     const MachineState *ms = MACHINE(qdev_get_machine());
     uint16_t total_cpus = 0, conf_cpus = 0, reserved_cpus = 0;
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
     SysIB sysib = { };
     int i, cc = 0;
 
@@ -411,7 +411,7 @@ uint32_t HELPER(sigp)(CPUS390XState *env, uint64_t order_code, uint32_t r1,
 #ifndef CONFIG_USER_ONLY
 void HELPER(xsch)(CPUS390XState *env, uint64_t r1)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
     qemu_mutex_lock_iothread();
     ioinst_handle_xsch(cpu, r1, GETPC());
     qemu_mutex_unlock_iothread();
@@ -419,7 +419,7 @@ void HELPER(xsch)(CPUS390XState *env, uint64_t r1)
 
 void HELPER(csch)(CPUS390XState *env, uint64_t r1)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
     qemu_mutex_lock_iothread();
     ioinst_handle_csch(cpu, r1, GETPC());
     qemu_mutex_unlock_iothread();
@@ -427,7 +427,7 @@ void HELPER(csch)(CPUS390XState *env, uint64_t r1)
 
 void HELPER(hsch)(CPUS390XState *env, uint64_t r1)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
     qemu_mutex_lock_iothread();
     ioinst_handle_hsch(cpu, r1, GETPC());
     qemu_mutex_unlock_iothread();
@@ -435,7 +435,7 @@ void HELPER(hsch)(CPUS390XState *env, uint64_t r1)
 
 void HELPER(msch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
     qemu_mutex_lock_iothread();
     ioinst_handle_msch(cpu, r1, inst >> 16, GETPC());
     qemu_mutex_unlock_iothread();
@@ -443,7 +443,7 @@ void HELPER(msch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
 
 void HELPER(rchp)(CPUS390XState *env, uint64_t r1)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
     qemu_mutex_lock_iothread();
     ioinst_handle_rchp(cpu, r1, GETPC());
     qemu_mutex_unlock_iothread();
@@ -451,7 +451,7 @@ void HELPER(rchp)(CPUS390XState *env, uint64_t r1)
 
 void HELPER(rsch)(CPUS390XState *env, uint64_t r1)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
     qemu_mutex_lock_iothread();
     ioinst_handle_rsch(cpu, r1, GETPC());
     qemu_mutex_unlock_iothread();
@@ -459,7 +459,7 @@ void HELPER(rsch)(CPUS390XState *env, uint64_t r1)
 
 void HELPER(sal)(CPUS390XState *env, uint64_t r1)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
 
     qemu_mutex_lock_iothread();
     ioinst_handle_sal(cpu, r1, GETPC());
@@ -468,7 +468,7 @@ void HELPER(sal)(CPUS390XState *env, uint64_t r1)
 
 void HELPER(schm)(CPUS390XState *env, uint64_t r1, uint64_t r2, uint64_t inst)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
 
     qemu_mutex_lock_iothread();
     ioinst_handle_schm(cpu, r1, r2, inst >> 16, GETPC());
@@ -477,7 +477,7 @@ void HELPER(schm)(CPUS390XState *env, uint64_t r1, uint64_t r2, uint64_t inst)
 
 void HELPER(ssch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
     qemu_mutex_lock_iothread();
     ioinst_handle_ssch(cpu, r1, inst >> 16, GETPC());
     qemu_mutex_unlock_iothread();
@@ -485,7 +485,7 @@ void HELPER(ssch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
 
 void HELPER(stcrw)(CPUS390XState *env, uint64_t inst)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
 
     qemu_mutex_lock_iothread();
     ioinst_handle_stcrw(cpu, inst >> 16, GETPC());
@@ -494,7 +494,7 @@ void HELPER(stcrw)(CPUS390XState *env, uint64_t inst)
 
 void HELPER(stsch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
     qemu_mutex_lock_iothread();
     ioinst_handle_stsch(cpu, r1, inst >> 16, GETPC());
     qemu_mutex_unlock_iothread();
@@ -503,7 +503,7 @@ void HELPER(stsch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
 uint32_t HELPER(tpi)(CPUS390XState *env, uint64_t addr)
 {
     const uintptr_t ra = GETPC();
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
     QEMUS390FLICState *flic = s390_get_qemu_flic(s390_get_flic());
     QEMUS390FlicIO *io = NULL;
     LowCore *lowcore;
@@ -555,7 +555,7 @@ uint32_t HELPER(tpi)(CPUS390XState *env, uint64_t addr)
 
 void HELPER(tsch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
     qemu_mutex_lock_iothread();
     ioinst_handle_tsch(cpu, r1, inst >> 16, GETPC());
     qemu_mutex_unlock_iothread();
@@ -563,7 +563,7 @@ void HELPER(tsch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
 
 void HELPER(chsc)(CPUS390XState *env, uint64_t inst)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
     qemu_mutex_lock_iothread();
     ioinst_handle_chsc(cpu, inst >> 16, GETPC());
     qemu_mutex_unlock_iothread();
@@ -618,7 +618,7 @@ void HELPER(per_ifetch)(CPUS390XState *env, uint64_t addr)
         /* If the instruction has to be nullified, trigger the
            exception immediately. */
         if (env->cregs[9] & PER_CR9_EVENT_NULLIFICATION) {
-            CPUState *cs = CPU(s390_env_get_cpu(env));
+            CPUState *cs = env_cpu(env);
 
             env->per_perc_atmid |= PER_CODE_EVENT_NULLIFICATION;
             env->int_pgm_code = PGM_PER;
@@ -695,7 +695,7 @@ uint32_t HELPER(stfle)(CPUS390XState *env, uint64_t addr)
  */
 void HELPER(clp)(CPUS390XState *env, uint32_t r2)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
 
     qemu_mutex_lock_iothread();
     clp_service_call(cpu, r2, GETPC());
@@ -704,7 +704,7 @@ void HELPER(clp)(CPUS390XState *env, uint32_t r2)
 
 void HELPER(pcilg)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
 
     qemu_mutex_lock_iothread();
     pcilg_service_call(cpu, r1, r2, GETPC());
@@ -713,7 +713,7 @@ void HELPER(pcilg)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 
 void HELPER(pcistg)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
 
     qemu_mutex_lock_iothread();
     pcistg_service_call(cpu, r1, r2, GETPC());
@@ -723,7 +723,7 @@ void HELPER(pcistg)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 void HELPER(stpcifc)(CPUS390XState *env, uint32_t r1, uint64_t fiba,
                      uint32_t ar)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
 
     qemu_mutex_lock_iothread();
     stpcifc_service_call(cpu, r1, fiba, ar, GETPC());
@@ -745,7 +745,7 @@ void HELPER(sic)(CPUS390XState *env, uint64_t r1, uint64_t r3)
 
 void HELPER(rpcit)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
 
     qemu_mutex_lock_iothread();
     rpcit_service_call(cpu, r1, r2, GETPC());
@@ -755,7 +755,7 @@ void HELPER(rpcit)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 void HELPER(pcistb)(CPUS390XState *env, uint32_t r1, uint32_t r3,
                     uint64_t gaddr, uint32_t ar)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
 
     qemu_mutex_lock_iothread();
     pcistb_service_call(cpu, r1, r3, gaddr, ar, GETPC());
@@ -765,7 +765,7 @@ void HELPER(pcistb)(CPUS390XState *env, uint32_t r1, uint32_t r3,
 void HELPER(mpcifc)(CPUS390XState *env, uint32_t r1, uint64_t fiba,
                     uint32_t ar)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
 
     qemu_mutex_lock_iothread();
     mpcifc_service_call(cpu, r1, fiba, ar, GETPC());
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 145b62a7ef..9669bae393 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -58,12 +58,12 @@
 static void trigger_access_exception(CPUS390XState *env, uint32_t type,
                                      uint32_t ilen, uint64_t tec)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
 
     if (kvm_enabled()) {
         kvm_s390_access_exception(cpu, type, tec);
     } else {
-        CPUState *cs = CPU(cpu);
+        CPUState *cs = env_cpu(env);
         if (type != PGM_ADDRESSING) {
             stq_phys(cs->as, env->psa + offsetof(LowCore, trans_exc_code), tec);
         }
@@ -185,7 +185,7 @@ static int mmu_translate_segment(CPUS390XState *env, target_ulong vaddr,
                                  target_ulong *raddr, int *flags, int rw,
                                  bool exc)
 {
-    CPUState *cs = CPU(s390_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     uint64_t origin, offs, pt_entry;
 
     if (st_entry & SEGMENT_ENTRY_RO) {
@@ -214,7 +214,7 @@ static int mmu_translate_region(CPUS390XState *env, target_ulong vaddr,
                                 target_ulong *raddr, int *flags, int rw,
                                 bool exc)
 {
-    CPUState *cs = CPU(s390_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     uint64_t origin, offs, new_entry;
     const int pchks[4] = {
         PGM_SEGMENT_TRANS, PGM_REG_THIRD_TRANS,
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index c1f9245797..ea5f69d5d8 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -454,7 +454,7 @@ int handle_sigp(CPUS390XState *env, uint8_t order, uint64_t r1, uint64_t r3)
 {
     uint64_t *status_reg = &env->regs[r1];
     uint64_t param = (r1 % 2) ? env->regs[r1] : env->regs[r1 + 1];
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
     S390CPU *dst_cpu = NULL;
     int ret;
 
@@ -492,7 +492,7 @@ int s390_cpu_restart(S390CPU *cpu)
 
 void do_stop_interrupt(CPUS390XState *env)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
 
     if (s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu) == 0) {
         qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-- 
2.17.1


