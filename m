Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3462BC606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 06:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D60216C4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 06:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D60216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkjnF-0007hQ-9J
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 02:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34959)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhexu@redhat.com>) id 1hkjmk-0007FD-RH
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 02:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhexu@redhat.com>) id 1hkjmi-0002MQ-Uv
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 02:39:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37963)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhexu@redhat.com>) id 1hkjmg-0002Jr-TP
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 02:39:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id z75so8922464pgz.5
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 23:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=bvGqzmcw85h3EbwUOHcoxh9t8Yk2J5NOzQ0lH/a3moQ=;
 b=RZm6BHNbKyf4jKSgU0rnEQIxGiOA4LAHWvIkhWdiLprTK5MKxDXya7SYDTwOZZnEI0
 ce60R92+B+VR3l1Y3+HpJN33SNcSW6Rft9NqnkT1isfQRLYetAKBBOzPvKmuEn8tYW5B
 TImK0oBNyqEjx7h89wEIlU7oqQtrzuk4JCpdj+zmNKSm81QVevCD5nMXPwKrGYDoNXo8
 hDVS3k4YrEmZCrwxy0DwCj/cFxmxf5wcI1UyADOr55+3vrciOpRWnqfR/4vLfphr1oxS
 IypX157BhaYlJ7zWMH6LmT2aJww2MRgk+FYzxsY6Xh+jLrSLd4wWe2+AN8IIZgkqPdYm
 Llsg==
X-Gm-Message-State: APjAAAVbzS4Bvc8phRS6LmGjvRl+J4uTJ/yHn9uuaAajFclwBOdhzhAi
 a8axQlLCAQGnh9XSwT4jG6DN8Q==
X-Google-Smtp-Source: APXvYqypfurbejdMOJ1Medej7i0dk2eLFxg8NJWviCiTCRv+NoOMnKKnWZnE44W7uK96RiV2pNJ67w==
X-Received: by 2002:a63:7a01:: with SMTP id v1mr29157315pgc.310.1562654364336; 
 Mon, 08 Jul 2019 23:39:24 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id m4sm40725235pff.108.2019.07.08.23.39.19
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 08 Jul 2019 23:39:23 -0700 (PDT)
From: Peter Xu <zhexu@redhat.com>
X-Google-Original-From: Peter Xu <peterx@redhat.com>
Date: Tue, 9 Jul 2019 14:39:15 +0800
To: Liu Yi L <yi.l.liu@intel.com>
Message-ID: <20190709063915.GG5178@xz-x1>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-12-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1562324511-2910-12-git-send-email-yi.l.liu@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.195
Subject: Re: [Qemu-devel] [RFC v1 11/18] intel_iommu: create VTDAddressSpace
 per BDF+PASID
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 qemu-devel@nongnu.org, eric.auger@redhat.com, alex.williamson@redhat.com,
 pbonzini@redhat.com, yi.y.sun@intel.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 05, 2019 at 07:01:44PM +0800, Liu Yi L wrote:

[...]

> +/**
> + * This function finds or adds a VTDAddressSpace for a device when
> + * it is bound to a pasid
> + */
> +static VTDAddressSpace *vtd_add_find_pasid_as(IntelIOMMUState *s,
> +                                              PCIBus *bus,
> +                                              int devfn,
> +                                              uint32_t pasid,
> +                                              bool allocate)
> +{
> +    char key[32];
> +    char *new_key;
> +    VTDAddressSpace *vtd_pasid_as;
> +    uint16_t sid;
> +
> +    sid = vtd_make_source_id(pci_bus_num(bus), devfn);
> +    vtd_get_pasid_key(&key[0], 32, pasid, sid);
> +    vtd_pasid_as = g_hash_table_lookup(s->vtd_pasid_as, &key[0]);
> +
> +    if (!vtd_pasid_as && allocate) {
> +        new_key = g_malloc(32);
> +        vtd_get_pasid_key(&new_key[0], 32, pasid, sid);
> +        /*
> +         * Initiate the vtd_pasid_as structure.
> +         *
> +         * This structure here is used to track the guest pasid
> +         * binding and also serves as pasid-cache mangement entry.
> +         *
> +         * TODO: in future, if wants to support the SVA-aware DMA
> +         *       emulation, the vtd_pasid_as should be fully initialized.
> +         *       e.g. the address_space and memory region fields.
> +         */

I'm not very sure about this part.  IMHO all those memory regions are
used to inlay the whole IOMMU idea into QEMU's memory API framework.
Now even without the whole PASID support we've already have a workable
vtd_iommu_translate() that will intercept device DMA operations and we
can try to translate the IOVA to anything we want.  Now the iommu_idx
parameter of vtd_iommu_translate() is never used (I'd say until now I
still don't sure on whether the "iommu_idx" idea is the best we can
have... I've tried to debate on that but... anyway I assume for Intel
we can think it as the "pasid" information or at least contains it),
however in the further we can have that PASID/iommu_idx/whatever
passed into this translate() function too, then we can walk the 1st
level page table there if we found that this device had enabled the
1st level mapping (or even nested).  I don't see what else we need to
do to play with extra memory regions.

Conclusion: I feel like SVA can use its own structure here instead of
reusing VTDAddressSpace, because I think those memory regions can
probably be useless.  Even it will, we can refactor the code later,
but I really doubt it...

> +        vtd_pasid_as = g_malloc0(sizeof(VTDAddressSpace));
> +        vtd_pasid_as->iommu_state = s;
> +        vtd_pasid_as->bus = bus;
> +        vtd_pasid_as->devfn = devfn;
> +        vtd_pasid_as->context_cache_entry.context_cache_gen = 0;
> +        vtd_pasid_as->pasid = pasid;
> +        vtd_pasid_as->pasid_allocated = true;
> +        vtd_pasid_as->pasid_cache_entry.pasid_cache_gen = 0;
> +        g_hash_table_insert(s->vtd_pasid_as, new_key, vtd_pasid_as);
> +    }
> +    return vtd_pasid_as;
> +}

Regards,

-- 
Peter Xu

