Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF77C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 20:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B21F207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 20:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UzqeHHtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B21F207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZKuE-0002oO-E2
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 16:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=396c018a7=alistair.francis@wdc.com>)
 id 1jZKtE-0001t5-PQ; Thu, 14 May 2020 16:55:36 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:19382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=396c018a7=alistair.francis@wdc.com>)
 id 1jZKtC-0005pz-Ub; Thu, 14 May 2020 16:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589489746; x=1621025746;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Xom2HChFLJ89UsWldjTfWChAxQHA6X3MY/cLxNR/uYk=;
 b=UzqeHHtLu7mh08mylESV8DLrSw4Wi3y2XpZW0dVJnFHVfm8PhSqTe21i
 qdEfAYyha3HCSCmYxnMd01lw5tBibotTMSVFmRvSgvDDnPjVla6hpOR7V
 KQtZPyxTJCiPTvJ6jlgNkTCWZdpDMDNEpxK3NzLISSY1adj2tOgoo50Lj
 xDhcmAgBmCRkADcITuK/A7rNvnsY80aRWubxekxZvVxYwKt/B3oiHFCgp
 nW3U1A1a5unZvlmLvCwz/OSEh2NiUmy06dKZ986W+sFnZPoMz9d2m6EAD
 9OBMcVJO5MzbDjgLNkOVHdg9kDmy3LErNf6O3ff79x5Tx5Xa2AbSnxQJZ w==;
IronPort-SDR: 7Rd+KCSg314htA9VlW/doxZZD9uZipe9SrKzM7l6+f2hxUUKKHJUHKD7/n20JiR5YJT43669If
 Oow+7P18bjA2qSBoZf0lmFV2F+zKy558ooYcruenGlocHKtO+A3U00FO1k91JY0VVqqDridzt9
 z7rP2wfgvKxlxgUcnDimYmkR2lpyAD8hy6RqFYLwApIpZ9tsn7zbll9yrq+1IM/pipvhyom1Mn
 Iy+HKcmk1NiyUnQF7EvICXRZDgERCLxnbyH8d43lQN9UfWwcRWa6H0cQhV1QENaeJXZ2jLXpZ7
 kME=
X-IronPort-AV: E=Sophos;i="5.73,392,1583164800"; d="scan'208";a="240427614"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 15 May 2020 04:55:39 +0800
IronPort-SDR: jO5RPaWuDaP/24IaFDdy9x6wIxpGoZJiXs5UUh3SAWZOoHgN7yvGnB617glzcFbYuJ9vLc856A
 z8LdI+Va5AB+/+5IhLsFyFwFZNqKbQ160=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2020 13:45:08 -0700
IronPort-SDR: J0DgQ/0JTQrxW683D6D89uuxSVhLyItBESuHFNpRLsqDWYrybB6pYVoH6mDanr6s8IRvKpBRh4
 0mu3xD/Apu2Q==
WDCIronportException: Internal
Received: from 327gvz1.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.233])
 by uls-op-cesaip01.wdc.com with ESMTP; 14 May 2020 13:55:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 1/2] riscv: sifive_e: Manually define the machine
Date: Thu, 14 May 2020 13:47:07 -0700
Message-Id: <da77b1e0a31f2f8fb18117b20a1493ab1ec0471f.1589489213.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=396c018a7=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 16:55:30
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_e.c         | 41 +++++++++++++++++++++++++++----------
 include/hw/riscv/sifive_e.h |  4 ++++
 2 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index b53109521e..472a98970b 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -79,7 +79,7 @@ static void riscv_sifive_e_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = sifive_e_memmap;
 
-    SiFiveEState *s = g_new0(SiFiveEState, 1);
+    SiFiveEState *s = RISCV_E_MACHINE(machine);
     MemoryRegion *sys_mem = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     int i;
@@ -115,6 +115,35 @@ static void riscv_sifive_e_init(MachineState *machine)
     }
 }
 
+static void sifive_e_machine_instance_init(Object *obj)
+{
+}
+
+static void sifive_e_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "RISC-V Board compatible with SiFive E SDK";
+    mc->init = riscv_sifive_e_init;
+    mc->max_cpus = 1;
+    mc->default_cpu_type = SIFIVE_E_CPU;
+}
+
+static const TypeInfo sifive_e_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("sifive_e"),
+    .parent     = TYPE_MACHINE,
+    .class_init = sifive_e_machine_class_init,
+    .instance_init = sifive_e_machine_instance_init,
+    .instance_size = sizeof(SiFiveEState),
+};
+
+static void sifive_e_machine_init_register_types(void)
+{
+    type_register_static(&sifive_e_machine_typeinfo);
+}
+
+type_init(sifive_e_machine_init_register_types)
+
 static void riscv_sifive_e_soc_init(Object *obj)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -214,16 +243,6 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
         &s->xip_mem);
 }
 
-static void riscv_sifive_e_machine_init(MachineClass *mc)
-{
-    mc->desc = "RISC-V Board compatible with SiFive E SDK";
-    mc->init = riscv_sifive_e_init;
-    mc->max_cpus = 1;
-    mc->default_cpu_type = SIFIVE_E_CPU;
-}
-
-DEFINE_MACHINE("sifive_e", riscv_sifive_e_machine_init)
-
 static void riscv_sifive_e_soc_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index 25ce7aa9d5..414992119e 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -47,6 +47,10 @@ typedef struct SiFiveEState {
     SiFiveESoCState soc;
 } SiFiveEState;
 
+#define TYPE_RISCV_E_MACHINE MACHINE_TYPE_NAME("sifive_e")
+#define RISCV_E_MACHINE(obj) \
+    OBJECT_CHECK(SiFiveEState, (obj), TYPE_RISCV_E_MACHINE)
+
 enum {
     SIFIVE_E_DEBUG,
     SIFIVE_E_MROM,
-- 
2.26.2


