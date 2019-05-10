Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B04C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4DA2053B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2FIHoUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4DA2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45058 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7P9-0004NM-IB
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:25:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7JS-0007Qm-Qe
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7JR-0008HQ-DL
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:19:54 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7JR-0008FO-6W
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:19:53 -0400
Received: by mail-pl1-x642.google.com with SMTP id d21so3002693plr.3
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=PI6csDpWdG6t7BSfq5z2Q2G3DWQrj5ohp4MLYzjDA0s=;
	b=X2FIHoUjkw7zfz+AnL3JyxdcsX6GMlDetKkTRm7XuOExyDl0igsfiy+OGRdP4rMAQv
	FQnUB8RMpr5vr5590bFsw7BbtQzR2fKC+XYoj6mFfhkBBIY87liZ9eZPXv/ebx4CqEBS
	t8KTTjP2imx6MoqboDFayszVhnVmln8Vid47nM/P6UBt5Jw4PZlPMVVZ4eQBaw2TWEE7
	9hwC2ZFyWmQcIXkjyXlbXd3T+z/jCkuzmngi2vd57jVLEfrkc9C3O2I54JifZBdoIe7X
	kDHkQcoHAXdOiucwBifnbHqfUza0qOu1eVqVQSqe2KQ+gzWtSIWDt98xvRXsPq7jxiAX
	Lm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=PI6csDpWdG6t7BSfq5z2Q2G3DWQrj5ohp4MLYzjDA0s=;
	b=co8NhdqCnCXaGLMa6OPNJoS3MIXz5udUZ9nMzXS1TgvvPdj11OFKEC/F79orJ5I6gM
	Bx26I2gAlAWX60PFQvGjF8fHaNocrLcDlpsFdJQaNSWwni93iUVscVRJFsloP6OdQ9R9
	myEADcjSToVxDcJ1CNxCQFstoSeQ0nzz8ZFg4iWAitC4J0mUzh1dmGgHPsdh7focMf/3
	z4wBuH51fdpwmi8+vKVIg4tHtbSmMzuS1MELwwKm/Rx2TNrumYf2IHQQ756/SpE/522C
	PvLOmIDR8oI1cAsVIcdmx9rCdvJ8SWw3NQHkk22WbyByUiMOIf5YsGqP7uxX2HonyJ3p
	ZlBA==
X-Gm-Message-State: APjAAAW5+NZzFxLdICgTDqFr+e//b1ewhtZCn4vL7hOi1inbUdodzoPF
	M6ln7F9oJSYiYKzGW5zWUHlMNqOGK/k=
X-Google-Smtp-Source: APXvYqwXiqXneT+c+lisy0Huzj68VA04fpohjXunMMGN5r8DXwgEdTaAZxNXDkwmXDbDzfI970J79w==
X-Received: by 2002:a17:902:12d:: with SMTP id 42mr7423220plb.4.1557501591865; 
	Fri, 10 May 2019 08:19:51 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.19.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:19:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:21 -0700
Message-Id: <20190510151944.22981-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
References: <20190510151944.22981-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PULL 04/27] target/cris: Convert to CPUClass::tlb_fill
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
Cc: peter.maydell@linaro.org, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
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


