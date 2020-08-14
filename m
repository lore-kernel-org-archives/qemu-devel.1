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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5A1C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40A8D20829
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7hl98eI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A8D20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6cmv-0001Gg-Dd
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 12:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k6clb-0006y5-OR; Fri, 14 Aug 2020 12:41:19 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k6clZ-0002d5-5S; Fri, 14 Aug 2020 12:41:19 -0400
Received: by mail-pl1-x643.google.com with SMTP id f10so4412695plj.8;
 Fri, 14 Aug 2020 09:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xaCbEcQNVinUp7yjQHa/3V60LKlx1/zzDfks3aE0/Gk=;
 b=j7hl98eICtaliygiUKYqTV0f+mXMkv2NQ5fK5NdV7CNli0p6hcpjLum22eBv0o0FhA
 W+FBxQItVvRbRURqFrhUefesRWINQ8isB5atojfsqQOtNhnWU4xsDRdymQa5a3D8ODw2
 twg90FxTJM9R10ZNM3m09ou24fekb1SHbt0jL1mPrG+mTlHsPS8j22+gPbN5xnz6NX+F
 KPOG7QnoP5Y8LQdSdLcQup3k74dfmxE+Cp0lVwE/mgIL9NpwymxyEYmQH+OZgqz27+5t
 t+Cp8JpT0elqRsJHMm+OdK5liuk63+t63okLyxDkeNBeqsYGkVWOzBus+HEa7agLaRnL
 2LlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xaCbEcQNVinUp7yjQHa/3V60LKlx1/zzDfks3aE0/Gk=;
 b=RmDcQXNgP9rM1wL4OBlYRqnRjnGb2E654Q2QbVWO7/89EkWQZ8iTvSRSZLR7DyFyyS
 Ais/eGers8inEeHvdXI/f+IaGTWMN/p9hGnQL0C/AW85euBl0SCAQ8d6U56kPVt/DrSC
 6HazhSS3tz4/bHXtZRLRbNqqZdojEDHkXAvxb8HWkY9+N++tyv09XYsiRTUlD2GmWoBp
 VcjoDMRkjceVbma6D6bROXB4NXiAlM6hEDRYnz3L1yPlKaqghVPQlfiYpya4ZXAqXoUM
 CR334R/BaIMDhiscAMOyTxmAR7rN65zrhy09Vy9QlimdG+2Dwt5vonDa+4hMu4qqb+Bu
 ZEjg==
X-Gm-Message-State: AOAM53071+tL8JCFdgXYeUuiJ2ROqnng/2zWJ6Si/vAhtx9OG6oW3aa5
 5utcKZKamoSNw8nf3KLS7rY=
X-Google-Smtp-Source: ABdhPJyaacMhZVvO0SvlEjI8nLtLi1pKhj6zmA1jEg7Ni4Xw4mxItvIaHdcZhuafH95Gci7PY+4O+Q==
X-Received: by 2002:a17:902:be12:: with SMTP id
 r18mr2543010pls.116.1597423275293; 
 Fri, 14 Aug 2020 09:41:15 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id 16sm9836332pfi.161.2020.08.14.09.41.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Aug 2020 09:41:14 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 02/18] hw/riscv: hart: Add a new 'resetvec' property
Date: Sat, 15 Aug 2020 00:40:40 +0800
Message-Id: <1597423256-14847-3-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
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

RISC-V machines do not instantiate RISC-V CPUs directly, instead
they do that via the hart array. Add a new property for the reset
vector address to allow the value to be passed to the CPU, before
CPU is realized.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/riscv_hart.c         | 3 +++
 include/hw/riscv/riscv_hart.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index f59fe52..613ea2a 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -31,6 +31,8 @@ static Property riscv_harts_props[] = {
     DEFINE_PROP_UINT32("num-harts", RISCVHartArrayState, num_harts, 1),
     DEFINE_PROP_UINT32("hartid-base", RISCVHartArrayState, hartid_base, 0),
     DEFINE_PROP_STRING("cpu-type", RISCVHartArrayState, cpu_type),
+    DEFINE_PROP_UINT64("resetvec", RISCVHartArrayState, resetvec,
+                       DEFAULT_RSTVEC),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -44,6 +46,7 @@ static bool riscv_hart_realize(RISCVHartArrayState *s, int idx,
                                char *cpu_type, Error **errp)
 {
     object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx], cpu_type);
+    qdev_prop_set_uint64(DEVICE(&s->harts[idx]), "resetvec", s->resetvec);
     s->harts[idx].env.mhartid = s->hartid_base + idx;
     qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
     return qdev_realize(DEVICE(&s->harts[idx]), NULL, errp);
diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h
index c75856f..77aa4bc 100644
--- a/include/hw/riscv/riscv_hart.h
+++ b/include/hw/riscv/riscv_hart.h
@@ -37,6 +37,7 @@ typedef struct RISCVHartArrayState {
     uint32_t num_harts;
     uint32_t hartid_base;
     char *cpu_type;
+    uint64_t resetvec;
     RISCVCPU *harts;
 } RISCVHartArrayState;
 
-- 
2.7.4


