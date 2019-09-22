Return-Path: <SRS0=thrq=XR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3793CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:10:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01EA220673
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5aLi2qV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EA220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBtCZ-0007pX-Sl
	for qemu-devel@archiver.kernel.org; Sun, 22 Sep 2019 00:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsy1-0001mB-5U
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsxz-0008I3-3m
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:21 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44909)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBsxy-0008Hc-OS
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:18 -0400
Received: by mail-pg1-x541.google.com with SMTP id g3so4419794pgs.11
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 20:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=l0x6N8LdqjYYjz2q3/Zm+HQDZY+orZYy+CSbM46axJQ=;
 b=F5aLi2qV/M0uhpdodo2zWB7S/Y/bvtX1+R7UFYy4ggy+AaDXhvGqeqDMr/VJouP0sw
 68eFCDwet4OxQ+zr/FOM9s+YW7AYXZUu5D3hD5BRThcyCF5ESO/kQ0HHRohz/G2YVM0o
 YboXCHH4Q1kknSyO42zOVdeaYEfJDwrBYxY62ggcwSSm4GjiT4PVnBNcxIabWQdMkXme
 9ITrk2x1qvEFVWGDIu43JQpsVxmu1P8alqSXUvbihJl4433GKXmj0tWlC5SoE485kWAs
 6RisMav8gzsXuwwG3eBeD6HN3ij6vShsVG0e4k1WR0YczK4Z0ZnuCTq1o2Gh2hAgMUEC
 Hbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=l0x6N8LdqjYYjz2q3/Zm+HQDZY+orZYy+CSbM46axJQ=;
 b=ac2jMMdJ/GxL94oyQdzU3si+fKoZ+komVNDzShxod/YrTvAXWtyuK6HxwPhhbrayCt
 NC51WSQ3ZNEe1uHhYQnX4QZXG05Tw3D59pK7ftBs6iKaMuDLuyo2Yoji//N6d9QB2HNh
 Bwft2vsIvX60cp25TZ9nQsFlI1uccAkv6GhOSMla0YIgE2+dsydIjCVp3/6se8ObrJuc
 RuYEGdo2eTkR1qAWq5yDv7Tll2kHJ8SgPCPoqlIW5CzvDKYdlecNnZnxGwRAk4Zpbd7K
 EASX0zOqZguvZHQhfpQPxmsnwZbDKhM1QQCEahwB/iqkqE/i5kLBGGXOCwkk4H2ckkMU
 H/vw==
X-Gm-Message-State: APjAAAWAZOtCukD1sHqKqmAi/Kn6TiB3AFJQ6jgYCKxlRD8ocJVbuH4f
 v39+QSi1FqVui6FkQDgw3PfeugtRvmI=
X-Google-Smtp-Source: APXvYqxJvoNyBxZlVzD1XetV19iz21uk1Nfkwyei7YxXXQEm9qUaMj9Yuwk5cJZ7D37X/3ksONeTjA==
X-Received: by 2002:a63:d60:: with SMTP id 32mr23212838pgn.316.1569124517127; 
 Sat, 21 Sep 2019 20:55:17 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z4sm6452921pjt.17.2019.09.21.20.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2019 20:55:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/20] cputlb: Move NOTDIRTY handling from I/O path to TLB
 path
Date: Sat, 21 Sep 2019 20:54:51 -0700
Message-Id: <20190922035458.14879-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190922035458.14879-1-richard.henderson@linaro.org>
References: <20190922035458.14879-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pages that we want to track for NOTDIRTY are RAM.  We do not
really need to go through the I/O path to handle them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-common.h |  2 --
 accel/tcg/cputlb.c        | 26 +++++++++++++++++---
 exec.c                    | 50 ---------------------------------------
 memory.c                  | 16 -------------
 4 files changed, 23 insertions(+), 71 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 1c0e03ddc2..81753bbb34 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -100,8 +100,6 @@ void qemu_flush_coalesced_mmio_buffer(void);
 
 void cpu_flush_icache_range(hwaddr start, hwaddr len);
 
