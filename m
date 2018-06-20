Received: from eggs.gnu.org ([2001:4830:134:3::10]:54769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVRQG-0004Ys-H6
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 20:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVRQF-0004vh-Kr
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 20:56:32 -0400
Date: Wed, 20 Jun 2018 10:56:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180620005622.GG3546@umbus.fritz.box>
References: <20180615152536.30093-1-clg@kaod.org>
	<20180615152536.30093-4-clg@kaod.org>
	<20180618103844.GX25461@umbus.fritz.box>
	<9d1ce421-9caa-08eb-2417-15307dd271ed@kaod.org>
	<20180618121328.GY25461@umbus.fritz.box>
	<048d2369-389f-1118-03b0-b81e6bd565a0@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="64j1qyTOoGvYcHb1"
Content-Disposition: inline
In-Reply-To: <048d2369-389f-1118-03b0-b81e6bd565a0@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] ppc/pnv: introduce Pnv8Chip and
 Pnv9Chip models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 07:24:44AM +0200, C=E9dric Le Goater wrote:
>=20
> >>>  typedef struct PnvChipClass {
> >>>      /*< private >*/
> >>> @@ -75,6 +95,7 @@ typedef struct PnvChipClass {
> >>> =20
> >>>      hwaddr       xscom_base;
> >>> =20
> >>> +    void (*realize)(PnvChip *chip, Error **errp);
> >>
> >> This looks the wrong way round from how things are usually done.
> >> Rather than having the base class realize() call the subclass specific
> >> realize hook, it's more usual for the subclass to set the
> >> dc->realize() and have it call a k->parent_realize() to call up the
> >> chain.  grep for device_class_set_parent_realize() for some more
> >> examples.
> >
> > Ah. That is more to my liking. There are a couple of models following
> > the wrong object pattern, xics, vio. I will check them.
>=20
> So XICS is causing some head-aches because the ics-kvm model inherits
> from ics-simple which inherits from ics-base. so we have a grand-parent
> class to handle.

Ok.  I mean, we should probably switch ics around to use the
parent_realize model, rather than the backwards one it does now.  But
it's not immediately obvious to me why having a grandparent class
breaks things.

> if we could affiliate ics-kvm directly to ics-base it would make the=20
> family affair easier. we need to check migration though.

But that said, I've been thinking for a while that it might make sense
to fold ics-kvm into ics-base.  It seems very risky to have two
different object classes that are supposed to have guest-identical
behaviour.  Certainly adding any migratable state to one not the other
would be horribly wrong.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsppjQACgkQbDjKyiDZ
s5K0ig//X+I8MSrMwQejePZntlLjGrPDlOGYuXtoXNkSR15JJPdwPvGE9V3laZA3
BKfpC7h602QYsxjEg6W76+BtIlfXdxhkuw35l7ZVx9s3L3YVR5IVtEVwKh/Nhu7N
nL7WfVsyh+lX0y7slsek+huToiLx8sGeTB1lY6UUdVyK18RvdD72NRTg+sJOAlmA
Bts4v2yiz9ho/31gQvnOTfEjQpUTwjuj6yGTYElG0ghsfPohO8ArRkG639j6cX7h
rMg2x40L1Fbc3b1xgMtID3pwBTKqq2p1731nUoYmsew0Wrq9agTYdb2T+UX5/6sP
4LycdnniZnfJ096JsQil5uoqudXEJ3f0KugrQqXe9F6F7ncp/GI+FjACqs6Nr+bz
nf+T3x/WOBSMARNZEbhlMeTDWR/VQtMiE0ES2CFT6cGREl3RkSFlNA/VlqQWT5j7
TRgoqgFJ9q11MsshnQbuN7GqSwrVw/h3LqJhuypLkU+ER85uQC7qCocKvYCQPVrF
JAqbl8kfN+kNLDV08cn4NkL+Xnd4mghlIgd6hIPUEJ0z3oHvXpDsfwydwUaqzDit
7zgjjS4E5LpcW+NNK2udWlS4rpl5O3bZ0FOsJv0idGJEjU6UKK3CyhTEf4Hq/x9/
RUn5Cw8EyK68rTwuUyE48iDmUjlZUgLclyxmAlivZ06OyREqbWE=
=jR/H
-----END PGP SIGNATURE-----

--64j1qyTOoGvYcHb1--
