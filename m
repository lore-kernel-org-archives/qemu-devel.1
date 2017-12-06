Received: from eggs.gnu.org ([2001:4830:134:3::10]:42280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMNXA-0004ce-5B
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 19:25:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMNX8-0003ML-R7
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 19:25:56 -0500
Date: Wed, 6 Dec 2017 11:25:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171206002544.GQ3057@umbus.fritz.box>
References: <151239850618.30749.18071098158203257789.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QVgWX4+QEldMe/r9"
Content-Disposition: inline
In-Reply-To: <151239850618.30749.18071098158203257789.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2] spapr: fix LSI interrupt specifiers in
 the device tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>


--QVgWX4+QEldMe/r9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2017 at 03:41:46PM +0100, Greg Kurz wrote:
> PAPR 2.7 C.6.9.1.2 describes the "#interrupt-cells" property of the
> PowerPC External Interrupt Source Controller node as follows:
>=20
> =E2=80=9C#interrupt-cells=E2=80=9D
>=20
>   Standard property name to define the number of cells in an interrupt-
>   specifier within an interrupt domain.
>=20
>   prop-encoded-array: An integer, encoded as with encode-int, that denotes
>   the number of cells required to represent an interrupt specifier in its
>   child nodes.
>=20
>   The value of this property for the PowerPC External Interrupt option sh=
all
>   be 2. Thus all interrupt specifiers (as used in the standard =E2=80=9Ci=
nterrupts=E2=80=9D
>   property) shall consist of two cells, each containing an integer encoded
>   as with encode-int. The first integer represents the interrupt number t=
he
>   second integer is the trigger code: 0 for edge triggered, 1 for level
>   triggered.
>=20
> This patch fixes the interrupt specifiers in the "interrupt-map" property
> of the PHB node, that were setting the second cell to 8 (confusion with
> IRQ_TYPE_LEVEL_LOW ?) instead of 1.
>=20
> VIO devices and RTAS event sources use the same format for interrupt
> specifiers: while here, we introduce a common helper to handle the
> encoding details.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>

Looks good, but I'd request two minor changes.

1) Please reference LoPAPR instead of the internal PAPR, since other
people can't see it.

2) Change the helper's name to spapr_dt_xics_irq(), for both brevity
and specificity.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QVgWX4+QEldMe/r9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlonOQUACgkQbDjKyiDZ
s5JCew/9HFfWM3ErucLYYd3/VdkacmCv+rcnQPx3ncckFH0+pFb88zaerHkrWR6C
jjfhQM8jEuhSfpV87WRAkxQGT06QGa7lKjOYXekFMq8IMmWWIVS1BVv8V4faCNCs
qTJbCMJAaJDiS8VjA0hnhHSPVY2nquWpXJJcCcvecbbdS9/qgo+7Q45x4SGjuvkd
a+3WlJEYc1Kj69M/c+vIZkj+OziwfNS3werE0eYYfE2SFDmvtS0Vx2FEWLShXGsc
ppDcs2BE3pfoNSSyL+ekM3E+mz8mBEIFwKiiROYEgbzaPWUh88Jo+iyibnj9iIOu
GFV+EnKQWsdbmceJiWz4+d4zdx3Dr3H/LjIcPNpYpUu6eYvflCak993E2YwODTyT
FRGTDXoOiIED4SA8hs5+dwkvWsOOr0APIgyPaY6XI5tE7OhGzE3OaS5TB3QqCnPE
zxsz8uSOo42nQ9yIXK/H0hp777GD8d1ekgSGMIx6zFoq1wJ7BCx5QxAJXih4SX3/
esQlSztxiy5nP4Gg7ZDhVoVNo/qWnp0oqdoGlSf51zGSX7VXKl7bOwlmeHIDXjIh
rczPYDpU+SLgIKOZzZL4Tv/Pum4kAdG9bg2w2aaBpxHqryewi7hbEJ81RngHK7RZ
hDEwiLUNatWebyzik1Kwwuejr7EzjDomrEu4IWfRK1egJg7XoDs=
=ZZ/j
-----END PGP SIGNATURE-----

--QVgWX4+QEldMe/r9--
