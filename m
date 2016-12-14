Received: from eggs.gnu.org ([2001:4830:134:3::10]:52235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cHIgR-0005sP-A8
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 18:10:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cHIgQ-0008Gu-Ee
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 18:09:59 -0500
Message-ID: <1481756926.22744.0.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu, 15 Dec 2016 10:08:46 +1100
In-Reply-To: <20161214062044.GJ32647@umbus>
References: <20161212040603.27295-1-david@gibson.dropbear.id.au>
	<20161212040603.27295-5-david@gibson.dropbear.id.au>
	<1481693546.1555.26.camel@gmail.com> <20161214062044.GJ32647@umbus>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv3 4/5] pseries: Enable HPT resizing for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: paulus@samba.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, thuth@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Wed, 2016-12-14 at 17:20 +1100, David Gibson wrote:
> On Wed, Dec 14, 2016 at 04:32:26PM +1100, Suraj Jitindar Singh wrote:
> > 
> > On Mon, 2016-12-12 at 15:06 +1100, David Gibson wrote:
> > > 
> > > We've now implemented a PAPR extensions which allows PAPR guests
> > > (i.e.
> > > "pseries" machine type) to resize their hash page table during
> > > runtime.
> > > 
> > > However, that extension is only enabled if explicitly chosen on
> > > the
> > > command line.  This patch enables it by default for spapr-2.9,
> > > but
> > > leaves
> > > it disabled (by default) for older machine types.
> > > 
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> > > ---
> > >  hw/ppc/spapr.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index d057031..f05d0e5 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2779,7 +2779,7 @@ static void
> > > spapr_machine_class_init(ObjectClass *oc, void *data)
> > >  
> > >      smc->dr_lmb_enabled = true;
> > >      smc->tcg_default_cpu = "POWER8";
> > > -    smc->resize_hpt_default = SPAPR_RESIZE_HPT_DISABLED;
> > > +    smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
> > >      mc->query_hotpluggable_cpus = spapr_query_hotpluggable_cpus;
> > >      fwc->get_dev_path = spapr_get_fw_dev_path;
> > >      nc->nmi_monitor_handler = spapr_nmi;
> > > @@ -2860,8 +2860,11 @@ static void
> > > spapr_machine_2_8_instance_options(MachineState *machine)
> > >  
> > >  static void spapr_machine_2_8_class_options(MachineClass *mc)
> > >  {
> > > +    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> > > +
> > >      spapr_machine_2_9_class_options(mc);
> > >      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_8);
> > > +    smc->resize_hpt_default = SPAPR_RESIZE_HPT_DISABLED;
> > >  }
> > >  
> > >  DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
> > If people don't want this by default they should probably specify
> > on
> > the command line.
> Uh.. I don't follow you.
Just agreeing with you setting the default to enabled :)
> 
> > 
> > Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > 
