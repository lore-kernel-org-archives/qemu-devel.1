Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AA6C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A6B20673
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A6B20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCKhG-0005BE-3B
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 05:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCKgC-0004fp-Ny
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCKgA-00040m-KS
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:30:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15978)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCKgA-00040S-Cn
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:30:46 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5A87283F40
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 09:30:45 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id 190so6383617wme.4
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 02:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x9O1fzVypj7ExlA1ATKk31Lt+Jra68iYDQPTteFkl78=;
 b=L0QNkkxCbRADh2tZzbesX9S2E3zZXgu39q6Lq1BZF1LuZkOxxwiGeCteDeWVeuSicx
 ve29sakuChU4D4jAZzqfqxG9786pwbLV9rbIq0vYk8ByoVA0UTrsL6gPfPiKJlFcDnlg
 kT8pQOiK14m2fI/Lhex1gAp5lgW2SEmMRWKJOZhYYI+vYq93zgJRHyTp6pR0l4JPE5r/
 Mqfr5RN3tHKYOm9Lfjn9NnD2Cf7neqP24nh4a1Wb+Ch5tgbxA6XVQh30OQ17ItzISDLJ
 aAE9deDCjqoGTN0f5RsFAAMh+Qvb3vKAQKsT3bE6ucSsJxs8/5/GX+YGlxCRD35DEZ4w
 iM8A==
X-Gm-Message-State: APjAAAUxqfpr0uCrOL6R1ekPdWKFkCNSXSxDtx4nlzXNg7BSeI+KhVHF
 TRJhJvat3um3cPQzEz+L5LML34lz+3UYWLVn3LBw84Wy1fhS/wvrkzn/sxMJk8UxRBzOnyUvQy3
 9g2SQwu8HvnGkDy0=
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr13253057wmk.49.1569231043624; 
 Mon, 23 Sep 2019 02:30:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwW5xe465hTSpw7hnYmr/0bsbscJxhffXJLzvMKQ82NpZ9a85DztHOzX+NkJ5BLCD8brn9rNg==
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr13253040wmk.49.1569231043403; 
 Mon, 23 Sep 2019 02:30:43 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id e9sm29860298wme.3.2019.09.23.02.30.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 02:30:42 -0700 (PDT)
Subject: Re: [PATCH v3 13/20] cputlb: Move NOTDIRTY handling from I/O path to
 TLB path
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190922035458.14879-1-richard.henderson@linaro.org>
 <20190922035458.14879-14-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2b195459-e836-f3f5-fe2a-7ad2d8ca6e33@redhat.com>
