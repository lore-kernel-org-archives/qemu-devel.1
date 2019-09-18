Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022A3C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 05:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B46A120856
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 05:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VTZ54ZA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46A120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iASY0-0003nv-Uo
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 01:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iASUO-0002LV-9s
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 01:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iASUK-00072f-PT
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 01:26:52 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iASUK-00071w-Gy
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 01:26:48 -0400
Received: by mail-pg1-x541.google.com with SMTP id w10so3299328pgj.7
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 22:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=eXPsXxfGFS9uUqqPWcAIj6xMUAWCK7/m700bnBt4I/g=;
 b=VTZ54ZA5ekmnyDYQYsZ6NPEEyVFlLIFyBcteVaQNn3vmesK8ygPPDNnnVQhN3obbtR
 4ZpfjqcuVE8J/Tfy2wq/1j97aeBqcGrFTAyt1b6RrM4emZg+9NDJyVOSpfcvDoc7cbTS
 5CjhBkPgr2pXUMBUPP/H2t7LCB+w9s7CM1LZklJg3bf0Mnh7hOshE/eRDoYXCFdjRFRe
 /y+TbZB2VC4pKmIjrAcSfqbQsrGng5y1WaZNK124Aggm5gVY6XAm6faLJroAoi4cCXf7
 p04kh3yG7YK7tQIv8jrsNtfggCRvftog1P/SMzwBr/YOqsLisPfnbXsRJ1b64WiLf+/K
 NMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=eXPsXxfGFS9uUqqPWcAIj6xMUAWCK7/m700bnBt4I/g=;
 b=FliFiVhPSDX95DuXU3WdXvKzfMImN9CW7q5BxhjZEQX0ZZdimnnRh97hhCF5P/uttl
 r+pIyUsvocRW3n1x1q+AEfROMLdYBe6N0ySgwKv2+OZo5xF1Z36v1SyskidUdIdNW/km
 TDGnMkLD91fBWPLt/YJMwapcg8yDWBu77QdFcoLaPaaL9Ywg2KpxHcORxq6MTSGrMOD8
 1CmoX8VXld2YE62zoF5nzL69wQVwMynCfc5PCM9lAx7kk/R3iYzDnSr8jUlilpWjNFX2
 +IrSjXxZ2XMIpUVeToPRhtlEogoyRiQRh38X7fwsy2C9th/5ufZGFHPa37gq5le9xiEs
 SiGA==
X-Gm-Message-State: APjAAAUlZhM4f1E3JAAcqJPaQ2V5LuS7DRH8zt+r9eDnqDYbypLsPJBZ
 ys54HU4j92DO1lqYBv5hc5iUtsCc/UA=
X-Google-Smtp-Source: APXvYqyy5RgDukOlEHYR0oJbE3BWhKDwXGupR1XU5yU4gR9z0oAyWaduyWuCn3WNVBFAD8RXdTjGFw==
X-Received: by 2002:a62:5214:: with SMTP id g20mr2190363pfb.103.1568784407045; 
 Tue, 17 Sep 2019 22:26:47 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a1sm3457234pgd.74.2019.09.17.22.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 22:26:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 22:26:40 -0700
Message-Id: <20190918052641.21300-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190918052641.21300-1-richard.henderson@linaro.org>
References: <20190918052641.21300-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [RFC 2/3] cputlb: Move NOTDIRTY handling from I/O path
 to TLB path
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pages that we want to track for NOTDIRTY are RAM.  We do not
really need to go through the I/O path to handle them.

Create cpu_notdirty_write() from the corpses of
memory_notdirty_write_prepare and memory_notdirty_write_complete.
Use this new function to implement all of the notdirty handling.

This merge is enabled by a previous patch, 9458a9a1df1a
("memory: fix race between TCG and accesses"), which forces
users of the dirty bitmap to delay reads until all vcpu
have exited any TB.  Thus we no longer require the actual
write to happen between *_prepare and *_complete.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-common.h      |  1 -
 include/exec/memory-internal.h | 53 +++---------------
 accel/tcg/cputlb.c             | 66 +++++++++++++----------
 exec.c                         | 98 ++++++----------------------------
 memory.c                       | 16 ------
 5 files changed, 61 insertions(+), 173 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index f7dbe75fbc..06c60c82be 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -101,7 +101,6 @@ void qemu_flush_coalesced_mmio_buffer(void);
 void cpu_flush_icache_range(hwaddr start, hwaddr len);
 
 extern struct MemoryRegion io_mem_rom;
