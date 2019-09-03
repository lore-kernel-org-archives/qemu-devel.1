Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D798C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E942C22CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TpBdmGv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E942C22CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BWb-00027n-7j
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BN5-0001Ql-2y
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BN3-0003tV-AL
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:30 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44927)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BN3-0003t6-2m
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:29 -0400
Received: by mail-pg1-x541.google.com with SMTP id i18so9387464pgl.11
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Skix+hAgqMkCzdxrRQp/gwNaGRFVNBB95exG932vdjo=;
 b=TpBdmGv+5MkNpu9HvgSnqMGezjjxtUG7IbwCXvaNUvm7cuNgdW8F5V64tMRFQ94R64
 ZugxkV1tGUTK1D7cv3yUqDk1fkXj9fUn6oEsLFAC5L3ROxhyl0mtweMA4X1v5VgFSCQ5
 ehyHvceNQStg+ilWq34uoY5kVrijlHHre3Kb5LGQUZ2mFM8cPxqxoVENk0NMWmvv8rYL
 DTscR4DOUuX6qEV044XTFN9G/qczbXiiav0EZgeaMM3XrqBTe0lNQ9G6EaYAxs48cyH6
 v5xG5fDtpCXl1mpXCRiFViw6fA7jeSf+reruHCHM+530QeYmhccp4TbFtPzPytk55zgf
 1lnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Skix+hAgqMkCzdxrRQp/gwNaGRFVNBB95exG932vdjo=;
 b=TZMmCvPXIMEK4FbkP49rH8/KgUtydl/aN8eFndHNBjinSsw/rwLH8QraFCrzW04bCd
 c1/tgYw0eBdJObyh+3y6BjcgzmyUYrvo1rmvVPolSk78GjXRFfnVLezChOaXks2g5ql9
 O0njKkN38ax/k8hLtp3Mr+Tld8+9NsPyv45G1sZDmLv07Vh9HtQ3nexBRv7TbwNRxDPK
 RKFocuvJCsuUT8rt0snyILTgYqnneqD22foQ/nD/seEo3PQRXvaLz8l4vv57gch7Y7Y6
 X1XxYGdSAWTn3tSms88eXX21DOLAVAbtX1bDq63g6AdLu6z4eMHCuD7Xoc3ChzFfM3cE
 sQeg==
X-Gm-Message-State: APjAAAUYbNbg7nVLDG84RW6L8QA+38f6183MCUwnoE7cvgLFKE0bvbMI
 ovJjirGrh9LbR4X+7g2mqjXoRhVOT40=
X-Google-Smtp-Source: APXvYqwTehH+hCcmP6gtMLMABypvbti0Y9oTCRg3+Te4PbU9YGru5AD1GYLHaKjoBoWL/pPRnCB7+w==
X-Received: by 2002:a17:90a:734a:: with SMTP id j10mr20125pjs.63.1567526967815; 
 Tue, 03 Sep 2019 09:09:27 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:44 -0700
Message-Id: <20190903160858.5296-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 22/36] cputlb: Fold TLB_RECHECK into
 TLB_INVALID_MASK
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

We had two different mechanisms to force a recheck of the tlb.

Before TLB_RECHECK was introduced, we had a PAGE_WRITE_INV bit
that would immediate set TLB_INVALID_MASK, which automatically
means that a second check of the tlb entry fails.

We can use the same mechanism to handle small pages.
Conserve TLB_* bits by removing TLB_RECHECK.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h |  5 +--
 accel/tcg/cputlb.c     | 86 +++++++++++-------------------------------
 2 files changed, 24 insertions(+), 67 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 8323094648..8d07ae23a5 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -329,14 +329,11 @@ CPUArchState *cpu_copy(CPUArchState *env);
 #define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS - 2))
 /* Set if TLB entry is an IO callback.  */
 #define TLB_MMIO            (1 << (TARGET_PAGE_BITS - 3))
-/* Set if TLB entry must have MMU lookup repeated for every access */
-#define TLB_RECHECK         (1 << (TARGET_PAGE_BITS - 4))
 
 /* Use this mask to check interception with an alignment mask
  * in a TCG backend.
  */
