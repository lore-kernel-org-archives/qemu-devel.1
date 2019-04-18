Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E3FC10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 21:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B2A0214C6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 21:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2A0214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47419 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHELw-0005kh-8i
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 17:13:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0e-0005Du-6p
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0V-0005Gw-ES
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHE0U-0005EZ-SK
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B22177DCE0
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DF9B160143
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id DFA52110CFAF; Thu, 18 Apr 2019 22:51:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 22:51:27 +0200
Message-Id: <20190418205135.6686-29-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
References: <20190418205135.6686-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 18 Apr 2019 20:51:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL for-4.1 28/36] target: Simplify how the
 TARGET_cpu_list() print
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418205127.BwHzy7QeJvKgxD13BWy94OWqleoJVEGkektPKMQ2Ifw@z>

The various TARGET_cpu_list() take an fprintf()-like callback and a
FILE * to pass to it.  Their callers (vl.c's main() via list_cpus(),
bsd-user/main.c's main(), linux-user/main.c's main()) all pass
fprintf() and stdout.  Thus, the flexibility provided by the (rather
tiresome) indirection isn't actually used.

Drop the callback, and call qemu_printf() instead.

Calling printf() would also work, but would make the code unsuitable
for monitor context without making it simpler.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190417191805.28198-10-armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 bsd-user/main.c                  |  2 +-
 cpus.c                           |  4 +--
 include/exec/cpu-common.h        | 13 ---------
 include/sysemu/cpus.h            |  3 +-
 linux-user/main.c                |  2 +-
 target/alpha/cpu.c               | 15 ++++------
 target/alpha/cpu.h               |  2 +-
 target/arm/cpu.c                 |  1 -
 target/arm/cpu.h                 |  2 +-
 target/arm/helper.c              | 15 ++++------
 target/cris/cpu.c                | 14 ++++-----
 target/cris/cpu.h                |  2 +-
 target/hppa/cpu.c                | 14 ++++-----
 target/hppa/cpu.h                |  2 +-
 target/i386/cpu.c                | 29 ++++++++-----------
 target/i386/cpu.h                |  2 +-
 target/lm32/cpu.c                | 14 ++++-----
 target/lm32/cpu.h                |  2 +-
 target/m68k/cpu.h                |  2 +-
 target/m68k/helper.c             | 14 +++------
 target/mips/cpu.h                |  2 +-
 target/mips/translate.c          |  1 +
 target/mips/translate_init.inc.c |  5 ++--
 target/openrisc/cpu.c            | 15 ++++------
 target/openrisc/cpu.h            |  2 +-
 target/ppc/cpu.h                 |  2 +-
 target/ppc/translate_init.inc.c  | 26 +++++++----------
 target/riscv/cpu.c               | 17 +++--------
 target/riscv/cpu.h               |  2 +-
 target/s390x/cpu.h               |  2 +-
 target/s390x/cpu_models.c        | 21 ++++++--------
 target/sh4/cpu.c                 | 17 +++--------
 target/sh4/cpu.h                 |  2 +-
 target/sparc/cpu.c               | 49 +++++++++++++++-----------------
 target/sparc/cpu.h               |  2 +-
 target/tricore/cpu.h             |  2 +-
 target/tricore/helper.c          | 15 ++++------
 target/xtensa/cpu.h              |  2 +-
 target/xtensa/helper.c           |  7 +++--
 vl.c                             |  2 +-
 40 files changed, 129 insertions(+), 218 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 8fd8ae4127..7657c6851d 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -819,7 +819,7 @@ int main(int argc, char **argv)
             if (is_help_option(cpu_model)) {
 /* XXX: implement xxx_cpu_list for targets that still miss it */
 #if defined(cpu_list)
-                    cpu_list(stdout, &fprintf);
+                    cpu_list();
 #endif
                 exit(1);
             }
diff --git a/cpus.c b/cpus.c
index 684aa9679a..b4eecf70f0 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2181,11 +2181,11 @@ int vm_stop_force_state(RunState state)
     }
 }
 
-void list_cpus(FILE *f, fprintf_function cpu_fprintf, const char *optarg)
+void list_cpus(const char *optarg)
 {
     /* XXX: implement xxx_cpu_list for targets that still miss it */
 #if defined(cpu_list)
-    cpu_list(f, cpu_fprintf);
+    cpu_list();
 #endif
 }
 
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index cef8b88a2a..848a4b94ab 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -9,19 +9,6 @@
 
 #include "qemu/bswap.h"
 #include "qemu/queue.h"
-#include "qemu/fprintf-fn.h"
-
-/**
- * CPUListState:
- * @cpu_fprintf: Print function.
- * @file: File to print to using @cpu_fprint.
- *
- * State commonly used for iterating over CPU models.
- */
-typedef struct CPUListState {
-    fprintf_function cpu_fprintf;
-    FILE *file;
-} CPUListState;
 
 /* The CPU list lock nests outside page_(un)lock or mmap_(un)lock */
 void qemu_init_cpu_list(void);
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index ef13a120cc..32c05f27e7 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -1,7 +1,6 @@
 #ifndef QEMU_CPUS_H
 #define QEMU_CPUS_H
 
-#include "qemu/fprintf-fn.h"
 #include "qemu/timer.h"
 
 /* cpus.c */
