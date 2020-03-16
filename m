Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012C3C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 08:01:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF7E20663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 08:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThS1t8Dm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF7E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDkgp-0001GQ-Hx
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 04:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bharatb.linux@gmail.com>) id 1jDkRX-0004m0-Fn
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bharatb.linux@gmail.com>) id 1jDkRV-000360-Sc
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:45:47 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:33482)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bharatb.linux@gmail.com>)
 id 1jDkRV-000307-CZ; Mon, 16 Mar 2020 03:45:45 -0400
Received: by mail-qv1-xf44.google.com with SMTP id cz10so8297790qvb.0;
 Mon, 16 Mar 2020 00:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fZftNYcpGXT78FMRsnc4SZnM9Z6P6UdIlZg56sEcZIA=;
 b=ThS1t8DmIbZAiZ9pIW29/iYOs8b0NAerDEecEO/l0HBcmo5ay6HISbg9EPWlutIOsV
 PAqFjbTNBEVm058ZqZQfReUCjCyWu3J4+UVsg2MmhsDEUIw/xRh7qv4NC0DRMMHdlumM
 xofCVFdXPNI1X+nf6Zw2qEV7O281cfWXphIQJRm3KS7++h4vAaulU2Kgfb2bS4NZMfM2
 yXppRrebUxxQSBBlo+ywDsUZJTrpjGD6/Ep45I+QdU6t8hHsLrCXBI2zA1IchMsxkqFY
 9mwnkgVIfnGfFHQvXgG/WggPl355zMltK1Mh8WDn199bNpVhK1nsHPG/lJc4l5g2CzdR
 hCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fZftNYcpGXT78FMRsnc4SZnM9Z6P6UdIlZg56sEcZIA=;
 b=ZIgWyHrRS8uYUaedIWa+zunxC7pI0/hR2v80UnQoplDgrbPefeiAui8Wkuefg4kxuK
 Rq1hU51rH3wS6Wi4j2ytSyEbyT/REftEzOQsqIQP6ZgnxpxAuCCmvQ6j78OBXk7oImcs
 sW4gj9J1mfWzVDgqFbjkOskCDK3t2XIFC1D/8xNtdfuZH4H0ga3YY4yRmkXu2oX8kgxY
 ItzxuiuRLjcJcWW97mjQJ8ZaHaL+Q4o2v6S6gu2dGF9IKFUuvocuwFpRVZDxpKr30QsK
 UUbYufuI1Ncs7GMs92cHujcRaD1beNg049K4c0fuI+GIa6lBHkhmXPOUPa5lQV66ySej
 /DJw==
X-Gm-Message-State: ANhLgQ0gIyjBbJHrsm4yWJBpA4VWbc2gcGNN81w5sbj5EPobZEl6FbI2
 o33gEo7TD+0xEsuWcp7EJxX7gxQg7nZlAKr9noQ=
X-Google-Smtp-Source: ADFU+vso0v9JsyZJMlvpO1CdkLFHzAPE5Xwg/OhEuER97afuZhVDiEXUYhJT7FsprG0Vzc3LhvX4j37c4g58SM0oz5s=
X-Received: by 2002:a0c:aee5:: with SMTP id n37mr22052207qvd.173.1584344744284; 
 Mon, 16 Mar 2020 00:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200313074811.27175-1-bbhushan2@marvell.com>
 <20200313074811.27175-4-bbhushan2@marvell.com>
 <da0a4d7b-c27d-839d-56b6-da67c94adeb7@redhat.com>
 <CAAeCc_m=PKV0T8DmaE06F9NMYfU792f9TDdoyKkaPaEN3597ag@mail.gmail.com>
 <9b4ab5e8-8848-50ba-17c8-652567483126@redhat.com>
In-Reply-To: <9b4ab5e8-8848-50ba-17c8-652567483126@redhat.com>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Mon, 16 Mar 2020 13:15:33 +0530
Message-ID: <CAAeCc_ksAdoNJcFWkoB4YcySAb5Hw7D+kLyHx-Nt0hZJY17AXA@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] virtio-iommu: Call iommu notifier for attach/detach
To: Auger Eric <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 mst@redhat.com, drjones@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, qemu-arm@nongnu.org,
 Bharat Bhushan <bbhushan2@marvell.com>, linuc.decode@gmail.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

