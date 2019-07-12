Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94BAC742B2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01FD20645
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01FD20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlteM-000180-Uh
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 07:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48312)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hlteA-0000bo-VR
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hlte9-0003Ay-PG
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:23:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35508)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hlte7-00035S-3V; Fri, 12 Jul 2019 07:23:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6EB2DC05566C;
 Fri, 12 Jul 2019 11:23:22 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CC6860BFB;
 Fri, 12 Jul 2019 11:23:19 +0000 (UTC)
Date: Fri, 12 Jul 2019 13:23:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190712112318.GG4514@dhcp-200-226.str.redhat.com>
References: <20190711195804.30703-1-mreitz@redhat.com>
 <20190711195804.30703-2-mreitz@redhat.com>
 <20190712092419.GB4514@dhcp-200-226.str.redhat.com>
 <8ce2ce78-833e-c98f-ad3a-d44f6432ae4c@redhat.com>
 <20190712110110.GE4514@dhcp-200-226.str.redhat.com>
 <cd184838-6c1f-0d22-1d89-415dbd62955b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Content-Disposition: inline
In-Reply-To: <cd184838-6c1f-0d22-1d89-415dbd62955b@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 12 Jul 2019 11:23:22 +0000 (UTC)
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


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 12.07.2019 um 13:09 hat Max Reitz geschrieben:
> On 12.07.19 13:01, Kevin Wolf wrote:
> > Am 12.07.2019 um 12:47 hat Max Reitz geschrieben:
> >> On 12.07.19 11:24, Kevin Wolf wrote:
> >>> Am 11.07.2019 um 21:58 hat Max Reitz geschrieben:
> >>>> When nbd_close() is called from a coroutine, the connection_co never
> >>>> gets to run, and thus nbd_teardown_connection() hangs.
> >>>>
> >>>> This is because aio_co_enter() only puts the connection_co into the =
main
> >>>> coroutine's wake-up queue, so this main coroutine needs to yield and
> >>>> reschedule itself to let the connection_co run.
> >>>>
> >>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >>>> ---
> >>>>  block/nbd.c | 12 +++++++++++-
> >>>>  1 file changed, 11 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/block/nbd.c b/block/nbd.c
> >>>> index 81edabbf35..b83b6cd43e 100644
> >>>> --- a/block/nbd.c
> >>>> +++ b/block/nbd.c
> >>>> @@ -135,7 +135,17 @@ static void nbd_teardown_connection(BlockDriver=
State *bs)
> >>>>      qio_channel_shutdown(s->ioc,
> >>>>                           QIO_CHANNEL_SHUTDOWN_BOTH,
> >>>>                           NULL);
> >>>> -    BDRV_POLL_WHILE(bs, s->connection_co);
> >>>> +
> >>>> +    if (qemu_in_coroutine()) {
> >>>> +        /* Let our caller poll and just yield until connection_co i=
s done */
> >>>> +        while (s->connection_co) {
> >>>> +            aio_co_schedule(qemu_get_current_aio_context(),
> >>>> +                            qemu_coroutine_self());
> >>>> +            qemu_coroutine_yield();
> >>>> +        }
> >>>
> >>> Isn't this busy waiting? Why not let s->connection_co wake us up when
> >>> it's about to terminate instead of immediately rescheduling ourselves?
> >>
> >> Yes, it is busy waiting, but I didn=E2=80=99t find that bad.  The conn=
ection_co
> >> will be invoked in basically every iteration, and once there is no
> >> pending data, it will quit.
> >>
> >> The answer to =E2=80=9Cwhy not...=E2=80=9D of course is because it=E2=
=80=99d be more complicated.
> >>
> >> But anyway.
> >>
> >> Adding a new function qemu_coroutine_run_after(target) that adds
> >> qemu_coroutine_self() to the given @target coroutine=E2=80=99s wake-up=
 queue and
> >> then using that instead of scheduling works, too, yes.
> >>
> >> I don=E2=80=99t really like being responsible for coroutine code, thou=
gh...
> >>
> >> (And maybe it=E2=80=99d be better to make it qemu_coroutine_yield_for(=
target),
> >> which does the above and then yields?)
> >=20
> > Or just do something like this, which is arguably not only a fix for the
> > busy wait, but also a code simplification:
>=20
> 1. Is that guaranteed to work?  What if data sneaks in, the
> connection_co handles that, and doesn=E2=80=99t wake up the teardown_co? =
 Will
> it be re-scheduled?

Then connection_co is buggy because we clearly requested that it
terminate. It is possible that it does so only after handling another
request, but this wouldn't be a problem. teardown_co would then just
sleep for a few cycles more until connection_co is done and reaches the
aio_co_wake() call.

> 2. I precisely didn=E2=80=99t want to do this because we have this functi=
onality
> already in the form of Coroutine.co_queue_wakeup.  Why duplicate it here?

co_queue_wakeup contains coroutines to be run at the next yield point
(or termination), which may be when connection_co is actually done, but
it might also be earlier. My explicit aio_co_wake() at the end of
connection_co is guaranteed to run only when connection_co is done.

Kevin

> > diff --git a/block/nbd.c b/block/nbd.c
> > index b83b6cd43e..c061bd1bfc 100644
> > --- a/block/nbd.c
> > +++ b/block/nbd.c
> > @@ -61,6 +61,7 @@ typedef struct BDRVNBDState {
> >      CoMutex send_mutex;
> >      CoQueue free_sema;
> >      Coroutine *connection_co;
> > +    Coroutine *teardown_co;
> >      int in_flight;
> >=20
> >      NBDClientRequest requests[MAX_NBD_REQUESTS];
> > @@ -137,12 +138,9 @@ static void nbd_teardown_connection(BlockDriverSta=
te *bs)
> >                           NULL);
> >=20
> >      if (qemu_in_coroutine()) {
> > -        /* Let our caller poll and just yield until connection_co is d=
one */
> > -        while (s->connection_co) {
> > -            aio_co_schedule(qemu_get_current_aio_context(),
> > -                            qemu_coroutine_self());
> > -            qemu_coroutine_yield();
> > -        }
> > +        /* just yield until connection_co is done */
> > +        s->teardown_co =3D qemu_coroutine_self();
> > +        qemu_coroutine_yield();
> >      } else {
> >          BDRV_POLL_WHILE(bs, s->connection_co);
> >      }
> > @@ -217,6 +215,9 @@ static coroutine_fn void nbd_connection_entry(void =
*opaque)
> >      bdrv_dec_in_flight(s->bs);
> >=20
> >      s->connection_co =3D NULL;
> > +    if (s->teardown_co) {
> > +        aio_co_wake(s->teardown_co);
> > +    }
> >      aio_wait_kick();
> >  }
> >=20
>=20
>=20




