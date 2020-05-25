Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FE0C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 14:43:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F27A2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 14:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkZdjVff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F27A2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdEJw-0004cy-7X
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 10:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jdEIQ-0003fs-G2
 for qemu-devel@nongnu.org; Mon, 25 May 2020 10:41:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41916
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jdEIK-0001Yq-Tj
 for qemu-devel@nongnu.org; Mon, 25 May 2020 10:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590417694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sqkg1jDCwm+p6v+Tu6WyELF7ni9j35HF99yDHkpEXsw=;
 b=hkZdjVffJr4y4sHihbL87sTZzG9+J27GK8v4Oa59mBAFQevjQro8e1MiGr/t/j8IJk2VPc
 epbSFlCUgbtcOHyYI9KWkJGjSe4Cbag5O7GTSU1lGgov1tqZUNCepsHjIrDl+6tWVN0AnR
 5/vyMZCciANSnovLp/OXsFn7b4UaHG8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-zHspUxfPMe23EkzGUFNbPQ-1; Mon, 25 May 2020 10:41:31 -0400
X-MC-Unique: zHspUxfPMe23EkzGUFNbPQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 856F0800688;
 Mon, 25 May 2020 14:41:28 +0000 (UTC)
Received: from gondolin (ovpn-112-215.ams2.redhat.com [10.36.112.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E12B6ED99;
 Mon, 25 May 2020 14:41:21 +0000 (UTC)
Date: Mon, 25 May 2020 16:41:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH Kernel v23 4/8] vfio iommu: Add ioctl definition for
 dirty pages tracking
Message-ID: <20200525164117.7d078845.cohuck@redhat.com>
In-Reply-To: <1589998088-3250-5-git-send-email-kwankhede@nvidia.com>
References: <1589998088-3250-1-git-send-email-kwankhede@nvidia.com>
 <1589998088-3250-5-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 02:40:56
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
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, cjia@nvidia.com,
 kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 alex.williamson@redhat.com, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 May 2020 23:38:04 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> IOMMU container maintains a list of all pages pinned by vfio_pin_pages API.
> All pages pinned by vendor driver through this API should be considered as
> dirty during migration. When container consists of IOMMU capable device and
> all pages are pinned and mapped, then all pages are marked dirty.
> Added support to start/stop dirtied pages tracking and to get bitmap of all
> dirtied pages for requested IO virtual address range.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  include/uapi/linux/vfio.h | 56 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)

(...)

> +/**
> + * VFIO_IOMMU_DIRTY_PAGES - _IOWR(VFIO_TYPE, VFIO_BASE + 17,
> + *                                     struct vfio_iommu_type1_dirty_bitmap)
> + * IOCTL is used for dirty pages logging.
> + * Caller should set flag depending on which operation to perform, details as
> + * below:
> + *
> + * Calling the IOCTL with VFIO_IOMMU_DIRTY_PAGES_FLAG_START flag set, instructs
> + * the IOMMU driver to log pages that are dirtied or potentially dirtied by
> + * device; designed to be used when a migration is in progress. Dirty pages are

s/device/the device/

> + * loggeded until logging is disabled by user application by calling the IOCTL

s/loggeded/logged/

> + * with VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP flag.
> + *
> + * Calling the IOCTL with VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP flag set, instructs
> + * the IOMMU driver to stop logging dirtied pages.
> + *
> + * Calling the IOCTL with VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP flag set
> + * returns the dirty pages bitmap for IOMMU container for a given IOVA range.
> + * User must specify the IOVA range and the pgsize through the structure

s/User/The user/

> + * vfio_iommu_type1_dirty_bitmap_get in the data[] portion. This interface
> + * supports to get bitmap of smallest supported pgsize only and can be modified

s/to get/getting a/

s/smallest/the smallest/

> + * in future to get bitmap of specified pgsize. The user must provide a zeroed

"a bitmap of any specified supported pgsize" ?

> + * memory area for the bitmap memory and specify its size in bitmap.size.
> + * One bit is used to represent one page consecutively starting from iova
> + * offset. The user should provide page size in bitmap.pgsize field. A bit set
> + * in the bitmap indicates that the page at that offset from iova is dirty.
> + * The caller must set argsz to a value including the size of structure
> + * vfio_iommu_type1_dirty_bitmap_get, but excluding the size of the actual
> + * bitmap. If dirty pages logging is not enabled, an error will be returned.

(...)

With the nits fixed,
Reviewed-by: Cornelia Huck <cohuck@redhat.com>


