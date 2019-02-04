Received: from eggs.gnu.org ([209.51.188.92]:46012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqSDf-0000bD-Pu
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 19:34:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqSDX-0000be-3u
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 19:34:35 -0500
Date: Mon, 4 Feb 2019 11:08:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190204000805.GB2593@umbus.fritz.box>
References: <20190130233605.22163-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <20190130233605.22163-1-muriloo@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] mmap-alloc: fix hugetlbfs misaligned
 length in ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cao jin <caoj.fnst@cn.fujitsu.com>, Fabiano Rosas <farosas@linux.ibm.com>, Greg Kurz <groug@kaod.org>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, mopsfelder@gmail.com


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 09:36:03PM -0200, Murilo Opsfelder Araujo wrote:
> The first patch unfolds parts of qemu_ram_mmap() to make it clearer.
> No changes in the function behaviour.
>=20
> The second one fixes the alignment of the length given to munmap().
>=20
> I am pretty sure there is room for improvement, so I would love to
> hear your feedback.
>=20
> Thank you!

Applied to ppc-for-4.0.

>=20
> Murilo Opsfelder Araujo (2):
>   mmap-alloc: unfold qemu_ram_mmap()
>   mmap-alloc: fix hugetlbfs misaligned length in ppc64
>=20
>  exec.c                    |  4 +--
>  include/qemu/mmap-alloc.h |  2 +-
>  util/mmap-alloc.c         | 73 ++++++++++++++++++++++++++-------------
>  util/oslib-posix.c        |  2 +-
>  4 files changed, 53 insertions(+), 28 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxXgmMACgkQbDjKyiDZ
s5K5iA//cF/C3cyHR89eF1mfdKHY/+/sIZa8uv+BRyukwteoUv7Mx6F0oZm8XtVl
LmHgWpmZUZCAfUdEAVcsDkyzHdHnSArp6TL3OZ/abeCR3LWr7P4asSCE2GsWoJcT
kYjwcqjZbNVKT7JtmEeG5VHGPejFjf7lbeNGrSA5+YmVyVnMHRnndTZqR3hS1L3n
B2qDGXQWOSFoswALxxsh6DDdzJvWiu+Zhvhd5uOdh3B6QJLDAmjFfRe4a+9QL9Js
FpsJdhZZlGktEO+Lp+xOVBJN57LSQNbIfFD5C7deEbgQF4lksnDuUqALQ1agXrPW
A9u5RtxGzoLjeYZjmjSUgdY9um3T3aC15dn3FDzs2gjrkNbCeZVSToZG7TuMrCFM
Riao/InmFbSJExgOIS/u9b7PcUTeBaubPiFJwvM7MGBYeKKukN2W2EpDnrus4g8r
DrFe0JvVxNGGuULC+9r/3lOQWiTjZNxTyyeNLuOSc0N0lPZfe6FY3jGYYBEfIUA5
OJpPhf74QzwkxzLtVoqkbZTW87vEdrvxkLt5fpnHYyGxx3jtZuLRdoMqLNQllGKV
i9I2rw2zYjX1wjJhE1+hoxHXX/qtgRhyFPLi/LyhG9yIIhUhnHoeKRsg3dke5LLs
z1k9yFvd2/bA6yt2SLizNNOyHIabpRqwqb8xvZsWNpRN1ft/lpQ=
=vM4t
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
