Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30129C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 21:16:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2031214DB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 21:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QgVrAgQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2031214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTX59-00069g-5U
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 17:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTWxG-0000co-DU
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 17:08:02 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:53673)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTWxD-0004nD-Tn
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 17:08:02 -0400
Received: by mail-pj1-x1041.google.com with SMTP id g16so2025051pjv.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 14:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tzpVWbbsA3myTqfadNtH08IGirbxENfmSPc8kYt/cFQ=;
 b=QgVrAgQneq2mFVYyJIDBt9L7stFFxUpcLNx0EMPl+sdn2LT75V39RtQJdawsLbv7nB
 ZX0KhrnppyiNCBUmwDDOew5Wp5w2aeHvULC2UYlI1CcQHU+YcTQSeMVvsjCOdflsXHTa
 XMsjoc7f/jOSBHpsXz4Yb7ArowYtdGpMnKDlEpU7AvhjuBuI9DZBhi97jsqg4JV2UdZq
 BsN+pkE34VmbGMBvbYzxf1ZxIZmGAen5td4stdCWKd2Iju2hU2t8Ieo0tAV+Vmn5hXyC
 +RrzFhpvHKMVX2V3ocjVZbaS453SKlTLx1D+56L02SsEQIyE9DSLi94OJA/ZjjqKQLiV
 hcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tzpVWbbsA3myTqfadNtH08IGirbxENfmSPc8kYt/cFQ=;
 b=l4qv3vzD8PPGf58foilOqpQWXzE++1MdTiIkg8vADUBSwcJdC+be2W7+fFAEi3kvkU
 wc7g01nGTtfXRQaykHPmfA1xMr/448Wd2wHDLEf7vHm7L9a7hdqNS7FxlRxtjQM0vZ56
 MwNWQ9Z+FsUryg67haRhxZLEoeif6ghCzd/ND+qLkE3/QBIM55wQpCM0ChPCQhzkZv/t
 wfimjawkqirK9XFWrXG5uxozDOD86GqD2A90t0sl26zGSK3L90/anrGnw8XQuwo8z5GP
 VhicqqiuoVWkT+xa5xmTMxPmE0HZBMOdBRGEAFoNns6maWW145MAFxWnm/yxXHc/a4ud
 UwVA==
X-Gm-Message-State: AOAM530/pBBYBeFkxi4pIOw1CELX2CJUY/yhVH2hpxJJF6A7Jb2SdUHs
 lmVdVx7gzV0Z6qYxBmp832oi/XhOkTf0JQ==
X-Google-Smtp-Source: ABdhPJxdUQNtYSRzLo87xhSeIHvCzH7XMHaAFmxaQtHnUaAgIfj3ZDRy0mohn5yHK3iMYwAAyc/wLA==
X-Received: by 2002:a17:90a:9f90:: with SMTP id
 o16mr6124216pjp.180.1602882477943; 
 Fri, 16 Oct 2020 14:07:57 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 198sm3682324pfy.41.2020.10.16.14.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 14:07:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] accel/tcg: Add tlb_flush_page_bits_by_mmuidx*
Date: Fri, 16 Oct 2020 14:07:53 -0700
Message-Id: <20201016210754.818257-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016210754.818257-1-richard.henderson@linaro.org>
References: <20201016210754.818257-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On ARM, the Top Byte Ignore feature means that only 56 bits of
the address are significant in the virtual address.  We are
required to give the entire 64-bit address to FAR_ELx on fault,
which means that we do not "clean" the top byte early in TCG.

This new interface allows us to flush all 256 possible aliases
for a given page, currently missed by tlb_flush_page*.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h |  36 ++++++
 accel/tcg/cputlb.c      | 275 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 302 insertions(+), 9 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 66f9b4cca6..4707ac140c 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -251,6 +251,25 @@ void tlb_flush_by_mmuidx_all_cpus(CPUState *cpu, uint16_t idxmap);
  * depend on when the guests translation ends the TB.
  */
 void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu, uint16_t idxmap);
