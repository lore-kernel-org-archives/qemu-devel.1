Received: from eggs.gnu.org ([2001:4830:134:3::10]:38012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dIeFM-0007yq-0p
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dIeFL-0006xw-1O
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:55:51 -0400
References: <20170601172734.9039-1-berrange@redhat.com>
	<20170601172734.9039-10-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e362e833-32b9-57ec-4a92-c17293eefbbe@redhat.com>
Date: Wed, 7 Jun 2017 18:55:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170601172734.9039-10-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tcoNkskWIIq7h9W4s7Jv5LgqB5CSEXmme"
Subject: Re: [Qemu-devel] [PATCH v8 09/20] qcow: convert QCow to use
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
--tcoNkskWIIq7h9W4s7Jv5LgqB5CSEXmme
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <e362e833-32b9-57ec-4a92-c17293eefbbe@redhat.com>
Subject: Re: [PATCH v8 09/20] qcow: convert QCow to use QCryptoBlock for
 encryption
References: <20170601172734.9039-1-berrange@redhat.com>
 <20170601172734.9039-10-berrange@redhat.com>
In-Reply-To: <20170601172734.9039-10-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-01 19:27, Daniel P. Berrange wrote:
> This converts the qcow driver to make use of the QCryptoBlock
> APIs for encrypting image content. This is only wired up to
> permit use of the legacy QCow encryption format. Users who wish
> to have the strong LUKS format should switch to qcow2 instead.
>=20
> With this change it is now required to use the QCryptoSecret
> object for providing passwords, instead of the current block
> password APIs / interactive prompting.
>=20

Beware, nit picks incoming:

>   $QEMU \
>     -object secret,id=3Dsec0,filename=3D/home/berrange/encrypted.pw \> =
    -drive file=3D/home/berrange/encrypted.qcow,encrypt.format=3Dqcow,\

encrypt.format should be "aes".

>            encrypt.key-secret=3Dsec0

This doesn't work at all, though, because:

Use of AES-CBC encrypted qcow images is no longer supported in system
emulators
You can use 'qemu-img convert' to convert your image to an alternative
supported format, such as unencrypted qcow, or raw with the LUKS format
instead.

>=20
> Likewise when creating images with the legacy AES-CBC format
>=20
>   qemu-img create -f qcow \
>     -object secret,id=3Dsec0,filename=3D/home/berrange/encrypted.pw \

Should be --object.

>     -o encrypt.format=3Daes,encrypt.key-secret=3Dsec0 \
>     /home/berrange/encrypted.qcow

There should be a size here to make it work.

The patch itself does look good to me, though.

Max

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


--tcoNkskWIIq7h9W4s7Jv5LgqB5CSEXmme
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZODALEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQO7s
B/48Xpv4OiMlzjAiXCmzMVEntrlVy7Bi7Hziurmw+eM9Y2+7WN8g50o5ewCrVF7n
m/lCp6V2OBIbR5EFTIQmI0jp6WD159Ou6gHtL5zHDR8cBR1Tf92AyYVOncuUe/Sl
B6EJsAlv9Eap3/z/0TY6Su5Lk2QttG8UBJzwiX9sN+EXs+DeMtzGlnbDxgeZGN4L
OtO3zoieiOBmNChwSmYjTpaUAbdKQQDnH/EogpismGzCfPgggZTuv6pPYCkO7AL9
6goqjanQe0ZPC0gBZsBVbbjbV1bMsSKzTRQtquQR02xPo8l16CUkmqC5jk2cnPGo
lP2v2rD6NB97VJQsYk2MrMZr
=klPa
-----END PGP SIGNATURE-----

--tcoNkskWIIq7h9W4s7Jv5LgqB5CSEXmme--
