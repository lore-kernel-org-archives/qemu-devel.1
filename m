Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B55C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C50206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKf4iupR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C50206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIyWc-0002X5-N4
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 14:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIyUS-0001cb-1K
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 14:18:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIyUO-0008FM-Hv
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 14:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600366715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZdQWqP2m7ztRFmmKH4OUGWKUgTTinBRohuLwe4L4C6k=;
 b=DKf4iupRB40Ax3X0hk7olGrBiHRpXgVq9pxo28FULmrNqLPejdUvx7K+OJLQouOPL1Qh+6
 y0Gbar8PTpnRrC4Yld46ogOn4ioJeB/h6zJBFFfqPWEHQeQkAX3DGX+4XQJ/uMPDVUV3JS
 8UHd9UpwxGwTP1D+vI//gNPh4nWLlpw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-KYMkOHptML6jakxbMuoMWA-1; Thu, 17 Sep 2020 14:18:33 -0400
X-MC-Unique: KYMkOHptML6jakxbMuoMWA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D6651882FC5;
 Thu, 17 Sep 2020 18:18:32 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB3BC6886B;
 Thu, 17 Sep 2020 18:18:31 +0000 (UTC)
Date: Thu, 17 Sep 2020 14:18:31 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Robert Hoo <robert.hu@linux.intel.com>
Subject: Re: [PATCH v3 1/2] Introduce (x86) CPU model deprecation API
Message-ID: <20200917181831.GU7594@habkost.net>
References: <1600245434-63021-1-git-send-email-robert.hu@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <1600245434-63021-1-git-send-email-robert.hu@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com, robert.hu@intel.com,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I think the patch looks better now, thanks!

Just a few minor questions and suggestions:

On Wed, Sep 16, 2020 at 04:37:13PM +0800, Robert Hoo wrote:
> Complement versioned CPU model framework with the ability of marking some
> versions deprecated. When that CPU model is chosen, get some warning. The
> warning message is customized, e.g. telling in which future QEMU version will
> it be obsoleted.
> The deprecation message will also appear by x86_cpu_list_entry(), e.g. '-cpu
> help'.
> QMP 'query-cpu-definitions' will also return a bool value indicating the
> deprecation status.
> 
> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> ---
> Changelog
> v3:
> Make the deprecation implementation CPUClass generic.
> 
> v2:
> Move deprecation check from parse_cpu_option() to machine_run_board_init(), so
> that it can cover implicit cpu_type assignment cases.

What do you mean by implicit cpu_type assignment cases?

Doing it inside parse_cpu_option() like you did in v1 will make
the deprecation warnings appear for *-user too (which is a good
thing).

> Add qapi new member documentation. Thanks Eric for comment and guidance on qapi.
> 
>  hw/core/machine.c        | 12 ++++++++++--
>  include/hw/core/cpu.h    |  6 ++++++
>  qapi/machine-target.json |  7 ++++++-
>  target/i386/cpu.c        | 29 +++++++++++++++++++++++------
>  4 files changed, 45 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index ea26d61..b41f88d 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1095,6 +1095,8 @@ MemoryRegion *machine_consume_memdev(MachineState *machine,
>  void machine_run_board_init(MachineState *machine)
>  {
>      MachineClass *machine_class = MACHINE_GET_CLASS(machine);
> +    ObjectClass *oc = object_class_by_name(machine->cpu_type);
> +    CPUClass *cc;
>  
>      if (machine->ram_memdev_id) {
>          Object *o;
> @@ -1114,11 +1116,10 @@ void machine_run_board_init(MachineState *machine)
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
> @@ -1141,6 +1142,13 @@ void machine_run_board_init(MachineState *machine)
>          }
>      }
>  
> +    /* Check if CPU type is deprecated and warn if so */
> +    cc = CPU_CLASS(oc);
> +    if (cc->deprecated) {
> +        warn_report("CPU model %s is deprecated -- %s", machine->cpu_type,
> +                    cc->deprecation_note);
> +    }
> +
>      machine_class->init(machine);
>  }
>  
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 99dc33f..c4b17c8 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -155,6 +155,10 @@ struct TranslationBlock;
>   * @disas_set_info: Setup architecture specific components of disassembly info
>   * @adjust_watchpoint_address: Perform a target-specific adjustment to an
>   * address before attempting to match it against watchpoints.
> + * @deprecated: True if this CPU model is deprecated (going to be removed in
> + *              near future).
> + * @deprecation_note: Message about the deprecation. e.g. Since which version
> + *                    will it be obsoleted.

We don't need two separate fields if (deprecation_note != NULL)
means the CPU model is deprecated.  This is how it was
implemented in MachineClass (see MachineClass::deprecation_reason).

