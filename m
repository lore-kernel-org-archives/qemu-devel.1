Received: from eggs.gnu.org ([2001:4830:134:3::10]:43743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgWJM-0001bO-OT
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgWJM-00038X-0d
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:46:24 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-7-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bfbcb037-643e-a65c-ca6c-4c7028394b83@redhat.com>
Date: Wed, 22 Feb 2017 13:46:13 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-7-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kJqiKEO91IfT7DAtVLmFwiO66UGtX1jbp"
Subject: Re: [Qemu-devel] [PATCH 06/54] block: Factor out
 bdrv_open_child_bs()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kJqiKEO91IfT7DAtVLmFwiO66UGtX1jbp
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <bfbcb037-643e-a65c-ca6c-4c7028394b83@redhat.com>
Subject: Re: [PATCH 06/54] block: Factor out bdrv_open_child_bs()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-7-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-7-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> This is the part of bdrv_open_child() that opens a BDS with option
> inheritance, but doesn't attach it as a child to the parent yet.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 61 +++++++++++++++++++++++++++++++++++++--------------------=
----
>  1 file changed, 37 insertions(+), 24 deletions(-)

Modulo the errors patchew noted (same applies to all of my R-bs):

Reviewed-by: Max Reitz <mreitz@redhat.com>



--kJqiKEO91IfT7DAtVLmFwiO66UGtX1jbp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitiBUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ACWcH/0UzS9DY86mWAE4OgPKPv7t6a7rkOOXF
u1pu/dGrdzcYNgn4vibjK/nJEoI4t0xaotVuWN4FZouMJWXaaharixD9g4sJL9Fo
0pDVfPjHnNB5vAFdP97znh+EP8P0Uy1GL/s+U3/lA3DXRXRG0jXcL3yL3/YBn3OX
nZvjQGKQQiI+EA3CxVpmd6Ei3d4ALR/DD+Pb+FJD7c7Y47jka29sDMivhtb3rAs4
fjQ3GlyqeI/WCHgA/jJUYWY/z37F9R/AygK8uUwejc34Z09RpQiKjWl2os7a3oc2
EitFhEk2E8o6dIL4bEZNQTggcGNE2puyHhbDzaZUbM5DYxj7XBlK/wo=
=kTfd
-----END PGP SIGNATURE-----

--kJqiKEO91IfT7DAtVLmFwiO66UGtX1jbp--
