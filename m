Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C11C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:28:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A4F217F5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A4F217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSMIj-0000zn-Hk
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 09:28:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iSMHz-0000RN-GL
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:28:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iSMHy-00024g-2z
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:28:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:21197)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iSMHw-000225-0p
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:28:00 -0500
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C8D548665A
 for <qemu-devel@nongnu.org>; Wed,  6 Nov 2019 14:27:57 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id i9so15877406qtq.11
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 06:27:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=F+Qn6CyJx76tnRGRBhaBq2PcYvQUuntn1zr+y079x5g=;
 b=avowM1V70+2uwSHyHe159CsBvzfImVcG0ph2bzOXYFGTeT2aHlJMOyLPDnAIoECnyo
 Tmdkvsj++NBAmrq8jkGzCChlANA+bv+fNWYpJIn1OrrFh9PJmTuwavzxDX+yJ1N30N8i
 wvPj1RqjDGf6919TQhPTiNeikIBE91CsmvgRRhgRZf2Ol5skEJYmyegUKQe43IFvb7hQ
 fEY6a4k8RP7yvmEwXGTs2xWy3udMVGU3jKdSNVSQYr2jMAMqPFA8oFa7TBoVu1bLQT7g
 /Xmg5otDNYaTzWgz32TPhRkIkd+kFOLEodkJ9g1amOGNRJwPQ7abUT2x3lWK0udfOZLG
 g8OQ==
X-Gm-Message-State: APjAAAVXvM4oxibN7w/x7ujc0Ldx/1uWjNblnFO/Mn6E1VyDXfD8Uum8
 7Nj1J0mGVAGQjwbWlpC5ELzw9eDLobxCyqct2zWP9e1ASoHzhJZETMQKZ4p4mSJ6VtMf5LCj5EA
 sIu9NcMjljbQoo2c=
X-Received: by 2002:a0c:d2b4:: with SMTP id q49mr2357995qvh.135.1573050477044; 
 Wed, 06 Nov 2019 06:27:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzdQX5lZeTrvzfdffsUSxXAyNg6fbC9M02lk8p46D67QyqunBvsXiuXwOTv/GXYGGtTABIjRA==
X-Received: by 2002:a0c:d2b4:: with SMTP id q49mr2357970qvh.135.1573050476749; 
 Wed, 06 Nov 2019 06:27:56 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id z3sm13464408qtu.83.2019.11.06.06.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 06:27:56 -0800 (PST)
