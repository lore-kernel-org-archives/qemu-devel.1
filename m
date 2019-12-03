Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7ECC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:15:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8FC2064B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXOWQtpM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8FC2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icHNi-0005Hj-Ja
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 18:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icH37-0002XK-1E
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:53:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icH35-0006Fg-5P
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:53:40 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icH34-0006Cg-Qg
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:53:39 -0500
Received: by mail-pf1-x441.google.com with SMTP id s18so2566108pfd.8
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 14:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GpVUc819EtKJmXmcFCtrJ6j6UAZ0zHMd3RprAICGD1Q=;
 b=BXOWQtpMs2xHzrkqMezlvx/Rx3H/5spS7nryedTFylz+s3IAZXQZrzLW5SPwAyoGbr
 rCmrLe8aCGEw8YbxfhE245cEuuqL8VG0oSUXW8ZJ10ntF6I4VaBOzWxi51q4nRpzGJa2
 HIO4xew7OX+onjwGnQkhlD9N8ExoaLR/bJ6O6z0pixDwzLMP3i79vH+DyrlhiOfT1cIn
 MvBMP0GZkiem2Dsg1GiGRHb/8yWsFxtl2Ey2Ldl3pETgfZuvBBGYxmIBt+e717Akz680
 F6OhH2+T2KNSvS6kpL5YXieVggjlKNutqvxZcqgO1woTZWAQgAFdF3z0N4Ly24dvRiWe
 cE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GpVUc819EtKJmXmcFCtrJ6j6UAZ0zHMd3RprAICGD1Q=;
 b=eKbqVsPnkdukHhkJRSanY9mCpqJf80dZJtniZQLEHrqUo/sOGcp+VsqCsiK6KRle9I
 eJsbHtQOaTRKZr+Xr4O0RKvgfjvHbZyu17NYG+8Bo42ddz2dFlsHZcuppka/cRgYTsJt
 NZvoFgEQ7+NApsgylkGohDl3ufk4UqfhxWwafZj99+KERmH+WNg5Sc7tOnhSNM4a9nCn
 Oe6yXo24Ald3YwTGn9XJ4cTaBooFZV1xtq/5+mKy/pGgHiHn0pWmALvi/V57mxGxkM/T
 wwXObk302rPkeX+O81wqS9VQ2F04cYK38KvceN2haLXysYh4dL3FpPwswLBmoo64KO8F
 V4Mw==
X-Gm-Message-State: APjAAAWwwEIVKtdSde/bDcdeUxf1MU0NyBi3ZOzpIhgIG9M8/MXJgJ8U
 9X8gNWDfPBf9VJQrP1ltAF03ubvWXQI=
X-Google-Smtp-Source: APXvYqwO+fX9D8kFXDXW+MLJYBVpr1S8AEqabpKa9FJimxt8juYiBVMYryGN0Ew3on1ZAa6TDqn/gw==
X-Received: by 2002:a62:e914:: with SMTP id j20mr266652pfh.245.1575413616536; 
 Tue, 03 Dec 2019 14:53:36 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d22sm3789713pjd.2.2019.12.03.14.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 14:53:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/11] cputlb: Handle NB_MMU_MODES > TARGET_PAGE_BITS_MIN
Date: Tue,  3 Dec 2019 14:53:23 -0800
Message-Id: <20191203225333.17055-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203225333.17055-1-richard.henderson@linaro.org>
References: <20191203225333.17055-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 167 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 132 insertions(+), 35 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 98221948d6..0c2adb93ea 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -447,28 +447,29 @@ static void tlb_flush_page_locked(CPUArchState *env, int midx,
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
@@ -477,22 +478,75 @@ static void tlb_flush_page_by_mmuidx_async_work(CPUState *cpu,
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
 
@@ -504,17 +558,36 @@ void tlb_flush_page(CPUState *cpu, target_ulong addr)
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
@@ -526,17 +599,41 @@ void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
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
2.17.1


