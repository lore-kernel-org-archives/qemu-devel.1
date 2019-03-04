Received: from eggs.gnu.org ([209.51.188.92]:57018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0gEP-0003Q6-FE
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 00:33:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0gEO-0003FM-Ku
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 00:33:41 -0500
Date: Mon, 4 Mar 2019 12:27:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190304012754.GH7792@umbus.fritz.box>
References: <20190301044609.9626-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X+8siUETKMkW99st"
Content-Disposition: inline
In-Reply-To: <20190301044609.9626-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 0/2] Enable mitigations by
 default for pseries-4.0 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--X+8siUETKMkW99st
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2019 at 03:46:07PM +1100, Suraj Jitindar Singh wrote:
> This series is based on the ppc-for-4.0 branch with my large-decrementer
> and count-cache-flush series applied.
>=20
> Suraj Jitindar Singh (2):
>   target/ppc/tcg: make spapr_caps apply cap-[cfpc/sbbc/ibs] non-fatal
>     for tcg
>   target/ppc/spapr: Enable mitigations by default for pseries-4.0
>     machine type

Applied to ppc-for-4.0, thanks.

>=20
>  hw/ppc/spapr.c      |  9 ++++++---
>  hw/ppc/spapr_caps.c | 33 ++++++++++++++++++++++++---------
>  2 files changed, 30 insertions(+), 12 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--X+8siUETKMkW99st
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx8fxgACgkQbDjKyiDZ
s5KbCA//RCFVlgSqn9HW4nPmm3xHTQtENGQJDgwkEP7qfCdKPvoDSwvouPCp4MJ/
eI6xGbZGBSA67+f9m+KGoz7M+eQn0dixB9+fDBMGzxdvxApTuj+rRRzvkyeTifmz
M12NIB+GKmtr2fOUUSU6KWvbMlSd9UpMs/bJYFxPpHKLGDvQs2pi6OdrZCEREnJy
SQkhWgdQiFqp2JM+PS7UGJCgsmX3m9l4N3eNiJdhm64fPKgvGfIQj4ioUMlr+tgw
exyUoXgXsLe0VSOEeuyImnjbaxNI90nWFOdN5T5HyKyaxiWIOksxqbbKy0OrVfR4
e6E5QWeR6gjel8WWwL7SN3xiZkbdok/6X9HAv5ZhIYyzBl9Nr58wfHZO/gSfBmwS
ePbQcc0uUJcBc7LYKJwTih0ME44fcvrLJcFOLbd+OJT+DEpEMWOHgZ7RkgUq0qqX
ydcWXoyF7VUuPfQ3HxRZn8UASpcC43PRA86A7P/q1o2UkPjuJvKhGgYzdCRIkI8S
G+D/2Xv1QhUE7R4WR6ZNB6tIQvKZxcJT97o3VCL8UzckSKrC4cjJc+vSDGMQystb
Q0kA8KMJ6RMY/1hWYD9sLNJEmdBW5jKd4tOsiFV2fXOJ6BM3D1vN8z72n9ItAI9z
1I+EpPg1n1I1HUfKyR0TdEdtRyLLCU7sAAMP8QzID+a16Kh4OIc=
=aCp+
-----END PGP SIGNATURE-----

--X+8siUETKMkW99st--
