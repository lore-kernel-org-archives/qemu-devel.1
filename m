Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AADC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 08:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED24821670
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 08:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED24821670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA91I-0001qS-6c
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 04:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iA90S-0001QD-AS
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iA90P-0005Vs-9g
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:38:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36468)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iA90O-0005Sv-Ut
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:38:37 -0400
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 66CB98553D
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 08:38:35 +0000 (UTC)
Received: by mail-pg1-f198.google.com with SMTP id k18so833261pgh.22
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 01:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5j0YaWbqTFkp/dpyMGQ24tQae5zep7HhufaLej/f1iw=;
 b=tc6cnVBQctnXVsfUfXq9HLuTqdNDdswrO9pGdeOEh8I3BwxLUpSQbUJcJmO0WQrMz5
 Fk/edvXxcseEnbyAu7Mbry9wNNukLNam9/pZXL+pMcvO87+HGLOVCSCKSUQ94jUmbuRg
 P2ixAwMVVx6pau7pg05BmRlATZJHCkTCVDcwihx8RIGdC0mWi7DxgUDMNt8hx8CO+9Aq
 Ug6K0uDDQoLd97mXo/sqQRf0cDllhnUkOBQR1lX405ignbUaFohhFDcQb5COrqoR7wzc
 UY0uMuq+9HUsXYg95duilZw/nJfe+8vhRibDoFjHQVzRP4VL+y9mQbzHQK1EINO+PvOW
 xxwg==
X-Gm-Message-State: APjAAAVT6KVTdyejovPRDeoUtQNHeTPPcP7G+0HQQ6694N+kDLFO9q5R
 AFzHuMET5ELB6tXizwoeYyc4k+oQBIY657TgG9S7Jd/VJbDpiJ5zLt1dfcKT0i+8CxGWXQb3bSD
 XC4sctiHf1csP5KY=
X-Received: by 2002:a62:7790:: with SMTP id s138mr2092377pfc.57.1568709514825; 
 Tue, 17 Sep 2019 01:38:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw34cH88vsheKUjOENiqbwzSMw+UCebF4UTCKuD1075KhuULw/bI3KqcZms0kJ4M3rRx6lVcw==
X-Received: by 2002:a62:7790:: with SMTP id s138mr2092353pfc.57.1568709514457; 
 Tue, 17 Sep 2019 01:38:34 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 202sm3843328pfu.161.2019.09.17.01.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 01:38:33 -0700 (PDT)
