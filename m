Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3F2C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 21:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B1A20869
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 21:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B1A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHEBL-0005XE-CS
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 17:02:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0a-00059U-W0
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0V-0005Ga-33
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHE0U-0005DU-Jf
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F159D7DCD7
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C96F5C21F
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id B2C731132758; Thu, 18 Apr 2019 22:51:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 22:51:21 +0200
Message-Id: <20190418205135.6686-23-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
References: <20190418205135.6686-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 18 Apr 2019 20:51:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL for-4.1 22/36] tcg: Simplify how
 dump_opcount_info() prints
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
Message-ID: <20190418205121.mEEihrxdtr5zcRVp66KIAB2CBTQuwjrRx_gvxWf5wYY@z>

dump_opcount_info() takes an fprintf()-like callback and a FILE * to
pass to it.

Its only caller hmp_info_opcount() passes monitor_fprintf() and the
current monitor cast to FILE *.  monitor_fprintf() casts it right
back, and is otherwise identical to monitor_printf().  The
type-punning is ugly.

Drop the callback, and call qemu_printf() instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190417191805.28198-4-armbru@redhat.com>
---
 accel/tcg/translate-all.c | 4 ++--
 include/exec/cpu-all.h    | 2 +-
 monitor.c                 | 2 +-
 tcg/tcg.c                 | 9 +++++----
 tcg/tcg.h                 | 2 +-
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 8f593b926f..85e80a1fad 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2333,9 +2333,9 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
     tcg_dump_info(f, cpu_fprintf);
 }
 
-void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf)
+void dump_opcount_info(void)
 {
-    tcg_dump_op_count(f, cpu_fprintf);
+    tcg_dump_op_count();
 }
 
 #else /* CONFIG_USER_ONLY */
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index b16c9ec513..40f5edf4dc 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -363,7 +363,7 @@ static inline bool tlb_hit(target_ulong tlb_addr, target_ulong addr)
 }
 
 void dump_exec_info(FILE *f, fprintf_function cpu_fprintf);
-void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf);
+void dump_opcount_info(void);
 #endif /* !CONFIG_USER_ONLY */
 
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
diff --git a/monitor.c b/monitor.c
index a3e66b7159..30a7ffe32b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1324,7 +1324,7 @@ static void hmp_info_jit(Monitor *mon, const QDict *qdict)
 
 static void hmp_info_opcount(Monitor *mon, const QDict *qdict)
 {
-    dump_opcount_info((FILE *)mon, monitor_fprintf);
+    dump_opcount_info();
 }
 #endif
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 9b2bf7f439..cc5f4e2a03 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -33,6 +33,7 @@
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
 #include "qemu/host-utils.h"
+#include "qemu/qemu-print.h"
 #include "qemu/timer.h"
 
 /* Note: the long term plan is to reduce the dependencies on the QEMU
@@ -3768,14 +3769,14 @@ static void tcg_profile_snapshot_table(TCGProfile *prof)
     tcg_profile_snapshot(prof, false, true);
 }
 
-void tcg_dump_op_count(FILE *f, fprintf_function cpu_fprintf)
+void tcg_dump_op_count(void)
 {
     TCGProfile prof = {};
     int i;
 
     tcg_profile_snapshot_table(&prof);
     for (i = 0; i < NB_OPS; i++) {
-        cpu_fprintf(f, "%s %" PRId64 "\n", tcg_op_defs[i].name,
+        qemu_printf("%s %" PRId64 "\n", tcg_op_defs[i].name,
                     prof.table_op_count[i]);
     }
 }
@@ -3795,9 +3796,9 @@ int64_t tcg_cpu_exec_time(void)
     return ret;
 }
 #else
-void tcg_dump_op_count(FILE *f, fprintf_function cpu_fprintf)
+void tcg_dump_op_count(void)
 {
-    cpu_fprintf(f, "[TCG profiler not compiled]\n");
+    qemu_printf("[TCG profiler not compiled]\n");
 }
 
 int64_t tcg_cpu_exec_time(void)
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 32b7cf3489..9f2b03f119 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -1018,7 +1018,7 @@ int tcg_check_temp_count(void);
 
 int64_t tcg_cpu_exec_time(void);
 void tcg_dump_info(FILE *f, fprintf_function cpu_fprintf);
-void tcg_dump_op_count(FILE *f, fprintf_function cpu_fprintf);
+void tcg_dump_op_count(void);
 
 #define TCG_CT_ALIAS  0x80
 #define TCG_CT_IALIAS 0x40
-- 
2.17.2


