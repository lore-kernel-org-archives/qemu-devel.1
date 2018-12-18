Received: from eggs.gnu.org ([2001:4830:134:3::10]:45236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZ6M4-0006iz-W8
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 22:47:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZ6M0-0001ir-VI
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 22:47:36 -0500
Date: Tue, 18 Dec 2018 13:26:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181218022613.GE23604@umbus.fritz.box>
References: <20181217223445.28594-1-clg@kaod.org>
	<20181217223445.28594-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Content-Disposition: inline
In-Reply-To: <20181217223445.28594-4-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v9 3/7] spapr/xive: fix compilation
 breakage on windows
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


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 11:34:41PM +0100, C=E9dric Le Goater wrote:
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, and folded into "spapr: add hcalls support for the XIVE
exploitation interrupt mode".


> ---
>  hw/intc/spapr_xive.c | 46 +++++++++++++++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index aaa5865c4080..3ceabe668b16 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -589,12 +589,14 @@ static target_ulong h_int_get_source_info(PowerPCCP=
U *cpu,
>      }
> =20
>      if (lisn >=3D xive->nr_irqs) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN %lx\n", lisn);
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN " TARGET_FMT_=
lx "\n",
> +                      lisn);
>          return H_P2;
>      }
> =20
>      if (!xive_eas_is_valid(&xive->eat[lisn])) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid LISN %lx\n", lisn);
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid LISN " TARGET_FMT_=
lx "\n",
> +                      lisn);
>          return H_P2;
>      }
> =20
> @@ -701,13 +703,15 @@ static target_ulong h_int_set_source_config(PowerPC=
CPU *cpu,
>      }
> =20
>      if (lisn >=3D xive->nr_irqs) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN %lx\n", lisn);
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN " TARGET_FMT_=
lx "\n",
> +                      lisn);
>          return H_P2;
>      }
> =20
>      eas =3D xive->eat[lisn];
>      if (!xive_eas_is_valid(&eas)) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid LISN %lx\n", lisn);
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid LISN " TARGET_FMT_=
lx "\n",
> +                      lisn);
>          return H_P2;
>      }
> =20
> @@ -724,8 +728,8 @@ static target_ulong h_int_set_source_config(PowerPCCP=
U *cpu,
>      }
> =20
>      if (spapr_xive_priority_is_reserved(priority)) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority %ld is reserved\n=
",
> -                      priority);
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority " TARGET_FMT_ld
> +                      " is reserved\n", priority);
>          return H_P4;
>      }
> =20
> @@ -793,13 +797,15 @@ static target_ulong h_int_get_source_config(PowerPC=
CPU *cpu,
>      }
> =20
>      if (lisn >=3D xive->nr_irqs) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN %lx\n", lisn);
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN " TARGET_FMT_=
lx "\n",
> +                      lisn);
>          return H_P2;
>      }
> =20
>      eas =3D xive->eat[lisn];
>      if (!xive_eas_is_valid(&eas)) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid LISN %lx\n", lisn);
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid LISN " TARGET_FMT_=
lx "\n",
> +                      lisn);
>          return H_P2;
>      }
> =20
> @@ -870,8 +876,8 @@ static target_ulong h_int_get_queue_info(PowerPCCPU *=
cpu,
>       */
> =20
>      if (spapr_xive_priority_is_reserved(priority)) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority %ld is reserved\n=
",
> -                      priority);
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority " TARGET_FMT_ld
> +                      " is reserved\n", priority);
>          return H_P3;
>      }
> =20
> @@ -956,8 +962,8 @@ static target_ulong h_int_set_queue_config(PowerPCCPU=
 *cpu,
>       */
> =20
>      if (spapr_xive_priority_is_reserved(priority)) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority %ld is reserved\n=
",
> -                      priority);
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority " TARGET_FMT_ld
> +                      " is reserved\n", priority);
>          return H_P3;
>      }
> =20
> @@ -1102,8 +1108,8 @@ static target_ulong h_int_get_queue_config(PowerPCC=
PU *cpu,
>       */
> =20
>      if (spapr_xive_priority_is_reserved(priority)) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority %ld is reserved\n=
",
> -                      priority);
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority " TARGET_FMT_ld
> +                      " is reserved\n", priority);
>          return H_P3;
>      }
> =20
> @@ -1268,13 +1274,15 @@ static target_ulong h_int_esb(PowerPCCPU *cpu,
>      }
> =20
>      if (lisn >=3D xive->nr_irqs) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN %lx\n", lisn);
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN " TARGET_FMT_=
lx "\n",
> +                      lisn);
>          return H_P2;
>      }
> =20
>      eas =3D xive->eat[lisn];
>      if (!xive_eas_is_valid(&eas)) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid LISN %lx\n", lisn);
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid LISN " TARGET_FMT_=
lx "\n",
> +                      lisn);
>          return H_P2;
>      }
> =20
> @@ -1330,13 +1338,15 @@ static target_ulong h_int_sync(PowerPCCPU *cpu,
>      }
> =20
>      if (lisn >=3D xive->nr_irqs) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN %lx\n", lisn);
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN " TARGET_FMT_=
lx "\n",
> +                      lisn);
>          return H_P2;
>      }
> =20
>      eas =3D xive->eat[lisn];
>      if (!xive_eas_is_valid(&eas)) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid LISN %lx\n", lisn);
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid LISN " TARGET_FMT_=
lx "\n",
> +                      lisn);
>          return H_P2;
>      }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwYWsUACgkQbDjKyiDZ
s5JWpA//bwKCUmxMxgNHMMEOI7o1/nVwEjfQcECY7MrHtIP3TaKYw/3PWuhlQgeV
GWA0bCYObRw2yVCIVvDS8W+A7U8bBY9Kzim7FhZhhVqqmtMDgwlmcHpZaU0IWhki
JAj1SNNjzx66Lbnnq1zNAWSXg7Iqb4wDBQv5VzFT2nFL702RpB5lGal72IPpolq/
o2FH7m6kDSjepIUwYvn5P8+Ky1CyBLkZRyAh72aJEjsc+9b61Ul+XILuzXCEoSZG
akyoVFX7PD6fhNDiKxh37IwMlejfPhMBRWFGY3w9COBbhjWft+NtntW+CIRXyCvh
/cgiBFJisNsGFCsR10TfburYxTSk6Ys3y9k2mqoQEm7ZRqsBrUIkPOrfjAwZvSZt
9IC8yc+ptGyeKGrVeF6wFzDlcy2JW25trVTBvPKegXsaClnOPxLxKAii6HiAZYm5
4SYrojp0RGfp1ggSC8b7C5MgxQrcFIq0+FJHH8TsMfmgna34y+hpTrtUa+h6dqF7
X34jGNlXCNMETYTcUNgGu1gO5tSHyqGHprGzpgjDjOmqV3hlc79Aq4+a7YRUMlEm
b/un1ALjvNzlmE/qlyqhVVHdneLZdd/8nnTyataTURcq75xOARjDeNOCwDSSigXW
6XM5eXVHnecok+OornlSId6sXr55RvjQyI+T9tQJffAky5SU+NM=
=t0yp
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--
