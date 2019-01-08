Received: from eggs.gnu.org ([209.51.188.92]:43533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ggf4K-00081U-EF
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 19:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ggf4H-00082h-CA
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 19:16:32 -0500
Date: Tue, 8 Jan 2019 11:08:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190108000823.GH13339@umbus.fritz.box>
References: <20190107193020.21744-1-ehabkost@redhat.com>
	<20190107193020.21744-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ik0NlRzMGhMnxrMX"
Content-Disposition: inline
In-Reply-To: <20190107193020.21744-3-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] machine: Eliminate unnecessary
 stringify() usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, xen-devel@lists.xenproject.org


--ik0NlRzMGhMnxrMX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 05:30:19PM -0200, Eduardo Habkost wrote:
> stringify() is useful when we need to use macros in compat_props
> (like when we set virtio-baloon-pci.class=3DPCI_CLASS_MEMORY_RAM at
> pc_i440fx_1_0_machine_options()), but it is pointless when we are
> already providing a number literal.
>=20
> Replace stringify() with string literals when appropriate.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/core/machine.c |  8 ++--
>  hw/i386/pc.c      | 94 +++++++++++++++++++++++------------------------
>  hw/i386/pc_piix.c | 30 +++++++--------
>  hw/ppc/spapr.c    |  2 +-
>  4 files changed, 67 insertions(+), 67 deletions(-)
>=20
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index f8563efb86..4b4d6c23de 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -135,11 +135,11 @@ GlobalProperty hw_compat_2_8[] =3D {
>      {
>          .driver   =3D "fw_cfg_mem",
>          .property =3D "x-file-slots",
> -        .value    =3D stringify(0x10),
> +        .value    =3D "0x10",
>      },{
>          .driver   =3D "fw_cfg_io",
>          .property =3D "x-file-slots",
> -        .value    =3D stringify(0x10),
> +        .value    =3D "0x10",
>      },{
>          .driver   =3D "pflash_cfi01",
>          .property =3D "old-multiple-chip-handling",
> @@ -337,11 +337,11 @@ GlobalProperty hw_compat_2_1[] =3D {
>      },{
>          .driver   =3D "usb-mouse",
>          .property =3D "usb_version",
> -        .value    =3D stringify(1),
> +        .value    =3D "1",
>      },{
>          .driver   =3D "usb-kbd",
>          .property =3D "usb_version",
> -        .value    =3D stringify(1),
> +        .value    =3D "1",
>      },{
>          .driver   =3D "virtio-pci",
>          .property =3D "virtio-pci-bus-master-bug-migration",
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 4952feb476..ff14b6d4df 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -148,11 +148,11 @@ GlobalProperty pc_compat_2_12[] =3D {
>      },{
>          .driver   =3D "EPYC-" TYPE_X86_CPU,
>          .property =3D "xlevel",
> -        .value    =3D stringify(0x8000000a),
> +        .value    =3D "0x8000000a",
>      },{
>          .driver   =3D "EPYC-IBPB-" TYPE_X86_CPU,
>          .property =3D "xlevel",
> -        .value    =3D stringify(0x8000000a),
> +        .value    =3D "0x8000000a",
>      },
>  };
>  const size_t pc_compat_2_12_len =3D G_N_ELEMENTS(pc_compat_2_12);
> @@ -191,7 +191,7 @@ GlobalProperty pc_compat_2_9[] =3D {
>      {
>          .driver   =3D "mch",
>          .property =3D "extended-tseg-mbytes",
> -        .value    =3D stringify(0),
> +        .value    =3D "0",
>      },
>  };
>  const size_t pc_compat_2_9_len =3D G_N_ELEMENTS(pc_compat_2_9);
> @@ -365,75 +365,75 @@ GlobalProperty pc_compat_2_3[] =3D {
>      },{
>          .driver   =3D "qemu64" "-" TYPE_X86_CPU,
>          .property =3D "min-level",
> -        .value    =3D stringify(4),
> +        .value    =3D "4",
>      },{
>          .driver   =3D "kvm64" "-" TYPE_X86_CPU,
>          .property =3D "min-level",
> -        .value    =3D stringify(5),
> +        .value    =3D "5",
>      },{
>          .driver   =3D "pentium3" "-" TYPE_X86_CPU,
>          .property =3D "min-level",
> -        .value    =3D stringify(2),
> +        .value    =3D "2",
>      },{
>          .driver   =3D "n270" "-" TYPE_X86_CPU,
>          .property =3D "min-level",
> -        .value    =3D stringify(5),
> +        .value    =3D "5",
>      },{
>          .driver   =3D "Conroe" "-" TYPE_X86_CPU,
>          .property =3D "min-level",
> -        .value    =3D stringify(4),
> +        .value    =3D "4",
>      },{
>          .driver   =3D "Penryn" "-" TYPE_X86_CPU,
>          .property =3D "min-level",
> -        .value    =3D stringify(4),
> +        .value    =3D "4",
>      },{
>          .driver   =3D "Nehalem" "-" TYPE_X86_CPU,
>          .property =3D "min-level",
> -        .value    =3D stringify(4),
> +        .value    =3D "4",
>      },{
>          .driver   =3D "n270" "-" TYPE_X86_CPU,
>          .property =3D "min-xlevel",
> -        .value    =3D stringify(0x8000000a),
> +        .value    =3D "0x8000000a",
>      },{
>          .driver   =3D "Penryn" "-" TYPE_X86_CPU,
>          .property =3D "min-xlevel",
> -        .value    =3D stringify(0x8000000a),
> +        .value    =3D "0x8000000a",
>      },{
>          .driver   =3D "Conroe" "-" TYPE_X86_CPU,
>          .property =3D "min-xlevel",
> -        .value    =3D stringify(0x8000000a),
> +        .value    =3D "0x8000000a",
>      },{
>          .driver   =3D "Nehalem" "-" TYPE_X86_CPU,
>          .property =3D "min-xlevel",
> -        .value    =3D stringify(0x8000000a),
> +        .value    =3D "0x8000000a",
>      },{
>          .driver   =3D "Westmere" "-" TYPE_X86_CPU,
>          .property =3D "min-xlevel",
> -        .value    =3D stringify(0x8000000a),
> +        .value    =3D "0x8000000a",
>      },{
>          .driver   =3D "SandyBridge" "-" TYPE_X86_CPU,
>          .property =3D "min-xlevel",
> -        .value    =3D stringify(0x8000000a),
> +        .value    =3D "0x8000000a",
>      },{
>          .driver   =3D "IvyBridge" "-" TYPE_X86_CPU,
>          .property =3D "min-xlevel",
> -        .value    =3D stringify(0x8000000a),
> +        .value    =3D "0x8000000a",
>      },{
>          .driver   =3D "Haswell" "-" TYPE_X86_CPU,
>          .property =3D "min-xlevel",
> -        .value    =3D stringify(0x8000000a),
> +        .value    =3D "0x8000000a",
>      },{
>          .driver   =3D "Haswell-noTSX" "-" TYPE_X86_CPU,
>          .property =3D "min-xlevel",
> -        .value    =3D stringify(0x8000000a),
> +        .value    =3D "0x8000000a",
>      },{
>          .driver   =3D "Broadwell" "-" TYPE_X86_CPU,
>          .property =3D "min-xlevel",
> -        .value    =3D stringify(0x8000000a),
> +        .value    =3D "0x8000000a",
>      },{
>          .driver   =3D "Broadwell-noTSX" "-" TYPE_X86_CPU,
>          .property =3D "min-xlevel",
> -        .value    =3D stringify(0x8000000a),
> +        .value    =3D "0x8000000a",
>      },{
>          .driver =3D TYPE_X86_CPU,
>          .property =3D "kvm-no-smi-migration",
> @@ -566,7 +566,7 @@ GlobalProperty pc_compat_2_0[] =3D {
>      {
>          .driver   =3D "apic",
>          .property =3D "version",
> -        .value    =3D stringify(0x11),
> +        .value    =3D "0x11",
>      },
>      {
>          .driver   =3D "nec-usb-xhci",
> @@ -581,17 +581,17 @@ GlobalProperty pc_compat_2_0[] =3D {
>      {
>          .driver   =3D "pci-serial",
>          .property =3D "prog_if",
> -        .value    =3D stringify(0),
> +        .value    =3D "0",
>      },
>      {
>          .driver   =3D "pci-serial-2x",
>          .property =3D "prog_if",
> -        .value    =3D stringify(0),
> +        .value    =3D "0",
>      },
>      {
>          .driver   =3D "pci-serial-4x",
>          .property =3D "prog_if",
> -        .value    =3D stringify(0),
> +        .value    =3D "0",
>      },
>      {
>          .driver   =3D "virtio-net-pci",
> @@ -629,7 +629,7 @@ GlobalProperty pc_compat_1_7[] =3D {
>      {
>          .driver   =3D "hpet",
>          .property =3D HPET_INTCAP,
> -        .value    =3D stringify(4),
> +        .value    =3D "4",
>      },
>  };
>  const size_t pc_compat_1_7_len =3D G_N_ELEMENTS(pc_compat_1_7);
> @@ -643,19 +643,19 @@ GlobalProperty pc_compat_1_6[] =3D {
>      },{
>          .driver   =3D "qemu64-" TYPE_X86_CPU,
>          .property =3D "model",
> -        .value    =3D stringify(2),
> +        .value    =3D "2",
>      },{
>          .driver   =3D "qemu32-" TYPE_X86_CPU,
>          .property =3D "model",
> -        .value    =3D stringify(3),
> +        .value    =3D "3",
>      },{
>          .driver   =3D "i440FX-pcihost",
>          .property =3D "short_root_bus",
> -        .value    =3D stringify(1),
> +        .value    =3D "1",
>      },{
>          .driver   =3D "q35-pcihost",
>          .property =3D "short_root_bus",
> -        .value    =3D stringify(1),
> +        .value    =3D "1",
>      },
>  };
>  const size_t pc_compat_1_6_len =3D G_N_ELEMENTS(pc_compat_1_6);
> @@ -665,27 +665,27 @@ GlobalProperty pc_compat_1_5[] =3D {
>      {
>          .driver   =3D "Conroe-" TYPE_X86_CPU,
>          .property =3D "model",
> -        .value    =3D stringify(2),
> +        .value    =3D "2",
>      },{
>          .driver   =3D "Conroe-" TYPE_X86_CPU,
>          .property =3D "min-level",
> -        .value    =3D stringify(2),
> +        .value    =3D "2",
>      },{
>          .driver   =3D "Penryn-" TYPE_X86_CPU,
>          .property =3D "model",
> -        .value    =3D stringify(2),
> +        .value    =3D "2",
>      },{
>          .driver   =3D "Penryn-" TYPE_X86_CPU,
>          .property =3D "min-level",
> -        .value    =3D stringify(2),
> +        .value    =3D "2",
>      },{
>          .driver   =3D "Nehalem-" TYPE_X86_CPU,
>          .property =3D "model",
> -        .value    =3D stringify(2),
> +        .value    =3D "2",
>      },{
>          .driver   =3D "Nehalem-" TYPE_X86_CPU,
>          .property =3D "min-level",
> -        .value    =3D stringify(2),
> +        .value    =3D "2",
>      },{
>          .driver   =3D "virtio-net-pci",
>          .property =3D "any_layout",
> @@ -697,11 +697,11 @@ GlobalProperty pc_compat_1_5[] =3D {
>      },{
>          .driver   =3D "i440FX-pcihost",
>          .property =3D "short_root_bus",
> -        .value    =3D stringify(0),
> +        .value    =3D "0",
>      },{
>          .driver   =3D "q35-pcihost",
>          .property =3D "short_root_bus",
> -        .value    =3D stringify(0),
> +        .value    =3D "0",
>      },
>  };
>  const size_t pc_compat_1_5_len =3D G_N_ELEMENTS(pc_compat_1_5);
> @@ -711,36 +711,36 @@ GlobalProperty pc_compat_1_4[] =3D {
>      {
>          .driver   =3D "scsi-hd",
>          .property =3D "discard_granularity",
> -        .value    =3D stringify(0),
> +        .value    =3D "0",
>      },{
>          .driver   =3D "scsi-cd",
>          .property =3D "discard_granularity",
> -        .value    =3D stringify(0),
> +        .value    =3D "0",
>      },{
>          .driver   =3D "scsi-disk",
>          .property =3D "discard_granularity",
> -        .value    =3D stringify(0),
> +        .value    =3D "0",
>      },{
>          .driver   =3D "ide-hd",
>          .property =3D "discard_granularity",
> -        .value    =3D stringify(0),
> +        .value    =3D "0",
>      },{
>          .driver   =3D "ide-cd",
>          .property =3D "discard_granularity",
> -        .value    =3D stringify(0),
> +        .value    =3D "0",
>      },{
>          .driver   =3D "ide-drive",
>          .property =3D "discard_granularity",
> -        .value    =3D stringify(0),
> +        .value    =3D "0",
>      },{
>          .driver   =3D "virtio-blk-pci",
>          .property =3D "discard_granularity",
> -        .value    =3D stringify(0),
> +        .value    =3D "0",
>      },{
>          .driver   =3D "virtio-serial-pci",
>          .property =3D "vectors",
>          /* DEV_NVECTORS_UNSPECIFIED as a uint32_t string */
> -        .value    =3D stringify(0xFFFFFFFF),
> +        .value    =3D "0xFFFFFFFF",
>      },{
>          .driver   =3D "virtio-net-pci",
>          .property =3D "ctrl_guest_offloads",
> @@ -768,7 +768,7 @@ GlobalProperty pc_compat_1_4[] =3D {
>      },{
>          .driver   =3D "486-" TYPE_X86_CPU,
>          .property =3D "model",
> -        .value    =3D stringify(0),
> +        .value    =3D "0",
>      },
>      {
>          .driver =3D "n270" "-" TYPE_X86_CPU,
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index ed6984638e..fd20227af3 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -697,7 +697,7 @@ static void pc_i440fx_1_3_machine_options(MachineClas=
s *m)
>          {
>              .driver   =3D "usb-tablet",
>              .property =3D "usb_version",
> -            .value    =3D stringify(1),
> +            .value    =3D "1",
>          },{
>              .driver   =3D "virtio-net-pci",
>              .property =3D "ctrl_mac_addr",
> @@ -741,11 +741,11 @@ static void pc_i440fx_1_2_machine_options(MachineCl=
ass *m)
>          },{
>              .driver   =3D "qxl",
>              .property =3D "revision",
> -            .value    =3D stringify(3),
> +            .value    =3D "3",
>          },{
>              .driver   =3D "qxl-vga",
>              .property =3D "revision",
> -            .value    =3D stringify(3),
> +            .value    =3D "3",
>          },{
>              .driver   =3D "VGA",
>              .property =3D "mmio",
> @@ -777,19 +777,19 @@ static void pc_i440fx_1_1_machine_options(MachineCl=
ass *m)
>          },{
>              .driver   =3D "VGA",
>              .property =3D "vgamem_mb",
> -            .value    =3D stringify(8),
> +            .value    =3D "8",
>          },{
>              .driver   =3D "vmware-svga",
>              .property =3D "vgamem_mb",
> -            .value    =3D stringify(8),
> +            .value    =3D "8",
>          },{
>              .driver   =3D "qxl-vga",
>              .property =3D "vgamem_mb",
> -            .value    =3D stringify(8),
> +            .value    =3D "8",
>          },{
>              .driver   =3D "qxl",
>              .property =3D "vgamem_mb",
> -            .value    =3D stringify(8),
> +            .value    =3D "8",
>          },{
>              .driver   =3D "virtio-blk-pci",
>              .property =3D "config-wce",
> @@ -876,11 +876,11 @@ static void pc_i440fx_0_14_machine_options(MachineC=
lass *m)
>          },{
>              .driver   =3D "qxl",
>              .property =3D "revision",
> -            .value    =3D stringify(2),
> +            .value    =3D "2",
>          },{
>              .driver   =3D "qxl-vga",
>              .property =3D "revision",
> -            .value    =3D stringify(2),
> +            .value    =3D "2",
>          },
>      };
> =20
> @@ -904,19 +904,19 @@ static void pc_i440fx_0_13_machine_options(MachineC=
lass *m)
>          },{
>              .driver   =3D "AC97",
>              .property =3D "use_broken_id",
> -            .value    =3D stringify(1),
> +            .value    =3D "1",
>          },{
>              .driver   =3D "virtio-9p-pci",
>              .property =3D "vectors",
> -            .value    =3D stringify(0),
> +            .value    =3D "0",
>          },{
>              .driver   =3D "VGA",
>              .property =3D "rombar",
> -            .value    =3D stringify(0),
> +            .value    =3D "0",
>          },{
>              .driver   =3D "vmware-svga",
>              .property =3D "rombar",
> -            .value    =3D stringify(0),
> +            .value    =3D "0",
>          },
>      };
> =20
> @@ -936,11 +936,11 @@ static void pc_i440fx_0_12_machine_options(MachineC=
lass *m)
>          {
>              .driver   =3D "virtio-serial-pci",
>              .property =3D "max_ports",
> -            .value    =3D stringify(1),
> +            .value    =3D "1",
>          },{
>              .driver   =3D "virtio-serial-pci",
>              .property =3D "vectors",
> -            .value    =3D stringify(0),
> +            .value    =3D "0",
>          },{
>              .driver   =3D "usb-mouse",
>              .property =3D "serial",
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index bff42f0adb..d7d87b0ae8 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4264,7 +4264,7 @@ static void spapr_machine_2_6_class_options(Machine=
Class *mc)
>          {
>              .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
>              .property =3D "ddw",
> -            .value    =3D stringify(off),
> +            .value    =3D "off",
>          },
>      };
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ik0NlRzMGhMnxrMX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwz6fcACgkQbDjKyiDZ
s5JihA/+MMEu2dLoAvJEtlAd7YcOMqsA/ZxiiILBfqMC8PMEzRHvkCZvnZyS0e3h
PWPUZBwOYqBJnF8XnTn2oinl2L59vKBZgxAMhwEVh+VIlHrVtnlV/H/o+E9RXvG0
6O6KboBBGuedUi2+LgIIA+MOdELJOQclNXUm1BbR3awX7R2mQZ0vPN/KrV31U6Fc
HSZSpKJIsXDJ0LWuxXCJSyfxJnPS9hNNMqnouLjZp1GZr8vavrDrddVHTUKqfWnJ
3FdDMtkfhAQstNTakfIf8g3nWxtrEfWqg3dU1uNQ299ZJqF7MpVFcaN6LX+jdrxU
n1Y/C7OY4FVRe9xN8urVKG/r/T2afuaGYb0fimIVD+xbvznrAT23PN3wg/T+vZUt
yXH8cNDsfStTChSe28YqmybhMgDspQJq3wo/M2ZYg2khF8z+BiczdMGrDygfqfE9
9cu8Yzlv39BnVeDEcgXS2fILXlmBz7grv7r5l0FlbZVcZ+zZR5CQa/HvxsTkzyGq
//cJMtuXQkpGjK22sA7OOAqOfdywJFQie1P1z07LWhDVSfkAMCAmGUQfaXC7+RlM
vAo7hJ9gKsDN7D7gufr/9+WdNskz6tpCMxvyC1N4EoT2AItbhcU2p8ivv1PV7Yj8
NI3nI1vWIRCcDWY2uQLu8FirGiA/gzDB6j21eMoxxWnFGkkqKhE=
=ibsj
-----END PGP SIGNATURE-----

--ik0NlRzMGhMnxrMX--