-extern struct MemoryRegion io_mem_notdirty;
-
 typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
 
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7ab523d7ec..b7bd738115 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -904,7 +904,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
     cpu->mem_io_pc = retaddr;
-    if (mr != &io_mem_notdirty && !cpu->can_do_io) {
+    if (!cpu->can_do_io) {
         cpu_io_recompile(cpu, retaddr);
     }
 
@@ -945,7 +945,7 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
-    if (mr != &io_mem_notdirty && !cpu->can_do_io) {
+    if (!cpu->can_do_io) {
         cpu_io_recompile(cpu, retaddr);
     }
     cpu->mem_io_vaddr = addr;
@@ -1606,7 +1606,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         }
 
         /* Handle I/O access.  */
-        if (likely(tlb_addr & (TLB_MMIO | TLB_NOTDIRTY))) {
+        if (tlb_addr & TLB_MMIO) {
             io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr,
                       op ^ (tlb_addr & TLB_BSWAP ? MO_BSWAP : 0));
             return;
@@ -1619,6 +1619,26 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
 
         haddr = (void *)((uintptr_t)addr + entry->addend);
 
+        /* Handle clean RAM pages.  */
+        if (tlb_addr & TLB_NOTDIRTY) {
+            NotDirtyInfo ndi;
+
+            /* We require mem_io_pc in tb_invalidate_phys_page_range.  */
+            env_cpu(env)->mem_io_pc = retaddr;
+
+            memory_notdirty_write_prepare(&ndi, env_cpu(env), addr,
+                                          addr + iotlbentry->addr, size);
+
+            if (unlikely(tlb_addr & TLB_BSWAP)) {
+                direct_swap(haddr, val);
+            } else {
+                direct(haddr, val);
+            }
+
+            memory_notdirty_write_complete(&ndi);
+            return;
+        }
+
         if (unlikely(tlb_addr & TLB_BSWAP)) {
             direct_swap(haddr, val);
         } else {
diff --git a/exec.c b/exec.c
index e21e068535..abf58b68a0 100644
--- a/exec.c
+++ b/exec.c
@@ -88,7 +88,6 @@ static MemoryRegion *system_io;
 AddressSpace address_space_io;
 AddressSpace address_space_memory;
 
-MemoryRegion io_mem_notdirty;
 static MemoryRegion io_mem_unassigned;
 #endif
 
@@ -157,7 +156,6 @@ typedef struct subpage_t {
 } subpage_t;
 
 #define PHYS_SECTION_UNASSIGNED 0
-#define PHYS_SECTION_NOTDIRTY 1
 
 static void io_mem_init(void);
 static void memory_map_init(void);
@@ -1438,9 +1436,6 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
     if (memory_region_is_ram(section->mr)) {
         /* Normal RAM.  */
         iotlb = memory_region_get_ram_addr(section->mr) + xlat;
-        if (!section->readonly) {
-            iotlb |= PHYS_SECTION_NOTDIRTY;
-        }
     } else {
         AddressSpaceDispatch *d;
 
@@ -2749,42 +2744,6 @@ void memory_notdirty_write_complete(NotDirtyInfo *ndi)
     }
 }
 
-/* Called within RCU critical section.  */
-static void notdirty_mem_write(void *opaque, hwaddr ram_addr,
-                               uint64_t val, unsigned size)
-{
-    NotDirtyInfo ndi;
-
-    memory_notdirty_write_prepare(&ndi, current_cpu, current_cpu->mem_io_vaddr,
-                         ram_addr, size);
-
-    stn_p(qemu_map_ram_ptr(NULL, ram_addr), size, val);
-    memory_notdirty_write_complete(&ndi);
-}
-
-static bool notdirty_mem_accepts(void *opaque, hwaddr addr,
-                                 unsigned size, bool is_write,
-                                 MemTxAttrs attrs)
-{
-    return is_write;
-}
-
-static const MemoryRegionOps notdirty_mem_ops = {
-    .write = notdirty_mem_write,
-    .valid.accepts = notdirty_mem_accepts,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 8,
-        .unaligned = false,
-    },
-    .impl = {
-        .min_access_size = 1,
-        .max_access_size = 8,
-        .unaligned = false,
-    },
-};
-
 /* Generate a debug exception if a watchpoint has been hit.  */
 void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                           MemTxAttrs attrs, int flags, uintptr_t ra)
