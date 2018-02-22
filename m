Received: from eggs.gnu.org ([2001:4830:134:3::10]:58847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eozrq-0002xh-6x
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:01:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eozrp-0005SF-Ag
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:01:34 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-18-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4f871355-1be3-d168-6f75-a535e8642c2c@redhat.com>
Date: Fri, 23 Feb 2018 00:01:08 +0100
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-18-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XWsDixTKZNJWaQkMRo37CbB5lKAWqW67M"
Subject: Re: [Qemu-devel] [PATCH v2 17/36] gluster: Support .bdrv_co_create
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
--XWsDixTKZNJWaQkMRo37CbB5lKAWqW67M
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <4f871355-1be3-d168-6f75-a535e8642c2c@redhat.com>
Subject: Re: [PATCH v2 17/36] gluster: Support .bdrv_co_create
References: <20180221135404.27598-1-kwolf@redhat.com>
 <20180221135404.27598-18-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-18-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-21 14:53, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to gluster, which enables=

> image creation over QMP.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json |  18 ++++++-
>  block/gluster.c      | 135 ++++++++++++++++++++++++++++++++++---------=
--------
>  2 files changed, 108 insertions(+), 45 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--XWsDixTKZNJWaQkMRo37CbB5lKAWqW67M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqPS7QSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ALWEH/0r0fve3HKlXPQMrehw/EWtZNDdAh5IJ
iuaFgciDgOQyqQKMPd/oP/8K1oMDGMoIK0wqiiQ5waco7Xj+TNoIYgQlblDDbUkR
gItr2AiqU6n1/eOF30zgfBDSpR7sujsaV0OBWYmtrHw2DHvDKTFdANorg2F6sOEk
KvYTyRUy2IIv/ffeuPluC3NgJzKIGWrE8Xmmtd41rREXzU63cczycWOOuvz8CSTL
Il6pVfyL6Y2n3REl247fCoCDEaZIq0Jhz8gj6BA92eTt4JYgUUmwCZg4Yi774tQR
TSLyRtf3tu/danVzRf9WuqB/BcUa0u3PmjBNeMNx+TONIgPbq18I7cA=
=1fYL
-----END PGP SIGNATURE-----

--XWsDixTKZNJWaQkMRo37CbB5lKAWqW67M--