--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdKG2mAAoJEH8JsnLIjy/WsGYP/j1wPsqLxGgdVsuAjWvmloF8
39ydqT+CS/WVE3iNkBx3EpGRjMVeXA5/lZKXgR2bVKJY5GM/fy6L5/k9bPFa4gvL
x1hamE2GNN+TyD1ILJvHN769HG9j8C1WLNPLarh3erjY9Bu5qkGPEBmy+wI5DdmW
8I+ccB4+DEJqwwdQB3Tl3WTOOKHP/ppTvkwzyoKmfDBfPD7HGYaUj/SDgQgCc/f1
MrVlqwey00xjToSZ8q3J5iUw+U9Z9nZdWEPm/7ZkE8ufzo3yciMHvunicuOWyINw
Z7H1kngsNGAwESZDznMl0oPt3w+TFOaUHFy7dglHFNI8Ikbyjn5uVM637tdrSKP9
bbX5CRbHgIBj/e59/AXNFeFQXSaOsTObLNdC6rhU8VtCthm3pOYRtIAij8vD3x2O
ZFEuu+7kJt4MjLFbscITl4vrn8fLDOulCeRpC3tyibDF5Ic1Q8v9nXpteLVCJSBN
smKT3X+vP6N6TADNl1OG0UObr83bgn6J1pJ37/0PXMc4Y7MR3GpO4tDPINtDfqKW
YxqPr6WiNTGoUMyJNf0pRpA/DT1GH0zAVQjujHuf6mRckaZp64fENTf0PRSM6nN3
nCnaZq10PF9UfD0mWnxj45fNik/z30ShNJdxGlX4zljuGwH3pUWyGYhDqE9rflUA
gjaCvaC2LfLhUTB3JIt1
=npG/
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--

