Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56236C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B212083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B212083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgv4m-0006BW-GW
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54864)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgukt-0008Q6-9i
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hguko-0000X8-KM
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39249)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hguko-0000Sy-DP
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so3615852pls.6
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 10:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=56FAFtkHihj7lBOpqOA5w6wtEoTrLs+0s6GAeWUEf7s=;
 b=XromaPnYpz/92gH2VPAV31LKRDsNNb2pvlFt9nlysKkQm1qdKH7K1GoaxfQEAznumy
 TKD6KoZLQFGsoZcMrI6ber5RtDcLtudeDeQbyyvgS1ReKHG9Ar57w2LfsjPJkhED21+8
 Vn3VAJocmYn8JgqiSZaAFvlvolemYSCqygqtcJgrYz6vxM30z957FN9eo//uJ8BEMgP1
 CYuAH1i7XB+Dfb2vwgqwkAbp+UTEZm+5xupHstkxewFuSSN1u6mF8Ws4d7q3XMHUjh4q
 tULHwaxCEjxJwmtutWud8a1uR8I+1wAFXx4NS19SKHJFUkjKtqXumfou7r8IJauLl6Y5
 WJjg==
X-Gm-Message-State: APjAAAV1hGHeRr/6gVSRYzxjBN/zcxfXzFE01wuM6mGGbZTQNeQ1WPtP
 xHtR/2ZJBoU4pjRhjCPmTLS0Tvqhc0NTnlbv
X-Google-Smtp-Source: APXvYqznNQ3eyCoXZAq52CxrgbT9M04glq+FVOGTOz6PPGiXCQKbizbiMV9h4/veE8ZXLHtRnOcjwQ==
X-Received: by 2002:a17:902:aa95:: with SMTP id
 d21mr12497216plr.185.1561743216016; 
 Fri, 28 Jun 2019 10:33:36 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id y5sm2156224pgv.12.2019.06.28.10.33.34
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 10:33:35 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:32:13 -0700
Message-Id: <20190628173227.31925-21-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628173227.31925-1-palmer@sifive.com>
References: <20190628173227.31925-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.193
Subject: [Qemu-devel] [PULL 20/34] target/riscv: Add support for
 disabling/enabling Counters
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Add support for disabling/enabling the "Counters" extension.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c |  1 +
 target/riscv/cpu.h |  1 +
 target/riscv/csr.c | 17 ++++++++++++-----
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6a54ebf10c62..be90fa7d0808 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -440,6 +440,7 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("c", RISCVCPU, cfg.ext_c, true),
     DEFINE_PROP_BOOL("s", RISCVCPU, cfg.ext_s, true),
     DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
+    DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
     DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
     DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
     DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0855277b92d4..4d4e0f89e206 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -222,6 +222,7 @@ typedef struct RISCVCPU {
         bool ext_c;
         bool ext_s;
         bool ext_u;
+        bool ext_counters;
 
         char *priv_spec;
         char *user_spec;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 448162e484a3..de67741f3648 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -56,17 +56,24 @@ static int fs(CPURISCVState *env, int csrno)
 static int ctr(CPURISCVState *env, int csrno)
 {
 #if !defined(CONFIG_USER_ONLY)
+    CPUState *cs = env_cpu(env);
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    uint32_t ctr_en = ~0u;
+
+    if (!cpu->cfg.ext_counters) {
+        /* The Counters extensions is not enabled */
+        return -1;
+    }
+
     /*
-     * The counters are always enabled on newer priv specs, as the CSR has
-     * changed from controlling that the counters can be read to controlling
-     * that the counters increment.
+     * The counters are always enabled at run time on newer priv specs, as the
+     * CSR has changed from controlling that the counters can be read to
+     * controlling that the counters increment.
      */
     if (env->priv_ver > PRIV_VERSION_1_09_1) {
         return 0;
     }
 
-    uint32_t ctr_en = ~0u;
-
     if (env->priv < PRV_M) {
         ctr_en &= env->mcounteren;
     }
-- 
2.21.0


