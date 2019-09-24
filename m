Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B781C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 23:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC6C1207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 23:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6C1207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtux-00030X-Jl
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 19:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1iCtrH-00078T-24
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 19:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1iCtrD-0001er-To
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 19:04:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:5781)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1iCtrD-0001dN-JP
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 19:04:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Sep 2019 16:04:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,545,1559545200"; d="scan'208";a="340231352"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by orsmga004.jf.intel.com with ESMTP; 24 Sep 2019 16:04:25 -0700
Received: from fmsmsx123.amr.corp.intel.com (10.18.125.38) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Sep 2019 16:04:25 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 fmsmsx123.amr.corp.intel.com (10.18.125.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Sep 2019 16:04:24 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.32]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.86]) with mapi id 14.03.0439.000;
 Wed, 25 Sep 2019 07:04:23 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v8 01/13] vfio: KABI for migration interface
Thread-Topic: [PATCH v8 01/13] vfio: KABI for migration interface
Thread-Index: AQHVXEPM6Ds11z4g1kGhkyVJXk+n4qcQheKAgAKxOUCAABvDkIAAD6EAgAYgQnCADi7SAIABCiGQgBGEuYCAAIWfAIAA2CrQ
Date: Tue, 24 Sep 2019 23:04:22 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D58EA38@SHSMSX104.ccr.corp.intel.com>
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
In-Reply-To: <20190924120318.04696187@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjgxOTA2YzgtZDk1ZS00Yjc0LTk0YmUtNWE4MTE2YWY2NGNlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZEJHNEVxQ0dKVHZHazhHVE4ydFJ2SEdoY3h2UzR4aVVtbEppYytzSTFodUdackQrSUl3VXRGTDRmdCtMY2FiaSJ9
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

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Wednesday, September 25, 2019 2:03 AM
>=20
> On Tue, 24 Sep 2019 02:19:15 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
>=20
> > > From: Tian, Kevin
> > > Sent: Friday, September 13, 2019 7:00 AM
> > >
> > > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > > Sent: Thursday, September 12, 2019 10:41 PM
> > > >
> > > > On Tue, 3 Sep 2019 06:57:27 +0000
> > > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > >
> > > > > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > > > > Sent: Saturday, August 31, 2019 12:33 AM
> > > > > >
> > > > > > On Fri, 30 Aug 2019 08:06:32 +0000
> > > > > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > > > >
> > > > > > > > From: Tian, Kevin
> > > > > > > > Sent: Friday, August 30, 2019 3:26 PM
> > > > > > > >
> > > > > > > [...]
> > > > > > > > > How does QEMU handle the fact that IOVAs are potentially
> > > > dynamic
> > > > > > while
> > > > > > > > > performing the live portion of a migration?  For example,
> each
> > > > time a
> > > > > > > > > guest driver calls dma_map_page() or dma_unmap_page(), a
> > > > > > > > > MemoryRegionSection pops in or out of the AddressSpace fo=
r
> > > the
> > > > device
> > > > > > > > > (I'm assuming a vIOMMU where the device AddressSpace is
> not
> > > > > > > > > system_memory).  I don't see any QEMU code that intercept=
s
> > > that
> > > > > > change
> > > > > > > > > in the AddressSpace such that the IOVA dirty pfns could b=
e
> > > > recorded and
> > > > > > > > > translated to GFNs.  The vendor driver can't track these
> beyond
> > > > getting
> > > > > > > > > an unmap notification since it only knows the IOVA pfns,
> which
> > > > can be
> > > > > > > > > re-used with different GFN backing.  Once the DMA mapping
> is
> > > > torn
> > > > > > down,
> > > > > > > > > it seems those dirty pfns are lost in the ether.  If this=
 works in
