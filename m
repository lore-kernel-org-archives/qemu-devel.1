Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CBBCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 20:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2EC8204FD
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 20:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EC8204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRiwp-0007IP-7X
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 15:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iRivP-0005ox-9R
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 15:26:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iRivM-0001lc-2u
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 15:26:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46448)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iRivL-0001lP-QK
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 15:26:04 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A23483F3D
 for <qemu-devel@nongnu.org>; Mon,  4 Nov 2019 20:26:02 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id f5so7359520qtm.10
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 12:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Ysl8NWdDLKSUrg85+bpwcp6e6w5APOGKBa/p26qI3+M=;
 b=Q7+ffAUjvIVcYvAcFAyzCSOVbpBI/n2OPnDQ80OIIU+C2WQTZw4qKbC0yqckq7upFC
 GLS3jBILGDIWQ0ds/Qc6YvFQhjKFKxewcVTyHuShvVsqmQ+bBjxQjfhvlNRstMFE74H8
 i9Exc3/YM+jzMY6FsZksl4kxRl+T7YWZz0g6CPUMYzwGfwj9aPNu7Ai7gS2eccShmBat
 srMQDj7oELixuP5P61pMraGU2mNJ5gA29UKTcHcspHKou6RzQyuTtVGbPVICvey9MOUR
 QVtB3kb5pm2bbCTpE2D4BKxDyUA7wTVhem0fP3MRtPAJP7Ci/q04PAmpxz6PnzBalR1h
 wiww==
X-Gm-Message-State: APjAAAUS9NXjIOWYdsD546ALUMlXcwc1gpyblB++i/vvDQnkiA+yctEL
 uXqmtruu2LGzRrlIlkUs9UlK7jxw5AGrcjJngzkgRVgoQj+JghIsDp6/ZCJxp6X4XSD56jcz9b/
 ZKp3IYDtHYg40yD4=
X-Received: by 2002:ac8:67c1:: with SMTP id r1mr13529697qtp.83.1572899161902; 
 Mon, 04 Nov 2019 12:26:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8Dq5DjD6bLYpyps2CBjCCGJAYCgzonb0DT/m01USeUYHURZZmjew0quIs7Nuji0SwjQBkhg==
X-Received: by 2002:ac8:67c1:: with SMTP id r1mr13529677qtp.83.1572899161683; 
 Mon, 04 Nov 2019 12:26:01 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id b2sm2155440qtc.21.2019.11.04.12.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2019 12:26:00 -0800 (PST)
Date: Mon, 4 Nov 2019 15:25:59 -0500
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC v2 15/22] intel_iommu: bind/unbind guest page table to host
Message-ID: <20191104202559.GA12619@xz-x1>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-16-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1571920483-3382-16-git-send-email-yi.l.liu@intel.com>
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

