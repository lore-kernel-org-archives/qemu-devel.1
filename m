Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA914C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1459206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TuQ7Xbfd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1459206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8dy-0002tx-Qt
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Zj-0002D3-QB
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:31 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Zi-00076q-LQ
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:31 -0400
Received: by mail-wr1-x441.google.com with SMTP id i15so10962518wrx.10
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=CQboh7y+EHPP7sJC4SySB6VjlEwG4682cwAsQyFjJUM=;
 b=TuQ7XbfdrHx4FKN38P07EMbrrtmzTHX5VMAW2ZH/pbVi6TMlP+vMWzcF7I+GmkpjQY
 KWK28k831PPw72n80cVGi+1ERlEVzTCsm4g/P//eOtH8ejz31UyC5GT2j4dyLDgrJuGB
 POZVSICOdC4n19bo0wqeGzb2iSKxsZZkZmqkDOm0VD7tGOnjbX2Z5w54rZmi4qlwwua2
 9WU9J6HyczbYqh7Jph9t8ZLuKcDNSuFV3leoTTGKC85EclyizEMieSL/qgJA6THLRKVe
 wK04xvds3j++Kn6y1Efyy1EiAO0aKzKFyVnH0a3boMABxMMOB7IRg5qbR79jTkRj0cXH
 MbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CQboh7y+EHPP7sJC4SySB6VjlEwG4682cwAsQyFjJUM=;
 b=YpBpKdYh1bxvDeCxGDtqejQxeNKYKJgAotODf2nnCBGSsqe+Jg2+lymm6KxmzONuph
 SNBmbFbIHx5pfp2WMUiyhDjLp7Q1DikblCNL2VtKE3pdzgY/BVDB5ChtqNtlKLkDFhvb
 cFLFEXpw8Z8LP3RifIHLYAwdt0DpqMBXnz7ehvhvvtmiJCzjR12yEL+I6rWrfHWNCDjE
 6v0MjTK8a0SE/fkcRzI7ztALQhRN1VbjQRZz3B9WrKgyKBZJ3bFSGVcnZmLB5iXsyRCY
 4B3UUMgwvGHJu4vYf9yQsvZqfHUtvG0NXq5ejiPwSGztjSfWrdd/kYvx/egjo5z8kVm3
 MP8g==
X-Gm-Message-State: AGi0PuZK1oPxFrJwVjEJfQqygpR08Dj2ZWMY8jAobDVf5NkZsGk6gOme
 14Gjrxtlz3J7qPy+UCHiKWFXqHXK0jfI0Q==
X-Google-Smtp-Source: APiQypLMdm5xLfKkAWX+vbi88xq5uBnIOeazWuw93t/4uRQhkZB4okpmR9t5tE4Nbf2y4eCVVwjgtA==
X-Received: by 2002:a5d:4006:: with SMTP id n6mr19553207wrp.27.1589204068805; 
 Mon, 11 May 2020 06:34:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/34] target/arm: Use SVEContLdSt in sve_ld1_r
Date: Mon, 11 May 2020 14:33:49 +0100
Message-Id: <20200511133405.5275-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

