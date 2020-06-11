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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656E5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 01:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24F2820747
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 01:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw/L3KQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F2820747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjBlE-0008De-D4
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 21:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jjBiS-0004jm-9n; Wed, 10 Jun 2020 21:09:12 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:46718)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jjBiR-0001QI-FQ; Wed, 10 Jun 2020 21:09:11 -0400
Received: by mail-pl1-x643.google.com with SMTP id n2so1644745pld.13;
 Wed, 10 Jun 2020 18:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tmawgWa+r5d+HKAE4Rj25zpLbu/ZFp/IN3GuO+vLsjg=;
 b=Hw/L3KQ7/ItZ0jE4GwhaF+QcpXyYdIeueApbRbveMRkixNmiG//4sZCtPDn2QBXdgB
 OgI65vs23B/G74uw2iCBFG30IQehCKRhbDt+s5wJGhaq4B5U4galygax7b9jqenJ4775
 JBrI8BfyDlqw8LsJKpjiLSHKTP9OHmbgqJrmbLVN3eOWb84Q1kI8I3BcOYUgakLgk+/c
 FCLdQIQ6eSbYy4T38FDdlH6zGvLosBeXeTljT1eRD1kDCNiabUxK/TXpM3t6xewm4qK3
 XFj19rCBkHyud38MXMKzE1GP330kz6NI4AmEdBW05FN/cJLSIteCwgucuSHM1iidsGuB
 OlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tmawgWa+r5d+HKAE4Rj25zpLbu/ZFp/IN3GuO+vLsjg=;
 b=AlzWY6/LFWbA0pGnMlnq9Ee09Xvg1ElnOpIb8wkEdEh/byFCkKi56P4fJ8eia/Ld0b
 IBs8ola9ULa7NnLLosZWEd0ymRAVfFnkRxKhnBcgwi+pBFqpL/QUXKIrjl1EAj3CdQp4
 FM9j4uZHupHckWIw2NdNUkZamP7DnlW1F+OmilaPRPGjkiJ2zA329pe6fnhOU7AdDnBh
 bjdaiQ3ECqdmqnxO3SHJn/aPO74fo2GQ/GrC788DNPAiZU4w1FXEbXvEvC65SC7FpZIl
 FUGh8HMm5vGAW6ybnkqTuAfWHChbD3447iEV65HsesBcDDsySfexWRwrPdTwcxAeNR/Q
 Lbdg==
X-Gm-Message-State: AOAM533l4BueHeI3N7rA3o74U2PkwvH3ALYoos7BH2tEh0+cfhM1rV5D
 5R7dHA3o1NYZovywZHJ5iEGg9xmD
X-Google-Smtp-Source: ABdhPJzVYSaVLUB07Qp1SgnHUp982ggghe8F2W7TrEwyHga0sqlygoTCOjGZm8fKDtpTHVLCtq1dwQ==
X-Received: by 2002:a17:90b:190e:: with SMTP id
 mp14mr5501537pjb.198.1591837737921; 
 Wed, 10 Jun 2020 18:08:57 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id i67sm1091721pfb.82.2020.06.10.18.08.57
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 10 Jun 2020 18:08:57 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 4/4] riscv: Keep the CPU init routine names consistent
Date: Wed, 10 Jun 2020 18:08:49 -0700
Message-Id: <1591837729-27486-4-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1591837729-27486-1-git-send-email-bmeng.cn@gmail.com>
References: <1591837729-27486-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pl1-x643.google.com
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

Adding a _ to keep some consistency among the CPU init routines.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

(no changes since v1)

 target/riscv/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 35a8c78..e867766 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -153,7 +153,7 @@ static void rvxx_imacu_nommu_cpu_init(Object *obj)
 
 #if defined(TARGET_RISCV32)
 
-static void rv32imcu_nommu_cpu_init(Object *obj)
+static void rv32_imcu_nommu_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV32 | RVI | RVM | RVC | RVU);
@@ -162,7 +162,7 @@ static void rv32imcu_nommu_cpu_init(Object *obj)
     qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
 
-static void rv32imafcu_nommu_cpu_init(Object *obj)
+static void rv32_imafcu_nommu_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVC | RVU);
@@ -577,9 +577,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
 #if defined(TARGET_RISCV32)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32imcu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32_imcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rvxx_imacu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32_imafcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rvxx_gcsu_priv1_10_0_cpu_init),
 #elif defined(TARGET_RISCV64)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base_cpu_init),
-- 
2.7.4


