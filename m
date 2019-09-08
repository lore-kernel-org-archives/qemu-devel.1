Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB9FC433EF
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 13:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5653218AC
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 13:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5653218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6wx2-0008L5-1F
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 09:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i6wvy-0007ui-0q
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 09:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i6wvv-00063d-2w
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 09:08:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56080)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i6wvu-00061u-6B
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 09:08:47 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9BEA664043
 for <qemu-devel@nongnu.org>; Sun,  8 Sep 2019 13:08:42 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id n59so12454365qtd.8
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2019 06:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Pja32IbTGwhZX+OwlO48I7pE/k9b5WX9DDcE9naEhoM=;
 b=eG9SN1JBncjfODpIY8kp65TGXz0AZMM6oEkbElcPobCnkaqBlqJrL9PG9NzIqEvlpz
 vvbIgGf+Pyuvj7vh4jzkAPWjtX1q7dZt0c7vudPrYNXrFGVcxbzqXa2iWF14xtgP1Gl0
 iaPXF1EyDx85xK9o2JAu1r5ziJ54Bhc+FDJB3yDpF1WS4hmZ1EeA4zMZSj6EwGb8bnqu
 cOVPy592BKqpO1ZltkN5yOlzsPcfkVBAFAbUfCEzrG6wIpMWUScFwExg75nu/l7WBoMl
 qmE+JAkx/e7Sh9hCxqO69lYK6sf4XQAP6q5htXUQMd/G+KI3E5yifVo+3+41Rwcm+RxW
 E88g==
X-Gm-Message-State: APjAAAXG8eupTQGwGmsHUm3hOJUJOP7Bh601UAC0r+VcOScVImPS/zCc
 e4pxhtWjmEVb/vqNS0RGOWqp/j2uvV9ylpJzvztNf1488lWBVTzZnqs8fRcKOC+9yX35wePNT53
 eL3tAwfe5hqH4gvU=
X-Received: by 2002:ac8:5388:: with SMTP id x8mr18635554qtp.26.1567948121998; 
 Sun, 08 Sep 2019 06:08:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxjWnhlSXwG0XiFAywEeW+bgggCzARaanbQ/aTlMX3Jt1OVYpCXwRCCZIHfNoImqIf37nBuyA==
X-Received: by 2002:ac8:5388:: with SMTP id x8mr18635530qtp.26.1567948121803; 
 Sun, 08 Sep 2019 06:08:41 -0700 (PDT)
Received: from redhat.com ([212.92.124.241])
 by smtp.gmail.com with ESMTPSA id a14sm5715220qkg.59.2019.09.08.06.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2019 06:08:41 -0700 (PDT)
Date: Sun, 8 Sep 2019 09:08:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20190908090650-mutt-send-email-mst@kernel.org>
References: <1567815389-18229-1-git-send-email-mjrosato@linux.ibm.com>
 <1567815389-18229-2-git-send-email-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567815389-18229-2-git-send-email-mjrosato@linux.ibm.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/5] vfio: vfio_iommu_type1: linux
 header place holder
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
Cc: walling@linux.ibm.com, alex.williamson@redhat.com, pmorel@linux.ibm.com,
 david@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 06, 2019 at 08:16:25PM -0400, Matthew Rosato wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> This should be copied from Linux kernel UAPI includes.
> The version used here is Linux 5.3.0
> 
> We define a new device region in vfio.h to be able to
> get the ZPCI CLP information by reading this region from
> userland.
> 
> We create a new file, vfio_zdev.h to define the structure
> of the new region we defined in vfio.h
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>


You should add these in scripts/update-linux-headers.sh ,
then run that script.

> ---
>  linux-headers/linux/vfio.h      |  7 ++++---
>  linux-headers/linux/vfio_zdev.h | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 3 deletions(-)
>  create mode 100644 linux-headers/linux/vfio_zdev.h
> 
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 24f5051..8328c87 100644
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
> @@ -371,6 +371,7 @@ struct vfio_region_gfx_edid {
>   * to do TLB invalidation on a GPU.
>   */
>  #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
> +#define VFIO_REGION_SUBTYPE_ZDEV_CLP		(2)
>  
>  /*
>   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
> @@ -914,4 +915,4 @@ struct vfio_iommu_spapr_tce_remove {
>  
>  /* ***************************************************************** */
>  
> -#endif /* VFIO_H */
> +#endif /* _UAPIVFIO_H */
> diff --git a/linux-headers/linux/vfio_zdev.h b/linux-headers/linux/vfio_zdev.h
> new file mode 100644
> index 0000000..2b912a5
> --- /dev/null
> +++ b/linux-headers/linux/vfio_zdev.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Region definition for ZPCI devices
> + *
> + * Copyright IBM Corp. 2019
> + *
> + * Author(s): Pierre Morel <pmorel@linux.ibm.com>
> + */
> +
> +#ifndef _VFIO_ZDEV_H_
> +#define _VFIO_ZDEV_H_
> +
> +#include <linux/types.h>
> +
> +/**
> + * struct vfio_region_zpci_info - ZPCI information.
> + *
> + */
> +struct vfio_region_zpci_info {
> +	__u64 dasm;
> +	__u64 start_dma;
> +	__u64 end_dma;
> +	__u64 msi_addr;
> +	__u64 flags;
> +	__u16 pchid;
> +	__u16 mui;
> +	__u16 noi;
> +	__u16 maxstbl;
> +	__u8 version;
> +	__u8 gid;
> +#define VFIO_PCI_ZDEV_FLAGS_REFRESH 1
> +	__u8 util_str[];
> +} __attribute__ ((__packed__));
> +
> +#endif
> -- 
> 1.8.3.1

