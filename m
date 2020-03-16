Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7523C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC20205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VkNFxLgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC20205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDoAo-0006L6-K2
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 07:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1jDmid-0006pO-P5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1jDmic-0004bM-8c
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:11:35 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35307)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1jDmib-0004H8-Ss
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:11:34 -0400
Received: by mail-wm1-x343.google.com with SMTP id m3so17304636wmi.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 03:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BU/ZwEwcB5nZlqTst3L0l7esGc+qpviZb36MSldnOCM=;
 b=VkNFxLgoMWyM+DkzSSXTHrky2hFNhpBOcJ7CZGW93w8fyFtsuD9bgfixDd6zCWQ07m
 U17asqNYxTpDHTJw8TrdmyBUDKPNvf1f9nMVLE0Rdy7VczlD/KtKA45gbZxaRMha8Pf3
 Pjjy1qXccZc5SkxV8fuaqLfVDecmmSGb4GWd4I0FYU2KrWGescEAennoWnA3k56WpR2T
 cKt5MYr4CS2ZrvE10L5t4tCXR5yVvaUrxVrKx8d1MMFuSdBQBdRSnIzXX7chEvh/gSrq
 pvkOwPouOfBpA3a8RwnP547GNjahUUkD472BXBkZa91OjfcoEAt2NvgHGBcrQ41TrpV4
 rUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BU/ZwEwcB5nZlqTst3L0l7esGc+qpviZb36MSldnOCM=;
 b=YbcuSmmtIj6HdHseCsrZpGE1CTsOrCfxYZ+c2H+vFj80Vs4D26qaYr1aBQSxfxjeH0
 5BjsIzcvVETGAVgWDXKeemaj/I8aRxrJJ2MnqKjBZmrThXaB/s0GNLzTMwSNnRmnIYSf
 QJBqyKCfy745axAGeYXTr6CypwdUiBA7EoW7c5UZOmQQ/w+XrjXgj3oSbwf+6EHXoZmV
 PgmLsybBDpW+Lv9MQEOzw4GClJvjzNmsTjt7PdZ6AeOUR9oCDdexmz4zpTaTOhjH+4p0
 4HbgaOJejKj2t/WTBpF0OKUnyYC6Y6gNzyG2EZCEdGsNUGwUJ70Hs4gO2YsXQdrgCW/G
 2dCw==
X-Gm-Message-State: ANhLgQ2PX7vpIYOUz1Fdx0ubCetbk34TfBgogA+F7XJBhcT9yQtWOT0y
 2S9A8OykiLPMvJBuFtV2jkHsFA==
X-Google-Smtp-Source: ADFU+vt8VudP8vxKT0FheGjpdz2ByYSTcejYK2XBnb8Hs3g755v7ZYiJoY47oogC7MPcqOFlEmhLgw==
X-Received: by 2002:a1c:2048:: with SMTP id g69mr27767216wmg.187.1584353492386; 
 Mon, 16 Mar 2020 03:11:32 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x24sm29248934wmc.36.2020.03.16.03.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:11:31 -0700 (PDT)
Date: Mon, 16 Mar 2020 11:11:24 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Bharat Bhushan <bharatb.linux@gmail.com>
Subject: Re: [PATCH v7 3/5] virtio-iommu: Call iommu notifier for attach/detach
Message-ID: <20200316101124.GA304669@myrica>
References: <20200313074811.27175-1-bbhushan2@marvell.com>
 <20200313074811.27175-4-bbhushan2@marvell.com>
 <da0a4d7b-c27d-839d-56b6-da67c94adeb7@redhat.com>
 <CAAeCc_m=PKV0T8DmaE06F9NMYfU792f9TDdoyKkaPaEN3597ag@mail.gmail.com>
 <9b4ab5e8-8848-50ba-17c8-652567483126@redhat.com>
 <CAAeCc_ksAdoNJcFWkoB4YcySAb5Hw7D+kLyHx-Nt0hZJY17AXA@mail.gmail.com>
 <CAAeCc_nnM-DGCyXjFJuk-6L8F+Oetq076SEjeV8kUAGxfJVQTw@mail.gmail.com>
 <cc447790-d1c5-784b-9706-fbcd76f0c94b@redhat.com>
 <CAAeCc_mSobL4oGcK-J3WJJq8BCS6M_oyPTrzJ9bk8yFgsUDBUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeCc_mSobL4oGcK-J3WJJq8BCS6M_oyPTrzJ9bk8yFgsUDBUw@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 mst@redhat.com, drjones@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org,
 Auger Eric <eric.auger@redhat.com>, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, Bharat Bhushan <bbhushan2@marvell.com>,
 linuc.decode@gmail.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bharat,

Could you Cc me on your next posting?  Unfortunately I don't have much
hardware for testing this at the moment, but I might be able to help a
little on the review.

On Mon, Mar 16, 2020 at 02:40:00PM +0530, Bharat Bhushan wrote:
> > >>> First issue is: your guest can use 4K page and your host can use 64KB
> > >>> pages. In that case VFIO_DMA_MAP will fail with -EINVAL. We must devise
> > >>> a way to pass the host settings to the VIRTIO-IOMMU device.
> > >>>
> > >>> Even with 64KB pages, it did not work for me. I have obviously not the
> > >>> storm of VFIO_DMA_MAP failures but I have some, most probably due to
> > >>> some wrong notifications somewhere. I will try to investigate on my side.
> > >>>
> > >>> Did you test with VFIO on your side?
> > >>
> > >> I did not tried with different page sizes, only tested with 4K page size.
> > >>
> > >> Yes it works, I tested with two n/w device assigned to VM, both interfaces works
> > >>
> > >> First I will try with 64k page size.
> > >
> > > 64K page size does not work for me as well,
> > >
> > > I think we are not passing correct page_size_mask here
> > > (config.page_size_mask is set to TARGET_PAGE_MASK ( which is
> > > 0xfffffffffffff000))
> > I guess you mean with guest using 4K and host using 64K.
> > >
> > > We need to set this correctly as per host page size, correct?
> > Yes that's correct. We need to put in place a control path to retrieve
> > the page settings on host through VFIO to inform the virtio-iommu device.
> >
> > Besides this issue, did you try with 64kB on host and guest?
> 
> I tried Followings
>   - 4k host and 4k guest  - it works with v7 version
>   - 64k host and 64k guest - it does not work with v7
>     hard-coded config.page_size_mask to 0xffffffffffff0000 and it works

You might get this from the iova_pgsize bitmap returned by
VFIO_IOMMU_GET_INFO. The virtio config.page_size_mask is global so there
is the usual problem of aggregating consistent properties, but I'm
guessing using the host page size as a granule here is safe enough. 

If it is a problem, we can add a PROBE property for page size mask,
allowing to define per-endpoint page masks. I have kernel patches
somewhere to do just that.

Thanks,
Jean

