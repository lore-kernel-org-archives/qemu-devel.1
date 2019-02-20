Received: from eggs.gnu.org ([209.51.188.92]:53997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwIbX-0005d9-9w
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:31:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwIbK-0003Yd-7E
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:31:18 -0500
Date: Wed, 20 Feb 2019 14:29:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190220032916.GN9345@umbus.fritz.box>
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<155059672420.1466090.15147504040270659866.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w+rhPQc/K9ract27"
Content-Disposition: inline
In-Reply-To: <155059672420.1466090.15147504040270659866.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 14/17] spapr_pci: add ibm,
 my-drc-index property for PHB hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>


--w+rhPQc/K9ract27
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 06:18:44PM +0100, Greg Kurz wrote:
> From: Michael Roth <mdroth@linux.vnet.ibm.com>
>=20
> This is needed to denote a boot-time PHB as being hot-pluggable.
>=20
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/ppc/spapr_pci.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index a0e17694396a..03fc26985ab1 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2203,6 +2203,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint3=
2_t intc_phandle, void *fdt,
>      sPAPRTCETable *tcet;
>      PCIBus *bus =3D PCI_HOST_BRIDGE(phb)->bus;
>      sPAPRFDT s_fdt;
> +    sPAPRDRConnector *drc;
> =20
>      /* Start populating the FDT */
>      nodename =3D g_strdup_printf("pci@%" PRIx64, phb->buid);
> @@ -2269,6 +2270,14 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint=
32_t intc_phandle, void *fdt,
>                   tcet->liobn, tcet->bus_offset,
>                   tcet->nb_table << tcet->page_shift);
> =20
> +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, phb->index);
> +    if (drc) {
> +        uint32_t drc_index =3D cpu_to_be32(spapr_drc_index(drc));
> +
> +        _FDT(fdt_setprop(fdt, bus_off, "ibm,my-drc-index", &drc_index,
> +                         sizeof(drc_index)));
> +    }
> +
>      /* Walk the bridges and program the bus numbers*/
>      spapr_phb_pci_enumerate(phb);
>      _FDT(fdt_setprop_cell(fdt, bus_off, "qemu,phb-enumerated", 0x1));
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--w+rhPQc/K9ract27
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxsyYwACgkQbDjKyiDZ
s5KR9g/8CszxbFLWX63AoAIVeR6MFlLJohjIjDkwix8nzRTJxdjJD8ZUBfOICjaO
g/hia7mYB6iAeFnBwpvR4i5vjxk74ZyJyRWRgiNEAt8EPmwyjJqUZ10XEpiwi5b4
oI+B8yfOHsc+RIOHVsLuXlPPAmXdZ+sQNChz0V++vMKKMEoiNBltmijw7ZxZekGY
MukS1QuMCw9NH4rndzd+ztrNwhRR/hoeGv/dxD/9AvPD6uGqaHmneQkbVbV+rjhr
pck3EPuLNYBT8n23NOY+HGMoksCuy+wveuQzqWZvfxsT9uQxX4rwispJzBrtT+qn
Xqdpmdj8vo7CVlMhr1t7IcWaM+yAvGSIaQ24pxJDxGOAomz8XNKop2psqqG1vsV8
XT6t5NM1g08Hl3YDW20XXbHBU6W5LQvrLtuFY/QcWFA/IpiF6PIJyB9R1VJ9eASi
Z1ddbQKil6L+MQ+j0h9iPokiWj5LoH8719+O3E9BZ/eJuN4lOvQLpBr8s4FgFZnK
70QhcV8H5xdthBYudFloUvof2OTu/7MFOql4PukxW1wXJuw330uYdatwi71ltzDo
zRJbmPaeKMWb3n71GUaroSahFR9L0jRmFcu9SPG8tKvkIW+WtI2xiKEAQMQBJ6jk
GewRQ7naQEGkMA82Puy7JvEZGGq+1BlmVbAqZfBClrGX7p/GWi4=
=iJAC
-----END PGP SIGNATURE-----

--w+rhPQc/K9ract27--
