Received: from eggs.gnu.org ([2001:4830:134:3::10]:37724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxJXQ-0000WL-Ae
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 17:06:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxJXP-00020J-9K
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 17:06:36 -0400
References: <20170927125340.12360-1-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8afc1fd5-5fdd-05d9-cc79-e05f52057c21@redhat.com>
Date: Wed, 27 Sep 2017 23:06:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170927125340.12360-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8xPNJfhQNa8X392eqGSxQLT39l2S3FvBV"
Subject: Re: [Qemu-devel] [PATCH v4 0/6] Misc improvements to crypto block
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8xPNJfhQNa8X392eqGSxQLT39l2S3FvBV
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <8afc1fd5-5fdd-05d9-cc79-e05f52057c21@redhat.com>
Subject: Re: [PATCH v4 0/6] Misc improvements to crypto block driver
References: <20170927125340.12360-1-berrange@redhat.com>
In-Reply-To: <20170927125340.12360-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-27 14:53, Daniel P. Berrange wrote:
> This is a followup to
>=20
>   v1: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg00781.ht=
ml
>   v2: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06464.ht=
ml
>   v3: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02923.ht=
ml
>=20
> This collection of patches first improves the performance of the
> crypto block driver and then does various cleanups to improve ongoing
> maint work.
>=20
> Changed in v4:
>=20
>   - Drop intermediate patch that replaced '512' with a constant (Max)
>   - Use MIN() macro where needed (Max)
>   - Fix bounce buffer size at 1MB instead of varying per sector size (M=
ax)
>   - Convert missing qcrypto_block_encrypt call to sectors in qcow.c (Ma=
x)
>=20
> Changed in v3:
>=20
>   - Support passthrough of BDRV_REQ_FUA (Eric)
>   - Fix potential truncation of payload offset values (Eric)
>   - Use encryption scheme sector size instead of BDRV_SECTOR_SIZE (Kevi=
n)
>   - Use QEMU_IS_ALIGNED where appropriate (Eric)
>   - Remove unused 'sector_num' variable (Eric)
>   - Fix whitespace alignment (Eric)
>   - Fix math error in qcow conversion (Eric)
>=20
> Daniel P. Berrange (6):
>   block: use 1 MB bounce buffers for crypto instead of 16KB
>   crypto: expose encryption sector size in APIs
>   block: fix data type casting for crypto payload offset
>   block: convert crypto driver to bdrv_co_preadv|pwritev
>   block: convert qcrypto_block_encrypt|decrypt to take bytes offset
>   block: support passthrough of BDRV_REQ_FUA in crypto driver
>=20
>  block/crypto.c         | 130 ++++++++++++++++++++++++++---------------=
--------
>  block/qcow.c           |  11 +++--
>  block/qcow2-cluster.c  |   8 ++-
>  block/qcow2.c          |   4 +-
>  crypto/block-luks.c    |  18 ++++---
>  crypto/block-qcow.c    |  13 +++--
>  crypto/block.c         |  26 +++++++---
>  crypto/blockpriv.h     |   5 +-
>  include/crypto/block.h |  29 ++++++++---
>  9 files changed, 148 insertions(+), 96 deletions(-)

Thanks; hoping that is OK with you, I've applied this series to my block
branch:

https://github.com/XanClic/qemu/commits/block

Max


--8xPNJfhQNa8X392eqGSxQLT39l2S3FvBV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnMEtASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A1AMH/j64QY/nDRvRCFIVWTPeIvJFIrxWdkO0
DtdxC9fcyCkiYk3pFSZ9K4fjL2L8dhL8+C16gZ3DaMKq7U2RgT1LmLUpWdsHrNMI
xvB3EaCfelEbIx2JoNbxdassYv0t+41p0en6nNrA5J3nTmM85Ug/C4IEbUQZm1vS
wUvFIYx2WoaPZ7IWkP1NHxfEUVJBd2GUi+BIcH4trbs2nhh9nTfCzNYXUxo7S7dl
0oB4xrxkQH5tH1Wn68ZryRhxjy8obLz1wbODZQv53sIDyqD4AodiWgmgILxl0VcW
6qQb0/vZycloKHm/Hxu6+r8rMvpHDdw6umVI8q+yijP+++crpnARzsU=
=Yuqp
-----END PGP SIGNATURE-----

--8xPNJfhQNa8X392eqGSxQLT39l2S3FvBV--
