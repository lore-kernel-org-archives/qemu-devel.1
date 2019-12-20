Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18D6C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 01:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C44C62465E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 01:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44C62465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii6mC-0006sg-4o
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 20:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1ii6l2-0006AQ-1E
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 20:07:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1ii6kz-00087y-Gc
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 20:07:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:39199)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1ii6ky-0007Te-TU
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 20:07:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Dec 2019 17:06:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,333,1571727600"; d="scan'208";a="390711989"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by orsmga005.jf.intel.com with ESMTP; 19 Dec 2019 17:06:50 -0800
Date: Thu, 19 Dec 2019 19:58:36 -0500
From: Yan Zhao <yan.y.zhao@intel.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v10 Kernel 4/5] vfio iommu: Implementation of ioctl to
 for dirty pages tracking.
Message-ID: <20191220005836.GK21868@joy-OptiPlex-7040>
References: <1576527700-21805-1-git-send-email-kwankhede@nvidia.com>
 <1576527700-21805-5-git-send-email-kwankhede@nvidia.com>
 <20191217051513.GE21868@joy-OptiPlex-7040>
 <17ac4c3b-5f7c-0e52-2c2b-d847d4d4e3b1@nvidia.com>
 <20191217095110.GH21868@joy-OptiPlex-7040>
 <0d9604d9-3bb2-6944-9858-983366f332bb@nvidia.com>
 <20191218010451.GI21868@joy-OptiPlex-7040>
 <20191218200552.GX3707@work-vm>
 <20191219005749.GJ21868@joy-OptiPlex-7040>
 <75c4f23b-b668-6edb-2f4e-191b253cede9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75c4f23b-b668-6edb-2f4e-191b253cede9@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Wang,
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

