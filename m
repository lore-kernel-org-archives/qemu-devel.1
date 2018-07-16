Received: from eggs.gnu.org ([2001:4830:134:3::10]:59168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fewPY-0006ER-TA
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 01:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fewPX-0001s6-WB
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 01:51:04 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52167)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fewPW-0001r3-UD
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 01:51:03 -0400
Date: Mon, 16 Jul 2018 14:26:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180716042626.GI2599@umbus.fritz.box>
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
	<20180705182001.16537-11-mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pe+tqlI1iYzVj1X/"
Content-Disposition: inline
In-Reply-To: <20180705182001.16537-11-mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 10/14] timer: ds1338 remove vestige of
 un-modeled OSF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, qemu-devel@nongnu.org


--pe+tqlI1iYzVj1X/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2018 at 11:19:57AM -0700, Michael Davidsaver wrote:
> Oscillator stop has never been modeled, so the
> Oscillator Stop Flag can never be set.
>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/timer/ds-rtc.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/timer/ds-rtc.c b/hw/timer/ds-rtc.c
> index 3c5781d53c..126566ce1f 100644
> --- a/hw/timer/ds-rtc.c
> +++ b/hw/timer/ds-rtc.c
> @@ -21,8 +21,6 @@
>   */
>  #define NVRAM_SIZE 64
> =20
> -#define CTRL_OSF   0x20
> -
>  #define TYPE_DSRTC "ds1338"
>  #define DSRTC(obj) OBJECT_CHECK(DSRTCState, (obj), TYPE_DSRTC)
> =20
> @@ -216,13 +214,11 @@ static int dsrtc_send(I2CSlave *i2c, uint8_t data)
>      if (s->ptr =3D=3D R_CTRL) {
>          /* Control register. */
> =20
> -        /* Ensure bits 2, 3 and 6 will read back as zero. */
> -        data &=3D 0xB3;
> -
> -        /* Attempting to write the OSF flag to logic 1 leaves the
> -           value unchanged. */
> -        data =3D (data & ~CTRL_OSF) | (data & s->nvram[s->ptr] & CTRL_OS=
F);
> -
> +        /* Allow guest to set no-op controls for clock out pin and
> +         * rate select.  Ignore write 1 to clear OSF.  We don't model
> +         * oscillator stop, so it is never set.
> +         */
> +        data =3D data & 0x93;
>      }
>      s->nvram[s->ptr] =3D data;
>      if (s->ptr <=3D R_YEAR) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pe+tqlI1iYzVj1X/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltMHnEACgkQbDjKyiDZ
s5Kmzg/9E1vQlA/HRgrnGG3B5x0gzPJGTdtcn5sSWp1Gqq7CljVdEOx1Y4tdaGNP
SAt5/quBSSt9bE+Vv8GYmBHA+U9fGEgu4SWjc2Ylj/fhiZm9I5dLOGgxDKa/T971
44vh5ZneKe3Moc6a1X/JA2rvS8BKMi4I12s9cdiJ1LMqfQ3LkoH7GQVBLhoWnmhe
4jFbhf6HlwLQI85dAcXCoaL2zJvPTNSLHqgXoO+gB1BvWTibybRDVvscyRdpWpo+
cuqbznV/7XuV1zHjt73E+vvCkLDav0f5GVmdP5lZ1tf1Wncn6/3F1wXr4U7CuPNj
Hj8GH5YndvkBF7DnIXSH/mvmOhCR9FMtjx+n+3TbdbSIhHvI5dFrY2hUT1a9ugml
ZA1WnWrDYD8Ci1MAW5amFjdZfJg+5Mso8NqGQyWCLr5mLTu86OWARHCjJivZhRCm
TUZj+0yMCv31A9Irtmv8t+RmYxDI98Rd03omqMoEbA9ZL8t6rcO6KXg8G4cvR5um
E890s9JhLVRx17hIMdBcFKDFp+7fpDGEiV0QmCnAyVGpTI9kaIrqR2iTVsom0Wrm
XNDEcO+c5qgP7pssbVIVLOFJ3IWurb7GOk1M4/8+oeYrh33qeCA08yyj0Z01V5Cs
Mu1Yrgqnohlkhn4+Za8XlFbxO448bhTvS1xY9Ee76o426oZxXck=
=5szw
-----END PGP SIGNATURE-----

--pe+tqlI1iYzVj1X/--
