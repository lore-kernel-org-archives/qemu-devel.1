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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FB1C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 01:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C65320801
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 01:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkoiJ8HZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C65320801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjBjP-00060y-Ks
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 21:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jjBiR-0004if-NU; Wed, 10 Jun 2020 21:09:11 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38019)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jjBiQ-0001QF-RY; Wed, 10 Jun 2020 21:09:11 -0400
Received: by mail-pl1-x644.google.com with SMTP id m7so1659353plt.5;
 Wed, 10 Jun 2020 18:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uci8H9IuXrjHdaxNTQi8zazVwSMslcvEd1O/odVItsY=;
 b=tkoiJ8HZZxgVVolA955O7Cf3idFyyLtyV8cds4gcKKLdAppfJgTSYWymcnBAHFc/q/
 QTb7ZOSSnKng1Q0tQvUtGjzFeAY77jEva2xsfIhleALpFfzXdTwQ5Wyb0nsnHbbxEb68
 jTn9dZXBi7px3NOLGz95dYT4zT/XmwOSJD3bu9BlrswuJTPUJTwpZiNLROTIEmQ3aEqj
 Vk6HaRsVW8to4yx5kR/HtUJg4GFct2hnePx0fGLgS+acaAJVTy1/pwkn4Ydb5PB3/cfS
 oJm/UXZKlF18uKz/o8dzNoHvX+7aHZ8wp/D+8qFBuCQ5vcS9hLvkflo4spYSpfS7Bsqu
 5m/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=uci8H9IuXrjHdaxNTQi8zazVwSMslcvEd1O/odVItsY=;
 b=tyIoDUc01k6HjP8n8FumYIBXMC9crVopJ/OiJeA7XerhZTjRS4EO+W/J0+OQGMrGx1
 0hT7owlgIbkM/omI8c/oPDeYGRUmMTgFharpndgoLtKDXdPnArozve6PrB0/TfwSv9Zn
 lwCVAa0xol1cWDxmDnoGxYOzmJeGD+xhZPLjtqRYuCpfzS+RxdjCXn37cVJv1lD02e05
 j0xske7eWr669lIo7w8C8ZwPxgLsRXXfW0rqiF7+q85MYsdMxDpFFA8N8LMtXfXgetlW
 yiWFLgZ44/9k7rXjUfs9wRpOOKuh9Zr2nSWlEa8BgWhbmX+FSOKLGf5iXlIM7ZoNhepC
 RjMQ==
X-Gm-Message-State: AOAM531fh1CsaIfgTkySrCkMHJO4VYT7TsbWII+MDuXeHXGupAaGNk2+
 6UwGiGsmzes4yD2JV9n1IDs=
X-Google-Smtp-Source: ABdhPJzWIrb2ROxSdTjyvQodjfsD6XLX5RUC2ywe/1Fj2UfOPoqsWD8EFtE1DjVqL8KIslUkP5u0hA==
X-Received: by 2002:a17:90a:1b87:: with SMTP id
 w7mr5515293pjc.177.1591837736970; 
 Wed, 10 Jun 2020 18:08:56 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id i67sm1091721pfb.82.2020.06.10.18.08.55
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 10 Jun 2020 18:08:56 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 3/4] riscv: Generalize CPU init routine for the imacu CPU
Date: Wed, 10 Jun 2020 18:08:48 -0700
Message-Id: <1591837729-27486-3-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1591837729-27486-1-git-send-email-bmeng.cn@gmail.com>
References: <1591837729-27486-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pl1-x644.google.com
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
codes for 32-bit and 64-bit imacu CPUs.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v2:
- Change the function names to rvxx_*

 target/riscv/cpu.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 437e141..35a8c78 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -142,23 +142,23 @@ static void rvxx_gcsu_priv1_10_0_cpu_init(Object *obj)
     set_resetvec(env, DEFAULT_RSTVEC);
 }
 
-#if defined(TARGET_RISCV32)
-
-static void rv32imcu_nommu_cpu_init(Object *obj)
+static void rvxx_imacu_nommu_cpu_init(Object *obj)
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
@@ -589,12 +578,12 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #if defined(TARGET_RISCV32)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32imcu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rvxx_imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rvxx_gcsu_priv1_10_0_cpu_init),
 #elif defined(TARGET_RISCV64)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rvxx_imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rvxx_gcsu_priv1_10_0_cpu_init),
 #endif
 };
-- 
2.7.4


