Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F67C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73EA22151B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fXxsX6a1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73EA22151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY8wS-0006gP-4u
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8ry-0001Yw-Rj
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:25:39 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8rw-0005fQ-QN
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603981536; x=1635517536;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g4WdlHNUsSqm5IYl1xQpaPDV/gYQAaTlwhWn8+X0BO0=;
 b=fXxsX6a1HJb7QjQNgJYB8acRN1hRqfjzDt94qkLb5sfw5LMLr60Bn9GD
 yftuCPtH9o5w/IzU0LKDk6yQNfMIVesxXgdVVDnvJtc0Wgv8o9/uYDWHJ
 YSF41nWao/tmZ4eDVHm4QVmIiTi4195VnbJm1vF31ILMBxMj+I6tPfe8O
 9ip7iwCGMXRIycw/N3KTnD8UYsUPE8rHfnJ987LRiE5OSpddgVn8IxgGv
 TQ2co4vrdyRVWmveij/rPClntrBwkyqLQL91rnAR5hsLMQvEROAcQiYGb
 zL5X0bAK/HeV977mYOKxPjWSiO20h+LEIbL454b/i7vktSPzaAnJrBpCu w==;
IronPort-SDR: OrmVCNKqJ92yfJD8yqtnEknxXjYkJ8s5DHa9OVuyRbFanvymv+GGaii+LimnGHaRLC+TLBZi1/
 0KR9mN1z5/cDtwsKaRrXA5NG6XskOj8sgxN+bD1TxOuIeiq+y3sTIf8Kv0vF6Sz4lHBKvYK6CO
 1p5H77l7oLhyQfgyGc96Ix4/S8bI/RoQMue4dTUv9fgJRA+x99gr71cuY5HUm2YnOE37MzB8Jm
 7EMVRxKp6K/EfXdyQIwIo+otJ5crXrYMxWIzXOB3VwZYBnHyNIOCdqkVczZ5FWZu9eD4YmxFzQ
 qus=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; d="scan'208";a="151317884"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 22:25:28 +0800
IronPort-SDR: 1D+IQcwbfnLHRfX8v7wOBAn6oe/0d6zWiNc+eXuKTSj4gCMyU8d5NJwAbx5HWYVptRgAg/G0GN
 lRkxz+GN2gD53PPWFSevQERxR6q8YbA4HAEwLYWNLd0lWdztPdbh0nSybkuL4EMC2DmmmkgFs+
 4GvGWqm+7u33a6K6OpM9eVuZL2t+ToS+CmHsFNhagT2B55yyPL8ntWeaSj1t2IpiNJMWveGYgB
 OlkbX6N92uS0shsk0g8TGsyRe5UCp9qxocy+hzW50jvKHFFzt7kNb514ePLFkVCyoVaqxIxbLH
 0W7YG/G/6v52fwml34IoFVB7
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 07:11:43 -0700
IronPort-SDR: m/BpHhmTfDtR+uerBV3x5/Zre4Vvb1dvFznU5t6P3K91Ngd7b7HynRA+DqdyfL9ag61glsPIft
 xqTEJgzTHu20pHK9m9F0ZnFvtwkcr2gDeq8m/0DAGzA36vNwYvd6YrFJWTykwGwiwoyWlY5pvL
 jXn2dqoHPi2k91taLTzWmVd/n/Gb/T/qfgU0ZoNmgZbZI6Q1adrIlkFwBKHTdfC9+0901l4GeS
 y5Wjp0gqU6i/p9xjMXtPmbTp9V7WjTQFDpAJSgxgh2FOBlY1DjsNsaNYvZSt7O+N5MEiqlOqAC
 1+M=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.131])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 07:25:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 08/18] target/riscv: Add sifive_plic vmstate
Date: Thu, 29 Oct 2020 07:13:48 -0700
Message-Id: <20201029141358.3102636-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029141358.3102636-1-alistair.francis@wdc.com>
References: <20201029141358.3102636-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=56447669b=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 10:25:26
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


