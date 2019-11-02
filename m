Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACE4CA9EC7
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 16:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2E52080F
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 16:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2E52080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQvwC-00040X-KN
	for qemu-devel@archiver.kernel.org; Sat, 02 Nov 2019 12:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iQvuk-000392-IO
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 12:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iQvug-00021G-EW
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 12:06:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39204)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iQvuf-0001fZ-8d
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 12:06:06 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 98AADC00162C
 for <qemu-devel@nongnu.org>; Sat,  2 Nov 2019 16:06:00 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id k184so5180176wmk.1
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2019 09:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=UX85l4bNyuN+zmJ6Zy1yw+PnsuGZRhi4PXpCTSxFSo0=;
 b=C7d26KxgRQH3DD+SZhyshwtv0wtb67j0qui2r0d/NoLX7Zhxpkyi2YquVZdxce3Pzf
 DKt7O0PwbQFuSjHdSVQSPqqjhHOrdz/2LxYOqEOYsZaMBjealYyqHm5aTNpjqh1nn5tU
 9KYFk3DDYKzOxl/8RuIaQd9GDgBrl52qaPrkCO+kcU8FSQ63e3GVu9zqI+X3qsQS1kGS
 1Ii1SgNuWawKI3stFCQXOH1Gm1LBy+X+hqIRpC8N18qzJaiPViGuVE9vVamZOfS5jdR4
 szPHxffF2tMU/p4wPo7pfo97T/hlSD2FZqnVbVfbUVJj0Tuyp7G7njo3gSbtI0+zR1Fy
 kS1g==
X-Gm-Message-State: APjAAAVCq/YhtPTBAVXVS7W5khNzf51GoEL/DVgUr4cqTYFRPxicAPn7
 uvHVyTHNPxvERRbUGLYeRHTIycZKasOh/42papKGgX8n++zTKmrTP++wBTLs4tpM9vzJ3N+9xH3
 NZEj1bUlPEykGlX0=
X-Received: by 2002:a1c:610b:: with SMTP id v11mr15203882wmb.156.1572710759324; 
 Sat, 02 Nov 2019 09:05:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxP0t6ot+ZMTCgURYKUCl069ijcL60b0EgeH0yHcaLePEM7EoRypv3WJa/ydpW8t8uoRedJLw==
X-Received: by 2002:a1c:610b:: with SMTP id v11mr15203866wmb.156.1572710759102; 
 Sat, 02 Nov 2019 09:05:59 -0700 (PDT)
Received: from xz-x1.metropole.lan ([213.58.148.146])
 by smtp.gmail.com with ESMTPSA id b17sm2067953wru.36.2019.11.02.09.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2019 09:05:57 -0700 (PDT)
