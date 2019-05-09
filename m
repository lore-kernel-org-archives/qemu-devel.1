Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC27C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D652175B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QYz7CEJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D652175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33825 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOrty-0005Az-0X
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 18:52:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrVL-0007xH-Pl
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:27:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrVJ-0005bQ-69
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:27:07 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOrVG-0005aH-7y
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:27:04 -0400
Received: by mail-pl1-x642.google.com with SMTP id y3so1819871plp.0
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 15:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Pawv8gVKgvIshmjx0BG7faLy+gIe8qsSKFcm+yZ5sy0=;
	b=QYz7CEJOpCCzIzxIaLaOuDxGP0wFO+2/A3mDz2zV5UgfJ0a67XZMfp1/M29q0YGbqt
	bHY43tPVk7tVNK1WfGnpRoZNrtqm+vkr0uN+ALnefC9V7Sf2EQjLw24tPrlKFmA9fSZb
	S/eMwwzy00sfZYeZAkMROtJ5223Po5QtWuH+qbZzz2USuwl6D5dx2Oo0B9dUOIFOFnBE
	89yX2ErWgwgAOpY53dwBYnXpgXF9ZPA3mnVRin95tWhfBbwYbX6UIDyg+zt/bUWi0AXk
	502KgQK/JFAhEbfF6RM7HiITK0+7lFL/tL1GoDZmYAO30H7UubVGf8Oas2GzrB14CZqf
	GbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Pawv8gVKgvIshmjx0BG7faLy+gIe8qsSKFcm+yZ5sy0=;
	b=d/A7D+foJMDjgKgUzO49cPk1aixF9BHlSXykWO/i8ir7o9p8Kw/ko2KXS4IW7bZuzi
	knmEaRwfHRNrtovjdDF7SxvHA/xAhlsoeRQQMNSkJXvTQp1k7eLpiLVTEP3YadfzQleX
	1HQnpz/ZoY0+orjAuk78b7j8cAwDLPadQ+6CaaYfCfMCu7fblV2bWPxu5wE4gzP9SriD
	5pFbIGI9Mc/kTXioRRvB+47wrflcsNZzEmyMkg35Iisdg7dnwxJWpZCNayrtn69ozjiO
	xH9iroG4SPbAiduVZEs+6bNMmaVW3ToBFsXtom5kk5KV6SsM+j/FZPEc3Mu/kapWN6H/
	RliQ==
X-Gm-Message-State: APjAAAXcWzX2f3MEpQGgGjoqiDOWQP/+isDIxZKaf3tvmuPnxu4VyRtc
	iPvp/NrPcXGszqftLzdMTv2IaYlObzc=
X-Google-Smtp-Source: APXvYqw0XRoKqmFVU30O/46yqdYrRZrBm870OoFkBy08/0ahJezEilHkBiVddyk+SlhEk8gtyKdbWA==
X-Received: by 2002:a17:902:704c:: with SMTP id
	h12mr8532139plt.270.1557440820301; 
	Thu, 09 May 2019 15:27:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m2sm4490521pfi.24.2019.05.09.15.26.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 15:26:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 15:26:24 -0700
Message-Id: <20190509222631.14271-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509222631.14271-1-richard.henderson@linaro.org>
References: <20190509222631.14271-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v3 20/27] target/sparc: Convert to
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Keep user-only, sparc32, and sparc64 tlb_fill separate.
v3: Assert !probe for sparc32.
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


