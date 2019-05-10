Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A72DC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:40:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 245462175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDlCn18U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245462175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45274 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7dP-0001cN-CD
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:40:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jl-0007jb-CA
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jj-0000Cb-PW
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:13 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7Jj-0000BS-Hi
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:11 -0400
Received: by mail-pg1-x542.google.com with SMTP id z3so3175178pgp.8
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=13zPpr8eu2CJQOgqlDgYW1euE5CjP18/vmWEohkbXwc=;
	b=fDlCn18UKtMmkf3KNXSl+izmHVQq2M7sw8GZb2r0jiE7FmEtsBiaux2VJwK5Jp0DmG
	X44fWbN9wsCB8FDuy8SJ/FEg9HqC4lg0MmJW+4IFdlAObXxeyOmUVGIAhp2rrw2TwF/O
	AW65UgC9mrxzHDmEuft9ZwAlbYekzgf8lULqU/ME6akEmFRXQg0vQaH267mrF+En3HQW
	ZqsoLA7hqn8cKp+y/8ZvTlHIj/OpNj6cYBzKqUvnrK8GxwSFDCwOm4HFpsCXHr/6DMiO
	SucxGXRUIor/yx5HUUVlbnbE1lH8uXPvLSpzP2n2eso5NaQHmXYWJRBYwyvG93icM65h
	67Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=13zPpr8eu2CJQOgqlDgYW1euE5CjP18/vmWEohkbXwc=;
	b=Ud4SFlQkVlKmw/AL7gWqXfoIJQXuObkpk7SJYZfv13YN4s7ZCLZhW0duZkJj+aGfCD
	u5skRbbLDFbAYEQwdG9B6F1qskiCbnSOkUXzkckTAZ9kWucjanZQlEidFVJ9jxHe+ULi
	IkJ9ukiPueAO76L1/r21qFH6Kj9rkq4f4lgxwPao8xJre+YWVp3A3O5HV9N3hoV2xId0
	jnsLaW3pM18MLX+I+N978QpxHGcyvncxykso2LwrSjVpChxbwyiAgx6nGy/ZGUKQ/Kq6
	5aLzn73lH9cOB+aqOtSCnm2FhVXEz2ixfZM9jAMT3ifLLuJVqAX1aGY8yf2RqSiztOs4
	td7g==
X-Gm-Message-State: APjAAAUDG+d6ka9JFRZBzkkShJ6P+Vs3p8XdUzilHCIwZFysKHT31jDN
	llPS4qjs8NKsTRZWdCphvOLAdH1L+bM=
X-Google-Smtp-Source: APXvYqz9sL8LvWfwGcYDfsAxRh4rCJ+jocwQjWNoJYqTkwHvlLmUUlQM9kQwY7xLDK44v2BXf1johw==
X-Received: by 2002:a62:ee05:: with SMTP id e5mr13260336pfi.117.1557501610322; 
	Fri, 10 May 2019 08:20:10 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.20.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:20:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:36 -0700
Message-Id: <20190510151944.22981-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
References: <20190510151944.22981-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PULL 19/27] target/sh4: Convert to CPUClass::tlb_fill
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
Cc: peter.maydell@linaro.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/cpu.h       |   5 +-
 target/sh4/cpu.c       |   5 +-
 target/sh4/helper.c    | 197 ++++++++++++++++++++---------------------
 target/sh4/op_helper.c |  12 ---
 4 files changed, 101 insertions(+), 118 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 1be36fe875..547194aac7 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -243,8 +243,9 @@ void superh_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
 void sh4_translate_init(void);
 int cpu_sh4_signal_handler(int host_signum, void *pinfo,
                            void *puc);
-int superh_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-                                int mmu_idx);
+bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                         MMUAccessType access_type, int mmu_idx,
+                         bool probe, uintptr_t retaddr);
 
 void sh4_cpu_list(void);
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index da2799082e..c4736a0a73 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -229,9 +229,8 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
     cc->synchronize_from_tb = superh_cpu_synchronize_from_tb;
     cc->gdb_read_register = superh_cpu_gdb_read_register;
     cc->gdb_write_register = superh_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = superh_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = superh_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->do_unaligned_access = superh_cpu_do_unaligned_access;
     cc->get_phys_page_debug = superh_cpu_get_phys_page_debug;
 #endif
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index fa51269fb1..1517a6152f 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -27,43 +27,6 @@
 #include "hw/sh4/sh_intc.h"
 #endif
 
