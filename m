Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13527C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C05232173B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAtV+oiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05232173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33504 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOra0-000318-Tp
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 18:31:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrUv-0007Xj-Vj
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrUu-0005Og-JS
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:41 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOrUu-0005OI-D1
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:40 -0400
Received: by mail-pf1-x442.google.com with SMTP id c6so2034953pfa.10
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=PI6csDpWdG6t7BSfq5z2Q2G3DWQrj5ohp4MLYzjDA0s=;
	b=QAtV+oiHuH571Lhxu80eQ4dRIKFTbHhoUfv7/ajK7NfDx24QyxTUbD2dyKAD9yogRm
	CM4ZRn7NKkbp7ekqG6Kifg5hmHg7F+M8BeHlrkzNuW8Nlt68ENyMN7UnlhK4Is1c478U
	x7lkHPEaHl71zSzyKnCqC79Tqsz2K2L4Aie3pykpQO8MyTLIta96P0+7GW42AztV/Cpw
	RNLPXzmWA68qphY7CBRdn7+MfZ9+8KuZXK3VRoKTDjhTbseiRvG/2ZPitCpVAq9OQKDV
	CcVTyNVtJ8sbGTJMTCQXurfcDGoxg8LNDIVrXfDYZDUR0fh6ME0gpodO5h+lZUnabdS3
	tc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=PI6csDpWdG6t7BSfq5z2Q2G3DWQrj5ohp4MLYzjDA0s=;
	b=KbfuiMN6knhXxqIWh27+IufIRiKiCN66/nIt69zL0xisjlwZnBSoQ0J7C/fAdoKDJr
	ypYQKyCzHtWV5uyLyccEBYLtY6tpt3zCfe0BSPwR6F0BoxXwLxqtJQvghssNz85L/60U
	yeXwXWJh+AOjqKVxyJ3NhPaJ7zXV8vVWuuh2+15xPc7xc3oWE1Sa9r9A2V2iTQ7bVdy1
	Q4fufKnpfR2FiTtGr0p6E84sWYeU4Z9i5FHREdqcPrTS5G3NIYEKhMflVwAqTCAetlNA
	QZuliAAsphYyGKAy8Afgqp06oeeZk7sOJdY1W/beOVZpVypR77jAFfdZB850a/XqIFB1
	BGGg==
X-Gm-Message-State: APjAAAUBlNhRbQ4aUOCaZPsEWAr5PFhp7SWPlniTrQmNLEGcYz+ntJ4/
	bl0ysaKcAHelZuiyxfY30ys/cdMbGBY=
X-Google-Smtp-Source: APXvYqxQNHo/Gp7cRZny7SUxjH5s0UPej4jL+ZxsBWf16kZjC33xd7JYdQ2kGb0E6ZUYX9gTp/tCSA==
X-Received: by 2002:a63:f843:: with SMTP id v3mr8949371pgj.69.1557440799216;
	Thu, 09 May 2019 15:26:39 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m2sm4490521pfi.24.2019.05.09.15.26.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 15:26:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 15:26:08 -0700
Message-Id: <20190509222631.14271-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509222631.14271-1-richard.henderson@linaro.org>
References: <20190509222631.14271-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v3 04/27] target/cris: Convert to
 CPUClass::tlb_fill
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove dumping of cpu state.  Remove logging of PC, as that
value is garbage until cpu_restore_state.

Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/cris/cpu.h       |  5 +--
 target/cris/cpu.c       |  5 ++-
 target/cris/helper.c    | 67 +++++++++++++++++++++++------------------
 target/cris/op_helper.c | 28 -----------------
 4 files changed, 42 insertions(+), 63 deletions(-)

diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 0fbe771639..857de79e24 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -281,8 +281,9 @@ static inline int cpu_mmu_index (CPUCRISState *env, bool ifetch)
 	return !!(env->pregs[PR_CCS] & U_FLAG);
 }
 
-int cris_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-                              int mmu_idx);
+bool cris_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr);
 
 /* Support function regs.  */
 #define SFR_RW_GC_CFG      0][0
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 75729bfdd5..4e5288ae80 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -269,9 +269,8 @@ static void cris_cpu_class_init(ObjectClass *oc, void *data)
     cc->set_pc = cris_cpu_set_pc;
     cc->gdb_read_register = cris_cpu_gdb_read_register;
     cc->gdb_write_register = cris_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = cris_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = cris_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->get_phys_page_debug = cris_cpu_get_phys_page_debug;
     dc->vmsd = &vmstate_cris_cpu;
 #endif
diff --git a/target/cris/helper.c b/target/cris/helper.c
index 3939603c73..69464837c8 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -24,6 +24,7 @@
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
+#include "exec/helper-proto.h"
 
 
 //#define CRIS_HELPER_DEBUG