@@ -39,7 +38,7 @@ extern int smp_cores;
 extern int smp_threads;
 #endif
 
-void list_cpus(FILE *f, fprintf_function cpu_fprintf, const char *optarg);
+void list_cpus(const char *optarg);
 
 void qemu_tcg_configure(QemuOpts *opts, Error **errp);
 
diff --git a/linux-user/main.c b/linux-user/main.c
index f9efe9ff6e..17387166ab 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -317,7 +317,7 @@ static void handle_arg_cpu(const char *arg)
     if (cpu_model == NULL || is_help_option(cpu_model)) {
         /* XXX: implement xxx_cpu_list for targets that still miss it */
 #if defined(cpu_list)
-        cpu_list(stdout, &fprintf);
+        cpu_list();
 #endif
         exit(EXIT_FAILURE);
     }
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 1fd95d6c0f..ad3588a44a 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -21,6 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "qemu-common.h"
 #include "exec/exec-all.h"
@@ -74,23 +75,17 @@ static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
 static void alpha_cpu_list_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
-    CPUListState *s = user_data;
 
-    (*s->cpu_fprintf)(s->file, "  %s\n",
-                      object_class_get_name(oc));
+    qemu_printf("  %s\n", object_class_get_name(oc));
 }
 
-void alpha_cpu_list(FILE *f, fprintf_function cpu_fprintf)
+void alpha_cpu_list(void)
 {
-    CPUListState s = {
-        .file = f,
-        .cpu_fprintf = cpu_fprintf,
-    };
     GSList *list;
 
     list = object_class_get_list_sorted(TYPE_ALPHA_CPU, false);
-    (*cpu_fprintf)(f, "Available CPUs:\n");
-    g_slist_foreach(list, alpha_cpu_list_entry, &s);
+    qemu_printf("Available CPUs:\n");
+    g_slist_foreach(list, alpha_cpu_list_entry, NULL);
     g_slist_free(list);
 }
 
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 7b50be785d..732764f23c 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -470,7 +470,7 @@ void alpha_translate_init(void);
 #define ALPHA_CPU_TYPE_NAME(model) model ALPHA_CPU_TYPE_SUFFIX
 #define CPU_RESOLVING_TYPE TYPE_ALPHA_CPU
 
-void alpha_cpu_list(FILE *f, fprintf_function cpu_fprintf);
+void alpha_cpu_list(void);
 /* you can call this signal handler from your SIGBUS and SIGSEGV
    signal handlers to inform the virtual CPU of exceptions. non zero
    is returned if the signal was handled by the virtual CPU.  */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4155782197..bb9fdc6304 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "target/arm/idau.h"
-#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "cpu.h"
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d4d2836923..85c3bd642a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1936,7 +1936,7 @@ static inline bool access_secure_reg(CPUARMState *env)
                        (arm_is_secure(_env) && !arm_el_is_aa64((_env), 3)), \
                        (_val))
 
-void arm_cpu_list(FILE *f, fprintf_function cpu_fprintf);
+void arm_cpu_list(void);
 uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
                                  uint32_t cur_el, bool secure);
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a36f4b3d69..57ef75b3fc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10,6 +10,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/bitops.h"
 #include "qemu/crc32c.h"
+#include "qemu/qemu-print.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "arm_ldst.h"
@@ -6724,29 +6725,23 @@ static gint arm_cpu_list_compare(gconstpointer a, gconstpointer b)
 static void arm_cpu_list_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
-    CPUListState *s = user_data;
     const char *typename;
     char *name;
 
     typename = object_class_get_name(oc);
     name = g_strndup(typename, strlen(typename) - strlen("-" TYPE_ARM_CPU));
-    (*s->cpu_fprintf)(s->file, "  %s\n",
-                      name);
+    qemu_printf("  %s\n", name);
     g_free(name);
 }
 
-void arm_cpu_list(FILE *f, fprintf_function cpu_fprintf)
+void arm_cpu_list(void)
 {
-    CPUListState s = {
-        .file = f,
-        .cpu_fprintf = cpu_fprintf,
-    };
     GSList *list;
 
     list = object_class_get_list(TYPE_ARM_CPU, false);
     list = g_slist_sort(list, arm_cpu_list_compare);
-    (*cpu_fprintf)(f, "Available CPUs:\n");
-    g_slist_foreach(list, arm_cpu_list_entry, &s);
+    qemu_printf("Available CPUs:\n");
+    g_slist_foreach(list, arm_cpu_list_entry, NULL);
     g_slist_free(list);
 }
 
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index a23aba2688..75729bfdd5 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -23,6 +23,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "qemu-common.h"
 #include "mmu.h"
@@ -103,27 +104,22 @@ static gint cris_cpu_list_compare(gconstpointer a, gconstpointer b)
 static void cris_cpu_list_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
-    CPUListState *s = user_data;
     const char *typename = object_class_get_name(oc);
     char *name;
 
     name = g_strndup(typename, strlen(typename) - strlen(CRIS_CPU_TYPE_SUFFIX));
-    (*s->cpu_fprintf)(s->file, "  %s\n", name);
+    qemu_printf("  %s\n", name);
     g_free(name);
 }
 
