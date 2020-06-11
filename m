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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E225DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 01:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A73D72078D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 01:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXgjnfiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73D72078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjBjB-0005w0-Vn
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 21:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jjBiP-0004h3-71; Wed, 10 Jun 2020 21:09:09 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34854)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jjBiO-0001Pu-BE; Wed, 10 Jun 2020 21:09:08 -0400
Received: by mail-pg1-x542.google.com with SMTP id s135so1111629pgs.2;
 Wed, 10 Jun 2020 18:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=kCKmh/06dTpZ4YQTxAm7HevYPRzYG787xaPPyASE+L4=;
 b=kXgjnfiJbeg4lQEd5xVSIgMZJCwkW1IwpJ+tHvu4uQ421sTILnI8HBaeyvFhK7slBU
 4DsgbkIq+zPosyQsfOsoQutGZSOn9nffv7RmBAbertvRR/FLYm0Xer6t7ORt9ZmNF0TF
 6OqiJEuxmzT5hDPXb3+TzTa4m3MDg4f54Kfr90cuRR/9YI4b5lNfAy3y9rpnF9Y6l/A3
 kPlNz3zoLfQ2SsdCNsiI2dJvZgPGU4zxmvFLGUuBwCaonh5PY2czWlcou+ASZklFaEcW
 bV4iEutpVo0Mwlec5a9TlPPJZBUpoB1q9FjI6rYyXi7RsH3qS3TbH0U9e1ZSWf2Yqmud
 Hslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=kCKmh/06dTpZ4YQTxAm7HevYPRzYG787xaPPyASE+L4=;
 b=FMtzJ22cOw3GGVHvlMieNA4tqS115D9newy9+nWo63zqVcrrfATWzIf0vpLPawe/8C
 rMPFxVZfkpgdfsAEywOIeSqOZDc95c07LR+QdQhMDKdcFLShOBRgIkDFA+LvQHlyGND5
 fQ+yIZu3wAh8h0Y6eJnNGckYGBiVWezDazHRApsPu3qVn7cniuYI5eu0UTj2JAUEcstV
 ITfspdUamp4DkN2oETIF7w3d0LZCGsvP/B0pAJv8dmP29EAO6PtgFlczMpKuGcZd1JIH
 DLbi3BkDDPF3wisgY/Rs92HsK+PlenbSGILHw+CPWSowcbsi0WBUEOHWSzD1ygq3WxC0
 jeZA==
X-Gm-Message-State: AOAM530gLinp4NrOlaspmZyWMRGhUJ9cQZdgTEJkz9C1n7W2EtiHrRLu
 rcI7R3xrm2UIOOqW4txBuEs=
X-Google-Smtp-Source: ABdhPJx4FAatdnHLMLap9Qpu6aFlV8e/sea1hGzjzsFb71LJaSZ8ViW2oxkpz/Hnb244+0yDR0BgMw==
X-Received: by 2002:a05:6a00:1592:: with SMTP id
 u18mr855601pfk.26.1591837734772; 
 Wed, 10 Jun 2020 18:08:54 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id i67sm1091721pfb.82.2020.06.10.18.08.53
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 10 Jun 2020 18:08:54 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 1/4] riscv: Generalize CPU init routine for the base CPU
Date: Wed, 10 Jun 2020 18:08:46 -0700
Message-Id: <1591837729-27486-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x542.google.com
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

There is no need to have two functions that have exactly the same
codes for 32-bit and 64-bit base CPUs.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

(no changes since v1)

 target/riscv/cpu.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3a6d202..81cdea8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -126,9 +126,7 @@ static void riscv_any_cpu_init(Object *obj)
     set_resetvec(env, DEFAULT_RSTVEC);
 }
 
-#if defined(TARGET_RISCV32)
-
-static void riscv_base32_cpu_init(Object *obj)
+static void riscv_base_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     /* We set this in the realise function */
@@ -136,6 +134,8 @@ static void riscv_base32_cpu_init(Object *obj)
     set_resetvec(env, DEFAULT_RSTVEC);
 }
 
+#if defined(TARGET_RISCV32)
+
 static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -173,14 +173,6 @@ static void rv32imafcu_nommu_cpu_init(Object *obj)
 
 #elif defined(TARGET_RISCV64)
 
-static void riscv_base64_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    /* We set this in the realise function */
-    set_misa(env, 0);
-    set_resetvec(env, DEFAULT_RSTVEC);
-}
-
 static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -603,13 +595,13 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     },
     DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
 #if defined(TARGET_RISCV32)
-    DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base32_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32imcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init),
 #elif defined(TARGET_RISCV64)
-    DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base64_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64gcsu_priv1_10_0_cpu_init),
 #endif
-- 
2.7.4


