Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E57C282E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 23:21:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2FCC2171F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 23:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FCC2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34359 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHcp0-0002ox-0p
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 19:21:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hHco4-0002VR-0a
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hHco3-0004hU-3g
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:20:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hHco2-0004gH-UV
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:20:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id v20so6818710qtv.12
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 16:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=hxvaQuDA4In2UgDjNM62/yG7AQGhbLYkWDquXwcq/WQ=;
	b=te+R9oZUj7RyYKRuMry/8YP1KNajuFhNimO4bYrqPLLV6knykS6tM5fMQ58xoBwf7O
	w7ZKFtPG67X3p+GlVPeUKDEQjMK+5rqrM9o3BPE2ZO6Rw+a3ry4MPwW9iIBEidnpA8XM
	aVyBspO+e1pFQ0FuMU2gApfYIXIc/VS2YyuWMb7J4vWrney/2aBN6SQvZ5c0xiq3GouS
	cMG/+2mUADDqXCrVcH1iT04akUdo5ryindd3PoouGzJdcOzfFoH2dbSLmk+GxFOoEJMx
	mZ9MuS274Mi5zq5iidhIIsauyqPd1ZHkRUEVXa1RhCAwVYPCcpzMStIrgfrIAVs0Opjq
	YEYw==
X-Gm-Message-State: APjAAAWHiLTyd/youKt3J+qIyBQ/yWCXY8xJLPt4XeOkN8MLIbvzwlTx
	uw3ddWkjI80SsX7v3PmLK3hxKw==
X-Google-Smtp-Source: APXvYqy5LxYvtVOI5fI1xLqgb3nSli0BIrClIPDTHbkPUcdXm8oGsLNf4j6EP3KotsNBtX05A3pYtQ==
X-Received: by 2002:ac8:21c7:: with SMTP id 7mr5457850qtz.66.1555716025594;
	Fri, 19 Apr 2019 16:20:25 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net.
	[173.76.246.42]) by smtp.gmail.com with ESMTPSA id
	i20sm2908588qkk.70.2019.04.19.16.20.23
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 19 Apr 2019 16:20:24 -0700 (PDT)
Date: Fri, 19 Apr 2019 19:20:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190419191910-mutt-send-email-mst@kernel.org>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411110157.14252-3-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190411110157.14252-3-yuval.shaia@oracle.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.196
Subject: Re: [Qemu-devel] [RFC 2/3] hw/virtio-rdma: VirtIO rdma device
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
Cc: linux-rdma@vger.kernel.org, cohuck@redhat.com, qemu-devel@nongnu.org,
	virtualization@lists.linux-foundation.org, jgg@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419232022.d_Cx4SGExUZBN3bPclGtJWV6hn4KYGhKrGbrKfukxsU@z>

On Thu, Apr 11, 2019 at 02:01:56PM +0300, Yuval Shaia wrote:
> diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
> index 6d5c3b2d4f..bd2c699450 100644
> --- a/include/standard-headers/linux/virtio_ids.h
> +++ b/include/standard-headers/linux/virtio_ids.h
> @@ -43,5 +43,6 @@
>  #define VIRTIO_ID_INPUT        18 /* virtio input */
>  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
>  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
> +#define VIRTIO_ID_RDMA         26 /* virtio crypto */
>  
>  #endif /* _LINUX_VIRTIO_IDS_H */


Please reserve an ID with the virtio TC.
Process:
- create a github issue
- post patch with Fixes: tag
- wait a bit
- if no comments on either ask for a vote

> -- 
> 2.20.1

