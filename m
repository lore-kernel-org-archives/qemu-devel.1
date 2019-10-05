Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB7DC47404
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 21:51:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEFA4222C0
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 21:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFA4222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGrxk-0002Q0-V9
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 17:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iGrwU-0001r7-Lh
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:50:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iGrwT-0001Lt-Fz
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:50:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iGrwT-0001Lc-7l
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:50:21 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 60D25C01DDF8
 for <qemu-devel@nongnu.org>; Sat,  5 Oct 2019 21:50:20 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id q80so10610804qke.22
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 14:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Gg3NfCO7ue6juhgGyHi1y9fS/svCoSxjd396wQQDHow=;
 b=elYkzb+zB4EGYcnLHRQveb1hYgjfSIbe+KTL3DzDfTy+c4TOav67aJf2zfN22cxfou
 rZirnD4wwGifnOH2pJEbLK/EKswjU7nGU/7b7oi482/vQH/xK3F+Zsofubzke4nrY19+
 84pB9JhPs+tdcMbz1gqfXkybXQVpuAMhoObrKIvq+4oTjqaWEzYf4DfOd/Jg9RJm29Pp
 jCREI/eqJQfq7xiQn21pVBjk58fKiwKknL1nlZQoLTFCfuzDtBSgnsr4PEwTFV5awvpx
 8euztkhEP30f0p7/R9R1Xl69i2Z4aL6anEqQG+Un2wNTBW+nQgXgPGctFbE7UAPO3AKf
 uC0Q==
X-Gm-Message-State: APjAAAUcP9dTXKYCnAG1QbMvBIXaZhR3HB8RlbwuwwiwfNVbwhH9zkHL
 TNYBZTuzealECGA1R6uMI7jpH4ddmzUwtizclB1VQDfjoMdLyYYGfcF2Mb3/8LHX7Itwn/RCyWE
 lleZjNwrMJnPYivk=
X-Received: by 2002:aed:2ce7:: with SMTP id g94mr23054148qtd.255.1570312219704; 
 Sat, 05 Oct 2019 14:50:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwklpkuQCm+3pG2ONx1QJE1rCIlNB5BbcZBcKpMap841qb/quVbHTPV5/egr8Qqw9wszmtQ5w==
X-Received: by 2002:aed:2ce7:: with SMTP id g94mr23054140qtd.255.1570312219490; 
 Sat, 05 Oct 2019 14:50:19 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 v85sm5285896qkb.25.2019.10.05.14.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 14:50:18 -0700 (PDT)
Date: Sat, 5 Oct 2019 17:50:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qi1.zhang@intel.com
Subject: Re: [PATCH v4] intel_iommu: TM field should not be in reserved bits
Message-ID: <20191005174844-mutt-send-email-mst@kernel.org>
References: <20190930050451.13618-1-qi1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930050451.13618-1-qi1.zhang@intel.com>
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 yadong.qi@intel.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 30, 2019 at 01:04:51PM +0800, qi1.zhang@intel.com wrote:
> From: "Zhang, Qi" <qi1.zhang@intel.com>
> 
> When dt is supported, TM field should not be Reserved(0).
> 
> Refer to VT-d Spec 9.8
> 
> Signed-off-by: Zhang, Qi <qi1.zhang@intel.com>
> Signed-off-by: Qi, Yadong <yadong.qi@intel.com>

I am guessing this is really a 2 patch series right?
So you need to format it as such with
git format-patch --cover-letter --thread=shallow

> ---
>  hw/i386/intel_iommu.c          | 12 ++++++++----
>  hw/i386/intel_iommu_internal.h | 17 +++++++++++++----
>  2 files changed, 21 insertions(+), 8 deletions(-)
> ---
> Changelog V2:
>  move dt_supported flag to VTD_SPTE_PAGE_LX_RSVD_MASK and VTD_SPTE_LPAGE_LX_RSVD_MASK
> Changelog V3:
>  based on the change to split the arrays into two ones
> Changelog V4:
>  style error check
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index a118efaeaf..d62604ece3 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3549,15 +3549,19 @@ static void vtd_init(IntelIOMMUState *s)
>       * Rsvd field masks for spte
>       */
>      vtd_spte_rsvd[0] = ~0ULL;
> -    vtd_spte_rsvd[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits);
> +    vtd_spte_rsvd[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits,
> +                                                  x86_iommu->dt_supported);
>      vtd_spte_rsvd[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
>      vtd_spte_rsvd[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
>      vtd_spte_rsvd[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
>  
>      vtd_spte_rsvd_large[0] = ~0ULL;
> -    vtd_spte_rsvd_large[1] = VTD_SPTE_LPAGE_L1_RSVD_MASK(s->aw_bits);
> -    vtd_spte_rsvd_large[2] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits);
> -    vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits);
> +    vtd_spte_rsvd_large[1] = VTD_SPTE_LPAGE_L1_RSVD_MASK(s->aw_bits,
> +                                                         x86_iommu->dt_supported);
> +    vtd_spte_rsvd_large[2] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits,
> +                                                         x86_iommu->dt_supported);
> +    vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits,
> +                                                         x86_iommu->dt_supported);
>      vtd_spte_rsvd_large[4] = VTD_SPTE_LPAGE_L4_RSVD_MASK(s->aw_bits);
>  
>      if (x86_iommu_ir_supported(x86_iommu)) {
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index c1235a7063..3a839a8925 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -387,7 +387,9 @@ typedef union VTDInvDesc VTDInvDesc;
>  #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0fff8
>  
>  /* Rsvd field masks for spte */
> -#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw) \
> +#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw, dt_supported) \
> +        dt_supported ? \
> +        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
>          (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>  #define VTD_SPTE_PAGE_L2_RSVD_MASK(aw) \
>          (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> @@ -395,11 +397,17 @@ typedef union VTDInvDesc VTDInvDesc;
>          (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>  #define VTD_SPTE_PAGE_L4_RSVD_MASK(aw) \
>          (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> -#define VTD_SPTE_LPAGE_L1_RSVD_MASK(aw) \
> +#define VTD_SPTE_LPAGE_L1_RSVD_MASK(aw, dt_supported) \
> +        dt_supported ? \
> +        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
>          (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> -#define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw) \
> +#define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw, dt_supported) \
> +        dt_supported ? \
> +        (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
>          (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> -#define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw) \
> +#define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw, dt_supported) \
> +        dt_supported ? \
> +        (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
>          (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>  #define VTD_SPTE_LPAGE_L4_RSVD_MASK(aw) \
>          (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> @@ -506,5 +514,6 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_SL_W                    (1ULL << 1)
>  #define VTD_SL_PT_BASE_ADDR_MASK(aw) (~(VTD_PAGE_SIZE - 1) & VTD_HAW_MASK(aw))
>  #define VTD_SL_IGN_COM              0xbff0000000000000ULL
> +#define VTD_SL_TM                   (1ULL << 62)
>  
>  #endif
> -- 
> 2.20.1

