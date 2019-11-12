Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2309EC17441
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 22:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DED0D2196E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 22:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6Kr3KvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED0D2196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUej1-0005TB-RS
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 17:33:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iUehE-0004AV-98
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 17:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iUehD-0007nT-1j
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 17:31:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43465
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iUehC-0007nN-UF
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 17:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573597894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IFjoCXM3aDjIq+KpZvKaiyfBSifVnRLohoE7M9/BvmA=;
 b=C6Kr3KvD6yn5HwHzG0QiulS5K2EEEl2BzLs/EKNhIQqSsRnxp+vbZsFhzs8O9eQoCxIE1s
 miFdU63LwFJ54DqV442AF2Oq0diGGDoUsi1y2N+fi+2qthN6VWNYgcNgl6d9XmZ8l0Kjjy
 iLF7vXFjkgapO1zTAi/Za1jhncBziVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-mYuiBlk2OPOXKtpPfD_7tQ-1; Tue, 12 Nov 2019 17:30:24 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7332464A7D;
 Tue, 12 Nov 2019 22:30:22 +0000 (UTC)
Received: from x1.home (ovpn-116-138.phx2.redhat.com [10.3.116.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22F1328D3C;
 Tue, 12 Nov 2019 22:30:21 +0000 (UTC)
Date: Tue, 12 Nov 2019 15:30:20 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v9 Kernel 2/5] vfio iommu: Add ioctl defination to get
 dirty pages bitmap.
Message-ID: <20191112153020.71406c44@x1.home>
In-Reply-To: <1573578220-7530-3-git-send-email-kwankhede@nvidia.com>
References: <1573578220-7530-1-git-send-email-kwankhede@nvidia.com>
 <1573578220-7530-3-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: mYuiBlk2OPOXKtpPfD_7tQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Tue, 12 Nov 2019 22:33:37 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> All pages pinned by vendor driver through vfio_pin_pages API should be
> considered as dirty during migration. IOMMU container maintains a list of
> all such pinned pages. Added an ioctl defination to get bitmap of such

definition

> pinned pages for requested IO virtual address range.

Additionally, all mapped pages are considered dirty when physically
mapped through to an IOMMU, modulo we discussed devices opting in to
per page pinning to indicate finer granularity with a TBD mechanism to
figure out if any non-opt-in devices remain.

> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  include/uapi/linux/vfio.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 35b09427ad9f..6fd3822aa610 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -902,6 +902,29 @@ struct vfio_iommu_type1_dma_unmap {
>  #define VFIO_IOMMU_ENABLE=09_IO(VFIO_TYPE, VFIO_BASE + 15)
>  #define VFIO_IOMMU_DISABLE=09_IO(VFIO_TYPE, VFIO_BASE + 16)
> =20
> +/**
> + * VFIO_IOMMU_GET_DIRTY_BITMAP - _IOWR(VFIO_TYPE, VFIO_BASE + 17,
> + *                                     struct vfio_iommu_type1_dirty_bit=
map)
> + *
> + * IOCTL to get dirty pages bitmap for IOMMU container during migration.
> + * Get dirty pages bitmap of given IO virtual addresses range using
> + * struct vfio_iommu_type1_dirty_bitmap. Caller sets argsz, which is siz=
e of
> + * struct vfio_iommu_type1_dirty_bitmap. User should allocate memory to =
get
> + * bitmap and should set size of allocated memory in bitmap_size field.
> + * One bit is used to represent per page consecutively starting from iov=
a
> + * offset. Bit set indicates page at that offset from iova is dirty.
> + */
> +struct vfio_iommu_type1_dirty_bitmap {
> +=09__u32        argsz;
> +=09__u32        flags;
> +=09__u64        iova;                      /* IO virtual address */
> +=09__u64        size;                      /* Size of iova range */
> +=09__u64        bitmap_size;               /* in bytes */

This seems redundant.  We can calculate the size of the bitmap based on
the iova size.

> +=09void __user *bitmap;                    /* one bit per page */

Should we define that as a __u64* to (a) help with the size
calculation, and (b) assure that we can use 8-byte ops on it?

However, who defines page size?  Is it necessarily the processor page
size?  A physical IOMMU may support page sizes other than the CPU page
size.  It might be more important to indicate the expected page size
than the bitmap size.  Thanks,

Alex

> +};
> +
> +#define VFIO_IOMMU_GET_DIRTY_BITMAP             _IO(VFIO_TYPE, VFIO_BASE=
 + 17)
> +
>  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU --------=
 */
> =20
>  /*


