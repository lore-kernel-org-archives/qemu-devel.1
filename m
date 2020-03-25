Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5B9C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 05:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EEF520774
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 05:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EEF520774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGyeU-00022I-6R
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 01:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1jGydW-0001cM-9l
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 01:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1jGydS-0006x4-5j
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 01:31:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:12368)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1jGydR-0006tt-Nm
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 01:31:26 -0400
IronPort-SDR: br1X5t9UXDKQYUU68+pWpiBJDh0tKRgcWeIocR2ZHBI6d22CHaYLN9b4zoSrdGwjxpJpHkmDO2
 otrAL/YtXMPA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2020 22:31:16 -0700
IronPort-SDR: FZLICKY7XSOBzu9GLXAw0kmFh2MjtGBT6Hq6yhuQdZu5jGyIj+tDMC8TtxMbpQtv89HALUvSHD
 HxC9yKMGhgHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,303,1580803200"; d="scan'208";a="270692717"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga004.fm.intel.com with ESMTP; 24 Mar 2020 22:31:16 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Mar 2020 22:31:16 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Mar 2020 22:31:16 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.43]) with mapi id 14.03.0439.000;
 Wed, 25 Mar 2020 13:31:13 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH v15 Kernel 4/7] vfio iommu: Implementation of ioctl for
 dirty pages tracking.
Thread-Topic: [PATCH v15 Kernel 4/7] vfio iommu: Implementation of ioctl for
 dirty pages tracking.
Thread-Index: AQHV/jAV21NxZGgpXU6dz1wdFLv9bqhQAO0AgAE8UwCAAAN2gIAAC00AgAAExwCABKT1gIAADgYAgAABzACAAIjsAIAAwk4AgABgwwCAARv/QA==
Date: Wed, 25 Mar 2020 05:31:13 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D7E8F15@SHSMSX104.ccr.corp.intel.com>
References: <20200319165704.1f4eb36a@w520.home>
 <bc48ae5c-67f9-d95e-5d60-6c42359bb790@nvidia.com>
 <20200320120137.6acd89ee@x1.home>
 <cf0ee134-c1c7-f60c-afc2-8948268d8880@nvidia.com>
 <20200320125910.028d7af5@w520.home>
 <7062f72a-bf06-a8cd-89f0-9e729699a454@nvidia.com>
 <20200323124448.2d3bc315@w520.home> <20200323185114.GF3017@work-vm>
 <20200324030118.GD5456@joy-OptiPlex-7040>
 <20200324083644.36494641@w520.home> <20200324202304.GJ2645@work-vm>
