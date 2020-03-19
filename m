Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5F0C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 03:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24CCB20722
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 03:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hni2Wwby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CCB20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEm8W-0001MG-5D
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 23:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jEm7C-0000ex-W9
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 23:45:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jEm7B-0006qW-A3
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 23:45:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:50352)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jEm7B-0006ly-1r
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 23:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584589500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V3IrYsm1nDYmYCrl6yeOdU+LoL6XC7ZlPWuzmgcSbtk=;
 b=hni2Wwby6IeMed1xVcMP97rgJOee1yvTSyGyBmkroB4dJvQetl3VUc+ML02/Nxoxj2DXnv
 oU2786DAGvsP/deHWXsfiX86HlWJBy5k/7FnYU8khs5iy71G7bArIZ9Qc6h6ha/Bs/Zbhj
 rCVudX87R6BpBaTYoA4YL2z/TALG3O8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-qH_aF-JePOmZbJ3uP1bOBg-1; Wed, 18 Mar 2020 23:44:56 -0400
X-MC-Unique: qH_aF-JePOmZbJ3uP1bOBg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05FE31857BE0;
 Thu, 19 Mar 2020 03:44:53 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB33F6EF97;
 Thu, 19 Mar 2020 03:44:50 +0000 (UTC)
Date: Wed, 18 Mar 2020 21:44:50 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v14 Kernel 3/7] vfio iommu: Add ioctl definition for
 dirty pages tracking.
Message-ID: <20200318214450.358ca543@w520.home>
In-Reply-To: <1584560474-19946-4-git-send-email-kwankhede@nvidia.com>
References: <1584560474-19946-1-git-send-email-kwankhede@nvidia.com>
 <1584560474-19946-4-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Mar 2020 01:11:10 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> IOMMU container maintains a list of all pages pinned by vfio_pin_pages API.
> All pages pinned by vendor driver through this API should be considered as
> dirty during migration. When container consists of IOMMU capable device and
> all pages are pinned and mapped, then all pages are marked dirty.
> Added support to start/stop pinned and unpinned pages tracking and to get
> bitmap of all dirtied pages for requested IO virtual address range.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  include/uapi/linux/vfio.h | 55 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index d0021467af53..043e9eafb255 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -995,6 +995,12 @@ struct vfio_iommu_type1_dma_map {
>  
>  #define VFIO_IOMMU_MAP_DMA _IO(VFIO_TYPE, VFIO_BASE + 13)
>  
> +struct vfio_bitmap {
> +	__u64        pgsize;	/* page size for bitmap */
> +	__u64        size;	/* in bytes */
> +	__u64 __user *data;	/* one bit per page */
> +};
> +
>  /**
>   * VFIO_IOMMU_UNMAP_DMA - _IOWR(VFIO_TYPE, VFIO_BASE + 14,
>   *							struct vfio_dma_unmap)
> @@ -1021,6 +1027,55 @@ struct vfio_iommu_type1_dma_unmap {
>  #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
>  #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
>  
> +/**
> + * VFIO_IOMMU_DIRTY_PAGES - _IOWR(VFIO_TYPE, VFIO_BASE + 17,
> + *                                     struct vfio_iommu_type1_dirty_bitmap)
> + * IOCTL is used for dirty pages tracking. Caller sets argsz, which is size of
> + * struct vfio_iommu_type1_dirty_bitmap. Caller set flag depend on which
> + * operation to perform, details as below:
> + *
> + * When IOCTL is called with VFIO_IOMMU_DIRTY_PAGES_FLAG_START set, indicates
> + * migration is active and IOMMU module should track pages which are pinned and
> + * could be dirtied by device.

"...should track" pages dirtied or potentially dirtied by devices.

As soon as we add support for Yan's DMA r/w the pinning requirement is
gone, besides pinning is an in-kernel implementation detail, the user
of this interface doesn't know or care which pages are pinned.

> + * Dirty pages are tracked until tracking is stopped by user application by
> + * setting VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP flag.
> + *
> + * When IOCTL is called with VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP set, indicates
> + * IOMMU should stop tracking pinned pages.

s/pinned/dirtied/

> + *
> + * When IOCTL is called with VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP flag set,
> + * IOCTL returns dirty pages bitmap for IOMMU container during migration for
> + * given IOVA range. User must provide data[] as the structure
> + * vfio_iommu_type1_dirty_bitmap_get through which user provides IOVA range and
> + * pgsize. This interface supports to get bitmap of smallest supported pgsize
> + * only and can be modified in future to get bitmap of specified pgsize.
> + * User must allocate memory for bitmap, zero the bitmap memory and set size
> + * of allocated memory in bitmap_size field. One bit is used to represent one
> + * page consecutively starting from iova offset. User should provide page size
> + * in 'pgsize'. Bit set in bitmap indicates page at that offset from iova is
> + * dirty. Caller must set argsz including size of structure
> + * vfio_iommu_type1_dirty_bitmap_get.
> + *
> + * Only one flag should be set at a time.

"Only one of the flags _START, _STOP, and _GET maybe be specified at a
time."  IOW, let's not presume what yet undefined flags may do.
Hopefully this addresses Dave's concern.

> + *
> + */
> +struct vfio_iommu_type1_dirty_bitmap {
> +	__u32        argsz;
> +	__u32        flags;
> +#define VFIO_IOMMU_DIRTY_PAGES_FLAG_START	(1 << 0)
> +#define VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP	(1 << 1)
> +#define VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP	(1 << 2)
> +	__u8         data[];
> +};
> +
> +struct vfio_iommu_type1_dirty_bitmap_get {
> +	__u64              iova;	/* IO virtual address */
> +	__u64              size;	/* Size of iova range */
> +	struct vfio_bitmap bitmap;
> +};
> +
> +#define VFIO_IOMMU_DIRTY_PAGES             _IO(VFIO_TYPE, VFIO_BASE + 17)
> +
>  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
>  
>  /*