Date: Wed, 6 Nov 2019 09:27:54 -0500
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v2 15/22] intel_iommu: bind/unbind guest page table to host
Message-ID: <20191106142754.GC29717@xz-x1>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-16-git-send-email-yi.l.liu@intel.com>
 <20191104202559.GA12619@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A0EEF4D@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A0EEF4D@SHSMSX104.ccr.corp.intel.com>
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 06, 2019 at 08:10:59AM +0000, Liu, Yi L wrote:
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Tuesday, November 5, 2019 4:26 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [RFC v2 15/22] intel_iommu: bind/unbind guest page table to host
> > 
> > On Thu, Oct 24, 2019 at 08:34:36AM -0400, Liu Yi L wrote:
> > > This patch captures the guest PASID table entry modifications and
> > > propagates the changes to host to setup nested translation. The
> > > guest page table is configured as 1st level page table (GVA->GPA)
> > > whose translation result would further go through host VT-d 2nd
> > > level page table(GPA->HPA) under nested translation mode. This is
> > > a key part of vSVA support.
> > >
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > ---
> > >  hw/i386/intel_iommu.c          | 81
> > ++++++++++++++++++++++++++++++++++++++++++
> > >  hw/i386/intel_iommu_internal.h | 20 +++++++++++
> > >  2 files changed, 101 insertions(+)
> > >
> > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > > index d8827c9..793b0de 100644
> > > --- a/hw/i386/intel_iommu.c
> > > +++ b/hw/i386/intel_iommu.c
> > > @@ -41,6 +41,7 @@
> > >  #include "migration/vmstate.h"
> > >  #include "trace.h"
> > >  #include "qemu/jhash.h"
> > > +#include <linux/iommu.h>
> > >
> > >  /* context entry operations */
> > >  #define VTD_CE_GET_RID2PASID(ce) \
> > > @@ -695,6 +696,16 @@ static inline uint16_t
> > vtd_pe_get_domain_id(VTDPASIDEntry *pe)
> > >      return VTD_SM_PASID_ENTRY_DID((pe)->val[1]);
> > >  }
> > >
> > > +static inline uint32_t vtd_pe_get_fl_aw(VTDPASIDEntry *pe)
> > > +{
> > > +    return 48 + ((pe->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM) * 9;
> > > +}
> > > +
> > > +static inline dma_addr_t vtd_pe_get_flpt_base(VTDPASIDEntry *pe)
> > > +{
> > > +    return pe->val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
> > > +}
> > > +
> > >  static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
> > >  {
> > >      return pdire->val & 1;
> > > @@ -1850,6 +1861,67 @@ static void
> > vtd_context_global_invalidate(IntelIOMMUState *s)
> > >      vtd_iommu_replay_all(s);
> > >  }
> > >
> > > +static void vtd_bind_guest_pasid(IntelIOMMUState *s, VTDBus *vtd_bus,
> > > +            int devfn, int pasid, VTDPASIDEntry *pe, VTDPASIDOp op)
> > > +{
> > > +#ifdef __linux__
> > > +    VTDIOMMUContext *vtd_ic;
> > > +    IOMMUCTXEventData event_data;
> > > +    IOMMUCTXPASIDBindData bind;
> > > +    struct iommu_gpasid_bind_data *g_bind_data;
> > > +
> > > +    vtd_ic = vtd_bus->dev_ic[devfn];
> > > +    if (!vtd_ic) {
> > > +        return;
> > > +    }
> > > +
> > > +    g_bind_data = g_malloc0(sizeof(*g_bind_data));
> > > +    bind.flag = 0;
> > > +    g_bind_data->flags = 0;
> > > +    g_bind_data->vtd.flags = 0;
> > > +    switch (op) {
> > > +    case VTD_PASID_BIND:
> > > +    case VTD_PASID_UPDATE:
> > > +        g_bind_data->version = IOMMU_GPASID_BIND_VERSION_1;
> > > +        g_bind_data->format = IOMMU_PASID_FORMAT_INTEL_VTD;
> > > +        g_bind_data->gpgd = vtd_pe_get_flpt_base(pe);
> > > +        g_bind_data->addr_width = vtd_pe_get_fl_aw(pe);
> > > +        g_bind_data->hpasid = pasid;
> > > +        g_bind_data->gpasid = pasid;
> > > +        g_bind_data->flags |= IOMMU_SVA_GPASID_VAL;
> > > +        g_bind_data->vtd.flags =
> > > +                             (VTD_SM_PASID_ENTRY_SRE_BIT(pe->val[2]) ? 1 : 0)
> > > +                           | (VTD_SM_PASID_ENTRY_EAFE_BIT(pe->val[2]) ? 1 : 0)
> > > +                           | (VTD_SM_PASID_ENTRY_PCD_BIT(pe->val[1]) ? 1 : 0)
> > > +                           | (VTD_SM_PASID_ENTRY_PWT_BIT(pe->val[1]) ? 1 : 0)
> > > +                           | (VTD_SM_PASID_ENTRY_EMTE_BIT(pe->val[1]) ? 1 : 0)
> > > +                           | (VTD_SM_PASID_ENTRY_CD_BIT(pe->val[1]) ? 1 : 0);
> > > +        g_bind_data->vtd.pat = VTD_SM_PASID_ENTRY_PAT(pe->val[1]);
> > > +        g_bind_data->vtd.emt = VTD_SM_PASID_ENTRY_EMT(pe->val[1]);
> > > +        bind.flag |= IOMMU_CTX_BIND_PASID;
> > > +        break;
> > > +
> > > +    case VTD_PASID_UNBIND:
> > > +        g_bind_data->gpgd = 0;
> > > +        g_bind_data->addr_width = 0;
> > > +        g_bind_data->hpasid = pasid;
> > > +        bind.flag |= IOMMU_CTX_UNBIND_PASID;
> > > +        break;
> > > +
> > > +    default:
> > > +        printf("Unknown VTDPASIDOp!!\n");
> > 
> > Please don't use printf()..  Here assert() suits.
> 
> Will correct it. Thanks.
> 
> > 
> > > +        break;
> > > +    }
> > > +    if (bind.flag) {
> > 
> > Will this be untrue?  If not, assert() works too.
> 
> yes, it is possible. If an unknown VTDPASIDOp, then no switch case
> will initiate bind.flag.

Then should it be a programming error?  If so we should still use
assert(), I think...

> 
> > > +        event_data.event = IOMMU_CTX_EVENT_PASID_BIND;
> > > +        bind.data = g_bind_data;
> > > +        event_data.data = &bind;
> > > +        iommu_ctx_event_notify(&vtd_ic->iommu_context, &event_data);
> > > +    }
> > > +    g_free(g_bind_data);
> > > +#endif
> > > +}
> > > +
> > >  /* Do a context-cache device-selective invalidation.
> > >   * @func_mask: FM field after shifting
> > >   */
> > > @@ -2528,12 +2600,17 @@ static gboolean vtd_flush_pasid(gpointer key,
> > gpointer value,
> > >                  pc_entry->pasid_cache_gen = s->pasid_cache_gen;
> > >                  if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
> > >                      pc_entry->pasid_entry = pe;
> > > +                    vtd_bind_guest_pasid(s, vtd_bus, devfn,
> > > +                                     pasid, &pe, VTD_PASID_UPDATE);
> > >                      /*
> > >                       * TODO: when pasid-base-iotlb(piotlb) infrastructure is
> > >                       * ready, should invalidate QEMU piotlb togehter with this
> > >                       * change.
> > >                       */
> > >                  }
> > > +            } else {
> > > +                vtd_bind_guest_pasid(s, vtd_bus, devfn,
> > > +                                  pasid, NULL, VTD_PASID_UNBIND);
> > 
> > Please see the reply in the other thread on vtd_flush_pasid().  I've
> > filled in where I feel like this UNBIND should exist, I feel like your
> > current code could miss some places where you should unbind but didn't.
> 
> I've replied in that thread regards to your comments. May you
> reconsider it here. Hope, it suits what you thought. If still
> something missed, pls feel free to point out.

Ok let's wait to see your next version.  Thanks,

-- 
Peter Xu

