Received: from eggs.gnu.org ([2001:4830:134:3::10]:54717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAex1-00078s-6Q
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAex0-0001Uw-DL
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:36:11 -0400
References: <cover.1509718618.git.berto@igalia.com>
	<feeceada92486bb8790b90f303fc9fe82a27391a.1509718618.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8fce2c95-b87e-d32d-1cfa-4467c422bc6d@redhat.com>
Date: Fri, 3 Nov 2017 17:36:01 +0100
MIME-Version: 1.0
In-Reply-To: <feeceada92486bb8790b90f303fc9fe82a27391a.1509718618.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="J9Np9nHRlVKuK4KGulKL9u6ONboetok20"
Subject: Re: [Qemu-devel] [PATCH v2 5/7] qcow2: Add iotest for an image with
 header.refcount_table_offset == 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J9Np9nHRlVKuK4KGulKL9u6ONboetok20
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>
Message-ID: <8fce2c95-b87e-d32d-1cfa-4467c422bc6d@redhat.com>
Subject: Re: [PATCH v2 5/7] qcow2: Add iotest for an image with
 header.refcount_table_offset == 0
References: <cover.1509718618.git.berto@igalia.com>
 <feeceada92486bb8790b90f303fc9fe82a27391a.1509718618.git.berto@igalia.com>
In-Reply-To: <feeceada92486bb8790b90f303fc9fe82a27391a.1509718618.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-03 15:18, Alberto Garcia wrote:
> This patch adds a simple iotest in which we try to write to an image
> with the refcount table offset set to 0.
>=20
> This scenario was already handled by the existing consistency checks,
> but we add an explicit test case for completeness.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  tests/qemu-iotests/060     | 7 +++++++
>  tests/qemu-iotests/060.out | 6 ++++++
>  2 files changed, 13 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--J9Np9nHRlVKuK4KGulKL9u6ONboetok20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAln8mvESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AONoIAJYQ3VphBLwBZGmFICA54jm/jWP0EZ7S
EvQMba402AVasjyl5M2ZK7nWX6/1HcL7hFdd4NuccjKR/ec3B/vc1ExBHqyBp/8/
yoSqyuMDIMy0omNmQHiD+Zx1qkGuJZz4paQ6aqnetcppO5swBDoswkURzaKnZZMH
uQuz52cCfYWmSoMuoi0OeUb0R16RhF2O1vkNRxjzbVm410rr+9sbL7E4OvUr5Zv0
qMJaWr/yCQj/MzAlkKP5ATB68/Bwr1znGZ+XdRKFpDAKYzpPARPR7tpvdxTloh9g
ZhQqj3hKyZvCO4UqwyzbxwFXmkCSnMfTwdZKX/6S0ghZw4BxLzjCt+E=
=XSTr
-----END PGP SIGNATURE-----

--J9Np9nHRlVKuK4KGulKL9u6ONboetok20--
