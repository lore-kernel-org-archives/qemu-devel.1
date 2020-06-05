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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F471C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB60B207D3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViXZYsLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB60B207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh71l-0002Pj-1z
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 03:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jh6xg-00021q-Rh; Fri, 05 Jun 2020 03:40:20 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jh6xf-00051k-Us; Fri, 05 Jun 2020 03:40:20 -0400
Received: by mail-pf1-x443.google.com with SMTP id x22so4540797pfn.3;
 Fri, 05 Jun 2020 00:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vcP7RRzMN1n+TntOOlFnQ40+IETKMI/NwMkd44061Kg=;
 b=ViXZYsLnz3vv1YdBqkIPspHiLwlFIMzUDYIERzWz5+yT5jiSpGCzRaVvdM/VUIHYlt
 UsZ7KIERJkuiOV6uTsfPlNQpJCZC56S6XwW22HKw4dMC9BO5BPwPWDvrDe+hUaKpT0fY
 7h6SOIzmDoVc3mUDxaiIxipkS/VHO3lx184gBCXyj0KOtDAVULAd9l2eZOdw52AOsq14
 zkmFwmVzqGgadXExMZxS/zHmbMVcDe1xy5arGkUUC0Zt6RVR95z0SDhDRCq08vLUvpak
 v8pMscoN7+s8nvSTZzq9jYlQIJDKx2TWJeVb0A9421d23jCJ/HWXgno98mrpSzFQ1NEZ
 Wq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vcP7RRzMN1n+TntOOlFnQ40+IETKMI/NwMkd44061Kg=;
 b=j76EDBVdLMiDx1so8PyZh8OjIw0keQUD1YgURAFARIQAguFkC+s/dBNBcDvzpLoIX8
 sYg6QHeiYF/agi3Rkm0on8aMH6Nk6WUO1Hsg0DprpUmOmW9vyg36Clka2IrGP3RB670W
 QEJJfqmB19OAi8X3hRU/ElmV/MLetKtmI2lU7lYwoB0a/ws3coHlThVSb9bYWFOQKEtC
 OMZCghcUij3lM5LlzyMQNb18vtfwYJT+gVpBTAPSAlm5jXQk4zb/Y0A+IcJKgdD46fWr
 c4C/2mHMIJW8b0tyvATzxLtz2la3MXXGJhR4GW5y/ozQ2dxgUm0NJwg8u4boYLLT4mjx
 6M5g==
X-Gm-Message-State: AOAM533g2BAZKqkN42dJbFpe5McOiFYwFcdks0GGKRyGtRCUVa47GZKq
 wHJXX8fEsiWKDS7BMoXDZto=
X-Google-Smtp-Source: ABdhPJz/FfJpk1E2vUlSosZ9t5mAOgxTheO9f4JM/7wugRBE0WAbrOYZbs7dWIS6+8AvWsBma98Cwg==
X-Received: by 2002:a63:7052:: with SMTP id a18mr8223415pgn.39.1591342818312; 
 Fri, 05 Jun 2020 00:40:18 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id y23sm7446619pje.3.2020.06.05.00.40.17
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 05 Jun 2020 00:40:17 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 4/4] riscv: Keep the CPU init routine names consistent
Date: Fri,  5 Jun 2020 00:38:27 -0700
Message-Id: <1591342707-9729-4-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1591342707-9729-1-git-send-email-bmeng.cn@gmail.com>
References: <1591342707-9729-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pf1-x443.google.com
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

Adding a _ to keep some consistency among the CPU init routines.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 target/riscv/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c5c2abc..5060534 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -153,7 +153,7 @@ static void rvnn_imacu_nommu_cpu_init(Object *obj)
 
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
@@ -575,9 +575,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
 #if defined(TARGET_RISCV32)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32imcu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32_imcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rvnn_imacu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32_imafcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rvnn_gcsu_priv1_10_0_cpu_init),
 #elif defined(TARGET_RISCV64)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base_cpu_init),
-- 
2.7.4


