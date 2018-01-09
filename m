Received: from eggs.gnu.org ([2001:4830:134:3::10]:51992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYwSN-00068k-12
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYwSM-00020o-2v
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:08:54 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1515506513-31961-1-git-send-email-peter.maydell@linaro.org>
	<1515506513-31961-3-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c83ab7dd-bbee-827d-bc63-af0f76740da7@amsat.org>
Date: Tue, 9 Jan 2018 13:08:41 -0300
MIME-Version: 1.0
In-Reply-To: <1515506513-31961-3-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="IY3uBVR4zRIgfTyeVhjqNaxNLgAPLWTyX"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/4] hw/sd/milkymist-memcard:
 Reset SD card on controller reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IY3uBVR4zRIgfTyeVhjqNaxNLgAPLWTyX
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, patches@linaro.org
Message-ID: <c83ab7dd-bbee-827d-bc63-af0f76740da7@amsat.org>
Subject: Re: [Qemu-arm] [PATCH 2/4] hw/sd/milkymist-memcard: Reset SD card on
 controller reset
References: <1515506513-31961-1-git-send-email-peter.maydell@linaro.org>
 <1515506513-31961-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515506513-31961-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 01/09/2018 11:01 AM, Peter Maydell wrote:
> Since pl181 is still using the legacy SD card API, the SD

pl181 -> milkymist-memcard ;)

> card created by sd_init() is not plugged into any bus. This
> means that the controller has to reset it manually.
>=20
> Failing to do this mostly didn't affect the guest since the
> guest typically does a programmed SD card reset as part of
> its SD controller driver initialization, but meant that
> migration failed because it's only in sd_reset() that we
> set up the wpgrps_size field.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/sd/milkymist-memcard.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
> index 4008c81..341da88 100644
> --- a/hw/sd/milkymist-memcard.c
> +++ b/hw/sd/milkymist-memcard.c
> @@ -248,6 +248,10 @@ static void milkymist_memcard_reset(DeviceState *d=
)
>      for (i =3D 0; i < R_MAX; i++) {
>          s->regs[i] =3D 0;
>      }
> +    /* Since we're still using the legacy SD API the card is not plugg=
ed
> +     * into any bus, and we must reset it manually.
> +     */
> +    device_reset(DEVICE(s->card));
>  }
> =20
>  static int milkymist_memcard_init(SysBusDevice *dev)
>=20


--IY3uBVR4zRIgfTyeVhjqNaxNLgAPLWTyX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpU6QkACgkQ4+MsLN6t
wN7inRAA0vHnpYGVr3WpI+V830Zg+UyT1YrGflJGqvsfdYmwbJJR1Z2Eig3vNHZW
bTcYZi1BMCKR8SWbHhjDmQ8hcMT4oH3h81CZtvoKX+ycc2bafGpTlp6XfbDzwl9z
t4b32dxnnpdtTaFUQtRPHbFQcz+jOyDXmZ4mO50pncN5k3u5AD8Wzu6M6/KO7Vgt
+6JZSQFPz8HDOQgv3HgW9fOXOi7wuu+GDxzGfMG/1EyJNr5UbZV1Y0R86lUIJBsY
khIo/iGGlUcyQJBT4CA7Zmlr12r23YXMAmb+TiXzvfK9+FEetnFd7zZiPjBJyOxQ
c2CZCF5/Sy/UVAkEXqBnOF0uCi5FndWMqta77fmsBpKH1zaEiSioQf3UX3ieY+bM
CvB1dQXE8rpAEzm/T50PP/6dvZGJc3GrwYBx72JyOgqhAIZNHHVvToYa6lPLo/bW
B4V4aZPeHoBDJ3FtEbGPLQkmw4dwFx1Eud0lrArteDsHUjoLAEK5UDiWthd3CyVo
vDagCdUudNmaa7kwo0qI+kASprAJ2588ArC5RYbKiQdzmGiMSBSyiBbUn97MO+xL
Xcbipqn7eG+wIXC8XCbnsTzQM7v9mDK/GRektefIM5kGFpnFYFfGk/Al3qwoDPV6
++pjtxo2fw5l5EPS/k0RYpl86Bh33912Bwy9t5IZSqoxV1Roefs=
=Rpm6
-----END PGP SIGNATURE-----

--IY3uBVR4zRIgfTyeVhjqNaxNLgAPLWTyX--
