Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F971C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 13:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33897218FD
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 13:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33897218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42082 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJIOP-0002E0-CT
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 09:56:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hJILt-0008ST-GX
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hJIJ7-0004Rl-Rv
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:51:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hJIJ7-0004Q0-Np
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:51:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id y49so1592393qta.7
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=KCU0XMiRPR5NCaUwFlSTFEEkQnbIzYLCELzyEEkHYqA=;
	b=Yo8pVkbR9+4rbovetNYy26h/nZIzUDUzpRK+05Hs/9dr1WaC+y/mhdefz5Uo/kjdrH
	b0ID7Q+SOuB0Pg49I5PqsVfVQyWc8NIstnxmY7u5Q/8zKqPKdpUyjb9zWPGIO5H1rQLz
	Tyh+f/MelMrJ9pHFljHJSbFxyRMh2be92no6BINAGCtMGetUqqqabR1AM7rc5woo+Nu0
	+73X9SBQJXJ3AZuu5eftXS+S3jVUkaOJL0rtobOq+4yXSQpUuBgEFDVIDCQ7xsZeonrt
	nW4s4soUM1VikPYYke2aRkrgPPqchWEyBCyjBUp3OMxpN34H1Xuc+gPZQVFSWGV9Za89
	oZ9A==
X-Gm-Message-State: APjAAAXahAQ2saw7bfubRJsswHm8OooziPHm7tvHOxV9PiEVyg8ItHvK
	C9SZFemXMsTPOq5rPDz9GrPx8A==
X-Google-Smtp-Source: APXvYqyuGjoY5Y0Syp4+5SLuh/vdTk3vcJ6sA+Lo/bmzUrEZYHy9kXPL99i9rMOZ3BlsiW3kLTF9YA==
X-Received: by 2002:a0c:f58a:: with SMTP id k10mr19263278qvm.89.1556113889106; 
	Wed, 24 Apr 2019 06:51:29 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	n6sm11888231qtb.40.2019.04.24.06.51.27
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 06:51:28 -0700 (PDT)
Date: Wed, 24 Apr 2019 09:51:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Message-ID: <20190424095058-mutt-send-email-mst@kernel.org>
References: <20190409055850.25797-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190409055850.25797-1-jasowang@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.194
Subject: Re: [Qemu-devel] [PATCH V3] vhost_net: don't set backend for the
 uninitialized virtqueue
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
Cc: yuri.benditovich@daynix.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424135126.JjhEOejVNRXbICCdaxP5XzhTgmFnTDg3w6nALJBU42c@z>

On Tue, Apr 09, 2019 at 01:58:50PM +0800, Jason Wang wrote:
> We used to set backend unconditionally, this won't work for some
> guests (e.g windows driver) who may not initialize all virtqueues. For
> kernel backend, this will fail since it may try to validate the rings
> during setting backend.
> 
> Fixing this by simply skipping the backend set when we find desc is
> not ready.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Changes from V1:
> - introduce a generic helper to check if a virtqueue is enabled
> ---
>  hw/net/vhost_net.c         | 10 ++++++++++
>  hw/virtio/virtio.c         |  5 +++++
>  include/hw/virtio/virtio.h |  1 +
>  3 files changed, 16 insertions(+)
> 
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index be3cc88370..a6b719035c 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -244,6 +244,11 @@ static int vhost_net_start_one(struct vhost_net *net,
>          qemu_set_fd_handler(net->backend, NULL, NULL, NULL);
>          file.fd = net->backend;
>          for (file.index = 0; file.index < net->dev.nvqs; ++file.index) {
> +            if (!virtio_queue_enabled(dev, net->dev.vq_index +
> +                                      file.index)) {
> +                /* Queue might not be ready for start */
> +                continue;
> +            }
>              r = vhost_net_set_backend(&net->dev, &file);
>              if (r < 0) {
>                  r = -errno;
> @@ -256,6 +261,11 @@ fail:
>      file.fd = -1;
>      if (net->nc->info->type == NET_CLIENT_DRIVER_TAP) {
>          while (file.index-- > 0) {
> +            if (!virtio_queue_enabled(dev, net->dev.vq_index +
> +                                      file.index)) {
> +                /* Queue might not be ready for start */
> +                continue;
> +            }
>              int r = vhost_net_set_backend(&net->dev, &file);
>              assert(r >= 0);
>          }
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 2626a895cb..28056a7ef7 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2318,6 +2318,11 @@ hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n)
>      return vdev->vq[n].vring.desc;
>  }
>  
> +bool virtio_queue_enabled(VirtIODevice *vdev, int n)
> +{
> +    return virtio_queue_get_desc_addr(vdev, n) != 0;
> +}
> +
>  hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n)
>  {
>      return vdev->vq[n].vring.avail;
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index ce9516236a..7140381e3a 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -282,6 +282,7 @@ typedef struct VirtIORNGConf VirtIORNGConf;
>                        VIRTIO_F_IOMMU_PLATFORM, false)
>  
>  hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
> +bool virtio_queue_enabled(VirtIODevice *vdev, int n);
>  hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
>  hwaddr virtio_queue_get_used_addr(VirtIODevice *vdev, int n);
>  hwaddr virtio_queue_get_desc_size(VirtIODevice *vdev, int n);
> -- 
> 2.19.1

