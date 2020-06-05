Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF96C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64850207D3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYcHBj9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64850207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh6yo-0003mt-LC
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 03:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jh6xf-0001ye-Mi; Fri, 05 Jun 2020 03:40:19 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:40170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jh6xe-00050A-Qg; Fri, 05 Jun 2020 03:40:19 -0400
Received: by mail-pj1-x1044.google.com with SMTP id s88so2377973pjb.5;
 Fri, 05 Jun 2020 00:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Rhy2L/UJyGdmzgxzSZV4yex5B1vPy4D3Y2E2zfPwvKc=;
 b=rYcHBj9dTEztQdgQcJuD0dwqojjAxrgjf+3IL67+0l+ZcTlrE4tp2MlJJQu5Nt1vjT
 h8gLzD5W+wLJchC++Uraag0WN5xZWkOOPpEphPeHG0RIT8xQpBqTT2qkRab3cohmhHPD
 vh58yX3AWdadzjD6Fc8W3u9QQcKQBxpoWuz6fgvQakkCZJRMHfvPla/L2lTfgCsbQEw1
 XejnrD7qIYNyHlUNUqsqLZQ26fcfFPZc8/4oJla3Mm9Yq7SHRoKNDasKXwWS1DA9+b5V
 DFvUaacniwALAZGmiPifr4/X9ShTnhPYYBLrYM/xZ0T5T6kDxbh/w/8b9XIIdK7NH/VP
 hang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Rhy2L/UJyGdmzgxzSZV4yex5B1vPy4D3Y2E2zfPwvKc=;
 b=IzCX3hWaoqtyYV8VvYo5Pk2wguVKK5xUkiyNLKMSRg8oIuZPX0QnP9vVHUUnwv2aLo
 LsrAj54ySTzhbVNzson/VeRIHrR9ncuiPK4PJ7DVniOMLNwWVZwsp+W/3AWvt21MFAHa
 b0v6XWUtHownT7ZO5DqzN5sGZmQmCCUIuj6IfQwFVRWk1BYSxkHY6LsGJpWHhhebM+1e
 KgUuTIUJ5KCaWMPGK8H2r8R6mdj3zVF996URMu3780ot3hoh2vt4r/HPC9HLz7pUSS0g
 PqjRk2Lk6rd9kZDsosi5z6cIIIkbHj1rmc3n2lMcvjXd3m4fJ1+fsOeGvPMkW8QDSyoG
 9Ttg==
X-Gm-Message-State: AOAM532RVcofp56vkwCBQd7dFydhZ0H9GEtclIXhzXoqAQzoFOIQAwrl
 rcgepAiMBYHMlBoyFFjqcmY=
X-Google-Smtp-Source: ABdhPJwEPMW1iETE4h62Hi/R+Z0sfxkFy6UHtUyen9/Vrs1PRvkaETbrRiG9HfufNArH7y7CJlnUTQ==
X-Received: by 2002:a17:90b:882:: with SMTP id
 bj2mr1618559pjb.122.1591342817292; 
 Fri, 05 Jun 2020 00:40:17 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id y23sm7446619pje.3.2020.06.05.00.40.16
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 05 Jun 2020 00:40:16 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 3/4] riscv: Generalize CPU init routine for the imacu CPU
Date: Fri,  5 Jun 2020 00:38:26 -0700
Message-Id: <1591342707-9729-3-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1591342707-9729-1-git-send-email-bmeng.cn@gmail.com>
References: <1591342707-9729-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

There is no need to have two functions that have almost the same
codes for 32-bit and 64-bit imacu CPUs.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 target/riscv/cpu.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e66488f..c5c2abc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -142,23 +142,23 @@ static void rvnn_gcsu_priv1_10_0_cpu_init(Object *obj)
     set_resetvec(env, DEFAULT_RSTVEC);
 }
 
-#if defined(TARGET_RISCV32)
-
-static void rv32imcu_nommu_cpu_init(Object *obj)
+static void rvnn_imacu_nommu_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
-    set_misa(env, RV32 | RVI | RVM | RVC | RVU);
+    set_misa(env, RVXLEN | RVI | RVM | RVA | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
-    set_resetvec(env, 0x8090);
+    set_resetvec(env, DEFAULT_RSTVEC);
     qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
 
-static void rv32imacu_nommu_cpu_init(Object *obj)
+#if defined(TARGET_RISCV32)
+
+static void rv32imcu_nommu_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
-    set_misa(env, RV32 | RVI | RVM | RVA | RVC | RVU);
+    set_misa(env, RV32 | RVI | RVM | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
-    set_resetvec(env, DEFAULT_RSTVEC);
+    set_resetvec(env, 0x8090);
     qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
 
@@ -171,17 +171,6 @@ static void rv32imafcu_nommu_cpu_init(Object *obj)
     qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
 
-#elif defined(TARGET_RISCV64)
-
-static void rv64imacu_nommu_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    set_misa(env, RV64 | RVI | RVM | RVA | RVC | RVU);
-    set_priv_version(env, PRIV_VERSION_1_10_0);
-    set_resetvec(env, DEFAULT_RSTVEC);
-    qdev_prop_set_bit(DEVICE(obj), "mmu", false);
-}
-
 #endif
 
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
@@ -587,12 +576,12 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #if defined(TARGET_RISCV32)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32imcu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rvnn_imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rvnn_gcsu_priv1_10_0_cpu_init),
 #elif defined(TARGET_RISCV64)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rvnn_imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rvnn_gcsu_priv1_10_0_cpu_init),
 #endif
 };
-- 
2.7.4


