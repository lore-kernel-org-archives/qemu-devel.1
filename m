Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7B8C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 12:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9245B20771
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 12:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YC1kdoV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9245B20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEXOa-00044i-Kq
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 08:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1jEXNW-0003Au-3S
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 08:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1jEXNT-00036N-RM
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 08:00:53 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37973)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1jEXNT-0002zj-Gj
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 08:00:51 -0400
Received: by mail-wm1-x344.google.com with SMTP id t13so2980134wmi.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 05:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=WA0dwpGGCV5bw7coKiunMLKDU9Xz8RVNcKzRXcBE5iw=;
 b=YC1kdoV/gCCcdtYEOvyJSgnwmkV1FX13FiyFrOuNLUwJ5bmoybMSAxZyxhKInglsxG
 X2gMPkNKo8vywiO/uhhPC2iMyrbeRwRH4gpf7WIOJjbs0eyOOEkUFgvSl2iFuBKQhq00
 iG0vfTOBDmGTKin61JHR9o6XgtasBcsRGz1OsjMrUQcT5u+g+ftjSixGMLTGyVF6sxYP
 xSkhpDjIwYmEed5n4rkuXcsqCjn0r1aP9l2OV1Ny5ZrU2sbAOEy8JRmNS83u5IryWumm
 O5lWfpHa4MY22n08PcF54bbYbdm9iKQ3k9e1jhzgHPzThZ+PC1rYpeEhE1jSQAo+eG0C
 WjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WA0dwpGGCV5bw7coKiunMLKDU9Xz8RVNcKzRXcBE5iw=;
 b=WDH0xJeveRo3JVhl5eMHfOfFUliUcmSdGfsvAePS88SOZaI3GpeVPgH2A5h00gESpf
 ThOp0eth7q3Py/OJ6LvpuZBVGzriU8HQhl16f9+DBRX3Qe+VbtvMORvHdJID+/hNOFD2
 rZyMFMYkK9cH7GoPwLwTTpmeQW2lexe+GQgSRkA+pHgTC59/3Nh9/5mM4GDNcNTQgxUZ
 egAVsa495lZibiO2iTPdKzsaHii21wGZNnl9T9+iLhmO2484OZBPTPYwgkaq8denLOCq
 DG5ti55HzzezI6tYkPXlSpGRGIMy9JlY6HpxSVf9YJWiLoeeXsn4GyptpdnBpMNptr6v
 kyCw==
X-Gm-Message-State: ANhLgQ2gEgRo/PMqL2PoO7/Au1gkRPrKgwnGhrmo9w9q2u/Z+JYbeEN0
 akYEsLhcvg9iMnAIpz5F0iEK9w==
X-Google-Smtp-Source: ADFU+vtxSiZkBCeKq79XZcawQbSR0h2KXJS89+04gck6XqtuQdTY0yIekvPomGQyXrHYV4WE9dY4mw==
X-Received: by 2002:a1c:a102:: with SMTP id k2mr4696134wme.125.1584532850255; 
 Wed, 18 Mar 2020 05:00:50 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id q11sm9203210wrp.53.2020.03.18.05.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 05:00:48 -0700 (PDT)
Date: Wed, 18 Mar 2020 13:00:41 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [EXT] Re: [PATCH v7 3/5] virtio-iommu: Call iommu notifier for
 attach/detach
Message-ID: <20200318120041.GA1501414@myrica>
References: <CAAeCc_mSobL4oGcK-J3WJJq8BCS6M_oyPTrzJ9bk8yFgsUDBUw@mail.gmail.com>
 <20200316101124.GA304669@myrica>
 <CAAeCc_kJq_TjbZxf3Un5rpwBrNrz-8gdL_SMS-gP_0=rARf0WQ@mail.gmail.com>
 <20200317085304.GA1057687@myrica>
 <CAAeCc_n8_sY0EJODeo_PrOZ22zp8nUMOmGx2tBewz8jLaU30kA@mail.gmail.com>
 <20200317155929.GB1057687@myrica>
 <CAAeCc_k_7Ny1Kf2ZiAAJe2xms2bdK-DqB1S2ro+omxp0EWi28g@mail.gmail.com>
 <20200318111751.GA1382151@myrica>
 <MWHPR1801MB19669B4653FC94E213B894C8E3F70@MWHPR1801MB1966.namprd18.prod.outlook.com>
 <4c3a1c68-384f-f351-7307-128022020084@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c3a1c68-384f-f351-7307-128022020084@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "Tomasz Nowicki \[C\]" <tnowicki@marvell.com>,
 "mst@redhat.com" <mst@redhat.com>, "drjones@redhat.com" <drjones@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Bharat Bhushan <bharatb.linux@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Bharat Bhushan <bbhushan2@marvell.com>,
 "linuc.decode@gmail.com" <linuc.decode@gmail.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 18, 2020 at 12:42:25PM +0100, Auger Eric wrote:
