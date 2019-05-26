Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BF2C07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3228D20815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3228D20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49344 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUiC4-0008Nw-DM
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:43:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxL-0003S6-4q
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhgA-0006CX-1e
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhg9-00061N-R5
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id t1so7095685pgc.2
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=CVbWDlas40F0rKvam5wngvhSb1j1fei2kGX8ZQssRDQ=;
	b=Pxc1hXQyzFuroWMfx9xN36cLDo8hQxW1As74E9JEx4IXh9yN8NqHTemJQxkntz6bZK
	7amyqpXfkDUwmc9O3BD4WACgUlZaQcoYvxwQPLflZhawHGLLvfRPIgZIwdR5U1bQW5Nl
	9g3dt4OEV+PJf+QHp9exJlafXdqKsbbrNTw8MPTxfiNsVAE0+iHm/hpPq8edN+xAkc7C
	mklIKhV66bpnUshmqyUg+ccdElMk/d8a2EaKF0vD7QGqHA0KaTijanN85d515YcDAqWh
	Kd5ZFwz7Z7NonCZ/b7NKhRW/b3CVrMn7aGqxJ3QS/4RXvYuerizxOxXKJX6w2MMQD6Ia
	hzOA==
X-Gm-Message-State: APjAAAWIyqlDUpnBRd64ZGgURjWAyaIDukn1ntiae1UxYXKzTz1nSlWt
	tV+PdzNcGIztrPdzrO44LNkHlQ==
X-Google-Smtp-Source: APXvYqyeMlO1o00rR1A2XrQVLivfcC38ZZJEIIXUB1pDCkwVOV1iDIuPiRQgn2/dBCseaowywF3KZg==
X-Received: by 2002:a63:5c5f:: with SMTP id
	n31mr117659621pgm.325.1558833022111; 
	Sat, 25 May 2019 18:10:22 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	q98sm12604903pjc.1.2019.05.25.18.10.21
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:21 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:34 -0700
Message-Id: <20190526010948.3923-16-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.215.194
Subject: [Qemu-devel] [PULL 15/29] target/riscv: Create settable CPU
 properties
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
	Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <Alistair.Francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 target/riscv/cpu.h |  8 ++++++++
 2 files changed, 57 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6a58bc9e9d90..0399e03e89c5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -23,6 +23,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "qapi/error.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 
 /* RISC-V CPU definitions */
@@ -296,7 +297,11 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
+    RISCVCPU *cpu = RISCV_CPU(dev);
+    CPURISCVState *env = &cpu->env;
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
+    int priv_version = PRIV_VERSION_1_10_0;
+    int user_version = USER_VERSION_2_02_0;
     Error *local_err = NULL;
 
     cpu_exec_realizefn(cs, &local_err);
@@ -305,6 +310,41 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (cpu->cfg.priv_spec) {
+        if (!g_strcmp0(cpu->cfg.priv_spec, "v1.10.0")) {
+            priv_version = PRIV_VERSION_1_10_0;
+        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.9.1")) {
+            priv_version = PRIV_VERSION_1_09_1;
+        } else {
+            error_setg(errp,
+                       "Unsupported privilege spec version '%s'",
+                       cpu->cfg.priv_spec);
+            return;
+        }
+    }
+
+    if (cpu->cfg.user_spec) {
+        if (!g_strcmp0(cpu->cfg.user_spec, "v2.02.0")) {
+            user_version = USER_VERSION_2_02_0;
+        } else {
+            error_setg(errp,
+                       "Unsupported user spec version '%s'",
+                       cpu->cfg.user_spec);
+            return;
+        }
+    }
+
+    set_versions(env, user_version, priv_version);
+    set_resetvec(env, DEFAULT_RSTVEC);
+
+    if (cpu->cfg.mmu) {
+        set_feature(env, RISCV_FEATURE_MMU);
+    }
+
+    if (cpu->cfg.pmp) {
+        set_feature(env, RISCV_FEATURE_PMP);
+    }
+
     riscv_cpu_register_gdb_regs_for_features(cs);
 
     qemu_init_vcpu(cs);
@@ -326,6 +366,14 @@ static const VMStateDescription vmstate_riscv_cpu = {
     .unmigratable = 1,
 };
 
+static Property riscv_cpu_properties[] = {
+    DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
+    DEFINE_PROP_STRING("user_spec", RISCVCPU, cfg.user_spec),
+    DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
+    DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void riscv_cpu_class_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
@@ -365,6 +413,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
 #endif
     /* For now, mark unmigratable: */
     cc->vmsd = &vmstate_riscv_cpu;
+    dc->props = riscv_cpu_properties;
 }
 
 char *riscv_isa_string(RISCVCPU *cpu)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c17184f4e477..3902138639e7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -224,6 +224,14 @@ typedef struct RISCVCPU {
     CPUState parent_obj;
     /*< public >*/
     CPURISCVState env;
+
+    /* Configuration Settings */
+    struct {
+        char *priv_spec;
+        char *user_spec;
+        bool mmu;
+        bool pmp;
+    } cfg;
 } RISCVCPU;
 
 static inline RISCVCPU *riscv_env_get_cpu(CPURISCVState *env)
-- 
2.21.0


