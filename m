Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E9AC3A5A5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 06:58:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09A1206B8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 06:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09A1206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i52lu-0002G9-0S
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 02:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1i52l0-0001qB-6U
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 02:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1i52kx-00071Q-W0
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 02:57:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:60247)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1i52kx-00070H-OA
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 02:57:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Sep 2019 23:57:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,462,1559545200"; d="scan'208";a="194253034"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga002.jf.intel.com with ESMTP; 02 Sep 2019 23:57:30 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Sep 2019 23:57:30 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Sep 2019 23:57:30 -0700
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Sep 2019 23:57:29 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.32]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.89]) with mapi id 14.03.0439.000;
 Tue, 3 Sep 2019 14:57:28 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Thread-Topic: [PATCH v8 01/13] vfio: KABI for migration interface
Thread-Index: AQHVXEPM6Ds11z4g1kGhkyVJXk+n4qcQheKAgAKxOUCAABvDkIAAD6EAgAYgQnA=
Date: Tue, 3 Sep 2019 06:57:27 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D560D74@SHSMSX104.ccr.corp.intel.com>
References: <1566845753-18993-1-git-send-email-kwankhede@nvidia.com>
 <1566845753-18993-2-git-send-email-kwankhede@nvidia.com>
 <20190828145045.20f2a7b3@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D553133@SHSMSX104.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D553184@SHSMSX104.ccr.corp.intel.com>
 <20190830103252.2b427144@x1.home>
In-Reply-To: <20190830103252.2b427144@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2QzYWRhZDYtYTdmZi00Y2U0LWExZGItNmI2NmZhZWIyODFkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWUpCVmQxSEdKa2ozMjVSbVlEVHVZVXlLbStQOU40QWJJSUtLRDdqVUV6NHREUFY1MGNDbXhZczRFSldHR0xDWiJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
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
> Sent: Saturday, August 31, 2019 12:33 AM
>=20
> On Fri, 30 Aug 2019 08:06:32 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
>=20
> > > From: Tian, Kevin
> > > Sent: Friday, August 30, 2019 3:26 PM
> > >
> > [...]
> > > > How does QEMU handle the fact that IOVAs are potentially dynamic
> while
> > > > performing the live portion of a migration?  For example, each time=
 a
> > > > guest driver calls dma_map_page() or dma_unmap_page(), a
> > > > MemoryRegionSection pops in or out of the AddressSpace for the devi=
ce
> > > > (I'm assuming a vIOMMU where the device AddressSpace is not
> > > > system_memory).  I don't see any QEMU code that intercepts that
> change
> > > > in the AddressSpace such that the IOVA dirty pfns could be recorded=
 and
> > > > translated to GFNs.  The vendor driver can't track these beyond get=
ting
> > > > an unmap notification since it only knows the IOVA pfns, which can =
be
> > > > re-used with different GFN backing.  Once the DMA mapping is torn
> down,
> > > > it seems those dirty pfns are lost in the ether.  If this works in =
QEMU,
> > > > please help me find the code that handles it.
> > >
> > > I'm curious about this part too. Interestingly, I didn't find any log=
_sync
> > > callback registered by emulated devices in Qemu. Looks dirty pages
> > > by emulated DMAs are recorded in some implicit way. But KVM always
> > > reports dirty page in GFN instead of IOVA, regardless of the presence=
 of
> > > vIOMMU. If Qemu also tracks dirty pages in GFN for emulated DMAs
> > >  (translation can be done when DMA happens), then we don't need
> > > worry about transient mapping from IOVA to GFN. Along this way we
> > > also want GFN-based dirty bitmap being reported through VFIO,
> > > similar to what KVM does. For vendor drivers, it needs to translate
> > > from IOVA to HVA to GFN when tracking DMA activities on VFIO
> > > devices. IOVA->HVA is provided by VFIO. for HVA->GFN, it can be
> > > provided by KVM but I'm not sure whether it's exposed now.
> > >
> >
> > HVA->GFN can be done through hva_to_gfn_memslot in kvm_host.h.
>=20
> I thought it was bad enough that we have vendor drivers that depend on
> KVM, but designing a vfio interface that only supports a KVM interface
> is more undesirable.  I also note without comment that gfn_to_memslot()
> is a GPL symbol.  Thanks,

