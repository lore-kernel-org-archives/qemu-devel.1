Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A3BC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 19:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C0A208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 19:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C0A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsuEY-00048r-N5
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 15:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39312)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hsuDw-0003bn-AE
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 15:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hsuDu-0001Vc-QO
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 15:25:20 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46907)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hsuDu-0001VK-KV
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 15:25:18 -0400
Received: by mail-ua1-f67.google.com with SMTP id o19so27422728uap.13
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 12:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+CbvwvbnfA818mkjtNcJHKeaTSPk5Cv2KGP0rJtEuwE=;
 b=ZA0G7SAkmHwWsUTU2UjQGPwun/HlPSvPhnG3f7led1kby89sX2mGzXA+u/vpDLCB4I
 Xb7wIuWC9C4aifPS5O2J29o4mbKrDuoPuZLjqsAzHrV1EnfGvpF6puwUv8knQ4d9P3YO
 MRD7B9SmYVsBfUeBXmwgoGrk72ckgCrikt0xgYIiSYhWCYdeD0ttf+oWBa/+Repf4GpI
 lz2XNYrXlJbEh4JJ584izVJ9rzizx+w+Kx+mdaDNBPgU0oZTZR8bhpHm4iRxV0KXFFmH
 3PP1mJb4Z6HE+8l32hFfshXuvE54ZZiepDhXTbs5+9gAV5Dn/rJNHpR7S3NardlfIlJC
 muHw==
X-Gm-Message-State: APjAAAX1tK06wnqa88WqbqH6JajTLPs2NSsQZ6KksE5PDDQfbQqROh8b
 cn9f4ZMyidHBgUWMfS2T9/sjRg==
X-Google-Smtp-Source: APXvYqzlqqIGBA0zCfbH4Yx//bjFhd25GHVV3dUdFAOAMrYR7+2KRLG7r4foaf5cW0qM3Vjcv76Prw==
X-Received: by 2002:a9f:3c24:: with SMTP id u36mr47313326uah.60.1564601117676; 
 Wed, 31 Jul 2019 12:25:17 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 m3sm18662671vkl.55.2019.07.31.12.25.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 12:25:16 -0700 (PDT)
Date: Wed, 31 Jul 2019 15:25:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Message-ID: <20190731151834-mutt-send-email-mst@kernel.org>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-12-eric.auger@redhat.com>
 <20190730153628-mutt-send-email-mst@kernel.org>
 <AADFC41AFE54684AB9EE6CBC0274A5D19CAF8E1B@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19CAF8E1B@SHSMSX104.ccr.corp.intel.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.67
Subject: Re: [Qemu-devel] [PATCH for-4.2 v10 11/15] virtio-iommu: Expose the
 IOAPIC MSI reserved region when relevant
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "tn@semihalf.com" <tn@semihalf.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 30, 2019 at 11:20:44PM +0000, Tian, Kevin wrote:
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Wednesday, July 31, 2019 3:38 AM
> > 
> > On Tue, Jul 30, 2019 at 07:21:33PM +0200, Eric Auger wrote:
> > > We introduce a new msi_bypass field which indicates whether
> > > the IOAPIC MSI window [0xFEE00000 - 0xFEEFFFFF] must be exposed
> 
> it's not good to call it IOAPIC MSI window. any write to this range, either
> from IOAPIC or PCI device, is interpreted by the platform as interrupt
> request. I'd call it "x86 interrupt address range".

Isn't this APIC_DEFAULT_ADDRESS? I'm not sure guests can't change it
even though I'm not sure qemu supports changing it.

And if so I'd say integrating IOAPIC defaults into the device itself is
inelegant.  How about having guest supply the range through config
space? It's a small change that won't be too late for Linux.

