Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520C1C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 09:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E9521479
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 09:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E9521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33948 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOJ5O-0003iQ-1D
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 05:42:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hOJ4Y-0003MN-4G
	for qemu-devel@nongnu.org; Wed, 08 May 2019 05:41:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hOJ4X-0002Br-0k
	for qemu-devel@nongnu.org; Wed, 08 May 2019 05:41:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hOJ4W-0002Aj-QX
	for qemu-devel@nongnu.org; Wed, 08 May 2019 05:41:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id l2so26304281wrb.9
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 02:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=HKCvhZMUr3qI8raRCGNb3WIEG28SJzKmhMGrENfN2ck=;
	b=Kq3drOHkTO07M2IuSX6RVjN9P6T3UHv55O+EITOhFz/zwOHq9VwzeuKLpL3fqBfb6o
	WMsXraERs2mwZdE9XM0gsp94J4Mh/SoLzG5iJNn24gZObxfC+5f6w7E3sGvN1Qw3aeDc
	0ERNYC4v/DljwVlgQ13kHAvNqHW0eZ3lM+/UWP9qjPCUxqncvzyIawjHKVhxkUYqRaOu
	DN6YVg5gsnfs2kaTm2bMv57n1IAJnkSSROTNdKCYCQGB0HH5ppgThEYPghTcClTH2Qsp
	IFNoaL3FD2xnsiYGy8NXE1hSnGrrjBiSSX5bhSAJGAmUFmWHFfgMxxbPrtJ7RcC0zKx6
	qc7Q==
X-Gm-Message-State: APjAAAU/JKdRBLT/44QNHJP0n64ntv+9uwpE5oAnJ+uRy1gSmyNqpgui
	EPZKyXY+ortiAB2Jew8vPCr36Q==
X-Google-Smtp-Source: APXvYqxiIkpi1aZrUly5+J5+cAPZf3TAPWqSwdhnC4ZtfaTYdge1aOHLLIeS8I58RkeAeCe61iN0LA==
X-Received: by 2002:adf:9042:: with SMTP id h60mr8225112wrh.248.1557308466245; 
	Wed, 08 May 2019 02:41:06 -0700 (PDT)
Received: from steredhat (host151-251-static.12-87-b.business.telecomitalia.it.
	[87.12.251.151]) by smtp.gmail.com with ESMTPSA id
	s10sm1823437wrt.66.2019.05.08.02.41.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 08 May 2019 02:41:05 -0700 (PDT)
Date: Wed, 8 May 2019 11:41:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190508094102.6iw2ryf7rphdjhhf@steredhat>
References: <20190503163028.213823-1-sgarzare@redhat.com>
	<CA+aFP1BWA416Q1=PB3xcQUPc1fQ-Cq+mhnG8FbkJiLDEvT0wyA@mail.gmail.com>
	<20190506095031.kffsp76faaqhkdr2@steredhat>
	<20190507094350.GE5808@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507094350.GE5808@localhost.localdomain>
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
Cc: Josh Durgin <jdurgin@redhat.com>, dillaman@redhat.com,
	qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 07, 2019 at 11:43:50AM +0200, Kevin Wolf wrote:
> Am 06.05.2019 um 11:50 hat Stefano Garzarella geschrieben:
> > On Fri, May 03, 2019 at 01:21:23PM -0400, Jason Dillaman wrote:
> > > On Fri, May 3, 2019 at 12:30 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > >
> > > > RBD APIs don't allow us to write more than the size set with
> > > > rbd_create() or rbd_resize().
> > > > In order to support growing images (eg. qcow2), we resize the
> > > > image before write operations that exceed the current size.
> > > >
> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > ---
> > > > v2:
> > > >   - use bs->total_sectors instead of adding a new field [Kevin]
> > > >   - resize the image only during write operation [Kevin]
> > > >     for read operation, the bdrv_aligned_preadv() already handles reads
> > > >     that exceed the length returned by bdrv_getlength(), so IMHO we can
> > > >     avoid to handle it in the rbd driver
> > > > ---
> > > >  block/rbd.c | 14 +++++++++++++-
> > > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/block/rbd.c b/block/rbd.c
> > > > index 0c549c9935..613e8f4982 100644
> > > > --- a/block/rbd.c
> > > > +++ b/block/rbd.c
> > > > @@ -934,13 +934,25 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
> > > >      }
> > > >
> > > >      switch (cmd) {
> > > > -    case RBD_AIO_WRITE:
> > > > +    case RBD_AIO_WRITE: {
> > > > +        /*
> > > > +         * RBD APIs don't allow us to write more than actual size, so in order
> > > > +         * to support growing images, we resize the image before write
> > > > +         * operations that exceed the current size.
> > > > +         */
> > > > +        if (off + size > bs->total_sectors * BDRV_SECTOR_SIZE) {
> > > 
> > > When will "bs->total_sectors" be refreshed to represent the correct
> > > current size? You wouldn't want a future write whose extent was
> > > greater than the original image size but less then a previous IO that
> > > expanded the image to attempt to shrink the image.
> > > 
> > 
> > Good point!
> > IIUC it can happen, because in the bdrv_aligned_pwritev() we do these
> > steps:
> > 1. call bdrv_driver_pwritev() that invokes "drv->bdrv_aio_pwritev" and
> >    then it waits calling "qemu_coroutine_yield()"
> > 2. call bdrv_co_write_req_finish() that updates the "bs->total_sectors"
> > 
> > Between steps 1 and 2, maybe another request can be executed, then the
> > issue that you described can occur.
> > 
> > The solutions that I have in mind are:
> > a. Add a variable in the BDRVRBDState to track the latest resize.
> 
> This would work and be relatively simple.
> 
> > b. Call rbd_get_size() before the rbd_resize() to be sure to avoid to shrink
> >    the image.
> 
> I'm not sure if rbd_get_size() involves network traffic or other
> significant complexity. If so, I'd definitely avoid it.
> 
> > c. Updates the "bs->total_sectors" after the rbd_resize(), but I'm not
> >    sure it is allowed.
> > 
> > @Jason, @Kevin Do you have any advice?
> 
> We need to make sure to run everything that bdrv_co_write_req_finish()
> does for resizing an image:
> 
>     bs->total_sectors = end_sector;
>     bdrv_parent_cb_resize(bs);
>     bdrv_dirty_bitmap_truncate(bs, end_sector << BDRV_SECTOR_BITS);
> 
> Just duplicating that code wouldn't be good; if something is added, we'd
> probably forget updating rbd, too. So I think your solution c would at
> least involve refactoring the above code into a separate function that
> can be called from rbd.
> 
> But solution a might actually be the simplest. In this case, sorry for
> giving you bad advice in v1 of the patch.
> 

I agree with you, 'a' should be simplest to implement.

I'll send a v3 fixing this.

Thanks,
Stefano

