Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49898C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 19:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A69820659
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 19:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A69820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsXxS-0004Jp-Bs
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 15:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58497)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hsXwu-0003mn-Iy
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hsXwt-0000Sg-FE
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:38:16 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35015)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hsXwt-0000SQ-Ac
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:38:15 -0400
Received: by mail-vs1-f67.google.com with SMTP id u124so44439593vsu.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 12:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BP/+nchjcS9kgbL7AsGw6LF48Cq7HEI9ZF+ZuhTotUI=;
 b=RIvbiEWE+Mgp5z2Gb2Dg8xmrTh3WESYk15zK/Vll0cqNAbpD+lrwiEhZJi9TIxrUU+
 3PAoAWIY2LRguGd5k7rEpWLqdElkee885CZp5ErIy89j68HcNnl63wKBaD8jrAribOGW
 h4lTlSPOzB095EI4lj3Anx+e5I7ITSdcEO+mKbapGLocUclCjRUR0qzJ4m8shpK2Pnn4
 +x2fqs2SzY0M6J4hHI3ItBKAggFjt0wd5tzOevZL2fU9GQq2FQVkq0ev1oj5Y6Mg3A4X
 ujUyrD1ABQAlZUUHjHBv/LKO3Uf+LEX/4C3FujSYEx4jUdW9JUr6AGUfKJZrIoyLo+z7
 NnWw==
X-Gm-Message-State: APjAAAXxgDaUNmJAn8qCpwivTG62/hrFvJ4FwV4R6xyu9uyuHgah2Uvu
 WKsRHhtxJdCfczzdX1kV7nanQw==
X-Google-Smtp-Source: APXvYqzXyKBWcFBRsAcrCcCJskwP89esdhwLreYt2bzkoW2AJz9NFpge0QonVCQFAjDQA9TGJLD+bg==
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr72542410vsm.178.1564515494816; 
 Tue, 30 Jul 2019 12:38:14 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 d67sm19327804vkd.25.2019.07.30.12.38.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 12:38:14 -0700 (PDT)
Date: Tue, 30 Jul 2019 15:38:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190730153628-mutt-send-email-mst@kernel.org>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-12-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730172137.23114-12-eric.auger@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.217.67
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, peter.maydell@linaro.org,
 tn@semihalf.com, qemu-devel@nongnu.org, peterx@redhat.com,
 alex.williamson@redhat.com, qemu-arm@nongnu.org, bharat.bhushan@nxp.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 30, 2019 at 07:21:33PM +0200, Eric Auger wrote:
> We introduce a new msi_bypass field which indicates whether
> the IOAPIC MSI window [0xFEE00000 - 0xFEEFFFFF] must be exposed
> as a reserved region. By default the field is set to true at
> instantiation time. Later on we will introduce a property at
> virtio pci proxy level to turn it off.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v8 -> v9:
> - pass IOAPIC_RANGE_END to virtio_iommu_register_resv_region
> - take into account the change in the struct virtio_iommu_probe_resv_mem
>   definition
> - We just introduce the field here. A property will be introduced later on
>   at pci proxy level.
> ---
>  hw/virtio/virtio-iommu.c         | 36 ++++++++++++++++++++++++++++++++
>  include/hw/virtio/virtio-iommu.h |  1 +
>  2 files changed, 37 insertions(+)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 66be9a4627..74038288b0 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -39,6 +39,9 @@
>  #define VIOMMU_DEFAULT_QUEUE_SIZE 256
>  #define VIOMMU_PROBE_SIZE 512
>  
> +#define IOAPIC_RANGE_START      (0xfee00000)
> +#define IOAPIC_RANGE_END        (0xfeefffff)
> +
>  #define SUPPORTED_PROBE_PROPERTIES (\
>      1 << VIRTIO_IOMMU_PROBE_T_RESV_MEM)
>  

Sorry where are these numbers coming from?
Does this really work on all platforms?
With all guests?

> @@ -100,6 +103,30 @@ static void virtio_iommu_detach_endpoint_from_domain(viommu_endpoint *ep)
>      ep->domain = NULL;
>  }
>  
> +static void virtio_iommu_register_resv_region(viommu_endpoint *ep,
> +                                              uint8_t subtype,
> +                                              uint64_t start, uint64_t end)
> +{
> +    viommu_interval *interval;
> +    struct virtio_iommu_probe_resv_mem *resv_reg_prop;
> +    size_t prop_size = sizeof(struct virtio_iommu_probe_resv_mem);
> +    size_t value_size = prop_size -
> +                sizeof(struct virtio_iommu_probe_property);
> +
> +    interval = g_malloc0(sizeof(*interval));
> +    interval->low = start;
> +    interval->high = end;
> +
> +    resv_reg_prop = g_malloc0(prop_size);
> +    resv_reg_prop->head.type = VIRTIO_IOMMU_PROBE_T_RESV_MEM;
> +    resv_reg_prop->head.length = cpu_to_le64(value_size);
> +    resv_reg_prop->subtype = cpu_to_le64(subtype);
> +    resv_reg_prop->start = cpu_to_le64(start);
> +    resv_reg_prop->end = cpu_to_le64(end);
> +
> +    g_tree_insert(ep->reserved_regions, interval, resv_reg_prop);
> +}
> +
>  static viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
>                                                    uint32_t ep_id)
>  {
> @@ -117,6 +144,12 @@ static viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
>      ep->reserved_regions = g_tree_new_full((GCompareDataFunc)interval_cmp,
>                                              NULL, (GDestroyNotify)g_free,
>                                              (GDestroyNotify)g_free);
> +    if (s->msi_bypass) {
> +        virtio_iommu_register_resv_region(ep, VIRTIO_IOMMU_RESV_MEM_T_MSI,
> +                                          IOAPIC_RANGE_START,
> +                                          IOAPIC_RANGE_END);
> +    }
> +
>      return ep;
>  }
>  
> @@ -822,6 +855,9 @@ static void virtio_iommu_set_status(VirtIODevice *vdev, uint8_t status)
>  
>  static void virtio_iommu_instance_init(Object *obj)
>  {
> +    VirtIOIOMMU *s = VIRTIO_IOMMU(obj);
> +
> +    s->msi_bypass = true;
>  }
>  
>  static const VMStateDescription vmstate_virtio_iommu = {
> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
> index f55f48d304..56c8b4e57f 100644
> --- a/include/hw/virtio/virtio-iommu.h
> +++ b/include/hw/virtio/virtio-iommu.h
> @@ -59,6 +59,7 @@ typedef struct VirtIOIOMMU {
>      GTree *domains;
>      QemuMutex mutex;
>      GTree *endpoints;
> +    bool msi_bypass;
>  } VirtIOIOMMU;
>  
>  #endif
> -- 
> 2.20.1

