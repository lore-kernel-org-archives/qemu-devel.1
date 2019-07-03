Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051F3C4646D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6A5218A3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6A5218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33913 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibFB-0006ma-3W
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51494)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hiapn-0006CX-E9
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hiapi-0007IC-RV
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:47 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:44249)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hiaph-00079x-Rt
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:42 -0400
Received: by mail-lj1-f176.google.com with SMTP id k18so1450895ljc.11
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=CCTUA83WsmaGam2XV7hw8vEWvHgX2YXg8c48BvbdAho=;
 b=GJKs9P738fHDrI+6IJCKcAw4k4bC1v8JtMQz4bYmr2OxafwI9Q7LtCBw2/i1rMZqsS
 aLEOl7HvDxBqLMf8wMnzJ8+H9oT7wZhpbNtuPqYFaepzJk82sXVnqYdiM7tCQurJYkRk
 KPwbJf6IeIGRjFKNdlbyGRzveem2sKmFPd6YSDZG6OLFptCb7FEQqub8zc38QxkeqCND
 P63oGw3/KLo1bSR3Rp480wS1SQyClnAUVpEpq8jNRmDGleZ681MfSHJStjKDF7fiCS54
 fcLEFqcmFSOLMTyo+n2ZDeQc1AuBN+d/moLwR7wr9RhjvAhLSRwIt4FxJkjoNQiZR7p6
 LVVA==
X-Gm-Message-State: APjAAAV8dgW0QmyaH93p4mydmzMJllk01BT5nwdb1fOTDxG3vggYmj9G
 RhKLYZ+W1HTlTXNULUdfAtOIt4Zae7rlPg==
X-Google-Smtp-Source: APXvYqxGJt5wVKU0cwAAl9cE8Cx+R3FTZ4xPgJuQDOa8Oo554v/Gj4878RpUVq7nN1j5ceZqq0jHLg==
X-Received: by 2002:a2e:870f:: with SMTP id m15mr20205143lji.223.1562143298179; 
 Wed, 03 Jul 2019 01:41:38 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id v21sm347593lje.10.2019.07.03.01.41.37
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:41:37 -0700 (PDT)
Date: Wed,  3 Jul 2019 01:40:32 -0700
Message-Id: <20190703084048.6980-17-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703084048.6980-1-palmer@sifive.com>
References: <20190703084048.6980-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.176
Subject: [Qemu-devel] [PULL 16/32] target/riscv: Set privledge spec 1.11.0
 as default
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

Set the priv spec version 1.11.0 as the default and allow selecting it
via the command line.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 17467c3d8705..ba1325f43533 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -111,7 +111,7 @@ static void riscv_any_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
-    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
+    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_11_0);
     set_resetvec(env, DEFAULT_RSTVEC);
 }
 
@@ -316,7 +316,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     RISCVCPU *cpu = RISCV_CPU(dev);
     CPURISCVState *env = &cpu->env;
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
-    int priv_version = PRIV_VERSION_1_10_0;
+    int priv_version = PRIV_VERSION_1_11_0;
     int user_version = USER_VERSION_2_02_0;
     target_ulong target_misa = 0;
     Error *local_err = NULL;
@@ -328,7 +328,9 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     }
 
     if (cpu->cfg.priv_spec) {
-        if (!g_strcmp0(cpu->cfg.priv_spec, "v1.10.0")) {
+        if (!g_strcmp0(cpu->cfg.priv_spec, "v1.11.0")) {
+            priv_version = PRIV_VERSION_1_11_0;
+        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.10.0")) {
             priv_version = PRIV_VERSION_1_10_0;
         } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.9.1")) {
             priv_version = PRIV_VERSION_1_09_1;
-- 
2.21.0


