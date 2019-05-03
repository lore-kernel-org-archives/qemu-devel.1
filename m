Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA55C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DEB12075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEB12075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45027 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMbtV-00059D-8z
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 13:22:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdillama@redhat.com>) id 1hMbsP-0004cP-AC
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdillama@redhat.com>) id 1hMbsO-0007ij-8O
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:21:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jdillama@redhat.com>) id 1hMbsO-0007hm-1k
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:21:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id f37so6822359edb.13
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 10:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
	:from:date:message-id:subject:to:cc;
	bh=H2FaNa1e+07Ozk09mqt7ANy0GB0sxbSTccsjC3gYo4Q=;
	b=MUHPI8nwIbhx1bih6UP8IXXBI/hN/nQz+0rIMOCPpUE9gDZOBRX7ULzJ05l3j+ibdu
	mupcwacAP893j1Ojs9QxgQ/HxUIdS8F7OswHkp2XpWhJ/5JEEdlbNvve83QAmHtSk5FT
	sjgwthBg6N64podArkHcW25/CN2IkKCpwrUkIh3aGurvwL0T2cG3vjAdCQXdLht1QFbB
	/JjPDmBMm9OKFwMa3ioWQu2HNQXwFtRQP/I3YwFAA7RTKt33JQOvGJEGtnpjDWo3nuBA
	wFtWG/rLe5CYuBDTw1281vcs0O64RWeFb8aMz516cVWRVIJ4C2A5GAE/gDnSrLww8Ls4
	nBxQ==
X-Gm-Message-State: APjAAAWw7ha9hAi7tMBCqmZK8ASnibmxEsPdmLnsumW9FP5uGAeQ0PBH
	SfWlaKU4avyc9L/aFP7K5pXnJuQfVpurR0KQOJTsBA==
X-Google-Smtp-Source: APXvYqwhoQaML21k6wjGw0GE+2eOvPkIpsyQ8JuJxW9TdD44Pduaps6PFQteR7O84Nd+YY951EZh24kUqmGkZFARmhU=
X-Received: by 2002:a50:ee01:: with SMTP id g1mr9869528eds.263.1556904094889; 
	Fri, 03 May 2019 10:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190503163028.213823-1-sgarzare@redhat.com>
In-Reply-To: <20190503163028.213823-1-sgarzare@redhat.com>
From: Jason Dillaman <jdillama@redhat.com>
Date: Fri, 3 May 2019 13:21:23 -0400
Message-ID:
 <CA+aFP1BWA416Q1=PB3xcQUPc1fQ-Cq+mhnG8FbkJiLDEvT0wyA@mail.gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.208.65
Subject: Re: [Qemu-devel] [PATCH v2] block/rbd: increase dynamically the
 image size
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
Reply-To: dillaman@redhat.com
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503172123.iPAkoLJGfVQaysaXHqSqNFccjl4xlHpylkqcVjypvLM@z>

On Fri, May 3, 2019 at 12:30 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> RBD APIs don't allow us to write more than the size set with
> rbd_create() or rbd_resize().
> In order to support growing images (eg. qcow2), we resize the
> image before write operations that exceed the current size.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v2:
>   - use bs->total_sectors instead of adding a new field [Kevin]
>   - resize the image only during write operation [Kevin]
>     for read operation, the bdrv_aligned_preadv() already handles reads
>     that exceed the length returned by bdrv_getlength(), so IMHO we can
>     avoid to handle it in the rbd driver
> ---
>  block/rbd.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index 0c549c9935..613e8f4982 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -934,13 +934,25 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
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
> +        if (off + size > bs->total_sectors * BDRV_SECTOR_SIZE) {

When will "bs->total_sectors" be refreshed to represent the correct
current size? You wouldn't want a future write whose extent was
greater than the original image size but less then a previous IO that
expanded the image to attempt to shrink the image.

> +            r = rbd_resize(s->image, off + size);
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
> --
> 2.20.1
>
>


-- 
Jason

