Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641A4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0336720780
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dtOlCLt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0336720780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyQV-0003e0-VO
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJV-0001bM-Kx
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:33:37 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:14996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJS-0001EJ-RO
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604417615; x=1635953615;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g4WdlHNUsSqm5IYl1xQpaPDV/gYQAaTlwhWn8+X0BO0=;
 b=dtOlCLt3IkE6aVP9LBANvkQbezCH7yaZTpba/j7ngfJMlc+s/tMvwMbu
 U9GsqgHN/bs/uneiN5J+9jJPTAf5LccM2TVdynXSyzSLAhJ+kZQX6L0PR
 +77yK1dMJy4ggeiPdeRPvJ8c/WmXsW5VwlALPqZcD3XBQR7kH55PS4fy2
 T+mEUYYl/2EGpbWT4lHKBlj96JQ8jDxuGMdJagqYh3bbr+2TINMDWMR/D
 yeCI8VBAP/Hy+Z+yg76WkhFuK+Nf6KqgkFpREZmkZ1GahwcdB53Rn+sJQ
 +2XTPZukclV3pCBoCQZ6ded8nVWk6R+pX/vX7Gtuv0vAPlIp3rUQbx9ks Q==;
IronPort-SDR: hDo9LPVF1pEKiVED61HUAjvxmdX0QHENUZQGAy/7gtzzMclY+1tcnfyL2Js5NkWDmRG3xd1cNK
 8/Uj88YtxjoYTiE4xm8e+cxHBvLdsRNp5clWvKe6syHjd+LhjWydDxvq7dDJQ+vcZAdWOP9eu1
 S3Rpw5QR4EJ2IoR2a4yIV/xUfnENKozq6JNnwDH7ex/2esHSRVqeXW5JDq/aIjFp/LWDit0PXJ
 G17Wo5ghpmgGvKuEWdJfZ6DAyt4h+pYs4/Vfe9B8zFnwGFIlOCsfXk96liXnO6r+PATnJKzwH1
 tL0=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="152867465"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 23:33:26 +0800
IronPort-SDR: iC7plak0tBkWUXGG9ie4QnfHTNAr1ZpGlpvacY4XQ9H4mryFjTpXyBOj6XgXm2A4fbjDCwjq+N
 p4LGZB78QjIypmaUZBl042CfCVYlSLydGg/A5JIrm3G4TckcN9sVGixnC4e1UuIr7oLIyHYglK
 0mKgllcLqeiYmvU3S7Ebe0+YPAUhr4USP/Zi6czzX6SUDxq778SV6yPdhIZzbJ99hivbPLTA7I
 1KlAQDd9kNfSVJ3HRaPvpFgaeajfOzaezEEs/r7LrrephTws3N0ETD+0pHnBCiukTMHYdtLMhv
 fSLGWup9/tsoPXcA0FcTDQCu
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 07:19:34 -0800
IronPort-SDR: eOqWtonO9HwqCFgkUMpS5s285aYyZzZFl39sZx40qnepr9cdHxm0meCE0ZCP3AAJILYPFhLkC8
 2IzCOrdKqvflpmDCAqAWNKhbABAvex6SPQngW//I675ImrfdkkLsRj4XwupAnTYvxTfM5+d4oM
 bSckxfYrnP1kCbnuCO9FgUhTrNxDDntJpcaUuyXyd7/nOBfFGRu1++v/j7DNz+Tvoq3ksMBGJS
 1Vv+EPlWPLP6lZ4sPdzvcfLuYionv/zhpp+AD5lLzYtxnRKHgwIfVnCOs5yD3yUbpXG5v7caPD
 Sts=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 07:33:26 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL v2 08/19] target/riscv: Add sifive_plic vmstate
Date: Tue,  3 Nov 2020 07:21:39 -0800
Message-Id: <20201103152150.2677566-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103152150.2677566-1-alistair.francis@wdc.com>
References: <20201103152150.2677566-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=569a91e0c=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 10:33:23
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Yifei Jiang <jiangyifei@huawei.com>, Yipeng Yin <yinyipeng1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yifei Jiang <jiangyifei@huawei.com>

Add sifive_plic vmstate for supporting sifive_plic migration.
Current vmstate framework only supports one structure parameter
as num field to describe variable length arrays, so introduce
num_enables.

Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20201026115530.304-7-jiangyifei@huawei.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/intc/sifive_plic.h |  1 +
 hw/intc/sifive_plic.c         | 26 +++++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/hw/intc/sifive_plic.h b/include/hw/intc/sifive_plic.h
index b75b1f145d..1e451a270c 100644
--- a/include/hw/intc/sifive_plic.h
+++ b/include/hw/intc/sifive_plic.h
@@ -52,6 +52,7 @@ struct SiFivePLICState {
     uint32_t num_addrs;
     uint32_t num_harts;
     uint32_t bitfield_words;
+    uint32_t num_enables;
     PLICAddr *addr_config;
     uint32_t *source_priority;
     uint32_t *target_priority;
diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index f42fd695d8..97a1a27a9a 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -30,6 +30,7 @@
 #include "hw/intc/sifive_plic.h"
 #include "target/riscv/cpu.h"
 #include "sysemu/sysemu.h"
+#include "migration/vmstate.h"
 
 #define RISCV_DEBUG_PLIC 0
 
@@ -448,11 +449,12 @@ static void sifive_plic_realize(DeviceState *dev, Error **errp)
                           TYPE_SIFIVE_PLIC, plic->aperture_size);
     parse_hart_config(plic);
     plic->bitfield_words = (plic->num_sources + 31) >> 5;
+    plic->num_enables = plic->bitfield_words * plic->num_addrs;
     plic->source_priority = g_new0(uint32_t, plic->num_sources);
     plic->target_priority = g_new(uint32_t, plic->num_addrs);
     plic->pending = g_new0(uint32_t, plic->bitfield_words);
     plic->claimed = g_new0(uint32_t, plic->bitfield_words);
-    plic->enable = g_new0(uint32_t, plic->bitfield_words * plic->num_addrs);
+    plic->enable = g_new0(uint32_t, plic->num_enables);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &plic->mmio);
     qdev_init_gpio_in(dev, sifive_plic_irq_request, plic->num_sources);
 
@@ -472,12 +474,34 @@ static void sifive_plic_realize(DeviceState *dev, Error **errp)
     msi_nonbroken = true;
 }
 
+static const VMStateDescription vmstate_sifive_plic = {
+    .name = "riscv_sifive_plic",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+            VMSTATE_VARRAY_UINT32(source_priority, SiFivePLICState,
+                                  num_sources, 0,
+                                  vmstate_info_uint32, uint32_t),
+            VMSTATE_VARRAY_UINT32(target_priority, SiFivePLICState,
+                                  num_addrs, 0,
+                                  vmstate_info_uint32, uint32_t),
+            VMSTATE_VARRAY_UINT32(pending, SiFivePLICState, bitfield_words, 0,
+                                  vmstate_info_uint32, uint32_t),
+            VMSTATE_VARRAY_UINT32(claimed, SiFivePLICState, bitfield_words, 0,
+                                  vmstate_info_uint32, uint32_t),
+            VMSTATE_VARRAY_UINT32(enable, SiFivePLICState, num_enables, 0,
+                                  vmstate_info_uint32, uint32_t),
+            VMSTATE_END_OF_LIST()
+        }
+};
+
 static void sifive_plic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_props(dc, sifive_plic_properties);
     dc->realize = sifive_plic_realize;
+    dc->vmsd = &vmstate_sifive_plic;
 }
 
 static const TypeInfo sifive_plic_info = {
-- 
2.28.0