In-Reply-To: <20200324202304.GJ2645@work-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.120
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
Cc: "Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wang, 
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 Kirti Wankhede <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Sent: Wednesday, March 25, 2020 4:23 AM
>=20
> * Alex Williamson (alex.williamson@redhat.com) wrote:
> > On Mon, 23 Mar 2020 23:01:18 -0400
> > Yan Zhao <yan.y.zhao@intel.com> wrote:
> >
> > > On Tue, Mar 24, 2020 at 02:51:14AM +0800, Dr. David Alan Gilbert wrot=
e:
> > > > * Alex Williamson (alex.williamson@redhat.com) wrote:
> > > > > On Mon, 23 Mar 2020 23:24:37 +0530
> > > > > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > > > >
> > > > > > On 3/21/2020 12:29 AM, Alex Williamson wrote:
> > > > > > > On Sat, 21 Mar 2020 00:12:04 +0530
> > > > > > > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > > > > > >
> > > > > > >> On 3/20/2020 11:31 PM, Alex Williamson wrote:
> > > > > > >>> On Fri, 20 Mar 2020 23:19:14 +0530
> > > > > > >>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > > > > > >>>
> > > > > > >>>> On 3/20/2020 4:27 AM, Alex Williamson wrote:
> > > > > > >>>>> On Fri, 20 Mar 2020 01:46:41 +0530
> > > > > > >>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > > > > > >>>>>
> > > > > > >>
> > > > > > >> <snip>
> > > > > > >>
> > > > > > >>>>>> +static int vfio_iova_dirty_bitmap(struct vfio_iommu
> *iommu, dma_addr_t iova,
> > > > > > >>>>>> +				  size_t size, uint64_t pgsize,
> > > > > > >>>>>> +				  u64 __user *bitmap)
> > > > > > >>>>>> +{
> > > > > > >>>>>> +	struct vfio_dma *dma;
> > > > > > >>>>>> +	unsigned long pgshift =3D __ffs(pgsize);
> > > > > > >>>>>> +	unsigned int npages, bitmap_size;
> > > > > > >>>>>> +
> > > > > > >>>>>> +	dma =3D vfio_find_dma(iommu, iova, 1);
> > > > > > >>>>>> +
> > > > > > >>>>>> +	if (!dma)
> > > > > > >>>>>> +		return -EINVAL;
> > > > > > >>>>>> +
> > > > > > >>>>>> +	if (dma->iova !=3D iova || dma->size !=3D size)
> > > > > > >>>>>> +		return -EINVAL;
> > > > > > >>>>>> +
> > > > > > >>>>>> +	npages =3D dma->size >> pgshift;
> > > > > > >>>>>> +	bitmap_size =3D DIRTY_BITMAP_BYTES(npages);
> > > > > > >>>>>> +
> > > > > > >>>>>> +	/* mark all pages dirty if all pages are pinned and
> mapped. */
> > > > > > >>>>>> +	if (dma->iommu_mapped)
> > > > > > >>>>>> +		bitmap_set(dma->bitmap, 0, npages);
> > > > > > >>>>>> +
> > > > > > >>>>>> +	if (copy_to_user((void __user *)bitmap, dma-
> >bitmap, bitmap_size))
> > > > > > >>>>>> +		return -EFAULT;
> > > > > > >>>>>
> > > > > > >>>>> We still need to reset the bitmap here, clearing and re-a=
dding
> the
> > > > > > >>>>> pages that are still pinned.
> > > > > > >>>>>
> > > > > > >>>>>
> https://lore.kernel.org/kvm/20200319070635.2ff5db56@x1.home/
> > > > > > >>>>>
> > > > > > >>>>
> > > > > > >>>> I thought you agreed on my reply to it
> > > > > > >>>> https://lore.kernel.org/kvm/31621b70-02a9-2ea5-045f-
> f72b671fe703@nvidia.com/
> > > > > > >>>>
> > > > > > >>>>    > Why re-populate when there will be no change since
> > > > > > >>>>    > vfio_iova_dirty_bitmap() is called holding iommu->loc=
k? If
> there is any
> > > > > > >>>>    > pin request while vfio_iova_dirty_bitmap() is still w=
orking, it
> will
> > > > > > >>>>    > wait till iommu->lock is released. Bitmap will be pop=
ulated
> when page is
> > > > > > >>>>    > pinned.
> > > > > > >>>
> > > > > > >>> As coded, dirty bits are only ever set in the bitmap, never
> cleared.
> > > > > > >>> If a page is unpinned between iterations of the user record=
ing
> the
> > > > > > >>> dirty bitmap, it should be marked dirty in the iteration
> immediately
> > > > > > >>> after the unpinning and not marked dirty in the following
> iteration.
> > > > > > >>> That doesn't happen here.  We're reporting cumulative dirty
> pages since
> > > > > > >>> logging was enabled, we need to be reporting dirty pages si=
nce
> the user
> > > > > > >>> last retrieved the dirty bitmap.  The bitmap should be clea=
red
> and
> > > > > > >>> currently pinned pages re-added after copying to the user.
> Thanks,
> > > > > > >>>
> > > > > > >>
> > > > > > >> Does that mean, we have to track every iteration? do we real=
ly
> need that
> > > > > > >> tracking?
> > > > > > >>
> > > > > > >> Generally the flow is:
> > > > > > >> - vendor driver pin x pages
> > > > > > >> - Enter pre-copy-phase where vCPUs are running - user starts
> dirty pages
> > > > > > >> tracking, then user asks dirty bitmap, x pages reported dirt=
y by
> > > > > > >> VFIO_IOMMU_DIRTY_PAGES ioctl with _GET flag
> > > > > > >> - In pre-copy phase, vendor driver pins y more pages, now
> bitmap
> > > > > > >> consists of x+y bits set
> > > > > > >> - In pre-copy phase, vendor driver unpins z pages, but bitma=
p is
> not
> > > > > > >> updated, so again bitmap consists of x+y bits set.
> > > > > > >> - Enter in stop-and-copy phase, vCPUs are stopped, mdev devi=
ces
> are stopped
> > > > > > >> - user asks dirty bitmap - Since here vCPU and mdev devices =
are
> stopped,
> > > > > > >> pages should not get dirty by guest driver or the physical d=
evice.
> > > > > > >> Hence, x+y dirty pages would be reported.
> > > > > > >>
> > > > > > >> I don't think we need to track every iteration of bitmap rep=
orting.
> > > > > > >
> > > > > > > Yes, once a bitmap is read, it's reset.  In your example, aft=
er
> > > > > > > unpinning z pages the user should still see a bitmap with x+y=
 pages,
> > > > > > > but once they've read that bitmap, the next bitmap should be =
x+y-
> z.
> > > > > > > Userspace can make decisions about when to switch from pre-
> copy to
> > > > > > > stop-and-copy based on convergence, ie. the slope of the line
> recording
> > > > > > > dirty pages per iteration.  The implementation here never all=
ows
> an
> > > > > > > inflection point, dirty pages reported through vfio would alw=
ays
> either
> > > > > > > be flat or climbing.  There might also be a case that an iomm=
u
> backed
> > > > > > > device could start pinning pages during the course of a migra=
tion,
> how
> > > > > > > would the bitmap ever revert from fully populated to only tra=
cking
> the
> > > > > > > pinned pages?  Thanks,
> > > > > > >
> > > > > >
> > > > > > At KVM forum we discussed this - if guest driver pins say 1024 =
pages
> > > > > > before migration starts, during pre-copy phase device can dirty=
 0
> pages
> > > > > > in best case and 1024 pages in worst case. In that case, user w=
ill
> > > > > > transfer content of 1024 pages during pre-copy phase and in
> > > > > > stop-and-copy phase also, that will be pages will be copied twi=
ce. So
> we
> > > > > > decided to only get dirty pages bitmap at stop-and-copy phase. =
If
> user
> > > > > > is going to get dirty pages in stop-and-copy phase only, then t=
hat will
> > > > > > be single iteration.
> > > > > > There aren't any devices yet that can track sys memory dirty pa=
ges.
> So
> > > > > > we can go ahead with this patch and support for dirty pages tra=
cking
> > > > > > during pre-copy phase can be added later when there will be
> consumers of
> > > > > > that functionality.
> > > > >
> > > > > So if I understand this right, you're expecting the dirty bitmap =
to
> > > > > accumulate dirty bits, in perpetuity, so that the user can only
> > > > > retrieve them once at the end of migration?  But if that's the ca=
se,
> > > > > the user could simply choose to not retrieve the bitmap until the=
 end
> > > > > of migration, the result would be the same.  What we have here is
> that
> > > > > dirty bits are never cleared, regardless of whether the user has =
seen
> > > > > them, which is wrong.  Sorry, we had a lot of discussions at KVM
> forum,
> > > > > I don't recall this specific one 5 months later and maybe we were=
n't
> > > > > considering all aspects.  I see the behavior we have here as inco=
rrect,
> > > > > but it also seems relatively trivial to make correct.  I hope the=
 QEMU
> > > > > code isn't making us go through all this trouble to report a dirt=
y
> > > > > bitmap that gets thrown away because it expects the final one to =
be
> > > > > cumulative since the beginning of dirty logging.  Thanks,
> > > >
> > > > I remember the discussion that we couldn't track the system memory
> > > > dirtying with current hardware; so the question then is just to tra=
ck
> > > hi Dave
> > > there are already devices that are able to track the system memory,
> > > through two ways:
> > > (1) software method. like VFs for "Intel(R) Ethernet Controller XL710
> Family
> > > support".
> > > (2) hardware method. through hardware internal buffer (as one Intel
> > > internal hardware not yet to public, but very soon) or through VTD-3.=
0
> > > IOMMU.
> > >
> > > we have already had code verified using the two ways to track system
> memory
> > > in fine-grained level.
> > >
> > >
> > > > what has been pinned and then ideally put that memory off until the
> end.
> > > > (Which is interesting because I don't think we currently have  a wa=
y
> > > > to delay RAM pages till the end in qemu).
> > >
> > > I think the problem here is that we mixed pinned pages with dirty pag=
es.
> >
> > We are reporting dirty pages, pinned pages are just assumed to be dirty=
.
> >
> > > yes, pinned pages for mdev devices are continuously likely to be dirt=
y
> > > until device stopped.
> > > But for devices that are able to report dirty pages, dirtied pages
> > > will be marked again if hardware writes them later.
> > >
> > > So, is it good to introduce a capability to let vfio/qemu know how to
> > > treat the dirty pages?
> >
> > Dirty pages are dirty, QEMU doesn't need any special flag, instead we
> > need to evolve different mechanisms for the vendor driver so that we
> > can differentiate pages pinned for read vs pages pinned for write.
> > Perhaps interfaces to pin pages without dirtying them, and a separate
> > mechanism to dirty a previously pinned-page, ie. promote it permanently
> > or transiently to a writable page.
> >
> > > (1) for devices have no fine-grained dirty page tracking capability
> > >   a. pinned pages are regarded as dirty pages. they are not cleared b=
y
> > >   dirty page query
> > >   b. unpinned pages are regarded as dirty pages. they are cleared by
> > >   dirty page query or UNMAP ioctl.
> > > (2) for devices that have fine-grained dirty page tracking capability
> > >    a. pinned/unpinned pages are not regarded as dirty pages
> >
> > We need a pin-read-only interface for this.
> >
> > >    b. only pages they reported are regarded as dirty pages and are to=
 be
> > >    cleared by dirty page query and UNMAP ioctl.
> >
> > We need a set-dirty or promote-writable interface for this.
> >
> > > (3) for dirty pages marking APIs, like vfio_dma_rw()...
> > >    pages marked by them are regared as dirty and are to be cleared by
> > >    dirty page query and UNMAP ioctl
> > >
> > > For (1), qemu VFIO only reports dirty page amount and would not
> transfer
> > > those pages until last round.
> > > for (2) and (3), qemu VFIO should report and transfer them in each
> > > round.
> >
> > IMO, QEMU should not be aware of any of this.  Userspace has an
> > interface to retrieve dirtied pages (period).  We should adjust the
> > pages that we report as dirtied to be accurate based on the
> > capabilities of the vendor driver.  We can evolve those internal APIs
> > between the vendor driver and vfio iommu over time without modifying
> > this user interface.
>=20
> I'm not sure;  if you have a block of memory that's constantly marked
> dirty in (1) - we need to avoid constantly retransmitting that memory to
> the destination; there's no point in sending it until the end of the
> iterations - so it shouldn't even get sent once in the iteration.
> But at the same time, we can't ignore the fact that those pages are
> going to be dirty - because that influences the downtime; so we need
> to know we're going to be getting them later, even if we don't
> initially mark them as dirty.

For that we possibly need a way to allow VFIO or vendor driver telling
the userspace that I can report dirty pages to you but it is better to do
it in the end since the set is sort of static and big thus not optimal to
transfer them multiple rounds, and I can also report to you the number=20
of currently-tracked dirty pages so you may use it to make accurate
prediction to decide when to exit the precopy. But such feature might
be introduced orthogonal to the standard bitmap interface, i.e. not
necessarily to block this series for the baseline live migration support...

Thanks
Kevin

>=20
> > > > [I still worry whether migration will be usable with any
> > > > significant amount of system ram that's pinned in this way; the
> > > > downside will very easily get above the threshold that people like]
> > > >
> > > yes. that's why we have to do multi-round dirty page query and
> > > transfer and clear the dirty bitmaps in each round for devices that a=
re
> > > able to track in fine grain.
> > > and that's why we have to report the amount of dirty pages before
> > > stop-and-copy phase for mdev devices, so that people are able to know
> > > the real downtime as much as possible.
> >
> > Yes, the dirty bitmap should be accurate to report the pages dirtied
> > since it was last retrieved and over time we can add internal
> > interfaces to give vendor drivers more granularity in marking pinned
> > pages dirty and perhaps even exposing the bitmap to the vendor drivers
> > to set pages themselves.  I don't necessarily think it's worthwhile to
> > create a new class of dirtied pages to transfer at the end, we're
> > fighting a losing battle at that point.  We should be focusing on
> > improving the granularity of page dirtying in order to reduce the pages
> > transferred at the end of migration.  Thanks,
>=20
> Dave
>=20
> > Alex
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


