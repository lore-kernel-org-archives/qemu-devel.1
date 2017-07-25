Received: from eggs.gnu.org ([2001:4830:134:3::10]:52601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7a1-000186-Qp
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7a0-0002eH-Nm
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:41:25 -0400
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
	<1500993699-19299-10-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3b2bc845-2201-a813-ad4e-d3cf86666bbd@redhat.com>
Date: Tue, 25 Jul 2017 16:41:16 -0500
MIME-Version: 1.0
In-Reply-To: <1500993699-19299-10-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6cnlIQVOKoggkRaUl6a3STMxoPO621R75"
Subject: Re: [Qemu-devel] [PATCH V5 09/10] block/qcow2: add lzo compress
 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6cnlIQVOKoggkRaUl6a3STMxoPO621R75
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com,
 den@openvz.org, mreitz@redhat.com, berrange@redhat.com
Message-ID: <3b2bc845-2201-a813-ad4e-d3cf86666bbd@redhat.com>
Subject: Re: [PATCH V5 09/10] block/qcow2: add lzo compress format
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
 <1500993699-19299-10-git-send-email-pl@kamp.de>
In-Reply-To: <1500993699-19299-10-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/25/2017 09:41 AM, Peter Lieven wrote:
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/qcow2-cluster.c  | 15 +++++++++++++++
>  block/qcow2.c          | 25 ++++++++++++++++++++++++-
>  configure              |  2 +-
>  docs/interop/qcow2.txt |  2 ++
>  qapi/block-core.json   | 15 ++++++++++++---
>  qemu-img.texi          |  1 +
>  6 files changed, 55 insertions(+), 5 deletions(-)
>=20

> +++ b/docs/interop/qcow2.txt
> @@ -335,6 +335,8 @@ The fields of the compress format extension are:
>                     deflate: Standard zlib deflate compression without
>                              compression header
> =20
> +                   lzo:     LZO1X compression without additional heade=
r
> +
>                14:  compress_level (uint8_t)
> =20
>                     0 =3D default compress level (valid for all formats=
, default)

What do compress_level and compress_window have to be for lzo?  (If they
are not useful, document that it must be 0 - which you've already done
for compress_level).


> +# @Qcow2CompressLZO:
> +#
> +# Since: 2.10

2.11

> +##
> +{ 'struct': 'Qcow2CompressLZO',
> +  'data': { } }
> +
> +##
>  # @Qcow2Compress:
>  #
>  # Specifies the compression format and compression level that should
> @@ -2491,8 +2500,8 @@
>  { 'union': 'Qcow2Compress',
>    'base': { 'format': 'Qcow2CompressFormat' },
>    'discriminator': 'format',
> -  'data': { 'deflate': 'Qcow2CompressDeflate' } }
> -
> +  'data': { 'deflate': 'Qcow2CompressDeflate',
> +            'lzo': 'Qcow2CompressLZO' } }
> =20

Was the loss of the blank line intentional?

> +++ b/qemu-img.texi
> @@ -682,6 +682,7 @@ The following options are available if support for =
the respective libraries
>  has been enabled at compile time:
> =20
>     deflate        Uses standard zlib defalte compression
> +   lzo            Uses LZO1X compression

The .json file spelled it lzo1x; is there a difference implied by the
choice of capitalization?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6cnlIQVOKoggkRaUl6a3STMxoPO621R75
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll3uvwACgkQp6FrSiUn
Q2rmcgf/VEOW3FrdzPEjdsoWFgw6aDOP1FYkulfX5RfheD6VgwX4k5d6/c2Xq2vN
XFKuOr+5vAyBOoWCDCn8WdUgaukinFt0JBntZcZCQgOem0bhsqSWluC44UZkMamA
USCVtEkEzxvd+MKvsUGWU0QAh/kq6BNKHBvjrDcdDpbYgCf9x7LE2zuv/ECfyiQp
2h6mZ7Qr5ponUIBWpezsiXwDIm+p2mw/fDn79ny0Xx9W+Cr2SV++75wqMBXTW5sY
+fmBstdiUT9//9Gxz5sK5q3IAD2ar/FmFwzH+l04GzqZ5LN11m9EJ4IsHQ4xMIBw
+aO2LWRePDj8UQ1tCqwqAqbOwCojpg==
=Tt1e
-----END PGP SIGNATURE-----

--6cnlIQVOKoggkRaUl6a3STMxoPO621R75--
