Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8F2C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 995CF208C2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995CF208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCKIK-0003Xs-J5
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 05:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iCJsu-0007nn-Ig
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:39:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iCJss-0004qL-Hj
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:39:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37306)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iCJss-0004qF-8b
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:39:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8F8B010CC1E1;
 Mon, 23 Sep 2019 08:39:49 +0000 (UTC)
Received: from [10.36.116.207] (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C706608C0;
 Mon, 23 Sep 2019 08:39:45 +0000 (UTC)
Subject: Re: [PATCH v3 12/20] cputlb: Move ROM handling from I/O path to TLB
 path
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190922035458.14879-1-richard.henderson@linaro.org>
 <20190922035458.14879-13-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <ef7b34cd-32ba-28b5-329a-3edd914a7fb4@redhat.com>
Date: Mon, 23 Sep 2019 10:39:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190922035458.14879-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Mon, 23 Sep 2019 08:39:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
> It does not require going through the whole I/O path
> in order to discard a write.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu-all.h    |  5 ++++-
>  include/exec/cpu-common.h |  1 -
>  accel/tcg/cputlb.c        | 35 +++++++++++++++++++--------------
>  exec.c                    | 41 +--------------------------------------
>  4 files changed, 25 insertions(+), 57 deletions(-)
>=20
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 1ebd1b59ab..9f0b17802e 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -348,12 +348,15 @@ CPUArchState *cpu_copy(CPUArchState *env);
>  #define TLB_WATCHPOINT      (1 << (TARGET_PAGE_BITS_MIN - 4))
>  /* Set if TLB entry requires byte swap.  */
>  #define TLB_BSWAP           (1 << (TARGET_PAGE_BITS_MIN - 5))
> +/* Set if TLB entry writes ignored.  */
> +#define TLB_ROM             (1 << (TARGET_PAGE_BITS_MIN - 6))

I was wondering if TLB_DISCARD_WRITE/TLB_IGNORE_WRITE/TLB_READONLY would
make it clearer what's actually happening here.

E.g., it isn't used for memory_region_is_romd(section->mr) but only for
memory_region_is_ram(section->mr) && section->readonly.

But anyhow, changes look fine to me

Reviewed-by: David Hildenbrand <david@redhat.com>

> =20
>  /* Use this mask to check interception with an alignment mask
>   * in a TCG backend.
>   */
>  #define TLB_FLAGS_MASK \
> -    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO | TLB_WATCHPOINT | TLB=
_BSWAP)
> +    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO \
> +    | TLB_WATCHPOINT | TLB_BSWAP | TLB_ROM)
> =20
>  /**
>   * tlb_hit_page: return true if page aligned @addr is a hit against th=
e
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index f7dbe75fbc..1c0e03ddc2 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -100,7 +100,6 @@ void qemu_flush_coalesced_mmio_buffer(void);
> =20
>  void cpu_flush_icache_range(hwaddr start, hwaddr len);
> =20
> -extern struct MemoryRegion io_mem_rom;
>  extern struct MemoryRegion io_mem_notdirty;
> =20
>  typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index cb603917a2..7ab523d7ec 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -577,7 +577,7 @@ static void tlb_reset_dirty_range_locked(CPUTLBEntr=
y *tlb_entry,
>  {
>      uintptr_t addr =3D tlb_entry->addr_write;
> =20
> -    if ((addr & (TLB_INVALID_MASK | TLB_MMIO | TLB_NOTDIRTY)) =3D=3D 0=
) {
> +    if ((addr & (TLB_INVALID_MASK | TLB_MMIO | TLB_ROM | TLB_NOTDIRTY)=
) =3D=3D 0) {
>          addr &=3D TARGET_PAGE_MASK;
>          addr +=3D tlb_entry->addend;
>          if ((addr - start) < length) {
> @@ -745,7 +745,6 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_=
ulong vaddr,
>          address |=3D TLB_MMIO;
>          addend =3D 0;
>      } else {
> -        /* TLB_MMIO for rom/romd handled below */
>          addend =3D (uintptr_t)memory_region_get_ram_ptr(section->mr) +=
 xlat;
