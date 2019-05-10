Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB33BC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7202070D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QW0okPle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7202070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45172 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7Xb-0004KB-MX
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:34:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jb-0007a7-LO
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7JW-0008Qr-GT
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:03 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7JW-0008QD-AH
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:19:58 -0400
Received: by mail-pl1-x643.google.com with SMTP id g9so2996119plm.6
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=epdYlBTiLaV9VQx6jCDpGmNhfjLLlYzffabxUVX4RgQ=;
	b=QW0okPleQujLTUlxcqDQUK0x+NfYr1wLiEpXpUc95jvPzeKAmnCfFWeEiGzJ17qXO9
	XkivkzLWsVeloBcgsnow1dBVhpJOiF69V5+QJSRs1ZLeDMZYDJKUhvx8Gsw4bxlu0McG
	5xRplWCO+S2AL1ehbKIYM2ge/R7oSkPPdldZ0XkZ74+IPt2GWRg4m4YEghfH8JqqovVx
	lRUCOpCzWVPuMNpb82P9J+Rv/dtKRQDnQwTwd/566O1wkUAt6N4NPOJIsMToAkiD+YGI
	Mpyb+BQeHv4GLRaYiuJuHt6vOlGOLtRFczmnpnj7yGrQT+TQT+r0T9qE6jrjjLEUjYIQ
	EFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=epdYlBTiLaV9VQx6jCDpGmNhfjLLlYzffabxUVX4RgQ=;
	b=UVoHpM1iFrnC0HJ3DVk3qUUcLhDdVz/cg7Uq9WW8MCutYnHcCLkT7whhiBXFHjEgUf
	A33lv0vh79stk/vt0vDamXMiyAIK6OdKdNGNEBiBQyVLyGy72TcB5I9Zihx9uv0fldog
	rGuVwiiKx18CEXBfCdQCvBMYNuR9qZOXGdENav2fomSL+FFzq6fnbREfVEhaZRSmNMY0
	ZS483CFnBRUH3ifTgeK6TdmH5XJZGe0rnTrXsfcBYLkHjlXFp++3tsnr55YPT+WulQFF
	onjI2ffWUFyJpDnXG7EKKfltOZ8YxPdGuuH2mt1CeJTsVBjDROWkPWDR9w4Rj1sOnF1H
	Sr3g==
X-Gm-Message-State: APjAAAWGOE+vnIpYpmEyB5wf/JjeTrYw4YAxZP5bnmaQ9XYxTOwBjYpZ
	ZbeljjPEc+uAKjfakri2aFYyFC9J+q0=
X-Google-Smtp-Source: APXvYqwJEQayE/urDGFQ3krsMl0yjOXhIVIzbFcEoUVaidbOPXR0bgH8bVjclRdi+vn/ndWR+Fldgg==
X-Received: by 2002:a17:902:f24:: with SMTP id
	33mr13743282ply.33.1557501596967; 
	Fri, 10 May 2019 08:19:56 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.19.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:19:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:25 -0700
Message-Id: <20190510151944.22981-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
References: <20190510151944.22981-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PULL 08/27] target/m68k: Convert to CPUClass::tlb_fill
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
Cc: peter.maydell@linaro.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.h       |  5 ++-
 target/m68k/cpu.c       |  2 +-
 target/m68k/helper.c    | 87 ++++++++++++++++++++++-------------------
 target/m68k/op_helper.c | 15 -------
 4 files changed, 50 insertions(+), 59 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index ad41608341..683d3e2f79 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -542,8 +542,9 @@ static inline int cpu_mmu_index (CPUM68KState *env, bool ifetch)
     return (env->sr & SR_S) == 0 ? 1 : 0;
 }
 
-int m68k_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-                              int mmu_idx);
+bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr);
 void m68k_cpu_unassigned_access(CPUState *cs, hwaddr addr,
                                 bool is_write, bool is_exec, int is_asi,
                                 unsigned size);
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 582e3a73b3..6f441bc973 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -269,7 +269,7 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
     cc->set_pc = m68k_cpu_set_pc;
     cc->gdb_read_register = m68k_cpu_gdb_read_register;
     cc->gdb_write_register = m68k_cpu_gdb_write_register;
-    cc->handle_mmu_fault = m68k_cpu_handle_mmu_fault;
+    cc->tlb_fill = m68k_cpu_tlb_fill;
 #if defined(CONFIG_SOFTMMU)
     cc->do_unassigned_access = m68k_cpu_unassigned_access;
     cc->get_phys_page_debug = m68k_cpu_get_phys_page_debug;
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index d958a34959..862f955f7b 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -353,20 +353,7 @@ void m68k_switch_sp(CPUM68KState *env)
     env->current_sp = new_sp;
 }
 
