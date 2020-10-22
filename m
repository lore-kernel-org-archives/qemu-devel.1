Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BACFC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B5EC21707
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tvOAhnqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5EC21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVVGw-0002SQ-Co
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 03:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kVVG1-00013V-FP; Thu, 22 Oct 2020 03:43:34 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:44568)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kVVFn-0007cz-Fq; Thu, 22 Oct 2020 03:43:31 -0400
Received: by mail-lf1-x144.google.com with SMTP id b1so1009021lfp.11;
 Thu, 22 Oct 2020 00:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EMHtwtlOhgQ1h5Kmz8jinmABS0h3Twjiwzgmx6BiYTU=;
 b=tvOAhnqUEF1HR4dLtrw58AK6xtuIa2JtxZJ1MFWLmXr6bn5I2O02Dxl506H6tiQ59a
 gyFjDcOtUJmZYHOK9ZOTh9n1gRUBPZ5dUAXuZL93gCwbfGRlpvWl5eQAblWPAlfs9VgD
 mULMrldSLBAYC7PjF1YTBrxyK9DxXZaQRn3QPmk5NFnnVEbMddVd/Zy3tH9EpJXw2p3A
 QKL0gJJ2Gk8N5oXBLuc2tHz3eKyIH60wNEPIeE0tUjT5puQGRV709G+XeRpTvRLyEv1/
 eWrHiXkVwAtI3R0zgJLOR1Lw7CwCt1WpBwWybXa171QHSVOzJd42+z8ZroBcf+iDMLSO
 b2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EMHtwtlOhgQ1h5Kmz8jinmABS0h3Twjiwzgmx6BiYTU=;
 b=VGIdFaobhwf/OR3Vv3xXBWsQjxc0Qq4ExUjIekIMILKv/vF5BqzDV0pySengWyNzvJ
 MaKtEeKFUN275/hXObtO+HUxUbJ4QDT8FRtPLZ/lf1jR6S9lOpMFAfMo4JrLzkxgmBN+
 RYH7K5frJMH9bPiXtMp1qj+/D1t9zhbJVPTk43VdG5kMRWD1oXGgueQlNQ05tavu99Vv
 zHzs6KzCID2VaK+CmGQGcBQwm8S0ii93I3piCpYimhX1TSKaTTPmxRUOzznDYc+3Q9T+
 Qv5kDYCBtTdlBinn9cfyukW2V6bLJHeK+AlhbJpkUxHhCvUzGvgfRPRNrdeR4J2GGSFY
 Kcqw==
X-Gm-Message-State: AOAM533ACh5nZ/deZ3LtdKgpUNIArdmyUJHcQK1fVoVbYGxrnZEmTcEK
 Cgk/uoT3eVj1TlT62OyGEBQqboVUVJbPc/Ie1Ok=
X-Google-Smtp-Source: ABdhPJyd/QwastSqdAsDDFHUsfUCjskdU96trIYqGFLW2H70YzG7Ze6Bfysdz/jIgYSu9CflfxT1lw==
X-Received: by 2002:a19:7e53:: with SMTP id z80mr376945lfc.72.1603352596199;
 Thu, 22 Oct 2020 00:43:16 -0700 (PDT)
Received: from neptune.lab ([46.39.229.104])
 by smtp.googlemail.com with ESMTPSA id n19sm138887lfe.142.2020.10.22.00.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 00:43:15 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <space.monkey.delivers@gmail.com>
To: 
Subject: [PATCH v5 1/6] [RISCV_PM] Add J-extension into RISC-V
Date: Thu, 22 Oct 2020 10:43:04 +0300
Message-Id: <20201022074309.3210-2-space.monkey.delivers@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201022074309.3210-1-space.monkey.delivers@gmail.com>
References: <20201022074309.3210-1-space.monkey.delivers@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: baturo.alexey@gmail.com, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, space.monkey.delivers@gmail.com,
 Alistair.Francis@wdc.com, kupokupokupopo@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

---
 target/riscv/cpu.c | 1 +
 target/riscv/cpu.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0bbfd7f457..4e305249b3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -516,6 +516,7 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
     /* This is experimental so mark with 'x-' */
     DEFINE_PROP_BOOL("x-h", RISCVCPU, cfg.ext_h, false),
+    DEFINE_PROP_BOOL("x-j", RISCVCPU, cfg.ext_j, false),
     DEFINE_PROP_BOOL("x-v", RISCVCPU, cfg.ext_v, false),
     DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
     DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index de275782e6..eca611a367 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -66,6 +66,7 @@
 #define RVS RV('S')
 #define RVU RV('U')
 #define RVH RV('H')
+#define RVJ RV('J')
 
 /* S extension denotes that Supervisor mode exists, however it is possible
    to have a core that support S mode but does not have an MMU and there
@@ -277,6 +278,7 @@ struct RISCVCPU {
         bool ext_s;
         bool ext_u;
         bool ext_h;
+        bool ext_j;
         bool ext_v;
         bool ext_counters;
         bool ext_ifencei;
-- 
2.20.1


