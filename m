Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AFEC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 334C520716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOrzOhml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334C520716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxQ5-0002Hi-Ck
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 18:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDwym-0007RO-GK
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 17:41:14 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:46152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDwyh-0004aB-2W
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 17:41:12 -0400
Received: by mail-pg1-x52d.google.com with SMTP id 31so3141132pgy.13
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 14:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IMG3qseWSaOmr5obAEbYxrSknPJe5yf/j+8Oo8HLII4=;
 b=VOrzOhmlVAWCYlFKporFwHYZxIC51hXuBXnY4gSTM16rv4qVYEl8t4IBIo2fI/SYn9
 Dc3sxXqdOPM7molRjqDUKOT5NX0VOvSsT+H7A2ioRyADljrQyIrA09BZmAaQq3042rHO
 B42IqSWmrgTa2QyLb+/vjRihknaqPgy47CAjBWFpkl0f6n5j43sM9MO3DkMJ8CLNH1+Q
 OFQb9liuAfIfZ659RmqTNCPvN/XPyXHqtQXBFEd1+v6eycpcMOcJhE52Nslj8AvMLDPN
 03oVs3gL7g3KC6QCmsl6UDsMTJoYTaql5rfblK3p3+3yFCdT3U8f94zwmNFAPRyNZ7sG
 UWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IMG3qseWSaOmr5obAEbYxrSknPJe5yf/j+8Oo8HLII4=;
 b=lCmqSBG/iEr7jFBYNhBezjMC4hxMnzTSn5RoWiglvg82lBgWGy7YAAyZiVF7gCHxud
 9jlS34i7VWjMeKBSuZFUY2oVf0Vna4zkaxG5XF+/5bH/osWrb4du0M3k6kNEzZ8WGH+4
 XnyqItU93GIyFYiK1YgQMyPVTv0s8X1Euou99RUnEOZUtk2c1nnfnrQ2XPUcnjJknPVp
 2cMgBGLfYOuc5Y+/g8AmEUP/HJAsNItIivnJeGI7FMY51w+/lKvzqgLynTDp8SL+fMV9
 yA5TXoQZAAnSRpqs1zmFGTRudnxAC6MUsOqNv5QdnVqudtJSGsEV8Dexgg5l55M/F3/G
 SyzQ==
X-Gm-Message-State: AOAM5305MlOX5jTNuJDaqeVup8/WQvgAen4EbPaoFME8RMkbq68q/5LX
 XYfOzueYynyNU4Jz9B25lK6BRLwGN2LxCA==
X-Google-Smtp-Source: ABdhPJyFJy94Zeik0GYh7GFnbIOy96MXCrOdU3ON6w8WAG71YBnpBE5aXx9Azaar98ZEFbEmsm9XtA==
X-Received: by 2002:a62:6003:: with SMTP id u3mr258146pfb.55.1599169264941;
 Thu, 03 Sep 2020 14:41:04 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v17sm4113290pfn.24.2020.09.03.14.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 14:41:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] cputlb: Make store_helper less fragile to compiler
 optimizations
Date: Thu,  3 Sep 2020 14:40:57 -0700
Message-Id: <20200903214101.1746878-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903214101.1746878-1-richard.henderson@linaro.org>
References: <20200903214101.1746878-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
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
index 2d48281942..6489abbf8c 100644
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