> > > > QEMU,
> > > > > > > > > please help me find the code that handles it.
> > > > > > > >
> > > > > > > > I'm curious about this part too. Interestingly, I didn't fi=
nd any
> > > > log_sync
> > > > > > > > callback registered by emulated devices in Qemu. Looks dirt=
y
> > > pages
> > > > > > > > by emulated DMAs are recorded in some implicit way. But KVM
> > > > always
> > > > > > > > reports dirty page in GFN instead of IOVA, regardless of th=
e
> > > > presence of
> > > > > > > > vIOMMU. If Qemu also tracks dirty pages in GFN for emulated
> > > DMAs
> > > > > > > >  (translation can be done when DMA happens), then we don't
> > > need
> > > > > > > > worry about transient mapping from IOVA to GFN. Along this
> way
> > > > we
> > > > > > > > also want GFN-based dirty bitmap being reported through VFI=
O,
> > > > > > > > similar to what KVM does. For vendor drivers, it needs to
> translate
> > > > > > > > from IOVA to HVA to GFN when tracking DMA activities on
> VFIO
> > > > > > > > devices. IOVA->HVA is provided by VFIO. for HVA->GFN, it ca=
n
> be
> > > > > > > > provided by KVM but I'm not sure whether it's exposed now.
> > > > > > > >
> > > > > > >
> > > > > > > HVA->GFN can be done through hva_to_gfn_memslot in
> kvm_host.h.
> > > > > >
> > > > > > I thought it was bad enough that we have vendor drivers that
> depend
> > > > on
> > > > > > KVM, but designing a vfio interface that only supports a KVM
> interface
> > > > > > is more undesirable.  I also note without comment that
> > > > gfn_to_memslot()
> > > > > > is a GPL symbol.  Thanks,
> > > > >
> > > > > yes it is bad, but sometimes inevitable. If you recall our discus=
sions
> > > > > back to 3yrs (when discussing the 1st mdev framework), there were
> > > > similar
> > > > > hypervisor dependencies in GVT-g, e.g. querying gpa->hpa when
> > > > > creating some shadow structures. gpa->hpa is definitely hyperviso=
r
> > > > > specific knowledge, which is easy in KVM (gpa->hva->hpa), but
> needs
> > > > > hypercall in Xen. but VFIO already makes assumption based on
> KVM-
> > > > > only flavor when implementing vfio_{un}pin_page_external.
> > > >
> > > > Where's the KVM assumption there?  The MAP_DMA ioctl takes an
> IOVA
> > > > and
> > > > HVA.  When an mdev vendor driver calls vfio_pin_pages(), we GUP the
> > > HVA
> > > > to get an HPA and provide an array of HPA pfns back to the caller. =
 The
> > > > other vGPU mdev vendor manages to make use of this without KVM...
> the
> > > > KVM interface used by GVT-g is GPL-only.
> > >
> > > To be clear it's the assumption on the host-based hypervisors e.g. KV=
M.
> > > GUP is a perfect example, which doesn't work for Xen since DomU's
> > > memory doesn't belong to Dom0. VFIO in Dom0 has to find the HPA
> > > through Xen specific hypercalls.
> > >
> > > >
> > > > > So GVT-g
> > > > > has to maintain an internal abstraction layer to support both Xen
> and
> > > > > KVM. Maybe someday we will re-consider introducing some
> hypervisor
> > > > > abstraction layer in VFIO, if this issue starts to hurt other dev=
ices
> and
> > > > > Xen guys are willing to support VFIO.
> > > >
> > > > Once upon a time, we had a KVM specific device assignment interface=
,
> > > > ie. legacy KVM devie assignment.  We developed VFIO specifically to
> get
> > > > KVM out of the business of being a (bad) device driver.  We do have
> > > > some awareness and interaction between VFIO and KVM in the vfio-
> kvm
> > > > pseudo device, but we still try to keep those interfaces generic.  =
In
> > > > some cases we're not very successful at that, see
> vfio_group_set_kvm(),
> > > > but that's largely just a mechanism to associate a cookie with a gr=
oup
> > > > to be consumed by the mdev vendor driver such that it can work with
> > > kvm
> > > > external to vfio.  I don't intend to add further hypervisor awarene=
ss
> > > > to vfio.
> > > >
> > > > > Back to this IOVA issue, I discussed with Yan and we found anothe=
r
> > > > > hypervisor-agnostic alternative, by learning from vhost. vhost is=
 very
