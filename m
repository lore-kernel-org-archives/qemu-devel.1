Received: from eggs.gnu.org ([2001:4830:134:3::10]:45928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ep0KO-00043N-Cd
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ep0KN-0000dJ-Ju
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:31:04 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-23-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bba7014f-b130-ac29-36fe-de4cbc1ecdd9@redhat.com>
Date: Fri, 23 Feb 2018 00:30:40 +0100
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-23-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lHhE5fxg1V6Y7Mw2Pa94uCIFQfKAgRgq0"
Subject: Re: [Qemu-devel] [PATCH v2 22/36] rbd: Support .bdrv_co_create
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
--lHhE5fxg1V6Y7Mw2Pa94uCIFQfKAgRgq0
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <bba7014f-b130-ac29-36fe-de4cbc1ecdd9@redhat.com>
Subject: Re: [PATCH v2 22/36] rbd: Support .bdrv_co_create
References: <20180221135404.27598-1-kwolf@redhat.com>
 <20180221135404.27598-23-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-23-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-21 14:53, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to rbd, which enables
> image creation over QMP.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json |  19 ++++++-
>  block/rbd.c          | 146 ++++++++++++++++++++++++++++++++++---------=
--------
>  2 files changed, 116 insertions(+), 49 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--lHhE5fxg1V6Y7Mw2Pa94uCIFQfKAgRgq0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqPUqASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AuXUH/3eSYhmhMUpcRrBx59BzLQCsLE4XCRDy
n6Y8O5oyApEgxb6mV3R2EXsr2qOpSlsjkesNFjQHcgGL2x0sybbN8kwjpvTTeTcT
z4W6fn6xcDa69YJa3Cs+R1hF9RJZ74z5pOqV5AFn1DLuGZt71pWr6SmgPCrG1Da8
kCbebmWk4wX7bR390LLeP7EVv1y2mCwNCkXIIqLjdIR3jxysR4w0Hxmcpygddw3k
TSo34oLNMgj4e2oIcB98O0TzmtyQOiG0JdFvADwG3fU2eBiJ6bmhtqYlchGkPeQz
ErK57CG9STvvPZSyRFp9NULziytSOZeAtXyoXXOu9I8057DGxhGxDHo=
=JqLV
-----END PGP SIGNATURE-----

--lHhE5fxg1V6Y7Mw2Pa94uCIFQfKAgRgq0--
