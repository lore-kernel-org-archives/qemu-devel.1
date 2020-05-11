Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D407C54E4B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:48:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083AE20746
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="c3XzV1SO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083AE20746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXxY7-0007Yi-8V
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 21:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jXxUt-0000wF-RD; Sun, 10 May 2020 21:44:47 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40849 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jXxUr-0000ep-La; Sun, 10 May 2020 21:44:47 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49L3dh0hVTz9sT3; Mon, 11 May 2020 11:44:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1589161480;
 bh=+Rn3CdA9n9JQew4PZJ8hYG1v3n0iNbURgN1AZwvZ8Es=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c3XzV1SOnMI8Flub2UM/B6MSZb6ONtDbWsML3CM0U1VdVVZ/lumuRdogrGMyk278F
 1P5oAOpHTBF6vESYOHwzIxfj1dIj6DrmwljtRAYsM74O4h1B/xRnBWnoid9/pDdYwv
 qvYp4PYzf+tBQX1cFaRu3s147XQgxwsrsC/K9cXk=
Date: Mon, 11 May 2020 11:33:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 07/10] exec: Move all RAMBlock functions to
 'exec/ramblock.h'
Message-ID: <20200511013359.GK2183@umbus.fritz.box>
References: <20200507173958.25894-1-philmd@redhat.com>
 <20200507173958.25894-8-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Z9t8O/5YJLB6LEUl"
Content-Disposition: inline
In-Reply-To: <20200507173958.25894-8-philmd@redhat.com>
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


--Z9t8O/5YJLB6LEUl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2020 at 07:39:55PM +0200, Philippe Mathieu-Daud=E9 wrote:
> The RAMBlock API was dispersed in 3 different headers.
> One of these headers, "exec/ram_addr.h", is restricted
> to target dependent code. However these functions are
> not target specific. Move all functions into a single
> place.  Now all these functions can be accessed by
> target-agnostic code.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

