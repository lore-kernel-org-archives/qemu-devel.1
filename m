Received: from eggs.gnu.org ([2001:4830:134:3::10]:60296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDr7-0002VY-IZ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDr6-0005lX-Ag
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:23:29 -0400
Date: Wed, 26 Jul 2017 14:15:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170726041516.GX8978@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100562212.27487.3148886355304043696.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IfhPODtivl1BCmut"
Content-Disposition: inline
In-Reply-To: <150100562212.27487.3148886355304043696.stgit@bahia>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 11/26] spapr_iommu: unregister
 vmstate at unrealize time
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


--IfhPODtivl1BCmut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 08:00:22PM +0200, Greg Kurz wrote:
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11.

> ---
>  hw/ppc/spapr_iommu.c |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index 8ec4e7a40834..40a44c563824 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -374,6 +374,8 @@ static void spapr_tce_table_unrealize(DeviceState *de=
v, Error **errp)
>  {
>      sPAPRTCETable *tcet =3D SPAPR_TCE_TABLE(dev);
> =20
> +    vmstate_unregister(DEVICE(tcet), &vmstate_spapr_tce_table, tcet);
> +
>      QLIST_REMOVE(tcet, list);
> =20
>      spapr_tce_table_disable(tcet);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IfhPODtivl1BCmut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll4F1QACgkQbDjKyiDZ
s5Jkqg//QBaSoBirjbvl0ufWyxDWd8oXi6/kedXw4t67JrSmuxNoaJ1DmTYKe6HR
uW7dEPpuWBIfoi1Vgh3klQPK6aLRtGl2tzfluui80n4iy/w88y//VOTMuj4owsBD
iJLVPV3jgSLF/zQpWClo9IUW5fGXIOSIvDf1HzCDQcn+6QczKNjEzd3KZ1jq12qg
8SqPTCPWfp78yOCTMUF014lC5iNLTYX+djySl7ohFdFT9aQ++o9S+z2e2VVX6fac
lT37Z/ZTzda/+u56Dpwsn4E3JDW3YG+MoXOnT9qLa++QOfiU5LuZBFLtJ2XUtWrg
NXZ7BCoziziJwQ7uc3/CgjEEh8XvH5CSCaZkUW+52SbIgSFuoiraaZ5x00LUPO0+
os67aPkz3CNUaTWimRLd3UTmbR9c5CUB9LdjiSGSOgW0ORsWC4RMnRzGwUYilMcT
NEf0BkfOX9UQbbXfnu0PXOultd67M6o6S/V1NA/y8SGAZj1Q4v0qrDNGi/YvifYh
Wo1hN4R8Xn7qp2dbRYEq/x0LHN3+Q95w/1qe1cACIElc4Kas6jmSm9oe1g0LhMl+
ClTCItJya1jLV6xwqMn5Gf5uE7j3IEJnVM1B+vUpSRAgnZeFnNHyq5ZhrEJDt0ex
ewNdQkgGZyld/6AciaEzFEH0iK62kSjDEZVS+8gGarTUvw173UI=
=or2v
-----END PGP SIGNATURE-----

--IfhPODtivl1BCmut--
