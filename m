Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAEEC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14BC8206DB
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pcbrkjEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BC8206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioVvb-0005ht-32
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 12:12:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1ioVq3-00086l-SK
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1ioVq2-0000o5-C9
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:06:47 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38371)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1ioVpy-0000jo-Ff
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:06:46 -0500
Received: by mail-wr1-x444.google.com with SMTP id y17so50499114wrh.5
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 09:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QwtBdC5pI1sgKCXH6j8cPBwozyzvDybZ4woNY7xn/Cg=;
 b=pcbrkjEd8PM/cmseu4JciD9/I7TRvwC47RtdpnoBoECQA8mNGU45dtKmFlGdMQ/I88
 HF8eS3sTnxw8ljtJREjRcfSfxte4Wn6N8YH0mzjMmAlrXR/1kWLS0LJheMnA/DhnlVcj
 Go5pPutKhtIuu4xJ7hslC7Pb9xF5muHxuqxfxr/FlJp64jDDfjYs5UQhFal4+SlDCnwl
 3jBlGbIUTeUB9sm9QTvdur8Hw7PtHip3zYb2SJPCuxTqOcOfJ7IXDSWOpmFK73qNIN3Z
 LLIHSW1/TIkQG6LEtY34/LhPNJgqNtXBc6oos0bG+z4UPpFAg9JVokP2vdquCJaOoc9T
 raUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QwtBdC5pI1sgKCXH6j8cPBwozyzvDybZ4woNY7xn/Cg=;
 b=fkjvejVsRLxGB80l1Vk2cDfJ52llIjHe6l+Biyw/oLr4o06MUlFHAZy3sUAHrOJN6i
 YUSxuVdtN/mExNKTILKFuaKpJLuDdQyUCbiaryX44sYk+qRQTx+2U6u/1UrxI7JYVAdg
 8kJk6wE7e/wFFsuqEtjdGooHBatgKx/7xQriwQ9rrYHQmQYLQ7d3iZFDuKobXQazCCAC
 Vtpf0BkonJLkTa9S3oaSQrDQSfBl57CkBFTIaeLq6d6/YIdq/HTBwj8qHfMSU0wiqTOz
 Wrl0U+JQlU8uBU9/reiCNxBRJditt82q9dltubW4ODHixCkL36wICVkmQjYLpaZQApWP
 vQlA==
X-Gm-Message-State: APjAAAU6kvsnLM3lin+jhWZR5LZSzOuprnU4fXcU0c16l4Dh3RD+2F/F
 XJ6OYtEhqDWRPz3nl6NsRdrwyQ==
X-Google-Smtp-Source: APXvYqwIm5Atl15tx1r8r9EFH+KPKAp94qgWgdQrh1zTWM3Ue3tPtJI6g1URL1Ye+BQSX7y+Qor0KQ==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr108873928wrh.121.1578330400372; 
 Mon, 06 Jan 2020 09:06:40 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id 2sm75044495wrq.31.2020.01.06.09.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 09:06:39 -0800 (PST)
Date: Mon, 6 Jan 2020 18:06:34 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH for-5.0 v11 08/20] virtio-iommu: Implement translate
Message-ID: <20200106170634.GF2062@myrica>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-9-eric.auger@redhat.com>
 <20191210193342.GJ3352@xz-x1>
 <44c0041d-68ad-796f-16cc-4bab7ba0f164@redhat.com>
 <20191219133308.GA4246@xz-x1>
 <9d58b293-ada0-353e-bba2-ad1f538dfc62@redhat.com>
 <20191219144936.GB50561@xz-x1>
 <9ec9d0d5-062b-f96b-c72c-4d15865ff9a1@redhat.com>
 <20191220162642.GA2626852@myrica> <20191220165100.GA3780@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220165100.GA3780@xz-x1>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 Auger Eric <eric.auger@redhat.com>, bharatb.linux@gmail.com,
 qemu-arm@nongnu.org, dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 20, 2019 at 11:51:00AM -0500, Peter Xu wrote:
> On Fri, Dec 20, 2019 at 05:26:42PM +0100, Jean-Philippe Brucker wrote:
> > There is at the virtio transport level: the driver sets status to
> > FEATURES_OK once it accepted the feature bits, and to DRIVER_OK once its
> > fully operational. The virtio-iommu spec says:
> > 
> >   If the driver does not accept the VIRTIO_IOMMU_F_BYPASS feature, the
> >   device SHOULD NOT let endpoints access the guest-physical address space.
> > 
> > So before features negotiation, there is no access. Afterwards it depends
> > if the VIRTIO_IOMMU_F_BYPASS has been accepted by the driver.
> 
> Before enabling virtio-iommu device, should we still let the devices
> to access the whole system address space?  I believe that's at least
> what Intel IOMMUs are doing.  From code-wise, its:
> 
>     if (likely(s->dmar_enabled)) {
>         success = vtd_do_iommu_translate(vtd_as, vtd_as->bus, vtd_as->devfn,
>                                          addr, flag & IOMMU_WO, &iotlb);
>     } else {
>         /* DMAR disabled, passthrough, use 4k-page*/
>         iotlb.iova = addr & VTD_PAGE_MASK_4K;
>         iotlb.translated_addr = addr & VTD_PAGE_MASK_4K;
>         iotlb.addr_mask = ~VTD_PAGE_MASK_4K;
>         iotlb.perm = IOMMU_RW;
>         success = true;
>     }
> 
> From hardware-wise, an IOMMU should be close to transparent if you
> never enable it, imho.

For hardware that's not necessarily the best choice. As cited in my
previous reply it has been shown to introduce vulnerabilities since
malicious devices can DMA during boot, before the OS takes control of the
IOMMU. The Arm SMMU allows an implementation to adopt a deny policy by
default.

> Otherwise I'm confused on how a guest (with virtio-iommu) could boot
> with a normal BIOS that does not contain a virtio-iommu driver.  For
> example, what if the BIOS needs to read some block sectors (as you
> mentioned)?

Ideally we should aim at supporting the device in both the BIOS and the
OS. Failing that, there should at least be a way to instantiate a
virtio-iommu device that is blocking by default, that cannot be bypassed
unless the controlling software decides to allow it. Could the bypass
policy be a command-line option to the virtio-iommu device?

[...]
> > Yes bypass mode assumes that devices and drivers aren't malicious, and the
> > IOMMU is only used for things like assigning devices to guest userspace,
> > or having large contiguous DMA buffers.
> 
> Yes I agree.  However again when the BYPASS flag was introduced, have
> you thought of introducing that flag per-device?  IMHO that could be
> better because you have a finer granularity on controlling all these,
> so you'll be able to reject malicious devices but at the meantime
> grant permission to trusted devices.

At the moment that per-device behavior can be emulated by sending an
ATTACH request followed by identity MAP. It could be a little more
efficient to add a "bypass" flag to the ATTACH request and avoid setting
up the identity mapping manually, since the device then wouldn't need to
look up the mapping on translation, but I don't know how much it would
improve performance. The device could also cache the fact that the address
space is identity-mapped, for the same result. The domain lookup has to
happen in any case, so you can never get the full iommu-free performance
with these mechanisms.

Thanks,
Jean

