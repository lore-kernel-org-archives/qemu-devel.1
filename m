Received: from eggs.gnu.org ([2001:4830:134:3::10]:43918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daFEb-0004zq-A6
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 01:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daFEa-0001Yj-Ew
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 01:51:49 -0400
Date: Wed, 26 Jul 2017 15:47:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170726054718.GI8978@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100572350.27487.14857589060586322098.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XCKmtPOB2gS6QFgg"
Content-Disposition: inline
In-Reply-To: <150100572350.27487.14857589060586322098.stgit@bahia>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 19/26] spapr: populate PHB DRC
 entries for root DT node
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


--XCKmtPOB2gS6QFgg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 08:02:03PM +0200, Greg Kurz wrote:
> From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
>=20
> This add entries to the root OF node to advertise our PHBs as being
> DR-capable in accordance with PAPR specification.
>=20
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> Changes since RFC:
> - rebased against ppc-for-2.10
> - use error_report
> ---
>  hw/ppc/spapr.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5950c009ab7e..632040f35ecc 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1151,6 +1151,16 @@ static void *spapr_build_fdt(sPAPRMachineState *sp=
apr,
>          exit(1);
>      }
> =20
> +    if (smc->dr_phb_enabled) {
> +        int offset =3D fdt_path_offset(fdt, "/");

Offset of the root node is guaranteed to be 0, so you don't need fdt_path_o=
ffset().

> +        ret =3D spapr_drc_populate_dt(fdt, offset, NULL,
> +                                    SPAPR_DR_CONNECTOR_TYPE_PHB);
> +        if (ret < 0) {
> +            error_report("Couldn't set up PHB DR device tree properties"=
);
> +            exit(1);
> +        }
> +    }
> +
>      return fdt;
>  }
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XCKmtPOB2gS6QFgg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll4LOMACgkQbDjKyiDZ
s5IB9BAAkWPJGDt+y04pXcXkcbGf4BccVBBts2FqKtTrRW4yTSBZmMDOp7SM9IUn
UoWLoIDf5TJRuz++g63Ef/asTEgT5VeQHPdwmB9+qJSVbFew9yKIyhgCnHnkkgwV
5qmaNXvVBqRZlIq7WuCErnaxtvJqnYnCOAI+7pRTe/vokl52yqPzVeRBRQZfVast
32uoUknvWtPqQBBSQj96/v0/plFy7tMlHoiA1PJhRvYC5/0RT+vnQlcLEcibdB8S
PQz4gce94KmMzo9G4uzN5HgS+P6r3J9G10jG0Xz5IKG2ga4KX4x/RJINiPmTB08s
mQzJrxgCJOiikopzpOb6itAVeiIrpg7DPgcFM3L0RS88rZOwUGaKJvm2I+CK7a2Q
lorT9Ouh7VtXNXHWfXWHTwDW8xxep7G4CFVMTLOoplWPo7OHS7q9GkV+TmmDeB4O
eBm2iZui5LbtBJOsOLVUCIcMcELxNSusIek+vsQ9EsOisyjaW71p/0ceCp+c8938
8oYWijn2LJ42P22RM8m/cEJ5bep4IfAzI/yNllIefB7LnDahkaPxHheRpEqd3y4C
pimJ+pEawwKHdmp37kNgLDC79V8PKIEUrdEZbovhzRni9ODRtITw4m1eCv5bU7u5
8DCWgBVM8pa1gUUl6ofLf18y4V0/u0Tal47LULFHFTmgPKetsE0=
=SdHp
-----END PGP SIGNATURE-----

--XCKmtPOB2gS6QFgg--
