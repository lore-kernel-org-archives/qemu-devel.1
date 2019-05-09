Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1655C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4CA2173C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x8hk+beM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4CA2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33531 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOrd2-0006Ry-MB
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 18:35:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrUy-0007au-82
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrUx-0005RV-23
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:44 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOrUw-0005RE-SO
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:43 -0400
Received: by mail-pg1-x541.google.com with SMTP id h1so1930148pgs.2
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 15:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=s87CuOmfhyfGLXIPM91Iv48ElcI94bqoXpVc6e0DK1o=;
	b=x8hk+beMmINKTHxQ4tsNFIFj0lQ4X/EJFQqBKEmcCxzdW49rBv9MAIxkrrTs7q4mXB
	aURbhMbuu447VXWEZob1gdI2gjUAGpkqY3gRNrjjF7LoSEYQMYbDl+zyEeF9fgfg4dPe
	h60UnvNYYeNb1diwfd7hsGkDVBnZpSq1XrkhxHE2i/OVXiCgBuO22dLf2u+O2E/t0Tby
	F9JPiRfq6SNymTRsUXVSlFGrKZsO9W3obEAJUvQSrfMSBgF/2LZjIKeMUQkM/R7lNxdX
	Eld/ZfYUDb8gi96dZwY4TvJBq7a3TTeYa9BlnpJqMn6Jbl36FrptkXQlly0LGIEYkih2
	lDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=s87CuOmfhyfGLXIPM91Iv48ElcI94bqoXpVc6e0DK1o=;
	b=M15alLF4UJWEkhoP0ZdWF3oAs8X0SExtA5aJb4GbHV5cBMbVqwlkXrBGljvQM9eoWp
	Xpy4d7tL+1d+vLJSDN6UDe59V9f19vaot18TJC+fT4cEO0TCphVvP7soi9bDXx2Z3kIT
	n4I6v/0nijX1Abxi3TlTpd73/junc0AZbYxuJQT7EOdwtjr8Br6/RG/UPZTHXgTxtQ3N
	EPOPF0hbjWh7ddJYy8+WtMPhzQ8uVRnByQOcDfs15kCcWcQnBi4MoBvhVTal57tFFrFQ
	zvqfrXyzuAOpT8ww71bTUblwCq9sog888ff3Jonl+l2bvdlfLfxIyojG2R1uJTz7HfqA
	KyiQ==
X-Gm-Message-State: APjAAAV/hBIgwY9PrVe5YBpo1hdEE37oY/Ifbc7bWzSfrzQ4fhJhNaNj
	wNuEfrPWsOIQ4zLp1Rj+1h4Edyi6eQs=
X-Google-Smtp-Source: APXvYqx3RfPTTnHIUGzRcxrRgeRtXtBi6C3wv/wT/BSf9+hJ5BWRci/Bd0wGF1glpkfXMDk1GJoTbg==
X-Received: by 2002:a62:d286:: with SMTP id c128mr9060320pfg.159.1557440801627;
	Thu, 09 May 2019 15:26:41 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m2sm4490521pfi.24.2019.05.09.15.26.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 15:26:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 15:26:10 -0700
Message-Id: <20190509222631.14271-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509222631.14271-1-richard.henderson@linaro.org>
References: <20190509222631.14271-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v3 06/27] target/i386: Convert to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do not support probing, but we do not need it yet either.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h         |  5 ++--
 target/i386/cpu.c         |  5 ++--
 target/i386/excp_helper.c | 61 +++++++++++++++++++++++++--------------
 target/i386/mem_helper.c  | 21 --------------
 4 files changed, 44 insertions(+), 48 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0128910661..fce6660bac 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1656,8 +1656,9 @@ void host_cpuid(uint32_t function, uint32_t count,
 void host_vendor_fms(char *vendor, int *family, int *model, int *stepping);
 
 /* helper.c */
-int x86_cpu_handle_mmu_fault(CPUState *cpu, vaddr addr, int size,
-                             int is_write, int mmu_idx);
+bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                      MMUAccessType access_type, int mmu_idx,
+                      bool probe, uintptr_t retaddr);
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 722c5514d4..3c98869577 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5915,9 +5915,8 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->gdb_write_register = x86_cpu_gdb_write_register;
     cc->get_arch_id = x86_cpu_get_arch_id;
     cc->get_paging_enabled = x86_cpu_get_paging_enabled;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = x86_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = x86_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->asidx_from_attrs = x86_asidx_from_attrs;
     cc->get_memory_mapping = x86_cpu_get_memory_mapping;
     cc->get_phys_page_debug = x86_cpu_get_phys_page_debug;
