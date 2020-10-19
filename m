Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFBAC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 21:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A822231B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 21:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DnP8oPQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A822231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUcq2-0003Zy-3k
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 17:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUcoo-0002zd-5q
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 17:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUcol-0003XX-Rb
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 17:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603143345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5zhdLrS8H735MttNDuBZAdVn3celV5qNKB64w21OpzI=;
 b=DnP8oPQQCXSv2zAiKChRbpU5h10RDAxVFxwxcZl2yUgMVVGD1HalrXWYnaMqkSWn461rI3
 vCotK0KNaXG6gYLxa2CEQSf3oYZ3vzg8TWc9q/74BQiZc9e7vhtcMfO1sOguVTWXhgbb4H
 G+18MOSe5qyEJSp/Wqn8IEuUFZMJbyA=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-zTSVNCcIMuO2xzHSwMKSWA-1; Mon, 19 Oct 2020 17:35:43 -0400
X-MC-Unique: zTSVNCcIMuO2xzHSwMKSWA-1
Received: by mail-il1-f200.google.com with SMTP id g1so1235459iln.15
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 14:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5zhdLrS8H735MttNDuBZAdVn3celV5qNKB64w21OpzI=;
 b=tjJ0cezHJlZI4C5tjzpHFSSpLBQuMS5OVar0IVWCy4tzuJ/yR4QU1BZ6Rl6CGFOYMQ
 GAoEoec9bFUqz9m1hVQW9UF2ETpAZGRoyaW/w5BbYOU6j/5/l4y/u1oiUI4916LLrwsC
 jn08GWouUxy2cCBmVd/J9x34QKiBOJXAH6qAMtT5ulUBbCGlztpCJE1C3J87tcJLowP7
 NwczM82AsxXxwnq4M5I79AjVlOOQ51tvNp58oYnY9MLk+789tEUmhNKJuIutpUJxtDaS
 yK7FB9Ts3orpFSsGElQSqqU/5oVtr68tClEcKkGYGuCQGV0qi+KluGWs9oWfb7VJ4SCU
 6UcA==
X-Gm-Message-State: AOAM531Hebb3oZjm1wvU7TmFesTuvkfFBRi1BkQdm8v8ki861oHJAovr
 hlG6Q2fTnrzsMaso3eM6ewKBiRuPXA/ER779rjcB9RrDhDB8861pccm5lM3tjBP7RtbyE2lrOnB
 HpDCeQERu8Bn4bQc=
X-Received: by 2002:a92:c650:: with SMTP id 16mr1659151ill.94.1603143342856;
 Mon, 19 Oct 2020 14:35:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBHmit+01qpEJKDaOMJK+6rcsaCckkxIZ7FmcRZl84PHYK6tjH8yOItJwEYGHlcwV8jie4MQ==
X-Received: by 2002:a92:c650:: with SMTP id 16mr1659134ill.94.1603143342489;
 Mon, 19 Oct 2020 14:35:42 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca.
 [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id x13sm991807iob.8.2020.10.19.14.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 14:35:41 -0700 (PDT)
Date: Mon, 19 Oct 2020 17:35:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 09/10] virtio-iommu: Set supported page size mask
Message-ID: <20201019213539.GC3203@xz-x1>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-10-jean-philippe@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20201008171558.410886-10-jean-philippe@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 15:28:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 08, 2020 at 07:15:57PM +0200, Jean-Philippe Brucker wrote:
> From: Bharat Bhushan <bbhushan2@marvell.com>
> 
> The virtio-iommu device can deal with arbitrary page sizes for virtual
> endpoints, but for endpoints assigned with VFIO it must follow the page
> granule used by the host IOMMU driver.
> 
> Implement the interface to set the vIOMMU page size mask, called by VFIO
> for each endpoint. We assume that all host IOMMU drivers use the same
> page granule (the host page granule). Override the page_size_mask field
> in the virtio config space.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v10: Use global page mask, allowing VFIO to override it until boot.
> ---
>  hw/virtio/virtio-iommu.c | 51 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 8823bfc804a..dd0b3093d1b 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -914,6 +914,56 @@ static int virtio_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu_mr,
>      return 0;
>  }
>  
> +static int virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
> +                                           uint64_t page_size_mask,
> +                                           Error **errp)
> +{
> +    int new_granule, old_granule;
> +    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
> +    VirtIOIOMMU *s = sdev->viommu;
> +
> +    if (!page_size_mask) {
> +        return -1;
> +    }
> +
> +    new_granule = ctz64(page_size_mask);
> +    old_granule = ctz64(s->config.page_size_mask);
> +
> +    /*
> +     * Modifying the page size after machine initialization isn't supported.
> +     * Having a different mask is possible but the guest will use sub-optimal
> +     * block sizes, so warn about it.
> +     */
> +    if (qdev_hotplug) {
> +        if (new_granule != old_granule) {
> +            error_setg(errp,
> +                       "virtio-iommu page mask 0x%"PRIx64
> +                       " is incompatible with mask 0x%"PRIx64,
> +                       s->config.page_size_mask, page_size_mask);
> +            return -1;
> +        } else if (page_size_mask != s->config.page_size_mask) {
> +            warn_report("virtio-iommu page mask 0x%"PRIx64
> +                        " does not match 0x%"PRIx64,
> +                        s->config.page_size_mask, page_size_mask);
> +        }
> +        return 0;
> +    }
> +
> +    /*
> +     * Disallow shrinking the page size. For example if an endpoint only
> +     * supports 64kB pages, we can't globally enable 4kB pages. But that
> +     * shouldn't happen, the host is unlikely to setup differing page granules.
> +     * The other bits are only hints describing optimal block sizes.
> +     */
> +    if (new_granule < old_granule) {
> +        error_setg(errp, "memory region shrinks the virtio-iommu page granule");
> +        return -1;
> +    }

My understanding is that shrink is actually allowed, instead we should forbid
growing of the mask?  For example, initially the old_granule will always points
to the guest page size.  Then as long as the host page size (which new_granule
represents) is smaller than the old_granule, then it seems fine... Or am I wrong?

Another thing, IIUC this function will be majorly called in vfio code when the
container page mask will be passed into it.  If there're multiple vfio
containers that support different host IOMMU page sizes, then IIUC the order of
the call to virtio_iommu_set_page_size_mask() is undefined.  It's probably
related to which "-device vfio-pci,..." parameter is earlier.

To make this simpler, I'm thinking whether we should just forbid the case where
devices have different iommu page sizes.  So when assigned devices are used, we
make sure all host iommu page sizes are the same, and the value should be
smaller than guest page size.  Otherwise we'll simply fall back to guest psize.

Thanks,

> +
> +    s->config.page_size_mask = page_size_mask;
> +    return 0;
> +}
> +
>  static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> @@ -1146,6 +1196,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
>      imrc->translate = virtio_iommu_translate;
>      imrc->replay = virtio_iommu_replay;
>      imrc->notify_flag_changed = virtio_iommu_notify_flag_changed;
> +    imrc->iommu_set_page_size_mask = virtio_iommu_set_page_size_mask;
>  }
>  
>  static const TypeInfo virtio_iommu_info = {
> -- 
> 2.28.0
> 

-- 
Peter Xu


