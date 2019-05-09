Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D6BC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:46:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F83D21744
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Brerx8jF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F83D21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33743 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOrna-0007On-FA
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 18:45:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrV2-0007ew-24
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrV0-0005Sz-Ns
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:48 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOrV0-0005Sm-Fv
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:46 -0400
Received: by mail-pg1-x541.google.com with SMTP id d31so1922864pgl.7
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 15:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=omewBU1W56CpN9jkgUsDwQLimncwo01SMHqSrNfd+ko=;
	b=Brerx8jFb4MLhY62NvxRp9Pgh4FR2LpBx+8FtNax2NdnECPCS9c4jMULj9VAuZMYcz
	p+3Mn4PsGnxw1SEWA1hETuvKlyq7V8MuYbWVGXTTEAGXXfTM4JxYY9PWcq1zX8UL4Hpj
	wCTEtT2v0giesTWApQYqYvKAdb3vrhLR0dL0OAfs23MLxj2PmoGLkmJsgycJhc8MO+kY
	fUfYoQ6J+lmNhLgfsP6FcEQK41W8EzzzDbMBLMeIk6/FAQl1cIUMCclMiiOQzMgAMSP5
	jEwe3Fc8m37jydEeDy/vNTWjf5lV9U95JdKK6Aac0KBZxY/D168PmqDAyUcCpSJ3uYdP
	YAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=omewBU1W56CpN9jkgUsDwQLimncwo01SMHqSrNfd+ko=;
	b=D1adRGlBbZKs2LUV2tb36Eynbmj0i4aKsIB/mvg5CzD+xUU+VQZjMRxgav7stNiyea
	C5wNBb/LKlP6sHx+5Gog7Ows8Uoo5VQwAEvyjK32ldZmh+3A5NsfhL4hscigd3gvdYVI
	Cmrbf4byqGz65cOQZaRmKsgA2Tz+bA3U6rvSx7B8PuMLeW1k5v6yqDgQrqY5j6Nf/fsm
	sbYppy5ppuTbO50p7IISG9LJ25jNKy+jsd/9TNCvCpfhoERa74g+tGIbJygobgAkHJ2E
	Jm8hkH2OTjUFhCANePdKVvOSqTziqL4O66jR2Ja9W+qHP6qJ/giurHS1/ryo1Dp3oI6a
	svfQ==
X-Gm-Message-State: APjAAAU7SmchG7C6qvhfxg1VgQj3X8LZ7AUIPhLWEpbGBhCIkfRiJjmW
	UcD2qCd7KKghTmtVd6Tbwmbi/G5m45A=
X-Google-Smtp-Source: APXvYqxZCoWZ5vWRJxcKnbbtohhKE+0xPrpH/ufVz57H0uixcWvuUwCnlfg1lOdHDCtugVB+7pDJrg==
X-Received: by 2002:aa7:8acb:: with SMTP id b11mr8920814pfd.115.1557440805289; 
	Thu, 09 May 2019 15:26:45 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m2sm4490521pfi.24.2019.05.09.15.26.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 15:26:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 15:26:13 -0700
Message-Id: <20190509222631.14271-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509222631.14271-1-richard.henderson@linaro.org>
References: <20190509222631.14271-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v3 09/27] target/microblaze: Convert to
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


