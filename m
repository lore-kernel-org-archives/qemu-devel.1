Received: from eggs.gnu.org ([2001:4830:134:3::10]:60328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDr9-0002Vl-5O
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDr6-0005lF-0x
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:23:31 -0400
Date: Wed, 26 Jul 2017 14:00:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170726040009.GR8978@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100554612.27487.13537614128295672408.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Bi+HF1AHjw0mn3zx"
Content-Disposition: inline
In-Reply-To: <150100554612.27487.13537614128295672408.stgit@bahia>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 05/26] spapr_iommu: convert TCE
 table object to realize()
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


--Bi+HF1AHjw0mn3zx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 07:59:06PM +0200, Greg Kurz wrote:
> Signed-off-by: Greg Kurz <groug@kaod.org>

Oh, wow, that was pretty messed up.

Applied to ppc-for-2.11.

> ---
>  hw/ppc/spapr_iommu.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index 740d42608b61..d4eca2a77225 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -248,7 +248,7 @@ static const VMStateDescription vmstate_spapr_tce_tab=
le =3D {
>      }
>  };
> =20
> -static int spapr_tce_table_realize(DeviceState *dev)
> +static void spapr_tce_table_realize(DeviceState *dev, Error **errp)
>  {
>      sPAPRTCETable *tcet =3D SPAPR_TCE_TABLE(dev);
>      Object *tcetobj =3D OBJECT(tcet);
> @@ -270,8 +270,6 @@ static int spapr_tce_table_realize(DeviceState *dev)
> =20
>      vmstate_register(DEVICE(tcet), tcet->liobn, &vmstate_spapr_tce_table,
>                       tcet);
> -
> -    return 0;
>  }
> =20
>  void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, bool need_vfio)
> @@ -618,7 +616,7 @@ int spapr_tcet_dma_dt(void *fdt, int node_off, const =
char *propname,
>  static void spapr_tce_table_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    dc->init =3D spapr_tce_table_realize;
> +    dc->realize =3D spapr_tce_table_realize;
>      dc->reset =3D spapr_tce_reset;
>      dc->unrealize =3D spapr_tce_table_unrealize;
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Bi+HF1AHjw0mn3zx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll4E8kACgkQbDjKyiDZ
s5KObw/+MB5vdrFqqXbZleP+9CNAGuUJqy6YRb44vDsbtS9u/DaeQMdaut6HwMy3
SOumWjFx8a2v/+29ziLdyaGCO6bPXobPSUbU6pSEozprE415/b0D02SZnJA3bbUQ
XdmP91k6/BCdMRMRjJ8tSBHjIRf/Mp5R0HKV7jcwqTwZIuHhm6C5t2I3x68U9r+Q
ZNEpbi9mOsrCnP/7ST9uj02Oyf3R/wazsSUhI/0zy+7KT5pJUPY+rDQS+dO6Sf7n
Hn57CJtmN0jgmfx3nevEbhELmSqJCczwSMKYpgKpjZQ/CDTgy5132YGZo3hvzZGL
KvoDUm0Sm8UNIb9lN0Tu2fQUSgyhtfKWS30YyN4MG2gRg0UC5ZLmSCvfP8bpcsIL
gM4RlBPrfwfeVz5BZfY+xblx279tRHfUJSxJCmYE5c1OEUtdyL77UkUEWcu/8tyT
RIy/NCRM7+OXg4Fe4AuNeSDk1AnhHUmrYu8HSh7wMCYdQRUd7lE7FXlr6vu5Qud7
8DB/G6DGKdErSrNv9buqJAaHfXsAPtAFbrXix6jVuggS1kTxJVTMsNqjN7o86sdn
EDEA9jp2RiWAGa9rlmsXs5eFWQDjw8iJ3IPDxu/Dp57KhqNfqM0X/rrDyRFRpuXN
5nwcoZKzyitKqXQqNIQXNxpUp1m5MtMDCaj8c8uFUyN9ltwUEvE=
=8dax
-----END PGP SIGNATURE-----

--Bi+HF1AHjw0mn3zx--
