Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E866CC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9358204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9358204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58467 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL7JT-0002zC-2H
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 10:31:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hL7IU-0002DZ-VI
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hL7IT-00087q-Is
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:30:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hL7IQ-00084i-Kq; Mon, 29 Apr 2019 10:30:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C15233082E09;
	Mon, 29 Apr 2019 14:30:17 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-63.ams2.redhat.com
	[10.36.116.63])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F578600C2;
	Mon, 29 Apr 2019 14:30:16 +0000 (UTC)
Date: Mon, 29 Apr 2019 16:30:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190429143014.GG8492@localhost.localdomain>
References: <20190411105025.97397-1-sgarzare@redhat.com>
	<20190411105025.97397-2-sgarzare@redhat.com>
	<20190429102510.GD8492@localhost.localdomain>
	<20190429140427.6tfpvdzza3io46g5@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190429140427.6tfpvdzza3io46g5@steredhat>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Mon, 29 Apr 2019 14:30:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Message-ID: <20190429143014.V2_gLpjphkyMFE4LAsvN_0VgQVe4ug788J7NBi4hvJI@z>

Am 29.04.2019 um 16:04 hat Stefano Garzarella geschrieben:
> On Mon, Apr 29, 2019 at 12:25:10PM +0200, Kevin Wolf wrote:
> > Am 11.04.2019 um 12:50 hat Stefano Garzarella geschrieben:
> > > RBD APIs don't allow us to write more than the size set with rbd_create()
> > > or rbd_resize().
> > > In order to support growing images (eg. qcow2), we resize the image
> > > before RW operations that exceed the current size.
> > > 
> > > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1171007
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > >  block/rbd.c | 25 +++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > > 
> > > diff --git a/block/rbd.c b/block/rbd.c
> > > index 0c549c9935..228658e20a 100644
> > > --- a/block/rbd.c
> > > +++ b/block/rbd.c
> > > @@ -102,6 +102,7 @@ typedef struct BDRVRBDState {
> > >      rbd_image_t image;
> > >      char *image_name;
> > >      char *snap;
> > > +    uint64_t image_size;
> > >  } BDRVRBDState;
> > 
> > Can't we use bs->total_sectors instead of adding a new image_size field?
> 
> I'm not sure we can use bs->total_sectors. IIUC, for example, it doesn't
> take care of bytes used by QCOW2 metadata.

bs->total_sectors for the rbd BLockDriverState is the image file size,
not the virtual disk size.

The only reason not to use it would be if we need byte granularity
rather than 512 byte granularity. But I don't think it's a problem to
round up offsets to the next 512 bytes (BDRV_SECTOR_SIZE) boundary.

> > >  static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
> > > @@ -777,6 +778,14 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
> > >          goto failed_open;
> > >      }
> > >  
> > > +    r = rbd_get_size(s->image, &s->image_size);
> > > +    if (r < 0) {
> > > +        error_setg_errno(errp, -r, "error reading image size from %s",
> > > +                         s->image_name);
> > > +        rbd_close(s->image);
> > > +        goto failed_open;
> > > +    }
> > > +
> > >      /* If we are using an rbd snapshot, we must be r/o, otherwise
> > >       * leave as-is */
> > >      if (s->snap != NULL) {
> > > @@ -921,6 +930,20 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
> > >          rcb->buf = acb->bounce;
> > >      }
> > >  
> > > +    /*
> > > +     * RBD APIs don't allow us to write more than actual size, so in order
> > > +     * to support growing images, we resize the image before RW operations
> > > +     * that exceed the current size.
> > > +     */
> > > +    if (s->image_size < off + size) {
> > > +        r = rbd_resize(s->image, off + size);
> > > +        if (r < 0) {
> > > +            goto failed;
> > > +        }
> > > +
> > > +        s->image_size = off + size;
> > > +    }
> > 
> > This doesn't check the request type, so it's actually not limited to RW
> > operations, but even reads will try to resize the image. This is at
> > least surprising. For regular files, file-posix extends the file for
> > write requests, but for reads it returns a zeroed buffer without
> > actually changing the file size.
> 
> Yes, I'll change the behaviour in the v2.
> 
> I did some tries (i.e. using qemu-io and reading more than bytes used) and
> the RBD driver didn't receive 'read' requests that exceed the current
> size, maybe because it is managed in the QCOW2 protocol, but of course
> I'll handle also in the RBD driver.

I don't remember the exact scenario where it happened, but I know I
implemented it for file-posix to fix a bug. Maybe it actually doesn't
happen any more because we have made other changes in the meantime, but
I'm not sure.

Kevin

