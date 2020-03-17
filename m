Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AF5C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 07:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA5F20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 07:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoKeJ786"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA5F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE6O1-000217-KL
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 03:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bharatb.linux@gmail.com>) id 1jE6NJ-0001Bj-It
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 03:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bharatb.linux@gmail.com>) id 1jE6NI-0006n9-9W
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 03:10:53 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:43580)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bharatb.linux@gmail.com>)
 id 1jE6NI-0006k9-55; Tue, 17 Mar 2020 03:10:52 -0400
Received: by mail-qt1-x841.google.com with SMTP id l13so16545393qtv.10;
 Tue, 17 Mar 2020 00:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/mcB+5zeRW8vpPjLibt/ORo0JBWyAeoH2anb6aQF1pA=;
 b=BoKeJ786Qd79JsV5Nzqd6vT3j7PP+tzKX9V4Lnn97NGHrf6F14RGeL7eVDJEJQb78J
 agwtOy24rDMSrR0prMM2WOWTJlMM5H7tTBSpRRr/bdgeysn0hB6MqcZbw7/zZlRFZQ5T
 b2uMP0fAuSMrVWULmVwDhMF6i5hN/jVkU5/afJR+goVQopRZ1pHbZwUmMOZaGGYl+5pA
 7ZxsJQ7MuIUmiyJpjRQ/e0XGeTHxsGW5aoerOJ4mkgQNDYfok1Ln2Sob41WnQufSJDnx
 MUJd7urv/m5ZwwMSFoYMv/3rEsm/S0GD9QjUVJBV71fxF3UbxXlT77HsrCMn+NIqqPDX
 hJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/mcB+5zeRW8vpPjLibt/ORo0JBWyAeoH2anb6aQF1pA=;
 b=phbwInfWCOHNFQ9imT9fX4MabRmb84xPySmLRJZ1GRw2w3rZ8bPP0XeX//o/yh6/HO
 Dufl59dnLWWoByeSzWBSX/EMrWK0G5rA9zb7R2QhPBD2sSCRNfJjI9Cjoa7oBBN6VZLV
 7Ng3KF1vsGkWJHQKSZEKOeQZr7WrQbLcZcHN7fTOen0TB6mcbGC++wzh+2GQXfW6xW9Z
 X/WJhT8StdxHhFRB8jHh5z9ge16Vk/NCtoxLWB0TIP9Odf9uDSMRccZVq3CnTKSFG/oN
 8gtFHCAsE69/pWrTmbmOVIovaaKfrxl9KODnD0WVUVCb3KOOVRGz140GuC4swDnTvwja
 aziQ==
X-Gm-Message-State: ANhLgQ0gj1p4Rfo6ZVzuF2op8gRa3DVSkQGMTjCWio8iEFj4HjTFvWDV
 JZlretnZX7pVBh7SK3CALxYPe5N1slWzE0t3s5s=
X-Google-Smtp-Source: ADFU+vuHfPx9Atur8Wv1AGpW91SiZiadJNyFWmI2+IWxXI00rexQLNZOQtDDTm8jF5GjE1iADLvd6+7P+5vgY1ZFOxk=
X-Received: by 2002:ac8:4a08:: with SMTP id x8mr3788320qtq.32.1584429051198;
 Tue, 17 Mar 2020 00:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200313074811.27175-1-bbhushan2@marvell.com>
 <20200313074811.27175-4-bbhushan2@marvell.com>
 <da0a4d7b-c27d-839d-56b6-da67c94adeb7@redhat.com>
 <CAAeCc_m=PKV0T8DmaE06F9NMYfU792f9TDdoyKkaPaEN3597ag@mail.gmail.com>
 <9b4ab5e8-8848-50ba-17c8-652567483126@redhat.com>
 <CAAeCc_ksAdoNJcFWkoB4YcySAb5Hw7D+kLyHx-Nt0hZJY17AXA@mail.gmail.com>
 <CAAeCc_nnM-DGCyXjFJuk-6L8F+Oetq076SEjeV8kUAGxfJVQTw@mail.gmail.com>
 <cc447790-d1c5-784b-9706-fbcd76f0c94b@redhat.com>
 <CAAeCc_mSobL4oGcK-J3WJJq8BCS6M_oyPTrzJ9bk8yFgsUDBUw@mail.gmail.com>
 <20200316101124.GA304669@myrica>