yes it is bad, but sometimes inevitable. If you recall our discussions
back to 3yrs (when discussing the 1st mdev framework), there were similar
hypervisor dependencies in GVT-g, e.g. querying gpa->hpa when
creating some shadow structures. gpa->hpa is definitely hypervisor
specific knowledge, which is easy in KVM (gpa->hva->hpa), but needs
hypercall in Xen. but VFIO already makes assumption based on KVM-
only flavor when implementing vfio_{un}pin_page_external. So GVT-g
has to maintain an internal abstraction layer to support both Xen and
KVM. Maybe someday we will re-consider introducing some hypervisor
abstraction layer in VFIO, if this issue starts to hurt other devices and
Xen guys are willing to support VFIO.

Back to this IOVA issue, I discussed with Yan and we found another=20
hypervisor-agnostic alternative, by learning from vhost. vhost is very
similar to VFIO - DMA also happens in the kernel, while it already=20
supports vIOMMU.

Generally speaking, there are three paths of dirty page collection
in Qemu so far (as previously noted, Qemu always tracks the dirty
bitmap in GFN):

1) Qemu-tracked memory writes (e.g. emulated DMAs). Dirty bitmaps=20
are updated directly when the guest memory is being updated. For=20
example, PCI writes are completed through pci_dma_write, which=20
goes through vIOMMU to translate IOVA into GPA and then update=20
the bitmap through cpu_physical_memory_set_dirty_range.

2) Memory writes that are not tracked by Qemu are collected by
registering .log_sync() callback, which is invoked in the dirty logging
process. Now there are two users: kvm and vhost.

  2.1) KVM tracks CPU-side memory writes, through write-protection
or EPT A/D bits (+PML). This part is always based on GFN and returned
to Qemu when kvm_log_sync is invoked;

  2.2) vhost tracks kernel-side DMA writes, by interpreting vring
data structure. It maintains an internal iotlb which is synced with
Qemu vIOMMU through a specific interface:
	- new vhost message type (VHOST_IOTLB_UPDATE/INVALIDATE)
for Qemu to keep vhost iotlb in sync
	- new VHOST_IOTLB_MISS message to notify Qemu in case of
a miss in vhost iotlb.
	- Qemu registers a log buffer to kernel vhost driver. The latter
update the buffer (using internal iotlb to get GFN) when serving vring
descriptor.

VFIO could also implement an internal iotlb, so vendor drivers can
utilize the iotlb to update the GFN-based dirty bitmap. Ideally we
don't need re-invent another iotlb protocol as vhost does. vIOMMU
already sends map/unmap ioctl cmds upon any change of IOVA
mapping. We may introduce a v2 map/unmap interface, allowing
Qemu to pass both {iova, gpa, hva} together to keep internal iotlb
in-sync. But we may also need a iotlb_miss_upcall interface, if VFIO
doesn't want to cache full-size vIOMMU mappings.=20

Definitely this alternative needs more work and possibly less=20
performant (if maintaining a small size iotlb) than straightforward
calling into KVM interface. But the gain is also obvious, since it
is fully constrained with VFIO.

Thoughts? :-)

Thanks
Kevin

>=20
> Alex
>=20
> > Above flow works for software-tracked dirty mechanism, e.g. in
> > KVMGT, where GFN-based 'dirty' is marked when a guest page is
> > mapped into device mmu. IOVA->HPA->GFN translation is done
> > at that time, thus immune from further IOVA->GFN changes.
> >
> > When hardware IOMMU supports D-bit in 2nd level translation (e.g.
> > VT-d rev3.0), there are two scenarios:
> >
> > 1) nested translation: guest manages 1st-level translation (IOVA->GPA)
> > and host manages 2nd-level translation (GPA->HPA). The 2nd-level
> > is not affected by guest mapping operations. So it's OK for IOMMU
> > driver to retrieve GFN-based dirty pages by directly scanning the 2nd-
> > level structure, upon request from user space.
> >
> > 2) shadowed translation (IOVA->HPA) in 2nd level: in such case the dirt=
y
> > information is tied to IOVA. the IOMMU driver is expected to maintain
> > an internal dirty bitmap. Upon any change of IOVA->GPA notification
> > from VFIO, the IOMMU driver should flush dirty status of affected 2nd-l=
evel
> > entries to the internal GFN-based bitmap. At this time, again IOVA->HVA
> > ->GPA translation required for GFN-based recording. When userspace
> > queries dirty bitmap, the IOMMU driver needs to flush latest 2nd-level
> > dirty status to internal bitmap, which is then copied to user space.
> >
> > Given the trickiness of 2), we aim to enable 1) on intel-iommu driver.
> >
> > Thanks
> > Kevin


