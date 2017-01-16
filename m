Received: from eggs.gnu.org ([2001:4830:134:3::10]:51705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTEdc-00083F-IX
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTEdb-00033V-Nr
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:16:24 -0500
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-10-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6c2ac3f6-8321-e744-dacd-213b2b3f53a2@redhat.com>
Date: Mon, 16 Jan 2017 22:16:15 +0100
MIME-Version: 1.0
In-Reply-To: <20170103182801.9638-10-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="S6O7aDEHgeSJf4NTbxgcjda8PUrJGxFq4"
Subject: Re: [Qemu-devel] [PATCH v1 09/15] qcow: convert QCow to use
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S6O7aDEHgeSJf4NTbxgcjda8PUrJGxFq4
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <6c2ac3f6-8321-e744-dacd-213b2b3f53a2@redhat.com>
Subject: Re: [PATCH v1 09/15] qcow: convert QCow to use QCryptoBlock for
 encryption
References: <20170103182801.9638-1-berrange@redhat.com>
 <20170103182801.9638-10-berrange@redhat.com>
In-Reply-To: <20170103182801.9638-10-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.01.2017 19:27, Daniel P. Berrange wrote:
> This converts the qcow2 driver to make use of the QCryptoBlock
> APIs for encrypting image content. This is only wired up to
> permit use of the legacy QCow encryption format. Users who wish
> to have the strong LUKS format should switch to qcow2 instead.
>=20
> With this change it is now required to use the QCryptoSecret
> object for providing passwords, instead of the current block
> password APIs / interactive prompting.
>=20
>   $QEMU \
>     -object secret,id=3Dsec0,filename=3D/home/berrange/encrypted.pw \
>     -drive file=3D/home/berrange/encrypted.qcow,aes-key-secret=3Dsec0
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c       |  10 +++
>  block/crypto.h       |   9 +++
>  block/qcow.c         | 184 +++++++++++++++++++++++--------------------=
--------
>  qapi/block-core.json |  17 ++++-
>  4 files changed, 117 insertions(+), 103 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--S6O7aDEHgeSJf4NTbxgcjda8PUrJGxFq4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlh9OB8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A0wAH/0fPN9oqsFM1TLaQISoc0C9EpV39d90q
BUZJdz07b8WtWHm6qmj5vAPDv59ZHT0L5So2aVm7HhXBfmnQmayyFX123j81Z1Vx
kGQrHedIhE+6I5emaBTNXg4I98b26EvcSZ4XsyMjp/thD19yWHmgW8/u2aFc0y9k
4xpoJnPthHA/t/2Y7chOzqFSB1ViZhA9+JGJ81coCApvxasrsNftYsFtxS0qzi4N
8AveASoYtT7vTyMM/sMm1eA8KweBsTUPORKLxzeSPrQzqGCiaOh4Oq1Z7L43JgjW
3Uwf4q3rxS2DmyH7EdPgG88JEdzgJc756+7BGASbGNw64400Pv0clLE=
=KjRq
-----END PGP SIGNATURE-----

--S6O7aDEHgeSJf4NTbxgcjda8PUrJGxFq4--
