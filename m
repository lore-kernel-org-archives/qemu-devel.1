Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1085AC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4F620578
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4F620578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs6mN-0000Dz-Vj
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 10:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60890)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hs6lz-0008CY-Sh
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hs6ly-0005XT-Kz
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:37:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31828)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hs6lv-0005Vp-So; Mon, 29 Jul 2019 10:37:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2C61C3CA0E;
 Mon, 29 Jul 2019 14:37:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-188.ams2.redhat.com
 [10.36.116.188])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A0465D6A5;
 Mon, 29 Jul 2019 14:37:05 +0000 (UTC)
Date: Mon, 29 Jul 2019 16:37:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190729143704.GB5757@localhost.localdomain>
References: <20190729105343.19250-1-kwolf@redhat.com>
 <816934c1-419d-10c0-4b13-c6304e832cbb@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <816934c1-419d-10c0-4b13-c6304e832cbb@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 29 Jul 2019 14:37:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1] block/copy-on-read: Fix
 permissions for inactive node
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 29.07.2019 um 15:35 hat Eric Blake geschrieben:
> On 7/29/19 5:53 AM, Kevin Wolf wrote:
> > The copy-on-read drive must not request the WRITE_UNCHANGED permission
> > for its child if the node is inactive, otherwise starting a migration
> > destination with -incoming will fail because the child cannot provide
> > write access yet:
> >=20
> >   qemu-system-x86_64: -blockdev copy-on-read,file=3Dimg,node-name=3Dcor=
: Block node is read-only
> >=20
> > Earlier QEMU versions additionally ran into an abort() on the migration
> > source side: bdrv_inactivate_recurse() failed to update permissions.
> > This is silently ignored today because it was only supposed to loosen
> > restrictions. This is the symptom that was originally reported here:
> >=20
> >   https://bugzilla.redhat.com/show_bug.cgi?id=3D1733022
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/copy-on-read.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
>=20
> Do any of the iotests cover this?  Should they, especially if you are
> trying to get this in for -rc3 tomorrow?

No, we don't have any iotests for migration with filter drivers yet. We
probably should, but I didn't want to miss -rc3 with the fix because I
was busy writing a test case.

> >=20
> > diff --git a/block/copy-on-read.c b/block/copy-on-read.c
> > index 22f24fd0db..6631f30205 100644
> > --- a/block/copy-on-read.c
> > +++ b/block/copy-on-read.c
> > @@ -56,16 +56,14 @@ static void cor_child_perm(BlockDriverState *bs, Bd=
rvChild *c,
> >                             uint64_t perm, uint64_t shared,
> >                             uint64_t *nperm, uint64_t *nshared)
> >  {
> > -    if (c =3D=3D NULL) {
> > -        *nperm =3D (perm & PERM_PASSTHROUGH) | BLK_PERM_WRITE_UNCHANGE=
D;
> > -        *nshared =3D (shared & PERM_PASSTHROUGH) | PERM_UNCHANGED;
> > -        return;
> > -    }
> > +    *nperm =3D perm & PERM_PASSTHROUGH;
> > +    *nshared =3D (shared & PERM_PASSTHROUGH) | PERM_UNCHANGED;
> > =20
> > -    *nperm =3D (perm & PERM_PASSTHROUGH) |
> > -             (c->perm & PERM_UNCHANGED);
> > -    *nshared =3D (shared & PERM_PASSTHROUGH) |
> > -               (c->shared_perm & PERM_UNCHANGED);
>=20
> The old code unconditionally returned one set of permissions when c =3D=3D
> NULL, or made a choice based on c's existing permissions on whether to
> pass in those two bits.
>=20
> > +    /* We must not request write permissions for an inactive node, the=
 child
> > +     * cannot provide it. */
> > +    if (!(bs->open_flags & BDRV_O_INACTIVE)) {
> > +        *nperm |=3D BLK_PERM_WRITE_UNCHANGED;
> > +    }
>=20
> The new code changes the condition for or'ing in WRITE_UNCHANGED to
> *nperm (it is no longer dependent on whether c =3D=3D NULL, but whether t=
he
> drive is inactive), which matches your commit message.
>=20
> But the new code also changes to always pass in the PERM_UNCHANGED to
> *nshared; that used to be skipped if c was non-NULL and did not already
> have the permission.  I don't follow that change from the commit
> message, am I missing something?

The old code didn't actually do anything that should have a different
result (apart from WRITE_UNCHANGED for inactive images), just everything
in a more complicated way for no apparent reason. Or at least that's
what Max and I concluded after looking at this.

Taking the PERM_UNCHANGED bits from the old value effectively means that
they are taken from the very first call, which had c =3D=3D NULL. So we can
just use the same code to set them instead of referring to the old
values of c->perm and c->shared_perm (which is really something a
=2Ebdrv_child_perm implementation shouldn't do - there are more cases, but
we can clean them up for 4.2).

Not cleaning this up would mean that I'd have to explicitly clear the
WRITE_UNCHANGED bit after uselessly copying from the old state. This
would be further complication of already unnecessarily complicated code,
so I decided that cleaning it up so that its correctness becomes very
obvious (request everything the parent nodes need, plus WRITE_UNCHANGED
for the copy on read functionality if the node is active) makes more
sense.

Kevin

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdPwSQAAoJEH8JsnLIjy/W2e4QALuwW9e+FFvjSTFtAyBv6mgb
hfCC/8JxbPFjEqOYSOd75lSvNUv/VKxTcMrQPkW53UDF8OCpv21V2lLWIhHAqWvF
nY7HOzLhFmcOY9FmKr7zs7WG22/EPn5ftWHaRdEsCXbb5Z3ylQkhnjeIAFFtYcaU
sTxKPdwH3DKJxhDySG3tTc2ScwfAsxn4StH3/kujnG4eiuZfGayCDiSQC20XBZUM
C0HXRW1i1N1UJOapMHclsJKZMHLA6q+TynhMhnozf9+VjVI11ef2tqJ+VsJSUzFr
0XewtP7+KX/1KupFDd0i1lNO6AaeVsaH/XEo+OUhBuvSglDM5VLJT2hlkThPs2u5
JYDs9s58fS7m0LHWOZLMXYiuWdN06cM4GnoYp0TB+BdvtgJxHoe12PeninllvupL
/kGEA8k3aQlvwFmTKnL2oYPiwLp3mZGDtJTew11v+UaNk11vFM2bZH1tALV1941P
xXOmoRo3RXbAi0cXjiCqFqrHeoQ6XBSjBwfZ3leDNrHqtMKh0s5F+3jn9fG1faXO
QPZy2pm4larabEr8K6TheUCFjXcLwQ3DBCZm6jRlNKBL9Hbz/S6mZBMA87f6gOsW
9vZVLxGh1t/PBIZTzSXafBXcnLzVapQg+xxg0+Og9BO8pCivesktQZdSqH075RLh
V5tsQBYLu/whz2b47DNm
=HG2M
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--

