Received: from eggs.gnu.org ([209.51.188.92]:34742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ggafo-0003P4-5g
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 14:34:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ggafm-0005R8-Ha
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 14:34:56 -0500
MIME-Version: 1.0
References: <20190107193020.21744-1-ehabkost@redhat.com>
	<20190107193020.21744-3-ehabkost@redhat.com>
In-Reply-To: <20190107193020.21744-3-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 7 Jan 2019 23:34:41 +0400
Message-ID: <CAJ+F1CLoDOPncYAm3BR+TD8ZM9tq0jQ+sk=DaZTmA3JwBC0-SQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: QEMU <qemu-devel@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Qemu-s390x list <qemu-s390x@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

On Mon, Jan 7, 2019 at 11:32 PM Eduardo Habkost <ehabkost@redhat.com> wrote=
:
>
> stringify() is useful when we need to use macros in compat_props
> (like when we set virtio-baloon-pci.class=3DPCI_CLASS_MEMORY_RAM at
> pc_i440fx_1_0_machine_options()), but it is pointless when we are
> already providing a number literal.
>
> Replace stringify() with string literals when appropriate.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/core/machine.c |  8 ++--
>  hw/i386/pc.c      | 94 +++++++++++++++++++++++------------------------
>  hw/i386/pc_piix.c | 30 +++++++--------
>  hw/ppc/spapr.c    |  2 +-
>  4 files changed, 67 insertions(+), 67 deletions(-)
>
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
>
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
>
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
>
> --
> 2.18.0.rc1.1.g3f1ff2140
>
>


--=20
Marc-Andr=C3=A9 Lureau
