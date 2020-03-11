Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145FDC10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:50:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49C2208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EL2RWt2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49C2208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBvBs-00062r-1F
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6Z-0006CR-Mi
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6X-0001vU-PY
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:35 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41528)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBv6V-0001rw-TO
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:33 -0400
Received: by mail-pl1-x642.google.com with SMTP id t14so614380plr.8
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WeaNzwzC03UA9+8arqHbMRnYm8SNdcLfajSQ8cx3zrw=;
 b=EL2RWt2DGrX6kJg5C4+cQ18aibmZetpuMBLgbQxG11B+rOZfBhV54BmfC2uh+j8+Z6
 SVWdFT4QIl7aQvjuGBj2T6f1Z3O8zNKAwSNEsYY8lY7nR+WnmC7yk1AWZhBOf4grB87Y
 4q2WOi/C3HO4mG2QSTyVvDm/eaAG4eMJnZMwb7ZUiLuVlC3+tpFiBCFwEwpVlSwUcsXS
 TeBkoJsy6vpa84dCFdTK5TmBtCEA2d1Rqpvwo50X+HZXQZg/CBLHQ7GxlhoE07Z2ECnE
 nuSwpZ5gsSBImNhjcbEAakSOR28LDROD041GlDZiCJXCY7LeUPWi7efTC41AKXZKLVaz
 21uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WeaNzwzC03UA9+8arqHbMRnYm8SNdcLfajSQ8cx3zrw=;
 b=kEVQQuq8ye0JoE8LvcimlFow18shbpF9y8uyUatcXIwi0GDl7Q48c0lueFEfQLhH0h
 pImPzng/LwQdYUrIsZCtRfRxvJZfKKrOSDWFD2WB3esZKMhJbc4KrtsfKtJPVm7Qq4Nw
 0z9Zm2GXemvjsTskmsKFJvVIkxeUpIUNwO7xBzQavBTbI/EXUhx9ni/ANNI1W0F78Wkb
 y2QMWd9G6SUHuw1OsX5Ugmlm7GAGhHF7GDSsPqiUvtCmniUJ8kIH9JYJGtl/APgpY0LY
 at3RE75s42RUJr7kgBC1kWGzLFdmx400TdGPK3lNcelGxjMhXpTxuRDBKl/BkzZsccSo
 99jg==
X-Gm-Message-State: ANhLgQ12Nw/0L3BrEsCnFvBeWbTQpINQi+NEm4J8GRmQb5kyT3Fdzg0W
 7BzMQuSPyECQJ/6vifGc9SpCSn/2j0w=
X-Google-Smtp-Source: ADFU+vspqwWUbwrKnd7zrvYKWblSz69ADlPtluClng+gC0u+7AW07LyUTe9wlUObKCiEjD18SZq+OA==
X-Received: by 2002:a17:902:a408:: with SMTP id
 p8mr1782284plq.132.1583909069346; 
 Tue, 10 Mar 2020 23:44:29 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id z3sm50137807pfz.155.2020.03.10.23.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 23:44:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/16] target/arm: Add sve infrastructure for page lookup
Date: Tue, 10 Mar 2020 23:44:10 -0700
Message-Id: <20200311064420.30606-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311064420.30606-1-richard.henderson@linaro.org>
References: <20200311064420.30606-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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

For contiguous predicated memory operations, we want to
minimize the number of tlb lookups performed.  We have
open-coded this for sve_ld1_r, but for correctness with
MTE we will need this for all of the memory operations.

Create a structure that holds the bounds of active elements,
and metadata for two pages.  Add routines to find those
active elements, lookup the pages, and run watchpoints
for those pages.

Temporarily mark the functions unused to avoid Werror.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 240 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 240 insertions(+)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 8b470991db..3f653e46a0 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4155,6 +4155,246 @@ static intptr_t max_for_page(target_ulong base, intptr_t mem_off,
     return MIN(split, mem_max - mem_off) + mem_off;
 }
 
