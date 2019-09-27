Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832E0C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A6D206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A6D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDjwh-0007Zd-O3
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 02:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iDjSV-0002hn-Bx
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iDjSS-0006DX-Qh
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:10:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40246)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iDjSS-00064Q-Gr
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:10:24 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 545202A09B1
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 06:10:22 +0000 (UTC)
Received: by mail-pg1-f199.google.com with SMTP id h189so2938383pgc.4
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 23:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Q3VcwwfIJDnhtPHgtff591ka965pgfBVQAYecX/DSPM=;
 b=bgMXK4hmiqZwFfued2FcHen9qhcta/DO35iE5x4777VSd6kGt17qdpt4XRGTCFmi7D
 +t16ojfA7ApbtRMgfPNlPCWaJiZthlAVFKf12JM5WtWRWL0eubRcCKSnfx+KOJqy+Y4t
 eQ1yX8Sr1Whaj2Pp/uKlone2U6mXAY/DISUeWwMvUzsn1PgVDckkzQSXGdtrGBMpGyHv
 g1QfH7dYIHsWQ+ZjKcL3Jw/CKtfD1Jpq/x+7jkVO5Xxuhix8o8c8YCthpo+SmNwytI8u
 In2O9vlChRqkUXBRqcxCBCu4w2UPhdrRcLZRM0eeASiPV2MrJ1qZvejd1GrEbs9WQFAh
 2KiQ==
X-Gm-Message-State: APjAAAXowHhbHmwtwQl2qZawEZ7UyLh8PlYMXcr7chKthS/94/N5foF1
 9RD/hk/2gTfJI4OtkBb/qG/59B4bV/hkcoKrH8XsExCvq+HJwMH1JNn1s6r+R+1CYC1eKhfV/eR
 8H4GBpQ5cUNQ7hVo=
X-Received: by 2002:a62:834c:: with SMTP id h73mr2232327pfe.183.1569564621760; 
 Thu, 26 Sep 2019 23:10:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwxmWyNdTjyyHgRfYVtbh/6+ftP0BxAdeEEiRcU55u20E9bPvDaUIQkSuipslo6yZOxZQG0Zw==
X-Received: by 2002:a62:834c:: with SMTP id h73mr2232314pfe.183.1569564621514; 
 Thu, 26 Sep 2019 23:10:21 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p68sm1981376pfp.9.2019.09.26.23.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 23:10:20 -0700 (PDT)
Date: Fri, 27 Sep 2019 14:10:11 +0800
From: Peter Xu <peterx@redhat.com>
To: qi1.zhang@intel.com
Subject: Re: [PATCH V2] intel_iommu: TM field should not be in reserved bits
Message-ID: <20190927061011.GB9412@xz-x1>
References: <20190927045838.2968-1-qi1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190927045838.2968-1-qi1.zhang@intel.com>
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
Cc: pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 27, 2019 at 12:58:38PM +0800, qi1.zhang@intel.com wrote:
> From: "Zhang, Qi" <qi1.zhang@intel.com>
> 
> When dt is supported, TM field should not be Reserved(0).
> 
> Refer to VT-d Spec 9.8
> 
> Signed-off-by: Zhang, Qi <qi1.zhang@intel.com>
> Signed-off-by: Qi, Yadong <yadong.qi@intel.com>
> ---
>  hw/i386/intel_iommu.c          | 12 ++++++------
>  hw/i386/intel_iommu_internal.h | 25 +++++++++++++++++++------
>  2 files changed, 25 insertions(+), 12 deletions(-)
> ---
> Changelog V2:
>  move dt_supported flag to VTD_SPTE_PAGE_LX_RSVD_MASK and VTD_SPTE_LPAGE_LX_RSVD_MASK
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index f1de8fdb75..35222cf55c 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3548,13 +3548,13 @@ static void vtd_init(IntelIOMMUState *s)
>       * Rsvd field masks for spte
>       */
>      vtd_paging_entry_rsvd_field[0] = ~0ULL;
> -    vtd_paging_entry_rsvd_field[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits);
> -    vtd_paging_entry_rsvd_field[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
> -    vtd_paging_entry_rsvd_field[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
> +    vtd_paging_entry_rsvd_field[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits, x86_iommu->dt_supported);
> +    vtd_paging_entry_rsvd_field[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits, x86_iommu->dt_supported);
> +    vtd_paging_entry_rsvd_field[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits, x86_iommu->dt_supported);
>      vtd_paging_entry_rsvd_field[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
> -    vtd_paging_entry_rsvd_field[5] = VTD_SPTE_LPAGE_L1_RSVD_MASK(s->aw_bits);
> -    vtd_paging_entry_rsvd_field[6] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits);
> -    vtd_paging_entry_rsvd_field[7] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits);
> +    vtd_paging_entry_rsvd_field[5] = VTD_SPTE_LPAGE_L1_RSVD_MASK(s->aw_bits, x86_iommu->dt_supported);
> +    vtd_paging_entry_rsvd_field[6] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits, x86_iommu->dt_supported);
> +    vtd_paging_entry_rsvd_field[7] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits, x86_iommu->dt_supported);
>      vtd_paging_entry_rsvd_field[8] = VTD_SPTE_LPAGE_L4_RSVD_MASK(s->aw_bits);