ppc parts
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/exec/cpu-common.h    |  24 -------
>  include/exec/ram_addr.h      | 105 ---------------------------
>  include/exec/ramblock.h      | 134 +++++++++++++++++++++++++++++++++++
>  migration/migration.h        |   1 +
>  accel/tcg/translate-all.c    |   2 -
>  hw/block/nvme.c              |   2 +-
>  hw/s390x/s390-stattrib-kvm.c |   1 -
>  hw/s390x/s390-stattrib.c     |   1 -
>  hw/s390x/s390-virtio-ccw.c   |   1 -
>  hw/virtio/vhost-user.c       |   1 +
>  hw/virtio/vhost.c            |   1 +
>  hw/virtio/virtio-balloon.c   |   1 +
>  memory.c                     |   1 +
>  migration/migration.c        |   1 +
>  migration/postcopy-ram.c     |   1 +
>  migration/savevm.c           |   1 +
>  stubs/ram-block.c            |   2 +-
>  target/ppc/kvm.c             |   1 -
>  target/s390x/kvm.c           |   1 -
>  util/vfio-helpers.c          |   2 +-
>  20 files changed, 145 insertions(+), 139 deletions(-)
>=20
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index b47e5630e7..347ceb603b 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -49,25 +49,6 @@ typedef uint32_t CPUReadMemoryFunc(void *opaque, hwadd=
r addr);
>  void qemu_ram_remap(ram_addr_t addr, ram_addr_t length);
>  /* This should not be used by devices.  */
>  ram_addr_t qemu_ram_addr_from_host(void *ptr);
> -RAMBlock *qemu_ram_block_by_name(const char *name);
> -RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
> -                                   ram_addr_t *offset);
> -ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host);
> -void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *=
dev);
> -void qemu_ram_unset_idstr(RAMBlock *block);
> -const char *qemu_ram_get_idstr(RAMBlock *rb);
> -void *qemu_ram_get_host_addr(RAMBlock *rb);
> -ram_addr_t qemu_ram_get_offset(RAMBlock *rb);
> -ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
> -bool qemu_ram_is_shared(RAMBlock *rb);
> -bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
> -void qemu_ram_set_uf_zeroable(RAMBlock *rb);
> -bool qemu_ram_is_migratable(RAMBlock *rb);
> -void qemu_ram_set_migratable(RAMBlock *rb);
> -void qemu_ram_unset_migratable(RAMBlock *rb);
> -
> -size_t qemu_ram_pagesize(RAMBlock *block);
> -size_t qemu_ram_pagesize_largest(void);
> =20
>  void cpu_physical_memory_rw(hwaddr addr, void *buf,
>                              hwaddr len, bool is_write);
> @@ -100,11 +81,6 @@ void qemu_flush_coalesced_mmio_buffer(void);
> =20
>  void cpu_flush_icache_range(hwaddr start, hwaddr len);
> =20
> -typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
> -
> -int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
> -int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
> -
>  #endif
> =20
>  #endif /* CPU_COMMON_H */
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index c61d5188f7..0deffad66f 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -26,112 +26,7 @@
>  #include "exec/ramlist.h"
>  #include "exec/ramblock.h"
> =20
> -/**
> - * clear_bmap_size: calculate clear bitmap size
> - *
> - * @pages: number of guest pages
> - * @shift: guest page number shift
> - *
> - * Returns: number of bits for the clear bitmap
> - */
> -static inline long clear_bmap_size(uint64_t pages, uint8_t shift)
> -{
> -    return DIV_ROUND_UP(pages, 1UL << shift);
> -}
> =20
> -/**
> - * clear_bmap_set: set clear bitmap for the page range
> - *
> - * @rb: the ramblock to operate on
> - * @start: the start page number
> - * @size: number of pages to set in the bitmap
> - *
> - * Returns: None
> - */
> -static inline void clear_bmap_set(RAMBlock *rb, uint64_t start,
> -                                  uint64_t npages)
> -{
> -    uint8_t shift =3D rb->clear_bmap_shift;
> -
> -    bitmap_set_atomic(rb->clear_bmap, start >> shift,
> -                      clear_bmap_size(npages, shift));
> -}
> -
> -/**
> - * clear_bmap_test_and_clear: test clear bitmap for the page, clear if s=
et
> - *
> - * @rb: the ramblock to operate on
> - * @page: the page number to check
> - *
> - * Returns: true if the bit was set, false otherwise
> - */
> -static inline bool clear_bmap_test_and_clear(RAMBlock *rb, uint64_t page)
> -{
> -    uint8_t shift =3D rb->clear_bmap_shift;
> -
> -    return bitmap_test_and_clear_atomic(rb->clear_bmap, page >> shift, 1=
);
> -}
> -
> -static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
> -{
> -    return (b && b->host && offset < b->used_length) ? true : false;
> -}
> -
> -static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
> -{
> -    assert(offset_in_ramblock(block, offset));
> -    return (char *)block->host + offset;
> -}
> -
> -bool ramblock_is_pmem(RAMBlock *rb);
> -
> -/**
> - * qemu_ram_alloc_from_file,
> - * qemu_ram_alloc_from_fd:  Allocate a ram block from the specified back=
ing
> - *                          file or device
> - *
> - * Parameters:
> - *  @size: the size in bytes of the ram block
> - *  @mr: the memory region where the ram block is
> - *  @ram_flags: specify the properties of the ram block, which can be one
> - *              or bit-or of following values
> - *              - RAM_SHARED: mmap the backing file or device with MAP_S=
HARED
> - *              - RAM_PMEM: the backend @mem_path or @fd is persistent m=
emory
> - *              Other bits are ignored.
> - *  @mem_path or @fd: specify the backing file or device
> - *  @errp: pointer to Error*, to store an error if it happens
> - *
> - * Return:
> - *  On success, return a pointer to the ram block.
> - *  On failure, return NULL.
> - */
> -RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
> -                                   uint32_t ram_flags, const char *mem_p=
ath,
> -                                   Error **errp);
> -RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
> -                                 uint32_t ram_flags, int fd,
> -                                 Error **errp);
> -
> -RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
> -                                  MemoryRegion *mr, Error **errp);
> -RAMBlock *qemu_ram_alloc(ram_addr_t size, bool share, MemoryRegion *mr,
> -                         Error **errp);
> -RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t max_size,
> -                                    void (*resized)(const char*,
> -                                                    uint64_t length,
> -                                                    void *host),
> -                                    MemoryRegion *mr, Error **errp);
> -void qemu_ram_free(RAMBlock *block);
> -
> -int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp);
> -
> -void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length=
);
> -
> -/* Clear whole block of mem */
> -static inline void qemu_ram_block_writeback(RAMBlock *block)
> -{
> -    qemu_ram_msync(block, 0, block->used_length);
> -}
> =20
>  #define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
>  #define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_C=
ODE))
> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> index 6ac0aa7a89..b6b34141fc 100644
> --- a/include/exec/ramblock.h
> +++ b/include/exec/ramblock.h
> @@ -22,6 +22,7 @@
>  #ifndef CONFIG_USER_ONLY
>  #include "cpu-common.h"
>  #include "qemu/rcu.h"
> +#include "qemu/bitmap.h"
> =20
>  struct RAMBlock {
>      struct rcu_head rcu;
> @@ -61,5 +62,138 @@ struct RAMBlock {
>      unsigned long *clear_bmap;
>      uint8_t clear_bmap_shift;
>  };
> +
> +RAMBlock *qemu_ram_block_by_name(const char *name);
> +RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
> +                                   ram_addr_t *offset);
> +ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host);
> +void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *=
dev);
> +void qemu_ram_unset_idstr(RAMBlock *block);
> +const char *qemu_ram_get_idstr(RAMBlock *rb);
> +void *qemu_ram_get_host_addr(RAMBlock *rb);
> +ram_addr_t qemu_ram_get_offset(RAMBlock *rb);
> +ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
> +bool qemu_ram_is_shared(RAMBlock *rb);
> +bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
> +void qemu_ram_set_uf_zeroable(RAMBlock *rb);
> +bool qemu_ram_is_migratable(RAMBlock *rb);
> +void qemu_ram_set_migratable(RAMBlock *rb);
> +void qemu_ram_unset_migratable(RAMBlock *rb);
> +
> +size_t qemu_ram_pagesize(RAMBlock *block);
> +size_t qemu_ram_pagesize_largest(void);
> +
> +/**
> + * clear_bmap_size: calculate clear bitmap size
> + *
> + * @pages: number of guest pages
> + * @shift: guest page number shift
> + *
> + * Returns: number of bits for the clear bitmap
> + */
> +static inline long clear_bmap_size(uint64_t pages, uint8_t shift)
> +{
> +    return DIV_ROUND_UP(pages, 1UL << shift);
> +}
> +
> +/**
> + * clear_bmap_set: set clear bitmap for the page range
> + *
> + * @rb: the ramblock to operate on
> + * @start: the start page number
> + * @size: number of pages to set in the bitmap
> + *
> + * Returns: None
> + */
> +static inline void clear_bmap_set(RAMBlock *rb, uint64_t start,
> +                                  uint64_t npages)
> +{
> +    uint8_t shift =3D rb->clear_bmap_shift;
> +
> +    bitmap_set_atomic(rb->clear_bmap, start >> shift,
> +                      clear_bmap_size(npages, shift));
> +}
> +
> +/**
> + * clear_bmap_test_and_clear: test clear bitmap for the page, clear if s=
et
> + *
> + * @rb: the ramblock to operate on
> + * @page: the page number to check
> + *
> + * Returns: true if the bit was set, false otherwise
> + */
> +static inline bool clear_bmap_test_and_clear(RAMBlock *rb, uint64_t page)
> +{
> +    uint8_t shift =3D rb->clear_bmap_shift;
> +
> +    return bitmap_test_and_clear_atomic(rb->clear_bmap, page >> shift, 1=
);
> +}
> +
> +static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
> +{
> +    return (b && b->host && offset < b->used_length) ? true : false;
> +}
> +
> +static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
> +{
> +    assert(offset_in_ramblock(block, offset));
> +    return (char *)block->host + offset;
> +}
> +
> +bool ramblock_is_pmem(RAMBlock *rb);
> +
> +/**
> + * qemu_ram_alloc_from_file,
> + * qemu_ram_alloc_from_fd:  Allocate a ram block from the specified back=
ing
> + *                          file or device
> + *
> + * Parameters:
> + *  @size: the size in bytes of the ram block
> + *  @mr: the memory region where the ram block is
> + *  @ram_flags: specify the properties of the ram block, which can be one
> + *              or bit-or of following values
> + *              - RAM_SHARED: mmap the backing file or device with MAP_S=
HARED
> + *              - RAM_PMEM: the backend @mem_path or @fd is persistent m=
emory
> + *              Other bits are ignored.
> + *  @mem_path or @fd: specify the backing file or device
> + *  @errp: pointer to Error*, to store an error if it happens
> + *
> + * Return:
> + *  On success, return a pointer to the ram block.
> + *  On failure, return NULL.
> + */
> +RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
> +                                   uint32_t ram_flags, const char *mem_p=
ath,
> +                                   Error **errp);
> +RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
> +                                 uint32_t ram_flags, int fd,
> +                                 Error **errp);
> +
> +RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
> +                                  MemoryRegion *mr, Error **errp);
> +RAMBlock *qemu_ram_alloc(ram_addr_t size, bool share, MemoryRegion *mr,
> +                         Error **errp);
> +RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t max_size,
> +                                    void (*resized)(const char*,
> +                                                    uint64_t length,
> +                                                    void *host),
> +                                    MemoryRegion *mr, Error **errp);
> +void qemu_ram_free(RAMBlock *block);
> +
> +int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp);
> +
> +void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length=
);
> +
> +/* Clear whole block of mem */
> +static inline void qemu_ram_block_writeback(RAMBlock *block)
> +{
> +    qemu_ram_msync(block, 0, block->used_length);
> +}
> +
> +typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
> +
> +int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
> +int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
> +
>  #endif
>  #endif
> diff --git a/migration/migration.h b/migration/migration.h
> index 507284e563..73eb210ef5 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -21,6 +21,7 @@
>  #include "qemu/coroutine_int.h"
>  #include "io/channel.h"
>  #include "net/announce.h"
> +#include "exec/ramblock.h"
> =20
>  struct PostcopyBlocktimeContext;
> =20
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 9924e66d1f..15c8ee9110 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -43,8 +43,6 @@
>  #include <libutil.h>
>  #endif
>  #endif
> -#else
> -#include "exec/ram_addr.h"
>  #endif
> =20
>  #include "exec/cputlb.h"
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 21a199e53b..8d8dd7ce80 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -46,7 +46,7 @@
>  #include "qapi/visitor.h"
>  #include "sysemu/hostmem.h"
>  #include "sysemu/block-backend.h"
> -#include "exec/ram_addr.h"
> +#include "exec/ramblock.h"
> =20
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
> index f89d8d9d16..46ca7e7d1f 100644
> --- a/hw/s390x/s390-stattrib-kvm.c
> +++ b/hw/s390x/s390-stattrib-kvm.c
> @@ -15,7 +15,6 @@
>  #include "hw/s390x/storage-attributes.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/kvm.h"
> -#include "exec/ram_addr.h"
>  #include "cpu.h"
>  #include "kvm_s390x.h"
> =20
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index 58121b9f68..9785d51577 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -16,7 +16,6 @@
>  #include "migration/register.h"
>  #include "hw/s390x/storage-attributes.h"
>  #include "qemu/error-report.h"
> -#include "exec/ram_addr.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qdict.h"
> =20
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index c009384505..ade36eda5e 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -17,7 +17,6 @@
>  #include "cpu.h"
>  #include "hw/boards.h"
>  #include "exec/address-spaces.h"
> -#include "exec/ram_addr.h"
>  #include "hw/s390x/s390-virtio-hcall.h"
>  #include "hw/s390x/sclp.h"
>  #include "hw/s390x/s390_flic.h"
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index ec21e8fbe8..12764d6254 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -23,6 +23,7 @@
>  #include "sysemu/cryptodev.h"
>  #include "migration/migration.h"
>  #include "migration/postcopy-ram.h"
> +#include "exec/ramblock.h"
>  #include "trace.h"
> =20
>  #include <sys/ioctl.h>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index aff98a0ede..7da8d95a43 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -22,6 +22,7 @@
>  #include "qemu/memfd.h"
>  #include "standard-headers/linux/vhost_types.h"
>  #include "exec/address-spaces.h"
> +#include "exec/ramblock.h"
>  #include "hw/virtio/virtio-bus.h"
>  #include "hw/virtio/virtio-access.h"
>  #include "migration/blocker.h"
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index a4729f7fc9..ea112e9403 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -23,6 +23,7 @@
>  #include "sysemu/balloon.h"
>  #include "hw/virtio/virtio-balloon.h"
>  #include "exec/address-spaces.h"
> +#include "exec/ramblock.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-events-misc.h"
>  #include "qapi/visitor.h"
> diff --git a/memory.c b/memory.c
> index 3e65e33ac4..e8e7bcd6c7 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -28,6 +28,7 @@
> =20
>  #include "exec/memory-internal.h"
>  #include "exec/ram_addr.h"
> +#include "exec/ramblock.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/runstate.h"
>  #include "sysemu/tcg.h"
> diff --git a/migration/migration.c b/migration/migration.c
> index 177cce9e95..8c7ed8cc79 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -46,6 +46,7 @@
>  #include "qemu/thread.h"
>  #include "trace.h"
>  #include "exec/target_page.h"
> +#include "exec/ramblock.h"
>  #include "io/channel-buffer.h"
>  #include "migration/colo.h"
>  #include "hw/boards.h"
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index a36402722b..78646abf7a 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -18,6 +18,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "exec/target_page.h"
> +#include "exec/ramblock.h"
>  #include "migration.h"
>  #include "qemu-file.h"
>  #include "savevm.h"
> diff --git a/migration/savevm.c b/migration/savevm.c
> index b979ea6e7f..714b5b4591 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -48,6 +48,7 @@
>  #include "sysemu/cpus.h"
>  #include "exec/memory.h"
>  #include "exec/target_page.h"
> +#include "exec/ramblock.h"
>  #include "trace.h"
>  #include "qemu/iov.h"
>  #include "qemu/main-loop.h"
> diff --git a/stubs/ram-block.c b/stubs/ram-block.c
> index 73c0a3ee08..9e73543598 100644
> --- a/stubs/ram-block.c
> +++ b/stubs/ram-block.c
> @@ -1,6 +1,6 @@
>  #include "qemu/osdep.h"
>  #include "exec/ramlist.h"
> -#include "exec/cpu-common.h"
> +#include "exec/ramblock.h"
> =20
>  void *qemu_ram_get_host_addr(RAMBlock *rb)
>  {
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 2692f76130..1f3db517db 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -43,7 +43,6 @@
>  #include "trace.h"
>  #include "exec/gdbstub.h"
>  #include "exec/memattrs.h"
> -#include "exec/ram_addr.h"
>  #include "sysemu/hostmem.h"
>  #include "qemu/cutils.h"
>  #include "qemu/main-loop.h"
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 69881a0da0..42657bc0a5 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -41,7 +41,6 @@
>  #include "sysemu/runstate.h"
>  #include "sysemu/device_tree.h"
>  #include "exec/gdbstub.h"
> -#include "exec/ram_addr.h"
>  #include "trace.h"
>  #include "hw/s390x/s390-pci-inst.h"
>  #include "hw/s390x/s390-pci-bus.h"
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index e399e330e2..2ee169da58 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -15,7 +15,7 @@
>  #include <linux/vfio.h>
>  #include "qapi/error.h"
>  #include "exec/ramlist.h"
> -#include "exec/cpu-common.h"
> +#include "exec/ramblock.h"
>  #include "trace.h"
>  #include "qemu/error-report.h"
>  #include "standard-headers/linux/pci_regs.h"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Z9t8O/5YJLB6LEUl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl64q4cACgkQbDjKyiDZ
s5KTlw/8CdkN1l++QxkA6FxdY8/lT4vIE9jhihBxWNfGSUBcabwpFlbP5eDVlqXs
giUSOPgXILVYZqPxw3u2CKxLTfjt6FliUUitboWXVjFgQQUxPoV5DrKNEu9GzqJU
+bYhLl2JWeRB+1JApcbvSX385A6J/DL8CAWVy2BKKz2bqkdXNpiZ+rNZgVTVbpjF
bKBvk9hiob4zJW+rp7R9sq4CHApQpNY/2DJC8uzs2u7Ije8hyiTREmhmtduD99V/
CJat+P5qxEsVO5nlVKFSq4kdBwnI5flCZYiPaFakuI5caFTwU8d+t4QYZpAUoQai
vraNVfJLey6rB3V5ZaFXK3JyFXFAMCjpK6xCnS3UONFYVSI9BfA+IhN7klreUV4/
gEIy76uyg+OntG/wJuTo3xIl4CsB+SPCAKVTy9jaMvyqW9nT22VUHpw+ndPLgG+Q
+5mR1dn1mylw+eo9zWLJ+1CVs16LWTH/YP0SEOXhpKpkR+1r6TfsXbXq7ewxrMzn
wGCP+92W7ufR8NJhwzq2q+zBwR2UwkIQNsq8SHB5Zx/IqnBR7ZyZmCaq14HSuP2v
zUfQwfiosqeW86lZRRTnmspbVsFf/CMlYCPpAJ3fK8cByt257rRCazKPlpvZwkWG
ZsoT8IPwQNWmNEvr7uhcqm1IookRyxQOUzK3FE3YkIDCOsadlwI=
=F15G
-----END PGP SIGNATURE-----

--Z9t8O/5YJLB6LEUl--

