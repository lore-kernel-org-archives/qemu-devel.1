Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C641C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15250207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15250207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAcGL-0004pX-Sa
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 11:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsZ-0007Ji-Lk
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsY-0006va-Ai
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:27 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:37109)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbsY-0006vD-33
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:26 -0400
Received: by mail-pg1-f182.google.com with SMTP id c17so51765pgg.4
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=dn6ffCPkA7oUVq7UkAAzaviL3Pr9DX2pgFSlHwRglF4=;
 b=EnaXY/595r84eBk9vQAyoYaIyphbsbIlX2QUEW+15IZsZslEr9hdP5ScfeFJ908/93
 tbUzV0pqKOyrWydXCcgHtn7TXUSyHRUuwC4bjtmmosMhESF3W3bX53E6SxcytVIdgbYg
 f6d3BjBOLM8EsqB0nFRPWB6MTqHjB6/+9a48zV7G0QKhwcer0gcka0kWwHhnadvTuG7q
 231OMvupF/bglgM0L7R0n5ceq2/0Oql8vFc+e1Qx5QlfblHVIJF9BS/atiz/qraox2UX
 RNBaNCEACb1yHW8PASebitkmk48K1GIk55wAiToinY+KE0sR6vvgCxIm4NflcGBfeTNj
 J4Qg==
X-Gm-Message-State: APjAAAXmCxmeWtdKPGknuF8P8lFFWFhAe4g3/Udd7lAdL7quudh8fE0e
 5C0Fl6csnHP9wl6ydvNB2hhZ3w==
X-Google-Smtp-Source: APXvYqwSKvCzSOh8f27P/cmcGQjfIIBR/oND3KTcmXUqw/2EOf35mIBED90MI2RhZTRXc1tZTI62Dg==
X-Received: by 2002:a17:90a:9a1:: with SMTP id 30mr4518354pjo.71.1568820504845; 
 Wed, 18 Sep 2019 08:28:24 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id s19sm6663401pfe.86.2019.09.18.08.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:28:24 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:20 -0700
Message-Id: <20190918145640.17349-29-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.182
Subject: [Qemu-devel] [PULL 28/48] riscv: hart: Extract hart realize to a
 separate routine
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
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/riscv_hart.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index d0f3199968..6620e41cb7 100644
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
@@ -39,26 +39,33 @@ static void riscv_harts_cpu_reset(void *opaque)
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
2.21.0


