Received: from eggs.gnu.org ([209.51.188.92]:52477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWi6-0008Ak-MC
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWi5-0005a2-Nc
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:02 -0500
Date: Mon, 18 Feb 2019 10:35:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190217233513.GE2765@umbus.fritz.box>
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023080638.1011724.792095453419098948.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7CZp05NP8/gJM8Cl"
Content-Disposition: inline
In-Reply-To: <155023080638.1011724.792095453419098948.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 04/10] spapr/irq: Use the base ICP class
 for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--7CZp05NP8/gJM8Cl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 12:40:06PM +0100, Greg Kurz wrote:
> The base ICP class knows how to interact with KVM. Adapt sPAPR to use it
> instead of the ICP KVM class.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/ppc/spapr_irq.c     |    4 +---
>  include/hw/ppc/spapr.h |    1 -
>  2 files changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 48d6b2daed6e..e6893df61e76 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -102,7 +102,6 @@ static void spapr_irq_init_xics(sPAPRMachineState *sp=
apr, int nr_irqs,
>      if (kvm_enabled()) {
>          if (machine_kernel_irqchip_allowed(machine) &&
>              !xics_kvm_init(spapr, &local_err)) {
> -            spapr->icp_type =3D TYPE_KVM_ICP;
>              spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs,
>                                            &local_err);
>          }
> @@ -117,7 +116,6 @@ static void spapr_irq_init_xics(sPAPRMachineState *sp=
apr, int nr_irqs,
> =20
>      if (!spapr->ics) {
>          xics_spapr_init(spapr);
> -        spapr->icp_type =3D TYPE_ICP;
>          spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,
>                                        &local_err);
>      }
> @@ -199,7 +197,7 @@ static void spapr_irq_cpu_intc_create_xics(sPAPRMachi=
neState *spapr,
>      Object *obj;
>      sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> =20
> -    obj =3D icp_create(OBJECT(cpu), spapr->icp_type, XICS_FABRIC(spapr),
> +    obj =3D icp_create(OBJECT(cpu), TYPE_ICP, XICS_FABRIC(spapr),
>                       &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index cbd276ed2b6a..631fc5103b7b 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -178,7 +178,6 @@ struct sPAPRMachineState {
>      /*< public >*/
>      char *kvm_type;
> =20
> -    const char *icp_type;
>      int32_t irq_map_nr;
>      unsigned long *irq_map;
>      sPAPRXive  *xive;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7CZp05NP8/gJM8Cl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxp77EACgkQbDjKyiDZ
s5LUQBAA0yxyOBX6n52qb8xwhjsbhMvqVI7hQed01BPF2Li35mG/fBZdraid44n0
ItetnqYdlc3SGQWbNYZXtiUAQdKylBZ53+CM8ZBdSQRdvC+Poa2eFVLx36k4MdvC
7ggJy8kMVKGEAEtTLAR0kLOksFoSIjZMmknccXsEkFSJ60cPD4JaD2MbafPMcf1L
hHV+KMy8ozqfwaoSWSayR2315gjDk7tTRSpoWVktKs74d1P0NFUY8dFCL8cwAlGV
5mdgbcO+W5kYSLjTED4hOltof/G9uGGB8v3ipkaticLEcEUN4kiS+FyXEVjisfFt
uRWled7NkCbItgAquoZddgUOypvnpBRa4yzLP7vorESeNG2+gKKPIzlrurVUri4z
bfiJwqdgs9cEFvqrk55BdlkYtCK808trwqkwl5HG4NgXEbKletaXMVjLRAkFXiv/
OasHDBfzSo4Wrxmrh/jvzryVyV4/KznS5joBbpsGrAeMV2kvM1odaWV1+wsUOasR
v3kInn9DVzwqlzWP8gDM5Xein2iDB2Iuyi31QHnc2iriyaUIu/NwgVw4in9SY0KU
RH2Lijyhgc/eLCyQgrFFCsW5vMnRKKaxhjWSzU8cEiMy0ggDUmGmIC06giwVNbY/
HgZF8CiTQwbHU8V+FgS73974el/SLwdZz4p+Wcrpm43nC52hYiY=
=gu2l
-----END PGP SIGNATURE-----

--7CZp05NP8/gJM8Cl--
