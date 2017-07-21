Received: from eggs.gnu.org ([2001:4830:134:3::10]:44122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dYWDw-0002Y0-Ma
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dYWDv-0007rr-SP
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:36:00 -0400
Date: Fri, 21 Jul 2017 13:35:46 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170721113546.detxu6cmlsiatky6@kamzik.brq.redhat.com>
References: <1500471597-2517-1-git-send-email-drjones@redhat.com>
	<1500471597-2517-2-git-send-email-drjones@redhat.com>
	<20170721111607.GA16350@cbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170721111607.GA16350@cbox>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] hw/arm/virt: add pmu interrupt state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christoffer Dall <cdall@linaro.org>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de

On Fri, Jul 21, 2017 at 01:16:07PM +0200, Christoffer Dall wrote:
> On Wed, Jul 19, 2017 at 09:39:54AM -0400, Andrew Jones wrote:
> > Mimicking gicv3-maintenance-interrupt, add the PMU's interrupt to
> > CPU state.
> > 
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  hw/arm/virt.c    | 3 +++
> >  target/arm/cpu.c | 2 ++
> >  target/arm/cpu.h | 2 ++
> >  3 files changed, 7 insertions(+)
> > 
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 31739d75a3e0..ea26f0c473c2 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -610,6 +610,9 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
> >          qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt", 0,
> >                                      qdev_get_gpio_in(gicdev, ppibase
> >                                                       + ARCH_GICV3_MAINT_IRQ));
> > +        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
> > +                                    qdev_get_gpio_in(gicdev, ppibase
> > +                                                     + VIRTUAL_PMU_IRQ));
> 
> I know Peter reviewed this, but isn't it a bit strange to create the
> pmu-interrupt when creating the gic (as this isn't an output from the
> GIC like the maintenance interrupt is) ?
>

Above the gic maintenance interrupt connection the timer irqs are also
connected. So, while the function name implies we only create the gic,
its function appears to be both its creation and the wiring up of CPU
inputs and outputs.

Thanks,
drew
