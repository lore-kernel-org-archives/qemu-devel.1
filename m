Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C130C5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ACB02076D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpBeN90n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACB02076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEVn7-0003xZ-Ix
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 06:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bharatb.linux@gmail.com>) id 1jEVlu-0002Uy-6w
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bharatb.linux@gmail.com>) id 1jEVls-0007gc-Ij
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:17:58 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:35685)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bharatb.linux@gmail.com>)
 id 1jEVls-0007eV-Ea; Wed, 18 Mar 2020 06:17:56 -0400
Received: by mail-qt1-x844.google.com with SMTP id v15so20161871qto.2;
 Wed, 18 Mar 2020 03:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YfcHd60/dJetYFRb9sg2e77ZWneZZBfevAMmE0OYj0w=;
 b=IpBeN90nFk4M7I5c/hBhd857zudGJpZV1V0NUgqhQSjBXoq+cgqer2+//BE6RVzBZu
 3t1uJ1jy2QY1xm8Yc0ygcV6wJBLDs0hNIsg31wkV9xFyR27dzMw9oQJY4kHWj+XV30EY
 Ot7D2fwRapCqK56xkBZGbKYY7bAINM/9DPMWB2kw8z0D4HoTMtc5CD6S3UW2DpMHlHXE
 MEIPSljdcdHuyLNJZI4/t+2jR0gMWDnOPxBR8BxbC5anRbm6RzeQcKl7/90H3hU/JInp
 0yQM0XlL9SVpXyiGa68wv/lE5l53odIw1xrU+B1VntnEQ0mbMvLf4H8jyJSBLhQ95t2f
 1keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YfcHd60/dJetYFRb9sg2e77ZWneZZBfevAMmE0OYj0w=;
 b=VkBQIblMiIj4YYChlmhxl06LfNgupsOyccmEX4xhXnsQNXPAeVH+comD66NW0DHtAG
 VeS7+9Xa+fvmEtg/i2KIQuN7QIcuKZ0J5Btt8mBKZXj9QLpufIuZzt7aLzRPo49xUOLx
 OaG7RSlbJzfVz8E4qJrupkRTWYr9KGrWdDqTYhlzCf3PH6xoCiB3TNbXTWbwXpkNENCe
 L5ZDilWbTn1d+Eshh9aat5iin6bsvChuetoF4KrBvOqe4gcN2aO8rKkGGp6url5TsU8j
 DFlDUxb9I64KCjVFPxNG1toGKK/sqqUwmG8Dd+MBkWQ87wiDgSsPKc2XGQ4bXNWNh6pA
 U7Hw==
X-Gm-Message-State: ANhLgQ2wBLfNBk4tWosnvWDDHWcp6sPTx2lO0+YrIksboIpfn62WwbO1
 P59tsYYZ9/imOJ9h2Ul0cK0UFbzVx6iOBkINeBs=
X-Google-Smtp-Source: ADFU+vtf5Utd7lm9clRBpfi1NLaltmUREgqpVlLZ0+fRxzH7fPiby0QtgfWZgQxVr2FBGCUigdleQB2v7VorcI1R+1w=
X-Received: by 2002:ac8:4548:: with SMTP id z8mr3686989qtn.188.1584526675502; 
 Wed, 18 Mar 2020 03:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeCc_m=PKV0T8DmaE06F9NMYfU792f9TDdoyKkaPaEN3597ag@mail.gmail.com>
 <9b4ab5e8-8848-50ba-17c8-652567483126@redhat.com>
 <CAAeCc_ksAdoNJcFWkoB4YcySAb5Hw7D+kLyHx-Nt0hZJY17AXA@mail.gmail.com>
 <CAAeCc_nnM-DGCyXjFJuk-6L8F+Oetq076SEjeV8kUAGxfJVQTw@mail.gmail.com>
 <cc447790-d1c5-784b-9706-fbcd76f0c94b@redhat.com>
 <CAAeCc_mSobL4oGcK-J3WJJq8BCS6M_oyPTrzJ9bk8yFgsUDBUw@mail.gmail.com>
 <20200316101124.GA304669@myrica>
 <CAAeCc_kJq_TjbZxf3Un5rpwBrNrz-8gdL_SMS-gP_0=rARf0WQ@mail.gmail.com>
 <20200317085304.GA1057687@myrica>
 <CAAeCc_n8_sY0EJODeo_PrOZ22zp8nUMOmGx2tBewz8jLaU30kA@mail.gmail.com>
 <20200317155929.GB1057687@myrica>
In-Reply-To: <20200317155929.GB1057687@myrica>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Wed, 18 Mar 2020 15:47:44 +0530
Message-ID: <CAAeCc_k_7Ny1Kf2ZiAAJe2xms2bdK-DqB1S2ro+omxp0EWi28g@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] virtio-iommu: Call iommu notifier for attach/detach
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, drjones@redhat.com, peterx@redhat.com,
 qemu-devel@nongnu.org, Auger Eric <eric.auger@redhat.com>,
 alex.williamson@redhat.com, qemu-arm@nongnu.org,
 Bharat Bhushan <bbhushan2@marvell.com>, linuc.decode@gmail.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jean,

