Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6775AC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A2432064A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2432064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59628 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL8er-0000fk-G5
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 11:57:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hL8dI-0007tu-GM
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hL8dH-0007sC-8Z
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:55:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hL8dD-0007oc-Fu
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:55:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id s18so16881220wrp.0
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=ILsergqfW1RQzuTYl5lwHg1XTor6XjOtRRu8lmYrI4U=;
	b=bkgAsehNtCmE/car3FCVyrRiJRfvrA8wjqjoRStLixxchQetxBobxmuxj0nNyudg5W
	4q838q88ennRa1w9QH0W2G9PJmo14NkRVdh1cYslliDvmzxXGVjgyCCDjZMHHIe/pK0D
	DWd0GD1pXtRW/nCKZbadPQbUd1jjdM1NqOIpsjdPOddnQ6CcS2WONR+/S75puBtulIUW
	zygzfAtjpOCyhnXUM2L2vQKVrdOzlS0YZtMVK0PnRsZRqVNWeQyZw990Sk1U6HKmBWGL
	h6cjy+VGxOBFyV+69BXH9FZm5+pHCj2gTi+BJutivzvwdHlSxDrq0PP5XKKEMu1K9OnX
	rmug==
X-Gm-Message-State: APjAAAVqGbL4leAQUN5Tr1BClxCsOUxzle/Ag0V9QgIPjP8IXHV1D6FB
	5uQYi+upmK+QxZ1a/u/VMtwvuw==
X-Google-Smtp-Source: APXvYqwi9lONC53YyQdyfXy/VCVPri6iN5LIQU4vQWYZTTjEqDI/WruIyQcFNK9kGnkpLxZ+VyJ2yg==
X-Received: by 2002:adf:dbc1:: with SMTP id e1mr25216406wrj.203.1556553349585; 
	Mon, 29 Apr 2019 08:55:49 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it.
	[87.12.203.35]) by smtp.gmail.com with ESMTPSA id
	c11sm25122530wrs.86.2019.04.29.08.55.48
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 29 Apr 2019 08:55:48 -0700 (PDT)
Date: Mon, 29 Apr 2019 17:55:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190429155546.3yous37l7vokkutb@steredhat>
References: <20190411105025.97397-1-sgarzare@redhat.com>
	<20190411105025.97397-2-sgarzare@redhat.com>
	<20190429102510.GD8492@localhost.localdomain>
	<20190429140427.6tfpvdzza3io46g5@steredhat>
	<20190429143014.GG8492@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190429143014.GG8492@localhost.localdomain>
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
Message-ID: <20190429155546.M3ULSThe4eSsZcaPXskmYDYNDSe1PHiPd3TNaI9dqNY@z>

On Mon, Apr 29, 2019 at 04:30:14PM +0200, Kevin Wolf wrote:
> Am 29.04.2019 um 16:04 hat Stefano Garzarella geschrieben:
> > On Mon, Apr 29, 2019 at 12:25:10PM +0200, Kevin Wolf wrote:
> > > Am 11.04.2019 um 12:50 hat Stefano Garzarella geschrieben:
> > > > RBD APIs don't allow us to write more than the size set with rbd_create()
> > > > or rbd_resize().
> > > > In order to support growing images (eg. qcow2), we resize the image
> > > > before RW operations that exceed the current size.
> > > > 
> > > > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1171007
> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > ---
> > > >  block/rbd.c | 25 +++++++++++++++++++++++++
> > > >  1 file changed, 25 insertions(+)
> > > > 
> > > > diff --git a/block/rbd.c b/block/rbd.c
> > > > index 0c549c9935..228658e20a 100644
> > > > --- a/block/rbd.c
> > > > +++ b/block/rbd.c
> > > > @@ -102,6 +102,7 @@ typedef struct BDRVRBDState {
> > > >      rbd_image_t image;
> > > >      char *image_name;
> > > >      char *snap;
> > > > +    uint64_t image_size;
> > > >  } BDRVRBDState;
> > > 
> > > Can't we use bs->total_sectors instead of adding a new image_size field?
> > 
> > I'm not sure we can use bs->total_sectors. IIUC, for example, it doesn't
> > take care of bytes used by QCOW2 metadata.
> 
> bs->total_sectors for the rbd BLockDriverState is the image file size,
> not the virtual disk size.
> 
> The only reason not to use it would be if we need byte granularity
> rather than 512 byte granularity. But I don't think it's a problem to
> round up offsets to the next 512 bytes (BDRV_SECTOR_SIZE) boundary.
> 

I tried and it works as you told me :) I'll remove the image_size in the
v2.

> > > >  static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
> > > > @@ -777,6 +778,14 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
> > > >          goto failed_open;
> > > >      }
> > > >  
> > > > +    r = rbd_get_size(s->image, &s->image_size);
> > > > +    if (r < 0) {
> > > > +        error_setg_errno(errp, -r, "error reading image size from %s",
> > > > +                         s->image_name);
> > > > +        rbd_close(s->image);
> > > > +        goto failed_open;
> > > > +    }
> > > > +
> > > >      /* If we are using an rbd snapshot, we must be r/o, otherwise
> > > >       * leave as-is */
> > > >      if (s->snap != NULL) {
> > > > @@ -921,6 +930,20 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
> > > >          rcb->buf = acb->bounce;
> > > >      }
> > > >  
> > > > +    /*
> > > > +     * RBD APIs don't allow us to write more than actual size, so in order
> > > > +     * to support growing images, we resize the image before RW operations
> > > > +     * that exceed the current size.
> > > > +     */
> > > > +    if (s->image_size < off + size) {
> > > > +        r = rbd_resize(s->image, off + size);
> > > > +        if (r < 0) {
> > > > +            goto failed;
> > > > +        }
> > > > +
> > > > +        s->image_size = off + size;
> > > > +    }
> > > 
> > > This doesn't check the request type, so it's actually not limited to RW
> > > operations, but even reads will try to resize the image. This is at
> > > least surprising. For regular files, file-posix extends the file for
> > > write requests, but for reads it returns a zeroed buffer without
> > > actually changing the file size.
> > 
> > Yes, I'll change the behaviour in the v2.
> > 
> > I did some tries (i.e. using qemu-io and reading more than bytes used) and
> > the RBD driver didn't receive 'read' requests that exceed the current
> > size, maybe because it is managed in the QCOW2 protocol, but of course
> > I'll handle also in the RBD driver.
> 
> I don't remember the exact scenario where it happened, but I know I
> implemented it for file-posix to fix a bug. Maybe it actually doesn't
> happen any more because we have made other changes in the meantime, but
> I'm not sure.
> 

Thanks for the details, I'll check better if we can avoid it, otherwise
I'll take care of this in the RBD driver.

Cheers,
Stefano