+
+/**
+ * tlb_flush_page_bits_by_mmuidx
+ * @cpu: CPU whose TLB should be flushed
+ * @addr: virtual address of page to be flushed
+ * @idxmap: bitmap of mmu indexes to flush
+ * @bits: number of significant bits in address
+ *
+ * Similar to tlb_flush_page_mask, but with a bitmap of indexes.
+ */
+void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, target_ulong addr,
+                                   uint16_t idxmap, unsigned bits);
+
+/* Similarly, with broadcast and syncing. */
+void tlb_flush_page_bits_by_mmuidx_all_cpus(CPUState *cpu, target_ulong addr,
+                                            uint16_t idxmap, unsigned bits);
+void tlb_flush_page_bits_by_mmuidx_all_cpus_synced
+    (CPUState *cpu, target_ulong addr, uint16_t idxmap, unsigned bits);
+
 /**
  * tlb_set_page_with_attrs:
  * @cpu: CPU to add this TLB entry for
@@ -337,6 +356,23 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                        uint16_t idxmap)
 {
 }
+static inline void tlb_flush_page_bits_by_mmuidx(CPUState *cpu,
+                                                 target_ulong addr,
+                                                 uint16_t idxmap,
+                                                 unsigned bits)
+{
+}
+static inline void tlb_flush_page_bits_by_mmuidx_all_cpus(CPUState *cpu,
+                                                          target_ulong addr,
+                                                          uint16_t idxmap,
+                                                          unsigned bits)
+{
+}
+static inline void
+tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *cpu, target_ulong addr,
+                                              uint16_t idxmap, unsigned bits)
+{
+}
 #endif
 /**
  * probe_access:
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 2bbbb3ab29..42ab79c1a5 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -409,12 +409,21 @@ void tlb_flush_all_cpus_synced(CPUState *src_cpu)
     tlb_flush_by_mmuidx_all_cpus_synced(src_cpu, ALL_MMUIDX_BITS);
 }
 
+static bool tlb_hit_page_mask_anyprot(CPUTLBEntry *tlb_entry,
+                                      target_ulong page, target_ulong mask)
+{
+    page &= mask;
+    mask &= TARGET_PAGE_MASK | TLB_INVALID_MASK;
+
+    return (page == (tlb_entry->addr_read & mask) ||
+            page == (tlb_addr_write(tlb_entry) & mask) ||
+            page == (tlb_entry->addr_code & mask));
+}
+
 static inline bool tlb_hit_page_anyprot(CPUTLBEntry *tlb_entry,
                                         target_ulong page)
 {
-    return tlb_hit_page(tlb_entry->addr_read, page) ||
-           tlb_hit_page(tlb_addr_write(tlb_entry), page) ||
-           tlb_hit_page(tlb_entry->addr_code, page);
+    return tlb_hit_page_mask_anyprot(tlb_entry, page, -1);
 }
 
 /**
@@ -427,31 +436,45 @@ static inline bool tlb_entry_is_empty(const CPUTLBEntry *te)
 }
 
 /* Called with tlb_c.lock held */
