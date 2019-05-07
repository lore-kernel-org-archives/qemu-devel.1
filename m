Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B052C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:45:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D2D0204FD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2D0204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43444 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNweu-0007G9-G9
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 05:45:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNwdk-0006d6-SC
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNwdj-0000cz-Qa
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:44:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hNwdh-0000bG-AN; Tue, 07 May 2019 05:43:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D913307CDD5;
	Tue,  7 May 2019 09:43:56 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-186.ams2.redhat.com
	[10.36.116.186])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CA5863BBC;
	Tue,  7 May 2019 09:43:51 +0000 (UTC)
Date: Tue, 7 May 2019 11:43:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190507094350.GE5808@localhost.localdomain>
References: <20190503163028.213823-1-sgarzare@redhat.com>
	<CA+aFP1BWA416Q1=PB3xcQUPc1fQ-Cq+mhnG8FbkJiLDEvT0wyA@mail.gmail.com>
	<20190506095031.kffsp76faaqhkdr2@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506095031.kffsp76faaqhkdr2@steredhat>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Tue, 07 May 2019 09:43:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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

Am 06.05.2019 um 11:50 hat Stefano Garzarella geschrieben:
> On Fri, May 03, 2019 at 01:21:23PM -0400, Jason Dillaman wrote:
> > On Fri, May 3, 2019 at 12:30 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > >
> > > RBD APIs don't allow us to write more than the size set with
> > > rbd_create() or rbd_resize().
> > > In order to support growing images (eg. qcow2), we resize the
> > > image before write operations that exceed the current size.
> > >
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > > v2:
> > >   - use bs->total_sectors instead of adding a new field [Kevin]
> > >   - resize the image only during write operation [Kevin]
> > >     for read operation, the bdrv_aligned_preadv() already handles reads
> > >     that exceed the length returned by bdrv_getlength(), so IMHO we can
> > >     avoid to handle it in the rbd driver
> > > ---
> > >  block/rbd.c | 14 +++++++++++++-
> > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/block/rbd.c b/block/rbd.c
> > > index 0c549c9935..613e8f4982 100644
> > > --- a/block/rbd.c
> > > +++ b/block/rbd.c
> > > @@ -934,13 +934,25 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
> > >      }
> > >
> > >      switch (cmd) {
> > > -    case RBD_AIO_WRITE:
> > > +    case RBD_AIO_WRITE: {
> > > +        /*
> > > +         * RBD APIs don't allow us to write more than actual size, so in order
> > > +         * to support growing images, we resize the image before write
> > > +         * operations that exceed the current size.
> > > +         */
> > > +        if (off + size > bs->total_sectors * BDRV_SECTOR_SIZE) {
> > 
> > When will "bs->total_sectors" be refreshed to represent the correct
> > current size? You wouldn't want a future write whose extent was
> > greater than the original image size but less then a previous IO that
> > expanded the image to attempt to shrink the image.
> > 
> 
> Good point!
> IIUC it can happen, because in the bdrv_aligned_pwritev() we do these
> steps:
> 1. call bdrv_driver_pwritev() that invokes "drv->bdrv_aio_pwritev" and
>    then it waits calling "qemu_coroutine_yield()"
> 2. call bdrv_co_write_req_finish() that updates the "bs->total_sectors"
> 
> Between steps 1 and 2, maybe another request can be executed, then the
> issue that you described can occur.
> 
> The solutions that I have in mind are:
> a. Add a variable in the BDRVRBDState to track the latest resize.

This would work and be relatively simple.

> b. Call rbd_get_size() before the rbd_resize() to be sure to avoid to shrink
>    the image.

I'm not sure if rbd_get_size() involves network traffic or other
significant complexity. If so, I'd definitely avoid it.

> c. Updates the "bs->total_sectors" after the rbd_resize(), but I'm not
>    sure it is allowed.
> 
> @Jason, @Kevin Do you have any advice?

We need to make sure to run everything that bdrv_co_write_req_finish()
does for resizing an image:

    bs->total_sectors = end_sector;
    bdrv_parent_cb_resize(bs);
    bdrv_dirty_bitmap_truncate(bs, end_sector << BDRV_SECTOR_BITS);

Just duplicating that code wouldn't be good; if something is added, we'd
probably forget updating rbd, too. So I think your solution c would at
least involve refactoring the above code into a separate function that
can be called from rbd.

But solution a might actually be the simplest. In this case, sorry for
giving you bad advice in v1 of the patch.

Kevin