-extern struct MemoryRegion io_mem_notdirty;
 
 typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
 
diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index ef4fb92371..55f75e7315 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -52,67 +52,28 @@ void mtree_print_dispatch(struct AddressSpaceDispatch *d,
 
 struct page_collection;
 
-/* Opaque struct for passing info from memory_notdirty_write_prepare()
- * to memory_notdirty_write_complete(). Callers should treat all fields
- * as private, with the exception of @active.
- *
- * @active is a field which is not touched by either the prepare or
- * complete functions, but which the caller can use if it wishes to
- * track whether it has called prepare for this struct and so needs
- * to later call the complete function.
- */
-typedef struct {
-    CPUState *cpu;
-    struct page_collection *pages;
-    ram_addr_t ram_addr;
-    vaddr mem_vaddr;
-    unsigned size;
-    bool active;
-} NotDirtyInfo;
-
 /**
- * memory_notdirty_write_prepare: call before writing to non-dirty memory
- * @ndi: pointer to opaque NotDirtyInfo struct
+ * cpu_notdirty_write: call before writing to non-dirty memory
  * @cpu: CPU doing the write
  * @mem_vaddr: virtual address of write
  * @ram_addr: the ram address of the write
  * @size: size of write in bytes
  *
- * Any code which writes to the host memory corresponding to
- * guest RAM which has been marked as NOTDIRTY must wrap those
- * writes in calls to memory_notdirty_write_prepare() and
- * memory_notdirty_write_complete():
+ * Any code which writes to the host memory corresponding to guest RAM
+ * which has been marked as NOTDIRTY must call cpu_notdirty_write().
  *
- *  NotDirtyInfo ndi;
- *  memory_notdirty_write_prepare(&ndi, ....);
- *  ... perform write here ...
- *  memory_notdirty_write_complete(&ndi);
- *
- * These calls will ensure that we flush any TCG translated code for
+ * This function ensures that we flush any TCG translated code for
  * the memory being written, update the dirty bits and (if possible)
  * remove the slowpath callback for writing to the memory.
  *
  * This must only be called if we are using TCG; it will assert otherwise.
  *
- * We may take locks in the prepare call, so callers must ensure that
- * they don't exit (via longjump or otherwise) without calling complete.
- *
  * This call must only be made inside an RCU critical section.
  * (Note that while we're executing a TCG TB we're always in an
- * RCU critical section, which is likely to be the case for callers
- * of these functions.)
+ * RCU critical section, which is likely to be the case for any callers.)
  */
-void memory_notdirty_write_prepare(NotDirtyInfo *ndi,
-                                   CPUState *cpu,
-                                   vaddr mem_vaddr,
-                                   ram_addr_t ram_addr,
-                                   unsigned size);
-/**
- * memory_notdirty_write_complete: finish write to non-dirty memory
- * @ndi: pointer to the opaque NotDirtyInfo struct which was initialized
- * by memory_not_dirty_write_prepare().
- */
-void memory_notdirty_write_complete(NotDirtyInfo *ndi);
+void cpu_notdirty_write(CPUState *cpu, vaddr mem_vaddr,
+                        ram_addr_t ram_addr, unsigned size);
 
 #endif
 #endif
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 354a75927a..7c4c763b88 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -904,7 +904,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
     cpu->mem_io_pc = retaddr;
-    if (mr != &io_mem_rom && mr != &io_mem_notdirty && !cpu->can_do_io) {
+    if (mr != &io_mem_rom && !cpu->can_do_io) {
         cpu_io_recompile(cpu, retaddr);
     }
 
@@ -945,7 +945,7 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
-    if (mr != &io_mem_rom && mr != &io_mem_notdirty && !cpu->can_do_io) {
+    if (mr != &io_mem_rom && !cpu->can_do_io) {
         cpu_io_recompile(cpu, retaddr);
     }
     cpu->mem_io_vaddr = addr;
@@ -1117,16 +1117,26 @@ void *probe_access(CPUArchState *env, target_ulong addr, int size,
         return NULL;
     }
 
-    /* Handle watchpoints.  */
-    if (tlb_addr & TLB_WATCHPOINT) {
-        cpu_check_watchpoint(env_cpu(env), addr, size,
-                             env_tlb(env)->d[mmu_idx].iotlb[index].attrs,
-                             wp_access, retaddr);
-    }
+    if (unlikely(tlb_addr & (TLB_WATCHPOINT | TLB_NOTDIRTY | TLB_MMIO))) {
+        CPUIOTLBEntry *iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
 
-    if (tlb_addr & (TLB_NOTDIRTY | TLB_MMIO)) {
-        /* I/O access */
-        return NULL;
+        /* Reject memory mapped I/O.  */
+        if (tlb_addr & TLB_MMIO) {
+            /* I/O access */
+            return NULL;
+        }
+
+        /* Handle watchpoints.  */
+        if (tlb_addr & TLB_WATCHPOINT) {
+            cpu_check_watchpoint(env_cpu(env), addr, size, iotlbentry->attrs,
+                                 wp_access, retaddr);
+        }
+
+        /* Handle clean pages.  */
+        if (tlb_addr & TLB_NOTDIRTY) {
+            cpu_notdirty_write(env_cpu(env), addr,
+                               addr + iotlbentry->addr, size);
+        }
     }
 
     return (void *)((uintptr_t)addr + entry->addend);
@@ -1185,8 +1195,7 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
 /* Probe for a read-modify-write atomic operation.  Do not allow unaligned
  * operations, or io operations to proceed.  Return the host address.  */
 static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
-                               TCGMemOpIdx oi, uintptr_t retaddr,
-                               NotDirtyInfo *ndi)
+                               TCGMemOpIdx oi, uintptr_t retaddr)
 {
     size_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
@@ -1227,7 +1236,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
         tlb_addr = tlb_addr_write(tlbe) & ~TLB_INVALID_MASK;
     }
 
-    /* Notice an IO access or a needs-MMU-lookup access */
+    /* Notice an IO access */
     if (unlikely(tlb_addr & TLB_MMIO)) {
         /* There's really nothing that can be done to
            support this apart from stop-the-world.  */
@@ -1246,12 +1255,10 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 
     hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
 
-    ndi->active = false;
     if (unlikely(tlb_addr & TLB_NOTDIRTY)) {
-        ndi->active = true;
-        memory_notdirty_write_prepare(ndi, env_cpu(env), addr,
-                                      qemu_ram_addr_from_host_nofail(hostaddr),
-                                      1 << s_bits);
+        CPUIOTLBEntry *iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
+        cpu_notdirty_write(env_cpu(env), addr,
+                           addr + iotlbentry->addr, 1 << s_bits);
     }
 
     return hostaddr;
@@ -1603,12 +1610,18 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         }
 
         /* Handle I/O access.  */
-        if (likely(tlb_addr & (TLB_MMIO | TLB_NOTDIRTY))) {
+        if (likely(tlb_addr & TLB_MMIO)) {
             io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr,
                       op ^ (tlb_addr & TLB_BSWAP ? MO_BSWAP : 0));
             return;
         }
 
+        /* Handle clean pages.  This is always RAM.  */
+        if (tlb_addr & TLB_NOTDIRTY) {
+            cpu_notdirty_write(env_cpu(env), addr,
+                               addr + iotlbentry->addr, size);
+        }
+
         if (unlikely(tlb_addr & TLB_BSWAP)) {
             haddr = (void *)((uintptr_t)addr + entry->addend);
             direct_swap(haddr, val);
@@ -1735,14 +1748,9 @@ void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
 #define EXTRA_ARGS     , TCGMemOpIdx oi, uintptr_t retaddr
 #define ATOMIC_NAME(X) \
     HELPER(glue(glue(glue(atomic_ ## X, SUFFIX), END), _mmu))
-#define ATOMIC_MMU_DECLS NotDirtyInfo ndi
-#define ATOMIC_MMU_LOOKUP atomic_mmu_lookup(env, addr, oi, retaddr, &ndi)
-#define ATOMIC_MMU_CLEANUP                              \
-    do {                                                \
-        if (unlikely(ndi.active)) {                     \
-            memory_notdirty_write_complete(&ndi);       \
-        }                                               \
-    } while (0)
+#define ATOMIC_MMU_DECLS 
+#define ATOMIC_MMU_LOOKUP atomic_mmu_lookup(env, addr, oi, retaddr)
+#define ATOMIC_MMU_CLEANUP
 
 #define DATA_SIZE 1
 #include "atomic_template.h"
@@ -1770,7 +1778,7 @@ void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
 #undef ATOMIC_MMU_LOOKUP
 #define EXTRA_ARGS         , TCGMemOpIdx oi
 #define ATOMIC_NAME(X)     HELPER(glue(glue(atomic_ ## X, SUFFIX), END))
-#define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, oi, GETPC(), &ndi)
+#define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, oi, GETPC())
 
 #define DATA_SIZE 1
 #include "atomic_template.h"
diff --git a/exec.c b/exec.c
index 9babe57615..219198e80e 100644
--- a/exec.c
+++ b/exec.c
@@ -88,7 +88,7 @@ static MemoryRegion *system_io;
 AddressSpace address_space_io;
 AddressSpace address_space_memory;
 
-MemoryRegion io_mem_rom, io_mem_notdirty;
+MemoryRegion io_mem_rom;
 static MemoryRegion io_mem_unassigned;
 #endif
 
@@ -191,8 +191,7 @@ typedef struct subpage_t {
 } subpage_t;
 
 #define PHYS_SECTION_UNASSIGNED 0
-#define PHYS_SECTION_NOTDIRTY 1
-#define PHYS_SECTION_ROM 2
+#define PHYS_SECTION_ROM 1
 
 static void io_mem_init(void);
 static void memory_map_init(void);
@@ -1473,9 +1472,7 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
     if (memory_region_is_ram(section->mr)) {
         /* Normal RAM.  */
         iotlb = memory_region_get_ram_addr(section->mr) + xlat;
-        if (!section->readonly) {
-            iotlb |= PHYS_SECTION_NOTDIRTY;
-        } else {
+        if (section->readonly) {
             iotlb |= PHYS_SECTION_ROM;
         }
     } else {
@@ -2743,85 +2740,33 @@ ram_addr_t qemu_ram_addr_from_host(void *ptr)
 }
 
 /* Called within RCU critical section. */
-void memory_notdirty_write_prepare(NotDirtyInfo *ndi,
-                          CPUState *cpu,
-                          vaddr mem_vaddr,
-                          ram_addr_t ram_addr,
-                          unsigned size)
+void cpu_notdirty_write(CPUState *cpu, vaddr mem_vaddr,
+                        ram_addr_t ram_addr, unsigned size)
 {
-    ndi->cpu = cpu;
-    ndi->ram_addr = ram_addr;
-    ndi->mem_vaddr = mem_vaddr;
-    ndi->size = size;
-    ndi->pages = NULL;
-
     trace_memory_notdirty_write(mem_vaddr, ram_addr, size);
 
     assert(tcg_enabled());
     if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_CODE)) {
-        ndi->pages = page_collection_lock(ram_addr, ram_addr + size);
-        tb_invalidate_phys_page_fast(ndi->pages, ram_addr, size);
-    }
-}
+        struct page_collection *pages;
 
-/* Called within RCU critical section. */
-void memory_notdirty_write_complete(NotDirtyInfo *ndi)
-{
-    if (ndi->pages) {
-        assert(tcg_enabled());
-        page_collection_unlock(ndi->pages);
-        ndi->pages = NULL;
+        pages = page_collection_lock(ram_addr, ram_addr + size);
+        tb_invalidate_phys_page_fast(pages, ram_addr, size);
+        page_collection_unlock(pages);
     }
 
-    /* Set both VGA and migration bits for simplicity and to remove
+    /*
+     * Set both VGA and migration bits for simplicity and to remove
      * the notdirty callback faster.
      */
-    cpu_physical_memory_set_dirty_range(ndi->ram_addr, ndi->size,
-                                        DIRTY_CLIENTS_NOCODE);
-    /* we remove the notdirty callback only if the code has been
-       flushed */
-    if (!cpu_physical_memory_is_clean(ndi->ram_addr)) {
-        trace_memory_notdirty_dirty(ndi->mem_vaddr);
-        tlb_set_dirty(ndi->cpu, ndi->mem_vaddr);
+    cpu_physical_memory_set_dirty_range(ram_addr, size, DIRTY_CLIENTS_NOCODE);
+
+    /* We remove the notdirty callback only if the code has been flushed.  */
+    if (!cpu_physical_memory_is_clean(ram_addr)) {
+        trace_memory_notdirty_dirty(mem_vaddr);
+        tlb_set_dirty(cpu, mem_vaddr);
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
@@ -3051,13 +2996,6 @@ static void io_mem_init(void)
                           NULL, NULL, UINT64_MAX);
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
@@ -3067,8 +3005,6 @@ AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv)
 
     n = dummy_section(&d->map, fv, &io_mem_unassigned);
     assert(n == PHYS_SECTION_UNASSIGNED);
-    n = dummy_section(&d->map, fv, &io_mem_notdirty);
-    assert(n == PHYS_SECTION_NOTDIRTY);
     n = dummy_section(&d->map, fv, &io_mem_rom);
     assert(n == PHYS_SECTION_ROM);
 
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


