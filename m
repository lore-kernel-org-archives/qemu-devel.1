Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CC6C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:16:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A6532173E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6532173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3O1z-0003YA-DS
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 13:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3O13-0002yR-IN
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3O10-0003do-0F
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:15:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56092)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3O0x-0003bw-V3
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:15:17 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC99B8667D
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 17:15:13 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id f14so1419391wmh.7
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 10:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VBHxqTN4KqhNz8Z5dIATlUGypx9Twn4bpoTGB1dkEZ4=;
 b=O49aF8ZM/QEinqJI/kqcy32Ha80nDPjbyXwIWRMgfUa/9WiTB+VSueut8jKreSHaTZ
 UHy2rFt29hW0tm/MpRUAav2BylTm0cQyzY+BumkiJLbC2lqx5fE4nRjZ+SjNEzQnK2j+
 YTeRYFkGxkmm2o3HBUHB3hr7tn/IHksDFA5jRIYqwJCP+TFb229yh1fKm5Wg5Uuo9XSE
 PQ1GJa/knzvdEkAF4sNX3EhvljGoA+rmBbgq6odUI5tDGeIEJ2ZMa189zxgR0lk771aY
 y7qM54DY0ms63BvQCTb1qqzeJbmOZi5KrpWM7BLzfFVYZYArtlT99O1rnWOBmXlvsWjW
 vrBg==
X-Gm-Message-State: APjAAAU2kGRoPtKUxJtJTQwpb3S+Ff3e8dugVLSLYBWb2X7/ho17HxCC
 q67rzPJ9IpWZOu/0WKA+FWiNV5UMck6Z0bc9yYWj7iMELJ9ACZFm7YLxejt1Lu40gXLIJIVWb8r
 eiuI6kAxyqdJiFlo=
X-Received: by 2002:a1c:2d4:: with SMTP id 203mr12971428wmc.105.1567098912336; 
 Thu, 29 Aug 2019 10:15:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwbqnTCLNrryM8FsMsl5Yv8aG/C8u/+Gk5O9G7XG5qbCveH5nbV0LqRBEEk8OuvC7lKQ7bJYA==
X-Received: by 2002:a1c:2d4:: with SMTP id 203mr12971388wmc.105.1567098911978; 
 Thu, 29 Aug 2019 10:15:11 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id x10sm4519150wrn.39.2019.08.29.10.15.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 10:15:11 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190828231651.17176-1-richard.henderson@linaro.org>
 <20190828231651.17176-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <406aec5e-20e0-4aba-a889-b089128b9b93@redhat.com>
Date: Thu, 29 Aug 2019 19:15:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190828231651.17176-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/29/19 1:16 AM, Richard Henderson wrote:
> The raising of exceptions from check_watchpoint, buried inside
> of the I/O subsystem, is fundamentally broken.  We do not have
> the helper return address with which we can unwind guest state.
>=20
> Replace PHYS_SECTION_WATCH and io_mem_watch with TLB_WATCHPOINT.
> Move the call to cpu_check_watchpoint into the cputlb helpers
> where we do have the helper return address.
>=20
> This also allows us to handle watchpoints on RAM to bypass the
> full i/o access path.