On Fri, Dec 20, 2019 at 12:21:45AM +0800, Kirti Wankhede wrote:
> 
> 
> On 12/19/2019 6:27 AM, Yan Zhao wrote:
> > On Thu, Dec 19, 2019 at 04:05:52AM +0800, Dr. David Alan Gilbert wrote:
> >> * Yan Zhao (yan.y.zhao@intel.com) wrote:
> >>> On Tue, Dec 17, 2019 at 07:47:05PM +0800, Kirti Wankhede wrote:
> >>>>
> >>>>
> >>>> On 12/17/2019 3:21 PM, Yan Zhao wrote:
> >>>>> On Tue, Dec 17, 2019 at 05:24:14PM +0800, Kirti Wankhede wrote:
> >>>>>>>>     
> >>>>>>>>     		return copy_to_user((void __user *)arg, &unmap, minsz) ?
> >>>>>>>>     			-EFAULT : 0;
> >>>>>>>> +	} else if (cmd == VFIO_IOMMU_DIRTY_PAGES) {
> >>>>>>>> +		struct vfio_iommu_type1_dirty_bitmap range;
> >>>>>>>> +		uint32_t mask = VFIO_IOMMU_DIRTY_PAGES_FLAG_START |
> >>>>>>>> +				VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP |
> >>>>>>>> +				VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP;
> >>>>>>>> +		int ret;
> >>>>>>>> +
> >>>>>>>> +		if (!iommu->v2)
> >>>>>>>> +			return -EACCES;
> >>>>>>>> +
> >>>>>>>> +		minsz = offsetofend(struct vfio_iommu_type1_dirty_bitmap,
> >>>>>>>> +				    bitmap);
> >>>>>>>> +
> >>>>>>>> +		if (copy_from_user(&range, (void __user *)arg, minsz))
> >>>>>>>> +			return -EFAULT;
> >>>>>>>> +
> >>>>>>>> +		if (range.argsz < minsz || range.flags & ~mask)
> >>>>>>>> +			return -EINVAL;
> >>>>>>>> +
> >>>>>>>> +		if (range.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_START) {
> >>>>>>>> +			iommu->dirty_page_tracking = true;
> >>>>>>>> +			return 0;
> >>>>>>>> +		} else if (range.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP) {
> >>>>>>>> +			iommu->dirty_page_tracking = false;
> >>>>>>>> +
> >>>>>>>> +			mutex_lock(&iommu->lock);
> >>>>>>>> +			vfio_remove_unpinned_from_dma_list(iommu);
> >>>>>>>> +			mutex_unlock(&iommu->lock);
> >>>>>>>> +			return 0;
> >>>>>>>> +
> >>>>>>>> +		} else if (range.flags &
> >>>>>>>> +				 VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP) {
> >>>>>>>> +			uint64_t iommu_pgmask;
> >>>>>>>> +			unsigned long pgshift = __ffs(range.pgsize);
> >>>>>>>> +			unsigned long *bitmap;
> >>>>>>>> +			long bsize;
> >>>>>>>> +
> >>>>>>>> +			iommu_pgmask =
> >>>>>>>> +			 ((uint64_t)1 << __ffs(vfio_pgsize_bitmap(iommu))) - 1;
> >>>>>>>> +
> >>>>>>>> +			if (((range.pgsize - 1) & iommu_pgmask) !=
> >>>>>>>> +			    (range.pgsize - 1))
> >>>>>>>> +				return -EINVAL;
> >>>>>>>> +
> >>>>>>>> +			if (range.iova & iommu_pgmask)
> >>>>>>>> +				return -EINVAL;
> >>>>>>>> +			if (!range.size || range.size > SIZE_MAX)
> >>>>>>>> +				return -EINVAL;
> >>>>>>>> +			if (range.iova + range.size < range.iova)
> >>>>>>>> +				return -EINVAL;
> >>>>>>>> +
> >>>>>>>> +			bsize = verify_bitmap_size(range.size >> pgshift,
> >>>>>>>> +						   range.bitmap_size);
> >>>>>>>> +			if (bsize)
> >>>>>>>> +				return ret;
> >>>>>>>> +
> >>>>>>>> +			bitmap = kmalloc(bsize, GFP_KERNEL);
> >>>>>>>> +			if (!bitmap)
> >>>>>>>> +				return -ENOMEM;
> >>>>>>>> +
> >>>>>>>> +			ret = copy_from_user(bitmap,
> >>>>>>>> +			     (void __user *)range.bitmap, bsize) ? -EFAULT : 0;
> >>>>>>>> +			if (ret)
> >>>>>>>> +				goto bitmap_exit;
> >>>>>>>> +
> >>>>>>>> +			iommu->dirty_page_tracking = false;
> >>>>>>> why iommu->dirty_page_tracking is false here?
> >>>>>>> suppose this ioctl can be called several times.
> >>>>>>>
> >>>>>>
> >>>>>> This ioctl can be called several times, but once this ioctl is called
> >>>>>> that means vCPUs are stopped and VFIO devices are stopped (i.e. in
> >>>>>> stop-and-copy phase) and dirty pages bitmap are being queried by user.
> >>>>>>
> >>>>> can't agree that VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP can only be
> >>>>> called in stop-and-copy phase.
> >>>>> As stated in last version, this will cause QEMU to get a wrong expectation
> >>>>> of VM downtime and this is also the reason for previously pinned pages
> >>>>> before log_sync cannot be treated as dirty. If this get bitmap ioctl can
> >>>>> be called early in save_setup phase, then it's no problem even all ram
> >>>>> is dirty.
> >>>>>
> >>>>
> >>>> Device can also write to pages which are pinned, and then there is no
> >>>> way to know pages dirtied by device during pre-copy phase.
> >>>> If user ask dirty bitmap in per-copy phase, even then user will have to
> >>>> query dirty bitmap in stop-and-copy phase where this will be superset
> >>>> including all pages reported during pre-copy. Then instead of copying
> >>>> all pages twice, its better to do it once during stop-and-copy phase.
> >>>>
> >>> I think the flow should be like this:
> >>> 1. save_setup --> GET_BITMAP ioctl --> return bitmap for currently + previously
> >>> pinned pages and clean all previously pinned pages
> >>>
> >>> 2. save_pending --> GET_BITMAP ioctl  --> return bitmap of (currently
> >>> pinned pages + previously pinned pages since last clean) and clean all
> >>> previously pinned pages
> >>>
> >>> 3. save_complete_precopy --> GET_BITMAP ioctl --> return bitmap of (currently
> >>> pinned pages + previously pinned pages since last clean) and clean all
> >>> previously pinned pages
> >>>
> >>>
> >>> Copying pinned pages multiple times is unavoidable because those pinned pages
> >>> are always treated as dirty. That's per vendor's implementation.
> >>> But if the pinned pages are not reported as dirty before stop-and-copy phase,
> >>> QEMU would think dirty pages has converged
> >>> and enter blackout phase, making downtime_limit severely incorrect.
> >>
> >> I'm not sure it's any worse.
> >> I *think* we do a last sync after we've decided to go to stop-and-copy;
> >> wont that then mark all those pages as dirty again, so it'll have the
> >> same behaviour?
> > No. something will be different.
> > currently, in kirti's implementation, if GET_BITMAP ioctl is called only
> > once in stop-and-copy phase, then before that phase, QEMU does not know those
> > pages are dirty.
> > If we can report those dirty pages earlier before stop-and-copy phase,
> > QEMU can at least copy other pages to reduce dirty pages to below threshold.
> > 
> > Take a example, let's assume those vfio dirty pages is 1Gb, and network speed is
> > also 1Gb. Expected vm downtime is 1s.
> > If before stop-and-copy phase, dirty pages produced by other pages is
> > also 1Gb. To meet the expected vm downtime, QEMU should copy pages to
> > let dirty pages be less than 1Gb, otherwise, it should not complete live
> > migration.
> > If vfio does not report this 1Gb dirty pages, QEMU would think there's
> > only 1Gb and stop the vm. It would then find out there's actually 2Gb and vm
> > downtime is 2s.
> > Though the expected vm downtime is always not exactly the same as the
> > true vm downtime, it should be caused by rapid dirty page rate, which is
> > not predictable.
> > Right?
> > 
> 
> If you report vfio dirty pages 1Gb before stop-and-copy phase (i.e. in 
> pre-copy phase), enter into stop-and-copy phase, how will you know which 
> and how many pages are dirtied by device from the time when pages copied 
> in pre-copy phase to that time where device is stopped? You don't have a 
> way to know which pages are dirtied by device. So ideally device can 
> write to all pages which are pinned. Then we have to mark all those 
> pinned pages dirty in stop-and-copy phase, 1Gb, and copy to destination. 
> Now you had copied same pages twice. Shouldn't we try not to copy pages 
> twice?
>
For mdevs who reply on treating all pinned pages as dirty pages, as above
mentioned condition, repeated page copying can be avoided by
(1) adding an ioctl to get size of dirty pages and report it to QEMU through
vfio_save_pending() interface
(2) in this GET_BITMAP ioctl, empty bitmap is returned until stop-and-copy phase.

But for devices who know fine-grained dirty pages, (e.g. devices have ditry page
tracking in hardware), GET_BITMAP ioctl has to return incremental dirty
bitmaps in each iteration and step (1) should return 0 to avoid 2*size
of dirty page reported.

Thanks
Yan

