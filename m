Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3684BC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948AC20774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="K8pFoIPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948AC20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNKxF-0003ga-GL
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKw0-0001zh-M1
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:05:08 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:34143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKvy-0001fF-R2
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:05:08 -0400
Received: by mail-pg1-x529.google.com with SMTP id u24so4651124pgi.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ehyRrMGdOjUIgMs9VpmBLNCLy7Zc+fW0jq8FzUHQAkk=;
 b=K8pFoIPSSO90EUskSuxGyDbtnirOlwmqgR0AJPFH7uApf3nj9Yb+acxruu9Y9PFbLg
 uAGl5Tq8i899TVNutC0GZqE0ZaVxFylIRDNd3AXWUAJ7Wi64NZzcRWSe3Oh6B9R9Hb1f
 ZhadmT6EldyAczLQiT5gBk8btvpSARULAC1Ja3tUorIt3dV2RcG8/j+C23pY9PE/LMsS
 yVzNwsCwG2p4t3aDGaYAAQLf67pBnYu9rdG36muWtV/SJK3O0pT5oIkPejV8VoafCtQo
 12C/AeasukLbsGTrVyOCUH919CP3XoncBVnxdP4o8SMzib8un9pghffxz37M4FxNPD6r
 2H1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ehyRrMGdOjUIgMs9VpmBLNCLy7Zc+fW0jq8FzUHQAkk=;
 b=sZSDLifPJMZAEVwoqqNHXXDHrG2ujsXSCP9NycFYLzlHeQqqQLdEIwgHLjeCCxMMsi
 PCOUCqEnQTJBVnAKv1neAYIYVipQbIObx3Y6cEwrNwK5N569X/iWPxsWh8aQ4AMZOzuV
 wSzggALMhvSm+ZTMLzyOgbCiWPQKUq5jua9NbwYxFL2gLV/J4Yna1XSYpGYDPTMSGj9p
 B0WL79s2Dyktnzspvl01pP8bKILRBkBFrBpR71dTB9T0axV6sE25RGsdgH+x8edVckft
 wnqYJJwZpDpbeHHCfJjr67pLgFSBgLY0BN8Z49KAstVcNgtLJovW5QG1JZT7/upoTocT
 H+GQ==
X-Gm-Message-State: AOAM531auqmKJfitywdMpNMfU+jkQ2TA4isZRpcdL6GopUzG0vRyDTF4
 Xz/o7Qjz6lpTei6b+InfFekXbCUYxCzAWQ==
X-Google-Smtp-Source: ABdhPJzV3OiOSk93OJFeeP+i0L16g8a1Yye2k6tvFxYBTEA8g9oFtjT67Xc9cHNZVJuJnYr8/GMNZw==
X-Received: by 2002:a05:6a00:1356:b029:13e:5203:fba3 with SMTP id
 k22-20020a056a001356b029013e5203fba3mr5290454pfu.3.1601406305172; 
 Tue, 29 Sep 2020 12:05:05 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:05:04 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 01/68] target/riscv: drop vector 0.7.1 and add 1.0 support
Date: Wed, 30 Sep 2020 03:03:36 +0800
Message-Id: <20200929190448.31116-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x529.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
index 57c006df5d..17c138bb90 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -345,7 +345,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     CPURISCVState *env = &cpu->env;
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     int priv_version = PRIV_VERSION_1_11_0;
-    int vext_version = VEXT_VERSION_0_07_1;
+    int vext_version = VEXT_VERSION_1_00_0;
     target_ulong target_misa = 0;
     Error *local_err = NULL;
 
@@ -463,8 +463,8 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
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
@@ -472,8 +472,8 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
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
index 65daa73675..bf10b64fcb 100644
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


