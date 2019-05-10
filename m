Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ECCC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B82A62177B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UoWgTuLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82A62177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45385 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7j8-000712-0s
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:46:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jr-0007sm-HU
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jq-0000K7-6Z
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:19 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:32819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7Jp-0000JY-WC
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:18 -0400
Received: by mail-pf1-x42c.google.com with SMTP id z28so3419549pfk.0
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=bWfPEK+qkU+H+gRl4yZYfGof/Snf7uW20Ba+qkEL858=;
	b=UoWgTuLQZR1/s5vdZUOVe5/548PhR4bjgDwviQ5/ypWDXRVGNHotq52am3pdItJ7/V
	krQ2CZyHn6DsbECkPiFiJpq9EbKKi3ZCQBQCqSpTXOGJ/jnA3+vtgUty0V+6b9pCOQID
	ZpfS5PHY92BR018U3FcQEUHulqSjdIEspu5krE+E4jSep3RYh44SsdSfOvTXdknHVdjN
	RSahWcHRAqPGbcQ0gU8y66f8FPDHnZpy7Q4nSv89pvM4FHUw5ByV+HQmurc5uHF+BxZ5
	FGAitO8SxCArx9N1OPby0+r9UumgEa6+QCyvzj4kvf4Va2dx2wdZF7W1Orb0InOT9jFQ
	pivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=bWfPEK+qkU+H+gRl4yZYfGof/Snf7uW20Ba+qkEL858=;
	b=cTQyXY9Hrpqv7OFdPsg0MX5l8DqEKG5EiXhZLTeNaABB58BQsoCBl2eM+6+xJ7TAsB
	OLUgI8Y+SdnCNlQ5KdnHTWyjZDoB4b60kQqTKb15xlv6OXl+hRl2S98JyrQmubnljgih
	yg/E22nblSiYcYXDzbxbxIvD8RPQNoz+IEwLto90RVjkI90nTSk5brAlylTNwqFqWNw7
	RBnTDX9NSxn1msDpQ6fFyVG6MeEkxiwMoM+KHZgW8ZEl3VBrGXzmpCuqUi1HYxcLbyTg
	kO/liENz6ArwgbnSP4sP0YZsy28zg3wfzqT8jqMwU4ixDg60MnjI6zf0XsKv+Vyxg52k
	RxtA==
X-Gm-Message-State: APjAAAW7JGr/cgRjNszq2K/KFY2uQN0OUGigP2YNOuQ2IKTls9ViEARt
	hYULQMsbxutRSZrW7p7is52EM7DkxYA=
X-Google-Smtp-Source: APXvYqxRrSzUMLXBVDjIpDD2Ip9mllM2Ch1rQKEosvnfdvjB7NFQzCMD9n7enEly/G53rDL+3htUMA==
X-Received: by 2002:a62:3381:: with SMTP id z123mr15461144pfz.42.1557501616646;
	Fri, 10 May 2019 08:20:16 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.20.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:20:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:41 -0700
Message-Id: <20190510151944.22981-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
References: <20190510151944.22981-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42c
Subject: [Qemu-devel] [PULL 24/27] target/xtensa: Convert to
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
Cc: peter.maydell@linaro.org, Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/cpu.h    |  5 +++--
 target/xtensa/cpu.c    |  5 ++---
 target/xtensa/helper.c | 39 ++++++++++++++++++++++++++-------------
 3 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 5d23e1345b..68d89f8faf 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -552,8 +552,9 @@ static inline XtensaCPU *xtensa_env_get_cpu(const CPUXtensaState *env)
 #define ENV_OFFSET offsetof(XtensaCPU, env)
 
 
