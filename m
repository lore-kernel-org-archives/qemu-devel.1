Received: from eggs.gnu.org ([209.51.188.92]:47435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gu6o1-0002a9-4B
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 21:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gu6o0-0006w3-7V
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 21:31:17 -0500
References: <20181203175211.8230-1-mreitz@redhat.com>
	<20181203175211.8230-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <413a20ef-77da-5818-24a4-38e67fb471ce@redhat.com>
Date: Wed, 13 Feb 2019 20:31:09 -0600
MIME-Version: 1.0
In-Reply-To: <20181203175211.8230-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xN7vsZtOC9EfdJLOyXvMqyOXW2fM6ERI5"
Subject: Re: [Qemu-devel] [PATCH for-next 1/6] qemu-img: Move quiet into
 ImgConvertState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xN7vsZtOC9EfdJLOyXvMqyOXW2fM6ERI5
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <413a20ef-77da-5818-24a4-38e67fb471ce@redhat.com>
Subject: Re: [PATCH for-next 1/6] qemu-img: Move quiet into ImgConvertState
References: <20181203175211.8230-1-mreitz@redhat.com>
 <20181203175211.8230-2-mreitz@redhat.com>
In-Reply-To: <20181203175211.8230-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/3/18 11:52 AM, Max Reitz wrote:
> Move img_convert()'s quiet flag into the ImgConvertState so it is
> accessible by nested functions.  -q dictates that it suppresses anythin=
g
> but errors, so if those functions want to emit warnings, they need to
> query this flag first.  (There currently are no such warnings, but ther=
e
> will be as of the next patch.)
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qemu-img.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--xN7vsZtOC9EfdJLOyXvMqyOXW2fM6ERI5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxk0u0ACgkQp6FrSiUn
Q2qYaAf9H5LzxIQbqE7EW/mdoKSHxtv+5OTmv5hZCZ0pNdezoTIUb3zUNfjy3iFH
4fuyak0ffzZjWuceuhc1h+Rwd1OGVZ2ib0Ck4CY9QBfLsclsNJowZ0qoLtm8fwEG
XhRWXaT2rQkzWwX/nALjEg+cywnARTKPxKEjaCHwpP2ec4IOhHis+kklb73OFoNx
OHq+BIPWKu9k1VlaWCsGR5jfQPXQBVo5r0vxdGsObVmd6zJh3NHUb6BGHIwGR3P4
lAJUEhoLxHkKxDLFSTFyplfehIiV5fEO8twBq5xCcXIFpIrykw1nppVu5gPSAUKu
7mEas3JN7rCGNwhiJ8fu9QRwhzTI1A==
=DoJn
-----END PGP SIGNATURE-----

--xN7vsZtOC9EfdJLOyXvMqyOXW2fM6ERI5--
