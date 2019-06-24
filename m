Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDFCC48BE9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 10:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44753205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 10:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44753205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49460 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfM0k-0008Jo-AE
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 06:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39311)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hfLxd-0006F5-A1
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hfLxc-0000nj-1a
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:12:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hfLxb-0000mq-QF
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:12:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so12177701wme.4
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 03:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SQ6+IaSerBE59OOm614LfmosC/d6DL0h4OvXPlt0b9I=;
 b=hv5qqhuWQwOk9lfhGU2f7Gco6ZS3DZcudGGhPeHjqF8FBRN2VAgdVA4iwa5Zhh9XxH
 57d6Gfd2p1pAdWJJNO3LcI1uF+KIoyk3T4Rq0G2/VGjmrx8FX6k4hPgK47/M4As5cYED
 v7TOT8tVnbEagTv+qg4zD6OsNVBO9gjFZGCeeyHLFczS+XVLwcLv6g+sjKHwFKtaAK7X
 oTHGJLwp4h+QtAR3ygtWWwL625KrJknBU4JbBd9nCJMSn9jNefMHEHPP5hUe1oQN3MJx
 9fd9gqV5BuR0z9eTD7d56olkM5qh+F+5DSDnaZMvixYG8Qo1M7z+1lE056fKCol38WcJ
 8WyA==
X-Gm-Message-State: APjAAAU0DjYlsVcpF6wcA7jFpekACXIBX9wtAgLHi1H7nqwwJTuhn7SL
 jjZY67gFufKmVIWh2Jt3FnZ3xA==
X-Google-Smtp-Source: APXvYqxNjIRMVEm6j8ecpq30bnzDom/AvE6HkIrwARYjiLE+wV37ioqQBrQM4IjBPfSiaAOw7P56Kw==
X-Received: by 2002:a05:600c:2201:: with SMTP id
 z1mr14465076wml.59.1561371146704; 
 Mon, 24 Jun 2019 03:12:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7822:aa18:a9d8:39ab?
 ([2001:b07:6468:f312:7822:aa18:a9d8:39ab])
 by smtp.gmail.com with ESMTPSA id o20sm32957541wrh.8.2019.06.24.03.12.25
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Jun 2019 03:12:26 -0700 (PDT)
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20190624091811.30412-1-peterx@redhat.com>
 <20190624091811.30412-3-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <53a519b1-a514-8a07-c17e-0c704cfe6d26@redhat.com>
Date: Mon, 24 Jun 2019 12:12:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190624091811.30412-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v2 2/2] intel_iommu: Fix unexpected unmaps
 during global unmap
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
Cc: Auger Eric <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yan Zhao <yan.y.zhao@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/06/19 11:18, Peter Xu wrote:
> This is an replacement work of Yan Zhao's patch:
> 
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg625340.html
> 
> vtd_address_space_unmap() will do proper page mask alignment to make
> sure each IOTLB message will have correct masks for notification
> messages (2^N-1), but sometimes it can be expanded to even supercede
> the registered range.  That could lead to unexpected UNMAP of already
> mapped regions in some other notifiers.
> 
> Instead of doing mindless expension of the start address and address
> mask, we split the range into smaller ones and guarantee that each
> small range will have correct masks (2^N-1) and at the same time we
> should also try our best to generate as less IOTLB messages as
> possible.
> 
> Reported-by: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 67 ++++++++++++++++++++++++++-----------------
>  1 file changed, 41 insertions(+), 26 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 719ce19ab3..de86f53b4e 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3363,11 +3363,28 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
>      return vtd_dev_as;
>  }
>  
> +static uint64_t get_naturally_aligned_size(uint64_t start,
> +                                           uint64_t size, int gaw)
> +{
> +    uint64_t max_mask = 1ULL << gaw;
> +    uint64_t alignment = start ? start & -start : max_mask;
> +
> +    alignment = MIN(alignment, max_mask);
> +    size = MIN(size, max_mask);
> +
> +    if (alignment <= size) {
> +        /* Increase the alignment of start */
> +        return alignment;
> +    } else {
> +        /* Find the largest page mask from size */
> +        return 1ULL << (63 - clz64(size));
> +    }
> +}
> +
>  /* Unmap the whole range in the notifier's scope. */
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>  {
> -    IOMMUTLBEntry entry;
> -    hwaddr size;
> +    hwaddr size, remain;
>      hwaddr start = n->start;
>      hwaddr end = n->end;
>      IntelIOMMUState *s = as->iommu_state;
> @@ -3388,39 +3405,37 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>      }
>  
>      assert(start <= end);
> -    size = end - start;
> +    size = remain = end - start + 1;
>  
> -    if (ctpop64(size) != 1) {
> -        /*
> -         * This size cannot format a correct mask. Let's enlarge it to
> -         * suite the minimum available mask.
> -         */
> -        int n = 64 - clz64(size);
> -        if (n > s->aw_bits) {
> -            /* should not happen, but in case it happens, limit it */
> -            n = s->aw_bits;
> -        }
> -        size = 1ULL << n;
> +    while (remain >= VTD_PAGE_SIZE) {
> +        IOMMUTLBEntry entry;
> +        uint64_t mask = get_naturally_aligned_size(start, remain, s->aw_bits);
> +
> +        assert(mask);
> +
> +        entry.iova = start;
> +        entry.addr_mask = mask - 1;
> +        entry.target_as = &address_space_memory;
> +        entry.perm = IOMMU_NONE;
> +        /* This field is meaningless for unmap */
> +        entry.translated_addr = 0;
> +
> +        memory_region_notify_one(n, &entry);
> +
> +        start += mask;
> +        remain -= mask;
>      }
>  
> -    entry.target_as = &address_space_memory;
> -    /* Adjust iova for the size */
> -    entry.iova = n->start & ~(size - 1);
> -    /* This field is meaningless for unmap */
> -    entry.translated_addr = 0;
> -    entry.perm = IOMMU_NONE;
> -    entry.addr_mask = size - 1;
> +    assert(!remain);
>  
>      trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
>                               VTD_PCI_SLOT(as->devfn),
>                               VTD_PCI_FUNC(as->devfn),
> -                             entry.iova, size);
> +                             n->start, size);
>  
> -    map.iova = entry.iova;
> -    map.size = entry.addr_mask;
> +    map.iova = n->start;
> +    map.size = size;
>      iova_tree_remove(as->iova_tree, &map);
> -
> -    memory_region_notify_one(n, &entry);
>  }
>  
>  static void vtd_address_space_unmap_all(IntelIOMMUState *s)
> 

Looks good, ignore my previous message.

Paolo

