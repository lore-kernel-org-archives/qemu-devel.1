Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F63C742BA
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 12:30:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB763208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 12:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB763208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hluh1-0005aP-H3
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 08:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38087)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hlugo-00056W-1z
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 08:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hlugm-0002al-Fc
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 08:30:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46962)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hlugj-0002Wr-KH; Fri, 12 Jul 2019 08:30:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 80EFDC058CBD;
 Fri, 12 Jul 2019 12:30:07 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 618D426E71;
 Fri, 12 Jul 2019 12:30:02 +0000 (UTC)
Date: Fri, 12 Jul 2019 14:30:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190712123000.GH4514@dhcp-200-226.str.redhat.com>
References: <20190711195804.30703-1-mreitz@redhat.com>
 <20190711195804.30703-2-mreitz@redhat.com>
 <20190712092419.GB4514@dhcp-200-226.str.redhat.com>
 <8ce2ce78-833e-c98f-ad3a-d44f6432ae4c@redhat.com>
 <20190712110110.GE4514@dhcp-200-226.str.redhat.com>
 <cd184838-6c1f-0d22-1d89-415dbd62955b@redhat.com>
 <20190712112318.GG4514@dhcp-200-226.str.redhat.com>
 <a05bce45-d7f7-99c4-8126-e326a5f21340@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="qGV0fN9tzfkG3CxV"
Content-Disposition: inline
In-Reply-To: <a05bce45-d7f7-99c4-8126-e326a5f21340@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 12 Jul 2019 12:30:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 1/5] block/nbd: Fix hang in .bdrv_close()
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--qGV0fN9tzfkG3CxV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 12.07.2019 um 13:44 hat Max Reitz geschrieben:
> On 12.07.19 13:23, Kevin Wolf wrote:
> > Am 12.07.2019 um 13:09 hat Max Reitz geschrieben:
> >> On 12.07.19 13:01, Kevin Wolf wrote:
> >>> Am 12.07.2019 um 12:47 hat Max Reitz geschrieben:
> >>>> On 12.07.19 11:24, Kevin Wolf wrote:
> >>>>> Am 11.07.2019 um 21:58 hat Max Reitz geschrieben:
> >>>>>> When nbd_close() is called from a coroutine, the connection_co nev=
er
> >>>>>> gets to run, and thus nbd_teardown_connection() hangs.
> >>>>>>
> >>>>>> This is because aio_co_enter() only puts the connection_co into th=
e main
> >>>>>> coroutine's wake-up queue, so this main coroutine needs to yield a=
nd
> >>>>>> reschedule itself to let the connection_co run.
> >>>>>>
> >>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >>>>>> ---
> >>>>>>  block/nbd.c | 12 +++++++++++-
> >>>>>>  1 file changed, 11 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/block/nbd.c b/block/nbd.c
> >>>>>> index 81edabbf35..b83b6cd43e 100644
> >>>>>> --- a/block/nbd.c
> >>>>>> +++ b/block/nbd.c
> >>>>>> @@ -135,7 +135,17 @@ static void nbd_teardown_connection(BlockDriv=
erState *bs)
> >>>>>>      qio_channel_shutdown(s->ioc,
> >>>>>>                           QIO_CHANNEL_SHUTDOWN_BOTH,
> >>>>>>                           NULL);
> >>>>>> -    BDRV_POLL_WHILE(bs, s->connection_co);
> >>>>>> +
> >>>>>> +    if (qemu_in_coroutine()) {
> >>>>>> +        /* Let our caller poll and just yield until connection_co=
 is done */
> >>>>>> +        while (s->connection_co) {
> >>>>>> +            aio_co_schedule(qemu_get_current_aio_context(),
> >>>>>> +                            qemu_coroutine_self());
> >>>>>> +            qemu_coroutine_yield();
> >>>>>> +        }
> >>>>>
> >>>>> Isn't this busy waiting? Why not let s->connection_co wake us up wh=
en
> >>>>> it's about to terminate instead of immediately rescheduling ourselv=
es?
> >>>>
> >>>> Yes, it is busy waiting, but I didn=E2=80=99t find that bad.  The co=
nnection_co
> >>>> will be invoked in basically every iteration, and once there is no
> >>>> pending data, it will quit.
> >>>>
> >>>> The answer to =E2=80=9Cwhy not...=E2=80=9D of course is because it=
=E2=80=99d be more complicated.
> >>>>
> >>>> But anyway.
> >>>>
> >>>> Adding a new function qemu_coroutine_run_after(target) that adds
> >>>> qemu_coroutine_self() to the given @target coroutine=E2=80=99s wake-=
up queue and
> >>>> then using that instead of scheduling works, too, yes.
> >>>>
> >>>> I don=E2=80=99t really like being responsible for coroutine code, th=
ough...
> >>>>
> >>>> (And maybe it=E2=80=99d be better to make it qemu_coroutine_yield_fo=
r(target),
> >>>> which does the above and then yields?)
> >>>
> >>> Or just do something like this, which is arguably not only a fix for =
the
> >>> busy wait, but also a code simplification:
> >>
> >> 1. Is that guaranteed to work?  What if data sneaks in, the
> >> connection_co handles that, and doesn=E2=80=99t wake up the teardown_c=
o?  Will
> >> it be re-scheduled?
> >=20
> > Then connection_co is buggy because we clearly requested that it
> > terminate.
>=20
> Did we?  This would be done by setting s->quit to true, which isn=E2=80=
=99t
> explicitly done here.

*we clearly requested implicitly ;-)

