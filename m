Received: from eggs.gnu.org ([2001:4830:134:3::10]:57771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dRDbi-0004CS-HW
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 04:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dRDbh-00027d-B5
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 04:18:22 -0400
Date: Sat, 1 Jul 2017 17:50:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170701075024.GI13989@umbus.fritz.box>
References: <149882869053.24031.15086612121177689276.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2nTeH+t2PBomgucg"
Content-Disposition: inline
In-Reply-To: <149882869053.24031.15086612121177689276.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr: make
 spapr_populate_hotplug_cpu_dt() static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org


--2nTeH+t2PBomgucg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2017 at 03:18:10PM +0200, Greg Kurz wrote:
> Since commit ff9006ddbfd1 ("spapr: move spapr_core_[foo]plug() callbacks
> close to machine code in spapr.c"), this function doesn't need to be exte=
rn
> anymore.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.10.

> ---
>  hw/ppc/spapr.c         |    4 ++--
>  include/hw/ppc/spapr.h |    2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0ee9fac50bd4..65d8ad2f4966 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2863,8 +2863,8 @@ out:
>      error_propagate(errp, local_err);
>  }
> =20
> -void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
> -                                    sPAPRMachineState *spapr)
> +static void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
> +                                           sPAPRMachineState *spapr)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index a66bbac35242..12bf9697990e 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -640,8 +640,6 @@ void spapr_hotplug_req_add_by_count_indexed(sPAPRDRCo=
nnectorType drc_type,
>  void spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType drc_=
type,
>                                                 uint32_t count, uint32_t =
index);
>  void spapr_cpu_parse_features(sPAPRMachineState *spapr);
> -void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
> -                                    sPAPRMachineState *spapr);
> =20
>  /* CPU and LMB DRC release callbacks. */
>  void spapr_core_release(DeviceState *dev);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2nTeH+t2PBomgucg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZV1Q8AAoJEGw4ysog2bOS4P0QAObR28rEfoIlcJeW5W5U4vlo
GESFD1iSkyQd3KW1N5pSql25DXTbpah8LSvClOMJIWf5I13nUqyo/Vt6bQepA9p9
fw1vuO5MhiGwvR/bqDccXOuI4WdFct6NS4RAc/dhZG0c0ErJ3mhCjG+Yy+FSjm/T
MvBf0VjeRSkqmsftBrpHHE7iPl68cKpRlCeDzhPrOmy9OSpMiF9nyutSuy2rv2S1
LIxoYQylkeX7UGQR0xxUCSxomVYpSBhk56TGhycDZJIq0kNr+P8TLq+zyOfdUoGB
eymbtPwL3EPUhRhYbwhSQLRdD/yvvYJi7ekf54tIggXt9igl3QoQBvTBvjdDdCpp
BuAxmbPutXTlVRXPMmfU5yztYCx7Gcl0Z6eIu9cwIEcpvexKuHUbaa5DmDQttAM3
pc4nj/Ks23lJLfW+xLbUScwu6Y9tqZQ+XwzDB1caWkj1IIrBbbbs1JyDjbE5LmKp
DxkXASQKthZtBbAbwC0582dRi7AmLmK3QJinXOQI03HdCy15sQRDS8IarJ+LF7oA
/t53Ob5YGIs++Ma4pWbkEFQTVS3xXOm5myK55pIunlEEwBWl1pT5ob5Y9kt4aJkg
Mzv2JcOcQR57czmx1hlPVlhPxvlefvCwjxxNgZSQdDDTmBCsg1hFlAWOVBuYdQ9A
CHgXceVCiKln6qJHAQYg
=Aa4p
-----END PGP SIGNATURE-----

--2nTeH+t2PBomgucg--