-#define TLB_FLAGS_MASK  (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO \
-                         | TLB_RECHECK)
+#define TLB_FLAGS_MASK  (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO)
 
 /**
  * tlb_hit_page: return true if page aligned @addr is a hit against the
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d9787cc893..c9576bebcf 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -732,11 +732,8 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
 
     address = vaddr_page;
     if (size < TARGET_PAGE_SIZE) {
-        /*
-         * Slow-path the TLB entries; we will repeat the MMU check and TLB
-         * fill on every access.
-         */
-        address |= TLB_RECHECK;
+        /* Repeat the MMU check and TLB fill on every access.  */
+        address |= TLB_INVALID_MASK;
     }
     if (attrs.byte_swap) {
         /* Force the access through the I/O slow path.  */
@@ -1026,10 +1023,15 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
   victim_tlb_hit(env, mmu_idx, index, offsetof(CPUTLBEntry, TY), \
                  (ADDR) & TARGET_PAGE_MASK)
 
-/* NOTE: this function can trigger an exception */
-/* NOTE2: the returned address is not exactly the physical address: it
- * is actually a ram_addr_t (in system mode; the user mode emulation
- * version of this function returns a guest virtual address).
+/*
+ * Return a ram_addr_t for the virtual address for execution.
+ *
+ * Return -1 if we can't translate and execute from an entire page
+ * of RAM.  This will force us to execute by loading and translating
+ * one insn at a time, without caching.
+ *
+ * NOTE: This function will trigger an exception if the page is
+ * not executable.
  */
 tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
 {
@@ -1043,19 +1045,20 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
             tlb_fill(env_cpu(env), addr, 0, MMU_INST_FETCH, mmu_idx, 0);
             index = tlb_index(env, mmu_idx, addr);
             entry = tlb_entry(env, mmu_idx, addr);
+
+            if (unlikely(entry->addr_code & TLB_INVALID_MASK)) {
+                /*
+                 * The MMU protection covers a smaller range than a target
+                 * page, so we must redo the MMU check for every insn.
+                 */
+                return -1;
+            }
         }
         assert(tlb_hit(entry->addr_code, addr));
     }
 
-    if (unlikely(entry->addr_code & (TLB_RECHECK | TLB_MMIO))) {
-        /*
-         * Return -1 if we can't translate and execute from an entire
-         * page of RAM here, which will cause us to execute by loading
-         * and translating one insn at a time, without caching:
-         *  - TLB_RECHECK: means the MMU protection covers a smaller range
-         *    than a target page, so we must redo the MMU check every insn
-         *  - TLB_MMIO: region is not backed by RAM
-         */
+    if (unlikely(entry->addr_code & TLB_MMIO)) {
+        /* The region is not backed by RAM.  */
         return -1;
     }
 
@@ -1180,7 +1183,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     }
 
     /* Notice an IO access or a needs-MMU-lookup access */
-    if (unlikely(tlb_addr & (TLB_MMIO | TLB_RECHECK))) {
+    if (unlikely(tlb_addr & TLB_MMIO)) {
         /* There's really nothing that can be done to
            support this apart from stop-the-world.  */
         goto stop_the_world;
@@ -1258,6 +1261,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
             entry = tlb_entry(env, mmu_idx, addr);
         }
         tlb_addr = code_read ? entry->addr_code : entry->addr_read;
+        tlb_addr &= ~TLB_INVALID_MASK;
     }
 
     /* Handle an IO access.  */
@@ -1265,27 +1269,6 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
         if ((addr & (size - 1)) != 0) {
             goto do_unaligned_access;
         }
-
-        if (tlb_addr & TLB_RECHECK) {
-            /*
-             * This is a TLB_RECHECK access, where the MMU protection
-             * covers a smaller range than a target page, and we must
-             * repeat the MMU check here. This tlb_fill() call might
-             * longjump out if this access should cause a guest exception.
-             */
-            tlb_fill(env_cpu(env), addr, size,
-                     access_type, mmu_idx, retaddr);
-            index = tlb_index(env, mmu_idx, addr);
-            entry = tlb_entry(env, mmu_idx, addr);
-
-            tlb_addr = code_read ? entry->addr_code : entry->addr_read;
-            tlb_addr &= ~TLB_RECHECK;
-            if (!(tlb_addr & ~TARGET_PAGE_MASK)) {
-                /* RAM access */
-                goto do_aligned_access;
-            }
-        }
-
         return io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
                         mmu_idx, addr, retaddr, access_type, op);
     }
@@ -1314,7 +1297,6 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
         return res & MAKE_64BIT_MASK(0, size * 8);
     }
 
- do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
     switch (op) {
     case MO_UB:
@@ -1509,27 +1491,6 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         if ((addr & (size - 1)) != 0) {
             goto do_unaligned_access;
         }
-
-        if (tlb_addr & TLB_RECHECK) {
-            /*
-             * This is a TLB_RECHECK access, where the MMU protection
-             * covers a smaller range than a target page, and we must
-             * repeat the MMU check here. This tlb_fill() call might
-             * longjump out if this access should cause a guest exception.
-             */
-            tlb_fill(env_cpu(env), addr, size, MMU_DATA_STORE,
-                     mmu_idx, retaddr);
-            index = tlb_index(env, mmu_idx, addr);
-            entry = tlb_entry(env, mmu_idx, addr);
-
-            tlb_addr = tlb_addr_write(entry);
-            tlb_addr &= ~TLB_RECHECK;
-            if (!(tlb_addr & ~TARGET_PAGE_MASK)) {
-                /* RAM access */
-                goto do_aligned_access;
-            }
-        }
-
         io_writex(env, &env_tlb(env)->d[mmu_idx].iotlb[index], mmu_idx,
                   val, addr, retaddr, op);
         return;
@@ -1579,7 +1540,6 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         return;
     }
 
- do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
     switch (op) {
     case MO_UB:
-- 
2.17.1


