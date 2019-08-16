Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F82C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 04:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A09E32064A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 04:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09E32064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyTrA-0006Rz-Qv
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 00:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1hyTqP-0005uA-F4
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 00:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hyTqN-0000Fa-Et
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 00:28:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38222)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hyTqN-0000DG-92
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 00:28:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id e11so2299016pga.5
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 21:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3u3ukdBsD3ecgQxpmyv7waCPQyX01dzxGzwo89XfmBI=;
 b=Q7njPaGmPK9kaiF0npu+pU7xOqonAEKAfaOqDhMM6mcrgj88q5eKQcKxfNkzV+4jin
 MBFCy1GJkESrgZK4PrqaA59EmlGRMKXAUU41A4qe9A8jorXLCcDdnrIVWU7WkWsyphBx
 KudZQRyldQp7S8C75bGzs2Xj6dFeym9kUyb/X5v+imJMeG0kDUUQJrl1bk8f86NumLuW
 URL0mzCQ608IncABXUFrhwi5ADImZMGYdc7uMbiE0wxctjPJdTovJPaXT4IGfWQZxIRt
 HKLzi7JzMZ6c7zHf5MNXlCGd5Er53V4TdzBCXHQKneo0ADLshOB3X8TuOFSUFutgM2dv
 87ww==
X-Gm-Message-State: APjAAAUxcS22W4HyRtzsPon3/mVoIlgFIfXIXTMSpmWYl5lAwog/aj3G
 Ytsl7pAQl4kIx/Xajs6V/prdrA==
X-Google-Smtp-Source: APXvYqzLqstgZGdE3PBEFMpteBIGln9P0hlo9HoeaNR4xCUiQYFiO0uKbnNJcxGSuZnD9MxLOilR2w==
X-Received: by 2002:a63:3281:: with SMTP id y123mr6015867pgy.72.1565929681989; 
 Thu, 15 Aug 2019 21:28:01 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id a15sm4924448pfg.102.2019.08.15.21.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2019 21:28:01 -0700 (PDT)
Date: Fri, 16 Aug 2019 12:27:49 +0800
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190816042749.GC3114@xz-x1>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-8-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190730172137.23114-8-eric.auger@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.196
Subject: Re: [Qemu-devel] [PATCH for-4.2 v10 07/15] virtio-iommu: Implement
 attach/detach command
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 tn@semihalf.com, qemu-devel@nongnu.org, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, jean-philippe@linaro.org, bharat.bhushan@nxp.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 30, 2019 at 07:21:29PM +0200, Eric Auger wrote:
> This patch implements the endpoint attach/detach to/from
> a domain.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> ---
>  hw/virtio/virtio-iommu.c | 40 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 77dccecc0a..5ea0930cc2 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -80,8 +80,8 @@ static void virtio_iommu_detach_endpoint_from_domain(viommu_endpoint *ep)
>      ep->domain = NULL;
>  }
>  
> -viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s, uint32_t ep_id);
> -viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s, uint32_t ep_id)

These lines were just introduced in previous patch, I wanted to ask
why the definition was needed but I don't know whether it'll be used
in follow up patches.  Looks like it wasn't really used.

I would prefer patches like these to be squashed together not only to
avoid the maintainance of diffs like this between patches, but also as
a reviewer it'll be easier too when with all the contexts together.
But I won't ask for it because it can be a personal preference only...

> +static viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
> +                                                  uint32_t ep_id)
>  {
>      viommu_endpoint *ep;
>  
> @@ -110,8 +110,8 @@ static void virtio_iommu_put_endpoint(gpointer data)
>      g_free(ep);
>  }
>  
> -viommu_domain *virtio_iommu_get_domain(VirtIOIOMMU *s, uint32_t domain_id);
> -viommu_domain *virtio_iommu_get_domain(VirtIOIOMMU *s, uint32_t domain_id)
> +static viommu_domain *virtio_iommu_get_domain(VirtIOIOMMU *s,
> +                                              uint32_t domain_id)
>  {
>      viommu_domain *domain;
>  
> @@ -187,10 +187,27 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
>  {
>      uint32_t domain_id = le32_to_cpu(req->domain);
>      uint32_t ep_id = le32_to_cpu(req->endpoint);
> +    viommu_domain *domain;
> +    viommu_endpoint *ep;
>  
>      trace_virtio_iommu_attach(domain_id, ep_id);
>  
> -    return VIRTIO_IOMMU_S_UNSUPP;
> +    ep = virtio_iommu_get_endpoint(s, ep_id);
> +    if (ep->domain) {
> +        /*
> +         * the device is already attached to a domain,
> +         * detach it first
> +         */
> +        virtio_iommu_detach_endpoint_from_domain(ep);

Hmm... so this can be called without virtio_iommu_put_endpoint().
Then I think we'd better move:

        g_tree_unref(ep->domain->mappings);

From virtio_iommu_put_endpoint() to inside
virtio_iommu_detach_endpoint_from_domain() otherwise domain refs might
leak?

> +    }
> +
> +    domain = virtio_iommu_get_domain(s, domain_id);
> +    QLIST_INSERT_HEAD(&domain->endpoint_list, ep, next);
> +
> +    ep->domain = domain;
> +    g_tree_ref(domain->mappings);
> +
> +    return VIRTIO_IOMMU_S_OK;
>  }

Regards,

-- 
Peter Xu

