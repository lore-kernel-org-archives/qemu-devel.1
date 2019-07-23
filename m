Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4060EC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F06A20823
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F06A20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hprdV-00076m-CP
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55263)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hprdI-0006bQ-BR
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hprdH-0004bN-3f
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:02:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hprdD-00044b-Ew; Tue, 23 Jul 2019 06:02:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 37F2785365;
 Tue, 23 Jul 2019 10:02:46 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-32.ams2.redhat.com
 [10.36.116.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EDE319C58;
 Tue, 23 Jul 2019 10:02:45 +0000 (UTC)
Date: Tue, 23 Jul 2019 12:02:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190723100243.GA11008@localhost.localdomain>
References: <20190722133054.21781-1-mreitz@redhat.com>
 <20190722133054.21781-3-mreitz@redhat.com>
 <20190723085236.GA5296@localhost.localdomain>
 <91179292-29aa-4d00-78ac-a8861fd5f308@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <91179292-29aa-4d00-78ac-a8861fd5f308@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 23 Jul 2019 10:02:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1 2/2] block: Only the main loop can
 change AioContexts
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 23.07.2019 um 11:41 hat Max Reitz geschrieben:
> On 23.07.19 10:52, Kevin Wolf wrote:
> > Am 22.07.2019 um 15:30 hat Max Reitz geschrieben:
> >> bdrv_set_aio_context_ignore() can only work in the main loop:
> >> bdrv_drained_begin() only works in the main loop and the node's (old)
> >> AioContext; and bdrv_drained_end() really only works in the main loop
> >> and the node's (new) AioContext (contrary to its current comment, which
> >> is just wrong).
> >>
> >> Consequentially, bdrv_set_aio_context_ignore() must be called from the
> >> main loop.  Luckily, assuming that we can make block graph changes only
> >> from the main loop as well, all its callers do that already.
> >>
> >> Note that changing a node's context in a sense is an operation that
> >> changes the block graph, so it actually makes sense to require this
> >> function to be called from the main loop.
> >>
> >> Also, fix bdrv_drained_end()'s description.  You can only use it from
> >> the main loop or the node's AioContext, and in the latter case, the
> >> whole subtree must be in the same context.
> >>
> >> Fixes: e037c09c78520cbdb6da7cfc6ad0256d5870b814
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >>  include/block/block.h |  8 +++-----
> >>  block.c               | 13 ++++++++-----
> >>  2 files changed, 11 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/include/block/block.h b/include/block/block.h
> >> index 60f00479e0..50a07c1c33 100644
> >> --- a/include/block/block.h
> >> +++ b/include/block/block.h
> >> @@ -667,11 +667,9 @@ void bdrv_subtree_drained_begin(BlockDriverState =
*bs);
> >>   *
> >>   * This polls @bs's AioContext until all scheduled sub-drained_ends
> >>   * have settled.  On one hand, that may result in graph changes.  On
> >> - * the other, this requires that all involved nodes (@bs and all of
> >> - * its parents) are in the same AioContext, and that the caller has
> >> - * acquired it.
> >> - * If there are any nodes that are in different contexts from @bs,
> >> - * these contexts must not be acquired.
> >> + * the other, this requires that the caller either runs in the main
> >> + * loop; or that all involved nodes (@bs and all of its parents) are
> >> + * in the caller's AioContext.
> >>   */
> >>  void bdrv_drained_end(BlockDriverState *bs);
> >=20
> > I think you are right about the requirement that bdrv_drained_end() is
> > only called from the main or the BDS AioContext, which is a requirement
> > that directly comes from AIO_WAIT_WHILE().
> >=20
> > However, I don't see why we have requirements on the AioContext of the
> > parent nodes (or any other nodes), except possibly not holding their
> > lock.  We don't poll their context, so it shouldn't matter in which
> > context they are?
>=20
> Hm.  I don=E2=80=99t know how I got confused there, you=E2=80=99re right.
>=20
> I don=E2=80=99t think the (falsely given) restriction hurts, though, beca=
use a
> subtree should be within a single context anyway (unless you=E2=80=99re in
> bdrv_set_aio_context_ignore(), which needs to be in the main context).
>=20
> So, hm, yes, I messed up this comment a bit now.  But now it=E2=80=99s ju=
st more
> restrictive than it needs to be and I don=E2=80=99t think callers are goi=
ng to
> care, so...

Nothing that should hold up your pull request, but I'd prefer to fix the
comment in a follow-up.

One thing where I could imagine it becoming relevant in the future is
cross-context block jobs. At the moment, we automatically pull the
target node into the AioContext of the source and fail if this isn't
possible, but that's really overly restrictive.

Kevin

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdNttDAAoJEH8JsnLIjy/WCrMP/2Lj8YLL5/M5zinAeKo5yy6O
EmcBXiCZzvmhcS2R6HmO0/nnvYu9jbbv9y7xS39HH4Ps7U+FyPXy6fbaTlou9Zkh
IZZ8DGIQP6rTghipWweVOSWR7DsiSfhm1p0vnZ9Ywm6IJGJYauFagwnCADETMN6P
rp2WspMGlFH8vgasHTHSNtrFDTsbKsYTUONz0F/5ajwSro4CssXtBQTl8DIFp8LL
Zr1Nr4JrN11VUPQBOO+FNOC1hB5joB3Z4y97Q5O0KK88GjDeScGdrfxdrdrLfasi
NT0CGDmCKpX9nw+RAVkQFeLJ9ou5tLK1aiQ69WfPoxFng5KZ9yNC05ig1G41GEOJ
Y1LXJtQeEPLF38G/3KmGAf2Nsl7fI+DWnfU7ZiN2Vt3riq6x1VZ9YWLWjHmUJr90
Cl8RQQSLw7uH2/YWp9eLJTHHPqxIcH9oB+mjWZ1x241+EozPYFEoBhLn9N8WSWxC
AGYlbAeZnTu+HyctSep0tL7CjqkVqCjHPX3R8d92/Yme+sM8skeFzURqZAz3dPqH
KTeKnYSQlUbZCnmP+dw7JuBT+ruiS94GAn/3YewcqlNnIHQpkCw+lq4NEpvQHU0C
kYFCSKhhDz42sw+/OWY4L4DASWH8YR0iJpFkaeWLDfN6vXmYBYZVX0bjtDllHrUh
InXc6gQF+NO7ffyIL0Ex
=2xnh
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--