>   *
>   * Represents a CPU family or model.
>   */
> @@ -221,6 +225,8 @@ struct CPUClass {
>      vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr addr, int len);
>      void (*tcg_initialize)(void);
>  
> +    bool deprecated;
> +    const char *deprecation_note;
>      /* Keep non-pointer data at the end to minimize holes.  */
>      int gdb_num_core_regs;
>      bool gdb_stop_before_watchpoint;
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index 698850c..fec3bb8 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -286,6 +286,10 @@
>  #            in the VM configuration, because aliases may stop being
>  #            migration-safe in the future (since 4.1)
>  #
> +# @deprecated: If true, this CPU model is deprecated and may be removed in
> +#              in some future version of QEMU according to the QEMU deprecation
> +#              policy. (since 5.2)
> +#
>  # @unavailable-features is a list of QOM property names that
>  # represent CPU model attributes that prevent the CPU from running.
>  # If the QOM property is read-only, that means there's no known
> @@ -310,7 +314,8 @@
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
> index 49d8958..9cb82b7 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1716,6 +1716,7 @@ typedef struct X86CPUVersionDefinition {
>      const char *alias;
>      const char *note;
>      PropValue *props;
> +    bool       deprecated;
>  } X86CPUVersionDefinition;
>  
>  /* Base definition for a CPU model */
> @@ -1751,6 +1752,11 @@ struct X86CPUModel {
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
> @@ -5096,6 +5102,7 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
>      info->migration_safe = cc->migration_safe;
>      info->has_migration_safe = true;
>      info->q_static = cc->static_model;
> +    info->deprecated = cc->model ? cc->model->deprecated : false;
>      /*
>       * Old machine types won't report aliases, so that alias translation
>       * doesn't break compatibility with previous QEMU versions.
> @@ -5486,9 +5493,12 @@ static void x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
>  {
>      X86CPUModel *model = data;
>      X86CPUClass *xcc = X86_CPU_CLASS(oc);
> +    CPUClass *cc = CPU_CLASS(oc);
>  
>      xcc->model = model;
>      xcc->migration_safe = true;
> +    cc->deprecated = model->deprecated;
> +    cc->deprecation_note = g_strdup(model->note);

The meaning of cc->deprecation_note and model->note is a bit
ambiguous here.  model->note is not necessarily a deprecation
note, but its contents are being copied unconditionally to
cc->deprecation_note.

What about setting cc->deprecation_note only if and only if the
model is deprecated?


>  }
>  
>  static void x86_register_cpu_model_type(const char *name, X86CPUModel *model)
> @@ -5524,21 +5534,28 @@ static void x86_register_cpudef_types(X86CPUDefinition *def)
>      x86_register_cpu_model_type(def->name, m);
>  
>      /* Versioned models: */
> -
>      for (vdef = x86_cpu_def_get_versions(def); vdef->version; vdef++) {
> -        X86CPUModel *m = g_new0(X86CPUModel, 1);
> +        X86CPUModel *vm = g_new0(X86CPUModel, 1);
>          g_autofree char *name =
>              x86_cpu_versioned_model_name(def, vdef->version);
> -        m->cpudef = def;
> -        m->version = vdef->version;
> -        m->note = vdef->note;
> -        x86_register_cpu_model_type(name, m);
> +        vm->cpudef = def;
> +        vm->version = vdef->version;
> +        vm->note = vdef->note;
> +        vm->deprecated = vdef->deprecated;
> +        /* If Model-v1 is deprecated, Model is deprecated. */
> +        if (vdef->version == 1 && vdef->deprecated == true) {
> +            m->deprecated = true;
> +            m->note = vdef->note;

I'm not sure this rule will always apply.  If we deprecate
"Model-v1" but not "Model-v2", we probably don't want "Model" to
be deprecated too.

Considering that we don't have cases where specific versions are
being deprecated, what about making it as simple as possible and
just add a new X86CPUDefinition::deprecation_note field?  No need
for any new fields in X86CPUModel (model->cpudef->deprecation_note
can be used directly), no need for two new fields in CPUClass
(just deprecation_note).

If one day we decide to deprecate just some versions of a CPU
model, we can extend X86CPUVersionDefinition in the future.

> +        }
> +        x86_register_cpu_model_type(name, vm);
>  
>          if (vdef->alias) {
>              X86CPUModel *am = g_new0(X86CPUModel, 1);
>              am->cpudef = def;
>              am->version = vdef->version;
>              am->is_alias = true;
> +            am->note = vdef->note;
> +            am->deprecated = vdef->deprecated;
>              x86_register_cpu_model_type(vdef->alias, am);
>          }
>      }
> -- 
> 1.8.3.1
> 

-- 
Eduardo


