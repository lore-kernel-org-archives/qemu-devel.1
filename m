Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E3BC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F7A421D92
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7A421D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOLBX-0006KG-91
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 09:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1kOLAz-0005u7-3h
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:32:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:55088)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1kOLAv-0004of-SH
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:32:44 -0400
IronPort-SDR: mTBHSFB1e3ZxZgvSB8zIaM3gdNAKEyTQhHA/F/O5uvjT5m+RRHssHVFKha4oVEvOkO2I3wYQIe
 RCvMek/HaHOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="163082459"
X-IronPort-AV: E=Sophos;i="5.77,327,1596524400"; d="scan'208";a="163082459"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2020 06:32:35 -0700
IronPort-SDR: GFEdzbfaVKoQHU2ZjwReX707fWCttz0ezP8EuqdEu5llYsUQYfKakHjW6H088t1WGnrYlvVh1B
 zUVXN+QXbLyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,327,1596524400"; d="scan'208";a="458621125"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by orsmga004.jf.intel.com with ESMTP; 02 Oct 2020 06:32:32 -0700
Message-ID: <4be42f1946b414d1ede60c3d5b6ce8666af3d4cc.camel@linux.intel.com>
Subject: Re: [PATCH v4 1/2] Introduce (x86) CPU model deprecation API
From: Robert Hoo <robert.hu@linux.intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 02 Oct 2020 21:32:31 +0800
In-Reply-To: <20200930215611.GB3717385@habkost.net>
References: <1600758855-80046-1-git-send-email-robert.hu@linux.intel.com>
 <20200930215611.GB3717385@habkost.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=134.134.136.65;
 envelope-from=robert.hu@linux.intel.com; helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 09:32:38
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com, robert.hu@intel.com,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-09-30 at 17:56 -0400, Eduardo Habkost wrote:
> On Tue, Sep 22, 2020 at 03:14:14PM +0800, Robert Hoo wrote:
> > Complement versioned CPU model framework with the ability of
> > marking some
> > versions deprecated. When that CPU model is chosen, get some
> > warning. The
> > warning message is customized, e.g. telling in which future QEMU
> > version will
> > it be obsoleted.
> > The deprecation message will also appear by x86_cpu_list_entry(),
> > e.g. '-cpu
> > help'.
> > QMP 'query-cpu-definitions' will also return a bool value
> > indicating the
> > deprecation status.
> > 
> > Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> > ---
> > Changelog
> > v4:
> > Move deprecation_note from X86CPUModel to X86CPUDefinition, to make
> > it
> > simple. Also, simplify 2 fields (deprecation_note and deprecated)
> > into 1
> > (deprecation_note).
> > 
> > v3:
> > Make the deprecation implementation CPUClass generic.
> > 
> > v2:
> > Move deprecation check from parse_cpu_option() to
> > machine_run_board_init(), so
> > that it can cover implicit cpu_type assignment cases.
> > Add qapi new member documentation. Thanks Eric for comment and
> > guidance on qapi.
> > 
> > ---
> >  hw/core/machine.c        | 12 ++++++++++--
> >  include/hw/core/cpu.h    |  3 +++
> >  qapi/machine-target.json |  7 ++++++-
> >  target/i386/cpu.c        |  8 ++++++++
> >  4 files changed, 27 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index ea26d61..67fff0b 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -1095,6 +1095,8 @@ MemoryRegion
> > *machine_consume_memdev(MachineState *machine,
> >  void machine_run_board_init(MachineState *machine)
> >  {
> >      MachineClass *machine_class = MACHINE_GET_CLASS(machine);
> > +    ObjectClass *oc = object_class_by_name(machine->cpu_type);
> 
> machine->cpu_type can be NULL...
> 
> > +    CPUClass *cc;
> >  
> >      if (machine->ram_memdev_id) {
> >          Object *o;
> > @@ -1114,11 +1116,10 @@ void machine_run_board_init(MachineState
> > *machine)
> >       * specified a CPU with -cpu check here that the user CPU is
> > supported.
> >       */
> >      if (machine_class->valid_cpu_types && machine->cpu_type) {
> > -        ObjectClass *class = object_class_by_name(machine-
> > >cpu_type);
> >          int i;
> >  
> >          for (i = 0; machine_class->valid_cpu_types[i]; i++) {
> > -            if (object_class_dynamic_cast(class,
> > +            if (object_class_dynamic_cast(oc,
> >                                            machine_class-
> > >valid_cpu_types[i])) {
> >                  /* The user specificed CPU is in the valid field,
> > we are
> >                   * good to go.
> > @@ -1141,6 +1142,13 @@ void machine_run_board_init(MachineState
> > *machine)
> >          }
> >      }
> >  
> > +    /* Check if CPU type is deprecated and warn if so */
> > +    cc = CPU_CLASS(oc);
> > +    if (cc->deprecation_note) {
> 
> ...so this will crash.
> 
> I've changed this to "if (cc && cc->deprecation_note)".

Thanks Eduardo.
> 
> > +        warn_report("CPU model %s is deprecated -- %s", machine-
> > >cpu_type,
> > +                    cc->deprecation_note);
> > +    }
> > +
> >      machine_class->init(machine);
> >  }
> >  
> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > index 99dc33f..c40c29d 100644
> > --- a/include/hw/core/cpu.h
> > +++ b/include/hw/core/cpu.h
> > @@ -155,6 +155,8 @@ struct TranslationBlock;
> >   * @disas_set_info: Setup architecture specific components of
> > disassembly info
> >   * @adjust_watchpoint_address: Perform a target-specific
> > adjustment to an
> >   * address before attempting to match it against watchpoints.
> > + * @deprecation_note: If this CPUClass is deprecated, this field
> > provides
> > + *                    related information.
> >   *
> >   * Represents a CPU family or model.
> >   */
> > @@ -221,6 +223,7 @@ struct CPUClass {
> >      vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr addr,
> > int len);
> >      void (*tcg_initialize)(void);
> >  
> > +    const char *deprecation_note;
> >      /* Keep non-pointer data at the end to minimize holes.  */
> >      int gdb_num_core_regs;
> >      bool gdb_stop_before_watchpoint;
> > diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> > index 698850c..fec3bb8 100644
> > --- a/qapi/machine-target.json
> > +++ b/qapi/machine-target.json
> > @@ -286,6 +286,10 @@
> >  #            in the VM configuration, because aliases may stop
> > being
> >  #            migration-safe in the future (since 4.1)
> >  #
> > +# @deprecated: If true, this CPU model is deprecated and may be
> > removed in
> > +#              in some future version of QEMU according to the
> > QEMU deprecation
> > +#              policy. (since 5.2)
> > +#
> >  # @unavailable-features is a list of QOM property names that
> >  # represent CPU model attributes that prevent the CPU from
> > running.
> >  # If the QOM property is read-only, that means there's no known
> > @@ -310,7 +314,8 @@
> >              'static': 'bool',
> >              '*unavailable-features': [ 'str' ],
> >              'typename': 'str',
> > -            '*alias-of' : 'str' },
> > +            '*alias-of' : 'str',
> > +            'deprecated' : 'bool' },
> >    'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) ||
> > defined(TARGET_I386) || defined(TARGET_S390X) ||
> > defined(TARGET_MIPS)' }
> >  
> >  ##
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 1c58f76..323c7e3 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -1633,6 +1633,7 @@ typedef struct X86CPUDefinition {
> >       * If NULL, version 1 will be registered automatically.
> >       */
> >      const X86CPUVersionDefinition *versions;
> > +    const char *deprecation_note;
> >  } X86CPUDefinition;
> >  
> >  /* Reference to a specific CPU model version */
> > @@ -4992,6 +4993,11 @@ static void
> > x86_cpu_definition_entry(gpointer data, gpointer user_data)
> >      info->migration_safe = cc->migration_safe;
> >      info->has_migration_safe = true;
> >      info->q_static = cc->static_model;
> > +    if (cc->model && cc->model->cpudef->deprecation_note) {
> > +        info->deprecated = true;
> > +    } else {
> > +        info->deprecated = false;
> > +    }
> >      /*
> >       * Old machine types won't report aliases, so that alias
> > translation
> >       * doesn't break compatibility with previous QEMU versions.
> > @@ -5382,9 +5388,11 @@ static void
> > x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
> >  {
> >      X86CPUModel *model = data;
> >      X86CPUClass *xcc = X86_CPU_CLASS(oc);
> > +    CPUClass *cc = CPU_CLASS(oc);
> >  
> >      xcc->model = model;
> >      xcc->migration_safe = true;
> > +    cc->deprecation_note = model->cpudef->deprecation_note;
> >  }
> >  
> >  static void x86_register_cpu_model_type(const char *name,
> > X86CPUModel *model)
> > -- 
> > 1.8.3.1
> > 
> > 
> 
> 


