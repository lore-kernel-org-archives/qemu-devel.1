Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0B8C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1FA42070B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHRmqnFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FA42070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2dID-0000AU-Hx
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cwL-0003NR-G3
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:59:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cwH-0003mG-T8
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:59:19 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i2cwE-0003ZU-L6; Tue, 27 Aug 2019 10:59:14 -0400
Received: by mail-pl1-x644.google.com with SMTP id h3so11910335pls.7;
 Tue, 27 Aug 2019 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=ODEtlj8wjeSL4VvR5EsvCfx+5VyX4hqhU8FC/9/mIoM=;
 b=QHRmqnFEp93OhUGVLzjExczv9+Vkrau6XH+7eusj7BxwwMKIpFsOPXHZMqQfCiK97O
 g1y4ue9bd5CwuG8pIgv7prDogyNRQ2PWQfe+QczePmSAIXzt78oKSKZWui8BKAiZ+4tt
 ICuRKdsJD7s9IuGMrZdplTFFbcCWPfyRksvX85DX4bO9OG5OCOkaBqkbq18GRUFx3OLj
 Gj7KmkbOs49WzZld0uud2dpPoJzSLVa27sx8tqD6eliGS5F11zcxhUJ6gGkHl7hKdSVv
 ztWRamAhxYPRfAqSlbsxuYW5bwDN3NNDkome2TpBKTXGwX0pheafM8trmDN88z/YZx/k
 MI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=ODEtlj8wjeSL4VvR5EsvCfx+5VyX4hqhU8FC/9/mIoM=;
 b=fJIRPn7vYSWL8oKcFRM4s4lVjF/jCYRbkJDXpDtF5RxktKyhNOYSRlXWz6yfUfIg8B
 W/C3OwpX9ZyC50zbSgt2P9jJt7lTGaf3qnGfZrsrFGZe1OM+nphUWBo/l85KLT+Dlv4X
 jLBBvZ3kwkaqEFwwlco7RMGoe9IG8SBIPGAM1ohLl5Xpv8+z+KoxNpPoJ+ADLXvfyNmb
 1aPJY9q3fHd7n06Yaogrr+V5EPt9hTHkXMNQLcjvgNlLRetyUcVQG/jOVSbET/HF9Xkr
 Tl7JsZuK7SpU7ain58DZk/oUbKUo1VWrZoXOMWpK/GEYDibHccSAokzoOUxtKmIuZSz9
 fDwA==
X-Gm-Message-State: APjAAAWyEwJTmj/oKR1LLvw6iKFIT3JvOe6LCBxjlYR2d8EjP3aJbdMV
 BdQcbzcprYA+JAWYnG3pQTc=
X-Google-Smtp-Source: APXvYqxfehCXKQTeOybHIH1p2joB+EHbsoozBBj2eLZmRDDuyMazsm2eNRyIxvHkM55ptWVLl//Tfw==
X-Received: by 2002:a17:902:3003:: with SMTP id
 u3mr12386085plb.161.1566917940715; 
 Tue, 27 Aug 2019 07:59:00 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id j15sm14839344pfr.146.2019.08.27.07.58.59
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Tue, 27 Aug 2019 07:58:59 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Tue, 27 Aug 2019 07:58:23 -0700
Message-Id: <1566917919-25381-15-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
References: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v6 14/30] riscv: hart: Extract hart realize to
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

Changes in v6: None
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