> Hi Jean,
> 
> On 3/18/20 12:20 PM, Bharat Bhushan wrote:
> > 
> > 
> >> -----Original Message-----
> >> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >> Sent: Wednesday, March 18, 2020 4:48 PM
> >> To: Bharat Bhushan <bharatb.linux@gmail.com>
> >> Cc: Auger Eric <eric.auger@redhat.com>; Peter Maydell
> >> <peter.maydell@linaro.org>; kevin.tian@intel.com; Tomasz Nowicki [C]
> >> <tnowicki@marvell.com>; mst@redhat.com; drjones@redhat.com;
> >> peterx@redhat.com; qemu-devel@nongnu.org; alex.williamson@redhat.com;
> >> qemu-arm@nongnu.org; Bharat Bhushan <bbhushan2@marvell.com>;
> >> linuc.decode@gmail.com; eric.auger.pro@gmail.com
> >> Subject: [EXT] Re: [PATCH v7 3/5] virtio-iommu: Call iommu notifier for
> >> attach/detach
> >>
> >> External Email
> >>
> >> ----------------------------------------------------------------------
> >> On Wed, Mar 18, 2020 at 03:47:44PM +0530, Bharat Bhushan wrote:
> >>> Hi Jean,
> >>>
> >>> On Tue, Mar 17, 2020 at 9:29 PM Jean-Philippe Brucker
> >>> <jean-philippe@linaro.org> wrote:
> >>>>
> >>>> On Tue, Mar 17, 2020 at 02:46:55PM +0530, Bharat Bhushan wrote:
> >>>>> Hi Jean,
> >>>>>
> >>>>> On Tue, Mar 17, 2020 at 2:23 PM Jean-Philippe Brucker
> >>>>> <jean-philippe@linaro.org> wrote:
> >>>>>>
> >>>>>> On Tue, Mar 17, 2020 at 12:40:39PM +0530, Bharat Bhushan wrote:
> >>>>>>> Hi Jean,
> >>>>>>>
> >>>>>>> On Mon, Mar 16, 2020 at 3:41 PM Jean-Philippe Brucker
> >>>>>>> <jean-philippe@linaro.org> wrote:
> >>>>>>>>
> >>>>>>>> Hi Bharat,
> >>>>>>>>
> >>>>>>>> Could you Cc me on your next posting?  Unfortunately I don't
> >>>>>>>> have much hardware for testing this at the moment, but I
> >>>>>>>> might be able to help a little on the review.
> >>>>>>>>
> >>>>>>>> On Mon, Mar 16, 2020 at 02:40:00PM +0530, Bharat Bhushan wrote:
> >>>>>>>>>>>>> First issue is: your guest can use 4K page and your
> >>>>>>>>>>>>> host can use 64KB pages. In that case VFIO_DMA_MAP
> >>>>>>>>>>>>> will fail with -EINVAL. We must devise a way to pass the host
> >> settings to the VIRTIO-IOMMU device.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Even with 64KB pages, it did not work for me. I have
> >>>>>>>>>>>>> obviously not the storm of VFIO_DMA_MAP failures but
> >>>>>>>>>>>>> I have some, most probably due to some wrong notifications
> >> somewhere. I will try to investigate on my side.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Did you test with VFIO on your side?
> >>>>>>>>>>>>
> >>>>>>>>>>>> I did not tried with different page sizes, only tested with 4K page
> >> size.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Yes it works, I tested with two n/w device assigned
> >>>>>>>>>>>> to VM, both interfaces works
> >>>>>>>>>>>>
> >>>>>>>>>>>> First I will try with 64k page size.
> >>>>>>>>>>>
> >>>>>>>>>>> 64K page size does not work for me as well,
> >>>>>>>>>>>
> >>>>>>>>>>> I think we are not passing correct page_size_mask here
> >>>>>>>>>>> (config.page_size_mask is set to TARGET_PAGE_MASK (
> >>>>>>>>>>> which is
> >>>>>>>>>>> 0xfffffffffffff000))
> >>>>>>>>>> I guess you mean with guest using 4K and host using 64K.
> >>>>>>>>>>>
> >>>>>>>>>>> We need to set this correctly as per host page size, correct?
> >>>>>>>>>> Yes that's correct. We need to put in place a control
> >>>>>>>>>> path to retrieve the page settings on host through VFIO to inform the
> >> virtio-iommu device.
> >>>>>>>>>>
> >>>>>>>>>> Besides this issue, did you try with 64kB on host and guest?
> >>>>>>>>>
> >>>>>>>>> I tried Followings
> >>>>>>>>>   - 4k host and 4k guest  - it works with v7 version
> >>>>>>>>>   - 64k host and 64k guest - it does not work with v7
> >>>>>>>>>     hard-coded config.page_size_mask to 0xffffffffffff0000
> >>>>>>>>> and it works
> >>>>>>>>
> >>>>>>>> You might get this from the iova_pgsize bitmap returned by
> >>>>>>>> VFIO_IOMMU_GET_INFO. The virtio config.page_size_mask is
> >>>>>>>> global so there is the usual problem of aggregating
> >>>>>>>> consistent properties, but I'm guessing using the host page size as a
> >> granule here is safe enough.
> >>>>>>>>
> >>>>>>>> If it is a problem, we can add a PROBE property for page
> >>>>>>>> size mask, allowing to define per-endpoint page masks. I
> >>>>>>>> have kernel patches somewhere to do just that.
> >>>>>>>
> >>>>>>> I do not see we need page size mask per endpoint.
> >>>>>>>
> >>>>>>> While I am trying to understand what "page-size-mask" guest
> >>>>>>> will work with
> >>>>>>>
> >>>>>>> - 4K page size host and 4k page size guest
> >>>>>>>   config.page_size_mask = 0xffffffffffff000 will work
> >>>>>>>
> >>>>>>> - 64K page size host and 64k page size guest
> >>>>>>>   config.page_size_mask = 0xfffffffffff0000 will work
> >>>>>>>
> >>>>>>> - 64K page size host and 4k page size guest
> >>>>>>>    1) config.page_size_mask = 0xffffffffffff000 will also not
> >>>>>>> work as VFIO in host expect iova and size to be aligned to 64k
> >>>>>>> (PAGE_SIZE in
> >>>>>>> host)
> >>>>>>>    2) config.page_size_mask = 0xfffffffffff0000 will not work,
> >>>>>>> iova initialization (in guest) expect minimum page-size
> >>>>>>> supported by h/w to be equal to 4k (PAGE_SIZE in guest)
> >>>>>>>        Should we look to relax this in iova allocation code?
> >>>>>>
> >>>>>> Oh right, that's not great. Maybe the BUG_ON() can be removed,
> >>>>>> I'll ask on the list.
> >>>>>
> >>>>> yes, the BUG_ON in iova_init.
> So you mean in init_iova_domain()?
> 
> I see the BUG_ON was introduced in
> 0fb5fe874c42942e16c450ae05da453e13a1c09e "iommu: Make IOVA domain page
> size explicit" but was it meant to remain?

