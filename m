Received: from eggs.gnu.org ([2001:4830:134:3::10]:54571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfLRI-00071k-Oz
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfLRE-0007j9-TS
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:30:00 -0400
Date: Wed, 9 Aug 2017 17:13:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170809071315.GN13670@umbus.fritz.box>
References: <1502121048-1816-1-git-send-email-frederic.konrad@adacore.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7fwXp2o0gOrkU5lS"
Content-Disposition: inline
In-Reply-To: <1502121048-1816-1-git-send-email-frederic.konrad@adacore.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 0/4] ppc64: add e6500
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--7fwXp2o0gOrkU5lS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2017 at 05:50:44PM +0200, KONRAD Frederic wrote:
> Hi,
>=20
> Those are some patches to add basic e6500 support for the moment e5500 wi=
th a
> correct MMU configuration and supported instructions.
> Some (maybe a lot of) things are missing (ie: the thread support) but it =
is
> enough to boot a propietary OS on my side.
>=20
> The first two patches are fixes when using MAV 2.0 MMU.
> The two last patches introduces the e6500.
>=20
> This can be cloned here:
> https://github.com/FredKonrad/qemu.git branch e6500

Looks sane as best as my minimal knowledge of e500 goes.  Applied to
ppc-for-2.11.  Alex, if you (or anyone with knowledge of this
platform) has objections, I'll reconsider.

>=20
> Thanks,
> Fred
>=20
> KONRAD Frederic (4):
>   booke206: fix booke206_tlbnps for mav 2.0
>   booke206: fix tlbnps for fixed size TLB
>   booke206: allow to specify an mmucfg value at the init
>   ppc64: introduce e6500
>=20
>  target/ppc/cpu-models.c     |   2 +
>  target/ppc/cpu-models.h     |   1 +
>  target/ppc/cpu.h            |  26 +++++++++++-
>  target/ppc/mmu_helper.c     |  16 ++++---
>  target/ppc/translate_init.c | 100 ++++++++++++++++++++++++++++++++++++++=
+++---
>  5 files changed, 132 insertions(+), 13 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7fwXp2o0gOrkU5lS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmKtgsACgkQbDjKyiDZ
s5IvbBAA176dgwyE/BDFjJIZnf/YTR+U0uXTecDNcJlH7cU5Gl3qoFmvobvHoRKP
kFRg7ROa+p5PTxOP+QyF/+Txz9tnywVWzyRXV1Gru1QzBVKo3llhMZOpc6pmaQ2N
o3JsyOiQex7QOWOrOVbzcYiKOw6AwSj1BfbsZ+USrKRQk2/VA8c3nmcBoogkNL/o
bywXC3x9xEcJoNaJTyqCiypVxe673OcEw1kjK7SAbRgTQApMkWPQ0g/FT5Bg9yaO
2XGr2CRUBoqB2C5soEWnF21jPk3uAdeJyrsJW4ARFqjv0k9mYqwzxm3BuoS8AFXf
81aJSQHnd0vs+QAe+pOv26mJKNhtQusnWPhHc8jYSO3Fi3PzJ8tezOQ9HaOUIsDd
VUPFnZ+UpoxEhjUpml7WQUOMYXIQeTWMm8bKy0gRZt4sViyMsfTaM/yfIRg8KToD
Cn8rJPc+R25S+NLizLjLpW1jzCXr7hYgDus6ksxNWC9QgRowzCBFU5RWdvnVX8+2
28+hLee9GZiT9r/MChBNZAKlSTiMDa3Jv0eOLuRIo+qnMGjWiHtjuUxsWHT52/bZ
E48J8/T44sD/o+rMIfGqGhXDUR2BCvEz7WQTAr+8j+jtG1pvjyy4FbUtOJDNHlyd
s6m8JXZNYV5ya4+ciA2aow7++NICLM58p6joIIJQsUo8gq6M57g=
=qptp
-----END PGP SIGNATURE-----

--7fwXp2o0gOrkU5lS--