> > > > > similar to VFIO - DMA also happens in the kernel, while it alread=
y
> > > > > supports vIOMMU.
> > > > >
> > > > > Generally speaking, there are three paths of dirty page collectio=
n
> > > > > in Qemu so far (as previously noted, Qemu always tracks the dirty
> > > > > bitmap in GFN):
> > > >
> > > > GFNs or simply PFNs within an AddressSpace?
> > > >
> > > > > 1) Qemu-tracked memory writes (e.g. emulated DMAs). Dirty
> bitmaps
> > > > > are updated directly when the guest memory is being updated. For
> > > > > example, PCI writes are completed through pci_dma_write, which
> > > > > goes through vIOMMU to translate IOVA into GPA and then update
> > > > > the bitmap through cpu_physical_memory_set_dirty_range.
> > > >
> > > > Right, so the IOVA to GPA (GFN) occurs through an explicit translat=
ion
> > > > on the IOMMU AddressSpace.
> > > >
> > > > > 2) Memory writes that are not tracked by Qemu are collected by
> > > > > registering .log_sync() callback, which is invoked in the dirty l=
ogging
> > > > > process. Now there are two users: kvm and vhost.
> > > > >
> > > > >   2.1) KVM tracks CPU-side memory writes, through write-protectio=
n
> > > > > or EPT A/D bits (+PML). This part is always based on GFN and
> returned
> > > > > to Qemu when kvm_log_sync is invoked;
> > > > >
> > > > >   2.2) vhost tracks kernel-side DMA writes, by interpreting vring
> > > > > data structure. It maintains an internal iotlb which is synced wi=
th
> > > > > Qemu vIOMMU through a specific interface:
> > > > > 	- new vhost message type (VHOST_IOTLB_UPDATE/INVALIDATE)
> > > > > for Qemu to keep vhost iotlb in sync
> > > > > 	- new VHOST_IOTLB_MISS message to notify Qemu in case of
> > > > > a miss in vhost iotlb.
> > > > > 	- Qemu registers a log buffer to kernel vhost driver. The latter
> > > > > update the buffer (using internal iotlb to get GFN) when serving
> vring
> > > > > descriptor.
> > > > >
> > > > > VFIO could also implement an internal iotlb, so vendor drivers ca=
n
> > > > > utilize the iotlb to update the GFN-based dirty bitmap. Ideally w=
e
> > > > > don't need re-invent another iotlb protocol as vhost does. vIOMMU
> > > > > already sends map/unmap ioctl cmds upon any change of IOVA
> > > > > mapping. We may introduce a v2 map/unmap interface, allowing
> > > > > Qemu to pass both {iova, gpa, hva} together to keep internal iotl=
b
> > > > > in-sync. But we may also need a iotlb_miss_upcall interface, if V=
FIO
> > > > > doesn't want to cache full-size vIOMMU mappings.
> > > > >
> > > > > Definitely this alternative needs more work and possibly less
> > > > > performant (if maintaining a small size iotlb) than straightforwa=
rd
> > > > > calling into KVM interface. But the gain is also obvious, since i=
t
> > > > > is fully constrained with VFIO.
> > > > >
> > > > > Thoughts? :-)
> > > >
> > > > So vhost must then be configuring a listener across system memory
> > > > rather than only against the device AddressSpace like we do in vfio=
,
> > > > such that it get's log_sync() callbacks for the actual GPA space ra=
ther
> > > > than only the IOVA space.  OTOH, QEMU could understand that the
> > > device
> > > > AddressSpace has a translate function and apply the IOVA dirty bits=
 to
