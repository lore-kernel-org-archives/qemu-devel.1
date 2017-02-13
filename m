Received: from eggs.gnu.org ([2001:4830:134:3::10]:49768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd8Ra-0002Qp-Es
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 23:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd8RX-00026R-D6
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 23:40:54 -0500
Date: Mon, 13 Feb 2017 15:33:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170213043351.GU25381@umbus>
References: <1486704360-27361-1-git-send-email-sjitindarsingh@gmail.com>
	<1486704360-27361-9-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qpPEP5KwiTnADq8L"
Content-Disposition: inline
In-Reply-To: <1486704360-27361-9-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V2 08/10] target/ppc/POWER9: Add
 POWER9 pa-features definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com


--qpPEP5KwiTnADq8L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2017 at 04:25:58PM +1100, Suraj Jitindar Singh wrote:
> Add a pa-features definition which includes all of the new fields which
> have been added, note we don't claim support for any of these new features
> at this stage.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 057adae..44eb014 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -356,6 +356,20 @@ static void spapr_populate_pa_features(CPUPPCState *=
env, void *fdt, int offset)
>          0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
>          0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
>          0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
> +    /* Currently we don't advertise any of the "new" ISAv3.00 functional=
ity */
> +    uint8_t pa_features_300[] =3D { 64, 0,
> +        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0, /*  0 -  5 */
> +        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /*  6 - 11 */
> +        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
> +        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 24 - 29 */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 30 - 35 */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 36 - 41 */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 42 - 47 */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 48 - 53 */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 54 - 59 */
> +        0x00, 0x00, 0x00, 0x00           }; /* 60 - 63 */
> +
>      uint8_t *pa_features;
>      size_t pa_size;
> =20
> @@ -370,6 +384,10 @@ static void spapr_populate_pa_features(CPUPPCState *=
env, void *fdt, int offset)
>          pa_features =3D pa_features_207;
>          pa_size =3D sizeof(pa_features_207);
>          break;
> +    case POWERPC_MMU_3_00:
> +        pa_features =3D pa_features_300;
> +        pa_size =3D sizeof(pa_features_300);
> +        break;
>      default:
>          return;
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qpPEP5KwiTnADq8L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYoTcuAAoJEGw4ysog2bOS818QAKFEuw4CD2YQvC+syQR3Tkkt
fc2TRvEezObG64+6nnIfaeE7fMUbTNwwrtegNOZSEXDTEgX2jJEVENZIYUpenPOw
30WG4cmshxlD+/6JQE/zZj25rPy+aE4lZGu9KGq3jBjA5TB5pT9+xDu3Q43A8jNy
7Ea/o2F+wKAwsetKp9cW892khP3ipeswUTssUpRXYz7ZSmkYnq3w8hEZhnqnN4/t
CsUEsFEdvlgdbb38OjhS8Y5KHBc0KlNzVWl6yASggcMyaS5HSQ3ByiJTMIdcjIVf
sn6muVhry3oTvle5h2+ZV0Mx9FiXLdjg8oeqhoDW8IftF4KC7vMoQm2gMInTT2ey
/i3qUma9dSYuv4ODG59szwSLnU0bWb9aI6wIdqhdNY4dbwItwf+WsEPPne32s1Yh
duYs3fuNgTTCH4GAXfLNsbdR7neWJVd4wZHvYBvHHD/C7COeAgWnAqVE1/4wtl1g
qNobPiWUFm/vhOC4PV1XMy/DMQqaVm1bYCPQEAr8Mayk/e5iuVXzqZzRnwwZak1T
0vtP5/8C8Uor1EDgcF1ZBjAYt2zvrXpIUbcb38BgbxltxPk9B3nlBRb4HvEQGec1
Qb0u+w/wbumDgh7xGcfdIFQzdhd93zH0aLEx4yAYN2aZBo70n+z6JIGTOkR4SQUK
DizVl28Cr1pea9dRcrqY
=486o
-----END PGP SIGNATURE-----

--qpPEP5KwiTnADq8L--
