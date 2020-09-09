Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196F0C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:17:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D222078E
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MP7KfMkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D222078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG4f0-0003JQ-Ct
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 14:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kG4ck-0001YJ-DN
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:15:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51481
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kG4ci-0003nr-6X
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599675310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8lWowCEYpxOGmMu23N5qiCWDodHf7aQ163SpneULwt0=;
 b=MP7KfMkjMO+MB/1teUg3HwZ/qMw6nYYTlqZqsGzNQZt2Lvl7x26K2i/KK4RLPMmofm6RZ4
 CEXwR6E7dXQq6PBrN23VhSc/vtijUvCpIXpt4y/2IF3eR1gM8+w5piSABXIAbkf0/SMQ4l
 rqFOB2BY4iM5s6ynO7OjXeRcxcNrkTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-rlLie-o-MdKvLs2SJHeD9g-1; Wed, 09 Sep 2020 14:15:09 -0400
X-MC-Unique: rlLie-o-MdKvLs2SJHeD9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 732B718BA285;
 Wed,  9 Sep 2020 18:15:07 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33977838CC;
 Wed,  9 Sep 2020 18:15:06 +0000 (UTC)
Date: Wed, 9 Sep 2020 14:15:06 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Robert Hoo <robert.hu@linux.intel.com>
Subject: Re: [PATCH v2 1/2] Introduce (x86) CPU model deprecation API
Message-ID: <20200909181506.GM1618070@habkost.net>
References: <1591843676-102054-1-git-send-email-robert.hu@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <1591843676-102054-1-git-send-email-robert.hu@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 14:15:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

Thanks for the patch, and sorry for taking so long to review
this.  I'm finally getting to the patches that were postponed to
5.2.

Comments and questions below:

On Thu, Jun 11, 2020 at 10:47:55AM +0800, Robert Hoo wrote:
> Complement versioned CPU model framework with the ability of marking some
> versions deprecated. When that CPU model is chosen, get some warning. The
> warning message is customized, e.g. telling in which future QEMU version will
> it be obsoleted.
> The deprecation message will also appear by x86_cpu_list_entry(), e.g. '-cpu
> help'.
> QMP 'query-cpu-definitions' will also return a bool value indicating the
> deprecation status.
> 
> Changes in v2:
> Move deprecation check from parse_cpu_option() to machine_run_board_init(), so
> that it can cover implicit cpu_type assignment cases.
> Add qapi new member documentation. Thanks Eric for comment and guidance on qapi.
> 
> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> ---
>  hw/core/machine.c        | 11 +++++++++--
>  include/hw/core/cpu.h    |  1 +
>  qapi/machine-target.json |  7 ++++++-
>  target/i386/cpu.c        | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 59 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index bb3a7b1..9318964 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1083,6 +1083,8 @@ MemoryRegion *machine_consume_memdev(MachineState *machine,
>  void machine_run_board_init(MachineState *machine)
>  {
>      MachineClass *machine_class = MACHINE_GET_CLASS(machine);
> +    ObjectClass *oc = object_class_by_name(machine->cpu_type);
> +    CPUClass *cc;
>  
>      if (machine->ram_memdev_id) {
>          Object *o;
> @@ -1102,11 +1104,10 @@ void machine_run_board_init(MachineState *machine)
>       * specified a CPU with -cpu check here that the user CPU is supported.
>       */
>      if (machine_class->valid_cpu_types && machine->cpu_type) {
> -        ObjectClass *class = object_class_by_name(machine->cpu_type);
>          int i;
>  
>          for (i = 0; machine_class->valid_cpu_types[i]; i++) {
> -            if (object_class_dynamic_cast(class,
> +            if (object_class_dynamic_cast(oc,
>                                            machine_class->valid_cpu_types[i])) {
>                  /* The user specificed CPU is in the valid field, we are
>                   * good to go.
> @@ -1129,6 +1130,12 @@ void machine_run_board_init(MachineState *machine)
>          }
>      }
>  
> +    /* Check if CPU type is deprecated and warn if so */
> +    cc = CPU_CLASS(oc);
> +    if (cc->deprecation_check) {
> +        cc->deprecation_check(oc);
> +    }

Why do we need target-specific code here?  A CPUClass::deprecated
field would be much simpler.

> +
>      machine_class->init(machine);
>  }
>  
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 497600c..1ca47dc 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -218,6 +218,7 @@ typedef struct CPUClass {
>      void (*disas_set_info)(CPUState *cpu, disassemble_info *info);
>      vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr addr, int len);
>      void (*tcg_initialize)(void);
> +    void (*deprecation_check)(ObjectClass *oc);
>  
>      /* Keep non-pointer data at the end to minimize holes.  */
>      int gdb_num_core_regs;
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index f2c8294..c24f506 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -285,6 +285,10 @@
>  #            in the VM configuration, because aliases may stop being
>  #            migration-safe in the future (since 4.1)
>  #
> +# @deprecated: If true, this CPU model is deprecated and may be removed in
> +#              in some future version of QEMU according to the QEMU deprecation
> +#              policy. (since 5.1)

Next version needs to say "since 5.2".

> +#
>  # @unavailable-features is a list of QOM property names that
>  # represent CPU model attributes that prevent the CPU from running.
>  # If the QOM property is read-only, that means there's no known
> @@ -309,7 +313,8 @@
>              'static': 'bool',
>              '*unavailable-features': [ 'str' ],
>              'typename': 'str',
> -            '*alias-of' : 'str' },
> +            '*alias-of' : 'str',
> +            'deprecated' : 'bool' },
>    'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }
>  
>  ##
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index ba05da3..0d8638a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1599,6 +1599,7 @@ typedef struct X86CPUVersionDefinition {
>      const char *alias;
>      const char *note;
>      PropValue *props;
> +    bool       deprecated;
>  } X86CPUVersionDefinition;
>  
>  /* Base definition for a CPU model */
> @@ -1638,6 +1639,11 @@ struct X86CPUModel {
>       * This matters only for "-cpu help" and query-cpu-definitions
>       */
>      bool is_alias;
> +    /*
> +     * If true, this model is deprecated, and may be removed in the future.
> +     * Trying to use it now will cause a warning.
> +     */
> +    bool deprecated;
>  };
>  
>  /* Get full model name for CPU version */
> @@ -4128,8 +4134,7 @@ static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
>      X86CPUVersion v = model->version;
>      if (v == CPU_VERSION_AUTO) {
>          v = default_cpu_version;
> -    }
> -    if (v == CPU_VERSION_LATEST) {
> +    } else if (v == CPU_VERSION_LATEST) {

Why is this change necessary?

>          return x86_cpu_model_last_version(model);
>      }
>      return v;
> @@ -4975,6 +4980,7 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
>      info->migration_safe = cc->migration_safe;
>      info->has_migration_safe = true;
>      info->q_static = cc->static_model;
> +    info->deprecated = cc->model ? cc->model->deprecated : false;
>      /*
>       * Old machine types won't report aliases, so that alias translation
>       * doesn't break compatibility with previous QEMU versions.
> @@ -5411,6 +5417,7 @@ static void x86_register_cpudef_types(X86CPUDefinition *def)
>          m->cpudef = def;
>          m->version = vdef->version;
>          m->note = vdef->note;
> +        m->deprecated = vdef->deprecated;
>          x86_register_cpu_model_type(name, m);
>  
>          if (vdef->alias) {
> @@ -5418,6 +5425,8 @@ static void x86_register_cpudef_types(X86CPUDefinition *def)
>              am->cpudef = def;
>              am->version = vdef->version;
>              am->is_alias = true;
> +            am->note = vdef->note;

Is this extra line related to the deprecation feature?

It doesn't seem related, and it doesn't seem necessary as the
`note` field is already ignored for alias CPU models.

> +            am->deprecated = vdef->deprecated;
>              x86_register_cpu_model_type(vdef->alias, am);
>          }
>      }
> @@ -7233,6 +7242,37 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> +static void x86_cpu_deprecation_check(ObjectClass *oc)
> +{
> +    X86CPUClass *xcc = X86_CPU_CLASS(oc);
> +    X86CPUVersion effective_version;
> +    const X86CPUVersionDefinition *vdef;
> +
> +    if (xcc->model == NULL) {
> +        return;
> +    }
> +
> +    if (xcc->model->version == CPU_VERSION_LEGACY) {
> +        /* Treat legacy version as v1 */
> +        effective_version = 1;
> +    } else {
> +        effective_version = x86_cpu_model_resolve_version(xcc->model);
> +    }
> +
> +    vdef = xcc->model->cpudef->versions;
> +
> +    if (vdef == NULL) {
> +        return;
> +    } else {
> +        if (vdef[effective_version - 1].deprecated) {
> +            warn_report("Effective CPU model '%s' -- %s",
> +                    x86_cpu_versioned_model_name(xcc->model->cpudef,\
> +                                                effective_version),
> +                    vdef[effective_version - 1].note);
> +        }
> +    }

Why do we need this extra logic?  Isn't it simpler to just add a
bool CPUClass::deprecated field, and set:

   cpu->deprecated = model->deprecated;

inside x86_cpu_cpudef_class_init()?

> +}
> +
>  static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
>  {
>      X86CPUClass *xcc = X86_CPU_CLASS(oc);
> @@ -7291,6 +7331,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
>      cc->tlb_fill = x86_cpu_tlb_fill;
>  #endif
>      cc->disas_set_info = x86_disas_set_info;
> +    cc->deprecation_check = x86_cpu_deprecation_check;
>  
>      dc->user_creatable = true;
>  }
> -- 
> 1.8.3.1
> 

-- 
Eduardo


