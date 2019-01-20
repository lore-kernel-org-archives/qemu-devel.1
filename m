Received: from eggs.gnu.org ([209.51.188.92]:42143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1glN1Q-0001bt-Bz
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 19:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1glN1O-0006FI-ML
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 19:01:00 -0500
Date: Mon, 21 Jan 2019 09:29:30 +1300
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190120202930.GB2423@umbus>
References: <154772319819.1163472.4313149332350138217.stgit@bahia.lan>
	<9e554917-e78d-0cd6-8ed0-6fd2808c4a84@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <9e554917-e78d-0cd6-8ed0-6fd2808c4a84@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] spapr: Forbid setting ic-mode for old
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 12:58:46PM +0100, C=E9dric Le Goater wrote:
> On 1/17/19 12:06 PM, Greg Kurz wrote:
> > Machine types 3.0 and older only know about the legacy XICS backend.
> > Make it clear by erroring out if the user tries to set ic-mode on
> > such machines.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
>=20
>=20
> Tested-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

>=20
> Thanks,
>=20
> C.
>=20
> > ---
> >=20
> > Motivation for this comes from a failing backward migration test, caused
> > by ic-mode=3Dxics I forgot to drop from the command line :)
> > ---
> >  hw/ppc/spapr.c |    5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 0942f35bf87e..6b8dbf5c5a3c 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3126,6 +3126,11 @@ static void spapr_set_ic_mode(Object *obj, const=
 char *value, Error **errp)
> >  {
> >      sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > =20
> > +    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> > +        error_setg(errp, "This machine only uses the legacy XICS backe=
nd, don't pass ic-mode");
> > +        return;
> > +    }
> > +
> >      /* The legacy IRQ backend can not be set */
> >      if (strcmp(value, "xics") =3D=3D 0) {
> >          spapr->irq =3D &spapr_irq_xics;
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxE2ioACgkQbDjKyiDZ
s5LljxAArXkF+BhUzoHbIyhJJa1VzCSfYER87fVhUJ7dGaa77NirKsBHSMm1UaBd
Nhiwc3olwfIlDPSk8Xgr/mltDpfO6ePHmFmzwikGHQaMosbi1q0aN/nLOQC8qObe
xY0yz56yOrY4JNFPp+9j8AyMvXkPMc5ZoIFVI2lVWMRA6lR1Xnx+qTaJ9GJYQUU2
TqP79QTUXT5MseMEFxFHOpVcOQ46pWWWFBrsk8tkBGXGdfKqQ8An3xwhx58tSS00
SBSC8aL1bBvKnntsfmrMlW/AG/sihKk4ynzsyjDU71fpi0ZRgVeFYd9THItf//X2
2ZoZPCJtn5dUSfi8gXc0hEzJszaIiiAKCunEE6W0JDl0diM9dG9aTQ053YPo91n2
bdR/lB3GrpjysWz+Tqu+0uCXANlU3D0mu3L1DtIYJnpMIpNL/1JfMMHkWYBNSmn0
/5BMP2JmkwUkWkIsc1yYr1Kc7sjPmuQnarxn2Pc8vWobbmGOX81YjlORXUpbZ9Aq
7IvBJQ9PBxJ+td38jIAsPkohceJ9ZjvqSdADfJEOH0TW9dMvpwdAqAWE7xpOJ+Bx
qSB8bnCBO3ZErVihxzn+ChrL9oV0/03DQfR+j1+ZB9uJ4qBFQHBmUvIQh2Mp/+4I
lqC7OpMpggm1UkVh7q7zMK9BKcO/zxH79ph/X+4plm3B4LLDNlw=
=iOUu
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