Date: Sat, 2 Nov 2019 16:05:47 +0000
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC v2 11/22] intel_iommu: process pasid cache invalidation
Message-ID: <20191102160547.GA26023@xz-x1.metropole.lan>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-12-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1571920483-3382-12-git-send-email-yi.l.liu@intel.com>
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, yi.y.sun@intel.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 08:34:32AM -0400, Liu Yi L wrote:
> This patch adds PASID cache invalidation handling. When guest enabled
> PASID usages (e.g. SVA), guest software should issue a proper PASID
> cache invalidation when caching-mode is exposed. This patch only adds
> the draft handling of pasid cache invalidation. Detailed handling will
> be added in subsequent patches.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  hw/i386/intel_iommu.c          | 66 ++++++++++++++++++++++++++++++++++++++----
>  hw/i386/intel_iommu_internal.h | 12 ++++++++
>  hw/i386/trace-events           |  3 ++
>  3 files changed, 76 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 88b843f..84ff6f0 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2335,6 +2335,63 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
>      return true;
>  }
>  
> +static int vtd_pasid_cache_dsi(IntelIOMMUState *s, uint16_t domain_id)
> +{
> +    return 0;
> +}
> +
> +static int vtd_pasid_cache_psi(IntelIOMMUState *s,
> +                               uint16_t domain_id, uint32_t pasid)
> +{
> +    return 0;
> +}
> +
> +static int vtd_pasid_cache_gsi(IntelIOMMUState *s)
> +{
> +    return 0;
> +}
> +
> +static bool vtd_process_pasid_desc(IntelIOMMUState *s,
> +                                   VTDInvDesc *inv_desc)
> +{
> +    uint16_t domain_id;
> +    uint32_t pasid;
> +    int ret = 0;
> +
> +    if ((inv_desc->val[0] & VTD_INV_DESC_PASIDC_RSVD_VAL0) ||
> +        (inv_desc->val[1] & VTD_INV_DESC_PASIDC_RSVD_VAL1) ||
> +        (inv_desc->val[2] & VTD_INV_DESC_PASIDC_RSVD_VAL2) ||
> +        (inv_desc->val[3] & VTD_INV_DESC_PASIDC_RSVD_VAL3)) {
> +        error_report_once("non-zero-field-in-pc_inv_desc hi: 0x%" PRIx64
> +                  " lo: 0x%" PRIx64, inv_desc->val[1], inv_desc->val[0]);
> +        return false;
> +    }
> +
> +    domain_id = VTD_INV_DESC_PASIDC_DID(inv_desc->val[0]);
> +    pasid = VTD_INV_DESC_PASIDC_PASID(inv_desc->val[0]);
> +
> +    switch (inv_desc->val[0] & VTD_INV_DESC_PASIDC_G) {
> +    case VTD_INV_DESC_PASIDC_DSI:
> +        ret = vtd_pasid_cache_dsi(s, domain_id);
> +        break;
> +
> +    case VTD_INV_DESC_PASIDC_PASID_SI:
> +        ret = vtd_pasid_cache_psi(s, domain_id, pasid);
> +        break;
> +
> +    case VTD_INV_DESC_PASIDC_GLOBAL:
> +        ret = vtd_pasid_cache_gsi(s);
> +        break;
> +
> +    default:
> +        error_report_once("invalid-inv-granu-in-pc_inv_desc hi: 0x%" PRIx64
> +                  " lo: 0x%" PRIx64, inv_desc->val[1], inv_desc->val[0]);
> +        return false;
> +    }
> +
> +    return (ret == 0) ? true : false;
> +}
> +
>  static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
>                                       VTDInvDesc *inv_desc)
>  {
> @@ -2441,12 +2498,11 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
>          }
>          break;
>  
> -    /*
> -     * TODO: the entity of below two cases will be implemented in future series.
> -     * To make guest (which integrates scalable mode support patch set in
> -     * iommu driver) work, just return true is enough so far.
> -     */
>      case VTD_INV_DESC_PC:
> +        trace_vtd_inv_desc("pasid-cache", inv_desc.val[1], inv_desc.val[0]);

Could be helpful if you dump [2|3] together here...

> +        if (!vtd_process_pasid_desc(s, &inv_desc)) {
> +            return false;
> +        }
>          break;
>  
>      case VTD_INV_DESC_PIOTLB:
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 8668771..c6cb28b 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -445,6 +445,18 @@ typedef union VTDInvDesc VTDInvDesc;
>  #define VTD_SPTE_LPAGE_L4_RSVD_MASK(aw) \
>          (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>  
> +#define VTD_INV_DESC_PASIDC_G          (3ULL << 4)
> +#define VTD_INV_DESC_PASIDC_PASID(val) (((val) >> 32) & 0xfffffULL)
> +#define VTD_INV_DESC_PASIDC_DID(val)   (((val) >> 16) & VTD_DOMAIN_ID_MASK)
> +#define VTD_INV_DESC_PASIDC_RSVD_VAL0  0xfff000000000ffc0ULL

Nit: Mind to comment here that bit 9-11 is marked as zero rather than
reserved?  This seems to work but if bit 9-11 can be non-zero in some
other descriptors then it would be clearer to define it as
0xfff000000000f1c0ULL then explicitly check bits 9-11.

Otherwise looks good to me.

> +#define VTD_INV_DESC_PASIDC_RSVD_VAL1  0xffffffffffffffffULL
> +#define VTD_INV_DESC_PASIDC_RSVD_VAL2  0xffffffffffffffffULL
> +#define VTD_INV_DESC_PASIDC_RSVD_VAL3  0xffffffffffffffffULL
> +
> +#define VTD_INV_DESC_PASIDC_DSI        (0ULL << 4)
> +#define VTD_INV_DESC_PASIDC_PASID_SI   (1ULL << 4)
> +#define VTD_INV_DESC_PASIDC_GLOBAL     (3ULL << 4)
> +
>  /* Information about page-selective IOTLB invalidate */
>  struct VTDIOTLBPageInvInfo {
>      uint16_t domain_id;
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 43c0314..6da8bd2 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -22,6 +22,9 @@ vtd_inv_qi_head(uint16_t head) "read head %d"
>  vtd_inv_qi_tail(uint16_t head) "write tail %d"
>  vtd_inv_qi_fetch(void) ""
>  vtd_context_cache_reset(void) ""
> +vtd_pasid_cache_gsi(void) ""
> +vtd_pasid_cache_dsi(uint16_t domain) "Domian slective PC invalidation domain 0x%"PRIx16
> +vtd_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID slective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
>  vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
>  vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
>  vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
> -- 
> 2.7.4
> 

-- 
Peter Xu

