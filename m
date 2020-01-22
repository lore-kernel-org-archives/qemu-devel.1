Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCA6C2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF2352087E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="svCUYgfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2352087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu67H-0007E3-8o
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 21:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65a-0005Me-Mu
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:49:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65Y-0002go-SH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:49:54 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45146)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu65Y-0002gU-Kl
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:49:52 -0500
Received: by mail-pl1-x643.google.com with SMTP id b22so2248773pls.12
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 18:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TwrbDOcBiJWe3P20iSui/ewdKReKQwEsoISJVZqcFRc=;
 b=svCUYgfD0pnczTgtjhO8kkdeoXkbnxHe5OOAvSkSfRWOurKDuCgBvks/X4nxCKO3fm
 nW0nj5228SGKXozo+zPYJKo3q37LbaWUBEp8EnMWqE+IdV9zJ4q5l78UdqOiRkIqqJU2
 qa+xTibg1cNenlVBK8m6ApQ/QYVgXaU127OFJr9oSN/oqxhEgpdRbmW1r4x0VC3cbI7I
 qM3HsZn4c7dDMfkIZKW9UQOPIaR9r2jeajA5ovhasX5pGVeFRzuIT6DOsFClHmvjn6/T
 RYw314iCqdVi0vSiL/FFHgseypzWvjZYEoBh6TQRsd9FPT9Sb1ZGeaM6ySH0XD0kFIl4
 1WFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TwrbDOcBiJWe3P20iSui/ewdKReKQwEsoISJVZqcFRc=;
 b=q/xLKlWc84DS4zehAnw2Y1xQDMFWvh7eYhzSU8q8jLUvjkxf/Jwe12wBM7gkTHYD5d
 A4WUOcaaErR04tSv47gb51lySqDOIwHdxBmSm/KGFbsY88W1gbV4a78dsWDgssXEDWc/
 JQV0uDxg7uCfTl067S8XvTUEJhgsgIAJbhBfHma+QxBXGPc2SygKUZewmph25bEq0++O
 8UrOO9HhIiIkjpwP0PPA8vaSFD0D+V39bnS+z9thGbu3jp6uIK1ZGUAT9vbVMJIDhNSN
 d60H/mRytEtQ+zsTFU9Q9orAVl5o8C8y5jjPRqzEEk6MH1YTEQDIALAiPUps2bbWR0VT
 R3Sg==
X-Gm-Message-State: APjAAAX3NxN3Ph8K0XkfoZAWFxVnI8V/GtP25znuVP31jOj177CKEZ1V
 yXIu0P/55qyTKrVEYAR7o2Ovq9w+GvA=
X-Google-Smtp-Source: APXvYqxCw/CfLVYxCJvwQEE6r+LKThk3sOrRKgPzo7Ho/7cGR0e8MtAeyyeNGsyr1QsdUuB9qljckQ==
X-Received: by 2002:a17:90b:46cf:: with SMTP id
 jx15mr473309pjb.2.1579661391276; 
 Tue, 21 Jan 2020 18:49:51 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id c22sm44149883pfo.50.2020.01.21.18.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 18:49:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/16] cputlb: Handle NB_MMU_MODES > TARGET_PAGE_BITS_MIN
Date: Tue, 21 Jan 2020 16:49:31 -1000
Message-Id: <20200122024946.28484-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122024946.28484-1-richard.henderson@linaro.org>
References: <20200122024946.28484-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In target/arm we will shortly have "too many" mmu_idx.
The current minimum barrier is caused by the way in which
tlb_flush_page_by_mmuidx is coded.

We can remove this limitation by allocating memory for
consumption by the worker.  Let us assume that this is
the unlikely case, as will be the case for the majority
of targets which have so far satisfied the BUILD_BUG_ON,
and only allocate memory when necessary.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 167 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 132 insertions(+), 35 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index a991ea2964..02b381cf50 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -449,28 +449,29 @@ static void tlb_flush_page_locked(CPUArchState *env, int midx,
     }
 }
 
-/* As we are going to hijack the bottom bits of the page address for a
- * mmuidx bit mask we need to fail to build if we can't do that
+/**
+ * tlb_flush_page_by_mmuidx_async_0:
+ * @cpu: cpu on which to flush
+ * @addr: page of virtual address to flush
+ * @idxmap: set of mmu_idx to flush
+ *
+ * Helper for tlb_flush_page_by_mmuidx and friends, flush one page
+ * at @addr from the tlbs indicated by @idxmap from @cpu.
  */