-#if defined(CONFIG_USER_ONLY)
-
-void superh_cpu_do_interrupt(CPUState *cs)
-{
-    cs->exception_index = -1;
-}
-
-int superh_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                                int mmu_idx)
-{
-    SuperHCPU *cpu = SUPERH_CPU(cs);
-    CPUSH4State *env = &cpu->env;
-
-    env->tea = address;
-    cs->exception_index = -1;
-    switch (rw) {
-    case 0:
-        cs->exception_index = 0x0a0;
-        break;
-    case 1:
-        cs->exception_index = 0x0c0;
-        break;
-    case 2:
-        cs->exception_index = 0x0a0;
-        break;
-    }
-    return 1;
-}
-
-int cpu_sh4_is_cached(CPUSH4State * env, target_ulong addr)
-{
-    /* For user mode, only U0 area is cacheable. */
-    return !(addr & 0x80000000);
-}
-
-#else /* !CONFIG_USER_ONLY */
-
 #define MMU_OK                   0
 #define MMU_ITLB_MISS            (-1)
 #define MMU_ITLB_MULTIPLE        (-2)
@@ -79,6 +42,21 @@ int cpu_sh4_is_cached(CPUSH4State * env, target_ulong addr)
 #define MMU_DADDR_ERROR_READ     (-12)
 #define MMU_DADDR_ERROR_WRITE    (-13)
 
+#if defined(CONFIG_USER_ONLY)
+
+void superh_cpu_do_interrupt(CPUState *cs)
+{
+    cs->exception_index = -1;
+}
+
+int cpu_sh4_is_cached(CPUSH4State *env, target_ulong addr)
+{
+    /* For user mode, only U0 area is cacheable. */
+    return !(addr & 0x80000000);
+}
+
+#else /* !CONFIG_USER_ONLY */
+
 void superh_cpu_do_interrupt(CPUState *cs)
 {
     SuperHCPU *cpu = SUPERH_CPU(cs);
@@ -458,69 +436,6 @@ static int get_physical_address(CPUSH4State * env, target_ulong * physical,
     return get_mmu_address(env, physical, prot, address, rw, access_type);
 }
 
-int superh_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                                int mmu_idx)
-{
-    SuperHCPU *cpu = SUPERH_CPU(cs);
-    CPUSH4State *env = &cpu->env;
-    target_ulong physical;
-    int prot, ret, access_type;
-
-    access_type = ACCESS_INT;
-    ret =
-	get_physical_address(env, &physical, &prot, address, rw,
-			     access_type);
-
-    if (ret != MMU_OK) {
-	env->tea = address;
-	if (ret != MMU_DTLB_MULTIPLE && ret != MMU_ITLB_MULTIPLE) {
-	    env->pteh = (env->pteh & PTEH_ASID_MASK) |
-		    (address & PTEH_VPN_MASK);
-	}
-	switch (ret) {
-	case MMU_ITLB_MISS:
-	case MMU_DTLB_MISS_READ:
-            cs->exception_index = 0x040;
-	    break;
-	case MMU_DTLB_MULTIPLE:
-	case MMU_ITLB_MULTIPLE:
-            cs->exception_index = 0x140;
-	    break;
-	case MMU_ITLB_VIOLATION:
-            cs->exception_index = 0x0a0;
-	    break;
-	case MMU_DTLB_MISS_WRITE:
-            cs->exception_index = 0x060;
-	    break;
-	case MMU_DTLB_INITIAL_WRITE:
-            cs->exception_index = 0x080;
-	    break;
-	case MMU_DTLB_VIOLATION_READ:
-            cs->exception_index = 0x0a0;
-	    break;
-	case MMU_DTLB_VIOLATION_WRITE:
-            cs->exception_index = 0x0c0;
-	    break;
-	case MMU_IADDR_ERROR:
-	case MMU_DADDR_ERROR_READ:
-            cs->exception_index = 0x0e0;
-	    break;
-	case MMU_DADDR_ERROR_WRITE:
-            cs->exception_index = 0x100;
-	    break;
-	default:
-            cpu_abort(cs, "Unhandled MMU fault");
-	}
-	return 1;
-    }
-
-    address &= TARGET_PAGE_MASK;
-    physical &= TARGET_PAGE_MASK;
-
-    tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZE);
-    return 0;
-}
-
 hwaddr superh_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     SuperHCPU *cpu = SUPERH_CPU(cs);
