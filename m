Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A074C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9B662175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HvtWRwwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B662175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45220 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7ZN-0005sP-3S
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:36:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jq-0007rH-1l
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jo-0000Hb-Kl
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:18 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7Jo-0000Gh-Ea
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:16 -0400
Received: by mail-pl1-x642.google.com with SMTP id w7so3006367plz.1
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=LTrRBAzo3ZXhs7/OIQshe/0vUKzYgpD3ylIgF8SzGa8=;
	b=HvtWRwwVB1w9aF10ma3266UkhJwugJ2Xe237/AcUu98AJ0mWShJrnsyeNI9Lc/r5UO
	GVNbtYnI8EWn/nGjON+9NWJI6CXQSLNpAU6ne+9LYILoXin9r7d5eVSN6efyl8xN2ybU
	8Ca09Y6WpgB0ALaztAQ8dt2X2OQH2oywhjmAUHFh2VLzTd6c+Xzx/GZwL7oZ3C8Fk3d3
	jKF5UKibHLqKbs8L3NK8BijGdCsU39ZGH5e60WZ5bKWLZD1wvPADmiCwxe+ZNsIQXDMx
	71EyIl1BJj9dkDjk6BJCLtlOdanGzRxAb2GpEMycn86abCne7kQUerf9KxVQlDUSBXBI
	K21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=LTrRBAzo3ZXhs7/OIQshe/0vUKzYgpD3ylIgF8SzGa8=;
	b=P2TWrznBmPY89/XJny//j0AInD7KKTygESgbyZcjwKdnFFkUMidxw9iRaD6Zrqnv0C
	VVxKm2/cU7anmTr0pT4NnOkOGOVqBblKABnWGpZ0plDg9rOe92v7HRRwmpjjnLBEKZeT
	JN8IdTocQOxdbtKBOAxwdYm1BSDTUPc0L5J87BssS3sAwjEcEjjzIK2ihBUbIiuyQFq9
	tK/aKzJYZ8uCuEL8sjffQXs9Fv9gMZ1frsJ0wo2AGMCe9+AdpeeiAvyyNjhsS15/1UTi
	H02dS1VjoHgBwLL+x1zNPNaEcHrirgXBs9/9deqzCUog6PRbSUv8wfA9C6mzZYVRRz1R
	j2vQ==
X-Gm-Message-State: APjAAAVDN4r8GeNQqKpczgchaHAv/y0OAz2NqUKz0lupkbNlujGtMhHG
	uPMaomuEEmNKOwKIYN5CBtRdSfT0vl0=
X-Google-Smtp-Source: APXvYqxy6tX9Mi6oLp0cu6mQnMLweSIFsnt80yXlbL/MnQ/JTRS8u16EaIBK4o1v7Jr+4NMSCS0Dgg==
X-Received: by 2002:a17:902:9a08:: with SMTP id
	v8mr13552234plp.105.1557501615201; 
	Fri, 10 May 2019 08:20:15 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.20.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:20:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:40 -0700
Message-Id: <20190510151944.22981-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
References: <20190510151944.22981-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PULL 23/27] target/unicore32: Convert to
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
Cc: peter.maydell@linaro.org, Guan Xuetao <gxt@mprc.pku.edu.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the user-only functions, as we no longer
have a user-only config.

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/unicore32/cpu.h       |  5 +++--
 target/unicore32/cpu.c       |  5 +----
 target/unicore32/helper.c    | 23 -----------------------
 target/unicore32/op_helper.c | 14 --------------
 target/unicore32/softmmu.c   | 19 +++++++++++++++----
 5 files changed, 19 insertions(+), 47 deletions(-)

diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 24abe5e5c0..f052ee08bf 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -178,8 +178,9 @@ static inline void cpu_get_tb_cpu_state(CPUUniCore32State *env, target_ulong *pc
     }
 }
 
-int uc32_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-                              int mmu_idx);
+bool uc32_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr);
 void uc32_translate_init(void);
 void switch_mode(CPUUniCore32State *, int);
 
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index 2b49d1ca40..3f57c508a0 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -138,11 +138,8 @@ static void uc32_cpu_class_init(ObjectClass *oc, void *data)
     cc->cpu_exec_interrupt = uc32_cpu_exec_interrupt;
     cc->dump_state = uc32_cpu_dump_state;
     cc->set_pc = uc32_cpu_set_pc;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = uc32_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = uc32_cpu_tlb_fill;
     cc->get_phys_page_debug = uc32_cpu_get_phys_page_debug;
-#endif
     cc->tcg_initialize = uc32_translate_init;
     dc->vmsd = &vmstate_uc32_cpu;
 }
diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
index a5ff2ddb74..0d4914b48d 100644
--- a/target/unicore32/helper.c
+++ b/target/unicore32/helper.c
@@ -215,29 +215,6 @@ void helper_cp1_putc(target_ulong x)
 }
 #endif
 
-#ifdef CONFIG_USER_ONLY
-void switch_mode(CPUUniCore32State *env, int mode)
-{
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
-
-    if (mode != ASR_MODE_USER) {
-        cpu_abort(CPU(cpu), "Tried to switch out of user mode\n");
-    }
-}
-
-void uc32_cpu_do_interrupt(CPUState *cs)
-{
-    cpu_abort(cs, "NO interrupt in user mode\n");
-}
-
-int uc32_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-                              int access_type, int mmu_idx)
-{
-    cpu_abort(cs, "NO mmu fault in user mode\n");
-    return 1;
-}
-#endif
-
 bool uc32_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
diff --git a/target/unicore32/op_helper.c b/target/unicore32/op_helper.c
index e0a15882d3..797ba60dc9 100644
--- a/target/unicore32/op_helper.c
+++ b/target/unicore32/op_helper.c
@@ -242,17 +242,3 @@ uint32_t HELPER(ror_cc)(CPUUniCore32State *env, uint32_t x, uint32_t i)
         return ((uint32_t)x >> shift) | (x << (32 - shift));
     }
 }
-
-#ifndef CONFIG_USER_ONLY
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    int ret;
-
-    ret = uc32_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (unlikely(ret)) {
-        /* now we have a real cpu fault */
-        cpu_loop_exit_restore(cs, retaddr);
-    }
-}
-#endif
diff --git a/target/unicore32/softmmu.c b/target/unicore32/softmmu.c
index 00c7e0d028..13678df4d7 100644
--- a/target/unicore32/softmmu.c
+++ b/target/unicore32/softmmu.c
@@ -215,8 +215,9 @@ do_fault:
     return code;
 }
 
-int uc32_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-                              int access_type, int mmu_idx)
+bool uc32_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
 {
     UniCore32CPU *cpu = UNICORE32_CPU(cs);
     CPUUniCore32State *env = &cpu->env;
@@ -257,7 +258,11 @@ int uc32_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
         phys_addr &= TARGET_PAGE_MASK;
         address &= TARGET_PAGE_MASK;
         tlb_set_page(cs, address, phys_addr, prot, mmu_idx, page_size);
-        return 0;
+        return true;
+    }
+
+    if (probe) {
+        return false;
     }
 
     env->cp0.c3_faultstatus = ret;
@@ -267,7 +272,13 @@ int uc32_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
     } else {
         cs->exception_index = UC32_EXCP_DTRAP;
     }
-    return ret;
+    cpu_loop_exit_restore(cs, retaddr);
+}
+
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    uc32_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
 }
 
 hwaddr uc32_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
-- 
2.17.1


