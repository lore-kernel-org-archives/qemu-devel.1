Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20C8C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B826120673
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B826120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD8Fq-0006wI-U3
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 10:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iD8F9-0006P3-LO
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iD8F7-0004zk-6p
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:26:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51832)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iD8F6-0004xh-UT
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:26:09 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E6AAFC01F2E8
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 14:26:06 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id f15so6063898qth.6
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 07:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UpuOBd/BE0QO811ZMzzblsv5BljuyY6JeACU5Klor7U=;
 b=Kwuk8GvYW3fe8afWrmN6I1Q3v8emh6LTA+8kbYOq1LJCrLKKKb4kONXGNeVH9tiD7u
 egCKha9ASJao8Ke0P3zrcWi0BAwuOC97I79dRmUXxH/IzLbR7+awGzFefzbAmFfpz3vc
 aQqe3gDdyNhvFhDHyB4nyrB78wy7IRrc78Svg9KqGsXY/R6OVHQAmCxW9ASG/SSkJ4fa
 8Ie7QX6jEAb9abRRr6r5l94jQN97l3B4LADITf3178JQ8TPYAal/nILNMFPtUXRcmEAc
 QN+MdffShayBjYIMGBACIspk+Bc6LuI3gZt82P0g7BuRNyaQMzBrrzrritNscqJZzHb4
 eMlg==
X-Gm-Message-State: APjAAAXE+OI6dvpWi0Y9yjuHe8EeKhC+++tI06mlKbG27eSW3caL1hYJ
 uUM89ATxSDaksaio64Fx3aiz2j28qaO3DnK5oA17AmSZacNzNHIpkLqCDL2CyCvglbBkhCrz0Ep
 8UEIAiwxNqBEggU4=
X-Received: by 2002:ac8:3743:: with SMTP id p3mr8664769qtb.333.1569421566266; 
 Wed, 25 Sep 2019 07:26:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxKxCWy84YSIVUc3fBZs3JPc9EaeXa/YbzrG/PQLRAs8O2aGVIrPkbCnn5gol/WRHoYusuFyw==
X-Received: by 2002:ac8:3743:: with SMTP id p3mr8664743qtb.333.1569421566015; 
 Wed, 25 Sep 2019 07:26:06 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id e42sm4021779qte.26.2019.09.25.07.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 07:26:05 -0700 (PDT)
Date: Wed, 25 Sep 2019 10:26:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 1/3] virtio: Add virito_fs linux headers
Message-ID: <20190925102352-mutt-send-email-mst@kernel.org>
References: <20190917160057.11847-1-dgilbert@redhat.com>
 <20190917160057.11847-2-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917160057.11847-2-dgilbert@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: mszeredi@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 17, 2019 at 05:00:55PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>

typo in subject

 
> Pull in the virtio_fs.h linux header and the constant for the virtiofs
> ID.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

This isn't how we add this normally, we normally add
the header to update-linux and then run it and add
the result.

In particular if someone reruns update-linux then the
ID will be gone and build will fail.

I suggest we either wait a bit until things land in Linux,
or add these things in a private header for now,
with an eye towards moving when header lands in Linux.



> ---
>  include/standard-headers/linux/virtio_fs.h  | 41 +++++++++++++++++++++
>  include/standard-headers/linux/virtio_ids.h |  1 +
>  2 files changed, 42 insertions(+)
>  create mode 100644 include/standard-headers/linux/virtio_fs.h
> 
> diff --git a/include/standard-headers/linux/virtio_fs.h b/include/standard-headers/linux/virtio_fs.h
> new file mode 100644
> index 0000000000..00bd7a6fa7
> --- /dev/null
> +++ b/include/standard-headers/linux/virtio_fs.h
> @@ -0,0 +1,41 @@
> +#ifndef _LINUX_VIRTIO_FS_H
> +#define _LINUX_VIRTIO_FS_H
> +/* This header is BSD licensed so anyone can use the definitions to implement
> + * compatible drivers/servers.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in the
> + *    documentation and/or other materials provided with the distribution.
> + * 3. Neither the name of IBM nor the names of its contributors
> + *    may be used to endorse or promote products derived from this software
> + *    without specific prior written permission.
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS'' AND
> + * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR CONTRIBUTORS BE LIABLE
> + * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
> + * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
> + * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
> + * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
> + * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
> + * SUCH DAMAGE. */
> +#include "standard-headers/linux/types.h"
> +#include "standard-headers/linux/virtio_ids.h"
> +#include "standard-headers/linux/virtio_config.h"
> +#include "standard-headers/linux/virtio_types.h"
> +
> +struct virtio_fs_config {
> +	/* Filesystem name (UTF-8, not NUL-terminated, padded with NULs) */
> +	uint8_t tag[36];
> +
> +	/* Number of request queues */
> +	uint32_t num_request_queues;
> +} QEMU_PACKED;
> +
> +#endif /* _LINUX_VIRTIO_FS_H */
> diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
> index 32b2f94d1f..73fc004807 100644
> --- a/include/standard-headers/linux/virtio_ids.h
> +++ b/include/standard-headers/linux/virtio_ids.h
> @@ -43,6 +43,7 @@
>  #define VIRTIO_ID_INPUT        18 /* virtio input */
>  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
>  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
> +#define VIRTIO_ID_FS           26 /* virtio filesystem */
>  #define VIRTIO_ID_PMEM         27 /* virtio pmem */
>  
>  #endif /* _LINUX_VIRTIO_IDS_H */
> -- 
> 2.21.0

