Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C9CC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB218213F2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB218213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58700 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfj0o-0005s1-PR
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 06:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43010)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hfizW-0005C2-0j
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hfizU-0006bH-PE
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:47:57 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35502)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hfizU-0006I2-JM
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:47:56 -0400
Received: by mail-oi1-f195.google.com with SMTP id a127so12139286oii.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 03:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fjZVnFtra4QQ2qkrZbd+UbgWuBZJM7Vh3R8gnfewT+w=;
 b=LymnLj1O46GxyZHwmA0CoqnvRaxoi68YHon7yl0wYVbiIejSBSUOjAlSC4aO88t+PM
 0c+yu0UA1AedMpTj0/UEcHlxdlAyAHTRwl3+txSPUYcQp/suNI4moub3fC8SggIiS7/d
 VA46ZQc+Xuufoy+caGfmG1Sjm+9fFNJ20mmWFhKcE2M7dLBrPuR6GixFB0tsQBh1wsP6
 FaUJIluXeU5huzVDhBjhbQwGZSTfl3I5bM/9gjToWGNUdLzf2T8Z0tmi2AkEG80KhT1u
 cN7xENBJaGtsXX7fe3RjlUhu1MhdnG6pgjBky3ajBlyIN0s9WFBYwaol9jW0FnhjTlc4
 P7Kw==
X-Gm-Message-State: APjAAAX2KtZ+Fni6b5DWdKJFENtxIzz9WXUEQZL1QhTIHk4X9tXMBRCU
 ZlPDWNcrAUmE03agg6G937S2OEbUglXRjUjPQycdfUSi
X-Google-Smtp-Source: APXvYqx9N7Bg+6/WOgSc3rpfjbP5Yc6AbKbCeMR2VNzaU5USiUmuqg/8YN5F38+rDZRuHBDooBaS6Tl35h8XTOlwfNE=
X-Received: by 2002:aca:aad3:: with SMTP id
 t202mr14739273oie.158.1561459660088; 
 Tue, 25 Jun 2019 03:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190509145927.293369-1-sgarzare@redhat.com>
 <20190521085615.lsckrdbfjdz5mzy4@steredhat.homenet.telecomitalia.it>
In-Reply-To: <20190521085615.lsckrdbfjdz5mzy4@steredhat.homenet.telecomitalia.it>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 25 Jun 2019 12:47:29 +0200
Message-ID: <CAGxU2F6fzrA35_7U+TjmMMjxO+yN2gGWtaFxgZ+at2XBeDrgOg@mail.gmail.com>
To: qemu devel list <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.195
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] block/rbd: increase
 dynamically the image size
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
Cc: Josh Durgin <jdurgin@redhat.com>, Jason Dillaman <jdillama@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping.

Thanks,
Stefano

On Tue, May 21, 2019 at 10:56 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Kindly ping.
>
> Thanks,
> Stefano
>
> On Thu, May 09, 2019 at 04:59:27PM +0200, Stefano Garzarella wrote:
> > RBD APIs don't allow us to write more than the size set with
> > rbd_create() or rbd_resize().
> > In order to support growing images (eg. qcow2), we resize the
> > image before write operations that exceed the current size.
> >
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v3:
> >   - add 'image_size' field in the BDRVRBDState to keep track of the
> >     current size of the RBD image [Jason, Kevin]
> > ---
> >  block/rbd.c | 42 +++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 39 insertions(+), 3 deletions(-)
> >
> > diff --git a/block/rbd.c b/block/rbd.c
> > index 0c549c9935..b0355a2ce0 100644
> > --- a/block/rbd.c
> > +++ b/block/rbd.c
> > @@ -102,6 +102,7 @@ typedef struct BDRVRBDState {
> >      rbd_image_t image;
> >      char *image_name;
> >      char *snap;
> > +    uint64_t image_size;
> >  } BDRVRBDState;
> >
> >  static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
> > @@ -777,6 +778,14 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
> >          goto failed_open;
> >      }
> >
> > +    r = rbd_get_size(s->image, &s->image_size);
> > +    if (r < 0) {
> > +        error_setg_errno(errp, -r, "error getting image size from %s",
> > +                         s->image_name);
> > +        rbd_close(s->image);
> > +        goto failed_open;
> > +    }
> > +
> >      /* If we are using an rbd snapshot, we must be r/o, otherwise
> >       * leave as-is */
> >      if (s->snap != NULL) {
> > @@ -833,6 +842,22 @@ static void qemu_rbd_close(BlockDriverState *bs)
> >      rados_shutdown(s->cluster);
> >  }
> >
> > +/* Resize the RBD image and update the 'image_size' with the current size */
> > +static int qemu_rbd_resize(BlockDriverState *bs, uint64_t size)
> > +{
> > +    BDRVRBDState *s = bs->opaque;
> > +    int r;
> > +
> > +    r = rbd_resize(s->image, size);
> > +    if (r < 0) {
> > +        return r;
> > +    }
> > +
> > +    s->image_size = size;
> > +
> > +    return 0;
> > +}
> > +
> >  static const AIOCBInfo rbd_aiocb_info = {
> >      .aiocb_size = sizeof(RBDAIOCB),
> >  };
> > @@ -934,13 +959,25 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
> >      }
> >
> >      switch (cmd) {
> > -    case RBD_AIO_WRITE:
> > +    case RBD_AIO_WRITE: {
> > +        /*
> > +         * RBD APIs don't allow us to write more than actual size, so in order
> > +         * to support growing images, we resize the image before write
> > +         * operations that exceed the current size.
> > +         */
> > +        if (off + size > s->image_size) {
> > +            r = qemu_rbd_resize(bs, off + size);
> > +            if (r < 0) {
> > +                goto failed_completion;
> > +            }
> > +        }
> >  #ifdef LIBRBD_SUPPORTS_IOVEC
> >              r = rbd_aio_writev(s->image, qiov->iov, qiov->niov, off, c);
> >  #else
> >              r = rbd_aio_write(s->image, off, size, rcb->buf, c);
> >  #endif
> >          break;
> > +    }
> >      case RBD_AIO_READ:
> >  #ifdef LIBRBD_SUPPORTS_IOVEC
> >              r = rbd_aio_readv(s->image, qiov->iov, qiov->niov, off, c);
> > @@ -1051,7 +1088,6 @@ static int coroutine_fn qemu_rbd_co_truncate(BlockDriverState *bs,
> >                                               PreallocMode prealloc,
> >                                               Error **errp)
> >  {
> > -    BDRVRBDState *s = bs->opaque;
> >      int r;
> >
> >      if (prealloc != PREALLOC_MODE_OFF) {
> > @@ -1060,7 +1096,7 @@ static int coroutine_fn qemu_rbd_co_truncate(BlockDriverState *bs,
> >          return -ENOTSUP;
> >      }
> >
> > -    r = rbd_resize(s->image, offset);
> > +    r = qemu_rbd_resize(bs, offset);
> >      if (r < 0) {
> >          error_setg_errno(errp, -r, "Failed to resize file");
> >          return r;
> > --
> > 2.20.1
> >
> >
>
> --
>
> Stefano Garzarella
> Software Engineer @ Red Hat



-- 
Stefano Garzarella
Software Engineer, Virt Team
Red Hat

