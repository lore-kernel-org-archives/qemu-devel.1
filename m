Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2379C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CAF020578
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y6l5WHcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CAF020578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45148 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7UL-0001HR-MO
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:31:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jd-0007cO-S9
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jc-0008VE-Ok
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:05 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7Jc-0008Uo-J1
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:04 -0400
Received: by mail-pl1-x644.google.com with SMTP id d3so2980358plj.11
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=SbdgfaYjW8ILfhiu0/mJqWKm/tBVnd5f44zvoNG8J24=;
	b=y6l5WHcHxqFLU9fWsT7tDzRc9SXW6pDNL6PQ8C9TsYLdi44PWcsYQm2e6IS/6Dq+jQ
	1BZBcyL1FWghSJkzRBXbh+OEIro96F/sUu6Lq8HFuWUchlIR+hXZugk6TDRtN4oTLB6G
	+Nwht7yr6g/JnuSbPaK0ZNUbhQFyN2j1QcQ4E67dsadZ3tRnQd5Uh20hqSKR2YJH6pzQ
	muf1g2VplOlVhXmnFdJ3o1MU5f6H3LbaLkqFX9RjcncKFR7ceHKZqkP4sdd50Fz89IFG
	ysnesyb4oAj8pDOAEIqCoHScdXpFNl9nSsjRO4RxYWWJLB5lLgu90pJLdY6D/Ms/TxIH
	G9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=SbdgfaYjW8ILfhiu0/mJqWKm/tBVnd5f44zvoNG8J24=;
	b=CEzE7/qHaA3kZYtrUTm9Gxa1GtE9KxhQgU5tmUs07Hb3KwCK2c8O6jUf5xh3g9qSe9
	5rgoa6aRHyXVt8QskM//Ap0PqfepMau7/otZkle8XZiXPMf3Ur+bzCEYsPR9QPfP83H7
	zgFWkipqSCzq0xoRdwRIdILqe+WjzR0PIXbh13S5Nso+vP8CcHlAvHVUvP0LkgXwTVcW
	mmrDQrHIBbBjC2rzOoC20hbKPUH8EQb+VQJoPDK+GJ9B/Wzt7vCNJ/5a9evXk6iV9oF1
	WbNPnbczG/YS7Psg5+Fg2QFqQNJN7mevcR4B8QNVtOevV3cpWZC7fjW2SY+WGh4clcF6
	tH1g==
X-Gm-Message-State: APjAAAW8En4rmEWcvIB2vDBVRRQmVHCKHiBPypFEFJjfrP4JwYJkVn+6
	jJ9TbgeKEc2vVYhItS/+8QIPOV/oOxE=
X-Google-Smtp-Source: APXvYqxPf8oyXDmi4u4MU/TQdiqNLqejVEXE0mmrquGfxCoTP+EizyTuMBWd8bRQqBws21sjRwm0/w==
X-Received: by 2002:a17:902:59db:: with SMTP id
	d27mr14068990plj.332.1557501603260; 
	Fri, 10 May 2019 08:20:03 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.20.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:20:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:30 -0700
Message-Id: <20190510151944.22981-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
References: <20190510151944.22981-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PULL 13/27] target/moxie: Convert to
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
Cc: peter.maydell@linaro.org, Anthony Green <green@moxielogic.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the user-only functions, as we don't have a user-only config.
Fix the unconditional call to tlb_set_page, even if the translation
failed.

Cc: Anthony Green <green@moxielogic.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/moxie/cpu.h    |  5 ++--
 target/moxie/cpu.c    |  5 ++--
 target/moxie/helper.c | 61 ++++++++++---------------------------------
 3 files changed, 19 insertions(+), 52 deletions(-)

diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index f3b6d83ae7..a63a96bc05 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -139,7 +139,8 @@ static inline void cpu_get_tb_cpu_state(CPUMoxieState *env, target_ulong *pc,
     *flags = 0;
 }
 
-int moxie_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
-                               int rw, int mmu_idx);
+bool moxie_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr);
 
 #endif /* MOXIE_CPU_H */
diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 46434e65ba..02b2b47574 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -112,9 +112,8 @@ static void moxie_cpu_class_init(ObjectClass *oc, void *data)
     cc->do_interrupt = moxie_cpu_do_interrupt;
     cc->dump_state = moxie_cpu_dump_state;
     cc->set_pc = moxie_cpu_set_pc;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = moxie_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = moxie_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->get_phys_page_debug = moxie_cpu_get_phys_page_debug;
     cc->vmsd = &vmstate_moxie_cpu;
 #endif
diff --git a/target/moxie/helper.c b/target/moxie/helper.c
index 287a45232c..216cef057e 100644
--- a/target/moxie/helper.c
+++ b/target/moxie/helper.c
@@ -26,18 +26,10 @@
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 
-/* Try to fill the TLB and return an exception if error. If retaddr is
-   NULL, it means that the function was called in C code (i.e. not
-   from generated code or from helper.c) */
 void tlb_fill(CPUState *cs, target_ulong addr, int size,
               MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
-    int ret;
-
-    ret = moxie_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (unlikely(ret)) {
-        cpu_loop_exit_restore(cs, retaddr);
-    }
+    moxie_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
 }
 
 void helper_raise_exception(CPUMoxieState *env, int ex)
@@ -85,53 +77,29 @@ void helper_debug(CPUMoxieState *env)
     cpu_loop_exit(cs);
 }
 
-#if defined(CONFIG_USER_ONLY)
-
-void moxie_cpu_do_interrupt(CPUState *cs)
-{
-    CPUState *cs = CPU(moxie_env_get_cpu(env));
-
-    cs->exception_index = -1;
-}
-
-int moxie_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-                               int rw, int mmu_idx)
-{
-    MoxieCPU *cpu = MOXIE_CPU(cs);
-
-    cs->exception_index = 0xaa;
-    cpu->env.debug1 = address;
-    cpu_dump_state(cs, stderr, 0);
-    return 1;
-}
-
-#else /* !CONFIG_USER_ONLY */
-
-int moxie_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-                               int rw, int mmu_idx)
+bool moxie_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr)
 {
     MoxieCPU *cpu = MOXIE_CPU(cs);
     CPUMoxieState *env = &cpu->env;
     MoxieMMUResult res;
     int prot, miss;
-    target_ulong phy;
-    int r = 1;
 
     address &= TARGET_PAGE_MASK;
     prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-    miss = moxie_mmu_translate(&res, env, address, rw, mmu_idx);
-    if (miss) {
-        /* handle the miss.  */
-        phy = 0;
-        cs->exception_index = MOXIE_EX_MMU_MISS;
-    } else {
-        phy = res.phy;
-        r = 0;
+    miss = moxie_mmu_translate(&res, env, address, access_type, mmu_idx);
+    if (likely(!miss)) {
+        tlb_set_page(cs, address, res.phy, prot, mmu_idx, TARGET_PAGE_SIZE);
+        return true;
+    }
+    if (probe) {
+        return false;
     }
-    tlb_set_page(cs, address, phy, prot, mmu_idx, TARGET_PAGE_SIZE);
-    return r;
-}
 
+    cs->exception_index = MOXIE_EX_MMU_MISS;
+    cpu_loop_exit_restore(cs, retaddr);
+}
 
 void moxie_cpu_do_interrupt(CPUState *cs)
 {
@@ -156,4 +124,3 @@ hwaddr moxie_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     }
     return phy;
 }
-#endif
-- 
2.17.1


