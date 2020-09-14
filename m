Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4D2C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:52:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1613B20829
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1613B20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHm5b-00047j-6f
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 06:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1kHm3u-000211-UJ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:50:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:62124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1kHm3s-0003Ul-Cv
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:50:18 -0400
IronPort-SDR: 01xze5c0/hULXLsdGObYxRbLoVNyy8I8PSgPcBimSU3fXHidiQJWZ5Z0AVaHACWN/HZSW0jvr9
 vux60c79rdiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9743"; a="159094755"
X-IronPort-AV: E=Sophos;i="5.76,425,1592895600"; d="scan'208";a="159094755"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2020 03:50:12 -0700
IronPort-SDR: D6Ga8BPJT1GlESDyl75B9zIVRecrBcm4pl6S/MAktIAdBsXZSZPuUCJ7qWzxPwTRYvYTn/10kQ
 hHN1TMEo4Rag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,425,1592895600"; d="scan'208";a="301715473"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by orsmga003.jf.intel.com with ESMTP; 14 Sep 2020 03:50:10 -0700
Message-ID: <b3d7de0e900c199e28702584a90a08987862e655.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/2] Introduce (x86) CPU model deprecation API
From: Robert Hoo <robert.hu@linux.intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 14 Sep 2020 18:50:09 +0800
In-Reply-To: <20200911140013.GS1618070@habkost.net>
References: <1591843676-102054-1-git-send-email-robert.hu@linux.intel.com>
 <20200909181506.GM1618070@habkost.net>
 <e3a289f5db0064dd363cb3481d152e20df14b35d.camel@linux.intel.com>
 <20200911140013.GS1618070@habkost.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=134.134.136.65;
 envelope-from=robert.hu@linux.intel.com; helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 06:50:13
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
Cc: xiaoyao.li@intel.com, qemu-devel@nongnu.org, armbru@redhat.com,
 robert.hu@intel.com, chenyi.qiang@intel.com, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2020-09-11 at 10:00 -0400, Eduardo Habkost wrote:
