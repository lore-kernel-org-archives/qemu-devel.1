Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8914C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 779BC207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779BC207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDmeo-00057v-FO
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 05:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iDmcC-0003XG-Ul
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iDmc9-0001gn-VJ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:32:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53344)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iDmc8-0001dm-E7
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:32:37 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0B2465313A
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 09:32:35 +0000 (UTC)
Received: by mail-pf1-f199.google.com with SMTP id 194so1521936pfu.3
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 02:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zPpXJBsgXCdgZO86UPMdugD/7JfMMFe/AjIloYQYWug=;
 b=k62ijUYUyIGdPQfmWVPrBsSupSl3Qy5PQYqCLAA6LhjIyMUFn1GdjvtRX50KyNUTfV
 B+2Qz/eY8E6Kgbo7aYc8Jq09U7Nj8pqimqCx73LdcBFvjzzW8nqM5nzLyALXhCHXRh2y
 kXmxPv2PDQElS98lSDIzMeJ7tmnGx6tU5YnWAPmecqDF6jMKoilAGPjDyC5wWtL0rWc4
 8X8n10m/e1UcTddMWWYKfTCcCKcLK+7dwSAr/0j1xmqueDTqVQWUVomz0hgljm4rkdMR
 R+xjFAdHYViJHiNGzKvFgRwkNFLLrrPgyBastbhlQ2G/sUi58Ys1rlZqMUkle3VMUV1J
 AXnA==
X-Gm-Message-State: APjAAAUVSb63bA0emZAzEqlzePtqNRl0ExgDYRb8IVc/JVHoEY3eV3IU
 0HRhJvTz1IGsfpA0W2ftD/exxe7RdkiDAbUk0Rqod75E0AcRPa9R7EL6ey/8FP6MmyoXGRU7nhX
 dd/FBNwSy4t1XC/M=
X-Received: by 2002:a17:90a:2086:: with SMTP id
 f6mr8816434pjg.104.1569576753574; 
 Fri, 27 Sep 2019 02:32:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyz3UiS5nvzuqeXSjJLmzd6fvm7V8YIpGiFRgwCXq9rx7oE8mStrFQV/OYbUISEQGV2S24AaA==
X-Received: by 2002:a17:90a:2086:: with SMTP id
 f6mr8816410pjg.104.1569576753307; 
 Fri, 27 Sep 2019 02:32:33 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b5sm4182873pgb.68.2019.09.27.02.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 02:32:32 -0700 (PDT)
Date: Fri, 27 Sep 2019 17:32:23 +0800
From: Peter Xu <peterx@redhat.com>
To: "Zhang, Qi1" <qi1.zhang@intel.com>
Subject: Re: [PATCH V2] intel_iommu: TM field should not be in reserved bits
Message-ID: <20190927093223.GC9412@xz-x1>
References: <20190927045838.2968-1-qi1.zhang@intel.com>
 <20190927061011.GB9412@xz-x1>
 <215440059103624D9AD9D1DCACBF45DD3E84E270@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <215440059103624D9AD9D1DCACBF45DD3E84E270@shsmsx102.ccr.corp.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Qi,
 Yadong" <yadong.qi@intel.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 27, 2019 at 08:03:21AM +0000, Zhang, Qi1 wrote:
> 
> 
> > -----Original Message-----
> > From: Peter Xu <peterx@redhat.com>
> > Sent: Friday, September 27, 2019 2:10 PM
> > To: Zhang, Qi1 <qi1.zhang@intel.com>
> > Cc: qemu-devel@nongnu.org; ehabkost@redhat.com; mst@redhat.com;
> > pbonzini@redhat.com; rth@twiddle.net
> > Subject: Re: [PATCH V2] intel_iommu: TM field should not be in reserved bits
> > 
> > On Fri, Sep 27, 2019 at 12:58:38PM +0800, qi1.zhang@intel.com wrote:
> > > From: "Zhang, Qi" <qi1.zhang@intel.com>
> > >
> > > When dt is supported, TM field should not be Reserved(0).
> > >
> > > Refer to VT-d Spec 9.8
> > >
> > > Signed-off-by: Zhang, Qi <qi1.zhang@intel.com>
> > > Signed-off-by: Qi, Yadong <yadong.qi@intel.com>
> > > ---
> > >  hw/i386/intel_iommu.c          | 12 ++++++------
> > >  hw/i386/intel_iommu_internal.h | 25 +++++++++++++++++++------
> > >  2 files changed, 25 insertions(+), 12 deletions(-)
> > > ---
> > > Changelog V2:
> > >  move dt_supported flag to VTD_SPTE_PAGE_LX_RSVD_MASK and
> > > VTD_SPTE_LPAGE_LX_RSVD_MASK
> > >
> > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c index
> > > f1de8fdb75..35222cf55c 100644
> > > --- a/hw/i386/intel_iommu.c
> > > +++ b/hw/i386/intel_iommu.c
> > > @@ -3548,13 +3548,13 @@ static void vtd_init(IntelIOMMUState *s)
> > >       * Rsvd field masks for spte
> > >       */
> > >      vtd_paging_entry_rsvd_field[0] = ~0ULL;
> > > -    vtd_paging_entry_rsvd_field[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s-
> > >aw_bits);
> > > -    vtd_paging_entry_rsvd_field[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s-
> > >aw_bits);
> > > -    vtd_paging_entry_rsvd_field[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s-
> > >aw_bits);
> > > +    vtd_paging_entry_rsvd_field[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s-
> > >aw_bits, x86_iommu->dt_supported);
> > > +    vtd_paging_entry_rsvd_field[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s-
> > >aw_bits, x86_iommu->dt_supported);
> > > +    vtd_paging_entry_rsvd_field[3] =
> > > + VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits, x86_iommu-
> > >dt_supported);
> > >      vtd_paging_entry_rsvd_field[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s-
> > >aw_bits);
> > > -    vtd_paging_entry_rsvd_field[5] = VTD_SPTE_LPAGE_L1_RSVD_MASK(s-
> > >aw_bits);
> > > -    vtd_paging_entry_rsvd_field[6] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s-
> > >aw_bits);
> > > -    vtd_paging_entry_rsvd_field[7] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s-
> > >aw_bits);
> > > +    vtd_paging_entry_rsvd_field[5] =
> > VTD_SPTE_LPAGE_L1_RSVD_MASK(s->aw_bits, x86_iommu-
> > >dt_supported);
> > > +    vtd_paging_entry_rsvd_field[6] =
> > VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits, x86_iommu-
> > >dt_supported);
> > > +    vtd_paging_entry_rsvd_field[7] =
> > > + VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits, x86_iommu-
> > >dt_supported);
> > >      vtd_paging_entry_rsvd_field[8] =
> > > VTD_SPTE_LPAGE_L4_RSVD_MASK(s->aw_bits);
> > 
> > Should this TM bit only affects leaves?  Say, entry 1 (4K), 5 (2M), 6 (1G).
> > While this reminded me that I'm totally confused on why we have had entry
> > 7, 8 after all...  Are they really used?
> Yes. TM bit only affects. To this array, index 1, 5,6,7 may be leaf. Will update a new patchset for it.

Could I ask why index 7 may be leaf?

> > 
> > >
> > >      if (x86_iommu_ir_supported(x86_iommu)) { diff --git
> > > a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> > > index c1235a7063..01f1aa6c86 100644
> > > --- a/hw/i386/intel_iommu_internal.h
> > > +++ b/hw/i386/intel_iommu_internal.h
> > > @@ -387,19 +387,31 @@ typedef union VTDInvDesc VTDInvDesc;  #define
> > > VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0fff8
> > >
> > >  /* Rsvd field masks for spte */
> > > -#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw) \
> > > +#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw, dt_supported) \
> > > +        dt_supported? \
> > > +        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM |
> > VTD_SL_TM))
> > > +: \
> > >          (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> > 
> > This seems strange too in that ~VTD_HAW_MASK(aw) probably covered bits
> > 63-48 for aw==48 case so it should already cover VTD_SL_TM?
> VTD_SL_IGN_COM 0xbff0000000000000ULL, TM field is cleared by ~ VTD_SL_IGN_COM
> > 
> > Meanwhile when I'm reading the spec I see at least bits 61-52 ignored rather
> > than reserved.
> Yes. Bit 61~52 is ignored. Such as the index 5 of this array is 0xfff8000000800.

Oops, my poor eye obviously didn't see that the "~" operator is
applied over the whole (VTD_HAW_MASK(aw) | VTD_SL_IGN_COM)... :)

Btw, you should only touch up the macros that are leaves here.
Non-leaves should still keep that bit as reserved.

Thanks,

-- 
Peter Xu