Date: Mon, 23 Sep 2019 11:30:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190922035458.14879-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/19 5:54 AM, Richard Henderson wrote:
> Pages that we want to track for NOTDIRTY are RAM.  We do not
> really need to go through the I/O path to handle them.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu-common.h |  2 --
>  accel/tcg/cputlb.c        | 26 +++++++++++++++++---
>  exec.c                    | 50 ---------------------------------------
>  memory.c                  | 16 -------------
>  4 files changed, 23 insertions(+), 71 deletions(-)
>=20
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 1c0e03ddc2..81753bbb34 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -100,8 +100,6 @@ void qemu_flush_coalesced_mmio_buffer(void);
> =20
>  void cpu_flush_icache_range(hwaddr start, hwaddr len);
> =20
> -extern struct MemoryRegion io_mem_notdirty;
> -
>  typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
> =20
>  int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 7ab523d7ec..b7bd738115 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -904,7 +904,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTL=
BEntry *iotlbentry,
>      mr =3D section->mr;
>      mr_offset =3D (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
>      cpu->mem_io_pc =3D retaddr;
> -    if (mr !=3D &io_mem_notdirty && !cpu->can_do_io) {
> +    if (!cpu->can_do_io) {
>          cpu_io_recompile(cpu, retaddr);
>      }
> =20
> @@ -945,7 +945,7 @@ static void io_writex(CPUArchState *env, CPUIOTLBEn=
try *iotlbentry,
>      section =3D iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->at=
trs);
>      mr =3D section->mr;
>      mr_offset =3D (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
> -    if (mr !=3D &io_mem_notdirty && !cpu->can_do_io) {
> +    if (!cpu->can_do_io) {
>          cpu_io_recompile(cpu, retaddr);
>      }
>      cpu->mem_io_vaddr =3D addr;
> @@ -1606,7 +1606,7 @@ store_helper(CPUArchState *env, target_ulong addr=
, uint64_t val,
>          }
> =20
>          /* Handle I/O access.  */
> -        if (likely(tlb_addr & (TLB_MMIO | TLB_NOTDIRTY))) {
> +        if (tlb_addr & TLB_MMIO) {
>              io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr,
>                        op ^ (tlb_addr & TLB_BSWAP ? MO_BSWAP : 0));
>              return;
> @@ -1619,6 +1619,26 @@ store_helper(CPUArchState *env, target_ulong add=
r, uint64_t val,
> =20
>          haddr =3D (void *)((uintptr_t)addr + entry->addend);
> =20
> +        /* Handle clean RAM pages.  */
> +        if (tlb_addr & TLB_NOTDIRTY) {
> +            NotDirtyInfo ndi;
> +
> +            /* We require mem_io_pc in tb_invalidate_phys_page_range. =
 */
> +            env_cpu(env)->mem_io_pc =3D retaddr;
> +
> +            memory_notdirty_write_prepare(&ndi, env_cpu(env), addr,
> +                                          addr + iotlbentry->addr, siz=
e);
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
> =20
> -MemoryRegion io_mem_notdirty;
>  static MemoryRegion io_mem_unassigned;
>  #endif
> =20
> @@ -157,7 +156,6 @@ typedef struct subpage_t {
>  } subpage_t;
> =20
>  #define PHYS_SECTION_UNASSIGNED 0
> -#define PHYS_SECTION_NOTDIRTY 1
> =20
>  static void io_mem_init(void);
>  static void memory_map_init(void);
> @@ -1438,9 +1436,6 @@ hwaddr memory_region_section_get_iotlb(CPUState *=
cpu,
>      if (memory_region_is_ram(section->mr)) {
>          /* Normal RAM.  */
>          iotlb =3D memory_region_get_ram_addr(section->mr) + xlat;
> -        if (!section->readonly) {
> -            iotlb |=3D PHYS_SECTION_NOTDIRTY;
> -        }
>      } else {
>          AddressSpaceDispatch *d;
> =20
> @@ -2749,42 +2744,6 @@ void memory_notdirty_write_complete(NotDirtyInfo=
 *ndi)
>      }
>  }
> =20
> -/* Called within RCU critical section.  */
> -static void notdirty_mem_write(void *opaque, hwaddr ram_addr,
> -                               uint64_t val, unsigned size)
> -{
> -    NotDirtyInfo ndi;
> -
> -    memory_notdirty_write_prepare(&ndi, current_cpu, current_cpu->mem_=
io_vaddr,
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
> -static const MemoryRegionOps notdirty_mem_ops =3D {
> -    .write =3D notdirty_mem_write,
> -    .valid.accepts =3D notdirty_mem_accepts,
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
>  /* Generate a debug exception if a watchpoint has been hit.  */
>  void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
>                            MemTxAttrs attrs, int flags, uintptr_t ra)
> @@ -2980,13 +2939,6 @@ static void io_mem_init(void)
>  {
>      memory_region_init_io(&io_mem_unassigned, NULL, &unassigned_mem_op=
s, NULL,
>                            NULL, UINT64_MAX);
> -
> -    /* io_mem_notdirty calls tb_invalidate_phys_page_fast,
> -     * which can be called without the iothread mutex.
> -     */
> -    memory_region_init_io(&io_mem_notdirty, NULL, &notdirty_mem_ops, N=
ULL,
> -                          NULL, UINT64_MAX);
> -    memory_region_clear_global_locking(&io_mem_notdirty);
>  }
> =20
>  AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv)
> @@ -2996,8 +2948,6 @@ AddressSpaceDispatch *address_space_dispatch_new(=
FlatView *fv)
> =20
>      n =3D dummy_section(&d->map, fv, &io_mem_unassigned);
>      assert(n =3D=3D PHYS_SECTION_UNASSIGNED);
> -    n =3D dummy_section(&d->map, fv, &io_mem_notdirty);
> -    assert(n =3D=3D PHYS_SECTION_NOTDIRTY);
> =20
>      d->phys_map  =3D (PhysPageEntry) { .ptr =3D PHYS_MAP_NODE_NIL, .sk=
ip =3D 1 };
> =20
> diff --git a/memory.c b/memory.c
> index 57c44c97db..a99b8c0767 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -434,10 +434,6 @@ static MemTxResult  memory_region_read_accessor(Me=
moryRegion *mr,
>      tmp =3D mr->ops->read(mr->opaque, addr, size);
>      if (mr->subpage) {
>          trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tm=
p, size);
> -    } else if (mr =3D=3D &io_mem_notdirty) {
> -        /* Accesses to code which has previously been translated into =
a TB show
> -         * up in the MMIO path, as accesses to the io_mem_notdirty
> -         * MemoryRegion. */
>      } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
>          hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tm=
p, size);
> @@ -460,10 +456,6 @@ static MemTxResult memory_region_read_with_attrs_a=
ccessor(MemoryRegion *mr,
>      r =3D mr->ops->read_with_attrs(mr->opaque, addr, &tmp, size, attrs=
);
>      if (mr->subpage) {
>          trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tm=
p, size);
> -    } else if (mr =3D=3D &io_mem_notdirty) {
> -        /* Accesses to code which has previously been translated into =
a TB show
> -         * up in the MMIO path, as accesses to the io_mem_notdirty
> -         * MemoryRegion. */
>      } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
>          hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tm=
p, size);
> @@ -484,10 +476,6 @@ static MemTxResult memory_region_write_accessor(Me=
moryRegion *mr,
> =20
>      if (mr->subpage) {
>          trace_memory_region_subpage_write(get_cpu_index(), mr, addr, t=
mp, size);
> -    } else if (mr =3D=3D &io_mem_notdirty) {
> -        /* Accesses to code which has previously been translated into =
a TB show
> -         * up in the MMIO path, as accesses to the io_mem_notdirty
> -         * MemoryRegion. */
>      } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
>          hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, t=
mp, size);
> @@ -508,10 +496,6 @@ static MemTxResult memory_region_write_with_attrs_=
accessor(MemoryRegion *mr,
> =20
>      if (mr->subpage) {
>          trace_memory_region_subpage_write(get_cpu_index(), mr, addr, t=
mp, size);
> -    } else if (mr =3D=3D &io_mem_notdirty) {
> -        /* Accesses to code which has previously been translated into =
a TB show
> -         * up in the MMIO path, as accesses to the io_mem_notdirty
> -         * MemoryRegion. */
>      } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
>          hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, t=
mp, size);
>=20

Very nice!
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

