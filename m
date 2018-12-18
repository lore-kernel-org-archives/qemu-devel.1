Received: from eggs.gnu.org ([2001:4830:134:3::10]:50308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZ6nm-0003vP-6H
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:16:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZ6j4-0001hp-C1
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:11:26 -0500
Date: Tue, 18 Dec 2018 15:04:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181218040423.GG23604@umbus.fritz.box>
References: <20181217223445.28594-1-clg@kaod.org>
	<20181217223445.28594-7-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MrRUTeZlqqNo1jQ9"
Content-Disposition: inline
In-Reply-To: <20181217223445.28594-7-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v9 6/7] spapr: change default CPU type to
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--MrRUTeZlqqNo1jQ9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 11:34:44PM +0100, C=E9dric Le Goater wrote:
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Fixed up for my removal of the update_dt patch, and applied.

> ---
>  hw/ppc/spapr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index aefa0f4ea430..8ea680fcde1e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3967,7 +3967,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
> =20
>      smc->dr_lmb_enabled =3D true;
>      smc->update_dt_enabled =3D true;
> -    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
>      mc->has_hotpluggable_cpus =3D true;
>      smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_ENABLED;
>      fwc->get_dev_path =3D spapr_get_fw_dev_path;
> @@ -4066,6 +4066,7 @@ static void spapr_machine_3_1_class_options(Machine=
Class *mc)
> =20
>      spapr_machine_4_0_class_options(mc);
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_1);
> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
>      smc->update_dt_enabled =3D false;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MrRUTeZlqqNo1jQ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwYccQACgkQbDjKyiDZ
s5II7BAAq0TbtvBnckPGQHLg8yBXFXfpK5CpH2tVz9lPR+2S+nQrw/G95lFrkfQf
Q8F6qzPGffDIRVV+d6c12JTbE97s6XgBZ1C5UjyeXYOLyXdQvrLH5/qvpzH4/MZV
n5FPYCTBNLT1Mmip7w8IaHGBijYGnktBZrLCwDVaXB3DAMO12RubutfR5AZJkyhe
SOf75bpk3Wpd3llWgrfXknXJRe85AOVMnJxQYlslAzSF06aOipc/Xm6YV+dSAQFg
fSH6wLtzcOSFJcPf+sgulGcjczqbAsE6mKVvYeGXoacIkdY4U1tqVeBaJ02i/0kN
GofW6eJq6TUdSAr/gJs4Ud1iNP2QLwHy720KuUIZ30rMN47N6XZU1gcQcuA7pcPA
EQh1yPp0OlnENK2NIxRpPVkp+itvIQWru1emwIuM6RiybsZ8jJLuEME+IKwuhdz3
sWtoAjkAkUWYbaA84WNjNwuOITD/8visGLFXlgG/jU9l0uS7kt+S6LpDl+fuSQBH
2VGZ1wDWWgzS96oKeU/IBnjVAIceD9G7Mm25EavcGncvRhy3ZkxBW47hCCijq8pF
XOCM/7mQm06ZAXZfZCYWfNfyG7Vx9LOe2VGQNWMTJuK5Rn65Lv0X656yUINjU3ow
KQeum4WWMMiy5syxB7eFAKD4XLF2EFlo/Orv2suvQp/p97u2dD0=
=D7fH
-----END PGP SIGNATURE-----

--MrRUTeZlqqNo1jQ9--
