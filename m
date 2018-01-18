Received: from eggs.gnu.org ([2001:4830:134:3::10]:39255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebzCZ-00046B-KM
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 20:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebzCY-0001XN-ES
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 20:41:11 -0500
Date: Thu, 18 Jan 2018 11:30:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180118003007.GB30352@umbus.fritz.box>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
	<1516203816-19374-12-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q1SX3yAxAkj1z+aD"
Content-Disposition: inline
In-Reply-To: <1516203816-19374-12-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/24] ppc: cpu: add
 TARGET_DEFAULT_CPU_TYPE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--q1SX3yAxAkj1z+aD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2018 at 04:43:23PM +0100, Igor Mammedov wrote:
> it will be used for for 2 purposes, 1st is to
> provide to cpu name resolving class for machine 'none'
>   cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model)
> and later to drop a bunch of ifdefs *-user/main.c that
> set default cpu_model.
>=20
> Use default values from linux-user for TARGET_DEFAULT_CPU_TYPE.
> While at it fixup linux-user to use corresponding cpu models
> instead of aliases.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> CC: Riku Voipio <riku.voipio@iki.fi>
> CC: Laurent Vivier <laurent@vivier.eu>
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: Alexander Graf <agraf@suse.de>
> CC: qemu-ppc@nongnu.org
> ---
>  target/ppc/cpu.h  | 6 ++++++
>  linux-user/main.c | 4 ++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index a5e49f2..4af4aff 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1377,6 +1377,12 @@ int ppc_dcr_write (ppc_dcr_t *dcr_env, int dcrn, u=
int32_t val);
>  #define POWERPC_CPU_TYPE_SUFFIX "-" TYPE_POWERPC_CPU
>  #define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
> =20
> +#ifdef TARGET_PPC64
> +#define TARGET_DEFAULT_CPU_TYPE POWERPC_CPU_TYPE_NAME("power8_v2.0")
> +#else
> +#define TARGET_DEFAULT_CPU_TYPE POWERPC_CPU_TYPE_NAME("750_v3.1")
> +#endif
> +
>  #define cpu_signal_handler cpu_ppc_signal_handler
>  #define cpu_list ppc_cpu_list
> =20
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 54e8aac..279cd97 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -4343,9 +4343,9 @@ int main(int argc, char **argv, char **envp)
>          cpu_model =3D "or1200";
>  #elif defined(TARGET_PPC)
>  # ifdef TARGET_PPC64
> -        cpu_model =3D "POWER8";
> +        cpu_model =3D "power8_v2.0";
>  # else
> -        cpu_model =3D "750";
> +        cpu_model =3D "750_v3.1";
>  # endif
>  #elif defined TARGET_SH4
>          cpu_model =3D "sh7785";

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--q1SX3yAxAkj1z+aD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpf6o8ACgkQbDjKyiDZ
s5IgpA//TpSovV/i3TNVHsk7PxTL112vhwtG1uPOLm2+o2adB4Xel4uPwNYf+YbP
rU1YyfotGrUKOuvvklUikhPQlmNY6yXm7lLBKKocfm5tMo+4MkAIs4e8LEk7dsmb
2FuP7QBPAcE5wJGcL4MwczfwPzEurz0d0vKRX4F1NkPxfC8/cZdmsOBWkDQqkTq+
sVMov9vWSJiOcffxF/nHZs18GbvePhC++CLrjBBaR5utAykIZrK6DpAicumxEEEC
H5bZmCNY7otYBa6ghXaEqI5jJTOZhGp54nZT3EPtiVqnf3UVrGjUlGFbgXBjSDg8
rXBL/v2ECVuf0//5jiVkDqE2x3pmAD1+CJs+KS8IIShc9PDwLLvQIqiu7mbgQv3P
8USpEOm7qPQMxZb9jMyTZJD7mMtRVH/PtKxMzvtcMuKOZUzKMMQjq4jE+MnTBgeH
L8rJWczQNGWvEZAVBpEInLoQA5mmGyZQr5s74EeeRMAVrY1mupTMC9Tp6yUpo9XE
VgxHLWyXn+kBR/WtO07EMmvmhVDJo0vuFGbjqpzX6Q1VW4kVHRERivkSoVElvDgR
z3vvPYz7cXlUEC2vRU8+OCw7Ha4A3FvU6g9TDlrhUDPydt9KIsaExrcNvFJSrVP/
ikmTk9H5FJtC4py1X154fwnvg4Enk/JldWnXMPeZdml6pot12Ro=
=1NIv
-----END PGP SIGNATURE-----

--q1SX3yAxAkj1z+aD--
