Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E3CC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B1EC2175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWSNiyZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1EC2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45228 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7ak-0007x6-Ej
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:37:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jg-0007es-MO
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jd-0008W8-To
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:08 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:47091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7Jd-0008VR-Je
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:05 -0400
Received: by mail-pl1-x643.google.com with SMTP id bi2so2971334plb.13
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=HbqwBnUY1nf/U3hx51h7fAODfIBTrHkKQ8MmHxK9GaE=;
	b=mWSNiyZ1b2LBHN+cszDGxMxoP/pGqYFdmgqWjJ3UqDkORQe6BA2Te4QOKBBtnRh4wC
	yaL7nXaswXhFn+GeNXVQEZaOpWFmTCLw7Zig1/D+lsKNt9nId7gO4kYX81jPyrfe04Mr
	FaqgiBq5Rsc8u5NnNpuIb5tjpOMDhHzNS7y2kZHkPvrpNNUpmRW2phkpgZAq50R9/Wj9
	aYdPVyuT5/9uOE7QTMCJ9ToYj7sil1ifECEc6mSCv3sDA6eiY+NSuAVZNikME6OLdTOA
	qDPTRspxQr0XbYk+fGUHygTbvv9h/yNQyIpVYUmedI/P5yVufxDROyIST9rKecE09eOo
	oZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=HbqwBnUY1nf/U3hx51h7fAODfIBTrHkKQ8MmHxK9GaE=;
	b=gnTOL1XV506BGK6CXAdXcbSt948Vgqr+FDk+aVawU/5qw5ejV8A56+by3d0PI6flwx
	d0T2zxPdBlG+bCLKdZetQ/MpdIPiBMb9E9ZetB2PiV1abq4jBIG/NdoEk4g5YG3Vn6+V
	T9EgfctnM75cfSEFCOr5Q9Y4LnbMQ6Vyz5DQQ6cZUwukYnmnsmt75pHyOgeDcxAxURZe
	hux3kUKLAK2iAqEI6RHirD/S0vk+zZ9XVN9/gN1r8EoHSeRgOKYpD3pacK089y2dW5by
	AspwMoqLPtt8/HYwUOCH+73kLG5Yt06pH9ysmaQoa2JBrtv7PVzyWABc1oaVi9hIzGHa
	N+LA==
X-Gm-Message-State: APjAAAWagOebXRWQYSH5tHlBn1F/Ij5r3ziiEtQ1xSWfNQgeuVyfX2na
	ggkS7L4yPKyvnNChjRvbRh3HGC5IURw=
X-Google-Smtp-Source: APXvYqz96ThR1F3IZlAJ7bHmh3i4GLz6TvJZBrlk/BArNloM+f7y5s8AnXSRjSAkvkGtwoMQ9KTp6A==
X-Received: by 2002:a17:902:7892:: with SMTP id
	q18mr13779407pll.163.1557501604387; 
	Fri, 10 May 2019 08:20:04 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.20.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:20:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:31 -0700
Message-Id: <20190510151944.22981-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
References: <20190510151944.22981-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PULL 14/27] target/nios2: Convert to
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
Cc: Marek Vasut <marex@denx.de>, peter.maydell@linaro.org,
	Chris Wulff <crwulff@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the leftover debugging cpu_dump_state.

Cc: Chris Wulff <crwulff@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/nios2/cpu.h    |   5 +-
 target/nios2/cpu.c    |   5 +-
 target/nios2/helper.c | 176 +++++++++++++++++++++---------------------
 target/nios2/mmu.c    |  12 ---
 4 files changed, 91 insertions(+), 107 deletions(-)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 881e7d58c9..60a916b2e5 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -252,8 +252,9 @@ static inline int cpu_mmu_index(CPUNios2State *env, bool ifetch)
                                                   MMU_SUPERVISOR_IDX;
 }
 
