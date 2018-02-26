Received: from eggs.gnu.org ([2001:4830:134:3::10]:47487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqHvC-0000iG-SN
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:30:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqHv7-0000mx-4w
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:30:22 -0500
References: <20180223192549.26666-1-kwolf@redhat.com>
	<20180223192549.26666-29-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6b40fa10-795e-32b4-33ef-9c69d31c18ee@redhat.com>
Date: Mon, 26 Feb 2018 13:30:03 +0100
MIME-Version: 1.0
In-Reply-To: <20180223192549.26666-29-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4grnIq1Xhbpw0Dzw1DeUUr8ek0zvLDJQo"
Subject: Re: [Qemu-devel] [PATCH v3 28/36] sheepdog: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4grnIq1Xhbpw0Dzw1DeUUr8ek0zvLDJQo
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <6b40fa10-795e-32b4-33ef-9c69d31c18ee@redhat.com>
Subject: Re: [PATCH v3 28/36] sheepdog: Support .bdrv_co_create
References: <20180223192549.26666-1-kwolf@redhat.com>
 <20180223192549.26666-29-kwolf@redhat.com>
In-Reply-To: <20180223192549.26666-29-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-23 20:25, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to sheepdog, which enable=
s
> image creation over QMP.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json |  24 ++++-
>  block/sheepdog.c     | 242 +++++++++++++++++++++++++++++++++++--------=
--------
>  2 files changed, 191 insertions(+), 75 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--4grnIq1Xhbpw0Dzw1DeUUr8ek0zvLDJQo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqT/csSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ao4YH/R5KPk8v1tBR3Ty6EdxciS1Rcs9jeN+O
SgCA5zwvtet21zJ4R1j8q3drthEa6w9PJ157AXTq9sm6hFVS1VDuuHX983T6sRgy
aIdJfzYLStrhjLCPsvz6qZSm9zGuKASmJAsjUXnXnnqIQxbWL/epLCT12LXjNoFh
RBVXQQnoW8VG3w0Y45zzhyNJpeJ7Oe0IVi5LII0d+OxMivsMQeX2q9GTwnfXhVo9
XYqyN+gee6GglrtXZuuNSjOu1h8d2kaQp9y9qroPui7+NtVz/9YHY8H1Et+QRXC5
gugXl7LmR8pHAoBJNbBCHugrgLQ1fSJofFYSLKWqulKacKRFyvKF054=
=hOy2
-----END PGP SIGNATURE-----

--4grnIq1Xhbpw0Dzw1DeUUr8ek0zvLDJQo--
