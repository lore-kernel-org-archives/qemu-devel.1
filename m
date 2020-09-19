Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328AEC43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 03:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C7421534
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 03:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C7421534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJTT3-0001Ls-Tm
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 23:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1kJTSH-0000v4-Oh
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 23:22:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:38167)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1kJTSE-000712-Mv
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 23:22:29 -0400
IronPort-SDR: WFDi9myfc39jvCCC5idJWQEf3MpgGXMWsvdMJsDf4DZT/F6Wp+NGX6tYwa7Lvjhk/wtO5gWwld
 4nBPGhF2UFcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="157470238"
X-IronPort-AV: E=Sophos;i="5.77,277,1596524400"; d="scan'208";a="157470238"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2020 20:22:17 -0700
IronPort-SDR: bHbal+9jD70GnoLVoQYgpNhOrAg06kxxTFQb3prIo70WNw1V8idplsi4rbx/A/6o0TRkWl5UYP
 Te2k4PeJ9V9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,277,1596524400"; d="scan'208";a="308155153"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by orsmga006.jf.intel.com with ESMTP; 18 Sep 2020 20:22:13 -0700
Message-ID: <d3a01f58e5ab0886b2e4d53d5a73162769722cd7.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/2] Introduce (x86) CPU model deprecation API
From: Robert Hoo <robert.hu@linux.intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Date: Sat, 19 Sep 2020 11:22:12 +0800
In-Reply-To: <20200918164237.GZ7594@habkost.net>
References: <1600245434-63021-1-git-send-email-robert.hu@linux.intel.com>
 <20200917181831.GU7594@habkost.net>
 <509a84f209fe6ac60b2e4b913a49190d0f1eeaa2.camel@linux.intel.com>
 <20200918164237.GZ7594@habkost.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=192.55.52.93;
 envelope-from=robert.hu@linux.intel.com; helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 23:22:23
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "Hu, Robert" <robert.hu@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2020-09-18 at 16:42 +0000, Eduardo Habkost wrote:
> ...
> > > > ---
> > > > Changelog
> > > > v3:
> > > > Make the deprecation implementation CPUClass generic.
> > > > 
> > > > v2:
> > > > Move deprecation check from parse_cpu_option() to
> > > > machine_run_board_init(), so
> > > > that it can cover implicit cpu_type assignment cases.
> > > 
> > > What do you mean by implicit cpu_type assignment cases?
> > 
> > Means the case that user doesn't explicitly assign '-cpu xxx' but
> > implicitly inherits machine's default cpu type.
> > vl.c
> >     /* parse features once if machine provides default cpu_type */
> >     current_machine->cpu_type = machine_class->default_cpu_type;
> >     if (cpu_option) {
> >         current_machine->cpu_type = parse_cpu_option(cpu_option);
> >     }
> 
> We probably would never deprecate CPU models that are still used
> by default, so this is not an issue.

