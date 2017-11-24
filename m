Received: from eggs.gnu.org ([2001:4830:134:3::10]:39519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eI5e8-00058O-5R
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 23:31:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eI5e7-00052X-4m
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 23:31:24 -0500
Date: Fri, 24 Nov 2017 15:28:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171124042843.GC18727@umbus.fritz.box>
References: <20171124042325.28012-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
In-Reply-To: <20171124042325.28012-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 0/2] target/ppc: hpt on radix
 and compat migration fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2017 at 03:23:23PM +1100, Suraj Jitindar Singh wrote:
> The following patches fix 2 migration bugs.
>=20
> The first being that migration of a hpt guest on a radix host currently
> doesn't work. The first patch fixes this by installing the correct value
> in patb_entry.
>=20
> The second bug is that migration in a compat mode will currently result
> in no compat mode actually being set on the receiving side. Fix this
> by ensuring the compat_pvr is communicated to kvm.
>=20
> The hpt on radix migration will require the host kernel to contain the pa=
tch:
> KVM: PPC: Book3S HV: Fix migration and HPT resizing of HPT guests on
> radix hosts

Applied to ppc-for-2.11.

>=20
> Suraj Jitindar Singh (2):
>   target/ppc: Move setting of patb_entry on hash table init
>   target/ppc: Fix setting of cpu->compat_pvr on incoming migration
>=20
>  hw/ppc/spapr.c       | 4 ++--
>  target/ppc/machine.c | 4 +++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloXn/sACgkQbDjKyiDZ
s5L8vQ//Qp7qfaE3kblGwGa3m/BzfwfYTPig8K2QXnais8Hl0C3FIhVoJimKeFpB
V5JMKeakv59SiNJskpely72oihXjYOFE8+k7mpuqDArM7lYPDFc+LwKBe0+jD36N
vhJtVpZciY4TADiTll8mnaDt4yNrstc9iGKeGvi1iaMQ3oo8sKSN44JQTpJFrocN
K6gzORNjnEDv7Fll8Zot7R0RJjQoWLLEslYc5nWpR3TSYj1d/dQwIQaI4MAFCIGA
DK8+choBGKaTIsu0R2fLrX/eSdEAVkNaMokxmqp7JmA4GnmR4NlhX3V0nRpiFfzF
qs3dehLVTvh9lAwaLC7v8G3RfOcVnkUHOwiPvKXbIvFZ5A1jFiBBP/A4bwgSRh/B
h6GtKQTZ+eFedVkrszleU0UmT1Myrm3Lq/tZb/W3u5Qbqw04FEY3hA3BA5f2PkVL
YzobOcCHfIV1ZYdWG0j680IlghP4SNvHOn8QtCb2lwjWMSraOS/RTKx6wYqNg8fj
vDqobOu1KDf635gyQXWKPDFLsewDdhOMpS3WSr0UPgdIj2Nq/hq0Y67ALET1+4Ef
YCh3XRSxngAmLsggjkMxvYY8eh3XVo29XKfG3fgr9SB+VnMjoKHLEITdNNDHAd/r
hCQP9XVjzC1toXYb1XJb/cqNfAFlw/pSpZICqR/aJlXpW/g9SNI=
=PTJB
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
