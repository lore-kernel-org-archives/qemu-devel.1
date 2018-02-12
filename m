Received: from eggs.gnu.org ([2001:4830:134:3::10]:34785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elGIz-0001jf-6F
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elGIy-0004ty-GM
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:46:09 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-18-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e13b766a-f57d-0638-bdcc-2c5440de2fb9@redhat.com>
Date: Mon, 12 Feb 2018 16:45:44 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-18-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6UhAXX8bn4QN0hK15C54lmPj7Hjih1Ks4"
Subject: Re: [Qemu-devel] [PATCH 17/27] nfs: Support .bdrv_co_create
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
--6UhAXX8bn4QN0hK15C54lmPj7Hjih1Ks4
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <e13b766a-f57d-0638-bdcc-2c5440de2fb9@redhat.com>
Subject: Re: [PATCH 17/27] nfs: Support .bdrv_co_create
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-18-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-18-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to nfs, which enables
> image creation over QMP.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json | 16 +++++++++++-
>  block/nfs.c          | 74 +++++++++++++++++++++++++++++++++++++++++---=
--------
>  2 files changed, 74 insertions(+), 16 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--6UhAXX8bn4QN0hK15C54lmPj7Hjih1Ks4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqBtqgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A9QoIAJRMGIH+qTKktXvJ11jm5loc7WmoVqr0
CaoV6N5pzntwMPCnue5vvT4TBsNBi3ggxVKGkc0HqNorhgTGzUwMSlu82fQwH8Ao
rYc//M751C0d8CcNYgqBKSiUv5IyfFxfuL/Os3XL6qz5i32xnt/cCNWOKxAgBFHb
FkbcXci1ChuHssqFaHFjfzMYmWO7BIaBCTmjsy8rLE22g0EHhbMZIAvSudpQPaI1
K5sgmAcEwSe2pSNAbKlfNv7CLOOWEMWjeofvb72dpyRniMtU0P6pj833ToXJYjcD
NPOjgh+psk8W4+/qtMFs2Y0jlGBhXG0HWclqsaq7vWf+6hHSNBYuHgI=
=iSbD
-----END PGP SIGNATURE-----

--6UhAXX8bn4QN0hK15C54lmPj7Hjih1Ks4--
