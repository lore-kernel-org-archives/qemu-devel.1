Received: from eggs.gnu.org ([2001:4830:134:3::10]:40410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gP4iJ-0003lS-RC
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:01:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gP4iD-0004xb-NF
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:01:06 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gP4iA-0004w7-0t
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:00:59 -0500
Received: by mail-qk1-f196.google.com with SMTP id n12so2305872qkh.11
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 04:00:55 -0800 (PST)
MIME-Version: 1.0
References: <20181030150453.9344-1-marcandre.lureau@redhat.com>
	<20181030150453.9344-10-marcandre.lureau@redhat.com>
	<20181101155937.480f4eb4@redhat.com>
In-Reply-To: <20181101155937.480f4eb4@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Nov 2018 16:00:43 +0400
Message-ID: <CAMxuvaw8_PgnBt-ENxU6+KgDOob72duLBXM8U4fjanqPiq1Wow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/10] hw/i386: add pc-i440fx-3.1 &
 pc-q35-3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>, "Shah, Amit" <amit@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, "Michael S . Tsirkin" <mst@redhat.com>, atar4qemu@gmail.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Thu, Nov 1, 2018 at 6:59 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Tue, 30 Oct 2018 19:04:52 +0400
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>
> > The following patch is going to add compatiblity parameters.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

ping,
missing 3.1 pc machines is listed as not fixed yet:
https://wiki.qemu.org/Planning/3.1

we have 3 reviewed-by on this patch already.



>
> > ---
> >  include/hw/i386/pc.h |  2 +-
> >  hw/i386/pc_piix.c    | 15 ++++++++++++---
> >  hw/i386/pc_q35.c     | 13 +++++++++++--
> >  3 files changed, 24 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index dfe6746692..67ff516d61 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -300,7 +300,7 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint=
64_t *);
> >          .driver   =3D TYPE_X86_CPU,\
> >          .property =3D "x-hv-synic-kvm-only",\
> >          .value    =3D "on",\
> > -    }
> > +    },
> >
> >  #define PC_COMPAT_2_12 \
> >      HW_COMPAT_2_12 \
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index dc09466b3e..7092d6d13f 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -428,21 +428,30 @@ static void pc_i440fx_machine_options(MachineClas=
s *m)
> >      machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
> >  }
> >
> > -static void pc_i440fx_3_0_machine_options(MachineClass *m)
> > +static void pc_i440fx_3_1_machine_options(MachineClass *m)
> >  {
> >      pc_i440fx_machine_options(m);
> >      m->alias =3D "pc";
> >      m->is_default =3D 1;
> >  }
> >
> > +DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1", NULL,
> > +                      pc_i440fx_3_1_machine_options);
> > +
> > +static void pc_i440fx_3_0_machine_options(MachineClass *m)
> > +{
> > +    pc_i440fx_3_1_machine_options(m);
> > +    m->is_default =3D 0;
> > +    m->alias =3D NULL;
> > +    SET_MACHINE_COMPAT(m, PC_COMPAT_3_0);
> > +}
> > +
> >  DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
> >                        pc_i440fx_3_0_machine_options);
> >
> >  static void pc_i440fx_2_12_machine_options(MachineClass *m)
> >  {
> >      pc_i440fx_3_0_machine_options(m);
> > -    m->is_default =3D 0;
> > -    m->alias =3D NULL;
> >      SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
> >  }
> >
> > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > index 532241e3f8..4702bb13c4 100644
> > --- a/hw/i386/pc_q35.c
> > +++ b/hw/i386/pc_q35.c
> > @@ -311,19 +311,28 @@ static void pc_q35_machine_options(MachineClass *=
m)
> >      m->max_cpus =3D 288;
> >  }
> >
> > -static void pc_q35_3_0_machine_options(MachineClass *m)
> > +static void pc_q35_3_1_machine_options(MachineClass *m)
> >  {
> >      pc_q35_machine_options(m);
> >      m->alias =3D "q35";
> >  }
> >
> > +DEFINE_Q35_MACHINE(v3_1, "pc-q35-3.1", NULL,
> > +                   pc_q35_3_1_machine_options);
> > +
> > +static void pc_q35_3_0_machine_options(MachineClass *m)
> > +{
> > +    pc_q35_3_1_machine_options(m);
> > +    m->alias =3D NULL;
> > +    SET_MACHINE_COMPAT(m, PC_COMPAT_3_0);
> > +}
> > +
> >  DEFINE_Q35_MACHINE(v3_0, "pc-q35-3.0", NULL,
> >                      pc_q35_3_0_machine_options);
> >
> >  static void pc_q35_2_12_machine_options(MachineClass *m)
> >  {
> >      pc_q35_3_0_machine_options(m);
> > -    m->alias =3D NULL;
> >      SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
> >  }
> >
>