> > > > the system memory AddressSpace.  Wouldn't it make more sense for
> > > > QEMU
> > > > to perform a log_sync() prior to removing a MemoryRegionSection
> within
> > > > an AddressSpace and update the GPA rather than pushing GPA
> > > awareness
> > > > and potentially large tracking structures into the host kernel?  Th=
anks,
> > > >
> > >
> >
> > Hi, Alex,
> >
> > I moved back the VFIO related discussion to this thread, to not mix wit=
h
> > vhost related discussions here.
> >
> > https://lists.nongnu.org/archive/html/qemu-devel/2019-
> 09/msg03126.html
> >
> > Your latest reply still prefers to the userspace approach:
> >
> > > > Same as last time, you're asking VFIO to be aware of an entirely ne=
w
> > > > address space and implement tracking structures of that address
> space
> > > > to make life easier for QEMU.  Don't we typically push such complex=
ity
> > > > to userspace rather than into the kernel?  I'm not convinced.  Than=
ks,
> > > >
> >
> > I answered two points but didn't hear your further thoughts. Can you
> > take a look and respond?
> >
> > The first point is about complexity and performance:
> > >
> > > Is it really complex? No need of a new tracking structure. Just allow=
ing
> > > the MAP interface to carry a new parameter and then record it in the
> > > existing vfio_dma objects.
> > >
> > > Note the frequency of guest DMA map/unmap could be very high. We
> > > saw >100K invocations per second with a 40G NIC. To do the right
> > > translation Qemu requires log_sync for every unmap, before the
> > > mapping for logged dirty IOVA becomes stale. In current Kirti's patch=
,
> > > each log_sync requires several system_calls through the migration
> > > info, e.g. setting start_pfn/page_size/total_pfns and then reading
> > > data_offset/data_size. That design is fine for doing log_sync in ever=
y
> > > pre-copy round, but too costly if doing so for every IOVA unmap. If
> > > small extension in kernel can lead to great overhead reduction,
> > > why not?
>=20
> You're citing a workload that already performs abysmally with vfio and
> vIOMMU, we cannot handle those rates efficiently with the current vfio
> DMA API.  The current use cases of vIOMMU and vfio are predominantly
> for nesting vfio, ex. DPDK/SPDK, where we assume the mappings are
> relatively static or else performance problems are already very
> apparent.  In that sort of model, I don't see that QEMU doing a
> log_sync on unmap is really an issue, unmaps should be relatively
> rare.  Of course I don't want to compound the issue, but the current
> vfio DMA mapping interfaces needs to be scrapped to make this remotely
> performant even before we look at migration performance, so does it
> really make sense to introduce GPAs for a workload the ioctls are
> unsuited for?
>=20
> > The second point is about write-protection:
> >
> > > There is another value of recording GPA in VFIO. Vendor drivers
> > > (e.g. GVT-g) may need to selectively write-protect guest memory
> > > pages when interpreting certain workload descriptors. Those pages
> > > are recorded in IOVA when vIOMMU is enabled, however the KVM
> > > write-protection API only knows GPA. So currently vIOMMU must
> > > be disabled on Intel vGPUs when GVT-g is enabled. To make it working
> > > we need a way to translate IOVA into GPA in the vendor drivers.
> > > There are two options. One is having KVM export a new API for such
> > > translation purpose. But as you explained earlier it's not good to
> > > have vendor drivers depend on KVM. The other is having VFIO
> > > maintaining such knowledge through extended MAP interface,
> > > then providing a uniform API for all vendor drivers to use.
>=20
> So the argument is that in order to interact with KVM (write protecting
> guest memory) there's a missing feature (IOVA to GPA translation), but
> we don't want to add an API to KVM for this feature because that would
> create a dependency on KVM (for interacting with KVM), so lets add an
> API to vfio instead.  That makes no sense to me.  What am I missing?
> Thanks,
>=20

Then do you have a recommendation how such feature can be=20
implemented cleanly in vendor driver, without introducing direct
dependency on KVM?=20

Thanks
Kevin

