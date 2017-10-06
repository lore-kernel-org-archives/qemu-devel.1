Received: from eggs.gnu.org ([2001:4830:134:3::10]:46635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e0amK-0002I7-Hl
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 18:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e0amI-0002fV-2C
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 18:07:32 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:44338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1e0amH-0002ev-Nj
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 18:07:29 -0400
Received: by mail-wm0-x235.google.com with SMTP id 196so4092218wma.1
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 15:07:29 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171006114549.GN4015@localhost.localdomain>
References: <20171003203654.GD4760@localhost.localdomain>
	<CAKmqyKN+QnBAS6c4mAb2EiTVQv3Km6EdmGXCFC3hVogL96QK1Q@mail.gmail.com>
	<20171004131232.32f5caae@nial.brq.redhat.com>
	<20171004122851.GJ4760@localhost.localdomain>
	<20171004150816.41ffc161@nial.brq.redhat.com>
	<20171004163434.GN4760@localhost.localdomain>
	<CAKmqyKP6yqWfGbzDnWeeROO=_27TiVSBZvdw1PA5JbRH_m3tcA@mail.gmail.com>
	<20171005110427.647fed06@nial.brq.redhat.com>
	<20171005170906.GF4015@localhost.localdomain>
	<20171006102312.3a9a76c2@nial.brq.redhat.com>
	<20171006114549.GN4015@localhost.localdomain>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 6 Oct 2017 15:06:57 -0700
Message-ID: <CAKmqyKMD8Mc5UcV1VwVQ1NmyRWk8cnvaW9HSBfckz+P3tgvcxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 3/5] xlnx-zcu102: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>

