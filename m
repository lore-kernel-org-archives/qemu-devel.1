Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0457AC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 12:02:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFCF420821
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 12:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFCF420821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35708 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGMnG-0008DV-Ts
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 08:02:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hGMlu-0007VF-9Q
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hGMls-0008Vg-C5
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:01:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hGMlr-0008Q6-UM; Tue, 16 Apr 2019 08:01:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6219230018E0;
	Tue, 16 Apr 2019 12:00:41 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C5F1C1001E9F;
	Tue, 16 Apr 2019 12:00:37 +0000 (UTC)
Date: Tue, 16 Apr 2019 14:00:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Like Xu <like.xu@linux.intel.com>
Message-ID: <20190416140033.666c6855@redhat.com>
In-Reply-To: <4d0ce2df-b396-80a0-a3b9-f2513bd2289d@linux.intel.com>
References: <1553849325-44201-1-git-send-email-like.xu@linux.intel.com>
	<1553849325-44201-4-git-send-email-like.xu@linux.intel.com>
	<20190408145424.45af3db8@redhat.com>
	<4d0ce2df-b396-80a0-a3b9-f2513bd2289d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Tue, 16 Apr 2019 12:00:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/9] cpu/topology: add uncommon arch
 support for smp machine properties
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org, like.xu@intel.com,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416120033.AROMvAVvIDd_MQ7lUQJk9lJy-nvWA4NYRCYF7-3JeBE@z>

On Tue, 16 Apr 2019 16:47:55 +0800
Like Xu <like.xu@linux.intel.com> wrote:

> On 2019/4/8 20:54, Igor Mammedov wrote:
> > On Fri, 29 Mar 2019 16:48:39 +0800
> > Like Xu <like.xu@linux.intel.com> wrote:
> > 
> > here should be a commit message explaining what patch does
> > in more detail.
> > 
> >   
> >> Signed-off-by: Like Xu <like.xu@linux.intel.com>  
> > 
> > Generic note, try not call qdev_get_machine() every time
> > you replace smp_cpus or other variables. It's often possible
> > to pass MachineState via call chain with trivial fixups.  
> 
> Hi Igor,
> 
> I have some doubts on this comments after some attempts.
> 
> I'm not sure if this idea could apply to all qdev_get_machine()
> usages in tree or just for this smp-touch-only patch.
Ideally it would apply to all users, but realistically it's
probably too much of refactoring for one series.
So whether we use qdev_get_machine() or not depends on
concrete usecase and how complex 'right' refactoring would be.

> It takes a lot of efforts on hooks overrides when we
> undo calls to qdev_get_machine() with modification of incoming parameters.
sometime it's too much of efforts and sometimes efforts are
justified if it makes code more robust and clear.
What I've seen in this series it's mostly trivial replacement
of -smp related globals with qdev_get_machine() without
looking up the call stack to see if Machine is already available
to the caller and just a several call frames away.

In case of this concrete patch wrt reset hook it's logical
to pass Machine as argument to the caller as I commented earlier
and it's not that complex change.

> The implementation of qdev_get_machine() couldn't be simpler more
> and it doesn't seem to bring much overhead compared with parameter stack.
It's not only about overhead, basically with qdev_get_machine()
you are replacing one global variable with another wrapped in
function call. That however introduces implicit dependency on
machine and the order it's initialized, which makes code a bit
more fragile and it's hard to review.

