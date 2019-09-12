Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F4BC4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 23:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A2EE20684
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 23:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2EE20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Y5n-0004Xh-3R
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 19:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1i8Y4Y-0003kZ-E6
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 19:00:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1i8Y4V-00057G-V4
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 19:00:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:3955)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1i8Y4V-00050L-NJ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 19:00:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Sep 2019 16:00:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; d="scan'208";a="386213574"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga006.fm.intel.com with ESMTP; 12 Sep 2019 16:00:06 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Sep 2019 16:00:06 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Sep 2019 16:00:05 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.32]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.86]) with mapi id 14.03.0439.000;
 Fri, 13 Sep 2019 07:00:04 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Thread-Topic: [PATCH v8 01/13] vfio: KABI for migration interface
Thread-Index: AQHVXEPM6Ds11z4g1kGhkyVJXk+n4qcQheKAgAKxOUCAABvDkIAAD6EAgAYgQnCADi7SAIABCiGQ
Date: Thu, 12 Sep 2019 23:00:03 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D572135@SHSMSX104.ccr.corp.intel.com>
References: <1566845753-18993-1-git-send-email-kwankhede@nvidia.com>
 <1566845753-18993-2-git-send-email-kwankhede@nvidia.com>
 <20190828145045.20f2a7b3@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D553133@SHSMSX104.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D553184@SHSMSX104.ccr.corp.intel.com>
 <20190830103252.2b427144@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D560D74@SHSMSX104.ccr.corp.intel.com>
 <20190912154106.4e784906@x1.home>
In-Reply-To: <20190912154106.4e784906@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWRiYzk4ZDYtNGY0Mi00MTA3LTljOTAtZGZhYmUxMTY2YTljIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiajJNZWV6aXA1Z0w0eHJRZkdWNFA3dThMTzNTTzNKc0JTQkJjOGYxSTRHOTF0TWZmYnFGWEY4S1NZRXR3c01haiJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
Subject: Re: [Qemu-devel] [PATCH v8 01/13] vfio: KABI for migration interface
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
> Sent: Thursday, September 12, 2019 10:41 PM
>=20
> On Tue, 3 Sep 2019 06:57:27 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
>=20
> > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > Sent: Saturday, August 31, 2019 12:33 AM
> > >
> > > On Fri, 30 Aug 2019 08:06:32 +0000
> > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > >
> > > > > From: Tian, Kevin
> > > > > Sent: Friday, August 30, 2019 3:26 PM
> > > > >
> > > > [...]
> > > > > > How does QEMU handle the fact that IOVAs are potentially
> dynamic
> > > while
> > > > > > performing the live portion of a migration?  For example, each
> time a
> > > > > > guest driver calls dma_map_page() or dma_unmap_page(), a
> > > > > > MemoryRegionSection pops in or out of the AddressSpace for the
> device
> > > > > > (I'm assuming a vIOMMU where the device AddressSpace is not
> > > > > > system_memory).  I don't see any QEMU code that intercepts that
> > > change
> > > > > > in the AddressSpace such that the IOVA dirty pfns could be
> recorded and
> > > > > > translated to GFNs.  The vendor driver can't track these beyond
> getting
> > > > > > an unmap notification since it only knows the IOVA pfns, which
> can be
> > > > > > re-used with different GFN backing.  Once the DMA mapping is
> torn
> > > down,
> > > > > > it seems those dirty pfns are lost in the ether.  If this works=
 in
> QEMU,
> > > > > > please help me find the code that handles it.
> > > > >
> > > > > I'm curious about this part too. Interestingly, I didn't find any
> log_sync
> > > > > callback registered by emulated devices in Qemu. Looks dirty page=
s
> > > > > by emulated DMAs are recorded in some implicit way. But KVM
> always
> > > > > reports dirty page in GFN instead of IOVA, regardless of the
> presence of
> > > > > vIOMMU. If Qemu also tracks dirty pages in GFN for emulated DMAs
> > > > >  (translation can be done when DMA happens), then we don't need
> > > > > worry about transient mapping from IOVA to GFN. Along this way
> we
> > > > > also want GFN-based dirty bitmap being reported through VFIO,
> > > > > similar to what KVM does. For vendor drivers, it needs to transla=
te
> > > > > from IOVA to HVA to GFN when tracking DMA activities on VFIO
> > > > > devices. IOVA->HVA is provided by VFIO. for HVA->GFN, it can be
> > > > > provided by KVM but I'm not sure whether it's exposed now.
> > > > >
> > > >
> > > > HVA->GFN can be done through hva_to_gfn_memslot in kvm_host.h.
> > >
> > > I thought it was bad enough that we have vendor drivers that depend
> on
> > > KVM, but designing a vfio interface that only supports a KVM interfac=
e
> > > is more undesirable.  I also note without comment that
> gfn_to_memslot()
> > > is a GPL symbol.  Thanks,
> >
> > yes it is bad, but sometimes inevitable. If you recall our discussions
> > back to 3yrs (when discussing the 1st mdev framework), there were
> similar
> > hypervisor dependencies in GVT-g, e.g. querying gpa->hpa when
> > creating some shadow structures. gpa->hpa is definitely hypervisor
> > specific knowledge, which is easy in KVM (gpa->hva->hpa), but needs
> > hypercall in Xen. but VFIO already makes assumption based on KVM-
> > only flavor when implementing vfio_{un}pin_page_external.
>=20
> Where's the KVM assumption there?  The MAP_DMA ioctl takes an IOVA
> and
> HVA.  When an mdev vendor driver calls vfio_pin_pages(), we GUP the HVA
> to get an HPA and provide an array of HPA pfns back to the caller.  The
> other vGPU mdev vendor manages to make use of this without KVM... the
> KVM interface used by GVT-g is GPL-only.