diff --git a/target/i386/excp_helper.c b/target/i386/excp_helper.c
index 49231f6b69..68bf8e3f7c 100644
--- a/target/i386/excp_helper.c
+++ b/target/i386/excp_helper.c
@@ -137,26 +137,7 @@ void raise_exception_ra(CPUX86State *env, int exception_index, uintptr_t retaddr
     raise_interrupt2(env, exception_index, 0, 0, 0, retaddr);
 }
 
-#if defined(CONFIG_USER_ONLY)
-int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
-                             int is_write, int mmu_idx)
-{
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
-
-    /* user mode only emulation */
-    is_write &= 1;
-    env->cr[2] = addr;
-    env->error_code = (is_write << PG_ERROR_W_BIT);
-    env->error_code |= PG_ERROR_U_MASK;
-    cs->exception_index = EXCP0E_PAGE;
-    env->exception_is_int = 0;
-    env->exception_next_eip = -1;
-    return 1;
-}
-
-#else
-
+#if !defined(CONFIG_USER_ONLY)
 static hwaddr get_hphys(CPUState *cs, hwaddr gphys, MMUAccessType access_type,
                         int *prot)
 {
@@ -365,8 +346,8 @@ static hwaddr get_hphys(CPUState *cs, hwaddr gphys, MMUAccessType access_type,
  * 0  = nothing more to do
  * 1  = generate PF fault
  */
-int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
-                             int is_write1, int mmu_idx)
+static int handle_mmu_fault(CPUState *cs, vaddr addr, int size,
+                            int is_write1, int mmu_idx)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
@@ -691,3 +672,39 @@ do_check_protect_pse36:
     return 1;
 }
 #endif
+
+bool x86_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
+                      MMUAccessType access_type, int mmu_idx,
+                      bool probe, uintptr_t retaddr)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+
+#ifdef CONFIG_USER_ONLY
+    /* user mode only emulation */
+    env->cr[2] = addr;
+    env->error_code = (access_type == MMU_DATA_STORE) << PG_ERROR_W_BIT;
+    env->error_code |= PG_ERROR_U_MASK;
+    cs->exception_index = EXCP0E_PAGE;
+    env->exception_is_int = 0;
+    env->exception_next_eip = -1;
+    cpu_loop_exit_restore(cs, retaddr);
+#else
+    env->retaddr = retaddr;
+    if (handle_mmu_fault(cs, addr, size, access_type, mmu_idx)) {
+        /* FIXME: On error in get_hphys we have already jumped out.  */
+        g_assert(!probe);
+        raise_exception_err_ra(env, cs->exception_index,
+                               env->error_code, retaddr);
+    }
+    return true;
+#endif
+}
+
+#if !defined(CONFIG_USER_ONLY)
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    x86_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
+}
+#endif
diff --git a/target/i386/mem_helper.c b/target/i386/mem_helper.c
index 6cc53bcb40..1885df29d2 100644
--- a/target/i386/mem_helper.c
+++ b/target/i386/mem_helper.c
@@ -191,24 +191,3 @@ void helper_boundl(CPUX86State *env, target_ulong a0, int v)
         raise_exception_ra(env, EXCP05_BOUND, GETPC());
     }
 }
-
-#if !defined(CONFIG_USER_ONLY)
-/* try to fill the TLB and return an exception if error. If retaddr is
- * NULL, it means that the function was called in C code (i.e. not
- * from generated code or from helper.c)
- */
-/* XXX: fix it to restore all registers */
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
-    int ret;
-
-    env->retaddr = retaddr;
-    ret = x86_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (ret) {
-        raise_exception_err_ra(env, cs->exception_index, env->error_code, retaddr);
-    }
-}
-#endif
-- 
2.17.1


