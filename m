Received: from eggs.gnu.org ([2001:4830:134:3::10]:41940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXYA5-0001SK-Fh
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 15:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXYA4-0000Cl-Gi
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 15:28:01 -0400
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-17-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <164d97c1-9244-d406-ecac-93d1a00eb8a6@redhat.com>
Date: Tue, 18 Jul 2017 14:27:42 -0500
MIME-Version: 1.0
In-Reply-To: <20170704220346.29244-17-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AsKXO7UiE0ixRp29OoeIaCdDmu9OQOjw6"
Subject: Re: [Qemu-devel] [PATCH 16/35] crypto: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AsKXO7UiE0ixRp29OoeIaCdDmu9OQOjw6
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <164d97c1-9244-d406-ecac-93d1a00eb8a6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 16/35] crypto: mark coroutine_fn
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
 <20170704220346.29244-17-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-17-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/04/2017 05:03 PM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  block/crypto.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/crypto.c b/block/crypto.c
> index 10e5ddccaa..0e30a4ea06 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -568,7 +568,8 @@ static int block_crypto_open_luks(BlockDriverState =
*bs,
>                                       bs, options, flags, errp);
>  }
> =20
> -static int block_crypto_create_luks(const char *filename,
> +static int coroutine_fn
> +block_crypto_create_luks(const char *filename,
>                                      QemuOpts *opts,
>                                      Error **errp)

Indentation is now off.

I don't know how hard we should try to keep our usual style of:

really long labels fn_name(parameters)

vs. the style I'm used to in emacs:

really long labels
fn_name(parameters)

the latter makes it easier to grep for a function implementation (grep
for ^fn_name), and also makes it easier to fit more parameters without
line wrapping, but is not heavily used in our current code base.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AsKXO7UiE0ixRp29OoeIaCdDmu9OQOjw6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluYS4ACgkQp6FrSiUn
Q2qa+gf9Hp1VrgZfj4oPlDmJp5QxaiGa9fSMqFYPVKeqwJ1I4Tz5jPUr7KTC85Lb
SVIBdEmhfLQ7MaSo+0YTPvYw8AFbAFFS5e8yfLkBerys+eqEWnXNUMfX5w+eCLgS
zENHx9hFRqSQyIRnCuebgIESH4i3MXjfAnu89+fIOVtXMmvBk0hUcFiNo36HabnD
VEq1r1hsQQGkY9TJZFJtfgx4w4mP3nwFxFbNZf2H1wokvWcCcLaPulUFwE4cKFve
sDj+6TAUZBLQrYzaMIE5nMMMG6yl+fwfJAK7RMaIZbRf8WOhJ83qBTRDTLueXUfx
w8CPNOkPCEk0ZVfV/57lgD2k65YZqQ==
=KxT/
-----END PGP SIGNATURE-----

--AsKXO7UiE0ixRp29OoeIaCdDmu9OQOjw6--
