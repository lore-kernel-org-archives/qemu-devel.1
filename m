Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14723C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B8B20674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVH4Zc/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B8B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE8MD-00031M-WC
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bharatb.linux@gmail.com>) id 1jE8LV-0002bG-I3
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bharatb.linux@gmail.com>) id 1jE8LU-0007Sq-7Z
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:17:09 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:42648)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bharatb.linux@gmail.com>)
 id 1jE8LU-0007RO-24; Tue, 17 Mar 2020 05:17:08 -0400
Received: by mail-qv1-xf42.google.com with SMTP id ca9so10448704qvb.9;
 Tue, 17 Mar 2020 02:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k+SaH3Lfepk5kkrWdLbL8cH0r/Gvrf4nNeqe4QatC3k=;
 b=FVH4Zc/UQgAqPsvGI+JoFBov41Qv+VfDdSE+U2JcduqVxgiPpqEDh+qZx/U9aWPDmO
 BnjgZ01ybmgi+FROgkYRtaFroN7ybo6baH1fqkju+0uON9zRSY4onl+eun7ZImodKinh
 IJ8Vx+pG0Ma/roEO7vjPScTEYOa99hDHOhBvdEntrJnxg24zwRIK0bK3bNsTIiL28rZv
 jwufXJncBRlhP1V+UxNsmeYJDx0Am2TEPLjEmiYWaNhk6bVDBgq/DiOuL2HAkAK1abHR
 FWLzQkmzwt6eU+pckJnG0CJ4X54nuBWkbKVR7dl+zRXicirAHZAQKkr09Lu3ziLM7gaN
 0+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k+SaH3Lfepk5kkrWdLbL8cH0r/Gvrf4nNeqe4QatC3k=;
 b=Zv4Ptbf50lga/1UYsfxZotkhkLck3oB6YrVzSkfwg7QT7HUqs5wH6aFPfVuiAYhPnb
 hMFOAApGuqc+F+jPdaAmaFTeKnG9TeMJN8zrxCybsxnSGoJFunqeUK9mp7oLzkGdv3dA
 wNIfC2unQSp/4FnT4vqB2hCK7N2XxNY69uACLixTHb2nWZftEcz35BS6k5lu/JGEMHeY
 d7W4lSG3UTtDbj8P7YoVMeUZ/NUCKu0oL1cIs9QgSMyhhmO0/tm0nny4zDpEtytzax6z
 dlLE0RRe3xk2axaheDyDdALihmR67/LEjRsCvJdL1RuY7IJLHKIutqI+E9ERuJ6cVQBf
 Xlqg==
X-Gm-Message-State: ANhLgQ3O2HWHIZ3oisRf+Rwbb2DRs+3Q+SC9iEGA8i2pbejDhP4SyG5Y
 9KS3O8QiD74IwNq6onyl6sYloNHLn4x6Qtr0NzQ=
X-Google-Smtp-Source: ADFU+vs0wNTzrwkdKYb6ujVnVdpfNLG40bwvEqomtHCW4nNhW33XmzL7+kiDHKYO9ZXEFAIfkTvwnZc8w0V1vk4Ar5M=
X-Received: by 2002:a05:6214:1449:: with SMTP id
 b9mr3889100qvy.217.1584436627037; 
 Tue, 17 Mar 2020 02:17:07 -0700 (PDT)
MIME-Version: 1.0
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
 <20200317085304.GA1057687@myrica>
In-Reply-To: <20200317085304.GA1057687@myrica>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Tue, 17 Mar 2020 14:46:55 +0530
Message-ID: <CAAeCc_n8_sY0EJODeo_PrOZ22zp8nUMOmGx2tBewz8jLaU30kA@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] virtio-iommu: Call iommu notifier for attach/detach
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f42
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

