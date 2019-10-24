Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA2DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC67205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC67205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41401 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcUq-0008C3-36
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1iNbVK-00085X-K7
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1iNbVH-0004lP-DJ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:42:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:35132)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1iNbVH-0004kR-3B
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:42:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Oct 2019 04:42:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; d="scan'208";a="373188226"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga005.jf.intel.com with ESMTP; 24 Oct 2019 04:42:02 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 24 Oct 2019 04:42:01 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 24 Oct 2019 04:42:01 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.166]) by
 SHSMSX154.ccr.corp.intel.com ([10.239.6.54]) with mapi id 14.03.0439.000;
 Thu, 24 Oct 2019 19:41:59 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v8 01/13] vfio: KABI for migration interface
Thread-Topic: [PATCH v8 01/13] vfio: KABI for migration interface
Thread-Index: AQHVXEPM6Ds11z4g1kGhkyVJXk+n4qcQheKAgAKxOUCAABvDkIAAD6EAgAYgQnCADi7SAIABCiGQgBGEuYCAAIWfAIAA2CrQgADLv4CAAOrXAIAA0IIAgCvN7lA=
Date: Thu, 24 Oct 2019 11:41:59 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D5CB2F7@SHSMSX104.ccr.corp.intel.com>
References: <1566845753-18993-1-git-send-email-kwankhede@nvidia.com>
 <1566845753-18993-2-git-send-email-kwankhede@nvidia.com>
 <20190828145045.20f2a7b3@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D553133@SHSMSX104.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D553184@SHSMSX104.ccr.corp.intel.com>
 <20190830103252.2b427144@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D560D74@SHSMSX104.ccr.corp.intel.com>
 <20190912154106.4e784906@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D572142@SHSMSX104.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D58C8FD@SHSMSX104.ccr.corp.intel.com>
 <20190924120318.04696187@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D58EA38@SHSMSX104.ccr.corp.intel.com>
 <20190925130613.4fdae237@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D5911BA@SHSMSX104.ccr.corp.intel.com>
 <20190926153302.65199771@x1.home>
In-Reply-To: <20190926153302.65199771@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZmFhMTBkZjItMWM5Mi00NjMxLThiMjktZWYyZDcwZjY1Nzg4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiR3JhK0dadHdoSHN6c0pzN09ITCtIMVBxYmpKcXRKU0lGWWZ4QVp0NFljQ2puQW16cW81cWxJQ0paN0tjNEQ0NCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
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
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liu,
 Yi L" <yi.l.liu@intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang, 
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

Sorry for late reply...

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Friday, September 27, 2019 5:33 AM
>=20
> On Thu, 26 Sep 2019 03:07:08 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
>=20
> > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > Sent: Thursday, September 26, 2019 3:06 AM
> > [...]
> > > > > > The second point is about write-protection:
> > > > > >
> > > > > > > There is another value of recording GPA in VFIO. Vendor drive=
rs
> > > > > > > (e.g. GVT-g) may need to selectively write-protect guest memo=
ry
> > > > > > > pages when interpreting certain workload descriptors. Those
> pages
> > > > > > > are recorded in IOVA when vIOMMU is enabled, however the
> KVM
> > > > > > > write-protection API only knows GPA. So currently vIOMMU must
> > > > > > > be disabled on Intel vGPUs when GVT-g is enabled. To make it
> > > working
> > > > > > > we need a way to translate IOVA into GPA in the vendor driver=
s.
> > > > > > > There are two options. One is having KVM export a new API for
> such
> > > > > > > translation purpose. But as you explained earlier it's not go=
od to
> > > > > > > have vendor drivers depend on KVM. The other is having VFIO
> > > > > > > maintaining such knowledge through extended MAP interface,
> > > > > > > then providing a uniform API for all vendor drivers to use.
> > > > >
> > > > > So the argument is that in order to interact with KVM (write
> protecting
> > > > > guest memory) there's a missing feature (IOVA to GPA translation)=
,
> but
> > > > > we don't want to add an API to KVM for this feature because that
> would
> > > > > create a dependency on KVM (for interacting with KVM), so lets ad=
d
> an
> > > > > API to vfio instead.  That makes no sense to me.  What am I missi=
ng?
> > > > > Thanks,
> > > > >
> > > >
> > > > Then do you have a recommendation how such feature can be
> > > > implemented cleanly in vendor driver, without introducing direct
> > > > dependency on KVM?
> > >
> > > I think the disconnect is that these sorts of extensions don't reflec=
t
> > > things that a physical device can actually do.  The idea of vfio is
> > > that it's a userspace driver interface.  It provides a channel for th=
e
> > > user to interact with the device, map device resources, receive
> > > interrupts, map system memory through the iommu, etc.  Mediated
> > > devices
> > > augment this by replacing the physical device the user accesses with =
a
> > > software virtualized device.  So then the question becomes why this
> > > device virtualizing software, ie. the mdev vendor driver, needs to do
> > > things that a physical device clearly cannot do.  For example, how ca=
n
> > > a physical device write-protect portions of system memory?  Or even,
> > > why would it need to?  It makes me suspect that mdev is being used to
> > > bypass the hypervisor, or maybe fill in the gaps for hardware that
> > > isn't as "mediation friendly" as it claims to be.
> >
> > We do have one such example on Intel GPU. To support direct cmd
> > submission from userspace (SVA), kernel driver allocates a doorbell
> > page (in system memory) for each application and then registers
> > the page to the GPU. Once the doorbell is armed, the GPU starts
> > to monitor CPU writes to that page. Then the application can ring the
> > GPU by simply writing to the doorbell page to submit cmds. This
> > possibly makes sense only for integrated devices.
> >
> > In case that direction submission is not allowed in mediated device
> > (some auditing work is required in GVT-g), we need to write-protect
> > the doorbell page with hypervisor help to mimic the hardware
> > behavior. We have prototype work internally, but hasn't sent it out.
>=20
> What would it look like for QEMU to orchestrate this?  Maybe the mdev
> device could expose a doorbell page as a device specific region.
> Possibly a quirk in QEMU vfio-pci could detect the guest driver
> registering a doorbell (or vendor driver could tell QEMU via a device
> specific interrupt) and setup a MemoryRegion overlay of the doorbell
> page in the guest.  If the physical GPU has the resources, maybe the
> doorbell page is real, otherwise it could be emulated in the vendor
> driver.  Trying to do this without QEMU seems to be where we're running
> into trouble and is what I'd classify as bypassing the hypervisor.

