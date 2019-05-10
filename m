Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4778C04AB2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 18:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FCC6217F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 18:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IvVEQFyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCC6217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48536 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPAhV-0000t1-QN
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 14:56:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hPAfY-0007vr-Q0
	for qemu-devel@nongnu.org; Fri, 10 May 2019 14:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hPAfQ-0005ro-90
	for qemu-devel@nongnu.org; Fri, 10 May 2019 14:54:56 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hPAfQ-0005pU-1l
	for qemu-devel@nongnu.org; Fri, 10 May 2019 14:54:48 -0400
Received: by mail-pl1-x641.google.com with SMTP id a5so3221256pls.12
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 11:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=QUvZbCp4hiIu4WKEe9vqsUzs+jUu0CQw3Oh1C09dIOU=;
	b=IvVEQFyEWqmQGAZ/cD5Z3fc3cuZFHOKeqBZK37/h0XMWhaJFZMKCUgJ8ja3zn/yJLv
	RiBBv1X3ImmKK+mIzyts3IUYKKeyEKHmD7MTzE2BFYiEnkbCXAGhGzpwYwR7I7s+LuHD
	2s53/z0ElIxP429Z8kQhh8NzdUdoXaKxUEe4TnNOsYkhgZf+2MbTTrdiQLZOIc5VVQpD
	OXHfVAWMPi/o4eKNV8RtfVTqAfMCh2xnNfuazXZhh86PsIJH/NFGv82Xn1n7ahZHfzzk
	86dRerJhw+8xwk1SHwaFhWdYGUPZGI2fTkfZ/Vhz2mVbBYrIK/tcnisIhKefV0ZThrwf
	SJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=QUvZbCp4hiIu4WKEe9vqsUzs+jUu0CQw3Oh1C09dIOU=;
	b=Aupk4z8FrrXqYSyhzl6pIirDF5vENIxBGxnQkxE/vF90WXP1Zb76N3/r6+7lMxrshQ
	Y/7hNVdXFtHkA9G4csi0cvS8nBudnZahAn3DUm6BM8shshyo7X/89+sLRv9qporWABmq
	zRtbTNGOfY3nKyXW7p6APkpfi2uDzbulvBe8uwKL3rpCz56AZOiwH85M4y15BNbdaOKE
	EmMG6kJVvTzY+c2+XQEemKrlzmx6s2Ho5rSfVPJKbu9Ag4XxGlVHSM6RQU7evhwLCIBA
	tdZn0+U60TpdkQTbAkWeeRVc79YSgF0m7NThRPowRqwKv0nT0ZwZ2hFq2S329k02HTex
	hzGA==
X-Gm-Message-State: APjAAAVrxxgEM6HYgZ/cdS+Sk9lwg33coGQMetdU5XwquCJAPu0RbfuJ
	8Orlm8CsUChNdr6Df1zohfgyr5QbSV8=
X-Google-Smtp-Source: APXvYqyB1pwPOy0ZH3OeZwXyEck1uYpf+ZuQDyTtHuWvLfhNKrJToF6kFQVtxt9wMrGQ02DO5g6QbA==
X-Received: by 2002:a17:902:5995:: with SMTP id
	p21mr15415797pli.216.1557514486616; 
	Fri, 10 May 2019 11:54:46 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	q20sm12733146pfi.166.2019.05.10.11.54.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 11:54:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 11:54:35 -0700
Message-Id: <20190510185438.29533-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510185438.29533-1-richard.henderson@linaro.org>
References: <20190510185438.29533-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PULL v2 16/27] target/ppc: Convert to
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
Cc: peter.maydell@linaro.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: qemu-ppc@nongnu.org
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu.h                |  7 +++----
 target/ppc/mmu_helper.c         | 22 +++++++++++++---------
 target/ppc/translate_init.inc.c |  5 ++---
 target/ppc/user_only_helper.c   | 14 ++++++++------
 4 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 5e7cf54b2f..d7f23ad5e0 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1311,10 +1311,9 @@ void ppc_translate_init(void);
  * is returned if the signal was handled by the virtual CPU.
  */
 int cpu_ppc_signal_handler(int host_signum, void *pinfo, void *puc);
-#if defined(CONFIG_USER_ONLY)
-int ppc_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-                             int mmu_idx);
-#endif
+bool ppc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                      MMUAccessType access_type, int mmu_idx,
+                      bool probe, uintptr_t retaddr);
 
 #if !defined(CONFIG_USER_ONLY)
 void ppc_store_sdr1(CPUPPCState *env, target_ulong value);
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 1dbc9acb75..afcca50530 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -3057,15 +3057,9 @@ void helper_check_tlb_flush_global(CPUPPCState *env)
 
 /*****************************************************************************/
 
-/*
- * try to fill the TLB and return an exception if error. If retaddr is
- * NULL, it means that the function was called in C code (i.e. not
- * from generated code or from helper.c)
- *
- * XXX: fix it to restore all registers
- */
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+bool ppc_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
+                      MMUAccessType access_type, int mmu_idx,
+                      bool probe, uintptr_t retaddr)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
@@ -3078,7 +3072,17 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
         ret = cpu_ppc_handle_mmu_fault(env, addr, access_type, mmu_idx);
     }
     if (unlikely(ret != 0)) {
+        if (probe) {
+            return false;
+        }
         raise_exception_err_ra(env, cs->exception_index, env->error_code,
                                retaddr);
     }
+    return true;
+}
+
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    ppc_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
 }
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 0394a9ddad..ad5e14b16f 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10592,9 +10592,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_read_register = ppc_cpu_gdb_read_register;
     cc->gdb_write_register = ppc_cpu_gdb_write_register;
     cc->do_unaligned_access = ppc_cpu_do_unaligned_access;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = ppc_cpu_handle_mmu_fault;
-#else
+#ifndef CONFIG_USER_ONLY
     cc->get_phys_page_debug = ppc_cpu_get_phys_page_debug;
     cc->vmsd = &vmstate_ppc_cpu;
 #endif
@@ -10624,6 +10622,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
 #endif
 #ifdef CONFIG_TCG
     cc->tcg_initialize = ppc_translate_init;
+    cc->tlb_fill = ppc_cpu_tlb_fill;
 #endif
     cc->disas_set_info = ppc_disas_set_info;
 
diff --git a/target/ppc/user_only_helper.c b/target/ppc/user_only_helper.c
index 2f1477f102..683c03390d 100644
--- a/target/ppc/user_only_helper.c
+++ b/target/ppc/user_only_helper.c
@@ -20,21 +20,24 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "exec/exec-all.h"
 
-int ppc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                             int mmu_idx)
+
+bool ppc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                      MMUAccessType access_type, int mmu_idx,
+                      bool probe, uintptr_t retaddr)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
     int exception, error_code;
 
-    if (rw == 2) {
+    if (access_type == MMU_INST_FETCH) {
         exception = POWERPC_EXCP_ISI;
         error_code = 0x40000000;
     } else {
         exception = POWERPC_EXCP_DSI;
         error_code = 0x40000000;
-        if (rw) {
+        if (access_type == MMU_DATA_STORE) {
             error_code |= 0x02000000;
         }
         env->spr[SPR_DAR] = address;
@@ -42,6 +45,5 @@ int ppc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
     }
     cs->exception_index = exception;
     env->error_code = error_code;
-
-    return 1;
+    cpu_loop_exit_restore(cs, retaddr);
 }
-- 
2.17.1