@@ -53,15 +54,15 @@ void crisv10_cpu_do_interrupt(CPUState *cs)
     cris_cpu_do_interrupt(cs);
 }
 
-int cris_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                              int mmu_idx)
+bool cris_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
 {
     CRISCPU *cpu = CRIS_CPU(cs);
 
     cs->exception_index = 0xaa;
     cpu->env.pregs[PR_EDA] = address;
-    cpu_dump_state(cs, stderr, 0);
-    return 1;
+    cpu_loop_exit_restore(cs, retaddr);
 }
 
 #else /* !CONFIG_USER_ONLY */
@@ -76,33 +77,19 @@ static void cris_shift_ccs(CPUCRISState *env)
     env->pregs[PR_CCS] = ccs;
 }
 
-int cris_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                              int mmu_idx)
+bool cris_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
 {
     CRISCPU *cpu = CRIS_CPU(cs);
     CPUCRISState *env = &cpu->env;
     struct cris_mmu_result res;
     int prot, miss;
-    int r = -1;
     target_ulong phy;
 
-    qemu_log_mask(CPU_LOG_MMU, "%s addr=%" VADDR_PRIx " pc=%x rw=%x\n",
-            __func__, address, env->pc, rw);
     miss = cris_mmu_translate(&res, env, address & TARGET_PAGE_MASK,
-                              rw, mmu_idx, 0);
-    if (miss) {
-        if (cs->exception_index == EXCP_BUSFAULT) {
-            cpu_abort(cs,
-                      "CRIS: Illegal recursive bus fault."
-                      "addr=%" VADDR_PRIx " rw=%d\n",
-                      address, rw);
-        }
-
-        env->pregs[PR_EDA] = address;
-        cs->exception_index = EXCP_BUSFAULT;
-        env->fault_vector = res.bf_vec;
-        r = 1;
-    } else {
+                              access_type, mmu_idx, 0);
+    if (likely(!miss)) {
         /*
          * Mask off the cache selection bit. The ETRAX busses do not
          * see the top bit.
@@ -111,15 +98,35 @@ int cris_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
         prot = res.prot;
         tlb_set_page(cs, address & TARGET_PAGE_MASK, phy,
                      prot, mmu_idx, TARGET_PAGE_SIZE);
-        r = 0;
+        return true;
     }
-    if (r > 0) {
-        qemu_log_mask(CPU_LOG_MMU,
-                "%s returns %d irqreq=%x addr=%" VADDR_PRIx " phy=%x vec=%x"
-                " pc=%x\n", __func__, r, cs->interrupt_request, address,
-                res.phy, res.bf_vec, env->pc);
+
+    if (probe) {
+        return false;
     }
-    return r;
+
+    if (cs->exception_index == EXCP_BUSFAULT) {
+        cpu_abort(cs, "CRIS: Illegal recursive bus fault."
+                      "addr=%" VADDR_PRIx " access_type=%d\n",
+                      address, access_type);
+    }
+
+    env->pregs[PR_EDA] = address;
+    cs->exception_index = EXCP_BUSFAULT;
+    env->fault_vector = res.bf_vec;
+    if (retaddr) {
+        if (cpu_restore_state(cs, retaddr, true)) {
+            /* Evaluate flags after retranslation. */
+            helper_top_evaluate_flags(env);
+        }
+    }
+    cpu_loop_exit(cs);
+}
+
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    cris_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
 }
 
 void crisv10_cpu_do_interrupt(CPUState *cs)
diff --git a/target/cris/op_helper.c b/target/cris/op_helper.c
index 0ee3a3117b..26a395b413 100644
--- a/target/cris/op_helper.c
+++ b/target/cris/op_helper.c
@@ -37,34 +37,6 @@
 #define D_LOG(...) do { } while (0)
 #endif
 
-#if !defined(CONFIG_USER_ONLY)
-/* Try to fill the TLB and return an exception if error. If retaddr is
-   NULL, it means that the function was called in C code (i.e. not
-   from generated code or from helper.c) */
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    CRISCPU *cpu = CRIS_CPU(cs);
-    CPUCRISState *env = &cpu->env;
-    int ret;
-
-    D_LOG("%s pc=%x tpc=%x ra=%p\n", __func__,
-          env->pc, env->pregs[PR_EDA], (void *)retaddr);
-    ret = cris_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (unlikely(ret)) {
-        if (retaddr) {
-            /* now we have a real cpu fault */
-            if (cpu_restore_state(cs, retaddr, true)) {
-                /* Evaluate flags after retranslation. */
-                helper_top_evaluate_flags(env);
-            }
-        }
-        cpu_loop_exit(cs);
-    }
-}
-
-#endif
-
 void helper_raise_exception(CPUCRISState *env, uint32_t index)
 {
     CPUState *cs = CPU(cris_env_get_cpu(env));
-- 
2.17.1