On Thu, Oct 24, 2019 at 08:34:36AM -0400, Liu Yi L wrote:
> This patch captures the guest PASID table entry modifications and
> propagates the changes to host to setup nested translation. The
> guest page table is configured as 1st level page table (GVA->GPA)
> whose translation result would further go through host VT-d 2nd
> level page table(GPA->HPA) under nested translation mode. This is
> a key part of vSVA support.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  hw/i386/intel_iommu.c          | 81 ++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/intel_iommu_internal.h | 20 +++++++++++
>  2 files changed, 101 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index d8827c9..793b0de 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -41,6 +41,7 @@
>  #include "migration/vmstate.h"
>  #include "trace.h"
>  #include "qemu/jhash.h"
> +#include <linux/iommu.h>
>  
>  /* context entry operations */
>  #define VTD_CE_GET_RID2PASID(ce) \
> @@ -695,6 +696,16 @@ static inline uint16_t vtd_pe_get_domain_id(VTDPASIDEntry *pe)
>      return VTD_SM_PASID_ENTRY_DID((pe)->val[1]);
>  }
>  
> +static inline uint32_t vtd_pe_get_fl_aw(VTDPASIDEntry *pe)
> +{
> +    return 48 + ((pe->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM) * 9;
> +}
> +
> +static inline dma_addr_t vtd_pe_get_flpt_base(VTDPASIDEntry *pe)
> +{
> +    return pe->val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
> +}
> +
>  static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
>  {
>      return pdire->val & 1;
> @@ -1850,6 +1861,67 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
>      vtd_iommu_replay_all(s);
>  }
>  
> +static void vtd_bind_guest_pasid(IntelIOMMUState *s, VTDBus *vtd_bus,
> +            int devfn, int pasid, VTDPASIDEntry *pe, VTDPASIDOp op)
> +{
> +#ifdef __linux__
> +    VTDIOMMUContext *vtd_ic;
> +    IOMMUCTXEventData event_data;
> +    IOMMUCTXPASIDBindData bind;
> +    struct iommu_gpasid_bind_data *g_bind_data;
> +
> +    vtd_ic = vtd_bus->dev_ic[devfn];
> +    if (!vtd_ic) {
> +        return;
> +    }
> +
> +    g_bind_data = g_malloc0(sizeof(*g_bind_data));
> +    bind.flag = 0;
> +    g_bind_data->flags = 0;
> +    g_bind_data->vtd.flags = 0;
> +    switch (op) {
> +    case VTD_PASID_BIND:
> +    case VTD_PASID_UPDATE:
> +        g_bind_data->version = IOMMU_GPASID_BIND_VERSION_1;
> +        g_bind_data->format = IOMMU_PASID_FORMAT_INTEL_VTD;
> +        g_bind_data->gpgd = vtd_pe_get_flpt_base(pe);
> +        g_bind_data->addr_width = vtd_pe_get_fl_aw(pe);
> +        g_bind_data->hpasid = pasid;
> +        g_bind_data->gpasid = pasid;
> +        g_bind_data->flags |= IOMMU_SVA_GPASID_VAL;
> +        g_bind_data->vtd.flags =
> +                             (VTD_SM_PASID_ENTRY_SRE_BIT(pe->val[2]) ? 1 : 0)
> +                           | (VTD_SM_PASID_ENTRY_EAFE_BIT(pe->val[2]) ? 1 : 0)
> +                           | (VTD_SM_PASID_ENTRY_PCD_BIT(pe->val[1]) ? 1 : 0)
> +                           | (VTD_SM_PASID_ENTRY_PWT_BIT(pe->val[1]) ? 1 : 0)
> +                           | (VTD_SM_PASID_ENTRY_EMTE_BIT(pe->val[1]) ? 1 : 0)
> +                           | (VTD_SM_PASID_ENTRY_CD_BIT(pe->val[1]) ? 1 : 0);
> +        g_bind_data->vtd.pat = VTD_SM_PASID_ENTRY_PAT(pe->val[1]);
> +        g_bind_data->vtd.emt = VTD_SM_PASID_ENTRY_EMT(pe->val[1]);
> +        bind.flag |= IOMMU_CTX_BIND_PASID;
> +        break;
> +
> +    case VTD_PASID_UNBIND:
> +        g_bind_data->gpgd = 0;
> +        g_bind_data->addr_width = 0;
> +        g_bind_data->hpasid = pasid;
> +        bind.flag |= IOMMU_CTX_UNBIND_PASID;
> +        break;
> +
> +    default:
> +        printf("Unknown VTDPASIDOp!!\n");

Please don't use printf()..  Here assert() suits.

> +        break;
> +    }
> +    if (bind.flag) {

Will this be untrue?  If not, assert() works too.

> +        event_data.event = IOMMU_CTX_EVENT_PASID_BIND;
> +        bind.data = g_bind_data;
> +        event_data.data = &bind;
> +        iommu_ctx_event_notify(&vtd_ic->iommu_context, &event_data);
> +    }
> +    g_free(g_bind_data);
> +#endif
> +}
> +
>  /* Do a context-cache device-selective invalidation.
>   * @func_mask: FM field after shifting
>   */
> @@ -2528,12 +2600,17 @@ static gboolean vtd_flush_pasid(gpointer key, gpointer value,
>                  pc_entry->pasid_cache_gen = s->pasid_cache_gen;
>                  if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
>                      pc_entry->pasid_entry = pe;
> +                    vtd_bind_guest_pasid(s, vtd_bus, devfn,
> +                                     pasid, &pe, VTD_PASID_UPDATE);
>                      /*
>                       * TODO: when pasid-base-iotlb(piotlb) infrastructure is
>                       * ready, should invalidate QEMU piotlb togehter with this
>                       * change.
>                       */
>                  }
> +            } else {
> +                vtd_bind_guest_pasid(s, vtd_bus, devfn,
> +                                  pasid, NULL, VTD_PASID_UNBIND);

Please see the reply in the other thread on vtd_flush_pasid().  I've
filled in where I feel like this UNBIND should exist, I feel like your
current code could miss some places where you should unbind but didn't.

>              }
>          }
>      }
> @@ -2623,6 +2700,10 @@ static inline void vtd_fill_in_pe_cache(
>  
>      pc_entry->pasid_entry = *pe;
>      pc_entry->pasid_cache_gen = s->pasid_cache_gen;
> +    vtd_bind_guest_pasid(s, vtd_pasid_as->vtd_bus,
> +                         vtd_pasid_as->devfn,
> +                         vtd_pasid_as->pasid,
> +                         pe, VTD_PASID_UPDATE);
>  }
>  
>  static int vtd_pasid_cache_psi(IntelIOMMUState *s,
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 12873e1..13e02e8 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -483,6 +483,14 @@ struct VTDRootEntry {
>  };
>  typedef struct VTDRootEntry VTDRootEntry;
>  
> +enum VTDPASIDOp {
> +    VTD_PASID_BIND,
> +    VTD_PASID_UNBIND,
> +    VTD_PASID_UPDATE,
> +    VTD_OP_NUM
> +};
> +typedef enum VTDPASIDOp VTDPASIDOp;
> +
>  struct VTDPASIDCacheInfo {
>  #define VTD_PASID_CACHE_DOMSI   (1ULL << 0);
>  #define VTD_PASID_CACHE_PASIDSI (1ULL << 1);
> @@ -549,6 +557,18 @@ typedef struct VTDPASIDCacheInfo VTDPASIDCacheInfo;
>  #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
>  #define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
>  
> +/* Adjusted guest-address-width */
> +#define VTD_SM_PASID_ENTRY_FLPM          3ULL
> +#define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
> +#define VTD_SM_PASID_ENTRY_SRE_BIT(val)  (!!((val) & 1ULL))
> +#define VTD_SM_PASID_ENTRY_EAFE_BIT(val) (!!(((val) >> 7) & 1ULL))
> +#define VTD_SM_PASID_ENTRY_PCD_BIT(val)  (!!(((val) >> 31) & 1ULL))
> +#define VTD_SM_PASID_ENTRY_PWT_BIT(val)  (!!(((val) >> 30) & 1ULL))
> +#define VTD_SM_PASID_ENTRY_EMTE_BIT(val) (!!(((val) >> 26) & 1ULL))
> +#define VTD_SM_PASID_ENTRY_CD_BIT(val)   (!!(((val) >> 25) & 1ULL))
> +#define VTD_SM_PASID_ENTRY_PAT(val)      (((val) >> 32) & 0xFFFFFFFFULL)
> +#define VTD_SM_PASID_ENTRY_EMT(val)      (((val) >> 27) & 0x7ULL)
> +
>  /* Second Level Page Translation Pointer*/
>  #define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
>  
> -- 
> 2.7.4
> 

-- 
Peter Xu

