Received: from eggs.gnu.org ([2001:4830:134:3::10]:59057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etPfj-0002S1-Ja
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 22:23:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etPfh-0000i2-0X
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 22:23:19 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:35083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etPfg-0000hY-OQ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 22:23:16 -0500
Received: by mail-oi0-x243.google.com with SMTP id x10so639737oig.2
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 19:23:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180306095834.187ce0bc@redhat.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-4-git-send-email-mjc@sifive.com>
	<20180305104447.41953c9e@redhat.com>
	<CAHNT7NtLiVnRrm35o=-47hBr6CMTOatPEfpJ5jFx5HLTPBY2NA@mail.gmail.com>
	<20180306095834.187ce0bc@redhat.com>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 7 Mar 2018 16:23:15 +1300
Message-ID: <CAHNT7NuJCXj7K2iOruRyenr+VQa_x+dtGFC09Ys6461xPgy7Yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 03/23] RISC-V CPU Core Definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Tue, Mar 6, 2018 at 9:58 PM, Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 6 Mar 2018 11:24:02 +1300
> Michael Clark <mjc@sifive.com> wrote:
>
> > On Mon, Mar 5, 2018 at 10:44 PM, Igor Mammedov <imammedo@redhat.com>
> wrote:
> >
> > > On Sat,  3 Mar 2018 02:51:31 +1300
> > > Michael Clark <mjc@sifive.com> wrote:
> > >
> > > > Add CPU state header, CPU definitions and initialization routines
> > > >
> > > > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > > > Signed-off-by: Sagar Karandikar <sagark@eecs.berkeley.edu>
> > > > Signed-off-by: Michael Clark <mjc@sifive.com>
> > > > ---
> > > >  target/riscv/cpu.c      | 432 ++++++++++++++++++++++++++++++
> > > ++++++++++++++++++
> > > >  target/riscv/cpu.h      | 296 +++++++++++++++++++++++++++++++++
> > > >  target/riscv/cpu_bits.h | 411 ++++++++++++++++++++++++++++++
> > > +++++++++++++++
> > > >  3 files changed, 1139 insertions(+)
> > > >  create mode 100644 target/riscv/cpu.c
> > > >  create mode 100644 target/riscv/cpu.h
> > > >  create mode 100644 target/riscv/cpu_bits.h
> > > >
> > > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > > new file mode 100644
> > > > index 0000000..4851890
> > > > --- /dev/null
> > > > +++ b/target/riscv/cpu.c
> > > [...]
> > >
> > > > +
> > > > +typedef struct RISCVCPUInfo {
> > > > +    const int bit_widths;
> > > > +    const char *name;
> > > > +    void (*initfn)(Object *obj);
> > > > +} RISCVCPUInfo;
> > > > +
> > > [...]
> > >
> > > > +static const RISCVCPUInfo riscv_cpus[] = {
> > > > +    { 96, TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init },
> > > > +    { 32, TYPE_RISCV_CPU_RV32GCSU_V1_09_1,
> > > rv32gcsu_priv1_09_1_cpu_init },
> > > > +    { 32, TYPE_RISCV_CPU_RV32GCSU_V1_10_0,
> > > rv32gcsu_priv1_10_0_cpu_init },
> > > > +    { 32, TYPE_RISCV_CPU_RV32IMACU_NOMMU,
> rv32imacu_nommu_cpu_init },
> > > > +    { 32, TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init
> },
> > > > +    { 32, TYPE_RISCV_CPU_SIFIVE_U34,
>  rv32gcsu_priv1_10_0_cpu_init
> > > },
> > > > +    { 64, TYPE_RISCV_CPU_RV64GCSU_V1_09_1,
> > > rv64gcsu_priv1_09_1_cpu_init },
> > > > +    { 64, TYPE_RISCV_CPU_RV64GCSU_V1_10_0,
> > > rv64gcsu_priv1_10_0_cpu_init },
> > > > +    { 64, TYPE_RISCV_CPU_RV64IMACU_NOMMU,
> rv64imacu_nommu_cpu_init },
> > > > +    { 64, TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_init
> },
> > > > +    { 64, TYPE_RISCV_CPU_SIFIVE_U54,
>  rv64gcsu_priv1_10_0_cpu_init
> > > },
> > > > +    { 0, NULL, NULL }
> > > > +};
> > > > +
> > > [...]
> > >
> > > > +static void cpu_register(const RISCVCPUInfo *info)
> > > > +{
> > > > +    TypeInfo type_info = {
> > > > +        .name = info->name,
> > > > +        .parent = TYPE_RISCV_CPU,
> > > > +        .instance_size = sizeof(RISCVCPU),
> > > > +        .instance_init = info->initfn,
> > > > +    };
> > > > +
> > > > +    type_register(&type_info);
> > > > +}
> > > [...]
> > >
> > > > +void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf)
> > > > +{
> > > > +    const RISCVCPUInfo *info = riscv_cpus;
> > > > +
> > > > +    while (info->name) {
> > > > +        if (info->bit_widths & TARGET_LONG_BITS) {
> > > > +            (*cpu_fprintf)(f, "%s\n", info->name);
> > > > +        }
> > > > +        info++;
> > > > +    }
> > > > +}
> > > > +
> > > > +static void riscv_cpu_register_types(void)
> > > > +{
> > > > +    const RISCVCPUInfo *info = riscv_cpus;
> > > > +
> > > > +    type_register_static(&riscv_cpu_type_info);
> > > > +
> > > > +    while (info->name) {
> > > > +        if (info->bit_widths & TARGET_LONG_BITS) {
> > > > +            cpu_register(info);
> > > > +        }
> > > > +        info++;
> > > > +    }
> > > > +}
> > > > +
> > > > +type_init(riscv_cpu_register_types)
> > > This still isn't fixed as requested
> > >  http://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06412.html
> >
> >
> > It's possibly because I explicitly requested a clarification. Pointing
> at a
> > commit and being asked to infer what the desired change is, is not what I
> > would call reasonable feedback. The code has already been reviewed.
> Well, it's been pointed since v4 (it's not like change has been asked for
> at the last moment) and no one asked for clarification.
>
>
> > We have
> > just expanded on it in a manner consistent with how the ARM port handled
> > cpu initialization.
> > I'm happy to comply if you give me detailed instructions on what is
> wrong,
> > why, and how to fix it versus infer your problem from this commit to
> > another architecture.
> >
> > Apologies if i'm a bit slow, but I really don't understand the change you
> > intend us to make.
> There is nothing wrong and it's totally ok to use existing code to
> start with writing new patches. The only thing is that it's moving
> codebase and new patches shouldn't interfere with ongoing work done
> by others. Hence sometimes you see comments requesting to use
> a particular approach to do something that could be done in
> various ways.
>
> In this specific case used reference code (ARM) still uses old way
> register CPU types that is phased out in favor of DEFINE_TYPES.
>
> There is nothing that warrants usage of custom 'struct RISCVCPUInfo'
> and riscv_cpu_register_types().
> You should use pretty trivial approach used in 974e58d2, namely:
>
>  1   rewrite riscv_cpu_list() to use object_class_get_list()
>      instead of 'struct RISCVCPUInfo', example sh4_cpu_list()
>

