Received: from eggs.gnu.org ([2001:4830:134:3::10]:41092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etQTF-0001Qm-6I
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 23:14:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etQTC-00071R-UB
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 23:14:29 -0500
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:37100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etQTC-00071A-LY
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 23:14:26 -0500
Received: by mail-ot0-x235.google.com with SMTP id t2so877916otj.4
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 20:14:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8787c302-b90a-df1f-9eb3-3ee16022a92e@amsat.org>
References: <1520369037-37977-1-git-send-email-mjc@sifive.com>
	<1520369037-37977-8-git-send-email-mjc@sifive.com>
	<8787c302-b90a-df1f-9eb3-3ee16022a92e@amsat.org>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 7 Mar 2018 17:14:25 +1300
Message-ID: <CAHNT7Nvm2L52Rt+EquCsLa9itaNb1GDo2xDDN9UtvhrC_5JKRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 07/22] RISC-V: Remove unused class
 definitions from
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches machines <patches@groups.riscv.org>

On Wed, Mar 7, 2018 at 12:27 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> Hi Michael,
>
> On 03/06/2018 05:43 PM, Michael Clark wrote:
> > Removes a whole lot of unnecessary boilerplate code. Machines
> > don't need to be objects. The expansion of the SOC object model
> > for the RISC-V machines will happen in the future as SiFive
> > plans to add their FE310 and FU540 SOCs to QEMU. However, it
> > seems that this present boilerplate is complete unnecessary.
> >
> > Signed-off-by: Michael Clark <mjc@sifive.com>
> > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> > ---
> >  hw/riscv/sifive_e.c         | 25 -------------------------
> >  hw/riscv/sifive_u.c         | 25 -------------------------
> >  hw/riscv/spike.c            | 20 --------------------
> >  hw/riscv/virt.c             | 25 -------------------------
> >  include/hw/riscv/sifive_e.h |  9 ---------
> >  include/hw/riscv/sifive_u.h |  9 ---------
> >  include/hw/riscv/virt.h     |  9 ---------
> >  7 files changed, 122 deletions(-)
> >
> > diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> > index 09c9d49..4872b68 100644
> > --- a/hw/riscv/sifive_e.c
> > +++ b/hw/riscv/sifive_e.c
> > @@ -194,24 +194,6 @@ static void riscv_sifive_e_init(MachineState
> *machine)
> >      }
> >  }
> >
> > -static int riscv_sifive_e_sysbus_device_init(SysBusDevice *sysbusdev)
> > -{
> > -    return 0;
> > -}
> > -
> > -static void riscv_sifive_e_class_init(ObjectClass *klass, void *data)
> > -{
> > -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> > -    k->init =3D riscv_sifive_e_sysbus_device_init;
> > -}
> > -
> > -static const TypeInfo riscv_sifive_e_device =3D {
> > -    .name          =3D TYPE_SIFIVE_E,
> > -    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > -    .instance_size =3D sizeof(SiFiveEState),
> > -    .class_init    =3D riscv_sifive_e_class_init,
> > -};
> > -
> >  static void riscv_sifive_e_machine_init(MachineClass *mc)
> >  {
> >      mc->desc =3D "RISC-V Board compatible with SiFive E SDK";
> > @@ -220,10 +202,3 @@ static void riscv_sifive_e_machine_init(MachineCla=
ss
> *mc)
> >  }
> >
> >  DEFINE_MACHINE("sifive_e", riscv_sifive_e_machine_init)
> > -
> > -static void riscv_sifive_e_register_types(void)
> > -{
> > -    type_register_static(&riscv_sifive_e_device);
> > -}
> > -
> > -type_init(riscv_sifive_e_register_types);
> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > index 25df16c..083043a 100644
> > --- a/hw/riscv/sifive_u.c
> > +++ b/hw/riscv/sifive_u.c
> > @@ -302,31 +302,6 @@ static void riscv_sifive_u_init(MachineState
> *machine)
> >          SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
> >  }
> >
> > -static int riscv_sifive_u_sysbus_device_init(SysBusDevice *sysbusdev)
> > -{
> > -    return 0;
> > -}
> > -
> > -static void riscv_sifive_u_class_init(ObjectClass *klass, void *data)
> > -{
> > -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> > -    k->init =3D riscv_sifive_u_sysbus_device_init;
> > -}
> > -
> > -static const TypeInfo riscv_sifive_u_device =3D {
> > -    .name          =3D TYPE_SIFIVE_U,
> > -    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > -    .instance_size =3D sizeof(SiFiveUState),
> > -    .class_init    =3D riscv_sifive_u_class_init,
> > -};
> > -
> > -static void riscv_sifive_u_register_types(void)
> > -{
> > -    type_register_static(&riscv_sifive_u_device);
> > -}
> > -
> > -type_init(riscv_sifive_u_register_types);
> > -
> >  static void riscv_sifive_u_machine_init(MachineClass *mc)
> >  {
> >      mc->desc =3D "RISC-V Board compatible with SiFive U SDK";
> > diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> > index 74edf33..64e585e 100644
> > --- a/hw/riscv/spike.c
> > +++ b/hw/riscv/spike.c
> > @@ -336,18 +336,6 @@ static void spike_v1_09_1_board_init(MachineState
> *machine)
> >          smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE,
> SIFIVE_TIME_BASE);
> >  }
> >
> > -static const TypeInfo spike_v_1_09_1_device =3D {
> > -    .name          =3D TYPE_RISCV_SPIKE_V1_09_1_BOARD,
> > -    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > -    .instance_size =3D sizeof(SpikeState),
> > -};
> > -
> > -static const TypeInfo spike_v_1_10_0_device =3D {
> > -    .name          =3D TYPE_RISCV_SPIKE_V1_10_0_BOARD,
> > -    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > -    .instance_size =3D sizeof(SpikeState),
> > -};
> > -
> >  static void spike_v1_09_1_machine_init(MachineClass *mc)
> >  {
> >      mc->desc =3D "RISC-V Spike Board (Privileged ISA v1.9.1)";
> > @@ -365,11 +353,3 @@ static void spike_v1_10_0_machine_init(MachineClas=
s
> *mc)
> >
> >  DEFINE_MACHINE("spike_v1.9.1", spike_v1_09_1_machine_init)
> >  DEFINE_MACHINE("spike_v1.10", spike_v1_10_0_machine_init)
> > -
> > -static void riscv_spike_board_register_types(void)
> > -{
> > -    type_register_static(&spike_v_1_09_1_device);
> > -    type_register_static(&spike_v_1_10_0_device);
> > -}
> > -
> > -type_init(riscv_spike_board_register_types);
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index f1e3641..5913100 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -380,24 +380,6 @@ static void riscv_virt_board_init(MachineState
> *machine)
> >          serial_hds[0], DEVICE_LITTLE_ENDIAN);
> >  }
> >
> > -static int riscv_virt_board_sysbus_device_init(SysBusDevice *sysbusdev=
)
> > -{
> > -    return 0;
> > -}
> > -
> > -static void riscv_virt_board_class_init(ObjectClass *klass, void *data=
)
> > -{
> > -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> > -    k->init =3D riscv_virt_board_sysbus_device_init;
> > -}
> > -
> > -static const TypeInfo riscv_virt_board_device =3D {
> > -    .name          =3D TYPE_RISCV_VIRT_BOARD,
> > -    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > -    .instance_size =3D sizeof(RISCVVirtState),
> > -    .class_init    =3D riscv_virt_board_class_init,
> > -};
> > -
> >  static void riscv_virt_board_machine_init(MachineClass *mc)
> >  {
> >      mc->desc =3D "RISC-V VirtIO Board (Privileged ISA v1.10)";
> > @@ -406,10 +388,3 @@ static void riscv_virt_board_machine_init(MachineC=
lass
> *mc)
> >  }
> >
> >  DEFINE_MACHINE("virt", riscv_virt_board_machine_init)
> > -
> > -static void riscv_virt_board_register_types(void)
> > -{
> > -    type_register_static(&riscv_virt_board_device);
> > -}
> > -
> > -type_init(riscv_virt_board_register_types);
>
> Ok until here.
>
> > diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
> > index 0aebc57..818fbdc 100644
> > --- a/include/hw/riscv/sifive_e.h
> > +++ b/include/hw/riscv/sifive_e.h
> > @@ -19,16 +19,7 @@
> >  #ifndef HW_SIFIVE_E_H
> >  #define HW_SIFIVE_E_H
> >
> > -#define TYPE_SIFIVE_E "riscv.sifive_e"
> > -
> > -#define SIFIVE_E(obj) \
> > -    OBJECT_CHECK(SiFiveEState, (obj), TYPE_SIFIVE_E)
> > -
> >  typedef struct SiFiveEState {
> > -    /*< private >*/
> > -    SysBusDevice parent_obj;
>
> I'd keep however a 'Object parent_obj' here, to stay QOM; but your patch
> is valid.
>

Okay I'll keep parent_obj when I respin.

Thanks,
Michael.

> -
> > -    /*< public >*/
> >      RISCVHartArrayState soc;
> >      DeviceState *plic;
> >  } SiFiveEState;
> > diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> > index be38aa0..8ebd545 100644
> > --- a/include/hw/riscv/sifive_u.h
> > +++ b/include/hw/riscv/sifive_u.h
> > @@ -19,16 +19,7 @@
> >  #ifndef HW_SIFIVE_U_H
> >  #define HW_SIFIVE_U_H
> >
> > -#define TYPE_SIFIVE_U "riscv.sifive_u"
> > -
> > -#define SIFIVE_U(obj) \
> > -    OBJECT_CHECK(SiFiveUState, (obj), TYPE_SIFIVE_U)
> > -
> >  typedef struct SiFiveUState {
> > -    /*< private >*/
> > -    SysBusDevice parent_obj;
> > -
> > -    /*< public >*/
> >      RISCVHartArrayState soc;
> >      DeviceState *plic;
> >      void *fdt;
> > diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> > index 655e85d..9588909 100644
> > --- a/include/hw/riscv/virt.h
> > +++ b/include/hw/riscv/virt.h
> > @@ -19,15 +19,7 @@
> >  #ifndef HW_VIRT_H
> >  #define HW_VIRT_H
> >
> > -#define TYPE_RISCV_VIRT_BOARD "riscv.virt"
> > -#define VIRT(obj) \
> > -    OBJECT_CHECK(RISCVVirtState, (obj), TYPE_RISCV_VIRT_BOARD)
> > -
> >  typedef struct {
> > -    /*< private >*/
> > -    SysBusDevice parent_obj;
> > -
> > -    /*< public >*/
> >      RISCVHartArrayState soc;
> >      DeviceState *plic;
> >      void *fdt;
> > @@ -45,7 +37,6 @@ enum {
> >      VIRT_DRAM
> >  };
> >
> > -
> >  enum {
> >      UART0_IRQ =3D 10,
> >      VIRTIO_IRQ =3D 1, /* 1 to 8 */
> >
>