-void cris_cpu_list(FILE *f, fprintf_function cpu_fprintf)
+void cris_cpu_list(void)
 {
-    CPUListState s = {
-        .file = f,
-        .cpu_fprintf = cpu_fprintf,
-    };
     GSList *list;
 
     list = object_class_get_list(TYPE_CRIS_CPU, false);
     list = g_slist_sort(list, cris_cpu_list_compare);
-    (*cpu_fprintf)(f, "Available CPUs:\n");
-    g_slist_foreach(list, cris_cpu_list_entry, &s);
+    qemu_printf("Available CPUs:\n");
+    g_slist_foreach(list, cris_cpu_list_entry, NULL);
     g_slist_free(list);
 }
 
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 8bb1dbc989..3d11922fb2 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -308,6 +308,6 @@ static inline void cpu_get_tb_cpu_state(CPUCRISState *env, target_ulong *pc,
 }
 
 #define cpu_list cris_cpu_list
-void cris_cpu_list(FILE *f, fprintf_function cpu_fprintf);
+void cris_cpu_list(void);
 
 #endif
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 00bf444620..e64f48581e 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "qemu-common.h"
 #include "exec/exec-all.h"
@@ -113,22 +114,17 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
 static void hppa_cpu_list_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
-    CPUListState *s = user_data;
 
-    (*s->cpu_fprintf)(s->file, "  %s\n", object_class_get_name(oc));
+    qemu_printf("  %s\n", object_class_get_name(oc));
 }
 
-void hppa_cpu_list(FILE *f, fprintf_function cpu_fprintf)
+void hppa_cpu_list(void)
 {
-    CPUListState s = {
-        .file = f,
-        .cpu_fprintf = cpu_fprintf,
-    };
     GSList *list;
 
     list = object_class_get_list_sorted(TYPE_HPPA_CPU, false);
-    (*cpu_fprintf)(f, "Available CPUs:\n");
-    g_slist_foreach(list, hppa_cpu_list_entry, &s);
+    qemu_printf("Available CPUs:\n");
+    g_slist_foreach(list, hppa_cpu_list_entry, NULL);
     g_slist_free(list);
 }
 
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index c062c7969c..db8c9b812c 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -272,7 +272,7 @@ void hppa_translate_init(void);
 
 #define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
 
-void hppa_cpu_list(FILE *f, fprintf_function cpu_fprintf);
+void hppa_cpu_list(void);
 
 static inline target_ulong hppa_form_gva_psw(target_ureg psw, uint64_t spc,
                                              target_ureg off)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d6bb57d210..e1687f7547 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -21,6 +21,7 @@
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qemu/bitops.h"
+#include "qemu/qemu-print.h"
 
 #include "cpu.h"
 #include "exec/exec-all.h"
@@ -3671,7 +3672,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
 
 /* Print all cpuid feature names in featureset
  */
-static void listflags(FILE *f, fprintf_function print, GList *features)
+static void listflags(GList *features)
 {
     size_t len = 0;
     GList *tmp;
@@ -3679,13 +3680,13 @@ static void listflags(FILE *f, fprintf_function print, GList *features)
     for (tmp = features; tmp; tmp = tmp->next) {
         const char *name = tmp->data;
         if ((len + strlen(name) + 1) >= 75) {
-            print(f, "\n");
+            qemu_printf("\n");
             len = 0;
         }
-        print(f, "%s%s", len == 0 ? "  " : " ", name);
+        qemu_printf("%s%s", len == 0 ? "  " : " ", name);
         len += strlen(name) + 1;
     }
-    print(f, "\n");
+    qemu_printf("\n");
 }
 
 /* Sort alphabetically by type name, respecting X86CPUClass::ordering. */
@@ -3721,32 +3722,26 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
     X86CPUClass *cc = X86_CPU_CLASS(oc);
-    CPUListState *s = user_data;
     char *name = x86_cpu_class_get_model_name(cc);
     const char *desc = cc->model_description;
     if (!desc && cc->cpu_def) {
         desc = cc->cpu_def->model_id;
     }
 
-    (*s->cpu_fprintf)(s->file, "x86 %-20s  %-48s\n",
-                      name, desc);
+    qemu_printf("x86 %-20s  %-48s\n", name, desc);
     g_free(name);
 }
 
 /* list available CPU models and flags */
-void x86_cpu_list(FILE *f, fprintf_function cpu_fprintf)
+void x86_cpu_list(void)
 {
     int i, j;
-    CPUListState s = {
-        .file = f,
-        .cpu_fprintf = cpu_fprintf,
-    };
     GSList *list;
     GList *names = NULL;
 
-    (*cpu_fprintf)(f, "Available CPUs:\n");
+    qemu_printf("Available CPUs:\n");
     list = get_sorted_cpu_model_list();
-    g_slist_foreach(list, x86_cpu_list_entry, &s);
+    g_slist_foreach(list, x86_cpu_list_entry, NULL);
     g_slist_free(list);
 
     names = NULL;
@@ -3761,9 +3756,9 @@ void x86_cpu_list(FILE *f, fprintf_function cpu_fprintf)
 
     names = g_list_sort(names, (GCompareFunc)strcmp);
 
-    (*cpu_fprintf)(f, "\nRecognized CPUID flags:\n");
-    listflags(f, cpu_fprintf, names);
-    (*cpu_fprintf)(f, "\n");
+    qemu_printf("\nRecognized CPUID flags:\n");
+    listflags(names);
+    qemu_printf("\n");
     g_list_free(names);
 }
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 83fb522554..b39327dcb7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1532,7 +1532,7 @@ int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void x86_cpu_exec_enter(CPUState *cpu);
 void x86_cpu_exec_exit(CPUState *cpu);
 
