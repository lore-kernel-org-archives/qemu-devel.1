Received: from eggs.gnu.org ([2001:4830:134:3::10]:41715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHLZK-0005L2-BD
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 22:19:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHLZI-0005O6-Vg
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 22:19:22 -0500
Date: Wed, 22 Nov 2017 13:34:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171122023432.GD2380@umbus.fritz.box>
References: <20171120100347.8601-1-clg@kaod.org>
	<20171120100347.8601-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
In-Reply-To: <20171120100347.8601-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 2/3] spapr/rtas: fix reboot of
 a a SMP TCG guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2017 at 11:03:46AM +0100, C=E9dric Le Goater wrote:
> Just like for hot unplug CPUs, when a guest is rebooted, the secondary
> CPUs can be awaken by the decrementer and start entering SLOF at the
> same time the boot CPU is.
>=20
> To be safe, let's disable on the secondaries all the exceptions which
> can cause an exit while the CPU is in power-saving mode.
>=20
> Based on previous work from Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

but not applying pending an update on 1/3.

> ---
>=20
> Changes in v3:
>=20
>  - used the cpu_ppc_papr_pece_bits() helper=20
>=20
>  hw/ppc/spapr_cpu_core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 3a4c17401226..4ba8563d49e4 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -35,6 +35,13 @@ static void spapr_cpu_reset(void *opaque)
>      cs->halted =3D 1;
> =20
>      env->spr[SPR_HIOR] =3D 0;
> +
> +    /* Disable Power-saving mode Exit Cause exceptions for the CPU.
> +     * This can cause issues when rebooting the guest if a secondary
> +     * is awaken */
> +    if (cs !=3D first_cpu) {
> +        env->spr[SPR_LPCR] &=3D ~cpu_ppc_papr_pece_bits(env);
> +    }
>  }
> =20
>  static void spapr_cpu_destroy(PowerPCCPU *cpu)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloU4jgACgkQbDjKyiDZ
s5Knig/9FCuUkUiKPOFIXoItJXr+N+3tCmHrtSp9h2RnH3gG1FFB+sRUumqjX7cP
oxXQfEkl3PW3HPg6+P67woNI2iRsdFVBprapKNfjz9/DObDC2m3Rg7AZij5NF54R
0X4OYBCNJVl5pO2BnpblFRJ+0BPZlfC8kiYUSX8FXUGzm8ow1x/2fWD3My8H2oTK
pTcCMTYqDcOKHMmT6Kb6AxJbORaV0IhXb4w2vjXgnMbkmcihUOgpX3XY0+ko2908
xT/f7n428Nu6qxiwJn3U9H2dUbXp9D5+p+YueregHapyZkm3swY39a/hfGkyNpgX
I64nxkxkVwPdMN18L0QD+GGaqJ3dT6ihIujy7LoOaUXyrxcTcotXyXjlSxvr5bAw
IAw6vCi5q6oCYPJYuprHq1/Pyv0eG3nIHo8DjulrqlTwDb0BPHq9Tux31o+yQ9NI
ZcIMyX3fjCHuxi1OAUnuSdYw5pSLJ9jvSbNzIaojT9DIDpgHieDRKnmn8ok4Qvug
hIAP825nBmcCw1Y8nwOJkCoJZwTgdU5rYciUyjy+7JKdIX2X4tObquGVyeig7f/y
04ViWNiOCroGJLw99nkZVsKNk+kr94kGg78jo1Ma5y6pWMiy4YgFpBqhrqjgh3P9
rdaYrB9g+8UEdEyRIz6DaqM1VLYb5tQlOrWJheRKswav/AKV1iY=
=Ehsh
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
