Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1D6C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 23:59:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE79F205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 23:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE79F205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ4Jg-0002mM-Rk
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 19:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jJ4It-0001sG-2f
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 19:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jJ4Io-0002xs-QD
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 19:58:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:52141)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jJ4Io-0002mr-CF
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 19:58:46 -0400
IronPort-SDR: FXcYh140HJZclCeu/Aefjz6Qb0K2XwN8M1J0G+HjcxpVx+W3QWZssIUpjndU3oTLQWbIZRWSsG
 N4cSyVIhbYmQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 16:58:42 -0700
IronPort-SDR: /Rds1xtWbzqIeuo4GdYbUL35pIWWSB/eISR0RdJMUFLTrpIuaGv9tG1AhGZTtsxKerMN/+Z8ce
 q06dbGKGwCZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,326,1580803200"; d="scan'208";a="449973813"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga006.fm.intel.com with ESMTP; 30 Mar 2020 16:58:38 -0700
Date: Mon, 30 Mar 2020 19:49:05 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v16 Kernel 4/7] vfio iommu: Implementation of ioctl for
 dirty pages tracking.
Message-ID: <20200330234904.GA6478@joy-OptiPlex-7040>
References: <1585084732-18473-1-git-send-email-kwankhede@nvidia.com>
 <20200325021135.GB20109@joy-OptiPlex-7040>
 <33d38629-aeaf-1c30-26d4-958b998620b0@nvidia.com>
 <20200327003055.GB26419@joy-OptiPlex-7040>
 <0fdf19d4-a45b-d0b1-b630-1ee9df087c15@nvidia.com>
 <20200330020708.GB30683@joy-OptiPlex-7040>
 <20200330144720.18acf66d@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330144720.18acf66d@w520.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
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

