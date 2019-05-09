Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41626C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25ED208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xn6yy1fM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25ED208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48799 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOcPE-0004kr-4M
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 02:19:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc99-00067Y-75
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc97-0007Ai-UJ
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:11 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOc97-0007AK-Og
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:09 -0400
Received: by mail-pf1-x444.google.com with SMTP id c6so711322pfa.10
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 23:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=i61mEex2vpahjushkr4y22Y6q9/HL9JKMG8d2fXnTE0=;
	b=Xn6yy1fMTS/xcWOSVdPzj0wgswV4rjlu2OVlYLqMhe/nQg3QthU0H3eYSWYmaeKON6
	mTGnKL1QLmJD6sjYDKG0NED75WYPN3Vwrt5jlPg2za6T8VJwuy78koBQUWvL0XKDcimT
	JmOfpSHzev9tFhAF8xB5cFgo6LrRwSw0R/W8A3OdVGSJkYr00o457BcdVgtaoUE7OKfA
	ifxxfy+OJ2HBJyaWYIV16N5fTnsDSe56N96Ia3y/uScm49xU73JkSjkh2YHwtg4Wsz3S
	tHhF0hKV7ASEMvSIeKRn7favWiyHi+dcQnz+GXqneZkEjghyRO3TH4IOlSBIEOOBSl5a
	ozUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=i61mEex2vpahjushkr4y22Y6q9/HL9JKMG8d2fXnTE0=;
	b=ozt2iXI0YpgG/nfnT6FPjvBvcT37NOe8iPOf7ZNNzfFBerkfAJhLXYc9mat9FAOB0I
	bSzG84pmTOYPY7ba6LIx6YJn+EyWAsa1vNlJMD2er0Y/reuMtUk+YPIAxj5OqFAuVAMe
	M2rVMiL2KIJIDnxp9vdwTudjdUddYNXmt+3Qu/98GWseF/kBVAoPrFmDhgG/VNVmjFpT
	VvRuELP+MaipSIMy1NFY47QrNE9WiYtsKdxhTTyrUalDfI2iD8WavNeblzYLTrdy0UhS
	TwlvGQYHO9lkbz2EUBLCKP3uwdnFTIzXhS+oCvKvQotAE2hGa+yfb+p8ojNpYGgh97VC
	y+Ug==
X-Gm-Message-State: APjAAAWWu8k4cG6GOT9nlDC8faaq+LGvK9EHYk6zMQhGxQwLqpwXCUPw
	Kh0gClu2DCV059fo3P8QQV3VyMXUMu0=
X-Google-Smtp-Source: APXvYqxeACIXS6SJ28rLBXWjiVd+EmPcnZsfWs2vj3SFgn0/w7YhGZoY0uY8AFsuQ0kYOGffPxPYEQ==
X-Received: by 2002:a65:5cca:: with SMTP id b10mr3193456pgt.444.1557381788567; 
	Wed, 08 May 2019 23:03:08 -0700 (PDT)
Received: from localhost.localdomain (97-113-27-95.tukw.qwest.net.
	[97.113.27.95])
	by smtp.gmail.com with ESMTPSA id n7sm1496109pff.45.2019.05.08.23.03.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 23:03:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 23:02:35 -0700
Message-Id: <20190509060246.4031-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509060246.4031-1-richard.henderson@linaro.org>
References: <20190509060246.4031-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v2 16/27] target/ppc: Convert to
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>
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
index 0394a9ddad..3f847de36c 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10592,9 +10592,8 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_read_register = ppc_cpu_gdb_read_register;
     cc->gdb_write_register = ppc_cpu_gdb_write_register;
     cc->do_unaligned_access = ppc_cpu_do_unaligned_access;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = ppc_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = ppc_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->get_phys_page_debug = ppc_cpu_get_phys_page_debug;
     cc->vmsd = &vmstate_ppc_cpu;
 #endif
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


