Received: from eggs.gnu.org ([2001:4830:134:3::10]:40835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbShP-0007v1-La
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:54:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbShK-0002xT-86
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:54:19 -0500
References: <20170208080900.4092-1-marcandre.lureau@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <58a6feee-8828-d159-daf9-b460a6c0c7c4@redhat.com>
Date: Wed, 8 Feb 2017 14:54:10 +0100
MIME-Version: 1.0
In-Reply-To: <20170208080900.4092-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bUdXavUBbbQPOfDvjod3tAO3tBkAaD3wE"
Subject: Re: [Qemu-devel] [PATCH] qcow2: remove useless NULL check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bUdXavUBbbQPOfDvjod3tAO3tBkAaD3wE
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-trivial@nongnu.org
Message-ID: <58a6feee-8828-d159-daf9-b460a6c0c7c4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: remove useless NULL check
References: <20170208080900.4092-1-marcandre.lureau@redhat.com>
In-Reply-To: <20170208080900.4092-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.02.2017 09:09, Marc-Andr=C3=A9 Lureau wrote:
> g_strdup() already handles the case where the argument is NULL.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  block/qcow2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 96fb8a8f16..9114218030 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2016,8 +2016,8 @@ static int qcow2_change_backing_file(BlockDriverS=
tate *bs,
>      g_free(s->image_backing_file);
>      g_free(s->image_backing_format);
> =20
> -    s->image_backing_file =3D backing_file ? g_strdup(bs->backing_file=
) : NULL;
> -    s->image_backing_format =3D backing_fmt ? g_strdup(bs->backing_for=
mat) : NULL;
> +    s->image_backing_file =3D g_strdup(bs->backing_file);
> +    s->image_backing_format =3D g_strdup(bs->backing_format);

bs->backing_file and bs->backing_format are arrays. They will never be NU=
LL.

The ternary operator tests backing_file and backing_fmt which instead
are pointers. So this is not an equivalent conversion.

Max

> =20
>      return qcow2_update_header(bs);
>  }
>=20



--bUdXavUBbbQPOfDvjod3tAO3tBkAaD3wE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlibIwISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AbcUIAIlKr9DwOEPllHrl+mxot3CwLSfzS4lV
dlgqj84NIeqdaKJmqA1z1+2zj7QhZsO6ZXiH4vbfGZY4vN0u/vdeBc5M/6h4B9ut
rmJqnVLycSi1aJ1Ar0J1gxhRenkcGa1CzskhWIWTMzTVp5a4ulZctW00a2RFUdDa
bokFc36KAvYoPA6vowyRAewr6438fDBP8RNBmbQ4x1Qrjya5/5qRB53b0iRdwuiK
02o0p25JKKS0DZMWzlMpiy927tReuDffY6fOmqxTCMIKhRhekDM23pfzQVf4u0Zz
OkaI82a/Snrtmnkhxjvr1Cf1/Z/xs5FTiEiWzV1COHd+iIQ2ZkP9Q2E=
=w3B5
-----END PGP SIGNATURE-----

--bUdXavUBbbQPOfDvjod3tAO3tBkAaD3wE--