-int xtensa_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw, int size,
-                                int mmu_idx);
+bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                         MMUAccessType access_type, int mmu_idx,
+                         bool probe, uintptr_t retaddr);
 void xtensa_cpu_do_interrupt(CPUState *cpu);
 bool xtensa_cpu_exec_interrupt(CPUState *cpu, int interrupt_request);
 void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index a54dbe4260..da1236377e 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -181,9 +181,8 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_read_register = xtensa_cpu_gdb_read_register;
     cc->gdb_write_register = xtensa_cpu_gdb_write_register;
     cc->gdb_stop_before_watchpoint = true;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = xtensa_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = xtensa_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->do_unaligned_access = xtensa_cpu_do_unaligned_access;
     cc->get_phys_page_debug = xtensa_cpu_get_phys_page_debug;
     cc->do_transaction_failed = xtensa_cpu_do_transaction_failed;
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 5f37f378a3..5c94f934dd 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -240,19 +240,21 @@ void xtensa_cpu_list(void)
 
 #ifdef CONFIG_USER_ONLY
 
-int xtensa_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                                int mmu_idx)
+bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                         MMUAccessType access_type, int mmu_idx,
+                         bool probe, uintptr_t retaddr)
 {
     XtensaCPU *cpu = XTENSA_CPU(cs);
     CPUXtensaState *env = &cpu->env;
 
     qemu_log_mask(CPU_LOG_INT,
                   "%s: rw = %d, address = 0x%08" VADDR_PRIx ", size = %d\n",
-                  __func__, rw, address, size);
+                  __func__, access_type, address, size);
     env->sregs[EXCVADDR] = address;
-    env->sregs[EXCCAUSE] = rw ? STORE_PROHIBITED_CAUSE : LOAD_PROHIBITED_CAUSE;
+    env->sregs[EXCCAUSE] = (access_type == MMU_DATA_STORE ?
+                            STORE_PROHIBITED_CAUSE : LOAD_PROHIBITED_CAUSE);
     cs->exception_index = EXC_USER;
-    return 1;
+    cpu_loop_exit_restore(cs, retaddr);
 }
 
 #else
@@ -273,31 +275,42 @@ void xtensa_cpu_do_unaligned_access(CPUState *cs,
     }
 }
 
-void tlb_fill(CPUState *cs, target_ulong vaddr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                         MMUAccessType access_type, int mmu_idx,
+                         bool probe, uintptr_t retaddr)
 {
     XtensaCPU *cpu = XTENSA_CPU(cs);
     CPUXtensaState *env = &cpu->env;
     uint32_t paddr;
     uint32_t page_size;
     unsigned access;
-    int ret = xtensa_get_physical_addr(env, true, vaddr, access_type, mmu_idx,
-                                       &paddr, &page_size, &access);
+    int ret = xtensa_get_physical_addr(env, true, address, access_type,
+                                       mmu_idx, &paddr, &page_size, &access);
 
-    qemu_log_mask(CPU_LOG_MMU, "%s(%08x, %d, %d) -> %08x, ret = %d\n",
-                  __func__, vaddr, access_type, mmu_idx, paddr, ret);
+    qemu_log_mask(CPU_LOG_MMU, "%s(%08" VADDR_PRIx
+                  ", %d, %d) -> %08x, ret = %d\n",
+                  __func__, address, access_type, mmu_idx, paddr, ret);
 
     if (ret == 0) {
         tlb_set_page(cs,
-                     vaddr & TARGET_PAGE_MASK,
+                     address & TARGET_PAGE_MASK,
                      paddr & TARGET_PAGE_MASK,
                      access, mmu_idx, page_size);
+        return true;
+    } else if (probe) {
+        return false;
     } else {
         cpu_restore_state(cs, retaddr, true);
-        HELPER(exception_cause_vaddr)(env, env->pc, ret, vaddr);
+        HELPER(exception_cause_vaddr)(env, env->pc, ret, address);
     }
 }
 
+void tlb_fill(CPUState *cs, target_ulong vaddr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    xtensa_cpu_tlb_fill(cs, vaddr, size, access_type, mmu_idx, false, retaddr);
+}
+
 void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                       unsigned size, MMUAccessType access_type,
                                       int mmu_idx, MemTxAttrs attrs,
-- 
2.17.1


