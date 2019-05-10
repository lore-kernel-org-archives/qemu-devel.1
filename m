Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A64C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878612070D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g1nhb+LX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878612070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45166 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7WJ-0003IE-My
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:33:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jm-0007mE-Kl
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jl-0000Ea-Ay
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:14 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7Jl-0000DM-3F
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:13 -0400
Received: by mail-pf1-x444.google.com with SMTP id 10so3404426pfo.5
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=31uk4YjQMNkXp7x9DtppMMcO/OZFqofAl5izW1hAuMk=;
	b=g1nhb+LXT/rD9mXKm+Qn3BTNHG4VcTPDGKD4xfSatkGioggBzYi4HpKyn/ZObWpHXn
	oW7rVsOaYuDU4YJAR2pohuNrHzImhf6hdAbM/LMAUhvXEUgFRT3A+PC7Z4P/27GOyTtp
	4HLlIMP2Vu77GTMQX9Sph3IMlnNL9gr+AacDW4DaK4cwGyW++BiWTAaIjaoYQJyzRpbg
	wcepPhRt+eOKIWG1zUO+S1WG7aylHTB2M/14BD8H2Z9+eLrSI2TuHwG+lgU1xHo986dG
	ItdaCoUVl1ZxDAgLMzV4+C4SL2j+Zuqw+GroPFB0Ap6+Bmtu1szEj4+Aa8sPjkv5wEqe
	/hyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=31uk4YjQMNkXp7x9DtppMMcO/OZFqofAl5izW1hAuMk=;
	b=IuAocMJ0VD+lA+Pkd0yCXDFSSdnv0UVLcS8e6RIvFkN+NQrnuS70+zulTYoPT9K1lV
	uanQprXf3gPTmzOu4cn5WX4RjWpVyCaYFo9XyBOAO8ULcGPkq2HLVZXmjb1bFykpAJF/
	FFI00vvsy7RztP09YIHOdz5dal0NOXSZEA+SvgPKFhXUoJtmGWA4dtrLCy/dszoSGhSQ
	lBVMcw7RikHyWZ3yze5smu2lz3N9vg2I1vWgdVi7TnvA+axkhnETbNhbBFA6znzd5y0S
	cFJn6gD3Fi7qqjMPGOvLOKydqnrJSvEBmNuRv8LsdhVfSRLCcdG3bc+fzh0G+s4bDnU/
	8WdQ==
X-Gm-Message-State: APjAAAVu5DlemfePax05HslbRb/+xHrYJL9SQfCyhAMmZ5fA66R4oms7
	WwPpnFvXY0X2Ef7kMOO5mO2YThwCNhQ=
X-Google-Smtp-Source: APXvYqx/B/89IM9k0UhcjQqvlrCAzJy+dEu0vS6rs6WztCtsqNzLJh7OkTPjNGdv32UW5lzpA1zpwQ==
X-Received: by 2002:aa7:95bb:: with SMTP id a27mr3076563pfk.30.1557501611584; 
	Fri, 10 May 2019 08:20:11 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.20.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:20:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:37 -0700
Message-Id: <20190510151944.22981-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
References: <20190510151944.22981-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PULL 20/27] target/sparc: Convert to
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
Cc: peter.maydell@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h         |  5 ++--
 target/sparc/cpu.c         |  5 ++--
 target/sparc/ldst_helper.c | 11 +-------
 target/sparc/mmu_helper.c  | 58 ++++++++++++++++++++++++--------------
 4 files changed, 43 insertions(+), 36 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 85b9665ccc..f31e8535df 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -579,8 +579,9 @@ void cpu_raise_exception_ra(CPUSPARCState *, int, uintptr_t) QEMU_NORETURN;
 void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu);
 void sparc_cpu_list(void);
 /* mmu_helper.c */
-int sparc_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-                               int mmu_idx);
+bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr);
 target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev);
 void dump_mmu(CPUSPARCState *env);
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 4654c2a6a0..f93ce72eb9 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -875,9 +875,8 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
     cc->synchronize_from_tb = sparc_cpu_synchronize_from_tb;
     cc->gdb_read_register = sparc_cpu_gdb_read_register;
     cc->gdb_write_register = sparc_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = sparc_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = sparc_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->do_unassigned_access = sparc_cpu_unassigned_access;
     cc->do_unaligned_access = sparc_cpu_do_unaligned_access;
     cc->get_phys_page_debug = sparc_cpu_get_phys_page_debug;
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index a7fcb84ac0..2558c08a64 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1925,18 +1925,9 @@ void QEMU_NORETURN sparc_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     cpu_raise_exception_ra(env, TT_UNALIGNED, retaddr);
 }
 
