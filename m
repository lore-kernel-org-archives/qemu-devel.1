Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1271FC0650F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:08:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A52208C2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vdNrHhBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A52208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwitU-0007RE-3e
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 04:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60040)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwisj-0005T2-FO
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwisi-0003qg-Ib
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:13 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38674)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hwisi-0003qK-D6; Sun, 11 Aug 2019 04:07:12 -0400
Received: by mail-pf1-x444.google.com with SMTP id o70so2898755pfg.5;
 Sun, 11 Aug 2019 01:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=b+BteCNl7LaQtomU9G8Fo8wvkmlvmSM+Wq5AwSdX96s=;
 b=vdNrHhBnrd1qvwt94HxxgSJxSELoGlCmiZ///BdI+TQQVjMZoogXgB+eKRjY+J2Z7r
 DPQ4bw0DXoT+HiTiF+QEQyvkPOIqvAzs8gsiX+SQ3CnUptbgk44gRAt05RKyw6sODpI3
 9wlMKJ8wnj9g/UEgYHDZqNz0Nnu8nCciIq01tsOvR76VBG+xS3uWm9Yjhut1hUGDF5CD
 4DiSrO5pU+++B4maozVzSibLumDuGtgXEZVHcEj/cdZuFWBsTxVu+ucPjSH/vOplFgsQ
 Xoqo2K4cjMlf2td37YvV4WNIQ9Mks1tnCE4mrIfT+FkS96/aiHqn6+TBph6pZaqtBV6k
 zAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=b+BteCNl7LaQtomU9G8Fo8wvkmlvmSM+Wq5AwSdX96s=;
 b=eqy3iA6lBr5E2LLZMeBOLwTEWgIm54442lD6czdRr5FeMkgXQBWCbLSBgWdhPHfHKU
 XW3my/SUj7dLVAKva/XxPfw4/z1VFxSmyNkvFnl/NMcUvVsWs1qhvAXmp/2vJPBengjk
 xCl/EysR4+axe3w8XQx+kjp/qIUwt2V3NrKffW8UEsr/B0WO+I1Xbqnsz1f6JnPPZHz9
 8kpX//PgqmSFEQBHAqIKCUvErp6yU+uVU2BlQ70Jum84yw49haiVrvXgrzKYO1qc3wfE
 7SpRonwok3rpTIDv7nLsIGZQS8GftZuCJuxMM8Hc5mTg/9GYZQVd/ZZzJRG0dQ3DKnC4
 mhHw==
X-Gm-Message-State: APjAAAUzpTSdd3Jdtf4lgNTvpJbHsRwTJ2/eOfZW/GXEf0ZLfln4wurB
 p9cy7jaj4VA0kM8SgdC0vc4=
X-Google-Smtp-Source: APXvYqwddlyWa5wfumuB9aigKCiZRNxC10XXuo/E292jMJ2fc6WrCmLGm+dx9e8uXbwDnM8APgPwhQ==
X-Received: by 2002:a63:5765:: with SMTP id h37mr24592764pgm.183.1565510831510; 
 Sun, 11 Aug 2019 01:07:11 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v8sm87339107pgs.82.2019.08.11.01.07.10
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 11 Aug 2019 01:07:10 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 11 Aug 2019 01:06:37 -0700
Message-Id: <1565510821-3927-5-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v3 04/28] riscv: hart: Extract hart realize to
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
implementation it can only create symmetric harts. Exact the
hart realize to a separate routine in preparation for supporting
heterogeneous hart arrays.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

Changes in v3: None
Changes in v2: None

 hw/riscv/riscv_hart.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index ca69a1b..3dd1c6a 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -37,26 +37,33 @@ static void riscv_harts_cpu_reset(void *opaque)
     cpu_reset(CPU(cpu));
 }
 
+static void riscv_hart_realize(RISCVHartArrayState *s, int hart,
+                               char *cpu_type, Error **errp)
+{
+    Error *err = NULL;
+
+    object_initialize_child(OBJECT(s), "harts[*]", &s->harts[hart],
+                            sizeof(RISCVCPU), cpu_type,
+                            &error_abort, NULL);
+    s->harts[hart].env.mhartid = hart;
+    qemu_register_reset(riscv_harts_cpu_reset, &s->harts[hart]);
+    object_property_set_bool(OBJECT(&s->harts[hart]), true,
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


