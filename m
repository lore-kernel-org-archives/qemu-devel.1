Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC11C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06FE221744
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cAhr9Lg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FE221744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33684 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOrlQ-0005ZP-71
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 18:43:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrV0-0007di-RT
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrUz-0005SX-IY
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:46 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOrUz-0005SJ-BJ
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:45 -0400
Received: by mail-pf1-x442.google.com with SMTP id l132so2041176pfc.8
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 15:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=epdYlBTiLaV9VQx6jCDpGmNhfjLLlYzffabxUVX4RgQ=;
	b=cAhr9Lg+v2BVuh68BTLHS1TLe8IlJdh1TBMtrxB985BXS4VUn0TVAs/Pwp/8YL9izK
	r1J/YFSmdIDMlOUuWoqIJyBRaLitMtarkNDiBce5Ld+lhI7XxZJmb5G3E45oAVw6K+dG
	4oyIvNntKg67qxQg3kVutyyPrGbWawtgI9li22NNyA4A+73q1UrX8ztdxj2wkEP2/Ilc
	9ZVB9IXRptq1xyGHUn4XwEQJ0ddmKtNrpUfsvkePxAvMcPazEqQ1yCH83ivEsj8g7mrZ
	oos0/hAPvVbNR0/wp0/n2ObV5byRcKPTTidK4O1aY8JkY/HQ0iX2ZS04iP52D5rByVQ+
	euvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=epdYlBTiLaV9VQx6jCDpGmNhfjLLlYzffabxUVX4RgQ=;
	b=QsrjpbEbLFrt+Rm78cQFvLTQz74VV1qCTqWzhvUOnDoblzrT8piUCun+QNRniBLLoQ
	iD8faomEDMfSUIkojcfHZ/Wuuj5ECssIRjbsTCiHIZpIX3j8O5iUqfiirtFRSz72Yzu0
	0hx4XVqQCwTxmpSqzfOHuriCUqo2VeiqzSeMvzUly2+1WTJ3ABipsbh9gglnpgqdebhq
	qOD5NWWGH/ppZHF7AUOqNqgyY8w7cOi9rdMmwBuOkiHIUdY2wTnBNSHwJOLCm0L3dDB0
	Anz9JGEzFJ2i3gtHlnA0d2DNECiZfLaGy5oxMNcsolvnKKCSEvstziKZM4Izc+kX8fyI
	pt3w==
X-Gm-Message-State: APjAAAXuw9qGDGcKtS9bQ0SRiWR0kku3Y3sz/Ce0L2tSFfnaEq6ejlxF
	UO+4O0tsI4u/Hb3Wm/fDg7+GHZyY63g=
X-Google-Smtp-Source: APXvYqz6Zyw/vsikI8lE53+BFSZ2evJ1mHfQefuFFm7KK8GpyECv3xKCar/jx97AxZ+zzAhulF9x9w==
X-Received: by 2002:a62:ee05:: with SMTP id e5mr7210282pfi.117.1557440804035; 
	Thu, 09 May 2019 15:26:44 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m2sm4490521pfi.24.2019.05.09.15.26.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 15:26:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 15:26:12 -0700
Message-Id: <20190509222631.14271-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509222631.14271-1-richard.henderson@linaro.org>
References: <20190509222631.14271-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v3 08/27] target/m68k: Convert to
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
Cc: Laurent Vivier <laurent@vivier.eu>
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


