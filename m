Received: from eggs.gnu.org ([2001:4830:134:3::10]:59847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcPbw-0004nm-9T
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 02:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcPbv-00063E-BW
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 02:25:24 -0400
Date: Mon, 9 Jul 2018 16:25:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180709062509.GH22363@umbus.fritz.box>
References: <ec95e71d-3d96-489d-6939-cdbef4d8c34e@gmail.com>
	<0e2e02a3-1737-abd8-e102-ebe22af549ec@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HuscSE0D68UGttcd"
Content-Disposition: inline
In-Reply-To: <0e2e02a3-1737-abd8-e102-ebe22af549ec@kaod.org>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] etsec: fix IRQ (un)masking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Michael Davidsaver <mdavidsaver@gmail.com>, Alexander Graf <agraf@suse.de>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--HuscSE0D68UGttcd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2018 at 08:20:03AM +0200, C=E9dric Le Goater wrote:
11;rgb:ffff/ffff/ffff> On 11/28/2017 03:42 AM, Michael Davidsaver wrote:
> > Interrupt conditions occurring while masked are not being
> > signaled when later unmasked.
> > The fix is to raise/lower IRQs when IMASK is changed.
> >=20
> > To avoid problems like this in future, consolidate
> > IRQ pin update logic in one function.
>=20
> it makes sense.
> =20
> > Also fix probable typo "IEVENT_TXF | IEVENT_TXF",
> > and update IRQ pins on reset.
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>

Thanks for the review C=E9dric.  Unfortunately, I've mislaid the
original patch.

Michael, can you resend with C=E9dric's R-b included, please.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HuscSE0D68UGttcd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltC/8IACgkQbDjKyiDZ
s5KidQ/9G4CO8jTiSmwU1r2jqk9fdG+IjhZtqavJqyakuBN4Y3dOTVlPyynFR0q/
n0HPNcEKbVJ7RhlhvKKYBK18erViQzRSMJMzFZ96QXwilixTNa8z5FFunfoxmZgQ
32H80yRIPmQZ39WHul/3hwZn/SUxRA9beupt8Bl3rbf/x1pLL4R4QlPhShuA8gdm
M0WTZGq1R8J9Tfx7U+VvCZjhMuObJ5nOgSralQCIJHHl+b67F9hA7GsA2U1boaFL
YNOXKNrfT1w9EQCiGxqAjsPEfNO0SLRiwY6Ofk28jPYb1O+EUievyOzYIZDPRQRb
y/DYUaZsQj80Q5xWL4p8ZFnSJ3RhSijytk5OCyhgpOG3EhRfeCn5+4TBdMivfQVf
c2sASFol3AlC95sZP1IrRF+mPYhdezE3LAIOl1qxbR6JiuHMKWZ82gB45Ss+LVlL
l0vFNo+fjCeDwDhLzL/tY46pM1IONPnYi1RLH+VcnrgouKPi2qRtEYl7Gy+s35OT
8vnMjZu/BRuIswJIqW2TS3Viagw1Mh5Ka+XGx6hPwmNClLgeCeMIqZ+fKB+jd8eB
n0I0oKC9eJkVQRQ42kIersbmUfZN8OopPWmT2wBWsuRqH7JQjNVztVi8/8u1v971
N1TR5O4qrfcTwXrXeEEGr2ilJW+4PHwuP2o3xXfGo181w/6iGpE=
=A2fU
-----END PGP SIGNATURE-----

--HuscSE0D68UGttcd--
