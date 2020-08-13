Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670F7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30CE92078B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5xdg2Nr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30CE92078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6K2Q-0003BA-Er
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 16:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6K1b-0002IW-4u
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 16:40:35 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:37568)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6K1X-0007mk-Aw
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 16:40:34 -0400
Received: by mail-pj1-x1032.google.com with SMTP id mw10so3311574pjb.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 13:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=voPjM3N6WynTe4jY3BSy+e4erlst/gxqvDOsGBXJmcA=;
 b=V5xdg2Nrd7Q2kGOQUJFKs++F9WUw9Bw6BsGQNVRx7O5Y7uJ0CPOLs1q78DoYqm0WRn
 z0VBBpvJbO5Uhq99+GNYWEh4qE6BGY9AmBnMYl0Hcy3Y3dpv9v8aQca4IDYU1J/2edCQ
 pv10L4Tl+8oWeQAQINQExaVPXLyx/mVKq5mrt+TJSsJRm9417f4rK6hwWa88A2iuDvB3
 s+Kgl32ts6RoOxSylq0Ao0zr8Bht8wvaVUKKWZxAqhCZL3XmCWfAc++mH3G+9tSY5SSo
 S6j3UfayG/HWZO1Bfr5YU+tVKCKwJ2FVhtuLDZyEr0ES7cV+0iLUBhNv9HcdaHllOprn
 VOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=voPjM3N6WynTe4jY3BSy+e4erlst/gxqvDOsGBXJmcA=;
 b=o5kQ6+RnYbnwcgjpAypbLCo9M0ScYczYnPf70ZrOk+HwH81HUrp+rKTAm2GZmwkB2Z
 WH58+VffS8wPoVJSi49H9Ig3kYZ8TXrYv8RaxCndO9dLWM887aDVEh31YsQdfzH4bcJa
 jqc6uPnovRpbYS6Sk+DTG1FEvYJiH5TJIO+Cv30T29oZ6bclqqfvBYUFKYaMIGJDR6nC
 PJZRmq8NMLc6IFy68acKvfmmwoDA1LlPk2dw17G2T3fJzVxoQ0gR8UJo2qB75PatUyvi
 jt4qV3YwiW75nREbtNjWR66V+PW3/t8fVHGLOz13Uz8j6JbrWlrv4SJgl92jnvqvrb3P
 hSaw==
X-Gm-Message-State: AOAM530StiOkcBGi56xchEyf2wdZ6JP4aDm7YHlL1njSAoiptLJcsn0S
 oX0P/+mz1DnKLaeHqwbs9Et1webBykw=
X-Google-Smtp-Source: ABdhPJyYmx3jN1J+Ozf5vL24Mk3m0I3FHY4iRmP/QJ/ZFu9RL6JwziMhVc1BUmghWyWPuQBE2TJtzg==
X-Received: by 2002:a17:90a:bb8a:: with SMTP id
 v10mr6574831pjr.144.1597351228553; 
 Thu, 13 Aug 2020 13:40:28 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q5sm5853313pgi.31.2020.08.13.13.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 13:40:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/1] cputlb: Make store_helper less fragile to compiler
 optimizations
Date: Thu, 13 Aug 2020 13:40:24 -0700
Message-Id: <20200813204024.3077275-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813204024.3077275-1-richard.henderson@linaro.org>
References: <20200813204024.3077275-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Shu-Chun Weng <scw@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This has no functional change.

The current function structure is:

    inline QEMU_ALWAYSINLINE
    store_memop() {
        switch () {
            ...
        default:
            qemu_build_not_reached();
        }
    }
    inline QEMU_ALWAYSINLINE
    store_helper() {
        ...
        if (span_two_pages_or_io) {
            ...
            helper_ret_stb_mmu();
        }
        store_memop();
    }
    helper_ret_stb_mmu() {
        store_helper();
    }

Whereas GCC will generate an error at compile-time when an always_inline
function is not inlined, Clang does not.  Nor does Clang prioritize the
inlining of always_inline functions.  Both of these are arguably bugs.

Both `store_memop` and `store_helper` need to be inlined and allow
constant propogations to eliminate the `qemu_build_not_reached` call.

However, if the compiler instead chooses to inline helper_ret_stb_mmu
into store_helper, then store_helper is now self-recursive and the
compiler is no longer able to propagate the constant in the same way.

This does not produce at current QEMU head, but was reproducible
at v4.2.0 with `clang-10 -O2 -fexperimental-new-pass-manager`.

The inline recursion problem can be fixed solely by marking
helper_ret_stb_mmu as noinline, so the compiler does not make an
incorrect decision about which functions to inline.

In addition, extract store_helper_unaligned as a noinline subroutine
that can be shared by all of the helpers.  This saves about 6k code
size in an optimized x86_64 build.

Reported-by: Shu-Chun Weng <scw@google.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 138 ++++++++++++++++++++++++++-------------------
 1 file changed, 79 insertions(+), 59 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5698292749..7e603d6666 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2009,6 +2009,80 @@ store_memop(void *haddr, uint64_t val, MemOp op)
     }
 }
 