On Tue, Mar 31, 2020 at 04:47:20AM +0800, Alex Williamson wrote:
> On Sun, 29 Mar 2020 22:07:08 -0400
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
> > On Fri, Mar 27, 2020 at 01:07:38PM +0800, Kirti Wankhede wrote:
> > > 
> > > 
> > > On 3/27/2020 6:00 AM, Yan Zhao wrote:  
> > > > On Fri, Mar 27, 2020 at 05:39:01AM +0800, Kirti Wankhede wrote:  
> > > >>
> > > >>
> > > >> On 3/25/2020 7:41 AM, Yan Zhao wrote:  
> > > >>> On Wed, Mar 25, 2020 at 05:18:52AM +0800, Kirti Wankhede wrote:  
> > > >>>> VFIO_IOMMU_DIRTY_PAGES ioctl performs three operations:
> > > >>>> - Start dirty pages tracking while migration is active
> > > >>>> - Stop dirty pages tracking.
> > > >>>> - Get dirty pages bitmap. Its user space application's responsibility to
> > > >>>>     copy content of dirty pages from source to destination during migration.
> > > >>>>
> > > >>>> To prevent DoS attack, memory for bitmap is allocated per vfio_dma
> > > >>>> structure. Bitmap size is calculated considering smallest supported page
> > > >>>> size. Bitmap is allocated for all vfio_dmas when dirty logging is enabled
> > > >>>>
> > > >>>> Bitmap is populated for already pinned pages when bitmap is allocated for
> > > >>>> a vfio_dma with the smallest supported page size. Update bitmap from
> > > >>>> pinning functions when tracking is enabled. When user application queries
> > > >>>> bitmap, check if requested page size is same as page size used to
> > > >>>> populated bitmap. If it is equal, copy bitmap, but if not equal, return
> > > >>>> error.
> > > >>>>
> > > >>>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > > >>>> Reviewed-by: Neo Jia <cjia@nvidia.com>
> > > >>>> ---
> > > >>>>    drivers/vfio/vfio_iommu_type1.c | 266 +++++++++++++++++++++++++++++++++++++++-
> > > >>>>    1 file changed, 260 insertions(+), 6 deletions(-)
> > > >>>>
> > > >>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > > >>>> index 70aeab921d0f..874a1a7ae925 100644
> > > >>>> --- a/drivers/vfio/vfio_iommu_type1.c
> > > >>>> +++ b/drivers/vfio/vfio_iommu_type1.c
> > > >>>> @@ -71,6 +71,7 @@ struct vfio_iommu {
> > > >>>>    	unsigned int		dma_avail;
> > > >>>>    	bool			v2;
> > > >>>>    	bool			nesting;
> > > >>>> +	bool			dirty_page_tracking;
> > > >>>>    };
> > > >>>>    
> > > >>>>    struct vfio_domain {
> > > >>>> @@ -91,6 +92,7 @@ struct vfio_dma {
> > > >>>>    	bool			lock_cap;	/* capable(CAP_IPC_LOCK) */
> > > >>>>    	struct task_struct	*task;
> > > >>>>    	struct rb_root		pfn_list;	/* Ex-user pinned pfn list */
> > > >>>> +	unsigned long		*bitmap;
> > > >>>>    };
> > > >>>>    
> > > >>>>    struct vfio_group {
> > > >>>> @@ -125,7 +127,21 @@ struct vfio_regions {
> > > >>>>    #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
> > > >>>>    					(!list_empty(&iommu->domain_list))
> > > >>>>    
> > > >>>> +#define DIRTY_BITMAP_BYTES(n)	(ALIGN(n, BITS_PER_TYPE(u64)) / BITS_PER_BYTE)
> > > >>>> +
> > > >>>> +/*
> > > >>>> + * Input argument of number of bits to bitmap_set() is unsigned integer, which
> > > >>>> + * further casts to signed integer for unaligned multi-bit operation,
> > > >>>> + * __bitmap_set().
> > > >>>> + * Then maximum bitmap size supported is 2^31 bits divided by 2^3 bits/byte,
> > > >>>> + * that is 2^28 (256 MB) which maps to 2^31 * 2^12 = 2^43 (8TB) on 4K page
> > > >>>> + * system.
> > > >>>> + */
> > > >>>> +#define DIRTY_BITMAP_PAGES_MAX	(uint64_t)(INT_MAX - 1)
> > > >>>> +#define DIRTY_BITMAP_SIZE_MAX	 DIRTY_BITMAP_BYTES(DIRTY_BITMAP_PAGES_MAX)
> > > >>>> +
> > > >>>>    static int put_pfn(unsigned long pfn, int prot);
> > > >>>> +static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu);
> > > >>>>    
> > > >>>>    /*
> > > >>>>     * This code handles mapping and unmapping of user data buffers
> > > >>>> @@ -175,6 +191,77 @@ static void vfio_unlink_dma(struct vfio_iommu *iommu, struct vfio_dma *old)
> > > >>>>    	rb_erase(&old->node, &iommu->dma_list);
> > > >>>>    }
> > > >>>>    
> > > >>>> +
> > > >>>> +static int vfio_dma_bitmap_alloc(struct vfio_dma *dma, uint64_t pgsize)
> > > >>>> +{
> > > >>>> +	uint64_t npages = dma->size / pgsize;
> > > >>>> +
> > > >>>> +	if (npages > DIRTY_BITMAP_PAGES_MAX)
> > > >>>> +		return -EINVAL;
> > > >>>> +
> > > >>>> +	dma->bitmap = kvzalloc(DIRTY_BITMAP_BYTES(npages), GFP_KERNEL);
> > > >>>> +	if (!dma->bitmap)
> > > >>>> +		return -ENOMEM;
> > > >>>> +
> > > >>>> +	return 0;
> > > >>>> +}
> > > >>>> +
> > > >>>> +static void vfio_dma_bitmap_free(struct vfio_dma *dma)
> > > >>>> +{
> > > >>>> +	kfree(dma->bitmap);
> > > >>>> +	dma->bitmap = NULL;
> > > >>>> +}
> > > >>>> +
> > > >>>> +static void vfio_dma_populate_bitmap(struct vfio_dma *dma, uint64_t pgsize)
> > > >>>> +{
> > > >>>> +	struct rb_node *p;
> > > >>>> +
> > > >>>> +	if (RB_EMPTY_ROOT(&dma->pfn_list))
> > > >>>> +		return;
> > > >>>> +
> > > >>>> +	for (p = rb_first(&dma->pfn_list); p; p = rb_next(p)) {
> > > >>>> +		struct vfio_pfn *vpfn = rb_entry(p, struct vfio_pfn, node);
> > > >>>> +
> > > >>>> +		bitmap_set(dma->bitmap, (vpfn->iova - dma->iova) / pgsize, 1);
> > > >>>> +	}
> > > >>>> +}
> > > >>>> +
> > > >>>> +static int vfio_dma_bitmap_alloc_all(struct vfio_iommu *iommu, uint64_t pgsize)
> > > >>>> +{
> > > >>>> +	struct rb_node *n = rb_first(&iommu->dma_list);
> > > >>>> +
> > > >>>> +	for (; n; n = rb_next(n)) {
> > > >>>> +		struct vfio_dma *dma = rb_entry(n, struct vfio_dma, node);
> > > >>>> +		int ret;
> > > >>>> +
> > > >>>> +		ret = vfio_dma_bitmap_alloc(dma, pgsize);
> > > >>>> +		if (ret) {
> > > >>>> +			struct rb_node *p = rb_prev(n);
> > > >>>> +
> > > >>>> +			for (; p; p = rb_prev(p)) {
> > > >>>> +				struct vfio_dma *dma = rb_entry(n,
> > > >>>> +							struct vfio_dma, node);
> > > >>>> +
> > > >>>> +				vfio_dma_bitmap_free(dma);
> > > >>>> +			}
> > > >>>> +			return ret;
> > > >>>> +		}
> > > >>>> +		vfio_dma_populate_bitmap(dma, pgsize);
> > > >>>> +	}
> > > >>>> +	return 0;
> > > >>>> +}
> > > >>>> +
> > > >>>> +static void vfio_dma_bitmap_free_all(struct vfio_iommu *iommu)
> > > >>>> +{
> > > >>>> +	struct rb_node *n = rb_first(&iommu->dma_list);
> > > >>>> +
> > > >>>> +	for (; n; n = rb_next(n)) {
> > > >>>> +		struct vfio_dma *dma = rb_entry(n, struct vfio_dma, node);
> > > >>>> +
> > > >>>> +		vfio_dma_bitmap_free(dma);
> > > >>>> +	}
> > > >>>> +}
> > > >>>> +
> > > >>>>    /*
> > > >>>>     * Helper Functions for host iova-pfn list
> > > >>>>     */
> > > >>>> @@ -567,6 +654,18 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
> > > >>>>    			vfio_unpin_page_external(dma, iova, do_accounting);
> > > >>>>    			goto pin_unwind;
> > > >>>>    		}
> > > >>>> +
> > > >>>> +		if (iommu->dirty_page_tracking) {
> > > >>>> +			unsigned long pgshift =
> > > >>>> +					 __ffs(vfio_pgsize_bitmap(iommu));
> > > >>>> +
> > > >>>> +			/*
> > > >>>> +			 * Bitmap populated with the smallest supported page
> > > >>>> +			 * size
> > > >>>> +			 */
> > > >>>> +			bitmap_set(dma->bitmap,
> > > >>>> +				   (vpfn->iova - dma->iova) >> pgshift, 1);
> > > >>>> +		}
> > > >>>>    	}
> > > >>>>    
> > > >>>>    	ret = i;
> > > >>>> @@ -801,6 +900,7 @@ static void vfio_remove_dma(struct vfio_iommu *iommu, struct vfio_dma *dma)
> > > >>>>    	vfio_unmap_unpin(iommu, dma, true);
> > > >>>>    	vfio_unlink_dma(iommu, dma);
> > > >>>>    	put_task_struct(dma->task);
> > > >>>> +	vfio_dma_bitmap_free(dma);
> > > >>>>    	kfree(dma);
> > > >>>>    	iommu->dma_avail++;
> > > >>>>    }
> > > >>>> @@ -831,6 +931,57 @@ static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu)
> > > >>>>    	return bitmap;
> > > >>>>    }
> > > >>>>    
> > > >>>> +static int vfio_iova_dirty_bitmap(struct vfio_iommu *iommu, dma_addr_t iova,
> > > >>>> +				  size_t size, uint64_t pgsize,
> > > >>>> +				  u64 __user *bitmap)
> > > >>>> +{
> > > >>>> +	struct vfio_dma *dma;
> > > >>>> +	unsigned long pgshift = __ffs(pgsize);
> > > >>>> +	unsigned int npages, bitmap_size;
> > > >>>> +
> > > >>>> +	dma = vfio_find_dma(iommu, iova, 1);
> > > >>>> +
> > > >>>> +	if (!dma)
> > > >>>> +		return -EINVAL;
> > > >>>> +
> > > >>>> +	if (dma->iova != iova || dma->size != size)
> > > >>>> +		return -EINVAL;
> > > >>>> +  
> > > >>> Still don't sure if it's a good practice.
> > > >>> I saw the qemu implementation.
> > > >>> Qemu just iterates the whole IOVA address space,
> > > >>> It needs to find IOTLB entry for an IOVA
> > > >>> (1) if it can find an IOTLB for an IOVA, do the DIRTY_PAGES IOCTL and
> > > >>> increment IOVA by (iotlb.addr_mask + 1)
> > > >>>
> > > >>> (2) if no existing IOTLB found, the imrc->translate needs to go searching shadow
> > > >>> page table to try to generate one.
> > > >>> if it still fails,(most probably case, as IOMMU only maps a small part in its address
> > > >>> space).  increment IOVA by 1 page.
> > > >>>
> > > >>> So, if the address space width is 39bit, and if there's only one page
> > > >>> mapped, you still have to translate IOVA for around 2^27 times in each
> > > >>> query. Isn't it too inefficient?
> > > >>>  
> > > >>
> > > >> This is Qemu side implementation, let discuss it on QEMU patches.
> > > >>  
> > > > But kernel has to support it first, right?
> > > >   
> > > 
> > > Shadow page table will be in QEMU (?), as long as we support map and   
> > Yes, shadow page table in QEMU.
> > 
> > > unmap in kernel space, QEMU part of changes should work. That shouldn't 
> > > block kernel side patches.  
> > Not sure whether this assertion is right:)
> > I just want to raise the issue out.
> 
> And I think we need to make sure that we have a path to an efficient
> userspace implementation.  Walking a shadow page table to unmap and
> collect individual dirty bits is clearly better than blindly walking
> every page of a 39 bit address space, but it would be an obvious
> improvement if the QEMU code could zap entire levels at once.
> 
> The issues we raised before about combining multiple bitmaps are not
> insurmountable, they're just complicated and potentially something that
> we can defer for the initial implementation.  We can change the
> implementation of the dirty bitmap without affecting the user, but we
> would need to use another flag bit of the IOMMU_GET_INFO ioctl or expose
> it via the CHECK_EXTENSION ioctl to indicate multi-mapping dirty bitmap
> support.  In fact, the flags field on IOMMU_GET_INFO so far only
> describes fields returned by the ioctl, not support for other ioctls.
> Would the CHECK_EXTENSION ioctl be a better choice for both exposing
> this initial support as well as a v2 when we have multi-mapping?
>
ok.

