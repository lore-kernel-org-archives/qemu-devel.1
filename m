Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D61EC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 06:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2407222CF5
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 06:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2407222CF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3EPN-0007mV-C9
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 02:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i3ENL-00065O-Q1
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 02:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i3ENJ-0003B9-T7
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 02:57:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33778)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1i3ENJ-0003Aj-KZ
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 02:57:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 02DB23084029;
 Thu, 29 Aug 2019 06:57:41 +0000 (UTC)
Received: from [10.36.117.166] (ovpn-117-166.ams2.redhat.com [10.36.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 220C03DE1;
 Thu, 29 Aug 2019 06:57:39 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190828231651.17176-1-richard.henderson@linaro.org>
 <20190828231651.17176-8-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <34d35514-82f0-130d-6c25-337df70219f2@redhat.com>
Date: Thu, 29 Aug 2019 08:57:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828231651.17176-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 29 Aug 2019 06:57:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 7/8] cputlb: Handle watchpoints via
 TLB_WATCHPOINT
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

On 29.08.19 01:16, Richard Henderson wrote:
> The raising of exceptions from check_watchpoint, buried inside
> of the I/O subsystem, is fundamentally broken.  We do not have
> the helper return address with which we can unwind guest state.
> 
> Replace PHYS_SECTION_WATCH and io_mem_watch with TLB_WATCHPOINT.
> Move the call to cpu_check_watchpoint into the cputlb helpers
> where we do have the helper return address.
> 
> This also allows us to handle watchpoints on RAM to bypass the
> full i/o access path.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu-all.h |   5 +-
>  accel/tcg/cputlb.c     |  89 ++++++++++++++++++++++++++++----
>  exec.c                 | 114 +++--------------------------------------
>  3 files changed, 90 insertions(+), 118 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 8d07ae23a5..d2d443c4f9 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -329,11 +329,14 @@ CPUArchState *cpu_copy(CPUArchState *env);
>  #define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS - 2))
>  /* Set if TLB entry is an IO callback.  */
>  #define TLB_MMIO            (1 << (TARGET_PAGE_BITS - 3))
> +/* Set if TLB entry contains a watchpoint.  */
> +#define TLB_WATCHPOINT      (1 << (TARGET_PAGE_BITS - 4))
>  
>  /* Use this mask to check interception with an alignment mask
>   * in a TCG backend.
>   */
> -#define TLB_FLAGS_MASK  (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO)
> +#define TLB_FLAGS_MASK \
> +    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO | TLB_WATCHPOINT)
>  
>  /**
>   * tlb_hit_page: return true if page aligned @addr is a hit against the
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index d0f8db33a2..9a9a626938 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -710,6 +710,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
>      hwaddr iotlb, xlat, sz, paddr_page;
>      target_ulong vaddr_page;
>      int asidx = cpu_asidx_from_attrs(cpu, attrs);
> +    int wp_flags;
>  
>      assert_cpu_is_self(cpu);
>  
> @@ -752,6 +753,8 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
>      code_address = address;
>      iotlb = memory_region_section_get_iotlb(cpu, section, vaddr_page,
>                                              paddr_page, xlat, prot, &address);
> +    wp_flags = cpu_watchpoint_address_matches(cpu, vaddr_page,
> +                                              TARGET_PAGE_SIZE);
>  
>      index = tlb_index(env, mmu_idx, vaddr_page);
>      te = tlb_entry(env, mmu_idx, vaddr_page);
> @@ -805,6 +808,9 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
>      tn.addend = addend - vaddr_page;
>      if (prot & PAGE_READ) {
>          tn.addr_read = address;
> +        if (wp_flags & BP_MEM_READ) {
> +            tn.addr_read |= TLB_WATCHPOINT;
> +        }
>      } else {
>          tn.addr_read = -1;
>      }
> @@ -831,6 +837,9 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
>          if (prot & PAGE_WRITE_INV) {
>              tn.addr_write |= TLB_INVALID_MASK;
>          }
> +        if (wp_flags & BP_MEM_WRITE) {
> +            tn.addr_write |= TLB_WATCHPOINT;
> +        }
>      }
>  
>      copy_tlb_helper_locked(te, &tn);
> @@ -1264,13 +1273,33 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>          tlb_addr &= ~TLB_INVALID_MASK;
>      }
>  
> -    /* Handle an IO access.  */
> +    /* Handle anything that isn't just a straight memory access.  */
>      if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
> +        CPUIOTLBEntry *iotlbentry;
> +
> +        /* For anything that is unaligned, recurse through full_load.  */
>          if ((addr & (size - 1)) != 0) {
>              goto do_unaligned_access;
>          }
> -        return io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
> -                        mmu_idx, addr, retaddr, access_type, op);
> +
> +        iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
> +
> +        /* Handle watchpoints.  */
> +        if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
> +            /* On watchpoint hit, this will longjmp out.  */
> +            cpu_check_watchpoint(env_cpu(env), addr, size,
> +                                 iotlbentry->attrs, BP_MEM_READ, retaddr);
> +
> +            /* The backing page may or may not require I/O.  */
> +            tlb_addr &= ~TLB_WATCHPOINT;
> +            if ((tlb_addr & ~TARGET_PAGE_MASK) == 0) {
> +                goto do_aligned_access;
> +            }
> +        }
> +
> +        /* Handle I/O access.  */
> +        return io_readx(env, iotlbentry, mmu_idx, addr,
> +                        retaddr, access_type, op);
>      }
>  
>      /* Handle slow unaligned access (it spans two pages or IO).  */
> @@ -1297,6 +1326,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>          return res & MAKE_64BIT_MASK(0, size * 8);
>      }
>  
> + do_aligned_access:
>      haddr = (void *)((uintptr_t)addr + entry->addend);
>      switch (op) {
>      case MO_UB:
> @@ -1486,13 +1516,32 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
>          tlb_addr = tlb_addr_write(entry) & ~TLB_INVALID_MASK;
>      }
>  
> -    /* Handle an IO access.  */
> +    /* Handle anything that isn't just a straight memory access.  */
>      if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
> +        CPUIOTLBEntry *iotlbentry;
> +
> +        /* For anything that is unaligned, recurse through byte stores.  */
>          if ((addr & (size - 1)) != 0) {
>              goto do_unaligned_access;
>          }
> -        io_writex(env, &env_tlb(env)->d[mmu_idx].iotlb[index], mmu_idx,
> -                  val, addr, retaddr, op);
> +
> +        iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
> +
> +        /* Handle watchpoints.  */
> +        if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
> +            /* On watchpoint hit, this will longjmp out.  */
> +            cpu_check_watchpoint(env_cpu(env), addr, size,
> +                                 iotlbentry->attrs, BP_MEM_WRITE, retaddr);
> +
> +            /* The backing page may or may not require I/O.  */
> +            tlb_addr &= ~TLB_WATCHPOINT;
> +            if ((tlb_addr & ~TARGET_PAGE_MASK) == 0) {
> +                goto do_aligned_access;
> +            }
> +        }
> +
> +        /* Handle I/O access.  */
> +        io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr, op);
>          return;
>      }
>  
> @@ -1517,10 +1566,29 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
>          index2 = tlb_index(env, mmu_idx, page2);
>          entry2 = tlb_entry(env, mmu_idx, page2);
>          tlb_addr2 = tlb_addr_write(entry2);
> -        if (!tlb_hit_page(tlb_addr2, page2)
> -            && !victim_tlb_hit(env, mmu_idx, index2, tlb_off, page2)) {
> -            tlb_fill(env_cpu(env), page2, size2, MMU_DATA_STORE,
> -                     mmu_idx, retaddr);
> +        if (!tlb_hit_page(tlb_addr2, page2)) {
> +            if (!victim_tlb_hit(env, mmu_idx, index2, tlb_off, page2)) {
> +                tlb_fill(env_cpu(env), page2, size2, MMU_DATA_STORE,
> +                         mmu_idx, retaddr);
> +                index2 = tlb_index(env, mmu_idx, page2);
> +                entry2 = tlb_entry(env, mmu_idx, page2);
> +            }
> +            tlb_addr2 = tlb_addr_write(entry2);
> +        }
> +
> +        /*
> +         * Handle watchpoints.  Since this may trap, all checks
> +         * must happen before any store.
> +         */
> +        if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
> +            cpu_check_watchpoint(env_cpu(env), addr, size - size2,
> +                                 env_tlb(env)->d[mmu_idx].iotlb[index].attrs,
> +                                 BP_MEM_WRITE, retaddr);
> +        }
> +        if (unlikely(tlb_addr2 & TLB_WATCHPOINT)) {
> +            cpu_check_watchpoint(env_cpu(env), page2, size2,
> +                                 env_tlb(env)->d[mmu_idx].iotlb[index2].attrs,
> +                                 BP_MEM_WRITE, retaddr);
>          }
>  
>          /*
> @@ -1542,6 +1610,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
>          return;
>      }
>  
> + do_aligned_access:
>      haddr = (void *)((uintptr_t)addr + entry->addend);
>      switch (op) {
>      case MO_UB:
> diff --git a/exec.c b/exec.c
> index 8575ce51ad..ad0f4a598f 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -193,15 +193,12 @@ typedef struct subpage_t {
>  #define PHYS_SECTION_UNASSIGNED 0
>  #define PHYS_SECTION_NOTDIRTY 1
>  #define PHYS_SECTION_ROM 2
> -#define PHYS_SECTION_WATCH 3
>  
>  static void io_mem_init(void);
>  static void memory_map_init(void);
>  static void tcg_log_global_after_sync(MemoryListener *listener);
>  static void tcg_commit(MemoryListener *listener);
>  
> -static MemoryRegion io_mem_watch;
> -
>  /**
>   * CPUAddressSpace: all the information a CPU needs about an AddressSpace
>   * @cpu: the CPU whose AddressSpace this is
> @@ -1472,7 +1469,6 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
>                                         target_ulong *address)
>  {
>      hwaddr iotlb;
> -    int flags, match;
>  
>      if (memory_region_is_ram(section->mr)) {
>          /* Normal RAM.  */
> @@ -1490,19 +1486,6 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
>          iotlb += xlat;
>      }
>  
> -    /* Avoid trapping reads of pages with a write breakpoint. */
> -    match = (prot & PAGE_READ ? BP_MEM_READ : 0)
> -          | (prot & PAGE_WRITE ? BP_MEM_WRITE : 0);
> -    flags = cpu_watchpoint_address_matches(cpu, vaddr, TARGET_PAGE_SIZE);
> -    if (flags & match) {
> -        /*
> -         * Make accesses to pages with watchpoints go via the
> -         * watchpoint trap routines.
> -         */
> -        iotlb = PHYS_SECTION_WATCH + paddr;
> -        *address |= TLB_MMIO;
> -    }
> -
>      return iotlb;
>  }
>  #endif /* defined(CONFIG_USER_ONLY) */
> @@ -2810,10 +2793,14 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
>  
>      assert(tcg_enabled());
>      if (cpu->watchpoint_hit) {
> -        /* We re-entered the check after replacing the TB. Now raise
> -         * the debug interrupt so that is will trigger after the
> -         * current instruction. */
> +        /*
> +         * We re-entered the check after replacing the TB.
> +         * Now raise the debug interrupt so that it will
> +         * trigger after the current instruction.
> +         */
> +        qemu_mutex_lock_iothread();
>          cpu_interrupt(cpu, CPU_INTERRUPT_DEBUG);
> +        qemu_mutex_unlock_iothread();
>          return;
>      }
>  
> @@ -2858,88 +2845,6 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
>      }
>  }
>  
> -static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
> -{
> -    CPUState *cpu = current_cpu;
> -    vaddr addr = (cpu->mem_io_vaddr & TARGET_PAGE_MASK) + offset;
> -
> -    cpu_check_watchpoint(cpu, addr, len, attrs, flags, 0);
> -}
> -
> -/* Watchpoint access routines.  Watchpoints are inserted using TLB tricks,
> -   so these check for a hit then pass through to the normal out-of-line
> -   phys routines.  */
> -static MemTxResult watch_mem_read(void *opaque, hwaddr addr, uint64_t *pdata,
> -                                  unsigned size, MemTxAttrs attrs)
> -{
> -    MemTxResult res;
> -    uint64_t data;
> -    int asidx = cpu_asidx_from_attrs(current_cpu, attrs);
> -    AddressSpace *as = current_cpu->cpu_ases[asidx].as;
> -
> -    check_watchpoint(addr & ~TARGET_PAGE_MASK, size, attrs, BP_MEM_READ);
> -    switch (size) {
> -    case 1:
> -        data = address_space_ldub(as, addr, attrs, &res);
> -        break;
> -    case 2:
> -        data = address_space_lduw(as, addr, attrs, &res);
> -        break;
> -    case 4:
> -        data = address_space_ldl(as, addr, attrs, &res);
> -        break;
> -    case 8:
> -        data = address_space_ldq(as, addr, attrs, &res);
> -        break;
> -    default: abort();
> -    }
> -    *pdata = data;
> -    return res;
> -}
> -
> -static MemTxResult watch_mem_write(void *opaque, hwaddr addr,
> -                                   uint64_t val, unsigned size,
> -                                   MemTxAttrs attrs)
> -{
> -    MemTxResult res;
> -    int asidx = cpu_asidx_from_attrs(current_cpu, attrs);
> -    AddressSpace *as = current_cpu->cpu_ases[asidx].as;
> -
> -    check_watchpoint(addr & ~TARGET_PAGE_MASK, size, attrs, BP_MEM_WRITE);
> -    switch (size) {
> -    case 1:
> -        address_space_stb(as, addr, val, attrs, &res);
> -        break;
> -    case 2:
> -        address_space_stw(as, addr, val, attrs, &res);
> -        break;
> -    case 4:
> -        address_space_stl(as, addr, val, attrs, &res);
> -        break;
> -    case 8:
> -        address_space_stq(as, addr, val, attrs, &res);
> -        break;
> -    default: abort();
> -    }
> -    return res;
> -}
> -
> -static const MemoryRegionOps watch_mem_ops = {
> -    .read_with_attrs = watch_mem_read,
> -    .write_with_attrs = watch_mem_write,
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
>  static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
>                                   MemTxAttrs attrs, uint8_t *buf, hwaddr len);
>  static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
> @@ -3115,9 +3020,6 @@ static void io_mem_init(void)
>      memory_region_init_io(&io_mem_notdirty, NULL, &notdirty_mem_ops, NULL,
>                            NULL, UINT64_MAX);
>      memory_region_clear_global_locking(&io_mem_notdirty);
> -
> -    memory_region_init_io(&io_mem_watch, NULL, &watch_mem_ops, NULL,
> -                          NULL, UINT64_MAX);
>  }
>  
>  AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv)
> @@ -3131,8 +3033,6 @@ AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv)
>      assert(n == PHYS_SECTION_NOTDIRTY);
>      n = dummy_section(&d->map, fv, &io_mem_rom);
>      assert(n == PHYS_SECTION_ROM);
> -    n = dummy_section(&d->map, fv, &io_mem_watch);
> -    assert(n == PHYS_SECTION_WATCH);
>  
>      d->phys_map  = (PhysPageEntry) { .ptr = PHYS_MAP_NODE_NIL, .skip = 1 };
>  
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

