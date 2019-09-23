Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EF9C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8800208C2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8800208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCKKD-0005fB-Ve
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 05:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iCJv0-0001va-Ok
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iCJuz-000643-0Z
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:42:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44030)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iCJuy-00061U-OO
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:42:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EEA16301D67F;
 Mon, 23 Sep 2019 08:41:59 +0000 (UTC)
Received: from [10.36.116.207] (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C6511001B05;
 Mon, 23 Sep 2019 08:41:56 +0000 (UTC)
Subject: Re: [PATCH v3 13/20] cputlb: Move NOTDIRTY handling from I/O path to
 TLB path
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190922035458.14879-1-richard.henderson@linaro.org>
 <20190922035458.14879-14-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <9b9f12bb-ec0d-061c-6d98-512cd41d9e9b@redhat.com>
Date: Mon, 23 Sep 2019 10:41:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190922035458.14879-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 23 Sep 2019 08:42:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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

On 22.09.19 05:54, Richard Henderson wrote:
> Pages that we want to track for NOTDIRTY are RAM.  We do not
> really need to go through the I/O path to handle them.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu-common.h |  2 --
>  accel/tcg/cputlb.c        | 26 +++++++++++++++++---
>  exec.c                    | 50 ---------------------------------------
>  memory.c                  | 16 -------------
>  4 files changed, 23 insertions(+), 71 deletions(-)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 1c0e03ddc2..81753bbb34 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -100,8 +100,6 @@ void qemu_flush_coalesced_mmio_buffer(void);
>  
>  void cpu_flush_icache_range(hwaddr start, hwaddr len);
>  
> -extern struct MemoryRegion io_mem_notdirty;
> -
>  typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
>  
>  int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 7ab523d7ec..b7bd738115 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -904,7 +904,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>      mr = section->mr;
>      mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
>      cpu->mem_io_pc = retaddr;
> -    if (mr != &io_mem_notdirty && !cpu->can_do_io) {
> +    if (!cpu->can_do_io) {
>          cpu_io_recompile(cpu, retaddr);
>      }
>  
> @@ -945,7 +945,7 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>      section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
>      mr = section->mr;
>      mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
> -    if (mr != &io_mem_notdirty && !cpu->can_do_io) {
> +    if (!cpu->can_do_io) {
>          cpu_io_recompile(cpu, retaddr);
>      }
>      cpu->mem_io_vaddr = addr;
> @@ -1606,7 +1606,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
>          }
>  
>          /* Handle I/O access.  */
> -        if (likely(tlb_addr & (TLB_MMIO | TLB_NOTDIRTY))) {
> +        if (tlb_addr & TLB_MMIO) {
>              io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr,
>                        op ^ (tlb_addr & TLB_BSWAP ? MO_BSWAP : 0));
>              return;
> @@ -1619,6 +1619,26 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
>  
>          haddr = (void *)((uintptr_t)addr + entry->addend);
>  
> +        /* Handle clean RAM pages.  */
> +        if (tlb_addr & TLB_NOTDIRTY) {
> +            NotDirtyInfo ndi;
> +
> +            /* We require mem_io_pc in tb_invalidate_phys_page_range.  */
> +            env_cpu(env)->mem_io_pc = retaddr;
> +
> +            memory_notdirty_write_prepare(&ndi, env_cpu(env), addr,
> +                                          addr + iotlbentry->addr, size);
> +
> +            if (unlikely(tlb_addr & TLB_BSWAP)) {
> +                direct_swap(haddr, val);
> +            } else {
> +                direct(haddr, val);
> +            }
> +
> +            memory_notdirty_write_complete(&ndi);
> +            return;
> +        }
> +
>          if (unlikely(tlb_addr & TLB_BSWAP)) {
>              direct_swap(haddr, val);
>          } else {
> diff --git a/exec.c b/exec.c
> index e21e068535..abf58b68a0 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -88,7 +88,6 @@ static MemoryRegion *system_io;
>  AddressSpace address_space_io;
>  AddressSpace address_space_memory;
>  
> -MemoryRegion io_mem_notdirty;
>  static MemoryRegion io_mem_unassigned;
>  #endif
>  
> @@ -157,7 +156,6 @@ typedef struct subpage_t {
>  } subpage_t;
>  
>  #define PHYS_SECTION_UNASSIGNED 0
> -#define PHYS_SECTION_NOTDIRTY 1
>  
>  static void io_mem_init(void);
>  static void memory_map_init(void);
> @@ -1438,9 +1436,6 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
>      if (memory_region_is_ram(section->mr)) {
>          /* Normal RAM.  */
>          iotlb = memory_region_get_ram_addr(section->mr) + xlat;
> -        if (!section->readonly) {
> -            iotlb |= PHYS_SECTION_NOTDIRTY;
> -        }
>      } else {
>          AddressSpaceDispatch *d;
>  
> @@ -2749,42 +2744,6 @@ void memory_notdirty_write_complete(NotDirtyInfo *ndi)
>      }
>  }
>  
> -/* Called within RCU critical section.  */
> -static void notdirty_mem_write(void *opaque, hwaddr ram_addr,
> -                               uint64_t val, unsigned size)
> -{
> -    NotDirtyInfo ndi;
> -
> -    memory_notdirty_write_prepare(&ndi, current_cpu, current_cpu->mem_io_vaddr,
> -                         ram_addr, size);
> -
> -    stn_p(qemu_map_ram_ptr(NULL, ram_addr), size, val);
> -    memory_notdirty_write_complete(&ndi);
> -}
> -
> -static bool notdirty_mem_accepts(void *opaque, hwaddr addr,
> -                                 unsigned size, bool is_write,
> -                                 MemTxAttrs attrs)
> -{
> -    return is_write;
> -}
> -
> -static const MemoryRegionOps notdirty_mem_ops = {
> -    .write = notdirty_mem_write,
> -    .valid.accepts = notdirty_mem_accepts,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> -    .valid = {
> -        .min_access_size = 1,
> -        .max_access_size = 8,
> -        .unaligned = false,
> -    },
> -    .impl = {
> -        .min_access_size = 1,
> -        .max_access_size = 8,
> -        .unaligned = false,
> -    },
> -};
> -
>  /* Generate a debug exception if a watchpoint has been hit.  */
>  void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
>                            MemTxAttrs attrs, int flags, uintptr_t ra)
> @@ -2980,13 +2939,6 @@ static void io_mem_init(void)
>  {
>      memory_region_init_io(&io_mem_unassigned, NULL, &unassigned_mem_ops, NULL,
>                            NULL, UINT64_MAX);
> -
> -    /* io_mem_notdirty calls tb_invalidate_phys_page_fast,
> -     * which can be called without the iothread mutex.
> -     */
> -    memory_region_init_io(&io_mem_notdirty, NULL, &notdirty_mem_ops, NULL,
> -                          NULL, UINT64_MAX);
> -    memory_region_clear_global_locking(&io_mem_notdirty);
>  }
>  
>  AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv)
> @@ -2996,8 +2948,6 @@ AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv)
>  
>      n = dummy_section(&d->map, fv, &io_mem_unassigned);
>      assert(n == PHYS_SECTION_UNASSIGNED);
> -    n = dummy_section(&d->map, fv, &io_mem_notdirty);
> -    assert(n == PHYS_SECTION_NOTDIRTY);
>  
>      d->phys_map  = (PhysPageEntry) { .ptr = PHYS_MAP_NODE_NIL, .skip = 1 };
>  
> diff --git a/memory.c b/memory.c
> index 57c44c97db..a99b8c0767 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -434,10 +434,6 @@ static MemTxResult  memory_region_read_accessor(MemoryRegion *mr,
>      tmp = mr->ops->read(mr->opaque, addr, size);
>      if (mr->subpage) {
>          trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp, size);
> -    } else if (mr == &io_mem_notdirty) {
> -        /* Accesses to code which has previously been translated into a TB show
> -         * up in the MMIO path, as accesses to the io_mem_notdirty
> -         * MemoryRegion. */
>      } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
>          hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size);
> @@ -460,10 +456,6 @@ static MemTxResult memory_region_read_with_attrs_accessor(MemoryRegion *mr,
>      r = mr->ops->read_with_attrs(mr->opaque, addr, &tmp, size, attrs);
>      if (mr->subpage) {
>          trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp, size);
> -    } else if (mr == &io_mem_notdirty) {
> -        /* Accesses to code which has previously been translated into a TB show
> -         * up in the MMIO path, as accesses to the io_mem_notdirty
> -         * MemoryRegion. */
>      } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
>          hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size);
> @@ -484,10 +476,6 @@ static MemTxResult memory_region_write_accessor(MemoryRegion *mr,
>  
>      if (mr->subpage) {
>          trace_memory_region_subpage_write(get_cpu_index(), mr, addr, tmp, size);
> -    } else if (mr == &io_mem_notdirty) {
> -        /* Accesses to code which has previously been translated into a TB show
> -         * up in the MMIO path, as accesses to the io_mem_notdirty
> -         * MemoryRegion. */
>      } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
>          hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp, size);
> @@ -508,10 +496,6 @@ static MemTxResult memory_region_write_with_attrs_accessor(MemoryRegion *mr,
>  
>      if (mr->subpage) {
>          trace_memory_region_subpage_write(get_cpu_index(), mr, addr, tmp, size);
> -    } else if (mr == &io_mem_notdirty) {
> -        /* Accesses to code which has previously been translated into a TB show
> -         * up in the MMIO path, as accesses to the io_mem_notdirty
> -         * MemoryRegion. */
>      } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
>          hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp, size);
> 

Complicated stuff but I think this is fine

Acked-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