> On Fri, Sep 11, 2020 at 02:22:51PM +0800, Robert Hoo wrote:
> > On Wed, 2020-09-09 at 14:15 -0400, Eduardo Habkost wrote:
> > > Hi,
> > > 
> > > 
> > > > @@ -1129,6 +1130,12 @@ void machine_run_board_init(MachineState
> > > > *machine)
> > > >          }
> > > >      }
> > > >  
> > > > +    /* Check if CPU type is deprecated and warn if so */
> > > > +    cc = CPU_CLASS(oc);
> > > > +    if (cc->deprecation_check) {
> > > > +        cc->deprecation_check(oc);
> > > > +    }
> > > 
> > > Why do we need target-specific code here?  A CPUClass::deprecated
> > > field would be much simpler.
> > > 
> > 
> > Because the Warning message composing is target-specific, using
> > X86CPUVersionDefinition.note.
> > Other targets can have their own warning message composing
> > approaches.
> 
> I think I understand what you were trying to do, but having each
> target with a different warning message would be a bad thing, not
> a desirable feature.  The warning message can be generic.
> 
> > 
> > > > +
> > > >      machine_class->init(machine);
> > > >  }
> > > >  
> > > > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > > > index 497600c..1ca47dc 100644
> > > > --- a/include/hw/core/cpu.h
> > > > +++ b/include/hw/core/cpu.h
> > > > @@ -218,6 +218,7 @@ typedef struct CPUClass {
> > > >      void (*disas_set_info)(CPUState *cpu, disassemble_info
> > > > *info);
> > > >      vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr
> > > > addr,
> > > > int len);
> > > >      void (*tcg_initialize)(void);
> > > > +    void (*deprecation_check)(ObjectClass *oc);
> > > >  
> > > >      /* Keep non-pointer data at the end to minimize holes.  */
> > > >      int gdb_num_core_regs;
> > > > diff --git a/qapi/machine-target.json b/qapi/machine-
> > > > target.json
> > > > index f2c8294..c24f506 100644
> > > > --- a/qapi/machine-target.json
> > > > +++ b/qapi/machine-target.json
> > > > @@ -285,6 +285,10 @@
> > > >  #            in the VM configuration, because aliases may stop
> > > > being
> > > >  #            migration-safe in the future (since 4.1)
> > > >  #
> > > > +# @deprecated: If true, this CPU model is deprecated and may
> > > > be
> > > > removed in
> > > > +#              in some future version of QEMU according to the
> > > > QEMU deprecation
> > > > +#              policy. (since 5.1)
> > > 
> > > Next version needs to say "since 5.2".
> > 
> > Sure.
> > > 
> > > > 
> > > >  
> > > >  /* Get full model name for CPU version */
> > > > @@ -4128,8 +4134,7 @@ static X86CPUVersion
> > > > x86_cpu_model_resolve_version(const X86CPUModel *model)
> > > >      X86CPUVersion v = model->version;
> > > >      if (v == CPU_VERSION_AUTO) {
> > > >          v = default_cpu_version;
> > > > -    }
> > > > -    if (v == CPU_VERSION_LATEST) {
> > > > +    } else if (v == CPU_VERSION_LATEST) {
> > > 
> > > Why is this change necessary?
> > 
> > Just kind of compulsion of avoiding unnecessary if() :-). 'v' can
> > only
> > be one of CPU_VERSION_AUTO and CPU_VERSION_LATEST, unnecessary to
> > judge
> > twice.
> 
> I think this breaks the case where default_cpu_version is set to
> CPU_VERSION_LATEST
> 
OK, understand.
> > > 
> > > >          return x86_cpu_model_last_version(model);
> > > >      }
> > > >      return v;
> > > > @@ -4975,6 +4980,7 @@ static void
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
> > > > @@ -5411,6 +5417,7 @@ static void
> > > > x86_register_cpudef_types(X86CPUDefinition *def)
> > > >          m->cpudef = def;
> > > >          m->version = vdef->version;
> > > >          m->note = vdef->note;
> > > > +        m->deprecated = vdef->deprecated;
> > > >          x86_register_cpu_model_type(name, m);
> > > >  
> > > >          if (vdef->alias) {
> > > > @@ -5418,6 +5425,8 @@ static void
> > > > x86_register_cpudef_types(X86CPUDefinition *def)
> > > >              am->cpudef = def;
> > > >              am->version = vdef->version;
> > > >              am->is_alias = true;
> > > > +            am->note = vdef->note;
> > > 
> > > Is this extra line related to the deprecation feature?
> > > 
> > > It doesn't seem related, and it doesn't seem necessary as the
> > > `note` field is already ignored for alias CPU models.
> > 
> > Because it is unused by other features, I use it to store model
> > specific deprecation message.
> > > 
> > > > +            am->deprecated = vdef->deprecated;
> > > >              x86_register_cpu_model_type(vdef->alias, am);
> > > >          }
> > > >      }
> > > > @@ -7233,6 +7242,37 @@ static Property x86_cpu_properties[] = {
> > > >      DEFINE_PROP_END_OF_LIST()
> > > >  };
> > > >  
> > > > +static void x86_cpu_deprecation_check(ObjectClass *oc)
> > > > +{
> > > > +    X86CPUClass *xcc = X86_CPU_CLASS(oc);
> > > > +    X86CPUVersion effective_version;
> > > > +    const X86CPUVersionDefinition *vdef;
> > > > +
> > > > +    if (xcc->model == NULL) {
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    if (xcc->model->version == CPU_VERSION_LEGACY) {
> > > > +        /* Treat legacy version as v1 */
> > > > +        effective_version = 1;
> > > > +    } else {
> > > > +        effective_version = x86_cpu_model_resolve_version(xcc-
> > > > > model);
> > > > 
> > > > +    }
> > > > +
> > > > +    vdef = xcc->model->cpudef->versions;
> > > > +
> > > > +    if (vdef == NULL) {
> > > > +        return;
> > > > +    } else {
> > > > +        if (vdef[effective_version - 1].deprecated) {
> > > > +            warn_report("Effective CPU model '%s' -- %s",
> > > > +                    x86_cpu_versioned_model_name(xcc->model-
> > > > > cpudef,\
> > > > 
> > > > +                                                effective_vers
> > > > ion)
> > > > ,
> > > > +                    vdef[effective_version - 1].note);
> > > > +        }
> > > > +    }
> > > 
> > > Why do we need this extra logic?  Isn't it simpler to just add a
> > > bool CPUClass::deprecated field, and set:
> > > 
> > >    cpu->deprecated = model->deprecated;
> > > 
> > > inside x86_cpu_cpudef_class_init()?
> > > 
> > 
> > All these are to fulfill the target you expected earlier:
> > 
> > "We need a proper CPU model deprecation API.  Deprecation info
> > should appear on query-cpu-definitions and should trigger a
> > warning when using the CPU model."
> > 
> > So I think each deprecated model shall have its own deprecation
> > message, e.g. by which version it's going to be deprecation, etc.
> 
> There's nothing x86-specific about having deprecated CPU models,
> so I don't understand the reason for the x86-specific hook.
> 
> If the .note field is the reason you added the arch-specific
> hook, you can just add a CPUClass::deprecation_note field and
> make the feature generic.
> 
I tend to agree with you on this generalization requirement.

But then I find it still has some tricky thing, perhaps that's why I
defined this x86 target specific hook:

1) The versioned CPU model is x86 specific (at least at present)

2) Each x86 cpudef CPU model has 1 unversioned cpu_model_type then its
versioned cpu_model_types. Refer to code in
x86_register_cpudef_types(). The unversioned model won't be marked
deprecated as it is unkown when registered. In
machine_run_board_init(), the cpu_model being checked is the
unversioned one, if I set -cpu to its general unversioned model.
In short, the unversioned cpudef CPU model would escape the deprecation
check.

> > 
> > > > +}
> > > > +
> > > >  static void x86_cpu_common_class_init(ObjectClass *oc, void
> > > > *data)
> > > >  {
> > > >      X86CPUClass *xcc = X86_CPU_CLASS(oc);
> > > > @@ -7291,6 +7331,7 @@ static void
> > > > x86_cpu_common_class_init(ObjectClass *oc, void *data)
> > > >      cc->tlb_fill = x86_cpu_tlb_fill;
> > > >  #endif
> > > >      cc->disas_set_info = x86_disas_set_info;
> > > > +    cc->deprecation_check = x86_cpu_deprecation_check;
> > > >  
> > > >      dc->user_creatable = true;
> > > >  }
> > > > -- 
> > > > 1.8.3.1
> > > > 
> > > 
> > > 
> 
> 


