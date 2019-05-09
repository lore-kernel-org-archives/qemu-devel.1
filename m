Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E31DC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B32B20675
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rjgGBBD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B32B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48631 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOcEg-0002px-PG
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 02:08:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc90-00060C-1n
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc8y-00075Q-Nq
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:01 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOc8y-000753-GJ
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:00 -0400
Received: by mail-pg1-x541.google.com with SMTP id z3so625224pgp.8
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 23:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Q91Bo01jfOxEub4sI+gq9ksRxZGSeHiaqcM2+tSVbC8=;
	b=rjgGBBD6rOcH09oZ+839j2/bdiSVeWnx63++rqD+v6YdQApzWt0hzI3ZdWJnQl8EfO
	M3s63XqQf3qmoEy3kPhPmhbnsCMYU6DDjIVzXKcx7dTaehU7foiU0z6WKW7WJFuRxezi
	ORcXy8F0N7OszfDtQpljU8xko9mimm19lO26GTJ/bSaBKI19yP+azjbl1yeQ2W10lZ56
	NN+ITH7lqV6gxQLnyb9HrIBfeXq97koUZqdeSBRvB1aFID1a4xgUna1Dl0q7lyomlHP6
	T0xCQAzS7Ti1fpx8pukkZSPkewNXl5NOj6TTB6JXBCGH2Pzx2hpB/8RfCBu1gd0Ft/nb
	tEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Q91Bo01jfOxEub4sI+gq9ksRxZGSeHiaqcM2+tSVbC8=;
	b=qPtaAGzRAoa6HrXOrZ+tUYX++z2R/9wk9dy4czIWUY1TzUNw3R3hOoQtC0d5qC2P9E
	VA3fvlNDlXNnsPYHQaXNyf2tal4inVr5oJ3jXJmMFI87+HDulnuUaouBr5eRxv77Egzx
	ExYKcryPlcF7af0GlYViDefpeESuKjWDd6306GFtyBQ3OWHVLo/XOflac8tfmaXsMVcO
	jUBtahpiM8NhXV/kVWUqlB57E28AqMadzGN95y8PNAa3DN66FYRa2y6SYgzG/mQCquQB
	TAoCtwZR8Gj7yBNvQJiPROIs5mTIkQ7Z1/hmS0XV72IHiMX2CuQvOJp/fpv0g/WIQdfF
	FPeA==
X-Gm-Message-State: APjAAAXdpv6pULMR75EZJR2z3N+AQlpv1zaNcxL1P6vXd4ex1TDyTDTi
	NI6D09VJAfQpofjlIIgDy1Bc5BershE=
X-Google-Smtp-Source: APXvYqzZyyrF2IJ0i2u0j+HSvmoAboAk5OwxHek4nc4E9k1sQCOBDOdib/3XMR4p2Yr+ngRLj7RgWA==
X-Received: by 2002:a62:3501:: with SMTP id c1mr2631203pfa.184.1557381779278; 
	Wed, 08 May 2019 23:02:59 -0700 (PDT)
Received: from localhost.localdomain (97-113-27-95.tukw.qwest.net.
	[97.113.27.95])
	by smtp.gmail.com with ESMTPSA id n7sm1496109pff.45.2019.05.08.23.02.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 23:02:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 23:02:28 -0700
Message-Id: <20190509060246.4031-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509060246.4031-1-richard.henderson@linaro.org>
References: <20190509060246.4031-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v2 09/27] target/microblaze: Convert to
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Keep user-only and system tlb_fill separate.
---
 target/microblaze/cpu.h       |   5 +-
 target/microblaze/cpu.c       |   5 +-
 target/microblaze/helper.c    | 107 ++++++++++++++++++----------------
 target/microblaze/op_helper.c |  19 ------
 4 files changed, 62 insertions(+), 74 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index f20e796865..7a9fb8f4aa 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -374,8 +374,9 @@ static inline int cpu_mmu_index (CPUMBState *env, bool ifetch)
     return MMU_KERNEL_IDX;
 }
 
-int mb_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-                            int mmu_idx);
+bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                     MMUAccessType access_type, int mmu_idx,
+                     bool probe, uintptr_t retaddr);
 
 #include "exec/cpu-all.h"
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 5596cd5485..0ea549910b 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -304,9 +304,8 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
     cc->set_pc = mb_cpu_set_pc;
     cc->gdb_read_register = mb_cpu_gdb_read_register;
     cc->gdb_write_register = mb_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = mb_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = mb_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->do_transaction_failed = mb_cpu_transaction_failed;
     cc->get_phys_page_debug = mb_cpu_get_phys_page_debug;
 #endif
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 9848e31d7f..a523c77959 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -38,73 +38,80 @@ void mb_cpu_do_interrupt(CPUState *cs)
     env->regs[14] = env->sregs[SR_PC];
 }
 
-int mb_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                            int mmu_idx)
+bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                     MMUAccessType access_type, int mmu_idx,
+                     bool probe, uintptr_t retaddr)
 {
     cs->exception_index = 0xaa;
-    cpu_dump_state(cs, stderr, 0);
-    return 1;
+    cpu_loop_exit_restore(cs, retaddr);
 }
 
 #else /* !CONFIG_USER_ONLY */
 
