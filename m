Received: from eggs.gnu.org ([2001:4830:134:3::10]:54031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dxQCY-0000fy-GD
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 00:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dxQCW-0003Xp-Rx
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 00:13:30 -0400
Date: Thu, 28 Sep 2017 14:10:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170928041056.GB12504@umbus>
References: <20170927195635.16014-1-ehabkost@redhat.com>
	<20170927195635.16014-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TIEGfCGDzZzDroj5"
Content-Disposition: inline
In-Reply-To: <20170927195635.16014-4-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] pci: Add INTERFACE_PCIE_DEVICE to
 all PCIe devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <dgibson@redhat.com>, Alistair Francis <alistair23@gmail.com>, Laine Stump <laine@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>, Paul Burton <paul.burton@imgtec.com>, Paolo Bonzini <pbonzini@redhat.com>, Hannes Reinecke <hare@suse.com>, qemu-block@nongnu.org


--TIEGfCGDzZzDroj5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2017 at 04:56:33PM -0300, Eduardo Habkost wrote:
> Change all devices that set is_express=3D1 to implement
> INTERFACE_PCIE_DEVICE.
>=20
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Dmitry Fleytman <dmitry@daynix.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: qemu-block@nongnu.org
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes v1 -> v2:
> * base-xhci is marked as hybrid, now (in another patch)
> * Included pcie-pci-bridge
> ---
>  hw/block/nvme.c                    | 4 ++++
>  hw/net/e1000e.c                    | 4 ++++
>  hw/pci-bridge/pcie_pci_bridge.c    | 1 +
>  hw/pci-bridge/pcie_root_port.c     | 4 ++++
>  hw/pci-bridge/xio3130_downstream.c | 4 ++++
>  hw/pci-bridge/xio3130_upstream.c   | 4 ++++
>  hw/pci-host/xilinx-pcie.c          | 4 ++++
>  hw/scsi/megasas.c                  | 6 ++++++
>  8 files changed, 31 insertions(+)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 9aa32692a3..441e21ed1f 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1110,6 +1110,10 @@ static const TypeInfo nvme_info =3D {
>      .instance_size =3D sizeof(NvmeCtrl),
>      .class_init    =3D nvme_class_init,
>      .instance_init =3D nvme_instance_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { }
> +    },
>  };
> =20
>  static void nvme_register_types(void)
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index 6c42b4478c..81f7934a59 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -708,6 +708,10 @@ static const TypeInfo e1000e_info =3D {
>      .instance_size =3D sizeof(E1000EState),
>      .class_init =3D e1000e_class_init,
>      .instance_init =3D e1000e_instance_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { }
> +    },
>  };
> =20
>  static void e1000e_register_types(void)
> diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bri=
dge.c
> index 9aa5cc3e45..88db143633 100644
> --- a/hw/pci-bridge/pcie_pci_bridge.c
> +++ b/hw/pci-bridge/pcie_pci_bridge.c
> @@ -180,6 +180,7 @@ static const TypeInfo pcie_pci_bridge_info =3D {
>          .class_init =3D pcie_pci_bridge_class_init,
>          .interfaces =3D (InterfaceInfo[]) {
>              { TYPE_HOTPLUG_HANDLER },
> +            { INTERFACE_PCIE_DEVICE },
>              { },
>          }
>  };
> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_por=
t.c
> index 4d588cb22e..9b6e4ce512 100644
> --- a/hw/pci-bridge/pcie_root_port.c
> +++ b/hw/pci-bridge/pcie_root_port.c
> @@ -161,6 +161,10 @@ static const TypeInfo rp_info =3D {
>      .class_init    =3D rp_class_init,
>      .abstract      =3D true,
>      .class_size =3D sizeof(PCIERootPortClass),
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { }
> +    },
>  };
> =20
>  static void rp_register_types(void)
> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_d=
ownstream.c
> index e706f36cb7..7d2f7629c1 100644
> --- a/hw/pci-bridge/xio3130_downstream.c
> +++ b/hw/pci-bridge/xio3130_downstream.c
> @@ -195,6 +195,10 @@ static const TypeInfo xio3130_downstream_info =3D {
>      .name          =3D "xio3130-downstream",
>      .parent        =3D TYPE_PCIE_SLOT,
>      .class_init    =3D xio3130_downstream_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { }
> +    },
>  };
> =20
>  static void xio3130_downstream_register_types(void)
> diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_ups=
tream.c
> index a052224bbf..227997ce46 100644
> --- a/hw/pci-bridge/xio3130_upstream.c
> +++ b/hw/pci-bridge/xio3130_upstream.c
> @@ -166,6 +166,10 @@ static const TypeInfo xio3130_upstream_info =3D {
>      .name          =3D "x3130-upstream",
>      .parent        =3D TYPE_PCIE_PORT,
>      .class_init    =3D xio3130_upstream_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { }
> +    },
>  };
> =20
>  static void xio3130_upstream_register_types(void)
> diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
> index 4613dda1d2..7659253090 100644
> --- a/hw/pci-host/xilinx-pcie.c
> +++ b/hw/pci-host/xilinx-pcie.c
> @@ -317,6 +317,10 @@ static const TypeInfo xilinx_pcie_root_info =3D {
>      .parent =3D TYPE_PCI_BRIDGE,
>      .instance_size =3D sizeof(XilinxPCIERoot),
>      .class_init =3D xilinx_pcie_root_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { }
> +    },
>  };
> =20
>  static void xilinx_pcie_register(void)
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index 0db68aacee..535ee267c3 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -2451,6 +2451,7 @@ typedef struct MegasasInfo {
>      int osts;
>      const VMStateDescription *vmsd;
>      Property *props;
> +    InterfaceInfo *interfaces;
>  } MegasasInfo;
> =20
>  static struct MegasasInfo megasas_devices[] =3D {
> @@ -2480,6 +2481,10 @@ static struct MegasasInfo megasas_devices[] =3D {
>          .is_express =3D true,
>          .vmsd =3D &vmstate_megasas_gen2,
>          .props =3D megasas_properties_gen2,
> +        .interfaces =3D (InterfaceInfo[]) {
> +            { INTERFACE_PCIE_DEVICE },
> +            { }
> +        },
>      }
>  };
> =20
> @@ -2531,6 +2536,7 @@ static void megasas_register_types(void)
>          type_info.parent =3D TYPE_MEGASAS_BASE;
>          type_info.class_data =3D (void *)info;
>          type_info.class_init =3D megasas_class_init;
> +        type_info.interfaces =3D info->interfaces;
> =20
>          type_register(&type_info);
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TIEGfCGDzZzDroj5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnMdlAACgkQbDjKyiDZ
s5JicBAA2soAEu7LvBzVIA0yhuq4X4tDYh4tscRf63cmwh3uOrJDq2UqmaLqBLfq
YVpMzKbUJyFLaOYGbUmQ3lDHe/bU8bwO8f7XMb6t+24Md2oaJLbDjPzwP7AWRXbb
SDplOSNyiPO5Vi+AFO1fZ5Baz1szraP4QOJttPYhZCqoq66x6RXSDexSTN4hk/ou
VMUpftVCOXjOUOu+qCLC3D31P5/JvBU06f0bkQKeGDyD4LMlB38pt1KBjpMjoIea
ZwwIAt+RZ6BFsSlaMLTkPH4CuV7LSxzy/1BeHzvXBAULR2l7YgC+GqpQg7zkuJRr
6DUVAhQVdJr88QWJ90yWV2FwIOe5iVZAGvCStMgppzR6u/nMuY5YoirFpGr2Wi3R
WQ+pIj1TySMWqexW/wQiZCwAM/EtkqjjlAdUM6Q2LQwJZjBLNGk3Kjxt8NBUzeM0
AGW7rDLVlO/6iPxpYCQ5GED2LqHQw1O0ZiSnBPDWP3rH4vv9AlPgbSx4nqwZ2MBb
a2DBy7LTQrdxR2CauL0Q+QZXCqqY9ezVEJ43Yxbxo6Q+BqfOnx8FOShT8sVBT9vM
TaD/Ba0U5kCwS2gfK8QT3AP46nxI2GTumi5j3GxJL1b4UmKn6gXM2/PjDLLFHIOM
epAMDlOi7bdXpWEWnefEg030xTakhptZskR7pEO7hy6XuQY43a0=
=HGWl
-----END PGP SIGNATURE-----

--TIEGfCGDzZzDroj5--
