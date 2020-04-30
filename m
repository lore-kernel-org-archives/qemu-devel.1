Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B48FC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC6C92070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZereAmgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6C92070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUCHy-0000x3-34
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC3B-0001qT-KR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC35-0006dr-KS
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:37 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUC35-0006YI-4q
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:31 -0400
Received: by mail-pl1-x643.google.com with SMTP id d24so2419494pll.8
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 09:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7ZJAf0ODZypJUEx/2hOu0Olpz0sJ7Rm6b/UcyBKBG+Y=;
 b=ZereAmgQO3hlSgIReZWndX/4U5wg9gmXv0KJO6OjOedqGmhrWYnB3STted5JkysLvH
 Nks+dwZxXd/g5sy1cRBnGLf47o4WQQLJU7KdMeWBFxfWO0o7I8yLUK+tVY/W5E1D7N+a
 P6ETwlMTyEPXZGyPR8O3EJWCrF0O/8DsdzmRE67PaKInPd3WDnPu7BfRWV0lLVOXp50Q
 Hl31S322UraBlxcWt3uYcBBrjpPn/+gLa4TO89skuAt/71MT5YsrpB/yhCmACkgKTMqY
 Wt2CPd27i4P/hXKsbxf1jNvn9O/qB8T015jbK8oJOQWLgWiIR7WINPhkc1LmBtILKvaL
 X5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7ZJAf0ODZypJUEx/2hOu0Olpz0sJ7Rm6b/UcyBKBG+Y=;
 b=GyK/u1KgKKRCzUr86NwvQjiTpi+P/uk+mpbYk3zK5BKLs10TG5o0AuHZzrT8an/kUe
 fy4QUTFSeLTYFeUqcUd4YddzxJ4u8hjKLyvKRzjl5eJ/pSRtBuedcbxa1HlgzdIuvg6Y
 w0gqs4YI3Acz0X6wT16JvGwF93j73K8seGEc2usyhrfqMWFIp6xP8Wt7jnyAjP6pOBcb
 Eazuj9NkuriB6O1qT4lorhbl0D/9RZnOC5Vu66txztQRCBWt2pd47TN2M34LaQaS69Vn
 fTgV/lVxmZycrRX+AcY2HpW8iZ9ySmQJFQ0cAsJMjuSy3MFNC0+tLYx4g+J9crTidADE
 A2fw==
X-Gm-Message-State: AGi0PuYmnasLrtm+nhmvY114+uNRJbDVhbc/E/W+R5gS8J5imVCbWUsD
 bBzxLargQKBBy2MGlu8LKpgZiw59lpo=
X-Google-Smtp-Source: APiQypKUsBLg6bcqc1vDh0FR6yHeza7MjeYLH8+q/wJlQrjbpVPEAh4Hhd8cyT5xFoqugW13ollYbw==
X-Received: by 2002:a17:902:9882:: with SMTP id
 s2mr4409551plp.184.1588264109355; 
 Thu, 30 Apr 2020 09:28:29 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id j5sm243514pfh.58.2020.04.30.09.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 09:28:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 10/18] target/arm: Use SVEContLdSt in sve_ld1_r
Date: Thu, 30 Apr 2020 09:28:05 -0700
Message-Id: <20200430162813.17671-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430162813.17671-1-richard.henderson@linaro.org>
References: <20200430162813.17671-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

First use of the new helper functions, so we can remove the
unused markup.  No longer need a scratch for user-only, as
we completely probe the page set before reading; system mode
still requires a scratch for MMIO.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 188 +++++++++++++++++++++-------------------
 1 file changed, 97 insertions(+), 91 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index d007137735..6bae342a17 100644
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