To be clear it's the assumption on the host-based hypervisors e.g. KVM.
GUP is a perfect example, which doesn't work for Xen since DomU's
memory doesn't belong to Dom0. VFIO in Dom0 has to find the HPA
through Xen specific hypercalls.

>=20
> > So GVT-g
> > has to maintain an internal abstraction layer to support both Xen and
> > KVM. Maybe someday we will re-consider introducing some hypervisor
> > abstraction layer in VFIO, if this issue starts to hurt other devices a=
nd
> > Xen guys are willing to support VFIO.
>=20
> Once upon a time, we had a KVM specific device assignment interface,
> ie. legacy KVM devie assignment.  We developed VFIO specifically to get
> KVM out of the business of being a (bad) device driver.  We do have
> some awareness and interaction between VFIO and KVM in the vfio-kvm
> pseudo device, but we still try to keep those interfaces generic.  In
> some cases we're not very successful at that, see vfio_group_set_kvm(),
> but that's largely just a mechanism to associate a cookie with a group
> to be consumed by the mdev vendor driver such that it can work with kvm
> external to vfio.  I don't intend to add further hypervisor awareness
> to vfio.
>=20
> > Back to this IOVA issue, I discussed with Yan and we found another
> > hypervisor-agnostic alternative, by learning from vhost. vhost is very
> > similar to VFIO - DMA also happens in the kernel, while it already
> > supports vIOMMU.
> >
> > Generally speaking, there are three paths of dirty page collection
> > in Qemu so far (as previously noted, Qemu always tracks the dirty
> > bitmap in GFN):
>=20
> GFNs or simply PFNs within an AddressSpace?
>=20
> > 1) Qemu-tracked memory writes (e.g. emulated DMAs). Dirty bitmaps
> > are updated directly when the guest memory is being updated. For
> > example, PCI writes are completed through pci_dma_write, which
> > goes through vIOMMU to translate IOVA into GPA and then update
> > the bitmap through cpu_physical_memory_set_dirty_range.
>=20
> Right, so the IOVA to GPA (GFN) occurs through an explicit translation
> on the IOMMU AddressSpace.
>=20
> > 2) Memory writes that are not tracked by Qemu are collected by
> > registering .log_sync() callback, which is invoked in the dirty logging
> > process. Now there are two users: kvm and vhost.
> >
> >   2.1) KVM tracks CPU-side memory writes, through write-protection
> > or EPT A/D bits (+PML). This part is always based on GFN and returned
> > to Qemu when kvm_log_sync is invoked;
> >
> >   2.2) vhost tracks kernel-side DMA writes, by interpreting vring
> > data structure. It maintains an internal iotlb which is synced with
> > Qemu vIOMMU through a specific interface:
> > 	- new vhost message type (VHOST_IOTLB_UPDATE/INVALIDATE)
> > for Qemu to keep vhost iotlb in sync
> > 	- new VHOST_IOTLB_MISS message to notify Qemu in case of
> > a miss in vhost iotlb.
> > 	- Qemu registers a log buffer to kernel vhost driver. The latter
> > update the buffer (using internal iotlb to get GFN) when serving vring
> > descriptor.
> >
> > VFIO could also implement an internal iotlb, so vendor drivers can
> > utilize the iotlb to update the GFN-based dirty bitmap. Ideally we
> > don't need re-invent another iotlb protocol as vhost does. vIOMMU
> > already sends map/unmap ioctl cmds upon any change of IOVA
> > mapping. We may introduce a v2 map/unmap interface, allowing
> > Qemu to pass both {iova, gpa, hva} together to keep internal iotlb
> > in-sync. But we may also need a iotlb_miss_upcall interface, if VFIO
> > doesn't want to cache full-size vIOMMU mappings.
> >
> > Definitely this alternative needs more work and possibly less
> > performant (if maintaining a small size iotlb) than straightforward
> > calling into KVM interface. But the gain is also obvious, since it
> > is fully constrained with VFIO.
> >
> > Thoughts? :-)
>=20
> So vhost must then be configuring a listener across system memory
> rather than only against the device AddressSpace like we do in vfio,
> such that it get's log_sync() callbacks for the actual GPA space rather
> than only the IOVA space.  OTOH, QEMU could understand that the device
> AddressSpace has a translate function and apply the IOVA dirty bits to
> the system memory AddressSpace.  Wouldn't it make more sense for
> QEMU
> to perform a log_sync() prior to removing a MemoryRegionSection within
> an AddressSpace and update the GPA rather than pushing GPA awareness
> and potentially large tracking structures into the host kernel?  Thanks,
>=20

It is an interesting idea.  One drawback is that log_sync might be
frequently invoked in IOVA case, but I guess the overhead is not much=20
compared to the total overhead of emulating the IOTLB invalidation.=20
Maybe other folks can better comment why this model was not=20
considered before, e.g. when vhost iotlb was introduced.

Thanks
Kevin

