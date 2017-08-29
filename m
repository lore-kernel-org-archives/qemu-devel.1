Received: from eggs.gnu.org ([2001:4830:134:3::10]:57686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmo2E-0000xo-RC
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmo2D-0005yh-QG
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:26:58 -0400
References: <cover.1503580370.git.berto@igalia.com>
	<763ffc40a26b17d54cf93f5a999e4656049fcf0c.1503580370.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <883c5683-97e6-d08f-4c90-803e53454047@redhat.com>
Date: Tue, 29 Aug 2017 16:26:50 -0500
MIME-Version: 1.0
In-Reply-To: <763ffc40a26b17d54cf93f5a999e4656049fcf0c.1503580370.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1GbhwtSh8SQLmpg4NTpIxFlesOvkAlora"
Subject: Re: [Qemu-devel] [PATCH v2 3/7] throttle: Make throttle_is_valid()
 a bit less verbose
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, Manos Pitsidianakis <el13635@mail.ntua.gr>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1GbhwtSh8SQLmpg4NTpIxFlesOvkAlora
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <883c5683-97e6-d08f-4c90-803e53454047@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/7] throttle: Make throttle_is_valid() a
 bit less verbose
References: <cover.1503580370.git.berto@igalia.com>
 <763ffc40a26b17d54cf93f5a999e4656049fcf0c.1503580370.git.berto@igalia.com>
In-Reply-To: <763ffc40a26b17d54cf93f5a999e4656049fcf0c.1503580370.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 08:24 AM, Alberto Garcia wrote:
> Use a pointer to the bucket instead of repeating cfg->buckets[i] all
> the time. This makes the code more concise and will help us expand the
> checks later and save a few line breaks.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  util/throttle.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>=20
> diff --git a/util/throttle.c b/util/throttle.c
> index 9a6bda813c..bde56fe3de 100644
> --- a/util/throttle.c
> +++ b/util/throttle.c
> @@ -324,32 +324,31 @@ bool throttle_is_valid(ThrottleConfig *cfg, Error=
 **errp)
>      }
> =20
>      for (i =3D 0; i < BUCKETS_COUNT; i++) {
> -        if (cfg->buckets[i].avg < 0 ||
> -            cfg->buckets[i].max < 0 ||
> -            cfg->buckets[i].avg > THROTTLE_VALUE_MAX ||
> -            cfg->buckets[i].max > THROTTLE_VALUE_MAX) {
> +        LeakyBucket *bkt =3D &cfg->buckets[i];
> +        if (bkt->avg < 0 || bkt->max < 0 ||

Up to the maintainer, but I'd include a blank line between declarations
and code.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1GbhwtSh8SQLmpg4NTpIxFlesOvkAlora
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlml3BoACgkQp6FrSiUn
Q2q3Kgf/Xdt3QfpUcdgaKNYdleim8dGVpU6cph1ghY+n8vhfHKAea4vFw6HwGtsS
vu7Rbb5umbKuhaX12PIFkFi9zlRJslO8t4D5eWIYcDCdtbNxl1iSxZpDPUKzVHSP
UvzAajRxIwHbTuzJHWPg28+AOoVPVz0pBawYcoKRWb8y35SUokhKvHE0TUoJuFUk
HUcnOtzvjs2jYXt1xpLXYydS10kmzB84CfukuO0aK20uytuEoPVhGedDFr2kYZQ2
jqukAMJ7K1wvvAWSJjf0l8q0qQ8EhF7pzvNhx27RC/P6cChQpcoSXrNC9C94bsjr
WcIWWczW1h4WbWjMQTaECwrlkbQ9Ig==
=yZb0
-----END PGP SIGNATURE-----

--1GbhwtSh8SQLmpg4NTpIxFlesOvkAlora--