-static inline bool tlb_flush_entry_locked(CPUTLBEntry *tlb_entry,
-                                          target_ulong page)
+static bool tlb_flush_entry_mask_locked(CPUTLBEntry *tlb_entry,
+                                        target_ulong page,
+                                        target_ulong mask)
 {
-    if (tlb_hit_page_anyprot(tlb_entry, page)) {
+    if (tlb_hit_page_mask_anyprot(tlb_entry, page, mask)) {
         memset(tlb_entry, -1, sizeof(*tlb_entry));
         return true;
     }
     return false;
 }
 
+static inline bool tlb_flush_entry_locked(CPUTLBEntry *tlb_entry,
+                                          target_ulong page)
+{
+    return tlb_flush_entry_mask_locked(tlb_entry, page, -1);
+}
+
 /* Called with tlb_c.lock held */
-static inline void tlb_flush_vtlb_page_locked(CPUArchState *env, int mmu_idx,
-                                              target_ulong page)
+static void tlb_flush_vtlb_page_mask_locked(CPUArchState *env, int mmu_idx,
+                                            target_ulong page,
+                                            target_ulong mask)
 {
     CPUTLBDesc *d = &env_tlb(env)->d[mmu_idx];
     int k;
 
     assert_cpu_is_self(env_cpu(env));
     for (k = 0; k < CPU_VTLB_SIZE; k++) {
-        if (tlb_flush_entry_locked(&d->vtable[k], page)) {
+        if (tlb_flush_entry_mask_locked(&d->vtable[k], page, mask)) {
             tlb_n_used_entries_dec(env, mmu_idx);
         }
     }
 }
 
+static inline void tlb_flush_vtlb_page_locked(CPUArchState *env, int mmu_idx,
+                                              target_ulong page)
+{
+    tlb_flush_vtlb_page_mask_locked(env, mmu_idx, page, -1);
+}
+
 static void tlb_flush_page_locked(CPUArchState *env, int midx,
                                   target_ulong page)
 {
@@ -666,6 +689,240 @@ void tlb_flush_page_all_cpus_synced(CPUState *src, target_ulong addr)
     tlb_flush_page_by_mmuidx_all_cpus_synced(src, addr, ALL_MMUIDX_BITS);
 }
 
+static void tlb_flush_page_bits_locked(CPUArchState *env, int midx,
+                                       target_ulong page, unsigned bits)
+{
+    CPUTLBDesc *d = &env_tlb(env)->d[midx];
+    CPUTLBDescFast *f = &env_tlb(env)->f[midx];
+    target_ulong mask = MAKE_64BIT_MASK(0, bits);
+
+    /*
+     * If @bits is smaller than the tlb size, there may be multiple entries
+     * within the TLB; otherwise all addresses that match under @mask hit
+     * the same TLB entry.
+     *
+     * TODO: Perhaps allow bits to be a few bits less than the size.
+     * For now, just flush the entire TLB.
+     */
+    if (mask < f->mask) {
+        tlb_debug("forcing full flush midx %d ("
+                  TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
+                  midx, page, mask);
+        tlb_flush_one_mmuidx_locked(env, midx, get_clock_realtime());
+        return;
+    }
+
+    /* Check if we need to flush due to large pages.  */
+    if ((page & d->large_page_mask) == d->large_page_addr) {
+        tlb_debug("forcing full flush midx %d ("
+                  TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
+                  midx, d->large_page_addr, d->large_page_mask);
+        tlb_flush_one_mmuidx_locked(env, midx, get_clock_realtime());
+        return;
+    }
+
+    if (tlb_flush_entry_mask_locked(tlb_entry(env, midx, page), page, mask)) {
+        tlb_n_used_entries_dec(env, midx);
+    }
+    tlb_flush_vtlb_page_mask_locked(env, midx, page, mask);
+}
+
+typedef struct {
+    target_ulong addr;
+    uint16_t idxmap;
+    uint16_t bits;
+} TLBFlushPageBitsByMMUIdxData;
+
+static void
+tlb_flush_page_bits_by_mmuidx_async_0(CPUState *cpu,
+                                      TLBFlushPageBitsByMMUIdxData d)
+{
+    CPUArchState *env = cpu->env_ptr;
+    int mmu_idx;
+
+    assert_cpu_is_self(cpu);
+
+    tlb_debug("page addr:" TARGET_FMT_lx "/%u mmu_map:0x%x\n",
+              d.addr, d.bits, d.idxmap);
+
+    qemu_spin_lock(&env_tlb(env)->c.lock);
+    for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
+        if ((d.idxmap >> mmu_idx) & 1) {
+            tlb_flush_page_bits_locked(env, mmu_idx, d.addr, d.bits);
+        }
+    }
+    qemu_spin_unlock(&env_tlb(env)->c.lock);
+
+    tb_flush_jmp_cache(cpu, d.addr);
+}
+
+static bool encode_pbm_to_runon(run_on_cpu_data *out,
+                                TLBFlushPageBitsByMMUIdxData d)
+{
+    /* We need 6 bits to hold to hold @bits up to 63. */
+    if (d.idxmap <= MAKE_64BIT_MASK(0, TARGET_PAGE_BITS - 6)) {
+        *out = RUN_ON_CPU_TARGET_PTR(d.addr | (d.idxmap << 6) | d.bits);
+        return true;
+    }
+    return false;
+}
+
+static TLBFlushPageBitsByMMUIdxData
+decode_runon_to_pbm(run_on_cpu_data data)
+{
+    target_ulong addr_map_bits = (target_ulong) data.target_ptr;
+    return (TLBFlushPageBitsByMMUIdxData){
+        .addr = addr_map_bits & TARGET_PAGE_MASK,
+        .idxmap = (addr_map_bits & ~TARGET_PAGE_MASK) >> 6,
+        .bits = addr_map_bits & 0x3f
+    };
+}
+
+static void tlb_flush_page_bits_by_mmuidx_async_1(CPUState *cpu,
+                                                  run_on_cpu_data runon)
+{
+    tlb_flush_page_bits_by_mmuidx_async_0(cpu, decode_runon_to_pbm(runon));
+}
+
+static void tlb_flush_page_bits_by_mmuidx_async_2(CPUState *cpu,
+                                                  run_on_cpu_data data)
+{
+    TLBFlushPageBitsByMMUIdxData *d = data.host_ptr;
+    tlb_flush_page_bits_by_mmuidx_async_0(cpu, *d);
+    g_free(d);
+}
+
+void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, target_ulong addr,
+                                   uint16_t idxmap, unsigned bits)
+{
+    TLBFlushPageBitsByMMUIdxData d;
+    run_on_cpu_data runon;
+
+    /* If all bits are significant, this devolves to tlb_flush_page. */
+    if (bits >= TARGET_LONG_BITS) {
+        tlb_flush_page_by_mmuidx(cpu, addr, idxmap);
+        return;
+    }
+    /* If no page bits are significant, this devolves to tlb_flush. */
+    if (bits < TARGET_PAGE_BITS) {
+        tlb_flush_by_mmuidx(cpu, idxmap);
+        return;
+    }
+
+    /* This should already be page aligned */
+    d.addr = addr & TARGET_PAGE_MASK;
+    d.idxmap = idxmap;
+    d.bits = bits;
+
+    if (qemu_cpu_is_self(cpu)) {
+        tlb_flush_page_bits_by_mmuidx_async_0(cpu, d);
+    } else if (encode_pbm_to_runon(&runon, d)) {
+        async_run_on_cpu(cpu, tlb_flush_page_bits_by_mmuidx_async_1, runon);
+    } else {
+        TLBFlushPageBitsByMMUIdxData *p
+            = g_new(TLBFlushPageBitsByMMUIdxData, 1);
+
+        /* Otherwise allocate a structure, freed by the worker.  */
+        *p = d;
+        async_run_on_cpu(cpu, tlb_flush_page_bits_by_mmuidx_async_2,
+                         RUN_ON_CPU_HOST_PTR(p));
+    }
+}
+
+void tlb_flush_page_bits_by_mmuidx_all_cpus(CPUState *src_cpu,
+                                            target_ulong addr,
+                                            uint16_t idxmap,
+                                            unsigned bits)
+{
+    TLBFlushPageBitsByMMUIdxData d;
+    run_on_cpu_data runon;
+
+    /* If all bits are significant, this devolves to tlb_flush_page. */
+    if (bits >= TARGET_LONG_BITS) {
+        tlb_flush_page_by_mmuidx_all_cpus(src_cpu, addr, idxmap);
+        return;
+    }
+    /* If no page bits are significant, this devolves to tlb_flush. */
+    if (bits < TARGET_PAGE_BITS) {
+        tlb_flush_by_mmuidx_all_cpus(src_cpu, idxmap);
+        return;
+    }
+
+    /* This should already be page aligned */
+    d.addr = addr & TARGET_PAGE_MASK;
+    d.idxmap = idxmap;
+    d.bits = bits;
+
+    if (encode_pbm_to_runon(&runon, d)) {
+        flush_all_helper(src_cpu, tlb_flush_page_bits_by_mmuidx_async_1, runon);
+    } else {
+        CPUState *dst_cpu;
+        TLBFlushPageBitsByMMUIdxData *p;
+
+        /* Allocate a separate data block for each destination cpu.  */
+        CPU_FOREACH(dst_cpu) {
+            if (dst_cpu != src_cpu) {
+                p = g_new(TLBFlushPageBitsByMMUIdxData, 1);
+                *p = d;
+                async_run_on_cpu(dst_cpu,
+                                 tlb_flush_page_bits_by_mmuidx_async_2,
+                                 RUN_ON_CPU_HOST_PTR(p));
+            }
+        }
+    }
+
+    tlb_flush_page_bits_by_mmuidx_async_0(src_cpu, d);
+}
+
+void tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
+                                                   target_ulong addr,
+                                                   uint16_t idxmap,
+                                                   unsigned bits)
+{
+    TLBFlushPageBitsByMMUIdxData d;
+    run_on_cpu_data runon;
+
+    /* If all bits are significant, this devolves to tlb_flush_page. */
+    if (bits >= TARGET_LONG_BITS) {
+        tlb_flush_page_by_mmuidx_all_cpus_synced(src_cpu, addr, idxmap);
+        return;
+    }
+    /* If no page bits are significant, this devolves to tlb_flush. */
+    if (bits < TARGET_PAGE_BITS) {
+        tlb_flush_by_mmuidx_all_cpus_synced(src_cpu, idxmap);
+        return;
+    }
+
+    /* This should already be page aligned */
+    d.addr = addr & TARGET_PAGE_MASK;
+    d.idxmap = idxmap;
+    d.bits = bits;
+
+    if (encode_pbm_to_runon(&runon, d)) {
+        flush_all_helper(src_cpu, tlb_flush_page_bits_by_mmuidx_async_1, runon);
+        async_safe_run_on_cpu(src_cpu, tlb_flush_page_bits_by_mmuidx_async_1,
+                              runon);
+    } else {
+        CPUState *dst_cpu;
+        TLBFlushPageBitsByMMUIdxData *p;
+
+        /* Allocate a separate data block for each destination cpu.  */
+        CPU_FOREACH(dst_cpu) {
+            if (dst_cpu != src_cpu) {
+                p = g_new(TLBFlushPageBitsByMMUIdxData, 1);
+                *p = d;
+                async_run_on_cpu(dst_cpu, tlb_flush_page_bits_by_mmuidx_async_2,
+                                 RUN_ON_CPU_HOST_PTR(p));
+            }
+        }
+
+        p = g_new(TLBFlushPageBitsByMMUIdxData, 1);
+        *p = d;
+        async_safe_run_on_cpu(src_cpu, tlb_flush_page_bits_by_mmuidx_async_2,
+                              RUN_ON_CPU_HOST_PTR(p));
+    }
+}
+
 /* update the TLBs so that writes to code in the virtual page 'addr'
    can be detected */
 void tlb_protect_code(ram_addr_t ram_addr)
-- 
2.25.1


