Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788B7C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:44:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4476E208E0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFM5Y+Ld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4476E208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7GC-0005qp-DK
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 10:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jH7F7-00041f-Pl
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jH7F6-0005ed-Aj
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:42:53 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:42676)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jH7F3-0005bp-8e; Wed, 25 Mar 2020 10:42:49 -0400
Received: by mail-pg1-x52c.google.com with SMTP id h8so1230972pgs.9;
 Wed, 25 Mar 2020 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WKYOGG0g9s481Vm+dxBUu5LtOyPszMxI1/G7LP+9Ut4=;
 b=XFM5Y+LdZSJf1fyJHzHaYC4KPs45aN1EYpypio/bBbiz/n4uGllxriKLqdCNtfKlb0
 1/sOh6mCHxdxO0urXnusWoVqXdAwgGyXTQTYG3mbbCDQgyfRsv/Uky5NhnHBlQNWrlof
 kNzQJ7YrYO07N0tz9zML9axbcg5mTwny9kYJHCvhVwtEfZppsw5BTiTpVpkjmcpVQlUm
 OALoejT2EJrrVRZ8NZ4ZK9+Oy5zZJQ7QEnLQiuOC27arv7AfuKSv+k2EzVbpT2Aqa7Ym
 XTYtdno8arx99PvyEsgR0z2c1punlhJI8xD1cRnR02EfQ5XA0yTpVBzeoTPnsOZPkOye
 Eb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WKYOGG0g9s481Vm+dxBUu5LtOyPszMxI1/G7LP+9Ut4=;
 b=U65kPHmUGxgJqiIE5iepujDy59LJxaEynyALhvCfH8deI4L1sYiHl9GiK7FKea6Lwk
 3Pe0ordizwirnPNn/rzcMWY5NVFGBc7I4FLcrSn3Lfcd/gUYGpdINZ9S5414p/WJMSwP
 oOL/+dgYdalPiFVQZtdX0ZFDvqga27DBvkzb7vlMzRniwQUaML6myO12fGyBScPFKxXI
 EV4dcCS59UNq1I5XZ639D0/wFbtqmCHucsUMwy0tRRecwmYD1Car6WOuWOZZlEokVK3d
 Asse1cZV47710B5XDNtayS0qPVhB87XY94lLVoPjrxRQ3u09pt6Pxbs7FmenlBWs6s5F
 QN8Q==
X-Gm-Message-State: ANhLgQ2hOHFFznhewDGXLmIU0LL30hBng5OpPpvEu8UfN/KYDsrRE8Df
 oYP/DJAoSFUvli6KxEngVzGF5el7
X-Google-Smtp-Source: ADFU+vuwJ60gCy3xAzXdh0hle4Cjf/kHhSwoM17PGT+Hnf2LoDXKtGmm/y1xK6LmySTBtL1jcnwJ0g==
X-Received: by 2002:a63:794d:: with SMTP id u74mr3491417pgc.15.1585147367982; 
 Wed, 25 Mar 2020 07:42:47 -0700 (PDT)
Received: from bobo.ibm.com (14-202-190-183.tpgi.com.au. [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id 93sm4609599pjo.43.2020.03.25.07.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 07:42:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH 3/5] nmi: add MCE class for implementing machine check
 injection commands
Date: Thu, 26 Mar 2020 00:41:45 +1000
Message-Id: <20200325144147.221875-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200325144147.221875-1-npiggin@gmail.com>
References: <20200325144147.221875-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52c
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Like commit 9cb805fd26 ("cpus: Define callback for QEMU "nmi" command")
this implements a machine check injection command framework and defines
a monitor command for ppc.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hmp-commands.hx              | 20 +++++++++++-
 hw/core/nmi.c                | 61 ++++++++++++++++++++++++++++++++++++
 include/hw/nmi.h             | 20 ++++++++++++
 include/monitor/hmp-target.h |  1 -
 include/monitor/hmp.h        |  1 +
 monitor/hmp-cmds.c           |  1 +
 target/ppc/monitor.c         | 11 +++++++
 7 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 7f0f3974ad..4a9089b431 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1581,12 +1581,30 @@ ERST
         .cmd        = hmp_mce,
     },
 
-#endif
 SRST
 ``mce`` *cpu* *bank* *status* *mcgstatus* *addr* *misc*
   Inject an MCE on the given CPU (x86 only).
 ERST
 
+#endif
+
+#if defined(TARGET_PPC)
+
+    {
+        .name       = "mce",
+        .args_type  = "cpu_index:i,srr1_mask:l,dsisr:i,dar:l,recovered:i",
+        .params     = "cpu srr1_mask dsisr dar recovered",
+        .help       = "inject a MCE on the given CPU",
+        .cmd        = hmp_mce,
+    },
+
+SRST
+``mce`` *cpu* *srr1_mask* *dsisr* *dar* *recovered*
+  Inject an MCE on the given CPU (PPC only).
+ERST
+
+#endif
+
     {
         .name       = "getfd",
         .args_type  = "fdname:s",
diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index 481c4b3c7e..2a79500967 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -86,3 +86,64 @@ static void nmi_register_types(void)
 }
 
 type_init(nmi_register_types)
