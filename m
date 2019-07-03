Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAC5C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:54:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37CE2218A3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CE2218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hib2O-0003Ql-FI
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 04:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51538)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hiapy-0006Dd-TE
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hiapn-0007U6-D1
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:52 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34267)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hiapk-0007H2-Ms
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id b29so1182261lfq.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=WFOcqA5bhC2gv8hijUonjP/cUpFUXz32Bb/6MGXuT1U=;
 b=fW/EufJdnfLa6Nh4EurJ/4h3mnBbelDrXXcksx/gG2FfE/S1JcZH45ETutiWq9FspQ
 FvFyLPV2pUqkmhNfk/Xw9sUOTeh0PAtES0gxnSWoFuHqLnWnfUKH93LlZusVm68Tu5+y
 Xyuu4+OUsvfwZHzzjl7PfIxSv41cLn8vJ8Ljjv4aKnFCDtyh1+t1kfYQyisz62IVFcRT
 FZmvyNwIAdEgzzgYQJZ+fZCDlljUkddwjEE9cTLDBtB+i93xF6FuUIQqpPiWpkguHw8h
 0tsRdibAdNNl+c+IREu2gdFgVnx0dfBeF3/ExWPvTya9Yp8c3yDLJjw1s++JojYSQm3t
 o7DQ==
X-Gm-Message-State: APjAAAXy7NVFB+rlMu8IeCSp3CUfEnGr4FtNqiMWm9vn89w2r5AJzwPY
 /93r4uggLTwpW3dorKtLEvjHlni8mGxGpQ==
X-Google-Smtp-Source: APXvYqztazGDlaFYC+WJx4zsTQ8xcsRfbQ7lRYHwt0fqFmw+IWx7nTbOV89DEcb6FFLFA9jmTHgeFg==
X-Received: by 2002:a19:ed0c:: with SMTP id y12mr16804747lfy.191.1562143301493; 
 Wed, 03 Jul 2019 01:41:41 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id w1sm292624lfe.50.2019.07.03.01.41.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:41:40 -0700 (PDT)
Date: Wed,  3 Jul 2019 01:40:34 -0700
Message-Id: <20190703084048.6980-19-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703084048.6980-1-palmer@sifive.com>
References: <20190703084048.6980-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.65
Subject: [Qemu-devel] [PULL 18/32] target/riscv: Require either I or E base
 extension
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ba1325f43533..1689ffecf85f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -373,6 +373,12 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
                        return;
        }
 
+        if (!cpu->cfg.ext_i && !cpu->cfg.ext_e) {
+            error_setg(errp,
+                       "Either I or E extension must be set");
+                       return;
+       }
+
        if (cpu->cfg.ext_g && !(cpu->cfg.ext_i & cpu->cfg.ext_m &
                                cpu->cfg.ext_a & cpu->cfg.ext_f &
                                cpu->cfg.ext_d)) {
-- 
2.21.0


