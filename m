Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A51BC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 04:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 115322077C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 04:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115322077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyThR-0004HX-6L
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 00:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1hyTga-0003jj-Bl
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 00:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hyTgZ-000817-4g
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 00:17:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37704)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hyTgY-00080H-Vp
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 00:17:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1so1696540pgp.4
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 21:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=D916J5lQmpyNIxpQMnm1h0/DyfcbEBR1HCuIX91921w=;
 b=dSV2rwHQNqOUqlMBSmrnWTCE0jM1pWUnHd8N06uslocfg45HWCgLP3Z1XEWLCq6Dby
 rRcRd4Y7VUPGZ0o0RdOa4ZtWoVvya10ShY1VKrMbyqDl4IfrGK8GdwqVyCZbe4T9kojM
 l1JS8ay/IdV3+Kn7eOyE9v7H2UbKr10GCxa1xriP83O+E6HGXT2K4Ipy2C9Qe/URvfKA
 mtOvJlnB1WjfnlOYJAswHXIDvx/NmHiG8rY/f3jAW0vB1PgrvpQIbHWrD78vc6pp8nsb
 Ld9rx2nFUb6FgwSuczZovF/J+ICBg+aMPFI1+LjnUXrbNWNbdL/9n9PYoI1qm/xNwZPi
 FG6g==
X-Gm-Message-State: APjAAAUzbZJZzSqEX0hXIit+PaHCuhzEMMFvnU1uoAvq8v0M5blPboaY
 aWmxyyL6xWMWRA9QPOE+LBP3rA==
X-Google-Smtp-Source: APXvYqz5DUWaWFHRQtxdCVdSONlwv1Ogr9AYz2b3Gd2FsAs5p8bWSMrPS+0yMkgXaDD1aCvg9DjQfg==
X-Received: by 2002:a17:90a:3465:: with SMTP id
 o92mr5227953pjb.20.1565929073839; 
 Thu, 15 Aug 2019 21:17:53 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f12sm3614701pgq.52.2019.08.15.21.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2019 21:17:52 -0700 (PDT)
Date: Fri, 16 Aug 2019 12:17:41 +0800
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190816041741.GB3114@xz-x1>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-7-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190730172137.23114-7-eric.auger@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.196
Subject: Re: [Qemu-devel] [PATCH for-4.2 v10 06/15] virtio-iommu: Endpoint
 and domains structs and helpers
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

On Tue, Jul 30, 2019 at 07:21:28PM +0200, Eric Auger wrote:
>  static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> @@ -334,6 +444,8 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_BYPASS);
>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MMIO);
>  
> +    qemu_mutex_init(&s->mutex);

It's a bit strange to init a mutex which has already been used in
patch 3. :)

Thanks,

> +
>      memset(s->as_by_bus_num, 0, sizeof(s->as_by_bus_num));
>      s->as_by_busptr = g_hash_table_new(NULL, NULL);
>  
> @@ -342,11 +454,20 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>      } else {
>          error_setg(errp, "VIRTIO-IOMMU is not attached to any PCI bus!");
>      }
> +
> +    s->domains = g_tree_new_full((GCompareDataFunc)int_cmp,
> +                                 NULL, NULL, virtio_iommu_put_domain);
> +    s->endpoints = g_tree_new_full((GCompareDataFunc)int_cmp,
> +                                   NULL, NULL, virtio_iommu_put_endpoint);
>  }

-- 
Peter Xu

