Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144C6C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 08:54:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2FDB206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 08:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g+m7AHA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FDB206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE7zJ-0002zQ-Rz
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 04:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1jE7yN-0002P4-9P
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1jE7yL-0002Op-S0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:53:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1jE7yL-0002A0-Hk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:53:13 -0400
Received: by mail-wr1-x444.google.com with SMTP id b2so18271400wrj.10
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 01:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=aI2s7wW+XMGHbm0nDpj/MylVuV97Ge7grkOdNqNLJJQ=;
 b=g+m7AHA+aHN1ZAyH2ms/jYmYyOVMJAL3nWiulbVva4Dk0cLt9URfwSxw/lVQ8/PtVm
 XYdi7gLuQgQqOFdyxxjG2wjCrYzkh7XnqyPyotEUO5C1u8+6r0qNNpbf8lLm5Piy6IgO
 /xj7GaZSXdQSn2U749LwE9HdBio+0Msu3xhue7fv7wn94VlR1v3a1qByv/WEiYmYDL0j
 PglSpvYZgHI7T6AAp+tdLZtjyub63LFHk5pxtSFn5K14Q0QTdX4iljr+s1fvOE1aegfT
 8oJaE1uh7OhGdT7fxncuUum+xUCIfJ7tLzIo3i1vo4PTuDX1qeSi0yEGNGtwv9/gw2DH
 UZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aI2s7wW+XMGHbm0nDpj/MylVuV97Ge7grkOdNqNLJJQ=;
 b=gFwbMK1hHkAqpWTWlMIJkvdcwKwBmtSmdmRqxdUC7gZBNfpGrO7VSbBW+1MeXhErhj
 DFyBwzeLTE3Idl50qeXPAq93DIwXLMOOy/9s9eFqx10u8aKd57nSjOEjNK9nsO0fGoMq
 SK2aA0LxDCAyqwoHtFrPb5sdrRMJmB99WYJpF9znR4I2O+e4zlaVji+I3ZIybCXNV85L
 P3W2SXC8MSTKLHKcf177Of5NRcLfeygcLH2eR08bGtC1hPd5lRNh872c2KguOljOiJ6f
 zYKzO4ZIqw8/4Nt3YVQd4r4sxpQ4o1ilOrtqn5eLVcTWuLlKUCXLN0uJqoUScmQC1qZU
 O6+Q==
X-Gm-Message-State: ANhLgQ1oMQrH2Nc/mg+ftjv7peovPCLhwfzDPATUHTNmY+9IdPThzdC5
 6NKBi7wegi0Kl4geymc8rJCIfg==
X-Google-Smtp-Source: ADFU+vvG27bs4E4zPGwRPjvOvMHH7m10PZA/ZNjbdE+RDtiYtTyaYUOVgvUTo8TycRPYb9H0F0Jo3Q==
X-Received: by 2002:a5d:43cc:: with SMTP id v12mr4635859wrr.125.1584435192185; 
 Tue, 17 Mar 2020 01:53:12 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id a6sm3663441wrn.49.2020.03.17.01.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 01:53:11 -0700 (PDT)
Date: Tue, 17 Mar 2020 09:53:04 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Bharat Bhushan <bharatb.linux@gmail.com>
Subject: Re: [PATCH v7 3/5] virtio-iommu: Call iommu notifier for attach/detach
Message-ID: <20200317085304.GA1057687@myrica>
References: <20200313074811.27175-4-bbhushan2@marvell.com>
 <da0a4d7b-c27d-839d-56b6-da67c94adeb7@redhat.com>
 <CAAeCc_m=PKV0T8DmaE06F9NMYfU792f9TDdoyKkaPaEN3597ag@mail.gmail.com>
 <9b4ab5e8-8848-50ba-17c8-652567483126@redhat.com>
 <CAAeCc_ksAdoNJcFWkoB4YcySAb5Hw7D+kLyHx-Nt0hZJY17AXA@mail.gmail.com>
 <CAAeCc_nnM-DGCyXjFJuk-6L8F+Oetq076SEjeV8kUAGxfJVQTw@mail.gmail.com>
 <cc447790-d1c5-784b-9706-fbcd76f0c94b@redhat.com>
 <CAAeCc_mSobL4oGcK-J3WJJq8BCS6M_oyPTrzJ9bk8yFgsUDBUw@mail.gmail.com>
 <20200316101124.GA304669@myrica>
 <CAAeCc_kJq_TjbZxf3Un5rpwBrNrz-8gdL_SMS-gP_0=rARf0WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeCc_kJq_TjbZxf3Un5rpwBrNrz-8gdL_SMS-gP_0=rARf0WQ@mail.gmail.com>
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 mst@redhat.com, drjones@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org,
 Auger Eric <eric.auger@redhat.com>, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, Bharat Bhushan <bbhushan2@marvell.com>,
 linuc.decode@gmail.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 12:40:39PM +0530, Bharat Bhushan wrote:
> Hi Jean,
> 
> On Mon, Mar 16, 2020 at 3:41 PM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > Hi Bharat,
> >
> > Could you Cc me on your next posting?  Unfortunately I don't have much
> > hardware for testing this at the moment, but I might be able to help a
> > little on the review.
> >
> > On Mon, Mar 16, 2020 at 02:40:00PM +0530, Bharat Bhushan wrote:
> > > > >>> First issue is: your guest can use 4K page and your host can use 64KB
> > > > >>> pages. In that case VFIO_DMA_MAP will fail with -EINVAL. We must devise
> > > > >>> a way to pass the host settings to the VIRTIO-IOMMU device.
> > > > >>>
> > > > >>> Even with 64KB pages, it did not work for me. I have obviously not the
> > > > >>> storm of VFIO_DMA_MAP failures but I have some, most probably due to
> > > > >>> some wrong notifications somewhere. I will try to investigate on my side.
> > > > >>>
> > > > >>> Did you test with VFIO on your side?
> > > > >>
> > > > >> I did not tried with different page sizes, only tested with 4K page size.
> > > > >>
> > > > >> Yes it works, I tested with two n/w device assigned to VM, both interfaces works
> > > > >>
> > > > >> First I will try with 64k page size.
> > > > >
> > > > > 64K page size does not work for me as well,
> > > > >
> > > > > I think we are not passing correct page_size_mask here
> > > > > (config.page_size_mask is set to TARGET_PAGE_MASK ( which is
> > > > > 0xfffffffffffff000))
> > > > I guess you mean with guest using 4K and host using 64K.
> > > > >
> > > > > We need to set this correctly as per host page size, correct?
> > > > Yes that's correct. We need to put in place a control path to retrieve
> > > > the page settings on host through VFIO to inform the virtio-iommu device.
> > > >
> > > > Besides this issue, did you try with 64kB on host and guest?
> > >
> > > I tried Followings
> > >   - 4k host and 4k guest  - it works with v7 version
> > >   - 64k host and 64k guest - it does not work with v7
> > >     hard-coded config.page_size_mask to 0xffffffffffff0000 and it works
> >
> > You might get this from the iova_pgsize bitmap returned by
> > VFIO_IOMMU_GET_INFO. The virtio config.page_size_mask is global so there
> > is the usual problem of aggregating consistent properties, but I'm
> > guessing using the host page size as a granule here is safe enough.
> >
> > If it is a problem, we can add a PROBE property for page size mask,
> > allowing to define per-endpoint page masks. I have kernel patches
> > somewhere to do just that.
> 
> I do not see we need page size mask per endpoint.
> 
> While I am trying to understand what "page-size-mask" guest will work with
> 
> - 4K page size host and 4k page size guest
>   config.page_size_mask = 0xffffffffffff000 will work
> 
> - 64K page size host and 64k page size guest
>   config.page_size_mask = 0xfffffffffff0000 will work
> 
> - 64K page size host and 4k page size guest
>    1) config.page_size_mask = 0xffffffffffff000 will also not work as
> VFIO in host expect iova and size to be aligned to 64k (PAGE_SIZE in
> host)
>    2) config.page_size_mask = 0xfffffffffff0000 will not work, iova
> initialization (in guest) expect minimum page-size supported by h/w to
> be equal to 4k (PAGE_SIZE in guest)
>        Should we look to relax this in iova allocation code?

Oh right, that's not great. Maybe the BUG_ON() can be removed, I'll ask on
the list.

In the meantime, 64k granule is the right value to advertise to the guest
in this case. Did you try 64k guest 4k host?

Thanks,
Jean

