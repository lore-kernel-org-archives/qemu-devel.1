Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE917C352A4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 03:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57642080C
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 03:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57642080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Lp9-0006c9-QP
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 22:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1j1Lob-0006AX-00
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 22:02:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1j1LoX-0000aw-PY
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 22:02:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:19569)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1j1LoX-0000I1-Gt
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 22:02:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Feb 2020 19:02:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,427,1574150400"; d="scan'208";a="431818732"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2020 19:02:09 -0800
Date: Mon, 10 Feb 2020 21:52:51 -0500
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v12 Kernel 4/7] vfio iommu: Implementation of ioctl to
 for dirty pages tracking.
Message-ID: <20200211025251.GB4530@joy-OptiPlex-7040>
References: <1581104554-10704-1-git-send-email-kwankhede@nvidia.com>
 <1581104554-10704-5-git-send-email-kwankhede@nvidia.com>
 <20200210094954.GA4530@joy-OptiPlex-7040>
 <20200210124454.12e0419a@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210124454.12e0419a@w520.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
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

On Tue, Feb 11, 2020 at 03:44:54AM +0800, Alex Williamson wrote:
> On Mon, 10 Feb 2020 04:49:54 -0500
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
> > On Sat, Feb 08, 2020 at 03:42:31AM +0800, Kirti Wankhede wrote:
> > > VFIO_IOMMU_DIRTY_PAGES ioctl performs three operations:
> > > - Start pinned and unpinned pages tracking while migration is active
> > > - Stop pinned and unpinned dirty pages tracking. This is also used to
> > >   stop dirty pages tracking if migration failed or cancelled.
> > > - Get dirty pages bitmap. This ioctl returns bitmap of dirty pages, its
> > >   user space application responsibility to copy content of dirty pages
> > >   from source to destination during migration.
> > > 
> > > To prevent DoS attack, memory for bitmap is allocated per vfio_dma
> > > structure. Bitmap size is calculated considering smallest supported page
> > > size. Bitmap is allocated when dirty logging is enabled for those
> > > vfio_dmas whose vpfn list is not empty or whole range is mapped, in
> > > case of pass-through device.
> > > 
> > > There could be multiple option as to when bitmap should be populated:
> > > * Polulate bitmap for already pinned pages when bitmap is allocated for
> > >   a vfio_dma with the smallest supported page size. Updates bitmap from
> > >   page pinning and unpinning functions. When user application queries
> > >   bitmap, check if requested page size is same as page size used to
> > >   populated bitmap. If it is equal, copy bitmap. But if not equal,
> > >   re-populated bitmap according to requested page size and then copy to
> > >   user.
> > >   Pros: Bitmap gets populated on the fly after dirty tracking has
> > >         started.
> > >   Cons: If requested page size is different than smallest supported
> > >         page size, then bitmap has to be re-populated again, with
> > >         additional overhead of allocating bitmap memory again for
> > >         re-population of bitmap.
> > > 
> > > * Populate bitmap when bitmap is queried by user application.
> > >   Pros: Bitmap is populated with requested page size. This eliminates
> > >         the need to re-populate bitmap if requested page size is
> > >         different than smallest supported pages size.
> > >   Cons: There is one time processing time, when bitmap is queried.
> > > 
> > > I prefer later option with simple logic and to eliminate over-head of
> > > bitmap repopulation in case of differnt page sizes. Later option is
> > > implemented in this patch.
> > > 
> > > Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > > Reviewed-by: Neo Jia <cjia@nvidia.com>
> > > ---
> > >  drivers/vfio/vfio_iommu_type1.c | 299 ++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 287 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > > index d386461e5d11..df358dc1c85b 100644
> > > --- a/drivers/vfio/vfio_iommu_type1.c
> > > +++ b/drivers/vfio/vfio_iommu_type1.c
> [snip]
> > > @@ -830,6 +924,113 @@ static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu)
> > >  	return bitmap;
> > >  }
> > >  
> > > +static int vfio_iova_dirty_bitmap(struct vfio_iommu *iommu, dma_addr_t iova,
> > > +				  size_t size, uint64_t pgsize,
> > > +				  unsigned char __user *bitmap)
> > > +{
> > > +	struct vfio_dma *dma;
> > > +	dma_addr_t i = iova, iova_limit;
> > > +	unsigned int bsize, nbits = 0, l = 0;
> > > +	unsigned long pgshift = __ffs(pgsize);
> > > +
> > > +	while ((dma = vfio_find_dma(iommu, i, pgsize))) {
> > > +		int ret, j;
> > > +		unsigned int npages = 0, shift = 0;
> > > +		unsigned char temp = 0;
> > > +
> > > +		/* mark all pages dirty if all pages are pinned and mapped. */
> > > +		if (dma->iommu_mapped) {
> > > +			iova_limit = min(dma->iova + dma->size, iova + size);
> > > +			npages = iova_limit/pgsize;
> > > +			bitmap_set(dma->bitmap, 0, npages);  
> > for pass-through devices, it's not good to always return all pinned pages as
> > dirty. could it also call vfio_pin_pages to track dirty pages? or any
> > other interface provided to do that?
> 
> See patch 7/7.  Thanks,
>
hi Alex and Kirti,
for pass-through devices, though patch 7/7 enables the vendor driver to
set dirty pages by calling vfio_pin_pages, however, its overhead is much
higher than the previous way of generating a bitmap directly to user.
And it also requires pass-through device vendor driver to track guest
operations to know when to call vfio_pin_pages.
There are still use cases like a pass-through device is able to track
dirty pages in its hardware buffer, so is there a way for it pass its
dirty bitmap to user?

Thanks
Yan

