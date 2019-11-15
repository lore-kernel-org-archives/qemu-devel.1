Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC93C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 05:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D1520637
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 05:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D1520637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVTth-0003NZ-JG
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 00:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1iVTsy-0002sf-TW
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 00:11:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1iVTsw-0002Se-IT
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 00:11:08 -0500
Received: from mga02.intel.com ([134.134.136.20]:53422)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1iVTsw-0002Q6-9O
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 00:11:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Nov 2019 21:10:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,307,1569308400"; d="scan'208";a="203291865"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga008.fm.intel.com with ESMTP; 14 Nov 2019 21:10:57 -0800
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 14 Nov 2019 21:10:57 -0800
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 14 Nov 2019 21:10:56 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.200]) with mapi id 14.03.0439.000;
 Fri, 15 Nov 2019 13:10:54 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, "Zhao, Yan Y"
 <yan.y.zhao@intel.com>
Subject: RE: [PATCH v9 Kernel 2/5] vfio iommu: Add ioctl defination to get
 dirty pages bitmap.
Thread-Topic: [PATCH v9 Kernel 2/5] vfio iommu: Add ioctl defination to get
 dirty pages bitmap.
Thread-Index: AQHVmX9T7ifKT6t+r02nKr4nCxrVM6eHmG0AgAFiAICAAAhOgIABfoGAgAAkaICAAF1egIAAC3KAgACYZPA=
Date: Fri, 15 Nov 2019 05:10:53 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D5F6A83@SHSMSX104.ccr.corp.intel.com>
References: <1573578220-7530-1-git-send-email-kwankhede@nvidia.com>
 <1573578220-7530-3-git-send-email-kwankhede@nvidia.com>
 <20191112153020.71406c44@x1.home>
 <324ce4f8-d655-ee37-036c-fc9ef9045bef@nvidia.com>
 <20191113130705.32c6b663@x1.home>
 <7f74a2a1-ba1c-9d4c-dc5e-343ecdd7d6d6@nvidia.com>
 <20191114140625.213e8a99@x1.home>
 <20191115024035.GA24163@joy-OptiPlex-7040>
 <20191114202133.4b046cb9@x1.home>
In-Reply-To: <20191114202133.4b046cb9@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzdlNzhhY2ItZmQ5ZC00NGY5LWFhYjAtYTY1ZDUwNjY3NmRmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZWxmVGQzTEMzQ1JCNDZaWE14OExFVkVqcUQ0WE9lMmpZeUh6TkhCQVI0VkxaUVRZSHAxNWY2N2g2TjErb1NFdyJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
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
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang, 
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 Kirti Wankhede <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Alex Williamson
> Sent: Friday, November 15, 2019 11:22 AM
>=20
> On Thu, 14 Nov 2019 21:40:35 -0500
> Yan Zhao <yan.y.zhao@intel.com> wrote:
>=20
> > On Fri, Nov 15, 2019 at 05:06:25AM +0800, Alex Williamson wrote:
> > > On Fri, 15 Nov 2019 00:26:07 +0530
> > > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > >
> > > > On 11/14/2019 1:37 AM, Alex Williamson wrote:
> > > > > On Thu, 14 Nov 2019 01:07:21 +0530
> > > > > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > > > >
> > > > >> On 11/13/2019 4:00 AM, Alex Williamson wrote:
> > > > >>> On Tue, 12 Nov 2019 22:33:37 +0530
> > > > >>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > > > >>>
> > > > >>>> All pages pinned by vendor driver through vfio_pin_pages API
> should be
> > > > >>>> considered as dirty during migration. IOMMU container
> maintains a list of
> > > > >>>> all such pinned pages. Added an ioctl defination to get bitmap=
 of
