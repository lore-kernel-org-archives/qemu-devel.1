Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF51C282DD
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 21:26:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE0C2208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 21:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0C2208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59738 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ2vp-00073x-2o
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 17:26:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJ2sl-0004Yr-9r
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJ2sf-0007mP-LW
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:23:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>)
	id 1hJ2sX-0007h2-9A; Tue, 23 Apr 2019 17:23:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 88297308795B;
	Tue, 23 Apr 2019 21:22:57 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 391095C239;
	Tue, 23 Apr 2019 21:22:52 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 18:22:45 -0300
Message-Id: <20190423212246.3542-3-ehabkost@redhat.com>
In-Reply-To: <20190423212246.3542-1-ehabkost@redhat.com>
References: <20190423212246.3542-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Tue, 23 Apr 2019 21:22:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/3] machine: Use SupportStatusInfo for
 deprecation info
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, mprivozn@redhat.com,
	Markus Armbruster <armbru@redhat.com>,
	=?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
	qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190423212245.sTJvtu4MEJBwYwd-ujR64U2g49B5U8deKGLcMSq9RMg@z>

Use SupportStatusInfo to represent deprecation information of
machine types.

Instead of using a generic "use XXX instead" message for humans,
encode the suggested alternative in a machine-friendly way at the
'suggested_alternatives' field.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h |  7 ++++---
 hw/i386/pc_piix.c   |  4 +++-
 hw/ppc/prep.c       |  4 +++-
 vl.c                | 13 +++++++++----
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index e231860666..243bf3c7ce 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -8,6 +8,8 @@
 #include "hw/qdev.h"
 #include "qom/object.h"
 #include "qom/cpu.h"
+#include "qapi/qapi-types-common.h"
+
 
 /**
  * memory_region_allocate_system_memory - Allocate a board's main memory
@@ -105,8 +107,7 @@ typedef struct {
 
 /**
  * MachineClass:
- * @deprecation_reason: If set, the machine is marked as deprecated. The
- *    string should provide some clear information about what to use instead.
+ * @support_status: Support and deprecation status of machine type.
  * @max_cpus: maximum number of CPUs supported. Default: 1
  * @min_cpus: minimum number of CPUs supported. Default: 1
  * @default_cpus: number of CPUs instantiated if none are specified. Default: 1
@@ -169,7 +170,7 @@ struct MachineClass {
     char *name;
     const char *alias;
     const char *desc;
-    const char *deprecation_reason;
+    SupportStatusInfo support_status;
 
     void (*init)(MachineState *state);
     void (*reset)(void);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8ad8e885c6..97bd401618 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -781,7 +781,9 @@ static void pc_i440fx_0_15_machine_options(MachineClass *m)
 
     pc_i440fx_1_0_machine_options(m);
     m->hw_version = "0.15";
-    m->deprecation_reason = "use a newer machine type instead";
+    m->support_status.deprecated = true;
+    m->support_status.has_suggested_alternative = true;
+    m->support_status.suggested_alternative = g_strdup("pc");
     compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
 }
 
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 847d320465..9a02b0eec4 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -587,7 +587,9 @@ static void ppc_prep_init(MachineState *machine)
 
 static void prep_machine_init(MachineClass *mc)
 {
-    mc->deprecation_reason = "use 40p machine type instead";
+    mc->support_status.deprecated = true;
+    mc->support_status.has_suggested_alternative = true;
+    mc->support_status.suggested_alternative = g_strdup("40p");
     mc->desc = "PowerPC PREP platform";
     mc->init = ppc_prep_init;
     mc->block_default_type = IF_IDE;
diff --git a/vl.c b/vl.c
index c696ad2a13..99b857ed2a 100644
--- a/vl.c
+++ b/vl.c
@@ -2610,7 +2610,7 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
             }
             printf("%-20s %s%s%s\n", mc->name, mc->desc,
                    mc->is_default ? " (default)" : "",
-                   mc->deprecation_reason ? " (deprecated)" : "");
+                   mc->support_status.deprecated ? " (deprecated)" : "");
         }
     }
 
@@ -4308,9 +4308,14 @@ int main(int argc, char **argv, char **envp)
      * called from configure_accelerator().
      */
 
-    if (!qtest_enabled() && machine_class->deprecation_reason) {
-        error_report("Machine type '%s' is deprecated: %s",
-                     machine_class->name, machine_class->deprecation_reason);
+    if (!qtest_enabled() && machine_class->support_status.deprecated) {
+        error_report("Machine type '%s' is deprecated%s%s", machine_class->name,
+                     machine_class->support_status.status_message ? ": " : "",
+                     machine_class->support_status.status_message ?: "");
+        if (machine_class->support_status.suggested_alternative) {
+            error_report("Suggested solution: use '%s' machine type instead",
+                         machine_class->support_status.suggested_alternative);
+        }
     }
 
     /*
-- 
2.18.0.rc1.1.g3f1ff2140


