Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URG_BIZ,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0438C74A52
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 11:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 469A0208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 11:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469A0208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlXdi-00072q-Is
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 07:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42310)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hlXcR-00067p-Cx
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 07:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hlXcH-00085M-7J
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 07:52:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54950)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hlXcG-00080a-2X
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 07:52:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 97585307D91E;
 Thu, 11 Jul 2019 11:51:58 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C912B60148;
 Thu, 11 Jul 2019 11:51:55 +0000 (UTC)
Date: Thu, 11 Jul 2019 12:51:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190711115153.GA5846@work-vm>
References: <20190711104412.31233-1-quintela@redhat.com>
 <20190711104412.31233-19-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711104412.31233-19-quintela@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 11 Jul 2019 11:51:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 18/19] migration: Split log_clear() into
 smaller chunks
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Currently we are doing log_clear() right after log_sync() which mostly
> keeps the old behavior when log_clear() was still part of log_sync().
> 
> This patch tries to further optimize the migration log_clear() code
> path to split huge log_clear()s into smaller chunks.
> 
> We do this by spliting the whole guest memory region into memory
> chunks, whose size is decided by MigrationState.clear_bitmap_shift (an
> example will be given below).  With that, we don't do the dirty bitmap
> clear operation on the remote node (e.g., KVM) when we fetch the dirty
> bitmap, instead we explicitly clear the dirty bitmap for the memory
> chunk for each of the first time we send a page in that chunk.
> 
> Here comes an example.
> 
> Assuming the guest has 64G memory, then before this patch the KVM
> ioctl KVM_CLEAR_DIRTY_LOG will be a single one covering 64G memory.
> If after the patch, let's assume when the clear bitmap shift is 18,
> then the memory chunk size on x86_64 will be 1UL<<18 * 4K = 1GB.  Then
> instead of sending a big 64G ioctl, we'll send 64 small ioctls, each
> of the ioctl will cover 1G of the guest memory.  For each of the 64
> small ioctls, we'll only send if any of the page in that small chunk
> was going to be sent right away.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Message-Id: <20190603065056.25211-12-peterx@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/exec/memory.h.rej    |   26 +
>  include/exec/ram_addr.h      |   76 +-
>  include/exec/ram_addr.h.orig |  488 ++++
>  memory.c.rej                 |   17 +
>  migration/migration.c        |    4 +
>  migration/migration.h        |   27 +
>  migration/migration.h.orig   |  315 +++
>  migration/ram.c              |   44 +
>  migration/ram.c.orig         | 4599 ++++++++++++++++++++++++++++++++++
>  migration/ram.c.rej          |   33 +
>  migration/trace-events       |    1 +
>  migration/trace-events.orig  |  297 +++

It looks like this patch has had an accident with 'patch' and git commit

Dave

