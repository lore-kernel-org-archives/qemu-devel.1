Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055FFC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 17:42:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC9552076C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 17:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oMK3CrFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9552076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAcy7-0003FG-4N
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 13:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAcwk-0002KI-S0
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 13:41:23 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:48241)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAcwh-0001AU-MO
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 13:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598377280; x=1629913280;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=x4Qcokgqs5OXpEujeFu7AYcPL4xuwYfManp7h1/6rJQ=;
 b=oMK3CrFG1tqyeIyqBuT9fkapTQsiIyBFmbnIDgcPmlVtQCwPO76UgB/v
 VEGl8oqU7ipaD6iKYDItlq6nqkQyDR0zaHP8IzHXoQ3yhtCaLh95/ea7D
 jeoXCG93+cIsWhtmAXAYJ1ai55YAsJWb8jyPpJzFsk0hYczTrFkVf9zH5
 8xm7eGfVIHR376AXECsbpx0qe+coajEjoZoXLAakLc1KaECCF5SpxloXH
 WZhwX5wQbiy5fKw8ZkrZyyGL2+9RDpesrtW8a25l+SLNHnKuj5SxSRrRk
 b+1X6S7sUwVPf0YD9HA4PpUuyZZwMDQ5dLcUIRKcjaTu1q46HRI2TCD0N g==;
IronPort-SDR: sMBmFhNPSiscRSoE8Sb9lpfqMVxDSAFg3vGwzNirNxCCRfxt90e0aU0C2qzBHBQfT5x0Cjn2pQ
 28b930/6NvMwGoD80Zq3pU4d+gr2Nqvbgsni4ycYkY9mNofqHxt0Ee1S4S1EfeWxjOYeOJ8yWY
 3P/25QMRSDc4o7i7uZWnyLS21CDGj0lmPYYvXz2/ro3J1WwCXC9LDARjiH/rtcFNxbKC1ZpKq9
 MBJelrJTl19oEg5LtNiNVgXtSeyLcy7dL+JrTBCBiUOlX/Syj+Jtx+zDtKcZsL9UMQL5tF77AR
 tR8=
X-IronPort-AV: E=Sophos;i="5.76,353,1592841600"; d="scan'208";a="147029867"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2020 01:41:16 +0800
IronPort-SDR: 8OCAlGgHx1ApOJdlFc5sv+veFE2qiRkhlNw1x/UQSIGyen0oCZhZXP9LY8p5SRMYHTJZ8eotkT
 pxQmESMj4Qrg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 10:28:51 -0700
IronPort-SDR: w1Cy7YF/HxQ6H2quv1voxrw4NeuSCqNvfQljtqWqgGD01Po1/sSx3YXt3IEPuO9SG61TzB/7NI
 xZD8r08ON+eA==
WDCIronportException: Internal
Received: from ind003389.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.125])
 by uls-op-cesaip01.wdc.com with ESMTP; 25 Aug 2020 10:41:15 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	ehabkost@redhat.com
Subject: [PATCH v2 1/1] core/register: Specify instance_size in the TypeInfo
Date: Tue, 25 Aug 2020 10:30:59 -0700
Message-Id: <4cf1beb7dafb9143c261d266557d3173bf160524.1598376594.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=49978a6e9=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 13:41:16
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
Cc: alistair23@gmail.com, alistair.francis@wdc.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reported-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/core/register.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/hw/core/register.c b/hw/core/register.c
index ddf91eb445..31038bd7cc 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -176,17 +176,6 @@ void register_reset(RegisterInfo *reg)
     }
 }
 
-void register_init(RegisterInfo *reg)
-{
-    assert(reg);
-
-    if (!reg->data || !reg->access) {
-        return;
-    }
-
-    object_initialize((void *)reg, sizeof(*reg), TYPE_REGISTER);
-}
-
 void register_write_memory(void *opaque, hwaddr addr,
                            uint64_t value, unsigned size)
 {
@@ -269,13 +258,18 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
         int index = rae[i].addr / data_size;
         RegisterInfo *r = &ri[index];
 
-        *r = (RegisterInfo) {
-            .data = data + data_size * index,
-            .data_size = data_size,
-            .access = &rae[i],
-            .opaque = owner,
-        };
-        register_init(r);
+        if (data + data_size * index == 0 || !&rae[i]) {
+            continue;
+        }
+
+        /* Init the register, this will zero it. */
+        object_initialize((void *)r, sizeof(*r), TYPE_REGISTER);
+
+        /* Set the properties of the register */
+        r->data = data + data_size * index;
+        r->data_size = data_size;
+        r->access = &rae[i];
+        r->opaque = owner;
 
         r_array->r[i] = r;
     }
@@ -329,6 +323,7 @@ static const TypeInfo register_info = {
     .name  = TYPE_REGISTER,
     .parent = TYPE_DEVICE,
     .class_init = register_class_init,
+    .instance_size = sizeof(RegisterInfo),
 };
 
 static void register_register_types(void)
-- 
2.28.0


