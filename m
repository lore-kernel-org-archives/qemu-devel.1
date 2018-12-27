Received: from eggs.gnu.org ([208.118.235.92]:56503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gcPKR-0007n8-7h
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:39:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gcPKN-0000kv-1Z
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:39:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gcPKM-0000Ot-NG
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:39:30 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29DA47FD4A
	for <qemu-devel@nongnu.org>; Thu, 27 Dec 2018 06:39:15 +0000 (UTC)
Date: Thu, 27 Dec 2018 07:39:07 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181227073907.4a7ccb90@Igors-MacBook-Pro.local>
In-Reply-To: <20181221090410.27250-9-marcandre.lureau@redhat.com>
References: <20181221090410.27250-1-marcandre.lureau@redhat.com>
	<20181221090410.27250-9-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 08/28] compat: replace PC_COMPAT_2_12 &
 HW_COMPAT_2_12 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com

On Fri, 21 Dec 2018 13:03:50 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Use static arrays instead.
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/boards.h        |  3 +++
>  include/hw/compat.h        | 27 ---------------------------
>  include/hw/i386/pc.h       | 21 ++-------------------
>  hw/arm/virt.c              |  5 +----
>  hw/core/machine.c          | 29 +++++++++++++++++++++++++++++
>  hw/i386/pc.c               | 21 +++++++++++++++++++++
>  hw/i386/pc_piix.c          |  7 ++-----
>  hw/i386/pc_q35.c           |  7 ++-----
>  hw/ppc/spapr.c             |  2 +-
>  hw/s390x/s390-virtio-ccw.c |  6 +-----
>  10 files changed, 62 insertions(+), 66 deletions(-)
>=20
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 6b94d36d6a..b06444ffed 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -293,4 +293,7 @@ extern const size_t hw_compat_3_1_len;
>  extern GlobalProperty hw_compat_3_0[];
>  extern const size_t hw_compat_3_0_len;
> =20
> +extern GlobalProperty hw_compat_2_12[];
> +extern const size_t hw_compat_2_12_len;
> +
>  #endif
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index c08f4040bb..13242b831a 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -1,33 +1,6 @@
>  #ifndef HW_COMPAT_H
>  #define HW_COMPAT_H
> =20
> -#define HW_COMPAT_2_12 \
> -    {\
> -        .driver   =3D "migration",\
> -        .property =3D "decompress-error-check",\
> -        .value    =3D "off",\
> -    },{\
> -        .driver   =3D "hda-audio",\
> -        .property =3D "use-timer",\
> -        .value    =3D "false",\
> -    },{\
> -        .driver   =3D "cirrus-vga",\
> -        .property =3D "global-vmstate",\
> -        .value    =3D "true",\
> -    },{\
> -        .driver   =3D "VGA",\
> -        .property =3D "global-vmstate",\
> -        .value    =3D "true",\
> -    },{\
> -        .driver   =3D "vmware-svga",\
> -        .property =3D "global-vmstate",\
> -        .value    =3D "true",\
> -    },{\
> -        .driver   =3D "qxl-vga",\
> -        .property =3D "global-vmstate",\
> -        .value    =3D "true",\
> -    },
> -
>  #define HW_COMPAT_2_11 \
>      {\
>          .driver   =3D "hpet",\
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 197131ff9a..91cb3283f0 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -300,25 +300,8 @@ extern const size_t pc_compat_3_1_len;
>  extern GlobalProperty pc_compat_3_0[];
>  extern const size_t pc_compat_3_0_len;
> =20
> -#define PC_COMPAT_2_12 \
> -    HW_COMPAT_2_12 \
> -    {\
> -        .driver   =3D TYPE_X86_CPU,\
> -        .property =3D "legacy-cache",\
> -        .value    =3D "on",\
> -    },{\
> -        .driver   =3D TYPE_X86_CPU,\
> -        .property =3D "topoext",\
> -        .value    =3D "off",\
> -    },{\
> -        .driver   =3D "EPYC-" TYPE_X86_CPU,\
> -        .property =3D "xlevel",\
> -        .value    =3D stringify(0x8000000a),\
> -    },{\
> -        .driver   =3D "EPYC-IBPB-" TYPE_X86_CPU,\
> -        .property =3D "xlevel",\
> -        .value    =3D stringify(0x8000000a),\
> -    },
> +extern GlobalProperty pc_compat_2_12[];
> +extern const size_t pc_compat_2_12_len;
> =20
>  #define PC_COMPAT_2_11 \
>      HW_COMPAT_2_11 \
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index d226e7922e..1b39d9845b 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1889,12 +1889,9 @@ DEFINE_VIRT_MACHINE(3, 0)
>  static void virt_machine_2_12_options(MachineClass *mc)
>  {
>      VirtMachineClass *vmc =3D VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> -    static GlobalProperty compat[] =3D {
> -        HW_COMPAT_2_12
> -    };
> =20
>      virt_machine_3_0_options(mc);
> -    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> +    compat_props_add(mc->compat_props, hw_compat_2_12, hw_compat_2_12_le=
n);
>      vmc->no_highmem_ecam =3D true;
>      mc->max_cpus =3D 255;
>  }
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index cd55366f2e..447fe1db6b 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -28,6 +28,35 @@ const size_t hw_compat_3_1_len =3D G_N_ELEMENTS(hw_com=
pat_3_1);
>  GlobalProperty hw_compat_3_0[] =3D {};
>  const size_t hw_compat_3_0_len =3D G_N_ELEMENTS(hw_compat_3_0);
> =20
> +GlobalProperty hw_compat_2_12[] =3D {
> +    {
> +        .driver   =3D "migration",
> +        .property =3D "decompress-error-check",
> +        .value    =3D "off",
> +    },{
> +        .driver   =3D "hda-audio",
> +        .property =3D "use-timer",
> +        .value    =3D "false",
> +    },{
> +        .driver   =3D "cirrus-vga",
> +        .property =3D "global-vmstate",
> +        .value    =3D "true",
> +    },{
> +        .driver   =3D "VGA",
> +        .property =3D "global-vmstate",
> +        .value    =3D "true",
> +    },{
> +        .driver   =3D "vmware-svga",
> +        .property =3D "global-vmstate",
> +        .value    =3D "true",
> +    },{
> +        .driver   =3D "qxl-vga",
> +        .property =3D "global-vmstate",
> +        .value    =3D "true",
> +    },
> +};
> +const size_t hw_compat_2_12_len =3D G_N_ELEMENTS(hw_compat_2_12);
> +
>  static char *machine_get_accel(Object *obj, Error **errp)
>  {
>      MachineState *ms =3D MACHINE(obj);
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 7b9271a7ff..84fe7e49af 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -129,6 +129,27 @@ GlobalProperty pc_compat_3_0[] =3D {
>  };
>  const size_t pc_compat_3_0_len =3D G_N_ELEMENTS(pc_compat_3_0);
> =20
> +GlobalProperty pc_compat_2_12[] =3D {
> +    {
> +        .driver   =3D TYPE_X86_CPU,
> +        .property =3D "legacy-cache",
> +        .value    =3D "on",
> +    },{
> +        .driver   =3D TYPE_X86_CPU,
> +        .property =3D "topoext",
> +        .value    =3D "off",
> +    },{
> +        .driver   =3D "EPYC-" TYPE_X86_CPU,
> +        .property =3D "xlevel",
> +        .value    =3D stringify(0x8000000a),
> +    },{
> +        .driver   =3D "EPYC-IBPB-" TYPE_X86_CPU,
> +        .property =3D "xlevel",
> +        .value    =3D stringify(0x8000000a),
> +    },
> +};
> +const size_t pc_compat_2_12_len =3D G_N_ELEMENTS(pc_compat_2_12);
> +
>  void gsi_handler(void *opaque, int n, int level)
>  {
>      GSIState *s =3D opaque;
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index c1a9a10911..16dda48c56 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -462,12 +462,9 @@ DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
> =20
>  static void pc_i440fx_2_12_machine_options(MachineClass *m)
>  {
> -    static GlobalProperty compat[] =3D {
> -        PC_COMPAT_2_12
> -    };
> -
>      pc_i440fx_3_0_machine_options(m);
> -    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
> +    compat_props_add(m->compat_props, hw_compat_2_12, hw_compat_2_12_len=
);
> +    compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len=
);
>  }
> =20
>  DEFINE_I440FX_MACHINE(v2_12, "pc-i440fx-2.12", NULL,
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 231b1269d1..86f08441d6 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -343,12 +343,9 @@ DEFINE_Q35_MACHINE(v3_0, "pc-q35-3.0", NULL,
> =20
>  static void pc_q35_2_12_machine_options(MachineClass *m)
>  {
> -    static GlobalProperty compat[] =3D {
> -        PC_COMPAT_2_12
> -    };
> -
>      pc_q35_3_0_machine_options(m);
> -    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
> +    compat_props_add(m->compat_props, hw_compat_2_12, hw_compat_2_12_len=
);
> +    compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len=
);
>  }
> =20
>  DEFINE_Q35_MACHINE(v2_12, "pc-q35-2.12", NULL,
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5c4c6be22f..63453f688f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3995,7 +3995,6 @@ static void spapr_machine_2_12_class_options(Machin=
eClass *mc)
>  {
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
>      static GlobalProperty compat[] =3D {
> -        HW_COMPAT_2_12
>          {
>              .driver =3D TYPE_POWERPC_CPU,
>              .property =3D "pre-3.0-migration",
> @@ -4009,6 +4008,7 @@ static void spapr_machine_2_12_class_options(Machin=
eClass *mc)
>      };
> =20
>      spapr_machine_3_0_class_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_2_12, hw_compat_2_12_le=
n);
>      compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> =20
>      /* We depend on kvm_enabled() to choose a default value for the
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index e54e6f6dd0..ce22a9d511 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -696,12 +696,8 @@ static void ccw_machine_2_12_instance_options(Machin=
eState *machine)
> =20
>  static void ccw_machine_2_12_class_options(MachineClass *mc)
>  {
> -    static GlobalProperty compat[] =3D {
> -        HW_COMPAT_2_12
> -    };
> -
>      ccw_machine_3_0_class_options(mc);
> -    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> +    compat_props_add(mc->compat_props, hw_compat_2_12, hw_compat_2_12_le=
n);
>  }
>  DEFINE_CCW_MACHINE(2_12, "2.12", false);
> =20
