Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7188C1975A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 02:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC1320732
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 02:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC1320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGDDl-00027k-NG
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 22:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jGDDC-0001i4-Ty
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 22:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jGDDB-0006AG-0i
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 22:53:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:50604)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jGDDA-00066M-JE
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 22:53:08 -0400
IronPort-SDR: ClppIW0NQe/uDLSib151/vlJ7UwlYwesiQDGSLLNPwaZ7ugdCi05Aahy8qtDXQXVZrlbFxvZJ8
 4gn+fpBjPYMg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2020 19:53:04 -0700
IronPort-SDR: lqqBrhqceOe8jZ9MbL23llbbR4S9C5niNFgZasxhdIdoV8WEYCrg0mXDJmkUY5EHioaqWdSrAu
 tZe9MFm7rLyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,294,1580803200"; d="scan'208";a="419359109"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga005.jf.intel.com with ESMTP; 22 Mar 2020 19:52:59 -0700
Date: Sun, 22 Mar 2020 22:43:28 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v14 Kernel 7/7] vfio: Selective dirty page tracking if
 IOMMU backed device pins pages
Message-ID: <20200323024328.GC5456@joy-OptiPlex-7040>
References: <1584560474-19946-1-git-send-email-kwankhede@nvidia.com>
 <1584560474-19946-8-git-send-email-kwankhede@nvidia.com>
 <20200319062433.GH4641@joy-OptiPlex-7040>
 <20200320134142.3abe56ea@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320134142.3abe56ea@w520.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.65
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

On Sat, Mar 21, 2020 at 03:41:42AM +0800, Alex Williamson wrote:
> On Thu, 19 Mar 2020 02:24:33 -0400
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> > On Thu, Mar 19, 2020 at 03:41:14AM +0800, Kirti Wankhede wrote:
> > > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > > index 912629320719..deec09f4b0f6 100644
> > > --- a/drivers/vfio/vfio_iommu_type1.c
> > > +++ b/drivers/vfio/vfio_iommu_type1.c
> > > @@ -72,6 +72,7 @@ struct vfio_iommu {
> > >  	bool			v2;
> > >  	bool			nesting;
> > >  	bool			dirty_page_tracking;
> > > +	bool			pinned_page_dirty_scope;
> > >  };
> > >  
> > >  struct vfio_domain {
> > > @@ -99,6 +100,7 @@ struct vfio_group {
> > >  	struct iommu_group	*iommu_group;
> > >  	struct list_head	next;
> > >  	bool			mdev_group;	/* An mdev group */
> > > +	bool			pinned_page_dirty_scope;
> > >  };
> > >  
> > >  struct vfio_iova {
> > > @@ -132,6 +134,10 @@ struct vfio_regions {
> > >  static int put_pfn(unsigned long pfn, int prot);
> > >  static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu);
> > >  
> > > +static struct vfio_group *vfio_iommu_find_iommu_group(struct vfio_iommu *iommu,
> > > +					       struct iommu_group *iommu_group);
> > > +
> > > +static void update_pinned_page_dirty_scope(struct vfio_iommu *iommu);
> > >  /*
> > >   * This code handles mapping and unmapping of user data buffers
> > >   * into DMA'ble space using the IOMMU
> > > @@ -556,11 +562,13 @@ static int vfio_unpin_page_external(struct vfio_dma *dma, dma_addr_t iova,
> > >  }
> > >  
> > >  static int vfio_iommu_type1_pin_pages(void *iommu_data,
> > > +				      struct iommu_group *iommu_group,
> > >  				      unsigned long *user_pfn,
> > >  				      int npage, int prot,
> > >  				      unsigned long *phys_pfn)
> > >  {
> > >  	struct vfio_iommu *iommu = iommu_data;
> > > +	struct vfio_group *group;
> > >  	int i, j, ret;
> > >  	unsigned long remote_vaddr;
> > >  	struct vfio_dma *dma;
> > > @@ -630,8 +638,14 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
> > >  				   (vpfn->iova - dma->iova) >> pgshift, 1);
> > >  		}
> > >  	}  
> > 
> > Could you provide an interface lightweight than vfio_pin_pages for pass-through
> > devices? e.g. vfio_mark_iova_dirty()
> > 
> > Or at least allowing phys_pfn to be empty for pass-through devices.
> > 
> > This is really inefficient:
> > bitmap_set(dma->bitmap, (vpfn->iova - dma->iova) / pgsize, 1));
> > i.e.
> > in order to mark an iova dirty, it has to go through iova ---> pfn --> iova
> > while acquiring pfn is not necessary for pass-through devices.
> 
> I think this would be possible, but I don't think it should be gating
> to this series.  We don't have such consumers yet.  Thanks,
>
ok. Reasonable.

Thanks
Yan