> such
> > > > >>>
> > > > >>> definition
> > > > >>>
> > > > >>>> pinned pages for requested IO virtual address range.
> > > > >>>
> > > > >>> Additionally, all mapped pages are considered dirty when
> physically
> > > > >>> mapped through to an IOMMU, modulo we discussed devices
> opting in to
> > > > >>> per page pinning to indicate finer granularity with a TBD
> mechanism to
> > > > >>> figure out if any non-opt-in devices remain.
> > > > >>>
> > > > >>
> > > > >> You mean, in case of device direct assignment (device pass
> through)?
> > > > >
> > > > > Yes, or IOMMU backed mdevs.  If vfio_dmas in the container are
> fully
> > > > > pinned and mapped, then the correct dirty page set is all mapped
> pages.
> > > > > We discussed using the vpfn list as a mechanism for vendor driver=
s
> to
> > > > > reduce their migration footprint, but we also discussed that we
> would
> > > > > need a way to determine that all participants in the container ha=
ve
> > > > > explicitly pinned their working pages or else we must consider th=
e
> > > > > entire potential working set as dirty.
> > > > >
> > > >
> > > > How can vendor driver tell this capability to iommu module? Any
> suggestions?
> > >
> > > I think it does so by pinning pages.  Is it acceptable that if the
> > > vendor driver pins any pages, then from that point forward we conside=
r
> > > the IOMMU group dirty page scope to be limited to pinned pages?
> There
> > > are complications around non-singleton IOMMU groups, but I think
> we're
> > > already leaning towards that being a non-worthwhile problem to solve.
> > > So if we require that only singleton IOMMU groups can pin pages and
> we
> > > pass the IOMMU group as a parameter to
> > > vfio_iommu_driver_ops.pin_pages(), then the type1 backend can set a
> > > flag on its local vfio_group struct to indicate dirty page scope is
> > > limited to pinned pages.  We might want to keep a flag on the
> > > vfio_iommu struct to indicate if all of the vfio_groups for each
> > > vfio_domain in the vfio_iommu.domain_list dirty page scope limited to
> > > pinned pages as an optimization to avoid walking lists too often.  Th=
en
> > > we could test if vfio_iommu.domain_list is not empty and this new fla=
g
> > > does not limit the dirty page scope, then everything within each
> > > vfio_dma is considered dirty.
> > >
> >
> > hi Alex
> > could you help clarify whether my understandings below are right?
> > In future,
> > 1. for mdev and for passthrough device withoug hardware ability to trac=
k
> > dirty pages, the vendor driver has to explicitly call
> > vfio_pin_pages()/vfio_unpin_pages() + a flag to tell vfio its dirty pag=
e set.
>=20
> For non-IOMMU backed mdevs without hardware dirty page tracking,
> there's no change to the vendor driver currently.  Pages pinned by the
> vendor driver are marked as dirty.

What about the vendor driver can figure out, in software means, which
pinned pages are actually dirty? In that case, would a separate mark_dirty
interface make more sense? Or introduce read/write flag to the pin_pages
interface similar to DMA API? Existing drivers always set both r/w flags bu=
t
just in case then a specific driver may set read-only or write-only...

>=20
> For any IOMMU backed device, mdev or direct assignment, all mapped
> memory would be considered dirty unless there are explicit calls to pin
> pages on top of the IOMMU page pinning and mapping.  These would likely
> be enabled only when the device is in the _SAVING device_state.
>=20
> > 2. for those devices with hardware ability to track dirty pages, will s=
till
> > provide a callback to vendor driver to get dirty pages. (as for those
> devices,
> > it is hard to explicitly call vfio_pin_pages()/vfio_unpin_pages())
> >
> > 3. for devices relying on dirty bit info in physical IOMMU, there
> > will be a callback to physical IOMMU driver to get dirty page set from
> > vfio.
>=20
> The proposal here does not cover exactly how these would be
> implemented, it only establishes the container as the point of user
> interaction with the dirty bitmap and hopefully allows us to maintain
> that interface regardless of whether we have dirty tracking at the
> device or the system IOMMU.  Ideally devices with dirty tracking would
> make use of page pinning and we'd extend the interface to allow vendor
> drivers the ability to indicate the clean/dirty state of those pinned

I don't think "dirty tracking" =3D=3D "page pinning". It's possible that a =
device
support tracking/logging dirty page info into a driver-registered buffer,=20
then the host vendor driver doesn't need to mediate fast-path operations.=20
In such case, the entire guest memory is always pinned and we just need=20
a log-sync like interface for vendor driver to fill dirty bitmap.

> pages.  For system IOMMU dirty page tracking, that potentially might
> mean that we support IOMMU page faults and the container manages
> those
> faults such that the container is the central record of dirty pages.

IOMMU dirty-bit is not equivalent to IOMMU page fault. The latter
is much more complex which requires support both in IOMMU and in
device. Here similar to above device-dirty-tracking case, we just need a
log-sync interface calling into iommu driver to get dirty info filled for
requested address range.

> Until these interfaces are designed, we can only speculate, but the
> goal is to design a user interface compatible with how those features
> might evolve.  If you identify something that can't work, please raise
> the issue.  Thanks,
>=20
> Alex

Here is the desired scheme in my mind. Feel free to correct me. :-)

1. iommu log-buf callback is preferred if underlying IOMMU reports
such capability. The iommu driver walks IOMMU page table to find
dirty pages for requested address range;
2. otherwise vendor driver log-buf callback is preferred if the vendor
driver reports such capability when registering mdev types. The
vendor driver calls device-specific interface to fill dirty info;
3. otherwise pages pined by vfio_pin_pages (with WRITE flag) are
considered dirty. This covers normal mediated devices or using
fast-path mediation for migrating passthrough device;
4. otherwise all mapped pages are considered dirty;

Currently we're working on 1) based on VT-d rev3.0. I know some
vendors implement 2) in their own code base. 3) has real usages=20
already. 4) is the fall-back.

Alex, are you willing to have all the interfaces ready in one batch,
or support them based on available usages? I'm fine with either
way, but even just doing 3/4 in this series, I'd prefer to having
above scheme included in the code comment, to give the whole=20
picture of all possible situations. :-)

Thanks
Kevin

