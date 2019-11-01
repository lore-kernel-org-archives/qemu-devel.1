Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED12CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 14:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74CBE20650
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 14:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74CBE20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQYOB-0005he-J6
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 10:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iQYNG-0005DQ-Cb
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 10:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iQYNE-0007Bt-Cl
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 10:58:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34770)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iQYNE-00070p-2c
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 10:58:00 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BAD163DE20
 for <qemu-devel@nongnu.org>; Fri,  1 Nov 2019 14:57:57 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id j17so5442618wru.13
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 07:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mxbhV/T/CvsMOMyGYwlWuXmCgdmHOLkaW1oOJvRLs5U=;
 b=q5oAU/fHHmKOMpgZaZAsHcdXjI6bqMLcnzW/QgAOJuaswhQ0HXdRm1NIt0ETU7YRjG
 zLa4oA4zAkmjMxBy2Tb1VJ4+vo37XiR7hxX3LN3zlPR5/twoKxTg1beaaDwRwEKebWQU
 LFlqR/OE+a1mSufiI/INhNgv+P6B+uo1gmDD9eOsFoApwr6njFu84CUb963ANtE6kJit
 ovf2Kc/Cl6YUDMVCrPaHdpHuz+smzrgYZOA5AZzdsN1nhrEY0JNhlI5jd8tMWnmAIQRt
 /rK6CnYOqhmSC45JIb98WPuLkIBfQzFz8SjSaWuyXvm14FUoAf3j7rQ0sKsAB4+wMfiJ
 eXCw==
X-Gm-Message-State: APjAAAWyQtLCpYyGWnQW4CXR3yziUrrwWVw7YD6QmWVMy3evPod2rl5f
 tUy0xGPtxI+cyNBpTeHAPgaAMRux4aHKuxTrTrENNKAH0hIDJaSutoS2xtdXD7lm2yLdwn5zZpl
 VH3MtZmVhRBy7+Gw=
X-Received: by 2002:adf:9dca:: with SMTP id q10mr11007753wre.183.1572620276515; 
 Fri, 01 Nov 2019 07:57:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy3RPaeRKKYjy99njnTtrRhDleSomhc57v9Y+qUEuftHEy0zp6kpuXrxOSkCRCWs1qec44ivA==
X-Received: by 2002:adf:9dca:: with SMTP id q10mr11007730wre.183.1572620276332; 
 Fri, 01 Nov 2019 07:57:56 -0700 (PDT)
Received: from xz-x1.metropole.lan ([91.217.168.176])
 by smtp.gmail.com with ESMTPSA id y1sm7962105wrw.6.2019.11.01.07.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 07:57:55 -0700 (PDT)
Date: Fri, 1 Nov 2019 15:57:53 +0100
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC v2 03/22] intel_iommu: modify x-scalable-mode to be string
 option
Message-ID: <20191101145753.GC8888@xz-x1.metropole.lan>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-4-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1571920483-3382-4-git-send-email-yi.l.liu@intel.com>
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

On Thu, Oct 24, 2019 at 08:34:24AM -0400, Liu Yi L wrote:
> Intel VT-d 3.0 introduces scalable mode, and it has a bunch of capabilities
> related to scalable mode translation, thus there are multiple combinations.
> While this vIOMMU implementation wants simplify it for user by providing
> typical combinations. User could config it by "x-scalable-mode" option. The
> usage is as below:
> 
> "-device intel-iommu,x-scalable-mode=["legacy"|"modern"]"
> 
>  - "legacy": gives support for SL page table
>  - "modern": gives support for FL page table, pasid, virtual command
>  -  if not configured, means no scalable mode support, if not proper
>     configured, will throw error
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> ---
>  hw/i386/intel_iommu.c          | 15 +++++++++++++--
>  hw/i386/intel_iommu_internal.h |  3 +++
>  include/hw/i386/intel_iommu.h  |  2 +-
>  3 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 771bed2..4a1a07a 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3019,7 +3019,7 @@ static Property vtd_properties[] = {
>      DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
>                        VTD_HOST_ADDRESS_WIDTH),
>      DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
> -    DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
> +    DEFINE_PROP_STRING("x-scalable-mode", IntelIOMMUState, scalable_mode),
>      DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> @@ -3581,7 +3581,12 @@ static void vtd_init(IntelIOMMUState *s)
>  
>      /* TODO: read cap/ecap from host to decide which cap to be exposed. */
>      if (s->scalable_mode) {
> -        s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
> +        if (!strcmp(s->scalable_mode, "legacy")) {
> +            s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
> +        } else if (!strcmp(s->scalable_mode, "modern")) {
> +            s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_PASID
> +                       | VTD_ECAP_FLTS | VTD_ECAP_PSS;
> +        }

Shall we do this string op only once in vtd_decide_config() then keep
it somewhere?

Something like:

  - s->scalable_mode_str to keep the string
  - s->scalable_mode still as a bool to cache the global enablement
  - s->scalable_modern as a bool to keep the mode

?

These could be used in some MMIO path (I think) and parsing strings
always could be a bit overkill.

>      }
>  
>      vtd_reset_caches(s);
> @@ -3700,6 +3705,12 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>          return false;
>      }
>  
> +    if (s->scalable_mode &&
> +        (strcmp(s->scalable_mode, "modern") &&
> +         strcmp(s->scalable_mode, "legacy"))) {
> +            error_setg(errp, "Invalid x-scalable-mode config");
> +    }
> +
>      return true;
>  }
>  
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index c1235a7..be7b30a 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -190,8 +190,11 @@
>  #define VTD_ECAP_PT                 (1ULL << 6)
>  #define VTD_ECAP_MHMV               (15ULL << 20)
>  #define VTD_ECAP_SRS                (1ULL << 31)
> +#define VTD_ECAP_PSS                (19ULL << 35)
> +#define VTD_ECAP_PASID              (1ULL << 40)
>  #define VTD_ECAP_SMTS               (1ULL << 43)
>  #define VTD_ECAP_SLTS               (1ULL << 46)
> +#define VTD_ECAP_FLTS               (1ULL << 47)
>  
>  /* CAP_REG */
>  /* (offset >> 4) << 24 */
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 66b931e..6062588 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -231,7 +231,7 @@ struct IntelIOMMUState {
>      uint32_t version;
>  
>      bool caching_mode;              /* RO - is cap CM enabled? */
> -    bool scalable_mode;             /* RO - is Scalable Mode supported? */
> +    char *scalable_mode;            /* RO - Scalable Mode model */
>  
>      dma_addr_t root;                /* Current root table pointer */
>      bool root_scalable;             /* Type of root table (scalable or not) */
> -- 
> 2.7.4
> 

Regards,

-- 
Peter Xu

