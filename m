Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6C2C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31DFC206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4ZSj4A1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DFC206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5wm-0003hu-B0
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 09:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kD5qU-0001SB-GZ; Tue, 01 Sep 2020 08:57:06 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:41241)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kD5qL-0002m2-Fo; Tue, 01 Sep 2020 08:57:06 -0400
Received: by mail-qv1-xf43.google.com with SMTP id ef16so428102qvb.8;
 Tue, 01 Sep 2020 05:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y1n4j8MWmzH3QTa58abB2b7OQGX7+9wfRdvkH69UYn8=;
 b=P4ZSj4A1M1q9lwZlJgsAbC454Rvh3CZwxVfaLedfKkt2b+npn+MsN7oWDT8pwSRF2z
 bsRYrO3wL42M30DRVDYKKD+h1xgFE3Kvb4FT+EFeO2OO6JywPlhyczhlSyfxd5F5gdDK
 BszP1mlwIrzoL4L87QWStlDzk/iHhZaCdb/nfpG2oiUUEcna+7MAjL+Xip49st7Griu7
 NCx8QAZMTjRtVgPzJcnAMt44gvENjEKJZt7ftRkHLvn8XXyUkKz7xOiBhXZ1NOwtBc3f
 gKQaBhpm5YiTmfdVqwFWFpfAkenvEfGu54/ccJ173hgi7DsA3uGhZFTQqKrd22qhUhxm
 Roxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y1n4j8MWmzH3QTa58abB2b7OQGX7+9wfRdvkH69UYn8=;
 b=OrkUVAOXnUbEcf/ilrFmO4gxR91IuDpjZHDB2HvyO7YVSmOZLKYL4e14AyESTumGTr
 783eSbZL50FfqrZCZ0FyoBcHYxMzqYz2fcDCbPL1w6xX+6ZuBpIHFaZaZgsFEUTQ0jMF
 Rlc9PR4v+IRmPfBKNsWxLvB0xz8ks3h4yEtVu95p2UpP1l8Z4dZRHaq8AF8KnqjBL+NZ
 IBZtU/RX4FiQoDb/Nb8mI686GtVFig+/6+tjE4w4gVWaK4WSIOs4bZsaRvzh2M/pQt+T
 lnPa8oN6+y6OsrslVyLOmYByOqxG9B+Y7O3CJn5vUhgKUF1mGQCPgelmzmuI4bWWSmtk
 +U1g==
X-Gm-Message-State: AOAM531g8HB3Czjm2Z96Ir/Wf7k9OSQ5vh7etgVRpkxaWf2h4wg0uEfe
 0Ae7eXEPXn55+mzzHH3ubsSd0NqvCIbHtQ==
X-Google-Smtp-Source: ABdhPJzayrWVpUUHw9fhuUsVAyYJKM1+31j2zwYQCKZNyQUw8zbxE/kfU5LI+PLZDwf3GJ3aDHBSiw==
X-Received: by 2002:ad4:5749:: with SMTP id q9mr1744768qvx.56.1598965015946;
 Tue, 01 Sep 2020 05:56:55 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:6be:f6e3:c671:cefe:b943])
 by smtp.gmail.com with ESMTPSA id q7sm1430164qkf.35.2020.09.01.05.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 05:56:55 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/7] ppc: introducing spapr_numa.c NUMA code helper
Date: Tue,  1 Sep 2020 09:56:39 -0300
Message-Id: <20200901125645.118026-2-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901125645.118026-1-danielhb413@gmail.com>
References: <20200901125645.118026-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f43;
 envelope-from=danielhb413@gmail.com; helo=mail-qv1-xf43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We're going to make changes in how spapr handles all
ibm,associativity* related properties to enhance our current NUMA
support.

At this moment we have associativity code scattered all around
spapr_* files, with hardcoded values and array sizes. This
makes it harder to change any NUMA specific parameters in
the future. Having everything in the same place allows not
only for easier tuning, but also easier understanding since all
NUMA related code is on the same file.

This patch introduces a new file to gather all NUMA/associativity
handling code in spapr, spapr_numa.c. To get things started, let's
remove associativity-reference-points and max-associativity-domains
code from spapr_dt_rtas() to a new helper called spapr_numa_write_rtas_dt().
This will decouple spapr_dt_rtas() from the NUMA changes that
are going to happen in those two properties.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/meson.build          |  3 ++-
 hw/ppc/spapr.c              | 26 ++-----------------
 hw/ppc/spapr_numa.c         | 50 +++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_numa.h | 20 +++++++++++++++
 4 files changed, 74 insertions(+), 25 deletions(-)
 create mode 100644 hw/ppc/spapr_numa.c
 create mode 100644 include/hw/ppc/spapr_numa.h

diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 918969b320..ffa2ec37fa 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -25,7 +25,8 @@ ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
   'spapr_irq.c',
   'spapr_tpm_proxy.c',
   'spapr_nvdimm.c',