Or putting it in the form of question: what the reason for
replacing one global with another and why we are getting rid of
globals in the first place?

   
> >> ---
> >>   hw/alpha/dp264.c     | 1 +
> >>   hw/hppa/machine.c    | 4 ++++
> >>   hw/mips/boston.c     | 1 +
> >>   hw/mips/mips_malta.c | 9 +++++++++
> >>   hw/sparc/sun4m.c     | 2 ++
> >>   hw/sparc64/sun4u.c   | 2 ++
> >>   hw/xtensa/sim.c      | 1 +
> >>   hw/xtensa/xtfpga.c   | 1 +
> >>   8 files changed, 21 insertions(+)
> >>
> >> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> >> index 0347eb8..ee5d432 100644
> >> --- a/hw/alpha/dp264.c
> >> +++ b/hw/alpha/dp264.c
> >> @@ -63,6 +63,7 @@ static void clipper_init(MachineState *machine)
> >>       char *palcode_filename;
> >>       uint64_t palcode_entry, palcode_low, palcode_high;
> >>       uint64_t kernel_entry, kernel_low, kernel_high;
> >> +    unsigned int smp_cpus = machine->topo.smp_cpus;
> >>   
> >>       /* Create up to 4 cpus.  */
> >>       memset(cpus, 0, sizeof(cpus));
> >> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> >> index d1b1d3c..f652891 100644
> >> --- a/hw/hppa/machine.c
> >> +++ b/hw/hppa/machine.c
> >> @@ -16,6 +16,7 @@
> >>   #include "hw/ide.h"
> >>   #include "hw/timer/i8254.h"
> >>   #include "hw/char/serial.h"
> >> +#include "hw/boards.h"
> >>   #include "hppa_sys.h"
> >>   #include "qemu/units.h"
> >>   #include "qapi/error.h"
> >> @@ -72,6 +73,7 @@ static void machine_hppa_init(MachineState *machine)
> >>       MemoryRegion *ram_region;
> >>       MemoryRegion *cpu_region;
> >>       long i;
> >> +    unsigned int smp_cpus = machine->topo.smp_cpus;  
> > I'd prefer to replace smp_cpus with machine->topo.smp_cpus
> > directly at places it's used, as it makes affected sites
> > more visible in the patch.
> > And use local smp_cpus only in places where using machine->topo.smp_cpus
> > makes core less readable.
> > (but it's just personal preference so I don't insist on it)
> >   
> >>   
> >>       ram_size = machine->ram_size;
> >>   
> >> @@ -242,7 +244,9 @@ static void machine_hppa_init(MachineState *machine)
> >>   
> >>   static void hppa_machine_reset(void)
> >>   {
> >> +    MachineState *ms = MACHINE(qdev_get_machine());
> >>       int i;
> >> +    unsigned int smp_cpus = ms->topo.smp_cpus;  
> > 
> > ***)
> > It would be better to pass MachineState as argument to
> > hppa_machine_reset(), a patch to so should go before this one.
> > 
> > Quick look shows only 3 overrides (hppa, pc, pnv) and one caller,
> > so I'd rather fix it than calling qdev_get_machine() unnecessarily
> >   
> >>   
> >>       qemu_devices_reset();
> >>   
> >> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> >> index e5bab3c..7752c10 100644
> >> --- a/hw/mips/boston.c
> >> +++ b/hw/mips/boston.c
> >> @@ -434,6 +434,7 @@ static void boston_mach_init(MachineState *machine)
> >>       DriveInfo *hd[6];
> >>       Chardev *chr;
> >>       int fw_size, fit_err;
> >> +    unsigned int smp_cpus = machine->topo.smp_cpus;
> >>       bool is_64b;
> >>   
> >>       if ((machine->ram_size % GiB) ||
> >> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> >> index 439665a..d595375 100644
> >> --- a/hw/mips/mips_malta.c
> >> +++ b/hw/mips/mips_malta.c
> >> @@ -1095,6 +1095,8 @@ static int64_t load_kernel (void)
> >>   
> >>   static void malta_mips_config(MIPSCPU *cpu)
> >>   {
> >> +    MachineState *ms = MACHINE(qdev_get_machine());
> >> +    unsigned int smp_cpus = ms->topo.smp_cpus;
> >>       CPUMIPSState *env = &cpu->env;
> >>       CPUState *cs = CPU(cpu);  
> > this one also called from reset, so the same [***] applies here too.
> >   
> >>   
> >> @@ -1127,9 +1129,11 @@ static void main_cpu_reset(void *opaque)
> >>   static void create_cpu_without_cps(const char *cpu_type,
> >>                                      qemu_irq *cbus_irq, qemu_irq *i8259_irq)
> >>   {
> >> +    MachineState *ms = MACHINE(qdev_get_machine());  
> > caller has an access to MachineState so pass it down call chain all the way
> >   
> >>       CPUMIPSState *env;
> >>       MIPSCPU *cpu;
> >>       int i;
> >> +    unsigned int smp_cpus = ms->topo.smp_cpus;
> >>   
> >>       for (i = 0; i < smp_cpus; i++) {
> >>           cpu = MIPS_CPU(cpu_create(cpu_type));
> >> @@ -1149,7 +1153,9 @@ static void create_cpu_without_cps(const char *cpu_type,
> >>   static void create_cps(MaltaState *s, const char *cpu_type,
> >>                          qemu_irq *cbus_irq, qemu_irq *i8259_irq)
> >>   {
> >> +    MachineState *ms = MACHINE(qdev_get_machine());  
> > ditto
> >   
> >>       Error *err = NULL;
> >> +    unsigned int smp_cpus = ms->topo.smp_cpus;
> >>   
> >>       s->cps = MIPS_CPS(object_new(TYPE_MIPS_CPS));
> >>       qdev_set_parent_bus(DEVICE(s->cps), sysbus_get_default());
> >> @@ -1171,6 +1177,9 @@ static void create_cps(MaltaState *s, const char *cpu_type,
> >>   static void mips_create_cpu(MaltaState *s, const char *cpu_type,
> >>                               qemu_irq *cbus_irq, qemu_irq *i8259_irq)
> >>   {
> >> +    MachineState *ms = MACHINE(qdev_get_machine());  
> > ditto
> >   
> >> +    unsigned int smp_cpus = ms->topo.smp_cpus;
> >> +
> >>       if ((smp_cpus > 1) && cpu_supports_cps_smp(cpu_type)) {
> >>           create_cps(s, cpu_type, cbus_irq, i8259_irq);
> >>       } else {
> >> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> >> index ca1e382..2321cfb 100644
> >> --- a/hw/sparc/sun4m.c
> >> +++ b/hw/sparc/sun4m.c
> >> @@ -853,6 +853,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
> >>       unsigned int num_vsimms;
> >>       DeviceState *dev;
> >>       SysBusDevice *s;
> >> +    unsigned int smp_cpus = machine->topo.smp_cpus;
> >> +    unsigned int max_cpus = machine->topo.max_cpus;
> >>   
> >>       /* init CPUs */
> >>       for(i = 0; i < smp_cpus; i++) {
> >> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> >> index 399f2d7..d089c4d 100644
> >> --- a/hw/sparc64/sun4u.c
> >> +++ b/hw/sparc64/sun4u.c
> >> @@ -546,6 +546,8 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
> >>       NICInfo *nd;
> >>       MACAddr macaddr;
> >>       bool onboard_nic;
> >> +    unsigned int smp_cpus = machine->topo.smp_cpus;
> >> +    unsigned int max_cpus = machine->topo.max_cpus;
> >>   
> >>       /* init CPUs */
> >>       cpu = sparc64_cpu_devinit(machine->cpu_type, hwdef->prom_addr);
> >> diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
> >> index 12c7437..cc0396b 100644
> >> --- a/hw/xtensa/sim.c
> >> +++ b/hw/xtensa/sim.c
> >> @@ -59,6 +59,7 @@ static void xtensa_sim_init(MachineState *machine)
> >>       ram_addr_t ram_size = machine->ram_size;
> >>       const char *kernel_filename = machine->kernel_filename;
> >>       int n;
> >> +    unsigned int smp_cpus = machine->topo.smp_cpus;
> >>   
> >>       for (n = 0; n < smp_cpus; n++) {
> >>           cpu = XTENSA_CPU(cpu_create(machine->cpu_type));
> >> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
> >> index e05ef75..f71a15e 100644
> >> --- a/hw/xtensa/xtfpga.c
> >> +++ b/hw/xtensa/xtfpga.c
> >> @@ -238,6 +238,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
> >>       const unsigned system_io_size = 224 * MiB;
> >>       uint32_t freq = 10000000;
> >>       int n;
> >> +    unsigned int smp_cpus = machine->topo.smp_cpus;
> >>   
> >>       if (smp_cpus > 1) {
> >>           mx_pic = xtensa_mx_pic_init(31);  
> > 
> >   
> 


