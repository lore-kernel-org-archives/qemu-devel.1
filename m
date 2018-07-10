Received: from eggs.gnu.org ([2001:4830:134:3::10]:51672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fchfw-0004NW-Ch
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 21:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fchft-0004CV-9u
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 21:42:44 -0400
Received: from ozlabs.org ([203.11.71.1]:45481)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fchfs-0004Bp-9s
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 21:42:41 -0400
Date: Tue, 10 Jul 2018 11:32:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180710013212.GK22363@umbus.fritz.box>
References: <20180709172005.5306274569D@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bX/mw5riLlTkt+Gv"
Content-Disposition: inline
In-Reply-To: <20180709172005.5306274569D@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH] sm501: Update screen on frame buffer
 address change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Sebastian Bauer <mail@sebastianbauer.info>


--bX/mw5riLlTkt+Gv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2018 at 07:02:36PM +0200, BALATON Zoltan wrote:
> When the guest changes the address of the frame buffer we need to
> refresh the screen to correctly display the new content. This fixes
> display update problems when changing between screens on AmigaOS.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> This fixes an annoying refresh problem in AmigaOS when changing or
> moving screens. The user could work around it by moving the mouse to
> repaint the screen but if it's possible to get this in before or
> during the freeze that could avoid this problem in the release.
>=20
>  hw/display/sm501.c | 2 ++
>  1 file changed, 2 insertions(+)

Looks like a clear bugfix, so I've applied to ppc-for-3.0.

>=20
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 3661a89..9ab29d3 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -1235,6 +1235,7 @@ static void sm501_disp_ctrl_write(void *opaque, hwa=
ddr addr,
>          if (value & 0x8000000) {
>              qemu_log_mask(LOG_UNIMP, "Panel external memory not supporte=
d\n");
>          }
> +        s->do_full_update =3D true;
>          break;
>      case SM501_DC_PANEL_FB_OFFSET:
>          s->dc_panel_fb_offset =3D value & 0x3FF03FF0;
> @@ -1298,6 +1299,7 @@ static void sm501_disp_ctrl_write(void *opaque, hwa=
ddr addr,
>          if (value & 0x8000000) {
>              qemu_log_mask(LOG_UNIMP, "CRT external memory not supported\=
n");
>          }
> +        s->do_full_update =3D true;
>          break;
>      case SM501_DC_CRT_FB_OFFSET:
>          s->dc_crt_fb_offset =3D value & 0x3FF03FF0;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bX/mw5riLlTkt+Gv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltEDJkACgkQbDjKyiDZ
s5J+DBAAiYjIYn8jS5262+FQm6uPaAf3689wS3YE2R37RyrckYNis4BLPuQoLDJi
KBFim/zIMvozIHSUnN215e1AgFtZw6E1cnC3gaNa19cGBXegiis1nmeQ6yQa2sjK
0HZQbl45fRt8GrcjT0yZHsIdYHoeVeDcZjsyF9Hkk1HFHiT2H+Vb29C/Ace2xqXp
P36Aa6wVnH20S0Jj/rzJAhrh+J26i+mgvYLdcrvHol4UkcyosEoWRNtorksbmViy
BTNRiAe2utDHeN2a+L/TIxXtPRzEZbWTv6Duue8EYbgXS6fLLtdXUvsG6jUbw7wX
7owKy/hciCNIbM42tXh/WziOmWXw0Hup4MrOyggqMR7pml5YVWPTlKocBAjc+LQi
msHgG1ldhRtnUjX4x2WpSF8RVPt2Z6D1XXM8lAtqFqFeoD18XNEVjxZLDloJVGgB
387nS66nsUIfYZIwtYk7cBgp4bzuDZjZd1Q99L+mhH6l7DHHizGkTKm76MJNAbSZ
2gPVeybl20z/gOQ933f253m2yB3CMkd9XSWBrfbaP6JmT8JC8Wvm6b3DvCcM5+C1
uC1qSxXAaz0MHQHwPCIrOo5jys938/q4FhPD2wboayMxRvsIkgGzkj01M6U0qpZw
ShmGkabGXekt/3rgc8JN8vKERIuqoNzFOEVAJuCtYWdkWF+QkgQ=
=PVeU
-----END PGP SIGNATURE-----

--bX/mw5riLlTkt+Gv--