-void x86_cpu_list(FILE *f, fprintf_function cpu_fprintf);
+void x86_cpu_list(void);
 int cpu_x86_support_mca_broadcast(CPUX86State *env);
 
 int cpu_get_pic_interrupt(CPUX86State *s);
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index b7499cb627..282da19994 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "qemu-common.h"
 
@@ -34,27 +35,22 @@ static void lm32_cpu_set_pc(CPUState *cs, vaddr value)
 static void lm32_cpu_list_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
-    CPUListState *s = user_data;
     const char *typename = object_class_get_name(oc);
     char *name;
 
     name = g_strndup(typename, strlen(typename) - strlen(LM32_CPU_TYPE_SUFFIX));
-    (*s->cpu_fprintf)(s->file, "  %s\n", name);
+    qemu_printf("  %s\n", name);
     g_free(name);
 }
 
 
-void lm32_cpu_list(FILE *f, fprintf_function cpu_fprintf)
+void lm32_cpu_list(void)
 {
-    CPUListState s = {
-        .file = f,
-        .cpu_fprintf = cpu_fprintf,
-    };
     GSList *list;
 
     list = object_class_get_list_sorted(TYPE_LM32_CPU, false);
-    (*cpu_fprintf)(f, "Available CPUs:\n");
-    g_slist_foreach(list, lm32_cpu_list_entry, &s);
+    qemu_printf("Available CPUs:\n");
+    g_slist_foreach(list, lm32_cpu_list_entry, NULL);
     g_slist_free(list);
 }
 
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 66157eefe9..b8d539ead8 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -243,7 +243,7 @@ static inline lm32_wp_t lm32_wp_type(uint32_t dc, int idx)
    is returned if the signal was handled by the virtual CPU.  */
 int cpu_lm32_signal_handler(int host_signum, void *pinfo,
                           void *puc);
-void lm32_cpu_list(FILE *f, fprintf_function cpu_fprintf);
+void lm32_cpu_list(void);
 void lm32_translate_init(void);
 void cpu_lm32_set_phys_msb_ignore(CPULM32State *env, int value);
 void QEMU_NORETURN raise_exception(CPULM32State *env, int index);
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index f154565117..9c1f0a2458 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -499,7 +499,7 @@ static inline int m68k_feature(CPUM68KState *env, int feature)
     return (env->features & (1u << feature)) != 0;
 }
 
-void m68k_cpu_list(FILE *f, fprintf_function cpu_fprintf);
+void m68k_cpu_list(void);
 
 void register_m68k_insns (CPUM68KState *env);
 
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 3e26d337bf..bb64cf15c0 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -22,9 +22,9 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
-
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
+#include "qemu/qemu-print.h"
 
 #define SIGNBIT (1u << 31)
 
@@ -49,28 +49,22 @@ static gint m68k_cpu_list_compare(gconstpointer a, gconstpointer b)
 static void m68k_cpu_list_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *c = data;
-    CPUListState *s = user_data;
     const char *typename;
     char *name;
 
     typename = object_class_get_name(c);
     name = g_strndup(typename, strlen(typename) - strlen("-" TYPE_M68K_CPU));
-    (*s->cpu_fprintf)(s->file, "%s\n",
-                      name);
+    qemu_printf("%s\n", name);
     g_free(name);
 }
 
-void m68k_cpu_list(FILE *f, fprintf_function cpu_fprintf)
+void m68k_cpu_list(void)
 {
-    CPUListState s = {
-        .file = f,
-        .cpu_fprintf = cpu_fprintf,
-    };
     GSList *list;
 
     list = object_class_get_list(TYPE_M68K_CPU, false);
     list = g_slist_sort(list, m68k_cpu_list_compare);
-    g_slist_foreach(list, m68k_cpu_list_entry, &s);
+    g_slist_foreach(list, m68k_cpu_list_entry, NULL);
     g_slist_free(list);
 }
 
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index a10eeb0de3..1f41cf66d5 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1065,7 +1065,7 @@ static inline MIPSCPU *mips_env_get_cpu(CPUMIPSState *env)
 
 #define ENV_OFFSET offsetof(MIPSCPU, env)
 
-void mips_cpu_list (FILE *f, fprintf_function cpu_fprintf);
+void mips_cpu_list(void);
 
 #define cpu_signal_handler cpu_mips_signal_handler
 #define cpu_list mips_cpu_list
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 364bd6dc4f..d886a0c9b2 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -38,6 +38,7 @@
 #include "trace-tcg.h"
 #include "exec/translator.h"
 #include "exec/log.h"
+#include "qemu/qemu-print.h"
 
 #define MIPS_DEBUG_DISAS 0
 
diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
index bf559aff08..1c2d017d36 100644
--- a/target/mips/translate_init.inc.c
+++ b/target/mips/translate_init.inc.c
@@ -835,13 +835,12 @@ const mips_def_t mips_defs[] =
 };
 const int mips_defs_number = ARRAY_SIZE(mips_defs);
 
