Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912C8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 00:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F26A2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 00:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npRk3Kbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F26A2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkzpT-0008Jk-Lk
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 20:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jkzoU-00072W-8a; Mon, 15 Jun 2020 20:50:54 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:54924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jkzoS-0006Hz-Pi; Mon, 15 Jun 2020 20:50:53 -0400
Received: by mail-pj1-x1042.google.com with SMTP id u8so649765pje.4;
 Mon, 15 Jun 2020 17:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Vtcx4S1GPP8c1wwhPLcdjKruiDpr1sKpV2nOfuK2xVs=;
 b=npRk3Kbs0FMB1jK1aqAaobO2/yWJx488tYBy3NY6SeSka0UbXt3TDtsscG3ol8F0Pk
 +7jtnyZnqWfnTL18VF6ttDdc78QLuhQptawn7W4CtRgZmxxa0pjXvMGEaNk6q+4N9GgU
 iiDoUd2PNDTbVS+Niz3LvIwCLM8HlNZT8LA1ThgQ4HE1MjIhTAnBp3xmfB1LuC3S7Ex6
 qB2Bk1TnRTt61/6nADBxEo6FAvmaw1zKa2yBaIeZS7uH7V62XkW27FrOce6BCpMmvziz
 kizl8n17IleXf0S86APvRd5JCS342t91qH9BFl9zuWglaHOneP8F7eyjEK6Ps8VbG7w2
 ztYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Vtcx4S1GPP8c1wwhPLcdjKruiDpr1sKpV2nOfuK2xVs=;
 b=Np0teNmsPzP2O9yB3P/DYB7u5t+ODb5lxLMtw/cf4u4BEui0O6HwBm7cJ27DKJ1V1A
 vV03uL2L5OmFMiJXk/RMUqDZpOptaY5OwpY63jebzQe0DvJqntx5sT7wh0OVHWmpkdUy
 5i035k5zr/O3vMwLbF7g0r5eQbnJYo50dCQ0Yx6oRSwIqm8SYUcj1PQ62Ea54Dgb3w5G
 y66gIcHISQcjLNsbk0hOPMdTXkm1Gv2FAavjXXNxEl4Nks7j/Es98ruCkgTP9jIYXtzA
 GAccT1lZyRSWcWRDLz4TUc485nwxVB0XnlOrOrYt3PLIHn2XWXsgc7z+u7ja6UNyjP4g
 pvRQ==
X-Gm-Message-State: AOAM5314eI+HXtuqiEG5Na6skHW/292zktk0REYz8Y8tNpQoSgD1Vdol
 a0WWJpgh2Oh7uhbiUh8n2eg=
X-Google-Smtp-Source: ABdhPJz3caIVl/52v0C0mUIa8L83ghSlVgcl44RUSjnS9F2TvL9f4hCI0tQCylPLht9OuhT6UoEWmw==
X-Received: by 2002:a17:90a:2683:: with SMTP id
 m3mr305335pje.196.1592268651224; 
 Mon, 15 Jun 2020 17:50:51 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id i20sm15210539pfd.81.2020.06.15.17.50.50
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 15 Jun 2020 17:50:50 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 1/5] target/riscv: Rename IBEX CPU init routine
Date: Mon, 15 Jun 2020 17:50:37 -0700
Message-Id: <1592268641-7478-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592268641-7478-1-git-send-email-bmeng.cn@gmail.com>
References: <1592268641-7478-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1042.google.com
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

Current IBEX CPU init routine name seems to be too generic.
Since it uses a different reset vector from the generic one,
it merits a dedicated name.

Signed-off-by: Bin Meng <bin.meng@windriver.com>

---

Changes in v2:
- new patch: Rename IBEX CPU init routine

 target/riscv/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e867766..5f03458 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -153,7 +153,7 @@ static void rvxx_imacu_nommu_cpu_init(Object *obj)
 
 #if defined(TARGET_RISCV32)
 
-static void rv32_imcu_nommu_cpu_init(Object *obj)
+static void rv32_ibex_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV32 | RVI | RVM | RVC | RVU);
@@ -577,7 +577,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
 #if defined(TARGET_RISCV32)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32_imcu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32_ibex_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rvxx_imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32_imafcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rvxx_gcsu_priv1_10_0_cpu_init),
-- 
2.7.4


