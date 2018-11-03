Received: from eggs.gnu.org ([2001:4830:134:3::10]:41999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gJ91J-0007B9-6Y
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 23:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gJ91I-0002kF-8k
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 23:24:13 -0400
Date: Sat, 3 Nov 2018 12:59:03 +0000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181103125903.GC24365@umbus.hotspot.internet-for-guests.com>
References: <20181101161758.12300-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <20181101161758.12300-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-3.1] hw/ppc/mac_newworld: Free
 openpic_irqs array after use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2018 at 04:17:58PM +0000, Peter Maydell wrote:
> In ppc_core99_init(), we allocate an openpic_irqs array, which
> we then use to collect up the various qemu_irqs which we're
> going to connect to the interrupt controller. Once we've
> called sysbus_connect_irq() to connect them all up, the
> array is no longer required, but we forgot to free it.
>=20
> Since board init is only run once at startup, the memory
> leak is not a significant one.
>=20
> Spotted by Coverity: CID 1192916.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Applied, thanks.

> ---
>  hw/ppc/mac_newworld.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index a630cb81cd8..14273a123e5 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -303,6 +303,7 @@ static void ppc_core99_init(MachineState *machine)
>              sysbus_connect_irq(s, k++, openpic_irqs[i][j]);
>          }
>      }
> +    g_free(openpic_irqs);
> =20
>      if (PPC_INPUT(env) =3D=3D PPC_FLAGS_INPUT_970) {
>          /* 970 gets a U3 bus */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvdm5cACgkQbDjKyiDZ
s5Iq2RAAxFeIlbBgigT8K6GB4tvwsZOgEDhFn3fm4T2QsL8Rw0E5VbkWHVww/VpP
gKnqzqvg75fnKhklupO2S4llXW5tSSjm5wZuRDWpef1kGCSXsgdAtKAONGgllFUi
zwIwr9hCWlNKG9Z1lM5Xf9C2Cs1lBdbC3EZmgZT5obHv277iV6vuyXS6LQ8jDpS1
N3P+nD/js5OH4Of2UxjyDDPjP4m01F9nV6caHiLDDtZYkG/fq56AnRyZkuvIiaBj
jtgX34sz5ggsG91UYDQIdbffbGYob3HoTZWsBMAzErYUo+NsITyF+jOUk+jcLhQP
cNb4sumIPO/CTqhTxBBclq6Ngep/XlePsHqx6lwZ1ar/vygjBwg5cIln6Ow+1Fo8
E/WkjUg2ofCLN9MqqQ0amlL+BCQnD+OsY/tEgji0eSgpuNheRfTw7g5X4aI+M/R5
6KQh1+1CBmgtEvT2BQvApevqcUzkjStKwr1zdLNUdTSjchRPIELXdUN+F5HLqMGy
m5BxViCYxGXUEDn30kSc5CoX1ufqZhAllVUtmXT4uzC8kRyRK5ViBgxDSai6CAHr
A0BLYQrrwz4GPG+9HLHltKVyO/Nkcn0bcJ6fagT5Q5gV1/eKhko/JeLO6u3uoxQc
os5Vy0iat6wIc2WApQsPPYPAOUMk8VUD3R/GbwqQ96zMqeLESeg=
=6FtW
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