-void mips_cpu_list (FILE *f, fprintf_function cpu_fprintf)
+void mips_cpu_list(void)
 {
     int i;
 
     for (i = 0; i < ARRAY_SIZE(mips_defs); i++) {
-        (*cpu_fprintf)(f, "MIPS '%s'\n",
-                       mips_defs[i].name);
+        qemu_printf("MIPS '%s'\n", mips_defs[i].name);
     }
 }
 
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 541b2a66c7..d125236977 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "qemu-common.h"
 
@@ -180,30 +181,24 @@ static gint openrisc_cpu_list_compare(gconstpointer a, gconstpointer b)
 static void openrisc_cpu_list_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
-    CPUListState *s = user_data;
     const char *typename;
     char *name;
 
     typename = object_class_get_name(oc);
     name = g_strndup(typename,
                      strlen(typename) - strlen("-" TYPE_OPENRISC_CPU));
-    (*s->cpu_fprintf)(s->file, "  %s\n",
-                      name);
+    qemu_printf("  %s\n", name);
     g_free(name);
 }
 
-void cpu_openrisc_list(FILE *f, fprintf_function cpu_fprintf)
+void cpu_openrisc_list(void)
 {
-    CPUListState s = {
-        .file = f,
-        .cpu_fprintf = cpu_fprintf,
-    };
     GSList *list;
 
     list = object_class_get_list(TYPE_OPENRISC_CPU, false);
     list = g_slist_sort(list, openrisc_cpu_list_compare);
-    (*cpu_fprintf)(f, "Available CPUs:\n");
-    g_slist_foreach(list, openrisc_cpu_list_entry, &s);
+    qemu_printf("Available CPUs:\n");
+    g_slist_foreach(list, openrisc_cpu_list_entry, NULL);
     g_slist_free(list);
 }
 
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index f1b31bc24a..9d2d49631e 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -336,7 +336,7 @@ static inline OpenRISCCPU *openrisc_env_get_cpu(CPUOpenRISCState *env)
 
 #define ENV_OFFSET offsetof(OpenRISCCPU, env)
 
-void cpu_openrisc_list(FILE *f, fprintf_function cpu_fprintf);
+void cpu_openrisc_list(void);
 void openrisc_cpu_do_interrupt(CPUState *cpu);
 bool openrisc_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void openrisc_cpu_dump_state(CPUState *cpu, FILE *f,
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0707177584..382a323c61 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1308,7 +1308,7 @@ void ppc_store_ptcr(CPUPPCState *env, target_ulong value);
 #endif /* !defined(CONFIG_USER_ONLY) */
 void ppc_store_msr (CPUPPCState *env, target_ulong value);
 
-void ppc_cpu_list (FILE *f, fprintf_function cpu_fprintf);
+void ppc_cpu_list(void);
 
 /* Time-base and decrementer management */
 #ifndef NO_CPU_IO_DEFS
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 0bd555eb19..996356dd99 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -28,6 +28,7 @@
 #include "mmu-hash32.h"
 #include "mmu-hash64.h"
 #include "qemu/error-report.h"
+#include "qemu/qemu-print.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/visitor.h"
@@ -10215,7 +10216,6 @@ static gint ppc_cpu_list_compare(gconstpointer a, gconstpointer b)
 static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
-    CPUListState *s = user_data;
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
     DeviceClass *family = DEVICE_CLASS(ppc_cpu_get_family_class(pcc));
     const char *typename = object_class_get_name(oc);
@@ -10228,8 +10228,7 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
 
     name = g_strndup(typename,
                      strlen(typename) - strlen(POWERPC_CPU_TYPE_SUFFIX));
-    (*s->cpu_fprintf)(s->file, "PowerPC %-16s PVR %08x\n",
-                      name, pcc->pvr);
+    qemu_printf("PowerPC %-16s PVR %08x\n", name, pcc->pvr);
     for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
         PowerPCCPUAlias *alias = &ppc_cpu_aliases[i];
         ObjectClass *alias_oc = ppc_cpu_class_by_name(alias->model);
@@ -10242,33 +10241,28 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
          * avoid printing the wrong alias here and use "preferred" instead
          */
         if (strcmp(alias->alias, family->desc) == 0) {
-            (*s->cpu_fprintf)(s->file,
-                              "PowerPC %-16s (alias for preferred %s CPU)\n",
-                              alias->alias, family->desc);
+            qemu_printf("PowerPC %-16s (alias for preferred %s CPU)\n",
+                        alias->alias, family->desc);
         } else {
-            (*s->cpu_fprintf)(s->file, "PowerPC %-16s (alias for %s)\n",
-                              alias->alias, name);
+            qemu_printf("PowerPC %-16s (alias for %s)\n",
+                        alias->alias, name);
         }
     }
     g_free(name);
 }
 
