Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A16CC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4BD521D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jtGcg8nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BD521D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDCWC-0007kc-OE
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 15:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIh-0001qM-E7
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIf-0004JT-GD
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:07 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37307)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDCIf-0004IR-7j
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:05 -0400
Received: by mail-pl1-x643.google.com with SMTP id u20so2927089plq.4
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 11:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lX5+tQiTw7pbywR4o4yaxcCikFvv/gVg8TPYVx+VaVQ=;
 b=jtGcg8nw5dEC11J861lR2ghlPLoj+YU76dkTCAPsVXMqqsGU0EA6BMzVnTCCYIEb2f
 LXy4JOnJZYnT53MQgMyZrRJegokCmHWOKvFVTHSv2vFcUjV3xpr5vh3CQudBuhasSGLt
 wCQb/6fnFoR2N+b5nDuFOETb593/fCaEg+bcmUaGVXR1bPKRBJJzHXu/4REwtIqW9g8s
 +OHijnEYUv32L7mtOy8KVFoQ42XD2D112kUxYSPuiaYutvNZ67CoSxF2/8mJfl1ZnBd4
 d/QFegVHHU2IQtoPLEpoONTXaxRgm7JUaZFnN3T0uzBGuSrwtJj1ckS3Mtmzvl2ahhR2
 SSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lX5+tQiTw7pbywR4o4yaxcCikFvv/gVg8TPYVx+VaVQ=;
 b=W4MsWK3ZxwWIJ2Hp4Na03rnQAuJsNsX2ShRg/4ZZS/W+/tyOjsrLU4mcvB5SDd1M9M
 9z+zRpY7cacZlwr5txF1Pd7MNVk3KPb4NE8viqAVLVC7I6q7wai9uRfxZ32u/oq5zZHs
 akGvOzytRqGIc13tJ6s0AtIutsKSmscTR7kA6fo7qLtEJ/v2DPDvw1KKX47Xt5bQxGPP
 u3GfLqLdMrR/jEQFqm/E+1zesvvfsdBTV7oT8lnEqdB57cbyvPJvV08exTXdZC8KosW2
 X5OHl3VDvv7pluFHhsBXLNfZYX2ipuTR4KAi/xj8UdyoSQ1X+eQEoeePVrGdbkVeKMfW
 9jKg==
X-Gm-Message-State: APjAAAWOLbNlv32QKOj6q+571GDm5HU6MbgVtPoEjbGfxMU4suMf74bX
 toeLIA+gRsgRdiXTT3E3/nZDHSDdMiQ=
X-Google-Smtp-Source: APXvYqykX8uBSsO4V6De5CFw8nBxNFQgxUBVynEz1AVJtkioiZdPPs2l7h5G58JIHSfZRVu/y34O4g==
X-Received: by 2002:a17:902:a418:: with SMTP id
 p24mr10551070plq.312.1569437163709; 
 Wed, 25 Sep 2019 11:46:03 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.61])
 by smtp.gmail.com with ESMTPSA id l24sm6133229pff.151.2019.09.25.11.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 11:46:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/16] cputlb: Move NOTDIRTY handling from I/O path to TLB path
Date: Wed, 25 Sep 2019 11:45:41 -0700
Message-Id: <20190925184548.30673-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925184548.30673-1-richard.henderson@linaro.org>
References: <20190925184548.30673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pages that we want to track for NOTDIRTY are RAM.  We do not
really need to go through the I/O path to handle them.

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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
index 404ec57a4e..7e9a0f7ac8 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -905,7 +905,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
     cpu->mem_io_pc = retaddr;
-    if (mr != &io_mem_notdirty && !cpu->can_do_io) {
+    if (!cpu->can_do_io) {
         cpu_io_recompile(cpu, retaddr);
     }
 
@@ -946,7 +946,7 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
-    if (mr != &io_mem_notdirty && !cpu->can_do_io) {
+    if (!cpu->can_do_io) {
         cpu_io_recompile(cpu, retaddr);
     }
     cpu->mem_io_vaddr = addr;
@@ -1612,7 +1612,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         need_swap = size > 1 && (tlb_addr & TLB_BSWAP);
 
         /* Handle I/O access.  */
-        if (likely(tlb_addr & (TLB_MMIO | TLB_NOTDIRTY))) {
+        if (tlb_addr & TLB_MMIO) {
             io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr,
                       op ^ (need_swap * MO_BSWAP));
             return;
@@ -1625,6 +1625,26 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
 
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
+            if (unlikely(need_swap)) {
+                store_memop(haddr, val, op ^ MO_BSWAP);
+            } else {
+                store_memop(haddr, val, op);
+            }
+
+            memory_notdirty_write_complete(&ndi);
+            return;
+        }
+
         /*
          * Keep these two store_memop separate to ensure that the compiler
          * is able to fold the entire function to a single instruction.
diff --git a/exec.c b/exec.c
index ea8c0b18ac..dc7001f115 100644
--- a/exec.c
+++ b/exec.c
@@ -88,7 +88,6 @@ static MemoryRegion *system_io;
 AddressSpace address_space_io;
 AddressSpace address_space_memory;
 
-MemoryRegion io_mem_notdirty;
 static MemoryRegion io_mem_unassigned;
 #endif
 
@@ -191,7 +190,6 @@ typedef struct subpage_t {
 } subpage_t;
 
 #define PHYS_SECTION_UNASSIGNED 0
-#define PHYS_SECTION_NOTDIRTY 1
 
 static void io_mem_init(void);
 static void memory_map_init(void);
@@ -1472,9 +1470,6 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
     if (memory_region_is_ram(section->mr)) {
         /* Normal RAM.  */
         iotlb = memory_region_get_ram_addr(section->mr) + xlat;
-        if (!section->readonly) {
-            iotlb |= PHYS_SECTION_NOTDIRTY;
-        }
     } else {
         AddressSpaceDispatch *d;
 
@@ -2783,42 +2778,6 @@ void memory_notdirty_write_complete(NotDirtyInfo *ndi)
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
@@ -3014,13 +2973,6 @@ static void io_mem_init(void)
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
@@ -3030,8 +2982,6 @@ AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv)
 
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