> > > >>> So, IMHO, why we could not just save an rb tree specific for dirty pages, then generate
> > > >>> a bitmap for each query?  
> 
> I'm curious to know how this might work, I was strongly encouraging
> that we must have a bitmap mechanism that supports copy_to_user(),
> otherwise we don't have an efficient way to push the bits to the user.
> We'd need to copy_from_user() a chunk of their bitmap, set bits, then
> push it back with copy_to_user().  If you're thinking of an rb-tree, do
> we have a node per dirty page?  The overhead for that seem excessive.
hmm, maybe the kernel can allocate a fixed-length buffer that works as a
transmitter for copy_to_user() ?
The sequence is:
1. when dirty bit tracking is on, alloc a fixed length buffer, say, 64k.
2. when a query ioctl comes, searching the rb tree for the queried
range, and filling the fixed length buffer by chunks and copy_to_user()
by chunks as well.
3. when dirty bit tracking is off, free the fixed length buffer.

yes, rb tree takes more memory than bitmap, but it only needs to alloc
nodes for dirty page ranges. e.g. node 1 for range starting with
address A, of size 0x200000, node 2 for range starting with address B,
of size 0x1000, node 3 for range starting with address C, of size
0x7000... as long as they are not overlapping.

for a vm with huge memory, is it still worthwhile?