-void ppc_cpu_list(FILE *f, fprintf_function cpu_fprintf)
+void ppc_cpu_list(void)
 {
-    CPUListState s = {
-        .file = f,
-        .cpu_fprintf = cpu_fprintf,
-    };
     GSList *list;
 
     list = object_class_get_list(TYPE_POWERPC_CPU, false);
     list = g_slist_sort(list, ppc_cpu_list_compare);
-    g_slist_foreach(list, ppc_cpu_list_entry, &s);
+    g_slist_foreach(list, ppc_cpu_list_entry, NULL);
     g_slist_free(list);
 
 #ifdef CONFIG_KVM
-    cpu_fprintf(f, "\n");
-    cpu_fprintf(f, "PowerPC %-16s\n", "host");
+    qemu_printf("\n");
+    qemu_printf("PowerPC %-16s\n", "host");
 #endif
 }
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d61bce6d55..104e676ab0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/qemu-print.h"
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
@@ -383,11 +384,6 @@ char *riscv_isa_string(RISCVCPU *cpu)
     return isa_str;
 }
 
-typedef struct RISCVCPUListState {
-    fprintf_function cpu_fprintf;
-    FILE *file;
-} RISCVCPUListState;
-
 static gint riscv_cpu_list_compare(gconstpointer a, gconstpointer b)
 {
     ObjectClass *class_a = (ObjectClass *)a;
@@ -401,24 +397,19 @@ static gint riscv_cpu_list_compare(gconstpointer a, gconstpointer b)
 
 static void riscv_cpu_list_entry(gpointer data, gpointer user_data)
 {
-    RISCVCPUListState *s = user_data;
     const char *typename = object_class_get_name(OBJECT_CLASS(data));
     int len = strlen(typename) - strlen(RISCV_CPU_TYPE_SUFFIX);
 
-    (*s->cpu_fprintf)(s->file, "%.*s\n", len, typename);
+    qemu_printf("%.*s\n", len, typename);
 }
 
-void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf)
+void riscv_cpu_list(void)
 {
-    RISCVCPUListState s = {
-        .cpu_fprintf = cpu_fprintf,
-        .file = f,
-    };
     GSList *list;
 
     list = object_class_get_list(TYPE_RISCV_CPU, false);
     list = g_slist_sort(list, riscv_cpu_list_compare);
-    g_slist_foreach(list, riscv_cpu_list_entry, &s);
+    g_slist_foreach(list, riscv_cpu_list_entry, NULL);
     g_slist_free(list);
 }
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 20bce8742e..7d9f48973f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -264,7 +264,7 @@ void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 int riscv_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
                               int rw, int mmu_idx);
 char *riscv_isa_string(RISCVCPU *cpu);
-void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf);
+void riscv_cpu_list(void);
 
 #define cpu_signal_handler riscv_cpu_signal_handler
 #define cpu_list riscv_cpu_list
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index cb6d77053a..d8990c405a 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -753,7 +753,7 @@ static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
 
 
 /* cpu_models.c */
-void s390_cpu_list(FILE *f, fprintf_function cpu_fprintf);
+void s390_cpu_list(void);
 #define cpu_list s390_cpu_list
 void s390_set_qemu_cpu_model(uint16_t type, uint8_t gen, uint8_t ec_ga,
                              const S390FeatInit feat_init);
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index eb125d4d0d..e5afa15512 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -18,6 +18,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
+#include "qemu/qemu-print.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qmp/qdict.h"
@@ -308,7 +309,6 @@ const S390CPUDef *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
 
 static void s390_print_cpu_model_list_entry(gpointer data, gpointer user_data)
 {
-    CPUListState *s = user_data;
     const S390CPUClass *scc = S390_CPU_CLASS((ObjectClass *)data);
     char *name = g_strdup(object_class_get_name((ObjectClass *)data));
     const char *details = "";
@@ -321,8 +321,7 @@ static void s390_print_cpu_model_list_entry(gpointer data, gpointer user_data)
 
     /* strip off the -s390x-cpu */
     g_strrstr(name, "-" TYPE_S390_CPU)[0] = 0;
-    (*s->cpu_fprintf)(s->file, "s390 %-15s %-35s %s\n", name, scc->desc,
-                      details);
+    qemu_printf("s390 %-15s %-35s %s\n", name, scc->desc, details);
     g_free(name);
 }
 
@@ -360,33 +359,29 @@ static gint s390_cpu_list_compare(gconstpointer a, gconstpointer b)
     return cc_a->is_static ? -1 : 1;
 }
 
-void s390_cpu_list(FILE *f, fprintf_function print)
+void s390_cpu_list(void)
 {
-    CPUListState s = {
-        .file = f,
-        .cpu_fprintf = print,
-    };
     S390FeatGroup group;
     S390Feat feat;
     GSList *list;
 
     list = object_class_get_list(TYPE_S390_CPU, false);
     list = g_slist_sort(list, s390_cpu_list_compare);
-    g_slist_foreach(list, s390_print_cpu_model_list_entry, &s);
+    g_slist_foreach(list, s390_print_cpu_model_list_entry, NULL);
     g_slist_free(list);
 
-    (*print)(f, "\nRecognized feature flags:\n");
+    qemu_printf("\nRecognized feature flags:\n");
     for (feat = 0; feat < S390_FEAT_MAX; feat++) {
         const S390FeatDef *def = s390_feat_def(feat);
 
-        (*print)(f, "%-20s %-50s\n", def->name, def->desc);
+        qemu_printf("%-20s %-50s\n", def->name, def->desc);
     }
 
-    (*print)(f, "\nRecognized feature groups:\n");
+    qemu_printf("\nRecognized feature groups:\n");
     for (group = 0; group < S390_FEAT_GROUP_MAX; group++) {
         const S390FeatGroupDef *def = s390_feat_group_def(group);
 
-        (*print)(f, "%-20s %-50s\n", def->name, def->desc);
+        qemu_printf("%-20s %-50s\n", def->name, def->desc);
     }
 }
 
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index b9f393b7c7..da2799082e 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -21,6 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "qemu-common.h"
 #include "migration/vmstate.h"