@@ -745,7 +660,6 @@ void cpu_sh4_write_mmaped_utlb_addr(CPUSH4State *s, hwaddr addr,
         if (needs_tlb_flush) {
             tlb_flush_page(CPU(sh_env_get_cpu(s)), vpn << 10);
         }
-        
     } else {
         int index = (addr & 0x00003f00) >> 8;
         tlb_t * entry = &s->utlb[index];
@@ -885,3 +799,84 @@ bool superh_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     }
     return false;
 }
+
+bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                         MMUAccessType access_type, int mmu_idx,
+                         bool probe, uintptr_t retaddr)
+{
+    SuperHCPU *cpu = SUPERH_CPU(cs);
+    CPUSH4State *env = &cpu->env;
+    int ret;
+
+#ifdef CONFIG_USER_ONLY
+    ret = (access_type == MMU_DATA_STORE ? MMU_DTLB_VIOLATION_WRITE :
+           access_type == MMU_INST_FETCH ? MMU_ITLB_VIOLATION :
+           MMU_DTLB_VIOLATION_READ);
+#else
+    target_ulong physical;
+    int prot, sh_access_type;
+
+    sh_access_type = ACCESS_INT;
+    ret = get_physical_address(env, &physical, &prot, address,
+                               access_type, sh_access_type);
+
+    if (ret == MMU_OK) {
+        address &= TARGET_PAGE_MASK;
+        physical &= TARGET_PAGE_MASK;
+        tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZE);
+        return true;
+    }
+    if (probe) {
+        return false;
+    }
+
+    if (ret != MMU_DTLB_MULTIPLE && ret != MMU_ITLB_MULTIPLE) {
+        env->pteh = (env->pteh & PTEH_ASID_MASK) | (address & PTEH_VPN_MASK);
+    }
+#endif
+
+    env->tea = address;
+    switch (ret) {
+    case MMU_ITLB_MISS:
+    case MMU_DTLB_MISS_READ:
+        cs->exception_index = 0x040;
+        break;
+    case MMU_DTLB_MULTIPLE:
+    case MMU_ITLB_MULTIPLE:
+        cs->exception_index = 0x140;
+        break;
+    case MMU_ITLB_VIOLATION:
+        cs->exception_index = 0x0a0;
+        break;
+    case MMU_DTLB_MISS_WRITE:
+        cs->exception_index = 0x060;
+        break;
+    case MMU_DTLB_INITIAL_WRITE:
+        cs->exception_index = 0x080;
+        break;
+    case MMU_DTLB_VIOLATION_READ:
+        cs->exception_index = 0x0a0;
+        break;
+    case MMU_DTLB_VIOLATION_WRITE:
+        cs->exception_index = 0x0c0;
+        break;
+    case MMU_IADDR_ERROR:
+    case MMU_DADDR_ERROR_READ:
+        cs->exception_index = 0x0e0;
+        break;
+    case MMU_DADDR_ERROR_WRITE:
+        cs->exception_index = 0x100;
+        break;
+    default:
+        cpu_abort(cs, "Unhandled MMU fault");
+    }
+    cpu_loop_exit_restore(cs, retaddr);
+}
+
+#ifndef CONFIG_USER_ONLY
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    superh_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
+}
+#endif
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 28027f9e0b..bd5d782b50 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -41,18 +41,6 @@ void superh_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    int ret;
-
-    ret = superh_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (ret) {
-        /* now we have a real cpu fault */
-        cpu_loop_exit_restore(cs, retaddr);
-    }
-}
-
 #endif
 
 void helper_ldtlb(CPUSH4State *env)
-- 
2.17.1


