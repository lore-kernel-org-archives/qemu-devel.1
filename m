Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EE4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 02:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C6472064C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 02:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6472064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjDGu-0006jD-8O
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 22:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1jjDGH-0006Hl-RO
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 22:48:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:56433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1jjDGG-0003U9-7q
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 22:48:13 -0400
IronPort-SDR: sE5UYzd0qD8ND8ftp4lcxdyrdXnT3c52+XyK7Kp7Fi2tY1bfMA+FTSzGuSQB91qsQuQ9cfZo8i
 5OTdyWD8coHg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2020 19:48:08 -0700
IronPort-SDR: 3hFtkJW9tdG55mi+CNfAC7HO9y0jgF9JOg7VSCkvulNcHDzjTkUr4vJXORT47ilyNFadA43XFk
 E4GhIfpQK54g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,498,1583222400"; d="scan'208";a="275183907"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by orsmga006.jf.intel.com with ESMTP; 10 Jun 2020 19:48:05 -0700
From: Robert Hoo <robert.hu@linux.intel.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 eblake@redhat.com, armbru@redhat.com
Subject: [PATCH v2 1/2] Introduce (x86) CPU model deprecation API
Date: Thu, 11 Jun 2020 10:47:55 +0800
Message-Id: <1591843676-102054-1-git-send-email-robert.hu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
Received-SPF: none client-ip=192.55.52.93;
 envelope-from=robert.hu@linux.intel.com; helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 22:48:08
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: robert.hu@intel.com, Robert Hoo <robert.hu@linux.intel.com>,
 xiaoyao.li@intel.com, qemu-devel@nongnu.org, chenyi.qiang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Complement versioned CPU model framework with the ability of marking some
versions deprecated. When that CPU model is chosen, get some warning. The
warning message is customized, e.g. telling in which future QEMU version will
it be obsoleted.
The deprecation message will also appear by x86_cpu_list_entry(), e.g. '-cpu
help'.
QMP 'query-cpu-definitions' will also return a bool value indicating the
deprecation status.