-int nios2_cpu_handle_mmu_fault(CPUState *env, vaddr address, int size,
-                               int rw, int mmu_idx);
+bool nios2_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr);
 
 static inline int cpu_interrupts_enabled(CPUNios2State *env)
 {
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index fbfaa2ce26..186af4913d 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -200,9 +200,8 @@ static void nios2_cpu_class_init(ObjectClass *oc, void *data)
     cc->dump_state = nios2_cpu_dump_state;
     cc->set_pc = nios2_cpu_set_pc;
     cc->disas_set_info = nios2_cpu_disas_set_info;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = nios2_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = nios2_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->do_unaligned_access = nios2_cpu_do_unaligned_access;
     cc->get_phys_page_debug = nios2_cpu_get_phys_page_debug;
 #endif
diff --git a/target/nios2/helper.c b/target/nios2/helper.c
index e01fc1ff3e..eb2eed7ad3 100644
--- a/target/nios2/helper.c
+++ b/target/nios2/helper.c
@@ -38,15 +38,12 @@ void nios2_cpu_do_interrupt(CPUState *cs)
     env->regs[R_EA] = env->regs[R_PC] + 4;
 }
 
-int nios2_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-                               int rw, int mmu_idx)
+bool nios2_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr)
 {
     cs->exception_index = 0xaa;
-    /* Page 0x1000 is kuser helper */
-    if (address < 0x1000 || address >= 0x2000) {
-        cpu_dump_state(cs, stderr, 0);
-    }
-    return 1;
+    cpu_loop_exit_restore(cs, retaddr);
 }
 
 #else /* !CONFIG_USER_ONLY */
@@ -203,89 +200,6 @@ void nios2_cpu_do_interrupt(CPUState *cs)
     }
 }
 
-static int cpu_nios2_handle_virtual_page(
-    CPUState *cs, target_ulong address, int rw, int mmu_idx)
-{
-    Nios2CPU *cpu = NIOS2_CPU(cs);
-    CPUNios2State *env = &cpu->env;
-    target_ulong vaddr, paddr;
-    Nios2MMULookup lu;
-    unsigned int hit;
-    hit = mmu_translate(env, &lu, address, rw, mmu_idx);
-    if (hit) {
-        vaddr = address & TARGET_PAGE_MASK;
-        paddr = lu.paddr + vaddr - lu.vaddr;
-
-        if (((rw == 0) && (lu.prot & PAGE_READ)) ||
-            ((rw == 1) && (lu.prot & PAGE_WRITE)) ||
-            ((rw == 2) && (lu.prot & PAGE_EXEC))) {
-
-            tlb_set_page(cs, vaddr, paddr, lu.prot,
-                         mmu_idx, TARGET_PAGE_SIZE);
-            return 0;
-        } else {
-            /* Permission violation */
-            cs->exception_index = (rw == 0) ? EXCP_TLBR :
-                                               ((rw == 1) ? EXCP_TLBW :
-                                                            EXCP_TLBX);
-        }
-    } else {
-        cs->exception_index = EXCP_TLBD;
-    }
-
-    if (rw == 2) {
-        env->regs[CR_TLBMISC] &= ~CR_TLBMISC_D;
-    } else {
-        env->regs[CR_TLBMISC] |= CR_TLBMISC_D;
-    }
-    env->regs[CR_PTEADDR] &= CR_PTEADDR_PTBASE_MASK;
-    env->regs[CR_PTEADDR] |= (address >> 10) & CR_PTEADDR_VPN_MASK;
-    env->mmu.pteaddr_wr = env->regs[CR_PTEADDR];
-    env->regs[CR_BADADDR] = address;
-    return 1;
-}
-
-int nios2_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-                               int rw, int mmu_idx)
-{
-    Nios2CPU *cpu = NIOS2_CPU(cs);
-    CPUNios2State *env = &cpu->env;
-
-    if (cpu->mmu_present) {
-        if (MMU_SUPERVISOR_IDX == mmu_idx) {
-            if (address >= 0xC0000000) {
-                /* Kernel physical page - TLB bypassed */
-                address &= TARGET_PAGE_MASK;
-                tlb_set_page(cs, address, address, PAGE_BITS,
-                             mmu_idx, TARGET_PAGE_SIZE);
-            } else if (address >= 0x80000000) {
-                /* Kernel virtual page */
-                return cpu_nios2_handle_virtual_page(cs, address, rw, mmu_idx);
-            } else {
-                /* User virtual page */
-                return cpu_nios2_handle_virtual_page(cs, address, rw, mmu_idx);
-            }
-        } else {
-            if (address >= 0x80000000) {
-                /* Illegal access from user mode */
-                cs->exception_index = EXCP_SUPERA;
-                env->regs[CR_BADADDR] = address;
-                return 1;
-            } else {
-                /* User virtual page */
-                return cpu_nios2_handle_virtual_page(cs, address, rw, mmu_idx);
-            }
-        }
-    } else {
-        /* No MMU */
-        address &= TARGET_PAGE_MASK;
-        tlb_set_page(cs, address, address, PAGE_BITS,
-                     mmu_idx, TARGET_PAGE_SIZE);
-    }
-
-    return 0;
-}
-
 hwaddr nios2_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     Nios2CPU *cpu = NIOS2_CPU(cs);