On Tue, Mar 17, 2020 at 9:29 PM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Tue, Mar 17, 2020 at 02:46:55PM +0530, Bharat Bhushan wrote:
> > Hi Jean,
> >
> > On Tue, Mar 17, 2020 at 2:23 PM Jean-Philippe Brucker
> > <jean-philippe@linaro.org> wrote:
> > >
> > > On Tue, Mar 17, 2020 at 12:40:39PM +0530, Bharat Bhushan wrote:
> > > > Hi Jean,
> > > >
> > > > On Mon, Mar 16, 2020 at 3:41 PM Jean-Philippe Brucker
> > > > <jean-philippe@linaro.org> wrote:
> > > > >
> > > > > Hi Bharat,
> > > > >
> > > > > Could you Cc me on your next posting?  Unfortunately I don't have much
> > > > > hardware for testing this at the moment, but I might be able to help a
> > > > > little on the review.
> > > > >
> > > > > On Mon, Mar 16, 2020 at 02:40:00PM +0530, Bharat Bhushan wrote:
> > > > > > > >>> First issue is: your guest can use 4K page and your host can use 64KB
> > > > > > > >>> pages. In that case VFIO_DMA_MAP will fail with -EINVAL. We must devise
> > > > > > > >>> a way to pass the host settings to the VIRTIO-IOMMU device.
> > > > > > > >>>
> > > > > > > >>> Even with 64KB pages, it did not work for me. I have obviously not the
> > > > > > > >>> storm of VFIO_DMA_MAP failures but I have some, most probably due to
> > > > > > > >>> some wrong notifications somewhere. I will try to investigate on my side.
> > > > > > > >>>
> > > > > > > >>> Did you test with VFIO on your side?
> > > > > > > >>
> > > > > > > >> I did not tried with different page sizes, only tested with 4K page size.
> > > > > > > >>
> > > > > > > >> Yes it works, I tested with two n/w device assigned to VM, both interfaces works
> > > > > > > >>
> > > > > > > >> First I will try with 64k page size.
> > > > > > > >
> > > > > > > > 64K page size does not work for me as well,
> > > > > > > >
> > > > > > > > I think we are not passing correct page_size_mask here
> > > > > > > > (config.page_size_mask is set to TARGET_PAGE_MASK ( which is
> > > > > > > > 0xfffffffffffff000))
> > > > > > > I guess you mean with guest using 4K and host using 64K.
> > > > > > > >
> > > > > > > > We need to set this correctly as per host page size, correct?
> > > > > > > Yes that's correct. We need to put in place a control path to retrieve
> > > > > > > the page settings on host through VFIO to inform the virtio-iommu device.
> > > > > > >
> > > > > > > Besides this issue, did you try with 64kB on host and guest?
> > > > > >
> > > > > > I tried Followings
> > > > > >   - 4k host and 4k guest  - it works with v7 version
> > > > > >   - 64k host and 64k guest - it does not work with v7
> > > > > >     hard-coded config.page_size_mask to 0xffffffffffff0000 and it works
> > > > >
> > > > > You might get this from the iova_pgsize bitmap returned by
> > > > > VFIO_IOMMU_GET_INFO. The virtio config.page_size_mask is global so there
> > > > > is the usual problem of aggregating consistent properties, but I'm
> > > > > guessing using the host page size as a granule here is safe enough.
> > > > >
> > > > > If it is a problem, we can add a PROBE property for page size mask,
> > > > > allowing to define per-endpoint page masks. I have kernel patches
> > > > > somewhere to do just that.
> > > >
> > > > I do not see we need page size mask per endpoint.
> > > >
> > > > While I am trying to understand what "page-size-mask" guest will work with
> > > >
> > > > - 4K page size host and 4k page size guest
> > > >   config.page_size_mask = 0xffffffffffff000 will work
> > > >
> > > > - 64K page size host and 64k page size guest
> > > >   config.page_size_mask = 0xfffffffffff0000 will work
> > > >
> > > > - 64K page size host and 4k page size guest
> > > >    1) config.page_size_mask = 0xffffffffffff000 will also not work as
> > > > VFIO in host expect iova and size to be aligned to 64k (PAGE_SIZE in
> > > > host)
> > > >    2) config.page_size_mask = 0xfffffffffff0000 will not work, iova
> > > > initialization (in guest) expect minimum page-size supported by h/w to
> > > > be equal to 4k (PAGE_SIZE in guest)
> > > >        Should we look to relax this in iova allocation code?
> > >
> > > Oh right, that's not great. Maybe the BUG_ON() can be removed, I'll ask on
> > > the list.
> >
> > yes, the BUG_ON in iova_init.
> > I tried with removing same and it worked, but not analyzed side effects.
>
> It might break the assumption from device drivers that mapping a page is
> safe. For example they call alloc_page() followed by dma_map_page(). In
> our situation dma-iommu.c will oblige and create one 64k mapping to one 4k
> physical page. As a result the endpoint can access the neighbouring 60k of
> memory.
>
> This isn't too terrible. After all, even when the page sizes match, device
> drivers can call dma_map_single() on sub-page buffers, which will also let
> the endpoint access a whole page. The solution, if you don't trust the
> endpoint, is to use bounce buffers.
>
> But I suspect it's not as simple as removing the BUG_ON(), we'll need to
> go over dma-iommu.c first. And it seems like assigning endpoints to guest
> userspace won't work either in this config. In vfio_dma_do_map():
>
>         mask = ((uint64_t)1 << __ffs(vfio_pgsize_bitmap(iommu))) - 1;
>
>         WARN_ON(mask & PAGE_MASK);

Yes, Agree

>
> If I read this correctly the WARN will trigger in a 4k guest under 64k
> host, right?  So maybe we can just say that this config isn't supported,
> unless it's an important use-case for virtio-iommu?

I sent v8 version of patch and with that guest and host with same page
size should work.
While i have not yet added analyzed how to mark 4k guest and 64k host
as un-supported configuration, will analyze and send patch.

Thanks
-Bharat

>
> Thanks,
> Jean
>

