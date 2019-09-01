Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6B0C3A5A4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 474D32190F
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZOC84dv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474D32190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4GMp-0006zo-Bx
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 23:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzm-0007gZ-9h
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzk-0006YJ-9i
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:38 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i4Fzj-0006Vt-0y; Sat, 31 Aug 2019 22:53:36 -0400
Received: by mail-pg1-x543.google.com with SMTP id u72so1305021pgb.10;
 Sat, 31 Aug 2019 19:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=DuGvBJA3DvXpolJ5nx3BtYlGXqT2mAEpwYYZ6X6h4K0=;
 b=WZOC84dvosqr0TqFQGop4ssMGnKRexq2GWTjmpIRurI3RyjinmRO9GdXbK4Nv9NvtV
 a9HDbdCDP7qE9k++DcWb+0plt9TLYz9IPAGlky1bHCYUk2vBOPPjBE0iwA8c3sWrSr/U
 Nlim7Hjkx2VfH9Z/4f4ieb2ElgNbJpsRoe3tgqhDrX0prnrsUE1WvEXoHUj5udQYVUNv
 fK1XRCticu4gOQzrdQRPZNCOzpUUqSI2bWa51JZvCeDGEEEfPOrULecoZvTgOXBaABab
 LEqHk8jvz1ZTE5YGXrcIVnlFiJE+sYQWY48EK/OH/wNcLAPvK5mgWcAlVI6Cw2G9GsAF
 D0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=DuGvBJA3DvXpolJ5nx3BtYlGXqT2mAEpwYYZ6X6h4K0=;
 b=IzyH2ZfeXSa4BGRZ7QrdLdrPFFoUMfkuXzDNLGhjAEeiz2RsX5rpOZKjT/cXOZGroF
 RbdrydLuPFxQrAr3R0Cfj8Bg0rlDxa9fcNO+s1H2XYtn27JrrHecoyd7vK9C6T06kEah
 QaZncqT2GsNFrIar6uKDG5mOEuJ9lzWwQb6b+6VYlxSy/3p5ehbdxBHASeVLsuiHfXYu
 XJeD97hMQNacnwd9hyiVfhkI9NbywsDEo0b0eIG678neXC5sooH/bHJE7n8Ty2ZA2ozB
 HQalzOAPYFleo/oP4/oOzsvftmwTlV7F8cUbHinTcG/cJP5VLVYTXwoZdbK2CoGrGrTa
 66FA==
X-Gm-Message-State: APjAAAWGk8uax705YGhQxENwznzMe6bzFC3I6ZOl8lzbwlOvIfMliYTv
 bV0Kdl0jNoa7LOqXB1UBFhw=
X-Google-Smtp-Source: APXvYqzqRc1JFv72Dj3Ro9O7wrVSdI3rap0FQ1HNU/XTP3jGGw497anlhglOdXxRfGONFtp1XiyQtg==
X-Received: by 2002:a17:90a:630a:: with SMTP id
 e10mr6398863pjj.25.1567306414164; 
 Sat, 31 Aug 2019 19:53:34 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id p10sm11453307pff.132.2019.08.31.19.53.33
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sat, 31 Aug 2019 19:53:33 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sat, 31 Aug 2019 19:52:55 -0700
Message-Id: <1567306391-2682-15-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
References: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v7 14/30] riscv: hart: Extract hart realize to
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

Changes in v7: None
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


