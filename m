Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ACAC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 13:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69BBF21479
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 13:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BBF21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54159 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT5Ea-0001L9-HV
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 09:55:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hT5Cn-0000ER-A0
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hT5B5-0004Is-LK
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:51:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hT5B5-0004IU-HB
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:51:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id t1so20487048qtc.12
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 06:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=TK1+q9ordzXuZZneT1jdBLnWaxfhFR3So8YN5DgmZPE=;
	b=Zy1p9XigdH2PW3+AFETT3cMqTdgw+CfGYhsavvKNS7vOrbpW1W/CYaqt/g2l4WdhYC
	SN91Uc71U+31qNzAdEGn0yxHZi6654INo8+MQuqwDuxDVRx9t1+2kcKi3tn4RL6TKenE
	Q22hyG1CQHBucdjihvQy9GevE5DA7CIxNy/BYr3hOi4kRh71QzuSqaZrCoKYCcquxN2U
	oCjL0dzHoy2Slzs4CIcLjnNqSiEZjzt1bNsWA7zyf86x28VdWRBKoXOHmd5cGqdzLQfI
	L6WfCJqyvds1dm4PnohFC127euckC2VZHAFbdwU9pYwKAQWSSnrjFQvjjVGYB8H/osdW
	n+tA==
X-Gm-Message-State: APjAAAXikv76jtIFsmOnrJPeSiS3v6oOdfUmG8D/5JiVrvUwmlf1uZCv
	YlLWV5hh7UUlPR12nVnCzfZWDQ==
X-Google-Smtp-Source: APXvYqyh4Hn5uFOLIUZJ6Or+HOPTIpSiSFn1uSWJgwWbt4T3Cy3pGgBfYiLTVuICBM9UJLxQWjWXvw==
X-Received: by 2002:ac8:5218:: with SMTP id r24mr28772252qtn.177.1558446698964;
	Tue, 21 May 2019 06:51:38 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	q27sm13106373qtf.27.2019.05.21.06.51.36
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 21 May 2019 06:51:37 -0700 (PDT)
Date: Tue, 21 May 2019 09:51:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <20190521094543-mutt-send-email-mst@kernel.org>
References: <20190521133713.31653-1-pagupta@redhat.com>
	<20190521133713.31653-3-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521133713.31653-3-pagupta@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.194
Subject: Re: [Qemu-devel] [PATCH v10 2/7] virtio-pmem: Add virtio pmem driver
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
Cc: cohuck@redhat.com, jack@suse.cz, kvm@vger.kernel.org, david@redhat.com,
	jasowang@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org,
	virtualization@lists.linux-foundation.org, dm-devel@redhat.com,
	adilger.kernel@dilger.ca, zwisler@kernel.org,
	aarcange@redhat.com, dave.jiang@intel.com, jstaron@google.com,
	linux-nvdimm@lists.01.org, vishal.l.verma@intel.com,
	willy@infradead.org, hch@infradead.org,
	linux-acpi@vger.kernel.org, jmoyer@redhat.com,
	linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl,
	rdunlap@infradead.org, riel@surriel.com, yuval.shaia@oracle.com,
	stefanha@redhat.com, pbonzini@redhat.com,
	dan.j.williams@intel.com, lcapitulino@redhat.com,
	kwolf@redhat.com, nilal@redhat.com, tytso@mit.edu,
	xiaoguangrong.eric@gmail.com, snitzer@redhat.com,
	darrick.wong@oracle.com, rjw@rjwysocki.net,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 21, 2019 at 07:07:08PM +0530, Pankaj Gupta wrote:
> diff --git a/include/uapi/linux/virtio_pmem.h b/include/uapi/linux/virtio_pmem.h
> new file mode 100644
> index 000000000000..7a3e2fe52415
> --- /dev/null
> +++ b/include/uapi/linux/virtio_pmem.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> +/*
> + * Definitions for virtio-pmem devices.
> + *
> + * Copyright (C) 2019 Red Hat, Inc.
> + *
> + * Author(s): Pankaj Gupta <pagupta@redhat.com>
> + */
> +
> +#ifndef _UAPI_LINUX_VIRTIO_PMEM_H
> +#define _UAPI_LINUX_VIRTIO_PMEM_H
> +
> +#include <linux/types.h>
> +#include <linux/virtio_types.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_config.h>
> +
> +struct virtio_pmem_config {
> +	__le64 start;
> +	__le64 size;
> +};
> +

config generally should be __u64.
Are you sure sparse does not complain?


> +#define VIRTIO_PMEM_REQ_TYPE_FLUSH      0
> +
> +struct virtio_pmem_resp {
> +	/* Host return status corresponding to flush request */
> +	__virtio32 ret;
> +};
> +
> +struct virtio_pmem_req {
> +	/* command type */
> +	__virtio32 type;
> +};
> +
> +#endif
> -- 
> 2.20.1

Sorry why are these __virtio32 not __le32?

-- 
MST