@@ -321,4 +235,86 @@ void nios2_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     env->regs[CR_EXCEPTION] = EXCP_UNALIGN << 2;
     helper_raise_exception(env, EXCP_UNALIGN);
 }
+
+bool nios2_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr)
+{
+    Nios2CPU *cpu = NIOS2_CPU(cs);
+    CPUNios2State *env = &cpu->env;
+    unsigned int excp = EXCP_TLBD;
+    target_ulong vaddr, paddr;
+    Nios2MMULookup lu;
+    unsigned int hit;
+
+    if (!cpu->mmu_present) {
+        /* No MMU */
+        address &= TARGET_PAGE_MASK;
+        tlb_set_page(cs, address, address, PAGE_BITS,
+                     mmu_idx, TARGET_PAGE_SIZE);
+        return true;
+    }
+
+    if (MMU_SUPERVISOR_IDX == mmu_idx) {
+        if (address >= 0xC0000000) {
+            /* Kernel physical page - TLB bypassed */
+            address &= TARGET_PAGE_MASK;
+            tlb_set_page(cs, address, address, PAGE_BITS,
+                         mmu_idx, TARGET_PAGE_SIZE);
+            return true;
+        }
+    } else {
+        if (address >= 0x80000000) {
+            /* Illegal access from user mode */
+            if (probe) {
+                return false;
+            }
+            cs->exception_index = EXCP_SUPERA;
+            env->regs[CR_BADADDR] = address;
+            cpu_loop_exit_restore(cs, retaddr);
+        }
+    }
+
+    /* Virtual page.  */
+    hit = mmu_translate(env, &lu, address, access_type, mmu_idx);
+    if (hit) {
+        vaddr = address & TARGET_PAGE_MASK;
+        paddr = lu.paddr + vaddr - lu.vaddr;
+
+        if (((access_type == MMU_DATA_LOAD) && (lu.prot & PAGE_READ)) ||
+            ((access_type == MMU_DATA_STORE) && (lu.prot & PAGE_WRITE)) ||
+            ((access_type == MMU_INST_FETCH) && (lu.prot & PAGE_EXEC))) {
+            tlb_set_page(cs, vaddr, paddr, lu.prot,
+                         mmu_idx, TARGET_PAGE_SIZE);
+            return true;
+        }
+
+        /* Permission violation */
+        excp = (access_type == MMU_DATA_LOAD ? EXCP_TLBR :
+                access_type == MMU_DATA_STORE ? EXCP_TLBW : EXCP_TLBX);
+    }
+
+    if (probe) {
+        return false;
+    }
+
+    if (access_type == MMU_INST_FETCH) {
+        env->regs[CR_TLBMISC] &= ~CR_TLBMISC_D;
+    } else {
+        env->regs[CR_TLBMISC] |= CR_TLBMISC_D;
+    }
+    env->regs[CR_PTEADDR] &= CR_PTEADDR_PTBASE_MASK;
+    env->regs[CR_PTEADDR] |= (address >> 10) & CR_PTEADDR_VPN_MASK;
+    env->mmu.pteaddr_wr = env->regs[CR_PTEADDR];
+
+    cs->exception_index = excp;
+    env->regs[CR_BADADDR] = address;
+    cpu_loop_exit_restore(cs, retaddr);
+}
+
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    nios2_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
+}
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/nios2/mmu.c b/target/nios2/mmu.c
index 5acf442d8b..47fa474efb 100644
--- a/target/nios2/mmu.c
+++ b/target/nios2/mmu.c
@@ -36,18 +36,6 @@
 #define MMU_LOG(x)
 #endif
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    int ret;
-
-    ret = nios2_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (unlikely(ret)) {
-        /* now we have a real cpu fault */
-        cpu_loop_exit_restore(cs, retaddr);
-    }
-}
-
 void mmu_read_debug(CPUNios2State *env, uint32_t rn)
 {
     switch (rn) {
-- 
2.17.1


