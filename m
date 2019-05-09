Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A41C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:20:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB70208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nvGPjlTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB70208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48828 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOcQ8-0005Ta-72
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 02:20:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc9L-0006KN-TM
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc9K-0007IJ-5T
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:23 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:34422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOc9J-0007Gu-UL
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:22 -0400
Received: by mail-pl1-x643.google.com with SMTP id w7so598209plz.1
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 23:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=LTrRBAzo3ZXhs7/OIQshe/0vUKzYgpD3ylIgF8SzGa8=;
	b=nvGPjlTb3GiXjNbaoDqBOvmFgiEejd3RRw61i/Cz3GZ42pAh1qD8ICkEw72b2OxabU
	5CosJYAT6WzgarRtge6sJzzdijd+gEHBmVVsZ+AhIptWlW/wBkrEcVpyfmyeil0tqu9l
	fk/ok82Sgwddg4TZ9QmBh7u+7ZMZy6Z1ynS73h58K914wfQoSzJKEYFTapGpAA4uJIjH
	EZfhSpTmUSj8awfRg+Pj7YcoqBrWGGIjcD5b3dtf7gA0cffPliUzGRi9k1WQ4DCQrXZv
	hhsUkzED2B8fNL7dCpedQ4Q7ZEnNNjFdAubDuE411X/aF1Wya32eIKJhEQmITsUruipS
	cOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=LTrRBAzo3ZXhs7/OIQshe/0vUKzYgpD3ylIgF8SzGa8=;
	b=rm+lSh2A17iIxH2ngJgArJsCmGWwYdOd6Xny+fJWwvhRH9JYlTqwyCkaxmapAHqMs5
	TN77IO5goXnmb21XdCDwiykzhoCfsxKc4psKJwDkkzi1p1C+UGHuE7M6i14/f4/EpEu0
	Hf6yZwC/uVgWqz92hKNsNE7NMD2eJ2net7gmHAkaD3FJAoaupjMluW2d5fuZstmt2mdn
	EWhp2GRlS7F0I1CRosbcZnW53Nm8PPZzyvwTUKOFlRqTqY6vo7zZ9c/1hCbsLGROrWoc
	7c/2RUF8lSCZegxPj23CVwneBLSkCXjZqpgKzZ4tk6aCHjwbKiXtmo4vjEJ3zoe7rPGu
	2Chg==
X-Gm-Message-State: APjAAAX6X3l0IYy1K5I1qZriwHiwG1gOIZQnSooeXtivJ9PPoXxJj7/E
	RqbE5oFWLpbUD78n2x0eLHLKJzVheX8=
X-Google-Smtp-Source: APXvYqx82VqwNBAggMBFKts4cKNvFfIZWIQGJiNE8nOwLVfALC0psvD70vO1jALQEftRIOq2pzlPjw==
X-Received: by 2002:a17:902:aa45:: with SMTP id
	c5mr2714237plr.144.1557381798986; 
	Wed, 08 May 2019 23:03:18 -0700 (PDT)
Received: from localhost.localdomain (97-113-27-95.tukw.qwest.net.
	[97.113.27.95])
	by smtp.gmail.com with ESMTPSA id n7sm1496109pff.45.2019.05.08.23.03.17
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 23:03:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 23:02:42 -0700
Message-Id: <20190509060246.4031-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509060246.4031-1-richard.henderson@linaro.org>
References: <20190509060246.4031-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v2 23/27] target/unicore32: Convert to
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
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
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


