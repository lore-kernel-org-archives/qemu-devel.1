Return-Path: <SRS0=zX6u=BS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915D2C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:09:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E102053B
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC9BPd3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E102053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4Oat-0001do-MZ
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 09:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan.lee.qnl@gmail.com>)
 id 1k4KsY-0000l1-MB; Sat, 08 Aug 2020 05:11:02 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:40717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ethan.lee.qnl@gmail.com>)
 id 1k4KsW-0000c8-9P; Sat, 08 Aug 2020 05:11:02 -0400
Received: by mail-pj1-x1041.google.com with SMTP id d4so2231180pjx.5;
 Sat, 08 Aug 2020 02:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZQ4wkJR7VVNblB+G2e/NZ21j2c8KfW3THWxKkfwdtAw=;
 b=PC9BPd3PwbPGf+qQvhYp2FBMAhVrZzjIIUTg5bMgguc2/uhGAgAv6VCgBGxiN/4tOq
 klGeJ/3ORPGbXWAmIQedOU6dssoTLg1QBRYdgQAIeZqNaW/ldbOSwOxQKnbcmGV+lryM
 xZ/ovI4vwff1qVIxh2BsUk7xZr3U2oxlgG0mUL40I/9Ro7ijyCqFLxxeORj/XnbCD+Jl
 z/Oem4f7ZKmWIGR/OQcw0TugSRdo65ImAHviAcyWMbu2orp/fdCRbQSfluKGYo77T9fJ
 L2QJwMDBozUZXw5c+08nIIQne7wXgDOM2SFJb/5RsgedQQxcj/zN6q3ezB7y9KxOXsRq
 sxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZQ4wkJR7VVNblB+G2e/NZ21j2c8KfW3THWxKkfwdtAw=;
 b=WbiIsFfh2OwkSu5QGIQOb7XGfUdQAyt9mlwjKCSgjRhm/rl25Yh4bKnkvXO1N0AxBs
 uAtddNjU+cs8qNmUKeo1IO3aWGCMs1mGFGHFiZM7RkBH0jmbgWUjRsNfg9XXTNh178GU
 G2qvqIhLdn4p+/ev/X6fsXdtp7nipgmgxoPqltLQaMKU7YtvuGicRobU4W3wQ0dRIh81
 FO65rOBXrA/nl7B5rJy3I6Yu3hD0R/GGyFT9ONkAMOc0iffNCpN4J1xngbIpHb2bp+9n
 ZzNcg8sfeLaCF83MHcGNdcMbiQ0MdJA/fFZ3S+SUj6S2oKPVHn6RgseA2EQML5Vfx5+P
 s0Mg==
X-Gm-Message-State: AOAM530cucPbfSH6PPmB0VBbNXpUZYUr7y3UaYwffHUTTElUk/0rcajX
 seKOM1tiZNbPTK3W9fI6j91RMO4UIXtYYA==
X-Google-Smtp-Source: ABdhPJzKHW2N9VyR2MzCX7L5LU5MliDKksICKxhZsiUiSUNdYvE0gZllyfxXWLq9jQpMdVGoDKogVw==
X-Received: by 2002:a17:90b:124e:: with SMTP id
 gx14mr18033376pjb.225.1596877858527; 
 Sat, 08 Aug 2020 02:10:58 -0700 (PDT)
Received: from localhost.localdomain (183178047145.ctinets.com.
 [183.178.47.145])
 by smtp.gmail.com with ESMTPSA id i11sm13312700pjv.30.2020.08.08.02.10.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Aug 2020 02:10:58 -0700 (PDT)
From: Hongzheng-Li <ethan.lee.qnl@gmail.com>
X-Google-Original-From: Hongzheng-Li <Ethan.Lee.QNL@gmail.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/4] Add a config option for ePMP.
Date: Sat,  8 Aug 2020 17:09:50 +0800
Message-Id: <20200808090950.13-5-Ethan.Lee.QNL@gmail.com>
X-Mailer: git-send-email 2.24.1.windows.2
In-Reply-To: <20200808090950.13-1-Ethan.Lee.QNL@gmail.com>
References: <20200808090950.13-1-Ethan.Lee.QNL@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=ethan.lee.qnl@gmail.com; helo=mail-pj1-x1041.google.com
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
X-Mailman-Approved-At: Sat, 08 Aug 2020 08:59:47 -0400
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
Cc: Hou Weiying <weiying_hou@outlook.com>, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, Hongzheng-Li <Ethan.Lee.QNL@gmail.com>,
 Alistair.Francis@wdc.com, palmer@dabbelt.com,
 Myriad-Dreamin <camiyoru@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hou Weiying <weiying_hou@outlook.com>

Add a config option to enable experimental support for ePMP. This
is disabled by default and can be enabled with 'x-epmp=true'.

Signed-off-by: Hongzheng-Li <Ethan.Lee.QNL@gmail.com>
Signed-off-by: Hou Weiying <weiying_hou@outlook.com>
Signed-off-by: Myriad-Dreamin <camiyoru@gmail.com>
---
 target/riscv/cpu.c | 9 +++++++++
 target/riscv/cpu.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 059d71f2c7..79fa9d3c2f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -407,6 +407,14 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 
     if (cpu->cfg.pmp) {
         set_feature(env, RISCV_FEATURE_PMP);
+
+        /*
+         * Enhanced PMP should only be available
+         * on harts with PMP support
+         */
+        if (cpu->cfg.epmp) {
+            set_feature(env, RISCV_FEATURE_EPMP);
+        }
     }
 
     /* If misa isn't set (rv32 and rv64 machines) set it here */
@@ -509,6 +517,7 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
     DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
     DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
+    DEFINE_PROP_BOOL("x-epmp", RISCVCPU, cfg.epmp, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d0e7f5b9c5..afdc9fa2bf 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -77,6 +77,7 @@
 enum {
     RISCV_FEATURE_MMU,
     RISCV_FEATURE_PMP,
+    RISCV_FEATURE_EPMP,
     RISCV_FEATURE_MISA
 };
 
@@ -202,6 +203,7 @@ struct CPURISCVState {
 
     /* physical memory protection */
     pmp_table_t pmp_state;
+    target_ulong mseccfg;
 
     /* machine specific rdtime callback */
     uint64_t (*rdtime_fn)(void);
@@ -272,6 +274,7 @@ typedef struct RISCVCPU {
         char *user_spec;
         bool mmu;
         bool pmp;
+        bool epmp;
     } cfg;
 } RISCVCPU;
 
-- 
2.20.1