@@ -79,30 +80,20 @@ static void superh_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
     info->print_insn = print_insn_sh;
 }
 
-typedef struct SuperHCPUListState {
-    fprintf_function cpu_fprintf;
-    FILE *file;
-} SuperHCPUListState;
-
 static void superh_cpu_list_entry(gpointer data, gpointer user_data)
 {
-    SuperHCPUListState *s = user_data;
     const char *typename = object_class_get_name(OBJECT_CLASS(data));
     int len = strlen(typename) - strlen(SUPERH_CPU_TYPE_SUFFIX);
 
-    (*s->cpu_fprintf)(s->file, "%.*s\n", len, typename);
+    qemu_printf("%.*s\n", len, typename);
 }
 
-void sh4_cpu_list(FILE *f, fprintf_function cpu_fprintf)
+void sh4_cpu_list(void)
 {
-    SuperHCPUListState s = {
-        .cpu_fprintf = cpu_fprintf,
-        .file = f,
-    };
     GSList *list;
 
     list = object_class_get_list_sorted(TYPE_SUPERH_CPU, false);
-    g_slist_foreach(list, superh_cpu_list_entry, &s);
+    g_slist_foreach(list, superh_cpu_list_entry, NULL);
     g_slist_free(list);
 }
 
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 775b5743bf..3e43f0a1a5 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -247,7 +247,7 @@ int cpu_sh4_signal_handler(int host_signum, void *pinfo,
 int superh_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
                                 int mmu_idx);
 
-void sh4_cpu_list(FILE *f, fprintf_function cpu_fprintf);
+void sh4_cpu_list(void);
 #if !defined(CONFIG_USER_ONLY)
 void cpu_sh4_invalidate_tlb(CPUSH4State *s);
 uint32_t cpu_sh4_read_mmaped_itlb_addr(CPUSH4State *s,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 4a4445bdf5..fd88a31806 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "qemu/error-report.h"
+#include "qemu/qemu-print.h"
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
 #include "qapi/visitor.h"
@@ -556,47 +556,44 @@ static const char * const feature_name[] = {
     "gl",
 };
 
-static void print_features(FILE *f, fprintf_function cpu_fprintf,
-                           uint32_t features, const char *prefix)
+static void print_features(uint32_t features, const char *prefix)
 {
     unsigned int i;
 
     for (i = 0; i < ARRAY_SIZE(feature_name); i++) {
         if (feature_name[i] && (features & (1 << i))) {
             if (prefix) {
-                (*cpu_fprintf)(f, "%s", prefix);
+                qemu_printf("%s", prefix);
             }
-            (*cpu_fprintf)(f, "%s ", feature_name[i]);
+            qemu_printf("%s ", feature_name[i]);
         }
     }
 }
 
-void sparc_cpu_list(FILE *f, fprintf_function cpu_fprintf)
+void sparc_cpu_list(void)
 {
     unsigned int i;
 
     for (i = 0; i < ARRAY_SIZE(sparc_defs); i++) {
-        (*cpu_fprintf)(f, "Sparc %16s IU " TARGET_FMT_lx
-                       " FPU %08x MMU %08x NWINS %d ",
-                       sparc_defs[i].name,
-                       sparc_defs[i].iu_version,
-                       sparc_defs[i].fpu_version,
-                       sparc_defs[i].mmu_version,
-                       sparc_defs[i].nwindows);
-        print_features(f, cpu_fprintf, CPU_DEFAULT_FEATURES &
-                       ~sparc_defs[i].features, "-");
-        print_features(f, cpu_fprintf, ~CPU_DEFAULT_FEATURES &
-                       sparc_defs[i].features, "+");
-        (*cpu_fprintf)(f, "\n");
+        qemu_printf("Sparc %16s IU " TARGET_FMT_lx
+                    " FPU %08x MMU %08x NWINS %d ",
+                    sparc_defs[i].name,
+                    sparc_defs[i].iu_version,
+                    sparc_defs[i].fpu_version,
+                    sparc_defs[i].mmu_version,
+                    sparc_defs[i].nwindows);
+        print_features(CPU_DEFAULT_FEATURES & ~sparc_defs[i].features, "-");
+        print_features(~CPU_DEFAULT_FEATURES & sparc_defs[i].features, "+");
+        qemu_printf("\n");
     }
-    (*cpu_fprintf)(f, "Default CPU feature flags (use '-' to remove): ");
-    print_features(f, cpu_fprintf, CPU_DEFAULT_FEATURES, NULL);
-    (*cpu_fprintf)(f, "\n");
-    (*cpu_fprintf)(f, "Available CPU feature flags (use '+' to add): ");
-    print_features(f, cpu_fprintf, ~CPU_DEFAULT_FEATURES, NULL);
-    (*cpu_fprintf)(f, "\n");
-    (*cpu_fprintf)(f, "Numerical features (use '=' to set): iu_version "
-                   "fpu_version mmu_version nwindows\n");
+    qemu_printf("Default CPU feature flags (use '-' to remove): ");
+    print_features(CPU_DEFAULT_FEATURES, NULL);
+    qemu_printf("\n");
+    qemu_printf("Available CPU feature flags (use '+' to add): ");
+    print_features(~CPU_DEFAULT_FEATURES, NULL);
+    qemu_printf("\n");
+    qemu_printf("Numerical features (use '=' to set): iu_version "
+                "fpu_version mmu_version nwindows\n");
 }
 
 static void cpu_print_cc(FILE *f, fprintf_function cpu_fprintf,
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 4972ebcfd4..ab9fa3ddbf 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -578,7 +578,7 @@ void cpu_raise_exception_ra(CPUSPARCState *, int, uintptr_t) QEMU_NORETURN;
 #ifndef NO_CPU_IO_DEFS
 /* cpu_init.c */
 void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu);
-void sparc_cpu_list(FILE *f, fprintf_function cpu_fprintf);
+void sparc_cpu_list(void);
 /* mmu_helper.c */
 int sparc_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
                                int mmu_idx);
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 00e69dc154..43d577ce8e 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -375,7 +375,7 @@ void fpu_set_state(CPUTriCoreState *env);
 
 #define MMU_USER_IDX 2
 
