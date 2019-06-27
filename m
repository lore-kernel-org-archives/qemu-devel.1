Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE720C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958CE20659
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958CE20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgWwj-0001ss-S8
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 12:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33289)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgWHk-0003Kd-HC
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgWHg-0000LU-KA
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:26:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40893)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgWHe-0006zd-6d
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:25:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so1493291pla.7
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 08:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=WFOcqA5bhC2gv8hijUonjP/cUpFUXz32Bb/6MGXuT1U=;
 b=Qxbfci8BCjMkQDWgwIp7Qoqk1E8Gz9kJeC8+Q/BObFnFZ8ZpYwpIaEoAwLxstulukd
 La54cOrPqjNqHoYBRR4cCCvnl8qMODDHFFnSpHyXMuFmBrQmOXpndx1vWsKi/iT9q/T9
 GRPthuAMKuJFH7aTqDLnRVHsRhHtE55tnLXCvjamC375PtIKzqlTCbc1ZsFnDMBuD0hZ
 9kWJbI9lv/+23SADpZVfrF/mW6Ir0igYbHonlY2V+23gk+KBLcZ0GnuP4cF6JU9gPZnL
 leV20Pn6YeTzsdKrj9uzDr87bO+JkUlnX9cYl73foOqYco1/cyO2wDl02jUlSWh4wTc/
 VBCQ==
X-Gm-Message-State: APjAAAXLApLjQ5kHgjn+op48oEp+8kILS4YmGCQc/uUAunlpkqMTQUrJ
 e/Bea9CR4pdLupB9xXW7YfhBlw==
X-Google-Smtp-Source: APXvYqxG+ii9erYoAAqHdSYPSfz4oS3lxy4uCURenbKkx2GKib/HRzewyohSuqz9t37LPiWGQUwmlw==
X-Received: by 2002:a17:902:f204:: with SMTP id
 gn4mr5376927plb.3.1561649046472; 
 Thu, 27 Jun 2019 08:24:06 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id p6sm2648446pgs.77.2019.06.27.08.24.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 08:24:06 -0700 (PDT)
Date: Thu, 27 Jun 2019 08:19:55 -0700
Message-Id: <20190627152011.18686-19-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627152011.18686-1-palmer@sifive.com>
References: <20190627152011.18686-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.195
Subject: [Qemu-devel] [PULL 18/34] target/riscv: Require either I or E base
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


