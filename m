Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B96BC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 10:28:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CA8C2087B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 10:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA8C2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55323 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL3Vx-0002kc-L0
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 06:28:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hL3Ti-0000Ua-MQ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hL3Th-0003Hb-DK
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:25:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hL3TR-00032y-UU; Mon, 29 Apr 2019 06:25:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B30F730917AD;
	Mon, 29 Apr 2019 10:25:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-63.ams2.redhat.com
	[10.36.116.63])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BECC2608C2;
	Mon, 29 Apr 2019 10:25:11 +0000 (UTC)
Date: Mon, 29 Apr 2019 12:25:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190429102510.GD8492@localhost.localdomain>
References: <20190411105025.97397-1-sgarzare@redhat.com>
	<20190411105025.97397-2-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190411105025.97397-2-sgarzare@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Mon, 29 Apr 2019 10:25:14 +0000 (UTC)
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
Message-ID: <20190429102510.Uct8p0Xc680K9mqTMgaSj4xG0EVtQVozsGH21WwYc_o@z>

Am 11.04.2019 um 12:50 hat Stefano Garzarella geschrieben:
> RBD APIs don't allow us to write more than the size set with rbd_create()
> or rbd_resize().
> In order to support growing images (eg. qcow2), we resize the image
> before RW operations that exceed the current size.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1171007
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  block/rbd.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/block/rbd.c b/block/rbd.c
> index 0c549c9935..228658e20a 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -102,6 +102,7 @@ typedef struct BDRVRBDState {
>      rbd_image_t image;
>      char *image_name;
>      char *snap;
> +    uint64_t image_size;
>  } BDRVRBDState;

Can't we use bs->total_sectors instead of adding a new image_size field?

>  static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
> @@ -777,6 +778,14 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
>          goto failed_open;
>      }
>  
> +    r = rbd_get_size(s->image, &s->image_size);
> +    if (r < 0) {
> +        error_setg_errno(errp, -r, "error reading image size from %s",
> +                         s->image_name);
> +        rbd_close(s->image);
> +        goto failed_open;
> +    }
> +
>      /* If we are using an rbd snapshot, we must be r/o, otherwise
>       * leave as-is */
>      if (s->snap != NULL) {
> @@ -921,6 +930,20 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
>          rcb->buf = acb->bounce;
>      }
>  
> +    /*
> +     * RBD APIs don't allow us to write more than actual size, so in order
> +     * to support growing images, we resize the image before RW operations
> +     * that exceed the current size.
> +     */
> +    if (s->image_size < off + size) {
> +        r = rbd_resize(s->image, off + size);
> +        if (r < 0) {
> +            goto failed;
> +        }
> +
> +        s->image_size = off + size;
> +    }

This doesn't check the request type, so it's actually not limited to RW
operations, but even reads will try to resize the image. This is at
least surprising. For regular files, file-posix extends the file for
write requests, but for reads it returns a zeroed buffer without
actually changing the file size.

Kevin

