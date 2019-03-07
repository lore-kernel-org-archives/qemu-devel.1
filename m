Received: from eggs.gnu.org ([209.51.188.92]:42203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1x0S-0002ne-S5
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:40:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1x0S-0005j5-6U
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:40:32 -0500
References: <20190307165303.15382-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <415d75bd-2d62-d19a-8a5f-e463f4f72866@redhat.com>
Date: Thu, 7 Mar 2019 11:40:25 -0600
MIME-Version: 1.0
In-Reply-To: <20190307165303.15382-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IG1tCIMt6q5wgmOr2MGM9QBX2X2AB64FK"
Subject: Re: [Qemu-devel] [PATCH] qcow2 spec: Describe string header
 extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IG1tCIMt6q5wgmOr2MGM9QBX2X2AB64FK
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, qemu-devel@nongnu.org
Message-ID: <415d75bd-2d62-d19a-8a5f-e463f4f72866@redhat.com>
Subject: Re: [PATCH] qcow2 spec: Describe string header extensions
References: <20190307165303.15382-1-kwolf@redhat.com>
In-Reply-To: <20190307165303.15382-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/7/19 10:53 AM, Kevin Wolf wrote:
> Be more specific about the string representation in header extensions.
>=20
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  docs/interop/qcow2.txt | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20

Based-on: <20190227172256.30368-1-kwolf@redhat.com>

> =20
> =20
> +=3D=3D String header extensions =3D=3D
> +
> +Some header extensions (such as the backing file format name and the e=
xternal
> +data file name) are just a single string. In this case, the header ext=
ension
> +length is the string length and the string is not '\0' terminated. (Th=
e header
> +extension padding can make it look like a string is '\0' terminated, b=
ut
> +neither is padding always necessary nor is there a guarantee that zero=
 bytes
> +are used for padding.)

We didn't require 0 padding?  (goes and re-reads) - oops, yes that's
correct. It makes it harder to extend a struct by making use of that
padding if you can't guarantee what the padding had to be prior to the
extension, and means that you have to consider whether there are any
potential security risks of the padding being used as a side channel to
leak information while still being a well-formed file. But changing the
standard to require zero padding is different than documenting existing
practice, so your patch is correct.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--IG1tCIMt6q5wgmOr2MGM9QBX2X2AB64FK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyBV4kACgkQp6FrSiUn
Q2r1iwf/UR+dedHQSz4G4qoIpLCx2q3Saf5JseS+9vlCN7p+kYlo+g8w6wy2v6Ph
oKUcZbPzqgV5yh8ZSQzxSFcYNGytFhR109t1A1fI4l80vsLi+2+ikYqtlkssCZAd
vZZPwQkGDIF3y5ApuiGibWel5Lbuj1WTR1f9PhRz6mo4ClhR3ppt24b1uKb2paxI
Kb6tiOVrNbZjnmSwoDB6RQzYsvt8OXUhf334AWSLGi/Nmo/ZRyl1HYDZBtkQpHUq
yj2+2MOlk0Tc0zZidg+TaTf5nvDLaeEnH9zIa0d0BLGjJUJCxlEMIuYdqlhB9j0O
HIomEyOvCwq9r3qfoaIHAz5LqJFWVQ==
=1qHl
-----END PGP SIGNATURE-----

--IG1tCIMt6q5wgmOr2MGM9QBX2X2AB64FK--
