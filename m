Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC99C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:00:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D252173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D252173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49529 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT0dB-00072Z-Hv
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 05:00:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hT0Zf-0004U9-Gl
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hT0Zd-0003YY-RD
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:56:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hT0Zd-0003Hf-Ki
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:56:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id b18so17552678wrq.12
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 01:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=xINJbtsj2QLLlbU59Adhhs5ucDu8KPI7qOkhEmQ2I8c=;
	b=Vq6gYiqCU9Esk+jL+ITci7Jz6LP3vKDdahk4b8M3YaXGBcSv6lwY1c/yeQ0yM4fiKo
	E6UXi6UB8W5S0z4L08d4xVlybij2tsY7PB7fJ8kb59bMJKrxMmGZhoVVlntNWggvjz3m
	ktTM2wVkNF2ynVAcEmZZOPb4fos8pb5I1yjJ50vWZLPChMnt0rOXEQ576iWBt93qhZ7G
	II3lUEdRURsM4kERh4IFUhhW3zBMuLw0iqzE0FtMWM8uC6ame/KQRR1iiRHpKF96Wrnu
	5RWj5ZSxlfntSPG6ZydQTm3F5a95NttKeI+91QeO+RH5N/BRmjz4xCzZG8w+Olwu8beH
	2MEw==
X-Gm-Message-State: APjAAAXGpFwfgxx51rRvf8HnAwet1AcVyzbq9HiRrCjjiAawvxy5QeXu
	gEDZGbe7ciKMsbpQw3tQsS9T4zPpm7A=
X-Google-Smtp-Source: APXvYqyylZdNx9xi3SrSjih3jkHqzgzP3R7zedYt/X+n7K4A328ThNxr/7i8kl7MdROfpppSPbOlnA==
X-Received: by 2002:a5d:4f0b:: with SMTP id c11mr11651216wru.35.1558428978274; 
	Tue, 21 May 2019 01:56:18 -0700 (PDT)
Received: from steredhat.homenet.telecomitalia.it
	(host253-229-dynamic.248-95-r.retail.telecomitalia.it.
	[95.248.229.253])
	by smtp.gmail.com with ESMTPSA id a9sm2866729wmh.5.2019.05.21.01.56.17
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 May 2019 01:56:17 -0700 (PDT)
Date: Tue, 21 May 2019 10:56:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190521085615.lsckrdbfjdz5mzy4@steredhat.homenet.telecomitalia.it>
References: <20190509145927.293369-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509145927.293369-1-sgarzare@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] block/rbd: increase
 dynamically the image size
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
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
	Jason Dillaman <jdillama@redhat.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kindly ping.

Thanks,
Stefano

On Thu, May 09, 2019 at 04:59:27PM +0200, Stefano Garzarella wrote:
> RBD APIs don't allow us to write more than the size set with
> rbd_create() or rbd_resize().
> In order to support growing images (eg. qcow2), we resize the
> image before write operations that exceed the current size.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v3:
>   - add 'image_size' field in the BDRVRBDState to keep track of the
>     current size of the RBD image [Jason, Kevin]
> ---
>  block/rbd.c | 42 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/block/rbd.c b/block/rbd.c
> index 0c549c9935..b0355a2ce0 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -102,6 +102,7 @@ typedef struct BDRVRBDState {
>      rbd_image_t image;
>      char *image_name;
>      char *snap;
> +    uint64_t image_size;
>  } BDRVRBDState;
>  
>  static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
> @@ -777,6 +778,14 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
>          goto failed_open;
>      }
>  
> +    r = rbd_get_size(s->image, &s->image_size);
> +    if (r < 0) {
> +        error_setg_errno(errp, -r, "error getting image size from %s",
> +                         s->image_name);
> +        rbd_close(s->image);
> +        goto failed_open;
> +    }
> +
>      /* If we are using an rbd snapshot, we must be r/o, otherwise
>       * leave as-is */
>      if (s->snap != NULL) {
> @@ -833,6 +842,22 @@ static void qemu_rbd_close(BlockDriverState *bs)
>      rados_shutdown(s->cluster);
>  }
>  
> +/* Resize the RBD image and update the 'image_size' with the current size */
> +static int qemu_rbd_resize(BlockDriverState *bs, uint64_t size)
> +{
> +    BDRVRBDState *s = bs->opaque;
> +    int r;
> +
> +    r = rbd_resize(s->image, size);
> +    if (r < 0) {
> +        return r;
> +    }
> +
> +    s->image_size = size;
> +
> +    return 0;
> +}
> +
>  static const AIOCBInfo rbd_aiocb_info = {
>      .aiocb_size = sizeof(RBDAIOCB),
>  };
> @@ -934,13 +959,25 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
>      }
>  
>      switch (cmd) {
> -    case RBD_AIO_WRITE:
> +    case RBD_AIO_WRITE: {
> +        /*
> +         * RBD APIs don't allow us to write more than actual size, so in order
> +         * to support growing images, we resize the image before write
> +         * operations that exceed the current size.
> +         */
> +        if (off + size > s->image_size) {
> +            r = qemu_rbd_resize(bs, off + size);
> +            if (r < 0) {
> +                goto failed_completion;
> +            }
> +        }
>  #ifdef LIBRBD_SUPPORTS_IOVEC
>              r = rbd_aio_writev(s->image, qiov->iov, qiov->niov, off, c);
>  #else
>              r = rbd_aio_write(s->image, off, size, rcb->buf, c);
>  #endif
>          break;
> +    }
>      case RBD_AIO_READ:
>  #ifdef LIBRBD_SUPPORTS_IOVEC
>              r = rbd_aio_readv(s->image, qiov->iov, qiov->niov, off, c);
> @@ -1051,7 +1088,6 @@ static int coroutine_fn qemu_rbd_co_truncate(BlockDriverState *bs,
>                                               PreallocMode prealloc,
>                                               Error **errp)
>  {
> -    BDRVRBDState *s = bs->opaque;
>      int r;
>  
>      if (prealloc != PREALLOC_MODE_OFF) {
> @@ -1060,7 +1096,7 @@ static int coroutine_fn qemu_rbd_co_truncate(BlockDriverState *bs,
>          return -ENOTSUP;
>      }
>  
> -    r = rbd_resize(s->image, offset);
> +    r = qemu_rbd_resize(bs, offset);
>      if (r < 0) {
>          error_setg_errno(errp, -r, "Failed to resize file");
>          return r;
> -- 
> 2.20.1
> 
> 

-- 

Stefano Garzarella
Software Engineer @ Red Hat