en, let's think about this approach. We are used to solving all the
problems in kernel (thus deeply relying on what VFIO affords). It
would be a different story by offloading some mediation knowledge=20
to userspace. This is possibly fine for doorbell virtualization, as its
registration interface is not complex. But it may not work well for
device page table shadowing. It's hard to split this knowledge=20
between user/kernel, while simply notifying Qemu to request=20
write-protection is likely slow. But as said, this is a good direction
for further study. :-)

>=20
> > > In the case of a physical device discovering an iova translation, thi=
s
> > > is what device iotlbs are for, but as an acceleration and offload
> > > mechanism for the system iommu rather than a lookup mechanism as
> > > seems
> > > to be wanted here.  If we had a system iommu with dirty page tracking=
,
> > > I believe that tracking would live in the iommu page tables and
> > > therefore reflect dirty pages relative to iova.  We'd need to consume
> > > those dirty page bits before we tear down the iova mappings, much lik=
e
> > > we're suggesting QEMU do here.
> >
> > Yes. There are two cases:
> >
> > 1) iova shadowing. Say using only 2nd level as today. Here the dirty
> > bits are associated to iova. When Qemu is revised to invoke log_sync
> > before tearing down any iova mapping, vfio can get the dirty info
> > from iommu driver for affected range.
>=20
> Maybe we need two mechanisms, log_sync for the "occasional" polling of
> dirty bits and an UNMAP_DMA ioctl extension that allows the user to
> provide a buffer into which the unmap ioctl would set dirty bits.
> Userspace could potentially chunk MAP/UNMAP_DMA calls in order to
> bound
> the size of the bitmap buffer (modulo the difficulties of assuming
> physical page alignment).  The QEMU vfio-pci driver would then perform
> the translation and mark the GPA pages dirty.  Seems that might relieve
> your efficiency concerns.  The unpin path and unpin notifier would need

yes, this approach can fix my concern. It carries the dirty info
in existing syscalls thus is much better than tying to the migration
region interface.

> to relay dirty info for mdev support, where a generic implementation
> might simply assume everything that has been or is currently pinned by
> mdev is dirty.
>=20
> Now I'm wondering if we should be consolidating vfio dirty page
> tracking per container rather than per device if we do something like
> this...

I sort of agree. UNMAP_DMA is per container by definition. If
we continue to keep log_sync path per device (through migration
region), it looks inconsistent. Possibly we should just keep the
migration region solely for poking the device state, while leaving
dirty page tracking through the container interface.