On Tue, Mar 17, 2020 at 2:23 PM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Tue, Mar 17, 2020 at 12:40:39PM +0530, Bharat Bhushan wrote:
> > Hi Jean,
> >
> > On Mon, Mar 16, 2020 at 3:41 PM Jean-Philippe Brucker
> > <jean-philippe@linaro.org> wrote:
> > >
> > > Hi Bharat,
> > >
> > > Could you Cc me on your next posting?  Unfortunately I don't have much
> > > hardware for testing this at the moment, but I might be able to help a
> > > little on the review.
> > >
> > > On Mon, Mar 16, 2020 at 02:40:00PM +0530, Bharat Bhushan wrote:
> > > > > >>> First issue is: your guest can use 4K page and your host can use 64KB
> > > > > >>> pages. In that case VFIO_DMA_MAP will fail with -EINVAL. We must devise
> > > > > >>> a way to pass the host settings to the VIRTIO-IOMMU device.
> > > > > >>>
> > > > > >>> Even with 64KB pages, it did not work for me. I have obviously not the
> > > > > >>> storm of VFIO_DMA_MAP failures but I have some, most probably due to
> > > > > >>> some wrong notifications somewhere. I will try to investigate on my side.
> > > > > >>>
> > > > > >>> Did you test with VFIO on your side?
> > > > > >>
> > > > > >> I did not tried with different page sizes, only tested with 4K page size.
> > > > > >>
> > > > > >> Yes it works, I tested with two n/w device assigned to VM, both interfaces works
> > > > > >>
> > > > > >> First I will try with 64k page size.
> > > > > >
> > > > > > 64K page size does not work for me as well,
> > > > > >
> > > > > > I think we are not passing correct page_size_mask here
> > > > > > (config.page_size_mask is set to TARGET_PAGE_MASK ( which is
> > > > > > 0xfffffffffffff000))
> > > > > I guess you mean with guest using 4K and host using 64K.
> > > > > >
> > > > > > We need to set this correctly as per host page size, correct?
> > > > > Yes that's correct. We need to put in place a control path to retrieve
> > > > > the page settings on host through VFIO to inform the virtio-iommu device.
> > > > >
> > > > > Besides this issue, did you try with 64kB on host and guest?
> > > >
> > > > I tried Followings
> > > >   - 4k host and 4k guest  - it works with v7 version
> > > >   - 64k host and 64k guest - it does not work with v7
> > > >     hard-coded config.page_size_mask to 0xffffffffffff0000 and it works
> > >
> > > You might get this from the iova_pgsize bitmap returned by
> > > VFIO_IOMMU_GET_INFO. The virtio config.page_size_mask is global so there
> > > is the usual problem of aggregating consistent properties, but I'm
> > > guessing using the host page size as a granule here is safe enough.
> > >
> > > If it is a problem, we can add a PROBE property for page size mask,
> > > allowing to define per-endpoint page masks. I have kernel patches
> > > somewhere to do just that.
> >
> > I do not see we need page size mask per endpoint.
> >
> > While I am trying to understand what "page-size-mask" guest will work with
> >
> > - 4K page size host and 4k page size guest
> >   config.page_size_mask = 0xffffffffffff000 will work
> >
> > - 64K page size host and 64k page size guest
> >   config.page_size_mask = 0xfffffffffff0000 will work
> >
> > - 64K page size host and 4k page size guest
> >    1) config.page_size_mask = 0xffffffffffff000 will also not work as
> > VFIO in host expect iova and size to be aligned to 64k (PAGE_SIZE in
> > host)
> >    2) config.page_size_mask = 0xfffffffffff0000 will not work, iova
> > initialization (in guest) expect minimum page-size supported by h/w to
> > be equal to 4k (PAGE_SIZE in guest)
> >        Should we look to relax this in iova allocation code?
>
> Oh right, that's not great. Maybe the BUG_ON() can be removed, I'll ask on
> the list.

yes, the BUG_ON in iova_init.
I tried with removing same and it worked, but not analyzed side effects.

>
> In the meantime, 64k granule is the right value to advertise to the guest
> in this case.
> Did you try 64k guest 4k host?

no, will try.

Thanks
-Bharat

>
> Thanks,
> Jean

