Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4260C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FDFA2073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WvMDtpxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDFA2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieiUy-0003v0-HY
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1ieiTH-00021c-Gr
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:34:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1ieiTG-0001RV-FZ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:34:47 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54280)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1ieiTG-0001NV-7g
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:34:46 -0500
Received: by mail-wm1-x341.google.com with SMTP id b11so3962598wmj.4
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 08:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=nr9qD4DaDvJHHdIuwYMg0Ovc1bfT2/hPbW+c8+9Fprs=;
 b=WvMDtpxa2/IRtVWRf8WkOpm5ElUVivgCV1sDbwTLx2o70NhfnVP78ng9rbfwZgnmIG
 wOPE8CZyTf0d/FHReVJkddPj3ZcYKd2PdwPCZdiI1+dbl1UtGWzeoMN4prS/kXrDMhFd
 JaOMMTFNu3W4tAuUJFiuI+bRgnGEQ/PnFnNjGwIHRVimVYT6bUQAgb8plNFuGkSE56AQ
 wzkWZeGkDb4L1SBBqjrVgOE/16dBzUPb+YdnJhoCMAV0e9cQzcmWvyzeJZazjPeGWr1Y
 TTjrmUMSnr+vhazzFdgAaZ2l3nA966C6LituUenMUacLMHbP1Z4HNHyKB3DpxHxQEUvu
 ms6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nr9qD4DaDvJHHdIuwYMg0Ovc1bfT2/hPbW+c8+9Fprs=;
 b=iDHXbafHDnA5eNV7fsdfHcT7Nc4mOZWcq+HJOc+SWSArfDN3PGtt8mr40P2p3Q5pI5
 x+/RCdYdHKifiUoOPZIzF/z8QK6x7kV2t/XJCcAJP0iogfS9IHc0ROxwQV+77slT1sV3
 6ftqhmycuzuaBgv9FUWk3rQORRdveF3jOGl5rCPldore3rzRn7maxnOhAvIHNAE8GfjF
 zcs+dLvNM0leTgoFdfuZFaPPKScCJUtnsMcTc/uMS+dyA3LnngYWZ0HoK3jR3cbK5xGn
 th/ne5OaYUqITXC9iezh8XY45E2VJg28uIH7AWqHmDHqKjuvkMJ9+a1s3CRo1hpFG5xn
 mK9w==
X-Gm-Message-State: APjAAAX11nUYoIB+zTapY2OwR+OFuVEavoyo4Zmv02yRrjSlzv+tifHI
 bQXQSVPMmoCGOv+1Y/+mwuwv8g==
X-Google-Smtp-Source: APXvYqxPconFr5AK4By59wJ2vTLjsF91W7jn0hl9Ry8Q5p6TIY4Ut5t41QS5QyV6raIk1Z+sUtBfDQ==
X-Received: by 2002:a1c:9602:: with SMTP id y2mr6185448wmd.23.1575995685380;
 Tue, 10 Dec 2019 08:34:45 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id g17sm3504156wmc.37.2019.12.10.08.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 08:34:44 -0800 (PST)
Date: Tue, 10 Dec 2019 17:34:40 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 04/20] virtio-iommu: Add the iommu regions
Message-ID: <20191210163440.GC277340@myrica>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-5-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122182943.4656-5-eric.auger@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Two small things below, but looks good overall

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

On Fri, Nov 22, 2019 at 07:29:27PM +0100, Eric Auger wrote:
> +static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
> +                                              int devfn)
> +{
> +    VirtIOIOMMU *s = opaque;
> +    IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
> +    static uint32_t mr_index;
> +    IOMMUDevice *sdev;
> +
> +    if (!sbus) {
> +        sbus = g_malloc0(sizeof(IOMMUPciBus) +
> +                         sizeof(IOMMUDevice *) * IOMMU_PCI_DEVFN_MAX);
> +        sbus->bus = bus;
> +        g_hash_table_insert(s->as_by_busptr, bus, sbus);
> +    }
> +
> +    sdev = sbus->pbdev[devfn];
> +    if (!sdev) {
> +        char *name = g_strdup_printf("%s-%d-%d",
> +                                     TYPE_VIRTIO_IOMMU_MEMORY_REGION,
> +                                     mr_index++, devfn);
> +        sdev = sbus->pbdev[devfn] = g_malloc0(sizeof(IOMMUDevice));
> +
> +        sdev->viommu = s;
> +        sdev->bus = bus;
> +        sdev->devfn = devfn;

It might be better to store the endpoint ID in IOMMUDevice, then you could
get rid of virtio_iommu_get_sid(), and remove a tiny bit of overhead in
virtio_iommu_translate(). But I doubt it's significant.

[...]
> +static const TypeInfo virtio_iommu_memory_region_info = {
> +    .parent = TYPE_IOMMU_MEMORY_REGION,
> +    .name = TYPE_VIRTIO_IOMMU_MEMORY_REGION,
> +    .class_init = virtio_iommu_memory_region_class_init,
> +};
> +
> +

nit: newline.

Thanks,
Jean 

