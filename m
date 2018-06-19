Received: from eggs.gnu.org ([2001:4830:134:3::10]:34195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV4Va-0000BE-8V
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 20:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV4VZ-0007Tj-CT
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 20:28:30 -0400
Date: Tue, 19 Jun 2018 10:26:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180619002650.GI25461@umbus.fritz.box>
References: <20180618170540.12143-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TXy4g9tqilp80iv6"
Content-Disposition: inline
In-Reply-To: <20180618170540.12143-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] ppc/pnv: new Pnv8Chip and Pnv9Chip
 models
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


--TXy4g9tqilp80iv6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2018 at 07:05:38PM +0200, C=E9dric Le Goater wrote:
> Hello,
>=20
> Here comes new chip models for the different processor the PowerNV
> machine supports and some more cleanups around the device tree of the
> ISA bus of the machine.

Applied to ppc-for-3.0, thanks.

>=20
> Thanks,
>=20
> C.=20
>=20
> Changes since v2:
>=20
>   - introduced a parent_realize
>   - removed the machines
>  =20
> Changes since v1:
>=20
>  - reworked the ISABus creation interface with the chip, the machine
>    is not aware anymore of the chip controllers.
>  - removed the bizarre controllers under the PnvChip base class.
>  - kept back some changes on the ISA device tree name. They will come
>    in time with the LPC controller for P9
>=20
> C=E9dric Le Goater (2):
>   ppc/pnv: introduce Pnv8Chip and Pnv9Chip models
>   ppc/pnv: consolidate the creation of the ISA bus device tree
>=20
>  include/hw/ppc/pnv.h |  24 +++-
>  hw/ppc/pnv.c         | 332 +++++++++++++++++++++++++++++++--------------=
------
>  2 files changed, 225 insertions(+), 131 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TXy4g9tqilp80iv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsoTcUACgkQbDjKyiDZ
s5KO6RAA34M52Z1BQjQ1dGEA75ixsW0s3cmqqKCK8C5/RtJL6/1PXY8xqH6wBmVK
w0Pg9Km5lFwr6mr1Xg74rRFC79aR91Hv4Ld/5t4BA2Scu3FqOzZebVTvMuSHZLjd
q6pg41IouMaMloEwjMjoYfSBmGhjFrhJ5GFk/vVea5+7ZjfvBILq4SJWJyWaxnwk
lhZ8E8DHYe0+EsCaRSpXjiGVYl26Cs0rGY9xzBeyfWtUdtam45r9yUaIJzf8FB/W
iv3U6hBHFTFbLR4DAMQ2yaJgF+TWo7vFQ6jnbAkWl4emQHEokA0CeCSl3niHFiee
sFUTNq6+/dqJqx2EULIAf8o0ULNes5s2qIiTfEDy/IMPcS/1Hl7m0v0ZFtW6xVYB
rNGVx22yQvJfOWxt6VMdZYm1brEJU4n9EnUDK1u5ku+ZXjVEqWjyXMYDJVS9fA9S
KXrQu2ampY1ADXhU49YS4RDrdTh9jfWWAqi4pAHG4IiiT4gRmjRWZTTiHxdNPykI
ZBk6aCcK6g3LcMO3WPsnPVLau4CUh3dOA0EU7nZ+SBwY9sNAXrp8KUd6Ui6r5hrL
Y/hLztc4CDwHTslnV43J65kvedgk1OXhKGBozeFKSQK/kXS5RrygAaOK7Y8hp+NN
kubQv+VTWb2s7LTDJ2pHlGcmo0uLrxRuwHiClw4p30txUdGcBvs=
=qK3g
-----END PGP SIGNATURE-----

--TXy4g9tqilp80iv6--