-QEMU_BUILD_BUG_ON(NB_MMU_MODES > TARGET_PAGE_BITS_MIN);
-
-static void tlb_flush_page_by_mmuidx_async_work(CPUState *cpu,
-                                                run_on_cpu_data data)
+static void tlb_flush_page_by_mmuidx_async_0(CPUState *cpu,
+                                             target_ulong addr,
+                                             uint16_t idxmap)
 {
     CPUArchState *env = cpu->env_ptr;
-    target_ulong addr_and_mmuidx = (target_ulong) data.target_ptr;
-    target_ulong addr = addr_and_mmuidx & TARGET_PAGE_MASK;
-    unsigned long mmu_idx_bitmap = addr_and_mmuidx & ALL_MMUIDX_BITS;
     int mmu_idx;
 
     assert_cpu_is_self(cpu);
 
-    tlb_debug("page addr:" TARGET_FMT_lx " mmu_map:0x%lx\n",
-              addr, mmu_idx_bitmap);
+    tlb_debug("page addr:" TARGET_FMT_lx " mmu_map:0x%x\n", addr, idxmap);
 
     qemu_spin_lock(&env_tlb(env)->c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
-        if (test_bit(mmu_idx, &mmu_idx_bitmap)) {
+        if ((idxmap >> mmu_idx) & 1) {
             tlb_flush_page_locked(env, mmu_idx, addr);
         }
     }
@@ -479,22 +480,75 @@ static void tlb_flush_page_by_mmuidx_async_work(CPUState *cpu,
     tb_flush_jmp_cache(cpu, addr);
 }
 
+/**
+ * tlb_flush_page_by_mmuidx_async_1:
+ * @cpu: cpu on which to flush
+ * @data: encoded addr + idxmap
+ *
+ * Helper for tlb_flush_page_by_mmuidx and friends, called through
+ * async_run_on_cpu.  The idxmap parameter is encoded in the page
+ * offset of the target_ptr field.  This limits the set of mmu_idx
+ * that can be passed via this method.
+ */
+static void tlb_flush_page_by_mmuidx_async_1(CPUState *cpu,
+                                             run_on_cpu_data data)
+{
+    target_ulong addr_and_idxmap = (target_ulong) data.target_ptr;
+    target_ulong addr = addr_and_idxmap & TARGET_PAGE_MASK;
+    uint16_t idxmap = addr_and_idxmap & ~TARGET_PAGE_MASK;
+
+    tlb_flush_page_by_mmuidx_async_0(cpu, addr, idxmap);
+}
+
+typedef struct {
+    target_ulong addr;
+    uint16_t idxmap;
+} TLBFlushPageByMMUIdxData;
+
+/**
+ * tlb_flush_page_by_mmuidx_async_2:
+ * @cpu: cpu on which to flush
+ * @data: allocated addr + idxmap
+ *
+ * Helper for tlb_flush_page_by_mmuidx and friends, called through
+ * async_run_on_cpu.  The addr+idxmap parameters are stored in a
+ * TLBFlushPageByMMUIdxData structure that has been allocated
+ * specifically for this helper.  Free the structure when done.
+ */
+static void tlb_flush_page_by_mmuidx_async_2(CPUState *cpu,
+                                             run_on_cpu_data data)
+{
+    TLBFlushPageByMMUIdxData *d = data.host_ptr;
+
+    tlb_flush_page_by_mmuidx_async_0(cpu, d->addr, d->idxmap);
+    g_free(d);
+}
+
 void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
 {
-    target_ulong addr_and_mmu_idx;
-
     tlb_debug("addr: "TARGET_FMT_lx" mmu_idx:%" PRIx16 "\n", addr, idxmap);
 
     /* This should already be page aligned */
-    addr_and_mmu_idx = addr & TARGET_PAGE_MASK;
-    addr_and_mmu_idx |= idxmap;
+    addr &= TARGET_PAGE_MASK;
 
-    if (!qemu_cpu_is_self(cpu)) {
-        async_run_on_cpu(cpu, tlb_flush_page_by_mmuidx_async_work,
-                         RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
+    if (qemu_cpu_is_self(cpu)) {
+        tlb_flush_page_by_mmuidx_async_0(cpu, addr, idxmap);
+    } else if (idxmap < TARGET_PAGE_SIZE) {
+        /*
+         * Most targets have only a few mmu_idx.  In the case where
+         * we can stuff idxmap into the low TARGET_PAGE_BITS, avoid
+         * allocating memory for this operation.
+         */
+        async_run_on_cpu(cpu, tlb_flush_page_by_mmuidx_async_1,
+                         RUN_ON_CPU_TARGET_PTR(addr | idxmap));
     } else {
-        tlb_flush_page_by_mmuidx_async_work(
-            cpu, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
+        TLBFlushPageByMMUIdxData *d = g_new(TLBFlushPageByMMUIdxData, 1);
+
+        /* Otherwise allocate a structure, freed by the worker.  */
+        d->addr = addr;
+        d->idxmap = idxmap;
+        async_run_on_cpu(cpu, tlb_flush_page_by_mmuidx_async_2,
+                         RUN_ON_CPU_HOST_PTR(d));
     }
 }
 
@@ -506,17 +560,36 @@ void tlb_flush_page(CPUState *cpu, target_ulong addr)
 void tlb_flush_page_by_mmuidx_all_cpus(CPUState *src_cpu, target_ulong addr,
                                        uint16_t idxmap)
 {
-    const run_on_cpu_func fn = tlb_flush_page_by_mmuidx_async_work;
-    target_ulong addr_and_mmu_idx;
-
     tlb_debug("addr: "TARGET_FMT_lx" mmu_idx:%"PRIx16"\n", addr, idxmap);
 
     /* This should already be page aligned */
-    addr_and_mmu_idx = addr & TARGET_PAGE_MASK;
-    addr_and_mmu_idx |= idxmap;
+    addr &= TARGET_PAGE_MASK;
 
-    flush_all_helper(src_cpu, fn, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
-    fn(src_cpu, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
+    /*
+     * Allocate memory to hold addr+idxmap only when needed.
+     * See tlb_flush_page_by_mmuidx for details.
+     */
+    if (idxmap < TARGET_PAGE_SIZE) {
+        flush_all_helper(src_cpu, tlb_flush_page_by_mmuidx_async_1,
+                         RUN_ON_CPU_TARGET_PTR(addr | idxmap));
+    } else {
+        CPUState *dst_cpu;
+
+        /* Allocate a separate data block for each destination cpu.  */
+        CPU_FOREACH(dst_cpu) {
+            if (dst_cpu != src_cpu) {
+                TLBFlushPageByMMUIdxData *d
+                    = g_new(TLBFlushPageByMMUIdxData, 1);
+
+                d->addr = addr;
+                d->idxmap = idxmap;
+                async_run_on_cpu(dst_cpu, tlb_flush_page_by_mmuidx_async_2,
+                                 RUN_ON_CPU_HOST_PTR(d));
+            }
+        }
+    }
+
+    tlb_flush_page_by_mmuidx_async_0(src_cpu, addr, idxmap);
 }
 
 void tlb_flush_page_all_cpus(CPUState *src, target_ulong addr)
@@ -528,17 +601,41 @@ void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
                                               target_ulong addr,
                                               uint16_t idxmap)
 {
-    const run_on_cpu_func fn = tlb_flush_page_by_mmuidx_async_work;
-    target_ulong addr_and_mmu_idx;
-
     tlb_debug("addr: "TARGET_FMT_lx" mmu_idx:%"PRIx16"\n", addr, idxmap);
 
     /* This should already be page aligned */
-    addr_and_mmu_idx = addr & TARGET_PAGE_MASK;
-    addr_and_mmu_idx |= idxmap;
+    addr &= TARGET_PAGE_MASK;
 
-    flush_all_helper(src_cpu, fn, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
-    async_safe_run_on_cpu(src_cpu, fn, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
+    /*
+     * Allocate memory to hold addr+idxmap only when needed.
+     * See tlb_flush_page_by_mmuidx for details.
+     */
+    if (idxmap < TARGET_PAGE_SIZE) {
+        flush_all_helper(src_cpu, tlb_flush_page_by_mmuidx_async_1,
+                         RUN_ON_CPU_TARGET_PTR(addr | idxmap));
+        async_safe_run_on_cpu(src_cpu, tlb_flush_page_by_mmuidx_async_1,
+                              RUN_ON_CPU_TARGET_PTR(addr | idxmap));
+    } else {
+        CPUState *dst_cpu;
+        TLBFlushPageByMMUIdxData *d;
+
+        /* Allocate a separate data block for each destination cpu.  */
+        CPU_FOREACH(dst_cpu) {
+            if (dst_cpu != src_cpu) {
+                d = g_new(TLBFlushPageByMMUIdxData, 1);
+                d->addr = addr;
+                d->idxmap = idxmap;
+                async_run_on_cpu(dst_cpu, tlb_flush_page_by_mmuidx_async_2,
+                                 RUN_ON_CPU_HOST_PTR(d));
+            }
+        }
+
+        d = g_new(TLBFlushPageByMMUIdxData, 1);
+        d->addr = addr;
+        d->idxmap = idxmap;
+        async_safe_run_on_cpu(src_cpu, tlb_flush_page_by_mmuidx_async_2,
+                              RUN_ON_CPU_HOST_PTR(d));
+    }
 }
 
 void tlb_flush_page_all_cpus_synced(CPUState *src, target_ulong addr)
-- 
2.20.1


