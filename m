Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF58BC28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC4C2067C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LnxoRJ+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC4C2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39812 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haA7G-0001nS-9l
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53230)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eA-0006oJ-Rr
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9e7-0001pb-U3
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:54 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:44624)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9e7-0001nx-Jn
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:51 -0400
Received: by mail-pg1-x534.google.com with SMTP id n2so4138864pgp.11
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tNvnNCk8bkIZbvgmRkGWwNTzuMHabY9VuHtIvR77ero=;
 b=LnxoRJ+FojABJVgJG1ktBebo4qBjgbz8I9JUE/zM4zNCFYVQBWGlGNXilS/C+PeVMC
 dpvfqTSR/2Fjsjz3+ZG1wzmbf3Z41GKaB9KRwN8ehP1qeSY5N8zBGESZI1QwjjZVSBFD
 adJoy1V5VIPEH4RkGCnosAPp7H1a7gtjoaSwyt/LqqGlN5nXaMY9fn3eqzJHu6D3Nj5E
 UuuqomxL1W7dmA25KalrTPfoDX3Xht0lQFWPFPMuSjP6XzG5grtx3r2qxbSIZVVHfU6g
 t4D3WcXKK6j7DsgNFY95rOnBgb49Y/zILMNoLVPSaidrDRFHge2f1OU/rDj0dD0lfZTY
 F5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tNvnNCk8bkIZbvgmRkGWwNTzuMHabY9VuHtIvR77ero=;
 b=Y2XG/dAvMkdpytKMdCdAv29lEwcknuqvmgKqrILvBVakGXIT5aMzl5pDVfrJKA0fN+
 ofk2sSeqFnrxqJ/EIEkutLJveCmIAzhX+mq317cFI+CwteTUAklWgnd6QjoaCJKPQymm
 SnYZmcLPAVZUEsBvMCwzExppFDQu4pRz7nZgN4goaZUpqApbblljTb3g2NVN7EHGC43h
 S1Lc4HNQcTVUGiX/ufrINnN0RtUo+4n/FgUuyWj0QJRTXO+oR+NYn3yG3R6EmeNC8f9e
 76Uva73+0wcMLG0oPg1I3vj0fHwfBzIZ008RlBepMCxqe0YvRUzNEQcc2zxeJe4KHNeG
 ReSQ==
X-Gm-Message-State: APjAAAUsjVElr539lQktUMkKvLj6Ap4+8uJVvszxvzIcu6Xiki70KtXN
 EOfiKZkmgInq3GDgA98ujAEbF5WN/U4=
X-Google-Smtp-Source: APXvYqxD2u5z1qCx4kjXaVpTXlGYKFuRy6oneMnaiZu1tOVpX76DMTAG2a0+Oj17eIamI5KHiXDDkg==
X-Received: by 2002:a65:41c6:: with SMTP id b6mr13296551pgq.399.1560132169976; 
 Sun, 09 Jun 2019 19:02:49 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.02.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:02:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:02:03 -0700
