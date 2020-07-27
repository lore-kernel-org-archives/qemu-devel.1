Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1F8C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229722074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y/szHDrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229722074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k08Ey-0006Pb-Db
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 14:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k08E4-0005Xg-Ty
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 14:51:52 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k08E2-0005sy-OR
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 14:51:52 -0400
Received: by mail-pl1-x643.google.com with SMTP id b9so8590542plx.6
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 11:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z5WIYbQSEaaOATSPOHvKV4ku83ggkBgPw79c14o7unk=;
 b=y/szHDrQGG+gmI3N5q+IzwRRtddWcA7iA044OLb9Lrhdg5jM7ZECEcIfOd8FBamWXv
 ZKBlXbjXxOUsopQGWdNAzkfU71ddzISs8yIyl1V+pT2hhTItsNEyC081hmVWmnDvEGhB
 uRdfiD7tymj0S39/G0lu9qucI8IOz4nxUWkxKn0V1L6oWs7TS2j3/PvVfZs0q/20hbsl
 TINRbguGHbfDcKb9OAb9o8hCHZtSEMrpe6ImsAtMZpVzviuelSe1M0DSm7APfPhWGP84
 IClmde4E/eTELZ8rAuxBuz6iAzid/w5V+qJMzrXz+46NVOKmgdOQzGTxLTNsGxh2lJQG
 MNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z5WIYbQSEaaOATSPOHvKV4ku83ggkBgPw79c14o7unk=;
 b=is2TDc3wO0XzJ4O6B7XjwMq9FJEBgGvqryOV/9ufHZQQegs3ojQINQknCXXFSB9XSg
 At46bU9Wrp97qk/xF1URqt1YxjmtiXOk72OCycWH9XuBz+fqwNcdCtcyQTkOtimb9Ewu
 XtSUbzheCkamAnzuoyVcVGb9wx/0DH4gpg05X97aMAONQf4G5yFlK0GPbPHWtEnLnFc/
 3pRGfhF/802sEJt/jro6eFxOfNiHd1u3wVvx5549W66FprXyLnNVJrCG6vcd7w8VGOMi
 5W7IWvCwUvAMRMH5u0E9tNLpzSfU+Pu7iQgsLul5+epu9p5GOGDA1bv5v2jz8QyzjM4i
 TS/A==
X-Gm-Message-State: AOAM531koJF4Oyu4QtXfGX/pgp4qeE4THG9rXU7PdJ9Ur9fEtFAjlpOV
 CoJghkTJlsZQAW55NYgY1eNiHQ==
X-Google-Smtp-Source: ABdhPJx2NBPt0qfCH24AATgAFWyI35LNsBJtivGWhzd6Jcpf0ybCYUABfRVC+dk3rv8TprsHbgzLMw==
X-Received: by 2002:a17:902:6545:: with SMTP id
 d5mr6576380pln.257.1595875909038; 
 Mon, 27 Jul 2020 11:51:49 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id f93sm305706pjk.56.2020.07.27.11.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 11:51:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: scw@google.com
Subject: Re: [PATCH v2] cputlb: Make store_helper less fragile to compiler
 optimizations
Date: Mon, 27 Jul 2020 11:51:47 -0700
Message-Id: <20200727185147.1017900-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724195128.2373212-1-scw@google.com>
References: <20200724195128.2373212-1-scw@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/24/20 12:51 PM, Shu-Chun Weng wrote:
> This change has no functional change.
> 
> There is a potential link error with "undefined symbol:
> qemu_build_not_reached" due to how `store_helper` is structured.
> This does not produce at current QEMU head, but was reproducible at
> v4.2.0 with `clang-10 -O2 -fexperimental-new-pass-manager`.

Thanks for the hint -- so far I had not been able to reproduce the
problem with any of clang 10, 11, or head (12), with default options.

> The current function structure is:
> 
>     inline QEMU_ALWAYSINLINE
>     store_memop() {
>         switch () {
>             ...
>         default:
>             qemu_build_not_reached();
>         }
>     }
>     inline QEMU_ALWAYSINLINE
>     store_helper() {
>         ...
>         if (span_two_pages_or_io) {
>             ...
>             helper_rst_stb_mmu();
>         }
>         store_memop();
>     }
>     helper_rst_stb_mmu() {
>         store_helper();
>     }
...
> The new structure is:
> 
>     inline QEMU_ALWAYSINLINE
>     store_memop() {
>         switch () {
>             ...
>         default:
>             qemu_build_not_reached();
>         }
>     }
>     inline QEMU_ALWAYSINLINE
>     store_helper_size_aligned()() {
>         ...
>         if (span_two_pages_or_io) {
>             return false;
>         }
>         store_memoop();
>         return true;
>     }
>     inline QEMU_ALWAYSINLINE
>     store_helper() {
>         if (store_helper_size_aligned() {
>             return;
>         }
>         helper_rst_stb_mmu();
>     }
>     helper_rst_stb_mmu() {
>         store_helper_size_aligned()();
>     }

Reasonable, I guess.

I did some experimenting though, and if I pull out the unaligned
portion into a noinline function, I can save about 6k code size.

Thoughts?


r~


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


