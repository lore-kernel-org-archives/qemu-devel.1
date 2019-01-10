Received: from eggs.gnu.org ([209.51.188.92]:49098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ghc0Z-0000SF-B2
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:12:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ghc0T-0004GO-R9
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:12:35 -0500
References: <20190108163008.7006-1-peter.maydell@linaro.org>
	<20190108163008.7006-2-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <3b738c7c-f42e-24c3-c8f6-74695e62c1dd@greensocs.com>
Date: Thu, 10 Jan 2019 16:11:55 +0100
MIME-Version: 1.0
In-Reply-To: <20190108163008.7006-2-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="09mHiv8vIxoM7oU6FU2Hqz2za2XihTaja"
Subject: Re: [Qemu-devel] [PATCH 1/4] hw/arm/xlx-zynqmp: Realize cluster
 after putting RPUs in it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Richard Henderson <richard.henderson@linaro.org>, "Emilio G . Cota" <cota@braap.org>, patches@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--09mHiv8vIxoM7oU6FU2Hqz2za2XihTaja
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Emilio G . Cota" <cota@braap.org>, patches@linaro.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3b738c7c-f42e-24c3-c8f6-74695e62c1dd@greensocs.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] hw/arm/xlx-zynqmp: Realize cluster after
 putting RPUs in it
References: <20190108163008.7006-1-peter.maydell@linaro.org>
 <20190108163008.7006-2-peter.maydell@linaro.org>
In-Reply-To: <20190108163008.7006-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/8/19 5:30 PM, Peter Maydell wrote:
> Currently the cluster implementation doesn't have any constraints
> on the ordering of realizing the TYPE_CPU_CLUSTER and populating it
> with child objects. We want to impose a constraint that realize
> must happen only after all the child objects are added, so move
> the realize of rpu_cluster. (The apu_cluster is already
> realized after child population.)
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/arm/xlnx-zynqmp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index c67ac2e64ac..370b0e44a38 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -183,8 +183,6 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState =
*s, const char *boot_cpu,
>                              &error_abort, NULL);
>      qdev_prop_set_uint32(DEVICE(&s->rpu_cluster), "cluster-id", 1);
> =20
> -    qdev_init_nofail(DEVICE(&s->rpu_cluster));
> -
>      for (i =3D 0; i < num_rpus; i++) {
>          char *name;
> =20
> @@ -212,6 +210,8 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState =
*s, const char *boot_cpu,
>              return;
>          }
>      }
> +
> +    qdev_init_nofail(DEVICE(&s->rpu_cluster));
>  }
> =20
>  static void xlnx_zynqmp_init(Object *obj)
>=20


--09mHiv8vIxoM7oU6FU2Hqz2za2XihTaja
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlw3YLsACgkQd8knW3Qn
Tr5kpg//cZoxzFT5RgRq3XXiIL6xAX3Z3Spe8Ej15z66iu5UwhCdDnNiPFY5+vH3
3TqqR8WxQJYWSJ6oBFQm4ptHHqhxIw9eVWd4+J91xl76OJ3VvckK5QkoaiWA0tiE
0BNTUNRShckoAHJVj3/PnoyeqwFiUt45KBtTRZORnygi54bgdEZ2ysO0z6FKkqhS
YAEtqDqVDqey9dj3UK5vA7EPqvpZejjbT5aqKsbRVVuCQxzFjz5j2gG4MsVt7Vpo
20aJPnqHDr106Mu7Pi2Xc5yEHU1d7mpXNZHCJpxbtceIFOBC6mhMLsS0JdKrN1FI
PXDOFVcrYKk5QqFaIuldh7/DR+3uXLv0Y73JhcJ0Ot3MIKutR/wkuCwNpD+5A/G9
txL6Hy1XDAwVeI0rWJIz+meru0OpG9a3uHEsyI8bjeuRsXLPwPwPaxsWk6VjeOiY
sibYxQnfo1cRhRsLXDVwdC24MReElGZI3MxPFYAbqqPprxQkGT+urnSG9rkDiRED
WqzB0MKKHEDLhWPMXB9tyxiwn4TPPi1eu0avAx7U8MLbF+C/+4zCwiT8Oz6ZnhUO
4Swek/udAgMiLtS0dNHLlnkkEiOtNgrIPp00yR8tL8jR15FHjh0qdiTZeGAsWgfG
OQKQjgk6fYD3G3oK2yHHd2o3zwlBcENxAAj7B56E+1XOM7y6zdI=
=42BG
-----END PGP SIGNATURE-----

--09mHiv8vIxoM7oU6FU2Hqz2za2XihTaja--
