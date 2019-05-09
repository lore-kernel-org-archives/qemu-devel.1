Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8F2C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49156208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jDwQO+o4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49156208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48708 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOcIr-00071g-Dn
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 02:13:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc95-00064N-Kz
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc94-00078i-GQ
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:07 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOc94-00078I-AW
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:06 -0400
Received: by mail-pg1-x544.google.com with SMTP id t22so619389pgi.10
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 23:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=SbdgfaYjW8ILfhiu0/mJqWKm/tBVnd5f44zvoNG8J24=;
	b=jDwQO+o4P71Y4cY4cnQJeEsM1kiC9c3aZ+io9ORyRcq/WdPUtcEXUzJAYv2s4lGujG
	fMQSrDFlbvxjOMr9pz5esRYICstDy7yr97zTTHoBoHilP/fq8JUreeW/m/7XX0Cu6YRR
	meHzUNKLIbY1n4ATASKb5HAOMdks+u4OoNXdWH5KGtgqqUERny9aGNdjsGnY3keP0p01
	Ni3jlhOEjxcRkk36wwaZM+rchm3JOg3g6MBeFAhV9c6jLtSd/SJQWBv6596fGxbJVfmw
	Tb3SB6S6+0XWpMVEMKX+Fp6B5VVn01+wtcI0GCvmMoimI+fKG11C3raqPWZKp09OXoIV
	6ZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=SbdgfaYjW8ILfhiu0/mJqWKm/tBVnd5f44zvoNG8J24=;
	b=QZ3VU8KI3T/Hb0nvuRZ4IRtj5/t15OXYAKvGeiBO1/K+uaNprXmyVP8b8dTHq7uTTC
	PZ3qF3r+dc5EIcPoZhv+z3a7CjWMglhqi5w/zV5+MsUw+0gC01k3hjU8SZ1c85fuL+J2
	t8G8OFhCXZ07uG+rNhTY1Aj5mza9Pgd0grVvAJIG0iZE7ZeyljS5us00eDWaXCUNRyde
	qbO/B7XPviDWYaEc44SqeRioiOLmiKy6wq8Icrg0zgzgh+pQNHlpW4ceyX9Eo8iXm0gp
	6/bzaEi1IunG0P4c+XvAZc9sKD8g8v9xz1skocrfY/n1Z98f3XiNpeTg5ffjWaz+6UqA
	qY4g==
X-Gm-Message-State: APjAAAUqkzUzPtdO3DYxVKzG4jZru1jEiLcPleanJb/VAzd1LEKdywSz
	WAll8fN76sWLrEsxg6jGBKydbxp/Zg4=
X-Google-Smtp-Source: APXvYqxru0U+okKZnXv8HFwn+w6p8xaakgPOQ6BtRHZ+Qne6Hj4WSeMJvrhQs+C1T2xOUQvQylJWwQ==
X-Received: by 2002:aa7:81d0:: with SMTP id c16mr2567292pfn.132.1557381785073; 
	Wed, 08 May 2019 23:03:05 -0700 (PDT)
Received: from localhost.localdomain (97-113-27-95.tukw.qwest.net.
	[97.113.27.95])
	by smtp.gmail.com with ESMTPSA id n7sm1496109pff.45.2019.05.08.23.03.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 23:03:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 23:02:32 -0700
Message-Id: <20190509060246.4031-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509060246.4031-1-richard.henderson@linaro.org>
References: <20190509060246.4031-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v2 13/27] target/moxie: Convert to
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