+static void __attribute__((noinline))
+store_helper_unaligned(CPUArchState *env, target_ulong addr, uint64_t val,
+                       uintptr_t retaddr, size_t size, uintptr_t mmu_idx,
+                       bool big_endian)
+{
+    const size_t tlb_off = offsetof(CPUTLBEntry, addr_write);
+    uintptr_t index, index2;
+    CPUTLBEntry *entry, *entry2;
+    target_ulong page2, tlb_addr, tlb_addr2;
+    TCGMemOpIdx oi;
+    size_t size2;
+    int i;
+
+    /*
+     * Ensure the second page is in the TLB.  Note that the first page
+     * is already guaranteed to be filled, and that the second page
+     * cannot evict the first.
+     */
+    page2 = (addr + size) & TARGET_PAGE_MASK;
+    size2 = (addr + size) & ~TARGET_PAGE_MASK;
+    index2 = tlb_index(env, mmu_idx, page2);
+    entry2 = tlb_entry(env, mmu_idx, page2);
+
+    tlb_addr2 = tlb_addr_write(entry2);
+    if (!tlb_hit_page(tlb_addr2, page2)) {
+        if (!victim_tlb_hit(env, mmu_idx, index2, tlb_off, page2)) {
+            tlb_fill(env_cpu(env), page2, size2, MMU_DATA_STORE,
+                     mmu_idx, retaddr);
+            index2 = tlb_index(env, mmu_idx, page2);
+            entry2 = tlb_entry(env, mmu_idx, page2);
+        }
+        tlb_addr2 = tlb_addr_write(entry2);
+    }
+
+    index = tlb_index(env, mmu_idx, addr);
+    entry = tlb_entry(env, mmu_idx, addr);
+    tlb_addr = tlb_addr_write(entry);
+
+    /*
+     * Handle watchpoints.  Since this may trap, all checks
+     * must happen before any store.
+     */
+    if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
+        cpu_check_watchpoint(env_cpu(env), addr, size - size2,
+                             env_tlb(env)->d[mmu_idx].iotlb[index].attrs,
+                             BP_MEM_WRITE, retaddr);
+    }
+    if (unlikely(tlb_addr2 & TLB_WATCHPOINT)) {
+        cpu_check_watchpoint(env_cpu(env), page2, size2,
+                             env_tlb(env)->d[mmu_idx].iotlb[index2].attrs,
+                             BP_MEM_WRITE, retaddr);
+    }
+
+    /*
+     * XXX: not efficient, but simple.
+     * This loop must go in the forward direction to avoid issues
+     * with self-modifying code in Windows 64-bit.
+     */
+    oi = make_memop_idx(MO_UB, mmu_idx);
+    if (big_endian) {
+        for (i = 0; i < size; ++i) {
+            /* Big-endian extract.  */
+            uint8_t val8 = val >> (((size - 1) * 8) - (i * 8));
+            helper_ret_stb_mmu(env, addr + i, val8, oi, retaddr);
+        }
+    } else {
+        for (i = 0; i < size; ++i) {
+            /* Little-endian extract.  */
+            uint8_t val8 = val >> (i * 8);
+            helper_ret_stb_mmu(env, addr + i, val8, oi, retaddr);
+        }
+    }
+}
+
 static inline void QEMU_ALWAYS_INLINE
 store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
              TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
@@ -2097,64 +2171,9 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
     if (size > 1
         && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
                      >= TARGET_PAGE_SIZE)) {
-        int i;
-        uintptr_t index2;
-        CPUTLBEntry *entry2;
-        target_ulong page2, tlb_addr2;
-        size_t size2;
-
     do_unaligned_access:
-        /*
-         * Ensure the second page is in the TLB.  Note that the first page
-         * is already guaranteed to be filled, and that the second page
-         * cannot evict the first.
-         */
-        page2 = (addr + size) & TARGET_PAGE_MASK;
-        size2 = (addr + size) & ~TARGET_PAGE_MASK;
-        index2 = tlb_index(env, mmu_idx, page2);
-        entry2 = tlb_entry(env, mmu_idx, page2);
-        tlb_addr2 = tlb_addr_write(entry2);
-        if (!tlb_hit_page(tlb_addr2, page2)) {
-            if (!victim_tlb_hit(env, mmu_idx, index2, tlb_off, page2)) {
-                tlb_fill(env_cpu(env), page2, size2, MMU_DATA_STORE,
-                         mmu_idx, retaddr);
-                index2 = tlb_index(env, mmu_idx, page2);
-                entry2 = tlb_entry(env, mmu_idx, page2);
-            }
-            tlb_addr2 = tlb_addr_write(entry2);
-        }
-
-        /*
-         * Handle watchpoints.  Since this may trap, all checks
-         * must happen before any store.
-         */
-        if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
-            cpu_check_watchpoint(env_cpu(env), addr, size - size2,
-                                 env_tlb(env)->d[mmu_idx].iotlb[index].attrs,
-                                 BP_MEM_WRITE, retaddr);
-        }
-        if (unlikely(tlb_addr2 & TLB_WATCHPOINT)) {
-            cpu_check_watchpoint(env_cpu(env), page2, size2,
-                                 env_tlb(env)->d[mmu_idx].iotlb[index2].attrs,
-                                 BP_MEM_WRITE, retaddr);
-        }
-
-        /*
-         * XXX: not efficient, but simple.
-         * This loop must go in the forward direction to avoid issues
-         * with self-modifying code in Windows 64-bit.
-         */
-        for (i = 0; i < size; ++i) {
-            uint8_t val8;
-            if (memop_big_endian(op)) {
-                /* Big-endian extract.  */
-                val8 = val >> (((size - 1) * 8) - (i * 8));
-            } else {
-                /* Little-endian extract.  */
-                val8 = val >> (i * 8);
-            }
-            helper_ret_stb_mmu(env, addr + i, val8, oi, retaddr);
-        }
+        store_helper_unaligned(env, addr, val, retaddr, size,
+                               mmu_idx, memop_big_endian(op));
         return;
     }
 
@@ -2162,8 +2181,9 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
     store_memop(haddr, val, op);
 }
 
-void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
-                        TCGMemOpIdx oi, uintptr_t retaddr)
+void __attribute__((noinline))
+helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
+                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
     store_helper(env, addr, val, oi, retaddr, MO_UB);
 }
-- 
2.25.1


