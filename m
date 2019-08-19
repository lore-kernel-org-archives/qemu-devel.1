Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CD6C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:21:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 624A22086C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4+5QGAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624A22086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hza6k-0006kI-5c
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 01:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZxu-00057q-BK
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZxt-0007eb-6W
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:22 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:32895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hzZxt-0007c8-0u; Mon, 19 Aug 2019 01:12:21 -0400
Received: by mail-pg1-x541.google.com with SMTP id n190so484258pgn.0;
 Sun, 18 Aug 2019 22:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=Tucvwbpl50vqcsdv4Gs5/Ot/ead75E87NGyI6G9+GKg=;
 b=H4+5QGARAQ8lFiWA8E9DyGPMftiaxe4LZAtcZR7aszHnE9fh2scOXndTS01R5dTm96
 Osxs1D5F8LN6TvuhZAnoXlBgVOEsNi2Gh/OVsqx2Ik101slS0WU0ZhdWBgYI/f29SBFG
 3xC9Inu9lu6B7XWRk0JpveEgQbjmSfCz52loBNswObRWd1JNXji4v3E/YEJbAeGpIlk8
 scBgvN80C+771aXHWo2oVi3VHo3kNUScga2KsFcksfMaHc/uzsvks6mNYNFCMrUZpJCe
 PpKtnFHvcG9BlCc0XD1ykmMqkYxNuS827Lqzubcpp8hI1/OTFQKShOsY2xKqIX1cp/Jc
 ngEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=Tucvwbpl50vqcsdv4Gs5/Ot/ead75E87NGyI6G9+GKg=;
 b=XM4+mtky2CFUB8PrzHHYcWKoAfnfejawnOjPIdzdoGH3dXo9kES3LS+WmCjooaA1Dk
 G4ML8V2t3IBENUyodkO8BqDZTaNE65CqGh69QOxjAWeCbn6LMukPZh2nhUlhYfhwM7uu
 2vvf9riAYgTB+p7ohAK3zVi+kbgxtfyC95huHWPHsUtHxw0rwnlYDKdjyXZhqL1pj95C
 iqUuRotAnC4s239L2Jp2xYNvTNM93cj5K5N0NHtQ7G9YmjBySGAnZAxcdezeYUHTR10J
 7vlgekWYFHp5L/zgsrHoBsU55AG71tUP0NkLUfBgjwhUTMXE55fVXGUJfLoTIGzZgHOe
 I+gA==
X-Gm-Message-State: APjAAAVdya7HjLK484q4DL+4P2ZeMQ7S5Zzd/ewVXo3TxPgBdOFWe0td
 XeYzEt27h3xlZYHfSwpsmQxbh4zJ
X-Google-Smtp-Source: APXvYqxAC5eKj3EDHSp2ErKzlOcyP3Os8wCFERO4qcJw5KphJJRUcpukwq/DVSIdemd70hS62bWBmg==
X-Received: by 2002:a62:174a:: with SMTP id 71mr23134453pfx.140.1566191540244; 
 Sun, 18 Aug 2019 22:12:20 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id q13sm15464986pfl.124.2019.08.18.22.12.19
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 18 Aug 2019 22:12:19 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 18 Aug 2019 22:11:45 -0700
Message-Id: <1566191521-7820-13-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
References: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v4 12/28] riscv: hart: Extract hart realize to
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


