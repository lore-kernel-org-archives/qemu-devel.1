Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2E1C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:00:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6212083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6212083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgvAe-0003aS-3M
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 14:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54792)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hguko-0008NC-AU
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgukh-0000Rs-Hr
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44183)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hguke-0000OS-C7
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so2876782pgp.11
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 10:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=WFOcqA5bhC2gv8hijUonjP/cUpFUXz32Bb/6MGXuT1U=;
 b=bP19ZOjdgjDpgX1DwcLAJqp5eJnJ5ZFkvQ4VqSI3aUJlP1JOjjfGeUrybVoqMwJAYW
 /LJXZIuuDPSxB951PTb+qv2MqgL85FaA7BynSJV9PRAzmo0+Qgo0sfMWkR6HTJdb9ItF
 yzSTI/QL66D0h9xB4q4MH7P3oRWyw5G+wGa3Ylni2fik3/rgLfqkyTXRrzJ4012L5RXs
 NA+Ur05ltSlFrBBPr333niefj5nCjH66fuyhzK0QjszmOsqFLbHTzBAEnCCk3k5oFigq
 TnUHiJl+OMDXEqZJtHocUCNa6Da8+O7+JGWORtF74KhST+1F4MT4UknNgl/ZFNvAkYHg
 pr/g==
X-Gm-Message-State: APjAAAVxMlbXNZ3DXC16uOFR+M/AladUEyAorBS4Y7RWgpwRQuApLTkB
 LJd0rdl0zIn9YsSKUI1S/IeV84a+fDO4O6J1
X-Google-Smtp-Source: APXvYqxZXcgQvYEmTU1tDWqSLAtLWxpU3JuDD0WS3iMyaSz63FTWLhL2MjZCmoruXx8hy7bbNJTCZQ==
X-Received: by 2002:a63:1316:: with SMTP id i22mr10815249pgl.274.1561743210410; 
 Fri, 28 Jun 2019 10:33:30 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id y10sm3105961pfm.66.2019.06.28.10.33.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 10:33:29 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:32:11 -0700
Message-Id: <20190628173227.31925-19-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628173227.31925-1-palmer@sifive.com>
References: <20190628173227.31925-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.196
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


