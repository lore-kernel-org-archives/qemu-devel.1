Received: from eggs.gnu.org ([2001:4830:134:3::10]:60824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTDBJ-0002lh-Ky
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:43:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTDBI-0005Vt-S2
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:43:05 -0500
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-2-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <eb8c2797-af9a-d6b0-85f0-2286f0a8e4dc@redhat.com>
Date: Mon, 16 Jan 2017 20:42:55 +0100
MIME-Version: 1.0
In-Reply-To: <20170103182801.9638-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tHQkj0TqxNvCRrJVBFFGDfIjuJT9GN50l"
Subject: Re: [Qemu-devel] [PATCH v1 01/15] block: expose crypto option names
 / defs to other drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tHQkj0TqxNvCRrJVBFFGDfIjuJT9GN50l
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <eb8c2797-af9a-d6b0-85f0-2286f0a8e4dc@redhat.com>
Subject: Re: [PATCH v1 01/15] block: expose crypto option names / defs to
 other drivers
References: <20170103182801.9638-1-berrange@redhat.com>
 <20170103182801.9638-2-berrange@redhat.com>
In-Reply-To: <20170103182801.9638-2-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.01.2017 19:27, Daniel P. Berrange wrote:
> The block/crypto.c defines a set of QemuOpts that provide
> parameters for encryption. This will also be needed by
> the qcow/qcow2 integration, so expose the relevant pieces
> in a new block/crypto.h header.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 61 +++++++--------------------------------
>  block/crypto.h | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 102 insertions(+), 50 deletions(-)
>  create mode 100644 block/crypto.h

Reviewed-by: Max Reitz <mreitz@redhat.com>


--tHQkj0TqxNvCRrJVBFFGDfIjuJT9GN50l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlh9Ij8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ASnAH/i5on8PQLKGHNLgPnGLxrcl3ICyBazmN
lqih9NAMf/bfr7IWLZEExO9g1PuV1ITSySSGY2W89DYXJ/QJKZNDsEcgqe+v8W5u
wnIkozycsJZP0KTOT6HZuaAJeMgSj9nUpk40LhZibwOGtBUmFvq9i+GzDHT2YoPm
K4hN92W+xWHKGmN1aRK80uAeiglt6zzaaqXyqSUxqrk0H3R+tJIBK0Cami6+GfAp
pqIHg6Kfm/GOoaNG82pYkzew7DuTk0+TZ1B6OyuUM7cVsnGOA9mOGNuYqlr4FgUJ
o3+AliZfLWFPAusXhSmtRhH9OGuaghiXpDp9N9paJrR1kMgHSAkm9vA=
=S+fl
-----END PGP SIGNATURE-----

--tHQkj0TqxNvCRrJVBFFGDfIjuJT9GN50l--
