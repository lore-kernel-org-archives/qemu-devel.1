Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6856CC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:26:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33616206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O2/ibXdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33616206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoVn-0003go-PC
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50935)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFf-0007fe-DL
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFe-0007qu-55
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:23 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36298)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFd-0007nc-VB
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:22 -0500
Received: by mail-wm1-x343.google.com with SMTP id p17so6224784wma.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=oFUUQobexKmEiGcHc00gtIO7FQq8Xq2VFD8z4YpIbXU=;
 b=O2/ibXdp/R2HNKVFg9vgznlZ9Rs7S0/UyMbitKpb3gHOG/KXDb15dZRPn/orXtyE8m
 5LtRN5DSwo/R4dOUWGVUVQaOE+6tkql7W6W9URa/Niz4+U7CcFd4ADmwFt6BODt+fwHo
 TGgzjh/8IVPPMhOquRUOClouqnwrLPbtXggY+XtOMB9/hEIcOKps0zrbfY5KE82A2zkY
 qfOTX+Bh17RU9/F5BJyl7vmsBhJZIL/j+lQ3i5KGA4Q3Acnl29gylLkD3dZ8nE8AyGz4
 OiujELXODU3Rfi+UinYJVfysaxXGHmBehpI5XMD4cTP3Z12onT5IzXQVUpJavSmqHEhu
 LR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oFUUQobexKmEiGcHc00gtIO7FQq8Xq2VFD8z4YpIbXU=;
 b=U/9gg3u2CzWqVzkL6LR/8/ogxrTg+ruBAa+zSLPxf6f7t7xyoliB/ezOkIeH8vXckd
 mtB94kgN485FqUCqJQ20Sc7aYhm9rn/f82jKct6A0B8aUUA/gXTzeLvCP0nctwgZqMup
 zzTwq7MvidwS88Ad4WKO1uQ7HPgEsLmMrvQrNCZNX+/VkxcLDCeOK0C0ZVDGqbihLeEQ
 sgwO6Pr4AqihDj4uDRdyH7Vw2dM2rQ3IeXC3r+sVzKlROVN1EWfJZBS2Unwk3MhjmxRf
 O8Li66zObqiTlEKYYyg34bT9zyxhGcf8LtkpDuCy0tQDL7HP2a0O+n7P1L3pWz8dEvxg
 gVCg==
X-Gm-Message-State: APjAAAX3LEJi2KEdYUao/dzce614ZY1Ioi3DVQ/IsJzVV9y9eFErEHB9
 Ep3ZQaoxInZyy+j8oQ/xUEINcmQGv/GcOw==
X-Google-Smtp-Source: APXvYqyylastqGrQXAl8xNNK5fyzbyH6O8gEB2z+TuXcSvCK6UnEELalme4yxD/fxBe+YU3LC7KsVw==
X-Received: by 2002:a1c:dc08:: with SMTP id t8mr30838010wmg.139.1576494560782; 
 Mon, 16 Dec 2019 03:09:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/34] aspeed/smc: Restore default AHB window mapping at reset
Date: Mon, 16 Dec 2019 11:08:42 +0000
Message-Id: <20191216110904.30815-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

From: Cédric Le Goater <clg@kaod.org>

The current model only restores the Segment Register values but leaves
the previous CS mapping behind. Introduce a helper setting the
register value and mapping the region at the requested address. Use
this helper when a Segment register is set and at reset.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20191119141211.25716-11-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/aspeed_smc.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index f0c7bbbad30..955ec21852a 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -475,10 +475,26 @@ static bool aspeed_smc_flash_overlap(const AspeedSMCState *s,
     return false;
 }
 
+static void aspeed_smc_flash_set_segment_region(AspeedSMCState *s, int cs,
+                                                uint64_t regval)
+{
+    AspeedSMCFlash *fl = &s->flashes[cs];
+    AspeedSegments seg;
+
+    s->ctrl->reg_to_segment(s, regval, &seg);
+
+    memory_region_transaction_begin();
+    memory_region_set_size(&fl->mmio, seg.size);
+    memory_region_set_address(&fl->mmio, seg.addr - s->ctrl->flash_window_base);
+    memory_region_set_enabled(&fl->mmio, true);
+    memory_region_transaction_commit();
+
+    s->regs[R_SEG_ADDR0 + cs] = regval;
+}
+
 static void aspeed_smc_flash_set_segment(AspeedSMCState *s, int cs,
                                          uint64_t new)
 {
-    AspeedSMCFlash *fl = &s->flashes[cs];
     AspeedSegments seg;
 
     s->ctrl->reg_to_segment(s, new, &seg);
@@ -529,13 +545,7 @@ static void aspeed_smc_flash_set_segment(AspeedSMCState *s, int cs,
     aspeed_smc_flash_overlap(s, &seg, cs);
 
     /* All should be fine now to move the region */
-    memory_region_transaction_begin();
-    memory_region_set_size(&fl->mmio, seg.size);
-    memory_region_set_address(&fl->mmio, seg.addr - s->ctrl->flash_window_base);
-    memory_region_set_enabled(&fl->mmio, true);
-    memory_region_transaction_commit();
-
-    s->regs[R_SEG_ADDR0 + cs] = new;
+    aspeed_smc_flash_set_segment_region(s, cs, new);
 }
 
 static uint64_t aspeed_smc_flash_default_read(void *opaque, hwaddr addr,
@@ -897,10 +907,10 @@ static void aspeed_smc_reset(DeviceState *d)
         qemu_set_irq(s->cs_lines[i], true);
     }
 
-    /* setup default segment register values for all */
+    /* setup the default segment register values and regions for all */
     for (i = 0; i < s->ctrl->max_slaves; ++i) {
-        s->regs[R_SEG_ADDR0 + i] =
-            s->ctrl->segment_to_reg(s, &s->ctrl->segments[i]);
+        aspeed_smc_flash_set_segment_region(s, i,
+                    s->ctrl->segment_to_reg(s, &s->ctrl->segments[i]));
     }
 
     /* HW strapping flash type for the AST2600 controllers  */
-- 
2.20.1


