Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E28EC32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:13:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED57C2087C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED57C2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htXN9-0004jT-7L
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 09:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47088)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1htXMi-00044n-Gc
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1htXMh-0004Qv-Ab
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:13:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1htXMe-0004Lj-Mj; Fri, 02 Aug 2019 09:12:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 378A7300BC74;
 Fri,  2 Aug 2019 13:12:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-107.ams2.redhat.com
 [10.36.117.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B4985C220;
 Fri,  2 Aug 2019 13:12:48 +0000 (UTC)
Date: Fri, 2 Aug 2019 15:12:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190802131247.GB6379@localhost.localdomain>
References: <20190724094025.12442-1-vsementsov@virtuozzo.com>
 <1977e825-0a1f-e575-2ffa-0ea8c65531bb@redhat.com>
 <7a7c668b-eac0-eadd-7065-689c5eae6ce0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <7a7c668b-eac0-eadd-7065-689c5eae6ce0@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 02 Aug 2019 13:12:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] blockjob: drain all job nodes in
 block_job_drain
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 01.08.2019 um 21:44 hat Max Reitz geschrieben:
> On 30.07.19 21:11, John Snow wrote:
> >=20
> >=20
> > On 7/24/19 5:40 AM, Vladimir Sementsov-Ogievskiy wrote:
> >> Instead of draining additional nodes in each job code, let's do it in
> >> common block_job_drain, draining just all job's children.
> >> BlockJobDriver.drain becomes unused, so, drop it at all.
> >>
> >> It's also a first step to finally get rid of blockjob->blk.
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> ---
> >>
> >> v3: just resend, as I've some auto returned mails and not sure that
> >>     v2 reached recipients.
> >>
> >> v2: apply Max's suggestions:
> >>  - drop BlockJobDriver.drain
> >>  - do firtly loop of bdrv_drained_begin and then separate loop
> >>    of bdrv_drained_end.
> >>
> >>    Hmm, a question here: should I call bdrv_drained_end in reverse
> >>    order? Or it's OK as is?
> >>
> >=20
> > I think it should be OK. These nodes don't necessarily have a well
> > defined relationship between each other, do they?
>=20
> It=E2=80=99s OK.  If they do have a relationship, the drain code sorts it=
 out by
> itself anyway.
>=20
> [...]
>=20
> > Seems much nicer to me. What becomes of the ref/unref pairs?
> >=20
> > I guess not needed anymore?, since job cleanup necessarily happens in
> > the main loop context now and we don't have a backup_complete function
> > anymore ...?
> >=20
> > In the cases where auto_finalize=3Dtrue, do we have any guarantee that =
the
> > completion callbacks cannot be scheduled while we are here?
>=20
> Let me try to figure this out...
>=20
> The only caller of block_job_drain() is job_drain(), whose only caller
> is job_finish_sync() in an AIO_WAIT_WHILE() loop.  That loop can only
> work in the main loop, so I suppose it does run in the main loop (and
> consequentially, block_job_drain() runs in the main loop, too).
>=20
> That AIO_WAIT_WHILE() loop drains the job (so all nodes) and waits until
> the job has completed.  To me that looks like it is designed to have the
> completion callback run at some point...?

Yes, definitely.

However, I wonder why we do this blk_drain(). We are not really
interested in stopping all requests to the nodes involves in the job, we
just want to get the job to make progress so that it will eventually
complete. Draining looks like the entirely wrong tool to me.

This was introduced in commit bae8196d9f9, and it looks to me as if it
was a hack because drain could work cross-AioContext and everything else
couldn't.

Today we use AIO_WAIT_WHILE() in job_finish_sync(), so I wonder if maybe
the whole drain part is unnecessary now and just doing the job_enter()
part would be enough.

> I suppose anything like that is scheduled by job_enter() in job_drain(),
> namely the aio_co_enter() in there.
>=20
> (A) If the job runs in the main AioContext, aio_co_enter() will enter
> the coroutine if we do not run in a coroutine right now (safe), or it
> will schedule it for a later point if we do run in a coroutine.  That
> latter part may be unsafe, because I guess some coroutine work in
> bdrv_drained_begin() or bdrv_drained_end() may wake it up, which can
> then mess everything up.

It should be fine, actually. The drain functions drop out of coroutine
context to avoid such problems. So if it gets woken up, it's before the
actual drain has started.

> (B) If the job runs in another context, aio_co_enter() will schedule the
> job immediately, which I guess means that it can run at any point?  So
> it could complete at any point, including block_job_drain().  Ah, no,
> actually.  AIO_WAIT_WHILE() will have the job=E2=80=99s context acquired =
while
> evaluating the condition (that is, when calling block_job_drain()).  So
> this is safe.
>=20
>=20
> So, well.  Unless Vladimir can give you a guarantee why e.g.
> block_job_remove_all_bdrv() won=E2=80=99t run during e.g. bdrv_drained_be=
gin(),
> I suppose you=E2=80=99re right and the node list needs to be copied at the
> beginning of this function and all nodes should be ref=E2=80=99d.

At some point, it will probably run, in the polling phase of
bdrv_drained_begin().

Kevin

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdRDbPAAoJEH8JsnLIjy/WBm0P/RDsxVZjnIjQ9fVI2rdb6Xna
sJs2CM8049nqkdD3y6E9ddAOU8hJx6dkuSo08geYWME4dr3CTYWzZ+h2WYntI5+p
Bt765yiJyfEUK+G+7k04FwBaGp5mkbFw7ZaG7IvPkxubPfKgAtNQtqwLo0yXgSen
a+O8rfDU3TC2UzvtLF6V/fqlvelpxkBFgb/HDP6D+EJvTnB9a/0L9SWCqX/oj7nS
scpxna6MzhLk2Z5lEgeZfsGBcGos4hIj+JohbjR5l82TXMAkjEyy95MF8KmwZzzL
M1a70c9h9MdObLdtM/Sm8b9ZFxGaok1/DP/HcC0QEorYxtbykjlrGy5SAfsq0Woa
dlbxNDKcEMSYeCKvzJY694kttyKlJbGVEBZUXDcRrcgS61jigqVrqvxR4wZIYPiQ
umdOEl2LlMs53xzULTHDiV7fRsh9AfaYfNPD+YyRhannF2kDk+oDsPNQVLdGsuqx
6mXRmNsPKhjjbixdGLKwj0w6g8vC5fi8THhFsPIisbTvhunsB9Vb3jETloFvx+a2
VoZ+jaoCJY604l8PnEKsCrNDRvdaozX26Zi1huffb7odUDghVAWiZjb3DdLDhN92
a2GGrD/AtDSV5Z5Gbd20zZJXiwNTZnmhrV4XJM5OMa9KTKuKv50fwhtyz1slFdA3
ckVZHeNHJQ2HBGwHLLeE
=lBGl
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