On Mon, Mar 16, 2020 at 1:02 PM Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Bharat,
>
> On 3/16/20 7:41 AM, Bharat Bhushan wrote:
> > Hi Eric,
> >
> > On Fri, Mar 13, 2020 at 8:11 PM Auger Eric <eric.auger@redhat.com> wrote:
> >>
> >> Hi Bharat
> >>
> >> On 3/13/20 8:48 AM, Bharat Bhushan wrote:
> >>> iommu-notifier are called when a device is attached
> >> IOMMU notifiers
> >>> or detached to as address-space.
> >>> This is needed for VFIO.
> >> and vhost for detach
> >>>
> >>> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> >>> ---
> >>>  hw/virtio/virtio-iommu.c | 47 ++++++++++++++++++++++++++++++++++++++++
> >>>  1 file changed, 47 insertions(+)
> >>>
> >>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> >>> index e51344a53e..2006f72901 100644
> >>> --- a/hw/virtio/virtio-iommu.c
> >>> +++ b/hw/virtio/virtio-iommu.c
> >>> @@ -49,6 +49,7 @@ typedef struct VirtIOIOMMUEndpoint {
> >>>      uint32_t id;
> >>>      VirtIOIOMMUDomain *domain;
> >>>      QLIST_ENTRY(VirtIOIOMMUEndpoint) next;
> >>> +    VirtIOIOMMU *viommu;
> >> This needs specal care on post-load. When migrating the EPs, only the id
> >> is migrated. On post-load you need to set viommu as it is done for
> >> domain. migration is allowed with vhost.
> >
> > ok, I have not tried vhost/migration. Below change set viommu when
> > reconstructing endpoint.
>
>
> Yes I think this should be OK.
>
> By the end I did the series a try with vhost/vfio. with vhost it works
> (not with recent kernel though, but the issue may be related to kernel).
> With VFIO however it does not for me.
>
> First issue is: your guest can use 4K page and your host can use 64KB
> pages. In that case VFIO_DMA_MAP will fail with -EINVAL. We must devise
> a way to pass the host settings to the VIRTIO-IOMMU device.
>
> Even with 64KB pages, it did not work for me. I have obviously not the
> storm of VFIO_DMA_MAP failures but I have some, most probably due to
> some wrong notifications somewhere. I will try to investigate on my side.
>
> Did you test with VFIO on your side?

I did not tried with different page sizes, only tested with 4K page size.

Yes it works, I tested with two n/w device assigned to VM, both interfaces works

First I will try with 64k page size.

Thanks
-Bharat

>
> Thanks
>
> Eric
> >
> > @@ -984,6 +973,7 @@ static gboolean reconstruct_endpoints(gpointer
> > key, gpointer value,
> >
> >      QLIST_FOREACH(iter, &d->endpoint_list, next) {
> >          iter->domain = d;
> > +       iter->viommu = s;
> >          g_tree_insert(s->endpoints, GUINT_TO_POINTER(iter->id), iter);
> >      }
> >      return false; /* continue the domain traversal */
> >
> >>>  } VirtIOIOMMUEndpoint;
> >>>
> >>>  typedef struct VirtIOIOMMUInterval {
> >>> @@ -155,8 +156,44 @@ static void virtio_iommu_notify_unmap(IOMMUMemoryRegion *mr, hwaddr iova,
> >>>      memory_region_notify_iommu(mr, 0, entry);
> >>>  }
> >>>
> >>> +static gboolean virtio_iommu_mapping_unmap(gpointer key, gpointer value,
> >>> +                                           gpointer data)
> >>> +{
> >>> +    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
> >>> +    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
> >>> +
> >>> +    virtio_iommu_notify_unmap(mr, interval->low,
> >>> +                              interval->high - interval->low + 1);
> >>> +
> >>> +    return false;
> >>> +}
> >>> +
> >>> +static gboolean virtio_iommu_mapping_map(gpointer key, gpointer value,
> >>> +                                         gpointer data)
> >>> +{
> >>> +    VirtIOIOMMUMapping *mapping = (VirtIOIOMMUMapping *) value;
> >>> +    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
> >>> +    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
> >>> +
> >>> +    virtio_iommu_notify_map(mr, interval->low, mapping->phys_addr,
> >>> +                            interval->high - interval->low + 1);
> >>> +
> >>> +    return false;
> >>> +}
> >>> +
> >>>  static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEndpoint *ep)
> >>>  {
> >>> +    VirtioIOMMUNotifierNode *node;
> >>> +    VirtIOIOMMU *s = ep->viommu;
> >>> +    VirtIOIOMMUDomain *domain = ep->domain;
> >>> +
> >>> +    QLIST_FOREACH(node, &s->notifiers_list, next) {
> >>> +        if (ep->id == node->iommu_dev->devfn) {
> >>> +            g_tree_foreach(domain->mappings, virtio_iommu_mapping_unmap,
> >>> +                           &node->iommu_dev->iommu_mr);
> >> I understand this should fo the job for domain removal
> >
> > did not get the comment, are you saying we should do this on domain removal?
> see my reply on 2/5
>
> Note the above code should be moved after the check of !ep->domain below

ohh yes, will move

Thanks
-Bharat

> >
> >>> +        }
> >>> +    }
> >>> +
> >>>      if (!ep->domain) {
> >>>          return;
> >>>      }
> >>> @@ -178,6 +215,7 @@ static VirtIOIOMMUEndpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
> >>>      }
> >>>      ep = g_malloc0(sizeof(*ep));
> >>>      ep->id = ep_id;
> >>> +    ep->viommu = s;
> >>>      trace_virtio_iommu_get_endpoint(ep_id);
> >>>      g_tree_insert(s->endpoints, GUINT_TO_POINTER(ep_id), ep);
> >>>      return ep;
> >>> @@ -272,6 +310,7 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
> >>>  {
> >>>      uint32_t domain_id = le32_to_cpu(req->domain);
> >>>      uint32_t ep_id = le32_to_cpu(req->endpoint);
> >>> +    VirtioIOMMUNotifierNode *node;
> >>>      VirtIOIOMMUDomain *domain;
> >>>      VirtIOIOMMUEndpoint *ep;
> >>>
> >>> @@ -299,6 +338,14 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
> >>>
> >>>      ep->domain = domain;
> >>>
> >>> +    /* Replay existing address space mappings on the associated memory region */
> >> maybe use the "domain" terminology here.
> >
> > ok,
> >
> > Thanks
> > -Bharat
> >
> >>> +    QLIST_FOREACH(node, &s->notifiers_list, next) {
> >>> +        if (ep_id == node->iommu_dev->devfn) {
> >>> +            g_tree_foreach(domain->mappings, virtio_iommu_mapping_map,
> >>> +                           &node->iommu_dev->iommu_mr);
> >>> +        }
> >>> +    }
> >>> +
> >>>      return VIRTIO_IOMMU_S_OK;
> >>>  }
> >>>
> >>>
> >> Thanks
> >>
> >> Eric
> >>
> >
>

