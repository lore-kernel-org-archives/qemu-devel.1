Received: from eggs.gnu.org ([2001:4830:134:3::10]:47467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cReba-0005Z4-2N
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 07:35:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRebV-0001iP-2n
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 07:35:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cRebU-0001iF-Q4
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 07:35:40 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBF6183F3A
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 12:35:40 +0000 (UTC)
Date: Thu, 12 Jan 2017 10:35:38 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170112123538.GI3565@thinpad.lan.raisama.net>
References: <20170108194041.10908-1-ehabkost@redhat.com>
	<20170108194041.10908-5-ehabkost@redhat.com>
	<20170110060603-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170110060603-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 4/5] pc: Add 2.9 machine-types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Tue, Jan 10, 2017 at 06:06:33AM +0200, Michael S. Tsirkin wrote:
> On Sun, Jan 08, 2017 at 05:40:40PM -0200, Eduardo Habkost wrote:
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Laszlo Ersek <lersek@redhat.com>
> > Cc: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> Do I understand it correctly that you are merging this through
> another tree?

I will apply it when including this series only if it is not
merged through another tree first. I believe multiple series
depend on adding the pc-2.9 machine-types. Feel free to apply it
to your tree if you want to.

> 
> In that case
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Thanks!

> 
> 
> > ---
> > Changes v1 -> v2:
> > * Added extra backslash to PC_COMPAT_2_8 definition
> >   * Suggested-by: Laszlo Ersek <lersek@redhat.com>
> > ---
> >  include/hw/i386/pc.h |  2 ++
> >  hw/i386/pc_piix.c    | 15 ++++++++++++---
> >  hw/i386/pc_q35.c     | 13 +++++++++++--
> >  3 files changed, 25 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index b22e699c46..230e9e70c5 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -375,6 +375,8 @@ int e820_get_num_entries(void);
> >  bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
> >  
> >  #define PC_COMPAT_2_8 \
> > +    HW_COMPAT_2_8 \
> > +
> >  
> >  #define PC_COMPAT_2_7 \
> >      HW_COMPAT_2_7 \
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index 5e1adbe53c..9f102aa388 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -437,13 +437,24 @@ static void pc_i440fx_machine_options(MachineClass *m)
> >      m->default_display = "std";
> >  }
> >  
> > -static void pc_i440fx_2_8_machine_options(MachineClass *m)
> > +static void pc_i440fx_2_9_machine_options(MachineClass *m)
> >  {
> >      pc_i440fx_machine_options(m);
> >      m->alias = "pc";
> >      m->is_default = 1;
> >  }
> >  
> > +DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9", NULL,
> > +                      pc_i440fx_2_9_machine_options);
> > +
> > +static void pc_i440fx_2_8_machine_options(MachineClass *m)
> > +{
> > +    pc_i440fx_2_9_machine_options(m);
> > +    m->is_default = 0;
> > +    m->alias = NULL;
> > +    SET_MACHINE_COMPAT(m, PC_COMPAT_2_8);
> > +}
> > +
> >  DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8", NULL,
> >                        pc_i440fx_2_8_machine_options);
> >  
> > @@ -451,8 +462,6 @@ DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8", NULL,
> >  static void pc_i440fx_2_7_machine_options(MachineClass *m)
> >  {
> >      pc_i440fx_2_8_machine_options(m);
> > -    m->is_default = 0;
> > -    m->alias = NULL;
> >      SET_MACHINE_COMPAT(m, PC_COMPAT_2_7);
> >  }
> >  
> > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > index d042fe0843..dd792a8547 100644
> > --- a/hw/i386/pc_q35.c
> > +++ b/hw/i386/pc_q35.c
> > @@ -301,19 +301,28 @@ static void pc_q35_machine_options(MachineClass *m)
> >      m->max_cpus = 288;
> >  }
> >  
> > -static void pc_q35_2_8_machine_options(MachineClass *m)
> > +static void pc_q35_2_9_machine_options(MachineClass *m)
> >  {
> >      pc_q35_machine_options(m);
> >      m->alias = "q35";
> >  }
> >  
> > +DEFINE_Q35_MACHINE(v2_9, "pc-q35-2.9", NULL,
> > +                   pc_q35_2_9_machine_options);
> > +
> > +static void pc_q35_2_8_machine_options(MachineClass *m)
> > +{
> > +    pc_q35_2_9_machine_options(m);
> > +    m->alias = NULL;
> > +    SET_MACHINE_COMPAT(m, PC_COMPAT_2_8);
> > +}
> > +
> >  DEFINE_Q35_MACHINE(v2_8, "pc-q35-2.8", NULL,
> >                     pc_q35_2_8_machine_options);
> >  
> >  static void pc_q35_2_7_machine_options(MachineClass *m)
> >  {
> >      pc_q35_2_8_machine_options(m);
> > -    m->alias = NULL;
> >      m->max_cpus = 255;
> >      SET_MACHINE_COMPAT(m, PC_COMPAT_2_7);
> >  }
> > -- 
> > 2.11.0.259.g40922b1

-- 
Eduardo
