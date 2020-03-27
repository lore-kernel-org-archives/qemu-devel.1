Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B747C2D0E8
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 00:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4418A20663
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 00:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4418A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHceV-0005E1-EY
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 20:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jHcdk-0004lu-2a
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 20:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jHcdh-0008Kr-Do
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 20:14:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:14024)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jHcdh-00086C-5K
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 20:14:21 -0400
IronPort-SDR: xirA3i0m7W8sSupW6VbXDprHki731xtgO+C/LOYFsHDLTrh6RGcm5PvwU/y/+XHsifCpxaIMNR
 kI70Tc8ImViQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2020 17:14:03 -0700
IronPort-SDR: mEe5Qq74slYzR5lwKOwReqjluzzJrAwiFd7oFDZQ1uhd71nnDNh5mTuGmUSj10eN0sTXvBmKaN
 uhXtwX/2zpgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,310,1580803200"; d="scan'208";a="271372032"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga004.fm.intel.com with ESMTP; 26 Mar 2020 17:13:59 -0700
Date: Thu, 26 Mar 2020 20:04:27 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v16 Kernel 5/7] vfio iommu: Update UNMAP_DMA ioctl to get
 dirty bitmap before unmap
Message-ID: <20200327000426.GA26419@joy-OptiPlex-7040>
References: <1585078359-20124-1-git-send-email-kwankhede@nvidia.com>
 <1585078359-20124-6-git-send-email-kwankhede@nvidia.com>
 <20200325021800.GC20109@joy-OptiPlex-7040>
 <3cabb357-b9c5-f8b3-5d57-1178ec0dde5a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cabb357-b9c5-f8b3-5d57-1178ec0dde5a@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.88
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
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 27, 2020 at 05:39:44AM +0800, Kirti Wankhede wrote:
> 
> 
> On 3/25/2020 7:48 AM, Yan Zhao wrote:
> > On Wed, Mar 25, 2020 at 03:32:37AM +0800, Kirti Wankhede wrote:
> >> DMA mapped pages, including those pinned by mdev vendor drivers, might
> >> get unpinned and unmapped while migration is active and device is still
> >> running. For example, in pre-copy phase while guest driver could access
> >> those pages, host device or vendor driver can dirty these mapped pages.
> >> Such pages should be marked dirty so as to maintain memory consistency
> >> for a user making use of dirty page tracking.
> >>
> >> To get bitmap during unmap, user should allocate memory for bitmap, set
> >> size of allocated memory, set page size to be considered for bitmap and
> >> set flag VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP.
> >>
> >> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> >> Reviewed-by: Neo Jia <cjia@nvidia.com>
> >> ---
> >>   drivers/vfio/vfio_iommu_type1.c | 54 ++++++++++++++++++++++++++++++++++++++---
> >>   include/uapi/linux/vfio.h       | 10 ++++++++
> >>   2 files changed, 60 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> >> index 27ed069c5053..b98a8d79e13a 100644
> >> --- a/drivers/vfio/vfio_iommu_type1.c
> >> +++ b/drivers/vfio/vfio_iommu_type1.c
> >> @@ -982,7 +982,8 @@ static int verify_bitmap_size(uint64_t npages, uint64_t bitmap_size)
> >>   }
> >>   
> >>   static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> >> -			     struct vfio_iommu_type1_dma_unmap *unmap)
> >> +			     struct vfio_iommu_type1_dma_unmap *unmap,
> >> +			     struct vfio_bitmap *bitmap)
> >>   {
> >>   	uint64_t mask;
> >>   	struct vfio_dma *dma, *dma_last = NULL;
> >> @@ -1033,6 +1034,10 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> >>   	 * will be returned if these conditions are not met.  The v2 interface
> >>   	 * will only return success and a size of zero if there were no
> >>   	 * mappings within the range.
> >> +	 *
> >> +	 * When VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP flag is set, unmap request
> >> +	 * must be for single mapping. Multiple mappings with this flag set is
> >> +	 * not supported.
> >>   	 */
> >>   	if (iommu->v2) {
> >>   		dma = vfio_find_dma(iommu, unmap->iova, 1);
> >> @@ -1040,6 +1045,13 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> >>   			ret = -EINVAL;
> >>   			goto unlock;
> >>   		}
> >> +
> >> +		if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
> >> +		    (dma->iova != unmap->iova || dma->size != unmap->size)) {
> > potential NULL pointer!
> > 
> > And could you address the comments in v14?
> > How to handle DSI unmaps in vIOMMU
> > (https://lore.kernel.org/kvm/20200323011041.GB5456@joy-OptiPlex-7040/)
> > 
> 
> Sorry, I drafted reply to it, but I missed to send, it remained in my drafts
> 
>  >
>  > it happens in vIOMMU Domain level invalidation of IOTLB
>  > (domain-selective invalidation, see vtd_iotlb_domain_invalidate() in 
> qemu).
>  > common in VTD lazy mode, and NOT just happening once at boot time.
>  > rather than invalidate page by page, it batches the page invalidation.
>  > so, when this invalidation takes place, even higher level page tables
>  > have been invalid and therefore it has to invalidate a bigger 
> combined range.
>  > That's why we see IOVAs are mapped in 4k pages, but are unmapped in 2M
>  > pages.
>  >
>  > I think those UNMAPs should also have GET_DIRTY_BIMTAP flag on, right?
> 
> 
> vtd_iotlb_domain_invalidate()
>    vtd_sync_shadow_page_table()
>      vtd_sync_shadow_page_table_range(vtd_as, &ce, 0, UINT64_MAX)
>        vtd_page_walk()
>          vtd_page_walk_level() - walk over specific level for IOVA range
>            vtd_page_walk_one()
>              memory_region_notify_iommu()
>              ...
>                vfio_iommu_map_notify()
> 
> In the above trace, isn't page walk will take care of creating proper 
> IOTLB entry which should be same as created during mapping for that 
> IOTLB entry?
>
No. It does walk the page table, but as it's dsi (delay & batched unmap),
pages table entry for a whole 2M (the higher level, not last level for 4K)
range is invalid, so the iotlb->addr_mask what vfio_iommu_map_notify()
receives is (2M - 1), not the same as the size for map.

> 
>  >>>
>  >>> Such unmap would callback vfio_iommu_map_notify() in QEMU. In
>  >>> vfio_iommu_map_notify(), unmap is called on same range <iova,
>  >>> iotlb->addr_mask + 1> which was used for map. Secondly unmap with 
> bitmap
>  >>> will be called only when device state has _SAVING flag set.
>  >>
>  > in this case, iotlb->addr_mask in unmap is 0x200000 -1.
>  > different than 0x1000 -1 used for map.
>  >> It might be helpful for Yan, and everyone else, to see the latest QEMU
>  >> patch series.  Thanks,
>  >>
>  > yes, please. also curious of log_sync part for vIOMMU. given most 
> IOVAs in
>  > address space are unmapped and therefore no IOTLBs are able to be found.
>  >
> 	
> Qemu patches compatible with v16 version are at:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg691806.html
> 
> 