First use of the new helper functions, so we can remove the
unused markup.  No longer need a scratch for user-only, as
we completely probe the page set before reading; system mode
still requires a scratch for MMIO.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200508154359.7494-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/sve_helper.c | 188 +++++++++++++++++++++-------------------
 1 file changed, 97 insertions(+), 91 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index d0071377351..6bae342a177 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4221,9 +4221,9 @@ typedef struct {
  * final element on each page.  Identify any single element that spans
  * the page boundary.  Return true if there are any active elements.
  */
-static bool __attribute__((unused))
-sve_cont_ldst_elements(SVEContLdSt *info, target_ulong addr, uint64_t *vg,
-                       intptr_t reg_max, int esz, int msize)
+static bool sve_cont_ldst_elements(SVEContLdSt *info, target_ulong addr,
+                                   uint64_t *vg, intptr_t reg_max,
+                                   int esz, int msize)
 {
     const int esize = 1 << esz;
     const uint64_t pg_mask = pred_esz_masks[esz];
@@ -4313,10 +4313,9 @@ sve_cont_ldst_elements(SVEContLdSt *info, target_ulong addr, uint64_t *vg,
  * Control the generation of page faults with @fault.  Return false if
  * there is no work to do, which can only happen with @fault == FAULT_NO.
  */
-static bool __attribute__((unused))
-sve_cont_ldst_pages(SVEContLdSt *info, SVEContFault fault, CPUARMState *env,
-                    target_ulong addr, MMUAccessType access_type,
-                    uintptr_t retaddr)
+static bool sve_cont_ldst_pages(SVEContLdSt *info, SVEContFault fault,
+                                CPUARMState *env, target_ulong addr,
+                                MMUAccessType access_type, uintptr_t retaddr)
 {
     int mmu_idx = cpu_mmu_index(env, false);
     int mem_off = info->mem_off_first[0];
@@ -4388,109 +4387,116 @@ static inline bool test_host_page(void *host)
 /*
  * Common helper for all contiguous one-register predicated loads.
  */
-static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
-                      uint32_t desc, const uintptr_t retaddr,
-                      const int esz, const int msz,
-                      sve_ldst1_host_fn *host_fn,
-                      sve_ldst1_tlb_fn *tlb_fn)
+static inline QEMU_ALWAYS_INLINE
+void sve_ld1_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
+               uint32_t desc, const uintptr_t retaddr,
+               const int esz, const int msz,
+               sve_ldst1_host_fn *host_fn,
+               sve_ldst1_tlb_fn *tlb_fn)
 {
-    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
-    const int mmu_idx = get_mmuidx(oi);
     const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
     void *vd = &env->vfp.zregs[rd];
-    const int diffsz = esz - msz;
     const intptr_t reg_max = simd_oprsz(desc);
-    const intptr_t mem_max = reg_max >> diffsz;
-    ARMVectorReg scratch;
+    intptr_t reg_off, reg_last, mem_off;
+    SVEContLdSt info;
     void *host;
-    intptr_t split, reg_off, mem_off;
+    int flags;
 
-    /* Find the first active element.  */
-    reg_off = find_next_active(vg, 0, reg_max, esz);
-    if (unlikely(reg_off == reg_max)) {
+    /* Find the active elements.  */
+    if (!sve_cont_ldst_elements(&info, addr, vg, reg_max, esz, 1 << msz)) {
         /* The entire predicate was false; no load occurs.  */
         memset(vd, 0, reg_max);
         return;
     }
-    mem_off = reg_off >> diffsz;
 
-    /*
-     * If the (remaining) load is entirely within a single page, then:
-     * For softmmu, and the tlb hits, then no faults will occur;
-     * For user-only, either the first load will fault or none will.
-     * We can thus perform the load directly to the destination and
-     * Vd will be unmodified on any exception path.
-     */
-    split = max_for_page(addr, mem_off, mem_max);
-    if (likely(split == mem_max)) {
-        host = tlb_vaddr_to_host(env, addr + mem_off, MMU_DATA_LOAD, mmu_idx);
-        if (test_host_page(host)) {
-            intptr_t i = reg_off;
-            host -= mem_off;
-            do {
-                host_fn(vd, i, host + (i >> diffsz));
-                i = find_next_active(vg, i + (1 << esz), reg_max, esz);
-            } while (i < reg_max);
-            /* After having taken any fault, zero leading inactive elements. */
-            swap_memzero(vd, reg_off);
-            return;
-        }
-    }
+    /* Probe the page(s).  Exit with exception for any invalid page. */
+    sve_cont_ldst_pages(&info, FAULT_ALL, env, addr, MMU_DATA_LOAD, retaddr);
 
-    /*
-     * Perform the predicated read into a temporary, thus ensuring
-     * if the load of the last element faults, Vd is not modified.
-     */
+    flags = info.page[0].flags | info.page[1].flags;
+    if (unlikely(flags != 0)) {
 #ifdef CONFIG_USER_ONLY
-    swap_memzero(&scratch, reg_off);
-    host = g2h(addr);
-    do {
-        host_fn(&scratch, reg_off, host + (reg_off >> diffsz));
-        reg_off += 1 << esz;
-        reg_off = find_next_active(vg, reg_off, reg_max, esz);
-    } while (reg_off < reg_max);
+        g_assert_not_reached();
 #else
-    memset(&scratch, 0, reg_max);
-    goto start;
-    while (1) {
-        reg_off = find_next_active(vg, reg_off, reg_max, esz);
-        if (reg_off >= reg_max) {
-            break;
-        }
-        mem_off = reg_off >> diffsz;
-        split = max_for_page(addr, mem_off, mem_max);
+        /*
+         * At least one page includes MMIO (or watchpoints).
+         * Any bus operation can fail with cpu_transaction_failed,
+         * which for ARM will raise SyncExternal.  Perform the load
+         * into scratch memory to preserve register state until the end.
+         */
+        ARMVectorReg scratch;
 
-    start:
-        if (split - mem_off >= (1 << msz)) {
-            /* At least one whole element on this page.  */
-            host = tlb_vaddr_to_host(env, addr + mem_off,
-                                     MMU_DATA_LOAD, mmu_idx);
-            if (host) {
-                host -= mem_off;
-                do {
-                    host_fn(&scratch, reg_off, host + mem_off);
-                    reg_off += 1 << esz;
-                    reg_off = find_next_active(vg, reg_off, reg_max, esz);
-                    mem_off = reg_off >> diffsz;
-                } while (split - mem_off >= (1 << msz));
-                continue;
+        memset(&scratch, 0, reg_max);
+        mem_off = info.mem_off_first[0];
+        reg_off = info.reg_off_first[0];
+        reg_last = info.reg_off_last[1];
+        if (reg_last < 0) {
+            reg_last = info.reg_off_split;
+            if (reg_last < 0) {
+                reg_last = info.reg_off_last[0];
             }
         }
 
-        /*
-         * Perform one normal read.  This may fault, longjmping out to the
-         * main loop in order to raise an exception.  It may succeed, and
-         * as a side-effect load the TLB entry for the next round.  Finally,
-         * in the extremely unlikely case we're performing this operation
-         * on I/O memory, it may succeed but not bring in the TLB entry.
-         * But even then we have still made forward progress.
-         */
-        tlb_fn(env, &scratch, reg_off, addr + mem_off, retaddr);
-        reg_off += 1 << esz;
-    }
-#endif
+        do {
+            uint64_t pg = vg[reg_off >> 6];
+            do {
+                if ((pg >> (reg_off & 63)) & 1) {
+                    tlb_fn(env, &scratch, reg_off, addr + mem_off, retaddr);
+                }
+                reg_off += 1 << esz;
+                mem_off += 1 << msz;
+            } while (reg_off & 63);
+        } while (reg_off <= reg_last);
 
-    memcpy(vd, &scratch, reg_max);
+        memcpy(vd, &scratch, reg_max);
+        return;
+#endif
+    }
+
+    /* The entire operation is in RAM, on valid pages. */
+
+    memset(vd, 0, reg_max);
+    mem_off = info.mem_off_first[0];
+    reg_off = info.reg_off_first[0];
+    reg_last = info.reg_off_last[0];
+    host = info.page[0].host;
+
+    while (reg_off <= reg_last) {
+        uint64_t pg = vg[reg_off >> 6];
+        do {
+            if ((pg >> (reg_off & 63)) & 1) {
+                host_fn(vd, reg_off, host + mem_off);
+            }
+            reg_off += 1 << esz;
+            mem_off += 1 << msz;
+        } while (reg_off <= reg_last && (reg_off & 63));
+    }
+
+    /*
+     * Use the slow path to manage the cross-page misalignment.
+     * But we know this is RAM and cannot trap.
+     */
+    mem_off = info.mem_off_split;
+    if (unlikely(mem_off >= 0)) {
+        tlb_fn(env, vd, info.reg_off_split, addr + mem_off, retaddr);
+    }
+
+    mem_off = info.mem_off_first[1];
+    if (unlikely(mem_off >= 0)) {
+        reg_off = info.reg_off_first[1];
+        reg_last = info.reg_off_last[1];
+        host = info.page[1].host;
+
+        do {
+            uint64_t pg = vg[reg_off >> 6];
+            do {
+                if ((pg >> (reg_off & 63)) & 1) {
+                    host_fn(vd, reg_off, host + mem_off);
+                }
+                reg_off += 1 << esz;
+                mem_off += 1 << msz;
+            } while (reg_off & 63);
+        } while (reg_off <= reg_last);
+    }
 }
 
 #define DO_LD1_1(NAME, ESZ) \
-- 
2.20.1


