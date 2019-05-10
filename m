Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABFCC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A612175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E72R3Yj6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A612175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45232 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7as-00084M-GY
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:37:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7JZ-0007Wl-2z
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7JX-0008Rr-QJ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:01 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7JX-0008RI-Id
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:19:59 -0400
Received: by mail-pg1-x543.google.com with SMTP id c13so3193993pgt.1
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=+7y06FOuP0C5aG2mOuHskCnd9OAXBDISnnNJ70hVpew=;
	b=E72R3Yj6L0iATHOIucHI0+wjwGaoWYGUrNwMcXXPNSfClCB2moQ6KZDoLfHsE4CdVV
	vQOf0yqiG3KB6R3+uABaT6aSTxM40NF6Jt5mtvCvfcLwPcjK9p6DLJa0HaO0dWS5zbKQ
	Lbm6EysukqLqcXV2Nm89MCtCBerMMtxkv5/bKiqiHh5OQ4yYTMp+8wuMUv9uWlH/4M++
	CC7SZQZt8z/3NWreg4k56aL7JFiWcxBsQUMWUDVNSrPmkbuHE4effcsVWnYs7vHZbZro
	r/G80eL/L8W6q4Ko94at055OEtMdp7ZXXc7CSEH4tYN6yj+sFjbbZum4vOgQ3EkLKZ8N
	RCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=+7y06FOuP0C5aG2mOuHskCnd9OAXBDISnnNJ70hVpew=;
	b=YkS6UYb8915lBDqpINd628XEeOSFmQxqiqnk7ZAgCoxEwURyjjKOmsUUrcxl6XKLdX
	jNqGGKcwCXWOn00FS4nbi90EmeOurP7mp6O22bzEAXIknqjfIbGvUG4BpBLpgE6HBcw6
	Adp0JAqrO9weABZqymMx1z4yQatt/fHEE/tM48VBUrUvSAnzd+7CrzXyM/D3RVCeOTy5
	XldNIv1y6rw68JFrTRWAOJYnET8RaZl5J4bphxDmYnCaZRSI3+ja3y9X4S9piSIi+iR5
	Ok+iiRHy4I8TpdwTM/ZON7VG9U0NjLPvsaTKt95nmSVodKIka4jNPhySqiXdVpIGc7Pl
	pYkQ==
X-Gm-Message-State: APjAAAWIcQtVXF1mqCnyBvoenrnDZWDnB7gFWgDg+EJTJu7IAyGclQcW
	5TPg828Pu2PjI0SCoKk8vcZsuG5foTI=
X-Google-Smtp-Source: APXvYqwkLAKs07ynckfyAybJNT4TyouwMrR2le66x2vrTYD9gCFSMN/KBae/gHSv7aNN55OKQhOWMg==
X-Received: by 2002:a62:6444:: with SMTP id y65mr15063612pfb.148.1557501598314;
	Fri, 10 May 2019 08:19:58 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.19.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:19:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:26 -0700
Message-Id: <20190510151944.22981-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
References: <20190510151944.22981-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PULL 09/27] target/microblaze: Convert to
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
Cc: peter.maydell@linaro.org, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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


