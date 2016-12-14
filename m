Received: from eggs.gnu.org ([2001:4830:134:3::10]:44628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cHC3S-0007zs-9s
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:05:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cHC3O-0008Qs-85
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:05:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cHC3N-0008QY-Vq
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:05:14 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C553104CE
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 16:05:13 +0000 (UTC)
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-6-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f13d65f5-e9bc-e8e6-8a5f-954d0412f218@redhat.com>
Date: Wed, 14 Dec 2016 10:05:11 -0600
MIME-Version: 1.0
In-Reply-To: <20161212224325.20790-6-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fN9bK17bUn5EdQpPn1SHCho7TBw9M2V3v"
Subject: Re: [Qemu-devel] [PATCH 05/54] char: fold single-user functions in
 caller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fN9bK17bUn5EdQpPn1SHCho7TBw9M2V3v
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <f13d65f5-e9bc-e8e6-8a5f-954d0412f218@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/54] char: fold single-user functions in
 caller
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
 <20161212224325.20790-6-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/12/2016 04:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> This shorten a bit the code.

Grammar:
This shortens the code a bit.

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qemu-char.c | 97 ++++++++++++++++++++---------------------------------=
--------
>  1 file changed, 31 insertions(+), 66 deletions(-)
>=20

>      name =3D g_strdup_printf("chardev-udp-%s", chr->label);
>      qio_channel_set_name(QIO_CHANNEL(sioc), name);
>      g_free(name);
> =20
> +    s =3D g_new0(NetCharDriver, 1);
> +    s->ioc =3D QIO_CHANNEL(sioc);
> +    s->bufcnt =3D 0;
> +    s->bufptr =3D 0;
> +    chr->opaque =3D s;
> +    /* be isn't opened until we get a connection */
> +    *be_opened =3D false;

The assignments to 0 and false are redundant with the g_new0(), if you
want to drop them for even more code reduction.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--fN9bK17bUn5EdQpPn1SHCho7TBw9M2V3v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYUW23AAoJEKeha0olJ0NqztwIAJDvFh5ewQrGzLye1G/SQ9oD
6Na/QBE7yH5usQjzZdTkgeAHXzI3+UKjEjkE1xLbNHzJahF9z0/5fxnf7GwJn2LH
i4BN8m/GNTDDgClNY9x2O5zD3L+vNNq2zykFGTFD5Q+1wjKPex549q1bpnDJJgPq
NAbN3JpFURzLrbhPhVzGYsdS8qSfp9yBk0YuzrU+lh1Rv37UlQ7dT1DhHy+l5SBJ
4qOPwE4lwqtabxrRh2/j3DO8n1cqRa0rntpUj95d0cnj+jttfOufcOMBAHXUTjvt
ZPO3ICdXwxfWariP3E8OnSnldNEqwdhGN51SlmtzKqJg4m/vzGIHFbt9GSj1NJk=
=KCuY
-----END PGP SIGNATURE-----

--fN9bK17bUn5EdQpPn1SHCho7TBw9M2V3v--
