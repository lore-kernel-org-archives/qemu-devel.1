Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4A3C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B07BE206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07BE206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZXTy-0003dn-UG
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 06:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jZXNu-0006G8-Fl
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:16:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:10345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jZXNr-0002bW-RJ
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:16:05 -0400
IronPort-SDR: TrgG/B6TxMysdtt9hes3uRBfGtEvVGebmpNBz+LXAFzb11+Ri0sxbPFm8YkYZ1GrSr+NrCU9ty
 CaiJTQw55oxQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2020 03:15:54 -0700
IronPort-SDR: opdi22F2y2voA/JCAVTJVY6uvjL3jDV02VVvJvYLV0Iy7VeRCDpcAYm60yL9oqsqMhr+ou4jy5
 X5+DDUylYMWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,394,1583222400"; d="scan'208";a="263147090"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga003.jf.intel.com with ESMTP; 15 May 2020 03:15:46 -0700
Date: Fri, 15 May 2020 06:05:54 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH Kernel v20 5/8] vfio iommu: Implementation of ioctl for
 dirty pages tracking
Message-ID: <20200515100553.GA5559@joy-OptiPlex-7040>
References: <1589488667-9683-1-git-send-email-kwankhede@nvidia.com>
 <1589488667-9683-6-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589488667-9683-6-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=134.134.136.31; envelope-from=yan.y.zhao@intel.com;
 helo=mga06.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 06:15:54
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, alex.williamson@redhat.com,
 eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com,
 changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 15, 2020 at 02:07:44AM +0530, Kirti Wankhede wrote:
> VFIO_IOMMU_DIRTY_PAGES ioctl performs three operations:
> - Start dirty pages tracking while migration is active
> - Stop dirty pages tracking.
> - Get dirty pages bitmap. Its user space application's responsibility to
>   copy content of dirty pages from source to destination during migration.
> 
> To prevent DoS attack, memory for bitmap is allocated per vfio_dma
> structure. Bitmap size is calculated considering smallest supported page
> size. Bitmap is allocated for all vfio_dmas when dirty logging is enabled
> 
> Bitmap is populated for already pinned pages when bitmap is allocated for
> a vfio_dma with the smallest supported page size. Update bitmap from
> pinning functions when tracking is enabled. When user application queries
> bitmap, check if requested page size is same as page size used to
> populated bitmap. If it is equal, copy bitmap, but if not equal, return
> error.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> 
> Fixed error reported by build bot by changing pgsize type from uint64_t
> to size_t.
> Reported-by: kbuild test robot <lkp@intel.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 294 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 288 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index de17787ffece..b76d3b14abfd 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -72,6 +72,7 @@ struct vfio_iommu {
>  	uint64_t		pgsize_bitmap;
>  	bool			v2;
>  	bool			nesting;
> +	bool			dirty_page_tracking;
>  };
>  
>  struct vfio_domain {
> @@ -92,6 +93,7 @@ struct vfio_dma {
>  	bool			lock_cap;	/* capable(CAP_IPC_LOCK) */
>  	struct task_struct	*task;
>  	struct rb_root		pfn_list;	/* Ex-user pinned pfn list */
> +	unsigned long		*bitmap;
>  };
>  
>  struct vfio_group {
> @@ -126,6 +128,19 @@ struct vfio_regions {
>  #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
>  					(!list_empty(&iommu->domain_list))
>  
> +#define DIRTY_BITMAP_BYTES(n)	(ALIGN(n, BITS_PER_TYPE(u64)) / BITS_PER_BYTE)
> +
> +/*
> + * Input argument of number of bits to bitmap_set() is unsigned integer, which
> + * further casts to signed integer for unaligned multi-bit operation,
> + * __bitmap_set().
> + * Then maximum bitmap size supported is 2^31 bits divided by 2^3 bits/byte,
> + * that is 2^28 (256 MB) which maps to 2^31 * 2^12 = 2^43 (8TB) on 4K page
> + * system.
> + */
> +#define DIRTY_BITMAP_PAGES_MAX	 ((u64)INT_MAX)
> +#define DIRTY_BITMAP_SIZE_MAX	 DIRTY_BITMAP_BYTES(DIRTY_BITMAP_PAGES_MAX)
> +
>  static int put_pfn(unsigned long pfn, int prot);
>  
>  /*
> @@ -176,6 +191,74 @@ static void vfio_unlink_dma(struct vfio_iommu *iommu, struct vfio_dma *old)
>  	rb_erase(&old->node, &iommu->dma_list);
>  }
>  
> +
> +static int vfio_dma_bitmap_alloc(struct vfio_dma *dma, size_t pgsize)
> +{
> +	uint64_t npages = dma->size / pgsize;
> +
> +	if (npages > DIRTY_BITMAP_PAGES_MAX)
> +		return -EINVAL;
> +
> +	dma->bitmap = kvzalloc(DIRTY_BITMAP_BYTES(npages), GFP_KERNEL);
> +	if (!dma->bitmap)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void vfio_dma_bitmap_free(struct vfio_dma *dma)
> +{
> +	kfree(dma->bitmap);
> +	dma->bitmap = NULL;
> +}
> +
> +static void vfio_dma_populate_bitmap(struct vfio_dma *dma, size_t pgsize)
> +{
> +	struct rb_node *p;
> +
> +	for (p = rb_first(&dma->pfn_list); p; p = rb_next(p)) {
> +		struct vfio_pfn *vpfn = rb_entry(p, struct vfio_pfn, node);
> +
> +		bitmap_set(dma->bitmap, (vpfn->iova - dma->iova) / pgsize, 1);
> +	}
> +}
> +
> +static int vfio_dma_bitmap_alloc_all(struct vfio_iommu *iommu, size_t pgsize)
> +{
> +	struct rb_node *n = rb_first(&iommu->dma_list);
> +
> +	for (; n; n = rb_next(n)) {
> +		struct vfio_dma *dma = rb_entry(n, struct vfio_dma, node);
> +		int ret;
> +
> +		ret = vfio_dma_bitmap_alloc(dma, pgsize);
> +		if (ret) {
> +			struct rb_node *p = rb_prev(n);
> +
> +			for (; p; p = rb_prev(p)) {
> +				struct vfio_dma *dma = rb_entry(n,
> +							struct vfio_dma, node);
> +
> +				vfio_dma_bitmap_free(dma);
> +			}
> +			return ret;
> +		}
> +		vfio_dma_populate_bitmap(dma, pgsize);
> +	}
> +	return 0;
> +}
> +
> +static void vfio_dma_bitmap_free_all(struct vfio_iommu *iommu)
> +{
> +	struct rb_node *n = rb_first(&iommu->dma_list);
> +
> +	for (; n; n = rb_next(n)) {
> +		struct vfio_dma *dma = rb_entry(n, struct vfio_dma, node);
> +
> +		vfio_dma_bitmap_free(dma);
> +	}
> +}
> +
>  /*
>   * Helper Functions for host iova-pfn list
>   */
> @@ -568,6 +651,17 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
>  			vfio_unpin_page_external(dma, iova, do_accounting);
>  			goto pin_unwind;
>  		}
> +
> +		if (iommu->dirty_page_tracking) {
> +			unsigned long pgshift = __ffs(iommu->pgsize_bitmap);
> +
> +			/*
> +			 * Bitmap populated with the smallest supported page
> +			 * size
> +			 */
> +			bitmap_set(dma->bitmap,
> +				   (vpfn->iova - dma->iova) >> pgshift, 1);
> +		}
>  	}
>  
>  	ret = i;
> @@ -802,6 +896,7 @@ static void vfio_remove_dma(struct vfio_iommu *iommu, struct vfio_dma *dma)
>  	vfio_unmap_unpin(iommu, dma, true);
>  	vfio_unlink_dma(iommu, dma);
>  	put_task_struct(dma->task);
> +	vfio_dma_bitmap_free(dma);
>  	kfree(dma);
>  	iommu->dma_avail++;
>  }
> @@ -829,6 +924,80 @@ static void vfio_pgsize_bitmap(struct vfio_iommu *iommu)
>  	}
>  }
>  
> +static int update_user_bitmap(u64 __user *bitmap, struct vfio_dma *dma,
> +			      dma_addr_t base_iova, size_t pgsize)
> +{
> +	unsigned long pgshift = __ffs(pgsize);
> +	unsigned long nbits = dma->size >> pgshift;
> +	unsigned long bit_offset = (dma->iova - base_iova) >> pgshift;
> +	unsigned long copy_offset = bit_offset / BITS_PER_LONG;
> +	unsigned long shift = bit_offset % BITS_PER_LONG;
> +	unsigned long leftover;
> +
> +	if (shift) {
> +		bitmap_shift_left(dma->bitmap, dma->bitmap, shift,
> +				  nbits + shift);
> +
> +		if (copy_from_user(&leftover, (u64 *)bitmap + copy_offset,
> +				   sizeof(leftover)))
> +			return -EFAULT;
> +
> +		bitmap_or(dma->bitmap, dma->bitmap, &leftover, shift);
> +	}
> +
> +	if (copy_to_user((u64 *)bitmap + copy_offset, dma->bitmap,
> +			 DIRTY_BITMAP_BYTES(nbits + shift)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int vfio_iova_dirty_bitmap(u64 __user *bitmap, struct vfio_iommu *iommu,
> +				  dma_addr_t iova, size_t size, size_t pgsize)
> +{
> +	struct vfio_dma *dma;
> +	dma_addr_t i = iova, limit = iova + size;
> +	unsigned long pgshift = __ffs(pgsize);
> +	size_t sz = size;
> +	int ret;
> +
> +	while ((dma = vfio_find_dma(iommu, i, sz))) {
not quite get the logic here.
if (i, i + size) is intersecting with (dma->iova, dma->iova + dma->size),
and a dma is found here, why the whole bitmap is cleared and copied?

Thanks
Yan
> +
> +		/* mark all pages dirty if all pages are pinned and mapped. */
> +		if (dma->iommu_mapped)
> +			bitmap_set(dma->bitmap, 0, dma->size >> pgshift);
> +
> +		ret = update_user_bitmap(bitmap, dma, iova, pgsize);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * Re-populate bitmap to include all pinned pages which are
> +		 * considered as dirty but exclude pages which are unpinned and
> +		 * pages which are marked dirty by vfio_dma_rw()
> +		 */
> +		bitmap_clear(dma->bitmap, 0, dma->size >> pgshift);
> +		vfio_dma_populate_bitmap(dma, pgsize);
> +
> +		i = dma->iova + dma->size;
> +		if (i >= limit)
> +			break;
> +
> +		sz = limit - i;
> +	}
> +
> +	return 0;
> +}
> +
> +static int verify_bitmap_size(uint64_t npages, uint64_t bitmap_size)
> +{
> +	if (!npages || !bitmap_size || (bitmap_size > DIRTY_BITMAP_SIZE_MAX) ||
> +	    (bitmap_size < DIRTY_BITMAP_BYTES(npages)))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  			     struct vfio_iommu_type1_dma_unmap *unmap)
>  {
> @@ -1046,7 +1215,7 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
>  	unsigned long vaddr = map->vaddr;
>  	size_t size = map->size;
>  	int ret = 0, prot = 0;
> -	uint64_t mask;
> +	size_t pgsize;
>  	struct vfio_dma *dma;
>  
>  	/* Verify that none of our __u64 fields overflow */
> @@ -1061,11 +1230,11 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
>  
>  	mutex_lock(&iommu->lock);
>  
> -	mask = ((uint64_t)1 << __ffs(iommu->pgsize_bitmap)) - 1;
> +	pgsize = (size_t)1 << __ffs(iommu->pgsize_bitmap);
>  
> -	WARN_ON(mask & PAGE_MASK);
> +	WARN_ON((pgsize - 1) & PAGE_MASK);
>  
> -	if (!prot || !size || (size | iova | vaddr) & mask) {
> +	if (!prot || !size || (size | iova | vaddr) & (pgsize - 1)) {
>  		ret = -EINVAL;
>  		goto out_unlock;
>  	}
> @@ -1142,6 +1311,12 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
>  	else
>  		ret = vfio_pin_map_dma(iommu, dma, size);
>  
> +	if (!ret && iommu->dirty_page_tracking) {
> +		ret = vfio_dma_bitmap_alloc(dma, pgsize);
> +		if (ret)
> +			vfio_remove_dma(iommu, dma);
> +	}
> +
>  out_unlock:
>  	mutex_unlock(&iommu->lock);
>  	return ret;
> @@ -2288,6 +2463,104 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  
>  		return copy_to_user((void __user *)arg, &unmap, minsz) ?
>  			-EFAULT : 0;
> +	} else if (cmd == VFIO_IOMMU_DIRTY_PAGES) {
> +		struct vfio_iommu_type1_dirty_bitmap dirty;
> +		uint32_t mask = VFIO_IOMMU_DIRTY_PAGES_FLAG_START |
> +				VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP |
> +				VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP;
> +		int ret = 0;
> +
> +		if (!iommu->v2)
> +			return -EACCES;
> +
> +		minsz = offsetofend(struct vfio_iommu_type1_dirty_bitmap,
> +				    flags);
> +
> +		if (copy_from_user(&dirty, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (dirty.argsz < minsz || dirty.flags & ~mask)
> +			return -EINVAL;
> +
> +		/* only one flag should be set at a time */
> +		if (__ffs(dirty.flags) != __fls(dirty.flags))
> +			return -EINVAL;
> +
> +		if (dirty.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_START) {
> +			size_t pgsize;
> +
> +			mutex_lock(&iommu->lock);
> +			pgsize = 1 << __ffs(iommu->pgsize_bitmap);
> +			if (!iommu->dirty_page_tracking) {
> +				ret = vfio_dma_bitmap_alloc_all(iommu, pgsize);
> +				if (!ret)
> +					iommu->dirty_page_tracking = true;
> +			}
> +			mutex_unlock(&iommu->lock);
> +			return ret;
> +		} else if (dirty.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP) {
> +			mutex_lock(&iommu->lock);
> +			if (iommu->dirty_page_tracking) {
> +				iommu->dirty_page_tracking = false;
> +				vfio_dma_bitmap_free_all(iommu);
> +			}
> +			mutex_unlock(&iommu->lock);
> +			return 0;
> +		} else if (dirty.flags &
> +				 VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP) {
> +			struct vfio_iommu_type1_dirty_bitmap_get range;
> +			unsigned long pgshift;
> +			size_t data_size = dirty.argsz - minsz;
> +			size_t iommu_pgsize;
> +
> +			if (!data_size || data_size < sizeof(range))
> +				return -EINVAL;
> +
> +			if (copy_from_user(&range, (void __user *)(arg + minsz),
> +					   sizeof(range)))
> +				return -EFAULT;
> +
> +			if (range.iova + range.size < range.iova)
> +				return -EINVAL;
> +			if (!access_ok((void __user *)range.bitmap.data,
> +				       range.bitmap.size))
> +				return -EINVAL;
> +
> +			pgshift = __ffs(range.bitmap.pgsize);
> +			ret = verify_bitmap_size(range.size >> pgshift,
> +						 range.bitmap.size);
> +			if (ret)
> +				return ret;
> +
> +			mutex_lock(&iommu->lock);
> +
> +			iommu_pgsize = (size_t)1 << __ffs(iommu->pgsize_bitmap);
> +
> +			/* allow only smallest supported pgsize */
> +			if (range.bitmap.pgsize != iommu_pgsize) {
> +				ret = -EINVAL;
> +				goto out_unlock;
> +			}
> +			if (range.iova & (iommu_pgsize - 1)) {
> +				ret = -EINVAL;
> +				goto out_unlock;
> +			}
> +			if (!range.size || range.size & (iommu_pgsize - 1)) {
> +				ret = -EINVAL;
> +				goto out_unlock;
> +			}
> +
> +			if (iommu->dirty_page_tracking)
> +				ret = vfio_iova_dirty_bitmap(range.bitmap.data,
> +						iommu, range.iova, range.size,
> +						range.bitmap.pgsize);
> +			else
> +				ret = -EINVAL;
> +out_unlock:
> +			mutex_unlock(&iommu->lock);
> +
> +			return ret;
> +		}
>  	}
>  
>  	return -ENOTTY;
> @@ -2355,10 +2628,19 @@ static int vfio_iommu_type1_dma_rw_chunk(struct vfio_iommu *iommu,
>  
>  	vaddr = dma->vaddr + offset;
>  
> -	if (write)
> +	if (write) {
>  		*copied = copy_to_user((void __user *)vaddr, data,
>  					 count) ? 0 : count;
> -	else
> +		if (*copied && iommu->dirty_page_tracking) {
> +			unsigned long pgshift = __ffs(iommu->pgsize_bitmap);
> +			/*
> +			 * Bitmap populated with the smallest supported page
> +			 * size
> +			 */
> +			bitmap_set(dma->bitmap, offset >> pgshift,
> +				   *copied >> pgshift);
> +		}
> +	} else
>  		*copied = copy_from_user(data, (void __user *)vaddr,
>  					   count) ? 0 : count;
>  	if (kthread)
> -- 
> 2.7.0
> 

