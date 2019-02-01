Received: from eggs.gnu.org ([209.51.188.92]:58002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gperc-0007nK-Sj
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:52:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gperZ-0000te-19
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:52:34 -0500
References: <20190201192935.18394-1-mreitz@redhat.com>
	<20190201192935.18394-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8c79113a-b384-2c6f-2330-8327d421d888@redhat.com>
Date: Fri, 1 Feb 2019 13:52:13 -0600
MIME-Version: 1.0
In-Reply-To: <20190201192935.18394-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JFoFX6x1fHOEQvCRb7ElgBmGvCMVW5foW"
Subject: Re: [Qemu-devel] [PATCH v13 01/31] block: Use
 bdrv_refresh_filename() to pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JFoFX6x1fHOEQvCRb7ElgBmGvCMVW5foW
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <8c79113a-b384-2c6f-2330-8327d421d888@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v13 01/31] block: Use bdrv_refresh_filename()
 to pull
References: <20190201192935.18394-1-mreitz@redhat.com>
 <20190201192935.18394-2-mreitz@redhat.com>
In-Reply-To: <20190201192935.18394-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/1/19 1:29 PM, Max Reitz wrote:
> Before this patch, bdrv_refresh_filename() is used in a pushing manner:=

> Whenever the BDS graph is modified, the parents of the modified edges
> are supposed to be updated (recursively upwards).  However, that is
> nonviable, considering that we want child changes not to concern
> parents.
>=20
> Also, in the long run we want a pull model anyway: Here, we would have =
a
> bdrv_filename() function which returns a BDS's filename, freshly
> constructed.
>=20
> This patch is an intermediate step.  It adds bdrv_refresh_filename()
> calls before every place a BDS.filename value is used.  The only
> exceptions are protocol drivers that use their own filename, which
> clearly would not profit from refreshing that filename before.
>=20
> Also, bdrv_get_encrypted_filename() is removed along the way (as a user=

> of BDS.filename), since it is completely unused.
>=20
> In turn, all of the calls to bdrv_refresh_filename() before this patch
> are removed, because we no longer have to call this function on graph
> changes.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--JFoFX6x1fHOEQvCRb7ElgBmGvCMVW5foW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxUo20ACgkQp6FrSiUn
Q2rajAf/X9vHW9vlLOVDhgSgQFlKwZyWAay+YiE4YN/o1fcliN5l7lyByw0gFyXK
2J9Bc8Js4vC8H8Uh7GuefSS3eWxj+w/2PyvfGm40sXg7Pc6q6uNfX27caSGLsvp6
Evl7zy0gLdfAnDB+fz9y18ZhBS8qbexxMphTTIy3s7Qj8sheqjleQ9yRnHCtYCzE
yrNnBkltJGRkhurp2qkSqzvdsN6NKl3fYxhXH6kcwDhy5IJfyaXe9DK7L/M95jH/
Pp9NYhLmth+eO+FGuDDWcAjoKkKaOqoc9StZllSpCHAkgGZjr/7MBe8G+zklE2YL
H64W9emDS/LqPJaykId8vUVjG7sJGA==
=W+B6
-----END PGP SIGNATURE-----

--JFoFX6x1fHOEQvCRb7ElgBmGvCMVW5foW--
