Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E570C54E4B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:46:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36EB120746
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cQtUDu/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EB120746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXxWP-0003bG-Cy
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 21:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jXxUu-0000wl-EJ; Sun, 10 May 2020 21:44:48 -0400
Received: from ozlabs.org ([203.11.71.1]:33685)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jXxUr-0000en-MH; Sun, 10 May 2020 21:44:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49L3dh1hC2z9sT4; Mon, 11 May 2020 11:44:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1589161480;
 bh=rNRKRkqr64A3lrJbutaFfIrbgAI/5OJZ0kLFzbu0684=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cQtUDu/kXka90VoLZu2wQ3P0OvO4PhZGYZkON/NyCcWIZHMKCN452g5cKYMsRAZqP
 9P2uThCMHbVZDm8C8F1Ibdbq6pr1l5glQzbkGsf7hEspVTJNuN9id/Shs4GWG07HLp
 FkqncZEx5wZNP576vEV8TSOqMJWxkGD00Q8XRekg=
Date: Mon, 11 May 2020 11:35:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 10/10] exec: Move cpu_physical_memory_* functions to
 'exec/memory-internal.h'
Message-ID: <20200511013522.GL2183@umbus.fritz.box>
References: <20200507173958.25894-1-philmd@redhat.com>
 <20200507173958.25894-11-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GeDkoc8jIzHasOdk"
Content-Disposition: inline
In-Reply-To: <20200507173958.25894-11-philmd@redhat.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/10 21:17:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--GeDkoc8jIzHasOdk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2020 at 07:39:58PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

