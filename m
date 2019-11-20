Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F1BC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 02:01:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75029223D8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 02:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75029223D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXFIn-000885-CE
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 21:01:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1iXFHZ-0007Xn-9L
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 20:59:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1iXFHW-0003pv-RX
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 20:59:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:7326)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1iXFHW-0003hM-Im
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 20:59:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Nov 2019 17:59:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,220,1571727600"; d="scan'208";a="196697881"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by orsmga007.jf.intel.com with ESMTP; 19 Nov 2019 17:59:37 -0800
Date: Tue, 19 Nov 2019 20:51:32 -0500
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v9 Kernel 2/5] vfio iommu: Add ioctl defination to get
 dirty pages bitmap.
Message-ID: <20191120015132.GA24995@joy-OptiPlex-7040>
References: <1573578220-7530-1-git-send-email-kwankhede@nvidia.com>
 <1573578220-7530-3-git-send-email-kwankhede@nvidia.com>
 <20191112153020.71406c44@x1.home>
 <324ce4f8-d655-ee37-036c-fc9ef9045bef@nvidia.com>
 <20191113130705.32c6b663@x1.home>
 <7f74a2a1-ba1c-9d4c-dc5e-343ecdd7d6d6@nvidia.com>
 <20191114140625.213e8a99@x1.home>
 <20191115024035.GA24163@joy-OptiPlex-7040>
 <20191114202133.4b046cb9@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114202133.4b046cb9@x1.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
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

On Fri, Nov 15, 2019 at 11:21:33AM +0800, Alex Williamson wrote:
> On Thu, 14 Nov 2019 21:40:35 -0500
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
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
> > > > >>>> All pages pinned by vendor driver through vfio_pin_pages API should be
> > > > >>>> considered as dirty during migration. IOMMU container maintains a list of
> > > > >>>> all such pinned pages. Added an ioctl defination to get bitmap of such    
> > > > >>>
> > > > >>> definition
> > > > >>>        
> > > > >>>> pinned pages for requested IO virtual address range.    
> > > > >>>
> > > > >>> Additionally, all mapped pages are considered dirty when physically
> > > > >>> mapped through to an IOMMU, modulo we discussed devices opting in to
> > > > >>> per page pinning to indicate finer granularity with a TBD mechanism to
> > > > >>> figure out if any non-opt-in devices remain.
> > > > >>>        
> > > > >>
> > > > >> You mean, in case of device direct assignment (device pass through)?    
> > > > > 
> > > > > Yes, or IOMMU backed mdevs.  If vfio_dmas in the container are fully
> > > > > pinned and mapped, then the correct dirty page set is all mapped pages.
> > > > > We discussed using the vpfn list as a mechanism for vendor drivers to
> > > > > reduce their migration footprint, but we also discussed that we would
> > > > > need a way to determine that all participants in the container have
> > > > > explicitly pinned their working pages or else we must consider the
> > > > > entire potential working set as dirty.
> > > > >     
> > > > 
> > > > How can vendor driver tell this capability to iommu module? Any suggestions?  
> > > 
> > > I think it does so by pinning pages.  Is it acceptable that if the
> > > vendor driver pins any pages, then from that point forward we consider
> > > the IOMMU group dirty page scope to be limited to pinned pages?  There
> > > are complications around non-singleton IOMMU groups, but I think we're
> > > already leaning towards that being a non-worthwhile problem to solve.
> > > So if we require that only singleton IOMMU groups can pin pages and we
> > > pass the IOMMU group as a parameter to
> > > vfio_iommu_driver_ops.pin_pages(), then the type1 backend can set a
> > > flag on its local vfio_group struct to indicate dirty page scope is
> > > limited to pinned pages.  We might want to keep a flag on the
> > > vfio_iommu struct to indicate if all of the vfio_groups for each
> > > vfio_domain in the vfio_iommu.domain_list dirty page scope limited to
> > > pinned pages as an optimization to avoid walking lists too often.  Then
> > > we could test if vfio_iommu.domain_list is not empty and this new flag
> > > does not limit the dirty page scope, then everything within each
> > > vfio_dma is considered dirty.
> > >  
> > 
> > hi Alex
> > could you help clarify whether my understandings below are right?
> > In future,
> > 1. for mdev and for passthrough device withoug hardware ability to track
> > dirty pages, the vendor driver has to explicitly call
> > vfio_pin_pages()/vfio_unpin_pages() + a flag to tell vfio its dirty page set.
> 
> For non-IOMMU backed mdevs without hardware dirty page tracking,
> there's no change to the vendor driver currently.  Pages pinned by the
> vendor driver are marked as dirty.
> 
> For any IOMMU backed device, mdev or direct assignment, all mapped
> memory would be considered dirty unless there are explicit calls to pin
> pages on top of the IOMMU page pinning and mapping.  These would likely
> be enabled only when the device is in the _SAVING device_state.
> 
> > 2. for those devices with hardware ability to track dirty pages, will still
> > provide a callback to vendor driver to get dirty pages. (as for those devices,
> > it is hard to explicitly call vfio_pin_pages()/vfio_unpin_pages())
> >
> > 3. for devices relying on dirty bit info in physical IOMMU, there
> > will be a callback to physical IOMMU driver to get dirty page set from
> > vfio.
> 
> The proposal here does not cover exactly how these would be
> implemented, it only establishes the container as the point of user
> interaction with the dirty bitmap and hopefully allows us to maintain
> that interface regardless of whether we have dirty tracking at the
> device or the system IOMMU.  Ideally devices with dirty tracking would
> make use of page pinning and we'd extend the interface to allow vendor
> drivers the ability to indicate the clean/dirty state of those pinned
> pages.  For system IOMMU dirty page tracking, that potentially might
> mean that we support IOMMU page faults and the container manages those
> faults such that the container is the central record of dirty pages.
> Until these interfaces are designed, we can only speculate, but the
> goal is to design a user interface compatible with how those features
> might evolve.  If you identify something that can't work, please raise
> the issue.  Thanks,
> 
> Alex
>
hi Alex
I think there are two downsides of centralizing dirty page tracking into
vfio container.
1. vendor driver has to report dirty pages to vfio container immediately
after it detects a dirty page.
It lost the freedom to record dirty pages in whatever way and query it on
receiving log_sync call.
e.g. it can record dirty page info in its internal hardware buffer or
record in hardware IOMMU and ask for that by itself.

2. the vfio container, if based on pin_pages, only knows which pages are
dirty or not dirty, but don't know incremental information. That's why
in Kirti's QEMU implementation only query dirty pages after stopping
device, right? but if in that way, QEMU migration may generate a wrong
downtime expectation and cause a longer downtime. E.g.  before stopping
device, QEMU thinks there's only 100M data left and can limit
migration downtime to certain value. but after stopping device and query
dirty pages again, it finds out there're actually 1000M more...

That's more concerns to it.

Thanks
Yan

