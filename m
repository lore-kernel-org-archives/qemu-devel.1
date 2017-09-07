Received: from eggs.gnu.org ([2001:4830:134:3::10]:57069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dpl9K-0002Vc-Q9
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 20:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dpl9H-00030a-O4
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 20:58:30 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dpl9G-0002y0-R3
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 20:58:27 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 7 Sep 2017 00:58:02 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA3A2524@DGGEMA505-MBX.china.huawei.com>
References: <1504603805-180240-1-git-send-email-arei.gonglei@huawei.com>
	<1504603805-180240-2-git-send-email-arei.gonglei@huawei.com>
	<20170905132034.GX7570@localhost.localdomain>
In-Reply-To: <20170905132034.GX7570@localhost.localdomain>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/2] pc: add 2.11 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "vrozenfe@redhat.com" <vrozenfe@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>



> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Tuesday, September 05, 2017 9:21 PM
> To: Gonglei (Arei)
> Cc: qemu-devel@nongnu.org; mst@redhat.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; vrozenfe@redhat.com;
> Huangweidong (C)
> Subject: Re: [PATCH 1/2] pc: add 2.11 machine type
>=20
> On Tue, Sep 05, 2017 at 05:30:04PM +0800, Gonglei wrote:
> > CC: "Michael S. Tsirkin" <mst@redhat.com>
> > CC: Paolo Bonzini <pbonzini@redhat.com>
> > CC: Richard Henderson <rth@twiddle.net>
> > CC: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> > ---
> >  hw/i386/pc_piix.c    | 15 ++++++++++++---
> >  hw/i386/pc_q35.c     | 13 +++++++++++--
> >  include/hw/i386/pc.h |  3 +++
> >  3 files changed, 26 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index 46dfd2c..b03cc04 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -436,21 +436,30 @@ static void
> pc_i440fx_machine_options(MachineClass *m)
> >      m->default_display =3D "std";
> >  }
> >
> > -static void pc_i440fx_2_10_machine_options(MachineClass *m)
> > +static void pc_i440fx_2_11_machine_options(MachineClass *m)
> >  {
> >      pc_i440fx_machine_options(m);
> >      m->alias =3D "pc";
> >      m->is_default =3D 1;
> >  }
> >
> > +DEFINE_I440FX_MACHINE(v2_11, "pc-i440fx-2.11", NULL,
> > +                      pc_i440fx_2_11_machine_options);
> > +
> > +static void pc_i440fx_2_10_machine_options(MachineClass *m)
> > +{
> > +    pc_i440fx_2_11_machine_options(m);
> > +    m->is_default =3D 0;
> > +    m->alias =3D NULL;
> > +    SET_MACHINE_COMPAT(m, PC_COMPAT_2_10);
> > +}
> > +
> >  DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10", NULL,
> >                        pc_i440fx_2_10_machine_options);
> >
> >  static void pc_i440fx_2_9_machine_options(MachineClass *m)
> >  {
> >      pc_i440fx_2_10_machine_options(m);
> > -    m->is_default =3D 0;
> > -    m->alias =3D NULL;
> >      SET_MACHINE_COMPAT(m, PC_COMPAT_2_9);
> >      m->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
> >  }
> > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > index 169a214..d6fef8d 100644
> > --- a/hw/i386/pc_q35.c
> > +++ b/hw/i386/pc_q35.c
> > @@ -302,20 +302,29 @@ static void
> pc_q35_machine_options(MachineClass *m)
> >      m->max_cpus =3D 288;
> >  }
> >
> > -static void pc_q35_2_10_machine_options(MachineClass *m)
> > +static void pc_q35_2_11_machine_options(MachineClass *m)
> >  {
> >      pc_q35_machine_options(m);
> >      m->alias =3D "q35";
> >      m->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
> >  }
> >
> > +DEFINE_Q35_MACHINE(v2_11, "pc-q35-2.11", NULL,
> > +                   pc_q35_2_11_machine_options);
> > +
> > +static void pc_q35_2_10_machine_options(MachineClass *m)
> > +{
> > +    pc_q35_2_11_machine_options(m);
> > +    m->alias =3D NULL;
> > +    SET_MACHINE_COMPAT(m, PC_COMPAT_2_10);
> > +}
> > +
> >  DEFINE_Q35_MACHINE(v2_10, "pc-q35-2.10", NULL,
> >                     pc_q35_2_10_machine_options);
> >
> >  static void pc_q35_2_9_machine_options(MachineClass *m)
> >  {
> >      pc_q35_2_10_machine_options(m);
> > -    m->alias =3D NULL;
> >      SET_MACHINE_COMPAT(m, PC_COMPAT_2_9);
> >  }
> >
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index d80859b..8226904 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -369,6 +369,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
> >  int e820_get_num_entries(void);
> >  bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
> >
> > +#define PC_COMPAT_2_10 \
> > +    HW_COMPAT_2_10 \
> > +
>=20
> Patch looks good, but I would remove the trailing backslash here.
>=20
OK.

> With that changed:
>=20
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>=20
Thanks.
