Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E158C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 117F02078D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSVg7xYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117F02078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6cqY-0007Oa-8k
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 12:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k6clf-00072R-5l; Fri, 14 Aug 2020 12:41:23 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:40259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k6clc-0002dO-GY; Fri, 14 Aug 2020 12:41:22 -0400
Received: by mail-pj1-x1044.google.com with SMTP id d4so4631437pjx.5;
 Fri, 14 Aug 2020 09:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Y2tMjmXkDl0fq+x9uIcxt1w/4Y6jZovYHNuWJ4DjJgo=;
 b=RSVg7xYv9Q/IoWSyVhG4Trl7MuaGmKnnz9X6pLvw93NeFrCjstbjDht99FpyMZP9zB
 +lH1BqGqTQc/+KvozaDdM7Ih7QeO7UUJyf0Wo8EMr0FyPT3Ox6Nl1tFOzaAYpAc98H38
 9NLCxilIr/XRA+jzFK7iLFDjUkzyRa2V+ta92vxLaswHOeH6AXV24OSpWK35Ntv6P4AB
 q3E9nnG6Jstf+Ki5OEpkgu0AOjB2fwOiWpRZMLCL1F6Lauir0eL1WzVvjXSbQbqB3TKA
 DIyDo1gc6ljk94opH0znZwBNIcQdxbwz0yz3tWUc/oQ0ROfy7iCsY05XYtr/ewb1/IRM
 m73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Y2tMjmXkDl0fq+x9uIcxt1w/4Y6jZovYHNuWJ4DjJgo=;
 b=NJqxBkIIsxkEqnQ5v0QhGf8ugKXDjle3KEIcDYFHb5uinVrwQMkT5MW0mRoz6KUy3X
 UW7Ue6yqgLpW+LkIOsivrsVcZJNjsOT1R6OzU9f2dlA740vdO3q4oADr2v4dAua23B+V
 5cbgCDf9N64xi8zTLQA9EwfjwZrbN8/mDnz9gUR4ZED6NKNg+520ksGNLVW6xU1AT7o2
 4nfCsaQFLE03pdvRFwsfnHZIcq6KTIX3Ze+a2I7usR066AlGHxulLfo6rsV0bfJutMAo
 6rU7N7ikgNqsy2DynwLkmjZlbWTgCOJetqzdJ9dHwFoV17zzX682hFJ7iK93DeOJeMJL
 D/EQ==
X-Gm-Message-State: AOAM530VaYUR/oT5FrAN0h8jx003XI0BfHXoUpfjy5DHdCaIReQc9bMs
 pEK15iUbD+78kw34FOCFi1vUJ5skH2vviqKO
X-Google-Smtp-Source: ABdhPJwaXsD85aSqD8jYaNOcaEoR/4TH4nUmKoQQmth2Y6pdC17NTaLtvfKbsjJjk1Z/6AhX/u4njQ==
X-Received: by 2002:a17:90a:ea13:: with SMTP id
 w19mr3116136pjy.18.1597423278660; 
 Fri, 14 Aug 2020 09:41:18 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id 16sm9836332pfi.161.2020.08.14.09.41.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Aug 2020 09:41:18 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 03/18] target/riscv: cpu: Set reset vector based on the
 configured property value
Date: Sat, 15 Aug 2020 00:40:41 +0800
Message-Id: <1597423256-14847-4-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Now that we have the newly introduced 'resetvec' property in the
RISC-V CPU and HART, instead of hard-coding the reset vector addr
in the CPU's instance_init(), move that to riscv_cpu_realize()
based on the configured property value from the RISC-V machines.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/opentitan.c | 1 +
 hw/riscv/sifive_e.c  | 1 +
 hw/riscv/sifive_u.c  | 2 ++
 target/riscv/cpu.c   | 7 ++-----
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index a8f0039..b0a4eae 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -111,6 +111,7 @@ static void lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
                             &error_abort);
     object_property_set_int(OBJECT(&s->cpus), "num-harts", ms->smp.cpus,
                             &error_abort);
+    object_property_set_int(OBJECT(&s->cpus), "resetvec", 0x8090, &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_abort);
 
     /* Boot ROM */
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index c8b0604..c84d407 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -177,6 +177,7 @@ static void sifive_e_soc_init(Object *obj)
     object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
     object_property_set_int(OBJECT(&s->cpus), "num-harts", ms->smp.cpus,
                             &error_abort);
+    object_property_set_int(OBJECT(&s->cpus), "resetvec", 0x1004, &error_abort);
     object_initialize_child(obj, "riscv.sifive.e.gpio0", &s->gpio,
                             TYPE_SIFIVE_GPIO);
 }
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 18301e6..e256da2 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -611,6 +611,7 @@ static void sifive_u_soc_instance_init(Object *obj)
     qdev_prop_set_uint32(DEVICE(&s->e_cpus), "num-harts", 1);
     qdev_prop_set_uint32(DEVICE(&s->e_cpus), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(&s->e_cpus), "cpu-type", SIFIVE_E_CPU);
+    qdev_prop_set_uint64(DEVICE(&s->e_cpus), "resetvec", 0x1004);
 
     object_initialize_child(obj, "u-cluster", &s->u_cluster, TYPE_CPU_CLUSTER);
     qdev_prop_set_uint32(DEVICE(&s->u_cluster), "cluster-id", 1);
@@ -620,6 +621,7 @@ static void sifive_u_soc_instance_init(Object *obj)
     qdev_prop_set_uint32(DEVICE(&s->u_cpus), "num-harts", ms->smp.cpus - 1);
     qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", 1);
     qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type", SIFIVE_U_CPU);
+    qdev_prop_set_uint64(DEVICE(&s->u_cpus), "resetvec", 0x1004);
 
     object_initialize_child(obj, "prci", &s->prci, TYPE_SIFIVE_U_PRCI);
     object_initialize_child(obj, "otp", &s->otp, TYPE_SIFIVE_U_OTP);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8067a26..bd41286 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -128,7 +128,6 @@ static void riscv_any_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_11_0);
-    set_resetvec(env, DEFAULT_RSTVEC);
 }
 
 static void riscv_base_cpu_init(Object *obj)
@@ -136,7 +135,6 @@ static void riscv_base_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     /* We set this in the realise function */
     set_misa(env, 0);
-    set_resetvec(env, DEFAULT_RSTVEC);
 }
 
 static void rvxx_sifive_u_cpu_init(Object *obj)
@@ -144,7 +142,6 @@ static void rvxx_sifive_u_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
-    set_resetvec(env, 0x1004);
 }
 
 static void rvxx_sifive_e_cpu_init(Object *obj)
@@ -152,7 +149,6 @@ static void rvxx_sifive_e_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RVXLEN | RVI | RVM | RVA | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
-    set_resetvec(env, 0x1004);
     qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
 
@@ -163,7 +159,6 @@ static void rv32_ibex_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV32 | RVI | RVM | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
-    set_resetvec(env, 0x8090);
     qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
 
@@ -373,6 +368,8 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         set_feature(env, RISCV_FEATURE_PMP);
     }
 
+    set_resetvec(env, cpu->cfg.resetvec);
+
     /* If misa isn't set (rv32 and rv64 machines) set it here */
     if (!env->misa) {
         /* Do some ISA extension error checking */
-- 
2.7.4


