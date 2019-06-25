Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CA4C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 09:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8383E2084B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 09:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8383E2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58032 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfhqW-00023j-Fp
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 05:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44118)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hfhoK-0000xc-Pc
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hfhoF-00021L-DH
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:32:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38700)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hfhoE-0001xW-Vl
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:32:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2075B307D93F;
 Tue, 25 Jun 2019 09:32:07 +0000 (UTC)
Received: from work-vm (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 274895D756;
 Tue, 25 Jun 2019 09:32:03 +0000 (UTC)
Date: Tue, 25 Jun 2019 10:32:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190625093201.GF3226@work-vm>
References: <20190625050008.12789-1-ehabkost@redhat.com>
 <20190625050008.12789-5-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625050008.12789-5-ehabkost@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 25 Jun 2019 09:32:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/6] i386: Infrastructure for versioned CPU
 models
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Eduardo Habkost (ehabkost@redhat.com) wrote:
> Base code for versioned CPU models.  This will register a "-4.1"
> version of all existing CPU models, and make the unversioned CPU
> models be an alias for the -4.1 versions on the pc-*-4.1 machine
> types.
> 
> On older machine types, the unversioned CPU models will keep the
> old behavior.  This way, management software can use old machine
> types while resolving aliases if compatibility with older QEMU
> versions is required.
> 
> Using "-machine none", the unversioned CPU models will be aliases
> to the latest CPU model version.
> 
> Includes a test case to ensure that:
> old machine types won't report any alias to versioned CPU models;
> "pc-*-4.1" will return aliases to -4.1 CPU models;
> and "-machine none" will report aliases to some versioned CPU model.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

What happens when we add the next new CPU model?  So say in 4.2 we add
a new CPU, does that default to being newcpu-4.2 ?

Dave

> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> ---
>  include/hw/i386/pc.h                       |   3 +
>  target/i386/cpu-qom.h                      |  10 +-
>  target/i386/cpu.h                          |  10 ++
>  hw/i386/pc.c                               |   3 +
>  hw/i386/pc_piix.c                          |   4 +
>  hw/i386/pc_q35.c                           |   4 +
>  target/i386/cpu.c                          | 159 +++++++++++++++++----
>  tests/acceptance/x86_cpu_model_versions.py | 102 +++++++++++++
>  8 files changed, 263 insertions(+), 32 deletions(-)
>  create mode 100644 tests/acceptance/x86_cpu_model_versions.py
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index c54cc54a47..d2e2ed072f 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -107,6 +107,9 @@ typedef struct PCMachineClass {
>  
>      /* Compat options: */
>  
> +    /* Default CPU model version.  See x86_cpu_set_default_version(). */
> +    const char *default_cpu_version;
> +
>      /* ACPI compat: */
>      bool has_acpi_build;
>      bool rsdp_in_ram;
> diff --git a/target/i386/cpu-qom.h b/target/i386/cpu-qom.h
> index 22f95eb3a4..1a52f02a4c 100644
> --- a/target/i386/cpu-qom.h
> +++ b/target/i386/cpu-qom.h
> @@ -36,13 +36,7 @@
>  #define X86_CPU_GET_CLASS(obj) \
>      OBJECT_GET_CLASS(X86CPUClass, (obj), TYPE_X86_CPU)
>  
> -/**
> - * X86CPUDefinition:
> - *
> - * CPU model definition data that was not converted to QOM per-subclass
> - * property defaults yet.
> - */
> -typedef struct X86CPUDefinition X86CPUDefinition;
> +typedef struct X86CPUModel X86CPUModel;
>  
>  /**
>   * X86CPUClass:
> @@ -64,7 +58,7 @@ typedef struct X86CPUClass {
>      /* CPU definition, automatically loaded by instance_init if not NULL.
>       * Should be eventually replaced by subclass-specific property defaults.
>       */
> -    X86CPUDefinition *cpu_def;
> +    X86CPUModel *model;
>  
>      bool host_cpuid_required;
>      int ordering;
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 25544fdaaa..800bee3c6a 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1925,6 +1925,16 @@ void apic_handle_tpr_access_report(DeviceState *d, target_ulong ip,
>   */
>  void x86_cpu_change_kvm_default(const char *prop, const char *value);
>  
> +/*
> + * Set default CPU model version for all CPU models
> + *
> + * If set to NULL, the old unversioned CPU models will be used by default.
> + *
> + * If non-NULL, the unversioned CPU models will be aliases to the
> + * corresponding version.
> + */
> +void x86_cpu_set_default_version(const char *version);
> +
>  /* Return name of 32-bit register, from a R_* constant */
>  const char *get_register_name_32(unsigned int reg);
>  
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index e96360b47a..d2852a77f8 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1561,6 +1561,9 @@ void pc_cpus_init(PCMachineState *pcms)
>      const CPUArchIdList *possible_cpus;
>      MachineState *ms = MACHINE(pcms);
>      MachineClass *mc = MACHINE_GET_CLASS(pcms);
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(mc);
> +
> +    x86_cpu_set_default_version(pcmc->default_cpu_version);
>  
>      /* Calculates the limit to CPU APIC ID values
>       *
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index c07c4a5b38..9de86c71bd 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -430,9 +430,11 @@ static void pc_i440fx_machine_options(MachineClass *m)
>  
>  static void pc_i440fx_4_1_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pc_i440fx_machine_options(m);
>      m->alias = "pc";
>      m->is_default = 1;
> +    pcmc->default_cpu_version = "4.1";
>  }
>  
>  DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1", NULL,
> @@ -440,9 +442,11 @@ DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1", NULL,
>  
>  static void pc_i440fx_4_0_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pc_i440fx_4_1_machine_options(m);
>      m->alias = NULL;
>      m->is_default = 0;
> +    pcmc->default_cpu_version = NULL;
>      compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
>      compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
>  }
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 57232aed6b..7755d60167 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -367,8 +367,10 @@ static void pc_q35_machine_options(MachineClass *m)
>  
>  static void pc_q35_4_1_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pc_q35_machine_options(m);
>      m->alias = "q35";
> +    pcmc->default_cpu_version = "4.1";
>  }
>  
>  DEFINE_Q35_MACHINE(v4_1, "pc-q35-4.1", NULL,
> @@ -376,8 +378,10 @@ DEFINE_Q35_MACHINE(v4_1, "pc-q35-4.1", NULL,
>  
>  static void pc_q35_4_0_1_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pc_q35_4_1_machine_options(m);
>      m->alias = NULL;
> +    pcmc->default_cpu_version = NULL;
>      /*
>       * This is the default machine for the 4.0-stable branch. It is basically
>       * a 4.0 that doesn't use split irqchip by default. It MUST hence apply the
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index cf03dc786e..121f568954 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1432,7 +1432,17 @@ static char *x86_cpu_class_get_model_name(X86CPUClass *cc)
>                       strlen(class_name) - strlen(X86_CPU_TYPE_SUFFIX));
>  }
>  
> -struct X86CPUDefinition {
> +typedef struct PropValue {
> +    const char *prop, *value;
> +} PropValue;
> +
> +typedef struct X86CPUVersionDefinition {
> +    const char *name;
> +    PropValue *props;
> +} X86CPUVersionDefinition;
> +
> +/* Base definition for a CPU model */
> +typedef struct X86CPUDefinition {
>      const char *name;
>      uint32_t level;
>      uint32_t xlevel;
> @@ -1444,8 +1454,32 @@ struct X86CPUDefinition {
>      FeatureWordArray features;
>      const char *model_id;
>      CPUCaches *cache_info;
> +    /*
> +     * Definitions for alternative versions of CPU model.
> +     * List is terminated by item with name==NULL.
> +     * If NULL, base_cpu_versions will be used instead.
> +     */
> +    const X86CPUVersionDefinition *versions;
> +} X86CPUDefinition;
> +
> +/* CPU model, which might include a specific CPU model version */
> +struct X86CPUModel {
> +    /* Base CPU definition */
> +    X86CPUDefinition *cpudef;
> +
> +    /*
> +     * CPU model version.  If NULL, version will be chosen depending on current
> +     * machine.
> +     */
> +    const char *version;
>  };
>  
> +static char *x86_cpu_versioned_model_name(X86CPUDefinition *cpudef,
> +                                          const char *version)
> +{
> +    return g_strdup_printf("%s-%s", cpudef->name, version);
> +}
> +
>  static CPUCaches epyc_cache_info = {
>      .l1d_cache = &(CPUCacheInfo) {
>          .type = DATA_CACHE,
> @@ -3010,10 +3044,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
>      },
>  };
>  
> -typedef struct PropValue {
> -    const char *prop, *value;
> -} PropValue;
> -
>  /* KVM-specific features that are automatically added/removed
>   * from all CPU models when KVM is enabled.
>   */
> @@ -3039,6 +3069,19 @@ static PropValue tcg_default_props[] = {
>  };
>  
>  
> +/* List of CPU model versions used when X86CPUDefinition::versions is NULL */
> +static const X86CPUVersionDefinition base_cpu_versions[] = {
> +    { "4.1" },
> +    { /* end of list */ },
> +};
> +
> +static const char *default_cpu_version = "4.1";
> +
> +void x86_cpu_set_default_version(const char *version)
> +{
> +    default_cpu_version = version;
> +}
> +
>  void x86_cpu_change_kvm_default(const char *prop, const char *value)
>  {
>      PropValue *pv;
> @@ -3116,8 +3159,6 @@ static void max_x86_cpu_class_init(ObjectClass *oc, void *data)
>      dc->props = max_x86_cpu_properties;
>  }
>  
> -static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp);
> -
>  static void max_x86_cpu_initfn(Object *obj)
>  {
>      X86CPU *cpu = X86_CPU(obj);
> @@ -3771,8 +3812,8 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
>      X86CPUClass *cc = X86_CPU_CLASS(oc);
>      char *name = x86_cpu_class_get_model_name(cc);
>      const char *desc = cc->model_description;
> -    if (!desc && cc->cpu_def) {
> -        desc = cc->cpu_def->model_id;
> +    if (!desc && cc->model) {
> +        desc = cc->model->cpudef->model_id;
>      }
>  
>      qemu_printf("x86 %-20s  %-48s\n", name, desc);
> @@ -3825,6 +3866,11 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
>      info->migration_safe = cc->migration_safe;
>      info->has_migration_safe = true;
>      info->q_static = cc->static_model;
> +    if (cc->model && !cc->model->version && default_cpu_version) {
> +        info->has_alias_of = true;
> +        info->alias_of = x86_cpu_versioned_model_name(cc->model->cpudef,
> +                                                      default_cpu_version);
> +    }
>  
>      entry = g_malloc0(sizeof(*entry));
>      entry->value = info;
> @@ -3898,10 +3944,38 @@ static void x86_cpu_apply_props(X86CPU *cpu, PropValue *props)
>      }
>  }
>  
> +static const X86CPUVersionDefinition *x86_cpu_def_get_versions(X86CPUDefinition *def)
> +{
> +    return def->versions ?: base_cpu_versions;
> +}
> +
> +static void x86_cpu_apply_version_props(X86CPU *cpu, X86CPUDefinition *def,
> +                                        const char *version)
> +{
> +    const X86CPUVersionDefinition *vdef;
> +
> +    for (vdef = x86_cpu_def_get_versions(def); vdef->name; vdef++) {
> +        PropValue *p;
> +
> +        for (p = vdef->props; p && p->prop; p++) {
> +            object_property_parse(OBJECT(cpu), p->value, p->prop,
> +                                  &error_abort);
> +        }
> +
> +        if (!strcmp(vdef->name, version)) {
> +            break;
> +        }
> +    }
> +
> +    /* If we reached the end of the list, version string was invalid */
> +    assert(vdef->name);
> +}
> +
>  /* Load data from X86CPUDefinition into a X86CPU object
>   */
> -static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
> +static void x86_cpu_load_model(X86CPU *cpu, X86CPUModel *model, Error **errp)
>  {
> +    X86CPUDefinition *def = model->cpudef;
>      CPUX86State *env = &cpu->env;
>      const char *vendor;
>      char host_vendor[CPUID_VENDOR_SZ + 1];
> @@ -3958,11 +4032,16 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
>  
>      object_property_set_str(OBJECT(cpu), vendor, "vendor", errp);
>  
> +    if (model->version) {
> +        x86_cpu_apply_version_props(cpu, def, model->version);
> +    } else if (default_cpu_version) {
> +        x86_cpu_apply_version_props(cpu, def, default_cpu_version);
> +    }
>  }
>  
>  #ifndef CONFIG_USER_ONLY
>  /* Return a QDict containing keys for all properties that can be included
> - * in static expansion of CPU models. All properties set by x86_cpu_load_def()
> + * in static expansion of CPU models. All properties set by x86_cpu_load_model()
>   * must be included in the dictionary.
>   */
>  static QDict *x86_cpu_static_props(void)
> @@ -4176,23 +4255,44 @@ static gchar *x86_gdb_arch_name(CPUState *cs)
>  
>  static void x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
>  {
> -    X86CPUDefinition *cpudef = data;
>      X86CPUClass *xcc = X86_CPU_CLASS(oc);
>  
> -    xcc->cpu_def = cpudef;
> +    xcc->model = data;
>      xcc->migration_safe = true;
>  }
>  
> -static void x86_register_cpudef_type(X86CPUDefinition *def)
> +static char *x86_cpu_model_type_name(X86CPUModel *model)
>  {
> -    char *typename = x86_cpu_type_name(def->name);
> +    if (model->version) {
> +        char *name = x86_cpu_versioned_model_name(model->cpudef,
> +                                                  model->version);
> +        char *r = x86_cpu_type_name(name);
> +        g_free(name);
> +        return r;
> +    } else {
> +        return x86_cpu_type_name(model->cpudef->name);
> +    }
> +}
> +
> +static void x86_register_cpu_model_type(X86CPUModel *model)
> +{
> +    char *typename = x86_cpu_model_type_name(model);
>      TypeInfo ti = {
>          .name = typename,
>          .parent = TYPE_X86_CPU,
>          .class_init = x86_cpu_cpudef_class_init,
> -        .class_data = def,
> +        .class_data = model,
>      };
>  
> +    type_register(&ti);
> +    g_free(typename);
> +}
> +
> +static void x86_register_cpudef_types(X86CPUDefinition *def)
> +{
> +    X86CPUModel *m;
> +    const X86CPUVersionDefinition *vdef;
> +
>      /* AMD aliases are handled at runtime based on CPUID vendor, so
>       * they shouldn't be set on the CPU model table.
>       */
> @@ -4200,9 +4300,20 @@ static void x86_register_cpudef_type(X86CPUDefinition *def)
>      /* catch mistakes instead of silently truncating model_id when too long */
>      assert(def->model_id && strlen(def->model_id) <= 48);
>  
> +    /* Unversioned model: */
> +    m = g_new0(X86CPUModel, 1);
> +    m->cpudef = def;
> +    x86_register_cpu_model_type(m);
> +
> +    /* Versioned models: */
> +
> +    for (vdef = x86_cpu_def_get_versions(def); vdef->name; vdef++) {
> +        X86CPUModel *m = g_new0(X86CPUModel, 1);
> +        m->cpudef = def;
> +        m->version = vdef->name;
> +        x86_register_cpu_model_type(m);
> +    }
>  
> -    type_register(&ti);
> -    g_free(typename);
>  }
>  
>  #if !defined(CONFIG_USER_ONLY)
> @@ -4989,7 +5100,7 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
>   * involved in setting up CPUID data are:
>   *
>   * 1) Loading CPU model definition (X86CPUDefinition). This is
> - *    implemented by x86_cpu_load_def() and should be completely
> + *    implemented by x86_cpu_load_model() and should be completely
>   *    transparent, as it is done automatically by instance_init.
>   *    No code should need to look at X86CPUDefinition structs
>   *    outside instance_init.
> @@ -5306,7 +5417,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>  
>      /* Cache information initialization */
>      if (!cpu->legacy_cache) {
> -        if (!xcc->cpu_def || !xcc->cpu_def->cache_info) {
> +        if (!xcc->model || !xcc->model->cpudef->cache_info) {
>              char *name = x86_cpu_class_get_model_name(xcc);
>              error_setg(errp,
>                         "CPU model '%s' doesn't support legacy-cache=off", name);
> @@ -5314,7 +5425,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>              return;
>          }
>          env->cache_info_cpuid2 = env->cache_info_cpuid4 = env->cache_info_amd =
> -            *xcc->cpu_def->cache_info;
> +            *xcc->model->cpudef->cache_info;
>      } else {
>          /* Build legacy cache information */
>          env->cache_info_cpuid2.l1d_cache = &legacy_l1d_cache;
> @@ -5671,8 +5782,8 @@ static void x86_cpu_initfn(Object *obj)
>      object_property_add_alias(obj, "sse4_1", obj, "sse4.1", &error_abort);
>      object_property_add_alias(obj, "sse4_2", obj, "sse4.2", &error_abort);
>  
> -    if (xcc->cpu_def) {
> -        x86_cpu_load_def(cpu, xcc->cpu_def, &error_abort);
> +    if (xcc->model) {
> +        x86_cpu_load_model(cpu, xcc->model, &error_abort);
>      }
>  }
>  
> @@ -6009,7 +6120,7 @@ static void x86_cpu_register_types(void)
>  
>      type_register_static(&x86_cpu_type_info);
>      for (i = 0; i < ARRAY_SIZE(builtin_x86_defs); i++) {
> -        x86_register_cpudef_type(&builtin_x86_defs[i]);
> +        x86_register_cpudef_types(&builtin_x86_defs[i]);
>      }
>      type_register_static(&max_x86_cpu_type_info);
>      type_register_static(&x86_base_cpu_type_info);
> diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/acceptance/x86_cpu_model_versions.py
> new file mode 100644
> index 0000000000..c0660a552f
> --- /dev/null
> +++ b/tests/acceptance/x86_cpu_model_versions.py
> @@ -0,0 +1,102 @@
> +#!/usr/bin/env python
> +#
> +# Basic validation of x86 versioned CPU models and CPU model aliases
> +#
> +#  Copyright (c) 2019 Red Hat Inc
> +#
> +# Author:
> +#  Eduardo Habkost <ehabkost@redhat.com>
> +#
> +# This library is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU Lesser General Public
> +# License as published by the Free Software Foundation; either
> +# version 2 of the License, or (at your option) any later version.
> +#
> +# This library is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +# Lesser General Public License for more details.
> +#
> +# You should have received a copy of the GNU Lesser General Public
> +# License along with this library; if not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +
> +import avocado_qemu
> +
> +def get_cpu_prop(vm, prop):
> +    cpu_path = vm.command('query-cpus')[0].get('qom_path')
> +    return vm.command('qom-get', path=cpu_path, property=prop)
> +
> +class X86CPUModelAliases(avocado_qemu.Test):
> +    """
> +    Validation of PC CPU model versions and CPU model aliases
> +
> +    :avocado: tags=arch:x86_64
> +    """
> +    def test_4_0_alias(self):
> +        """Check if pc-*-4.0 unversioned CPU model won't be an alias"""
> +        # pc-*-4.0 won't expose non-versioned CPU models as aliases
> +        # We do this to help management software to keep compatibility
> +        # with older QEMU versions that didn't have the versioned CPU model
> +        self.vm.add_args('-S')
> +        self.vm.set_machine('pc-i440fx-4.0')
> +        self.vm.launch()
> +
> +        cpus = dict((m['name'], m) for m in self.vm.command('query-cpu-definitions'))
> +
> +        self.assertFalse(cpus['Cascadelake-Server']['static'],
> +                         'unversioned Cascadelake-Server CPU model must not be static')
> +        self.assertNotIn('alias-of', cpus['Cascadelake-Server'],
> +                         'Cascadelake-Server must not be an alias')
> +
> +        self.assertFalse(cpus['qemu64']['static'],
> +                         'unversioned qemu64 CPU model must not be static')
> +        self.assertNotIn('alias-of', cpus['qemu64'],
> +                         'qemu64 must not be an alias')
> +        self.assertNotIn('alias-of', cpus['qemu64-4.1'],
> +                         'qemu64-4.1 must not be an alias')
> +
> +    def test_4_1_alias(self):
> +        """Check if unversioned CPU model is an alias pointing to 4.1 version"""
> +        self.vm.add_args('-S')
> +        self.vm.set_machine('pc-i440fx-4.1')
> +        self.vm.launch()
> +
> +        cpus = dict((m['name'], m) for m in self.vm.command('query-cpu-definitions'))
> +
> +        self.assertFalse(cpus['Cascadelake-Server']['static'],
> +                         'unversioned Cascadelake-Server CPU model must not be static')
> +        self.assertEquals(cpus['Cascadelake-Server'].get('alias-of'), 'Cascadelake-Server-4.1',
> +                          'Cascadelake-Server must be an alias of Cascadelake-Server-4.1')
> +        self.assertNotIn('alias-of', cpus['Cascadelake-Server-4.1'],
> +                         'Cascadelake-Server-4.1 must not be an alias')
> +
> +        self.assertFalse(cpus['qemu64']['static'],
> +                         'unversioned qemu64 CPU model must not be static')
> +        self.assertEquals(cpus['qemu64'].get('alias-of'), 'qemu64-4.1',
> +                          'qemu64 must be an alias of qemu64-4.1')
> +        self.assertNotIn('alias-of', cpus['qemu64-4.1'],
> +                         'qemu64-4.1 must not be an alias')
> +
> +    def test_none_alias(self):
> +        """Check if unversioned CPU model is an alias pointing to 4.1 version"""
> +        self.vm.add_args('-S')
> +        self.vm.set_machine('none')
> +        self.vm.launch()
> +
> +        cpus = dict((m['name'], m) for m in self.vm.command('query-cpu-definitions'))
> +
> +        self.assertFalse(cpus['Cascadelake-Server']['static'],
> +                         'unversioned Cascadelake-Server CPU model must not be static')
> +        self.assertTrue(cpus['Cascadelake-Server']['alias-of'].startswith('Cascadelake-Server-'),
> +                          'Cascadelake-Server must be an alias of versioned CPU model')
> +        self.assertNotIn('alias-of', cpus['Cascadelake-Server-4.1'],
> +                         'Cascadelake-Server-4.1 must not be an alias')
> +
> +        self.assertFalse(cpus['qemu64']['static'],
> +                         'unversioned qemu64 CPU model must not be static')
> +        self.assertTrue(cpus['qemu64']['alias-of'].startswith('qemu64-'),
> +                          'qemu64 must be an alias of versioned CPU model')
> +        self.assertNotIn('alias-of', cpus['qemu64-4.1'],
> +                         'qemu64-4.1 must not be an alias')
> -- 
> 2.18.0.rc1.1.g3f1ff2140
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

