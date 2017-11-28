Received: from eggs.gnu.org ([2001:4830:134:3::10]:51605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eJUQW-0008WV-Vx
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 20:11:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eJUQT-00048C-Qd
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 20:11:08 -0500
Date: Mon, 27 Nov 2017 23:11:00 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171128011059.GD3037@localhost.localdomain>
References: <20171125151610.20547-1-ehabkost@redhat.com>
	<20171125151610.20547-4-ehabkost@redhat.com>
	<20171125193119.39a3d62f@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171125193119.39a3d62f@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] ppc: e500: Allow only supported
 dynamic sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, jgross@suse.com, Thomas Huth <thuth@redhat.com>, sstabellini@kernel.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Sat, Nov 25, 2017 at 07:31:19PM +0100, Greg Kurz wrote:
> On Sat, 25 Nov 2017 13:16:07 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > platform_bus_create_devtree() already rejects all dynamic sysbus
> > devices except TYPE_ETSEC_COMMON, so register it as the only
> > allowed dynamic sysbus device for the ppce500 machine-type.
> > 
> 
> Maybe drop the code that rejects unsupported sysbus devices, but this
> can be done in a followup patch.

Yes, that's a good idea.  Probably an opportunity to provide a
better API to handle dynamic sysbus devices.

> 
> Anyway,
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>

Thanks!


> 
> > Cc: Alexander Graf <agraf@suse.de>
> > Cc: David Gibson <david@gibson.dropbear.id.au>
> > Cc: qemu-ppc@nongnu.org
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Changes series v1 -> v2:
> > * New patch added to series
> > ---
> >  hw/ppc/e500plat.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
> > index 438118c29b..81d03e1038 100644
> > --- a/hw/ppc/e500plat.c
> > +++ b/hw/ppc/e500plat.c
> > @@ -12,6 +12,7 @@
> >  #include "qemu/osdep.h"
> >  #include "qemu-common.h"
> >  #include "e500.h"
> > +#include "hw/net/fsl_etsec/etsec.h"
> >  #include "hw/boards.h"
> >  #include "sysemu/device_tree.h"
> >  #include "sysemu/kvm.h"
> > @@ -64,8 +65,7 @@ static void e500plat_machine_init(MachineClass *mc)
> >      mc->desc = "generic paravirt e500 platform";
> >      mc->init = e500plat_init;
> >      mc->max_cpus = 32;
> > -    /*TODO: allow only sysbus devices that really work with this machine */
> > -    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SYS_BUS_DEVICE);
> > +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ETSEC_COMMON);
> >      mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
> >  }
> >  
> 

-- 
Eduardo
