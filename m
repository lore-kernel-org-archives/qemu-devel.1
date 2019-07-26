Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F21C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 11:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2634F229F3
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 11:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2634F229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqyjb-0005TG-CF
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 07:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51688)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hqyjP-000518-V2
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hqyjK-0004o2-Q3
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:49:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47740)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hqyjF-0004Qq-26; Fri, 26 Jul 2019 07:49:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4171230917AA;
 Fri, 26 Jul 2019 11:49:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-109.ams2.redhat.com
 [10.36.116.109])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79EFC101E24B;
 Fri, 26 Jul 2019 11:49:32 +0000 (UTC)
Date: Fri, 26 Jul 2019 13:49:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190726114930.GD6295@localhost.localdomain>
References: <20190725162704.12622-1-kwolf@redhat.com>
 <20190725162704.12622-5-kwolf@redhat.com>
 <6c00ea43-5b9f-5fb7-3e52-86bcf3933668@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <6c00ea43-5b9f-5fb7-3e52-86bcf3933668@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 26 Jul 2019 11:49:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/4] block-backend: Queue requests while
 drained
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
Cc: dplotnikov@virtuozzo.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 26.07.2019 um 12:50 hat Max Reitz geschrieben:
> On 25.07.19 18:27, Kevin Wolf wrote:
> > This fixes device like IDE that can still start new requests from I/O
>=20
> *devices
>=20
> > handlers in the CPU thread while the block backend is drained.
> >=20
> > The basic assumption is that in a drain section, no new requests should
> > be allowed through a BlockBackend (blk_drained_begin/end don't exist,
> > we get drain sections only on the node level). However, there are two
> > special cases where requests should not be queued:
> >=20
> > 1. Block jobs: We already make sure that block jobs are paused in a
> >    drain section, so they won't start new requests. However, if the
> >    drain_begin is called on the job's BlockBackend first, it can happen
> >    that we deadlock because the job stays busy until it reaches a pause
> >    point - which it can't if it's requests aren't processed any more.
> >=20
> >    The proper solution here would be to make all requests through the
> >    job's filter node instead of using a BlockBackend. For now, just
> >    disabling request queuin on the job BlockBackend is simpler.
>=20
> Yep, seems reasonable.
>=20
> (We=E2=80=99d need a relationship that a BB is owned by some job, and the=
n pause
> the job when the BB is drained, I suppose.  But that=E2=80=99s exactly
> accomplished by not making the job use a BB, but its BdrvChild
> references instead.)

We actually had this before commit ad90feba, when we changed it to use
the job's BdrvChild objects instead. All block jobs have both currently,
they just don't use their BdrvChild objects much.

> > 2. In test cases where making requests through bdrv_* would be
> >    cumbersome because we'd need a BdrvChild. As we already got the
> >    functionality to disable request queuing from 1., use it in tests,
> >    too, for convenience.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/sysemu/block-backend.h | 11 +++---
> >  block/backup.c                 |  1 +
> >  block/block-backend.c          | 69 +++++++++++++++++++++++++++++-----
> >  block/commit.c                 |  2 +
> >  block/mirror.c                 |  6 ++-
> >  blockjob.c                     |  3 ++
> >  tests/test-bdrv-drain.c        |  1 +
> >  7 files changed, 76 insertions(+), 17 deletions(-)
>=20
> [...]
>=20
> > diff --git a/block/block-backend.c b/block/block-backend.c
> > index fdd6b01ecf..603b281743 100644
> > --- a/block/block-backend.c
> > +++ b/block/block-backend.c
>=20
> [...]
>=20
> > @@ -1127,13 +1136,26 @@ static int blk_check_byte_request(BlockBackend =
*blk, int64_t offset,
> >      return 0;
> >  }
> > =20
> > +static void blk_wait_while_drained(BlockBackend *blk)
>=20
> +coroutine_fn?  (Maybe even blk_co_wait...)
>=20
> > +{
> > +    if (blk->quiesce_counter && !blk->disable_request_queuing) {
> > +        qemu_co_queue_wait(&blk->queued_requests, NULL);
> > +    }
> > +}
> > +
> >  int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
> >                                 unsigned int bytes, QEMUIOVector *qiov,
> > -                               BdrvRequestFlags flags)
> > +                               BdrvRequestFlags flags, bool wait_while=
_drained)
>=20
> What=E2=80=99s the purpose of this parameter?  How would it hurt to always
> wait_while_drained?
>=20
> I see the following callers of blk_co_p{read,write}v() that call it with
> wait_while_drained=3Dfalse:
>=20
> 1. blk_aio_{read,write}_entry(): They wait themselves, so they don=E2=80=
=99t
>    need these functions to wait.  But OTOH, because they have waited, we
>    know that the BB is not quiesced here, so we won=E2=80=99t wait here a=
nyway.
>    (These functions should be coroutine_fn, too, by the way)