In-Reply-To: <20200316101124.GA304669@myrica>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Tue, 17 Mar 2020 12:40:39 +0530
Message-ID: <CAAeCc_kJq_TjbZxf3Un5rpwBrNrz-8gdL_SMS-gP_0=rARf0WQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] virtio-iommu: Call iommu notifier for attach/detach
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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

Hi Jean,

On Mon, Mar 16, 2020 at 3:41 PM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Hi Bharat,
>
> Could you Cc me on your next posting?  Unfortunately I don't have much
> hardware for testing this at the moment, but I might be able to help a
> little on the review.
>
> On Mon, Mar 16, 2020 at 02:40:00PM +0530, Bharat Bhushan wrote:
> > > >>> First issue is: your guest can use 4K page and your host can use 64KB
> > > >>> pages. In that case VFIO_DMA_MAP will fail with -EINVAL. We must devise
> > > >>> a way to pass the host settings to the VIRTIO-IOMMU device.
> > > >>>
> > > >>> Even with 64KB pages, it did not work for me. I have obviously not the
> > > >>> storm of VFIO_DMA_MAP failures but I have some, most probably due to
> > > >>> some wrong notifications somewhere. I will try to investigate on my side.
> > > >>>
> > > >>> Did you test with VFIO on your side?
> > > >>
> > > >> I did not tried with different page sizes, only tested with 4K page size.
> > > >>
> > > >> Yes it works, I tested with two n/w device assigned to VM, both interfaces works
> > > >>
> > > >> First I will try with 64k page size.
> > > >
> > > > 64K page size does not work for me as well,
> > > >
> > > > I think we are not passing correct page_size_mask here
> > > > (config.page_size_mask is set to TARGET_PAGE_MASK ( which is
> > > > 0xfffffffffffff000))
> > > I guess you mean with guest using 4K and host using 64K.
> > > >
> > > > We need to set this correctly as per host page size, correct?
> > > Yes that's correct. We need to put in place a control path to retrieve
> > > the page settings on host through VFIO to inform the virtio-iommu device.
> > >
> > > Besides this issue, did you try with 64kB on host and guest?
> >
> > I tried Followings
> >   - 4k host and 4k guest  - it works with v7 version
> >   - 64k host and 64k guest - it does not work with v7
> >     hard-coded config.page_size_mask to 0xffffffffffff0000 and it works
>
> You might get this from the iova_pgsize bitmap returned by
> VFIO_IOMMU_GET_INFO. The virtio config.page_size_mask is global so there
> is the usual problem of aggregating consistent properties, but I'm
> guessing using the host page size as a granule here is safe enough.
>
> If it is a problem, we can add a PROBE property for page size mask,
> allowing to define per-endpoint page masks. I have kernel patches
> somewhere to do just that.

I do not see we need page size mask per endpoint.

While I am trying to understand what "page-size-mask" guest will work with

- 4K page size host and 4k page size guest
  config.page_size_mask = 0xffffffffffff000 will work

- 64K page size host and 64k page size guest
  config.page_size_mask = 0xfffffffffff0000 will work

- 64K page size host and 4k page size guest
   1) config.page_size_mask = 0xffffffffffff000 will also not work as
VFIO in host expect iova and size to be aligned to 64k (PAGE_SIZE in
host)
   2) config.page_size_mask = 0xfffffffffff0000 will not work, iova
initialization (in guest) expect minimum page-size supported by h/w to
be equal to 4k (PAGE_SIZE in guest)
       Should we look to relax this in iova allocation code?

Thanks
-Bharat


>
> Thanks,
> Jean

