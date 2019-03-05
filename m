Received: from eggs.gnu.org ([209.51.188.92]:42610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0yMa-00066q-TY
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 19:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0yLF-0002ZL-Ir
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 19:53:58 -0500
Date: Tue, 5 Mar 2019 11:53:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190305005332.GB7877@umbus.fritz.box>
References: <20190214043916.22128-1-david@gibson.dropbear.id.au>
	<20190228083821-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <20190228083821-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 0/5] Improve balloon handling of pagesizes
 other than 4kiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 08:39:21AM -0500, Michael S. Tsirkin wrote:
> On Thu, Feb 14, 2019 at 03:39:11PM +1100, David Gibson wrote:
> > I posted some RFCs for this back in December, but didn't wrap it up in
> > time for 3.1.  Posting again for inclusion in 4.0.
> >=20
> > The virtio-balloon devices was never really thought out for cases
> > other than 4kiB pagesize on both guest and host.  It works in some
> > cases, but in others can be ineffectual or even cause guest memory
> > corruption.
> >=20
> > This series makes a handful of preliminary cleanups, then makes a
> > change to safely, though not perfectly, handle cases with non 4kiB
> > pagesizes.
>=20
> I'd like to see a version of this that does not depend on patch 1 which
> is not a cleanup nor a bugfix. Could you look into this please?

Ok... the original series is already applied to master, so I'm not
exactly sure what you want me to do here.  Should I try to come up
with a "logical revert" of the first patch?  Or do you intend to
revert the whole series, and I rewrite the series without the first
patch?

> We can then debate merits of patch 1 separately.
>=20
>=20
> > Changes since RFC:
> >  * Further refinement of when to issue warnings in 5/5
> >=20
> > David Gibson (5):
> >   virtio-balloon: Remove unnecessary MADV_WILLNEED on deflate
> >   virtio-balloon: Corrections to address verification
> >   virtio-balloon: Rework ballon_page() interface
> >   virtio-balloon: Use ram_block_discard_range() instead of raw madvise()
> >   virtio-balloon: Safely handle BALLOON_PAGE_SIZE < host page size
> >=20
> >  hw/virtio/virtio-balloon.c         | 102 ++++++++++++++++++++++++-----
> >  include/hw/virtio/virtio-balloon.h |   3 +
> >  2 files changed, 89 insertions(+), 16 deletions(-)
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx9yIwACgkQbDjKyiDZ
s5JwKxAAo8AjgSggCZwoBz8Hn/gp/Z4FipGSxBqM6iAo7vzvi3pdo6ufXrHIVQm6
WCYL0VSpb4fdlAVrc9zFcghsvAiKz5h3vA0/PLfhsHc6nlYNE4QGjNu9brn77puy
Yv5ZpcHby8W8Ggyi09tK0g9Bg1iPFgca4vuKPcSLFCZ2TkiywxVQ81iMrolZCTgp
xt07feV8ae0T/G2zSIdxLav3OgErHUJuLIA24L/Vtt9pYQt9EgGt5M5sDvrxJw2M
gKG8N+7ZwxN+dmEyNDG1W5SD1fLBeSgPxXTgCEHeqwxs48RLG2/RUFEwQyQ1kvTF
3M7FnUkXw8GyJA8EjN4Edn7gqugwgntNXAJa7wwNIsCf9Dw+MiIj3LLA9N61vq+5
4NY/VUNsilzf2j1Kd0w4kcpJ86IHFonKsyY2XCZSdYr/QJc5a7dbQfrr7QgR5OOF
D64El6cSLw4zsK/XVUIMMqybm6HRJWftfKtdzPRYwFYY4G72/iI/CKuXNsEI+MB9
sPsVGzsXPR0dmRXVGhhrU5vFPAbPHDpXx+DYTWnfCOK1hkynScVf/Fo2rD5Wp41x
f0cDFaJNqGI/kiOT4L+CbotYp0D2QUTlSeLZSo2FdTLDsERnX0Xk0DsuWujM/JyA
YRjihOiMNxw2nIa8guuCqoJOYGq4fZAxk0ZBxZEgVEIKJaLA9JQ=
=Qy4S
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
