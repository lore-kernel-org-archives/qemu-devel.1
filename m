Return-Path: <SRS0=55mG=TM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B26BC04A6B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 18:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FCCB21019
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 18:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCCB21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46014 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPt8L-0008WE-D7
	for qemu-devel@archiver.kernel.org; Sun, 12 May 2019 14:23:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hPt7O-00084M-Bx
	for qemu-devel@nongnu.org; Sun, 12 May 2019 14:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hPt7N-0007cO-7h
	for qemu-devel@nongnu.org; Sun, 12 May 2019 14:22:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hPt7M-0007al-SG
	for qemu-devel@nongnu.org; Sun, 12 May 2019 14:22:37 -0400
Received: by mail-qt1-f196.google.com with SMTP id o7so12345840qtp.4
	for <qemu-devel@nongnu.org>; Sun, 12 May 2019 11:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=f4uBTHcAL8EPsWbws4u7sJLvdbHPyHmRcJrHO/4wdUA=;
	b=U2uaK/qJCywlkXxGG31FQ01a+hWCRfb5xNmCDGTZzM7NmvNk8AUlx8+4XfyFB7AajS
	P0CGANbnQ6tSC396Q0fAfzDWHSDvhzLtIBTXaozJwBsG9pirjtGuRsKaWok+GDJV4Pg2
	9ltmgeQ131MxXmCrOnDXq8WSMTR0WO4WYMP73Ajmbw/wOLck1WVFVBP3qhht+mG4MRhT
	jpjHZercRrqUVOlNewlqQXE98PycxYiYEd//h5Iks+ys9vJHva0wF4nX1UmzSCwo2q1J
	3XPxnVV2OqaMGu1UDkzqMEja9bz5/lTCklltczjbhC+DO0i2txC+zJfKpV1toKw15SGJ
	kI7A==
X-Gm-Message-State: APjAAAVIn1TwMDWK3CXfRnRDgXvjNBOrBflTiXYJHBcWBLFUHSE4jnWY
	QSvLRJYp5jQKffokpdMt5rbwWA==
X-Google-Smtp-Source: APXvYqzjD0WJ28Jr9WrUkhF2EJ5EjV4u+vtYbuX6lBVZZa//5KdQL6nrIuYDxLIB5lfd8ud72dF1eA==
X-Received: by 2002:ac8:2f6c:: with SMTP id k41mr19838786qta.371.1557685356409;
	Sun, 12 May 2019 11:22:36 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	n62sm5735387qkd.76.2019.05.12.11.22.34
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sun, 12 May 2019 11:22:35 -0700 (PDT)
Date: Sun, 12 May 2019 14:22:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <20190512142218-mutt-send-email-mst@kernel.org>
References: <1557499133-24169-1-git-send-email-pmorel@linux.ibm.com>
	<1557499133-24169-2-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557499133-24169-2-git-send-email-pmorel@linux.ibm.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.196
Subject: Re: [Qemu-devel] [PATCH 1/5] vfio: vfio_iommu_type1: linux header
 place holder
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pasic@linux.vnet.ibm.com, david@redhat.com, qemu-s390x@nongnu.org,
	cohuck@redhat.com, walling@linux.ibm.com, qemu-devel@nongnu.org,
	borntraeger@de.ibm.com, alex.williamson@redhat.com,
	pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 10, 2019 at 04:38:49PM +0200, Pierre Morel wrote:
> This should be copied from Linux kernel UAPI includes.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>

pls add a note which linux version did you sync with.

> ---
>  linux-headers/linux/vfio.h | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 12a7b1d..eaecaef 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -9,8 +9,8 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> -#ifndef VFIO_H
> -#define VFIO_H
> +#ifndef _UAPIVFIO_H
> +#define _UAPIVFIO_H
>  
>  #include <linux/types.h>
>  #include <linux/ioctl.h>
> @@ -711,6 +711,16 @@ struct vfio_iommu_type1_info {
>  	__u32	flags;
>  #define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
>  	__u64	iova_pgsizes;		/* Bitmap of supported page sizes */
> +#define VFIO_IOMMU_INFO_CAPABILITIES (1 << 1)  /* support capabilities info */
> +	__u64   cap_offset;     /* Offset within info struct of first cap */
> +};
> +
> +#define VFIO_IOMMU_INFO_CAP_QFN		1
> +#define VFIO_IOMMU_INFO_CAP_QGRP	2
> +
> +struct vfio_iommu_type1_info_block {
> +	struct vfio_info_cap_header header;
> +	__u32 data[];
>  };
>  
>  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
> @@ -910,4 +920,4 @@ struct vfio_iommu_spapr_tce_remove {
>  
>  /* ***************************************************************** */
>  
> -#endif /* VFIO_H */
> +#endif /* _UAPIVFIO_H */
> -- 
> 2.7.4