> > > as a reserved region. By default the field is set to true at
> > > instantiation time. Later on we will introduce a property at
> > > virtio pci proxy level to turn it off.
> > >
> > > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > >
> > > ---
> > >
> > > v8 -> v9:
> > > - pass IOAPIC_RANGE_END to virtio_iommu_register_resv_region
> > > - take into account the change in the struct virtio_iommu_probe_resv_mem
> > >   definition
> > > - We just introduce the field here. A property will be introduced later on
> > >   at pci proxy level.
> > > ---
> > >  hw/virtio/virtio-iommu.c         | 36 ++++++++++++++++++++++++++++++++
> > >  include/hw/virtio/virtio-iommu.h |  1 +
> > >  2 files changed, 37 insertions(+)
> > >
> > > diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> > > index 66be9a4627..74038288b0 100644
> > > --- a/hw/virtio/virtio-iommu.c
> > > +++ b/hw/virtio/virtio-iommu.c
> > > @@ -39,6 +39,9 @@
> > >  #define VIOMMU_DEFAULT_QUEUE_SIZE 256
> > >  #define VIOMMU_PROBE_SIZE 512
> > >
> > > +#define IOAPIC_RANGE_START      (0xfee00000)
> > > +#define IOAPIC_RANGE_END        (0xfeefffff)
> > > +
> > >  #define SUPPORTED_PROBE_PROPERTIES (\
> > >      1 << VIRTIO_IOMMU_PROBE_T_RESV_MEM)
> > >
> > 
> > Sorry where are these numbers coming from?
> 
> this is architecturally defined in x86 SDM.
> 
> > Does this really work on all platforms?
> 
> x86 only. 

But you seem to add this code for all platforms:

	@@ -6,6 +6,11 @@ config VIRTIO_RNG
	     default y
	     depends on VIRTIO

	+config VIRTIO_IOMMU
	+    bool
	+    default y
	+    depends on VIRTIO
	+    


> > With all guests?
> 
> yes.
> 
> > 
> > > @@ -100,6 +103,30 @@ static void
> > virtio_iommu_detach_endpoint_from_domain(viommu_endpoint *ep)
> > >      ep->domain = NULL;
> > >  }
> > >
> > > +static void virtio_iommu_register_resv_region(viommu_endpoint *ep,
> > > +                                              uint8_t subtype,
> > > +                                              uint64_t start, uint64_t end)
> > > +{
> > > +    viommu_interval *interval;
> > > +    struct virtio_iommu_probe_resv_mem *resv_reg_prop;
> > > +    size_t prop_size = sizeof(struct virtio_iommu_probe_resv_mem);
> > > +    size_t value_size = prop_size -
> > > +                sizeof(struct virtio_iommu_probe_property);
> > > +
> > > +    interval = g_malloc0(sizeof(*interval));
> > > +    interval->low = start;
> > > +    interval->high = end;
> > > +
> > > +    resv_reg_prop = g_malloc0(prop_size);
> > > +    resv_reg_prop->head.type = VIRTIO_IOMMU_PROBE_T_RESV_MEM;
> > > +    resv_reg_prop->head.length = cpu_to_le64(value_size);
> > > +    resv_reg_prop->subtype = cpu_to_le64(subtype);
> > > +    resv_reg_prop->start = cpu_to_le64(start);
> > > +    resv_reg_prop->end = cpu_to_le64(end);
> > > +
> > > +    g_tree_insert(ep->reserved_regions, interval, resv_reg_prop);
> > > +}
> > > +
> > >  static viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
> > >                                                    uint32_t ep_id)
> > >  {
> > > @@ -117,6 +144,12 @@ static viommu_endpoint
> > *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
> > >      ep->reserved_regions =
> > g_tree_new_full((GCompareDataFunc)interval_cmp,
> > >                                              NULL, (GDestroyNotify)g_free,
> > >                                              (GDestroyNotify)g_free);
> > > +    if (s->msi_bypass) {
> > > +        virtio_iommu_register_resv_region(ep,
> > VIRTIO_IOMMU_RESV_MEM_T_MSI,
> > > +                                          IOAPIC_RANGE_START,
> > > +                                          IOAPIC_RANGE_END);
> > > +    }
> > > +
> > >      return ep;
> > >  }
> > >
> > > @@ -822,6 +855,9 @@ static void virtio_iommu_set_status(VirtIODevice
> > *vdev, uint8_t status)
> > >
> > >  static void virtio_iommu_instance_init(Object *obj)
> > >  {
> > > +    VirtIOIOMMU *s = VIRTIO_IOMMU(obj);
> > > +
> > > +    s->msi_bypass = true;
> > >  }
> > >
> > >  static const VMStateDescription vmstate_virtio_iommu = {
> > > diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-
> > iommu.h
> > > index f55f48d304..56c8b4e57f 100644
> > > --- a/include/hw/virtio/virtio-iommu.h
> > > +++ b/include/hw/virtio/virtio-iommu.h
> > > @@ -59,6 +59,7 @@ typedef struct VirtIOIOMMU {
> > >      GTree *domains;
> > >      QemuMutex mutex;
> > >      GTree *endpoints;
> > > +    bool msi_bypass;
> > >  } VirtIOIOMMU;
> > >
> > >  #endif
> > > --
> > > 2.20.1

