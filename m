Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6A5C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 06:35:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC7920881
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 06:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC7920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibfIn-0002CP-KF
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 01:35:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1ibfGH-0006jn-GW
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 01:32:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1ibfGG-00016d-Ew
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 01:32:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:13274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1ibfGG-00015V-6V
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 01:32:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Dec 2019 22:32:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,268,1571727600"; d="scan'208";a="293301517"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by orsmga001.jf.intel.com with ESMTP; 01 Dec 2019 22:32:42 -0800
From: Tao Xu <tao3.xu@intel.com>
To: pbonzini@redhat.com,
	rth@twiddle.net,
	ehabkost@redhat.com
Subject: [PATCH RESEND 3/4] target/i386: Add new property note to versioned
 CPU models
Date: Mon,  2 Dec 2019 14:32:32 +0800
Message-Id: <20191202063233.28523-4-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191202063233.28523-1-tao3.xu@intel.com>
References: <20191202063233.28523-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
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
Cc: tao3.xu@intel.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add additional information for -cpu help to indicate the changes in this
version of CPU model.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 target/i386/cpu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b09ac38409..7b3bd6d4db 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1693,6 +1693,7 @@ typedef struct PropValue {
 typedef struct X86CPUVersionDefinition {
     X86CPUVersion version;
     const char *alias;
+    const char *note;
     PropValue *props;
 } X86CPUVersionDefinition;
 
@@ -1723,6 +1724,7 @@ struct X86CPUModel {
     X86CPUDefinition *cpudef;
     /* CPU model version */
     X86CPUVersion version;
+    const char *note;
     /*
      * If true, this is an alias CPU model.
      * This matters only for "-cpu help" and query-cpu-definitions
@@ -4788,6 +4790,7 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
     char *name = x86_cpu_class_get_model_name(cc);
     char *desc = g_strdup(cc->model_description);
     char *alias_of = x86_cpu_class_get_alias_of(cc);
+    char *model_id = x86_cpu_class_get_model_id(cc);
 
     if (!desc && alias_of) {
         if (cc->model && cc->model->version == CPU_VERSION_AUTO) {
@@ -4796,14 +4799,18 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
             desc = g_strdup_printf("(alias of %s)", alias_of);
         }
     }
+    if (!desc && cc->model && cc->model->note) {
+        desc = g_strdup_printf("%s [%s]", model_id, cc->model->note);
+    }
     if (!desc) {
-        desc = x86_cpu_class_get_model_id(cc);
+        desc = g_strdup_printf("%s", model_id);
     }
 
-    qemu_printf("x86 %-20s  %-48s\n", name, desc);
+    qemu_printf("x86 %-20s  %-58s\n", name, desc);
     g_free(name);
     g_free(desc);
     g_free(alias_of);
+    g_free(model_id);
 }
 
 /* list available CPU models and flags */
@@ -5280,6 +5287,7 @@ static void x86_register_cpudef_types(X86CPUDefinition *def)
         X86CPUModel *m = g_new0(X86CPUModel, 1);
         m->cpudef = def;
         m->version = vdef->version;
+        m->note = vdef->note;
         name = x86_cpu_versioned_model_name(def, vdef->version);
         x86_register_cpu_model_type(name, m);
         g_free(name);
-- 
2.20.1


