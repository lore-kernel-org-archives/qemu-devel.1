Received: from eggs.gnu.org ([2001:4830:134:3::10]:52774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fN1qy-0007QP-7b
	for qemu-devel@nongnu.org; Sun, 27 May 2018 16:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fN1qu-0006W5-Ff
	for qemu-devel@nongnu.org; Sun, 27 May 2018 16:01:19 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:40639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fN1qu-0006Vo-7a
	for qemu-devel@nongnu.org; Sun, 27 May 2018 16:01:16 -0400
Received: by mail-qk0-x244.google.com with SMTP id r66-v6so7809445qkr.7
	for <qemu-devel@nongnu.org>; Sun, 27 May 2018 13:01:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180525045344.28347-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <394911d0-fc40-33c3-1871-19b4b9b2c9c5@amsat.org>
Date: Sun, 27 May 2018 17:01:08 -0300
MIME-Version: 1.0
In-Reply-To: <20180525045344.28347-1-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="OVGSQwbultk51bdzFExgeK0OSCH1OmaNg"
Subject: Re: [Qemu-devel] [PATCH] bochs-display: add missing break
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OVGSQwbultk51bdzFExgeK0OSCH1OmaNg
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Message-ID: <394911d0-fc40-33c3-1871-19b4b9b2c9c5@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] bochs-display: add missing break
References: <20180525045344.28347-1-kraxel@redhat.com>
In-Reply-To: <20180525045344.28347-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/25/2018 01:53 AM, Gerd Hoffmann wrote:
> Fixes: CID 1391291
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/bochs-display.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
> index c33524b558..1187d77576 100644
> --- a/hw/display/bochs-display.c
> +++ b/hw/display/bochs-display.c
> @@ -158,6 +158,7 @@ static int bochs_display_get_mode(BochsDisplayState=
 *s,
>          /* best effort: support native endianess only */
>          mode->format =3D PIXMAN_r5g6b5;
>          mode->bytepp =3D 2;
> +        break;

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

>      case 32:
>          mode->format =3D s->big_endian_fb
>              ? PIXMAN_BE_x8r8g8b8
>=20


--OVGSQwbultk51bdzFExgeK0OSCH1OmaNg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlsLDoQACgkQ4+MsLN6t
wN605BAAu0NQtO3r6rZO+k9g/Ie/P3mfdoq5pDH+9WJK6427jAgWsCPbk3Dj9VzD
jJLM0eFvtL0kCJVgiadh7Ux09zyh9hu/0wCkS4RSxlTW1YIkwTKTQjqcviMWr9Jt
/xTEOZhYbiX3H5AgfFZZuh28h0OkZ66QM5aRlAIaFpugh+XEtPTkirfskF+hjilU
Z21zTwYFwLZS7Rf14XwTOIVYahm771bE+qJ0CLjyRqnICbzWQS84m6l0+nuyQNNf
C75LwiL5Xd+UDrzcaPQXaVnkfLujddn/etYX7gdn+7jPzTwYY59kaX+T3d9sDx7T
gx+zaau6abckgs9i8EcIaC6TCR9z//r+VQCIzxc7SRFbh//aDbZBxS2r//jl+D6A
OEhXrIJm3L/WdRUGcOUH+aCfMIAkNeYrrC6NgtCv0MPbvmbePH53mdQ5iWKSe536
X7IoNneky9dyd4O4nHQ8hh2Fti26TpLVQPOMWOhoZPht9n0tQvbSEKR7/UI1J7WD
S2Iw3ZwAYVLkg5a7DEBucx2DjWFXj7AfxoWNr1HIx9Ga6oaXZg31IO8/EQjMUvn6
e4VfS7efT/NoiRPsVC13X2iXER0M6gFyzn8aT6u8p//v1DQZ2z7pH6fIomdRcXaH
GVN5VmSTcPueZNcDZAJMhwTaJ8SNHpT1AQIRTko0arACABePYxw=
=Hxxa
-----END PGP SIGNATURE-----

--OVGSQwbultk51bdzFExgeK0OSCH1OmaNg--
