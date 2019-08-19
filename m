Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55703C3A59D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A1420851
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A1420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzgTI-0001PB-BU
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 08:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1hzgSd-0000e0-36
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hzgSb-0001h2-RN
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:08:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53034)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hzgSb-0001fY-Ix
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:08:29 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CD35F62E9A
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 12:08:28 +0000 (UTC)
Received: by mail-pl1-f197.google.com with SMTP id 71so1909184pld.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 05:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WAswI7IvJsamoUX+PIF1wVLMxOBTG1uRKswJMWAJkx8=;
 b=e79ytMCpsT5UQ/yt+RY2TXPRzAREBySaM2CObFhH6LzxGnx5Ap7Ni+nwumrwZnigcn
 7zkySxVNJrz3heBk6TIyP4wH55+cqZMYxY0wALlJWWZtLd6o8X8cHjygEUhSPkcBg9KA
 By/KCjkVS+0sYYdcJztetABPj8eLR4PF4p7Poun2GxaBwr28MINUmBoYOaIcGP/BGWTP
 upH+HIXCBgbE1h42XxA4Db+Kwx8H1+piG85LyoZ/Riau8GrEMyugRjD7jfmrQXCbkLcY
 qWfPAufQE9B66vA45ubb4/DeU5nS89hue2JZmw/X2PXECByAAI7rURqpZglJXyZatQJl
 mcYA==
X-Gm-Message-State: APjAAAX9d1KemOJTUGWYQ17IajYa9fr96iMShPm5QjBK3+LqW/Z1zF1H
 Kew5R6C8ZOZ8pTcgpRtYjKpv4MMDrTaJasD8ulXlfEop9rYcyOpHr/ftiGmZbDcjf2VslGyIYx0
 fHWKkIr85sbQjSVs=
X-Received: by 2002:a65:6552:: with SMTP id a18mr20080136pgw.208.1566216508081; 
 Mon, 19 Aug 2019 05:08:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqySqU4LCBmVWZdi98WDXP/XvgxMA/B3LaPyLB5hNi/O8FM/gCTCK3M9oHWTSO7qSdZ8tEzdFQ==
X-Received: by 2002:a65:6552:: with SMTP id a18mr20080071pgw.208.1566216507259; 
 Mon, 19 Aug 2019 05:08:27 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u74sm18616232pjb.26.2019.08.19.05.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 05:08:26 -0700 (PDT)
Date: Mon, 19 Aug 2019 20:08:15 +0800
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190819120815.GD13560@xz-x1>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-11-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190730172137.23114-11-eric.auger@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 v10 10/15] virtio-iommu: Implement
 probe request
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

On Tue, Jul 30, 2019 at 07:21:32PM +0200, Eric Auger wrote:

[...]

> +/* Fill the properties[] buffer with properties of type @type */
> +static int virtio_iommu_fill_property(int type,
> +                                      viommu_property_buffer *bufstate)
> +{
> +    int ret = -ENOSPC;
> +
> +    if (bufstate->filled + sizeof(struct virtio_iommu_probe_property)
> +            >= VIOMMU_PROBE_SIZE) {
> +        /* no space left for the header */
> +        bufstate->error = true;
> +        goto out;
> +    }
> +
> +    switch (type) {
> +    case VIRTIO_IOMMU_PROBE_T_NONE:
> +        ret = virtio_iommu_fill_none_prop(bufstate);
> +        break;
> +    case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
> +    {
> +        viommu_endpoint *ep = bufstate->endpoint;
> +
> +        g_tree_foreach(ep->reserved_regions,
> +                       virtio_iommu_fill_resv_mem_prop,
> +                       bufstate);
> +        if (!bufstate->error) {
> +            ret = 0;
> +        }
> +        break;
> +    }
> +    default:
> +        ret = -ENOENT;
> +        break;
> +    }
> +out:
> +    if (ret) {
> +        error_report("%s property of type=%d could not be filled (%d),"
> +                     " remaining size = 0x%lx",
> +                     __func__, type, ret, bufstate->filled);

Nit: If this can really be triggered then we might still change it to
error_report_once()?  If it's not (which it seems to), maybe assert
directly?

Other than that it looks good to me:

Reviewed-by: Peter Xu <peterx@redhat.com>

Regards,

-- 
Peter Xu

