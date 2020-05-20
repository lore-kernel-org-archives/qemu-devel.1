Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ED3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7F62065F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PUXU/mcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7F62065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbRj4-0006pk-1L
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 12:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40290bcd2=alistair.francis@wdc.com>)
 id 1jbRi0-0005Bz-OR; Wed, 20 May 2020 12:36:44 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40290bcd2=alistair.francis@wdc.com>)
 id 1jbRhy-0002lk-Sn; Wed, 20 May 2020 12:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589992603; x=1621528603;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=O6p3SU0rWuvXbYL4jojiksBa0f7cc5aFdL7xeuzsdQE=;
 b=PUXU/mcR23A2GXRQHbcL4qVhEirJbTc3OCfWGdQOviw/s5rT6XS5CLKY
 ljZqvBQqq/7GBgM/95fkhPOZc+XzazdcrjSOZC1farPxvX8e8B2hlLd4I
 cjf+affYnadgN2TF1UneP/lI91SeoBJhEhFUcw205EfDvCeXxvlLkH7bn
 KAtufTbMp/Z4W4X1zMcYbKHq3AtBpISPrwX8uf++D0VrMSPkPTsISaIhS
 yQcNcLHNlZy8UqYBqgDI9cpCcaJGlKOAZvN6Guec4mAjGskYcCZRgS+ox
 JAsuKsUCyprnwXGpA1ZePsIyyNZPchsqmEAiubSYgPQKrFFLK4KBPOxhM g==;
IronPort-SDR: 302vhv39QniYj31BVgsVtqTUJj9PPXC7QbufX86/J98nrrGNuyOE9THMB8kM7g1sNn1TDw78WA
 di/Y6vH9nSdki9EJe6uUaZ1o2utKtbwpTD8isHl4qRnIbKpHvixUkemSUxCsrHWs9UyjkdEFhs
 Y2J9jUj31F9nH2GMqEaQej6cu9Zez8V+jqpcKuMefQ0EB/AZOHqSwqUO0+zAbsyzZ4f15bT+MD
 6YC84CZ0AevBUUwyY4wvSvCX5/dpCuimx8wbraI7fFhZsVhB76BItHCxUcbqvYYKiZNeQytHwl
 yfk=
X-IronPort-AV: E=Sophos;i="5.73,414,1583164800"; d="scan'208";a="138468211"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 21 May 2020 00:36:41 +0800
IronPort-SDR: wSVQlTZf/xlsGRFML+054qpgPOSlPECnimtjMwsjS1zqi0QjBPJYojnqT35rkhfA5WS5JmFwg3
 hl6B9Hs2KuepTw8jQiPhJClPWBPpD6Nrg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2020 09:26:43 -0700
IronPort-SDR: hYeWJ+dxBc2JrLpf1djsjbttFYHOtTPG2BTKeg2Hf3eEKN2RCNEA+ODjYv0q9YGVIfyElpVOw9
 Vf91pTnvBhPQ==
WDCIronportException: Internal
Received: from 96yhgc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.51])
 by uls-op-cesaip02.wdc.com with ESMTP; 20 May 2020 09:36:40 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 1/2] riscv: sifive_e: Manually define the machine
Date: Wed, 20 May 2020 09:28:12 -0700
Message-Id: <c717c5f78596d7d080567d847f42310a60835ec9.1589992028.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1589992028.git.alistair.francis@wdc.com>
References: <cover.1589992028.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=40290bcd2=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 12:36:38
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
Cc: alistair.francis@wdc.com, philmd@redhat.com, palmer@dabbelt.com,
 bmeng.cn@gmail.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/sifive_e.h |  4 ++++
 hw/riscv/sifive_e.c         | 41 +++++++++++++++++++++++++++----------
 2 files changed, 34 insertions(+), 11 deletions(-)

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
-- 
2.26.2


