Received: from eggs.gnu.org ([2001:4830:134:3::10]:34535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e0Pd4-0000P3-IL
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e0Pcz-0001QT-Lx
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:13:14 -0400
Received: from 19.mo4.mail-out.ovh.net ([87.98.179.66]:46199)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e0Pcz-0001P0-Fc
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:13:09 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id C7792CC565
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 12:13:05 +0200 (CEST)
Date: Fri, 6 Oct 2017 12:12:56 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171006121256.27be8386@bahia.lan>
In-Reply-To: <20171006112710.3fab9960@nial.brq.redhat.com>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-17-git-send-email-imammedo@redhat.com>
	<20171006093925.71e1b3cd@bahia.lan>
	<20171006112710.3fab9960@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/23] ppc: spapr: use cpu model names as
 tcg defaults instead of aliases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:ppce500" <qemu-ppc@nongnu.org>, "Edgar
	E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On Fri, 6 Oct 2017 11:27:10 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Fri, 6 Oct 2017 09:39:25 +0200
> Greg Kurz <groug@kaod.org> wrote:
> 
> > On Thu,  5 Oct 2017 18:24:43 +0200
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >   
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---    
> > 
> > So... this is preparatory work for the next patch because the generic cpu_model
> > parsing code doesn't handle aliases, is it ?  
> generic parsing does handle aliases thanks to ppc_cpu_class_by_name() callback
> but generic parsing doesn't parse default cpu model as it doesn't exists
> it works with default cpu TYPE.
> 
> So yes it's preparation for the next patch where exact default cpu model
> is converted into cpu type with help of POWERPC_CPU_TYPE_NAME(), like its done
> everywhere else.
> 

I understand now, thanks for the clarification.

Maybe this patch could have been folded into the next one then, but anyway
the change is fine.

Reviewed-by: Greg Kurz <groug@kaod.org>

> >   
> > >  hw/ppc/spapr.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index ad7afd6..0661dba 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -3603,7 +3603,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
> > >      hc->unplug_request = spapr_machine_device_unplug_request;
> > >  
> > >      smc->dr_lmb_enabled = true;
> > > -    smc->tcg_default_cpu = "POWER8";
> > > +    smc->tcg_default_cpu = "power8_v2.0";
> > >      mc->has_hotpluggable_cpus = true;
> > >      smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
> > >      fwc->get_dev_path = spapr_get_fw_dev_path;
> > > @@ -3849,7 +3849,7 @@ static void spapr_machine_2_7_class_options(MachineClass *mc)
> > >      sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> > >  
> > >      spapr_machine_2_8_class_options(mc);
> > > -    smc->tcg_default_cpu = "POWER7";
> > > +    smc->tcg_default_cpu = "power7_v2.3";
> > >      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_7);
> > >      smc->phb_placement = phb_placement_2_7;
> > >  }    
> >   
> 