Should this TM bit only affects leaves?  Say, entry 1 (4K), 5 (2M), 6
(1G).  While this reminded me that I'm totally confused on why we have
had entry 7, 8 after all...  Are they really used?

>  
>      if (x86_iommu_ir_supported(x86_iommu)) {
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index c1235a7063..01f1aa6c86 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -387,19 +387,31 @@ typedef union VTDInvDesc VTDInvDesc;
>  #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0fff8
>  
>  /* Rsvd field masks for spte */
> -#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw) \
> +#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw, dt_supported) \
> +        dt_supported? \
> +        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
>          (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))

This seems strange too in that ~VTD_HAW_MASK(aw) probably covered bits
63-48 for aw==48 case so it should already cover VTD_SL_TM?

Meanwhile when I'm reading the spec I see at least bits 61-52 ignored
rather than reserved.

Thanks,

> -#define VTD_SPTE_PAGE_L2_RSVD_MASK(aw) \
> +#define VTD_SPTE_PAGE_L2_RSVD_MASK(aw, dt_supported) \
> +        dt_supported? \
> +        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
>          (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> -#define VTD_SPTE_PAGE_L3_RSVD_MASK(aw) \
> +#define VTD_SPTE_PAGE_L3_RSVD_MASK(aw, dt_supported) \
> +        dt_supported? \
> +        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
>          (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>  #define VTD_SPTE_PAGE_L4_RSVD_MASK(aw) \
>          (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> -#define VTD_SPTE_LPAGE_L1_RSVD_MASK(aw) \
> +#define VTD_SPTE_LPAGE_L1_RSVD_MASK(aw, dt_supported) \
> +        dt_supported? \
> +        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
>          (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> -#define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw) \
> +#define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw, dt_supported) \
> +        dt_supported? \
> +        (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
>          (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> -#define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw) \
> +#define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw, dt_supported) \
> +        dt_supported? \
> +        (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
>          (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>  #define VTD_SPTE_LPAGE_L4_RSVD_MASK(aw) \
>          (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> @@ -506,5 +518,6 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_SL_W                    (1ULL << 1)
>  #define VTD_SL_PT_BASE_ADDR_MASK(aw) (~(VTD_PAGE_SIZE - 1) & VTD_HAW_MASK(aw))
>  #define VTD_SL_IGN_COM              0xbff0000000000000ULL
> +#define VTD_SL_TM                   (1ULL << 62)
>  
>  #endif
> -- 
> 2.20.1
> 
> 

-- 
Peter Xu