+
+struct do_mce_s {
+    const QDict *qdict;
+    Error *err;
+    bool handled;
+};
+
+static void mce_children(Object *o, struct do_mce_s *ns);
+
+static int do_mce(Object *o, void *opaque)
+{
+    struct do_mce_s *ms = opaque;
+    MCEState *m = (MCEState *) object_dynamic_cast(o, TYPE_MCE);
+
+    if (m) {
+        MCEClass *mc = MCE_GET_CLASS(m);
+
+        ms->handled = true;
+        mc->mce_monitor_handler(m, ms->qdict, &ms->err);
+        if (ms->err) {
+            return -1;
+        }
+    }
+    mce_children(o, ms);
+
+    return 0;
+}
+
+static void mce_children(Object *o, struct do_mce_s *ms)
+{
+    object_child_foreach(o, do_mce, ms);
+}
+
+void mce_monitor_handle(const QDict *qdict, Error **errp)
+{
+    struct do_mce_s ms = {
+        .qdict = qdict,
+        .err = NULL,
+        .handled = false
+    };
+
+    mce_children(object_get_root(), &ms);
+    if (ms.handled) {
+        error_propagate(errp, ms.err);
+    } else {
+        error_setg(errp, QERR_UNSUPPORTED);
+    }
+}
+
+static const TypeInfo mce_info = {
+    .name          = TYPE_MCE,
+    .parent        = TYPE_INTERFACE,
+    .class_size    = sizeof(MCEClass),
+};
+
+static void mce_register_types(void)
+{
+    type_register_static(&mce_info);
+}
+
+type_init(mce_register_types)
diff --git a/include/hw/nmi.h b/include/hw/nmi.h
index fe37ce3ad8..de39d95c9a 100644
--- a/include/hw/nmi.h
+++ b/include/hw/nmi.h
@@ -43,4 +43,24 @@ typedef struct NMIClass {
 
 void nmi_monitor_handle(int cpu_index, Error **errp);
 
+
+#define TYPE_MCE "mce"
+
+#define MCE_CLASS(klass) \
+     OBJECT_CLASS_CHECK(MCEClass, (klass), TYPE_MCE)
+#define MCE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(MCEClass, (obj), TYPE_MCE)
+#define MCE(obj) \
+     INTERFACE_CHECK(MCEState, (obj), TYPE_MCE)
+
+typedef struct MCEState MCEState;
+
+typedef struct MCEClass {
+    InterfaceClass parent_class;
+
+    void (*mce_monitor_handler)(MCEState *n, const QDict *qdict, Error **errp);
+} MCEClass;
+
+void mce_monitor_handle(const QDict *qdict, Error **errp);
+
 #endif /* NMI_H */
diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index 8b7820a3ad..afb8f5bca2 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -45,7 +45,6 @@ CPUState *mon_get_cpu(void);
 
 void hmp_info_mem(Monitor *mon, const QDict *qdict);
 void hmp_info_tlb(Monitor *mon, const QDict *qdict);
-void hmp_mce(Monitor *mon, const QDict *qdict);
 void hmp_info_local_apic(Monitor *mon, const QDict *qdict);
 void hmp_info_io_apic(Monitor *mon, const QDict *qdict);
 
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index e33ca5a911..f747a5e214 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -54,6 +54,7 @@ void hmp_ringbuf_read(Monitor *mon, const QDict *qdict);
 void hmp_cont(Monitor *mon, const QDict *qdict);
 void hmp_system_wakeup(Monitor *mon, const QDict *qdict);
 void hmp_nmi(Monitor *mon, const QDict *qdict);
+void hmp_mce(Monitor *mon, const QDict *qdict);
 void hmp_set_link(Monitor *mon, const QDict *qdict);
 void hmp_balloon(Monitor *mon, const QDict *qdict);
 void hmp_loadvm(Monitor *mon, const QDict *qdict);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 58724031ea..3664ef2a4f 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -52,6 +52,7 @@
 #include "exec/ramlist.h"
 #include "hw/intc/intc.h"
 #include "hw/rdma/rdma.h"
+#include "hw/nmi.h"
 #include "migration/snapshot.h"
 #include "migration/misc.h"
 
diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
index a5a177d717..6daf543efc 100644
--- a/target/ppc/monitor.c
+++ b/target/ppc/monitor.c
@@ -28,6 +28,8 @@
 #include "qemu/ctype.h"
 #include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
+#include "qapi/qmp/qdict.h"
+#include "hw/nmi.h"
 
 static target_long monitor_get_ccr(const struct MonitorDef *md, int val)
 {
@@ -72,6 +74,15 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
     dump_mmu(env1);
 }
 
+void hmp_mce(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+
+    mce_monitor_handle(qdict, &err);
+
+    hmp_handle_error(mon, err);
+}
+
 const MonitorDef monitor_defs[] = {
     { "fpscr", offsetof(CPUPPCState, fpscr) },
     /* Next instruction pointer */
-- 
2.23.0


