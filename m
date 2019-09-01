Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE105C3A5A4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 06:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB00921897
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 06:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB00921897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4JVz-0002nc-Vf
	for qemu-devel@archiver.kernel.org; Sun, 01 Sep 2019 02:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i4JV7-000287-Fe
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 02:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i4JV5-0000NF-Cr
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 02:38:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40132)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i4JV5-0000L9-5Q
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 02:38:11 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E253883F45
 for <qemu-devel@nongnu.org>; Sun,  1 Sep 2019 06:38:08 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id v16so12117087qtp.14
 for <qemu-devel@nongnu.org>; Sat, 31 Aug 2019 23:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rq0DpYBJB8j8ZbzZncVpaa9gLbGM3m9PJgoZO2coneQ=;
 b=sOyBL/FX9eJiYHHP2cQczEgBvewsVeMK0Kc0sSlULZEEJ17Y5bSodzCiHfgICQLGM9
 sGcYMwPMTyBnwlvTIPpOU0F5pqz21iGml0HqrpsRUtc6dUa98HsQHcmJ3iw7kRZ/Q6EH
 g5Tlnzt5KGf6o4vKPLOtXDfuFzR+ARXDH8BvixUlUf6edFfsEa5IjA9qnUIqhZ6GdjK5
 5YAiX96jg1P5rLIImMEdsG7ObZaprFnK5/+O0/ptZrEJEkJMPY+H61Ndsthgd4KuvQk1
 14TqNSr8Oot2WWKqMlmXc30rMs3CddVm7JKQd6KpY7atXlzJs1lA+32fNHDdU5rRrs/6
 bUUg==
X-Gm-Message-State: APjAAAXyJU3+4HFRHxlNA9LpZCWxtGOU7wcBv7DvxObVAQjwowsfIjLp
 3rt86JiJNqjUryBbDu04aa7TmW+89cTbOZ4Oxu/RHMgo05fzJcAXqSiUeILV6k4AwxEAB5cXqDV
 /Ot5Oo5MnnyCGfk0=
X-Received: by 2002:a0c:d959:: with SMTP id t25mr933923qvj.19.1567319888212;
 Sat, 31 Aug 2019 23:38:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyBo37N9snoK4u3Jgo8cj7mypl4129QI4e7kR5oW6aVWNuzJL9kopNRfJCk/JUgcOvYVYBhzg==
X-Received: by 2002:a0c:d959:: with SMTP id t25mr933907qvj.19.1567319888009;
 Sat, 31 Aug 2019 23:38:08 -0700 (PDT)
Received: from redhat.com (bzq-79-180-62-110.red.bezeqint.net. [79.180.62.110])
 by smtp.gmail.com with ESMTPSA id h1sm6329583qtc.92.2019.08.31.23.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Aug 2019 23:38:07 -0700 (PDT)
Date: Sun, 1 Sep 2019 02:38:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190901023751-mutt-send-email-mst@kernel.org>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-14-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730172137.23114-14-eric.auger@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 v10 13/15] virtio_iommu: Handle
 reserved regions in translation process
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

On Tue, Jul 30, 2019 at 07:21:35PM +0200, Eric Auger wrote:
> When translating an address we need to check if it belongs to
> a reserved virtual address range. If it does, there are 2 cases:
> 
> - it belongs to a RESERVED region: the guest should neither use
>   this address in a MAP not instruct the end-point to DMA on
>   them. We report an error
> 
> - It belongs to an MSI region: we bypass the translation.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

something wrong with the subject here.

> ---
> 
> v9 -> v10:
> - in case of MSI region, we immediatly return
> ---
>  hw/virtio/virtio-iommu.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 8e54a17227..20d92b7ab0 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -711,6 +711,7 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>      viommu_interval interval;
>      bool bypass_allowed;
>      bool read_fault, write_fault;
> +    struct virtio_iommu_probe_resv_mem *reg;
>  
>      interval.low = addr;
>      interval.high = addr + 1;
> @@ -743,6 +744,21 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>          goto unlock;
>      }
>  
> +    reg = g_tree_lookup(ep->reserved_regions, (gpointer)(&interval));
> +    if (reg) {
> +        switch (reg->subtype) {
> +        case VIRTIO_IOMMU_RESV_MEM_T_MSI:
> +            entry.perm = flag;
> +            return entry;
> +        case VIRTIO_IOMMU_RESV_MEM_T_RESERVED:
> +        default:
> +            virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_MAPPING,
> +                                      0, sid, addr);
> +            break;
> +        }
> +        goto unlock;
> +    }
> +
>      if (!ep->domain) {
>          if (!bypass_allowed) {
>              qemu_log_mask(LOG_GUEST_ERROR,
> -- 
> 2.20.1