Date: Tue, 17 Sep 2019 16:38:24 +0800
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190917083824.GD30562@xz-x1>
References: <20190916132347.30676-1-imammedo@redhat.com>
 <20190916132347.30676-2-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190916132347.30676-2-imammedo@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 1/2] kvm: s390: split too big memory
 section on several memslots
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, qemu-s390x@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 16, 2019 at 09:23:46AM -0400, Igor Mammedov wrote:
> Max memslot size supported by kvm on s390 is 8Tb,
> move logic of splitting RAM in chunks upto 8T to KVM code.
> 
> This way it will hide KVM specific restrictions in KVM code
> and won't affect board level design decisions. Which would allow
> us to avoid misusing memory_region_allocate_system_memory() API
> and eventually use a single hostmem backend for guest RAM.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> Since there is quite a bit of migration related code churn in the patch
> CCing migration maintainer
> 
> CC: dgilbert@redhat.com
> 
> v6:
>   * KVM's migration code was assuming 1:1 relation between
>     memslot and MemorySection, which becomes not true fo s390x
>     with this patch. As result migration was broken and
>     dirty logging wasn't even started with when a MemorySection
>     was split on several memslots. Amend related KVM dirty
>     log tracking code to account for split MemorySection.
> v5:
>   * move computation 'size -= slot_size' inside of loop body
>           (David Hildenbrand <david@redhat.com>)
> v4:
>   * fix compilation issue
>           (Christian Borntraeger <borntraeger@de.ibm.com>)
>   * advance HVA along with GPA in kvm_set_phys_mem()
>           (Christian Borntraeger <borntraeger@de.ibm.com>)
> 
> patch prepares only KVM side for switching to single RAM memory region
> another patch will take care of  dropping manual RAM partitioning in
> s390 code.
> 
> 
>  include/sysemu/kvm_int.h   |   1 +
>  accel/kvm/kvm-all.c        | 239 ++++++++++++++++++++++---------------
>  hw/s390x/s390-virtio-ccw.c |   9 --
>  target/s390x/kvm.c         |  12 ++
>  4 files changed, 159 insertions(+), 102 deletions(-)
> 
> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
> index 72b2d1b3ae..ac2d1f8b56 100644
> --- a/include/sysemu/kvm_int.h
> +++ b/include/sysemu/kvm_int.h
> @@ -41,4 +41,5 @@ typedef struct KVMMemoryListener {
>  void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
>                                    AddressSpace *as, int as_id);
>  
> +void kvm_set_max_memslot_size(hwaddr max_slot_size);
>  #endif
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index b09bad0804..0635903408 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -140,6 +140,7 @@ bool kvm_direct_msi_allowed;
>  bool kvm_ioeventfd_any_length_allowed;
>  bool kvm_msi_use_devid;
>  static bool kvm_immediate_exit;
> +static hwaddr kvm_max_slot_size = ~0;
>  
>  static const KVMCapabilityInfo kvm_required_capabilites[] = {
>      KVM_CAP_INFO(USER_MEMORY),
> @@ -437,7 +438,7 @@ static int kvm_slot_update_flags(KVMMemoryListener *kml, KVMSlot *mem,
>  static int kvm_section_update_flags(KVMMemoryListener *kml,
>                                      MemoryRegionSection *section)
>  {
> -    hwaddr start_addr, size;
> +    hwaddr start_addr, size, slot_size;
>      KVMSlot *mem;
>      int ret = 0;
>  
> @@ -448,13 +449,18 @@ static int kvm_section_update_flags(KVMMemoryListener *kml,
>  
>      kvm_slots_lock(kml);
>  
> -    mem = kvm_lookup_matching_slot(kml, start_addr, size);
> -    if (!mem) {
> -        /* We don't have a slot if we want to trap every access. */
> -        goto out;
> -    }
> +    while (size && !ret) {
> +        slot_size = kvm_max_slot_size < size ? kvm_max_slot_size : size;

Nit: use MIN()?

> +        mem = kvm_lookup_matching_slot(kml, start_addr, slot_size);
> +        if (!mem) {
> +            /* We don't have a slot if we want to trap every access. */
> +            goto out;

I don't really understand the rational behind e377e87ca6a3d by simply
reading the commit message... Just want to make sure: this won't be
triggered when memslot split happened for this memory region section,
right?

> +        }
>  
> -    ret = kvm_slot_update_flags(kml, mem, section->mr);
> +        ret = kvm_slot_update_flags(kml, mem, section->mr);
> +        start_addr += slot_size;
> +        size -= slot_size;
> +    }
>  
>  out:
>      kvm_slots_unlock(kml);
> @@ -497,11 +503,14 @@ static void kvm_log_stop(MemoryListener *listener,
>  
>  /* get kvm's dirty pages bitmap and update qemu's */
>  static int kvm_get_dirty_pages_log_range(MemoryRegionSection *section,
> +                                         hwaddr offset_in_section,
> +                                         hwaddr range_size,
>                                           unsigned long *bitmap)
>  {
>      ram_addr_t start = section->offset_within_region +
> +                       offset_in_section +
>                         memory_region_get_ram_addr(section->mr);
> -    ram_addr_t pages = int128_get64(section->size) / getpagesize();
> +    ram_addr_t pages = range_size / getpagesize();

I feel like we can avoid touching kvm_get_dirty_pages_log_range() by
passing in a correct MemoryRegionSection* to it (please see [1]
below).

>  
>      cpu_physical_memory_set_dirty_lebitmap(bitmap, start, pages);
>      return 0;
> @@ -527,11 +536,13 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
>      struct kvm_dirty_log d = {};
>      KVMSlot *mem;
>      hwaddr start_addr, size;
> +    hwaddr slot_size, slot_offset = 0;
>      int ret = 0;
>  
>      size = kvm_align_section(section, &start_addr);
> -    if (size) {
> -        mem = kvm_lookup_matching_slot(kml, start_addr, size);
> +    while (size) {
> +        slot_size = kvm_max_slot_size < size ? kvm_max_slot_size : size;

(use MIN?)

> +        mem = kvm_lookup_matching_slot(kml, start_addr, slot_size);
>          if (!mem) {
>              /* We don't have a slot if we want to trap every access. */
>              goto out;
> @@ -549,11 +560,11 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
>           * So for now, let's align to 64 instead of HOST_LONG_BITS here, in
>           * a hope that sizeof(long) won't become >8 any time soon.
>           */
> -        size = ALIGN(((mem->memory_size) >> TARGET_PAGE_BITS),
> -                     /*HOST_LONG_BITS*/ 64) / 8;
>          if (!mem->dirty_bmap) {
> +            hwaddr bitmap_size = ALIGN(((mem->memory_size) >> TARGET_PAGE_BITS),
> +                                        /*HOST_LONG_BITS*/ 64) / 8;
>              /* Allocate on the first log_sync, once and for all */
> -            mem->dirty_bmap = g_malloc0(size);
> +            mem->dirty_bmap = g_malloc0(bitmap_size);
>          }
>  
>          d.dirty_bitmap = mem->dirty_bmap;
> @@ -564,7 +575,12 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
>              goto out;
>          }
>  
> -        kvm_get_dirty_pages_log_range(section, d.dirty_bitmap);
> +        kvm_get_dirty_pages_log_range(section, slot_offset, slot_size,
> +                                      d.dirty_bitmap);

[1]

Here can we hand-made a MemoryRegionSection which covers the
slot_offset/slot_size region and pass it to
kvm_get_dirty_pages_log_range()?

> +
> +        slot_offset += slot_size;
> +        start_addr += slot_size;
> +        size -= slot_size;
>      }
>  out:
>      return ret;
> @@ -575,55 +591,14 @@ out:
>  #define KVM_CLEAR_LOG_ALIGN  (qemu_real_host_page_size << KVM_CLEAR_LOG_SHIFT)
>  #define KVM_CLEAR_LOG_MASK   (-KVM_CLEAR_LOG_ALIGN)
>  
> -/**
> - * kvm_physical_log_clear - Clear the kernel's dirty bitmap for range
> - *
> - * NOTE: this will be a no-op if we haven't enabled manual dirty log
> - * protection in the host kernel because in that case this operation
> - * will be done within log_sync().
> - *
> - * @kml:     the kvm memory listener
> - * @section: the memory range to clear dirty bitmap
> - */
> -static int kvm_physical_log_clear(KVMMemoryListener *kml,
> -                                  MemoryRegionSection *section)
> +static int kvm_physical_log_slot_clear(uint64_t start, uint64_t size,
> +                                       KVMSlot *mem, int as_id)
>  {
>      KVMState *s = kvm_state;
> -    struct kvm_clear_dirty_log d;
> -    uint64_t start, end, bmap_start, start_delta, bmap_npages, size;
>      unsigned long *bmap_clear = NULL, psize = qemu_real_host_page_size;
> -    KVMSlot *mem = NULL;
> -    int ret, i;
> -
> -    if (!s->manual_dirty_log_protect) {
> -        /* No need to do explicit clear */
> -        return 0;
> -    }
> -
> -    start = section->offset_within_address_space;
> -    size = int128_get64(section->size);
> -
> -    if (!size) {
> -        /* Nothing more we can do... */
> -        return 0;
> -    }
> -
> -    kvm_slots_lock(kml);
> -
> -    /* Find any possible slot that covers the section */
> -    for (i = 0; i < s->nr_slots; i++) {
> -        mem = &kml->slots[i];
> -        if (mem->start_addr <= start &&
> -            start + size <= mem->start_addr + mem->memory_size) {
> -            break;
> -        }
> -    }
> -
> -    /*
> -     * We should always find one memslot until this point, otherwise
> -     * there could be something wrong from the upper layer
> -     */
> -    assert(mem && i != s->nr_slots);
> +    uint64_t end, bmap_start, start_delta, bmap_npages;
> +    struct kvm_clear_dirty_log d;
> +    int ret;
>  
>      /*
>       * We need to extend either the start or the size or both to
> @@ -694,7 +669,7 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
>      /* It should never overflow.  If it happens, say something */
>      assert(bmap_npages <= UINT32_MAX);
>      d.num_pages = bmap_npages;
> -    d.slot = mem->slot | (kml->as_id << 16);
> +    d.slot = mem->slot | (as_id << 16);
>  
>      if (kvm_vm_ioctl(s, KVM_CLEAR_DIRTY_LOG, &d) == -1) {
>          ret = -errno;
> @@ -718,8 +693,66 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
>      /* This handles the NULL case well */
>      g_free(bmap_clear);
>  
> -    kvm_slots_unlock(kml);
> +    return ret;
> +}
> +
> +/**
> + * kvm_physical_log_clear - Clear the kernel's dirty bitmap for range
> + *
> + * NOTE: this will be a no-op if we haven't enabled manual dirty log
> + * protection in the host kernel because in that case this operation
> + * will be done within log_sync().
> + *
> + * @kml:     the kvm memory listener
> + * @section: the memory range to clear dirty bitmap
> + */
> +static int kvm_physical_log_clear(KVMMemoryListener *kml,
> +                                  MemoryRegionSection *section)
> +{
> +    KVMState *s = kvm_state;
> +    uint64_t start, size, slot_size;
> +    KVMSlot *mem = NULL;
> +    int i, ret = 0;
> +
> +    if (!s->manual_dirty_log_protect) {
> +        /* No need to do explicit clear */
> +        return 0;
> +    }
> +
> +    start = section->offset_within_address_space;
> +    size = int128_get64(section->size);
> +
> +    if (!size) {
> +        /* Nothing more we can do... */
> +        return 0;
> +    }
> +
> +    kvm_slots_lock(kml);
> +
> +    while (size) {
> +        slot_size = kvm_max_slot_size < size ? kvm_max_slot_size : size;

MIN?

Also, the naming of slot_size might be a bit misleading here because
log_clear() is different in that it could happen with very small
memory region section passed in, hence slot_size could very probably
not be the size of slot.  Maybe range_size or anything else?

> +        /* Iterate over slots that cover the section */
> +        for (i = 0; i < s->nr_slots; i++) {
> +            mem = &kml->slots[i];
> +            if (mem->start_addr <= start &&
> +                start + slot_size <= mem->start_addr + mem->memory_size) {
> +                break;
> +            }
> +        }
>  
> +        /*
> +         * We should always find one memslot until this point, otherwise
> +         * there could be something wrong from the upper layer
> +         */
> +        assert(mem && i != s->nr_slots);
> +
> +        kvm_physical_log_slot_clear(start, slot_size, mem, kml->as_id);

Use ret to capture errors?

> +
> +        size -= slot_size;
> +        start += slot_size;
> +    }
> +
> +    kvm_slots_unlock(kml);
>      return ret;
>  }
>  
> @@ -953,6 +986,14 @@ kvm_check_extension_list(KVMState *s, const KVMCapabilityInfo *list)
>      return NULL;
>  }
>  
> +void kvm_set_max_memslot_size(hwaddr max_slot_size)
> +{
> +    g_assert(
> +        ROUND_UP(max_slot_size, qemu_real_host_page_size) == max_slot_size
> +    );
> +    kvm_max_slot_size = max_slot_size;
> +}
> +
>  static void kvm_set_phys_mem(KVMMemoryListener *kml,
>                               MemoryRegionSection *section, bool add)
>  {
> @@ -960,7 +1001,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
>      int err;
>      MemoryRegion *mr = section->mr;
>      bool writeable = !mr->readonly && !mr->rom_device;
> -    hwaddr start_addr, size;
> +    hwaddr start_addr, size, slot_size;
>      void *ram;
>  
>      if (!memory_region_is_ram(mr)) {
> @@ -985,41 +1026,52 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
>      kvm_slots_lock(kml);
>  
>      if (!add) {
> -        mem = kvm_lookup_matching_slot(kml, start_addr, size);
> -        if (!mem) {
> -            goto out;
> -        }
> -        if (mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
> -            kvm_physical_sync_dirty_bitmap(kml, section);
> -        }
> +        do {
> +            slot_size = kvm_max_slot_size < size ? kvm_max_slot_size : size;

Same

> +            mem = kvm_lookup_matching_slot(kml, start_addr, slot_size);
> +            if (!mem) {
> +                goto out;
> +            }
> +            if (mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
> +                kvm_physical_sync_dirty_bitmap(kml, section);
> +            }
>  
> -        /* unregister the slot */
> -        g_free(mem->dirty_bmap);
> -        mem->dirty_bmap = NULL;
> -        mem->memory_size = 0;
> -        mem->flags = 0;
> -        err = kvm_set_user_memory_region(kml, mem, false);
> -        if (err) {
> -            fprintf(stderr, "%s: error unregistering slot: %s\n",
> -                    __func__, strerror(-err));
> -            abort();
> -        }
> +            /* unregister the slot */
> +            g_free(mem->dirty_bmap);
> +            mem->dirty_bmap = NULL;
> +            mem->memory_size = 0;
> +            mem->flags = 0;
> +            err = kvm_set_user_memory_region(kml, mem, false);
> +            if (err) {
> +                fprintf(stderr, "%s: error unregistering slot: %s\n",
> +                        __func__, strerror(-err));
> +                abort();
> +            }
> +            start_addr += slot_size;
> +            size -= slot_size;
> +        } while (size);
>          goto out;
>      }
>  
>      /* register the new slot */
> -    mem = kvm_alloc_slot(kml);
> -    mem->memory_size = size;
> -    mem->start_addr = start_addr;
> -    mem->ram = ram;
> -    mem->flags = kvm_mem_flags(mr);
> -
> -    err = kvm_set_user_memory_region(kml, mem, true);
> -    if (err) {
> -        fprintf(stderr, "%s: error registering slot: %s\n", __func__,
> -                strerror(-err));
> -        abort();
> -    }
> +    do {
> +        slot_size = kvm_max_slot_size < size ? kvm_max_slot_size : size;

Same.

> +        mem = kvm_alloc_slot(kml);
> +        mem->memory_size = slot_size;
> +        mem->start_addr = start_addr;
> +        mem->ram = ram;
> +        mem->flags = kvm_mem_flags(mr);
> +
> +        err = kvm_set_user_memory_region(kml, mem, true);
> +        if (err) {
> +            fprintf(stderr, "%s: error registering slot: %s\n", __func__,
> +                    strerror(-err));
> +            abort();
> +        }
> +        start_addr += slot_size;
> +        ram += slot_size;
> +        size -= slot_size;
> +    } while (size);
>  
>  out:
>      kvm_slots_unlock(kml);
> @@ -2859,6 +2911,7 @@ static bool kvm_accel_has_memory(MachineState *ms, AddressSpace *as,
>  
>      for (i = 0; i < kvm->nr_as; ++i) {
>          if (kvm->as[i].as == as && kvm->as[i].ml) {
> +            size = kvm_max_slot_size < size ? kvm_max_slot_size : size;
>              return NULL != kvm_lookup_matching_slot(kvm->as[i].ml,
>                                                      start_addr, size);
>          }
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 8bfb6684cb..baa95aad38 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -154,15 +154,6 @@ static void virtio_ccw_register_hcalls(void)
>                                     virtio_ccw_hcall_early_printk);
>  }
>  
> -/*
> - * KVM does only support memory slots up to KVM_MEM_MAX_NR_PAGES pages
> - * as the dirty bitmap must be managed by bitops that take an int as
> - * position indicator. If we have a guest beyond that we will split off
> - * new subregions. The split must happen on a segment boundary (1MB).
> - */
> -#define KVM_MEM_MAX_NR_PAGES ((1ULL << 31) - 1)
> -#define SEG_MSK (~0xfffffULL)
> -#define KVM_SLOT_MAX_BYTES ((KVM_MEM_MAX_NR_PAGES * TARGET_PAGE_SIZE) & SEG_MSK)

(Nit: IMHO it'll be cleaner to keep these and in the next patch to
 simply revert bb223055b9b327e)

>  static void s390_memory_init(ram_addr_t mem_size)
>  {
>      MemoryRegion *sysmem = get_system_memory();
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index cea71ac7c3..838d23cb17 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -28,6 +28,7 @@
>  #include "cpu.h"
>  #include "internal.h"
>  #include "kvm_s390x.h"
> +#include "sysemu/kvm_int.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qemu/timer.h"
> @@ -123,6 +124,16 @@
>  #define VCPU_IRQ_BUF_SIZE(max_cpus) (sizeof(struct kvm_s390_irq) * \
>                                       (max_cpus + NR_LOCAL_IRQS))
>  
> +/*
> + * KVM does only support memory slots up to KVM_MEM_MAX_NR_PAGES pages
> + * as the dirty bitmap must be managed by bitops that take an int as
> + * position indicator. If we have a guest beyond that we will split off
> + * new subregions. The split must happen on a segment boundary (1MB).
> + */
> +#define KVM_MEM_MAX_NR_PAGES ((1ULL << 31) - 1)

Not related to this series, but... should kvm export this to uapi
headers?

> +#define SEG_MSK (~0xfffffULL)
> +#define KVM_SLOT_MAX_BYTES ((KVM_MEM_MAX_NR_PAGES * TARGET_PAGE_SIZE) & SEG_MSK)
> +
>  static CPUWatchpoint hw_watchpoint;
>  /*
>   * We don't use a list because this structure is also used to transmit the
> @@ -348,6 +359,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>       */
>      /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
>  
> +    kvm_set_max_memslot_size(KVM_SLOT_MAX_BYTES);
>      return 0;
>  }
>  
> -- 
> 2.18.1
> 
> 

Regards,

-- 
Peter Xu

