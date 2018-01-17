Received: from eggs.gnu.org ([2001:4830:134:3::10]:53786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebet7-0003Qh-9G
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 22:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebet3-0006wW-GJ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 22:59:45 -0500
Date: Wed, 17 Jan 2018 14:26:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180117032636.GZ30352@umbus.fritz.box>
References: <20180116074157.16886-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lKbk9CFItQTD29wm"
Content-Disposition: inline
In-Reply-To: <20180116074157.16886-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 0/3] target/ppc: add support for hypervisor
 doorbells
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--lKbk9CFItQTD29wm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 08:41:54AM +0100, C=E9dric Le Goater wrote:
> Hi,
>=20
> The hypervisor doorbells are used by skiboot and Linux on POWER9
> processors to wake up secondaries. This adds processor control support
> to the Book3S architecture.
>=20
> The full tree can be found here :
>=20
>   https://github.com/legoater/qemu powernv-2.12

1 & 2 look like correct fixes regardless of anything else, so I've
applied them.  Still looking at 3/3.

>=20
> Thanks,
>=20
> C.
>=20
> C=E9dric Le Goater (3):
>   target/ppc: fix doorbell and hypervisor doorbell definitions
>   target/ppc: msgsnd and msgclr instructions need hypervisor privilege
>   target/ppc: add support for hypervisor doorbells on book3s CPUs
>=20
>  target/ppc/cpu.h            | 16 ++++++++++------
>  target/ppc/excp_helper.c    | 39 ++++++++++++++++++++++++++++++++-------
>  target/ppc/helper.h         |  2 +-
>  target/ppc/translate.c      | 17 ++++++++++++++---
>  target/ppc/translate_init.c |  2 +-
>  5 files changed, 58 insertions(+), 18 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lKbk9CFItQTD29wm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpewmkACgkQbDjKyiDZ
s5IQIw//anbpSvnmbKdwIh75ncDq90JA+eKc4aCHXcLFAKdGA++0eZuMSKca4T5T
SLTjshaGFw8CtexYvUU+deFygHPIGYyklRRYdLtYsJLoHhjJOvWPMt5dxEE0IC5U
tc6o3Fe59UqGxYCVDmmWsEVwQcqyQs9UJYYvJzPZHnNYou4F0FNeIMzxgtJe4R5Z
KqYRK1TQXIbYtvF1P13rAAUWul6pLZp8ItwW+CRcCm0xPK3ph7ZRsP5LhKDU6YAc
ROL4eYeirQm0gWyzE5AuKPqFdGdmL9FB4MZEny1H/AlKArr5mnMSbTctwbopaHTt
a1JdBctl0Iw7pANGaJFUSZeuWZ4BYYFtM6sYg1ttDc0AT0K3vb8w8aC7u5zbMLsE
uKmRGAOWlIA5nmgEu4F1HhSgisfHOIkUVDY1yeKPUrIREX4jpGjqVpSlmxkxopr6
7uAd4lp8xELbDD0CxWvA7xwP82i+pPl8cikyfPr9G43qD9+bMT0YOzCztIqaOpbZ
PaKADcqN0TVzf3ilSS0PdMXY/JvG2zMHU0qutPedCDViT5ujxqQSdf+IuUtE1m9b
UlLsg1eYk1H2Gzhn1tNneYGAzy5CUmKgzCiyF/+4FOA8kys8BvFrRJO57tcI25kP
Nv8+jnChZbDTqOq7OQV00Yk3q3F5H7UMCwaemtYC1PMmHbv94N8=
=ZURI
-----END PGP SIGNATURE-----

--lKbk9CFItQTD29wm--
