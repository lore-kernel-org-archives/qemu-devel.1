Received: from eggs.gnu.org ([209.51.188.92]:55745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hG4Kc-0005F5-9o
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hG4Kb-00033I-CV
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:19:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hG4Ka-00031x-UF
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:19:41 -0400
References: <20190415154906.14621-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <86b16e27-781b-d298-a1c8-afd27972f000@redhat.com>
Date: Mon, 15 Apr 2019 11:19:36 -0500
MIME-Version: 1.0
In-Reply-To: <20190415154906.14621-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iFdUrPtVr1DKGQXpaa6M0wHa7v8rkKZrB"
Subject: Re: [Qemu-devel] [PATCH for-4.0?] socket: allow wait=false for
 client socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iFdUrPtVr1DKGQXpaa6M0wHa7v8rkKZrB
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <86b16e27-781b-d298-a1c8-afd27972f000@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0?] socket: allow wait=false for client
 socket
References: <20190415154906.14621-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190415154906.14621-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/15/19 10:49 AM, Marc-Andr=C3=A9 Lureau wrote:
> Commit 767abe7 ("chardev: forbid 'wait' option with client sockets")
> is a bit too strict. Current libvirt always set wait=3Dfalse, and will
> thus fail to add client chardev.
>=20
> Make the code more permissive, allowing wait=3Dfalse with client socket=

> chardevs.
>=20
> Fixes: 767abe7f49e8be14d29da5db3527817b5d696a52
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

According to Fixes, this is a regression in 4.0. Is it worth having this
fix in -rc4?

>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 3916505d67..2ad9c9eea5 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1262,7 +1262,7 @@ static bool qmp_chardev_validate_socket(ChardevSo=
cket *sock,
>              error_setg(errp, "%s", "Websocket client is not implemente=
d");
>              return false;
>          }
> -        if (sock->has_wait) {
> +        if (sock->has_wait && sock->wait) {
>              error_setg(errp, "%s",
>                         "'wait' option is incompatible with "
>                         "socket in client connect mode");
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--iFdUrPtVr1DKGQXpaa6M0wHa7v8rkKZrB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly0rxgACgkQp6FrSiUn
Q2pdmwf7Br/xHtQLfu3jN9Yb0MD6vkz4P+KBYwQ7iCXaRR+4PKnUxWcvpOktlJJM
/+4p3MC1l5naP1zJ6Ls3LJC3iirdahMmH0U0wLG/1WV9s5IMAlDCw/57Vu5TQ8AF
Sp0VATl/bpMQ64D+uVFe+R1wridVlYRYKmC/2vq1A2fTl1xKNhYvYBKmQnnDHeVL
tX51/adCTqdOIa4tqPtG/5hexPk7mLtNgG5uvqfrP1KNrmHAVMRnEjYgaaxElhP2
WeJsz3x1Ohgl6btqX7Bwnpyuhauw8AeuLVIrQNtspwT0u+oBgP1O+uXQwC7TGo8t
JeIEyrzk6g4Wl7eWkLAt+BR4Z8AjQQ==
=+2DL
-----END PGP SIGNATURE-----

--iFdUrPtVr1DKGQXpaa6M0wHa7v8rkKZrB--