I think I was worried that the coroutine might yield between the two
places. Later I noticed that blk_wait_while_drained() must be the very
first thing anyway, so maybe it doesn't matter any more now.

If we did yield here for requests coming from blk_aio_prwv(), in_flight
would be increased and drain would deadlock.

Would you prefer if I just unconditionally wait if we're drained?

> 2. mirror: It disables request queuing anyway, so wait_while_drained
>    doesn=E2=80=99t have any effect.

Yes, I wasn't sure what to use there. false seemed like it would be
less likely to cause misunderstandings because it just repeats what
would happen anyway.

> >  {
> >      int ret;
> > -    BlockDriverState *bs =3D blk_bs(blk);
> > +    BlockDriverState *bs;
> > =20
> > +    if (wait_while_drained) {
> > +        blk_wait_while_drained(blk);
> > +    }
>=20
> [...]
>=20
> What about blk_co_flush()?  Should that wait, too?

Hm, probably, yes.

> > @@ -2232,6 +2278,9 @@ static void blk_root_drained_end(BdrvChild *child=
, int *drained_end_counter)
> >          if (blk->dev_ops && blk->dev_ops->drained_end) {
> >              blk->dev_ops->drained_end(blk->dev_opaque);
> >          }
> > +        while (qemu_co_enter_next(&blk->queued_requests, NULL)) {
> > +            /* Resume all queued requests */
> > +        }
>=20
> Wouldn=E2=80=99t qemu_co_queue_restart_all(&blk->queued_requests) achieve=
 the same?

It would fail an assertion because we're not in coroutine context.
(Guess what my first attempt was!)

Kevin

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdOujKAAoJEH8JsnLIjy/W82gP/2F5ibqvFudTIN4gkvpo9ClH
y4ArINshlt9WVE5OxOk1u6dHstnE4iQPPau/8id16Tu0Pyi2OQ0X91bispW+3sxF
9Qszdv584q/dvQM2jcFKqNnSyS5wRSdZj7Yyrk8AsswIpjDQXweU16NR8Q5E5VVY
+btpNLstEA+rM54cu7jeE6gBZmXU28m+q88UwXd7AbruTk70aNJJJt7OwJJMWfF2
JwG44RDhxZ/RaGLG7ziq/BXzQ1qd9gnE+HKxqVdK5uZwhzuTxjiy/QCNWjf1tpsN
XD/e6qJnDDjMpMVJQZCtTU2feV98x7QOhMTSe0V1V/KbWUatAGLTMYXeMPCqjcJQ
+rWHCWqP3+qIiSCF8v8iLfNia7jQ0aXGRtGkDeh5K6dTIt2B5cBMxQfEc1P0Nc7J
1leyix0OyC83C43KltuMN3lQUoO26doYrpyZxWpKVTNg2K8YJ/nnZOqV+8rPKSSe
4MPCgL6rBmCR6gAAX0sedGR5AqDnKdZw99riBqoQuo2moYjdD8xlsrCS7Xeqr9x2
bc/BuPsI4KnwEdTwBHEYf8maf2H6CkE/EGdzDvBSe7dt82SFHk1J9ACnqT4uPxNI
dGxC19+/4vwiLXVs75QGVyoFjMOI+6MY4/dBpDGqcvBcISKcDKHg+56bya6fpNlN
WRvr/GrGml3y6S5U0Uvi
=VSO9
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--