Yay!

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu-all.h |   5 +-
>  accel/tcg/cputlb.c     |  89 ++++++++++++++++++++++++++++----
>  exec.c                 | 114 +++--------------------------------------
>  3 files changed, 90 insertions(+), 118 deletions(-)
>=20
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
> =20
>  /* Use this mask to check interception with an alignment mask
>   * in a TCG backend.
>   */
> -#define TLB_FLAGS_MASK  (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO)
> +#define TLB_FLAGS_MASK \
> +    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO | TLB_WATCHPOINT)
> =20
>  /**
>   * tlb_hit_page: return true if page aligned @addr is a hit against th=
e
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index d0f8db33a2..9a9a626938 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -710,6 +710,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_=
ulong vaddr,
>      hwaddr iotlb, xlat, sz, paddr_page;
>      target_ulong vaddr_page;
>      int asidx =3D cpu_asidx_from_attrs(cpu, attrs);
> +    int wp_flags;
> =20
>      assert_cpu_is_self(cpu);
> =20
> @@ -752,6 +753,8 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_=
ulong vaddr,
>      code_address =3D address;
>      iotlb =3D memory_region_section_get_iotlb(cpu, section, vaddr_page=
,
>                                              paddr_page, xlat, prot, &a=
ddress);
> +    wp_flags =3D cpu_watchpoint_address_matches(cpu, vaddr_page,
> +                                              TARGET_PAGE_SIZE);
> =20
>      index =3D tlb_index(env, mmu_idx, vaddr_page);
>      te =3D tlb_entry(env, mmu_idx, vaddr_page);
> @@ -805,6 +808,9 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_=
ulong vaddr,
>      tn.addend =3D addend - vaddr_page;
>      if (prot & PAGE_READ) {
>          tn.addr_read =3D address;
> +        if (wp_flags & BP_MEM_READ) {
> +            tn.addr_read |=3D TLB_WATCHPOINT;
> +        }
>      } else {
>          tn.addr_read =3D -1;
>      }
> @@ -831,6 +837,9 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_=
ulong vaddr,
>          if (prot & PAGE_WRITE_INV) {
>              tn.addr_write |=3D TLB_INVALID_MASK;
>          }
> +        if (wp_flags & BP_MEM_WRITE) {
> +            tn.addr_write |=3D TLB_WATCHPOINT;
> +        }
>      }
> =20
>      copy_tlb_helper_locked(te, &tn);
> @@ -1264,13 +1273,33 @@ load_helper(CPUArchState *env, target_ulong add=
r, TCGMemOpIdx oi,
>          tlb_addr &=3D ~TLB_INVALID_MASK;
>      }
> =20
> -    /* Handle an IO access.  */
> +    /* Handle anything that isn't just a straight memory access.  */
>      if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
> +        CPUIOTLBEntry *iotlbentry;
> +
> +        /* For anything that is unaligned, recurse through full_load. =
 */
