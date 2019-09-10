Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CF9ECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:00:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A56421928
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A56421928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7yU0-0004fc-Em
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 05:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7xwY-0000DR-SH
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7xwX-0006yF-G0
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38217)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7xwX-0006xr-9E
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id o184so2378997wme.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 01:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=hEFvw8Q4h+2ImCXdycbkvzEGKttDjRBeJ0Zb0arlL54=;
 b=OG7ZiqpCao8lbKUQkIXklFRp7UrG1XCLJHXZhC6gwR4X03JtL4hoWv9pyaIWc1BvWO
 pBJV8B5Qiwz+/xR4BjEcTZRaPwOWQIZewa8x6oFOTLDo9ZYWXPwvgIhi3peo1JoCVTIv
 8+wG745n5ZOGPdo4Hi4at7f7cZzvqF8lcUonw7H0wSIrKTt79IXvB2F2RJM+uk/ziBvx
 bWMw9FN6tM16CChmargYCZ3624zjbEKDX0buIQz1w3ihjNvBPvByX+qplZZ7xz4O4PcQ
 8D9Bxr/rYbr75846s2jWzwvHcdDg2hMcTaLQ2DpeD8RRpCBRkNcoIeVdGi+AnnPMRa85
 eVcA==
X-Gm-Message-State: APjAAAV74fKHmsQaCR/OyXWrShrGQAKEHRSQXt8DIYoDjHDlNuapQEG7
 oLiwjLmQFVSrk/a5+DXZX3uvNA==
X-Google-Smtp-Source: APXvYqxJd91LJ2r0TLiLCMTwuqBHyWBKum6LW94RLWS0d32rVYRadjk0whp7EmEmtm3V3XpCTkkHZg==
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr2703067wmj.73.1568190336111; 
 Wed, 11 Sep 2019 01:25:36 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id q19sm28409669wra.89.2019.09.11.01.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 01:25:35 -0700 (PDT)
Date: Tue, 10 Sep 2019 12:05:10 -0700
Message-Id: <20190910190513.21160-45-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910190513.21160-1-palmer@sifive.com>
References: <20190910190513.21160-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: [Qemu-devel] [PULL 44/47] riscv: sifive_u: Update model and
 compatible strings in device tree
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

This updates model and compatible strings to use the same strings
as used in the Linux kernel device tree (hifive-unleashed-a00.dts).

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 507a6e2fa9..ca9f7fea41 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -96,8 +96,9 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         exit(1);
     }
 
-    qemu_fdt_setprop_string(fdt, "/", "model", "ucbbar,spike-bare,qemu");
-    qemu_fdt_setprop_string(fdt, "/", "compatible", "ucbbar,spike-bare-dev");
+    qemu_fdt_setprop_string(fdt, "/", "model", "SiFive HiFive Unleashed A00");
+    qemu_fdt_setprop_string(fdt, "/", "compatible",
+                            "sifive,hifive-unleashed-a00");
     qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
 
-- 
2.21.0


