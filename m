Received: from eggs.gnu.org ([209.51.188.92]:44383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goBYT-0003pD-Vn
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:22:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goBYS-0002fP-Sr
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:22:45 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1goBYS-0002dN-Nb
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:22:44 -0500
Received: by mail-oi1-x242.google.com with SMTP id u18so13850659oie.10
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:22:42 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Date: Mon, 28 Jan 2019 12:22:38 -0600
From: Corey Minyard <minyard@acm.org>
Message-ID: <20190128182238.GA2402@minyard.net>
Reply-To: minyard@acm.org
References: <20190128175458.27255-1-minyard@acm.org>
	<20190128175458.27255-11-minyard@acm.org>
	<20190128180859.GV4136@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128180859.GV4136@habkost.net>
Subject: Re: [Qemu-devel] [PATCH v4 10/19] boards.h: Ignore migration for
 SMBus devices on older machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On Mon, Jan 28, 2019 at 04:08:59PM -0200, Eduardo Habkost wrote:
> On Mon, Jan 28, 2019 at 11:54:49AM -0600, minyard@acm.org wrote:
> > From: Corey Minyard <cminyard@mvista.com>
> > 
> > Migration capability is being added for pm_smbus and SMBus devices.
> > This change will allow backwards compatibility to be kept when
> > migrating back to an old qemu version.  Add a bool to the machine
> > class tho keep smbus migration from happening.  Future changes
> > will use this.
> > 
> > Signed-off-by: Corey Minyard <cminyard@mvista.com>
> > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  hw/i386/pc_piix.c   | 1 +
> >  hw/i386/pc_q35.c    | 1 +
> >  include/hw/boards.h | 1 +
> >  3 files changed, 3 insertions(+)
> > 
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index 6ba163ccbb..a8331b82f2 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -431,6 +431,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
> >  static void pc_i440fx_4_0_machine_options(MachineClass *m)
> >  {
> >      pc_i440fx_machine_options(m);
> > +    m->smbus_no_migration_support = true;
> >      m->alias = "pc";
> >      m->is_default = 1;
> >  }
> > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > index 1689885cac..bafc73b2d9 100644
> > --- a/hw/i386/pc_q35.c
> > +++ b/hw/i386/pc_q35.c
> > @@ -368,6 +368,7 @@ static void pc_q35_machine_options(MachineClass *m)
> >  static void pc_q35_4_0_machine_options(MachineClass *m)
> >  {
> >      pc_q35_machine_options(m);
> > +    m->smbus_no_migration_support = true;
> >      m->alias = "q35";
> >  }
> >  
> 
> Wasn't this supposed to be added to pc_*_3_1_machine_options(),
> so the flag is set to false on pc-*-4.0?

Yes, I stuck it in the wrong place.  I'll fix it.

-corey

> 
> -- 
> Eduardo
