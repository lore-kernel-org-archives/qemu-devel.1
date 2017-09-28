Received: from eggs.gnu.org ([2001:4830:134:3::10]:53985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dxQCV-0000dv-A7
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 00:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dxQCU-0003WJ-8Z
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 00:13:27 -0400
Received: from ozlabs.org ([103.22.144.67]:42939)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dxQCT-0003VR-TR
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 00:13:26 -0400
Date: Thu, 28 Sep 2017 14:13:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170928041308.GD12504@umbus>
References: <20170927195635.16014-1-ehabkost@redhat.com>
	<20170927195635.16014-6-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i3WE5m5QLioBhvvb"
Content-Disposition: inline
In-Reply-To: <20170927195635.16014-6-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] pci: Validate interfaces on
 base_class_init
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


--i3WE5m5QLioBhvvb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2017 at 04:56:35PM -0300, Eduardo Habkost wrote:
> Make sure we don't forget to add the Conventional PCI or PCI
> Express interface names on PCI device classes in the future.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Revieed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes v1 -> v2:
> * s/legacy/conventional/
>   * Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  hw/pci/pci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 1b08e18205..5ed3c8dca4 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2547,6 +2547,17 @@ static void pci_device_class_init(ObjectClass *kla=
ss, void *data)
>      pc->realize =3D pci_default_realize;
>  }
> =20
> +static void pci_device_class_base_init(ObjectClass *klass, void *data)
> +{
> +    if (!object_class_is_abstract(klass)) {
> +        ObjectClass *conventional =3D
> +            object_class_dynamic_cast(klass, INTERFACE_CONVENTIONAL_PCI_=
DEVICE);
> +        ObjectClass *pcie =3D
> +            object_class_dynamic_cast(klass, INTERFACE_PCIE_DEVICE);
> +        assert(conventional || pcie);
> +    }
> +}
> +
>  AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>  {
>      PCIBus *bus =3D PCI_BUS(dev->bus);
> @@ -2671,6 +2682,7 @@ static const TypeInfo pci_device_type_info =3D {
>      .abstract =3D true,
>      .class_size =3D sizeof(PCIDeviceClass),
>      .class_init =3D pci_device_class_init,
> +    .class_base_init =3D pci_device_class_base_init,
>  };
> =20
>  static void pci_register_types(void)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--i3WE5m5QLioBhvvb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnMdtQACgkQbDjKyiDZ
s5INgQ/6A9w8WOtVWpsw1iX5VNxXr4c6Ihm6cve4AMSe7Va9R7TcLGDjWiWWr7so
Ra1cet/9lfoCqdksuYs0OWIbMALqfPDHENiwuvutnzNu76HZRZ/OllX2F/kghgUj
Om7mZXIzreZBPijprjstSJrmP1hJXSp/3+AhmDMQW/7ExkO1ZCytkmErNKlwMTFQ
0NHAAy5e0Um4pbZdKRYZJko70Py9e/PMeH+qQOA3Kxxhq5RHD7ewEG9H/dgA7J3Y
cluHX8gn22EJsNez58MhPYfIg15zyZ2dyI/RLA9Yc2lyM1cSgyenpkcjhvDIVcYB
LUU2xr3giDiP5DJMvsethurqPfhUfYs6PwP/wgl9AyC6Fi/jj7q+UA5t33aoAdVM
NtxVo1sno2rZv70NseQ/LDXLamKZwkFlXJZm9iOdStJptSJGIm8Uat+VMLfqPv0W
sG76iA9lsWhhyvMTQ0ng3BShAN+nqqh9QGANZsuyloG/pyDcJ2o7vCsibc8jcciG
RtSHSHi94wlVqavK6od0rjjRf5WvvriUozhUAC7Xi/NJYtd4w4xKFQvIzB8UIQVh
a6aRQ+Vtoqht5fYhij5TsMGhToKDFy7r8mqJkhGZa4sW4C0BBhayRnl/mMIG5uMN
rpi6eBlRv3Gzo5WiMvT5RZSqHXTw+LS3kzi/4Dy8MDhvr6yTeIY=
=V3Oj
-----END PGP SIGNATURE-----

--i3WE5m5QLioBhvvb--
