Received: from eggs.gnu.org ([2001:4830:134:3::10]:53979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dxQCV-0000dm-1N
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 00:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dxQCR-0003V5-S5
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 00:13:26 -0400
Received: from ozlabs.org ([103.22.144.67]:56489)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dxQCQ-0003TN-GQ
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 00:13:23 -0400
Date: Thu, 28 Sep 2017 14:04:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170928040457.GZ12504@umbus>
References: <20170927195635.16014-1-ehabkost@redhat.com>
	<20170927195635.16014-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CtqPPqYpYc7tL2y7"
Content-Disposition: inline
In-Reply-To: <20170927195635.16014-2-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/5] pci: conventional-pci-device and
 pci-express-device interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <dgibson@redhat.com>, Alistair Francis <alistair23@gmail.com>, Laine Stump <laine@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>


--CtqPPqYpYc7tL2y7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2017 at 04:56:31PM -0300, Eduardo Habkost wrote:
> Those two interfaces will be used to indicate which device types
> support Conventional PCI or PCI Express buses.  Management
> software will be able to use the qom-list-types QMP command to
> query that information.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes v1 -> v2:
> * s/legacy/conventional/
>   * Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  include/hw/pci/pci.h |  6 ++++++
>  hw/pci/pci.c         | 12 ++++++++++++
>  2 files changed, 18 insertions(+)
>=20
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index aa7ef9cf69..8d02a0a383 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -198,6 +198,12 @@ enum {
>  #define PCI_DEVICE_GET_CLASS(obj) \
>       OBJECT_GET_CLASS(PCIDeviceClass, (obj), TYPE_PCI_DEVICE)
> =20
> +/* Implemented by devices that can be plugged on PCI Express buses */
> +#define INTERFACE_PCIE_DEVICE "pci-express-device"
> +
> +/* Implemented by devices that can be plugged on Conventional PCI buses =
*/
> +#define INTERFACE_CONVENTIONAL_PCI_DEVICE "conventional-pci-device"
> +
>  typedef struct PCIINTxRoute {
>      enum {
>          PCI_INTX_ENABLED,
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 1e6fb88eba..1b08e18205 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -170,6 +170,16 @@ static const TypeInfo pci_bus_info =3D {
>      .class_init =3D pci_bus_class_init,
>  };
> =20
> +static const TypeInfo pcie_interface_info =3D {
> +    .name          =3D INTERFACE_PCIE_DEVICE,
> +    .parent        =3D TYPE_INTERFACE,
> +};
> +
> +static const TypeInfo conventional_pci_interface_info =3D {
> +    .name          =3D INTERFACE_CONVENTIONAL_PCI_DEVICE,
> +    .parent        =3D TYPE_INTERFACE,
> +};
> +
>  static const TypeInfo pcie_bus_info =3D {
>      .name =3D TYPE_PCIE_BUS,
>      .parent =3D TYPE_PCI_BUS,
> @@ -2667,6 +2677,8 @@ static void pci_register_types(void)
>  {
>      type_register_static(&pci_bus_info);
>      type_register_static(&pcie_bus_info);
> +    type_register_static(&conventional_pci_interface_info);
> +    type_register_static(&pcie_interface_info);
>      type_register_static(&pci_device_type_info);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CtqPPqYpYc7tL2y7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnMdOkACgkQbDjKyiDZ
s5JAsw//XRI43oFO/P7CxRbjj/w5gQDjBphfsJHg8ERHRyB8f1z6g6vD+GBv1WbH
RgsAQX3kuIydG2c0OT0z4hU8KE0lT2bafuKpwp/1LzCNkY/qJwz5fTBPRjK55ki9
pwklzln40r3UoypdWCqH+8YLss9pt2YOQoiHpC7JdszmQvF4/3Lv2eKDzdoWXUuV
1y/xVAYNKvrli4j/TB5vOo4oP5qHixDIj+2ifFEejVuJo2SfPiQp4gVXQGNox/bl
9yP+Rxw9cOvJfJLQYGygF/31+8AYih0RYTFVQoQoGmQo6cBT0R7BbbDmbGDTWLK2
3aW4OI/1Ons3fkuqHk47b9PskO6bUqp/pg5UxS9tJpLBB42b5bWYilCUFab1ugSC
369/odNy15/PsrLySdWski3kDjbY9T3aAykN2Hr9xFl44ymhH5bvbQk/zmED8GdS
sKvTk0zeyr9LgdhqxYXFoqS8PkiQbg/tGy/qKxdC7SQsZ4SsebhJ9FSJ3H7AoI69
4IeR17uXJDkRvmry5qvgYuX+GAvSfAgKBla8FgCXGA60Cn7Inpq/i1Ow74i95eDL
MTTUHthiG3LPFrBN+bS31oWJc9lW5Rfn1PrAvCXh7QIhK0TrleGHdOJU8BZEjS50
YrHdNPbE+1oz2nqRRAGCJ4PaTI1EdM9mgywBI1x7K39Zb8eD/jU=
=kgNB
-----END PGP SIGNATURE-----

--CtqPPqYpYc7tL2y7--