>=20
> > 2) iova nesting, where iova->gpa is in 1st level and gpa->hpa is in
> > 2nd level. In that case the iova carried in the map/unmap ioctl is
> > actually gpa, thus the dirty bits are associated to gpa. In such case,
> > Qemu should continue to consume gpa-based dirty bitmap, as if
> > viommu is disabled.
>=20
> Seems again that it's QEMU that really knows which AddressSpace that
> the kernel vfio is operating in and how to apply it to a dirty bitmap.
>=20
> > > Unfortunately I also think that KVM and vhost are not really the best
> > > examples of what we need to do for vfio.  KVM is intimately involved
> > > with GPAs, so clearly dirty page tracking at that level is not an
> > > issue.  Vhost tends to circumvent the viommu; it's trying to poke
> > > directly into guest memory without the help of a physical iommu.  So
> > > I can't say that I have much faith that QEMU is already properly wire=
d
> > > with respect to viommu and dirty page tracking, leaving open the
> > > possibility that a log_sync on iommu region unmap is simply a gap in
> > > the QEMU migration story.  The vfio migration interface we have on th=
e
> > > table seems like it could work, but QEMU needs an update and we need
> to
> > > define the interface in terms of pfns relative to the address space.
> >
> > Yan and I did a brief discussion on this. Besides the basic change of
> > doing log_sync for every iova unmap, there are two others gaps to
> > be fixed:
> >
> > 1) Today the iova->gpa mapping is maintained in two places: viommu
> > page table in guest memory and viotlb in Qemu. viotlb is filled when
> > a walk on the viommu page table happens, due to emulation of a virtual
> > DMA operation from emulated devices or request from vhost devices.
> > It's not affected by passthrough device activities though, since the la=
tter
> > goes through physical iommu. Per iommu spec, guest iommu driver
> > first clears the viommu page table, followed by viotlb invalidation
> > request. It's the latter being trapped by Qemu, then vfio is notified
> > at that point, where iova->gpa translation will simply fail since no
> > valid mapping in viommu page table and very likely no hit in viotlb.
> > To fix this gap, we need extend Qemu to cache all the valid iova
> > mappings in viommu page table, similar to how vfio does.
> >
> > 2) Then there will be parallel log_sync requests on each vfio device.
> > One is from the vcpu thread, when iotlb invalidation request is being
> > emulated. The other is from the migration thread, where log_sync is
> > requested for the entire guest memory in iterative copies. The
> > contention among multiple vCPU threads is already protected through
> > iommu lock, but we didn't find such thing between migration thread
> > and vcpu threads. Maybe we overlooked something, but ideally the
> > whole iova address space should be locked when the migration thread
> > is doing mega-sync/translation.
> >
> > +Yi and Peter for their opinions.
>=20
> Good points, not sure I have anything to add to that.  As above, we can
> think about whether the device or the container is the right place to
> do dirty page tracking.

Sure. And above two points are orthogonal to whether doing it
in container or device level. We haven't got time to continue the
investigation since last post. will resume after KVM forum.

>=20
> > > If GPAs are still needed, what are they for?  The write-protect examp=
le
> > > is clearly a hypervisor level interaction as I assume it's write
> > > protection relative to the vCPU.  It's a hypervisor specific interfac=
e
> > > to perform that write-protection, so why wouldn't we use a hypervisor
> > > specific interface to collect the data to perform that operation?
> > > IOW, if GVT-g already has a KVM dependency, why be concerned about
> > > adding another GVT-g KVM dependency?  It seems like vfio is just a
> >
> > This is possibly the way that we have to go, based on discussions
> > so far. Earlier I just hold the same argument as you emphasized
> > for vfio - although there are existing KVM dependencies, we want
> > minimize it. :-) Another worry is what if other vendor drivers may
> > have similar requirements, then can we invent some generic ways
> > thus avoid pushing them to do same tricky thing again. Of course,
> > we may revisit it later until this issue does become a common
> > requirement.
>=20
> I know we don't see quite the same on the degree to which vfio has KVM
> dependencies, but it's possible, and regularly done, to use vfio without
> KVM.  The same cannot be said of GVT-g.  Therefore it's not very
> motivating for me to entertain a proposal for a new vfio interface
> whose main purpose is to fill in a gap in the already existing GVT-g
> dependency on KVM (and in no way reduce that existing KVM dependency).
> I maintain vfio's lack of dependencies on KVM either way ;)

Understand.

>=20
> > > potentially convenient channel, but as discussed above, vfio has no
> > > business in GPAs because devices don't operate on GPAs and I've not
> > > been sold that there's value in vfio getting involved in that
> > > address space.  Convince me otherwise ;)  Thanks,
> > >
> >
> > Looks none of my arguments is convincible to you :-), so we move
> > to investigate what should be changed in qemu to support your
> > proposal (as discussed above). While this part is on-going, let me
> > have a last try on my original idea. ;) Just be curious how your
> > further thought is, regarding to earlier doorbell monitoring
> > example for operating GPA on device. If it's just Intel GPU only
> > thing, yes we can still fix it in GVT-g itself as you suggested. But
> > I'm just not sure about other integrated devices, and also new
> > accelerators with coherent bus connected to cpu package. Also we
> > don't need call it GPA - it could be named as user_target_address
> > that the iova is mapped to, and is the address space that userspace
> > expects the device to operate for purposes (logging, monitoring,
> > etc.) other than for dma (using iova) and for accessing
> > userspace/guest memory (hva).
>=20
> My impression of the doorbell example is that we're taking the wrong
> approach to solving how that interaction should work.  To setup an
> interaction between a device and a vCPU, we should be going through
> QEMU.  This is the model we've used from the start with vfio.  KVM is
> an accelerator, but it's up to QEMU to connect KVM and vfio together.
> I'm curious if there's any merit to my proposal above about how this
> could be redesigned.  Thanks,
>=20

There are merits for sure. We will explore that direction and see how
it works. Even if still some extension required between QEMU and KVM
(in case of functionality or efficiency concern), that might be better
fitted than extending VFIO.

Thanks
Kevin

