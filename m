Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A15C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:37:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B5922CF7
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGvEpElU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B5922CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i12Gr-0005xN-1C
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 01:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i11rK-00049O-37
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i11rI-0002bR-Oe
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:11:33 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i11rI-0002at-IS; Fri, 23 Aug 2019 01:11:32 -0400
Received: by mail-pg1-x542.google.com with SMTP id m3so5064333pgv.13;
 Thu, 22 Aug 2019 22:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=MbR9FGmtjHfjmzRf/lgM9bln6VL0g2SBm+zUiqsHiEY=;
 b=kGvEpElUX+2zhMLMw3BjJ/1d9W+4azjO24ZpV3T+7X0Hit11y78qdjzVmuBYb8PA+4
 WfrQILNgb7TVk5FX3swmKiHlSQi1kaV94VCJVlK1ySuOjV++ImPIeU5iIP+Q1cXDPMID
 E5UQ7CRdT7cMbJ2w32g7efcg0gpxVJgN/88XUWrYsOxLhTp2Vhjrv3q0TmRWikJz2nBc
 xvzGFbZLSCo5sGRq27W5dE1fnl1C6nZ0aijYzS7gyP5xjjC8ZqSvOufoB+1EPS39dJJL
 SJxVtLCSeQDz185saRjnh2tl3pmRlvMzEGj6mtBYMDHBgnDepKLwGlPRauV8LDby0rMg
 lSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=MbR9FGmtjHfjmzRf/lgM9bln6VL0g2SBm+zUiqsHiEY=;
 b=LEVz+o4vrOG4+ZHxwMoCtmKBks61DSvT+jeeFYM/sFjDSzjfgrmjchNSRA7XtEuGBD
 yFabPnKjc5QDIK62i+RnWxdTbp9JiSjwsSbaxSyDHkl59KvLRqJGeFtMHxhU4rrPWE8j
 fFbGESkqIrXAq/tBttrjhGWD16R2ul/FScC2HImtMy746MDmK1Y2fkRh+1SX577wI7Xi
 Pc1rTYmywJVJ6NAznDt7AkA3iyPnnlMhlIhR6HQBTwFE5WP/EELtc3LzVjBWJ5bQcQRY
 unNSOgUv+S1DoJ5UatQZ/yhUpDKsipc16q2WiEcSZgy9TZ+ZvAs9kC3itvsBQQzswbvf
 U6mA==
X-Gm-Message-State: APjAAAVxwHaMSQ73fq6r3AQFcoAMDtzFuGyB20DCDJLcwENxDFXe7/Wl
 kcGsqczoIAI58ISvvYL2i9eYduDv
X-Google-Smtp-Source: APXvYqy6ler01oD7WHuceQ6f1JkU9UwQBsXViY3P5RKYaP6YdzuVWClrlI91BqRgLXl+tw/C6Igyag==
X-Received: by 2002:a17:90a:a486:: with SMTP id
 z6mr3202153pjp.13.1566537091815; 
 Thu, 22 Aug 2019 22:11:31 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v189sm1122527pfv.176.2019.08.22.22.11.30
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 22 Aug 2019 22:11:31 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Thu, 22 Aug 2019 22:10:53 -0700
Message-Id: <1566537069-22741-15-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
References: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v5 14/30] riscv: hart: Extract hart realize to
 a separate routine
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently riscv_harts_realize() creates all harts based on the
same cpu type given in the hart array property. With current
implementation it can only create homogeneous harts. Exact the
hart realize to a separate routine in preparation for supporting
multiple hart arrays.

Note the file header says the RISC-V hart array holds the state
of a heterogeneous array of RISC-V harts, which is not true.
Update the comment to mention homogeneous array of RISC-V harts.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/riscv_hart.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index ca69a1b..9deef869 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2017 SiFive, Inc.
  *
- * Holds the state of a heterogenous array of RISC-V harts
+ * Holds the state of a homogeneous array of RISC-V harts
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -37,26 +37,33 @@ static void riscv_harts_cpu_reset(void *opaque)
     cpu_reset(CPU(cpu));
 }
 
+static void riscv_hart_realize(RISCVHartArrayState *s, int idx,
+                               char *cpu_type, Error **errp)
+{
+    Error *err = NULL;
+
+    object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx],
+                            sizeof(RISCVCPU), cpu_type,
+                            &error_abort, NULL);
+    s->harts[idx].env.mhartid = idx;
+    qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
+    object_property_set_bool(OBJECT(&s->harts[idx]), true,
+                             "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+}
+
 static void riscv_harts_realize(DeviceState *dev, Error **errp)
 {
     RISCVHartArrayState *s = RISCV_HART_ARRAY(dev);
-    Error *err = NULL;
     int n;
 
     s->harts = g_new0(RISCVCPU, s->num_harts);
 
     for (n = 0; n < s->num_harts; n++) {
-        object_initialize_child(OBJECT(s), "harts[*]", &s->harts[n],
-                                sizeof(RISCVCPU), s->cpu_type,
-                                &error_abort, NULL);
-        s->harts[n].env.mhartid = n;
-        qemu_register_reset(riscv_harts_cpu_reset, &s->harts[n]);
-        object_property_set_bool(OBJECT(&s->harts[n]), true,
-                                 "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
-            return;
-        }
+        riscv_hart_realize(s, n, s->cpu_type, errp);
     }
 }
 
-- 
2.7.4