ppc parts
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/exec/memory-internal.h | 305 ++++++++++++++++++++++++++++++++-
>  include/exec/ram_addr.h        | 303 +-------------------------------
>  accel/tcg/cputlb.c             |   1 -
>  hw/ppc/spapr.c                 |   1 -
>  hw/ppc/spapr_pci.c             |   1 -
>  memory.c                       |   1 -
>  6 files changed, 305 insertions(+), 307 deletions(-)
>=20
> diff --git a/include/exec/memory-internal.h b/include/exec/memory-interna=
l.h
> index b2b7c1e78a..4abb3bbd85 100644
> --- a/include/exec/memory-internal.h
> +++ b/include/exec/memory-internal.h
> @@ -21,8 +21,13 @@
>  #define MEMORY_INTERNAL_H
> =20
>  #include "cpu.h"
> +#include "sysemu/tcg.h"
> +#include "sysemu/xen.h"
> +#include "exec/ramlist.h"
> +#include "exec/ramblock.h"
> =20
>  #ifdef CONFIG_SOFTMMU
> +
>  static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
>  {
>      return fv->dispatch;
> @@ -49,5 +54,303 @@ void address_space_dispatch_free(AddressSpaceDispatch=
 *d);
> =20
>  void mtree_print_dispatch(struct AddressSpaceDispatch *d,
>                            MemoryRegion *root);
> -#endif
> +
> +#define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
> +#define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_C=
ODE))
> +
> +static inline bool cpu_physical_memory_get_dirty(ram_addr_t start,
> +                                                 ram_addr_t length,
> +                                                 unsigned client)
> +{
> +    DirtyMemoryBlocks *blocks;
> +    unsigned long end, page;
> +    unsigned long idx, offset, base;
> +    bool dirty =3D false;
> +
> +    assert(client < DIRTY_MEMORY_NUM);
> +
> +    end =3D TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
> +    page =3D start >> TARGET_PAGE_BITS;
> +
> +    WITH_RCU_READ_LOCK_GUARD() {
> +        blocks =3D atomic_rcu_read(&ram_list.dirty_memory[client]);
> +
> +        idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
> +        offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
> +        base =3D page - offset;
> +        while (page < end) {
> +            unsigned long next =3D MIN(end, base + DIRTY_MEMORY_BLOCK_SI=
ZE);
> +            unsigned long num =3D next - base;
> +            unsigned long found =3D find_next_bit(blocks->blocks[idx],
> +                                                num, offset);
> +            if (found < num) {
> +                dirty =3D true;
> +                break;
> +            }
> +
> +            page =3D next;
> +            idx++;
> +            offset =3D 0;
> +            base +=3D DIRTY_MEMORY_BLOCK_SIZE;
> +        }
> +    }
> +
> +    return dirty;
> +}
> +
> +static inline bool cpu_physical_memory_all_dirty(ram_addr_t start,
> +                                                 ram_addr_t length,
> +                                                 unsigned client)
> +{
> +    DirtyMemoryBlocks *blocks;
> +    unsigned long end, page;
> +    unsigned long idx, offset, base;
> +    bool dirty =3D true;
> +
> +    assert(client < DIRTY_MEMORY_NUM);
> +
> +    end =3D TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
> +    page =3D start >> TARGET_PAGE_BITS;
> +
> +    RCU_READ_LOCK_GUARD();
> +
> +    blocks =3D atomic_rcu_read(&ram_list.dirty_memory[client]);
> +
> +    idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
> +    offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
> +    base =3D page - offset;
> +    while (page < end) {
> +        unsigned long next =3D MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE);
> +        unsigned long num =3D next - base;
> +        unsigned long found =3D find_next_zero_bit(blocks->blocks[idx],
> +                                                 num, offset);
> +        if (found < num) {
> +            dirty =3D false;
> +            break;
> +        }
> +
> +        page =3D next;
> +        idx++;
> +        offset =3D 0;
> +        base +=3D DIRTY_MEMORY_BLOCK_SIZE;
> +    }
> +
> +    return dirty;
> +}
> +
> +static inline bool cpu_physical_memory_get_dirty_flag(ram_addr_t addr,
> +                                                      unsigned client)
> +{
> +    return cpu_physical_memory_get_dirty(addr, 1, client);
> +}
> +
> +static inline bool cpu_physical_memory_is_clean(ram_addr_t addr)
> +{
> +    bool vga =3D cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_V=
GA);
> +    bool code =3D cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_=
CODE);
> +    bool migration =3D cpu_physical_memory_get_dirty_flag(addr,
> +                                                        DIRTY_MEMORY_MIG=
RATION);
> +    return !(vga && code && migration);
> +}
> +
> +static inline uint8_t cpu_physical_memory_range_includes_clean(ram_addr_=
t start,
> +                                                            ram_addr_t l=
ength,
> +                                                            uint8_t mask)
> +{
> +    uint8_t ret =3D 0;
> +
> +    if (mask & (1 << DIRTY_MEMORY_VGA) &&
> +        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_VGA))=
 {
> +        ret |=3D (1 << DIRTY_MEMORY_VGA);
> +    }
> +    if (mask & (1 << DIRTY_MEMORY_CODE) &&
> +        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_CODE)=
) {
> +        ret |=3D (1 << DIRTY_MEMORY_CODE);
> +    }
> +    if (mask & (1 << DIRTY_MEMORY_MIGRATION) &&
> +        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_MIGRA=
TION)) {
> +        ret |=3D (1 << DIRTY_MEMORY_MIGRATION);
> +    }
> +    return ret;
> +}
> +
> +static inline void cpu_physical_memory_set_dirty_flag(ram_addr_t addr,
> +                                                      unsigned client)
> +{
> +    unsigned long page, idx, offset;
> +    DirtyMemoryBlocks *blocks;
> +
> +    assert(client < DIRTY_MEMORY_NUM);
> +
> +    page =3D addr >> TARGET_PAGE_BITS;
> +    idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
> +    offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
> +
> +    RCU_READ_LOCK_GUARD();
> +
> +    blocks =3D atomic_rcu_read(&ram_list.dirty_memory[client]);
> +
> +    set_bit_atomic(offset, blocks->blocks[idx]);
> +}
> +
> +static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
> +                                                       ram_addr_t length,
> +                                                       uint8_t mask)
> +{
> +    DirtyMemoryBlocks *blocks[DIRTY_MEMORY_NUM];
> +    unsigned long end, page;
> +    unsigned long idx, offset, base;
> +    int i;
> +
> +    if (!mask && !xen_enabled()) {
> +        return;
> +    }
> +
> +    end =3D TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
> +    page =3D start >> TARGET_PAGE_BITS;
> +
> +    WITH_RCU_READ_LOCK_GUARD() {
> +        for (i =3D 0; i < DIRTY_MEMORY_NUM; i++) {
> +            blocks[i] =3D atomic_rcu_read(&ram_list.dirty_memory[i]);
> +        }
> +
> +        idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
> +        offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
> +        base =3D page - offset;
> +        while (page < end) {
> +            unsigned long next =3D MIN(end, base + DIRTY_MEMORY_BLOCK_SI=
ZE);
> +
> +            if (likely(mask & (1 << DIRTY_MEMORY_MIGRATION))) {
> +                bitmap_set_atomic(blocks[DIRTY_MEMORY_MIGRATION]->blocks=
[idx],
> +                                  offset, next - page);
> +            }
> +            if (unlikely(mask & (1 << DIRTY_MEMORY_VGA))) {
> +                bitmap_set_atomic(blocks[DIRTY_MEMORY_VGA]->blocks[idx],
> +                                  offset, next - page);
> +            }
> +            if (unlikely(mask & (1 << DIRTY_MEMORY_CODE))) {
> +                bitmap_set_atomic(blocks[DIRTY_MEMORY_CODE]->blocks[idx],
> +                                  offset, next - page);
> +            }
> +
> +            page =3D next;
> +            idx++;
> +            offset =3D 0;
> +            base +=3D DIRTY_MEMORY_BLOCK_SIZE;
> +        }
> +    }
> +
> +    xen_hvm_modified_memory(start, length);
> +}
> +
> +#if !defined(_WIN32)
> +static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long =
*bitmap,
> +                                                          ram_addr_t sta=
rt,
> +                                                          ram_addr_t pag=
es)
> +{
> +    unsigned long i, j;
> +    unsigned long page_number, c;
> +    hwaddr addr;
> +    ram_addr_t ram_addr;
> +    unsigned long len =3D (pages + HOST_LONG_BITS - 1) / HOST_LONG_BITS;
> +    unsigned long hpratio =3D qemu_real_host_page_size / TARGET_PAGE_SIZ=
E;
> +    unsigned long page =3D BIT_WORD(start >> TARGET_PAGE_BITS);
> +
> +    /* start address is aligned at the start of a word? */
> +    if ((((page * BITS_PER_LONG) << TARGET_PAGE_BITS) =3D=3D start) &&
> +        (hpratio =3D=3D 1)) {
> +        unsigned long **blocks[DIRTY_MEMORY_NUM];
> +        unsigned long idx;
> +        unsigned long offset;
> +        long k;
> +        long nr =3D BITS_TO_LONGS(pages);
> +
> +        idx =3D (start >> TARGET_PAGE_BITS) / DIRTY_MEMORY_BLOCK_SIZE;
> +        offset =3D BIT_WORD((start >> TARGET_PAGE_BITS) %
> +                          DIRTY_MEMORY_BLOCK_SIZE);
> +
> +        WITH_RCU_READ_LOCK_GUARD() {
> +            for (i =3D 0; i < DIRTY_MEMORY_NUM; i++) {
> +                blocks[i] =3D atomic_rcu_read(&ram_list.dirty_memory[i])=
->blocks;
> +            }
> +
> +            for (k =3D 0; k < nr; k++) {
> +                if (bitmap[k]) {
> +                    unsigned long temp =3D leul_to_cpu(bitmap[k]);
> +
> +                    atomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], te=
mp);
> +
> +                    if (global_dirty_log) {
> +                        atomic_or(&blocks[DIRTY_MEMORY_MIGRATION][idx][o=
ffset],
> +                                  temp);
> +                    }
> +
> +                    if (tcg_enabled()) {
> +                        atomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset=
],
> +                                  temp);
> +                    }
> +                }
> +
> +                if (++offset >=3D BITS_TO_LONGS(DIRTY_MEMORY_BLOCK_SIZE)=
) {
> +                    offset =3D 0;
> +                    idx++;
> +                }
> +            }
> +        }
> +
> +        xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
> +    } else {
> +        uint8_t clients =3D tcg_enabled() ? DIRTY_CLIENTS_ALL
> +                                        : DIRTY_CLIENTS_NOCODE;
> +
> +        if (!global_dirty_log) {
> +            clients &=3D ~(1 << DIRTY_MEMORY_MIGRATION);
> +        }
> +
> +        /*
> +         * bitmap-traveling is faster than memory-traveling (for addr...)
> +         * especially when most of the memory is not dirty.
> +         */
> +        for (i =3D 0; i < len; i++) {
> +            if (bitmap[i] !=3D 0) {
> +                c =3D leul_to_cpu(bitmap[i]);
> +                do {
> +                    j =3D ctzl(c);
> +                    c &=3D ~(1ul << j);
> +                    page_number =3D (i * HOST_LONG_BITS + j) * hpratio;
> +                    addr =3D page_number * TARGET_PAGE_SIZE;
> +                    ram_addr =3D start + addr;
> +                    cpu_physical_memory_set_dirty_range(ram_addr,
> +                                       TARGET_PAGE_SIZE * hpratio, clien=
ts);
> +                } while (c !=3D 0);
> +            }
> +        }
> +    }
> +}
> +#endif /* not _WIN32 */
> +
> +bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
> +                                              ram_addr_t length,
> +                                              unsigned client);
> +
> +DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty(
> +                                                            MemoryRegion=
 *mr,
> +                                                            hwaddr offse=
t,
> +                                                            hwaddr lengt=
h,
> +                                                            unsigned cli=
ent);
> +
> +bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
> +                                            ram_addr_t start,
> +                                            ram_addr_t length);
> +
> +static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t star=
t,
> +                                                         ram_addr_t leng=
th)
> +{
> +    cpu_physical_memory_test_and_clear_dirty(start, length,
> +                                             DIRTY_MEMORY_MIGRATION);
> +    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY=
_VGA);
> +    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY=
_CODE);
> +}
> +
> +#endif /* CONFIG_SOFTMMU */
>  #endif
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 6acde47a0f..64bf28a332 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -21,310 +21,9 @@
> =20
>  #ifndef CONFIG_USER_ONLY
>  #include "cpu.h"
> -#include "sysemu/xen.h"
> -#include "sysemu/tcg.h"
>  #include "exec/ramlist.h"
>  #include "exec/ramblock.h"
> -
> -
> -
> -#define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
> -#define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_C=
ODE))
> -
> -static inline bool cpu_physical_memory_get_dirty(ram_addr_t start,
> -                                                 ram_addr_t length,
> -                                                 unsigned client)
> -{
> -    DirtyMemoryBlocks *blocks;
> -    unsigned long end, page;
> -    unsigned long idx, offset, base;
> -    bool dirty =3D false;
> -
> -    assert(client < DIRTY_MEMORY_NUM);
> -
> -    end =3D TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
> -    page =3D start >> TARGET_PAGE_BITS;
> -
> -    WITH_RCU_READ_LOCK_GUARD() {
> -        blocks =3D atomic_rcu_read(&ram_list.dirty_memory[client]);
> -
> -        idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
> -        offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
> -        base =3D page - offset;
> -        while (page < end) {
> -            unsigned long next =3D MIN(end, base + DIRTY_MEMORY_BLOCK_SI=
ZE);
> -            unsigned long num =3D next - base;
> -            unsigned long found =3D find_next_bit(blocks->blocks[idx],
> -                                                num, offset);
> -            if (found < num) {
> -                dirty =3D true;
> -                break;
> -            }
> -
> -            page =3D next;
> -            idx++;
> -            offset =3D 0;
> -            base +=3D DIRTY_MEMORY_BLOCK_SIZE;
> -        }
> -    }
> -
> -    return dirty;
> -}
> -
> -static inline bool cpu_physical_memory_all_dirty(ram_addr_t start,
> -                                                 ram_addr_t length,
> -                                                 unsigned client)
> -{
> -    DirtyMemoryBlocks *blocks;
> -    unsigned long end, page;
> -    unsigned long idx, offset, base;
> -    bool dirty =3D true;
> -
> -    assert(client < DIRTY_MEMORY_NUM);
> -
> -    end =3D TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
> -    page =3D start >> TARGET_PAGE_BITS;
> -
> -    RCU_READ_LOCK_GUARD();
> -
> -    blocks =3D atomic_rcu_read(&ram_list.dirty_memory[client]);
> -
> -    idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
> -    offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
> -    base =3D page - offset;
> -    while (page < end) {
> -        unsigned long next =3D MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE);
> -        unsigned long num =3D next - base;
> -        unsigned long found =3D find_next_zero_bit(blocks->blocks[idx],
> -                                                 num, offset);
> -        if (found < num) {
> -            dirty =3D false;
> -            break;
> -        }
> -
> -        page =3D next;
> -        idx++;
> -        offset =3D 0;
> -        base +=3D DIRTY_MEMORY_BLOCK_SIZE;
> -    }
> -
> -    return dirty;
> -}
> -
> -static inline bool cpu_physical_memory_get_dirty_flag(ram_addr_t addr,
> -                                                      unsigned client)
> -{
> -    return cpu_physical_memory_get_dirty(addr, 1, client);
> -}
> -
> -static inline bool cpu_physical_memory_is_clean(ram_addr_t addr)
> -{
> -    bool vga =3D cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_V=
GA);
> -    bool code =3D cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_=
CODE);
> -    bool migration =3D cpu_physical_memory_get_dirty_flag(addr,
> -                                                        DIRTY_MEMORY_MIG=
RATION);
> -    return !(vga && code && migration);
> -}
> -
> -static inline uint8_t cpu_physical_memory_range_includes_clean(ram_addr_=
t start,
> -                                                            ram_addr_t l=
ength,
> -                                                            uint8_t mask)
> -{
> -    uint8_t ret =3D 0;
> -
> -    if (mask & (1 << DIRTY_MEMORY_VGA) &&
> -        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_VGA))=
 {
> -        ret |=3D (1 << DIRTY_MEMORY_VGA);
> -    }
> -    if (mask & (1 << DIRTY_MEMORY_CODE) &&
> -        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_CODE)=
) {
> -        ret |=3D (1 << DIRTY_MEMORY_CODE);
> -    }
> -    if (mask & (1 << DIRTY_MEMORY_MIGRATION) &&
> -        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_MIGRA=
TION)) {
> -        ret |=3D (1 << DIRTY_MEMORY_MIGRATION);
> -    }
> -    return ret;
> -}
> -
> -static inline void cpu_physical_memory_set_dirty_flag(ram_addr_t addr,
> -                                                      unsigned client)
> -{
> -    unsigned long page, idx, offset;
> -    DirtyMemoryBlocks *blocks;
> -
> -    assert(client < DIRTY_MEMORY_NUM);
> -
> -    page =3D addr >> TARGET_PAGE_BITS;
> -    idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
> -    offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
> -
> -    RCU_READ_LOCK_GUARD();
> -
> -    blocks =3D atomic_rcu_read(&ram_list.dirty_memory[client]);
> -
> -    set_bit_atomic(offset, blocks->blocks[idx]);
> -}
> -
> -static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
> -                                                       ram_addr_t length,
> -                                                       uint8_t mask)
> -{
> -    DirtyMemoryBlocks *blocks[DIRTY_MEMORY_NUM];
> -    unsigned long end, page;
> -    unsigned long idx, offset, base;
> -    int i;
> -
> -    if (!mask && !xen_enabled()) {
> -        return;
> -    }
> -
> -    end =3D TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
> -    page =3D start >> TARGET_PAGE_BITS;
> -
> -    WITH_RCU_READ_LOCK_GUARD() {
> -        for (i =3D 0; i < DIRTY_MEMORY_NUM; i++) {
> -            blocks[i] =3D atomic_rcu_read(&ram_list.dirty_memory[i]);
> -        }
> -
> -        idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
> -        offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
> -        base =3D page - offset;
> -        while (page < end) {
> -            unsigned long next =3D MIN(end, base + DIRTY_MEMORY_BLOCK_SI=
ZE);
> -
> -            if (likely(mask & (1 << DIRTY_MEMORY_MIGRATION))) {
> -                bitmap_set_atomic(blocks[DIRTY_MEMORY_MIGRATION]->blocks=
[idx],
> -                                  offset, next - page);
> -            }
> -            if (unlikely(mask & (1 << DIRTY_MEMORY_VGA))) {
> -                bitmap_set_atomic(blocks[DIRTY_MEMORY_VGA]->blocks[idx],
> -                                  offset, next - page);
> -            }
> -            if (unlikely(mask & (1 << DIRTY_MEMORY_CODE))) {
> -                bitmap_set_atomic(blocks[DIRTY_MEMORY_CODE]->blocks[idx],
> -                                  offset, next - page);
> -            }
> -
> -            page =3D next;
> -            idx++;
> -            offset =3D 0;
> -            base +=3D DIRTY_MEMORY_BLOCK_SIZE;
> -        }
> -    }
> -
> -    xen_hvm_modified_memory(start, length);
> -}
> -
> -#if !defined(_WIN32)
> -static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long =
*bitmap,
> -                                                          ram_addr_t sta=
rt,
> -                                                          ram_addr_t pag=
es)
> -{
> -    unsigned long i, j;
> -    unsigned long page_number, c;
> -    hwaddr addr;
> -    ram_addr_t ram_addr;
> -    unsigned long len =3D (pages + HOST_LONG_BITS - 1) / HOST_LONG_BITS;
> -    unsigned long hpratio =3D qemu_real_host_page_size / TARGET_PAGE_SIZ=
E;
> -    unsigned long page =3D BIT_WORD(start >> TARGET_PAGE_BITS);
> -
> -    /* start address is aligned at the start of a word? */
> -    if ((((page * BITS_PER_LONG) << TARGET_PAGE_BITS) =3D=3D start) &&
> -        (hpratio =3D=3D 1)) {
> -        unsigned long **blocks[DIRTY_MEMORY_NUM];
> -        unsigned long idx;
> -        unsigned long offset;
> -        long k;
> -        long nr =3D BITS_TO_LONGS(pages);
> -
> -        idx =3D (start >> TARGET_PAGE_BITS) / DIRTY_MEMORY_BLOCK_SIZE;
> -        offset =3D BIT_WORD((start >> TARGET_PAGE_BITS) %
> -                          DIRTY_MEMORY_BLOCK_SIZE);
> -
> -        WITH_RCU_READ_LOCK_GUARD() {
> -            for (i =3D 0; i < DIRTY_MEMORY_NUM; i++) {
> -                blocks[i] =3D atomic_rcu_read(&ram_list.dirty_memory[i])=
->blocks;
> -            }
> -
> -            for (k =3D 0; k < nr; k++) {
> -                if (bitmap[k]) {
> -                    unsigned long temp =3D leul_to_cpu(bitmap[k]);
> -
> -                    atomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], te=
mp);
> -
> -                    if (global_dirty_log) {
> -                        atomic_or(&blocks[DIRTY_MEMORY_MIGRATION][idx][o=
ffset],
> -                                  temp);
> -                    }
> -
> -                    if (tcg_enabled()) {
> -                        atomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset=
],
> -                                  temp);
> -                    }
> -                }
> -
> -                if (++offset >=3D BITS_TO_LONGS(DIRTY_MEMORY_BLOCK_SIZE)=
) {
> -                    offset =3D 0;
> -                    idx++;
> -                }
> -            }
> -        }
> -
> -        xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
> -    } else {
> -        uint8_t clients =3D tcg_enabled()
> -                          ? DIRTY_CLIENTS_ALL : DIRTY_CLIENTS_NOCODE;
> -
> -        if (!global_dirty_log) {
> -            clients &=3D ~(1 << DIRTY_MEMORY_MIGRATION);
> -        }
> -
> -        /*
> -         * bitmap-traveling is faster than memory-traveling (for addr...)
> -         * especially when most of the memory is not dirty.
> -         */
> -        for (i =3D 0; i < len; i++) {
> -            if (bitmap[i] !=3D 0) {
> -                c =3D leul_to_cpu(bitmap[i]);
> -                do {
> -                    j =3D ctzl(c);
> -                    c &=3D ~(1ul << j);
> -                    page_number =3D (i * HOST_LONG_BITS + j) * hpratio;
> -                    addr =3D page_number * TARGET_PAGE_SIZE;
> -                    ram_addr =3D start + addr;
> -                    cpu_physical_memory_set_dirty_range(ram_addr,
> -                                       TARGET_PAGE_SIZE * hpratio, clien=
ts);
> -                } while (c !=3D 0);
> -            }
> -        }
> -    }
> -}
> -#endif /* not _WIN32 */
> -
> -bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
> -                                              ram_addr_t length,
> -                                              unsigned client);
> -
> -DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty(
> -                                                            MemoryRegion=
 *mr,
> -                                                            hwaddr offse=
t,
> -                                                            hwaddr lengt=
h,
> -                                                            unsigned cli=
ent);
> -
> -bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
> -                                            ram_addr_t start,
> -                                            ram_addr_t length);
> -
> -static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t star=
t,
> -                                                         ram_addr_t leng=
th)
> -{
> -    cpu_physical_memory_test_and_clear_dirty(start, length,
> -                                             DIRTY_MEMORY_MIGRATION);
> -    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY=
_VGA);
> -    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY=
_CODE);
> -}
> -
> +#include "exec/memory-internal.h"
> =20
>  /* Called with RCU critical section */
>  static inline
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index e3b5750c3b..922671f246 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -26,7 +26,6 @@
>  #include "exec/cpu_ldst.h"
>  #include "exec/cputlb.h"
>  #include "exec/memory-internal.h"
> -#include "exec/ram_addr.h"
>  #include "tcg/tcg.h"
>  #include "qemu/error-report.h"
>  #include "exec/log.h"
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c18eab0a23..d7c3bf3932 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -69,7 +69,6 @@
>  #include "hw/virtio/vhost-scsi-common.h"
> =20
>  #include "exec/address-spaces.h"
> -#include "exec/ram_addr.h"
>  #include "hw/usb.h"
>  #include "qemu/config-file.h"
>  #include "qemu/error-report.h"
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 61b84a392d..8d9aeba6e6 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -36,7 +36,6 @@
>  #include "hw/ppc/spapr.h"
>  #include "hw/pci-host/spapr.h"
>  #include "exec/address-spaces.h"
> -#include "exec/ram_addr.h"
>  #include <libfdt.h>
>  #include "trace.h"
>  #include "qemu/error-report.h"
> diff --git a/memory.c b/memory.c
> index e8e7bcd6c7..4e1d19c5fc 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -27,7 +27,6 @@
>  #include "trace-root.h"
> =20
>  #include "exec/memory-internal.h"
> -#include "exec/ram_addr.h"
>  #include "exec/ramblock.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/runstate.h"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GeDkoc8jIzHasOdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl64q9oACgkQbDjKyiDZ
s5JroQ//c6UBQ+a/Jk9FtTZQcbytG0Xw3jhi1uOlLdNlQOPk6fHHjpTz++Bh42HL
b1dKEw6vC1t3CS0nQhb7fJsNE/mPcE4L9Nc1iij8HcnbiZXTv0GGBzu+Ug2wx/1w
eD/JgsuoZvvRjQiJXuPo8ID763LuElDWgNiMu1JVKQktOEfoF9JQrVIerZo23Xmg
0KhxK+ZJgzfO8b/heI31pMupxVXhCCrbjhgJXQHC+6bXxcOfIBCQMXCbO8sqDVRF
OuZlS9YsYful12zk9M++7llx6DuAjr0Z1XbxBfKJ1wMXyCexBh4QU7UXxd4Gl/Gb
dIL+kkfqTZVuP2hHhLjTI7/1vs4Urs6sAUJS8ae6XrulMvSk6xCWnAltOSvJ4GmS
9Xx8WNHSr2Y6F6EbYNeWz87Wzx5o2AgZ659EppwcGiCoY8mFNPhNDSh0jmsqiblT
2sg+KcjT6k4m7NeJqI7J0f6dqMC/QSBGUGT6ddmbFXi1QGsdaqgMTVV3UyyrtZuM
OjPjNdF724ohnuu9WkVbmNPZbMBUhIUQBUrAUbD1AUD210lffHes51ANIdO8EEOq
aSOo+8WJtCvLzH9nvsW1uJe/azPKNN9dXPnQ/Fz5vlLtileYce+2G9vFXbBWWZdl
HJPQKkmzOANcGyuyT56NKaj2w7JWPAf64vt+C5WjlJ5fGsZQRZM=
=4FxC
-----END PGP SIGNATURE-----

--GeDkoc8jIzHasOdk--