+/*
+ * Resolve the guest virtual address to info->host and info->flags.
+ * If @nofault, return false if the page is invalid, otherwise
+ * exit via page fault exception.
+ */
+
+typedef struct {
+    void *host;
+    int flags;
+    MemTxAttrs attrs;
+} SVEHostPage;
+
+static bool sve_probe_page(SVEHostPage *info, bool nofault,
+                           CPUARMState *env, target_ulong addr,
+                           int mem_off, MMUAccessType access_type,
+                           int mmu_idx, uintptr_t retaddr)
+{
+    int flags;
+
+    addr += mem_off;
+    flags = probe_access_flags(env, addr, access_type, mmu_idx, nofault,
+                               &info->host, retaddr);
+    info->flags = flags;
+
+    if (flags & TLB_INVALID_MASK) {
+        g_assert(nofault);
+        return false;
+    }
+
+    /* Ensure that info->host[] is relative to addr, not addr + mem_off. */
+    info->host -= mem_off;
+
+#ifdef CONFIG_USER_ONLY
+    memset(&info->attrs, 0, sizeof(info->attrs));
+#else
+    /*
+     * Find the iotlbentry for addr and return the transaction attributes.
+     * This *must* be present in the TLB because we just found the mapping.
+     */
+    {
+        uintptr_t index = tlb_index(env, mmu_idx, addr);
+
+# ifdef CONFIG_DEBUG_TCG
+        CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
+        target_ulong comparator = (access_type == MMU_DATA_LOAD
+                                   ? entry->addr_read
+                                   : tlb_addr_write(entry));
+        g_assert(tlb_hit(comparator, addr));
+# endif
+
+        CPUIOTLBEntry *iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
+        info->attrs = iotlbentry->attrs;
+    }
+#endif
+
+    return true;
+}
+
+
+/*
+ * Analyse contiguous data, protected by a governing predicate.
+ */
+
+typedef enum {
+    FAULT_NO,
+    FAULT_FIRST,
+    FAULT_ALL,
+} SVEContFault;
+
+typedef struct {
+    /* First and last element wholy contained within the two pages. */
+    int16_t mem_off_first[2];
+    int16_t reg_off_first[2];
+    int16_t reg_off_last[2];
+
+    /* One element that is misaligned and spans both pages. */
+    int16_t mem_off_split;
+    int16_t reg_off_split;
+    int16_t page_split;
+
+    /* TLB data for the two pages. */
+    SVEHostPage page[2];
+} SVEContLdSt;
+
+/*
+ * Find first active element on each page, and a loose bound for the
+ * final element on each page.  Identify any single element that spans
+ * the page boundary.  Return true if there are any active elements.
+ */
+static bool __attribute__((unused))
+sve_cont_ldst_elements(SVEContLdSt *info, target_ulong addr, uint64_t *vg,
+                       intptr_t reg_max, int esz, int msize)
+{
+    const int esize = 1 << esz;
+    const uint64_t pg_mask = pred_esz_masks[esz];
+    intptr_t reg_off_first = -1, reg_off_last = -1, reg_off_split;
+    intptr_t mem_off_last, mem_off_split;
+    intptr_t page_split, elt_split;
+    intptr_t i;
+
+    /* Set all of the element indicies to -1, and the TLB data to 0. */
+    memset(info, -1, offsetof(SVEContLdSt, page));
+    memset(info->page, 0, sizeof(info->page));
+
+    /* Gross scan over the entire predicate to find bounds. */
+    i = 0;
+    do {
+        uint64_t pg = vg[i] & pg_mask;
+        if (pg) {
+            reg_off_last = i * 64 + 63 - clz64(pg);
+            if (reg_off_first < 0) {
+                reg_off_first = i * 64 + ctz64(pg);
+            }
+        }
+    } while (++i * 64 < reg_max);
+
+    if (unlikely(reg_off_first < 0)) {
+        /* No active elements, no pages touched. */
+        return false;
+    }
+    tcg_debug_assert(reg_off_last >= 0 && reg_off_last < reg_max);
+
+    info->reg_off_first[0] = reg_off_first;
+    info->mem_off_first[0] = (reg_off_first >> esz) * msize;
+    mem_off_last = (reg_off_last >> esz) * msize;
+
+    page_split = -(addr | TARGET_PAGE_MASK);
+    if (likely(mem_off_last + msize <= page_split)) {
+        /* The entire operation fits within a single page. */
+        info->reg_off_last[0] = reg_off_last;
+        return true;
+    }
+
+    info->page_split = page_split;
+    elt_split = page_split / msize;
+    reg_off_split = elt_split << esz;
+    mem_off_split = elt_split * msize;
+
+    /*
+     * This is the last full element on the first page, but it is not
+     * necessarily active.  If there is no full element, i.e. the first
+     * active element is the one that's split, this value remains -1.
+     * It is useful as iteration bounds.
+     */
+    if (elt_split != 0) {
+        info->reg_off_last[0] = reg_off_split - esize;
+    }
+
+    /* Determine if an unaligned element spans the pages.  */
+    if (page_split % msize != 0) {
+        /* It is helpful to know if the split element is active. */
+        if ((vg[reg_off_split >> 6] >> (reg_off_split & 63)) & 1) {
+            info->reg_off_split = reg_off_split;
+            info->mem_off_split = mem_off_split;
+
+            if (reg_off_split == reg_off_last) {
+                /* The page crossing element is last. */
+                return true;
+            }
+        }
+        reg_off_split += esize;
+        mem_off_split += msize;
+    }
+
+    /*
+     * We do want the first active element on the second page, because
+     * this may affect the address reported in an exception.
+     */
+    reg_off_split = find_next_active(vg, reg_off_split, reg_max, esz);
+    tcg_debug_assert(reg_off_split <= reg_off_last);
+    info->reg_off_first[1] = reg_off_split;
+    info->mem_off_first[1] = (reg_off_split >> esz) * msize;
+    info->reg_off_last[1] = reg_off_last;
+    return true;
+}
+
+/*
+ * Resolve the guest virtual addresses to info->page[].
+ * Control the generation of page faults with @fault.  Return false if
+ * there is no work to do, which can only happen with @fault == FAULT_NO.
+ */
+static bool __attribute__((unused))
+sve_cont_ldst_pages(SVEContLdSt *info, SVEContFault fault, CPUARMState *env,
+                    target_ulong addr, MMUAccessType access_type,
+                    uintptr_t retaddr)
+{
+    int mmu_idx = cpu_mmu_index(env, false);
+    int mem_off = info->mem_off_first[0];
+    bool nofault = fault == FAULT_NO;
+    bool have_work = true;
+
+    if (!sve_probe_page(&info->page[0], nofault, env, addr, mem_off,
+                        access_type, mmu_idx, retaddr)) {
+        /* No work to be done. */
+        return false;
+    }
+
+    if (likely(info->page_split < 0)) {
+        /* The entire operation was on the one page. */
+        return true;
+    }
+
+    /*
+     * If the second page is invalid, then we want the fault address to be
+     * the first byte on that page which is accessed.
+     */
+    if (info->mem_off_split >= 0) {
+        /*
+         * There is an element split across the pages.  The fault address
+         * should be the first byte of the second page.
+         */
+        mem_off = info->page_split;
+        /*
+         * If the split element is also the first active element
+         * of the vector, then:  For first-fault we should continue
+         * to generate faults for the second page.  For no-fault,
+         * we have work only if the second page is valid.
+         */
+        if (info->mem_off_first[0] < info->mem_off_split) {
+            nofault = FAULT_FIRST;
+            have_work = false;
+        }
+    } else {
+        /*
+         * There is no element split across the pages.  The fault address
+         * should be the first active element on the second page.
+         */
+        mem_off = info->mem_off_first[1];
+        /*
+         * There must have been one active element on the first page,
+         * so we're out of first-fault territory.
+         */
+        nofault = fault != FAULT_ALL;
+    }
+
+    have_work |= sve_probe_page(&info->page[1], nofault, env, addr, mem_off,
+                                access_type, mmu_idx, retaddr);
+    return have_work;
+}
+
 /*
  * The result of tlb_vaddr_to_host for user-only is just g2h(x),
  * which is always non-null.  Elide the useless test.
-- 
2.20.1


