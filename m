Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8292C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 07:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A812085B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 07:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="paBA1W8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A812085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVrpk-00022b-S3
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 03:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kVrpC-0001de-Gl
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 03:49:22 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kVrpA-0000JT-8h
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 03:49:22 -0400
Received: by mail-wr1-x443.google.com with SMTP id h5so687702wrv.7
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 00:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Sse5QCWJlSqEriI6XJN4D1K2P2RgTMgLRgONhhxjruM=;
 b=paBA1W8cmusUV53CcmoZCYA1GT3QEnmHNzhgubIydmF5WpiBtwyAuS16MmqC7PRF/l
 wj+gpieDWUoyGXFgtZIHNjLf6/Ye7JLdL5jC2GCFc8KCf5NKnXSsMOT5gxSqwq4gLoFc
 OBM1xI66k8RdcuBs+DJV17EXy+XZdYptQvazajWN1dnNIGnZdSlv8dfDLooLuZJ/vJ5U
 S/KiNVr4xZtoTBHIlrH8JKCooLZoNpBGyl52ZFz3UyR5b/FGnwH0z0mq1mf6GUGL8hex
 6jyURDO/Pn7oYXwfhaxKtcChyx0wqBj3uAiaYMIGWiER1bU11rbm96neYGV/+TyJRYUH
 eWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Sse5QCWJlSqEriI6XJN4D1K2P2RgTMgLRgONhhxjruM=;
 b=quRdz1/x+It6w9dMjyh+mTvAXnc9EqsMPtB5DwbNmjXwIp2CQ0+R8BmVD522mecbrL
 o5hsgG+trargfF7jlyk/Q2kb4Y9VBxgjiTEZBxLtomLDV7I6mu2+MlE69QT2skraVCUL
 Qsp1PLkyegtWUO59TO4KpoI6kXYvHDnxRWvULM9MFO9U2uOzG/YGFIEM5VGtjWwSSsEg
 0/BAo1kIvHBbmhBxrDg2QLNgb73KPZ4AkPCKtfixIeiWTcewPDvxgBKZwwoUCF6jjb1x
 tA2EdXjT6ONBCXIrv6mRQyM+t+ons3qnwnzKsvWlsVZqD3ZczUCUyWc/9AHfhb+yMW1l
 TvfA==
X-Gm-Message-State: AOAM5338xF4m74ThClWPXkxOKzh1sbGHxp1NCLpQ8ZqhLPP5kAOjBksY
 kaO3ruKE3lIS0lf51dJSZghLdw==
X-Google-Smtp-Source: ABdhPJyEJKlBHPDXVUmF17CiMQRqunRAPCUTaCvoS9MqPDmYAHvxZyWYu3YhjaikTSbF9PjN3FqltQ==
X-Received: by 2002:adf:c501:: with SMTP id q1mr1100350wrf.147.1603439358393; 
 Fri, 23 Oct 2020 00:49:18 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id m12sm1521819wmi.33.2020.10.23.00.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 00:49:17 -0700 (PDT)
Date: Fri, 23 Oct 2020 09:48:58 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v10 09/10] virtio-iommu: Set supported page size mask
Message-ID: <20201023074858.GA2265982@myrica>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-10-jean-philippe@linaro.org>
 <20201019213539.GC3203@xz-x1> <20201022163937.GB1808268@myrica>
 <20201022205616.GD3208@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022205616.GD3208@xz-x1>
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 22, 2020 at 04:56:16PM -0400, Peter Xu wrote:
> On Thu, Oct 22, 2020 at 06:39:37PM +0200, Jean-Philippe Brucker wrote:
> > So what I'd like to do for next version:
> > 
> > * Set qemu_real_host_page_mask as the default page mask, instead of the
> >   rather arbitrary TARGET_PAGE_MASK.
> 
> Oh, I thought TARGET_PAGE_MASK was intended - kernel committ 39b3b3c9cac1
> ("iommu/virtio: Reject IOMMU page granule larger than PAGE_SIZE", 2020-03-27)
> explicitly introduced a check that virtio-iommu kernel driver will fail
> directly if this psize is bigger than PAGE_SIZE in the guest.  So it sounds
> reasonable to have the default value as PAGE_SIZE (if it's the same as
> TARGET_PAGE_SIZE in QEMU, which seems true?).
> 
> For example, I'm thinking whether qemu_real_host_page_mask could be bigger than
> PAGE_SIZE in the guest in some environments, then it seems virtio-iommu won't
> boot anymore without assigned devices, because that extra check above will
> always fail.

Right, I missed this problem again. Switching to qemu_real_host_page_mask
is probably not the best idea until we solve the host64k-guest4k problem.

> 
> >   Otherwise we cannot hotplug assigned
> >   devices on a 64kB host, since TARGET_PAGE_MASK is pretty much always
> >   4kB.
> > 
> > * Disallow changing the page size. It's simpler and works in
> >   practice if we default to qemu_real_host_page_mask.
> > 
> > * For non-hotplug devices, allow changing the rest of the mask. For
> >   hotplug devices, only warn about it.
> 
> Could I ask what's "the rest of the mask"?

The LSB in the mask defines the page size. The other bits define which
block sizes are supported, for example 2MB and 1GB blocks with a 4k page
size. These are only for optimization, the upper bits of the mask could
also be all 1s. If the guest aligns its mappings on those block sizes,
then the host can use intermediate levels in the page tables resulting in
fewer IOTLB entries.

> On the driver side, I see that
> viommu_domain_finalise() will pick the largest supported page size to use, if
> so then we seem to be quite restricted on what page size we can use.

In Linux iommu_dma_alloc_remap() tries to allocate blocks based on the
page mask (copied by viommu_domain_finalise() into domain->pgsize_bitmap)

> I'm also a bit curious about what scenario we plan to support in this initial
> version, especially for ARM.  For x86, I think it's probably always 4k
> everywhere so it's fairly simple.  Know little on ARM side...

Arm CPUs and SMMU support 4k, 16k and 64k page sizes. I don't think 16k is
used anywhere but some distributions chose 64k (RHEL, I think?), others
4k, so we need to support both.

Unfortunately as noted above host64k-guest4k is not possible without
adding a negotiation mechanism to virtio-iommu, host VFIO and IOMMU
driver.

Thanks,
Jean