No I don't think iova.c is the problem, we could as well remove the
BUG_ON(). Now my concern is more with dma-iommu.c and VFIO which use the
PAGE_SIZE in some places and could have ingrained assumption about
iommu_pgsize <= PAGE_SIZE. We need a thorough audit of these drivers
before relaxing this. I started with dma-iommu yesterday but gave up after
seeing the VFIO WARN_ON.

I just sent the patch for virtio-iommu on the IOMMU list, we can continue
the discussion there

Thanks,
Jean

> 
> Logically when we allocate buffer IOVAs for DMA accesses, later on,
> shouldn't it be possible to use the actual granule set on init() and
> make sure the allocated size is properly aligned.
> 
> Reading the commit msg it explicitly says that "the systems may contain
> heterogeneous IOMMUs supporting differing minimum page sizes, which may
> also not be common with the CPU page size".
> 
> Thanks
> 
> Eric
> 
> 
> >>>>> I tried with removing same and it worked, but not analyzed side effects.
> >>>>
> >>>> It might break the assumption from device drivers that mapping a
> >>>> page is safe. For example they call alloc_page() followed by
> >>>> dma_map_page(). In our situation dma-iommu.c will oblige and create
> >>>> one 64k mapping to one 4k physical page. As a result the endpoint
> >>>> can access the neighbouring 60k of memory.
> >>>>
> >>>> This isn't too terrible. After all, even when the page sizes match,
> >>>> device drivers can call dma_map_single() on sub-page buffers, which
> >>>> will also let the endpoint access a whole page. The solution, if you
> >>>> don't trust the endpoint, is to use bounce buffers.
> >>>>
> >>>> But I suspect it's not as simple as removing the BUG_ON(), we'll
> >>>> need to go over dma-iommu.c first. And it seems like assigning
> >>>> endpoints to guest userspace won't work either in this config. In
> >> vfio_dma_do_map():
> >>>>
> >>>>         mask = ((uint64_t)1 << __ffs(vfio_pgsize_bitmap(iommu))) -
> >>>> 1;
> >>>>
> >>>>         WARN_ON(mask & PAGE_MASK);
> >>>
> >>> Yes, Agree
> >>>
> >>>>
> >>>> If I read this correctly the WARN will trigger in a 4k guest under
> >>>> 64k host, right?  So maybe we can just say that this config isn't
> >>>> supported, unless it's an important use-case for virtio-iommu?
> >>>
> >>> I sent v8 version of patch and with that guest and host with same page
> >>> size should work.
> >>> While i have not yet added analyzed how to mark 4k guest and 64k host
> >>> as un-supported configuration, will analyze and send patch.
> >>
> >> I don't think there is anything to do for QEMU, it's Linux that doesn't support the
> >> configuration. We could add something like the attached patch, in the virtio-
> >> iommu driver, to abort more gracefully than with a BUG_ON().
> > 
> > Yes agree, we need to have change in Linux side.
> > 
> > Thanks
> > -Bharat
> > 
> >>
> >> Thanks,
> >> Jean
> > 
> 

