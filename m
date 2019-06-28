Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A59C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90444205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90444205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgunZ-0001wM-Lw
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54327)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hguju-00080s-6n
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgujr-0008Dp-A4
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:32:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32862)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgujr-0008DL-3U
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:32:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id x15so3337192pfq.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 10:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=93jKVryLi5S9dNljnJoTk5o5gCPNFkrJiDJGBHe6zKM=;
 b=dftmA0XHy4cQgYNmIzxeHxk1TSI4EuGq3Tj6YAWSxEsz1ePkAMfOrHx11RTz5hinLB
 sUaE68qLN352hQlQJelw/0w/AWD/5qB4npd0squVQ967aOxNeRwlnX/kPYPdW5tmkwZJ
 logXiAt1JOjio+hKBGS8qOn6nTcQHAKnaQkfEZBD3fejR7hOyuqZFT/nrdtM4v8W9TpJ
 rxeWtBbvWE+FmKGjJ5S+/BCwf9uQ976+n3AES8ew0KWPq9Yg17VLYMJhbvs9IQdkhFC5
 zNfy5CBm376/ngeC71gXuTWIdVwY7DhMMAAqr+7q0gc0ixFu70qZz8qS9s4lxvAkXqt0
 IIPQ==
X-Gm-Message-State: APjAAAUwOyH3O9l+vzYCieXNcnU3Npfa/UyFue2O5TxNez6VmTxDsxSb
 DEDiifIRF+OgfuIBYLBWe8m+51m5w+F8EQ==
X-Google-Smtp-Source: APXvYqyYhL0QcB4X0yTQn+5v7BSpoyuzKC1hRlbT+1pEk8oJenCMqSbQMIyS51vCPgSio3m1xLdFFw==
X-Received: by 2002:a17:90a:eb08:: with SMTP id
 j8mr14902053pjz.72.1561743161587; 
 Fri, 28 Jun 2019 10:32:41 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id b5sm5998657pga.72.2019.06.28.10.32.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 10:32:40 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:31:54 -0700
Message-Id: <20190628173227.31925-2-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628173227.31925-1-palmer@sifive.com>
References: <20190628173227.31925-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.196
Subject: [Qemu-devel] [PULL 01/34] target/riscv: Allow setting ISA
 extensions via CPU props
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <Alistair.Francis@wdc.com>

This patch allows us to enable/disable the RISC-V ISA extensions from
the QEMU command line. This works with the rv32 and rv64 machines. The
idea is that in the future we can now add extensions and leave them
disabled by default until enabled by the user.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c | 70 ++++++++++++++++++++++++++++++++++++++++++++--
 target/riscv/cpu.h | 11 ++++++++
 2 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6f2b64422086..0632ac08cf35 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -24,6 +24,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 
@@ -119,7 +120,8 @@ static void riscv_any_cpu_init(Object *obj)
 static void riscv_base32_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
-    set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
+    /* We set this in the realise function */
+    set_misa(env, 0);
 }
 
 static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
@@ -156,7 +158,8 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
 static void riscv_base64_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
-    set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
+    /* We set this in the realise function */
+    set_misa(env, 0);
 }
 
 static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
@@ -315,6 +318,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     int priv_version = PRIV_VERSION_1_10_0;
     int user_version = USER_VERSION_2_02_0;
+    target_ulong target_misa = 0;
     Error *local_err = NULL;
 
     cpu_exec_realizefn(cs, &local_err);
@@ -358,6 +362,58 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         set_feature(env, RISCV_FEATURE_PMP);
     }
 
+    /* If misa isn't set (rv32 and rv64 machines) set it here */
+    if (!env->misa) {
+        /* Do some ISA extension error checking */
+        if (cpu->cfg.ext_i && cpu->cfg.ext_e) {
+            error_setg(errp,
+                       "I and E extensions are incompatible");
+                       return;
+       }
+
+       if (cpu->cfg.ext_g && !(cpu->cfg.ext_i & cpu->cfg.ext_m &
+                               cpu->cfg.ext_a & cpu->cfg.ext_f &
+                               cpu->cfg.ext_d)) {
+            warn_report("Setting G will also set IMAFD");
+            cpu->cfg.ext_i = true;
+            cpu->cfg.ext_m = true;
+            cpu->cfg.ext_a = true;
+            cpu->cfg.ext_f = true;
+            cpu->cfg.ext_d = true;
+        }
+
+        /* Set the ISA extensions, checks should have happened above */
+        if (cpu->cfg.ext_i) {
+            target_misa |= RVI;
+        }
+        if (cpu->cfg.ext_e) {
+            target_misa |= RVE;
+        }
+        if (cpu->cfg.ext_m) {
+            target_misa |= RVM;
+        }
+        if (cpu->cfg.ext_a) {
+            target_misa |= RVA;
+        }
+        if (cpu->cfg.ext_f) {
+            target_misa |= RVF;
+        }
+        if (cpu->cfg.ext_d) {
+            target_misa |= RVD;
+        }
+        if (cpu->cfg.ext_c) {
+            target_misa |= RVC;
+        }
+        if (cpu->cfg.ext_s) {
+            target_misa |= RVS;
+        }
+        if (cpu->cfg.ext_u) {
+            target_misa |= RVU;
+        }
+
+        set_misa(env, RVXLEN | target_misa);
+    }
+
     riscv_cpu_register_gdb_regs_for_features(cs);
 
     qemu_init_vcpu(cs);
@@ -379,6 +435,16 @@ static const VMStateDescription vmstate_riscv_cpu = {
 };
 
 static Property riscv_cpu_properties[] = {
+    DEFINE_PROP_BOOL("i", RISCVCPU, cfg.ext_i, true),
+    DEFINE_PROP_BOOL("e", RISCVCPU, cfg.ext_e, false),
+    DEFINE_PROP_BOOL("g", RISCVCPU, cfg.ext_g, true),
+    DEFINE_PROP_BOOL("m", RISCVCPU, cfg.ext_m, true),
+    DEFINE_PROP_BOOL("a", RISCVCPU, cfg.ext_a, true),
+    DEFINE_PROP_BOOL("f", RISCVCPU, cfg.ext_f, true),
+    DEFINE_PROP_BOOL("d", RISCVCPU, cfg.ext_d, true),
+    DEFINE_PROP_BOOL("c", RISCVCPU, cfg.ext_c, true),
+    DEFINE_PROP_BOOL("s", RISCVCPU, cfg.ext_s, true),
+    DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
     DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
     DEFINE_PROP_STRING("user_spec", RISCVCPU, cfg.user_spec),
     DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6c5de37b2520..b47cde501766 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -211,6 +211,17 @@ typedef struct RISCVCPU {
 
     /* Configuration Settings */
     struct {
+        bool ext_i;
+        bool ext_e;
+        bool ext_g;
+        bool ext_m;
+        bool ext_a;
+        bool ext_f;
+        bool ext_d;
+        bool ext_c;
+        bool ext_s;
+        bool ext_u;
+
         char *priv_spec;
         char *user_spec;
         bool mmu;
-- 
2.21.0


