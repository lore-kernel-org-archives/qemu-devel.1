Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE28C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 22:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7926C20708
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 22:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezr+cLpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7926C20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWSWm-00017W-HH
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 18:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jWSW2-0000dr-Pw
 for qemu-devel@nongnu.org; Wed, 06 May 2020 18:27:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58013
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jWSW1-0007X2-PF
 for qemu-devel@nongnu.org; Wed, 06 May 2020 18:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588804065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtyZQxIBvrwGclxq/zCovldcHxaVBe7Li+rCCyfx+sE=;
 b=ezr+cLpSjNDC75mJ3AXp92mzUiLKS2JB3jonmZ9JOyNpVoO2OWaMroNmUqrk2+1sv1AgqK
 7fEC764Ewrf0kaLeeIZcGSTzvqUPI+3g+cNDhHRDTLiNagq5r1mxnv2S4oNr1msv2i/+n1
 Jv+HJ+dsewZZ6sEGbugdRtCojGPkGmM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-5x6HgCc7N-mvSSmOZ1TKEg-1; Wed, 06 May 2020 18:27:43 -0400
X-MC-Unique: 5x6HgCc7N-mvSSmOZ1TKEg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 055E78014D9;
 Wed,  6 May 2020 22:27:41 +0000 (UTC)
Received: from w520.home (ovpn-113-95.phx2.redhat.com [10.3.113.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6DCCE1001920;
 Wed,  6 May 2020 22:27:39 +0000 (UTC)
Date: Wed, 6 May 2020 16:27:38 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH Kernel v18 6/7] vfio iommu: Add migration capability to
 report supported features
Message-ID: <20200506162738.6e08dbf2@w520.home>
In-Reply-To: <1588607939-26441-7-git-send-email-kwankhede@nvidia.com>
References: <1588607939-26441-1-git-send-email-kwankhede@nvidia.com>
 <1588607939-26441-7-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 16:22:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

On Mon, 4 May 2020 21:28:58 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Added migration capability in IOMMU info chain.
> User application should check IOMMU info chain for migration capability
> to use dirty page tracking feature provided by kernel module.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 15 +++++++++++++++
>  include/uapi/linux/vfio.h       | 14 ++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 8b27faf1ec38..b38d278d7bff 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2378,6 +2378,17 @@ static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
>  	return ret;
>  }
>  
> +static int vfio_iommu_migration_build_caps(struct vfio_info_cap *caps)
> +{
> +	struct vfio_iommu_type1_info_cap_migration cap_mig;
> +
> +	cap_mig.header.id = VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION;
> +	cap_mig.header.version = 1;
> +	cap_mig.flags = VFIO_IOMMU_INFO_CAPS_MIGRATION_DIRTY_PAGE_TRACK;
> +
> +	return vfio_info_add_capability(caps, &cap_mig.header, sizeof(cap_mig));
> +}
> +
>  static long vfio_iommu_type1_ioctl(void *iommu_data,
>  				   unsigned int cmd, unsigned long arg)
>  {
> @@ -2427,6 +2438,10 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  		if (ret)
>  			return ret;
>  
> +		ret = vfio_iommu_migration_build_caps(&caps);
> +		if (ret)
> +			return ret;
> +
>  		if (caps.size) {
>  			info.flags |= VFIO_IOMMU_INFO_CAPS;
>  
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index e3cbf8b78623..df9ce8aaafab 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1013,6 +1013,20 @@ struct vfio_iommu_type1_info_cap_iova_range {
>  	struct	vfio_iova_range iova_ranges[];
>  };
>  
> +/*
> + * The migration capability allows to report supported features for migration.
> + *
> + * The structures below define version 1 of this capability.
> + */
> +#define VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION  1
> +
> +struct vfio_iommu_type1_info_cap_migration {
> +	struct	vfio_info_cap_header header;
> +	__u32	flags;
> +	/* supports dirty page tracking */
> +#define VFIO_IOMMU_INFO_CAPS_MIGRATION_DIRTY_PAGE_TRACK	(1 << 0)
> +};
> +

What about exposing the maximum supported dirty bitmap size and the
supported page sizes?  Thanks,

Alex

>  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
>  
>  /**