Message-Id: <20190610020218.9228-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::534
Subject: [Qemu-devel] [PULL 24/39] target/s390x: Use env_cpu, env_archcpu
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cleanup in the boilerplate that each target must define.
Replace s390_env_get_cpu with env_archcpu.  The combination
CPU(s390_env_get_cpu) should have used ENV_GET_CPU to begin;
use env_cpu now.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.h          |  5 ----
 linux-user/s390x/cpu_loop.c |  2 +-
 target/s390x/cc_helper.c    |  5 ++--
 target/s390x/diag.c         |  2 +-
 target/s390x/excp_helper.c  |  8 +++---
 target/s390x/fpu_helper.c   |  4 +--
 target/s390x/helper.c       |  7 +++---
 target/s390x/int_helper.c   |  3 +--
 target/s390x/interrupt.c    |  6 ++---
 target/s390x/mem_helper.c   | 28 ++++++++-------------
 target/s390x/misc_helper.c  | 50 ++++++++++++++++++-------------------
 target/s390x/mmu_helper.c   |  8 +++---
 target/s390x/sigp.c         |  4 +--
 13 files changed, 57 insertions(+), 75 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 56767f289d..d18b279d87 100644
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
index a00294f183..cf68792733 100644
--- a/target/s390x/cc_helper.c
+++ b/target/s390x/cc_helper.c
@@ -419,7 +419,6 @@ static uint32_t cc_calc_vc(uint64_t low, uint64_t high)
 static uint32_t do_calc_cc(CPUS390XState *env, uint32_t cc_op,
                                   uint64_t src, uint64_t dst, uint64_t vr)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
     uint32_t r = 0;
 
     switch (cc_op) {
@@ -543,7 +542,7 @@ static uint32_t do_calc_cc(CPUS390XState *env, uint32_t cc_op,
         break;
 
     default:
-        cpu_abort(CPU(cpu), "Unknown CC operation: %s\n", cc_name(cc_op));
+        cpu_abort(env_cpu(env), "Unknown CC operation: %s\n", cc_name(cc_op));
     }
 
     HELPER_LOG("%s: %15s 0x%016lx 0x%016lx 0x%016lx = %d\n", __func__,
@@ -567,7 +566,7 @@ uint32_t HELPER(calc_cc)(CPUS390XState *env, uint32_t cc_op, uint64_t src,
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
index f21bcf79ae..202456cdc5 100644
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
 
@@ -68,7 +68,7 @@ void QEMU_NORETURN tcg_s390_vector_exception(CPUS390XState *env, uint32_t vxc,
     g_assert(vxc <= 0xff);
 #if !defined(CONFIG_USER_ONLY)
     /* Always store the VXC into the lowcore, without AFP it is undefined */
-    stl_phys(CPU(s390_env_get_cpu(env))->as,
+    stl_phys(env_cpu(env)->as,
              env->psa + offsetof(LowCore, data_exc_code), vxc);
 #endif
 
@@ -297,7 +297,7 @@ static void do_svc_interrupt(CPUS390XState *env)
 static void do_ext_interrupt(CPUS390XState *env)
 {
     QEMUS390FLICState *flic = QEMU_S390_FLIC(s390_get_flic());
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
     uint64_t mask, addr;
     uint16_t cpu_addr;
     LowCore *lowcore;
diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index d2c17ed942..5faf973c6c 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -114,8 +114,6 @@ static void handle_exceptions(CPUS390XState *env, bool XxC, uintptr_t retaddr)
 
 int float_comp_to_cc(CPUS390XState *env, int float_compare)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
-
     switch (float_compare) {
     case float_relation_equal:
         return 0;
@@ -126,7 +124,7 @@ int float_comp_to_cc(CPUS390XState *env, int float_compare)
     case float_relation_unordered:
         return 3;
     default:
-        cpu_abort(CPU(cpu), "unknown return value for float compare\n");
+        cpu_abort(env_cpu(env), "unknown return value for float compare\n");
     }
 }
 
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index a69e5abf5f..52a11daeae 100644
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
index 4a0161602f..29d9eaa5b7 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1617,7 +1617,6 @@ uint32_t HELPER(csst_parallel)(CPUS390XState *env, uint32_t r3, uint64_t a1,
 void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 {
     uintptr_t ra = GETPC();
-    S390CPU *cpu = s390_env_get_cpu(env);
     bool PERchanged = false;
     uint64_t src = a2;
     uint32_t i;
@@ -1642,16 +1641,15 @@ void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
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
@@ -1675,10 +1673,10 @@ void HELPER(lctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     }
 
     if (PERchanged && env->psw.mask & PSW_MASK_PER) {
-        s390_cpu_recompute_watchpoints(CPU(cpu));
+        s390_cpu_recompute_watchpoints(env_cpu(env));
     }
 
-    tlb_flush(CPU(cpu));
+    tlb_flush(env_cpu(env));
 }
 
 void HELPER(stctg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
@@ -1737,8 +1735,8 @@ uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
 
 uint32_t HELPER(tprot)(CPUS390XState *env, uint64_t a1, uint64_t a2)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    S390CPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
 
     /*
      * TODO: we currently don't handle all access protection types
@@ -1906,7 +1904,7 @@ uint32_t HELPER(mvcp)(CPUS390XState *env, uint64_t l, uint64_t a1, uint64_t a2)
 
 void HELPER(idte)(CPUS390XState *env, uint64_t r1, uint64_t r2, uint32_t m4)
 {
-    CPUState *cs = CPU(s390_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     const uintptr_t ra = GETPC();
     uint64_t table, entry, raddr;
     uint16_t entries, i, index = 0;
@@ -1958,7 +1956,7 @@ void HELPER(idte)(CPUS390XState *env, uint64_t r1, uint64_t r2, uint32_t m4)
 void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr,
                   uint32_t m4)
 {
-    CPUState *cs = CPU(s390_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     const uintptr_t ra = GETPC();
     uint64_t page = vaddr & TARGET_PAGE_MASK;
     uint64_t pte_addr, pte;
@@ -1998,17 +1996,13 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr,
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
@@ -2052,7 +2046,7 @@ void HELPER(sturg)(CPUS390XState *env, uint64_t addr, uint64_t v1)
 /* load real address */
 uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
 {
-    CPUState *cs = CPU(s390_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     uint32_t cc = 0;
     uint64_t asc = env->psw.mask & PSW_MASK_ASC;
     uint64_t ret;
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 10aa617cf9..7530dcb8f3 100644
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
@@ -702,7 +702,7 @@ uint32_t HELPER(stfle)(CPUS390XState *env, uint64_t addr)
  */
 void HELPER(clp)(CPUS390XState *env, uint32_t r2)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
 
     qemu_mutex_lock_iothread();
     clp_service_call(cpu, r2, GETPC());
@@ -711,7 +711,7 @@ void HELPER(clp)(CPUS390XState *env, uint32_t r2)
 
 void HELPER(pcilg)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
 
     qemu_mutex_lock_iothread();
     pcilg_service_call(cpu, r1, r2, GETPC());
@@ -720,7 +720,7 @@ void HELPER(pcilg)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 
 void HELPER(pcistg)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
 
     qemu_mutex_lock_iothread();
     pcistg_service_call(cpu, r1, r2, GETPC());
@@ -730,7 +730,7 @@ void HELPER(pcistg)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 void HELPER(stpcifc)(CPUS390XState *env, uint32_t r1, uint64_t fiba,
                      uint32_t ar)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
 
     qemu_mutex_lock_iothread();
     stpcifc_service_call(cpu, r1, fiba, ar, GETPC());
@@ -752,7 +752,7 @@ void HELPER(sic)(CPUS390XState *env, uint64_t r1, uint64_t r3)
 
 void HELPER(rpcit)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
 
     qemu_mutex_lock_iothread();
     rpcit_service_call(cpu, r1, r2, GETPC());
@@ -762,7 +762,7 @@ void HELPER(rpcit)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 void HELPER(pcistb)(CPUS390XState *env, uint32_t r1, uint32_t r3,
                     uint64_t gaddr, uint32_t ar)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *cpu = env_archcpu(env);
 
     qemu_mutex_lock_iothread();
     pcistb_service_call(cpu, r1, r3, gaddr, ar, GETPC());
@@ -772,7 +772,7 @@ void HELPER(pcistb)(CPUS390XState *env, uint32_t r1, uint32_t r3,
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


