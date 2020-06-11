Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69826C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 01:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B832078D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 01:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwsC4XkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B832078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjBjP-000635-DG
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 21:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jjBiP-0004hC-Q1; Wed, 10 Jun 2020 21:09:09 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41888)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jjBiO-0001Q0-Vi; Wed, 10 Jun 2020 21:09:09 -0400
Received: by mail-pl1-x642.google.com with SMTP id y17so1658046plb.8;
 Wed, 10 Jun 2020 18:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1hEXCyP+d0AS0Gz8RWRlFluIJ/Algo1zWunX4XIw82E=;
 b=bwsC4XkVfB60893zqr1Um2YbMe3AvBzkLxark9i0pt0cmizNtPpHQHQZDGH1WvMlp3
 sGdoN57oFe/IfPRK+i6f0wC4QGT/Y82ortQa+qTIRa6NTwkQ2Fru93YoL+CtMFavqkXD
 fPRF8KatSlyhuox59lVRf3Cvt9gTUWRUC3fhJVxFWIn4JoVDiBwvSis+tjRisprmTpdh
 mM79eZWiRTrTseXxSRr7N7GR7CedDxCEVS8b7exs3X7p0Ibb96XD3oaMXKtsYJgedJzn
 fIdf8j9VV7clL2OSIrBlFnHMtqtj168P7oZRuQsXR678E3dNSF52jWo2wBMtcjBF2Jxy
 4hsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1hEXCyP+d0AS0Gz8RWRlFluIJ/Algo1zWunX4XIw82E=;
 b=YRIADxH6UpT4YFPzAHNz7mI8lkYe7wqQt99kQtQcotQnjFylpq3Id8wdqgQi52yeup
 TJ6fnXypr3j84Fjj45uNQTuWm1iEPPbq0l/0BzTkmphY7Mn/iclMSHocRMwH7Yzp7Gnp
 /FMibfaMvcGMSIrEwaY+8af1tA0J1dGRT7fKyo/0Hll+e8DV+0ZydrgmK0ZWg8DDpkJv
 ajB7J6tIkcEY9eHeChIRtGgsaxeX8OUw43Cjm0ERRCWyGlTi+bKgwYQxq8iuBrTU9Glo
 VVFitkicoUMHndzoy3FtutSdxzpwkGQlo+e0g1YEnmG39JsXzwolDQyJT6Ck4AA0s5MP
 lhVw==
X-Gm-Message-State: AOAM5319cEO+E33hq7yMM5e53oHaldmMjg+1oogwbALdqXiLJxjOa2Hs
 nTPfzVIFBqG/fNPCPXOKKaQ=
X-Google-Smtp-Source: ABdhPJx/QnRvSipInJa5s5/1onEj8vyIkK4io2frLvLdCPPl0mLjCRhxQMa5mfaZlj5rFodQdZob8A==
X-Received: by 2002:a17:902:6906:: with SMTP id
 j6mr5359397plk.261.1591837735691; 
 Wed, 10 Jun 2020 18:08:55 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id i67sm1091721pfb.82.2020.06.10.18.08.54
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 10 Jun 2020 18:08:55 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 2/4] riscv: Generalize CPU init routine for the gcsu CPU
Date: Wed, 10 Jun 2020 18:08:47 -0700
Message-Id: <1591837729-27486-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1591837729-27486-1-git-send-email-bmeng.cn@gmail.com>
References: <1591837729-27486-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
codes for 32-bit and 64-bit gcsu CPUs.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v2:
- Change the function names to rvxx_*

 target/riscv/cpu.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 81cdea8..437e141 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -134,16 +134,16 @@ static void riscv_base_cpu_init(Object *obj)
     set_resetvec(env, DEFAULT_RSTVEC);
 }
 
-#if defined(TARGET_RISCV32)
-
-static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
+static void rvxx_gcsu_priv1_10_0_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
-    set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
+    set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
 }
 
+#if defined(TARGET_RISCV32)
+
 static void rv32imcu_nommu_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -173,14 +173,6 @@ static void rv32imafcu_nommu_cpu_init(Object *obj)
 
 #elif defined(TARGET_RISCV64)
 
-static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
-    set_priv_version(env, PRIV_VERSION_1_10_0);
-    set_resetvec(env, DEFAULT_RSTVEC);
-}
-
 static void rv64imacu_nommu_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -599,11 +591,11 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32imcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rvxx_gcsu_priv1_10_0_cpu_init),
 #elif defined(TARGET_RISCV64)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64gcsu_priv1_10_0_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rvxx_gcsu_priv1_10_0_cpu_init),
 #endif
 };
 
-- 
2.7.4