Understand.
Even though less possible, I think it is still doable, say, firstly
switch the default model to the other one, then deprecate it.
> 
> > > 
> > > Doing it inside parse_cpu_option() like you did in v1 will make
> > > the deprecation warnings appear for *-user too (which is a good
> > > thing).
> > > 
> > 
> > So you changed your mind;-)
> 
> Sorry, I don't remember suggesting this.  I couldn't find any
> reply from myself in v1, and v2 already had the code moved to
> machine_run_board_init().
> 
> Note that doing the check in machine_run_board_init() is not
> necessarily a problem, I'm just trying to understand why the code
> was moved from parse_cpu_option() to machine_run_board_init()
> between v1 and v2.
> 
Sorry, I just searched my Linux mailbox, cannot find previous thread
either. But in my memory, it was your suggestion:) and I prefer this
than doing it in parse_cpu_option() as well, as parse_cpu_option() is
early time, the passed in cpu_model could be not concrete yet. See my
below idea of making unversioned cpu_model virtual.
> > 
> > Could you shed more details? I don't get this point. What do you
> > mean
> > "*-user"?
> 
> I mean QEMU user mode emulator, bsd-user and linux-user (e.g. the
> qemu-x86_64 binary).  They call parse_cpu_option() as well.
> 
Oh, I'm not familiar with these user modes yet. How about leave them
alone at this moment? let's cover most cases, i.e. based on machine
type, first. Then in the future we consider how to expand this to *-
user cases.
> > 
> > > > Add qapi new member documentation. Thanks Eric for comment and
> > > > guidance on qapi.
> > > > 
> > > >  hw/core/machine.c        | 12 ++++++++++--
> > > >  include/hw/core/cpu.h    |  6 ++++++
> > > >  qapi/machine-target.json |  7 ++++++-
> > > >  target/i386/cpu.c        | 29 +++++++++++++++++++++++------
> > > >  4 files changed, 45 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > index ea26d61..b41f88d 100644
> > > > --- a/hw/core/machine.c
> > > > +++ b/hw/core/machine.c
> > > > @@ -1095,6 +1095,8 @@ MemoryRegion
> > > > *machine_consume_memdev(MachineState *machine,
> > > >  void machine_run_board_init(MachineState *machine)
> > > >  {
> > > >      MachineClass *machine_class = MACHINE_GET_CLASS(machine);
> > > > +    ObjectClass *oc = object_class_by_name(machine->cpu_type);
> > > > +    CPUClass *cc;
> > > > 
> > > >      if (machine->ram_memdev_id) {
> > > >          Object *o;
> > > > @@ -1114,11 +1116,10 @@ void
> > > > machine_run_board_init(MachineState
> > > > *machine)
> > > >       * specified a CPU with -cpu check here that the user CPU
> > > > is
> > > > supported.
> > > >       */
> > > >      if (machine_class->valid_cpu_types && machine->cpu_type) {
> > > > -        ObjectClass *class = object_class_by_name(machine-
> > > > > cpu_type);
> > > > 
> > > >          int i;
> > > > 
> > > >          for (i = 0; machine_class->valid_cpu_types[i]; i++) {
> > > > -            if (object_class_dynamic_cast(class,
> > > > +            if (object_class_dynamic_cast(oc,
> > > >                                            machine_class-
> > > > > valid_cpu_types[i])) {
> > > > 
> > > >                  /* The user specificed CPU is in the valid
> > > > field,
> > > > we are
> > > >                   * good to go.
> > > > @@ -1141,6 +1142,13 @@ void machine_run_board_init(MachineState
> > > > *machine)
> > > >          }
> > > >      }
> > > > 
> > > > +    /* Check if CPU type is deprecated and warn if so */
> > > > +    cc = CPU_CLASS(oc);
> > > > +    if (cc->deprecated) {
> > > > +        warn_report("CPU model %s is deprecated -- %s",
> > > > machine-
> > > > > cpu_type,
> > > > 
> > > > +                    cc->deprecation_note);
> > > > +    }
> > > > +
> > > >      machine_class->init(machine);
> > > >  }
> > > > 
> > > > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > > > index 99dc33f..c4b17c8 100644
> > > > --- a/include/hw/core/cpu.h
> > > > +++ b/include/hw/core/cpu.h
> > > > @@ -155,6 +155,10 @@ struct TranslationBlock;
> > > >   * @disas_set_info: Setup architecture specific components of
> > > > disassembly info
> > > >   * @adjust_watchpoint_address: Perform a target-specific
> > > > adjustment to an
> > > >   * address before attempting to match it against watchpoints.
> > > > + * @deprecated: True if this CPU model is deprecated (going to
> > > > be
> > > > removed in
> > > > + *              near future).
> > > > + * @deprecation_note: Message about the deprecation. e.g.
> > > > Since
> > > > which version
> > > > + *                    will it be obsoleted.
> > > 
> > > We don't need two separate fields if (deprecation_note != NULL)
> > > means the CPU model is deprecated.  This is how it was
> > > implemented in MachineClass (see
> > > MachineClass::deprecation_reason).
> > > 
> > 
> > Agree.
> > I think such applies to X86CPUModel::deprecated and
> > X86CPUModel::note
> > as well; and rename X86CPUModel::note --> deprecation_note. How do
> > you
> > like this?
> 
> Sound good!
> 
> > 
> > > >   *
> > > >   * Represents a CPU family or model.
> > > >   */
> > > > @@ -221,6 +225,8 @@ struct CPUClass {
> > > >      vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr
> > > > addr,
> > > > int len);
> > > >      void (*tcg_initialize)(void);
> > > > 
> > > > +    bool deprecated;
> > > > +    const char *deprecation_note;
> > > >      /* Keep non-pointer data at the end to minimize holes.  */
> > > >      int gdb_num_core_regs;
> > > >      bool gdb_stop_before_watchpoint;
> > > > diff --git a/qapi/machine-target.json b/qapi/machine-
> > > > target.json
> > > > index 698850c..fec3bb8 100644
> > > > --- a/qapi/machine-target.json
> > > > +++ b/qapi/machine-target.json
> > > > @@ -286,6 +286,10 @@
> > > >  #            in the VM configuration, because aliases may stop
> > > > being
> > > >  #            migration-safe in the future (since 4.1)
> > > >  #
> > > > +# @deprecated: If true, this CPU model is deprecated and may
> > > > be
> > > > removed in
> > > > +#              in some future version of QEMU according to the
> > > > QEMU deprecation
> > > > +#              policy. (since 5.2)
> > > > +#
> > > >  # @unavailable-features is a list of QOM property names that
> > > >  # represent CPU model attributes that prevent the CPU from
> > > > running.
> > > >  # If the QOM property is read-only, that means there's no
> > > > known
> > > > @@ -310,7 +314,8 @@
> > > >              'static': 'bool',
> > > >              '*unavailable-features': [ 'str' ],
> > > >              'typename': 'str',
> > > > -            '*alias-of' : 'str' },
> > > > +            '*alias-of' : 'str',
> > > > +            'deprecated' : 'bool' },
> > > >    'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) ||
> > > > defined(TARGET_I386) || defined(TARGET_S390X) ||
> > > > defined(TARGET_MIPS)' }
> > > > 
> > > >  ##
> > > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > > index 49d8958..9cb82b7 100644
> > > > --- a/target/i386/cpu.c
> > > > +++ b/target/i386/cpu.c
> > > > @@ -1716,6 +1716,7 @@ typedef struct X86CPUVersionDefinition {
> > > >      const char *alias;
> > > >      const char *note;
> > > >      PropValue *props;
> > > > +    bool       deprecated;
> > > >  } X86CPUVersionDefinition;
> > > > 
> > > >  /* Base definition for a CPU model */
> > > > @@ -1751,6 +1752,11 @@ struct X86CPUModel {
> > > >       * This matters only for "-cpu help" and query-cpu-
> > > > definitions
> > > >       */
> > > >      bool is_alias;
> > > > +    /*
> > > > +     * If true, this model is deprecated, and may be removed
> > > > in
> > > > the future.
> > > > +     * Trying to use it now will cause a warning.
> > > > +     */
> > > > +    bool deprecated;
> > > >  };
> > > > 
> > > >  /* Get full model name for CPU version */
> > > > @@ -5096,6 +5102,7 @@ static void
> > > > x86_cpu_definition_entry(gpointer
> > > > data, gpointer user_data)
> > > >      info->migration_safe = cc->migration_safe;
> > > >      info->has_migration_safe = true;
> > > >      info->q_static = cc->static_model;
> > > > +    info->deprecated = cc->model ? cc->model->deprecated :
> > > > false;
> > > >      /*
> > > >       * Old machine types won't report aliases, so that alias
> > > > translation
> > > >       * doesn't break compatibility with previous QEMU
> > > > versions.
> > > > @@ -5486,9 +5493,12 @@ static void
> > > > x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
> > > >  {
> > > >      X86CPUModel *model = data;
> > > >      X86CPUClass *xcc = X86_CPU_CLASS(oc);
> > > > +    CPUClass *cc = CPU_CLASS(oc);
> > > > 
> > > >      xcc->model = model;
> > > >      xcc->migration_safe = true;
> > > > +    cc->deprecated = model->deprecated;
> > > > +    cc->deprecation_note = g_strdup(model->note);
> > > 
> > > The meaning of cc->deprecation_note and model->note is a bit
> > > ambiguous here.  model->note is not necessarily a deprecation
> > > note, but its contents are being copied unconditionally to
> > > cc->deprecation_note.
> > > 
> > > What about setting cc->deprecation_note only if and only if the
> > > model is deprecated?
> > > 
> > 
> > Agree. Since X86CPUModel::note is actually unused by anything now,
> > going to rename it to deprecation_note as aforementioned.
> 
> .note is used by all the CPU models that set .note.  See for
> example:
> 
> x86 Cascadelake-Server-v1  Intel Xeon Processor (Cascadelake)
> x86 Cascadelake-Server-v2  Intel Xeon Processor (Cascadelake)
> [ARCH_CAPABILITIES]
> x86 Cascadelake-Server-v3  Intel Xeon Processor (Cascadelake)
> [ARCH_CAPABILITIES, no TSX]
> x86 Cascadelake-Server-v4  Intel Xeon Processor (Cascadelake)
> [ARCH_CAPABILITIES, no TSX]
> 
OK, then I'll add another deprecation_note.
> 
> > 
> > A side concern,
> > cc->deprecation_note = g_strdup(model->note);
> > 
> > I don's see where free the cc object. Assuming the dup'ed string,
> > as
> > well as object, will last through QEMU process life time, freed
> > implicitly as this process gone. Is my understanding right?
> 
> We never free QOM class structs (like CPUClass), so that's OK.
> 
> > > 
> > > >  }
> > > > 
> > > >  static void x86_register_cpu_model_type(const char *name,
> > > > X86CPUModel *model)
> > > > @@ -5524,21 +5534,28 @@ static void
> > > > x86_register_cpudef_types(X86CPUDefinition *def)
> > > >      x86_register_cpu_model_type(def->name, m);
> > > > 
> > > >      /* Versioned models: */
> > > > -
> > > >      for (vdef = x86_cpu_def_get_versions(def); vdef->version;
> > > > vdef++) {
> > > > -        X86CPUModel *m = g_new0(X86CPUModel, 1);
> > > > +        X86CPUModel *vm = g_new0(X86CPUModel, 1);
> > > >          g_autofree char *name =
> > > >              x86_cpu_versioned_model_name(def, vdef->version);
> > > > -        m->cpudef = def;
> > > > -        m->version = vdef->version;
> > > > -        m->note = vdef->note;
> > > > -        x86_register_cpu_model_type(name, m);
> > > > +        vm->cpudef = def;
> > > > +        vm->version = vdef->version;
> > > > +        vm->note = vdef->note;
> > > > +        vm->deprecated = vdef->deprecated;
> > > > +        /* If Model-v1 is deprecated, Model is deprecated. */
> > > > +        if (vdef->version == 1 && vdef->deprecated == true) {
> > > > +            m->deprecated = true;
> > > > +            m->note = vdef->note;
> > > 
> > > I'm not sure this rule will always apply.  If we deprecate
> > > "Model-v1" but not "Model-v2", we probably don't want "Model" to
> > > be deprecated too.
> > 
> > Agree
> > > 
> > > Considering that we don't have cases where specific versions are
> > > being deprecated, what about making it as simple as possible and
> > > just add a new X86CPUDefinition::deprecation_note field?  No need
> > > for any new fields in X86CPUModel (model->cpudef-
> > > >deprecation_note
> > > can be used directly), no need for two new fields in CPUClass
> > > (just deprecation_note).
> > 
> > How about eliminating the unversioned CPU model? Then we can still
> > have
> > deprecation_note in X86CPUModel, which looks more natural to me
> > than in
> > X86CPUDefition.
> > For anyway, the unversioned CPU model will eventually be
> > instantiated
> > to its some versioned CPU model. It's like a virtual class.
> 
> What do you mean by eliminating the unversioned CPU model?  Keep
> in mind that we need "-cpu Model" to keep working, because of
> compatibility and also because "-cpu Model" is more convenient.
> 
Yes, keeping "-cpu Model" usage as before is my thought as well. I mean
making it virtual, no real CPU model associate with it, but parse it to
some concrete version when CPUModel initializes.

> There are ways the representation of CPU models + aliases +
> versions can be improved, but I assume you wouldn't want a large
> refactor of the CPU model/version table to get in the way of a
> simple feature.
> 
Yes. Trying as less refactor as possible. I think my changes even
cannot be called refactor at all. :)
My idea is to make unversioned CPU model virtual. I did some patch,
doable:
1) in x86_register_cpudef_types(), don't register cpu_model type for
the unversioned 'Model'.
2) in x86_cpu_class_by_name(), check passed-in cpu_model param
versioned or not, if the virtual unversioned 'Model', parse it to some
concrete version by global default_cpu_version designation.

So, user can still use '-cpu Model' as before, no interface changes.
And no nature changes:
1) in current code, even legacy 'Model', you have created a v1 model
for it. i.e., every virtual 'Model' already has at least one concrete
versioned one.
2) in current code, x86_cpu_model_resolve_version() is called when
x86_cpu_load_model(). x86_cpu_model_resolve_version() actually does
kind of work that concreting unversioned Model to its versioned one, by
global default_cpu_version designation. Same as my aforementioned
above.

Would you like me to integrate this implementation in v4? to have a
look.
> > 
> > > 
> > > If one day we decide to deprecate just some versions of a CPU
> > > model, we can extend X86CPUVersionDefinition in the future.
> > > 
> > > > +        }
> > > > +        x86_register_cpu_model_type(name, vm);
> > > > 
> > > >          if (vdef->alias) {
> > > >              X86CPUModel *am = g_new0(X86CPUModel, 1);
> > > >              am->cpudef = def;
> > > >              am->version = vdef->version;
> > > >              am->is_alias = true;
> > > > +            am->note = vdef->note;
> > > > +            am->deprecated = vdef->deprecated;
> > > >              x86_register_cpu_model_type(vdef->alias, am);
> > > >          }
> > > >      }
> > > > --
> > > > 1.8.3.1
> > > > 
> > > 
> > > 
> 
> --
> Eduardo
> 


