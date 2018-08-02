Received: from eggs.gnu.org ([2001:4830:134:3::10]:52557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1flEGi-0005tp-Mf
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1flEGh-0007MZ-MO
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:07:56 -0400
Date: Fri, 3 Aug 2018 00:07:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180802140744.GD11211@umbus.fritz.box>
References: <20180801035357.7804-1-david@gibson.dropbear.id.au>
	<CAFEAcA-FitsqU3kQJTFGSFgOh6Zsf2Zy2fO3OTnL5c+Tzi5pog@mail.gmail.com>
	<alpine.BSF.2.21.1808011300070.7488@zero.eik.bme.hu>
	<CAFEAcA-=c7O+h3c-gQ=31q0oyLzJhDNmEBzv4X2Yp_TBfYhC-w@mail.gmail.com>
	<20180802070824.GC11211@umbus.fritz.box>
	<CAFEAcA8sGVjGgXxR8ivSWJ6oDKJPfEGnWUuHh_quZK2GDSgU2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eqp4TxRxnD4KrmFZ"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8sGVjGgXxR8ivSWJ6oDKJPfEGnWUuHh_quZK2GDSgU2A@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 0/2] ppc-for-3.0 queue 20180801
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>


--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 02, 2018 at 10:16:32AM +0100, Peter Maydell wrote:
> On 2 August 2018 at 08:08, David Gibson <david@gibson.dropbear.id.au> wro=
te:
> > The macio fix, however, *is* a regression from 2.12.  Whether it's
> > severe enough to warrant another -rc, I'm not sure.  It is a bad
> > pointer access which is, well, bad.  It doesn't seem to bite
> > obviously, needing valgrind to pick it up, but possibly that's just
> > luck.
>=20
> I thought those introspection-bugs like the macio ones weren't
> regressions ?

Well, I ran Thomas's testcase on master and it generates several
valgrind warnings, which don't appear on either 2.12 or master+the
patch.

> Certainly the devices have been leaking a refcount
> in their init methods for a long time. I don't view these as
> very important bugs, though, as they only manifest if you
> try to introspect fixed-always-present device/SoC objects,
> which in practice I don't think anybody does except as
> part of "test every device via introspection" test cases.
>=20
> thanks
> -- PMM
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eqp4TxRxnD4KrmFZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltjEC4ACgkQbDjKyiDZ
s5JopA/+M2hmhMWRjogaZNifaFLW4eRjeZ/uJ6Vyxhfb/sUjOzCge0JrApA7A0eV
l0quWZuEDY/rA6679w3sUEfMVyvYpHQV2qi6gEUdF6bvFI1/6OIJfRmqD/HER2HW
ZCcvR+OrTp0PwoRyaR5xd4+UPxs2RXcd/uPgK4DcxWjCIMH93l9xjVegcTJhd+W6
2MXgj2ATqAvRM4gmVE4Sdy8BNE6BobrokrAxl3FmCf8jhd65hbUaD9egtm5xq8wM
xmXeBeK73uXn1g+ASlPklT90lo24qg98vyoGr4UdmCO/OBP2yCQKT/D9g3h6xU5Y
S6fsIqRvWywr9M4aezxBmeD66zi02oCsOsOSNLLhuf+gQ1lOaxU/51bhfy6Tp2R5
c1F3hr0kUJ991eZ1/7WN1rl+b/5yF+0BcaJx9+aPQq/wrKRCGNdzdAhTpYLnxfLZ
vps2/V3zHjegw1/o79MSrmEJq4NL1oEEOn9GJprHonQrwMNIKa/+JzZJIwjP1KNX
yuqfV6AVRlbp0/S2sFcEnyFwWk7KRo4AVBQtGibfTytJ6/xgzWxOKE5qajCiji26
wPR7UPmDkZFVEWRBb/ANxyyH+BaeBgyjgwQWvranjK16OGxrmQqJoSNWdHR3lW0c
ZTy0KSxA8HnCf110DW+TwakFmhssmr1m6UWXaunx6/EcZqQ/aOA=
=00la
-----END PGP SIGNATURE-----

--eqp4TxRxnD4KrmFZ--
