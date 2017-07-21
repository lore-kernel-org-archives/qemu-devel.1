Received: from eggs.gnu.org ([2001:4830:134:3::10]:48413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cdall@linaro.org>) id 1dYWcR-00018J-OK
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cdall@linaro.org>) id 1dYWcQ-0002v0-Rg
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:01:19 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:37405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cdall@linaro.org>) id 1dYWcQ-0002ua-LN
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:01:18 -0400
Received: by mail-wm0-x22d.google.com with SMTP id e131so12110412wme.0
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 05:01:18 -0700 (PDT)
Date: Fri, 21 Jul 2017 14:01:13 +0200
From: Christoffer Dall <cdall@linaro.org>
Message-ID: <20170721120113.GA16354@cbox>
References: <1500471597-2517-1-git-send-email-drjones@redhat.com>
	<1500471597-2517-2-git-send-email-drjones@redhat.com>
	<20170721111607.GA16350@cbox>
	<20170721113546.detxu6cmlsiatky6@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170721113546.detxu6cmlsiatky6@kamzik.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] hw/arm/virt: add pmu interrupt state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de

On Fri, Jul 21, 2017 at 01:35:46PM +0200, Andrew Jones wrote:
> On Fri, Jul 21, 2017 at 01:16:07PM +0200, Christoffer Dall wrote:
> > On Wed, Jul 19, 2017 at 09:39:54AM -0400, Andrew Jones wrote:
> > > Mimicking gicv3-maintenance-interrupt, add the PMU's interrupt to
> > > CPU state.
> > > 
> > > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > >  hw/arm/virt.c    | 3 +++
> > >  target/arm/cpu.c | 2 ++
> > >  target/arm/cpu.h | 2 ++
> > >  3 files changed, 7 insertions(+)
> > > 
> > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > index 31739d75a3e0..ea26f0c473c2 100644
> > > --- a/hw/arm/virt.c
> > > +++ b/hw/arm/virt.c
> > > @@ -610,6 +610,9 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
> > >          qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt", 0,
> > >                                      qdev_get_gpio_in(gicdev, ppibase
> > >                                                       + ARCH_GICV3_MAINT_IRQ));
> > > +        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
> > > +                                    qdev_get_gpio_in(gicdev, ppibase
> > > +                                                     + VIRTUAL_PMU_IRQ));
> > 
> > I know Peter reviewed this, but isn't it a bit strange to create the
> > pmu-interrupt when creating the gic (as this isn't an output from the
> > GIC like the maintenance interrupt is) ?
> >
> 
> Above the gic maintenance interrupt connection the timer irqs are also
> connected. So, while the function name implies we only create the gic,
> its function appears to be both its creation and the wiring up of CPU
> inputs and outputs.
> 

ok, I didn't see that.

Otherwise this patch looks good to me.

-Christoffer