>      }
> =20
> @@ -822,16 +821,17 @@ void tlb_set_page_with_attrs(CPUState *cpu, targe=
t_ulong vaddr,
> =20
>      tn.addr_write =3D -1;
>      if (prot & PAGE_WRITE) {
> -        if ((memory_region_is_ram(section->mr) && section->readonly)
> -            || memory_region_is_romd(section->mr)) {
> -            /* Write access calls the I/O callback.  */
> -            tn.addr_write =3D address | TLB_MMIO;
> -        } else if (memory_region_is_ram(section->mr)
> -                   && cpu_physical_memory_is_clean(
> -                       memory_region_get_ram_addr(section->mr) + xlat)=
) {
> -            tn.addr_write =3D address | TLB_NOTDIRTY;
> -        } else {
> -            tn.addr_write =3D address;
> +        tn.addr_write =3D address;
> +        if (memory_region_is_romd(section->mr)) {
> +            /* Use the MMIO path so that the device can switch states.=
 */
> +            tn.addr_write |=3D TLB_MMIO;
> +        } else if (memory_region_is_ram(section->mr)) {
> +            if (section->readonly) {
> +                tn.addr_write |=3D TLB_ROM;
> +            } else if (cpu_physical_memory_is_clean(
> +                        memory_region_get_ram_addr(section->mr) + xlat=
)) {
> +                tn.addr_write |=3D TLB_NOTDIRTY;
> +            }
>          }
>          if (prot & PAGE_WRITE_INV) {
>              tn.addr_write |=3D TLB_INVALID_MASK;
> @@ -904,7 +904,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTL=
BEntry *iotlbentry,
>      mr =3D section->mr;
>      mr_offset =3D (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
>      cpu->mem_io_pc =3D retaddr;
> -    if (mr !=3D &io_mem_rom && mr !=3D &io_mem_notdirty && !cpu->can_d=
o_io) {
> +    if (mr !=3D &io_mem_notdirty && !cpu->can_do_io) {
>          cpu_io_recompile(cpu, retaddr);
>      }
> =20
> @@ -945,7 +945,7 @@ static void io_writex(CPUArchState *env, CPUIOTLBEn=
try *iotlbentry,
>      section =3D iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->at=
trs);
>      mr =3D section->mr;
>      mr_offset =3D (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
> -    if (mr !=3D &io_mem_rom && mr !=3D &io_mem_notdirty && !cpu->can_d=
o_io) {
> +    if (mr !=3D &io_mem_notdirty && !cpu->can_do_io) {
>          cpu_io_recompile(cpu, retaddr);
>      }
>      cpu->mem_io_vaddr =3D addr;
> @@ -1125,7 +1125,7 @@ void *probe_access(CPUArchState *env, target_ulon=
g addr, int size,
>      }
> =20
>      /* Reject I/O access, or other required slow-path.  */
> -    if (tlb_addr & (TLB_NOTDIRTY | TLB_MMIO | TLB_BSWAP)) {
> +    if (tlb_addr & (TLB_NOTDIRTY | TLB_MMIO | TLB_BSWAP | TLB_ROM)) {
>          return NULL;
>      }
> =20
> @@ -1612,6 +1612,11 @@ store_helper(CPUArchState *env, target_ulong add=
r, uint64_t val,
>              return;
>          }
> =20
> +        /* Ignore writes to ROM.  */
> +        if (unlikely(tlb_addr & TLB_ROM)) {
> +            return;
> +        }
> +
>          haddr =3D (void *)((uintptr_t)addr + entry->addend);
> =20
>          if (unlikely(tlb_addr & TLB_BSWAP)) {
> diff --git a/exec.c b/exec.c
> index 7ce0515635..e21e068535 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -88,7 +88,7 @@ static MemoryRegion *system_io;
>  AddressSpace address_space_io;
>  AddressSpace address_space_memory;
> =20
> -MemoryRegion io_mem_rom, io_mem_notdirty;
> +MemoryRegion io_mem_notdirty;
>  static MemoryRegion io_mem_unassigned;
>  #endif
> =20
> @@ -158,7 +158,6 @@ typedef struct subpage_t {
> =20
>  #define PHYS_SECTION_UNASSIGNED 0
>  #define PHYS_SECTION_NOTDIRTY 1
> -#define PHYS_SECTION_ROM 2
> =20
>  static void io_mem_init(void);
>  static void memory_map_init(void);
> @@ -1441,8 +1440,6 @@ hwaddr memory_region_section_get_iotlb(CPUState *=
cpu,
>          iotlb =3D memory_region_get_ram_addr(section->mr) + xlat;
>          if (!section->readonly) {
>              iotlb |=3D PHYS_SECTION_NOTDIRTY;
> -        } else {
> -            iotlb |=3D PHYS_SECTION_ROM;
>          }
>      } else {
>          AddressSpaceDispatch *d;
> @@ -2968,38 +2965,6 @@ static uint16_t dummy_section(PhysPageMap *map, =
FlatView *fv, MemoryRegion *mr)
>      return phys_section_add(map, &section);
>  }
> =20
> -static void readonly_mem_write(void *opaque, hwaddr addr,
> -                               uint64_t val, unsigned size)
> -{
> -    /* Ignore any write to ROM. */
> -}
> -
> -static bool readonly_mem_accepts(void *opaque, hwaddr addr,
> -                                 unsigned size, bool is_write,
> -                                 MemTxAttrs attrs)
> -{
> -    return is_write;
> -}
> -
> -/* This will only be used for writes, because reads are special cased
> - * to directly access the underlying host ram.
> - */
> -static const MemoryRegionOps readonly_mem_ops =3D {
> -    .write =3D readonly_mem_write,
> -    .valid.accepts =3D readonly_mem_accepts,
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
>  MemoryRegionSection *iotlb_to_section(CPUState *cpu,
>                                        hwaddr index, MemTxAttrs attrs)
>  {
> @@ -3013,8 +2978,6 @@ MemoryRegionSection *iotlb_to_section(CPUState *c=
pu,
> =20
>  static void io_mem_init(void)
>  {
> -    memory_region_init_io(&io_mem_rom, NULL, &readonly_mem_ops,
> -                          NULL, NULL, UINT64_MAX);
>      memory_region_init_io(&io_mem_unassigned, NULL, &unassigned_mem_op=
s, NULL,
>                            NULL, UINT64_MAX);
> =20
> @@ -3035,8 +2998,6 @@ AddressSpaceDispatch *address_space_dispatch_new(=
FlatView *fv)
>      assert(n =3D=3D PHYS_SECTION_UNASSIGNED);
>      n =3D dummy_section(&d->map, fv, &io_mem_notdirty);
>      assert(n =3D=3D PHYS_SECTION_NOTDIRTY);
> -    n =3D dummy_section(&d->map, fv, &io_mem_rom);
> -    assert(n =3D=3D PHYS_SECTION_ROM);
> =20
>      d->phys_map  =3D (PhysPageEntry) { .ptr =3D PHYS_MAP_NODE_NIL, .sk=
ip =3D 1 };
> =20
>=20


--=20

Thanks,

David / dhildenb

