Received: from eggs.gnu.org ([2001:4830:134:3::10]:41844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e1wQ6-00039v-FD
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e1wQ2-0002ez-F6
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:26:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e1wQ2-0002ei-4v
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:26:06 -0400
Date: Tue, 10 Oct 2017 12:25:59 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171010152559.GB3246@localhost.localdomain>
References: <20171004122851.GJ4760@localhost.localdomain>
	<20171004150816.41ffc161@nial.brq.redhat.com>
	<20171004163434.GN4760@localhost.localdomain>
	<CAKmqyKP6yqWfGbzDnWeeROO=_27TiVSBZvdw1PA5JbRH_m3tcA@mail.gmail.com>
	<20171005110427.647fed06@nial.brq.redhat.com>
	<20171005170906.GF4015@localhost.localdomain>
	<20171006102312.3a9a76c2@nial.brq.redhat.com>
	<20171006114549.GN4015@localhost.localdomain>
	<CAKmqyKMD8Mc5UcV1VwVQ1NmyRWk8cnvaW9HSBfckz+P3tgvcxQ@mail.gmail.com>
	<20171009091229.661d8c30@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171009091229.661d8c30@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/5] xlnx-zcu102: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Marcel Apfelbaum <marcel@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Oct 09, 2017 at 09:12:29AM +0200, Igor Mammedov wrote:
> On Fri, 6 Oct 2017 15:06:57 -0700
> Alistair Francis <alistair.francis@xilinx.com> wrote:
> 
> > On Fri, Oct 6, 2017 at 4:45 AM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > > On Fri, Oct 06, 2017 at 10:23:12AM +0200, Igor Mammedov wrote:  
> > >> On Thu, 5 Oct 2017 14:09:06 -0300
> > >> Eduardo Habkost <ehabkost@redhat.com> wrote:
> > >>  
> > >> > On Thu, Oct 05, 2017 at 11:04:27AM +0200, Igor Mammedov wrote:  
> > >> > > On Wed, 4 Oct 2017 14:39:20 -0700
> > >> > > Alistair Francis <alistair.francis@xilinx.com> wrote:
> > >> > >  
> > >> > > > On Wed, Oct 4, 2017 at 9:34 AM, Eduardo Habkost <ehabkost@redhat.com> wrote:  
> > >> > > > > On Wed, Oct 04, 2017 at 03:08:16PM +0200, Igor Mammedov wrote:  
> > >> > > > >> On Wed, 4 Oct 2017 09:28:51 -0300
> > >> > > > >> Eduardo Habkost <ehabkost@redhat.com> wrote:
> > >> > > > >>  
> > >> > > > >> > On Wed, Oct 04, 2017 at 01:12:32PM +0200, Igor Mammedov wrote:  
> > >> > > > >> > > On Tue, 3 Oct 2017 14:41:17 -0700
> > >> > > > >> > > Alistair Francis <alistair.francis@xilinx.com> wrote:
> > >> > > > >> > >  
> > >> > > > >> > > > On Tue, Oct 3, 2017 at 1:36 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:  
> > >> > > > >> > > > > On Tue, Oct 03, 2017 at 01:05:13PM -0700, Alistair Francis wrote:  
> > >> > > > >> > > > >> List all possible valid CPU options.
> > >> > > > >> > > > >>
> > >> > > > >> > > > >> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> > >> > > > >> > > > >> ---
> > >> > > > >> > > > >>
> > >> > > > >> > > > >>  hw/arm/xlnx-zcu102.c         | 10 ++++++++++
> > >> > > > >> > > > >>  hw/arm/xlnx-zynqmp.c         | 16 +++++++++-------
> > >> > > > >> > > > >>  include/hw/arm/xlnx-zynqmp.h |  1 +
> > >> > > > >> > > > >>  3 files changed, 20 insertions(+), 7 deletions(-)
> > >> > > > >> > > > >>
> > >> > > > >> > > > >> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> > >> > > > >> > > > >> index 519a16ed98..039649e522 100644
> > >> > > > >> > > > >> --- a/hw/arm/xlnx-zcu102.c
> > >> > > > >> > > > >> +++ b/hw/arm/xlnx-zcu102.c
> > >> > > > >> > > > >> @@ -98,6 +98,8 @@ static void xlnx_zynqmp_init(XlnxZCU102 *s, MachineState *machine)
> > >> > > > >> > > > >>      object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
> > >> > > > >> > > > >>                                &error_abort);
> > >> > > > >> > > > >>
> > >> > > > >> > > > >> +    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
> > >> > > > >> > > > >> +                            &error_fatal);  
> > >> > > > >> > > > >
> > >> > > > >> > > > > Do you have plans to support other CPU types to xlnx_zynqmp in
> > >> > > > >> > > > > the future?  If not, I wouldn't bother adding the cpu-type
> > >> > > > >> > > > > property and the extra boilerplate code if it's always going to
> > >> > > > >> > > > > be set to cortex-a53.  
> > >> > > > >> > > >
> > >> > > > >> > > > No, it'll always be A53.
> > >> > > > >> > > >
> > >> > > > >> > > > I did think of that, but I also wanted to use the new option! I also
> > >> > > > >> > > > think there is an advantage in sanely handling users '-cpu' option,
> > >> > > > >> > > > before now we just ignored it, so I think it still does give a
> > >> > > > >> > > > benefit. That'll be especially important on the Xilinx tree (sometimes
> > >> > > > >> > > > people use our machines with a different CPU to 'benchmark' or test
> > >> > > > >> > > > other CPUs with our CoSimulation setup). So I think it does make sense
> > >> > > > >> > > > to keep in.  
> > >> > > > >> > > if cpu isn't user settable, one could just outright die if cpu_type
> > >> > > > >> > > is not NULL and say that user's CLI is wrong.
> > >> > > > >> > > (i.e. don't give users illusion that they allowed to use '-cpu')  
> > >> > > > >> >
> > >> > > > >> > Isn't it exactly what this patch does, by setting:
> > >> > > > >> >     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
> > >> > > > >> >     mc->valid_cpu_types = xlnx_zynqmp_valid_cpus;
> > >> > > > >> > ?
> > >> > > > >> >
> > >> > > > >> > Except that "-cpu cortex-a53" won't die, which is a good thing.  
> > >> > > > >> allowing "-cpu cortex-a53" here, would allow to use feature parsing
> > >> > > > >> which weren't allowed or were ignored before if user supplied '-cpu'.
> > >> > > > >> so I'd more strict and refuse any -cpu and break CLI that tries to use it
> > >> > > > >> if board has non configurable cpu type. It would be easier to relax
> > >> > > > >> restriction later if necessary.
> > >> > > > >>
> > >> > > > >> using validate_cpus here just to have users for the new code,
> > >> > > > >> doesn't seem like valid justification and at that it makes board
> > >> > > > >> code more complex where it's not necessary and build in cpu type
> > >> > > > >> works just fine.  
> > >> > > > >
> > >> > > > > It's up to the board maintainer to decide what's the best option.
> > >> > > > > Both features are independent from each other and can be
> > >> > > > > implemented by machine core.  
> > >> > > >
> > >> > > > Noooo!
> > >> > > >
> > >> > > > My hope with this series is that eventually we could hit a state where
> > >> > > > every single machine acts the same way with the -cpu option.
> > >> > > >
> > >> > > > I really don't like what we do now where some boards use it, some
> > >> > > > boards error and some boars just ignore the option. I think we should
> > >> > > > agree on something and every machine should follow the same flow so
> > >> > > > that users know what to expect when they use the -cpu option.
> > >> > > >
> > >> > > > If this means we allow machines to specify they don't support the
> > >> > > > option or only have a single element in the list of supported options
> > >> > > > doesn't really matter, but all machines should do the same thing.
> > >> > > >  
> > >> > > > >
> > >> > > > > In either case, the valid_cpu_types feature will be still very
> > >> > > > > useful for boards like pxa270 and sa1110, which support -cpu but
> > >> > > > > only with specific families of CPU types (grep for
> > >> > > > > "strncmp(cpu_type").
> > >> > > > >  
> > >> > > > >>
> > >> > > > >> wrt centralized way to refuse -cpu if board doesn't support it,
> > >> > > > >> (which is not really related to this series) following could be done:
> > >> > > > >>
> > >> > > > >> when cpu_model removal is completely done I plan to replace
> > >> > > > >>   vl.c
> > >> > > > >>      cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model)
> > >> > > > >> with
> > >> > > > >>      cpu_parse_cpu_model(DEFAULT_TARGET_CPU_TYPE, cpu_model)
> > >> > > > >>
> > >> > > > >> so that we could drop temporary guard
> > >> > > > >>
> > >> > > > >>      if (machine_class->default_cpu_type) {  
> > >> > > > >
> > >> > > > > This sounds good to me, even if we don't reject -cpu on any
> > >> > > > > board.
> > >> > > > >
> > >> > > > >  
> > >> > > > >>
> > >> > > > >> with that it would be possible to tell from machine_run_board_init()
> > >> > > > >> that board doesn't provide cpu but user provided '-cpu'
> > >> > > > >> so we would be able to:
> > >> > > > >>   if ((machine_class->default_cpu_type == NULL) &&
> > >> > > > >>       (machine->cpu_type != NULL))
> > >> > > > >>           error_fatal("machine doesn't support -cpu option");  
> > >> > > > >
> > >> > > > > I won't complain too much if a board maintainer really wants to
> > >> > > > > make the board reject -cpu completely, but it's up to them.  
> > >> > > >
> > >> > > > I disagree. I think a standard way of doing it is better. At least for
> > >> > > > each architecture. The ARM -cpu option is very confusing at the moment
> > >> > > > and it really doesn't need to be that bad.
> > >> > > >  
> > >> > > > >
> > >> > > > > Personally, I'd prefer to have all boards setting
> > >> > > > > default_cpu_type even if they support only one CPU model, so
> > >> > > > > clients don't need a special case for boards that don't support
> > >> > > > > -cpu.  
> > >> > > >
> > >> > > > I agree, I think having one CPU makes more sense. It makes it easier
> > >> > > > to add support for more cpus in the future and allows the users to use
> > >> > > > the -cpu option without killing QEMU.  
> > >> > > I'm considering -cpu option as a legacy one that server 2 purposes now  
> > >> >
> > >> > I'm not sure about "legacy", but the list of purposes looks
> > >> > accurate:
> > >> >  
> > >> > >  1: pick cpu type for running instance  
> > >> >
> > >> > This one has no replacement yet, so can we really call it legacy?  
> > >> not really, it's not going anywhere in near future
> > >>  
> > >> >  
> > >> > >  2: convert optional features/legacy syntax to global properties
> > >> > >     for related cpu type  
> > >> >
> > >> > This one has a replacement: -global.  But there's a difference
> > >> > between saying "-cpu features are implemented using -global" and
> > >> > "-cpu features are obsoleted by -global".  I don't think we can
> > >> > say it's obsolete or legacy unless existing management software
> > >> > is changed to be using something else.
> > >> >
> > >> >  
> > >> > >
> > >> > > It plays ok for machines with single type of cpu but doesn't really scale
> > >> > > to more and doesn't work well nor needed if we were to specify cpus on CLI
> > >> > > with -device (i.e. build machine from config/CLI)  
> > >> >
> > >> > This is a good point.  But -cpu is still a useful shortcut for
> > >> > boards that have a single CPU type.  What are the arguments we
> > >> > have to get rid of it completely?  
> > >> boards that have single cpu type don't need -cpu. since cpu is not
> > >> configurable there.  
> > >
> > > They don't need -cpu, but there's no need to reject "-cpu FOO" if
> > > we know FOO is the CPU model used by the board.  This is the only
> > > difference between what you propose and what Alistair proposes,
> > > right?
> > >
> > >  
> > >>
> > >>  
> > >> > > So I would not extend usage '-cpu' to boards that have fixed cpu type,
> > >> > > because it really useless in that case and confuses users with idea that
> > >> > > they have ability/need to specify -cpu on fixed cpu board.  
> > >> >
> > >> > If they try to choose any other CPU model, they will see an error
> > >> > message explicitly saying only one CPU type is supported.  What
> > >> > would be the harm?  
> > >> I guess I've already pointed drawbacks from interface point of view,
> > >> from maintainer pov it will be extra code to maintain valid cpus
> > >> vs just 'create_cpu(MY_CPU_TYPE)'
> > >> this patch is vivid example of the case  
> > >
> > > With this part I agree.  We don't need to add boilerplate code to
> > > board init if the CPU model will always be the same.
> > >
> > > But I would still prefer to do this:
> > >
> > >   create_cpu(MY_CPU_TYPE);  // at XXX_init()
> > > [...]
> > >   static void xxx_class_init(...) {
> > >       mc->default_cpu_type = MY_CPU_TYPE;
> > >       /* Reason: XXX_init() is hardcoded to MY_CPU_TYPE */
> > >       mc->valid_cpu_types = { MY_CPU_TYPE, NULL };
> > >   }  
> > 
> > I like this option. It doesn't add much code and I think makes it very
> > clear to users.
> > 
> > Another thing to point out is that I see users specifying options to
> > QEMU all the time that QEMU will just ignore. Imagine people see
> > somewhere online that others use '-cpu' and suddenly they think they
> > have to. Having this throw an error that '-cpu' isn't supported in
> > this case (but is in others) will create confusion of when it
> > should/shouldn't be use. I think always allowing it and telling users
> > the supported CPUs clears this up.
> 
> patch would look better with what Eduardo suggested above.
> at least it will minimize amount of not need code, so I'd go for it.

I just see one problem: I don't see an easy way for setting:
  mc->valid_cpu_types = { MY_CPU_TYPE, NULL };
without one additional static variable for holding the array.  So
my claim about "only 2 lines of code" is not accurate.

But we might do this to make the code shorter and simpler on
boards like xlnx_zynqmp:

1) Change the default on TYPE_MACHINE to:
     mc->valid_cpu_types = { TYPE_CPU, NULL };

   This will keep the existing behavior for all boards.

2) mc->valid_cpu_types=NULL be interpreted as "no CPU model
   except the default is accepted" or "-cpu is not accepted" in
   machine_run_board_init() (I prefer the former, but both
   options would be correct)

3) Boards like xlnx_zynqmp could then just do this:

   static void xxx_class_init(...) {
       mc->default_cpu_type = MY_CPU_TYPE;
       /* Reason: XXX_init() is hardcoded to MY_CPU_TYPE */
       mc->valid_cpu_types = NULL;
   }


-- 
Eduardo
