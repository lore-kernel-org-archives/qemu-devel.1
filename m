Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D860C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0618C2173B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yrmaTw1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0618C2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33446 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOrWx-0000Wx-4g
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 18:28:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrV6-0007ju-Im
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrV5-0005VB-Dk
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:52 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOrV5-0005Uo-7E
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:51 -0400
Received: by mail-pf1-x443.google.com with SMTP id n19so2057572pfa.1
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 15:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=SbdgfaYjW8ILfhiu0/mJqWKm/tBVnd5f44zvoNG8J24=;
	b=yrmaTw1isYlaWL0h+7ulMQ5InyN7qPN1b6Vv8b3I86iMq+GoPcz0+KSzsakznlng0B
	JDD5fj8I4FK3bxucKKhEpvlWt+7wCYbD6jHWh6fI49PU8Sd9OKat5nuo2w3taJSvOkkI
	8GNDqQjYUPDWUnOgHgwt/C2DzyeHctU07jK++Vdg6v9Gmr9bdcO445CPlddAN885sMqr
	WLW9oSlyEDJw8+FN9SQ2D8gRQw45siWMhhLMNF+TIp7PC9EaDWGTywBsRHOP4n5TiCxr
	OyVJkoB4mv7eodqTpo+N6/d7uMfpBWr+N+bx7ZGe7I7IFpjRvxKRFo+ZdUPwTHkHlryt
	/VrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=SbdgfaYjW8ILfhiu0/mJqWKm/tBVnd5f44zvoNG8J24=;
	b=HucpIPX2+9GhkFk9PWJr1hW+BuSqN6lWnr2MOdGQx+KQ0fdIgjzEwpiypQGwyV/mbX
	l9QeccyquBIdkiaJd6tY5FE3Sk9RCsROkxb6DKEu4RttjLypXw4L98MfYjncSh80n05P
	NUlW3J8TfdH7x8UCALEnfDkexQEXpqWPmiWUHCnXPfirfdAYQOt7LrbQSKfdk8GN2uPj
	HA7ENbSDbGpRH/RbELY3jXp/IjWhvd0/C3ICQZ2YpBFdtsc000RzD965RfhZuBpvBHsx
	WPAcQYRBdA3idtWm9kUWx3cFLzkfZbMpc5Uro/HaXaSxIBCuypoEOwEUYs0uxLdXkuSo
	iv9g==
X-Gm-Message-State: APjAAAVk/v6VrvXSFZ1Es5ZI/rnRQAXfaWsmmLZyatkHyeWNnwApib+I
	sGAkP8hcQd/wUH/5N1dCX3655bvr9do=
X-Google-Smtp-Source: APXvYqwpxgHkkUFlnOasIkZ8iKDO2JPj61Cs4qqWju6M7Zvv4H4rixRKjU6369WnXE0MfMbzdUYWZg==
X-Received: by 2002:aa7:8ec6:: with SMTP id b6mr8882550pfr.234.1557440809813; 
	Thu, 09 May 2019 15:26:49 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m2sm4490521pfi.24.2019.05.09.15.26.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 15:26:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 15:26:17 -0700
Message-Id: <20190509222631.14271-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509222631.14271-1-richard.henderson@linaro.org>
References: <20190509222631.14271-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v3 13/27] target/moxie: Convert to
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
Cc: Anthony Green <green@moxielogic.com>
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


