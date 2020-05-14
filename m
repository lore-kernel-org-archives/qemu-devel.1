Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97490C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:02:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 616FA205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AhHBCjCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616FA205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ61F-00031w-7y
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 01:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jZ60W-0002cD-SC
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:02:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52012
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jZ60V-0006rK-1k
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589432524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LGl3hQ6jGEPFYk2qkojWn52Vuj/W0QDDdOeJbURBeJE=;
 b=AhHBCjCBsrHr+6jlfsQU/aW0ODWw8S8BN5FK7/6xuPxS2mHlwzfKl6sKSh/6z3l6rdoTuh
 fP/+RCme/DMA2BCbcOTLHwSLS9u8w4ciToM5t8FV60zbzlUZ13RWyyVWVaBKchgUKDWh/Q
 JTzvS5CvZR5EaqAS/QLBCZE8Ug8xIog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-tdxmD7RlMoaXV6xooKYw7Q-1; Thu, 14 May 2020 01:02:00 -0400
X-MC-Unique: tdxmD7RlMoaXV6xooKYw7Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2200E106B207;
 Thu, 14 May 2020 05:01:58 +0000 (UTC)
Received: from x1.home (ovpn-113-111.phx2.redhat.com [10.3.113.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E2EC55D9C5;
 Thu, 14 May 2020 05:01:53 +0000 (UTC)
Date: Wed, 13 May 2020 23:01:53 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH Kernel v19 7/8] vfio iommu: Add migration capability to
 report supported features
Message-ID: <20200513230153.0b5f3729@x1.home>
In-Reply-To: <1589400279-28522-8-git-send-email-kwankhede@nvidia.com>
References: <1589400279-28522-1-git-send-email-kwankhede@nvidia.com>
 <1589400279-28522-8-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On Thu, 14 May 2020 01:34:38 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Added migration capability in IOMMU info chain.
> User application should check IOMMU info chain for migration capability
> to use dirty page tracking feature provided by kernel module.
> User application must check page sizes supported and maximum dirty
> bitmap size returned by this capability structure for ioctls used to get
> dirty bitmap.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 24 +++++++++++++++++++++++-
>  include/uapi/linux/vfio.h       | 21 +++++++++++++++++++++
>  2 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 4358be26ff80..77351497a9c2 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2389,6 +2389,22 @@ static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
>  	return ret;
>  }
>  
> +static int vfio_iommu_migration_build_caps(struct vfio_iommu *iommu,
> +					   struct vfio_info_cap *caps)
> +{
> +	struct vfio_iommu_type1_info_cap_migration cap_mig;
> +
> +	cap_mig.header.id = VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION;
> +	cap_mig.header.version = 1;
> +	cap_mig.flags = VFIO_IOMMU_INFO_CAPS_MIGRATION_DIRTY_PAGE_TRACK;
> +
> +	/* support minimum pgsize */
> +	cap_mig.pgsize_bitmap = (size_t)1 << __ffs(iommu->pgsize_bitmap);
> +	cap_mig.max_dirty_bitmap_size = DIRTY_BITMAP_SIZE_MAX;
> +
> +	return vfio_info_add_capability(caps, &cap_mig.header, sizeof(cap_mig));
> +}
> +
>  static long vfio_iommu_type1_ioctl(void *iommu_data,
>  				   unsigned int cmd, unsigned long arg)
>  {
> @@ -2433,10 +2449,16 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  		mutex_lock(&iommu->lock);
>  		info.flags = VFIO_IOMMU_INFO_PGSIZES;
>  
> +		vfio_pgsize_bitmap(iommu);


Why is it necessary to rebuild the bitmap here?  The user can't get to
this ioctl until they've added a group to the container and set the
IOMMU model.


>  		info.iova_pgsizes = iommu->pgsize_bitmap;
>  
> -		ret = vfio_iommu_iova_build_caps(iommu, &caps);
> +		ret = vfio_iommu_migration_build_caps(iommu, &caps);
> +
> +		if (!ret)
> +			ret = vfio_iommu_iova_build_caps(iommu, &caps);
> +
>  		mutex_unlock(&iommu->lock);
> +
>  		if (ret)
>  			return ret;
>  
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index e3cbf8b78623..c90604322798 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1013,6 +1013,27 @@ struct vfio_iommu_type1_info_cap_iova_range {
>  	struct	vfio_iova_range iova_ranges[];
>  };
>  
> +/*
> + * The migration capability allows to report supported features for migration.
> + *
> + * The structures below define version 1 of this capability.
> + *
> + * pgsize_bitmap: Kernel driver returns supported page sizes bitmap for dirty
> + * page tracking.
> + * max_dirty_bitmap_size: Kernel driver returns maximum supported dirty bitmap
> + * size in bytes to be used by user application for ioctls to get dirty bitmap.
> + */
> +#define VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION  1
> +
> +struct vfio_iommu_type1_info_cap_migration {
> +	struct	vfio_info_cap_header header;
> +	__u32	flags;
> +	/* supports dirty page tracking */
> +#define VFIO_IOMMU_INFO_CAPS_MIGRATION_DIRTY_PAGE_TRACK	(1 << 0)

This flag is a bit redundant to the purpose of this capability, isn't
it?  I think exposing the capability itself is indicating support for
dirty page tracking.  We should probably be explicit in the comment
about exactly what interface this capability implies.  Thanks,

Alex

> +	__u64	pgsize_bitmap;
> +	__u64	max_dirty_bitmap_size;		/* in bytes */
> +};
> +
>  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
>  
>  /**