Changes in v2:
Move deprecation check from parse_cpu_option() to machine_run_board_init(), so
that it can cover implicit cpu_type assignment cases.
Add qapi new member documentation. Thanks Eric for comment and guidance on qapi.

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
 hw/core/machine.c        | 11 +++++++++--
 include/hw/core/cpu.h    |  1 +
 qapi/machine-target.json |  7 ++++++-
 target/i386/cpu.c        | 45 +++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index bb3a7b1..9318964 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1083,6 +1083,8 @@ MemoryRegion *machine_consume_memdev(MachineState *machine,
 void machine_run_board_init(MachineState *machine)
 {
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
+    ObjectClass *oc = object_class_by_name(machine->cpu_type);
+    CPUClass *cc;
 
     if (machine->ram_memdev_id) {
         Object *o;
@@ -1102,11 +1104,10 @@ void machine_run_board_init(MachineState *machine)
      * specified a CPU with -cpu check here that the user CPU is supported.
      */
     if (machine_class->valid_cpu_types && machine->cpu_type) {
-        ObjectClass *class = object_class_by_name(machine->cpu_type);
         int i;
 
         for (i = 0; machine_class->valid_cpu_types[i]; i++) {
-            if (object_class_dynamic_cast(class,
+            if (object_class_dynamic_cast(oc,
                                           machine_class->valid_cpu_types[i])) {
                 /* The user specificed CPU is in the valid field, we are
                  * good to go.
@@ -1129,6 +1130,12 @@ void machine_run_board_init(MachineState *machine)
         }
     }
 
+    /* Check if CPU type is deprecated and warn if so */
+    cc = CPU_CLASS(oc);
+    if (cc->deprecation_check) {
+        cc->deprecation_check(oc);
+    }
+
     machine_class->init(machine);
 }
 
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 497600c..1ca47dc 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -218,6 +218,7 @@ typedef struct CPUClass {
     void (*disas_set_info)(CPUState *cpu, disassemble_info *info);
     vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr addr, int len);
     void (*tcg_initialize)(void);
+    void (*deprecation_check)(ObjectClass *oc);
 
     /* Keep non-pointer data at the end to minimize holes.  */
     int gdb_num_core_regs;
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index f2c8294..c24f506 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -285,6 +285,10 @@
 #            in the VM configuration, because aliases may stop being
 #            migration-safe in the future (since 4.1)
 #
+# @deprecated: If true, this CPU model is deprecated and may be removed in
+#              in some future version of QEMU according to the QEMU deprecation
+#              policy. (since 5.1)
+#
 # @unavailable-features is a list of QOM property names that
 # represent CPU model attributes that prevent the CPU from running.
 # If the QOM property is read-only, that means there's no known
@@ -309,7 +313,8 @@
             'static': 'bool',
             '*unavailable-features': [ 'str' ],
             'typename': 'str',
-            '*alias-of' : 'str' },
+            '*alias-of' : 'str',
+            'deprecated' : 'bool' },
   'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }
 
 ##
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ba05da3..0d8638a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1599,6 +1599,7 @@ typedef struct X86CPUVersionDefinition {
     const char *alias;
     const char *note;
     PropValue *props;
+    bool       deprecated;
 } X86CPUVersionDefinition;
 
 /* Base definition for a CPU model */
@@ -1638,6 +1639,11 @@ struct X86CPUModel {
      * This matters only for "-cpu help" and query-cpu-definitions
      */
     bool is_alias;
+    /*
+     * If true, this model is deprecated, and may be removed in the future.
+     * Trying to use it now will cause a warning.
+     */
+    bool deprecated;
 };
 
 /* Get full model name for CPU version */
@@ -4128,8 +4134,7 @@ static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
     X86CPUVersion v = model->version;
     if (v == CPU_VERSION_AUTO) {
         v = default_cpu_version;
-    }
-    if (v == CPU_VERSION_LATEST) {
+    } else if (v == CPU_VERSION_LATEST) {
         return x86_cpu_model_last_version(model);
     }
     return v;
@@ -4975,6 +4980,7 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
     info->migration_safe = cc->migration_safe;
     info->has_migration_safe = true;
     info->q_static = cc->static_model;
+    info->deprecated = cc->model ? cc->model->deprecated : false;
     /*
      * Old machine types won't report aliases, so that alias translation
      * doesn't break compatibility with previous QEMU versions.
@@ -5411,6 +5417,7 @@ static void x86_register_cpudef_types(X86CPUDefinition *def)
         m->cpudef = def;
         m->version = vdef->version;
         m->note = vdef->note;
+        m->deprecated = vdef->deprecated;
         x86_register_cpu_model_type(name, m);
 
         if (vdef->alias) {
@@ -5418,6 +5425,8 @@ static void x86_register_cpudef_types(X86CPUDefinition *def)
             am->cpudef = def;
             am->version = vdef->version;
             am->is_alias = true;
+            am->note = vdef->note;
+            am->deprecated = vdef->deprecated;
             x86_register_cpu_model_type(vdef->alias, am);
         }
     }
@@ -7233,6 +7242,37 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
+static void x86_cpu_deprecation_check(ObjectClass *oc)
+{
+    X86CPUClass *xcc = X86_CPU_CLASS(oc);
+    X86CPUVersion effective_version;
+    const X86CPUVersionDefinition *vdef;
+
+    if (xcc->model == NULL) {
+        return;
+    }
+
+    if (xcc->model->version == CPU_VERSION_LEGACY) {
+        /* Treat legacy version as v1 */
+        effective_version = 1;
+    } else {
+        effective_version = x86_cpu_model_resolve_version(xcc->model);
+    }
+
+    vdef = xcc->model->cpudef->versions;
+
+    if (vdef == NULL) {
+        return;
+    } else {
+        if (vdef[effective_version - 1].deprecated) {
+            warn_report("Effective CPU model '%s' -- %s",
+                    x86_cpu_versioned_model_name(xcc->model->cpudef,\
+                                                effective_version),
+                    vdef[effective_version - 1].note);
+        }
+    }
+}
+
 static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 {
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
@@ -7291,6 +7331,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->tlb_fill = x86_cpu_tlb_fill;
 #endif
     cc->disas_set_info = x86_disas_set_info;
+    cc->deprecation_check = x86_cpu_deprecation_check;
 
     dc->user_creatable = true;
 }
-- 
1.8.3.1


