Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EADC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B61C208D5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o2Iur9HP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B61C208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKhV-00060f-LU
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUO-0000rg-4E
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:41 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUG-0004Q3-LY
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586457; x=1624122457;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4Ag3dG3gO5iJShtsvDkPTUJzzzPAJlVfRVRDsoWCqx0=;
 b=o2Iur9HPwTx3NLtSqBxYLv36RtWuF03Zdow6BwiBQvIRBXaO6OsXMFPd
 Us9S2rZ8D5XptPK7FzNk2p44ApWQl5DOicJBeD2a6gXClI1zpdItMWWte
 KcWTm2aVX18ukhfkrULgQtsdg2PwToWDP5nuIiJA8IH3LNBcxXUMGrFAD
 muaVIAHkVCyO7X0cyrpZJBRY8CP0NdrUtZ3h98RRzystYxbi8aktFTUUk
 6H4EgvEcGPRN2405VBBOsah6dHCz3r9BoGitMF1KqdNYxdLZO+WJPEywr
 eAvP9tAvMI0tw1INU7S1CaaaIKb92t6appwcbM6MhNJLMgzN55ht21m3J Q==;
IronPort-SDR: 2wbGMnErFY+zQZSHyMbkR+Z1PxetB0QEK00+3NcSWqzwCrbismtUcniUn4k4qK9uUngG9r1h5O
 AV63LpgSxjXrO5eL4mcuLZxDbyFClyFF70X6NyP+e2lL+3r1AA8wTGtZDgaQVcfO+YSvyIwlTy
 6JVRxgcUyzZZr61mlgMTQrWVKqoX+we+f8B6EEHPFJvyseywPlmAUs8A/1ivnkJOEpinU8s41Z
 jOW19rvsCthxYmY2FfijUKJ8yJXfY9LYrinBBVvLIhHTyJMFTi7ZAbVldYHR/FzB9RDHED/vvO
 6ZY=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="243417005"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:28 +0800
IronPort-SDR: qDC0zaLiwgNKKviT3xufOVTbF+WPMvVIfPMJ1uyNIbNhvKW0LZjpqgoEKbFo8D/6vRXVIE4OF7
 Ml+kSQv1+ciN6z5vu+GmlPnfDhGTYh6/w=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:56:03 -0700
IronPort-SDR: hQnxKYaYSn3YmJsSWkuJgVikTNj0fyt72a8/9DSKuONaPINRdMsMSGRr2lwdi0DAV3yxb32ViS
 AjWaeLYvpwkw==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:26 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 21/32] hw/riscv: sifive_gpio: Clean up the codes
Date: Fri, 19 Jun 2020 09:58:06 -0700
Message-Id: <20200619165817.4144200-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619165817.4144200-1-alistair.francis@wdc.com>
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 13:07:24
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Do various minor clean-ups to the exisiting codes for:

- coding convention conformance
- remove unnecessary blank lines
- spell SiFive correctly

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1591625864-31494-6-git-send-email-bmeng.cn@gmail.com
Message-Id: <1591625864-31494-6-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/sifive_gpio.h |  7 ++++---
 hw/riscv/sifive_gpio.c         | 13 +++++--------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/include/hw/riscv/sifive_gpio.h b/include/hw/riscv/sifive_gpio.h
index fce03d6c41..ad915b26d6 100644
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
diff --git a/hw/riscv/sifive_gpio.c b/hw/riscv/sifive_gpio.c
index 5c7c596e6b..c9cffa2eba 100644
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
-- 
2.27.0