>  12 files changed, 5925 insertions(+), 2 deletions(-)
>  create mode 100644 include/exec/memory.h.rej
>  create mode 100644 include/exec/ram_addr.h.orig
>  create mode 100644 memory.c.rej
>  create mode 100644 migration/migration.h.orig
>  create mode 100644 migration/ram.c.orig
>  create mode 100644 migration/ram.c.rej
>  create mode 100644 migration/trace-events.orig
> 
> diff --git a/include/exec/memory.h.rej b/include/exec/memory.h.rej
> new file mode 100644
> index 0000000000..66aa66616a
> --- /dev/null
> +++ b/include/exec/memory.h.rej
> @@ -0,0 +1,26 @@
> +--- include/exec/memory.h
> ++++ include/exec/memory.h
> +@@ -1254,23 +1254,6 @@ void memory_region_ram_resize(MemoryRegion *mr, ram_addr_t newsize,
> +  */
> + void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client);
> + 
> +-/**
> +- * memory_region_get_dirty: Check whether a range of bytes is dirty
> +- *                          for a specified client.
> +- *
> +- * Checks whether a range of bytes has been written to since the last
> +- * call to memory_region_reset_dirty() with the same @client.  Dirty logging
> +- * must be enabled.
> +- *
> +- * @mr: the memory region being queried.
> +- * @addr: the address (relative to the start of the region) being queried.
> +- * @size: the size of the range being queried.
> +- * @client: the user of the logging information; %DIRTY_MEMORY_MIGRATION or
> +- *          %DIRTY_MEMORY_VGA.
> +- */
> +-bool memory_region_get_dirty(MemoryRegion *mr, hwaddr addr,
> +-                             hwaddr size, unsigned client);
> +-
> + /**
> +  * memory_region_set_dirty: Mark a range of bytes as dirty in a memory region.
> +  *
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 222b4338fb..b7b2e60ff6 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -51,8 +51,70 @@ struct RAMBlock {
>      unsigned long *unsentmap;
>      /* bitmap of already received pages in postcopy */
>      unsigned long *receivedmap;
> +
> +    /*
> +     * bitmap to track already cleared dirty bitmap.  When the bit is
> +     * set, it means the corresponding memory chunk needs a log-clear.
> +     * Set this up to non-NULL to enable the capability to postpone
> +     * and split clearing of dirty bitmap on the remote node (e.g.,
> +     * KVM).  The bitmap will be set only when doing global sync.
> +     *
> +     * NOTE: this bitmap is different comparing to the other bitmaps
> +     * in that one bit can represent multiple guest pages (which is
> +     * decided by the `clear_bmap_shift' variable below).  On
> +     * destination side, this should always be NULL, and the variable
> +     * `clear_bmap_shift' is meaningless.
> +     */
> +    unsigned long *clear_bmap;
> +    uint8_t clear_bmap_shift;
>  };
>  
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
> +    uint8_t shift = rb->clear_bmap_shift;
> +
> +    bitmap_set_atomic(rb->clear_bmap, start >> shift,
> +                      clear_bmap_size(npages, shift));
> +}
> +
> +/**
> + * clear_bmap_test_and_clear: test clear bitmap for the page, clear if set
> + *
> + * @rb: the ramblock to operate on
> + * @page: the page number to check
> + *
> + * Returns: true if the bit was set, false otherwise
> + */
> +static inline bool clear_bmap_test_and_clear(RAMBlock *rb, uint64_t page)
> +{
> +    uint8_t shift = rb->clear_bmap_shift;
> +
> +    return bitmap_test_and_clear_atomic(rb->clear_bmap, page >> shift, 1);
> +}
> +
>  static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
>  {
>      return (b && b->host && offset < b->used_length) ? true : false;
> @@ -463,8 +525,18 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>              }
>          }
>  
> -        /* TODO: split the huge bitmap into smaller chunks */
> -        memory_region_clear_dirty_bitmap(rb->mr, start, length);
> +        if (rb->clear_bmap) {
> +            /*
> +             * Postpone the dirty bitmap clear to the point before we
> +             * really send the pages, also we will split the clear
> +             * dirty procedure into smaller chunks.
> +             */
> +            clear_bmap_set(rb, start >> TARGET_PAGE_BITS,
> +                           length >> TARGET_PAGE_BITS);
> +        } else {
> +            /* Slow path - still do that in a huge chunk */
> +            memory_region_clear_dirty_bitmap(rb->mr, start, length);
> +        }
>      } else {
>          ram_addr_t offset = rb->offset;
>  
> diff --git a/include/exec/ram_addr.h.orig b/include/exec/ram_addr.h.orig
> new file mode 100644
> index 0000000000..222b4338fb
> --- /dev/null
> +++ b/include/exec/ram_addr.h.orig
> @@ -0,0 +1,488 @@
> +/*
> + * Declarations for cpu physical memory functions
> + *
> + * Copyright 2011 Red Hat, Inc. and/or its affiliates
> + *
> + * Authors:
> + *  Avi Kivity <avi@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later.  See the COPYING file in the top-level directory.
> + *
> + */
> +
> +/*
> + * This header is for use by exec.c and memory.c ONLY.  Do not include it.
> + * The functions declared here will be removed soon.
> + */
> +
> +#ifndef RAM_ADDR_H
> +#define RAM_ADDR_H
> +
> +#ifndef CONFIG_USER_ONLY
> +#include "hw/xen/xen.h"
> +#include "sysemu/tcg.h"
> +#include "exec/ramlist.h"
> +
> +struct RAMBlock {
> +    struct rcu_head rcu;
> +    struct MemoryRegion *mr;
> +    uint8_t *host;
> +    uint8_t *colo_cache; /* For colo, VM's ram cache */
> +    ram_addr_t offset;
> +    ram_addr_t used_length;
> +    ram_addr_t max_length;
> +    void (*resized)(const char*, uint64_t length, void *host);
> +    uint32_t flags;
> +    /* Protected by iothread lock.  */
> +    char idstr[256];
> +    /* RCU-enabled, writes protected by the ramlist lock */
> +    QLIST_ENTRY(RAMBlock) next;
> +    QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
> +    int fd;
> +    size_t page_size;
> +    /* dirty bitmap used during migration */
> +    unsigned long *bmap;
> +    /* bitmap of pages that haven't been sent even once
> +     * only maintained and used in postcopy at the moment
> +     * where it's used to send the dirtymap at the start
> +     * of the postcopy phase
> +     */
> +    unsigned long *unsentmap;
> +    /* bitmap of already received pages in postcopy */
> +    unsigned long *receivedmap;
> +};
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
> +static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
> +                                                            RAMBlock *rb)
> +{
> +    uint64_t host_addr_offset =
> +            (uint64_t)(uintptr_t)(host_addr - (void *)rb->host);
> +    return host_addr_offset >> TARGET_PAGE_BITS;
> +}
> +
> +bool ramblock_is_pmem(RAMBlock *rb);
> +
> +long qemu_minrampagesize(void);
> +long qemu_maxrampagesize(void);
> +
> +/**
> + * qemu_ram_alloc_from_file,
> + * qemu_ram_alloc_from_fd:  Allocate a ram block from the specified backing
> + *                          file or device
> + *
> + * Parameters:
> + *  @size: the size in bytes of the ram block
> + *  @mr: the memory region where the ram block is
> + *  @ram_flags: specify the properties of the ram block, which can be one
> + *              or bit-or of following values
> + *              - RAM_SHARED: mmap the backing file or device with MAP_SHARED
> + *              - RAM_PMEM: the backend @mem_path or @fd is persistent memory
> + *              Other bits are ignored.
> + *  @mem_path or @fd: specify the backing file or device
> + *  @errp: pointer to Error*, to store an error if it happens
> + *
> + * Return:
> + *  On success, return a pointer to the ram block.
> + *  On failure, return NULL.
> + */
> +RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
> +                                   uint32_t ram_flags, const char *mem_path,
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
> +#define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
> +#define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_CODE))
> +
> +void tb_invalidate_phys_range(ram_addr_t start, ram_addr_t end);
> +
> +static inline bool cpu_physical_memory_get_dirty(ram_addr_t start,
> +                                                 ram_addr_t length,
> +                                                 unsigned client)
> +{
> +    DirtyMemoryBlocks *blocks;
> +    unsigned long end, page;
> +    unsigned long idx, offset, base;
> +    bool dirty = false;
> +
> +    assert(client < DIRTY_MEMORY_NUM);
> +
> +    end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
> +    page = start >> TARGET_PAGE_BITS;
> +
> +    rcu_read_lock();
> +
> +    blocks = atomic_rcu_read(&ram_list.dirty_memory[client]);
> +
> +    idx = page / DIRTY_MEMORY_BLOCK_SIZE;
> +    offset = page % DIRTY_MEMORY_BLOCK_SIZE;
> +    base = page - offset;
> +    while (page < end) {
> +        unsigned long next = MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE);
> +        unsigned long num = next - base;
> +        unsigned long found = find_next_bit(blocks->blocks[idx], num, offset);
> +        if (found < num) {
> +            dirty = true;
> +            break;
> +        }
> +
> +        page = next;
> +        idx++;
> +        offset = 0;
> +        base += DIRTY_MEMORY_BLOCK_SIZE;
> +    }
> +
> +    rcu_read_unlock();
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
> +    bool dirty = true;
> +
> +    assert(client < DIRTY_MEMORY_NUM);
> +
> +    end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
> +    page = start >> TARGET_PAGE_BITS;
> +
> +    rcu_read_lock();
> +
> +    blocks = atomic_rcu_read(&ram_list.dirty_memory[client]);
> +
> +    idx = page / DIRTY_MEMORY_BLOCK_SIZE;
> +    offset = page % DIRTY_MEMORY_BLOCK_SIZE;
> +    base = page - offset;
> +    while (page < end) {
> +        unsigned long next = MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE);
> +        unsigned long num = next - base;
> +        unsigned long found = find_next_zero_bit(blocks->blocks[idx], num, offset);
> +        if (found < num) {
> +            dirty = false;
> +            break;
> +        }
> +
> +        page = next;
> +        idx++;
> +        offset = 0;
> +        base += DIRTY_MEMORY_BLOCK_SIZE;
> +    }
> +
> +    rcu_read_unlock();
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
> +    bool vga = cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_VGA);
> +    bool code = cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_CODE);
> +    bool migration =
> +        cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_MIGRATION);
> +    return !(vga && code && migration);
> +}
> +
> +static inline uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t start,
> +                                                               ram_addr_t length,
> +                                                               uint8_t mask)
> +{
> +    uint8_t ret = 0;
> +
> +    if (mask & (1 << DIRTY_MEMORY_VGA) &&
> +        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_VGA)) {
> +        ret |= (1 << DIRTY_MEMORY_VGA);
> +    }
> +    if (mask & (1 << DIRTY_MEMORY_CODE) &&
> +        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_CODE)) {
> +        ret |= (1 << DIRTY_MEMORY_CODE);
> +    }
> +    if (mask & (1 << DIRTY_MEMORY_MIGRATION) &&
> +        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_MIGRATION)) {
> +        ret |= (1 << DIRTY_MEMORY_MIGRATION);
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
> +    page = addr >> TARGET_PAGE_BITS;
> +    idx = page / DIRTY_MEMORY_BLOCK_SIZE;
> +    offset = page % DIRTY_MEMORY_BLOCK_SIZE;
> +
> +    rcu_read_lock();
> +
> +    blocks = atomic_rcu_read(&ram_list.dirty_memory[client]);
> +
> +    set_bit_atomic(offset, blocks->blocks[idx]);
> +
> +    rcu_read_unlock();
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
> +    end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
> +    page = start >> TARGET_PAGE_BITS;
> +
> +    rcu_read_lock();
> +
> +    for (i = 0; i < DIRTY_MEMORY_NUM; i++) {
> +        blocks[i] = atomic_rcu_read(&ram_list.dirty_memory[i]);
> +    }
> +
> +    idx = page / DIRTY_MEMORY_BLOCK_SIZE;
> +    offset = page % DIRTY_MEMORY_BLOCK_SIZE;
> +    base = page - offset;
> +    while (page < end) {
> +        unsigned long next = MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE);
> +
> +        if (likely(mask & (1 << DIRTY_MEMORY_MIGRATION))) {
> +            bitmap_set_atomic(blocks[DIRTY_MEMORY_MIGRATION]->blocks[idx],
> +                              offset, next - page);
> +        }
> +        if (unlikely(mask & (1 << DIRTY_MEMORY_VGA))) {
> +            bitmap_set_atomic(blocks[DIRTY_MEMORY_VGA]->blocks[idx],
> +                              offset, next - page);
> +        }
> +        if (unlikely(mask & (1 << DIRTY_MEMORY_CODE))) {
> +            bitmap_set_atomic(blocks[DIRTY_MEMORY_CODE]->blocks[idx],
> +                              offset, next - page);
> +        }
> +
> +        page = next;
> +        idx++;
> +        offset = 0;
> +        base += DIRTY_MEMORY_BLOCK_SIZE;
> +    }
> +
> +    rcu_read_unlock();
> +
> +    xen_hvm_modified_memory(start, length);
> +}
> +
> +#if !defined(_WIN32)
> +static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
> +                                                          ram_addr_t start,
> +                                                          ram_addr_t pages)
> +{
> +    unsigned long i, j;
> +    unsigned long page_number, c;
> +    hwaddr addr;
> +    ram_addr_t ram_addr;
> +    unsigned long len = (pages + HOST_LONG_BITS - 1) / HOST_LONG_BITS;
> +    unsigned long hpratio = getpagesize() / TARGET_PAGE_SIZE;
> +    unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
> +
> +    /* start address is aligned at the start of a word? */
> +    if ((((page * BITS_PER_LONG) << TARGET_PAGE_BITS) == start) &&
> +        (hpratio == 1)) {
> +        unsigned long **blocks[DIRTY_MEMORY_NUM];
> +        unsigned long idx;
> +        unsigned long offset;
> +        long k;
> +        long nr = BITS_TO_LONGS(pages);
> +
> +        idx = (start >> TARGET_PAGE_BITS) / DIRTY_MEMORY_BLOCK_SIZE;
> +        offset = BIT_WORD((start >> TARGET_PAGE_BITS) %
> +                          DIRTY_MEMORY_BLOCK_SIZE);
> +
> +        rcu_read_lock();
> +
> +        for (i = 0; i < DIRTY_MEMORY_NUM; i++) {
> +            blocks[i] = atomic_rcu_read(&ram_list.dirty_memory[i])->blocks;
> +        }
> +
> +        for (k = 0; k < nr; k++) {
> +            if (bitmap[k]) {
> +                unsigned long temp = leul_to_cpu(bitmap[k]);
> +
> +                atomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp);
> +
> +                if (global_dirty_log) {
> +                    atomic_or(&blocks[DIRTY_MEMORY_MIGRATION][idx][offset],
> +                              temp);
> +                }
> +
> +                if (tcg_enabled()) {
> +                    atomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset], temp);
> +                }
> +            }
> +
> +            if (++offset >= BITS_TO_LONGS(DIRTY_MEMORY_BLOCK_SIZE)) {
> +                offset = 0;
> +                idx++;
> +            }
> +        }
> +
> +        rcu_read_unlock();
> +
> +        xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
> +    } else {
> +        uint8_t clients = tcg_enabled() ? DIRTY_CLIENTS_ALL : DIRTY_CLIENTS_NOCODE;
> +
> +        if (!global_dirty_log) {
> +            clients &= ~(1 << DIRTY_MEMORY_MIGRATION);
> +        }
> +
> +        /*
> +         * bitmap-traveling is faster than memory-traveling (for addr...)
> +         * especially when most of the memory is not dirty.
> +         */
> +        for (i = 0; i < len; i++) {
> +            if (bitmap[i] != 0) {
> +                c = leul_to_cpu(bitmap[i]);
> +                do {
> +                    j = ctzl(c);
> +                    c &= ~(1ul << j);
> +                    page_number = (i * HOST_LONG_BITS + j) * hpratio;
> +                    addr = page_number * TARGET_PAGE_SIZE;
> +                    ram_addr = start + addr;
> +                    cpu_physical_memory_set_dirty_range(ram_addr,
> +                                       TARGET_PAGE_SIZE * hpratio, clients);
> +                } while (c != 0);
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
> +DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
> +    (MemoryRegion *mr, hwaddr offset, hwaddr length, unsigned client);
> +
> +bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
> +                                            ram_addr_t start,
> +                                            ram_addr_t length);
> +
> +static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
> +                                                         ram_addr_t length)
> +{
> +    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_MIGRATION);
> +    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_VGA);
> +    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_CODE);
> +}
> +
> +
> +/* Called with RCU critical section */
> +static inline
> +uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
> +                                               ram_addr_t start,
> +                                               ram_addr_t length,
> +                                               uint64_t *real_dirty_pages)
> +{
> +    ram_addr_t addr;
> +    unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
> +    uint64_t num_dirty = 0;
> +    unsigned long *dest = rb->bmap;
> +
> +    /* start address and length is aligned at the start of a word? */
> +    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) ==
> +         (start + rb->offset) &&
> +        !(length & ((BITS_PER_LONG << TARGET_PAGE_BITS) - 1))) {
> +        int k;
> +        int nr = BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
> +        unsigned long * const *src;
> +        unsigned long idx = (word * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_SIZE;
> +        unsigned long offset = BIT_WORD((word * BITS_PER_LONG) %
> +                                        DIRTY_MEMORY_BLOCK_SIZE);
> +        unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
> +
> +        src = atomic_rcu_read(
> +                &ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION])->blocks;
> +
> +        for (k = page; k < page + nr; k++) {
> +            if (src[idx][offset]) {
> +                unsigned long bits = atomic_xchg(&src[idx][offset], 0);
> +                unsigned long new_dirty;
> +                *real_dirty_pages += ctpopl(bits);
> +                new_dirty = ~dest[k];
> +                dest[k] |= bits;
> +                new_dirty &= bits;
> +                num_dirty += ctpopl(new_dirty);
> +            }
> +
> +            if (++offset >= BITS_TO_LONGS(DIRTY_MEMORY_BLOCK_SIZE)) {
> +                offset = 0;
> +                idx++;
> +            }
> +        }
> +
> +        /* TODO: split the huge bitmap into smaller chunks */
> +        memory_region_clear_dirty_bitmap(rb->mr, start, length);
> +    } else {
> +        ram_addr_t offset = rb->offset;
> +
> +        for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
> +            if (cpu_physical_memory_test_and_clear_dirty(
> +                        start + addr + offset,
> +                        TARGET_PAGE_SIZE,
> +                        DIRTY_MEMORY_MIGRATION)) {
> +                *real_dirty_pages += 1;
> +                long k = (start + addr) >> TARGET_PAGE_BITS;
> +                if (!test_and_set_bit(k, dest)) {
> +                    num_dirty++;
> +                }
> +            }
> +        }
> +    }
> +
> +    return num_dirty;
> +}
> +#endif
> +#endif
> diff --git a/memory.c.rej b/memory.c.rej
> new file mode 100644
> index 0000000000..bb1c1d0360
> --- /dev/null
> +++ b/memory.c.rej
> @@ -0,0 +1,17 @@
> +--- memory.c
> ++++ memory.c
> +@@ -2027,14 +2027,6 @@ void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
> +     memory_region_transaction_commit();
> + }
> + 
> +-bool memory_region_get_dirty(MemoryRegion *mr, hwaddr addr,
> +-                             hwaddr size, unsigned client)
> +-{
> +-    assert(mr->ram_block);
> +-    return cpu_physical_memory_get_dirty(memory_region_get_ram_addr(mr) + addr,
> +-                                         size, client);
> +-}
> +-
> + void memory_region_set_dirty(MemoryRegion *mr, hwaddr addr,
> +                              hwaddr size)
> + {
> diff --git a/migration/migration.c b/migration/migration.c
> index 2865ae3fa9..8a607fe1e2 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3362,6 +3362,8 @@ void migration_global_dump(Monitor *mon)
>                     ms->send_section_footer ? "on" : "off");
>      monitor_printf(mon, "decompress-error-check: %s\n",
>                     ms->decompress_error_check ? "on" : "off");
> +    monitor_printf(mon, "clear-bitmap-shift: %u\n",
> +                   ms->clear_bitmap_shift);
>  }
>  
>  #define DEFINE_PROP_MIG_CAP(name, x)             \
> @@ -3376,6 +3378,8 @@ static Property migration_properties[] = {
>                       send_section_footer, true),
>      DEFINE_PROP_BOOL("decompress-error-check", MigrationState,
>                        decompress_error_check, true),
> +    DEFINE_PROP_UINT8("x-clear-bitmap-shift", MigrationState,
> +                      clear_bitmap_shift, CLEAR_BITMAP_SHIFT_DEFAULT),
>  
>      /* Migration parameters */
>      DEFINE_PROP_UINT8("x-compress-level", MigrationState,
> diff --git a/migration/migration.h b/migration/migration.h
> index 5e8f09c6db..1fdd7b21fd 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -26,6 +26,23 @@ struct PostcopyBlocktimeContext;
>  
>  #define  MIGRATION_RESUME_ACK_VALUE  (1)
>  
> +/*
> + * 1<<6=64 pages -> 256K chunk when page size is 4K.  This gives us
> + * the benefit that all the chunks are 64 pages aligned then the
> + * bitmaps are always aligned to LONG.
> + */
> +#define CLEAR_BITMAP_SHIFT_MIN             6
> +/*
> + * 1<<18=256K pages -> 1G chunk when page size is 4K.  This is the
> + * default value to use if no one specified.
> + */
> +#define CLEAR_BITMAP_SHIFT_DEFAULT        18
> +/*
> + * 1<<31=2G pages -> 8T chunk when page size is 4K.  This should be
> + * big enough and make sure we won't overflow easily.
> + */
> +#define CLEAR_BITMAP_SHIFT_MAX            31
> +
>  /* State for the incoming migration */
>  struct MigrationIncomingState {
>      QEMUFile *from_src_file;
> @@ -232,6 +249,16 @@ struct MigrationState
>       * do not trigger spurious decompression errors.
>       */
>      bool decompress_error_check;
> +
> +    /*
> +     * This decides the size of guest memory chunk that will be used
> +     * to track dirty bitmap clearing.  The size of memory chunk will
> +     * be GUEST_PAGE_SIZE << N.  Say, N=0 means we will clear dirty
> +     * bitmap for each page to send (1<<0=1); N=10 means we will clear
> +     * dirty bitmap only once for 1<<10=1K continuous guest pages
> +     * (which is in 4M chunk).
> +     */
> +    uint8_t clear_bitmap_shift;
>  };
>  
>  void migrate_set_state(int *state, int old_state, int new_state);
> diff --git a/migration/migration.h.orig b/migration/migration.h.orig
> new file mode 100644
> index 0000000000..5e8f09c6db
> --- /dev/null
> +++ b/migration/migration.h.orig
> @@ -0,0 +1,315 @@
> +/*
> + * QEMU live migration
> + *
> + * Copyright IBM, Corp. 2008
> + *
> + * Authors:
> + *  Anthony Liguori   <aliguori@us.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef QEMU_MIGRATION_H
> +#define QEMU_MIGRATION_H
> +
> +#include "qapi/qapi-types-migration.h"
> +#include "qemu/thread.h"
> +#include "exec/cpu-common.h"
> +#include "qemu/coroutine_int.h"
> +#include "hw/qdev.h"
> +#include "io/channel.h"
> +#include "net/announce.h"
> +
> +struct PostcopyBlocktimeContext;
> +
> +#define  MIGRATION_RESUME_ACK_VALUE  (1)
> +
> +/* State for the incoming migration */
> +struct MigrationIncomingState {
> +    QEMUFile *from_src_file;
> +
> +    /*
> +     * Free at the start of the main state load, set as the main thread finishes
> +     * loading state.
> +     */
> +    QemuEvent main_thread_load_event;
> +
> +    /* For network announces */
> +    AnnounceTimer  announce_timer;
> +
> +    size_t         largest_page_size;
> +    bool           have_fault_thread;
> +    QemuThread     fault_thread;
> +    QemuSemaphore  fault_thread_sem;
> +    /* Set this when we want the fault thread to quit */
> +    bool           fault_thread_quit;
> +
> +    bool           have_listen_thread;
> +    QemuThread     listen_thread;
> +    QemuSemaphore  listen_thread_sem;
> +
> +    /* For the kernel to send us notifications */
> +    int       userfault_fd;
> +    /* To notify the fault_thread to wake, e.g., when need to quit */
> +    int       userfault_event_fd;
> +    QEMUFile *to_src_file;
> +    QemuMutex rp_mutex;    /* We send replies from multiple threads */
> +    /* RAMBlock of last request sent to source */
> +    RAMBlock *last_rb;
> +    void     *postcopy_tmp_page;
> +    void     *postcopy_tmp_zero_page;
> +    /* PostCopyFD's for external userfaultfds & handlers of shared memory */
> +    GArray   *postcopy_remote_fds;
> +
> +    QEMUBH *bh;
> +
> +    int state;
> +
> +    bool have_colo_incoming_thread;
> +    QemuThread colo_incoming_thread;
> +    /* The coroutine we should enter (back) after failover */
> +    Coroutine *migration_incoming_co;
> +    QemuSemaphore colo_incoming_sem;
> +
> +    /*
> +     * PostcopyBlocktimeContext to keep information for postcopy
> +     * live migration, to calculate vCPU block time
> +     * */
> +    struct PostcopyBlocktimeContext *blocktime_ctx;
> +
> +    /* notify PAUSED postcopy incoming migrations to try to continue */
> +    bool postcopy_recover_triggered;
> +    QemuSemaphore postcopy_pause_sem_dst;
> +    QemuSemaphore postcopy_pause_sem_fault;
> +
> +    /* List of listening socket addresses  */
> +    SocketAddressList *socket_address_list;
> +};
> +
> +MigrationIncomingState *migration_incoming_get_current(void);
> +void migration_incoming_state_destroy(void);
> +/*
> + * Functions to work with blocktime context
> + */
> +void fill_destination_postcopy_migration_info(MigrationInfo *info);
> +
> +#define TYPE_MIGRATION "migration"
> +
> +#define MIGRATION_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(MigrationClass, (klass), TYPE_MIGRATION)
> +#define MIGRATION_OBJ(obj) \
> +    OBJECT_CHECK(MigrationState, (obj), TYPE_MIGRATION)
> +#define MIGRATION_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(MigrationClass, (obj), TYPE_MIGRATION)
> +
> +typedef struct MigrationClass {
> +    /*< private >*/
> +    DeviceClass parent_class;
> +} MigrationClass;
> +
> +struct MigrationState
> +{
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
> +    size_t bytes_xfer;
> +    QemuThread thread;
> +    QEMUBH *cleanup_bh;
> +    QEMUFile *to_dst_file;
> +    /*
> +     * Protects to_dst_file pointer.  We need to make sure we won't
> +     * yield or hang during the critical section, since this lock will
> +     * be used in OOB command handler.
> +     */
> +    QemuMutex qemu_file_lock;
> +
> +    /*
> +     * Used to allow urgent requests to override rate limiting.
> +     */
> +    QemuSemaphore rate_limit_sem;
> +
> +    /* pages already send at the beginning of current iteration */
> +    uint64_t iteration_initial_pages;
> +
> +    /* pages transferred per second */
> +    double pages_per_second;
> +
> +    /* bytes already send at the beginning of current iteration */
> +    uint64_t iteration_initial_bytes;
> +    /* time at the start of current iteration */
> +    int64_t iteration_start_time;
> +    /*
> +     * The final stage happens when the remaining data is smaller than
> +     * this threshold; it's calculated from the requested downtime and
> +     * measured bandwidth
> +     */
> +    int64_t threshold_size;
> +
> +    /* params from 'migrate-set-parameters' */
> +    MigrationParameters parameters;
> +
> +    int state;
> +
> +    /* State related to return path */
> +    struct {
> +        QEMUFile     *from_dst_file;
> +        QemuThread    rp_thread;
> +        bool          error;
> +        QemuSemaphore rp_sem;
> +    } rp_state;
> +
> +    double mbps;
> +    /* Timestamp when recent migration starts (ms) */
> +    int64_t start_time;
> +    /* Total time used by latest migration (ms) */
> +    int64_t total_time;
> +    /* Timestamp when VM is down (ms) to migrate the last stuff */
> +    int64_t downtime_start;
> +    int64_t downtime;
> +    int64_t expected_downtime;
> +    bool enabled_capabilities[MIGRATION_CAPABILITY__MAX];
> +    int64_t setup_time;
> +    /*
> +     * Whether guest was running when we enter the completion stage.
> +     * If migration is interrupted by any reason, we need to continue
> +     * running the guest on source.
> +     */
> +    bool vm_was_running;
> +
> +    /* Flag set once the migration has been asked to enter postcopy */
> +    bool start_postcopy;
> +    /* Flag set after postcopy has sent the device state */
> +    bool postcopy_after_devices;
> +
> +    /* Flag set once the migration thread is running (and needs joining) */
> +    bool migration_thread_running;
> +
> +    /* Flag set once the migration thread called bdrv_inactivate_all */
> +    bool block_inactive;
> +
> +    /* Migration is paused due to pause-before-switchover */
> +    QemuSemaphore pause_sem;
> +
> +    /* The semaphore is used to notify COLO thread that failover is finished */
> +    QemuSemaphore colo_exit_sem;
> +
> +    /* The semaphore is used to notify COLO thread to do checkpoint */
> +    QemuSemaphore colo_checkpoint_sem;
> +    int64_t colo_checkpoint_time;
> +    QEMUTimer *colo_delay_timer;
> +
> +    /* The first error that has occurred.
> +       We used the mutex to be able to return the 1st error message */
> +    Error *error;
> +    /* mutex to protect errp */
> +    QemuMutex error_mutex;
> +
> +    /* Do we have to clean up -b/-i from old migrate parameters */
> +    /* This feature is deprecated and will be removed */
> +    bool must_remove_block_options;
> +
> +    /*
> +     * Global switch on whether we need to store the global state
> +     * during migration.
> +     */
> +    bool store_global_state;
> +
> +    /* Whether we send QEMU_VM_CONFIGURATION during migration */
> +    bool send_configuration;
> +    /* Whether we send section footer during migration */
> +    bool send_section_footer;
> +
> +    /* Needed by postcopy-pause state */
> +    QemuSemaphore postcopy_pause_sem;
> +    QemuSemaphore postcopy_pause_rp_sem;
> +    /*
> +     * Whether we abort the migration if decompression errors are
> +     * detected at the destination. It is left at false for qemu
> +     * older than 3.0, since only newer qemu sends streams that
> +     * do not trigger spurious decompression errors.
> +     */
> +    bool decompress_error_check;
> +};
> +
> +void migrate_set_state(int *state, int old_state, int new_state);
> +
> +void migration_fd_process_incoming(QEMUFile *f);
> +void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
> +void migration_incoming_process(void);
> +
> +bool  migration_has_all_channels(void);
> +
> +uint64_t migrate_max_downtime(void);
> +
> +void migrate_set_error(MigrationState *s, const Error *error);
> +void migrate_fd_error(MigrationState *s, const Error *error);
> +
> +void migrate_fd_connect(MigrationState *s, Error *error_in);
> +
> +bool migration_is_setup_or_active(int state);
> +
> +void migrate_init(MigrationState *s);
> +bool migration_is_blocked(Error **errp);
> +/* True if outgoing migration has entered postcopy phase */
> +bool migration_in_postcopy(void);
> +MigrationState *migrate_get_current(void);
> +
> +bool migrate_postcopy(void);
> +
> +bool migrate_release_ram(void);
> +bool migrate_postcopy_ram(void);
> +bool migrate_zero_blocks(void);
> +bool migrate_dirty_bitmaps(void);
> +bool migrate_ignore_shared(void);
> +
> +bool migrate_auto_converge(void);
> +bool migrate_use_multifd(void);
> +bool migrate_pause_before_switchover(void);
> +int migrate_multifd_channels(void);
> +
> +int migrate_use_xbzrle(void);
> +int64_t migrate_xbzrle_cache_size(void);
> +bool migrate_colo_enabled(void);
> +
> +bool migrate_use_block(void);
> +bool migrate_use_block_incremental(void);
> +int migrate_max_cpu_throttle(void);
> +bool migrate_use_return_path(void);
> +
> +uint64_t ram_get_total_transferred_pages(void);
> +
> +bool migrate_use_compression(void);
> +int migrate_compress_level(void);
> +int migrate_compress_threads(void);
> +int migrate_compress_wait_thread(void);
> +int migrate_decompress_threads(void);
> +bool migrate_use_events(void);
> +bool migrate_postcopy_blocktime(void);
> +
> +/* Sending on the return path - generic and then for each message type */
> +void migrate_send_rp_shut(MigrationIncomingState *mis,
> +                          uint32_t value);
> +void migrate_send_rp_pong(MigrationIncomingState *mis,
> +                          uint32_t value);
> +int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
> +                              ram_addr_t start, size_t len);
> +void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
> +                                 char *block_name);
> +void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
> +
> +void dirty_bitmap_mig_before_vm_start(void);
> +void init_dirty_bitmap_incoming_migration(void);
> +void migrate_add_address(SocketAddress *address);
> +
> +int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
> +
> +#define qemu_ram_foreach_block \
> +  #warning "Use foreach_not_ignored_block in migration code"
> +
> +void migration_make_urgent_request(void);
> +void migration_consume_urgent_request(void);
> +
> +#endif
> diff --git a/migration/ram.c b/migration/ram.c
> index 48969db84b..8a6ad61d3d 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1664,6 +1664,33 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
>      bool ret;
>  
>      qemu_mutex_lock(&rs->bitmap_mutex);
> +
> +    /*
> +     * Clear dirty bitmap if needed.  This _must_ be called before we
> +     * send any of the page in the chunk because we need to make sure
> +     * we can capture further page content changes when we sync dirty
> +     * log the next time.  So as long as we are going to send any of
> +     * the page in the chunk we clear the remote dirty bitmap for all.
> +     * Clearing it earlier won't be a problem, but too late will.
> +     */
> +    if (rb->clear_bmap && clear_bmap_test_and_clear(rb, page)) {
> +        uint8_t shift = rb->clear_bmap_shift;
> +        hwaddr size = 1ULL << (TARGET_PAGE_BITS + shift);
> +        hwaddr start = (page << TARGET_PAGE_BITS) & (-size);
> +
> +        /*
> +         * CLEAR_BITMAP_SHIFT_MIN should always guarantee this... this
> +         * can make things easier sometimes since then start address
> +         * of the small chunk will always be 64 pages aligned so the
> +         * bitmap will always be aligned to unsigned long.  We should
> +         * even be able to remove this restriction but I'm simply
> +         * keeping it.
> +         */
> +        assert(shift >= 6);
> +        trace_migration_bitmap_clear_dirty(rb->idstr, start, size, page);
> +        memory_region_clear_dirty_bitmap(rb->mr, start, size);
> +    }
> +
>      ret = test_and_clear_bit(page, rb->bmap);
>  
>      if (ret) {
> @@ -2687,6 +2714,8 @@ static void ram_save_cleanup(void *opaque)
>      memory_global_dirty_log_stop();
>  
>      RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +        g_free(block->clear_bmap);
> +        block->clear_bmap = NULL;
>          g_free(block->bmap);
>          block->bmap = NULL;
>          g_free(block->unsentmap);
> @@ -3197,11 +3226,24 @@ static int ram_state_init(RAMState **rsp)
>  
>  static void ram_list_init_bitmaps(void)
>  {
> +    MigrationState *ms = migrate_get_current();
>      RAMBlock *block;
>      unsigned long pages;
> +    uint8_t shift;
>  
>      /* Skip setting bitmap if there is no RAM */
>      if (ram_bytes_total()) {
> +        shift = ms->clear_bitmap_shift;
> +        if (shift > CLEAR_BITMAP_SHIFT_MAX) {
> +            error_report("clear_bitmap_shift (%u) too big, using "
> +                         "max value (%u)", shift, CLEAR_BITMAP_SHIFT_MAX);
> +            shift = CLEAR_BITMAP_SHIFT_MAX;
> +        } else if (shift < CLEAR_BITMAP_SHIFT_MIN) {
> +            error_report("clear_bitmap_shift (%u) too small, using "
> +                         "min value (%u)", shift, CLEAR_BITMAP_SHIFT_MIN);
> +            shift = CLEAR_BITMAP_SHIFT_MIN;
> +        }
> +
>          RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>              pages = block->max_length >> TARGET_PAGE_BITS;
>              /*
> @@ -3214,6 +3256,8 @@ static void ram_list_init_bitmaps(void)
>               * Here setting RAMBlock.bmap would be fine too but not necessary.
>               */
>              block->bmap = bitmap_new(pages);
> +            block->clear_bmap_shift = shift;
> +            block->clear_bmap = bitmap_new(clear_bmap_size(pages, shift));
>              if (migrate_postcopy_ram()) {
>                  block->unsentmap = bitmap_new(pages);
>                  bitmap_set(block->unsentmap, 0, pages);
> diff --git a/migration/ram.c.orig b/migration/ram.c.orig
> new file mode 100644
> index 0000000000..48969db84b
> --- /dev/null
> +++ b/migration/ram.c.orig
> @@ -0,0 +1,4599 @@
> +/*
> + * QEMU System Emulator
> + *
> + * Copyright (c) 2003-2008 Fabrice Bellard
> + * Copyright (c) 2011-2015 Red Hat Inc
> + *
> + * Authors:
> + *  Juan Quintela <quintela@redhat.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include <zlib.h>
> +#include "qemu/cutils.h"
> +#include "qemu/bitops.h"
> +#include "qemu/bitmap.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/pmem.h"
> +#include "xbzrle.h"
> +#include "ram.h"
> +#include "migration.h"
> +#include "socket.h"
> +#include "migration/register.h"
> +#include "migration/misc.h"
> +#include "qemu-file.h"
> +#include "postcopy-ram.h"
> +#include "page_cache.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-events-migration.h"
> +#include "qapi/qmp/qerror.h"
> +#include "trace.h"
> +#include "exec/ram_addr.h"
> +#include "exec/target_page.h"
> +#include "qemu/rcu_queue.h"
> +#include "migration/colo.h"
> +#include "block.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/uuid.h"
> +#include "savevm.h"
> +#include "qemu/iov.h"
> +
> +/***********************************************************/
> +/* ram save/restore */
> +
> +/* RAM_SAVE_FLAG_ZERO used to be named RAM_SAVE_FLAG_COMPRESS, it
> + * worked for pages that where filled with the same char.  We switched
> + * it to only search for the zero value.  And to avoid confusion with
> + * RAM_SSAVE_FLAG_COMPRESS_PAGE just rename it.
> + */
> +
> +#define RAM_SAVE_FLAG_FULL     0x01 /* Obsolete, not used anymore */
> +#define RAM_SAVE_FLAG_ZERO     0x02
> +#define RAM_SAVE_FLAG_MEM_SIZE 0x04
> +#define RAM_SAVE_FLAG_PAGE     0x08
> +#define RAM_SAVE_FLAG_EOS      0x10
> +#define RAM_SAVE_FLAG_CONTINUE 0x20
> +#define RAM_SAVE_FLAG_XBZRLE   0x40
> +/* 0x80 is reserved in migration.h start with 0x100 next */
> +#define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
> +
> +static inline bool is_zero_range(uint8_t *p, uint64_t size)
> +{
> +    return buffer_is_zero(p, size);
> +}
> +
> +XBZRLECacheStats xbzrle_counters;
> +
> +/* struct contains XBZRLE cache and a static page
> +   used by the compression */
> +static struct {
> +    /* buffer used for XBZRLE encoding */
> +    uint8_t *encoded_buf;
> +    /* buffer for storing page content */
> +    uint8_t *current_buf;
> +    /* Cache for XBZRLE, Protected by lock. */
> +    PageCache *cache;
> +    QemuMutex lock;
> +    /* it will store a page full of zeros */
> +    uint8_t *zero_target_page;
> +    /* buffer used for XBZRLE decoding */
> +    uint8_t *decoded_buf;
> +} XBZRLE;
> +
> +static void XBZRLE_cache_lock(void)
> +{
> +    if (migrate_use_xbzrle())
> +        qemu_mutex_lock(&XBZRLE.lock);
> +}
> +
> +static void XBZRLE_cache_unlock(void)
> +{
> +    if (migrate_use_xbzrle())
> +        qemu_mutex_unlock(&XBZRLE.lock);
> +}
> +
> +/**
> + * xbzrle_cache_resize: resize the xbzrle cache
> + *
> + * This function is called from qmp_migrate_set_cache_size in main
> + * thread, possibly while a migration is in progress.  A running
> + * migration may be using the cache and might finish during this call,
> + * hence changes to the cache are protected by XBZRLE.lock().
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @new_size: new cache size
> + * @errp: set *errp if the check failed, with reason
> + */
> +int xbzrle_cache_resize(int64_t new_size, Error **errp)
> +{
> +    PageCache *new_cache;
> +    int64_t ret = 0;
> +
> +    /* Check for truncation */
> +    if (new_size != (size_t)new_size) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
> +                   "exceeding address space");
> +        return -1;
> +    }
> +
> +    if (new_size == migrate_xbzrle_cache_size()) {
> +        /* nothing to do */
> +        return 0;
> +    }
> +
> +    XBZRLE_cache_lock();
> +
> +    if (XBZRLE.cache != NULL) {
> +        new_cache = cache_init(new_size, TARGET_PAGE_SIZE, errp);
> +        if (!new_cache) {
> +            ret = -1;
> +            goto out;
> +        }
> +
> +        cache_fini(XBZRLE.cache);
> +        XBZRLE.cache = new_cache;
> +    }
> +out:
> +    XBZRLE_cache_unlock();
> +    return ret;
> +}
> +
> +static bool ramblock_is_ignored(RAMBlock *block)
> +{
> +    return !qemu_ram_is_migratable(block) ||
> +           (migrate_ignore_shared() && qemu_ram_is_shared(block));
> +}
> +
> +/* Should be holding either ram_list.mutex, or the RCU lock. */
> +#define RAMBLOCK_FOREACH_NOT_IGNORED(block)            \
> +    INTERNAL_RAMBLOCK_FOREACH(block)                   \
> +        if (ramblock_is_ignored(block)) {} else
> +
> +#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
> +    INTERNAL_RAMBLOCK_FOREACH(block)                   \
> +        if (!qemu_ram_is_migratable(block)) {} else
> +
> +#undef RAMBLOCK_FOREACH
> +
> +int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque)
> +{
> +    RAMBlock *block;
> +    int ret = 0;
> +
> +    rcu_read_lock();
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +        ret = func(block, opaque);
> +        if (ret) {
> +            break;
> +        }
> +    }
> +    rcu_read_unlock();
> +    return ret;
> +}
> +
> +static void ramblock_recv_map_init(void)
> +{
> +    RAMBlock *rb;
> +
> +    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> +        assert(!rb->receivedmap);
> +        rb->receivedmap = bitmap_new(rb->max_length >> qemu_target_page_bits());
> +    }
> +}
> +
> +int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr)
> +{
> +    return test_bit(ramblock_recv_bitmap_offset(host_addr, rb),
> +                    rb->receivedmap);
> +}
> +
> +bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte_offset)
> +{
> +    return test_bit(byte_offset >> TARGET_PAGE_BITS, rb->receivedmap);
> +}
> +
> +void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr)
> +{
> +    set_bit_atomic(ramblock_recv_bitmap_offset(host_addr, rb), rb->receivedmap);
> +}
> +
> +void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr,
> +                                    size_t nr)
> +{
> +    bitmap_set_atomic(rb->receivedmap,
> +                      ramblock_recv_bitmap_offset(host_addr, rb),
> +                      nr);
> +}
> +
> +#define  RAMBLOCK_RECV_BITMAP_ENDING  (0x0123456789abcdefULL)
> +
> +/*
> + * Format: bitmap_size (8 bytes) + whole_bitmap (N bytes).
> + *
> + * Returns >0 if success with sent bytes, or <0 if error.
> + */
> +int64_t ramblock_recv_bitmap_send(QEMUFile *file,
> +                                  const char *block_name)
> +{
> +    RAMBlock *block = qemu_ram_block_by_name(block_name);
> +    unsigned long *le_bitmap, nbits;
> +    uint64_t size;
> +
> +    if (!block) {
> +        error_report("%s: invalid block name: %s", __func__, block_name);
> +        return -1;
> +    }
> +
> +    nbits = block->used_length >> TARGET_PAGE_BITS;
> +
> +    /*
> +     * Make sure the tmp bitmap buffer is big enough, e.g., on 32bit
> +     * machines we may need 4 more bytes for padding (see below
> +     * comment). So extend it a bit before hand.
> +     */
> +    le_bitmap = bitmap_new(nbits + BITS_PER_LONG);
> +
> +    /*
> +     * Always use little endian when sending the bitmap. This is
> +     * required that when source and destination VMs are not using the
> +     * same endianess. (Note: big endian won't work.)
> +     */
> +    bitmap_to_le(le_bitmap, block->receivedmap, nbits);
> +
> +    /* Size of the bitmap, in bytes */
> +    size = DIV_ROUND_UP(nbits, 8);
> +
> +    /*
> +     * size is always aligned to 8 bytes for 64bit machines, but it
> +     * may not be true for 32bit machines. We need this padding to
> +     * make sure the migration can survive even between 32bit and
> +     * 64bit machines.
> +     */
> +    size = ROUND_UP(size, 8);
> +
> +    qemu_put_be64(file, size);
> +    qemu_put_buffer(file, (const uint8_t *)le_bitmap, size);
> +    /*
> +     * Mark as an end, in case the middle part is screwed up due to
> +     * some "misterious" reason.
> +     */
> +    qemu_put_be64(file, RAMBLOCK_RECV_BITMAP_ENDING);
> +    qemu_fflush(file);
> +
> +    g_free(le_bitmap);
> +
> +    if (qemu_file_get_error(file)) {
> +        return qemu_file_get_error(file);
> +    }
> +
> +    return size + sizeof(size);
> +}
> +
> +/*
> + * An outstanding page request, on the source, having been received
> + * and queued
> + */
> +struct RAMSrcPageRequest {
> +    RAMBlock *rb;
> +    hwaddr    offset;
> +    hwaddr    len;
> +
> +    QSIMPLEQ_ENTRY(RAMSrcPageRequest) next_req;
> +};
> +
> +/* State of RAM for migration */
> +struct RAMState {
> +    /* QEMUFile used for this migration */
> +    QEMUFile *f;
> +    /* Last block that we have visited searching for dirty pages */
> +    RAMBlock *last_seen_block;
> +    /* Last block from where we have sent data */
> +    RAMBlock *last_sent_block;
> +    /* Last dirty target page we have sent */
> +    ram_addr_t last_page;
> +    /* last ram version we have seen */
> +    uint32_t last_version;
> +    /* We are in the first round */
> +    bool ram_bulk_stage;
> +    /* The free page optimization is enabled */
> +    bool fpo_enabled;
> +    /* How many times we have dirty too many pages */
> +    int dirty_rate_high_cnt;
> +    /* these variables are used for bitmap sync */
> +    /* last time we did a full bitmap_sync */
> +    int64_t time_last_bitmap_sync;
> +    /* bytes transferred at start_time */
> +    uint64_t bytes_xfer_prev;
> +    /* number of dirty pages since start_time */
> +    uint64_t num_dirty_pages_period;
> +    /* xbzrle misses since the beginning of the period */
> +    uint64_t xbzrle_cache_miss_prev;
> +
> +    /* compression statistics since the beginning of the period */
> +    /* amount of count that no free thread to compress data */
> +    uint64_t compress_thread_busy_prev;
> +    /* amount bytes after compression */
> +    uint64_t compressed_size_prev;
> +    /* amount of compressed pages */
> +    uint64_t compress_pages_prev;
> +
> +    /* total handled target pages at the beginning of period */
> +    uint64_t target_page_count_prev;
> +    /* total handled target pages since start */
> +    uint64_t target_page_count;
> +    /* number of dirty bits in the bitmap */
> +    uint64_t migration_dirty_pages;
> +    /* Protects modification of the bitmap and migration dirty pages */
> +    QemuMutex bitmap_mutex;
> +    /* The RAMBlock used in the last src_page_requests */
> +    RAMBlock *last_req_rb;
> +    /* Queue of outstanding page requests from the destination */
> +    QemuMutex src_page_req_mutex;
> +    QSIMPLEQ_HEAD(, RAMSrcPageRequest) src_page_requests;
> +};
> +typedef struct RAMState RAMState;
> +
> +static RAMState *ram_state;
> +
> +static NotifierWithReturnList precopy_notifier_list;
> +
> +void precopy_infrastructure_init(void)
> +{
> +    notifier_with_return_list_init(&precopy_notifier_list);
> +}
> +
> +void precopy_add_notifier(NotifierWithReturn *n)
> +{
> +    notifier_with_return_list_add(&precopy_notifier_list, n);
> +}
> +
> +void precopy_remove_notifier(NotifierWithReturn *n)
> +{
> +    notifier_with_return_remove(n);
> +}
> +
> +int precopy_notify(PrecopyNotifyReason reason, Error **errp)
> +{
> +    PrecopyNotifyData pnd;
> +    pnd.reason = reason;
> +    pnd.errp = errp;
> +
> +    return notifier_with_return_list_notify(&precopy_notifier_list, &pnd);
> +}
> +
> +void precopy_enable_free_page_optimization(void)
> +{
> +    if (!ram_state) {
> +        return;
> +    }
> +
> +    ram_state->fpo_enabled = true;
> +}
> +
> +uint64_t ram_bytes_remaining(void)
> +{
> +    return ram_state ? (ram_state->migration_dirty_pages * TARGET_PAGE_SIZE) :
> +                       0;
> +}
> +
> +MigrationStats ram_counters;
> +
> +/* used by the search for pages to send */
> +struct PageSearchStatus {
> +    /* Current block being searched */
> +    RAMBlock    *block;
> +    /* Current page to search from */
> +    unsigned long page;
> +    /* Set once we wrap around */
> +    bool         complete_round;
> +};
> +typedef struct PageSearchStatus PageSearchStatus;
> +
> +CompressionStats compression_counters;
> +
> +struct CompressParam {
> +    bool done;
> +    bool quit;
> +    bool zero_page;
> +    QEMUFile *file;
> +    QemuMutex mutex;
> +    QemuCond cond;
> +    RAMBlock *block;
> +    ram_addr_t offset;
> +
> +    /* internally used fields */
> +    z_stream stream;
> +    uint8_t *originbuf;
> +};
> +typedef struct CompressParam CompressParam;
> +
> +struct DecompressParam {
> +    bool done;
> +    bool quit;
> +    QemuMutex mutex;
> +    QemuCond cond;
> +    void *des;
> +    uint8_t *compbuf;
> +    int len;
> +    z_stream stream;
> +};
> +typedef struct DecompressParam DecompressParam;
> +
> +static CompressParam *comp_param;
> +static QemuThread *compress_threads;
> +/* comp_done_cond is used to wake up the migration thread when
> + * one of the compression threads has finished the compression.
> + * comp_done_lock is used to co-work with comp_done_cond.
> + */
> +static QemuMutex comp_done_lock;
> +static QemuCond comp_done_cond;
> +/* The empty QEMUFileOps will be used by file in CompressParam */
> +static const QEMUFileOps empty_ops = { };
> +
> +static QEMUFile *decomp_file;
> +static DecompressParam *decomp_param;
> +static QemuThread *decompress_threads;
> +static QemuMutex decomp_done_lock;
> +static QemuCond decomp_done_cond;
> +
> +static bool do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
> +                                 ram_addr_t offset, uint8_t *source_buf);
> +
> +static void *do_data_compress(void *opaque)
> +{
> +    CompressParam *param = opaque;
> +    RAMBlock *block;
> +    ram_addr_t offset;
> +    bool zero_page;
> +
> +    qemu_mutex_lock(&param->mutex);
> +    while (!param->quit) {
> +        if (param->block) {
> +            block = param->block;
> +            offset = param->offset;
> +            param->block = NULL;
> +            qemu_mutex_unlock(&param->mutex);
> +
> +            zero_page = do_compress_ram_page(param->file, &param->stream,
> +                                             block, offset, param->originbuf);
> +
> +            qemu_mutex_lock(&comp_done_lock);
> +            param->done = true;
> +            param->zero_page = zero_page;
> +            qemu_cond_signal(&comp_done_cond);
> +            qemu_mutex_unlock(&comp_done_lock);
> +
> +            qemu_mutex_lock(&param->mutex);
> +        } else {
> +            qemu_cond_wait(&param->cond, &param->mutex);
> +        }
> +    }
> +    qemu_mutex_unlock(&param->mutex);
> +
> +    return NULL;
> +}
> +
> +static void compress_threads_save_cleanup(void)
> +{
> +    int i, thread_count;
> +
> +    if (!migrate_use_compression() || !comp_param) {
> +        return;
> +    }
> +
> +    thread_count = migrate_compress_threads();
> +    for (i = 0; i < thread_count; i++) {
> +        /*
> +         * we use it as a indicator which shows if the thread is
> +         * properly init'd or not
> +         */
> +        if (!comp_param[i].file) {
> +            break;
> +        }
> +
> +        qemu_mutex_lock(&comp_param[i].mutex);
> +        comp_param[i].quit = true;
> +        qemu_cond_signal(&comp_param[i].cond);
> +        qemu_mutex_unlock(&comp_param[i].mutex);
> +
> +        qemu_thread_join(compress_threads + i);
> +        qemu_mutex_destroy(&comp_param[i].mutex);
> +        qemu_cond_destroy(&comp_param[i].cond);
> +        deflateEnd(&comp_param[i].stream);
> +        g_free(comp_param[i].originbuf);
> +        qemu_fclose(comp_param[i].file);
> +        comp_param[i].file = NULL;
> +    }
> +    qemu_mutex_destroy(&comp_done_lock);
> +    qemu_cond_destroy(&comp_done_cond);
> +    g_free(compress_threads);
> +    g_free(comp_param);
> +    compress_threads = NULL;
> +    comp_param = NULL;
> +}
> +
> +static int compress_threads_save_setup(void)
> +{
> +    int i, thread_count;
> +
> +    if (!migrate_use_compression()) {
> +        return 0;
> +    }
> +    thread_count = migrate_compress_threads();
> +    compress_threads = g_new0(QemuThread, thread_count);
> +    comp_param = g_new0(CompressParam, thread_count);
> +    qemu_cond_init(&comp_done_cond);
> +    qemu_mutex_init(&comp_done_lock);
> +    for (i = 0; i < thread_count; i++) {
> +        comp_param[i].originbuf = g_try_malloc(TARGET_PAGE_SIZE);
> +        if (!comp_param[i].originbuf) {
> +            goto exit;
> +        }
> +
> +        if (deflateInit(&comp_param[i].stream,
> +                        migrate_compress_level()) != Z_OK) {
> +            g_free(comp_param[i].originbuf);
> +            goto exit;
> +        }
> +
> +        /* comp_param[i].file is just used as a dummy buffer to save data,
> +         * set its ops to empty.
> +         */
> +        comp_param[i].file = qemu_fopen_ops(NULL, &empty_ops);
> +        comp_param[i].done = true;
> +        comp_param[i].quit = false;
> +        qemu_mutex_init(&comp_param[i].mutex);
> +        qemu_cond_init(&comp_param[i].cond);
> +        qemu_thread_create(compress_threads + i, "compress",
> +                           do_data_compress, comp_param + i,
> +                           QEMU_THREAD_JOINABLE);
> +    }
> +    return 0;
> +
> +exit:
> +    compress_threads_save_cleanup();
> +    return -1;
> +}
> +
> +/* Multiple fd's */
> +
> +#define MULTIFD_MAGIC 0x11223344U
> +#define MULTIFD_VERSION 1
> +
> +#define MULTIFD_FLAG_SYNC (1 << 0)
> +
> +/* This value needs to be a multiple of qemu_target_page_size() */
> +#define MULTIFD_PACKET_SIZE (512 * 1024)
> +
> +typedef struct {
> +    uint32_t magic;
> +    uint32_t version;
> +    unsigned char uuid[16]; /* QemuUUID */
> +    uint8_t id;
> +    uint8_t unused1[7];     /* Reserved for future use */
> +    uint64_t unused2[4];    /* Reserved for future use */
> +} __attribute__((packed)) MultiFDInit_t;
> +
> +typedef struct {
> +    uint32_t magic;
> +    uint32_t version;
> +    uint32_t flags;
> +    /* maximum number of allocated pages */
> +    uint32_t pages_alloc;
> +    uint32_t pages_used;
> +    /* size of the next packet that contains pages */
> +    uint32_t next_packet_size;
> +    uint64_t packet_num;
> +    uint64_t unused[4];    /* Reserved for future use */
> +    char ramblock[256];
> +    uint64_t offset[];
> +} __attribute__((packed)) MultiFDPacket_t;
> +
> +typedef struct {
> +    /* number of used pages */
> +    uint32_t used;
> +    /* number of allocated pages */
> +    uint32_t allocated;
> +    /* global number of generated multifd packets */
> +    uint64_t packet_num;
> +    /* offset of each page */
> +    ram_addr_t *offset;
> +    /* pointer to each page */
> +    struct iovec *iov;
> +    RAMBlock *block;
> +} MultiFDPages_t;
> +
> +typedef struct {
> +    /* this fields are not changed once the thread is created */
> +    /* channel number */
> +    uint8_t id;
> +    /* channel thread name */
> +    char *name;
> +    /* channel thread id */
> +    QemuThread thread;
> +    /* communication channel */
> +    QIOChannel *c;
> +    /* sem where to wait for more work */
> +    QemuSemaphore sem;
> +    /* this mutex protects the following parameters */
> +    QemuMutex mutex;
> +    /* is this channel thread running */
> +    bool running;
> +    /* should this thread finish */
> +    bool quit;
> +    /* thread has work to do */
> +    int pending_job;
> +    /* array of pages to sent */
> +    MultiFDPages_t *pages;
> +    /* packet allocated len */
> +    uint32_t packet_len;
> +    /* pointer to the packet */
> +    MultiFDPacket_t *packet;
> +    /* multifd flags for each packet */
> +    uint32_t flags;
> +    /* size of the next packet that contains pages */
> +    uint32_t next_packet_size;
> +    /* global number of generated multifd packets */
> +    uint64_t packet_num;
> +    /* thread local variables */
> +    /* packets sent through this channel */
> +    uint64_t num_packets;
> +    /* pages sent through this channel */
> +    uint64_t num_pages;
> +}  MultiFDSendParams;
> +
> +typedef struct {
> +    /* this fields are not changed once the thread is created */
> +    /* channel number */
> +    uint8_t id;
> +    /* channel thread name */
> +    char *name;
> +    /* channel thread id */
> +    QemuThread thread;
> +    /* communication channel */
> +    QIOChannel *c;
> +    /* this mutex protects the following parameters */
> +    QemuMutex mutex;
> +    /* is this channel thread running */
> +    bool running;
> +    /* array of pages to receive */
> +    MultiFDPages_t *pages;
> +    /* packet allocated len */
> +    uint32_t packet_len;
> +    /* pointer to the packet */
> +    MultiFDPacket_t *packet;
> +    /* multifd flags for each packet */
> +    uint32_t flags;
> +    /* global number of generated multifd packets */
> +    uint64_t packet_num;
> +    /* thread local variables */
> +    /* size of the next packet that contains pages */
> +    uint32_t next_packet_size;
> +    /* packets sent through this channel */
> +    uint64_t num_packets;
> +    /* pages sent through this channel */
> +    uint64_t num_pages;
> +    /* syncs main thread and channels */
> +    QemuSemaphore sem_sync;
> +} MultiFDRecvParams;
> +
> +static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
> +{
> +    MultiFDInit_t msg;
> +    int ret;
> +
> +    msg.magic = cpu_to_be32(MULTIFD_MAGIC);
> +    msg.version = cpu_to_be32(MULTIFD_VERSION);
> +    msg.id = p->id;
> +    memcpy(msg.uuid, &qemu_uuid.data, sizeof(msg.uuid));
> +
> +    ret = qio_channel_write_all(p->c, (char *)&msg, sizeof(msg), errp);
> +    if (ret != 0) {
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
> +{
> +    MultiFDInit_t msg;
> +    int ret;
> +
> +    ret = qio_channel_read_all(c, (char *)&msg, sizeof(msg), errp);
> +    if (ret != 0) {
> +        return -1;
> +    }
> +
> +    msg.magic = be32_to_cpu(msg.magic);
> +    msg.version = be32_to_cpu(msg.version);
> +
> +    if (msg.magic != MULTIFD_MAGIC) {
> +        error_setg(errp, "multifd: received packet magic %x "
> +                   "expected %x", msg.magic, MULTIFD_MAGIC);
> +        return -1;
> +    }
> +
> +    if (msg.version != MULTIFD_VERSION) {
> +        error_setg(errp, "multifd: received packet version %d "
> +                   "expected %d", msg.version, MULTIFD_VERSION);
> +        return -1;
> +    }
> +
> +    if (memcmp(msg.uuid, &qemu_uuid, sizeof(qemu_uuid))) {
> +        char *uuid = qemu_uuid_unparse_strdup(&qemu_uuid);
> +        char *msg_uuid = qemu_uuid_unparse_strdup((const QemuUUID *)msg.uuid);
> +
> +        error_setg(errp, "multifd: received uuid '%s' and expected "
> +                   "uuid '%s' for channel %hhd", msg_uuid, uuid, msg.id);
> +        g_free(uuid);
> +        g_free(msg_uuid);
> +        return -1;
> +    }
> +
> +    if (msg.id > migrate_multifd_channels()) {
> +        error_setg(errp, "multifd: received channel version %d "
> +                   "expected %d", msg.version, MULTIFD_VERSION);
> +        return -1;
> +    }
> +
> +    return msg.id;
> +}
> +
> +static MultiFDPages_t *multifd_pages_init(size_t size)
> +{
> +    MultiFDPages_t *pages = g_new0(MultiFDPages_t, 1);
> +
> +    pages->allocated = size;
> +    pages->iov = g_new0(struct iovec, size);
> +    pages->offset = g_new0(ram_addr_t, size);
> +
> +    return pages;
> +}
> +
> +static void multifd_pages_clear(MultiFDPages_t *pages)
> +{
> +    pages->used = 0;
> +    pages->allocated = 0;
> +    pages->packet_num = 0;
> +    pages->block = NULL;
> +    g_free(pages->iov);
> +    pages->iov = NULL;
> +    g_free(pages->offset);
> +    pages->offset = NULL;
> +    g_free(pages);
> +}
> +
> +static void multifd_send_fill_packet(MultiFDSendParams *p)
> +{
> +    MultiFDPacket_t *packet = p->packet;
> +    uint32_t page_max = MULTIFD_PACKET_SIZE / qemu_target_page_size();
> +    int i;
> +
> +    packet->magic = cpu_to_be32(MULTIFD_MAGIC);
> +    packet->version = cpu_to_be32(MULTIFD_VERSION);
> +    packet->flags = cpu_to_be32(p->flags);
> +    packet->pages_alloc = cpu_to_be32(page_max);
> +    packet->pages_used = cpu_to_be32(p->pages->used);
> +    packet->next_packet_size = cpu_to_be32(p->next_packet_size);
> +    packet->packet_num = cpu_to_be64(p->packet_num);
> +
> +    if (p->pages->block) {
> +        strncpy(packet->ramblock, p->pages->block->idstr, 256);
> +    }
> +
> +    for (i = 0; i < p->pages->used; i++) {
> +        packet->offset[i] = cpu_to_be64(p->pages->offset[i]);
> +    }
> +}
> +
> +static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
> +{
> +    MultiFDPacket_t *packet = p->packet;
> +    uint32_t pages_max = MULTIFD_PACKET_SIZE / qemu_target_page_size();
> +    RAMBlock *block;
> +    int i;
> +
> +    packet->magic = be32_to_cpu(packet->magic);
> +    if (packet->magic != MULTIFD_MAGIC) {
> +        error_setg(errp, "multifd: received packet "
> +                   "magic %x and expected magic %x",
> +                   packet->magic, MULTIFD_MAGIC);
> +        return -1;
> +    }
> +
> +    packet->version = be32_to_cpu(packet->version);
> +    if (packet->version != MULTIFD_VERSION) {
> +        error_setg(errp, "multifd: received packet "
> +                   "version %d and expected version %d",
> +                   packet->version, MULTIFD_VERSION);
> +        return -1;
> +    }
> +
> +    p->flags = be32_to_cpu(packet->flags);
> +
> +    packet->pages_alloc = be32_to_cpu(packet->pages_alloc);
> +    /*
> +     * If we recevied a packet that is 100 times bigger than expected
> +     * just stop migration.  It is a magic number.
> +     */
> +    if (packet->pages_alloc > pages_max * 100) {
> +        error_setg(errp, "multifd: received packet "
> +                   "with size %d and expected a maximum size of %d",
> +                   packet->pages_alloc, pages_max * 100) ;
> +        return -1;
> +    }
> +    /*
> +     * We received a packet that is bigger than expected but inside
> +     * reasonable limits (see previous comment).  Just reallocate.
> +     */
> +    if (packet->pages_alloc > p->pages->allocated) {
> +        multifd_pages_clear(p->pages);
> +        p->pages = multifd_pages_init(packet->pages_alloc);
> +    }
> +
> +    p->pages->used = be32_to_cpu(packet->pages_used);
> +    if (p->pages->used > packet->pages_alloc) {
> +        error_setg(errp, "multifd: received packet "
> +                   "with %d pages and expected maximum pages are %d",
> +                   p->pages->used, packet->pages_alloc) ;
> +        return -1;
> +    }
> +
> +    p->next_packet_size = be32_to_cpu(packet->next_packet_size);
> +    p->packet_num = be64_to_cpu(packet->packet_num);
> +
> +    if (p->pages->used) {
> +        /* make sure that ramblock is 0 terminated */
> +        packet->ramblock[255] = 0;
> +        block = qemu_ram_block_by_name(packet->ramblock);
> +        if (!block) {
> +            error_setg(errp, "multifd: unknown ram block %s",
> +                       packet->ramblock);
> +            return -1;
> +        }
> +    }
> +
> +    for (i = 0; i < p->pages->used; i++) {
> +        ram_addr_t offset = be64_to_cpu(packet->offset[i]);
> +
> +        if (offset > (block->used_length - TARGET_PAGE_SIZE)) {
> +            error_setg(errp, "multifd: offset too long " RAM_ADDR_FMT
> +                       " (max " RAM_ADDR_FMT ")",
> +                       offset, block->max_length);
> +            return -1;
> +        }
> +        p->pages->iov[i].iov_base = block->host + offset;
> +        p->pages->iov[i].iov_len = TARGET_PAGE_SIZE;
> +    }
> +
> +    return 0;
> +}
> +
> +struct {
> +    MultiFDSendParams *params;
> +    /* array of pages to sent */
> +    MultiFDPages_t *pages;
> +    /* syncs main thread and channels */
> +    QemuSemaphore sem_sync;
> +    /* global number of generated multifd packets */
> +    uint64_t packet_num;
> +    /* send channels ready */
> +    QemuSemaphore channels_ready;
> +} *multifd_send_state;
> +
> +/*
> + * How we use multifd_send_state->pages and channel->pages?
> + *
> + * We create a pages for each channel, and a main one.  Each time that
> + * we need to send a batch of pages we interchange the ones between
> + * multifd_send_state and the channel that is sending it.  There are
> + * two reasons for that:
> + *    - to not have to do so many mallocs during migration
> + *    - to make easier to know what to free at the end of migration
> + *
> + * This way we always know who is the owner of each "pages" struct,
> + * and we don't need any locking.  It belongs to the migration thread
> + * or to the channel thread.  Switching is safe because the migration
> + * thread is using the channel mutex when changing it, and the channel
> + * have to had finish with its own, otherwise pending_job can't be
> + * false.
> + */
> +
> +static void multifd_send_pages(void)
> +{
> +    int i;
> +    static int next_channel;
> +    MultiFDSendParams *p = NULL; /* make happy gcc */
> +    MultiFDPages_t *pages = multifd_send_state->pages;
> +    uint64_t transferred;
> +
> +    qemu_sem_wait(&multifd_send_state->channels_ready);
> +    for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
> +        p = &multifd_send_state->params[i];
> +
> +        qemu_mutex_lock(&p->mutex);
> +        if (!p->pending_job) {
> +            p->pending_job++;
> +            next_channel = (i + 1) % migrate_multifd_channels();
> +            break;
> +        }
> +        qemu_mutex_unlock(&p->mutex);
> +    }
> +    p->pages->used = 0;
> +
> +    p->packet_num = multifd_send_state->packet_num++;
> +    p->pages->block = NULL;
> +    multifd_send_state->pages = p->pages;
> +    p->pages = pages;
> +    transferred = ((uint64_t) pages->used) * TARGET_PAGE_SIZE + p->packet_len;
> +    ram_counters.multifd_bytes += transferred;
> +    ram_counters.transferred += transferred;;
> +    qemu_mutex_unlock(&p->mutex);
> +    qemu_sem_post(&p->sem);
> +}
> +
> +static void multifd_queue_page(RAMBlock *block, ram_addr_t offset)
> +{
> +    MultiFDPages_t *pages = multifd_send_state->pages;
> +
> +    if (!pages->block) {
> +        pages->block = block;
> +    }
> +
> +    if (pages->block == block) {
> +        pages->offset[pages->used] = offset;
> +        pages->iov[pages->used].iov_base = block->host + offset;
> +        pages->iov[pages->used].iov_len = TARGET_PAGE_SIZE;
> +        pages->used++;
> +
> +        if (pages->used < pages->allocated) {
> +            return;
> +        }
> +    }
> +
> +    multifd_send_pages();
> +
> +    if (pages->block != block) {
> +        multifd_queue_page(block, offset);
> +    }
> +}
> +
> +static void multifd_send_terminate_threads(Error *err)
> +{
> +    int i;
> +
> +    if (err) {
> +        MigrationState *s = migrate_get_current();
> +        migrate_set_error(s, err);
> +        if (s->state == MIGRATION_STATUS_SETUP ||
> +            s->state == MIGRATION_STATUS_PRE_SWITCHOVER ||
> +            s->state == MIGRATION_STATUS_DEVICE ||
> +            s->state == MIGRATION_STATUS_ACTIVE) {
> +            migrate_set_state(&s->state, s->state,
> +                              MIGRATION_STATUS_FAILED);
> +        }
> +    }
> +
> +    for (i = 0; i < migrate_multifd_channels(); i++) {
> +        MultiFDSendParams *p = &multifd_send_state->params[i];
> +
> +        qemu_mutex_lock(&p->mutex);
> +        p->quit = true;
> +        qemu_sem_post(&p->sem);
> +        qemu_mutex_unlock(&p->mutex);
> +    }
> +}
> +
> +void multifd_save_cleanup(void)
> +{
> +    int i;
> +
> +    if (!migrate_use_multifd()) {
> +        return;
> +    }
> +    multifd_send_terminate_threads(NULL);
> +    for (i = 0; i < migrate_multifd_channels(); i++) {
> +        MultiFDSendParams *p = &multifd_send_state->params[i];
> +
> +        if (p->running) {
> +            qemu_thread_join(&p->thread);
> +        }
> +        socket_send_channel_destroy(p->c);
> +        p->c = NULL;
> +        qemu_mutex_destroy(&p->mutex);
> +        qemu_sem_destroy(&p->sem);
> +        g_free(p->name);
> +        p->name = NULL;
> +        multifd_pages_clear(p->pages);
> +        p->pages = NULL;
> +        p->packet_len = 0;
> +        g_free(p->packet);
> +        p->packet = NULL;
> +    }
> +    qemu_sem_destroy(&multifd_send_state->channels_ready);
> +    qemu_sem_destroy(&multifd_send_state->sem_sync);
> +    g_free(multifd_send_state->params);
> +    multifd_send_state->params = NULL;
> +    multifd_pages_clear(multifd_send_state->pages);
> +    multifd_send_state->pages = NULL;
> +    g_free(multifd_send_state);
> +    multifd_send_state = NULL;
> +}
> +
> +static void multifd_send_sync_main(void)
> +{
> +    int i;
> +
> +    if (!migrate_use_multifd()) {
> +        return;
> +    }
> +    if (multifd_send_state->pages->used) {
> +        multifd_send_pages();
> +    }
> +    for (i = 0; i < migrate_multifd_channels(); i++) {
> +        MultiFDSendParams *p = &multifd_send_state->params[i];
> +
> +        trace_multifd_send_sync_main_signal(p->id);
> +
> +        qemu_mutex_lock(&p->mutex);
> +
> +        p->packet_num = multifd_send_state->packet_num++;
> +        p->flags |= MULTIFD_FLAG_SYNC;
> +        p->pending_job++;
> +        qemu_mutex_unlock(&p->mutex);
> +        qemu_sem_post(&p->sem);
> +    }
> +    for (i = 0; i < migrate_multifd_channels(); i++) {
> +        MultiFDSendParams *p = &multifd_send_state->params[i];
> +
> +        trace_multifd_send_sync_main_wait(p->id);
> +        qemu_sem_wait(&multifd_send_state->sem_sync);
> +    }
> +    trace_multifd_send_sync_main(multifd_send_state->packet_num);
> +}
> +
> +static void *multifd_send_thread(void *opaque)
> +{
> +    MultiFDSendParams *p = opaque;
> +    Error *local_err = NULL;
> +    int ret;
> +
> +    trace_multifd_send_thread_start(p->id);
> +    rcu_register_thread();
> +
> +    if (multifd_send_initial_packet(p, &local_err) < 0) {
> +        goto out;
> +    }
> +    /* initial packet */
> +    p->num_packets = 1;
> +
> +    while (true) {
> +        qemu_sem_wait(&p->sem);
> +        qemu_mutex_lock(&p->mutex);
> +
> +        if (p->pending_job) {
> +            uint32_t used = p->pages->used;
> +            uint64_t packet_num = p->packet_num;
> +            uint32_t flags = p->flags;
> +
> +            p->next_packet_size = used * qemu_target_page_size();
> +            multifd_send_fill_packet(p);
> +            p->flags = 0;
> +            p->num_packets++;
> +            p->num_pages += used;
> +            p->pages->used = 0;
> +            qemu_mutex_unlock(&p->mutex);
> +
> +            trace_multifd_send(p->id, packet_num, used, flags,
> +                               p->next_packet_size);
> +
> +            ret = qio_channel_write_all(p->c, (void *)p->packet,
> +                                        p->packet_len, &local_err);
> +            if (ret != 0) {
> +                break;
> +            }
> +
> +            if (used) {
> +                ret = qio_channel_writev_all(p->c, p->pages->iov,
> +                                             used, &local_err);
> +                if (ret != 0) {
> +                    break;
> +                }
> +            }
> +
> +            qemu_mutex_lock(&p->mutex);
> +            p->pending_job--;
> +            qemu_mutex_unlock(&p->mutex);
> +
> +            if (flags & MULTIFD_FLAG_SYNC) {
> +                qemu_sem_post(&multifd_send_state->sem_sync);
> +            }
> +            qemu_sem_post(&multifd_send_state->channels_ready);
> +        } else if (p->quit) {
> +            qemu_mutex_unlock(&p->mutex);
> +            break;
> +        } else {
> +            qemu_mutex_unlock(&p->mutex);
> +            /* sometimes there are spurious wakeups */
> +        }
> +    }
> +
> +out:
> +    if (local_err) {
> +        multifd_send_terminate_threads(local_err);
> +    }
> +
> +    qemu_mutex_lock(&p->mutex);
> +    p->running = false;
> +    qemu_mutex_unlock(&p->mutex);
> +
> +    rcu_unregister_thread();
> +    trace_multifd_send_thread_end(p->id, p->num_packets, p->num_pages);
> +
> +    return NULL;
> +}
> +
> +static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
> +{
> +    MultiFDSendParams *p = opaque;
> +    QIOChannel *sioc = QIO_CHANNEL(qio_task_get_source(task));
> +    Error *local_err = NULL;
> +
> +    if (qio_task_propagate_error(task, &local_err)) {
> +        migrate_set_error(migrate_get_current(), local_err);
> +        multifd_save_cleanup();
> +    } else {
> +        p->c = QIO_CHANNEL(sioc);
> +        qio_channel_set_delay(p->c, false);
> +        p->running = true;
> +        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
> +                           QEMU_THREAD_JOINABLE);
> +    }
> +}
> +
> +int multifd_save_setup(void)
> +{
> +    int thread_count;
> +    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
> +    uint8_t i;
> +
> +    if (!migrate_use_multifd()) {
> +        return 0;
> +    }
> +    thread_count = migrate_multifd_channels();
> +    multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
> +    multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
> +    multifd_send_state->pages = multifd_pages_init(page_count);
> +    qemu_sem_init(&multifd_send_state->sem_sync, 0);
> +    qemu_sem_init(&multifd_send_state->channels_ready, 0);
> +
> +    for (i = 0; i < thread_count; i++) {
> +        MultiFDSendParams *p = &multifd_send_state->params[i];
> +
> +        qemu_mutex_init(&p->mutex);
> +        qemu_sem_init(&p->sem, 0);
> +        p->quit = false;
> +        p->pending_job = 0;
> +        p->id = i;
> +        p->pages = multifd_pages_init(page_count);
> +        p->packet_len = sizeof(MultiFDPacket_t)
> +                      + sizeof(ram_addr_t) * page_count;
> +        p->packet = g_malloc0(p->packet_len);
> +        p->name = g_strdup_printf("multifdsend_%d", i);
> +        socket_send_channel_create(multifd_new_send_channel_async, p);
> +    }
> +    return 0;
> +}
> +
> +struct {
> +    MultiFDRecvParams *params;
> +    /* number of created threads */
> +    int count;
> +    /* syncs main thread and channels */
> +    QemuSemaphore sem_sync;
> +    /* global number of generated multifd packets */
> +    uint64_t packet_num;
> +} *multifd_recv_state;
> +
> +static void multifd_recv_terminate_threads(Error *err)
> +{
> +    int i;
> +
> +    if (err) {
> +        MigrationState *s = migrate_get_current();
> +        migrate_set_error(s, err);
> +        if (s->state == MIGRATION_STATUS_SETUP ||
> +            s->state == MIGRATION_STATUS_ACTIVE) {
> +            migrate_set_state(&s->state, s->state,
> +                              MIGRATION_STATUS_FAILED);
> +        }
> +    }
> +
> +    for (i = 0; i < migrate_multifd_channels(); i++) {
> +        MultiFDRecvParams *p = &multifd_recv_state->params[i];
> +
> +        qemu_mutex_lock(&p->mutex);
> +        /* We could arrive here for two reasons:
> +           - normal quit, i.e. everything went fine, just finished
> +           - error quit: We close the channels so the channel threads
> +             finish the qio_channel_read_all_eof() */
> +        qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
> +        qemu_mutex_unlock(&p->mutex);
> +    }
> +}
> +
> +int multifd_load_cleanup(Error **errp)
> +{
> +    int i;
> +    int ret = 0;
> +
> +    if (!migrate_use_multifd()) {
> +        return 0;
> +    }
> +    multifd_recv_terminate_threads(NULL);
> +    for (i = 0; i < migrate_multifd_channels(); i++) {
> +        MultiFDRecvParams *p = &multifd_recv_state->params[i];
> +
> +        if (p->running) {
> +            qemu_thread_join(&p->thread);
> +        }
> +        object_unref(OBJECT(p->c));
> +        p->c = NULL;
> +        qemu_mutex_destroy(&p->mutex);
> +        qemu_sem_destroy(&p->sem_sync);
> +        g_free(p->name);
> +        p->name = NULL;
> +        multifd_pages_clear(p->pages);
> +        p->pages = NULL;
> +        p->packet_len = 0;
> +        g_free(p->packet);
> +        p->packet = NULL;
> +    }
> +    qemu_sem_destroy(&multifd_recv_state->sem_sync);
> +    g_free(multifd_recv_state->params);
> +    multifd_recv_state->params = NULL;
> +    g_free(multifd_recv_state);
> +    multifd_recv_state = NULL;
> +
> +    return ret;
> +}
> +
> +static void multifd_recv_sync_main(void)
> +{
> +    int i;
> +
> +    if (!migrate_use_multifd()) {
> +        return;
> +    }
> +    for (i = 0; i < migrate_multifd_channels(); i++) {
> +        MultiFDRecvParams *p = &multifd_recv_state->params[i];
> +
> +        trace_multifd_recv_sync_main_wait(p->id);
> +        qemu_sem_wait(&multifd_recv_state->sem_sync);
> +    }
> +    for (i = 0; i < migrate_multifd_channels(); i++) {
> +        MultiFDRecvParams *p = &multifd_recv_state->params[i];
> +
> +        qemu_mutex_lock(&p->mutex);
> +        if (multifd_recv_state->packet_num < p->packet_num) {
> +            multifd_recv_state->packet_num = p->packet_num;
> +        }
> +        qemu_mutex_unlock(&p->mutex);
> +        trace_multifd_recv_sync_main_signal(p->id);
> +        qemu_sem_post(&p->sem_sync);
> +    }
> +    trace_multifd_recv_sync_main(multifd_recv_state->packet_num);
> +}
> +
> +static void *multifd_recv_thread(void *opaque)
> +{
> +    MultiFDRecvParams *p = opaque;
> +    Error *local_err = NULL;
> +    int ret;
> +
> +    trace_multifd_recv_thread_start(p->id);
> +    rcu_register_thread();
> +
> +    while (true) {
> +        uint32_t used;
> +        uint32_t flags;
> +
> +        ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
> +                                       p->packet_len, &local_err);
> +        if (ret == 0) {   /* EOF */
> +            break;
> +        }
> +        if (ret == -1) {   /* Error */
> +            break;
> +        }
> +
> +        qemu_mutex_lock(&p->mutex);
> +        ret = multifd_recv_unfill_packet(p, &local_err);
> +        if (ret) {
> +            qemu_mutex_unlock(&p->mutex);
> +            break;
> +        }
> +
> +        used = p->pages->used;
> +        flags = p->flags;
> +        trace_multifd_recv(p->id, p->packet_num, used, flags,
> +                           p->next_packet_size);
> +        p->num_packets++;
> +        p->num_pages += used;
> +        qemu_mutex_unlock(&p->mutex);
> +
> +        if (used) {
> +            ret = qio_channel_readv_all(p->c, p->pages->iov,
> +                                        used, &local_err);
> +            if (ret != 0) {
> +                break;
> +            }
> +        }
> +
> +        if (flags & MULTIFD_FLAG_SYNC) {
> +            qemu_sem_post(&multifd_recv_state->sem_sync);
> +            qemu_sem_wait(&p->sem_sync);
> +        }
> +    }
> +
> +    if (local_err) {
> +        multifd_recv_terminate_threads(local_err);
> +    }
> +    qemu_mutex_lock(&p->mutex);
> +    p->running = false;
> +    qemu_mutex_unlock(&p->mutex);
> +
> +    rcu_unregister_thread();
> +    trace_multifd_recv_thread_end(p->id, p->num_packets, p->num_pages);
> +
> +    return NULL;
> +}
> +
> +int multifd_load_setup(void)
> +{
> +    int thread_count;
> +    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
> +    uint8_t i;
> +
> +    if (!migrate_use_multifd()) {
> +        return 0;
> +    }
> +    thread_count = migrate_multifd_channels();
> +    multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
> +    multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
> +    atomic_set(&multifd_recv_state->count, 0);
> +    qemu_sem_init(&multifd_recv_state->sem_sync, 0);
> +
> +    for (i = 0; i < thread_count; i++) {
> +        MultiFDRecvParams *p = &multifd_recv_state->params[i];
> +
> +        qemu_mutex_init(&p->mutex);
> +        qemu_sem_init(&p->sem_sync, 0);
> +        p->id = i;
> +        p->pages = multifd_pages_init(page_count);
> +        p->packet_len = sizeof(MultiFDPacket_t)
> +                      + sizeof(ram_addr_t) * page_count;
> +        p->packet = g_malloc0(p->packet_len);
> +        p->name = g_strdup_printf("multifdrecv_%d", i);
> +    }
> +    return 0;
> +}
> +
> +bool multifd_recv_all_channels_created(void)
> +{
> +    int thread_count = migrate_multifd_channels();
> +
> +    if (!migrate_use_multifd()) {
> +        return true;
> +    }
> +
> +    return thread_count == atomic_read(&multifd_recv_state->count);
> +}
> +
> +/*
> + * Try to receive all multifd channels to get ready for the migration.
> + * - Return true and do not set @errp when correctly receving all channels;
> + * - Return false and do not set @errp when correctly receiving the current one;
> + * - Return false and set @errp when failing to receive the current channel.
> + */
> +bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
> +{
> +    MultiFDRecvParams *p;
> +    Error *local_err = NULL;
> +    int id;
> +
> +    id = multifd_recv_initial_packet(ioc, &local_err);
> +    if (id < 0) {
> +        multifd_recv_terminate_threads(local_err);
> +        error_propagate_prepend(errp, local_err,
> +                                "failed to receive packet"
> +                                " via multifd channel %d: ",
> +                                atomic_read(&multifd_recv_state->count));
> +        return false;
> +    }
> +
> +    p = &multifd_recv_state->params[id];
> +    if (p->c != NULL) {
> +        error_setg(&local_err, "multifd: received id '%d' already setup'",
> +                   id);
> +        multifd_recv_terminate_threads(local_err);
> +        error_propagate(errp, local_err);
> +        return false;
> +    }
> +    p->c = ioc;
> +    object_ref(OBJECT(ioc));
> +    /* initial packet */
> +    p->num_packets = 1;
> +
> +    p->running = true;
> +    qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
> +                       QEMU_THREAD_JOINABLE);
> +    atomic_inc(&multifd_recv_state->count);
> +    return atomic_read(&multifd_recv_state->count) ==
> +           migrate_multifd_channels();
> +}
> +
> +/**
> + * save_page_header: write page header to wire
> + *
> + * If this is the 1st block, it also writes the block identification
> + *
> + * Returns the number of bytes written
> + *
> + * @f: QEMUFile where to send the data
> + * @block: block that contains the page we want to send
> + * @offset: offset inside the block for the page
> + *          in the lower bits, it contains flags
> + */
> +static size_t save_page_header(RAMState *rs, QEMUFile *f,  RAMBlock *block,
> +                               ram_addr_t offset)
> +{
> +    size_t size, len;
> +
> +    if (block == rs->last_sent_block) {
> +        offset |= RAM_SAVE_FLAG_CONTINUE;
> +    }
> +    qemu_put_be64(f, offset);
> +    size = 8;
> +
> +    if (!(offset & RAM_SAVE_FLAG_CONTINUE)) {
> +        len = strlen(block->idstr);
> +        qemu_put_byte(f, len);
> +        qemu_put_buffer(f, (uint8_t *)block->idstr, len);
> +        size += 1 + len;
> +        rs->last_sent_block = block;
> +    }
> +    return size;
> +}
> +
> +/**
> + * mig_throttle_guest_down: throotle down the guest
> + *
> + * Reduce amount of guest cpu execution to hopefully slow down memory
> + * writes. If guest dirty memory rate is reduced below the rate at
> + * which we can transfer pages to the destination then we should be
> + * able to complete migration. Some workloads dirty memory way too
> + * fast and will not effectively converge, even with auto-converge.
> + */
> +static void mig_throttle_guest_down(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +    uint64_t pct_initial = s->parameters.cpu_throttle_initial;
> +    uint64_t pct_icrement = s->parameters.cpu_throttle_increment;
> +    int pct_max = s->parameters.max_cpu_throttle;
> +
> +    /* We have not started throttling yet. Let's start it. */
> +    if (!cpu_throttle_active()) {
> +        cpu_throttle_set(pct_initial);
> +    } else {
> +        /* Throttling already on, just increase the rate */
> +        cpu_throttle_set(MIN(cpu_throttle_get_percentage() + pct_icrement,
> +                         pct_max));
> +    }
> +}
> +
> +/**
> + * xbzrle_cache_zero_page: insert a zero page in the XBZRLE cache
> + *
> + * @rs: current RAM state
> + * @current_addr: address for the zero page
> + *
> + * Update the xbzrle cache to reflect a page that's been sent as all 0.
> + * The important thing is that a stale (not-yet-0'd) page be replaced
> + * by the new data.
> + * As a bonus, if the page wasn't in the cache it gets added so that
> + * when a small write is made into the 0'd page it gets XBZRLE sent.
> + */
> +static void xbzrle_cache_zero_page(RAMState *rs, ram_addr_t current_addr)
> +{
> +    if (rs->ram_bulk_stage || !migrate_use_xbzrle()) {
> +        return;
> +    }
> +
> +    /* We don't care if this fails to allocate a new cache page
> +     * as long as it updated an old one */
> +    cache_insert(XBZRLE.cache, current_addr, XBZRLE.zero_target_page,
> +                 ram_counters.dirty_sync_count);
> +}
> +
> +#define ENCODING_FLAG_XBZRLE 0x1
> +
> +/**
> + * save_xbzrle_page: compress and send current page
> + *
> + * Returns: 1 means that we wrote the page
> + *          0 means that page is identical to the one already sent
> + *          -1 means that xbzrle would be longer than normal
> + *
> + * @rs: current RAM state
> + * @current_data: pointer to the address of the page contents
> + * @current_addr: addr of the page
> + * @block: block that contains the page we want to send
> + * @offset: offset inside the block for the page
> + * @last_stage: if we are at the completion stage
> + */
> +static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
> +                            ram_addr_t current_addr, RAMBlock *block,
> +                            ram_addr_t offset, bool last_stage)
> +{
> +    int encoded_len = 0, bytes_xbzrle;
> +    uint8_t *prev_cached_page;
> +
> +    if (!cache_is_cached(XBZRLE.cache, current_addr,
> +                         ram_counters.dirty_sync_count)) {
> +        xbzrle_counters.cache_miss++;
> +        if (!last_stage) {
> +            if (cache_insert(XBZRLE.cache, current_addr, *current_data,
> +                             ram_counters.dirty_sync_count) == -1) {
> +                return -1;
> +            } else {
> +                /* update *current_data when the page has been
> +                   inserted into cache */
> +                *current_data = get_cached_data(XBZRLE.cache, current_addr);
> +            }
> +        }
> +        return -1;
> +    }
> +
> +    prev_cached_page = get_cached_data(XBZRLE.cache, current_addr);
> +
> +    /* save current buffer into memory */
> +    memcpy(XBZRLE.current_buf, *current_data, TARGET_PAGE_SIZE);
> +
> +    /* XBZRLE encoding (if there is no overflow) */
> +    encoded_len = xbzrle_encode_buffer(prev_cached_page, XBZRLE.current_buf,
> +                                       TARGET_PAGE_SIZE, XBZRLE.encoded_buf,
> +                                       TARGET_PAGE_SIZE);
> +
> +    /*
> +     * Update the cache contents, so that it corresponds to the data
> +     * sent, in all cases except where we skip the page.
> +     */
> +    if (!last_stage && encoded_len != 0) {
> +        memcpy(prev_cached_page, XBZRLE.current_buf, TARGET_PAGE_SIZE);
> +        /*
> +         * In the case where we couldn't compress, ensure that the caller
> +         * sends the data from the cache, since the guest might have
> +         * changed the RAM since we copied it.
> +         */
> +        *current_data = prev_cached_page;
> +    }
> +
> +    if (encoded_len == 0) {
> +        trace_save_xbzrle_page_skipping();
> +        return 0;
> +    } else if (encoded_len == -1) {
> +        trace_save_xbzrle_page_overflow();
> +        xbzrle_counters.overflow++;
> +        return -1;
> +    }
> +
> +    /* Send XBZRLE based compressed page */
> +    bytes_xbzrle = save_page_header(rs, rs->f, block,
> +                                    offset | RAM_SAVE_FLAG_XBZRLE);
> +    qemu_put_byte(rs->f, ENCODING_FLAG_XBZRLE);
> +    qemu_put_be16(rs->f, encoded_len);
> +    qemu_put_buffer(rs->f, XBZRLE.encoded_buf, encoded_len);
> +    bytes_xbzrle += encoded_len + 1 + 2;
> +    xbzrle_counters.pages++;
> +    xbzrle_counters.bytes += bytes_xbzrle;
> +    ram_counters.transferred += bytes_xbzrle;
> +
> +    return 1;
> +}
> +
> +/**
> + * migration_bitmap_find_dirty: find the next dirty page from start
> + *
> + * Returns the page offset within memory region of the start of a dirty page
> + *
> + * @rs: current RAM state
> + * @rb: RAMBlock where to search for dirty pages
> + * @start: page where we start the search
> + */
> +static inline
> +unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
> +                                          unsigned long start)
> +{
> +    unsigned long size = rb->used_length >> TARGET_PAGE_BITS;
> +    unsigned long *bitmap = rb->bmap;
> +    unsigned long next;
> +
> +    if (ramblock_is_ignored(rb)) {
> +        return size;
> +    }
> +
> +    /*
> +     * When the free page optimization is enabled, we need to check the bitmap
> +     * to send the non-free pages rather than all the pages in the bulk stage.
> +     */
> +    if (!rs->fpo_enabled && rs->ram_bulk_stage && start > 0) {
> +        next = start + 1;
> +    } else {
> +        next = find_next_bit(bitmap, size, start);
> +    }
> +
> +    return next;
> +}
> +
> +static inline bool migration_bitmap_clear_dirty(RAMState *rs,
> +                                                RAMBlock *rb,
> +                                                unsigned long page)
> +{
> +    bool ret;
> +
> +    qemu_mutex_lock(&rs->bitmap_mutex);
> +    ret = test_and_clear_bit(page, rb->bmap);
> +
> +    if (ret) {
> +        rs->migration_dirty_pages--;
> +    }
> +    qemu_mutex_unlock(&rs->bitmap_mutex);
> +
> +    return ret;
> +}
> +
> +/* Called with RCU critical section */
> +static void migration_bitmap_sync_range(RAMState *rs, RAMBlock *rb,
> +                                        ram_addr_t length)
> +{
> +    rs->migration_dirty_pages +=
> +        cpu_physical_memory_sync_dirty_bitmap(rb, 0, length,
> +                                              &rs->num_dirty_pages_period);
> +}
> +
> +/**
> + * ram_pagesize_summary: calculate all the pagesizes of a VM
> + *
> + * Returns a summary bitmap of the page sizes of all RAMBlocks
> + *
> + * For VMs with just normal pages this is equivalent to the host page
> + * size. If it's got some huge pages then it's the OR of all the
> + * different page sizes.
> + */
> +uint64_t ram_pagesize_summary(void)
> +{
> +    RAMBlock *block;
> +    uint64_t summary = 0;
> +
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +        summary |= block->page_size;
> +    }
> +
> +    return summary;
> +}
> +
> +uint64_t ram_get_total_transferred_pages(void)
> +{
> +    return  ram_counters.normal + ram_counters.duplicate +
> +                compression_counters.pages + xbzrle_counters.pages;
> +}
> +
> +static void migration_update_rates(RAMState *rs, int64_t end_time)
> +{
> +    uint64_t page_count = rs->target_page_count - rs->target_page_count_prev;
> +    double compressed_size;
> +
> +    /* calculate period counters */
> +    ram_counters.dirty_pages_rate = rs->num_dirty_pages_period * 1000
> +                / (end_time - rs->time_last_bitmap_sync);
> +
> +    if (!page_count) {
> +        return;
> +    }
> +
> +    if (migrate_use_xbzrle()) {
> +        xbzrle_counters.cache_miss_rate = (double)(xbzrle_counters.cache_miss -
> +            rs->xbzrle_cache_miss_prev) / page_count;
> +        rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
> +    }
> +
> +    if (migrate_use_compression()) {
> +        compression_counters.busy_rate = (double)(compression_counters.busy -
> +            rs->compress_thread_busy_prev) / page_count;
> +        rs->compress_thread_busy_prev = compression_counters.busy;
> +
> +        compressed_size = compression_counters.compressed_size -
> +                          rs->compressed_size_prev;
> +        if (compressed_size) {
> +            double uncompressed_size = (compression_counters.pages -
> +                                    rs->compress_pages_prev) * TARGET_PAGE_SIZE;
> +
> +            /* Compression-Ratio = Uncompressed-size / Compressed-size */
> +            compression_counters.compression_rate =
> +                                        uncompressed_size / compressed_size;
> +
> +            rs->compress_pages_prev = compression_counters.pages;
> +            rs->compressed_size_prev = compression_counters.compressed_size;
> +        }
> +    }
> +}
> +
> +static void migration_bitmap_sync(RAMState *rs)
> +{
> +    RAMBlock *block;
> +    int64_t end_time;
> +    uint64_t bytes_xfer_now;
> +
> +    ram_counters.dirty_sync_count++;
> +
> +    if (!rs->time_last_bitmap_sync) {
> +        rs->time_last_bitmap_sync = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    }
> +
> +    trace_migration_bitmap_sync_start();
> +    memory_global_dirty_log_sync();
> +
> +    qemu_mutex_lock(&rs->bitmap_mutex);
> +    rcu_read_lock();
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +        migration_bitmap_sync_range(rs, block, block->used_length);
> +    }
> +    ram_counters.remaining = ram_bytes_remaining();
> +    rcu_read_unlock();
> +    qemu_mutex_unlock(&rs->bitmap_mutex);
> +
> +    trace_migration_bitmap_sync_end(rs->num_dirty_pages_period);
> +
> +    end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +
> +    /* more than 1 second = 1000 millisecons */
> +    if (end_time > rs->time_last_bitmap_sync + 1000) {
> +        bytes_xfer_now = ram_counters.transferred;
> +
> +        /* During block migration the auto-converge logic incorrectly detects
> +         * that ram migration makes no progress. Avoid this by disabling the
> +         * throttling logic during the bulk phase of block migration. */
> +        if (migrate_auto_converge() && !blk_mig_bulk_active()) {
> +            /* The following detection logic can be refined later. For now:
> +               Check to see if the dirtied bytes is 50% more than the approx.
> +               amount of bytes that just got transferred since the last time we
> +               were in this routine. If that happens twice, start or increase
> +               throttling */
> +
> +            if ((rs->num_dirty_pages_period * TARGET_PAGE_SIZE >
> +                   (bytes_xfer_now - rs->bytes_xfer_prev) / 2) &&
> +                (++rs->dirty_rate_high_cnt >= 2)) {
> +                    trace_migration_throttle();
> +                    rs->dirty_rate_high_cnt = 0;
> +                    mig_throttle_guest_down();
> +            }
> +        }
> +
> +        migration_update_rates(rs, end_time);
> +
> +        rs->target_page_count_prev = rs->target_page_count;
> +
> +        /* reset period counters */
> +        rs->time_last_bitmap_sync = end_time;
> +        rs->num_dirty_pages_period = 0;
> +        rs->bytes_xfer_prev = bytes_xfer_now;
> +    }
> +    if (migrate_use_events()) {
> +        qapi_event_send_migration_pass(ram_counters.dirty_sync_count);
> +    }
> +}
> +
> +static void migration_bitmap_sync_precopy(RAMState *rs)
> +{
> +    Error *local_err = NULL;
> +
> +    /*
> +     * The current notifier usage is just an optimization to migration, so we
> +     * don't stop the normal migration process in the error case.
> +     */
> +    if (precopy_notify(PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC, &local_err)) {
> +        error_report_err(local_err);
> +    }
> +
> +    migration_bitmap_sync(rs);
> +
> +    if (precopy_notify(PRECOPY_NOTIFY_AFTER_BITMAP_SYNC, &local_err)) {
> +        error_report_err(local_err);
> +    }
> +}
> +
> +/**
> + * save_zero_page_to_file: send the zero page to the file
> + *
> + * Returns the size of data written to the file, 0 means the page is not
> + * a zero page
> + *
> + * @rs: current RAM state
> + * @file: the file where the data is saved
> + * @block: block that contains the page we want to send
> + * @offset: offset inside the block for the page
> + */
> +static int save_zero_page_to_file(RAMState *rs, QEMUFile *file,
> +                                  RAMBlock *block, ram_addr_t offset)
> +{
> +    uint8_t *p = block->host + offset;
> +    int len = 0;
> +
> +    if (is_zero_range(p, TARGET_PAGE_SIZE)) {
> +        len += save_page_header(rs, file, block, offset | RAM_SAVE_FLAG_ZERO);
> +        qemu_put_byte(file, 0);
> +        len += 1;
> +    }
> +    return len;
> +}
> +
> +/**
> + * save_zero_page: send the zero page to the stream
> + *
> + * Returns the number of pages written.
> + *
> + * @rs: current RAM state
> + * @block: block that contains the page we want to send
> + * @offset: offset inside the block for the page
> + */
> +static int save_zero_page(RAMState *rs, RAMBlock *block, ram_addr_t offset)
> +{
> +    int len = save_zero_page_to_file(rs, rs->f, block, offset);
> +
> +    if (len) {
> +        ram_counters.duplicate++;
> +        ram_counters.transferred += len;
> +        return 1;
> +    }
> +    return -1;
> +}
> +
> +static void ram_release_pages(const char *rbname, uint64_t offset, int pages)
> +{
> +    if (!migrate_release_ram() || !migration_in_postcopy()) {
> +        return;
> +    }
> +
> +    ram_discard_range(rbname, offset, pages << TARGET_PAGE_BITS);
> +}
> +
> +/*
> + * @pages: the number of pages written by the control path,
> + *        < 0 - error
> + *        > 0 - number of pages written
> + *
> + * Return true if the pages has been saved, otherwise false is returned.
> + */
> +static bool control_save_page(RAMState *rs, RAMBlock *block, ram_addr_t offset,
> +                              int *pages)
> +{
> +    uint64_t bytes_xmit = 0;
> +    int ret;
> +
> +    *pages = -1;
> +    ret = ram_control_save_page(rs->f, block->offset, offset, TARGET_PAGE_SIZE,
> +                                &bytes_xmit);
> +    if (ret == RAM_SAVE_CONTROL_NOT_SUPP) {
> +        return false;
> +    }
> +
> +    if (bytes_xmit) {
> +        ram_counters.transferred += bytes_xmit;
> +        *pages = 1;
> +    }
> +
> +    if (ret == RAM_SAVE_CONTROL_DELAYED) {
> +        return true;
> +    }
> +
> +    if (bytes_xmit > 0) {
> +        ram_counters.normal++;
> +    } else if (bytes_xmit == 0) {
> +        ram_counters.duplicate++;
> +    }
> +
> +    return true;
> +}
> +
> +/*
> + * directly send the page to the stream
> + *
> + * Returns the number of pages written.
> + *
> + * @rs: current RAM state
> + * @block: block that contains the page we want to send
> + * @offset: offset inside the block for the page
> + * @buf: the page to be sent
> + * @async: send to page asyncly
> + */
> +static int save_normal_page(RAMState *rs, RAMBlock *block, ram_addr_t offset,
> +                            uint8_t *buf, bool async)
> +{
> +    ram_counters.transferred += save_page_header(rs, rs->f, block,
> +                                                 offset | RAM_SAVE_FLAG_PAGE);
> +    if (async) {
> +        qemu_put_buffer_async(rs->f, buf, TARGET_PAGE_SIZE,
> +                              migrate_release_ram() &
> +                              migration_in_postcopy());
> +    } else {
> +        qemu_put_buffer(rs->f, buf, TARGET_PAGE_SIZE);
> +    }
> +    ram_counters.transferred += TARGET_PAGE_SIZE;
> +    ram_counters.normal++;
> +    return 1;
> +}
> +
> +/**
> + * ram_save_page: send the given page to the stream
> + *
> + * Returns the number of pages written.
> + *          < 0 - error
> + *          >=0 - Number of pages written - this might legally be 0
> + *                if xbzrle noticed the page was the same.
> + *
> + * @rs: current RAM state
> + * @block: block that contains the page we want to send
> + * @offset: offset inside the block for the page
> + * @last_stage: if we are at the completion stage
> + */
> +static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
> +{
> +    int pages = -1;
> +    uint8_t *p;
> +    bool send_async = true;
> +    RAMBlock *block = pss->block;
> +    ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
> +    ram_addr_t current_addr = block->offset + offset;
> +
> +    p = block->host + offset;
> +    trace_ram_save_page(block->idstr, (uint64_t)offset, p);
> +
> +    XBZRLE_cache_lock();
> +    if (!rs->ram_bulk_stage && !migration_in_postcopy() &&
> +        migrate_use_xbzrle()) {
> +        pages = save_xbzrle_page(rs, &p, current_addr, block,
> +                                 offset, last_stage);
> +        if (!last_stage) {
> +            /* Can't send this cached data async, since the cache page
> +             * might get updated before it gets to the wire
> +             */
> +            send_async = false;
> +        }
> +    }
> +
> +    /* XBZRLE overflow or normal page */
> +    if (pages == -1) {
> +        pages = save_normal_page(rs, block, offset, p, send_async);
> +    }
> +
> +    XBZRLE_cache_unlock();
> +
> +    return pages;
> +}
> +
> +static int ram_save_multifd_page(RAMState *rs, RAMBlock *block,
> +                                 ram_addr_t offset)
> +{
> +    multifd_queue_page(block, offset);
> +    ram_counters.normal++;
> +
> +    return 1;
> +}
> +
> +static bool do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
> +                                 ram_addr_t offset, uint8_t *source_buf)
> +{
> +    RAMState *rs = ram_state;
> +    uint8_t *p = block->host + (offset & TARGET_PAGE_MASK);
> +    bool zero_page = false;
> +    int ret;
> +
> +    if (save_zero_page_to_file(rs, f, block, offset)) {
> +        zero_page = true;
> +        goto exit;
> +    }
> +
> +    save_page_header(rs, f, block, offset | RAM_SAVE_FLAG_COMPRESS_PAGE);
> +
> +    /*
> +     * copy it to a internal buffer to avoid it being modified by VM
> +     * so that we can catch up the error during compression and
> +     * decompression
> +     */
> +    memcpy(source_buf, p, TARGET_PAGE_SIZE);
> +    ret = qemu_put_compression_data(f, stream, source_buf, TARGET_PAGE_SIZE);
> +    if (ret < 0) {
> +        qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
> +        error_report("compressed data failed!");
> +        return false;
> +    }
> +
> +exit:
> +    ram_release_pages(block->idstr, offset & TARGET_PAGE_MASK, 1);
> +    return zero_page;
> +}
> +
> +static void
> +update_compress_thread_counts(const CompressParam *param, int bytes_xmit)
> +{
> +    ram_counters.transferred += bytes_xmit;
> +
> +    if (param->zero_page) {
> +        ram_counters.duplicate++;
> +        return;
> +    }
> +
> +    /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
> +    compression_counters.compressed_size += bytes_xmit - 8;
> +    compression_counters.pages++;
> +}
> +
> +static bool save_page_use_compression(RAMState *rs);
> +
> +static void flush_compressed_data(RAMState *rs)
> +{
> +    int idx, len, thread_count;
> +
> +    if (!save_page_use_compression(rs)) {
> +        return;
> +    }
> +    thread_count = migrate_compress_threads();
> +
> +    qemu_mutex_lock(&comp_done_lock);
> +    for (idx = 0; idx < thread_count; idx++) {
> +        while (!comp_param[idx].done) {
> +            qemu_cond_wait(&comp_done_cond, &comp_done_lock);
> +        }
> +    }
> +    qemu_mutex_unlock(&comp_done_lock);
> +
> +    for (idx = 0; idx < thread_count; idx++) {
> +        qemu_mutex_lock(&comp_param[idx].mutex);
> +        if (!comp_param[idx].quit) {
> +            len = qemu_put_qemu_file(rs->f, comp_param[idx].file);
> +            /*
> +             * it's safe to fetch zero_page without holding comp_done_lock
> +             * as there is no further request submitted to the thread,
> +             * i.e, the thread should be waiting for a request at this point.
> +             */
> +            update_compress_thread_counts(&comp_param[idx], len);
> +        }
> +        qemu_mutex_unlock(&comp_param[idx].mutex);
> +    }
> +}
> +
> +static inline void set_compress_params(CompressParam *param, RAMBlock *block,
> +                                       ram_addr_t offset)
> +{
> +    param->block = block;
> +    param->offset = offset;
> +}
> +
> +static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
> +                                           ram_addr_t offset)
> +{
> +    int idx, thread_count, bytes_xmit = -1, pages = -1;
> +    bool wait = migrate_compress_wait_thread();
> +
> +    thread_count = migrate_compress_threads();
> +    qemu_mutex_lock(&comp_done_lock);
> +retry:
> +    for (idx = 0; idx < thread_count; idx++) {
> +        if (comp_param[idx].done) {
> +            comp_param[idx].done = false;
> +            bytes_xmit = qemu_put_qemu_file(rs->f, comp_param[idx].file);
> +            qemu_mutex_lock(&comp_param[idx].mutex);
> +            set_compress_params(&comp_param[idx], block, offset);
> +            qemu_cond_signal(&comp_param[idx].cond);
> +            qemu_mutex_unlock(&comp_param[idx].mutex);
> +            pages = 1;
> +            update_compress_thread_counts(&comp_param[idx], bytes_xmit);
> +            break;
> +        }
> +    }
> +
> +    /*
> +     * wait for the free thread if the user specifies 'compress-wait-thread',
> +     * otherwise we will post the page out in the main thread as normal page.
> +     */
> +    if (pages < 0 && wait) {
> +        qemu_cond_wait(&comp_done_cond, &comp_done_lock);
> +        goto retry;
> +    }
> +    qemu_mutex_unlock(&comp_done_lock);
> +
> +    return pages;
> +}
> +
> +/**
> + * find_dirty_block: find the next dirty page and update any state
> + * associated with the search process.
> + *
> + * Returns true if a page is found
> + *
> + * @rs: current RAM state
> + * @pss: data about the state of the current dirty page scan
> + * @again: set to false if the search has scanned the whole of RAM
> + */
> +static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss, bool *again)
> +{
> +    pss->page = migration_bitmap_find_dirty(rs, pss->block, pss->page);
> +    if (pss->complete_round && pss->block == rs->last_seen_block &&
> +        pss->page >= rs->last_page) {
> +        /*
> +         * We've been once around the RAM and haven't found anything.
> +         * Give up.
> +         */
> +        *again = false;
> +        return false;
> +    }
> +    if ((pss->page << TARGET_PAGE_BITS) >= pss->block->used_length) {
> +        /* Didn't find anything in this RAM Block */
> +        pss->page = 0;
> +        pss->block = QLIST_NEXT_RCU(pss->block, next);
> +        if (!pss->block) {
> +            /*
> +             * If memory migration starts over, we will meet a dirtied page
> +             * which may still exists in compression threads's ring, so we
> +             * should flush the compressed data to make sure the new page
> +             * is not overwritten by the old one in the destination.
> +             *
> +             * Also If xbzrle is on, stop using the data compression at this
> +             * point. In theory, xbzrle can do better than compression.
> +             */
> +            flush_compressed_data(rs);
> +
> +            /* Hit the end of the list */
> +            pss->block = QLIST_FIRST_RCU(&ram_list.blocks);
> +            /* Flag that we've looped */
> +            pss->complete_round = true;
> +            rs->ram_bulk_stage = false;
> +        }
> +        /* Didn't find anything this time, but try again on the new block */
> +        *again = true;
> +        return false;
> +    } else {
> +        /* Can go around again, but... */
> +        *again = true;
> +        /* We've found something so probably don't need to */
> +        return true;
> +    }
> +}
> +
> +/**
> + * unqueue_page: gets a page of the queue
> + *
> + * Helper for 'get_queued_page' - gets a page off the queue
> + *
> + * Returns the block of the page (or NULL if none available)
> + *
> + * @rs: current RAM state
> + * @offset: used to return the offset within the RAMBlock
> + */
> +static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset)
> +{
> +    RAMBlock *block = NULL;
> +
> +    if (QSIMPLEQ_EMPTY_ATOMIC(&rs->src_page_requests)) {
> +        return NULL;
> +    }
> +
> +    qemu_mutex_lock(&rs->src_page_req_mutex);
> +    if (!QSIMPLEQ_EMPTY(&rs->src_page_requests)) {
> +        struct RAMSrcPageRequest *entry =
> +                                QSIMPLEQ_FIRST(&rs->src_page_requests);
> +        block = entry->rb;
> +        *offset = entry->offset;
> +
> +        if (entry->len > TARGET_PAGE_SIZE) {
> +            entry->len -= TARGET_PAGE_SIZE;
> +            entry->offset += TARGET_PAGE_SIZE;
> +        } else {
> +            memory_region_unref(block->mr);
> +            QSIMPLEQ_REMOVE_HEAD(&rs->src_page_requests, next_req);
> +            g_free(entry);
> +            migration_consume_urgent_request();
> +        }
> +    }
> +    qemu_mutex_unlock(&rs->src_page_req_mutex);
> +
> +    return block;
> +}
> +
> +/**
> + * get_queued_page: unqueue a page from the postcopy requests
> + *
> + * Skips pages that are already sent (!dirty)
> + *
> + * Returns true if a queued page is found
> + *
> + * @rs: current RAM state
> + * @pss: data about the state of the current dirty page scan
> + */
> +static bool get_queued_page(RAMState *rs, PageSearchStatus *pss)
> +{
> +    RAMBlock  *block;
> +    ram_addr_t offset;
> +    bool dirty;
> +
> +    do {
> +        block = unqueue_page(rs, &offset);
> +        /*
> +         * We're sending this page, and since it's postcopy nothing else
> +         * will dirty it, and we must make sure it doesn't get sent again
> +         * even if this queue request was received after the background
> +         * search already sent it.
> +         */
> +        if (block) {
> +            unsigned long page;
> +
> +            page = offset >> TARGET_PAGE_BITS;
> +            dirty = test_bit(page, block->bmap);
> +            if (!dirty) {
> +                trace_get_queued_page_not_dirty(block->idstr, (uint64_t)offset,
> +                       page, test_bit(page, block->unsentmap));
> +            } else {
> +                trace_get_queued_page(block->idstr, (uint64_t)offset, page);
> +            }
> +        }
> +
> +    } while (block && !dirty);
> +
> +    if (block) {
> +        /*
> +         * As soon as we start servicing pages out of order, then we have
> +         * to kill the bulk stage, since the bulk stage assumes
> +         * in (migration_bitmap_find_and_reset_dirty) that every page is
> +         * dirty, that's no longer true.
> +         */
> +        rs->ram_bulk_stage = false;
> +
> +        /*
> +         * We want the background search to continue from the queued page
> +         * since the guest is likely to want other pages near to the page
> +         * it just requested.
> +         */
> +        pss->block = block;
> +        pss->page = offset >> TARGET_PAGE_BITS;
> +
> +        /*
> +         * This unqueued page would break the "one round" check, even is
> +         * really rare.
> +         */
> +        pss->complete_round = false;
> +    }
> +
> +    return !!block;
> +}
> +
> +/**
> + * migration_page_queue_free: drop any remaining pages in the ram
> + * request queue
> + *
> + * It should be empty at the end anyway, but in error cases there may
> + * be some left.  in case that there is any page left, we drop it.
> + *
> + */
> +static void migration_page_queue_free(RAMState *rs)
> +{
> +    struct RAMSrcPageRequest *mspr, *next_mspr;
> +    /* This queue generally should be empty - but in the case of a failed
> +     * migration might have some droppings in.
> +     */
> +    rcu_read_lock();
> +    QSIMPLEQ_FOREACH_SAFE(mspr, &rs->src_page_requests, next_req, next_mspr) {
> +        memory_region_unref(mspr->rb->mr);
> +        QSIMPLEQ_REMOVE_HEAD(&rs->src_page_requests, next_req);
> +        g_free(mspr);
> +    }
> +    rcu_read_unlock();
> +}
> +
> +/**
> + * ram_save_queue_pages: queue the page for transmission
> + *
> + * A request from postcopy destination for example.
> + *
> + * Returns zero on success or negative on error
> + *
> + * @rbname: Name of the RAMBLock of the request. NULL means the
> + *          same that last one.
> + * @start: starting address from the start of the RAMBlock
> + * @len: length (in bytes) to send
> + */
> +int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
> +{
> +    RAMBlock *ramblock;
> +    RAMState *rs = ram_state;
> +
> +    ram_counters.postcopy_requests++;
> +    rcu_read_lock();
> +    if (!rbname) {
> +        /* Reuse last RAMBlock */
> +        ramblock = rs->last_req_rb;
> +
> +        if (!ramblock) {
> +            /*
> +             * Shouldn't happen, we can't reuse the last RAMBlock if
> +             * it's the 1st request.
> +             */
> +            error_report("ram_save_queue_pages no previous block");
> +            goto err;
> +        }
> +    } else {
> +        ramblock = qemu_ram_block_by_name(rbname);
> +
> +        if (!ramblock) {
> +            /* We shouldn't be asked for a non-existent RAMBlock */
> +            error_report("ram_save_queue_pages no block '%s'", rbname);
> +            goto err;
> +        }
> +        rs->last_req_rb = ramblock;
> +    }
> +    trace_ram_save_queue_pages(ramblock->idstr, start, len);
> +    if (start+len > ramblock->used_length) {
> +        error_report("%s request overrun start=" RAM_ADDR_FMT " len="
> +                     RAM_ADDR_FMT " blocklen=" RAM_ADDR_FMT,
> +                     __func__, start, len, ramblock->used_length);
> +        goto err;
> +    }
> +
> +    struct RAMSrcPageRequest *new_entry =
> +        g_malloc0(sizeof(struct RAMSrcPageRequest));
> +    new_entry->rb = ramblock;
> +    new_entry->offset = start;
> +    new_entry->len = len;
> +
> +    memory_region_ref(ramblock->mr);
> +    qemu_mutex_lock(&rs->src_page_req_mutex);
> +    QSIMPLEQ_INSERT_TAIL(&rs->src_page_requests, new_entry, next_req);
> +    migration_make_urgent_request();
> +    qemu_mutex_unlock(&rs->src_page_req_mutex);
> +    rcu_read_unlock();
> +
> +    return 0;
> +
> +err:
> +    rcu_read_unlock();
> +    return -1;
> +}
> +
> +static bool save_page_use_compression(RAMState *rs)
> +{
> +    if (!migrate_use_compression()) {
> +        return false;
> +    }
> +
> +    /*
> +     * If xbzrle is on, stop using the data compression after first
> +     * round of migration even if compression is enabled. In theory,
> +     * xbzrle can do better than compression.
> +     */
> +    if (rs->ram_bulk_stage || !migrate_use_xbzrle()) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +/*
> + * try to compress the page before posting it out, return true if the page
> + * has been properly handled by compression, otherwise needs other
> + * paths to handle it
> + */
> +static bool save_compress_page(RAMState *rs, RAMBlock *block, ram_addr_t offset)
> +{
> +    if (!save_page_use_compression(rs)) {
> +        return false;
> +    }
> +
> +    /*
> +     * When starting the process of a new block, the first page of
> +     * the block should be sent out before other pages in the same
> +     * block, and all the pages in last block should have been sent
> +     * out, keeping this order is important, because the 'cont' flag
> +     * is used to avoid resending the block name.
> +     *
> +     * We post the fist page as normal page as compression will take
> +     * much CPU resource.
> +     */
> +    if (block != rs->last_sent_block) {
> +        flush_compressed_data(rs);
> +        return false;
> +    }
> +
> +    if (compress_page_with_multi_thread(rs, block, offset) > 0) {
> +        return true;
> +    }
> +
> +    compression_counters.busy++;
> +    return false;
> +}
> +
> +/**
> + * ram_save_target_page: save one target page
> + *
> + * Returns the number of pages written
> + *
> + * @rs: current RAM state
> + * @pss: data about the page we want to send
> + * @last_stage: if we are at the completion stage
> + */
> +static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
> +                                bool last_stage)
> +{
> +    RAMBlock *block = pss->block;
> +    ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
> +    int res;
> +
> +    if (control_save_page(rs, block, offset, &res)) {
> +        return res;
> +    }
> +
> +    if (save_compress_page(rs, block, offset)) {
> +        return 1;
> +    }
> +
> +    res = save_zero_page(rs, block, offset);
> +    if (res > 0) {
> +        /* Must let xbzrle know, otherwise a previous (now 0'd) cached
> +         * page would be stale
> +         */
> +        if (!save_page_use_compression(rs)) {
> +            XBZRLE_cache_lock();
> +            xbzrle_cache_zero_page(rs, block->offset + offset);
> +            XBZRLE_cache_unlock();
> +        }
> +        ram_release_pages(block->idstr, offset, res);
> +        return res;
> +    }
> +
> +    /*
> +     * do not use multifd for compression as the first page in the new
> +     * block should be posted out before sending the compressed page
> +     */
> +    if (!save_page_use_compression(rs) && migrate_use_multifd()) {
> +        return ram_save_multifd_page(rs, block, offset);
> +    }
> +
> +    return ram_save_page(rs, pss, last_stage);
> +}
> +
> +/**
> + * ram_save_host_page: save a whole host page
> + *
> + * Starting at *offset send pages up to the end of the current host
> + * page. It's valid for the initial offset to point into the middle of
> + * a host page in which case the remainder of the hostpage is sent.
> + * Only dirty target pages are sent. Note that the host page size may
> + * be a huge page for this block.
> + * The saving stops at the boundary of the used_length of the block
> + * if the RAMBlock isn't a multiple of the host page size.
> + *
> + * Returns the number of pages written or negative on error
> + *
> + * @rs: current RAM state
> + * @ms: current migration state
> + * @pss: data about the page we want to send
> + * @last_stage: if we are at the completion stage
> + */
> +static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss,
> +                              bool last_stage)
> +{
> +    int tmppages, pages = 0;
> +    size_t pagesize_bits =
> +        qemu_ram_pagesize(pss->block) >> TARGET_PAGE_BITS;
> +
> +    if (ramblock_is_ignored(pss->block)) {
> +        error_report("block %s should not be migrated !", pss->block->idstr);
> +        return 0;
> +    }
> +
> +    do {
> +        /* Check the pages is dirty and if it is send it */
> +        if (!migration_bitmap_clear_dirty(rs, pss->block, pss->page)) {
> +            pss->page++;
> +            continue;
> +        }
> +
> +        tmppages = ram_save_target_page(rs, pss, last_stage);
> +        if (tmppages < 0) {
> +            return tmppages;
> +        }
> +
> +        pages += tmppages;
> +        if (pss->block->unsentmap) {
> +            clear_bit(pss->page, pss->block->unsentmap);
> +        }
> +
> +        pss->page++;
> +    } while ((pss->page & (pagesize_bits - 1)) &&
> +             offset_in_ramblock(pss->block, pss->page << TARGET_PAGE_BITS));
> +
> +    /* The offset we leave with is the last one we looked at */
> +    pss->page--;
> +    return pages;
> +}
> +
> +/**
> + * ram_find_and_save_block: finds a dirty page and sends it to f
> + *
> + * Called within an RCU critical section.
> + *
> + * Returns the number of pages written where zero means no dirty pages,
> + * or negative on error
> + *
> + * @rs: current RAM state
> + * @last_stage: if we are at the completion stage
> + *
> + * On systems where host-page-size > target-page-size it will send all the
> + * pages in a host page that are dirty.
> + */
> +
> +static int ram_find_and_save_block(RAMState *rs, bool last_stage)
> +{
> +    PageSearchStatus pss;
> +    int pages = 0;
> +    bool again, found;
> +
> +    /* No dirty page as there is zero RAM */
> +    if (!ram_bytes_total()) {
> +        return pages;
> +    }
> +
> +    pss.block = rs->last_seen_block;
> +    pss.page = rs->last_page;
> +    pss.complete_round = false;
> +
> +    if (!pss.block) {
> +        pss.block = QLIST_FIRST_RCU(&ram_list.blocks);
> +    }
> +
> +    do {
> +        again = true;
> +        found = get_queued_page(rs, &pss);
> +
> +        if (!found) {
> +            /* priority queue empty, so just search for something dirty */
> +            found = find_dirty_block(rs, &pss, &again);
> +        }
> +
> +        if (found) {
> +            pages = ram_save_host_page(rs, &pss, last_stage);
> +        }
> +    } while (!pages && again);
> +
> +    rs->last_seen_block = pss.block;
> +    rs->last_page = pss.page;
> +
> +    return pages;
> +}
> +
> +void acct_update_position(QEMUFile *f, size_t size, bool zero)
> +{
> +    uint64_t pages = size / TARGET_PAGE_SIZE;
> +
> +    if (zero) {
> +        ram_counters.duplicate += pages;
> +    } else {
> +        ram_counters.normal += pages;
> +        ram_counters.transferred += size;
> +        qemu_update_position(f, size);
> +    }
> +}
> +
> +static uint64_t ram_bytes_total_common(bool count_ignored)
> +{
> +    RAMBlock *block;
> +    uint64_t total = 0;
> +
> +    rcu_read_lock();
> +    if (count_ignored) {
> +        RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +            total += block->used_length;
> +        }
> +    } else {
> +        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +            total += block->used_length;
> +        }
> +    }
> +    rcu_read_unlock();
> +    return total;
> +}
> +
> +uint64_t ram_bytes_total(void)
> +{
> +    return ram_bytes_total_common(false);
> +}
> +
> +static void xbzrle_load_setup(void)
> +{
> +    XBZRLE.decoded_buf = g_malloc(TARGET_PAGE_SIZE);
> +}
> +
> +static void xbzrle_load_cleanup(void)
> +{
> +    g_free(XBZRLE.decoded_buf);
> +    XBZRLE.decoded_buf = NULL;
> +}
> +
> +static void ram_state_cleanup(RAMState **rsp)
> +{
> +    if (*rsp) {
> +        migration_page_queue_free(*rsp);
> +        qemu_mutex_destroy(&(*rsp)->bitmap_mutex);
> +        qemu_mutex_destroy(&(*rsp)->src_page_req_mutex);
> +        g_free(*rsp);
> +        *rsp = NULL;
> +    }
> +}
> +
> +static void xbzrle_cleanup(void)
> +{
> +    XBZRLE_cache_lock();
> +    if (XBZRLE.cache) {
> +        cache_fini(XBZRLE.cache);
> +        g_free(XBZRLE.encoded_buf);
> +        g_free(XBZRLE.current_buf);
> +        g_free(XBZRLE.zero_target_page);
> +        XBZRLE.cache = NULL;
> +        XBZRLE.encoded_buf = NULL;
> +        XBZRLE.current_buf = NULL;
> +        XBZRLE.zero_target_page = NULL;
> +    }
> +    XBZRLE_cache_unlock();
> +}
> +
> +static void ram_save_cleanup(void *opaque)
> +{
> +    RAMState **rsp = opaque;
> +    RAMBlock *block;
> +
> +    /* caller have hold iothread lock or is in a bh, so there is
> +     * no writing race against the migration bitmap
> +     */
> +    memory_global_dirty_log_stop();
> +
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +        g_free(block->bmap);
> +        block->bmap = NULL;
> +        g_free(block->unsentmap);
> +        block->unsentmap = NULL;
> +    }
> +
> +    xbzrle_cleanup();
> +    compress_threads_save_cleanup();
> +    ram_state_cleanup(rsp);
> +}
> +
> +static void ram_state_reset(RAMState *rs)
> +{
> +    rs->last_seen_block = NULL;
> +    rs->last_sent_block = NULL;
> +    rs->last_page = 0;
> +    rs->last_version = ram_list.version;
> +    rs->ram_bulk_stage = true;
> +    rs->fpo_enabled = false;
> +}
> +
> +#define MAX_WAIT 50 /* ms, half buffered_file limit */
> +
> +/*
> + * 'expected' is the value you expect the bitmap mostly to be full
> + * of; it won't bother printing lines that are all this value.
> + * If 'todump' is null the migration bitmap is dumped.
> + */
> +void ram_debug_dump_bitmap(unsigned long *todump, bool expected,
> +                           unsigned long pages)
> +{
> +    int64_t cur;
> +    int64_t linelen = 128;
> +    char linebuf[129];
> +
> +    for (cur = 0; cur < pages; cur += linelen) {
> +        int64_t curb;
> +        bool found = false;
> +        /*
> +         * Last line; catch the case where the line length
> +         * is longer than remaining ram
> +         */
> +        if (cur + linelen > pages) {
> +            linelen = pages - cur;
> +        }
> +        for (curb = 0; curb < linelen; curb++) {
> +            bool thisbit = test_bit(cur + curb, todump);
> +            linebuf[curb] = thisbit ? '1' : '.';
> +            found = found || (thisbit != expected);
> +        }
> +        if (found) {
> +            linebuf[curb] = '\0';
> +            fprintf(stderr,  "0x%08" PRIx64 " : %s\n", cur, linebuf);
> +        }
> +    }
> +}
> +
> +/* **** functions for postcopy ***** */
> +
> +void ram_postcopy_migrated_memory_release(MigrationState *ms)
> +{
> +    struct RAMBlock *block;
> +
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +        unsigned long *bitmap = block->bmap;
> +        unsigned long range = block->used_length >> TARGET_PAGE_BITS;
> +        unsigned long run_start = find_next_zero_bit(bitmap, range, 0);
> +
> +        while (run_start < range) {
> +            unsigned long run_end = find_next_bit(bitmap, range, run_start + 1);
> +            ram_discard_range(block->idstr, run_start << TARGET_PAGE_BITS,
> +                              (run_end - run_start) << TARGET_PAGE_BITS);
> +            run_start = find_next_zero_bit(bitmap, range, run_end + 1);
> +        }
> +    }
> +}
> +
> +/**
> + * postcopy_send_discard_bm_ram: discard a RAMBlock
> + *
> + * Returns zero on success
> + *
> + * Callback from postcopy_each_ram_send_discard for each RAMBlock
> + * Note: At this point the 'unsentmap' is the processed bitmap combined
> + *       with the dirtymap; so a '1' means it's either dirty or unsent.
> + *
> + * @ms: current migration state
> + * @pds: state for postcopy
> + * @start: RAMBlock starting page
> + * @length: RAMBlock size
> + */
> +static int postcopy_send_discard_bm_ram(MigrationState *ms,
> +                                        PostcopyDiscardState *pds,
> +                                        RAMBlock *block)
> +{
> +    unsigned long end = block->used_length >> TARGET_PAGE_BITS;
> +    unsigned long current;
> +    unsigned long *unsentmap = block->unsentmap;
> +
> +    for (current = 0; current < end; ) {
> +        unsigned long one = find_next_bit(unsentmap, end, current);
> +
> +        if (one <= end) {
> +            unsigned long zero = find_next_zero_bit(unsentmap, end, one + 1);
> +            unsigned long discard_length;
> +
> +            if (zero >= end) {
> +                discard_length = end - one;
> +            } else {
> +                discard_length = zero - one;
> +            }
> +            if (discard_length) {
> +                postcopy_discard_send_range(ms, pds, one, discard_length);
> +            }
> +            current = one + discard_length;
> +        } else {
> +            current = one;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +/**
> + * postcopy_each_ram_send_discard: discard all RAMBlocks
> + *
> + * Returns 0 for success or negative for error
> + *
> + * Utility for the outgoing postcopy code.
> + *   Calls postcopy_send_discard_bm_ram for each RAMBlock
> + *   passing it bitmap indexes and name.
> + * (qemu_ram_foreach_block ends up passing unscaled lengths
> + *  which would mean postcopy code would have to deal with target page)
> + *
> + * @ms: current migration state
> + */
> +static int postcopy_each_ram_send_discard(MigrationState *ms)
> +{
> +    struct RAMBlock *block;
> +    int ret;
> +
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +        PostcopyDiscardState *pds =
> +            postcopy_discard_send_init(ms, block->idstr);
> +
> +        /*
> +         * Postcopy sends chunks of bitmap over the wire, but it
> +         * just needs indexes at this point, avoids it having
> +         * target page specific code.
> +         */
> +        ret = postcopy_send_discard_bm_ram(ms, pds, block);
> +        postcopy_discard_send_finish(ms, pds);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +/**
> + * postcopy_chunk_hostpages_pass: canocalize bitmap in hostpages
> + *
> + * Helper for postcopy_chunk_hostpages; it's called twice to
> + * canonicalize the two bitmaps, that are similar, but one is
> + * inverted.
> + *
> + * Postcopy requires that all target pages in a hostpage are dirty or
> + * clean, not a mix.  This function canonicalizes the bitmaps.
> + *
> + * @ms: current migration state
> + * @unsent_pass: if true we need to canonicalize partially unsent host pages
> + *               otherwise we need to canonicalize partially dirty host pages
> + * @block: block that contains the page we want to canonicalize
> + * @pds: state for postcopy
> + */
> +static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
> +                                          RAMBlock *block,
> +                                          PostcopyDiscardState *pds)
> +{
> +    RAMState *rs = ram_state;
> +    unsigned long *bitmap = block->bmap;
> +    unsigned long *unsentmap = block->unsentmap;
> +    unsigned int host_ratio = block->page_size / TARGET_PAGE_SIZE;
> +    unsigned long pages = block->used_length >> TARGET_PAGE_BITS;
> +    unsigned long run_start;
> +
> +    if (block->page_size == TARGET_PAGE_SIZE) {
> +        /* Easy case - TPS==HPS for a non-huge page RAMBlock */
> +        return;
> +    }
> +
> +    if (unsent_pass) {
> +        /* Find a sent page */
> +        run_start = find_next_zero_bit(unsentmap, pages, 0);
> +    } else {
> +        /* Find a dirty page */
> +        run_start = find_next_bit(bitmap, pages, 0);
> +    }
> +
> +    while (run_start < pages) {
> +        bool do_fixup = false;
> +        unsigned long fixup_start_addr;
> +        unsigned long host_offset;
> +
> +        /*
> +         * If the start of this run of pages is in the middle of a host
> +         * page, then we need to fixup this host page.
> +         */
> +        host_offset = run_start % host_ratio;
> +        if (host_offset) {
> +            do_fixup = true;
> +            run_start -= host_offset;
> +            fixup_start_addr = run_start;
> +            /* For the next pass */
> +            run_start = run_start + host_ratio;
> +        } else {
> +            /* Find the end of this run */
> +            unsigned long run_end;
> +            if (unsent_pass) {
> +                run_end = find_next_bit(unsentmap, pages, run_start + 1);
> +            } else {
> +                run_end = find_next_zero_bit(bitmap, pages, run_start + 1);
> +            }
> +            /*
> +             * If the end isn't at the start of a host page, then the
> +             * run doesn't finish at the end of a host page
> +             * and we need to discard.
> +             */
> +            host_offset = run_end % host_ratio;
> +            if (host_offset) {
> +                do_fixup = true;
> +                fixup_start_addr = run_end - host_offset;
> +                /*
> +                 * This host page has gone, the next loop iteration starts
> +                 * from after the fixup
> +                 */
> +                run_start = fixup_start_addr + host_ratio;
> +            } else {
> +                /*
> +                 * No discards on this iteration, next loop starts from
> +                 * next sent/dirty page
> +                 */
> +                run_start = run_end + 1;
> +            }
> +        }
> +
> +        if (do_fixup) {
> +            unsigned long page;
> +
> +            /* Tell the destination to discard this page */
> +            if (unsent_pass || !test_bit(fixup_start_addr, unsentmap)) {
> +                /* For the unsent_pass we:
> +                 *     discard partially sent pages
> +                 * For the !unsent_pass (dirty) we:
> +                 *     discard partially dirty pages that were sent
> +                 *     (any partially sent pages were already discarded
> +                 *     by the previous unsent_pass)
> +                 */
> +                postcopy_discard_send_range(ms, pds, fixup_start_addr,
> +                                            host_ratio);
> +            }
> +
> +            /* Clean up the bitmap */
> +            for (page = fixup_start_addr;
> +                 page < fixup_start_addr + host_ratio; page++) {
> +                /* All pages in this host page are now not sent */
> +                set_bit(page, unsentmap);
> +
> +                /*
> +                 * Remark them as dirty, updating the count for any pages
> +                 * that weren't previously dirty.
> +                 */
> +                rs->migration_dirty_pages += !test_and_set_bit(page, bitmap);
> +            }
> +        }
> +
> +        if (unsent_pass) {
> +            /* Find the next sent page for the next iteration */
> +            run_start = find_next_zero_bit(unsentmap, pages, run_start);
> +        } else {
> +            /* Find the next dirty page for the next iteration */
> +            run_start = find_next_bit(bitmap, pages, run_start);
> +        }
> +    }
> +}
> +
> +/**
> + * postcopy_chuck_hostpages: discrad any partially sent host page
> + *
> + * Utility for the outgoing postcopy code.
> + *
> + * Discard any partially sent host-page size chunks, mark any partially
> + * dirty host-page size chunks as all dirty.  In this case the host-page
> + * is the host-page for the particular RAMBlock, i.e. it might be a huge page
> + *
> + * Returns zero on success
> + *
> + * @ms: current migration state
> + * @block: block we want to work with
> + */
> +static int postcopy_chunk_hostpages(MigrationState *ms, RAMBlock *block)
> +{
> +    PostcopyDiscardState *pds =
> +        postcopy_discard_send_init(ms, block->idstr);
> +
> +    /* First pass: Discard all partially sent host pages */
> +    postcopy_chunk_hostpages_pass(ms, true, block, pds);
> +    /*
> +     * Second pass: Ensure that all partially dirty host pages are made
> +     * fully dirty.
> +     */
> +    postcopy_chunk_hostpages_pass(ms, false, block, pds);
> +
> +    postcopy_discard_send_finish(ms, pds);
> +    return 0;
> +}
> +
> +/**
> + * ram_postcopy_send_discard_bitmap: transmit the discard bitmap
> + *
> + * Returns zero on success
> + *
> + * Transmit the set of pages to be discarded after precopy to the target
> + * these are pages that:
> + *     a) Have been previously transmitted but are now dirty again
> + *     b) Pages that have never been transmitted, this ensures that
> + *        any pages on the destination that have been mapped by background
> + *        tasks get discarded (transparent huge pages is the specific concern)
> + * Hopefully this is pretty sparse
> + *
> + * @ms: current migration state
> + */
> +int ram_postcopy_send_discard_bitmap(MigrationState *ms)
> +{
> +    RAMState *rs = ram_state;
> +    RAMBlock *block;
> +    int ret;
> +
> +    rcu_read_lock();
> +
> +    /* This should be our last sync, the src is now paused */
> +    migration_bitmap_sync(rs);
> +
> +    /* Easiest way to make sure we don't resume in the middle of a host-page */
> +    rs->last_seen_block = NULL;
> +    rs->last_sent_block = NULL;
> +    rs->last_page = 0;
> +
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +        unsigned long pages = block->used_length >> TARGET_PAGE_BITS;
> +        unsigned long *bitmap = block->bmap;
> +        unsigned long *unsentmap = block->unsentmap;
> +
> +        if (!unsentmap) {
> +            /* We don't have a safe way to resize the sentmap, so
> +             * if the bitmap was resized it will be NULL at this
> +             * point.
> +             */
> +            error_report("migration ram resized during precopy phase");
> +            rcu_read_unlock();
> +            return -EINVAL;
> +        }
> +        /* Deal with TPS != HPS and huge pages */
> +        ret = postcopy_chunk_hostpages(ms, block);
> +        if (ret) {
> +            rcu_read_unlock();
> +            return ret;
> +        }
> +
> +        /*
> +         * Update the unsentmap to be unsentmap = unsentmap | dirty
> +         */
> +        bitmap_or(unsentmap, unsentmap, bitmap, pages);
> +#ifdef DEBUG_POSTCOPY
> +        ram_debug_dump_bitmap(unsentmap, true, pages);
> +#endif
> +    }
> +    trace_ram_postcopy_send_discard_bitmap();
> +
> +    ret = postcopy_each_ram_send_discard(ms);
> +    rcu_read_unlock();
> +
> +    return ret;
> +}
> +
> +/**
> + * ram_discard_range: discard dirtied pages at the beginning of postcopy
> + *
> + * Returns zero on success
> + *
> + * @rbname: name of the RAMBlock of the request. NULL means the
> + *          same that last one.
> + * @start: RAMBlock starting page
> + * @length: RAMBlock size
> + */
> +int ram_discard_range(const char *rbname, uint64_t start, size_t length)
> +{
> +    int ret = -1;
> +
> +    trace_ram_discard_range(rbname, start, length);
> +
> +    rcu_read_lock();
> +    RAMBlock *rb = qemu_ram_block_by_name(rbname);
> +
> +    if (!rb) {
> +        error_report("ram_discard_range: Failed to find block '%s'", rbname);
> +        goto err;
> +    }
> +
> +    /*
> +     * On source VM, we don't need to update the received bitmap since
> +     * we don't even have one.
> +     */
> +    if (rb->receivedmap) {
> +        bitmap_clear(rb->receivedmap, start >> qemu_target_page_bits(),
> +                     length >> qemu_target_page_bits());
> +    }
> +
> +    ret = ram_block_discard_range(rb, start, length);
> +
> +err:
> +    rcu_read_unlock();
> +
> +    return ret;
> +}
> +
> +/*
> + * For every allocation, we will try not to crash the VM if the
> + * allocation failed.
> + */
> +static int xbzrle_init(void)
> +{
> +    Error *local_err = NULL;
> +
> +    if (!migrate_use_xbzrle()) {
> +        return 0;
> +    }
> +
> +    XBZRLE_cache_lock();
> +
> +    XBZRLE.zero_target_page = g_try_malloc0(TARGET_PAGE_SIZE);
> +    if (!XBZRLE.zero_target_page) {
> +        error_report("%s: Error allocating zero page", __func__);
> +        goto err_out;
> +    }
> +
> +    XBZRLE.cache = cache_init(migrate_xbzrle_cache_size(),
> +                              TARGET_PAGE_SIZE, &local_err);
> +    if (!XBZRLE.cache) {
> +        error_report_err(local_err);
> +        goto free_zero_page;
> +    }
> +
> +    XBZRLE.encoded_buf = g_try_malloc0(TARGET_PAGE_SIZE);
> +    if (!XBZRLE.encoded_buf) {
> +        error_report("%s: Error allocating encoded_buf", __func__);
> +        goto free_cache;
> +    }
> +
> +    XBZRLE.current_buf = g_try_malloc(TARGET_PAGE_SIZE);
> +    if (!XBZRLE.current_buf) {
> +        error_report("%s: Error allocating current_buf", __func__);
> +        goto free_encoded_buf;
> +    }
> +
> +    /* We are all good */
> +    XBZRLE_cache_unlock();
> +    return 0;
> +
> +free_encoded_buf:
> +    g_free(XBZRLE.encoded_buf);
> +    XBZRLE.encoded_buf = NULL;
> +free_cache:
> +    cache_fini(XBZRLE.cache);
> +    XBZRLE.cache = NULL;
> +free_zero_page:
> +    g_free(XBZRLE.zero_target_page);
> +    XBZRLE.zero_target_page = NULL;
> +err_out:
> +    XBZRLE_cache_unlock();
> +    return -ENOMEM;
> +}
> +
> +static int ram_state_init(RAMState **rsp)
> +{
> +    *rsp = g_try_new0(RAMState, 1);
> +
> +    if (!*rsp) {
> +        error_report("%s: Init ramstate fail", __func__);
> +        return -1;
> +    }
> +
> +    qemu_mutex_init(&(*rsp)->bitmap_mutex);
> +    qemu_mutex_init(&(*rsp)->src_page_req_mutex);
> +    QSIMPLEQ_INIT(&(*rsp)->src_page_requests);
> +
> +    /*
> +     * This must match with the initial values of dirty bitmap.
> +     * Currently we initialize the dirty bitmap to all zeros so
> +     * here the total dirty page count is zero.
> +     */
> +    (*rsp)->migration_dirty_pages = 0;
> +    ram_state_reset(*rsp);
> +
> +    return 0;
> +}
> +
> +static void ram_list_init_bitmaps(void)
> +{
> +    RAMBlock *block;
> +    unsigned long pages;
> +
> +    /* Skip setting bitmap if there is no RAM */
> +    if (ram_bytes_total()) {
> +        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +            pages = block->max_length >> TARGET_PAGE_BITS;
> +            /*
> +             * The initial dirty bitmap for migration must be set with all
> +             * ones to make sure we'll migrate every guest RAM page to
> +             * destination.
> +             * Here we didn't set RAMBlock.bmap simply because it is already
> +             * set in ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] in
> +             * ram_block_add, and that's where we'll sync the dirty bitmaps.
> +             * Here setting RAMBlock.bmap would be fine too but not necessary.
> +             */
> +            block->bmap = bitmap_new(pages);
> +            if (migrate_postcopy_ram()) {
> +                block->unsentmap = bitmap_new(pages);
> +                bitmap_set(block->unsentmap, 0, pages);
> +            }
> +        }
> +    }
> +}
> +
> +static void ram_init_bitmaps(RAMState *rs)
> +{
> +    /* For memory_global_dirty_log_start below.  */
> +    qemu_mutex_lock_iothread();
> +    qemu_mutex_lock_ramlist();
> +    rcu_read_lock();
> +
> +    ram_list_init_bitmaps();
> +    memory_global_dirty_log_start();
> +    migration_bitmap_sync_precopy(rs);
> +
> +    rcu_read_unlock();
> +    qemu_mutex_unlock_ramlist();
> +    qemu_mutex_unlock_iothread();
> +}
> +
> +static int ram_init_all(RAMState **rsp)
> +{
> +    if (ram_state_init(rsp)) {
> +        return -1;
> +    }
> +
> +    if (xbzrle_init()) {
> +        ram_state_cleanup(rsp);
> +        return -1;
> +    }
> +
> +    ram_init_bitmaps(*rsp);
> +
> +    return 0;
> +}
> +
> +static void ram_state_resume_prepare(RAMState *rs, QEMUFile *out)
> +{
> +    RAMBlock *block;
> +    uint64_t pages = 0;
> +
> +    /*
> +     * Postcopy is not using xbzrle/compression, so no need for that.
> +     * Also, since source are already halted, we don't need to care
> +     * about dirty page logging as well.
> +     */
> +
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +        pages += bitmap_count_one(block->bmap,
> +                                  block->used_length >> TARGET_PAGE_BITS);
> +    }
> +
> +    /* This may not be aligned with current bitmaps. Recalculate. */
> +    rs->migration_dirty_pages = pages;
> +
> +    rs->last_seen_block = NULL;
> +    rs->last_sent_block = NULL;
> +    rs->last_page = 0;
> +    rs->last_version = ram_list.version;
> +    /*
> +     * Disable the bulk stage, otherwise we'll resend the whole RAM no
> +     * matter what we have sent.
> +     */
> +    rs->ram_bulk_stage = false;
> +
> +    /* Update RAMState cache of output QEMUFile */
> +    rs->f = out;
> +
> +    trace_ram_state_resume_prepare(pages);
> +}
> +
> +/*
> + * This function clears bits of the free pages reported by the caller from the
> + * migration dirty bitmap. @addr is the host address corresponding to the
> + * start of the continuous guest free pages, and @len is the total bytes of
> + * those pages.
> + */
> +void qemu_guest_free_page_hint(void *addr, size_t len)
> +{
> +    RAMBlock *block;
> +    ram_addr_t offset;
> +    size_t used_len, start, npages;
> +    MigrationState *s = migrate_get_current();
> +
> +    /* This function is currently expected to be used during live migration */
> +    if (!migration_is_setup_or_active(s->state)) {
> +        return;
> +    }
> +
> +    for (; len > 0; len -= used_len, addr += used_len) {
> +        block = qemu_ram_block_from_host(addr, false, &offset);
> +        if (unlikely(!block || offset >= block->used_length)) {
> +            /*
> +             * The implementation might not support RAMBlock resize during
> +             * live migration, but it could happen in theory with future
> +             * updates. So we add a check here to capture that case.
> +             */
> +            error_report_once("%s unexpected error", __func__);
> +            return;
> +        }
> +
> +        if (len <= block->used_length - offset) {
> +            used_len = len;
> +        } else {
> +            used_len = block->used_length - offset;
> +        }
> +
> +        start = offset >> TARGET_PAGE_BITS;
> +        npages = used_len >> TARGET_PAGE_BITS;
> +
> +        qemu_mutex_lock(&ram_state->bitmap_mutex);
> +        ram_state->migration_dirty_pages -=
> +                      bitmap_count_one_with_offset(block->bmap, start, npages);
> +        bitmap_clear(block->bmap, start, npages);
> +        qemu_mutex_unlock(&ram_state->bitmap_mutex);
> +    }
> +}
> +
> +/*
> + * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
> + * long-running RCU critical section.  When rcu-reclaims in the code
> + * start to become numerous it will be necessary to reduce the
> + * granularity of these critical sections.
> + */
> +
> +/**
> + * ram_save_setup: Setup RAM for migration
> + *
> + * Returns zero to indicate success and negative for error
> + *
> + * @f: QEMUFile where to send the data
> + * @opaque: RAMState pointer
> + */
> +static int ram_save_setup(QEMUFile *f, void *opaque)
> +{
> +    RAMState **rsp = opaque;
> +    RAMBlock *block;
> +
> +    if (compress_threads_save_setup()) {
> +        return -1;
> +    }
> +
> +    /* migration has already setup the bitmap, reuse it. */
> +    if (!migration_in_colo_state()) {
> +        if (ram_init_all(rsp) != 0) {
> +            compress_threads_save_cleanup();
> +            return -1;
> +        }
> +    }
> +    (*rsp)->f = f;
> +
> +    rcu_read_lock();
> +
> +    qemu_put_be64(f, ram_bytes_total_common(true) | RAM_SAVE_FLAG_MEM_SIZE);
> +
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        qemu_put_byte(f, strlen(block->idstr));
> +        qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idstr));
> +        qemu_put_be64(f, block->used_length);
> +        if (migrate_postcopy_ram() && block->page_size != qemu_host_page_size) {
> +            qemu_put_be64(f, block->page_size);
> +        }
> +        if (migrate_ignore_shared()) {
> +            qemu_put_be64(f, block->mr->addr);
> +            qemu_put_byte(f, ramblock_is_ignored(block) ? 1 : 0);
> +        }
> +    }
> +
> +    rcu_read_unlock();
> +
> +    ram_control_before_iterate(f, RAM_CONTROL_SETUP);
> +    ram_control_after_iterate(f, RAM_CONTROL_SETUP);
> +
> +    multifd_send_sync_main();
> +    qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> +    qemu_fflush(f);
> +
> +    return 0;
> +}
> +
> +/**
> + * ram_save_iterate: iterative stage for migration
> + *
> + * Returns zero to indicate success and negative for error
> + *
> + * @f: QEMUFile where to send the data
> + * @opaque: RAMState pointer
> + */
> +static int ram_save_iterate(QEMUFile *f, void *opaque)
> +{
> +    RAMState **temp = opaque;
> +    RAMState *rs = *temp;
> +    int ret;
> +    int i;
> +    int64_t t0;
> +    int done = 0;
> +
> +    if (blk_mig_bulk_active()) {
> +        /* Avoid transferring ram during bulk phase of block migration as
> +         * the bulk phase will usually take a long time and transferring
> +         * ram updates during that time is pointless. */
> +        goto out;
> +    }
> +
> +    rcu_read_lock();
> +    if (ram_list.version != rs->last_version) {
> +        ram_state_reset(rs);
> +    }
> +
> +    /* Read version before ram_list.blocks */
> +    smp_rmb();
> +
> +    ram_control_before_iterate(f, RAM_CONTROL_ROUND);
> +
> +    t0 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> +    i = 0;
> +    while ((ret = qemu_file_rate_limit(f)) == 0 ||
> +            !QSIMPLEQ_EMPTY(&rs->src_page_requests)) {
> +        int pages;
> +
> +        if (qemu_file_get_error(f)) {
> +            break;
> +        }
> +
> +        pages = ram_find_and_save_block(rs, false);
> +        /* no more pages to sent */
> +        if (pages == 0) {
> +            done = 1;
> +            break;
> +        }
> +
> +        if (pages < 0) {
> +            qemu_file_set_error(f, pages);
> +            break;
> +        }
> +
> +        rs->target_page_count += pages;
> +
> +        /* we want to check in the 1st loop, just in case it was the 1st time
> +           and we had to sync the dirty bitmap.
> +           qemu_clock_get_ns() is a bit expensive, so we only check each some
> +           iterations
> +        */
> +        if ((i & 63) == 0) {
> +            uint64_t t1 = (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - t0) / 1000000;
> +            if (t1 > MAX_WAIT) {
> +                trace_ram_save_iterate_big_wait(t1, i);
> +                break;
> +            }
> +        }
> +        i++;
> +    }
> +    rcu_read_unlock();
> +
> +    /*
> +     * Must occur before EOS (or any QEMUFile operation)
> +     * because of RDMA protocol.
> +     */
> +    ram_control_after_iterate(f, RAM_CONTROL_ROUND);
> +
> +out:
> +    multifd_send_sync_main();
> +    qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> +    qemu_fflush(f);
> +    ram_counters.transferred += 8;
> +
> +    ret = qemu_file_get_error(f);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    return done;
> +}
> +
> +/**
> + * ram_save_complete: function called to send the remaining amount of ram
> + *
> + * Returns zero to indicate success or negative on error
> + *
> + * Called with iothread lock
> + *
> + * @f: QEMUFile where to send the data
> + * @opaque: RAMState pointer
> + */
> +static int ram_save_complete(QEMUFile *f, void *opaque)
> +{
> +    RAMState **temp = opaque;
> +    RAMState *rs = *temp;
> +    int ret = 0;
> +
> +    rcu_read_lock();
> +
> +    if (!migration_in_postcopy()) {
> +        migration_bitmap_sync_precopy(rs);
> +    }
> +
> +    ram_control_before_iterate(f, RAM_CONTROL_FINISH);
> +
> +    /* try transferring iterative blocks of memory */
> +
> +    /* flush all remaining blocks regardless of rate limiting */
> +    while (true) {
> +        int pages;
> +
> +        pages = ram_find_and_save_block(rs, !migration_in_colo_state());
> +        /* no more blocks to sent */
> +        if (pages == 0) {
> +            break;
> +        }
> +        if (pages < 0) {
> +            ret = pages;
> +            break;
> +        }
> +    }
> +
> +    flush_compressed_data(rs);
> +    ram_control_after_iterate(f, RAM_CONTROL_FINISH);
> +
> +    rcu_read_unlock();
> +
> +    multifd_send_sync_main();
> +    qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> +    qemu_fflush(f);
> +
> +    return ret;
> +}
> +
> +static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
> +                             uint64_t *res_precopy_only,
> +                             uint64_t *res_compatible,
> +                             uint64_t *res_postcopy_only)
> +{
> +    RAMState **temp = opaque;
> +    RAMState *rs = *temp;
> +    uint64_t remaining_size;
> +
> +    remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
> +
> +    if (!migration_in_postcopy() &&
> +        remaining_size < max_size) {
> +        qemu_mutex_lock_iothread();
> +        rcu_read_lock();
> +        migration_bitmap_sync_precopy(rs);
> +        rcu_read_unlock();
> +        qemu_mutex_unlock_iothread();
> +        remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
> +    }
> +
> +    if (migrate_postcopy_ram()) {
> +        /* We can do postcopy, and all the data is postcopiable */
> +        *res_compatible += remaining_size;
> +    } else {
> +        *res_precopy_only += remaining_size;
> +    }
> +}
> +
> +static int load_xbzrle(QEMUFile *f, ram_addr_t addr, void *host)
> +{
> +    unsigned int xh_len;
> +    int xh_flags;
> +    uint8_t *loaded_data;
> +
> +    /* extract RLE header */
> +    xh_flags = qemu_get_byte(f);
> +    xh_len = qemu_get_be16(f);
> +
> +    if (xh_flags != ENCODING_FLAG_XBZRLE) {
> +        error_report("Failed to load XBZRLE page - wrong compression!");
> +        return -1;
> +    }
> +
> +    if (xh_len > TARGET_PAGE_SIZE) {
> +        error_report("Failed to load XBZRLE page - len overflow!");
> +        return -1;
> +    }
> +    loaded_data = XBZRLE.decoded_buf;
> +    /* load data and decode */
> +    /* it can change loaded_data to point to an internal buffer */
> +    qemu_get_buffer_in_place(f, &loaded_data, xh_len);
> +
> +    /* decode RLE */
> +    if (xbzrle_decode_buffer(loaded_data, xh_len, host,
> +                             TARGET_PAGE_SIZE) == -1) {
> +        error_report("Failed to load XBZRLE page - decode error!");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +/**
> + * ram_block_from_stream: read a RAMBlock id from the migration stream
> + *
> + * Must be called from within a rcu critical section.
> + *
> + * Returns a pointer from within the RCU-protected ram_list.
> + *
> + * @f: QEMUFile where to read the data from
> + * @flags: Page flags (mostly to see if it's a continuation of previous block)
> + */
> +static inline RAMBlock *ram_block_from_stream(QEMUFile *f, int flags)
> +{
> +    static RAMBlock *block = NULL;
> +    char id[256];
> +    uint8_t len;
> +
> +    if (flags & RAM_SAVE_FLAG_CONTINUE) {
> +        if (!block) {
> +            error_report("Ack, bad migration stream!");
> +            return NULL;
> +        }
> +        return block;
> +    }
> +
> +    len = qemu_get_byte(f);
> +    qemu_get_buffer(f, (uint8_t *)id, len);
> +    id[len] = 0;
> +
> +    block = qemu_ram_block_by_name(id);
> +    if (!block) {
> +        error_report("Can't find block %s", id);
> +        return NULL;
> +    }
> +
> +    if (ramblock_is_ignored(block)) {
> +        error_report("block %s should not be migrated !", id);
> +        return NULL;
> +    }
> +
> +    return block;
> +}
> +
> +static inline void *host_from_ram_block_offset(RAMBlock *block,
> +                                               ram_addr_t offset)
> +{
> +    if (!offset_in_ramblock(block, offset)) {
> +        return NULL;
> +    }
> +
> +    return block->host + offset;
> +}
> +
> +static inline void *colo_cache_from_block_offset(RAMBlock *block,
> +                                                 ram_addr_t offset)
> +{
> +    if (!offset_in_ramblock(block, offset)) {
> +        return NULL;
> +    }
> +    if (!block->colo_cache) {
> +        error_report("%s: colo_cache is NULL in block :%s",
> +                     __func__, block->idstr);
> +        return NULL;
> +    }
> +
> +    /*
> +    * During colo checkpoint, we need bitmap of these migrated pages.
> +    * It help us to decide which pages in ram cache should be flushed
> +    * into VM's RAM later.
> +    */
> +    if (!test_and_set_bit(offset >> TARGET_PAGE_BITS, block->bmap)) {
> +        ram_state->migration_dirty_pages++;
> +    }
> +    return block->colo_cache + offset;
> +}
> +
> +/**
> + * ram_handle_compressed: handle the zero page case
> + *
> + * If a page (or a whole RDMA chunk) has been
> + * determined to be zero, then zap it.
> + *
> + * @host: host address for the zero page
> + * @ch: what the page is filled from.  We only support zero
> + * @size: size of the zero page
> + */
> +void ram_handle_compressed(void *host, uint8_t ch, uint64_t size)
> +{
> +    if (ch != 0 || !is_zero_range(host, size)) {
> +        memset(host, ch, size);
> +    }
> +}
> +
> +/* return the size after decompression, or negative value on error */
> +static int
> +qemu_uncompress_data(z_stream *stream, uint8_t *dest, size_t dest_len,
> +                     const uint8_t *source, size_t source_len)
> +{
> +    int err;
> +
> +    err = inflateReset(stream);
> +    if (err != Z_OK) {
> +        return -1;
> +    }
> +
> +    stream->avail_in = source_len;
> +    stream->next_in = (uint8_t *)source;
> +    stream->avail_out = dest_len;
> +    stream->next_out = dest;
> +
> +    err = inflate(stream, Z_NO_FLUSH);
> +    if (err != Z_STREAM_END) {
> +        return -1;
> +    }
> +
> +    return stream->total_out;
> +}
> +
> +static void *do_data_decompress(void *opaque)
> +{
> +    DecompressParam *param = opaque;
> +    unsigned long pagesize;
> +    uint8_t *des;
> +    int len, ret;
> +
> +    qemu_mutex_lock(&param->mutex);
> +    while (!param->quit) {
> +        if (param->des) {
> +            des = param->des;
> +            len = param->len;
> +            param->des = 0;
> +            qemu_mutex_unlock(&param->mutex);
> +
> +            pagesize = TARGET_PAGE_SIZE;
> +
> +            ret = qemu_uncompress_data(&param->stream, des, pagesize,
> +                                       param->compbuf, len);
> +            if (ret < 0 && migrate_get_current()->decompress_error_check) {
> +                error_report("decompress data failed");
> +                qemu_file_set_error(decomp_file, ret);
> +            }
> +
> +            qemu_mutex_lock(&decomp_done_lock);
> +            param->done = true;
> +            qemu_cond_signal(&decomp_done_cond);
> +            qemu_mutex_unlock(&decomp_done_lock);
> +
> +            qemu_mutex_lock(&param->mutex);
> +        } else {
> +            qemu_cond_wait(&param->cond, &param->mutex);
> +        }
> +    }
> +    qemu_mutex_unlock(&param->mutex);
> +
> +    return NULL;
> +}
> +
> +static int wait_for_decompress_done(void)
> +{
> +    int idx, thread_count;
> +
> +    if (!migrate_use_compression()) {
> +        return 0;
> +    }
> +
> +    thread_count = migrate_decompress_threads();
> +    qemu_mutex_lock(&decomp_done_lock);
> +    for (idx = 0; idx < thread_count; idx++) {
> +        while (!decomp_param[idx].done) {
> +            qemu_cond_wait(&decomp_done_cond, &decomp_done_lock);
> +        }
> +    }
> +    qemu_mutex_unlock(&decomp_done_lock);
> +    return qemu_file_get_error(decomp_file);
> +}
> +
> +static void compress_threads_load_cleanup(void)
> +{
> +    int i, thread_count;
> +
> +    if (!migrate_use_compression()) {
> +        return;
> +    }
> +    thread_count = migrate_decompress_threads();
> +    for (i = 0; i < thread_count; i++) {
> +        /*
> +         * we use it as a indicator which shows if the thread is
> +         * properly init'd or not
> +         */
> +        if (!decomp_param[i].compbuf) {
> +            break;
> +        }
> +
> +        qemu_mutex_lock(&decomp_param[i].mutex);
> +        decomp_param[i].quit = true;
> +        qemu_cond_signal(&decomp_param[i].cond);
> +        qemu_mutex_unlock(&decomp_param[i].mutex);
> +    }
> +    for (i = 0; i < thread_count; i++) {
> +        if (!decomp_param[i].compbuf) {
> +            break;
> +        }
> +
> +        qemu_thread_join(decompress_threads + i);
> +        qemu_mutex_destroy(&decomp_param[i].mutex);
> +        qemu_cond_destroy(&decomp_param[i].cond);
> +        inflateEnd(&decomp_param[i].stream);
> +        g_free(decomp_param[i].compbuf);
> +        decomp_param[i].compbuf = NULL;
> +    }
> +    g_free(decompress_threads);
> +    g_free(decomp_param);
> +    decompress_threads = NULL;
> +    decomp_param = NULL;
> +    decomp_file = NULL;
> +}
> +
> +static int compress_threads_load_setup(QEMUFile *f)
> +{
> +    int i, thread_count;
> +
> +    if (!migrate_use_compression()) {
> +        return 0;
> +    }
> +
> +    thread_count = migrate_decompress_threads();
> +    decompress_threads = g_new0(QemuThread, thread_count);
> +    decomp_param = g_new0(DecompressParam, thread_count);
> +    qemu_mutex_init(&decomp_done_lock);
> +    qemu_cond_init(&decomp_done_cond);
> +    decomp_file = f;
> +    for (i = 0; i < thread_count; i++) {
> +        if (inflateInit(&decomp_param[i].stream) != Z_OK) {
> +            goto exit;
> +        }
> +
> +        decomp_param[i].compbuf = g_malloc0(compressBound(TARGET_PAGE_SIZE));
> +        qemu_mutex_init(&decomp_param[i].mutex);
> +        qemu_cond_init(&decomp_param[i].cond);
> +        decomp_param[i].done = true;
> +        decomp_param[i].quit = false;
> +        qemu_thread_create(decompress_threads + i, "decompress",
> +                           do_data_decompress, decomp_param + i,
> +                           QEMU_THREAD_JOINABLE);
> +    }
> +    return 0;
> +exit:
> +    compress_threads_load_cleanup();
> +    return -1;
> +}
> +
> +static void decompress_data_with_multi_threads(QEMUFile *f,
> +                                               void *host, int len)
> +{
> +    int idx, thread_count;
> +
> +    thread_count = migrate_decompress_threads();
> +    qemu_mutex_lock(&decomp_done_lock);
> +    while (true) {
> +        for (idx = 0; idx < thread_count; idx++) {
> +            if (decomp_param[idx].done) {
> +                decomp_param[idx].done = false;
> +                qemu_mutex_lock(&decomp_param[idx].mutex);
> +                qemu_get_buffer(f, decomp_param[idx].compbuf, len);
> +                decomp_param[idx].des = host;
> +                decomp_param[idx].len = len;
> +                qemu_cond_signal(&decomp_param[idx].cond);
> +                qemu_mutex_unlock(&decomp_param[idx].mutex);
> +                break;
> +            }
> +        }
> +        if (idx < thread_count) {
> +            break;
> +        } else {
> +            qemu_cond_wait(&decomp_done_cond, &decomp_done_lock);
> +        }
> +    }
> +    qemu_mutex_unlock(&decomp_done_lock);
> +}
> +
> +/*
> + * colo cache: this is for secondary VM, we cache the whole
> + * memory of the secondary VM, it is need to hold the global lock
> + * to call this helper.
> + */
> +int colo_init_ram_cache(void)
> +{
> +    RAMBlock *block;
> +
> +    rcu_read_lock();
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +        block->colo_cache = qemu_anon_ram_alloc(block->used_length,
> +                                                NULL,
> +                                                false);
> +        if (!block->colo_cache) {
> +            error_report("%s: Can't alloc memory for COLO cache of block %s,"
> +                         "size 0x" RAM_ADDR_FMT, __func__, block->idstr,
> +                         block->used_length);
> +            goto out_locked;
> +        }
> +        memcpy(block->colo_cache, block->host, block->used_length);
> +    }
> +    rcu_read_unlock();
> +    /*
> +    * Record the dirty pages that sent by PVM, we use this dirty bitmap together
> +    * with to decide which page in cache should be flushed into SVM's RAM. Here
> +    * we use the same name 'ram_bitmap' as for migration.
> +    */
> +    if (ram_bytes_total()) {
> +        RAMBlock *block;
> +
> +        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +            unsigned long pages = block->max_length >> TARGET_PAGE_BITS;
> +
> +            block->bmap = bitmap_new(pages);
> +            bitmap_set(block->bmap, 0, pages);
> +        }
> +    }
> +    ram_state = g_new0(RAMState, 1);
> +    ram_state->migration_dirty_pages = 0;
> +    qemu_mutex_init(&ram_state->bitmap_mutex);
> +    memory_global_dirty_log_start();
> +
> +    return 0;
> +
> +out_locked:
> +
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +        if (block->colo_cache) {
> +            qemu_anon_ram_free(block->colo_cache, block->used_length);
> +            block->colo_cache = NULL;
> +        }
> +    }
> +
> +    rcu_read_unlock();
> +    return -errno;
> +}
> +
> +/* It is need to hold the global lock to call this helper */
> +void colo_release_ram_cache(void)
> +{
> +    RAMBlock *block;
> +
> +    memory_global_dirty_log_stop();
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +        g_free(block->bmap);
> +        block->bmap = NULL;
> +    }
> +
> +    rcu_read_lock();
> +
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +        if (block->colo_cache) {
> +            qemu_anon_ram_free(block->colo_cache, block->used_length);
> +            block->colo_cache = NULL;
> +        }
> +    }
> +
> +    rcu_read_unlock();
> +    qemu_mutex_destroy(&ram_state->bitmap_mutex);
> +    g_free(ram_state);
> +    ram_state = NULL;
> +}
> +
> +/**
> + * ram_load_setup: Setup RAM for migration incoming side
> + *
> + * Returns zero to indicate success and negative for error
> + *
> + * @f: QEMUFile where to receive the data
> + * @opaque: RAMState pointer
> + */
> +static int ram_load_setup(QEMUFile *f, void *opaque)
> +{
> +    if (compress_threads_load_setup(f)) {
> +        return -1;
> +    }
> +
> +    xbzrle_load_setup();
> +    ramblock_recv_map_init();
> +
> +    return 0;
> +}
> +
> +static int ram_load_cleanup(void *opaque)
> +{
> +    RAMBlock *rb;
> +
> +    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> +        if (ramblock_is_pmem(rb)) {
> +            pmem_persist(rb->host, rb->used_length);
> +        }
> +    }
> +
> +    xbzrle_load_cleanup();
> +    compress_threads_load_cleanup();
> +
> +    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> +        g_free(rb->receivedmap);
> +        rb->receivedmap = NULL;
> +    }
> +
> +    return 0;
> +}
> +
> +/**
> + * ram_postcopy_incoming_init: allocate postcopy data structures
> + *
> + * Returns 0 for success and negative if there was one error
> + *
> + * @mis: current migration incoming state
> + *
> + * Allocate data structures etc needed by incoming migration with
> + * postcopy-ram. postcopy-ram's similarly names
> + * postcopy_ram_incoming_init does the work.
> + */
> +int ram_postcopy_incoming_init(MigrationIncomingState *mis)
> +{
> +    return postcopy_ram_incoming_init(mis);
> +}
> +
> +/**
> + * ram_load_postcopy: load a page in postcopy case
> + *
> + * Returns 0 for success or -errno in case of error
> + *
> + * Called in postcopy mode by ram_load().
> + * rcu_read_lock is taken prior to this being called.
> + *
> + * @f: QEMUFile where to send the data
> + */
> +static int ram_load_postcopy(QEMUFile *f)
> +{
> +    int flags = 0, ret = 0;
> +    bool place_needed = false;
> +    bool matches_target_page_size = false;
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +    /* Temporary page that is later 'placed' */
> +    void *postcopy_host_page = postcopy_get_tmp_page(mis);
> +    void *last_host = NULL;
> +    bool all_zero = false;
> +
> +    while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
> +        ram_addr_t addr;
> +        void *host = NULL;
> +        void *page_buffer = NULL;
> +        void *place_source = NULL;
> +        RAMBlock *block = NULL;
> +        uint8_t ch;
> +
> +        addr = qemu_get_be64(f);
> +
> +        /*
> +         * If qemu file error, we should stop here, and then "addr"
> +         * may be invalid
> +         */
> +        ret = qemu_file_get_error(f);
> +        if (ret) {
> +            break;
> +        }
> +
> +        flags = addr & ~TARGET_PAGE_MASK;
> +        addr &= TARGET_PAGE_MASK;
> +
> +        trace_ram_load_postcopy_loop((uint64_t)addr, flags);
> +        place_needed = false;
> +        if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE)) {
> +            block = ram_block_from_stream(f, flags);
> +
> +            host = host_from_ram_block_offset(block, addr);
> +            if (!host) {
> +                error_report("Illegal RAM offset " RAM_ADDR_FMT, addr);
> +                ret = -EINVAL;
> +                break;
> +            }
> +            matches_target_page_size = block->page_size == TARGET_PAGE_SIZE;
> +            /*
> +             * Postcopy requires that we place whole host pages atomically;
> +             * these may be huge pages for RAMBlocks that are backed by
> +             * hugetlbfs.
> +             * To make it atomic, the data is read into a temporary page
> +             * that's moved into place later.
> +             * The migration protocol uses,  possibly smaller, target-pages
> +             * however the source ensures it always sends all the components
> +             * of a host page in order.
> +             */
> +            page_buffer = postcopy_host_page +
> +                          ((uintptr_t)host & (block->page_size - 1));
> +            /* If all TP are zero then we can optimise the place */
> +            if (!((uintptr_t)host & (block->page_size - 1))) {
> +                all_zero = true;
> +            } else {
> +                /* not the 1st TP within the HP */
> +                if (host != (last_host + TARGET_PAGE_SIZE)) {
> +                    error_report("Non-sequential target page %p/%p",
> +                                  host, last_host);
> +                    ret = -EINVAL;
> +                    break;
> +                }
> +            }
> +
> +
> +            /*
> +             * If it's the last part of a host page then we place the host
> +             * page
> +             */
> +            place_needed = (((uintptr_t)host + TARGET_PAGE_SIZE) &
> +                                     (block->page_size - 1)) == 0;
> +            place_source = postcopy_host_page;
> +        }
> +        last_host = host;
> +
> +        switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
> +        case RAM_SAVE_FLAG_ZERO:
> +            ch = qemu_get_byte(f);
> +            memset(page_buffer, ch, TARGET_PAGE_SIZE);
> +            if (ch) {
> +                all_zero = false;
> +            }
> +            break;
> +
> +        case RAM_SAVE_FLAG_PAGE:
> +            all_zero = false;
> +            if (!matches_target_page_size) {
> +                /* For huge pages, we always use temporary buffer */
> +                qemu_get_buffer(f, page_buffer, TARGET_PAGE_SIZE);
> +            } else {
> +                /*
> +                 * For small pages that matches target page size, we
> +                 * avoid the qemu_file copy.  Instead we directly use
> +                 * the buffer of QEMUFile to place the page.  Note: we
> +                 * cannot do any QEMUFile operation before using that
> +                 * buffer to make sure the buffer is valid when
> +                 * placing the page.
> +                 */
> +                qemu_get_buffer_in_place(f, (uint8_t **)&place_source,
> +                                         TARGET_PAGE_SIZE);
> +            }
> +            break;
> +        case RAM_SAVE_FLAG_EOS:
> +            /* normal exit */
> +            multifd_recv_sync_main();
> +            break;
> +        default:
> +            error_report("Unknown combination of migration flags: %#x"
> +                         " (postcopy mode)", flags);
> +            ret = -EINVAL;
> +            break;
> +        }
> +
> +        /* Detect for any possible file errors */
> +        if (!ret && qemu_file_get_error(f)) {
> +            ret = qemu_file_get_error(f);
> +        }
> +
> +        if (!ret && place_needed) {
> +            /* This gets called at the last target page in the host page */
> +            void *place_dest = host + TARGET_PAGE_SIZE - block->page_size;
> +
> +            if (all_zero) {
> +                ret = postcopy_place_page_zero(mis, place_dest,
> +                                               block);
> +            } else {
> +                ret = postcopy_place_page(mis, place_dest,
> +                                          place_source, block);
> +            }
> +        }
> +    }
> +
> +    return ret;
> +}
> +
> +static bool postcopy_is_advised(void)
> +{
> +    PostcopyState ps = postcopy_state_get();
> +    return ps >= POSTCOPY_INCOMING_ADVISE && ps < POSTCOPY_INCOMING_END;
> +}
> +
> +static bool postcopy_is_running(void)
> +{
> +    PostcopyState ps = postcopy_state_get();
> +    return ps >= POSTCOPY_INCOMING_LISTENING && ps < POSTCOPY_INCOMING_END;
> +}
> +
> +/*
> + * Flush content of RAM cache into SVM's memory.
> + * Only flush the pages that be dirtied by PVM or SVM or both.
> + */
> +static void colo_flush_ram_cache(void)
> +{
> +    RAMBlock *block = NULL;
> +    void *dst_host;
> +    void *src_host;
> +    unsigned long offset = 0;
> +
> +    memory_global_dirty_log_sync();
> +    rcu_read_lock();
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +        migration_bitmap_sync_range(ram_state, block, block->used_length);
> +    }
> +    rcu_read_unlock();
> +
> +    trace_colo_flush_ram_cache_begin(ram_state->migration_dirty_pages);
> +    rcu_read_lock();
> +    block = QLIST_FIRST_RCU(&ram_list.blocks);
> +
> +    while (block) {
> +        offset = migration_bitmap_find_dirty(ram_state, block, offset);
> +
> +        if (offset << TARGET_PAGE_BITS >= block->used_length) {
> +            offset = 0;
> +            block = QLIST_NEXT_RCU(block, next);
> +        } else {
> +            migration_bitmap_clear_dirty(ram_state, block, offset);
> +            dst_host = block->host + (offset << TARGET_PAGE_BITS);
> +            src_host = block->colo_cache + (offset << TARGET_PAGE_BITS);
> +            memcpy(dst_host, src_host, TARGET_PAGE_SIZE);
> +        }
> +    }
> +
> +    rcu_read_unlock();
> +    trace_colo_flush_ram_cache_end();
> +}
> +
> +static int ram_load(QEMUFile *f, void *opaque, int version_id)
> +{
> +    int flags = 0, ret = 0, invalid_flags = 0;
> +    static uint64_t seq_iter;
> +    int len = 0;
> +    /*
> +     * If system is running in postcopy mode, page inserts to host memory must
> +     * be atomic
> +     */
> +    bool postcopy_running = postcopy_is_running();
> +    /* ADVISE is earlier, it shows the source has the postcopy capability on */
> +    bool postcopy_advised = postcopy_is_advised();
> +
> +    seq_iter++;
> +
> +    if (version_id != 4) {
> +        ret = -EINVAL;
> +    }
> +
> +    if (!migrate_use_compression()) {
> +        invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
> +    }
> +    /* This RCU critical section can be very long running.
> +     * When RCU reclaims in the code start to become numerous,
> +     * it will be necessary to reduce the granularity of this
> +     * critical section.
> +     */
> +    rcu_read_lock();
> +
> +    if (postcopy_running) {
> +        ret = ram_load_postcopy(f);
> +    }
> +
> +    while (!postcopy_running && !ret && !(flags & RAM_SAVE_FLAG_EOS)) {
> +        ram_addr_t addr, total_ram_bytes;
> +        void *host = NULL;
> +        uint8_t ch;
> +
> +        addr = qemu_get_be64(f);
> +        flags = addr & ~TARGET_PAGE_MASK;
> +        addr &= TARGET_PAGE_MASK;
> +
> +        if (flags & invalid_flags) {
> +            if (flags & invalid_flags & RAM_SAVE_FLAG_COMPRESS_PAGE) {
> +                error_report("Received an unexpected compressed page");
> +            }
> +
> +            ret = -EINVAL;
> +            break;
> +        }
> +
> +        if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
> +                     RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
> +            RAMBlock *block = ram_block_from_stream(f, flags);
> +
> +            /*
> +             * After going into COLO, we should load the Page into colo_cache.
> +             */
> +            if (migration_incoming_in_colo_state()) {
> +                host = colo_cache_from_block_offset(block, addr);
> +            } else {
> +                host = host_from_ram_block_offset(block, addr);
> +            }
> +            if (!host) {
> +                error_report("Illegal RAM offset " RAM_ADDR_FMT, addr);
> +                ret = -EINVAL;
> +                break;
> +            }
> +
> +            if (!migration_incoming_in_colo_state()) {
> +                ramblock_recv_bitmap_set(block, host);
> +            }
> +
> +            trace_ram_load_loop(block->idstr, (uint64_t)addr, flags, host);
> +        }
> +
> +        switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
> +        case RAM_SAVE_FLAG_MEM_SIZE:
> +            /* Synchronize RAM block list */
> +            total_ram_bytes = addr;
> +            while (!ret && total_ram_bytes) {
> +                RAMBlock *block;
> +                char id[256];
> +                ram_addr_t length;
> +
> +                len = qemu_get_byte(f);
> +                qemu_get_buffer(f, (uint8_t *)id, len);
> +                id[len] = 0;
> +                length = qemu_get_be64(f);
> +
> +                block = qemu_ram_block_by_name(id);
> +                if (block && !qemu_ram_is_migratable(block)) {
> +                    error_report("block %s should not be migrated !", id);
> +                    ret = -EINVAL;
> +                } else if (block) {
> +                    if (length != block->used_length) {
> +                        Error *local_err = NULL;
> +
> +                        ret = qemu_ram_resize(block, length,
> +                                              &local_err);
> +                        if (local_err) {
> +                            error_report_err(local_err);
> +                        }
> +                    }
> +                    /* For postcopy we need to check hugepage sizes match */
> +                    if (postcopy_advised &&
> +                        block->page_size != qemu_host_page_size) {
> +                        uint64_t remote_page_size = qemu_get_be64(f);
> +                        if (remote_page_size != block->page_size) {
> +                            error_report("Mismatched RAM page size %s "
> +                                         "(local) %zd != %" PRId64,
> +                                         id, block->page_size,
> +                                         remote_page_size);
> +                            ret = -EINVAL;
> +                        }
> +                    }
> +                    if (migrate_ignore_shared()) {
> +                        hwaddr addr = qemu_get_be64(f);
> +                        bool ignored = qemu_get_byte(f);
> +                        if (ignored != ramblock_is_ignored(block)) {
> +                            error_report("RAM block %s should %s be migrated",
> +                                         id, ignored ? "" : "not");
> +                            ret = -EINVAL;
> +                        }
> +                        if (ramblock_is_ignored(block) &&
> +                            block->mr->addr != addr) {
> +                            error_report("Mismatched GPAs for block %s "
> +                                         "%" PRId64 "!= %" PRId64,
> +                                         id, (uint64_t)addr,
> +                                         (uint64_t)block->mr->addr);
> +                            ret = -EINVAL;
> +                        }
> +                    }
> +                    ram_control_load_hook(f, RAM_CONTROL_BLOCK_REG,
> +                                          block->idstr);
> +                } else {
> +                    error_report("Unknown ramblock \"%s\", cannot "
> +                                 "accept migration", id);
> +                    ret = -EINVAL;
> +                }
> +
> +                total_ram_bytes -= length;
> +            }
> +            break;
> +
> +        case RAM_SAVE_FLAG_ZERO:
> +            ch = qemu_get_byte(f);
> +            ram_handle_compressed(host, ch, TARGET_PAGE_SIZE);
> +            break;
> +
> +        case RAM_SAVE_FLAG_PAGE:
> +            qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
> +            break;
> +
> +        case RAM_SAVE_FLAG_COMPRESS_PAGE:
> +            len = qemu_get_be32(f);
> +            if (len < 0 || len > compressBound(TARGET_PAGE_SIZE)) {
> +                error_report("Invalid compressed data length: %d", len);
> +                ret = -EINVAL;
> +                break;
> +            }
> +            decompress_data_with_multi_threads(f, host, len);
> +            break;
> +
> +        case RAM_SAVE_FLAG_XBZRLE:
> +            if (load_xbzrle(f, addr, host) < 0) {
> +                error_report("Failed to decompress XBZRLE page at "
> +                             RAM_ADDR_FMT, addr);
> +                ret = -EINVAL;
> +                break;
> +            }
> +            break;
> +        case RAM_SAVE_FLAG_EOS:
> +            /* normal exit */
> +            multifd_recv_sync_main();
> +            break;
> +        default:
> +            if (flags & RAM_SAVE_FLAG_HOOK) {
> +                ram_control_load_hook(f, RAM_CONTROL_HOOK, NULL);
> +            } else {
> +                error_report("Unknown combination of migration flags: %#x",
> +                             flags);
> +                ret = -EINVAL;
> +            }
> +        }
> +        if (!ret) {
> +            ret = qemu_file_get_error(f);
> +        }
> +    }
> +
> +    ret |= wait_for_decompress_done();
> +    rcu_read_unlock();
> +    trace_ram_load_complete(ret, seq_iter);
> +
> +    if (!ret  && migration_incoming_in_colo_state()) {
> +        colo_flush_ram_cache();
> +    }
> +    return ret;
> +}
> +
> +static bool ram_has_postcopy(void *opaque)
> +{
> +    RAMBlock *rb;
> +    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> +        if (ramblock_is_pmem(rb)) {
> +            info_report("Block: %s, host: %p is a nvdimm memory, postcopy"
> +                         "is not supported now!", rb->idstr, rb->host);
> +            return false;
> +        }
> +    }
> +
> +    return migrate_postcopy_ram();
> +}
> +
> +/* Sync all the dirty bitmap with destination VM.  */
> +static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
> +{
> +    RAMBlock *block;
> +    QEMUFile *file = s->to_dst_file;
> +    int ramblock_count = 0;
> +
> +    trace_ram_dirty_bitmap_sync_start();
> +
> +    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +        qemu_savevm_send_recv_bitmap(file, block->idstr);
> +        trace_ram_dirty_bitmap_request(block->idstr);
> +        ramblock_count++;
> +    }
> +
> +    trace_ram_dirty_bitmap_sync_wait();
> +
> +    /* Wait until all the ramblocks' dirty bitmap synced */
> +    while (ramblock_count--) {
> +        qemu_sem_wait(&s->rp_state.rp_sem);
> +    }
> +
> +    trace_ram_dirty_bitmap_sync_complete();
> +
> +    return 0;
> +}
> +
> +static void ram_dirty_bitmap_reload_notify(MigrationState *s)
> +{
> +    qemu_sem_post(&s->rp_state.rp_sem);
> +}
> +
> +/*
> + * Read the received bitmap, revert it as the initial dirty bitmap.
> + * This is only used when the postcopy migration is paused but wants
> + * to resume from a middle point.
> + */
> +int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
> +{
> +    int ret = -EINVAL;
> +    QEMUFile *file = s->rp_state.from_dst_file;
> +    unsigned long *le_bitmap, nbits = block->used_length >> TARGET_PAGE_BITS;
> +    uint64_t local_size = DIV_ROUND_UP(nbits, 8);
> +    uint64_t size, end_mark;
> +
> +    trace_ram_dirty_bitmap_reload_begin(block->idstr);
> +
> +    if (s->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
> +        error_report("%s: incorrect state %s", __func__,
> +                     MigrationStatus_str(s->state));
> +        return -EINVAL;
> +    }
> +
> +    /*
> +     * Note: see comments in ramblock_recv_bitmap_send() on why we
> +     * need the endianess convertion, and the paddings.
> +     */
> +    local_size = ROUND_UP(local_size, 8);
> +
> +    /* Add paddings */
> +    le_bitmap = bitmap_new(nbits + BITS_PER_LONG);
> +
> +    size = qemu_get_be64(file);
> +
> +    /* The size of the bitmap should match with our ramblock */
> +    if (size != local_size) {
> +        error_report("%s: ramblock '%s' bitmap size mismatch "
> +                     "(0x%"PRIx64" != 0x%"PRIx64")", __func__,
> +                     block->idstr, size, local_size);
> +        ret = -EINVAL;
> +        goto out;
> +    }
> +
> +    size = qemu_get_buffer(file, (uint8_t *)le_bitmap, local_size);
> +    end_mark = qemu_get_be64(file);
> +
> +    ret = qemu_file_get_error(file);
> +    if (ret || size != local_size) {
> +        error_report("%s: read bitmap failed for ramblock '%s': %d"
> +                     " (size 0x%"PRIx64", got: 0x%"PRIx64")",
> +                     __func__, block->idstr, ret, local_size, size);
> +        ret = -EIO;
> +        goto out;
> +    }
> +
> +    if (end_mark != RAMBLOCK_RECV_BITMAP_ENDING) {
> +        error_report("%s: ramblock '%s' end mark incorrect: 0x%"PRIu64,
> +                     __func__, block->idstr, end_mark);
> +        ret = -EINVAL;
> +        goto out;
> +    }
> +
> +    /*
> +     * Endianess convertion. We are during postcopy (though paused).
> +     * The dirty bitmap won't change. We can directly modify it.
> +     */
> +    bitmap_from_le(block->bmap, le_bitmap, nbits);
> +
> +    /*
> +     * What we received is "received bitmap". Revert it as the initial
> +     * dirty bitmap for this ramblock.
> +     */
> +    bitmap_complement(block->bmap, block->bmap, nbits);
> +
> +    trace_ram_dirty_bitmap_reload_complete(block->idstr);
> +
> +    /*
> +     * We succeeded to sync bitmap for current ramblock. If this is
> +     * the last one to sync, we need to notify the main send thread.
> +     */
> +    ram_dirty_bitmap_reload_notify(s);
> +
> +    ret = 0;
> +out:
> +    g_free(le_bitmap);
> +    return ret;
> +}
> +
> +static int ram_resume_prepare(MigrationState *s, void *opaque)
> +{
> +    RAMState *rs = *(RAMState **)opaque;
> +    int ret;
> +
> +    ret = ram_dirty_bitmap_sync_all(s, rs);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    ram_state_resume_prepare(rs, s->to_dst_file);
> +
> +    return 0;
> +}
> +
> +static SaveVMHandlers savevm_ram_handlers = {
> +    .save_setup = ram_save_setup,
> +    .save_live_iterate = ram_save_iterate,
> +    .save_live_complete_postcopy = ram_save_complete,
> +    .save_live_complete_precopy = ram_save_complete,
> +    .has_postcopy = ram_has_postcopy,
> +    .save_live_pending = ram_save_pending,
> +    .load_state = ram_load,
> +    .save_cleanup = ram_save_cleanup,
> +    .load_setup = ram_load_setup,
> +    .load_cleanup = ram_load_cleanup,
> +    .resume_prepare = ram_resume_prepare,
> +};
> +
> +void ram_mig_init(void)
> +{
> +    qemu_mutex_init(&XBZRLE.lock);
> +    register_savevm_live(NULL, "ram", 0, 4, &savevm_ram_handlers, &ram_state);
> +}
> diff --git a/migration/ram.c.rej b/migration/ram.c.rej
> new file mode 100644
> index 0000000000..1bcfb8066a
> --- /dev/null
> +++ b/migration/ram.c.rej
> @@ -0,0 +1,33 @@
> +--- migration/ram.c
> ++++ migration/ram.c
> +@@ -3224,15 +3253,30 @@ static int ram_state_init(RAMState **rsp)
> + 
> + static void ram_list_init_bitmaps(void)
> + {
> ++    MigrationState *ms = migrate_get_current();
> +     RAMBlock *block;
> +     unsigned long pages;
> ++    uint8_t shift;
> + 
> +     /* Skip setting bitmap if there is no RAM */
> +     if (ram_bytes_total()) {
> ++        shift = ms->clear_bitmap_shift;
> ++        if (shift > CLEAR_BITMAP_SHIFT_MAX) {
> ++            error_report("clear_bitmap_shift (%u) too big, using "
> ++                         "max value (%u)", shift, CLEAR_BITMAP_SHIFT_MAX);
> ++            shift = CLEAR_BITMAP_SHIFT_MAX;
> ++        } else if (shift < CLEAR_BITMAP_SHIFT_MIN) {
> ++            error_report("clear_bitmap_shift (%u) too small, using "
> ++                         "min value (%u)", shift, CLEAR_BITMAP_SHIFT_MIN);
> ++            shift = CLEAR_BITMAP_SHIFT_MIN;
> ++        }
> ++
> +         RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +             pages = block->max_length >> TARGET_PAGE_BITS;
> +             block->bmap = bitmap_new(pages);
> +             bitmap_set(block->bmap, 0, pages);
> ++            block->clear_bmap_shift = shift;
> ++            block->clear_bmap = bitmap_new(clear_bmap_size(pages, shift));
> +             if (migrate_postcopy_ram()) {
> +                 block->unsentmap = bitmap_new(pages);
> +                 bitmap_set(block->unsentmap, 0, pages);
> diff --git a/migration/trace-events b/migration/trace-events
> index cd50a1e659..d8e54c367a 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -79,6 +79,7 @@ get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned long page_
>  get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, unsigned long page_abs, int sent) "%s/0x%" PRIx64 " page_abs=0x%lx (sent=%d)"
>  migration_bitmap_sync_start(void) ""
>  migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
> +migration_bitmap_clear_dirty(char *str, uint64_t start, uint64_t size, unsigned long page) "rb %s start 0x%"PRIx64" size 0x%"PRIx64" page 0x%lx"
>  migration_throttle(void) ""
>  multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags, uint32_t next_packet_size) "channel %d packet_num %" PRIu64 " pages %d flags 0x%x next packet size %d"
>  multifd_recv_sync_main(long packet_num) "packet num %ld"
> diff --git a/migration/trace-events.orig b/migration/trace-events.orig
> new file mode 100644
> index 0000000000..cd50a1e659
> --- /dev/null
> +++ b/migration/trace-events.orig
> @@ -0,0 +1,297 @@
> +# See docs/devel/tracing.txt for syntax documentation.
> +
> +# savevm.c
> +qemu_loadvm_state_section(unsigned int section_type) "%d"
> +qemu_loadvm_state_section_command(int ret) "%d"
> +qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
> +qemu_loadvm_state_post_main(int ret) "%d"
> +qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
> +qemu_savevm_send_packaged(void) ""
> +loadvm_state_setup(void) ""
> +loadvm_state_cleanup(void) ""
> +loadvm_handle_cmd_packaged(unsigned int length) "%u"
> +loadvm_handle_cmd_packaged_main(int ret) "%d"
> +loadvm_handle_cmd_packaged_received(int ret) "%d"
> +loadvm_handle_recv_bitmap(char *s) "%s"
> +loadvm_postcopy_handle_advise(void) ""
> +loadvm_postcopy_handle_listen(void) ""
> +loadvm_postcopy_handle_run(void) ""
> +loadvm_postcopy_handle_run_cpu_sync(void) ""
> +loadvm_postcopy_handle_run_vmstart(void) ""
> +loadvm_postcopy_handle_resume(void) ""
> +loadvm_postcopy_ram_handle_discard(void) ""
> +loadvm_postcopy_ram_handle_discard_end(void) ""
> +loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s: %ud"
> +loadvm_process_command(uint16_t com, uint16_t len) "com=0x%x len=%d"
> +loadvm_process_command_ping(uint32_t val) "0x%x"
> +postcopy_ram_listen_thread_exit(void) ""
> +postcopy_ram_listen_thread_start(void) ""
> +qemu_savevm_send_postcopy_advise(void) ""
> +qemu_savevm_send_postcopy_ram_discard(const char *id, uint16_t len) "%s: %ud"
> +savevm_command_send(uint16_t command, uint16_t len) "com=0x%x len=%d"
> +savevm_section_start(const char *id, unsigned int section_id) "%s, section_id %u"
> +savevm_section_end(const char *id, unsigned int section_id, int ret) "%s, section_id %u -> %d"
> +savevm_section_skip(const char *id, unsigned int section_id) "%s, section_id %u"
> +savevm_send_open_return_path(void) ""
> +savevm_send_ping(uint32_t val) "0x%x"
> +savevm_send_postcopy_listen(void) ""
> +savevm_send_postcopy_run(void) ""
> +savevm_send_postcopy_resume(void) ""
> +savevm_send_colo_enable(void) ""
> +savevm_send_recv_bitmap(char *name) "%s"
> +savevm_state_setup(void) ""
> +savevm_state_resume_prepare(void) ""
> +savevm_state_header(void) ""
> +savevm_state_iterate(void) ""
> +savevm_state_cleanup(void) ""
> +savevm_state_complete_precopy(void) ""
> +vmstate_save(const char *idstr, const char *vmsd_name) "%s, %s"
> +vmstate_load(const char *idstr, const char *vmsd_name) "%s, %s"
> +postcopy_pause_incoming(void) ""
> +postcopy_pause_incoming_continued(void) ""
> +
> +# vmstate.c
> +vmstate_load_field_error(const char *field, int ret) "field \"%s\" load failed, ret = %d"
> +vmstate_load_state(const char *name, int version_id) "%s v%d"
> +vmstate_load_state_end(const char *name, const char *reason, int val) "%s %s/%d"
> +vmstate_load_state_field(const char *name, const char *field) "%s:%s"
> +vmstate_n_elems(const char *name, int n_elems) "%s: %d"
> +vmstate_subsection_load(const char *parent) "%s"
> +vmstate_subsection_load_bad(const char *parent,  const char *sub, const char *sub2) "%s: %s/%s"
> +vmstate_subsection_load_good(const char *parent) "%s"
> +vmstate_save_state_pre_save_res(const char *name, int res) "%s/%d"
> +vmstate_save_state_loop(const char *name, const char *field, int n_elems) "%s/%s[%d]"
> +vmstate_save_state_top(const char *idstr) "%s"
> +vmstate_subsection_save_loop(const char *name, const char *sub) "%s/%s"
> +vmstate_subsection_save_top(const char *idstr) "%s"
> +
> +# vmstate-types.c
> +get_qtailq(const char *name, int version_id) "%s v%d"
> +get_qtailq_end(const char *name, const char *reason, int val) "%s %s/%d"
> +put_qtailq(const char *name, int version_id) "%s v%d"
> +put_qtailq_end(const char *name, const char *reason) "%s %s"
> +
> +# qemu-file.c
> +qemu_file_fclose(void) ""
> +
> +# ram.c
> +get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=0x%lx"
> +get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, unsigned long page_abs, int sent) "%s/0x%" PRIx64 " page_abs=0x%lx (sent=%d)"
> +migration_bitmap_sync_start(void) ""
> +migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
> +migration_throttle(void) ""
> +multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags, uint32_t next_packet_size) "channel %d packet_num %" PRIu64 " pages %d flags 0x%x next packet size %d"
> +multifd_recv_sync_main(long packet_num) "packet num %ld"
> +multifd_recv_sync_main_signal(uint8_t id) "channel %d"
> +multifd_recv_sync_main_wait(uint8_t id) "channel %d"
> +multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "channel %d packets %" PRIu64 " pages %" PRIu64
> +multifd_recv_thread_start(uint8_t id) "%d"
> +multifd_send(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags, uint32_t next_packet_size) "channel %d packet_num %" PRIu64 " pages %d flags 0x%x next packet size %d"
> +multifd_send_sync_main(long packet_num) "packet num %ld"
> +multifd_send_sync_main_signal(uint8_t id) "channel %d"
> +multifd_send_sync_main_wait(uint8_t id) "channel %d"
> +multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "channel %d packets %" PRIu64 " pages %"  PRIu64
> +multifd_send_thread_start(uint8_t id) "%d"
> +ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: start: %" PRIx64 " %zx"
> +ram_load_loop(const char *rbname, uint64_t addr, int flags, void *host) "%s: addr: 0x%" PRIx64 " flags: 0x%x host: %p"
> +ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
> +ram_postcopy_send_discard_bitmap(void) ""
> +ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: 0x%" PRIx64 " host: %p"
> +ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: 0x%zx len: 0x%zx"
> +ram_dirty_bitmap_request(char *str) "%s"
> +ram_dirty_bitmap_reload_begin(char *str) "%s"
> +ram_dirty_bitmap_reload_complete(char *str) "%s"
> +ram_dirty_bitmap_sync_start(void) ""
> +ram_dirty_bitmap_sync_wait(void) ""
> +ram_dirty_bitmap_sync_complete(void) ""
> +ram_state_resume_prepare(uint64_t v) "%" PRId64
> +colo_flush_ram_cache_begin(uint64_t dirty_pages) "dirty_pages %" PRIu64
> +colo_flush_ram_cache_end(void) ""
> +save_xbzrle_page_skipping(void) ""
> +save_xbzrle_page_overflow(void) ""
> +ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
> +ram_load_complete(int ret, uint64_t seq_iter) "exit_code %d seq iteration %" PRIu64
> +
> +# migration.c
> +await_return_path_close_on_source_close(void) ""
> +await_return_path_close_on_source_joining(void) ""
> +migrate_set_state(const char *new_state) "new state %s"
> +migrate_fd_cleanup(void) ""
> +migrate_fd_error(const char *error_desc) "error=%s"
> +migrate_fd_cancel(void) ""
> +migrate_handle_rp_req_pages(const char *rbname, size_t start, size_t len) "in %s at 0x%zx len 0x%zx"
> +migrate_pending(uint64_t size, uint64_t max, uint64_t pre, uint64_t compat, uint64_t post) "pending size %" PRIu64 " max %" PRIu64 " (pre = %" PRIu64 " compat=%" PRIu64 " post=%" PRIu64 ")"
> +migrate_send_rp_message(int msg_type, uint16_t len) "%d: len %d"
> +migrate_send_rp_recv_bitmap(char *name, int64_t size) "block '%s' size 0x%"PRIi64
> +migration_completion_file_err(void) ""
> +migration_completion_postcopy_end(void) ""
> +migration_completion_postcopy_end_after_complete(void) ""
> +migration_return_path_end_before(void) ""
> +migration_return_path_end_after(int rp_error) "%d"
> +migration_thread_after_loop(void) ""
> +migration_thread_file_err(void) ""
> +migration_thread_ratelimit_pre(int ms) "%d ms"
> +migration_thread_ratelimit_post(int urgent) "urgent: %d"
> +migration_thread_setup_complete(void) ""
> +open_return_path_on_source(void) ""
> +open_return_path_on_source_continue(void) ""
> +postcopy_start(void) ""
> +postcopy_pause_return_path(void) ""
> +postcopy_pause_return_path_continued(void) ""
> +postcopy_pause_continued(void) ""
> +postcopy_start_set_run(void) ""
> +source_return_path_thread_bad_end(void) ""
> +source_return_path_thread_end(void) ""
> +source_return_path_thread_entry(void) ""
> +source_return_path_thread_loop_top(void) ""
> +source_return_path_thread_pong(uint32_t val) "0x%x"
> +source_return_path_thread_shut(uint32_t val) "0x%x"
> +source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
> +migration_thread_low_pending(uint64_t pending) "%" PRIu64
> +migrate_transferred(uint64_t tranferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
> +process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
> +process_incoming_migration_co_postcopy_end_main(void) ""
> +
> +# channel.c
> +migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
> +migration_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname, void *err)  "ioc=%p ioctype=%s hostname=%s err=%p"
> +
> +# global_state.c
> +migrate_state_too_big(void) ""
> +migrate_global_state_post_load(const char *state) "loaded state: %s"
> +migrate_global_state_pre_save(const char *state) "saved state: %s"
> +
> +# rdma.c
> +qemu_rdma_accept_incoming_migration(void) ""
> +qemu_rdma_accept_incoming_migration_accepted(void) ""
> +qemu_rdma_accept_pin_state(bool pin) "%d"
> +qemu_rdma_accept_pin_verbsc(void *verbs) "Verbs context after listen: %p"
> +qemu_rdma_block_for_wrid_miss(const char *wcompstr, int wcomp, const char *gcompstr, uint64_t req) "A Wanted wrid %s (%d) but got %s (%" PRIu64 ")"
> +qemu_rdma_cleanup_disconnect(void) ""
> +qemu_rdma_close(void) ""
> +qemu_rdma_connect_pin_all_requested(void) ""
> +qemu_rdma_connect_pin_all_outcome(bool pin) "%d"
> +qemu_rdma_dest_init_trying(const char *host, const char *ip) "%s => %s"
> +qemu_rdma_dump_gid(const char *who, const char *src, const char *dst) "%s Source GID: %s, Dest GID: %s"
> +qemu_rdma_exchange_get_response_start(const char *desc) "CONTROL: %s receiving..."
> +qemu_rdma_exchange_get_response_none(const char *desc, int type) "Surprise: got %s (%d)"
> +qemu_rdma_exchange_send_issue_callback(void) ""
> +qemu_rdma_exchange_send_waiting(const char *desc) "Waiting for response %s"
> +qemu_rdma_exchange_send_received(const char *desc) "Response %s received."
> +qemu_rdma_fill(size_t control_len, size_t size) "RDMA %zd of %zd bytes already in buffer"
> +qemu_rdma_init_ram_blocks(int blocks) "Allocated %d local ram block structures"
> +qemu_rdma_poll_recv(const char *compstr, int64_t comp, int64_t id, int sent) "completion %s #%" PRId64 " received (%" PRId64 ") left %d"
> +qemu_rdma_poll_write(const char *compstr, int64_t comp, int left, uint64_t block, uint64_t chunk, void *local, void *remote) "completions %s (%" PRId64 ") left %d, block %" PRIu64 ", chunk: %" PRIu64 " %p %p"
> +qemu_rdma_poll_other(const char *compstr, int64_t comp, int left) "other completion %s (%" PRId64 ") received left %d"
> +qemu_rdma_post_send_control(const char *desc) "CONTROL: sending %s.."
> +qemu_rdma_register_and_get_keys(uint64_t len, void *start) "Registering %" PRIu64 " bytes @ %p"
> +qemu_rdma_registration_handle_compress(int64_t length, int index, int64_t offset) "Zapping zero chunk: %" PRId64 " bytes, index %d, offset %" PRId64
> +qemu_rdma_registration_handle_finished(void) ""
> +qemu_rdma_registration_handle_ram_blocks(void) ""
> +qemu_rdma_registration_handle_ram_blocks_loop(const char *name, uint64_t offset, uint64_t length, void *local_host_addr, unsigned int src_index) "%s: @0x%" PRIx64 "/%" PRIu64 " host:@%p src_index: %u"
> +qemu_rdma_registration_handle_register(int requests) "%d requests"
> +qemu_rdma_registration_handle_register_loop(int req, int index, uint64_t addr, uint64_t chunks) "Registration request (%d): index %d, current_addr %" PRIu64 " chunks: %" PRIu64
> +qemu_rdma_registration_handle_register_rkey(int rkey) "0x%x"
> +qemu_rdma_registration_handle_unregister(int requests) "%d requests"
> +qemu_rdma_registration_handle_unregister_loop(int count, int index, uint64_t chunk) "Unregistration request (%d): index %d, chunk %" PRIu64
> +qemu_rdma_registration_handle_unregister_success(uint64_t chunk) "%" PRIu64
> +qemu_rdma_registration_handle_wait(void) ""
> +qemu_rdma_registration_start(uint64_t flags) "%" PRIu64
> +qemu_rdma_registration_stop(uint64_t flags) "%" PRIu64
> +qemu_rdma_registration_stop_ram(void) ""
> +qemu_rdma_resolve_host_trying(const char *host, const char *ip) "Trying %s => %s"
> +qemu_rdma_signal_unregister_append(uint64_t chunk, int pos) "Appending unregister chunk %" PRIu64 " at position %d"
> +qemu_rdma_signal_unregister_already(uint64_t chunk) "Unregister chunk %" PRIu64 " already in queue"
> +qemu_rdma_unregister_waiting_inflight(uint64_t chunk) "Cannot unregister inflight chunk: %" PRIu64
> +qemu_rdma_unregister_waiting_proc(uint64_t chunk, int pos) "Processing unregister for chunk: %" PRIu64 " at position %d"
> +qemu_rdma_unregister_waiting_send(uint64_t chunk) "Sending unregister for chunk: %" PRIu64
> +qemu_rdma_unregister_waiting_complete(uint64_t chunk) "Unregister for chunk: %" PRIu64 " complete."
> +qemu_rdma_write_flush(int sent) "sent total: %d"
> +qemu_rdma_write_one_block(int count, int block, uint64_t chunk, uint64_t current, uint64_t len, int nb_sent, int nb_chunks) "(%d) Not clobbering: block: %d chunk %" PRIu64 " current %" PRIu64 " len %" PRIu64 " %d %d"
> +qemu_rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRIu32
> +qemu_rdma_write_one_queue_full(void) ""
> +qemu_rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) "Received registration result: my key: 0x%x their key 0x%x, chunk %" PRIu64
> +qemu_rdma_write_one_sendreg(uint64_t chunk, int len, int index, int64_t offset) "Sending registration request chunk %" PRIu64 " for %d bytes, index: %d, offset: %" PRId64
> +qemu_rdma_write_one_top(uint64_t chunks, uint64_t size) "Writing %" PRIu64 " chunks, (%" PRIu64 " MB)"
> +qemu_rdma_write_one_zero(uint64_t chunk, int len, int index, int64_t offset) "Entire chunk is zero, sending compress: %" PRIu64 " for %d bytes, index: %d, offset: %" PRId64
> +rdma_add_block(const char *block_name, int block, uint64_t addr, uint64_t offset, uint64_t len, uint64_t end, uint64_t bits, int chunks) "Added Block: '%s':%d, addr: %" PRIu64 ", offset: %" PRIu64 " length: %" PRIu64 " end: %" PRIu64 " bits %" PRIu64 " chunks %d"
> +rdma_block_notification_handle(const char *name, int index) "%s at %d"
> +rdma_delete_block(void *block, uint64_t addr, uint64_t offset, uint64_t len, uint64_t end, uint64_t bits, int chunks) "Deleted Block: %p, addr: %" PRIu64 ", offset: %" PRIu64 " length: %" PRIu64 " end: %" PRIu64 " bits %" PRIu64 " chunks %d"
> +rdma_start_incoming_migration(void) ""
> +rdma_start_incoming_migration_after_dest_init(void) ""
> +rdma_start_incoming_migration_after_rdma_listen(void) ""
> +rdma_start_outgoing_migration_after_rdma_connect(void) ""
> +rdma_start_outgoing_migration_after_rdma_source_init(void) ""
> +
> +# postcopy-ram.c
> +postcopy_discard_send_finish(const char *ramblock, int nwords, int ncmds) "%s mask words sent=%d in %d commands"
> +postcopy_discard_send_range(const char *ramblock, unsigned long start, unsigned long length) "%s:%lx/%lx"
> +postcopy_cleanup_range(const char *ramblock, void *host_addr, size_t offset, size_t length) "%s: %p offset=0x%zx length=0x%zx"
> +postcopy_init_range(const char *ramblock, void *host_addr, size_t offset, size_t length) "%s: %p offset=0x%zx length=0x%zx"
> +postcopy_nhp_range(const char *ramblock, void *host_addr, size_t offset, size_t length) "%s: %p offset=0x%zx length=0x%zx"
> +postcopy_place_page(void *host_addr) "host=%p"
> +postcopy_place_page_zero(void *host_addr) "host=%p"
> +postcopy_ram_enable_notify(void) ""
> +mark_postcopy_blocktime_begin(uint64_t addr, void *dd, uint32_t time, int cpu, int received) "addr: 0x%" PRIx64 ", dd: %p, time: %u, cpu: %d, already_received: %d"
> +mark_postcopy_blocktime_end(uint64_t addr, void *dd, uint32_t time, int affected_cpu) "addr: 0x%" PRIx64 ", dd: %p, time: %u, affected_cpu: %d"
> +postcopy_pause_fault_thread(void) ""
> +postcopy_pause_fault_thread_continued(void) ""
> +postcopy_ram_fault_thread_entry(void) ""
> +postcopy_ram_fault_thread_exit(void) ""
> +postcopy_ram_fault_thread_fds_core(int baseufd, int quitfd) "ufd: %d quitfd: %d"
> +postcopy_ram_fault_thread_fds_extra(size_t index, const char *name, int fd) "%zd/%s: %d"
> +postcopy_ram_fault_thread_quit(void) ""
> +postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset, uint32_t pid) "Request for HVA=0x%" PRIx64 " rb=%s offset=0x%zx pid=%u"
> +postcopy_ram_incoming_cleanup_closeuf(void) ""
> +postcopy_ram_incoming_cleanup_entry(void) ""
> +postcopy_ram_incoming_cleanup_exit(void) ""
> +postcopy_ram_incoming_cleanup_join(void) ""
> +postcopy_ram_incoming_cleanup_blocktime(uint64_t total) "total blocktime %" PRIu64
> +postcopy_request_shared_page(const char *sharer, const char *rb, uint64_t rb_offset) "for %s in %s offset 0x%"PRIx64
> +postcopy_request_shared_page_present(const char *sharer, const char *rb, uint64_t rb_offset) "%s already %s offset 0x%"PRIx64
> +postcopy_wake_shared(uint64_t client_addr, const char *rb) "at 0x%"PRIx64" in %s"
> +
> +get_mem_fault_cpu_index(int cpu, uint32_t pid) "cpu: %d, pid: %u"
> +
> +# exec.c
> +migration_exec_outgoing(const char *cmd) "cmd=%s"
> +migration_exec_incoming(const char *cmd) "cmd=%s"
> +
> +# fd.c
> +migration_fd_outgoing(int fd) "fd=%d"
> +migration_fd_incoming(int fd) "fd=%d"
> +
> +# socket.c
> +migration_socket_incoming_accepted(void) ""
> +migration_socket_outgoing_connected(const char *hostname) "hostname=%s"
> +migration_socket_outgoing_error(const char *err) "error=%s"
> +
> +# tls.c
> +migration_tls_outgoing_handshake_start(const char *hostname) "hostname=%s"
> +migration_tls_outgoing_handshake_error(const char *err) "err=%s"
> +migration_tls_outgoing_handshake_complete(void) ""
> +migration_tls_incoming_handshake_start(void) ""
> +migration_tls_incoming_handshake_error(const char *err) "err=%s"
> +migration_tls_incoming_handshake_complete(void) ""
> +
> +# colo.c
> +colo_vm_state_change(const char *old, const char *new) "Change '%s' => '%s'"
> +colo_send_message(const char *msg) "Send '%s' message"
> +colo_receive_message(const char *msg) "Receive '%s' message"
> +
> +# colo-failover.c
> +colo_failover_set_state(const char *new_state) "new state %s"
> +
> +# block-dirty-bitmap.c
> +send_bitmap_header_enter(void) ""
> +send_bitmap_bits(uint32_t flags, uint64_t start_sector, uint32_t nr_sectors, uint64_t data_size) "flags: 0x%x, start_sector: %" PRIu64 ", nr_sectors: %" PRIu32 ", data_size: %" PRIu64
> +dirty_bitmap_save_iterate(int in_postcopy) "in postcopy: %d"
> +dirty_bitmap_save_complete_enter(void) ""
> +dirty_bitmap_save_complete_finish(void) ""
> +dirty_bitmap_save_pending(uint64_t pending, uint64_t max_size) "pending %" PRIu64 " max: %" PRIu64
> +dirty_bitmap_load_complete(void) ""
> +dirty_bitmap_load_bits_enter(uint64_t first_sector, uint32_t nr_sectors) "chunk: %" PRIu64 " %" PRIu32
> +dirty_bitmap_load_bits_zeroes(void) ""
> +dirty_bitmap_load_header(uint32_t flags) "flags 0x%x"
> +dirty_bitmap_load_enter(void) ""
> +dirty_bitmap_load_success(void) ""
> -- 
> 2.21.0
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

