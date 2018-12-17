Received: from eggs.gnu.org ([2001:4830:134:3::10]:49006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gYm4U-0004yv-4I
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 01:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gYm4P-0008Tm-VN
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 01:08:06 -0500
Date: Mon, 17 Dec 2018 17:07:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181217060750.GJ5597@umbus.fritz.box>
References: <20181211223823.13770-1-clg@kaod.org>
	<20181211223823.13770-13-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ONvqYzh+7ST5RsLk"
Content-Disposition: inline
In-Reply-To: <20181211223823.13770-13-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v8 12/12] spapr: change default CPU type to
 POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--ONvqYzh+7ST5RsLk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 11:38:23PM +0100, C=E9dric Le Goater wrote:
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Uh.. this will need something to keep the default at POWER8 for the
older machine types.

> ---
>  hw/ppc/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 97a5e3c9929f..705d3f4057b0 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3938,7 +3938,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      hc->unplug =3D spapr_machine_device_unplug;
> =20
>      smc->dr_lmb_enabled =3D true;
> -    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
>      mc->has_hotpluggable_cpus =3D true;
>      smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_ENABLED;
>      fwc->get_dev_path =3D spapr_get_fw_dev_path;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ONvqYzh+7ST5RsLk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwXPTUACgkQbDjKyiDZ
s5IXMg//ehmu+Looc3P7Tm40NK5LJjMOdQvYukx3J6818mPuxV2vpVApVbXpwqpK
kamoYYvMF+5/BXzNOO6Vqza6A4tCuOYln6hOfaz2sLOHlBUAYGIHDmEhfUo8226y
v4SJwMMHW0ETLZ7XXg5tMdE9GChYVsRhF5rfehB9huDo5uAEHcTSKRKamR0G+V6Y
KFXQ66hg49ehQdMrrilAtarGkFtgc8rgCcGyYnwHMAxVKUiksB2PzZTirz6Ldkfq
Ml6j3ExkeA/P5KIah3KdCf3H++k8clzxhWj4tXOZLG1HbrLf9wydz2geDBZa/1qc
No32Em1TcQIGpAU0LA3M2iWwenK799z5+lXCiKA5FTQ7PxYjw8k8na1WyK978skO
58uRiTLUyzcYQYLzzRmq5TlXgE8y/yRbz7KCeF7l3eju37IZAYCWLIN1DSc0ouqz
Xp7ewzZqJKX6M7PMJpJS9xOEtDzDKudkHCPy99/sPij1vv2IjZzh3SUcUAbBst6p
eHvmBWWgEkvjpy7Yhs1ogTzHivegNviy1mwWMBBXeBJgxbB90mGyDKr5gnwUyOER
406Ho44+Hh2bVU4YABiZuWMPU6wga7m938WMoCn+MJvGeDnWCf9/dHMiIcyrA4iV
CA//pT8IOhDaY4KefWtYNA6kzdlznRmaAbQSd+qGaL7OF3wbLHY=
=RYPt
-----END PGP SIGNATURE-----

--ONvqYzh+7ST5RsLk--
