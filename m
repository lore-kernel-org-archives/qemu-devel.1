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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DDBC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8294A207D3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCfkRX2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8294A207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh70N-00078v-LR
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 03:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jh6xe-0001xG-Ti; Fri, 05 Jun 2020 03:40:18 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35060)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jh6xe-0004zA-2D; Fri, 05 Jun 2020 03:40:18 -0400
Received: by mail-pg1-x544.google.com with SMTP id o6so4782593pgh.2;
 Fri, 05 Jun 2020 00:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tib5h16t63KQQfVBSFiE6JLJlg8hBo2UFPC9qCjD2Cc=;
 b=dCfkRX2UuycFayEHgdnTYPdEJeHJ5QUbjIfGJ8CfMf6sqHyuKKcSET40339CCoeM5Y
 uCMG/ckcM9VVljSrwlinAJgsxdp7/ZRvM9InIKHGZtfc84HQ14qAbgj+zX3puU8Ik8Fz
 7CXeCzQr0j8s1TUkN/J0gz3AH5xFIBFrv0pdNUHUmcPePE8I/9/EQe0EDM9ozIoMVdss
 FK6K71SNW1jkyqxtxwpa3GYBnuhvkB7zANooNQK8P+ft2jwH6iUL7FHj9EZwXNwQEbl4
 D+HG4BFCRoZ/XHhP21qFkyvnaTASwoyOMVWFe8Tg5WR53BSamAbpcplp5rrWqguDBJFa
 n7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tib5h16t63KQQfVBSFiE6JLJlg8hBo2UFPC9qCjD2Cc=;
 b=WR3xawZN6gJdHxGabGaMrEYA85pLKYkplFMj9pANAOTQmUQuEuKEYMxN4fRT+Wtmk9
 /RUeFFt7JeJUyEiJudvv40qW1yUrcn9u7pkztDSDHYY49G4HadbpaRU0sNTtoiMIY2Vo
 tZ7AhJa91LN/fBA84FNmchG5HW3pcoRcXdDv5xxY5vH6dyDGyWC0pu63G4InkHKNV01C
 3GJ6lh4iLLqKAn9zQ+VXwxerdO4jP+td90phfOXdA+77zXWKSOnxspApsmNMRV5WM6h6
 n0ap1nWyLbCEXPb+SsNbbWw+lnyT3WXFXyfdBr2Lj39JQoAlexF13ZwV0fhWdA2nTFmn
 vwfw==
X-Gm-Message-State: AOAM533Ot5wOVrcH1sj3pxjvv0l6Hgwk3F9zXFppgWioI6EHKu2TCT7v
 eL7Uws2e4vbuiEVjuNRg/+A=
X-Google-Smtp-Source: ABdhPJxg+pjwjO2/6ykp1GacqGc0TD6mpxubhaIpSoPCZORRvfT1asbtQIBYSlNi/7x3mDvBdtREOQ==
X-Received: by 2002:a63:1348:: with SMTP id 8mr8206263pgt.8.1591342816195;
 Fri, 05 Jun 2020 00:40:16 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id y23sm7446619pje.3.2020.06.05.00.40.15
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 05 Jun 2020 00:40:15 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 2/4] riscv: Generalize CPU init routine for the gcsu CPU
Date: Fri,  5 Jun 2020 00:38:25 -0700
Message-Id: <1591342707-9729-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1591342707-9729-1-git-send-email-bmeng.cn@gmail.com>
References: <1591342707-9729-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x544.google.com
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
codes for 32-bit and 64-bit gcsu CPUs.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 target/riscv/cpu.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d38d829..e66488f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -134,16 +134,16 @@ static void riscv_base_cpu_init(Object *obj)
     set_resetvec(env, DEFAULT_RSTVEC);
 }
 
-#if defined(TARGET_RISCV32)
-
-static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
+static void rvnn_gcsu_priv1_10_0_cpu_init(Object *obj)
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
@@ -597,11 +589,11 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32imcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rvnn_gcsu_priv1_10_0_cpu_init),
 #elif defined(TARGET_RISCV64)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64gcsu_priv1_10_0_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rvnn_gcsu_priv1_10_0_cpu_init),
 #endif
 };
 
-- 
2.7.4


