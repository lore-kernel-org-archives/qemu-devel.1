Received: from eggs.gnu.org ([2001:4830:134:3::10]:36994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT29S-0007Fn-DN
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT29O-0006tc-Fm
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:33:14 -0400
Date: Wed, 13 Jun 2018 19:12:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180613091213.GA30690@umbus.fritz.box>
References: <20180613065707.30766-1-david@gibson.dropbear.id.au>
	<20180613065707.30766-3-david@gibson.dropbear.id.au>
	<bdf40ba1-b9da-cc37-32fa-8aec4e6e254f@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W/IQTGW+1SjCkQmn"
Content-Disposition: inline
In-Reply-To: <bdf40ba1-b9da-cc37-32fa-8aec4e6e254f@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 2/7] pnv: Add missing error check during
 cpu realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--W/IQTGW+1SjCkQmn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 10:15:09AM +0200, C=E9dric Le Goater wrote:
> On 06/13/2018 08:57 AM, David Gibson wrote:
> > In pnv_core_realize() we call two functions with an Error * parameter in
> > succession, which means if they both cause errors we'll lose the first =
one.
> > Add an extra test/escape to fix this.
>=20
> I tend now to pass just NULL or &error_abort to object_property_add_child=
()=20
> and object_property_add_const_link(). These calls should just not
> fail.

Hm, good point. Another day.

>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Thanks,
>=20
> C.=20
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/pnv_core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> > index 13ad7d9e04..efb68226bb 100644
> > --- a/hw/ppc/pnv_core.c
> > +++ b/hw/ppc/pnv_core.c
> > @@ -173,6 +173,9 @@ static void pnv_core_realize(DeviceState *dev, Erro=
r **errp)
> > =20
> >          snprintf(name, sizeof(name), "thread[%d]", i);
> >          object_property_add_child(OBJECT(pc), name, obj, &local_err);
> > +        if (local_err) {
> > +            goto err;
> > +        }
> >          object_property_add_alias(obj, "core-pir", OBJECT(pc),
> >                                    "pir", &local_err);
> >          if (local_err) {
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--W/IQTGW+1SjCkQmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsg3+sACgkQbDjKyiDZ
s5L7TRAAlBOSVYDn9ueZXCpiV6B/TX1R5tBgob3dCr0wMJqEYm5DpgDyh3y4nnaz
wkjJi+Y0rZG73CX2Qpx1KZmN4RCapHF8+7LPz1cFvFSWpWprb7WQiRU4usqpZO5Q
/HXFjCjkjlZhdAAOQME3lha25IfVo/qy88WdnS+mHOlbpbYNxvG9fj3qxoeUSwWY
mr+bxRLBmeU0FQDc+LTxGpRlYeGnevGspbq7d7CNZb4AN6g1fd3tZBavpo3n78P2
4hL2ZhtbnKqfLTEQsC8YQB7A8bIkr+iW9+wCCtlPCsJESAC1FiNeVvrC9wuZylw0
y8fLOg+WuysdSA5LDeQ+j/+blgpiUtXXxhYVLCMzAbPkKZxPg97uY22SqH2Ubr6j
LUmxt+bGwb7DCulyq6nYdnEtX6CGUMazy6Cf0JcwltitLIh3/OfAEsn10sLvraqh
klaU9gCt4d5NHn0g5HwAuTosHTq8wViGqovkjJR9SD5UWnanYj105opVubfaJ7GI
RBJMT1wTyoSREnfgbqiENcuXzIsSK4xotkrWcHZnSwc++17QqVBHYHICUvISAyZs
IQyWWfzRJtx6tsDZkQRzAWoczfJdMKYKNvIo9Cac5eOoXW83wqA9mtdpuThAWMPX
A1JLTP5FHZCh7n9fIa+qTmmpIZpClXy65buGtV767HyrshUAB3Q=
=dG8U
-----END PGP SIGNATURE-----

--W/IQTGW+1SjCkQmn--
