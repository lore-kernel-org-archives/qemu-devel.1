Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9135C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:05:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7965C21670
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7965C21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58098 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL6un-0002GD-QS
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 10:05:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hL6tV-0001VK-BW
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hL6tU-0000kQ-23
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:04:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hL6tT-0000jB-RF
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:04:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so16210064wra.12
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=zUVOHjLu+1Hwep77hFuKbQlr8COu0/5kr4ihIdjSvDU=;
	b=EZpJEONdlnPE5lSTo7i4CbV/9zULFmdpuAvTpbyYPKJWdydLBV3Z/vGj1tqzz7R8Vx
	XzFoohxQU+GHO6reN8ZIjRIyO7A9ltXK/AGNB/7pKoIoVYAvy+gYYo6JH41GZDNlJhOM
	8dJ5vNAHkPl1oXv2HIhGc+ElU0viZwv7QrGkG354eKYgqc2BrPZl18BjpX5juc6xh+2b
	bdNIk/e8fPAE515w5UpG+TtYSQcWVxiqlOkxwI5hlSLhMj7Bd1SCETYU2C0LcYWnLbhF
	d8N38wotdvrMbjBfm2tg2yUudJyMlJDH2F6Qgq3sytVNSjHQwt2sMSBNBH/z/QaPyM1r
	5tTg==
X-Gm-Message-State: APjAAAVxUSSIQvNdGSsNhUk1r3kHhCHvebWV5hoWyjM6L/DlgLJnCD6z
	UJfP9UkIrtF58hS2GIHWedU92Q==
X-Google-Smtp-Source: APXvYqy/BJkxHBf3VP7WKWuluNpSEP0unUbpOvvi3pWh03c4wPfEYBnYsU73DZhWxDDu+EVqbnHaJQ==
X-Received: by 2002:a5d:410f:: with SMTP id l15mr14769084wrp.6.1556546670519; 
	Mon, 29 Apr 2019 07:04:30 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it.
	[87.12.203.35]) by smtp.gmail.com with ESMTPSA id
	z6sm14605061wrw.87.2019.04.29.07.04.29
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 29 Apr 2019 07:04:29 -0700 (PDT)
Date: Mon, 29 Apr 2019 16:04:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190429140427.6tfpvdzza3io46g5@steredhat>
References: <20190411105025.97397-1-sgarzare@redhat.com>
	<20190411105025.97397-2-sgarzare@redhat.com>
	<20190429102510.GD8492@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190429102510.GD8492@localhost.localdomain>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] block/rbd: increase dynamically
 the image size
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
Cc: Josh Durgin <jdurgin@redhat.com>, qemu-devel@nongnu.org,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429140427.CW3zdyefF0O8og5txwWhi1JuI_Ilm6h0mten9hCa-lE@z>

On Mon, Apr 29, 2019 at 12:25:10PM +0200, Kevin Wolf wrote:
> Am 11.04.2019 um 12:50 hat Stefano Garzarella geschrieben:
> > RBD APIs don't allow us to write more than the size set with rbd_create()
> > or rbd_resize().
> > In order to support growing images (eg. qcow2), we resize the image
> > before RW operations that exceed the current size.
> > 
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1171007
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  block/rbd.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/block/rbd.c b/block/rbd.c
> > index 0c549c9935..228658e20a 100644
> > --- a/block/rbd.c
> > +++ b/block/rbd.c
> > @@ -102,6 +102,7 @@ typedef struct BDRVRBDState {
> >      rbd_image_t image;
> >      char *image_name;
> >      char *snap;
> > +    uint64_t image_size;
> >  } BDRVRBDState;
> 
> Can't we use bs->total_sectors instead of adding a new image_size field?

I'm not sure we can use bs->total_sectors. IIUC, for example, it doesn't
take care of bytes used by QCOW2 metadata.

> 
> >  static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
> > @@ -777,6 +778,14 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
> >          goto failed_open;
> >      }
> >  
> > +    r = rbd_get_size(s->image, &s->image_size);
> > +    if (r < 0) {
> > +        error_setg_errno(errp, -r, "error reading image size from %s",
> > +                         s->image_name);
> > +        rbd_close(s->image);
> > +        goto failed_open;
> > +    }
> > +
> >      /* If we are using an rbd snapshot, we must be r/o, otherwise
> >       * leave as-is */
> >      if (s->snap != NULL) {
> > @@ -921,6 +930,20 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
> >          rcb->buf = acb->bounce;
> >      }
> >  
> > +    /*
> > +     * RBD APIs don't allow us to write more than actual size, so in order
> > +     * to support growing images, we resize the image before RW operations
> > +     * that exceed the current size.
> > +     */
> > +    if (s->image_size < off + size) {
> > +        r = rbd_resize(s->image, off + size);
> > +        if (r < 0) {
> > +            goto failed;
> > +        }
> > +
> > +        s->image_size = off + size;
> > +    }
> 
> This doesn't check the request type, so it's actually not limited to RW
> operations, but even reads will try to resize the image. This is at
> least surprising. For regular files, file-posix extends the file for
> write requests, but for reads it returns a zeroed buffer without
> actually changing the file size.

Yes, I'll change the behaviour in the v2.

I did some tries (i.e. using qemu-io and reading more than bytes used) and
the RBD driver didn't receive 'read' requests that exceed the current
size, maybe because it is managed in the QCOW2 protocol, but of course
I'll handle also in the RBD driver.

Thanks,
Stefano