-int mb_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                            int mmu_idx)
+bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                     MMUAccessType access_type, int mmu_idx,
+                     bool probe, uintptr_t retaddr)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
+    struct microblaze_mmu_lookup lu;
     unsigned int hit;
-    int r = 1;
     int prot;
 
-    /* Translate if the MMU is available and enabled.  */
-    if (mmu_idx != MMU_NOMMU_IDX) {
-        uint32_t vaddr, paddr;
-        struct microblaze_mmu_lookup lu;
-
-        hit = mmu_translate(&env->mmu, &lu, address, rw, mmu_idx);
-        if (hit) {
-            vaddr = address & TARGET_PAGE_MASK;
-            paddr = lu.paddr + vaddr - lu.vaddr;
-
-            qemu_log_mask(CPU_LOG_MMU, "MMU map mmu=%d v=%x p=%x prot=%x\n",
-                    mmu_idx, vaddr, paddr, lu.prot);
-            tlb_set_page(cs, vaddr, paddr, lu.prot, mmu_idx, TARGET_PAGE_SIZE);
-            r = 0;
-        } else {
-            env->sregs[SR_EAR] = address;
-            qemu_log_mask(CPU_LOG_MMU, "mmu=%d miss v=%" VADDR_PRIx "\n",
-                                        mmu_idx, address);
-
-            switch (lu.err) {
-                case ERR_PROT:
-                    env->sregs[SR_ESR] = rw == 2 ? 17 : 16;
-                    env->sregs[SR_ESR] |= (rw == 1) << 10;
-                    break;
-                case ERR_MISS:
-                    env->sregs[SR_ESR] = rw == 2 ? 19 : 18;
-                    env->sregs[SR_ESR] |= (rw == 1) << 10;
-                    break;
-                default:
-                    abort();
-                    break;
-            }
-
-            if (cs->exception_index == EXCP_MMU) {
-                cpu_abort(cs, "recursive faults\n");
-            }
-
-            /* TLB miss.  */
-            cs->exception_index = EXCP_MMU;
-        }
-    } else {
+    if (mmu_idx == MMU_NOMMU_IDX) {
         /* MMU disabled or not available.  */
         address &= TARGET_PAGE_MASK;
         prot = PAGE_BITS;
         tlb_set_page(cs, address, address, prot, mmu_idx, TARGET_PAGE_SIZE);
-        r = 0;
+        return true;
     }
-    return r;
+
+    hit = mmu_translate(&env->mmu, &lu, address, access_type, mmu_idx);
+    if (likely(hit)) {
+        uint32_t vaddr = address & TARGET_PAGE_MASK;
+        uint32_t paddr = lu.paddr + vaddr - lu.vaddr;
+
+        qemu_log_mask(CPU_LOG_MMU, "MMU map mmu=%d v=%x p=%x prot=%x\n",
+                      mmu_idx, vaddr, paddr, lu.prot);
+        tlb_set_page(cs, vaddr, paddr, lu.prot, mmu_idx, TARGET_PAGE_SIZE);
+        return true;
+    }
+
+    /* TLB miss.  */
+    if (probe) {
+        return false;
+    }
+
+    qemu_log_mask(CPU_LOG_MMU, "mmu=%d miss v=%" VADDR_PRIx "\n",
+                  mmu_idx, address);
+
+    env->sregs[SR_EAR] = address;
+    switch (lu.err) {
+    case ERR_PROT:
+        env->sregs[SR_ESR] = access_type == MMU_INST_FETCH ? 17 : 16;
+        env->sregs[SR_ESR] |= (access_type == MMU_DATA_STORE) << 10;
+        break;
+    case ERR_MISS:
+        env->sregs[SR_ESR] = access_type == MMU_INST_FETCH ? 19 : 18;
+        env->sregs[SR_ESR] |= (access_type == MMU_DATA_STORE) << 10;
+        break;
+    default:
+        abort();
+    }
+
+    if (cs->exception_index == EXCP_MMU) {
+        cpu_abort(cs, "recursive faults\n");
+    }
+
+    /* TLB miss.  */
+    cs->exception_index = EXCP_MMU;
+    cpu_loop_exit_restore(cs, retaddr);
+}
+
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    mb_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
 }
 
 void mb_cpu_do_interrupt(CPUState *cs)
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index e23dcfdc20..b5dbb90d05 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -28,25 +28,6 @@
 
 #define D(x)
 
-#if !defined(CONFIG_USER_ONLY)
-
-/* Try to fill the TLB and return an exception if error. If retaddr is
- * NULL, it means that the function was called in C code (i.e. not
- * from generated code or from helper.c)
- */
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    int ret;
-
-    ret = mb_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (unlikely(ret)) {
-        /* now we have a real cpu fault */
-        cpu_loop_exit_restore(cs, retaddr);
-    }
-}
-#endif
-
 void helper_put(uint32_t id, uint32_t ctrl, uint32_t data)
 {
     int test = ctrl & STREAM_TEST;
-- 
2.17.1


