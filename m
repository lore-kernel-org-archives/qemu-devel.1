Received: from eggs.gnu.org ([2001:4830:134:3::10]:43979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbbcx-00022w-Ab
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 18:26:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbbct-0000uE-Em
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 18:26:19 -0500
References: <20170126101827.22378-1-berrange@redhat.com>
	<20170126101827.22378-12-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <60d79ad6-fd95-e800-04ca-252ac32f514d@redhat.com>
Date: Thu, 9 Feb 2017 00:26:07 +0100
MIME-Version: 1.0
In-Reply-To: <20170126101827.22378-12-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="caC3p3p7rU3InDl0NnlO2amxrMa2jkDEe"
Subject: Re: [Qemu-devel] [PATCH v3 11/18] qcow2: convert QCow2 to use
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--caC3p3p7rU3InDl0NnlO2amxrMa2jkDEe
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <60d79ad6-fd95-e800-04ca-252ac32f514d@redhat.com>
Subject: Re: [PATCH v3 11/18] qcow2: convert QCow2 to use QCryptoBlock for
 encryption
References: <20170126101827.22378-1-berrange@redhat.com>
 <20170126101827.22378-12-berrange@redhat.com>
In-Reply-To: <20170126101827.22378-12-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 26.01.2017 11:18, Daniel P. Berrange wrote:
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
>  block/qcow2.c              | 190 +++++++++++++++++++++++++++++--------=
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
>  14 files changed, 212 insertions(+), 181 deletions(-)

For the record: Apart from the the issue Berto found (which I didn't
even notice in the last version */me whistles*), no objections from my si=
de.

Max


--caC3p3p7rU3InDl0NnlO2amxrMa2jkDEe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlibqQ8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AjiIH/3+nspKIunYDR9hYviHJYlGKILCLz8ax
b3obeDd367Ku+1dwbuhT1S6i21tDJpH06fgAyzyzqkJXx7Y518DJlEz08Bgis4pL
2m2Lau4xMDYH/kjvRjIh20uxJ+88QTr2/8sehgYpDqvuQfc2ocT0qT3SzKYAqWQb
WlbmlZJJKp/rRt6KOdc9osEkqPXJRmqUK6ODUd9U2NxD1fSr6P9pORMhn2LmXZUB
+tkvICk/o33ukSKECjbksgASsElBfuEEy19ifbers3s6aNMl8BfYHP9MX/GLJ8wa
xjJV+nw/iY8+xTwo7rgmBqySnZDar2uUdlv6LIJWwpD0qngMVSFmmpk=
=nWiJ
-----END PGP SIGNATURE-----

--caC3p3p7rU3InDl0NnlO2amxrMa2jkDEe--
