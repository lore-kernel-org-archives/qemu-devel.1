Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D96CC742A1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 320FB208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320FB208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hleOO-0001kT-8G
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 15:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36392)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hleOC-0001M6-3q
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hleO9-00085w-Qc
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:05:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37486)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hleO9-0007yc-FN
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:05:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1C4DC308FC4E;
 Thu, 11 Jul 2019 19:05:46 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 798165D71A;
 Thu, 11 Jul 2019 19:05:44 +0000 (UTC)
Date: Thu, 11 Jul 2019 20:05:41 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Message-ID: <20190711190541.GU3971@work-vm>
References: <20190710202219.25939-1-brijesh.singh@amd.com>
 <20190710202219.25939-5-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710202219.25939-5-brijesh.singh@amd.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 11 Jul 2019 19:05:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 04/13] kvm: add support to sync the page
 encryption state bitmap
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Lendacky,
 Thomas" <Thomas.Lendacky@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Singh, Brijesh (brijesh.singh@amd.com) wrote:
> The SEV VMs have concept of private and shared memory. The private memory
> is encrypted with guest-specific key, while shared memory may be encrypted
> with hyperivosr key. The KVM_GET_PAGE_ENC_BITMAP can be used to get a
> bitmap indicating whether the guest page is private or shared. A private
> page must be transmitted using the SEV migration commands.
> 
> Add a cpu_physical_memory_sync_encrypted_bitmap() which can be used to sync
> the page encryption bitmap for a given memory region.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  accel/kvm/kvm-all.c     |  38 ++++++++++
>  include/exec/ram_addr.h | 161 ++++++++++++++++++++++++++++++++++++++--
>  include/exec/ramlist.h  |   3 +-
>  migration/ram.c         |  28 ++++++-
>  4 files changed, 222 insertions(+), 8 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 162a2d5085..c935e9366c 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -504,6 +504,37 @@ static int kvm_get_dirty_pages_log_range(MemoryRegionSection *section,
>  
>  #define ALIGN(x, y)  (((x)+(y)-1) & ~((y)-1))
>  
> +/* sync page_enc bitmap */
> +static int kvm_sync_page_enc_bitmap(KVMMemoryListener *kml,
> +                                    MemoryRegionSection *section,
> +                                    KVMSlot *mem)

How AMD/SEV specific is this? i.e. should this be in a target/ specific
place? 

> +{
> +    unsigned long size;
> +    KVMState *s = kvm_state;
> +    struct kvm_page_enc_bitmap e = {};
> +    ram_addr_t pages = int128_get64(section->size) / getpagesize();
> +    ram_addr_t start = section->offset_within_region +
> +                       memory_region_get_ram_addr(section->mr);
> +
> +    size = ALIGN(((mem->memory_size) >> TARGET_PAGE_BITS),
> +                 /*HOST_LONG_BITS*/ 64) / 8;
> +    e.enc_bitmap = g_malloc0(size);
> +    e.start_gfn = mem->start_addr >> TARGET_PAGE_BITS;
> +    e.num_pages = pages;
> +    if (kvm_vm_ioctl(s, KVM_GET_PAGE_ENC_BITMAP, &e) == -1) {
> +        DPRINTF("KVM_GET_PAGE_ENC_BITMAP ioctl failed %d\n", errno);
> +        g_free(e.enc_bitmap);
> +        return 1;
> +    }
> +
> +    cpu_physical_memory_set_encrypted_lebitmap(e.enc_bitmap,
> +                                               start, pages);
> +
> +    g_free(e.enc_bitmap);
> +
> +    return 0;
> +}
> +
>  /**
>   * kvm_physical_sync_dirty_bitmap - Grab dirty bitmap from kernel space
>   * This function updates qemu's dirty bitmap using
> @@ -553,6 +584,13 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
>          }
>  
>          kvm_get_dirty_pages_log_range(section, d.dirty_bitmap);
> +
> +        if (kvm_memcrypt_enabled() &&
> +            kvm_sync_page_enc_bitmap(kml, section, mem)) {
> +            g_free(d.dirty_bitmap);
> +            return -1;
> +        }
> +
>          g_free(d.dirty_bitmap);
>      }
>  
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index f96777bb99..6fc6864194 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -51,6 +51,8 @@ struct RAMBlock {
>      unsigned long *unsentmap;
>      /* bitmap of already received pages in postcopy */
>      unsigned long *receivedmap;
> +    /* bitmap of page encryption state for an encrypted guest */
> +    unsigned long *encbmap;
>  };
>  
>  static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
> @@ -314,9 +316,41 @@ static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
>  }
>  
>  #if !defined(_WIN32)
> -static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
> +
> +static inline void cpu_physical_memory_set_encrypted_range(ram_addr_t start,
> +                                                           ram_addr_t length,
> +                                                           unsigned long val)
> +{
> +    unsigned long end, page;
> +    unsigned long * const *src;
> +
> +    if (length == 0) {
> +        return;
> +    }
> +
> +    end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
> +    page = start >> TARGET_PAGE_BITS;
> +
> +    rcu_read_lock();
> +
> +    src = atomic_rcu_read(&ram_list.dirty_memory[DIRTY_MEMORY_ENCRYPTED])->blocks;
> +
> +    while (page < end) {
> +        unsigned long idx = page / DIRTY_MEMORY_BLOCK_SIZE;
> +        unsigned long offset = page % DIRTY_MEMORY_BLOCK_SIZE;
> +        unsigned long num = MIN(end - page, DIRTY_MEMORY_BLOCK_SIZE - offset);
> +
> +        atomic_xchg(&src[idx][BIT_WORD(offset)], val);
> +        page += num;
> +    }
> +
> +    rcu_read_unlock();
> +}
> +
> +static inline void cpu_physical_memory_set_dirty_enc_lebitmap(unsigned long *bitmap,
>                                                            ram_addr_t start,
> -                                                          ram_addr_t pages)
> +                                                          ram_addr_t pages,
> +                                                          bool enc_map)
>  {
>      unsigned long i, j;
>      unsigned long page_number, c;
> @@ -349,10 +383,14 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>              if (bitmap[k]) {
>                  unsigned long temp = leul_to_cpu(bitmap[k]);
>  
> -                atomic_or(&blocks[DIRTY_MEMORY_MIGRATION][idx][offset], temp);
> -                atomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp);
> -                if (tcg_enabled()) {
> -                    atomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset], temp);
> +                if (enc_map) {
> +                    atomic_xchg(&blocks[DIRTY_MEMORY_ENCRYPTED][idx][offset], temp);

It makes me nervous that this is almost but not exactly like the other
bitmaps;  I *think* you're saying the bits here are purely a matter of
state about whether the page is encrypted and not a matter of actually
dirtyness; in particular a page that is encrypted and then becomes dirty
doesn't reset or clear this flag.

> +                } else {
> +                    atomic_or(&blocks[DIRTY_MEMORY_MIGRATION][idx][offset], temp);
> +                    atomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp);
> +                    if (tcg_enabled()) {
> +                        atomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset], temp);
> +                    }
>                  }
>              }
>  
> @@ -372,6 +410,17 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>           * especially when most of the memory is not dirty.
>           */
>          for (i = 0; i < len; i++) {
> +
> +            /* If its encrypted bitmap update, then we need to copy the bitmap
> +             * value as-is to the destination.
> +             */
> +            if (enc_map) {
> +                cpu_physical_memory_set_encrypted_range(start + i * TARGET_PAGE_SIZE,
> +                                                        TARGET_PAGE_SIZE * hpratio,
> +                                                        leul_to_cpu(bitmap[i]));
> +                continue;
> +            }
> +
>              if (bitmap[i] != 0) {
>                  c = leul_to_cpu(bitmap[i]);
>                  do {
> @@ -387,6 +436,21 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>          }
>      }
>  }
> +
> +static inline void cpu_physical_memory_set_encrypted_lebitmap(unsigned long *bitmap,
> +                                                              ram_addr_t start,
> +                                                              ram_addr_t pages)
> +{
> +    return cpu_physical_memory_set_dirty_enc_lebitmap(bitmap, start, pages, true);
> +}
> +
> +static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
> +                                                          ram_addr_t start,
> +                                                          ram_addr_t pages)
> +{
> +    return cpu_physical_memory_set_dirty_enc_lebitmap(bitmap, start, pages, false);
> +}
> +
>  #endif /* not _WIN32 */
>  
>  bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
> @@ -406,6 +470,7 @@ static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
>      cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_MIGRATION);
>      cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_VGA);
>      cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_CODE);
> +    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_ENCRYPTED);