@@ -2980,13 +2939,6 @@ static void io_mem_init(void)
 {
     memory_region_init_io(&io_mem_unassigned, NULL, &unassigned_mem_ops, NULL,
                           NULL, UINT64_MAX);
-
-    /* io_mem_notdirty calls tb_invalidate_phys_page_fast,
-     * which can be called without the iothread mutex.
-     */
-    memory_region_init_io(&io_mem_notdirty, NULL, &notdirty_mem_ops, NULL,
-                          NULL, UINT64_MAX);
-    memory_region_clear_global_locking(&io_mem_notdirty);
 }
 
 AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv)
@@ -2996,8 +2948,6 @@ AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv)
 
     n = dummy_section(&d->map, fv, &io_mem_unassigned);
     assert(n == PHYS_SECTION_UNASSIGNED);
-    n = dummy_section(&d->map, fv, &io_mem_notdirty);
-    assert(n == PHYS_SECTION_NOTDIRTY);
 
     d->phys_map  = (PhysPageEntry) { .ptr = PHYS_MAP_NODE_NIL, .skip = 1 };
 
diff --git a/memory.c b/memory.c
index 57c44c97db..a99b8c0767 100644
--- a/memory.c
+++ b/memory.c
@@ -434,10 +434,6 @@ static MemTxResult  memory_region_read_accessor(MemoryRegion *mr,
     tmp = mr->ops->read(mr->opaque, addr, size);
     if (mr->subpage) {
         trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp, size);
-    } else if (mr == &io_mem_notdirty) {
-        /* Accesses to code which has previously been translated into a TB show
-         * up in the MMIO path, as accesses to the io_mem_notdirty
-         * MemoryRegion. */
     } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
         hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
         trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size);
@@ -460,10 +456,6 @@ static MemTxResult memory_region_read_with_attrs_accessor(MemoryRegion *mr,
     r = mr->ops->read_with_attrs(mr->opaque, addr, &tmp, size, attrs);
     if (mr->subpage) {
         trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp, size);
-    } else if (mr == &io_mem_notdirty) {
-        /* Accesses to code which has previously been translated into a TB show
-         * up in the MMIO path, as accesses to the io_mem_notdirty
-         * MemoryRegion. */
     } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
         hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
         trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size);
@@ -484,10 +476,6 @@ static MemTxResult memory_region_write_accessor(MemoryRegion *mr,
 
     if (mr->subpage) {
         trace_memory_region_subpage_write(get_cpu_index(), mr, addr, tmp, size);
-    } else if (mr == &io_mem_notdirty) {
-        /* Accesses to code which has previously been translated into a TB show
-         * up in the MMIO path, as accesses to the io_mem_notdirty
-         * MemoryRegion. */
     } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
         hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
         trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp, size);
@@ -508,10 +496,6 @@ static MemTxResult memory_region_write_with_attrs_accessor(MemoryRegion *mr,
 
     if (mr->subpage) {
         trace_memory_region_subpage_write(get_cpu_index(), mr, addr, tmp, size);
-    } else if (mr == &io_mem_notdirty) {
-        /* Accesses to code which has previously been translated into a TB show
-         * up in the MMIO path, as accesses to the io_mem_notdirty
-         * MemoryRegion. */
     } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
         hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
         trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp, size);
-- 
2.17.1


