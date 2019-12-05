Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DB2C2D0C0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 23:58:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E35C206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 23:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0kxuN6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E35C206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1id10p-0002B6-Ng
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 18:58:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1id0yD-0008Oo-6m
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 18:55:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1id0yB-0001Ks-Jd
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 18:55:41 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47625
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1id0yB-0001H6-Ac
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 18:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575590138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VIfLIfTffCMFdHpcmASazhIPnOM/rt4yCIY2BsD9K90=;
 b=G0kxuN6oNJa3qjXgldogg+XfzCCZMBtesNPcttFdhwUrV8qIg4WNQ6B57aW73+zVASZadR
 qCm21WobNJgotGM5wn2nckjq5iLjjSRLNJPSWTNvuE9fb2Pt6naAkh0cPSpbNgnycpPNNY
 fiNld3kJKryyEiTvPPF1mPuVw6QkHf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-E6xlXRqJNJOn9F_CW9YAVQ-1; Thu, 05 Dec 2019 18:55:35 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C58E9101F4E1;
 Thu,  5 Dec 2019 23:55:33 +0000 (UTC)
Received: from x1.home (ovpn-116-56.phx2.redhat.com [10.3.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E295F5D6A3;
 Thu,  5 Dec 2019 23:55:30 +0000 (UTC)
Date: Thu, 5 Dec 2019 16:55:30 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [RFC PATCH 4/9] vfio-pci: register default
 dynamic-trap-bar-info region
Message-ID: <20191205165530.1f29fe85@x1.home>
In-Reply-To: <20191205032650.29794-1-yan.y.zhao@intel.com>
References: <20191205032419.29606-1-yan.y.zhao@intel.com>
 <20191205032650.29794-1-yan.y.zhao@intel.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: E6xlXRqJNJOn9F_CW9YAVQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: kevin.tian@intel.com, kvm@vger.kernel.org, libvir-list@redhat.com,
 cohuck@redhat.com, linux-kernel@vger.kernel.org, zhenyuw@linux.intel.com,
 qemu-devel@nongnu.org, shaopeng.he@intel.com, zhi.a.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  4 Dec 2019 22:26:50 -0500
Yan Zhao <yan.y.zhao@intel.com> wrote:

> Dynamic trap bar info region is a channel for QEMU and vendor driver to
> communicate dynamic trap info. It is of type
> VFIO_REGION_TYPE_DYNAMIC_TRAP_BAR_INFO and subtype
> VFIO_REGION_SUBTYPE_DYNAMIC_TRAP_BAR_INFO.
> 
> This region has two fields: dt_fd and trap.
> When QEMU detects a device regions of this type, it will create an
> eventfd and write its eventfd id to dt_fd field.
> When vendor drivre signals this eventfd, QEMU reads trap field of this
> info region.
> - If trap is true, QEMU would search the device's PCI BAR
> regions and disable all the sparse mmaped subregions (if the sparse
> mmaped subregion is disablable).
> - If trap is false, QEMU would re-enable those subregions.
> 
> A typical usage is
> 1. vendor driver first cuts its bar 0 into several sections, all in a
> sparse mmap array. So initally, all its bar 0 are passthroughed.
> 2. vendor driver specifys part of bar 0 sections to be disablable.
> 3. on migration starts, vendor driver signals dt_fd and set trap to true
> to notify QEMU disabling the bar 0 sections of disablable flags on.
> 4. QEMU disables those bar 0 section and hence let vendor driver be able
> to trap access of bar 0 registers and make dirty page tracking possible.
> 5. on migration failure, vendor driver signals dt_fd to QEMU again.
> QEMU reads trap field of this info region which is false and QEMU
> re-passthrough the whole bar 0 region.
> 
> Vendor driver specifies whether it supports dynamic-trap-bar-info region
> through cap VFIO_PCI_DEVICE_CAP_DYNAMIC_TRAP_BAR in
> vfio_pci_mediate_ops->open().
> 
> If vfio-pci detects this cap, it will create a default
> dynamic_trap_bar_info region on behalf of vendor driver with region len=0
> and region->ops=null.
> Vvendor driver should override this region's len, flags, rw, mmap in its
> vfio_pci_mediate_ops.

TBH, I don't like this interface at all.  Userspace doesn't pass data
to the kernel via INFO ioctls.  We have a SET_IRQS ioctl for
configuring user signaling with eventfds.  I think we only need to
define an IRQ type that tells the user to re-evaluate the sparse mmap
information for a region.  The user would enumerate the device IRQs via
GET_IRQ_INFO, find one of this type where the IRQ info would also
indicate which region(s) should be re-evaluated on signaling.  The user
would enable that signaling via SET_IRQS and simply re-evaluate the
sparse mmap capability for the associated regions when signaled.
Thanks,

Alex

> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> 
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci.c | 16 ++++++++++++++++
>  include/linux/vfio.h        |  3 ++-
>  include/uapi/linux/vfio.h   | 11 +++++++++++
>  3 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 059660328be2..62b811ca43e4 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -127,6 +127,19 @@ void init_migration_region(struct vfio_pci_device *vdev)
>  		NULL);
>  }
>  
> +/**
> + * register a region to hold info for dynamically trap bar regions
> + */
> +void init_dynamic_trap_bar_info_region(struct vfio_pci_device *vdev)
> +{
> +	vfio_pci_register_dev_region(vdev,
> +		VFIO_REGION_TYPE_DYNAMIC_TRAP_BAR_INFO,
> +		VFIO_REGION_SUBTYPE_DYNAMIC_TRAP_BAR_INFO,
> +		NULL, 0,
> +		VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_WRITE,
> +		NULL);
> +}
> +
>  static void vfio_pci_probe_mmaps(struct vfio_pci_device *vdev)
>  {
>  	struct resource *res;
> @@ -538,6 +551,9 @@ static int vfio_pci_open(void *device_data)
>  				if (caps & VFIO_PCI_DEVICE_CAP_MIGRATION)
>  					init_migration_region(vdev);
>  
> +				if (caps & VFIO_PCI_DEVICE_CAP_DYNAMIC_TRAP_BAR)
> +					init_dynamic_trap_bar_info_region(vdev);
> +
>  				pr_info("vfio pci found mediate_ops %s, caps=%llx, handle=%x for %x:%x\n",
>  						vdev->mediate_ops->name, caps,
>  						handle, vdev->pdev->vendor,
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index cddea8e9dcb2..cf8ecf687bee 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -197,7 +197,8 @@ extern void vfio_virqfd_disable(struct virqfd **pvirqfd);
>  
>  struct vfio_pci_mediate_ops {
>  	char	*name;
> -#define VFIO_PCI_DEVICE_CAP_MIGRATION (0x01)
> +#define VFIO_PCI_DEVICE_CAP_MIGRATION		(0x01)
> +#define VFIO_PCI_DEVICE_CAP_DYNAMIC_TRAP_BAR	(0x02)
>  	int	(*open)(struct pci_dev *pdev, u64 *caps, u32 *handle);
>  	void	(*release)(int handle);
>  	void	(*get_region_info)(int handle,
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index caf8845a67a6..74a2d0b57741 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -258,6 +258,9 @@ struct vfio_region_info {
>  struct vfio_region_sparse_mmap_area {
>  	__u64	offset;	/* Offset of mmap'able area within region */
>  	__u64	size;	/* Size of mmap'able area */
> +	__u32	disablable;	/* whether this mmap'able are able to
> +				 *  be dynamically disabled
> +				 */
>  };
>  
>  struct vfio_region_info_cap_sparse_mmap {
> @@ -454,6 +457,14 @@ struct vfio_device_migration_info {
>  #define VFIO_DEVICE_DIRTY_PFNS_ALL	(~0ULL)
>  } __attribute__((packed));
>  
> +/* Region type and sub-type to hold info to dynamically trap bars */
> +#define VFIO_REGION_TYPE_DYNAMIC_TRAP_BAR_INFO		(4)
> +#define VFIO_REGION_SUBTYPE_DYNAMIC_TRAP_BAR_INFO	(1)
> +
> +struct vfio_device_dt_bar_info_region {
> +	__u32 dt_fd; /* fd of eventfd to notify qemu trap/untrap bars*/
> +	__u32 trap;   /* trap/untrap bar regions */
> +};
>  
>  /* sub-types for VFIO_REGION_TYPE_PCI_* */
>  


