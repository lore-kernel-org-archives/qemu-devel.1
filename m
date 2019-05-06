Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F0BC04AAA
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 09:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5059620830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 09:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5059620830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53659 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNaHX-0004Z9-8n
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 05:51:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hNaGf-0003qi-VW
	for qemu-devel@nongnu.org; Mon, 06 May 2019 05:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hNaGe-0005Zu-L7
	for qemu-devel@nongnu.org; Mon, 06 May 2019 05:50:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hNaGe-0005XQ-E5
	for qemu-devel@nongnu.org; Mon, 06 May 2019 05:50:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so16408839wre.7
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 02:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=g/lXSVz7Pj2RTbxlnyH0U7w6CdIbUHi1iO7auRNRDvY=;
	b=ZT7txqXZ4B61on4pks9dTpWvUG7lG+K3+CB4q4pRlFXS2nXBzdN8BjwY29ABAvlMSq
	DvoZlIuCS/bpDQZCRzhvAX/mxDDt6f26WU+u0zEnPmBktcZFzf4q34Hwn5m8ToJBowDN
	Xx9onwLJgqfQsVZScr3U8w5pHbjZu1tAqSiYNfNFKRmFZdHAo5dqdohgGNKZPmDEzb9J
	0r61OOiUpRVUXXvtx7c6lliepJlgnG8sjrwiVct9H8DP/VLVtn94rHVewhi+asuRsFrF
	Fx4KiYkbGzYc0BQCXskobNJ7bKEwSG6y+LrBu+flCCpBjqPp9gP90IK8XetknK7EzU8S
	F9Qg==
X-Gm-Message-State: APjAAAXIXJjGYzSaBYdvNPFZAc0Lw7myI6zcNml5y2uJo0JxhtSJRRX9
	XZdMIAfNB5IC7oc9G1y7jiOB6A==
X-Google-Smtp-Source: APXvYqziRn+n/Y0MeU+YBG2DAFcoAGDe5PamMmtswyaPKpISJnHL9YkxwqTOII99ygOspVwkduwwGw==
X-Received: by 2002:adf:80c4:: with SMTP id 62mr6199114wrl.234.1557136239398; 
	Mon, 06 May 2019 02:50:39 -0700 (PDT)
Received: from steredhat (host103-125-dynamic.46-79-r.retail.telecomitalia.it.
	[79.46.125.103]) by smtp.gmail.com with ESMTPSA id
	b10sm15517785wrh.59.2019.05.06.02.50.38
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 06 May 2019 02:50:38 -0700 (PDT)
Date: Mon, 6 May 2019 11:50:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: dillaman@redhat.com, Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190506095031.kffsp76faaqhkdr2@steredhat>
References: <20190503163028.213823-1-sgarzare@redhat.com>
	<CA+aFP1BWA416Q1=PB3xcQUPc1fQ-Cq+mhnG8FbkJiLDEvT0wyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+aFP1BWA416Q1=PB3xcQUPc1fQ-Cq+mhnG8FbkJiLDEvT0wyA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
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
Cc: Josh Durgin <jdurgin@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
	qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 03, 2019 at 01:21:23PM -0400, Jason Dillaman wrote:
> On Fri, May 3, 2019 at 12:30 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > RBD APIs don't allow us to write more than the size set with
> > rbd_create() or rbd_resize().
> > In order to support growing images (eg. qcow2), we resize the
> > image before write operations that exceed the current size.
> >
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v2:
> >   - use bs->total_sectors instead of adding a new field [Kevin]
> >   - resize the image only during write operation [Kevin]
> >     for read operation, the bdrv_aligned_preadv() already handles reads
> >     that exceed the length returned by bdrv_getlength(), so IMHO we can
> >     avoid to handle it in the rbd driver
> > ---
> >  block/rbd.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/rbd.c b/block/rbd.c
> > index 0c549c9935..613e8f4982 100644
> > --- a/block/rbd.c
> > +++ b/block/rbd.c
> > @@ -934,13 +934,25 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
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
> > +        if (off + size > bs->total_sectors * BDRV_SECTOR_SIZE) {
> 
> When will "bs->total_sectors" be refreshed to represent the correct
> current size? You wouldn't want a future write whose extent was
> greater than the original image size but less then a previous IO that
> expanded the image to attempt to shrink the image.
> 

Good point!
IIUC it can happen, because in the bdrv_aligned_pwritev() we do these
steps:
1. call bdrv_driver_pwritev() that invokes "drv->bdrv_aio_pwritev" and
   then it waits calling "qemu_coroutine_yield()"
2. call bdrv_co_write_req_finish() that updates the "bs->total_sectors"

Between steps 1 and 2, maybe another request can be executed, then the
issue that you described can occur.

The solutions that I have in mind are:
a. Add a variable in the BDRVRBDState to track the latest resize.
b. Call rbd_get_size() before the rbd_resize() to be sure to avoid to shrink
   the image.
c. Updates the "bs->total_sectors" after the rbd_resize(), but I'm not
   sure it is allowed.

@Jason, @Kevin Do you have any advice?

Thanks,
Stefano