-/* try to fill the TLB and return an exception if error. If retaddr is
-   NULL, it means that the function was called in C code (i.e. not
-   from generated code or from helper.c) */
-/* XXX: fix it to restore all registers */
 void tlb_fill(CPUState *cs, target_ulong addr, int size,
               MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
-    int ret;
-
-    ret = sparc_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (ret) {
-        cpu_loop_exit_restore(cs, retaddr);
-    }
+    sparc_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
 }
 #endif
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index afcc5b617d..facc0c60e9 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -27,13 +27,14 @@
 
 #if defined(CONFIG_USER_ONLY)
 
-int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                               int mmu_idx)
+bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
 
-    if (rw & 2) {
+    if (access_type == MMU_INST_FETCH) {
         cs->exception_index = TT_TFAULT;
     } else {
         cs->exception_index = TT_DFAULT;
@@ -43,7 +44,7 @@ int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
         env->mmuregs[4] = address;
 #endif
     }
-    return 1;
+    cpu_loop_exit_restore(cs, retaddr);
 }
 
 #else
@@ -208,8 +209,9 @@ static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
 }
 
 /* Perform address translation */
-int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                               int mmu_idx)
+bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
@@ -218,16 +220,26 @@ int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
     target_ulong page_size;
     int error_code = 0, prot, access_index;
 
+    /*
+     * TODO: If we ever need tlb_vaddr_to_host for this target,
+     * then we must figure out how to manipulate FSR and FAR
+     * when both MMU_NF and probe are set.  In the meantime,
+     * do not support this use case.
+     */
+    assert(!probe);
+
     address &= TARGET_PAGE_MASK;
     error_code = get_physical_address(env, &paddr, &prot, &access_index,
-                                      address, rw, mmu_idx, &page_size);
+                                      address, access_type,
+                                      mmu_idx, &page_size);
     vaddr = address;
-    if (error_code == 0) {
+    if (likely(error_code == 0)) {
         qemu_log_mask(CPU_LOG_MMU,
-                "Translate at %" VADDR_PRIx " -> " TARGET_FMT_plx ", vaddr "
-                TARGET_FMT_lx "\n", address, paddr, vaddr);
+                      "Translate at %" VADDR_PRIx " -> "
+                      TARGET_FMT_plx ", vaddr " TARGET_FMT_lx "\n",
+                      address, paddr, vaddr);
         tlb_set_page(cs, vaddr, paddr, prot, mmu_idx, page_size);
-        return 0;
+        return true;
     }
 
     if (env->mmuregs[3]) { /* Fault status register */
@@ -243,14 +255,14 @@ int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
            switching to normal mode. */
         prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         tlb_set_page(cs, vaddr, paddr, prot, mmu_idx, TARGET_PAGE_SIZE);
-        return 0;
+        return true;
     } else {
-        if (rw & 2) {
+        if (access_type == MMU_INST_FETCH) {
             cs->exception_index = TT_TFAULT;
         } else {
             cs->exception_index = TT_DFAULT;
         }
-        return 1;
+        cpu_loop_exit_restore(cs, retaddr);
     }
 }
 
@@ -713,8 +725,9 @@ static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
 }
 
 /* Perform address translation */
-int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                               int mmu_idx)
+bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
@@ -725,8 +738,9 @@ int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
 
     address &= TARGET_PAGE_MASK;
     error_code = get_physical_address(env, &paddr, &prot, &access_index,
-                                      address, rw, mmu_idx, &page_size);
-    if (error_code == 0) {
+                                      address, access_type,
+                                      mmu_idx, &page_size);
+    if (likely(error_code == 0)) {
         vaddr = address;
 
         trace_mmu_helper_mmu_fault(address, paddr, mmu_idx, env->tl,
@@ -734,10 +748,12 @@ int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
                                    env->dmmu.mmu_secondary_context);
 
         tlb_set_page(cs, vaddr, paddr, prot, mmu_idx, page_size);
-        return 0;
+        return true;
     }
-    /* XXX */
-    return 1;
+    if (probe) {
+        return false;
+    }
+    cpu_loop_exit_restore(cs, retaddr);
 }
 
 void dump_mmu(CPUSPARCState *env)
-- 
2.17.1


