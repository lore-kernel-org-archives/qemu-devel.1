Received: from eggs.gnu.org ([2001:4830:134:3::10]:56059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVkcG-00061G-Nv
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVkcF-0004kd-N6
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:21:40 -0400
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
	<20170713163219.9024-11-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <873282ab-9f53-6a48-c644-280ebf0e1a81@redhat.com>
Date: Thu, 13 Jul 2017 15:21:28 -0500
MIME-Version: 1.0
In-Reply-To: <20170713163219.9024-11-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m40CrhB2HjXb82kcqH8wUxTQukcC01UUl"
Subject: Re: [Qemu-devel] [PATCH v2 10/29] vvfat: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org, "open list:vvfat" <qemu-block@nongnu.org>, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m40CrhB2HjXb82kcqH8wUxTQukcC01UUl
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org,
 "open list:vvfat" <qemu-block@nongnu.org>, qemu-trivial@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <873282ab-9f53-6a48-c644-280ebf0e1a81@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 10/29] vvfat: use DIV_ROUND_UP
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
 <20170713163219.9024-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170713163219.9024-11-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/13/2017 11:32 AM, Marc-Andr=C3=A9 Lureau wrote:
> I used the clang-tidy qemu-round check to generate the fix:
> https://github.com/elmarco/clang-tools-extra
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  block/vvfat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 4fd28e1e87..c08c4fb525 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -437,7 +437,7 @@ static direntry_t *create_long_filename(BDRVVVFATSt=
ate *s, const char *filename)
>          return NULL;
>      }
> =20
> -    number_of_entries =3D (length * 2 + 25) / 26;
> +    number_of_entries =3D DIV_ROUND_UP(length * 2, 26);

Wow - a non-power-of-2!  Good thing our macro works for that.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--m40CrhB2HjXb82kcqH8wUxTQukcC01UUl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZ9ZIAAoJEKeha0olJ0NqCIAH/j/Ip3fzG4cwA0j1YnlSGSwK
QNhAcoGuI53jkZh/b6b2y7msSlw1Y/qTb1heIveLwpHIKN/xiyJeNdHxMXil/nZN
DBo6BXkcBr9RXJ7p2DNFnRzNSjwr0lV4eXnUzG33lH+bHaY72PK4YqflaZ5TiV+g
Sj5v0yYd1oQ9IhTR3F0SAJ6hx4H30PmoMURiJ/2a4L4AqekJdAh01yW72eGFYY4G
HZRdFC7iHWx84Olq9VirQbaYG/k+kwzkcTDZBqKq+KkAAC+MICAoUKumWBrmhSMO
VvyAnFNMYNxSAFyd3SypKEdEORJ/2u7YZjkAx4OJilJWz4i+5ZnyKGumvBlb/Uo=
=/yS+
-----END PGP SIGNATURE-----

--m40CrhB2HjXb82kcqH8wUxTQukcC01UUl--