-  'spapr_rtas_ddw.c'
+  'spapr_rtas_ddw.c',
+  'spapr_numa.c',
 ))
 ppc_ss.add(when: 'CONFIG_SPAPR_RNG', if_true: files('spapr_rng.c'))
 ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_LINUX'], if_true: files(
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b0a04443fb..a45912acac 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -81,6 +81,7 @@
 #include "hw/mem/memory-device.h"
 #include "hw/ppc/spapr_tpm_proxy.h"
 #include "hw/ppc/spapr_nvdimm.h"
+#include "hw/ppc/spapr_numa.h"
 
 #include "monitor/monitor.h"
 
@@ -891,16 +892,9 @@ static int spapr_dt_rng(void *fdt)
 static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
 {
     MachineState *ms = MACHINE(spapr);
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(ms);
     int rtas;
     GString *hypertas = g_string_sized_new(256);
     GString *qemu_hypertas = g_string_sized_new(256);
-    uint32_t refpoints[] = {
-        cpu_to_be32(0x4),
-        cpu_to_be32(0x4),
-        cpu_to_be32(0x2),
-    };
-    uint32_t nr_refpoints = ARRAY_SIZE(refpoints);
     uint64_t max_device_addr = MACHINE(spapr)->device_memory->base +
         memory_region_size(&MACHINE(spapr)->device_memory->mr);
     uint32_t lrdr_capacity[] = {
@@ -910,14 +904,6 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
         cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE & 0xffffffff),
         cpu_to_be32(ms->smp.max_cpus / ms->smp.threads),
     };
-    uint32_t maxdomain = cpu_to_be32(spapr->gpu_numa_id > 1 ? 1 : 0);
-    uint32_t maxdomains[] = {
-        cpu_to_be32(4),
-        maxdomain,
-        maxdomain,
-        maxdomain,
-        cpu_to_be32(spapr->gpu_numa_id),
-    };
 
     _FDT(rtas = fdt_add_subnode(fdt, 0, "rtas"));
 
@@ -953,15 +939,7 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
                      qemu_hypertas->str, qemu_hypertas->len));
     g_string_free(qemu_hypertas, TRUE);
 
-    if (smc->pre_5_1_assoc_refpoints) {
-        nr_refpoints = 2;
-    }
-
-    _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points",
-                     refpoints, nr_refpoints * sizeof(refpoints[0])));
-
-    _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
-                     maxdomains, sizeof(maxdomains)));
+    spapr_numa_write_rtas_dt(spapr, fdt, rtas);
 
     /*
      * FWNMI reserves RTAS_ERROR_LOG_MAX for the machine check error log,
diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
new file mode 100644
index 0000000000..cdf3288cbd
--- /dev/null
+++ b/hw/ppc/spapr_numa.c
@@ -0,0 +1,50 @@
+/*
+ * QEMU PowerPC pSeries Logical Partition NUMA associativity handling
+ *
+ * Copyright IBM Corp. 2020
+ *
+ * Authors:
+ *  Daniel Henrique Barboza      <danielhb413@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "hw/ppc/spapr_numa.h"
+#include "hw/ppc/fdt.h"
+
+/*
+ * Helper that writes ibm,associativity-reference-points and
+ * max-associativity-domains in the RTAS pointed by @rtas
+ * in the DT @fdt.
+ */
+void spapr_numa_write_rtas_dt(SpaprMachineState *spapr, void *fdt, int rtas)
+{
+    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
+    uint32_t refpoints[] = {
+        cpu_to_be32(0x4),
+        cpu_to_be32(0x4),
+        cpu_to_be32(0x2),
+    };
+    uint32_t nr_refpoints = ARRAY_SIZE(refpoints);
+    uint32_t maxdomain = cpu_to_be32(spapr->gpu_numa_id > 1 ? 1 : 0);
+    uint32_t maxdomains[] = {
+        cpu_to_be32(4),
+        maxdomain,
+        maxdomain,
+        maxdomain,
+        cpu_to_be32(spapr->gpu_numa_id),
+    };
+
+    if (smc->pre_5_1_assoc_refpoints) {
+        nr_refpoints = 2;
+    }
+
+    _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points",
+                     refpoints, nr_refpoints * sizeof(refpoints[0])));
+
+    _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
+                     maxdomains, sizeof(maxdomains)));
+}
diff --git a/include/hw/ppc/spapr_numa.h b/include/hw/ppc/spapr_numa.h
new file mode 100644
index 0000000000..7a370a8768
--- /dev/null
+++ b/include/hw/ppc/spapr_numa.h
@@ -0,0 +1,20 @@
+/*
+ * QEMU PowerPC pSeries Logical Partition NUMA associativity handling
+ *
+ * Copyright IBM Corp. 2020
+ *
+ * Authors:
+ *  Daniel Henrique Barboza      <danielhb413@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_SPAPR_NUMA_H
+#define HW_SPAPR_NUMA_H
+
+#include "hw/ppc/spapr.h"
+
+void spapr_numa_write_rtas_dt(SpaprMachineState *spapr, void *fdt, int rtas);
+
+#endif /* HW_SPAPR_NUMA_H */
-- 
2.26.2


