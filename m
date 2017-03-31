Received: from eggs.gnu.org ([2001:4830:134:3::10]:50288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cu2DG-0007CC-4s
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cu2DF-0004Sl-1T
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:27:58 -0400
References: <20170331120431.1767-1-mreitz@redhat.com>
	<20170331120431.1767-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f516884a-771f-39f0-db29-f71557dd7250@redhat.com>
Date: Fri, 31 Mar 2017 14:27:47 -0500
MIME-Version: 1.0
In-Reply-To: <20170331120431.1767-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fvpomFbR8RRAQHqfQ1S9HlKAophe3KLIQ"
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/2] qapi/curl: Extend and fix
 blockdev-add schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fvpomFbR8RRAQHqfQ1S9HlKAophe3KLIQ
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <f516884a-771f-39f0-db29-f71557dd7250@redhat.com>
Subject: Re: [PATCH for-2.9 1/2] qapi/curl: Extend and fix blockdev-add schema
References: <20170331120431.1767-1-mreitz@redhat.com>
 <20170331120431.1767-2-mreitz@redhat.com>
In-Reply-To: <20170331120431.1767-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/31/2017 07:04 AM, Max Reitz wrote:
> The curl block driver accepts more options than just "filename"; also,
> the URL is actually expected to be passed through the "url" option
> instead of "filename".
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qapi/block-core.json | 103 +++++++++++++++++++++++++++++++++++++++++++=
+++-----
>  1 file changed, 94 insertions(+), 9 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index b5f0e9958c..033457ce86 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2737,16 +2737,101 @@
>              '*debug': 'int' } }
> =20
>  ##
> -# @BlockdevOptionsCurl:
> +# @BlockdevOptionsCurlBase:
>  #
> -# Driver specific block device options for the curl backend.
> +# Driver specific block device options shared by all protocols support=
ed by the
> +# curl backend.
>  #
> -# @filename:    path to the image file
> +# @url:                     URL of the image file
> +#
> +# @readahead:               Size of the read-ahead cache; must be a mu=
ltiple of
> +#                           512 (defaults to 256 kB)
> +#
> +# @timeout:                 Timeout for connections, in seconds (defau=
lts to 5)
> +#
> +# @username:                Username for authentication (defaults to n=
one)
> +#
> +# @password-secret:         ID of a QCryptoSecret object providing a p=
assword
> +#                           for authentication (defaults to no passwor=
d)
> +#
> +# @proxy-username:          Username for proxy authentication (default=
s to none)
> +#
> +# @proxy-password-secret:   ID of a QCryptoSecret object providing a p=
assword
> +#                           for proxy authentication (defaults to no p=
assword)
> +#

Matches runtime_opts of block/curl.c, modulo the fields that you
restricted to specific protocols by creating subtypes. Looks like you
covered everything correctly.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--fvpomFbR8RRAQHqfQ1S9HlKAophe3KLIQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3q2zAAoJEKeha0olJ0NqxUYIAI5hdqHXUfI218t8wz1xRYRK
d84u2xiqyJAV3X+aEfAx6WKiWGuFZqNC13A6hyBlP83ns+85kgIe/hTpoqnEuDv5
ovbTIc+8w2e/wSv3sOkGBnSDk5tDR4850moivdCB17vSNcLcEM9rNdDuw2nJ8Vjr
kC5xRD9UKCZZN5lAVTtJXrswlHnvpJqvm9ifmOgpTYjBH/n/1mBuhinRnneuBWaa
R5lJ1Cy+atyJTn5hX8M/cNguFjriESkxmDy9rCcIjNRIVckwz7PxNQduNGLcWocp
G/Vwh3oirZc0QH8jdbr40kNzdnVD6wiP8wgwo5VOER0o8DQ+t6JrXbCiV/mrQeI=
=9Bb/
-----END PGP SIGNATURE-----

--fvpomFbR8RRAQHqfQ1S9HlKAophe3KLIQ--
