Received: from eggs.gnu.org ([208.118.235.92]:57807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geYK4-0001jt-Ek
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 23:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geYK1-0007o2-5E
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 23:40:04 -0500
Date: Wed, 2 Jan 2019 15:15:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190102041529.GO27457@umbus.fritz.box>
References: <cover.1546394798.git.balaton@eik.bme.hu>
	<1d0a75ac8b76ba8d070c3c1c01bad04ca2b13e26.1546394798.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9DptZICXTlJ7FQ09"
Content-Disposition: inline
In-Reply-To: <1d0a75ac8b76ba8d070c3c1c01bad04ca2b13e26.1546394798.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 5/8] ppc4xx: Rename ppc4xx_sdram_t in
 ppc440_uc.c to ppc440_sdram_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--9DptZICXTlJ7FQ09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 03:06:38AM +0100, BALATON Zoltan wrote:
> There's already a struct with the same name in ppc4xx_devs.c. They are
> not used outside their files so don't clash but they are also not
> identical so rename the ppc440 specific one to distinguish them.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/ppc440_uc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> index 9360f781ce..e46f59fba8 100644
> --- a/hw/ppc/ppc440_uc.c
> +++ b/hw/ppc/ppc440_uc.c
> @@ -481,7 +481,7 @@ void ppc4xx_sdr_init(CPUPPCState *env)
> =20
>  /***********************************************************************=
******/
>  /* SDRAM controller */
> -typedef struct ppc4xx_sdram_t {
> +typedef struct ppc440_sdram_t {
>      uint32_t addr;
>      int nbanks;
>      MemoryRegion containers[4]; /* used for clipping */
> @@ -489,7 +489,7 @@ typedef struct ppc4xx_sdram_t {
>      hwaddr ram_bases[4];
>      hwaddr ram_sizes[4];
>      uint32_t bcr[4];
> -} ppc4xx_sdram_t;
> +} ppc440_sdram_t;
> =20
>  enum {
>      SDRAM0_CFGADDR =3D 0x10,
> @@ -564,7 +564,7 @@ static target_ulong sdram_size(uint32_t bcr)
>      return size;
>  }
> =20
> -static void sdram_set_bcr(ppc4xx_sdram_t *sdram,
> +static void sdram_set_bcr(ppc440_sdram_t *sdram,
>                            uint32_t *bcrp, uint32_t bcr, int enabled)
>  {
>      unsigned n =3D bcrp - sdram->bcr;
> @@ -589,7 +589,7 @@ static void sdram_set_bcr(ppc4xx_sdram_t *sdram,
>      }
>  }
> =20
> -static void sdram_map_bcr(ppc4xx_sdram_t *sdram)
> +static void sdram_map_bcr(ppc440_sdram_t *sdram)
>  {
>      int i;
> =20
> @@ -607,7 +607,7 @@ static void sdram_map_bcr(ppc4xx_sdram_t *sdram)
> =20
>  static uint32_t dcr_read_sdram(void *opaque, int dcrn)
>  {
> -    ppc4xx_sdram_t *sdram =3D opaque;
> +    ppc440_sdram_t *sdram =3D opaque;
>      uint32_t ret =3D 0;
> =20
>      switch (dcrn) {
> @@ -658,7 +658,7 @@ static uint32_t dcr_read_sdram(void *opaque, int dcrn)
> =20
>  static void dcr_write_sdram(void *opaque, int dcrn, uint32_t val)
>  {
> -    ppc4xx_sdram_t *sdram =3D opaque;
> +    ppc440_sdram_t *sdram =3D opaque;
> =20
>      switch (dcrn) {
>      case SDRAM_R0BAS:
> @@ -689,7 +689,7 @@ static void dcr_write_sdram(void *opaque, int dcrn, u=
int32_t val)
> =20
>  static void sdram_reset(void *opaque)
>  {
> -    ppc4xx_sdram_t *sdram =3D opaque;
> +    ppc440_sdram_t *sdram =3D opaque;
> =20
>      sdram->addr =3D 0;
>  }
> @@ -699,7 +699,7 @@ void ppc440_sdram_init(CPUPPCState *env, int nbanks,
>                         hwaddr *ram_bases, hwaddr *ram_sizes,
>                         int do_init)
>  {
> -    ppc4xx_sdram_t *sdram;
> +    ppc440_sdram_t *sdram;
> =20
>      sdram =3D g_malloc0(sizeof(*sdram));
>      sdram->nbanks =3D nbanks;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9DptZICXTlJ7FQ09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwsOuAACgkQbDjKyiDZ
s5LyTQ/+Ok+vltqIEhCqiHr1jW06XPQHxyLOw/vyI5z42eE/7EhU5wZumAjXTnpn
FVdGE1YGtjrClvV2gcTX6+30FKG6seDOM7qEdh8MEDlof7ysKGAyOEMAdUmk83yA
cDJuJeVypUBUZcnGytZzDcNoKU+1H+/KXIrSgtMulOjZYiyyvqWkIIwHGdcOfcU7
8hV5YvcYVl9YLBOQlFuuzHYCnMnlEwGujiHce6lAg3n7bwKVPY5HUg0qb2aBJqY8
cxbq2HdddoJSHE5ycDcG3/ZXIs1c+KwqzK/JXSxAnNi68Sc5mf1I9WMnAT9+Nubl
Unfh4lm/iYBN1h0KEUVkYE4C8TT2XxTm2yJECfHZTPUE6d5X9C0BwNbeRvbTnIun
/fJnUX2zjlLSeGsmFCQclVrIgLKJJloauP7dhkIdPG0TeqYPEY2c/jRwU7pl21wS
6dr8ivBOWMFn8kvjN9h8kfH2oBfNFKWJIvbhqqZc/9RRn/mCFj9zoNTsy+Jlon+2
5mP8ds3CxhodgOq0PADXW6i4WfvGuqaQBRCzqq8SL5JZYipdfhfdJn0JYPqKZZl7
6hqJcKMqtyh/ZcERTSY78KccK01X0m6SJoeeQ/DvpiJigBLrh8wH2dY/TAaKty7k
ja89j9NidV8YtBZHcP/TufU5hnNpOzcS/wx60+a3LLhSMnDoRF4=
=oFFr
-----END PGP SIGNATURE-----

--9DptZICXTlJ7FQ09--
