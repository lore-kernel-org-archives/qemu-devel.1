Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5651BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 221632067C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KJnatw/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221632067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7at3-00028H-BR
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 04:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7aqH-0005FD-O2
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:50:09 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:36045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7aqF-0004gd-J8
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:50:09 -0400
Received: by mail-pf1-x42b.google.com with SMTP id m8so7905926pfh.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5wUgVwUxSUpO2CbZpUkYP5iB/oW0JGxOf5Pb87o0hjA=;
 b=KJnatw/KAlGcZk20QS8llpXnVJZqH/1/bN0l8UH8zsefCnahrhPrPnqin8TFZMXzP/
 RTgHL7c82puCokMbf6VJcAJWC0jPE7F+Ha+ffxUzs21cPQQbZCGF8yJLPw4HzDJsfpbb
 rSVJwZs/JNkSMANL/fjs+GrwucC4cvpUwW5BH0xiXIYwaRzmzIOjfnZWaei5GlOklFX2
 4bI/ebv459V2anosQ3FM+9rg7UkqwuiODXl8qCc7vsP6yTj6KBA6dWT/WA5LZGzvIjd8
 cv9CM/2m83oUAKn7BSlnPwxDSm/cr9Qk92udlEZXtZUmE8ZOZiJuZh/Z2NiWu1Kt+yXp
 TPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5wUgVwUxSUpO2CbZpUkYP5iB/oW0JGxOf5Pb87o0hjA=;
 b=LcmCyTvjHX6hv72kZbXSeNdmGqcOUoXqwJktm36To8Vhas5VpCCGMQq6LUUtzvpdMh
 m1+EtqT39Gc+Zmhe68Me+oad1PGjxwzuCH3EIGo7KIQqPVr+uv1B3hElPAvWM1M9xIEO
 gAkWD39H7cMBvXmrECp2gdz6YUhK3SC36ffihnVIHETddYht809hgvFkRjs01KJgdW9G
 RdS/CIpBf0qtvsO4c6JGDAULFQtVEBEd8swcghsOwLyt+W6/stJaWlCQ4/C2+GliqRfU
 I7ZAJfCYsu1SlolSOxaxyEo+2eVh3ZrYWABbgjKjgY6Gd7jHMfQo4a45kLFb1ZPFflmd
 Uz8g==
X-Gm-Message-State: AOAM532OYfcu5gSFthJVquNhjFD9EbQBGsDRoGQM6YPudoyl2OonNI/4
 b83DZKnapKe4nfJaq5J2uQSMuy6YLF1KCw==
X-Google-Smtp-Source: ABdhPJyXAGxEH3WmhhStAXVm5dzzP+nXQE36gF2bCGjtVsvS0BsiCmmfw4rMcLJ9JE67/xBz78T5bQ==
X-Received: by 2002:a63:742:: with SMTP id 63mr9042892pgh.295.1597654205998;
 Mon, 17 Aug 2020 01:50:05 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:50:05 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 01/70] target/riscv: drop vector 0.7.1 and add 1.0 support
Date: Mon, 17 Aug 2020 16:48:46 +0800
Message-Id: <20200817084955.28793-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 10 +++++-----
 target/riscv/cpu.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 228b9bdb5d6..085381fee00 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -339,7 +339,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     CPURISCVState *env = &cpu->env;
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     int priv_version = PRIV_VERSION_1_11_0;
-    int vext_version = VEXT_VERSION_0_07_1;
+    int vext_version = VEXT_VERSION_1_00_0;
     target_ulong target_misa = 0;
     Error *local_err = NULL;
 
@@ -455,8 +455,8 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
                 return;
             }
             if (cpu->cfg.vext_spec) {
-                if (!g_strcmp0(cpu->cfg.vext_spec, "v0.7.1")) {
-                    vext_version = VEXT_VERSION_0_07_1;
+                if (!g_strcmp0(cpu->cfg.vext_spec, "v1.0")) {
+                    vext_version = VEXT_VERSION_1_00_0;
                 } else {
                     error_setg(errp,
                            "Unsupported vector spec version '%s'",
@@ -464,8 +464,8 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
                     return;
                 }
             } else {
-                qemu_log("vector verison is not specified, "
-                        "use the default value v0.7.1\n");
+                qemu_log("vector version is not specified, "
+                        "use the default value v1.0\n");
             }
             set_vext_version(env, vext_version);
         }
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a804a5d0bab..f9ef20fe89a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -79,7 +79,7 @@ enum {
 #define PRIV_VERSION_1_10_0 0x00011000
 #define PRIV_VERSION_1_11_0 0x00011100
 
-#define VEXT_VERSION_0_07_1 0x00000701
+#define VEXT_VERSION_1_00_0 0x00010000
 
 #define TRANSLATE_PMP_FAIL 2
 #define TRANSLATE_FAIL 1
-- 
2.17.1


