Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227AEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E10342072F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWMnxlz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10342072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIgC-0008ME-5H
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIbY-00018k-VG; Mon, 08 Jun 2020 10:18:25 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIbX-0004Ua-T8; Mon, 08 Jun 2020 10:18:24 -0400
Received: by mail-pf1-x441.google.com with SMTP id a127so8587953pfa.12;
 Mon, 08 Jun 2020 07:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/vk8h8B6uTwCemZZoAx6aAehDYIy0T5OpDNP5dyOEg8=;
 b=PWMnxlz+hgZhCH6jZVuChUUCvIg3CooTpEKoGq1BRb50qbXkSutJ5PI6j1M12eni+J
 iliMqppxU6JC/lCxACkFCsQ5BxjuMBRjyOTIlmY94EArTyLoMExjR6GDXsC3+wgxrbQG
 HVBwb08nyhoiWIyEqBLnLwn8PJUz2lk9BnP2RLdofuPLVASOsnHy5Gyj07iFz4c2JCDy
 TljmQpO4ri7iFV2IGAmNkOwNsbVdYzmdYobnucwN0o14/FtQPjg/vXJYZCpVOZ1pvoip
 S0PSX+CfcuflafVLA7ASsNF2ZZSx88DFOJM2MG4zmJZtBaj2RbmDDTJ02HQmCAugfn7l
 CilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/vk8h8B6uTwCemZZoAx6aAehDYIy0T5OpDNP5dyOEg8=;
 b=ad7/PJqG3udBVCYH3MHY3laMfIRkHdm2tizy+LLjk4NPm4fg2m2QX0XS4TdYsC0nQq
 gqUZYG9Q3zTRjg8DjUIc55FfSqzhxsknKngXKXLd2NCm/vPsy7502JHGY7DLHoHkRae6
 hyApHwI3d5+WWNareQcME5SUqn/BB8WP7dUBMqwr+4gomL81rGl3CF1lDX0cVHMWJ0Fc
 JzBRqrjtSDiV48cRUkcNGvA3Ahu/dKl/E8axTtTfpXjLYUG53UoUkE7o+Flgf7angOeh
 f1BsqSxYvHovqeBf6aYnjdx8Gi2+Z/X7CBYVo75SfqbeWPDc/4ghbF11jtlZtnqvKFfx
 hZQw==
X-Gm-Message-State: AOAM533ak7rtCBGuVhY0fji1i7vvTxSHsWSHu395tiHCW88xF1tD8DHk
 VsoQX3p3uQxJHlvj/e9nOCw=
X-Google-Smtp-Source: ABdhPJzK0Pwok2eWDwdSTmmbn7oPRpeQB8vXlquZ111ZbOOkcJKSpYixtEFPmMSQe0e4sD5n9YFbVw==
X-Received: by 2002:a62:2f45:: with SMTP id v66mr22654828pfv.45.1591625902256; 
 Mon, 08 Jun 2020 07:18:22 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id b19sm7292575pft.74.2020.06.08.07.18.21
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 08 Jun 2020 07:18:21 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 05/15] hw/riscv: sifive_gpio: Clean up the codes
Date: Mon,  8 Jun 2020 07:17:34 -0700
Message-Id: <1591625864-31494-6-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Do various minor clean-ups to the exisiting codes for:

- coding convention conformance
- remove unnecessary blank lines
- spell SiFive correctly

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/sifive_gpio.c         | 13 +++++--------
 include/hw/riscv/sifive_gpio.h |  7 ++++---
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/hw/riscv/sifive_gpio.c b/hw/riscv/sifive_gpio.c
index 5c7c596..c9cffa2 100644
--- a/hw/riscv/sifive_gpio.c
+++ b/hw/riscv/sifive_gpio.c
@@ -1,5 +1,5 @@
 /*
- * sifive System-on-Chip general purpose input/output register definition
+ * SiFive System-on-Chip general purpose input/output register definition
  *
  * Copyright 2019 AdaCore
  *
@@ -20,7 +20,6 @@
 
 static void update_output_irq(SIFIVEGPIOState *s)
 {
-
     uint32_t pending;
     uint32_t pin;
 
@@ -186,7 +185,7 @@ static uint64_t sifive_gpio_read(void *opaque, hwaddr offset, unsigned int size)
 }
 
 static void sifive_gpio_write(void *opaque, hwaddr offset,
-                       uint64_t value, unsigned int size)
+                              uint64_t value, unsigned int size)
 {
     SIFIVEGPIOState *s = SIFIVE_GPIO(opaque);
 
@@ -318,7 +317,6 @@ static void sifive_gpio_reset(DeviceState *dev)
     s->out_xor = 0;
     s->in = 0;
     s->in_mask = 0;
-
 }
 
 static const VMStateDescription vmstate_sifive_gpio = {
@@ -342,8 +340,8 @@ static const VMStateDescription vmstate_sifive_gpio = {
         VMSTATE_UINT32(iof_en,    SIFIVEGPIOState),
         VMSTATE_UINT32(iof_sel,   SIFIVEGPIOState),
         VMSTATE_UINT32(out_xor,   SIFIVEGPIOState),
-        VMSTATE_UINT32(in, SIFIVEGPIOState),
-        VMSTATE_UINT32(in_mask, SIFIVEGPIOState),
+        VMSTATE_UINT32(in,        SIFIVEGPIOState),
+        VMSTATE_UINT32(in_mask,   SIFIVEGPIOState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -356,7 +354,6 @@ static void sifive_gpio_init(Object *obj)
             TYPE_SIFIVE_GPIO, SIFIVE_GPIO_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 
-
     for (int i = 0; i < SIFIVE_GPIO_PINS; i++) {
         sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[i]);
     }
@@ -371,7 +368,7 @@ static void sifive_gpio_class_init(ObjectClass *klass, void *data)
 
     dc->vmsd = &vmstate_sifive_gpio;
     dc->reset = sifive_gpio_reset;
-    dc->desc = "sifive GPIO";
+    dc->desc = "SiFive GPIO";
 }
 
 static const TypeInfo sifive_gpio_info = {
diff --git a/include/hw/riscv/sifive_gpio.h b/include/hw/riscv/sifive_gpio.h
index fce03d6..ad915b2 100644
--- a/include/hw/riscv/sifive_gpio.h
+++ b/include/hw/riscv/sifive_gpio.h
@@ -1,5 +1,5 @@
 /*
- * sifive System-on-Chip general purpose input/output register definition
+ * SiFive System-on-Chip general purpose input/output register definition
  *
  * Copyright 2019 AdaCore
  *
@@ -10,10 +10,12 @@
  * This code is licensed under the GPL version 2 or later.  See
  * the COPYING file in the top-level directory.
  */
+
 #ifndef SIFIVE_GPIO_H
 #define SIFIVE_GPIO_H
 
 #include "hw/sysbus.h"
+
 #define TYPE_SIFIVE_GPIO "sifive_soc.gpio"
 #define SIFIVE_GPIO(obj) OBJECT_CHECK(SIFIVEGPIOState, (obj), TYPE_SIFIVE_GPIO)
 
@@ -66,7 +68,6 @@ typedef struct SIFIVEGPIOState {
     uint32_t out_xor;
     uint32_t in;
     uint32_t in_mask;
-
 } SIFIVEGPIOState;
 
-#endif
+#endif /* SIFIVE_GPIO_H */
-- 
2.7.4


