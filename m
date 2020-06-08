Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EE9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C5172053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5K+RYPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5172053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIkH-0006Eh-AN
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIbg-0001Mz-Qp; Mon, 08 Jun 2020 10:18:32 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIbf-0004W5-Oa; Mon, 08 Jun 2020 10:18:32 -0400
Received: by mail-pl1-x641.google.com with SMTP id n9so6731101plk.1;
 Mon, 08 Jun 2020 07:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ahVicGXm+tC5Wu9Y9B8W3IdHq6HS3ZueVU615K0isTk=;
 b=f5K+RYPuJPBNr8klVYgtNsaR5gObqjTrjLiuNYfwLtTmwRSUqZkCEc+XIRDQVVzzMK
 J8p5y7h2ZYV3LqzTfuVW+8tRs14Z2pflKdIqjjGiUm23quyKDCsnx6fg3wCAq/++SN5l
 pH+6GRm4b3n38l5Nag7XixIvgHjdqZw7l+TmlefLcUEo2H5Q7Dv4D28cvTIkv3gvrckm
 nq12dDsJuccrEdDrgJpkLnzO/lRR2XiLTvg3vaMnjs563YpXf+co5WPShhc/8h6u5Zhs
 bMtq342giEWCe1FiajqAFW/YMDP5G5HNWu0oM8o7610/4bPF+yjD2eHFsQc74nrR/VUB
 +gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ahVicGXm+tC5Wu9Y9B8W3IdHq6HS3ZueVU615K0isTk=;
 b=P2adCPfUazVNutt8Z8oGpIUgmP6J24mPz0qJOple1U3KK7ACc7bINRO8fB44Ln53mv
 CFaUBTvrkXXChG8J3CIMoCOWFToFPdss1ovPg99S7XoMjHT4xc4b8kyxynRQ5403dSIP
 FktFVjZz/tbP+E7pPNMTKtFX8WBg5F2GPHJP+HWlrvC1OgBEJCcUeLXxK4hT7edpqPAo
 cu2dqQoblmwgMJVuLoe1dj6LUrxOTKvk8Tup91Vjt0SaU1JTBFH7sdIxQdW2Ru7XIkPH
 DDX0cWt8ufudpJlHw06i2FSxCfH7t5R86cvo8KqAj1fVXJmooPKp4Ft3agnd7qASIyKU
 RDhw==
X-Gm-Message-State: AOAM532eBopCvkeLVR2pkb1uyZOyNKGQXn//k8JhzJK1t6kqJunLOZLQ
 YPBz/9Vv6Lnkwk7A2hxYJDs=
X-Google-Smtp-Source: ABdhPJxXDYtmWS6SqoOsFRdEKX0nkJRXaAh1OPZ8oyK1gPVLkq6F7h8HOr+kVjCPbNu5lAM8OpyaXA==
X-Received: by 2002:a17:90b:3005:: with SMTP id
 hg5mr16838257pjb.215.1591625910171; 
 Mon, 08 Jun 2020 07:18:30 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id b19sm7292575pft.74.2020.06.08.07.18.29
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 08 Jun 2020 07:18:29 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 12/15] hw/riscv: sifive: Change SiFive E/U CPU reset vector to
 0x1004
Date: Mon,  8 Jun 2020 07:17:41 -0700
Message-Id: <1591625864-31494-13-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pl1-x641.google.com
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

Per the SiFive manual, all E/U series CPU cores' reset vector is
at 0x1004. Update our codes to match the hardware.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/sifive_e.c | 8 +++++---
 hw/riscv/sifive_u.c | 6 +++---
 target/riscv/cpu.c  | 4 ++--
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 8fab152..f05cabd 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -98,9 +98,11 @@ static void sifive_e_machine_init(MachineState *machine)
         memmap[SIFIVE_E_DTIM].base, main_mem);
 
     /* Mask ROM reset vector */
-    uint32_t reset_vec[2] = {
-        0x204002b7,        /* 0x1000: lui     t0,0x20400 */
-        0x00028067,        /* 0x1004: jr      t0 */
+    uint32_t reset_vec[4] = {
+        0x00000000,
+        0x204002b7,        /* 0x1004: lui     t0,0x20400 */
+        0x00028067,        /* 0x1008: jr      t0 */
+        0x00000000,
     };
 
     /* copy in the reset vector in little_endian byte order */
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index aaa5adb..0a86ffc 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -433,18 +433,18 @@ static void sifive_u_machine_init(MachineState *machine)
 
     /* reset vector */
     uint32_t reset_vec[8] = {
+        0x00000000,
         0x00000297,                    /* 1:  auipc  t0, %pcrel_hi(dtb) */
-        0x02028593,                    /*     addi   a1, t0, %pcrel_lo(1b) */
+        0x01c28593,                    /*     addi   a1, t0, %pcrel_lo(1b) */
         0xf1402573,                    /*     csrr   a0, mhartid  */
 #if defined(TARGET_RISCV32)
         0x0182a283,                    /*     lw     t0, 24(t0) */
 #elif defined(TARGET_RISCV64)
-        0x0182b283,                    /*     ld     t0, 24(t0) */
+        0x0182e283,                    /*     lwu    t0, 24(t0) */
 #endif
         0x00028067,                    /*     jr     t0 */
         0x00000000,
         start_addr,                    /* start: .dword */
-        0x00000000,
                                        /* dtb: */
     };
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5060534..1944ad6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -139,7 +139,7 @@ static void rvnn_gcsu_priv1_10_0_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
-    set_resetvec(env, DEFAULT_RSTVEC);
+    set_resetvec(env, 0x1004);
 }
 
 static void rvnn_imacu_nommu_cpu_init(Object *obj)
@@ -147,7 +147,7 @@ static void rvnn_imacu_nommu_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RVXLEN | RVI | RVM | RVA | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
-    set_resetvec(env, DEFAULT_RSTVEC);
+    set_resetvec(env, 0x1004);
     qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
 
-- 
2.7.4


