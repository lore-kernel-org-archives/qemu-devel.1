Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A153EC5AE5C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 09:57:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73DB62086D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 09:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73DB62086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7GPx-0004jy-Gv
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 05:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i7GOp-0003dE-Su
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i7GOo-00063d-G5
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:55:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i7GOl-00061I-Dr; Mon, 09 Sep 2019 05:55:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B4C2C102BB32;
 Mon,  9 Sep 2019 09:55:50 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-198.ams2.redhat.com
 [10.36.117.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA30A3D8F;
 Mon,  9 Sep 2019 09:55:48 +0000 (UTC)
Date: Mon, 9 Sep 2019 11:55:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190909095547.GB17606@localhost.localdomain>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-15-mreitz@redhat.com>
 <20190905140547.GC4911@localhost.localdomain>
 <c8ef1957-e656-80bf-7e53-a8a417861d26@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <c8ef1957-e656-80bf-7e53-a8a417861d26@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Mon, 09 Sep 2019 09:55:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 14/42] block: Use CAFs when working with
 backing chains
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
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 09.09.2019 um 10:25 hat Max Reitz geschrieben:
> On 05.09.19 16:05, Kevin Wolf wrote:
> > Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
> >> Use child access functions when iterating through backing chains so
> >> filters do not break the chain.
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >>  block.c | 40 ++++++++++++++++++++++++++++------------
> >>  1 file changed, 28 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/block.c b/block.c
> >> index 86b84bea21..42abbaf0ba 100644
> >> --- a/block.c
> >> +++ b/block.c
> >> @@ -4376,7 +4376,8 @@ int bdrv_change_backing_file(BlockDriverState *b=
s,
> >>  }
> >> =20
> >>  /*
> >> - * Finds the image layer in the chain that has 'bs' as its backing fi=
le.
> >> + * Finds the image layer in the chain that has 'bs' (or a filter on
> >> + * top of it) as its backing file.
> >>   *
> >>   * active is the current topmost image.
> >>   *
> >> @@ -4388,11 +4389,18 @@ int bdrv_change_backing_file(BlockDriverState =
*bs,
> >>  BlockDriverState *bdrv_find_overlay(BlockDriverState *active,
> >>                                      BlockDriverState *bs)
> >>  {
> >> -    while (active && bs !=3D backing_bs(active)) {
> >> -        active =3D backing_bs(active);
> >> +    bs =3D bdrv_skip_rw_filters(bs);
> >> +    active =3D bdrv_skip_rw_filters(active);
> >=20
> > This does more than the commit message says. In addition to iterating
> > through filters instead of stopping, it also changes the semantics of
> > the function to return the next non-filter on top of bs instead of the
> > next node.
>=20
> Which is to say the overlay.
>=20
> (I think we only ever use =E2=80=9Coverlay=E2=80=9D in the COW sense.)

I think we do, but so far also only ever for immediate COW childs, not
for skipping through intermediate node.

> > The block jobs seem to use it only for bdrv_is_allocated_above(), which
> > should return the same thing in both cases, so the behaviour stays the
> > same. qmp_block_commit() will check op blockers on a different node now,
> > which could be a fix or a bug, I can't tell offhand. Probably the
> > blocking doesn't really work anyway.
>=20
> You mean that the op blocker could have been on a block job filter node
> before?  I think that=E2=80=98s pretty much the point of this fix; that t=
hat
> doesn=E2=80=99t make sense.  (We didn=E2=80=99t have mirror_top_bs and th=
e like at
> 058223a6e3b.)

On the off chance that the op blocker actually works, it can't be a job
filter. I was thinking more of throttling, blkdebug etc.

> > All of this should be mentioned in the commit message at least. Maybe
> > it's also worth splitting in two patches.
>=20
> I don=E2=80=99t know.  The function was written when there were no filter=
s.

I doubt it. blkdebug is a really old filter.

> This change would have been a no-op then.  The fact that it isn=E2=80=99t=
 to me
> just means that introducing filters broke it.
>=20
> So I don=E2=80=99t know what I would write.  Maybe =E2=80=9Cbdrv_find_ove=
rlay() now
> actually finds the overlay, that is, it will not return a filter node.
> This is the behavior that all callers expect (because they work on COW
> backing chains).=E2=80=9D

Maybe just something like "In addition, filter nodes are not returned as
overlays any more. Instead, the first non-filter node on top of bs is
considered the overlay now."?

Kevin

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJddiGjAAoJEH8JsnLIjy/WKY0P/iAS78oylJB5L5gS9V1O2NWP
xY2h0NjUa7kdDFSYPDj4qhE23G+jKPDrfSDp6FIILZzY8DnosxzTD+Qp84LZ+05m
Hh0m9+Z/21wn6eZo3bHaPiiU7H4uXOXwAKoiexHykdH6fZsHcnCg585o6vZX2+J2
sPGmtB/WlLu2LDvA4dVEumo+d0r0udpj18Qqv4nRJLgWCmseKnVz7iXxiYjrpl6F
ri2pf6wnER22sRL9M/g5InhyKcRmbISgsnxi3sahDTlDRC0oZxvWX7ryjLao8DBY
dQqwCbkxjhNCBwRhirrF57NoDuruWCnMlVBN03/mvEojOWcWll/tz8jotnX+oQqM
p/Huf7gmjpVEBGQhZSbhGkC6WXyajNCyxHvWfQERCssxFnVTfBBr9beK+3H9b46D
pVGBywRbUCaZ0BP3e7/RuPpWhMY18nQFdMCLyAxkh671dhI59NmN8jDrzAKlUYCg
kknYjV+EYyDBlIPSubp9RrBwASlwmAWWfx9Ozklyv9rPd5NIaNsFqkMV7WJ16Xdc
ijVoqkY4wkDa7oZjcYN7oFZqpzgNULtzIuWqntQ3nssk1IntquVm0frqCNGXR4G5
c3YhGu+EoiOQoGQKvqk4sKFteK3v8gAV8j+QR8WsRmIF+VhSWwT6ziJ0tWjxCpVA
YVK80o5TPqK0/ERXIRSD
=li4r
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--

