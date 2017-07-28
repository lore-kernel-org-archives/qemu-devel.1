Received: from eggs.gnu.org ([2001:4830:134:3::10]:36288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dawr7-0003EZ-Do
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 00:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dawr6-0007q1-DW
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 00:26:29 -0400
Date: Fri, 28 Jul 2017 13:46:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170728034642.GE3098@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100569817.27487.947951250042841104.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zjcmjzIkjQU2rmur"
Content-Disposition: inline
In-Reply-To: <150100569817.27487.947951250042841104.stgit@bahia>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 17/26] spapr_pci: introduce drc_id
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--zjcmjzIkjQU2rmur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 08:01:38PM +0200, Greg Kurz wrote:
> With the addition of PHB hotplug, we have a static number of DRCs
> that can be used to handle hotplug/unplug operations on our PHBs,
> and need a consistent way to map PHBs to these connectors, and
> assign a unique identifiers for the connectors.
>=20
> This patch adds a drc_id property for that purpose.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

I'd prefer to see this folded into the patch that actually uses this
property.

> ---
>  hw/ppc/spapr_pci.c          |    1 +
>  include/hw/pci-host/spapr.h |    2 ++
>  2 files changed, 3 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 994d2f36105f..54533d8a3841 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1878,6 +1878,7 @@ static Property spapr_phb_properties[] =3D {
>                       pre_2_8_migration, false),
>      DEFINE_PROP_BOOL("pcie-extended-configuration-space", sPAPRPHBState,
>                       pcie_ecs, true),
> +    DEFINE_PROP_UINT32("drc_id", sPAPRPHBState, drc_id, -1),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 5a4e9686d562..31bae68167f2 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -82,6 +82,8 @@ struct sPAPRPHBState {
> =20
>      bool pcie_ecs; /* Allow access to PCIe extended config space? */
> =20
> +    uint32_t drc_id;
> +
>      /* Fields for migration compatibility hacks */
>      bool pre_2_8_migration;
>      uint32_t mig_liobn;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zjcmjzIkjQU2rmur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll6s6IACgkQbDjKyiDZ
s5IQhhAAko+bEfztcr+IjeA/MnwEMfAtes2wDbVuN9cauze6Babv9AeXwePAyfAI
SmzOh6eSLS9gRk4yCeFa3feD0L+NwMCKWgZtiBnv0fOZqSUVwSyvtT+evdAHaymX
e+78d9dex6wg2Gwr4Ql8/HGIv/lNY0sFKRjbUFkJNsWwMj39rB3cIW8zNO66fHMd
R6muWa4d7m1TDuX2PPdia6XVV29hJEowtGw28Eg/NUnJlWOkovX9I4mYBgGz46iO
WkyWlwYTHF2qDOjLPI8IrT3Pqz2s9CBPVKGPHeR8MAE/3fqMJDPsJUSfp9k109fv
W17XUqpStVtjNPm0smXfJ886laTbkmwrywL3kTBCX0AFCnv+t1sTEuCiXFlKyeQx
hwpGC08xAyPpgLTj8oEM0tNwKtT/oQh/Ny0TFmcCvcxYzfqtXV4Bx+x8JqCh2eba
H3SfLqH7jb8xyl2xFTiShBABSyDJAWw1RRaOUMofY1OB+ilCkeMCigMgXvae/RFO
kO0Im1I7Rxfyk7/ZsWBSZzikGHAYk3jHAWqOwvNj6LB0oUOIdvsRS/iq2hrfo6cc
d2bgrFo8OwzZ6pM1cYZlyBo8P6SK1KjL0fF0sJu++a64+dvCuW95ncJjdn4qkjW6
vtAcqWDIQXThvjJMCBZKXnLaPJapqZ202u3RGQnY2nH42hr/Aqo=
=6G0u
-----END PGP SIGNATURE-----

--zjcmjzIkjQU2rmur--