-#if defined(CONFIG_USER_ONLY)
-
-int m68k_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                              int mmu_idx)
-{
-    M68kCPU *cpu = M68K_CPU(cs);
-
-    cs->exception_index = EXCP_ACCESS;
-    cpu->env.mmu.ar = address;
-    return 1;
-}
-
-#else
-
+#if !defined(CONFIG_USER_ONLY)
 /* MMU: 68040 only */
 
 static void print_address_zone(uint32_t logical, uint32_t physical,
@@ -795,11 +782,36 @@ hwaddr m68k_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return phys_addr;
 }
 
-int m68k_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                              int mmu_idx)
+/*
+ * Notify CPU of a pending interrupt.  Prioritization and vectoring should
+ * be handled by the interrupt controller.  Real hardware only requests
+ * the vector when the interrupt is acknowledged by the CPU.  For
+ * simplicity we calculate it when the interrupt is signalled.
+ */
+void m68k_set_irq_level(M68kCPU *cpu, int level, uint8_t vector)
+{
+    CPUState *cs = CPU(cpu);
+    CPUM68KState *env = &cpu->env;
+
+    env->pending_level = level;
+    env->pending_vector = vector;
+    if (level) {
+        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+    } else {
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+    }
+}
+
+#endif
+
+bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType qemu_access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
 {
     M68kCPU *cpu = M68K_CPU(cs);
     CPUM68KState *env = &cpu->env;
+
+#ifndef CONFIG_USER_ONLY
     hwaddr physical;
     int prot;
     int access_type;
@@ -812,32 +824,35 @@ int m68k_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
                      address & TARGET_PAGE_MASK,
                      PAGE_READ | PAGE_WRITE | PAGE_EXEC,
                      mmu_idx, TARGET_PAGE_SIZE);
-        return 0;
+        return true;
     }
 
-    if (rw == 2) {
+    if (qemu_access_type == MMU_INST_FETCH) {
         access_type = ACCESS_CODE;
-        rw = 0;
     } else {
         access_type = ACCESS_DATA;
-        if (rw) {
+        if (qemu_access_type == MMU_DATA_STORE) {
             access_type |= ACCESS_STORE;
         }
     }
-
     if (mmu_idx != MMU_USER_IDX) {
         access_type |= ACCESS_SUPER;
     }
 
     ret = get_physical_address(&cpu->env, &physical, &prot,
                                address, access_type, &page_size);
-    if (ret == 0) {
+    if (likely(ret == 0)) {
         address &= TARGET_PAGE_MASK;
         physical += address & (page_size - 1);
         tlb_set_page(cs, address, physical,
                      prot, mmu_idx, TARGET_PAGE_SIZE);
-        return 0;
+        return true;
     }
+
+    if (probe) {
+        return false;
+    }
+
     /* page fault */
     env->mmu.ssw = M68K_ATC_040;
     switch (size) {
@@ -862,29 +877,19 @@ int m68k_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
     if (!(access_type & ACCESS_STORE)) {
         env->mmu.ssw |= M68K_RW_040;
     }
-    env->mmu.ar = address;
+#endif
+
     cs->exception_index = EXCP_ACCESS;
-    return 1;
+    env->mmu.ar = address;
+    cpu_loop_exit_restore(cs, retaddr);
 }
 
-/* Notify CPU of a pending interrupt.  Prioritization and vectoring should
-   be handled by the interrupt controller.  Real hardware only requests
-   the vector when the interrupt is acknowledged by the CPU.  For
-   simplicitly we calculate it when the interrupt is signalled.  */
-void m68k_set_irq_level(M68kCPU *cpu, int level, uint8_t vector)
+#ifndef CONFIG_USER_ONLY
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
-    CPUState *cs = CPU(cpu);
-    CPUM68KState *env = &cpu->env;
-
-    env->pending_level = level;
-    env->pending_vector = vector;
-    if (level) {
-        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
-    } else {
-        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
-    }
+    m68k_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
 }
-
 #endif
 
 uint32_t HELPER(bitrev)(uint32_t x)
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 76f439985a..d421614727 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -36,21 +36,6 @@ static inline void do_interrupt_m68k_hardirq(CPUM68KState *env)
 
 #else
 
-/* Try to fill the TLB and return an exception if error. If retaddr is
-   NULL, it means that the function was called in C code (i.e. not
-   from generated code or from helper.c) */
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    int ret;
-
-    ret = m68k_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (unlikely(ret)) {
-        /* now we have a real cpu fault */
-        cpu_loop_exit_restore(cs, retaddr);
-    }
-}
-
 static void cf_rte(CPUM68KState *env)
 {
     uint32_t sp;
-- 
2.17.1


