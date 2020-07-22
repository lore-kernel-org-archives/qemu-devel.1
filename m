Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C965EC433E6
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:18:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8658220792
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fAl+4JmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8658220792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyAtI-0006V8-PY
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAsH-0004la-IX
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:17:17 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:52334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAsF-0005BI-G8
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:17:17 -0400
Received: by mail-pj1-x1031.google.com with SMTP id gc9so863138pjb.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lIAWnZ0kGmaPMXxXhAaDX7KeOlS4ElOBc/y5+NIu9jI=;
 b=fAl+4JmGLef92i5d7ZnmTLeloBTWFijxEAC/C05KRKBEJAQ5wZfZ7vBwsnp6x6gRLI
 aRpZMFtfc5X62ppaaJxwsQONDTX8mWEuYrrnaFGG4lmCuNHsuBZekdlOsblPcGlB4yIu
 1jredABBfPh2Ba94IG1pfugvTmmd1QQ8PhlS/WuE4prA5GTggEBPnX2+TlektnqSM/Hn
 52AR/CQe8oKJv2EdVnmRSHBu6xTiB64rndRUxhye3VVAensIfsQ+Fp8qyF3UMgoogs4I
 q7GLBHgw4th1jDOuGRFRqnD+RSaRKTG81BJmo1q1qRIqsUTpJUnxHouDByxtHWp7gtY3
 pWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lIAWnZ0kGmaPMXxXhAaDX7KeOlS4ElOBc/y5+NIu9jI=;
 b=CAszbH3KJPbU7NYo+qm9/a5Anli5eAPfoJv4nhdeBXoleJoCfWlH9rkDnJSZOEfBgH
 InfvkOcbcQY9AC0PVjuYsaiGRn8/fwgp0MC8kONN8obFk3xGQ+4Rfz/C0U/D9JwuXEHB
 3ZhZyBO0hz3S4tKTVhlqB3MQpXYU91mlyHG8rSeMzJDe53cjnySbQBUTfviXPZOfkr9M
 OydSDBzLkeE4C1t3rSaB4TxN52JPUHFsUpWiMjfdLmpujZolhckhtmc/q4QUJ4k7IfJr
 zdujlP/sOBdOxWRRmBDHx8ojClxeHZ5rGdSFpAcsWCp3HAumnJdvvtGtum0Xd12jl+mE
 tLdQ==
X-Gm-Message-State: AOAM533tbDtFwZaLbjMrSEkogPSxwi5SF2lBye94PCWeA5FX9h0IzOmy
 F5vfhPv7K8fhE6sIQGo0KJ21C3Pxq7E=
X-Google-Smtp-Source: ABdhPJyElK+jTC6uT3yuXXlo0UodDCf+khJgxVo2b1iKT1siY25JKg5zkJHj6zkC5d0TOXe3NES1Vg==
X-Received: by 2002:a17:902:b185:: with SMTP id
 s5mr26253436plr.211.1595409434101; 
 Wed, 22 Jul 2020 02:17:14 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:17:13 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 01/76] target/riscv: drop vector 0.7.1 support
Date: Wed, 22 Jul 2020 17:15:24 +0800
Message-Id: <20200722091641.8834-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1031.google.com
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
---
 target/riscv/cpu.c | 24 ++++++------------------
 target/riscv/cpu.h |  2 --
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 228b9bdb5d..2800953e6c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -106,11 +106,6 @@ static void set_priv_version(CPURISCVState *env, int priv_ver)
     env->priv_ver = priv_ver;
 }
 
-static void set_vext_version(CPURISCVState *env, int vext_ver)
-{
-    env->vext_ver = vext_ver;
-}
-
 static void set_feature(CPURISCVState *env, int feature)
 {
     env->features |= (1ULL << feature);
@@ -339,7 +334,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     CPURISCVState *env = &cpu->env;
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     int priv_version = PRIV_VERSION_1_11_0;
-    int vext_version = VEXT_VERSION_0_07_1;
     target_ulong target_misa = 0;
     Error *local_err = NULL;
 
@@ -363,7 +357,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     }
 
     set_priv_version(env, priv_version);
-    set_vext_version(env, vext_version);
 
     if (cpu->cfg.mmu) {
         set_feature(env, RISCV_FEATURE_MMU);
@@ -455,19 +448,14 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
                 return;
             }
             if (cpu->cfg.vext_spec) {
-                if (!g_strcmp0(cpu->cfg.vext_spec, "v0.7.1")) {
-                    vext_version = VEXT_VERSION_0_07_1;
-                } else {
-                    error_setg(errp,
-                           "Unsupported vector spec version '%s'",
-                           cpu->cfg.vext_spec);
-                    return;
-                }
+                error_setg(errp,
+                       "Unsupported vector spec version '%s'",
+                       cpu->cfg.vext_spec);
+                return;
             } else {
-                qemu_log("vector verison is not specified, "
-                        "use the default value v0.7.1\n");
+                qemu_log("vector version is not specified\n");
+                return;
             }
-            set_vext_version(env, vext_version);
         }
 
         set_misa(env, RVXLEN | target_misa);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index eef20ca6e5..6766dcd914 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -79,8 +79,6 @@ enum {
 #define PRIV_VERSION_1_10_0 0x00011000
 #define PRIV_VERSION_1_11_0 0x00011100
 
-#define VEXT_VERSION_0_07_1 0x00000701
-
 #define TRANSLATE_PMP_FAIL 2
 #define TRANSLATE_FAIL 1
 #define TRANSLATE_SUCCESS 0
-- 
2.17.1