> I thought it worked by just waking up the coroutine until it doesn=E2=80=
=99t
> receive anything anymore, because the connection is closed.  Now I don=E2=
=80=99t
> know whether QIO_CHANNEL_SHUTDOWN_BOTH discards data that has been
> received before the channel is closed.  I don=E2=80=99t expect it to.

It doesn't really matter, but I expect that we'll still read everything
that was buffered and receive EOF after everything is read.

> >            It is possible that it does so only after handling another
> > request, but this wouldn't be a problem. teardown_co would then just
> > sleep for a few cycles more until connection_co is done and reaches the
> > aio_co_wake() call.
>=20
> I don=E2=80=99t quite understand, because the fact how connection_co would
> proceed after handling another request was exactly my question.  If it
> were to yield and not to wake up, it would never be done.

But why would it not wake up? This would be a bug, every yield needs a
corresponding place from which the coroutine is reentered later.

If this were missing, it would already today mean that we hang during
shutdown because s->connection_co would never become NULL.

> But I=E2=80=99ve followed nbd_receive_reply() now, and I suppose nbd_read=
_eof()
> will simply never yield after we have invoked qio_channel_shutdown().

If my expectation above is right, this would probably be the case at
least for the "main" yield. Not sure if there aren't other yield points,
though. But as I said, it doesn't matter anyway how many times the
coroutine yields and is reentered before finally reaching the
aio_co_wake() and terminating.

Kevin

--qGV0fN9tzfkG3CxV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdKH1IAAoJEH8JsnLIjy/WmNMQAIlVxTaFxLG1ffSKhPtbLFTj
PNiPrKNAgudQo0BMuOPbdH4tL6j/rYOgFBdOuyqJd7T9CUjtmFQ1MPtu93Zqhuvw
011CIqz/TesmQzs11OW4iFAm8rLlkM0bb0Ste/lOQ9VPhTX67o95PHS1vKnUuHw6
sihpL+JY3SLeuQvvHY5Bm/LU8Xv9Wwur8NqWmm8Ca55l6bWEii2M45Wi52EQW2ab
8c5M9VDZZcdegWs/7ujBEXcOMePu76MHKp4g5nTBpbU7VHPnh01BTPCJr08SoNbp
QRJe9K09saJhAevlzlLfKRufSnxfqWrFaVv4/CHZKqiUHU6lLuEdDy4htifLtYKJ
NJUOvcIOpfRxu8CoYah65KogVQ3VnnZJhoOIL+DvTpgQ/NanN6n5RhMVcenhqAId
2SKtBDwPLaRfL4m+uUMZWIJelPsXH8ac1h+4Vp9B3/nLd5gcJc/9j8eKr3RJpdKl
7aG42tqUdSm8kZLzfqIYjftarvCGis/NesafHWvVAsGJKIZaxX10FMMeHJl1pYzh
9bpmyyeGns77pwszXOvpi7B3dUoDpdVKXXrqZ5kIm5ROJ7E6bw/vjU2wVjitrtpW
1bqsY4W10zSdi+BoMRdMUD6QthNk/shk4qbmiGzn+53zoqQ6LDrIzZwQHSmzT8GV
vG9ikR9sh3vZCtrweNba
=O3oC
-----END PGP SIGNATURE-----

--qGV0fN9tzfkG3CxV--

