Received: from eggs.gnu.org ([2001:4830:134:3::10]:59934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gX40j-0001Qf-IY
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 07:53:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gX40i-0002YB-5U
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 07:53:09 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gX40h-0002Xl-Sl
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 07:53:08 -0500
Received: by mail-wm1-x344.google.com with SMTP id m1so5031093wml.2
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 04:53:07 -0800 (PST)
MIME-Version: 1.0
References: <20181211180129.7661-1-ehabkost@redhat.com>
	<20181211180129.7661-14-ehabkost@redhat.com>
	<CAJ+F1CKq3wk_DMLtxFG316ZUuGELgytHVBuUYqGim7T=JjtZcA@mail.gmail.com>
In-Reply-To: <CAJ+F1CKq3wk_DMLtxFG316ZUuGELgytHVBuUYqGim7T=JjtZcA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 12 Dec 2018 16:52:54 +0400
Message-ID: <CAJ+F1CKjdiRPK1WmW9Df_q38Yqv9MKqpzT3j9tmKW=1M+C7EXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 13/24] q35/440fx/arm/spapr: Add QEMU 4.0
 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, alex.williamson@redhat.com, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>

Hi

On Wed, Dec 12, 2018 at 4:51 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Tue, Dec 11, 2018 at 10:22 PM Eduardo Habkost <ehabkost@redhat.com> wr=
ote:
> >
> > From: Alex Williamson <alex.williamson@redhat.com>
> >
> > Including all machine types that might have a pcie-root-port.
> >
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Richard Henderson <rth@twiddle.net>
> > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > Message-Id: <154394083644.28192.8501647946108201466.stgit@gimli.home>
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > [ehabkost: fixed accidental recursion at spapr_machine_3_1_class_option=
s()]
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>
> Why was ccw dropped? (can't find the discussion)
> thanks

Ah I see it is already in Cornelia pullreq, nevermind.

> > ---
> >  include/hw/compat.h  |  3 +++
> >  include/hw/i386/pc.h |  3 +++
> >  hw/arm/virt.c        | 19 +++++++++++++++++--
> >  hw/i386/pc_piix.c    | 15 ++++++++++++---
> >  hw/i386/pc_q35.c     | 13 +++++++++++--
> >  hw/ppc/spapr.c       | 25 ++++++++++++++++++++++---
> >  6 files changed, 68 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/hw/compat.h b/include/hw/compat.h
> > index 6f4d5fc647..70958328fe 100644
> > --- a/include/hw/compat.h
> > +++ b/include/hw/compat.h
> > @@ -1,6 +1,9 @@
> >  #ifndef HW_COMPAT_H
> >  #define HW_COMPAT_H
> >
> > +#define HW_COMPAT_3_1 \
> > +    /* empty */
> > +
> >  #define HW_COMPAT_3_0 \
> >      /* empty */
> >
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index 7bb52b4762..9d29c4b1df 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -294,6 +294,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
> >  int e820_get_num_entries(void);
> >  bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
> >
> > +#define PC_COMPAT_3_1 \
> > +    HW_COMPAT_3_1 \
> > +
> >  #define PC_COMPAT_3_0 \
> >      HW_COMPAT_3_0 \
> >      {\
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index f69e7eb399..beaf6bc439 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -1797,7 +1797,7 @@ static void machvirt_machine_init(void)
> >  }
> >  type_init(machvirt_machine_init);
> >
> > -static void virt_3_1_instance_init(Object *obj)
> > +static void virt_4_0_instance_init(Object *obj)
> >  {
> >      VirtMachineState *vms =3D VIRT_MACHINE(obj);
> >      VirtMachineClass *vmc =3D VIRT_MACHINE_GET_CLASS(vms);
> > @@ -1867,10 +1867,25 @@ static void virt_3_1_instance_init(Object *obj)
> >      vms->irqmap =3D a15irqmap;
> >  }
> >
> > +static void virt_machine_4_0_options(MachineClass *mc)
> > +{
> > +}
> > +DEFINE_VIRT_MACHINE_AS_LATEST(4, 0)
> > +
> > +#define VIRT_COMPAT_3_1 \
> > +    HW_COMPAT_3_1
> > +
> > +static void virt_3_1_instance_init(Object *obj)
> > +{
> > +    virt_4_0_instance_init(obj);
> > +}
> > +
> >  static void virt_machine_3_1_options(MachineClass *mc)
> >  {
> > +    virt_machine_4_0_options(mc);
> > +    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_3_1);
> >  }
> > -DEFINE_VIRT_MACHINE_AS_LATEST(3, 1)
> > +DEFINE_VIRT_MACHINE(3, 1)
> >
> >  #define VIRT_COMPAT_3_0 \
> >      HW_COMPAT_3_0
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index 2d996162f1..d9b04c8427 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -429,21 +429,30 @@ static void pc_i440fx_machine_options(MachineClas=
s *m)
> >      machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
> >  }
> >
> > -static void pc_i440fx_3_1_machine_options(MachineClass *m)
> > +static void pc_i440fx_4_0_machine_options(MachineClass *m)
> >  {
> >      pc_i440fx_machine_options(m);
> >      m->alias =3D "pc";
> >      m->is_default =3D 1;
> >  }
> >
> > +DEFINE_I440FX_MACHINE(v4_0, "pc-i440fx-4.0", NULL,
> > +                      pc_i440fx_4_0_machine_options);
> > +
> > +static void pc_i440fx_3_1_machine_options(MachineClass *m)
> > +{
> > +    pc_i440fx_4_0_machine_options(m);
> > +    m->is_default =3D 0;
> > +    m->alias =3D NULL;
> > +    SET_MACHINE_COMPAT(m, PC_COMPAT_3_1);
> > +}
> > +
> >  DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1", NULL,
> >                        pc_i440fx_3_1_machine_options);
> >
> >  static void pc_i440fx_3_0_machine_options(MachineClass *m)
> >  {
> >      pc_i440fx_3_1_machine_options(m);
> > -    m->is_default =3D 0;
> > -    m->alias =3D NULL;
> >      SET_MACHINE_COMPAT(m, PC_COMPAT_3_0);
> >  }
> >
> > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > index 6e3d81f5be..58459bdab5 100644
> > --- a/hw/i386/pc_q35.c
> > +++ b/hw/i386/pc_q35.c
> > @@ -311,19 +311,28 @@ static void pc_q35_machine_options(MachineClass *=
m)
> >      m->max_cpus =3D 288;
> >  }
> >
> > -static void pc_q35_3_1_machine_options(MachineClass *m)
> > +static void pc_q35_4_0_machine_options(MachineClass *m)
> >  {
> >      pc_q35_machine_options(m);
> >      m->alias =3D "q35";
> >  }
> >
> > +DEFINE_Q35_MACHINE(v4_0, "pc-q35-4.0", NULL,
> > +                   pc_q35_4_0_machine_options);
> > +
> > +static void pc_q35_3_1_machine_options(MachineClass *m)
> > +{
> > +    pc_q35_4_0_machine_options(m);
> > +    m->alias =3D NULL;
> > +    SET_MACHINE_COMPAT(m, PC_COMPAT_3_1);
> > +}
> > +
> >  DEFINE_Q35_MACHINE(v3_1, "pc-q35-3.1", NULL,
> >                     pc_q35_3_1_machine_options);
> >
> >  static void pc_q35_3_0_machine_options(MachineClass *m)
> >  {
> >      pc_q35_3_1_machine_options(m);
> > -    m->alias =3D NULL;
> >      SET_MACHINE_COMPAT(m, PC_COMPAT_3_0);
> >  }
> >
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 7afd1a175b..def3e502d8 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3956,19 +3956,38 @@ static const TypeInfo spapr_machine_info =3D {
> >      }                                                                \
> >      type_init(spapr_machine_register_##suffix)
> >
> > - /*
> > +/*
> > + * pseries-4.0
> > + */
> > +static void spapr_machine_4_0_instance_options(MachineState *machine)
> > +{
> > +}
> > +
> > +static void spapr_machine_4_0_class_options(MachineClass *mc)
> > +{
> > +    /* Defaults for the latest behaviour inherited from the base class=
 */
> > +}
> > +
> > +DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
> > +
> > +/*
> >   * pseries-3.1
> >   */
> > +#define SPAPR_COMPAT_3_1                                              =
\
> > +    HW_COMPAT_3_1
> > +
> >  static void spapr_machine_3_1_instance_options(MachineState *machine)
> >  {
> > +    spapr_machine_4_0_instance_options(machine);
> >  }
> >
> >  static void spapr_machine_3_1_class_options(MachineClass *mc)
> >  {
> > -    /* Defaults for the latest behaviour inherited from the base class=
 */
> > +    spapr_machine_4_0_class_options(mc);
> > +    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_1);
> >  }
> >
> > -DEFINE_SPAPR_MACHINE(3_1, "3.1", true);
> > +DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
> >
> >  /*
> >   * pseries-3.0
> > --
> > 2.18.0.rc1.1.g3f1ff2140
> >
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau



--=20
Marc-Andr=C3=A9 Lureau
