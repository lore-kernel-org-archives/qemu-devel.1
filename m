Received: from eggs.gnu.org ([2001:4830:134:3::10]:32808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNgd9-0006wC-H0
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNgd8-0005g4-MA
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:29:15 -0400
References: <20170619173455.18805-1-berrange@redhat.com>
	<20170619173455.18805-10-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0456194f-d8c0-3542-2a8a-6a952b4c8b58@redhat.com>
Date: Wed, 21 Jun 2017 16:29:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170619173455.18805-10-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BE3h4bMiPvsgnSGXH3Iks7MCaam29a1Xf"
Subject: Re: [Qemu-devel] [PATCH v9 09/20] qcow: convert QCow to use
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
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BE3h4bMiPvsgnSGXH3Iks7MCaam29a1Xf
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <0456194f-d8c0-3542-2a8a-6a952b4c8b58@redhat.com>
Subject: Re: [PATCH v9 09/20] qcow: convert QCow to use QCryptoBlock for
 encryption
References: <20170619173455.18805-1-berrange@redhat.com>
 <20170619173455.18805-10-berrange@redhat.com>
In-Reply-To: <20170619173455.18805-10-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-19 19:34, Daniel P. Berrange wrote:
> This converts the qcow driver to make use of the QCryptoBlock
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
>     -drive file=3D/home/berrange/encrypted.qcow,encrypt.format=3Dqcow,\=


Still should be encrypt.format=3Daes, but, well... Let's just give it a

Reviewed-by: Max Reitz <mreitz@redhat.com>

regardless.

>            encrypt.key-secret=3Dsec0
>=20
> Though note that running QEMU system emulators with the AES
> encryption is no longer supported, so while the above syntax
> is valid, QEMU will refuse to actually run the VM in this
> particular example.
>=20
> Likewise when creating images with the legacy AES-CBC format
>=20
>   qemu-img create -f qcow \
>     --object secret,id=3Dsec0,filename=3D/home/berrange/encrypted.pw \
>     -o encrypt.format=3Daes,encrypt.key-secret=3Dsec0 \
>     /home/berrange/encrypted.qcow 64M
>=20
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c       |  10 +++
>  block/crypto.h       |  20 ++++--
>  block/qcow.c         | 198 +++++++++++++++++++++++++------------------=
--------
>  qapi/block-core.json |  38 +++++++++-
>  4 files changed, 158 insertions(+), 108 deletions(-)


--BE3h4bMiPvsgnSGXH3Iks7MCaam29a1Xf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZSoKuEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQD6Q
B/9LgZSOOCJauDLYfIy6kYZwiKrThvX0c42iIUitkaeN3F2IqE0ZgazHo0RfYWoF
1c7Eq8e3nDj63U2/exXk64MeLparYJC7yX5KD201KVCnnVPzggDw+uo3WoAeJ2UT
Hq11O2MVgyEdoWCz4FOQeO07Q5eW4X56wEcMkZPk7rjEZmZ17jIn0NpRlFlGp3BS
+GRwSiDcHvoMlp9tTnJLWgezCV0xLtbGmAbp3nLPXucgSBe2r8hPHUEZXTakNrws
WcRIytKeRjDbg8EwBYCP9tJO9at9xESnakjXMk+g1Aya1JUgY0NPwUQmlt6mk5BX
9JQWYeP83dOF0Zq44UGLksaF
=gPZw
-----END PGP SIGNATURE-----

--BE3h4bMiPvsgnSGXH3Iks7MCaam29a1Xf--
