Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67083C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 14:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA815217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 14:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA815217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49587 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEaW5-0001jH-FY
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 10:17:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEaUk-0000w3-Bq
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEaUi-0006Kl-GD
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:16:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hEaUe-0006Gb-NV; Thu, 11 Apr 2019 10:15:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96E8030AA789;
	Thu, 11 Apr 2019 14:15:50 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B1F25108BEEA;
	Thu, 11 Apr 2019 14:15:49 +0000 (UTC)
Date: Thu, 11 Apr 2019 16:15:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190411141548.GE5694@linux.fritz.box>
References: <20190225152053.15976-1-kwolf@redhat.com>
	<20190225152053.15976-17-kwolf@redhat.com>
	<4f9792a1-4702-62d0-cad4-4da1169baa3b@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <4f9792a1-4702-62d0-cad4-4da1169baa3b@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Thu, 11 Apr 2019 14:15:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 16/71] nbd: Increase bs->in_flight during
 AioContext switch
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411141548.moRRTsOfMCmhUkM2z5OqHLyG8-hh92A-3wgNn4Bfkrs@z>

Am 11.04.2019 um 15:40 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 25.02.2019 18:19, Kevin Wolf wrote:
> > bdrv_drain() must not leave connection_co scheduled, so bs->in_flight
> > needs to be increased while the coroutine is waiting to be scheduled
> > in the new AioContext after nbd_client_attach_aio_context().
> 
> Hi!
> 
> I have some questions, could you explain, please?
> 
> "bdrv_drain() must not leave connection_co scheduled" - it's because we want to be
> sure that connection_co yielded from nbd_read_eof, yes?
> 
> But it is guaranteed by aio_wait_bh_oneshot.. Why do we need additioinally inc/dec
> bs->in_flight ?

Without incrementing bs->in_flight, nothing would guarantee that
aio_poll() is called and the BH is actually executed before bdrv_drain()
returns.

Kevin

> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   block/nbd-client.c | 20 ++++++++++++++++++--
> >   1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/nbd-client.c b/block/nbd-client.c
> > index 60f38f0320..bfbaf7ebe9 100644
> > --- a/block/nbd-client.c
> > +++ b/block/nbd-client.c
> > @@ -977,14 +977,30 @@ void nbd_client_detach_aio_context(BlockDriverState *bs)
> >       qio_channel_detach_aio_context(QIO_CHANNEL(client->ioc));
> >   }
> >   
> > +static void nbd_client_attach_aio_context_bh(void *opaque)
> > +{
> > +    BlockDriverState *bs = opaque;
> > +    NBDClientSession *client = nbd_get_client_session(bs);
> > +
> > +    /* The node is still drained, so we know the coroutine has yielded in
> > +     * nbd_read_eof(), the only place where bs->in_flight can reach 0, or it is
> > +     * entered for the first time. Both places are safe for entering the
> > +     * coroutine.*/
> > +    qemu_aio_coroutine_enter(bs->aio_context, client->connection_co);
> > +    bdrv_dec_in_flight(bs);
> > +}
> > +
> >   void nbd_client_attach_aio_context(BlockDriverState *bs,
> >                                      AioContext *new_context)
> >   {
> >       NBDClientSession *client = nbd_get_client_session(bs);
> >       qio_channel_attach_aio_context(QIO_CHANNEL(client->ioc), new_context);
> >   
> > -    /* FIXME Really need a bdrv_inc_in_flight() here */
> > -    aio_co_schedule(new_context, client->connection_co);
> > +    bdrv_inc_in_flight(bs);
> > +
> > +    /* Need to wait here for the BH to run because the BH must run while the
> > +     * node is still drained. */
> > +    aio_wait_bh_oneshot(new_context, nbd_client_attach_aio_context_bh, bs);
> >   }
> >   
> >   void nbd_client_close(BlockDriverState *bs)
> > 
> 
> 
> -- 
> Best regards,
> Vladimir

