Received: from eggs.gnu.org ([2001:4830:134:3::10]:39082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXqc-0006eJ-QH
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:24:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXqc-00054P-1S
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:24:50 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-23-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <99523dd5-2f47-11f9-2fe5-8c3ac312ab59@redhat.com>
Date: Wed, 22 Feb 2017 15:24:40 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-23-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nlmpDiUkPCDbb1TcoJDjuQort649wrA2O"
Subject: Re: [Qemu-devel] [PATCH 22/54] block: Request real permissions in
 bdrv_attach_child()
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
--nlmpDiUkPCDbb1TcoJDjuQort649wrA2O
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <99523dd5-2f47-11f9-2fe5-8c3ac312ab59@redhat.com>
Subject: Re: [PATCH 22/54] block: Request real permissions in
 bdrv_attach_child()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-23-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-23-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> Now that all block drivers with children tell us what permissions they
> need from each of their children, bdrv_attach_child() can use this
> information and make the right requirements while trying to attach new
> children.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Not sure whether it was intended how the assertion in vvfat still passes
(@c =3D=3D s->qcow because both are NULL...), but it works, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--nlmpDiUkPCDbb1TcoJDjuQort649wrA2O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitnygSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AV1IH/RQ/YFH2JbkyXcp8q0C75v5SvNtm1g3n
+NpbbTqzFH/gHhLKZZ4axbRsF2LqLQzi95cibHhR0fEzegtwo1jpVEKw3crd2EGY
HbjwMBUwEnbpk4cMsh+vuyUy9pevwpkJPrMRcOekG3TP2koe23qrvSCqSquUIZWD
YIm/zdoF5GNsdZvN7SAZ5JJMiO2HrLObCy4mZyJreUbVU4leX0/2h+WVuWrwFxGA
FKk6C83NwYdKH6twSN9OpbK/hcGBLdhZaGqWdpsCWFttaSbaN2tIDwPYbiiNCKsL
IrtolZ2YCeK76adkayqxRMUQaOf7zSQ7kKEJWG7bmeKk3lILz4y7E6g=
=oToU
-----END PGP SIGNATURE-----

--nlmpDiUkPCDbb1TcoJDjuQort649wrA2O--