-void tricore_cpu_list(FILE *f, fprintf_function cpu_fprintf);
+void tricore_cpu_list(void);
 
 #define cpu_signal_handler cpu_tricore_signal_handler
 #define cpu_list tricore_cpu_list
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 0769046993..78ee87c9ea 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -20,6 +20,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "fpu/softfloat.h"
+#include "qemu/qemu-print.h"
 
 enum {
     TLBRET_DIRTY = -4,
@@ -82,28 +83,22 @@ int cpu_tricore_handle_mmu_fault(CPUState *cs, target_ulong address,
 static void tricore_cpu_list_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
-    CPUListState *s = user_data;
     const char *typename;
     char *name;
 
     typename = object_class_get_name(oc);
     name = g_strndup(typename, strlen(typename) - strlen("-" TYPE_TRICORE_CPU));
-    (*s->cpu_fprintf)(s->file, "  %s\n",
-                      name);
+    qemu_printf("  %s\n", name);
     g_free(name);
 }
 
-void tricore_cpu_list(FILE *f, fprintf_function cpu_fprintf)
+void tricore_cpu_list(void)
 {
-    CPUListState s = {
-        .file = f,
-        .cpu_fprintf = cpu_fprintf,
-    };
     GSList *list;
 
     list = object_class_get_list_sorted(TYPE_TRICORE_CPU, false);
-    (*cpu_fprintf)(f, "Available CPUs:\n");
-    g_slist_foreach(list, tricore_cpu_list_entry, &s);
+    qemu_printf("Available CPUs:\n");
+    g_slist_foreach(list, tricore_cpu_list_entry, NULL);
     g_slist_free(list);
 }
 
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 4d8152682f..4aaf1f7bb2 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -600,7 +600,7 @@ void xtensa_irq_init(CPUXtensaState *env);
 qemu_irq *xtensa_get_extints(CPUXtensaState *env);
 qemu_irq xtensa_get_runstall(CPUXtensaState *env);
 int cpu_xtensa_signal_handler(int host_signum, void *pinfo, void *puc);
-void xtensa_cpu_list(FILE *f, fprintf_function cpu_fprintf);
+void xtensa_cpu_list(void);
 void xtensa_sync_window_from_phys(CPUXtensaState *env);
 void xtensa_sync_phys_from_window(CPUXtensaState *env);
 void xtensa_rotate_window(CPUXtensaState *env, uint32_t delta);
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index f4867a9b56..5f37f378a3 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -31,6 +31,7 @@
 #include "exec/gdbstub.h"
 #include "exec/helper-proto.h"
 #include "qemu/error-report.h"
+#include "qemu/qemu-print.h"
 #include "qemu/host-utils.h"
 
 static struct XtensaConfigList *xtensa_cores;
@@ -228,12 +229,12 @@ void xtensa_breakpoint_handler(CPUState *cs)
     }
 }
 
-void xtensa_cpu_list(FILE *f, fprintf_function cpu_fprintf)
+void xtensa_cpu_list(void)
 {
     XtensaConfigList *core = xtensa_cores;
-    cpu_fprintf(f, "Available CPUs:\n");
+    qemu_printf("Available CPUs:\n");
     for (; core; core = core->next) {
-        cpu_fprintf(f, "  %s\n", core->config->name);
+        qemu_printf("  %s\n", core->config->name);
     }
 }
 
diff --git a/vl.c b/vl.c
index 190c773176..ff5dfb6fbc 100644
--- a/vl.c
+++ b/vl.c
@@ -4051,7 +4051,7 @@ int main(int argc, char **argv, char **envp)
     }
 
     if (cpu_model && is_help_option(cpu_model)) {
-        list_cpus(stdout, &fprintf, cpu_model);
+        list_cpus(cpu_model);
         exit(0);
     }
 
-- 
2.17.2


