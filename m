Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA12CC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:32:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80DE220B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DE220B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51150 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZEyP-0007Rz-OG
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36908)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hZEtn-0005sU-EK
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hZEtj-0004mh-VV
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:27:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45390)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hZEtb-0004NL-NZ; Fri, 07 Jun 2019 09:27:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5387A83F45;
 Fri,  7 Jun 2019 13:26:59 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 61F3082F6E;
 Fri,  7 Jun 2019 13:26:54 +0000 (UTC)
Date: Fri, 7 Jun 2019 15:26:52 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190607132652.GD5055@dhcp-200-226.str.redhat.com>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
 <20190411172709.205032-7-vsementsov@virtuozzo.com>
 <0b64cff5-33fa-0945-504c-b1bdd004c42a@redhat.com>
 <20190607080635.GB5055@dhcp-200-226.str.redhat.com>
 <c1414cfd-99cd-ea31-ab22-f7d76974e6b3@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1414cfd-99cd-ea31-ab22-f7d76974e6b3@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 07 Jun 2019 13:26:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 6/7] block/nbd-client: nbd reconnect
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.06.2019 um 14:02 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 07.06.2019 11:06, Kevin Wolf wrote:
> > Am 07.06.2019 um 05:17 hat Eric Blake geschrieben:
> >> On 4/11/19 12:27 PM, Vladimir Sementsov-Ogievskiy wrote:
> >>> +static coroutine_fn void nbd_reconnect_loop(NBDConnection *con)
> >>> +{
> >>> +    NBDClientSession *s = nbd_get_client_session(con->bs);
> >>> +    uint64_t start_time_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> >>> +    uint64_t delay_ns = s->reconnect_delay * 1000000000UL;
> >>
> >> Do we have a #define constant for nanoseconds in a second to make this
> >> more legible than counting '0's?
> >>
> >>> +    uint64_t timeout = 1000000000UL; /* 1 sec */
> >>> +    uint64_t max_timeout = 16000000000UL; /* 16 sec */
> >>
> >> 1 * constant, 16 * constant
> >>
> >>> +
> >>> +    nbd_reconnect_attempt(con);
> >>> +
> >>> +    while (nbd_client_connecting(s)) {
> >>> +        if (s->state == NBD_CLIENT_CONNECTING_WAIT &&
> >>> +            qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start_time_ns > delay_ns)
> >>> +        {
> >>> +            s->state = NBD_CLIENT_CONNECTING_NOWAIT;
> >>> +            qemu_co_queue_restart_all(&s->free_sema);
> >>> +        }
> >>> +
> >>> +        bdrv_dec_in_flight(con->bs);
> >>> +        qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, timeout);
> >>
> >> Another place where I'd like someone more familiar with coroutines to
> >> also have a look.
> > 
> > What's the exact question you'd like me to answer?
> > 
> > But anyway, bdrv_dec/inc_in_flight() around the sleep looks wrong to me.
> > Either the operation must be waited for in drain, then you can't
> > decrease the counter even during the sleep. Or drain doesn't have to
> > consider it, then why is the counter even increased in the first place?
> > 
> > The way it currently is, drain can return assuming that there are no
> > requests, but after the timeout the request automatically comes back
> > while the drain caller assumes that there is no more activity. This
> > doesn't look right.
> 
> Hmm.
> 
> This ind/dec around all lifetime of connection coroutine you added in
> 
> commit 5ad81b4946baf948c65cf7e1436d9b74803c1280
> Author: Kevin Wolf <kwolf@redhat.com>
> Date:   Fri Feb 15 16:53:51 2019 +0100
> 
>      nbd: Restrict connection_co reentrance
> 
> 
> And now I try to connect in endless loop, with qemu_co_sleep_ns() inside.
> I need to get a change to bdrv_drain to complete, so I have to sometimes
> drop this in_flight request. But I understand your point.

Ah, right, I see. I think it's fine to add a second point where we
decrease the counter (though I would add a comment telling why we do
this) as long as the right conditions are met.

The right conditions are probably something like: Once drained, we
guarantee that we don't call any callbacks until the drained section
ends. In nbd_read_eof() this is true because we can't get an answer if
we had no request running.

Or actually... This assumes a nice compliant server that doesn't just
arbitrarily send unexpected messages. Is the existing code broken if we
connect to a malicious server?

> Will the following work better?
> 
> bdrv_dec_in_flight(con->bs);
> qemu_co_sleep_ns(...);
> while (s->drained) {
>    s->wait_drained_end = true;
>    qemu_coroutine_yield();
> }
> bdrv_inc_in_flight(con->bs);
> 
> ...
> .drained_begin() {
>     s->drained = true;
> }
> 
> .drained_end() {
>     if (s->wait_drained_end) {
>        s->wait_drained_end = false;
>        aio_co_wake(s->connection_co);
>     }
> }

This should make sure that we don't call any callbacks before the drain
section has ended.

We probably still have a problem because nbd_client_attach_aio_context()
reenters the coroutine with qemu_aio_coroutine_enter(), which will cause
an assertion failure if co->scheduled is set. So this needs to use a
version that can cancel a sleep.

I see that your patch currently simply ignores attaching a new context,
but then the coroutine stays in the old AioContext. Did I miss some
additional code that moves it to the new context somehow or will it just
stay where it was if the coroutine happens to be reconnecting when the
AioContext was supposed to change?

Kevin

