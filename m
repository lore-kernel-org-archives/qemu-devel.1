Received: from eggs.gnu.org ([209.51.188.92]:36021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ggYXD-0007YA-9e
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:18:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ggYX4-0006pK-8l
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:17:55 -0500
References: <20190103094728.31747-1-rjones@redhat.com>
	<20190103094728.31747-2-rjones@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
Date: Mon, 7 Jan 2019 18:17:30 +0100
MIME-Version: 1.0
In-Reply-To: <20190103094728.31747-2-rjones@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iaKwFR2U5lWWNtBGYIv1RvxEa1Gt1KpIW"
Subject: Re: [Qemu-devel] [PATCH v2] qemu-io: Reinitialize optind to 1 (not
 0) before parsing inner command.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, eblake@redhat.com
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iaKwFR2U5lWWNtBGYIv1RvxEa1Gt1KpIW
From: Max Reitz <mreitz@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>, eblake@redhat.com
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
Subject: Re: [PATCH v2] qemu-io: Reinitialize optind to 1 (not 0) before
 parsing inner command.
References: <20190103094728.31747-1-rjones@redhat.com>
 <20190103094728.31747-2-rjones@redhat.com>
In-Reply-To: <20190103094728.31747-2-rjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.01.19 10:47, Richard W.M. Jones wrote:
> On FreeBSD 11.2:
>=20
>   $ nbdkit memory size=3D1M --run './qemu-io -f raw -c "aio_write 0 512=
" $nbd'
>   Parsing error: non-numeric argument, or extraneous/unrecognized suffi=
x -- aio_write
>=20
> After main option parsing, we reinitialize optind so we can parse each
> command.  However reinitializing optind to 0 does not work on FreeBSD.
> What happens when you do this is optind remains 0 after the option
> parsing loop, and the result is we try to parse argv[optind] =3D=3D
> argv[0] =3D=3D "aio_write" as if it was the first parameter.
>=20
> The FreeBSD manual page says:
>=20
>   In order to use getopt() to evaluate multiple sets of arguments, or t=
o
>   evaluate a single set of arguments multiple times, the variable optre=
set
>   must be set to 1 before the second and each additional set of calls t=
o
>   getopt(), and the variable optind must be reinitialized.

[...]

> Note I didn't set optreset.  It's not present in glibc and the "hard
> reset" is not necessary in this context.

But it sure sounds like FreeBSD requires you to set it, doesn't it?

Max

> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  qemu-io-cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index 2c39124036..aa10ed5a20 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -114,7 +114,7 @@ static int command(BlockBackend *blk, const cmdinfo=
_t *ct, int argc,
>          }
>      }
> =20
> -    optind =3D 0;
> +    optind =3D 1;
>      return ct->cfunc(blk, argc, argv);
>  }
> =20
>=20



--iaKwFR2U5lWWNtBGYIv1RvxEa1Gt1KpIW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlwziaoACgkQ9AfbAGHV
z0DCAgf+J2J2x3zON8AkXsQHUDpA61JGF6edoFerxmNS800i4odDQw0QwSgig3AV
cAD/U4LickRBESvnRC0rokZgN22xPQGlHodLgheiiYf5cuDPEbIFMz70H7vhIMT1
PYKRX0ak7rNsGDJr8DtLIChGCPBKSwd4wPvINub67whfgrjN9Ihn9nc+iSOObVkm
zEcx3EmUWpiVDIz1vNAifo+CnvBnhi3cqoJjrrVq886sKOKhnU3wKLHKWKxSKdUz
A7rk3LsuMgGQbwQRFoJ5pbxlEf/qjzd6lpMgWgxc5x+tRbjoA5NjhXbr8YzsLrqt
LATsqEO2fNeXv5sXWfg4wuU6b9ddqg==
=QniL
-----END PGP SIGNATURE-----

--iaKwFR2U5lWWNtBGYIv1RvxEa1Gt1KpIW--