I've done this. I'll send a patches shortly. Diffstat after this change is
not promising.:

 cpu.c |   43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

 2.1 drop 'struct RISCVCPUInfo' and use TypeInfo array instead
>      superh_cpu_type_infos[] and DEFINE_SUPERH_CPU_TYPE() could serve as
> example
>

The RISC-V port has a common codebase for riscv32 and riscv64 and we are
now using RISCVCPUInfo to contain a mask of the supported bitwidths of each
CPU. It allowed us to remove #ifdef at the expense of several cycles at
runtime in cpu_register. Some of the generic models can be used on any
bitwidth. e.g. "any" can be instantiated on any bitwidth. We could further
reduce code if we were to format the bitwidth into the model name, with the
current cpu initialisation model. This was added so that we can use the
RISC-V ISA strings as model names for the generic CPUs and mask the SiFive
in or out depending on whether we are compiling for TARGET_RISCV32
or TARGET_RISCV64

The arm style is intrinsicly compact without the use of macros because it
uses a templace type in cpu_register. In any case this particular change is
a win in terms of lines of code.

 cpu.c |   87
++++++++++++++++++++++++++++--------------------------------------
 1 file changed, 38 insertions(+), 49 deletions(-)

 2.2 replace riscv_cpu_register_types/type_init with DEFINE_TYPES()
>
> That way your code will be consistent with direction this part
> moves towards and when others work on generalizing CPU related parts
> they won't have to deal with one more instance of old style cpu
> types init and listing.
>

I just squashed them. Now we have added some more C macros, #ifdefs and
several more lines of code. BTW, all of the current machines select
specific processors, however, this may change, but it is likely we may want
to use RISCVCPUInfo to contain additional information as to which
processors are compatible with which boards/machines. With this patch we
lose our custom meta-data; currently bit width mask.

 cpu.c |  124
+++++++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 70 insertions(+), 54 deletions(-)

Okay. Done. I'll send a patch for review in a moment... Tell me what you
think when you do a side-by-side comparison...

It doesn't break anything so I'm not fussed either way...
