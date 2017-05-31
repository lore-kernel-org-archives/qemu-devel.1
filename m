Received: from eggs.gnu.org ([2001:4830:134:3::10]:41319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG6Ha-0000B5-RC
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG6Ha-00029d-41
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:15:38 -0400
References: <20170509173342.29286-1-berrange@redhat.com>
	<20170509173342.29286-6-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1762f0c5-9881-99bb-6134-2877257d2895@redhat.com>
Date: Wed, 31 May 2017 18:15:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170509173342.29286-6-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nl9CkO1Ud0Iivx52NfrXSLpwlwO8RhEld"
Subject: Re: [Qemu-devel] [PATCH v5 5/5] iotests: chown LUKS device before
 qemu-io launches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nl9CkO1Ud0Iivx52NfrXSLpwlwO8RhEld
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <1762f0c5-9881-99bb-6134-2877257d2895@redhat.com>
Subject: Re: [PATCH v5 5/5] iotests: chown LUKS device before qemu-io launches
References: <20170509173342.29286-1-berrange@redhat.com>
 <20170509173342.29286-6-berrange@redhat.com>
In-Reply-To: <20170509173342.29286-6-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-09 19:33, Daniel P. Berrange wrote:
> On some distros, whenever you close a block device file
> descriptor there is a udev rule that resets the file
> permissions. This can race with the test script when
> we run qemu-io multiple times against the same block
> device. Occasionally the second qemu-io invocation
> will find udev has reset the permissions causing failure.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/qemu-iotests/149     |  13 +-
>  tests/qemu-iotests/149.out | 344 ++++++++++++++++++++++---------------=
--------
>  2 files changed, 178 insertions(+), 179 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
> index 5faf585..bc628ce 100755
> --- a/tests/qemu-iotests/149
> +++ b/tests/qemu-iotests/149
> @@ -23,6 +23,7 @@
>  import subprocess
>  import os
>  import os.path
> +import time

Why?

Rest looks good.

Max


--nl9CkO1Ud0Iivx52NfrXSLpwlwO8RhEld
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLuwfEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQMnV
B/wP5s5cIxkaCZwcHsO9M8taCc7RDxvQ/dZG3wtuNmRKOGAck5ljURnXqALxsziZ
AUVHos+L3AIubim0Qm3Y8ZmHEhvS8JYypZTxAjLJNBdnF6dndsp/vloBmetSwaKc
kcHsTrPzsdbW/uZTz89tnq8zlkHyVBZEusiuElgNBCCObnhOZb8BUZNx9Ss+8Fd7
aIoP+4cjkR9r498KekqfsU+iGS2/DeQOvuzd+BCdwdchIaRcXy4Ky3CPBfhDBtOk
2aFEvMWkBR9yb2yYP6AFiL/YWPbh+BRNxK4jsc1I0fwN5ZqmNWLwcRjp4uXFU321
kVR+t+OuZbk5wXaYVGWpy/xw
=DjVa
-----END PGP SIGNATURE-----

--nl9CkO1Ud0Iivx52NfrXSLpwlwO8RhEld--
