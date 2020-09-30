Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0139AC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 21:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64CDA2064E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 21:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ac7qCLda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CDA2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNk62-0004Dv-HL
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 17:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kNk5F-0003lJ-DW
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 17:56:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kNk5D-000783-5B
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 17:56:20 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601502977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qS0YgUVD1QHOvxSN8HwwXYL46UMtm88lIRB8ifIEbJU=;
 b=Ac7qCLdaLpilwjBn+BWTjRzNh5D82Iq0i1si9tMF0SB2vAsGsk/Dz45LTBt2YfSqLE4u3a
 MMJ82e4Oju1HJZU8ZGlcxwg5bTBMGY0BlmwGumC4mOjgaV5ZFNcAqXXLWLVQf7uhgfqpG1
 YO03P/87Z5uVN8nO9L2Ah7EqHXgJino=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-RqPLiFYMPNqNnVCoth-ARA-1; Wed, 30 Sep 2020 17:56:13 -0400
X-MC-Unique: RqPLiFYMPNqNnVCoth-ARA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 395B510BBEC9;
 Wed, 30 Sep 2020 21:56:12 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D378710013BD;
 Wed, 30 Sep 2020 21:56:11 +0000 (UTC)
Date: Wed, 30 Sep 2020 17:56:11 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Robert Hoo <robert.hu@linux.intel.com>
Subject: Re: [PATCH v4 1/2] Introduce (x86) CPU model deprecation API
Message-ID: <20200930215611.GB3717385@habkost.net>
References: <1600758855-80046-1-git-send-email-robert.hu@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <1600758855-80046-1-git-send-email-robert.hu@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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

On Tue, Sep 22, 2020 at 03:14:14PM +0800, Robert Hoo wrote:
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
> v4:
> Move deprecation_note from X86CPUModel to X86CPUDefinition, to make it
> simple. Also, simplify 2 fields (deprecation_note and deprecated) into 1
> (deprecation_note).
> 
> v3:
> Make the deprecation implementation CPUClass generic.
> 
> v2:
> Move deprecation check from parse_cpu_option() to machine_run_board_init(), so
> that it can cover implicit cpu_type assignment cases.
> Add qapi new member documentation. Thanks Eric for comment and guidance on qapi.
> 
> ---
>  hw/core/machine.c        | 12 ++++++++++--
>  include/hw/core/cpu.h    |  3 +++
>  qapi/machine-target.json |  7 ++++++-
>  target/i386/cpu.c        |  8 ++++++++
>  4 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index ea26d61..67fff0b 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1095,6 +1095,8 @@ MemoryRegion *machine_consume_memdev(MachineState *machine,
>  void machine_run_board_init(MachineState *machine)
>  {
>      MachineClass *machine_class = MACHINE_GET_CLASS(machine);
> +    ObjectClass *oc = object_class_by_name(machine->cpu_type);

machine->cpu_type can be NULL...

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
> +    if (cc->deprecation_note) {

...so this will crash.

I've changed this to "if (cc && cc->deprecation_note)".

> +        warn_report("CPU model %s is deprecated -- %s", machine->cpu_type,
> +                    cc->deprecation_note);
> +    }
> +
>      machine_class->init(machine);
>  }
>  
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 99dc33f..c40c29d 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -155,6 +155,8 @@ struct TranslationBlock;
>   * @disas_set_info: Setup architecture specific components of disassembly info
>   * @adjust_watchpoint_address: Perform a target-specific adjustment to an
>   * address before attempting to match it against watchpoints.
> + * @deprecation_note: If this CPUClass is deprecated, this field provides
> + *                    related information.
>   *
>   * Represents a CPU family or model.
>   */
> @@ -221,6 +223,7 @@ struct CPUClass {
>      vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr addr, int len);
>      void (*tcg_initialize)(void);
>  
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
> index 1c58f76..323c7e3 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1633,6 +1633,7 @@ typedef struct X86CPUDefinition {
>       * If NULL, version 1 will be registered automatically.
>       */
>      const X86CPUVersionDefinition *versions;
> +    const char *deprecation_note;
>  } X86CPUDefinition;
>  
>  /* Reference to a specific CPU model version */
> @@ -4992,6 +4993,11 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
>      info->migration_safe = cc->migration_safe;
>      info->has_migration_safe = true;
>      info->q_static = cc->static_model;
> +    if (cc->model && cc->model->cpudef->deprecation_note) {
> +        info->deprecated = true;
> +    } else {
> +        info->deprecated = false;
> +    }
>      /*
>       * Old machine types won't report aliases, so that alias translation
>       * doesn't break compatibility with previous QEMU versions.
> @@ -5382,9 +5388,11 @@ static void x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
>  {
>      X86CPUModel *model = data;
>      X86CPUClass *xcc = X86_CPU_CLASS(oc);
> +    CPUClass *cc = CPU_CLASS(oc);
>  
>      xcc->model = model;
>      xcc->migration_safe = true;
> +    cc->deprecation_note = model->cpudef->deprecation_note;
>  }
>  
>  static void x86_register_cpu_model_type(const char *name, X86CPUModel *model)
> -- 
> 1.8.3.1
> 
> 

-- 
Eduardo


