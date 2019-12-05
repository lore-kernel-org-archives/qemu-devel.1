Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E18C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 05:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7578E2077B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 05:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7578E2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ick8J-00065H-Md
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 00:56:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1ick7N-0005Y7-B2
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 00:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1ick7K-00035u-Ro
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 00:56:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:24144)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1ick7K-0002qi-Fx
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 00:55:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Dec 2019 21:55:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; d="scan'208";a="201667256"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by orsmga007.jf.intel.com with ESMTP; 04 Dec 2019 21:55:49 -0800
Date: Thu, 5 Dec 2019 00:47:39 -0500
From: Yan Zhao <yan.y.zhao@intel.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v9 Kernel 2/5] vfio iommu: Add ioctl defination to get
 dirty pages bitmap.
Message-ID: <20191205054739.GC31791@joy-OptiPlex-7040>
References: <324ce4f8-d655-ee37-036c-fc9ef9045bef@nvidia.com>
 <20191113130705.32c6b663@x1.home>
 <7f74a2a1-ba1c-9d4c-dc5e-343ecdd7d6d6@nvidia.com>
 <20191114140625.213e8a99@x1.home>
 <20191126005739.GA31144@joy-OptiPlex-7040>
 <20191203110412.055c38df@x1.home>
 <cce08ca5-79df-2839-16cd-15723b995c07@nvidia.com>
 <20191204113457.16c1316d@x1.home>
 <20191205012835.GB31791@joy-OptiPlex-7040>
 <fc7e8cf2-d5e6-0fe6-7466-7bdde55ff7d6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc7e8cf2-d5e6-0fe6-7466-7bdde55ff7d6@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
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
 Alex Williamson <alex.williamson@redhat.com>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 05, 2019 at 01:42:23PM +0800, Kirti Wankhede wrote:
> 
> 
> On 12/5/2019 6:58 AM, Yan Zhao wrote:
> > On Thu, Dec 05, 2019 at 02:34:57AM +0800, Alex Williamson wrote:
> >> On Wed, 4 Dec 2019 23:40:25 +0530
> >> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>
> >>> On 12/3/2019 11:34 PM, Alex Williamson wrote:
> >>>> On Mon, 25 Nov 2019 19:57:39 -0500
> >>>> Yan Zhao <yan.y.zhao@intel.com> wrote:
> >>>>    
> >>>>> On Fri, Nov 15, 2019 at 05:06:25AM +0800, Alex Williamson wrote:
> >>>>>> On Fri, 15 Nov 2019 00:26:07 +0530
> >>>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>>>>>       
> >>>>>>> On 11/14/2019 1:37 AM, Alex Williamson wrote:
> >>>>>>>> On Thu, 14 Nov 2019 01:07:21 +0530
> >>>>>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>>>>>>>         
> >>>>>>>>> On 11/13/2019 4:00 AM, Alex Williamson wrote:
> >>>>>>>>>> On Tue, 12 Nov 2019 22:33:37 +0530
> >>>>>>>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>>>>>>>>>            
> >>>>>>>>>>> All pages pinned by vendor driver through vfio_pin_pages API should be
> >>>>>>>>>>> considered as dirty during migration. IOMMU container maintains a list of
> >>>>>>>>>>> all such pinned pages. Added an ioctl defination to get bitmap of such
> >>>>>>>>>>
> >>>>>>>>>> definition
> >>>>>>>>>>            
> >>>>>>>>>>> pinned pages for requested IO virtual address range.
> >>>>>>>>>>
> >>>>>>>>>> Additionally, all mapped pages are considered dirty when physically
> >>>>>>>>>> mapped through to an IOMMU, modulo we discussed devices opting in to
> >>>>>>>>>> per page pinning to indicate finer granularity with a TBD mechanism to
> >>>>>>>>>> figure out if any non-opt-in devices remain.
> >>>>>>>>>>            
> >>>>>>>>>
> >>>>>>>>> You mean, in case of device direct assignment (device pass through)?
> >>>>>>>>
> >>>>>>>> Yes, or IOMMU backed mdevs.  If vfio_dmas in the container are fully
> >>>>>>>> pinned and mapped, then the correct dirty page set is all mapped pages.
> >>>>>>>> We discussed using the vpfn list as a mechanism for vendor drivers to
> >>>>>>>> reduce their migration footprint, but we also discussed that we would
> >>>>>>>> need a way to determine that all participants in the container have
> >>>>>>>> explicitly pinned their working pages or else we must consider the
> >>>>>>>> entire potential working set as dirty.
> >>>>>>>>         
> >>>>>>>
> >>>>>>> How can vendor driver tell this capability to iommu module? Any suggestions?
> >>>>>>
> >>>>>> I think it does so by pinning pages.  Is it acceptable that if the
> >>>>>> vendor driver pins any pages, then from that point forward we consider
> >>>>>> the IOMMU group dirty page scope to be limited to pinned pages?  There
> >>>>> we should also be aware of that dirty page scope is pinned pages + unpinned pages,
> >>>>> which means ever since a page is pinned, it should be regarded as dirty
> >>>>> no matter whether it's unpinned later. only after log_sync is called and
> >>>>> dirty info retrieved, its dirty state should be cleared.
> >>>>
> >>>> Yes, good point.  We can't just remove a vpfn when a page is unpinned
> >>>> or else we'd lose information that the page potentially had been
> >>>> dirtied while it was pinned.  Maybe that vpfn needs to move to a dirty
> >>>> list and both the currently pinned vpfns and the dirty vpfns are walked
> >>>> on a log_sync.  The dirty vpfns list would be cleared after a log_sync.
> >>>> The container would need to know that dirty tracking is enabled and
> >>>> only manage the dirty vpfns list when necessary.  Thanks,
> >>>>    
> >>>
> >>> If page is unpinned, then that page is available in free page pool for
> >>> others to use, then how can we say that unpinned page has valid data?
> >>>
> >>> If suppose, one driver A unpins a page and when driver B of some other
> >>> device gets that page and he pins it, uses it, and then unpins it, then
> >>> how can we say that page has valid data for driver A?
> >>>
> >>> Can you give one example where unpinned page data is considered reliable
> >>> and valid?
> >>
> >> We can only pin pages that the user has already allocated* and mapped
> >> through the vfio DMA API.  The pinning of the page simply locks the
> >> page for the vendor driver to access it and unpinning that page only
> >> indicates that access is complete.  Pages are not freed when a vendor
> >> driver unpins them, they still exist and at this point we're now
> >> assuming the device dirtied the page while it was pinned.  Thanks,
> >>
> >> Alex
> >>
> >> * An exception here is that the page might be demand allocated and the
> >>    act of pinning the page could actually allocate the backing page for
> >>    the user if they have not faulted the page to trigger that allocation
> >>    previously.  That page remains mapped for the user's virtual address
> >>    space even after the unpinning though.
> >>
> > 
> > Yes, I can give an example in GVT.
> > when a gem_object is allocated in guest, before submitting it to guest
> > vGPU, gfx cmds in its ring buffer need to be pinned into GGTT to get a
> > global graphics address for hardware access. At that time, we shadow
> > those cmds and pin pages through vfio pin_pages(), and submit the shadow
> > gem_object to physial hardware.
> > After guest driver thinks the submitted gem_object has completed hardware
> > DMA, it unnpinnd those pinned GGTT graphics memory addresses. Then in
> > host, we unpin the shadow pages through vfio unpin_pages.
> > But, at this point, guest driver is still free to access the gem_object
> > through vCPUs, and guest user space is probably still mapping an object
> > into the gem_object in guest driver.
> > So, missing the dirty page tracking for unpinned pages would cause
> > data inconsitency.
> > 
> 
> If pages are accessed by guest through vCPUs, then RAM module in QEMU 
> will take care of tracking those pages as dirty.
> 
> All unpinned pages might not be used, so tracking all unpinned pages 
> during VM or application life time would also lead to tracking lots of 
> stale pages, even though they are not being used. Increasing number of 
> not needed pages could also lead to increasing migration data leading 
> increase in migration downtime.
> 
> Thanks,
> Kirti

Those are pages dirtied by vGPU during Pin/Unpin. They are not dirtied
by vCPUs. RAM module in QEMU has no idea of it.