just an idea, for your consideration :)

> I think we could support multi-mapping dirty bits using __bitmap_and(),
> __bitmap_or(), and __bitmap_shift_left/right() to extract the unaligned
> portion of the bitmap, or it into a previous segment, then shift the
> remainder of the bitmap so that we could use copy_to_user() with it.
> 

> > > >> This is looping back to implentation in v10 - v12 version. There are
> > > >> problems discussed during v10 to v12 version of patches with this approach.
> > > >> - populating dirty bitmap at the time of query will add more CPU cycles.
> > > >> - If we save these CPU cyles means dirty pages need to be tracked when
> > > >> they are pinned or dirtied by CPU, that is, inttoduced per vfio_dma
> > > >> bitmap. If ranges are not vfio_dma aligned, then copying bitmap to user
> > > >> space becomes complicated and unefficient.
> > > >>
> > > >> So we decided to go with the approach implemented here.  
> > > > 
> > > > I checked v12, it's not like what I said.
> > > > In v12, bitmaps are generated per vfio_dma, and combination of the
> > > > bitmaps are required in order to generate a big bitmap suiting for dirty
> > > > query. It can cause problem when offset not aligning.
> > > > But what I propose here is to generate an rb tree orthogonal to the tree
> > > > of vfio_dma.
> > > > 
> > > > as to CPU cycles saving, I don't think iterating/translating page by page
> > > > would achieve that purpose.
> > > > 
> > > >   
> > > 
> > > 
> > >   
> > > >   
> > > >>>  
> > > >>>> +	npages = dma->size >> pgshift;
> > > >>>> +	bitmap_size = DIRTY_BITMAP_BYTES(npages);
> > > >>>> +
> > > >>>> +	/* mark all pages dirty if all pages are pinned and mapped. */
> > > >>>> +	if (dma->iommu_mapped)
> > > >>>> +		bitmap_set(dma->bitmap, 0, npages);
> > > >>>> +
> > > >>>> +	if (copy_to_user((void __user *)bitmap, dma->bitmap, bitmap_size))
> > > >>>> +		return -EFAULT;
> > > >>>> +
> > > >>>> +	/*
> > > >>>> +	 * Re-populate bitmap to include all pinned pages which are considered
> > > >>>> +	 * as dirty but exclude pages which are unpinned and pages which are
> > > >>>> +	 * marked dirty by vfio_dma_rw()
> > > >>>> +	 */
> > > >>>> +	bitmap_clear(dma->bitmap, 0, npages);
> > > >>>> +	vfio_dma_populate_bitmap(dma, pgsize);  
> > > >>> will this also repopulate bitmap for pinned pages set by pass-through devices in
> > > >>> patch 07 ?
> > > >>>  
> > > >>
> > > >> If pass through device's driver pins pages using vfio_pin_pages and all
> > > >> devices in the group pins pages through vfio_pin_pages, then
> > > >> iommu->pinned_page_dirty_scope is set true, then bitmap is repolutated.
> > > >>
> > > >>  
> > > > pass-through devices already have all guest memory pinned, it would have
> > > > no reason to call vfio_pin_pages if not attempting to mark page dirty.
> > > > Then if it calls vfio_pin_pages, it means "the pages are accessed, please
> > > > mark them dirty, feel free to clean it when you get it",  
> > > 
> > > if you see vfio_dma_populate_bitmap() function, then if vfio_pin_pages 
> > > is called, dma->pfn_list rb_tree will be non-empty and bitmap gets 
> > > populates as per pinned pages.
> > >   
> > > > not "the pages will be accesses, please mark them dirty continuously"
> > > >  
> > > 
> > > if vfio_pin_pages is not called, dma->pfn_list is empty, then it returns 
> > > early.
> > > If suppose there are 2 deviced in the group, one is IOMMU backed device 
> > > and other non-IOMMU mdev device. In that case, all pages are pinned, 
> > > iommu->pinned_page_dirty_scope is false, but dma->pfn_list is also not 
> > > empty since non-IOMMU backed device pins pages using external API. We 
> > > still have to populate bitmap according to dma->pfn_list here, because 
> > > in prec-copy phase on first bitmap query, IOMMU backed device might pin 
> > > pages using external API - with that iommu->pinned_page_dirty_scope will 
> > > get updated to 'true', which means during next iteration report pinned 
> > > pages by external API only.
> > >  
> > ok, I previously thought vfio_pin_pages for IOMMU backed device is to set
> > dirty pages after it has write access to them. Looks your intention here
> > is presume pinned pages are dirty so you have to re-fill them until they
> > are unpinned.
> > Maybe you can leave it as is, and we can add mark dirty interface later for
> > the purpose I said above (mark dirty after write access).
> 
> Yes, just as with non-iommu backed devices, pinned pages are assumed to
> be continuously dirtied.  A pin followed by unpin could be used by a
> driver to indicate a transient dirty page, but I think we'd want to
> think about a lower overhead interface when we have such a driver.
> We'd essentially need vfio_dma_rw with only the portion that sets the
> dirty bit on write.  Thanks,
> 
ok. got it.

Thanks
Yan