On Fri, Oct 6, 2017 at 4:45 AM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Fri, Oct 06, 2017 at 10:23:12AM +0200, Igor Mammedov wrote:
>> On Thu, 5 Oct 2017 14:09:06 -0300
>> Eduardo Habkost <ehabkost@redhat.com> wrote:
>>
>> > On Thu, Oct 05, 2017 at 11:04:27AM +0200, Igor Mammedov wrote:
>> > > On Wed, 4 Oct 2017 14:39:20 -0700
>> > > Alistair Francis <alistair.francis@xilinx.com> wrote:
>> > >
>> > > > On Wed, Oct 4, 2017 at 9:34 AM, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> > > > > On Wed, Oct 04, 2017 at 03:08:16PM +0200, Igor Mammedov wrote:
>> > > > >> On Wed, 4 Oct 2017 09:28:51 -0300
>> > > > >> Eduardo Habkost <ehabkost@redhat.com> wrote:
>> > > > >>
>> > > > >> > On Wed, Oct 04, 2017 at 01:12:32PM +0200, Igor Mammedov wrote:
>> > > > >> > > On Tue, 3 Oct 2017 14:41:17 -0700
>> > > > >> > > Alistair Francis <alistair.francis@xilinx.com> wrote:
>> > > > >> > >
>> > > > >> > > > On Tue, Oct 3, 2017 at 1:36 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> > > > >> > > > > On Tue, Oct 03, 2017 at 01:05:13PM -0700, Alistair Francis wrote:
>> > > > >> > > > >> List all possible valid CPU options.
>> > > > >> > > > >>
>> > > > >> > > > >> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> > > > >> > > > >> ---
>> > > > >> > > > >>
>> > > > >> > > > >>  hw/arm/xlnx-zcu102.c         | 10 ++++++++++
>> > > > >> > > > >>  hw/arm/xlnx-zynqmp.c         | 16 +++++++++-------
>> > > > >> > > > >>  include/hw/arm/xlnx-zynqmp.h |  1 +
>> > > > >> > > > >>  3 files changed, 20 insertions(+), 7 deletions(-)
>> > > > >> > > > >>
>> > > > >> > > > >> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
>> > > > >> > > > >> index 519a16ed98..039649e522 100644
>> > > > >> > > > >> --- a/hw/arm/xlnx-zcu102.c
>> > > > >> > > > >> +++ b/hw/arm/xlnx-zcu102.c
>> > > > >> > > > >> @@ -98,6 +98,8 @@ static void xlnx_zynqmp_init(XlnxZCU102 *s, MachineState *machine)
>> > > > >> > > > >>      object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
>> > > > >> > > > >>                                &error_abort);
>> > > > >> > > > >>
>> > > > >> > > > >> +    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
>> > > > >> > > > >> +                            &error_fatal);
>> > > > >> > > > >
>> > > > >> > > > > Do you have plans to support other CPU types to xlnx_zynqmp in
>> > > > >> > > > > the future?  If not, I wouldn't bother adding the cpu-type
>> > > > >> > > > > property and the extra boilerplate code if it's always going to
>> > > > >> > > > > be set to cortex-a53.
>> > > > >> > > >
>> > > > >> > > > No, it'll always be A53.
>> > > > >> > > >
>> > > > >> > > > I did think of that, but I also wanted to use the new option! I also
>> > > > >> > > > think there is an advantage in sanely handling users '-cpu' option,
>> > > > >> > > > before now we just ignored it, so I think it still does give a
>> > > > >> > > > benefit. That'll be especially important on the Xilinx tree (sometimes
>> > > > >> > > > people use our machines with a different CPU to 'benchmark' or test
>> > > > >> > > > other CPUs with our CoSimulation setup). So I think it does make sense
>> > > > >> > > > to keep in.
>> > > > >> > > if cpu isn't user settable, one could just outright die if cpu_type
>> > > > >> > > is not NULL and say that user's CLI is wrong.
>> > > > >> > > (i.e. don't give users illusion that they allowed to use '-cpu')
>> > > > >> >
>> > > > >> > Isn't it exactly what this patch does, by setting:
>> > > > >> >     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
>> > > > >> >     mc->valid_cpu_types = xlnx_zynqmp_valid_cpus;
>> > > > >> > ?
>> > > > >> >
>> > > > >> > Except that "-cpu cortex-a53" won't die, which is a good thing.
>> > > > >> allowing "-cpu cortex-a53" here, would allow to use feature parsing
>> > > > >> which weren't allowed or were ignored before if user supplied '-cpu'.
>> > > > >> so I'd more strict and refuse any -cpu and break CLI that tries to use it
>> > > > >> if board has non configurable cpu type. It would be easier to relax
>> > > > >> restriction later if necessary.
>> > > > >>
>> > > > >> using validate_cpus here just to have users for the new code,
>> > > > >> doesn't seem like valid justification and at that it makes board
>> > > > >> code more complex where it's not necessary and build in cpu type
>> > > > >> works just fine.
>> > > > >
>> > > > > It's up to the board maintainer to decide what's the best option.
>> > > > > Both features are independent from each other and can be
>> > > > > implemented by machine core.
>> > > >
>> > > > Noooo!
>> > > >
>> > > > My hope with this series is that eventually we could hit a state where
>> > > > every single machine acts the same way with the -cpu option.
>> > > >
>> > > > I really don't like what we do now where some boards use it, some
>> > > > boards error and some boars just ignore the option. I think we should
>> > > > agree on something and every machine should follow the same flow so
>> > > > that users know what to expect when they use the -cpu option.
>> > > >
>> > > > If this means we allow machines to specify they don't support the
>> > > > option or only have a single element in the list of supported options
>> > > > doesn't really matter, but all machines should do the same thing.
>> > > >
>> > > > >
>> > > > > In either case, the valid_cpu_types feature will be still very
>> > > > > useful for boards like pxa270 and sa1110, which support -cpu but
>> > > > > only with specific families of CPU types (grep for
>> > > > > "strncmp(cpu_type").
>> > > > >
>> > > > >>
>> > > > >> wrt centralized way to refuse -cpu if board doesn't support it,
>> > > > >> (which is not really related to this series) following could be done:
>> > > > >>
>> > > > >> when cpu_model removal is completely done I plan to replace
>> > > > >>   vl.c
>> > > > >>      cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model)
>> > > > >> with
>> > > > >>      cpu_parse_cpu_model(DEFAULT_TARGET_CPU_TYPE, cpu_model)
>> > > > >>
>> > > > >> so that we could drop temporary guard
>> > > > >>
>> > > > >>      if (machine_class->default_cpu_type) {
>> > > > >
>> > > > > This sounds good to me, even if we don't reject -cpu on any
>> > > > > board.
>> > > > >
>> > > > >
>> > > > >>
>> > > > >> with that it would be possible to tell from machine_run_board_init()
>> > > > >> that board doesn't provide cpu but user provided '-cpu'
>> > > > >> so we would be able to:
>> > > > >>   if ((machine_class->default_cpu_type == NULL) &&
>> > > > >>       (machine->cpu_type != NULL))
>> > > > >>           error_fatal("machine doesn't support -cpu option");
>> > > > >
>> > > > > I won't complain too much if a board maintainer really wants to
>> > > > > make the board reject -cpu completely, but it's up to them.
>> > > >
>> > > > I disagree. I think a standard way of doing it is better. At least for
>> > > > each architecture. The ARM -cpu option is very confusing at the moment
>> > > > and it really doesn't need to be that bad.
>> > > >
>> > > > >
>> > > > > Personally, I'd prefer to have all boards setting
>> > > > > default_cpu_type even if they support only one CPU model, so
>> > > > > clients don't need a special case for boards that don't support
>> > > > > -cpu.
>> > > >
>> > > > I agree, I think having one CPU makes more sense. It makes it easier
>> > > > to add support for more cpus in the future and allows the users to use
>> > > > the -cpu option without killing QEMU.
>> > > I'm considering -cpu option as a legacy one that server 2 purposes now
>> >
>> > I'm not sure about "legacy", but the list of purposes looks
>> > accurate:
>> >
>> > >  1: pick cpu type for running instance
>> >
>> > This one has no replacement yet, so can we really call it legacy?
>> not really, it's not going anywhere in near future
>>
>> >
>> > >  2: convert optional features/legacy syntax to global properties
>> > >     for related cpu type
>> >
>> > This one has a replacement: -global.  But there's a difference
>> > between saying "-cpu features are implemented using -global" and
>> > "-cpu features are obsoleted by -global".  I don't think we can
>> > say it's obsolete or legacy unless existing management software
>> > is changed to be using something else.
>> >
>> >
>> > >
>> > > It plays ok for machines with single type of cpu but doesn't really scale
>> > > to more and doesn't work well nor needed if we were to specify cpus on CLI
>> > > with -device (i.e. build machine from config/CLI)
>> >
>> > This is a good point.  But -cpu is still a useful shortcut for
>> > boards that have a single CPU type.  What are the arguments we
>> > have to get rid of it completely?
>> boards that have single cpu type don't need -cpu. since cpu is not
>> configurable there.
>
> They don't need -cpu, but there's no need to reject "-cpu FOO" if
> we know FOO is the CPU model used by the board.  This is the only
> difference between what you propose and what Alistair proposes,
> right?
>
>
>>
>>
>> > > So I would not extend usage '-cpu' to boards that have fixed cpu type,
>> > > because it really useless in that case and confuses users with idea that
>> > > they have ability/need to specify -cpu on fixed cpu board.
>> >
>> > If they try to choose any other CPU model, they will see an error
>> > message explicitly saying only one CPU type is supported.  What
>> > would be the harm?
>> I guess I've already pointed drawbacks from interface point of view,
>> from maintainer pov it will be extra code to maintain valid cpus
>> vs just 'create_cpu(MY_CPU_TYPE)'
>> this patch is vivid example of the case
>
> With this part I agree.  We don't need to add boilerplate code to
> board init if the CPU model will always be the same.
>
> But I would still prefer to do this:
>
>   create_cpu(MY_CPU_TYPE);  // at XXX_init()
> [...]
>   static void xxx_class_init(...) {
>       mc->default_cpu_type = MY_CPU_TYPE;
>       /* Reason: XXX_init() is hardcoded to MY_CPU_TYPE */
>       mc->valid_cpu_types = { MY_CPU_TYPE, NULL };
>   }

I like this option. It doesn't add much code and I think makes it very
clear to users.

Another thing to point out is that I see users specifying options to
QEMU all the time that QEMU will just ignore. Imagine people see
somewhere online that others use '-cpu' and suddenly they think they
have to. Having this throw an error that '-cpu' isn't supported in
this case (but is in others) will create confusion of when it
should/shouldn't be use. I think always allowing it and telling users
the supported CPUs clears this up.

Thanks,
Alistair

>
> because this will let management software know that the board
> creates CPU of type MY_CPU_TYPE.
>
>>
>>
>> > > I'd be upfront with users and fail explicitly if -cpu is not supported
>> > > (yes, it is not uniform CLI behavior across machines but it makes
>> > > sense since not all machines are the same, there probably are other
>> > > options with which some machines error out with unsupported error,
>> > > -cpu is not any different case).
>> >
>> > I'm not strongly for/against neither of those two approaches, but
>> > I'm inclined towards letting all (or most) machines support -cpu
>> > as suggested by Alistair.
>> Alistair said 'I also wanted to use the new option!'
>> and not allow users to specify a cpu for 'testing' that will be ignored anyways.
>> there are 2 ways to do the later
>>   1. complicated, do it using valid_cpus as in this patch
>>      and error out if wrong cpu is specified
>>   2. simple, error out if board doesn't allow to change cpu type.
>>      could also be done from one centralized place and
>>      a board developer won't need to add extra to to support
>>      default/valid cpus at all
>
> Well, the "complicated" option is just 2 lines of code at
> class_init.  (see above)
>
>
>>
>> > I see advantages in having less code relying on -cpu, and
>> > replacing it with something more generic.  But I also see
>> > advantages into reusing the same logic (both inside QEMU and on
>> > management software) to query/configure/create CPUs for the cases
>> > where a single CPU type is used.
>> management shouldn't care about querying cpu types for machines
>> with fixed cpu as it won't be really able to configure it.
>
> Management could show the user what's the CPU used by the board.
> "-machine BOARD -cpu help" could show the user what's the CPU
> used by the board.
>
>>
>>
>> > I'd be more inclined to agree with you if -cpu was really an
>> > obsolete option that was already completely replaced by something
>> > else.  But the reality is that there's no generic mechanism to
>> > choose the CPU type yet.
>> there is no choice with fixed cpu boards, it's just soldered on.
>
> True, but what's the harm in saying "there's no choice, and the
> only choice is cortex-a53" instead of "there's no choice, and I
> won't tell you what's the CPU type"?
>
>>
>> > Unless we officially document -cpu as obsolete and point
>> > users/developers to a replacement, I don't see the problem with
>> > making "-cpu <model>" work on more (or all?) boards.
>> as I've already pointed out issues are:
>>  - it's confusing for user (he/she sees ability to specify cpu)
>
> Where exactly does the user "sees" the ability to specify the CPU?
>
>>  - using -cpu won't have any effect in practice
>
> True, but why this is a problem?
>
> "-cpu qemu64" doesn't have any effect in practice in x86 but we
> don't make PC reject "-cpu qemu64".  "-cpu cortex-a53" won't have
> any effect on xlnz-zcu102, but we don't need to make QEMU error
> out, either.
>
>
>>  - extra code vs just creating build in cpu, confusing for developer
>
> The extra code is just 2 lines of code in class_init.
>
> We could even make it 1 line of code, if we define
> valid_cpu_types=NULL as equivalent to { default_cpu_type, NULL }
> (but only after we make all boards that truly support -cpu today
> set valid_cpu_types).
>
>>
>> all of above could be avoided by bailing out if -cpu is used with
>> fixed cpu boards.
>
> The only problem I see above is "extra code", but it's only
> 2 lines of code on class_init.
>
> This means I don't think it's an argument against doing it on a
> specific board if the board maintainer wants to.
>
> However, this might be an argument for not requiring it to be
> done on all boards, unless there's a visible benefit for the user
> or management software.
>
>>
>> PS:
>> I can come up with another option that have a fixed value
>> for a some boards, should we replace their hardcoded values
>> with extra generic handling of useless for board option too?
>> Lets not go down the road of enabling something where it
>> doesn't make much sense and only adds up to confusion/maintenance.
>
> --
> Eduardo
>