What are the ordering/consistency rules associated with this data.
Specifically:

  Consider a page that transitions from being shared to encrypted
(does that happen?) - but we've just done the sync's so we know the page
is dirty, but we don't know it's encrypted; so we transmit the page as
unencrypted; what happens?

  I *think* that means we should always sync the encryped bitmap before
the dirty bitmap, so that if it flips we're guaranteed the dirty bitmap
gets flipped again after the flip has happened; but my brain is starting
to hurt....

  But, even if we're guaranteed to have a dirty for the next time
around, I think we're always at risk of transmitting a page that
has just flipped; so we'll be sure to transmit it again correctly,
but we might transmit an encrypted page to a non-encrypted dest or
the reverse - is that OK?


>  }
>  
>  
> @@ -474,5 +539,89 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>  
>      return num_dirty;
>  }
> +
> +static inline bool cpu_physical_memory_test_encrypted(ram_addr_t start,
> +                                                      ram_addr_t length)
> +{
> +    unsigned long end, page;
> +    bool enc = false;
> +    unsigned long * const *src;
> +
> +    if (length == 0) {
> +        return enc;
> +    }
> +
> +    end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
> +    page = start >> TARGET_PAGE_BITS;
> +
> +    rcu_read_lock();
> +
> +    src = atomic_rcu_read(&ram_list.dirty_memory[DIRTY_MEMORY_ENCRYPTED])->blocks;
> +
> +    while (page < end) {
> +        unsigned long idx = page / DIRTY_MEMORY_BLOCK_SIZE;
> +        unsigned long offset = page % DIRTY_MEMORY_BLOCK_SIZE;
> +        unsigned long num = MIN(end - page, DIRTY_MEMORY_BLOCK_SIZE - offset);
> +
> +        enc |= atomic_read(&src[idx][BIT_WORD(offset)]);

I'm confused; I thought what I was about to get there was a long* and
you were going to mask out a bit or set of bits.

> +        page += num;
> +    }
> +
> +    rcu_read_unlock();
> +
> +    return enc;
> +}
> +
> +static inline
> +void cpu_physical_memory_sync_encrypted_bitmap(RAMBlock *rb,
> +                                               ram_addr_t start,
> +                                               ram_addr_t length)
> +{
> +    ram_addr_t addr;
> +    unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
> +    unsigned long *dest = rb->encbmap;
> +
> +    /* start address and length is aligned at the start of a word? */
> +    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) ==
> +         (start + rb->offset) &&
> +        !(length & ((BITS_PER_LONG << TARGET_PAGE_BITS) - 1))) {
> +        int k;
> +        int nr = BITS_TO_LONGS(length >> TARGET_PAGE_BITS);

Feels odd it's an int.

> +        unsigned long * const *src;
> +        unsigned long idx = (word * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_SIZE;
> +        unsigned long offset = BIT_WORD((word * BITS_PER_LONG) %
> +                                        DIRTY_MEMORY_BLOCK_SIZE);
> +        unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
> +
> +        rcu_read_lock();
> +
> +        src = atomic_rcu_read(
> +                &ram_list.dirty_memory[DIRTY_MEMORY_ENCRYPTED])->blocks;
> +
> +        for (k = page; k < page + nr; k++) {
> +            unsigned long bits = atomic_read(&src[idx][offset]);
> +            dest[k] = bits;
> +
> +            if (++offset >= BITS_TO_LONGS(DIRTY_MEMORY_BLOCK_SIZE)) {
> +                offset = 0;
> +                idx++;
> +            }
> +        }
> +
> +        rcu_read_unlock();
> +    } else {
> +        ram_addr_t offset = rb->offset;
> +
> +        for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
> +            long k = (start + addr) >> TARGET_PAGE_BITS;
> +            if (cpu_physical_memory_test_encrypted(start + addr + offset,
> +                                                   TARGET_PAGE_SIZE)) {
> +                set_bit(k, dest);
> +            } else {
> +                clear_bit(k, dest);
> +            }
> +        }
> +    }
> +}
>  #endif
>  #endif
> diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
> index bc4faa1b00..2a5eab8b11 100644
> --- a/include/exec/ramlist.h
> +++ b/include/exec/ramlist.h
> @@ -11,7 +11,8 @@ typedef struct RAMBlockNotifier RAMBlockNotifier;
>  #define DIRTY_MEMORY_VGA       0
>  #define DIRTY_MEMORY_CODE      1
>  #define DIRTY_MEMORY_MIGRATION 2
> -#define DIRTY_MEMORY_NUM       3        /* num of dirty bits */
> +#define DIRTY_MEMORY_ENCRYPTED 3
> +#define DIRTY_MEMORY_NUM       4        /* num of dirty bits */
>  
>  /* The dirty memory bitmap is split into fixed-size blocks to allow growth
>   * under RCU.  The bitmap for a block can be accessed as follows:
> diff --git a/migration/ram.c b/migration/ram.c
> index 3c8977d508..d179867e1b 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1680,6 +1680,9 @@ static void migration_bitmap_sync_range(RAMState *rs, RAMBlock *rb,
>      rs->migration_dirty_pages +=
>          cpu_physical_memory_sync_dirty_bitmap(rb, 0, length,
>                                                &rs->num_dirty_pages_period);
> +    if (kvm_memcrypt_enabled()) {
> +        cpu_physical_memory_sync_encrypted_bitmap(rb, 0, length);
> +    }
>  }
>  
>  /**
> @@ -2465,6 +2468,22 @@ static bool save_compress_page(RAMState *rs, RAMBlock *block, ram_addr_t offset)
>      return false;
>  }
>  
> +/**
> + * encrypted_test_bitmap: check if the page is encrypted
> + *
> + * Returns a bool indicating whether the page is encrypted.
> + */
> +static bool encrypted_test_bitmap(RAMState *rs, RAMBlock *block,
> +                                  unsigned long page)
> +{
> +    /* ROM devices contains the unencrypted data */
> +    if (memory_region_is_rom(block->mr)) {
> +        return false;
> +    }
> +
> +    return test_bit(page, block->encbmap);
> +}
> +
>  /**
>   * ram_save_target_page: save one target page
>   *
> @@ -2491,7 +2510,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
>       * will take care of accessing the guest memory and re-encrypt it
>       * for the transport purposes.
>       */
> -     if (kvm_memcrypt_enabled()) {
> +     if (kvm_memcrypt_enabled() &&
> +         encrypted_test_bitmap(rs, pss->block, pss->page)) {
>          return ram_save_encrypted_page(rs, pss, last_stage);
>       }
>  
> @@ -2724,6 +2744,8 @@ static void ram_save_cleanup(void *opaque)
>          block->bmap = NULL;
>          g_free(block->unsentmap);
>          block->unsentmap = NULL;
> +        g_free(block->encbmap);
> +        block->encbmap = NULL;
>      }
>  
>      xbzrle_cleanup();
> @@ -3251,6 +3273,10 @@ static void ram_list_init_bitmaps(void)
>                  block->unsentmap = bitmap_new(pages);
>                  bitmap_set(block->unsentmap, 0, pages);
>              }
> +            if (kvm_memcrypt_enabled()) {
> +                block->encbmap = bitmap_new(pages);
> +                bitmap_set(block->encbmap, 0, pages);
> +            }
>          }
>      }
>  }
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

