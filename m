Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB65C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23DF2207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DF2207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDmgc-0007xK-92
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 05:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iDmdP-0004Og-90
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iDmdN-0003kG-Sq
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:33:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60824)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iDmdN-0003hX-Jr
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:33:53 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1693AC075BD2
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 09:33:52 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id s14so2017938qkg.12
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 02:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7UM00UcrCaSPxcPQqtoVqMVIKFSE6j3nr5iVz7sjcNM=;
 b=pWKUDYTRgh6K7hUX3TR/hLtLD5zfo/jPnW1XoXR4qcUZhPgJzf6Wxxa1pd3QjVGh65
 A83whKc7kErvtZagO0YbYCCwJ1GZ1U3y6p9Ddeh59GeVGEIQr74k9KA8TduNRS8dyFT6
 6nWreoWUPbup6uBmW+dMyftq3o/PEFkbzujr7pUOqz2K/oLj6O7mDIQCLLSdkMS+do9q
 NrNJ+DNY9xzfmQYlU+e5v9FFOGbQRrsFv2ooIP88MBZuubc88o0lCwsefgG0LcPCK6wz
 It4PcdNbGM3wJ08gBie+2WM+drsRsZRFGAEQnWrs1kuVqE8j6Wn1PbjO2tpOONXfcLBY
 mPfQ==
X-Gm-Message-State: APjAAAWQrGZK97sD2e1FLGJvWyut8y6EC5wxwugUzmevQzs+IAxaJw/9
 XJzCP0mvgvLeEXHD2MkB9Vkd5tAOK8KsRMI06p7pMcESGLTOOGzT3i67ITH5jV8RHC9jGi9bstl
 ZtucJYur5f0A0Tq8=
X-Received: by 2002:a05:620a:16da:: with SMTP id
 a26mr3469656qkn.412.1569576831371; 
 Fri, 27 Sep 2019 02:33:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqydB6yjV3BmfaTX2D6jYxPoGXdlwovtXjLPwIy1hyI4KWUzTpudghCHH5snfvLjujSgYz/VtA==
X-Received: by 2002:a05:620a:16da:: with SMTP id
 a26mr3469637qkn.412.1569576831143; 
 Fri, 27 Sep 2019 02:33:51 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id 54sm2520627qts.75.2019.09.27.02.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 02:33:50 -0700 (PDT)
Date: Fri, 27 Sep 2019 05:33:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qi1.zhang@intel.com
Subject: Re: [PATCH V2] intel_iommu: TM field should not be in reserved bits
Message-ID: <20190927053226-mutt-send-email-mst@kernel.org>
References: <20190927045838.2968-1-qi1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927045838.2968-1-qi1.zhang@intel.com>
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
Cc: pbonzini@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 rth@twiddle.net
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


space before ? please.

> +        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
>          (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))

cleaner:
	0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM |
		(dt_supported ? VTD_SL_TM : 0x0))


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

