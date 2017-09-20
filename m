Received: from eggs.gnu.org ([2001:4830:134:3::10]:41113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duYvM-00010i-NK
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duYvL-0002VB-Oq
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:55:56 -0400
Date: Wed, 20 Sep 2017 16:31:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170920063118.GK5520@umbus.fritz.box>
References: <1505888401-10130-1-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NqNl6FRZtoRUn5bW"
Content-Disposition: inline
In-Reply-To: <1505888401-10130-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 0/2] macio patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--NqNl6FRZtoRUn5bW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2017 at 07:19:59AM +0100, Mark Cave-Ayland wrote:
> Here are the macio patches taken from my previous "ppc: more Mac-related =
fixups"
> patchset with the v2 pmac_ide_ops conversion changes as requested.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-2.11, thanks.

>=20
>=20
> Benjamin Herrenschmidt (1):
>   ppc/ide/macio: Add missing registers
>=20
> Mark Cave-Ayland (1):
>   macio: convert pmac_ide_ops from old_mmio
>=20
>  hw/ide/macio.c |  191 +++++++++++++++++++++++++++++---------------------=
------
>  hw/ppc/mac.h   |    6 +-
>  2 files changed, 104 insertions(+), 93 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NqNl6FRZtoRUn5bW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnCCzAACgkQbDjKyiDZ
s5JywRAAjfMUnFqq91PIXzDbw+EFYcRt4XFW/jhE8kgIDOdl0qzaa7A6FA1NdXWk
OBFLwnvokU7/5vzNT55ZBgexXF6U7hqGKIPCwFFxCcCpkAap0/s9R1GXm8oGsGhy
qGqEhUpsejve26Y5+Bi5lbnt7+uIZXkMX5999kHLtr02tlpwhAgd3yU937ZSCl2r
epuQ6G355MeRaOGIXEE6AxKZ2QjMXMigv7knhN8oHBM8+sb1oMUB5J7RD4s1fhyS
0xKR9OE4z/FafTvFI6/QfeBelifEoirbo8cQQW7+xZ315JunEDfwSLLQ517gLC5+
tmHLiS8Gx9ZJ7Rk5xVGtfAW8Drphb3fWXXc54Fp1WjWQcHvaugw2yArqFvgWInQY
SBWpsCePj3ajD6APDXp2XkgPPwA5V7IzuY4OdXoDs9qi2m4kTCmi5THXyuxJs0t/
ahFh9Zlk9LyFtB1jzzxWUGAKW8YJkN3HHtLvcK0IEDjpbrQtHLGdM3Rccb2V0Ikk
wXr1pOirk70acuujyMLCQ/HJTtJDXM5QlBbiM8PR7zD1AAfI2W/J1uRfw4xLlKys
8UM11lf1PFddozaYGj7HT8yVmpZLNiQQDyo5IKCU7qdAn6nfry4YV1ED+rwq6xEL
P8c10QF4ZCzeAuZcJDyiPDpQLxN0z/pusqF/xxowmN3fTui3b7Q=
=Y27B
-----END PGP SIGNATURE-----

--NqNl6FRZtoRUn5bW--