>          if ((addr & (size - 1)) !=3D 0) {
>              goto do_unaligned_access;
>          }
> -        return io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
> -                        mmu_idx, addr, retaddr, access_type, op);
> +
> +        iotlbentry =3D &env_tlb(env)->d[mmu_idx].iotlb[index];
> +
> +        /* Handle watchpoints.  */
> +        if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
> +            /* On watchpoint hit, this will longjmp out.  */
> +            cpu_check_watchpoint(env_cpu(env), addr, size,
> +                                 iotlbentry->attrs, BP_MEM_READ, retad=
dr);
> +
> +            /* The backing page may or may not require I/O.  */
> +            tlb_addr &=3D ~TLB_WATCHPOINT;
> +            if ((tlb_addr & ~TARGET_PAGE_MASK) =3D=3D 0) {
> +                goto do_aligned_access;
> +            }
> +        }
> +
> +        /* Handle I/O access.  */
> +        return io_readx(env, iotlbentry, mmu_idx, addr,
> +                        retaddr, access_type, op);
>      }
> =20
>      /* Handle slow unaligned access (it spans two pages or IO).  */
> @@ -1297,6 +1326,7 @@ load_helper(CPUArchState *env, target_ulong addr,=
 TCGMemOpIdx oi,
>          return res & MAKE_64BIT_MASK(0, size * 8);
>      }
> =20
> + do_aligned_access:
>      haddr =3D (void *)((uintptr_t)addr + entry->addend);
>      switch (op) {
>      case MO_UB:
> @@ -1486,13 +1516,32 @@ store_helper(CPUArchState *env, target_ulong ad=
dr, uint64_t val,
>          tlb_addr =3D tlb_addr_write(entry) & ~TLB_INVALID_MASK;
>      }
> =20
> -    /* Handle an IO access.  */
> +    /* Handle anything that isn't just a straight memory access.  */
>      if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
> +        CPUIOTLBEntry *iotlbentry;
> +
> +        /* For anything that is unaligned, recurse through byte stores=
.  */
>          if ((addr & (size - 1)) !=3D 0) {
>              goto do_unaligned_access;
>          }
> -        io_writex(env, &env_tlb(env)->d[mmu_idx].iotlb[index], mmu_idx=
,
> -                  val, addr, retaddr, op);
> +
> +        iotlbentry =3D &env_tlb(env)->d[mmu_idx].iotlb[index];
> +
> +        /* Handle watchpoints.  */
> +        if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
> +            /* On watchpoint hit, this will longjmp out.  */
> +            cpu_check_watchpoint(env_cpu(env), addr, size,
> +                                 iotlbentry->attrs, BP_MEM_WRITE, reta=
ddr);
> +
> +            /* The backing page may or may not require I/O.  */
> +            tlb_addr &=3D ~TLB_WATCHPOINT;
> +            if ((tlb_addr & ~TARGET_PAGE_MASK) =3D=3D 0) {
> +                goto do_aligned_access;
> +            }
> +        }
> +
> +        /* Handle I/O access.  */
> +        io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr, op);
>          return;
>      }
> =20
> @@ -1517,10 +1566,29 @@ store_helper(CPUArchState *env, target_ulong ad=
dr, uint64_t val,
>          index2 =3D tlb_index(env, mmu_idx, page2);
>          entry2 =3D tlb_entry(env, mmu_idx, page2);
>          tlb_addr2 =3D tlb_addr_write(entry2);
> -        if (!tlb_hit_page(tlb_addr2, page2)
> -            && !victim_tlb_hit(env, mmu_idx, index2, tlb_off, page2)) =
{
> -            tlb_fill(env_cpu(env), page2, size2, MMU_DATA_STORE,
> -                     mmu_idx, retaddr);
> +        if (!tlb_hit_page(tlb_addr2, page2)) {
> +            if (!victim_tlb_hit(env, mmu_idx, index2, tlb_off, page2))=
 {
> +                tlb_fill(env_cpu(env), page2, size2, MMU_DATA_STORE,
> +                         mmu_idx, retaddr);
> +                index2 =3D tlb_index(env, mmu_idx, page2);
> +                entry2 =3D tlb_entry(env, mmu_idx, page2);
> +            }
> +            tlb_addr2 =3D tlb_addr_write(entry2);
> +        }
> +
> +        /*
> +         * Handle watchpoints.  Since this may trap, all checks
> +         * must happen before any store.
> +         */
> +        if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
> +            cpu_check_watchpoint(env_cpu(env), addr, size - size2,
> +                                 env_tlb(env)->d[mmu_idx].iotlb[index]=
.attrs,
> +                                 BP_MEM_WRITE, retaddr);
> +        }
> +        if (unlikely(tlb_addr2 & TLB_WATCHPOINT)) {
> +            cpu_check_watchpoint(env_cpu(env), page2, size2,
> +                                 env_tlb(env)->d[mmu_idx].iotlb[index2=
].attrs,
> +                                 BP_MEM_WRITE, retaddr);
>          }
> =20
>          /*
> @@ -1542,6 +1610,7 @@ store_helper(CPUArchState *env, target_ulong addr=
, uint64_t val,
>          return;
>      }
> =20
> + do_aligned_access:
>      haddr =3D (void *)((uintptr_t)addr + entry->addend);
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
> =20
>  static void io_mem_init(void);
>  static void memory_map_init(void);
>  static void tcg_log_global_after_sync(MemoryListener *listener);
>  static void tcg_commit(MemoryListener *listener);
> =20
> -static MemoryRegion io_mem_watch;
> -
>  /**
>   * CPUAddressSpace: all the information a CPU needs about an AddressSp=
ace
>   * @cpu: the CPU whose AddressSpace this is
> @@ -1472,7 +1469,6 @@ hwaddr memory_region_section_get_iotlb(CPUState *=
cpu,
>                                         target_ulong *address)
>  {
>      hwaddr iotlb;
> -    int flags, match;
> =20
>      if (memory_region_is_ram(section->mr)) {
>          /* Normal RAM.  */
> @@ -1490,19 +1486,6 @@ hwaddr memory_region_section_get_iotlb(CPUState =
*cpu,
>          iotlb +=3D xlat;
>      }
> =20
> -    /* Avoid trapping reads of pages with a write breakpoint. */
> -    match =3D (prot & PAGE_READ ? BP_MEM_READ : 0)
> -          | (prot & PAGE_WRITE ? BP_MEM_WRITE : 0);
> -    flags =3D cpu_watchpoint_address_matches(cpu, vaddr, TARGET_PAGE_S=
IZE);
> -    if (flags & match) {
> -        /*
> -         * Make accesses to pages with watchpoints go via the
> -         * watchpoint trap routines.
> -         */
> -        iotlb =3D PHYS_SECTION_WATCH + paddr;
> -        *address |=3D TLB_MMIO;
> -    }
> -
>      return iotlb;
>  }
>  #endif /* defined(CONFIG_USER_ONLY) */
> @@ -2810,10 +2793,14 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr =
addr, vaddr len,
> =20
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
> =20
> @@ -2858,88 +2845,6 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr a=
ddr, vaddr len,
>      }
>  }
> =20
> -static void check_watchpoint(int offset, int len, MemTxAttrs attrs, in=
t flags)
> -{
> -    CPUState *cpu =3D current_cpu;
> -    vaddr addr =3D (cpu->mem_io_vaddr & TARGET_PAGE_MASK) + offset;
> -
> -    cpu_check_watchpoint(cpu, addr, len, attrs, flags, 0);
> -}
> -
> -/* Watchpoint access routines.  Watchpoints are inserted using TLB tri=
cks,
> -   so these check for a hit then pass through to the normal out-of-lin=
e
> -   phys routines.  */
> -static MemTxResult watch_mem_read(void *opaque, hwaddr addr, uint64_t =
*pdata,
> -                                  unsigned size, MemTxAttrs attrs)
> -{
> -    MemTxResult res;
> -    uint64_t data;
> -    int asidx =3D cpu_asidx_from_attrs(current_cpu, attrs);
> -    AddressSpace *as =3D current_cpu->cpu_ases[asidx].as;
> -
> -    check_watchpoint(addr & ~TARGET_PAGE_MASK, size, attrs, BP_MEM_REA=
D);
> -    switch (size) {
> -    case 1:
> -        data =3D address_space_ldub(as, addr, attrs, &res);
> -        break;
> -    case 2:
> -        data =3D address_space_lduw(as, addr, attrs, &res);
> -        break;
> -    case 4:
> -        data =3D address_space_ldl(as, addr, attrs, &res);
> -        break;
> -    case 8:
> -        data =3D address_space_ldq(as, addr, attrs, &res);
> -        break;
> -    default: abort();
> -    }
> -    *pdata =3D data;
> -    return res;
> -}
> -
> -static MemTxResult watch_mem_write(void *opaque, hwaddr addr,
> -                                   uint64_t val, unsigned size,
> -                                   MemTxAttrs attrs)
> -{
> -    MemTxResult res;
> -    int asidx =3D cpu_asidx_from_attrs(current_cpu, attrs);
> -    AddressSpace *as =3D current_cpu->cpu_ases[asidx].as;
> -
> -    check_watchpoint(addr & ~TARGET_PAGE_MASK, size, attrs, BP_MEM_WRI=
TE);
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
> -static const MemoryRegionOps watch_mem_ops =3D {
> -    .read_with_attrs =3D watch_mem_read,
> -    .write_with_attrs =3D watch_mem_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> -    .valid =3D {
> -        .min_access_size =3D 1,
> -        .max_access_size =3D 8,
> -        .unaligned =3D false,
> -    },
> -    .impl =3D {
> -        .min_access_size =3D 1,
> -        .max_access_size =3D 8,
> -        .unaligned =3D false,
> -    },
> -};
> -
>  static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
>                                   MemTxAttrs attrs, uint8_t *buf, hwadd=
r len);
>  static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttr=
s attrs,
> @@ -3115,9 +3020,6 @@ static void io_mem_init(void)
>      memory_region_init_io(&io_mem_notdirty, NULL, &notdirty_mem_ops, N=
ULL,
>                            NULL, UINT64_MAX);
>      memory_region_clear_global_locking(&io_mem_notdirty);
> -
> -    memory_region_init_io(&io_mem_watch, NULL, &watch_mem_ops, NULL,
> -                          NULL, UINT64_MAX);
>  }
> =20
>  AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv)
> @@ -3131,8 +3033,6 @@ AddressSpaceDispatch *address_space_dispatch_new(=
FlatView *fv)
>      assert(n =3D=3D PHYS_SECTION_NOTDIRTY);
>      n =3D dummy_section(&d->map, fv, &io_mem_rom);
>      assert(n =3D=3D PHYS_SECTION_ROM);
> -    n =3D dummy_section(&d->map, fv, &io_mem_watch);
> -    assert(n =3D=3D PHYS_SECTION_WATCH);
> =20
>      d->phys_map  =3D (PhysPageEntry) { .ptr =3D PHYS_MAP_NODE_NIL, .sk=
ip =3D 1 };
> =20

