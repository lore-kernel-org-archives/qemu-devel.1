Received: from eggs.gnu.org ([2001:4830:134:3::10]:53817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cck26-0007oe-1X
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 21:36:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cck24-0002n6-RV
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 21:36:58 -0500
References: <20170210170910.8867-1-berrange@redhat.com>
	<20170210170910.8867-12-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <aa0bf1b3-a220-91e5-ad7a-6bdbcd5c0442@redhat.com>
Date: Sun, 12 Feb 2017 03:36:47 +0100
MIME-Version: 1.0
In-Reply-To: <20170210170910.8867-12-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7F2OHJsAXbBtxWfP097eswjoCnwXLB8SE"
Subject: Re: [Qemu-devel] [PATCH v4 11/18] qcow2: convert QCow2 to use
 QCryptoBlock for encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7F2OHJsAXbBtxWfP097eswjoCnwXLB8SE
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>
Message-ID: <aa0bf1b3-a220-91e5-ad7a-6bdbcd5c0442@redhat.com>
Subject: Re: [PATCH v4 11/18] qcow2: convert QCow2 to use QCryptoBlock for
 encryption
References: <20170210170910.8867-1-berrange@redhat.com>
 <20170210170910.8867-12-berrange@redhat.com>
In-Reply-To: <20170210170910.8867-12-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 10.02.2017 18:09, Daniel P. Berrange wrote:
> This converts the qcow2 driver to make use of the QCryptoBlock
> APIs for encrypting image content, using the legacyy QCow2 AES
> scheme.
>=20
> With this change it is now required to use the QCryptoSecret
> object for providing passwords, instead of the current block
> password APIs / interactive prompting.
>=20
>   $QEMU \
>     -object secret,id=3Dsec0,filename=3D/home/berrange/encrypted.pw \
>     -drive file=3D/home/berrange/encrypted.qcow2,aes-key-secret=3Dsec0
>=20
> The test 087 could be simplified since there is no longer a
> difference in behaviour when using blockdev_add with encrypted
> images for the running vs stopped CPU state.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/qcow2-cluster.c      |  47 +----------
>  block/qcow2.c              | 192 +++++++++++++++++++++++++++++--------=
--------
>  block/qcow2.h              |   5 +-
>  qapi/block-core.json       |   8 +-
>  tests/qemu-iotests/049     |   2 +-
>  tests/qemu-iotests/049.out |   4 +-
>  tests/qemu-iotests/082.out |  27 +++++++
>  tests/qemu-iotests/087     |  27 +++----
>  tests/qemu-iotests/087.out |  12 +--
>  tests/qemu-iotests/134     |  18 +++--
>  tests/qemu-iotests/134.out |  10 +--
>  tests/qemu-iotests/158     |  19 +++--
>  tests/qemu-iotests/158.out |  14 +---
>  tests/qemu-iotests/common  |  10 ++-
>  14 files changed, 214 insertions(+), 181 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--7F2OHJsAXbBtxWfP097eswjoCnwXLB8SE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlifyj8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ATRgIAICI/vVgj5hdKHnftgJLfTX1YT5GQMs2
m1NduR9XIB5nqTngaislcIkyHqHPloZ39vnicFb+E2zu9JBhPSKq5Vot3mW8RgqT
TlO4n2lUxF11g8XezznqTJiuoTOzdHqeoSK+cN2b4cWK4PsJ6vMAZRSrQrJE5fTR
M1M5EP8qKos0C+EeAE9D94qD/V+DXoTh13Jm/jxJvZNeKyNVZJ+VXOPCAIYzmZZ+
50OKEv83LfxV1Q3c8RUs+UpAfHOKslWy96ZrLMrYvmiibiMHYlqqbcVyANoeCIdl
bkKA3l8JKlkouKP2urB3T46DjN0GbePCbL1t04p8aXoq/0L/P1u+ajg=
=82JK
-----END PGP SIGNATURE-----

--7F2OHJsAXbBtxWfP097eswjoCnwXLB8SE--
