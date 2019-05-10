Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6C8C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D4D20578
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TFUFnw6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D4D20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45111 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7TH-000067-Ti
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:30:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jh-0007fV-FJ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jg-00005x-6P
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:09 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7Jg-00005J-0y
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:08 -0400
Received: by mail-pl1-x641.google.com with SMTP id a59so2995912pla.5
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ERTfGga5mStSjhtEmfd35eidZa/k5s6k3BsixP9VyyI=;
	b=TFUFnw6HA8dXeMZZN6tkZPD/k5JYIs2K/wQ5rMZhUbayZKyxF8+5x/ag4qhFBNWou2
	VbKLZvDKTTEw/DHL0kWj1G4+WaH5FBEwSwHiNeZHu0dME2cGSPA73+jBv60gh9HCs/XE
	lKc1tygl/bHWS/GcCZdCcyduSV6PwV82GUmMtrUiQN86/vSnxl9EIJBO7KLFFezU4FWj
	8jF0JhLzUPIngMRJRibwCDker8j1Mwj7xCWSiYOo44bUIZhhzcqalp0bhPUHpkoU8UVj
	A+eKXo9GHtkGctvbGLMGFcwpMKOV0EwVKoQydtFoi/l8Pp0fO1Wt5KyEv51qcvv1LOzg
	HtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ERTfGga5mStSjhtEmfd35eidZa/k5s6k3BsixP9VyyI=;
	b=rUZJ1jGjpTGf727ccV18egZwyMjfk72VX+un9R6EfpiyVy6E8dRQoZbrS4gNs7ZKtN
	S5VcPt5lnevYq3XbR4cbHVglg+e4+RrlY0funiOyB0oHuDkog1dDFSNHF11KmPUfVcR6
	wwpO5Q3HjbrzGRlTSB739eXchHtbf+pkpGr+wvuXJ6kcd+G8d7cl/CErf3EKhLRAbQVx
	b+kG44mXlXmWs/8kj/Nb5mql/BuZWO3rXZtMFqzybe/LtcyuqxZa80pQ/pmg1JagZrMj
	ckuTUPcN3NOZmL9c/EuL5PXMGRCNn+Crln9pTX0oS1bznrxRLLm/aYd2Ty/FJevAFL1f
	QOwQ==
X-Gm-Message-State: APjAAAWh6NCQ1wXggYtNmV/SoqVclwaPoi1UKUR//LQh8zqJPEUhym2d
	6Y9AasPDamARGfdg8Pqvc9gB7aYNdtA=
X-Google-Smtp-Source: APXvYqwKT35FukBqkKqiW0Qn9NLHJBRWqgiMsXtmsnKCxjQNVKEsVSg3OLp7G+flRZ/AqVTZHNK2Cw==
X-Received: by 2002:a17:902:4281:: with SMTP id
	h1mr2833560pld.288.1557501606712; 
	Fri, 10 May 2019 08:20:06 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.20.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:20:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:33 -0700
Message-Id: <20190510151944.22981-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
References: <20190510151944.22981-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PULL 16/27] target/ppc: Convert to CPUClass::tlb_fill
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


