Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B70C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60ED220851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kKac+OuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60ED220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37493 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hToiI-0006b8-Ha
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:28:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTodr-0002r8-13
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTodo-00073l-Kj
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:22 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTodj-0006xh-AM
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:17 -0400
Received: by mail-wr1-x443.google.com with SMTP id b18so6482751wrq.12
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 07:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=exxIKDT1hSlWQGoFaTkC2wgALrrl2HNKcUB/LvRbfDw=;
	b=kKac+OuO8Ys/0dUOT7UXZK9TgxDQygzqM510cJ15czSxywllaipYrkxsSMss0bMAlV
	z3jh1V75aGxqx3x6IqrVRPzPDomUcOBX9vp8fJRQwF8wx7V/GuY7TgpLpcbR7fX3euFM
	GOLH72RYElH8qGndJSNWM1dIq+Cm1UE4+0iImBY9EZHNa/BEQzZ5y+3MFsbm8VyzCPy+
	ajM29H++5bik2I88QQF2nT+gorN/3kEkc90MB35lMhBGTJvLGMm4YIqKkwy86rSIB20C
	NZfy7q70W2YTE/1OjLYoGm3plZRbnRQFAU6CLfm4qPW00KqDUKEeAD9MhDciHRVEj4kL
	1+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=exxIKDT1hSlWQGoFaTkC2wgALrrl2HNKcUB/LvRbfDw=;
	b=HBvuP1fAO4TOG3UJ9+HsVtaXKqM3SOjxyB5rUZXuew63Ek1zaAEXk2ZNC6RXuvj6dH
	BxmMHb410RGT4p3HDLFQ1ArLJYbmVX9nF+vuIQ6FCcaySpOn0bxp6gRr4G+1rhGG5VnS
	mk6cLGydrsZVhtTvtqjfyn3G/BdoJ2CC91v9xQhJ8g4e3rQz7u8YjMaTXWjG6PB1APtR
	RkpAsw5UVzGVkC7IcavwkfISpkcBTbUAHdM3+BfXZ4ponRV/0QM+YpYEBP2V58MrvRQ6
	wtL9B05oTq6yzBUvf23tMo/zeradtG12zkC2W15rECOw1MYIT5IbBoskyBowNvVtASyx
	bZyw==
X-Gm-Message-State: APjAAAV/AmPEqVvGmkB0FLAMw0hZVGMuqH24UUkMqmcUSRI6GnKwq5CN
	2u0yuQpuD+mrVqQ+ADOhyPTTVaXjxXEk4g==
X-Google-Smtp-Source: APXvYqzy2fQ/0R7ay3cOVH2OOgJM5nObo8eh5feRuIvIXJdKU9Wtyr4wPH+87FX4TGEFy+5QNkUWKQ==
X-Received: by 2002:adf:f6c4:: with SMTP id y4mr33407175wrp.37.1558621452353; 
	Thu, 23 May 2019 07:24:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id z5sm9700617wmi.34.2019.05.23.07.24.11
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 07:24:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 15:23:57 +0100
Message-Id: <20190523142357.5175-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523142357.5175-1-peter.maydell@linaro.org>
References: <20190523142357.5175-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PULL 12/12] hw/arm/exynos4210: QOM'ify the Exynos4210
 SoC
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20190520214342.13709-5-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/exynos4210.h |  9 +++++++--
 hw/arm/exynos4210.c         | 28 ++++++++++++++++++++++++----
 hw/arm/exynos4_boards.c     |  9 ++++++---
 3 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
index 098a69ec73d..27c684e851d 100644
--- a/include/hw/arm/exynos4210.h
+++ b/include/hw/arm/exynos4210.h
@@ -85,6 +85,9 @@ typedef struct Exynos4210Irq {
 } Exynos4210Irq;
 
 typedef struct Exynos4210State {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
     ARMCPU *cpu[EXYNOS4210_NCPUS];
     Exynos4210Irq irqs;
     qemu_irq *irq_table;
@@ -98,11 +101,13 @@ typedef struct Exynos4210State {
     I2CBus *i2c_if[EXYNOS4210_I2C_NUMBER];
 } Exynos4210State;
 
+#define TYPE_EXYNOS4210_SOC "exynos4210"
+#define EXYNOS4210_SOC(obj) \
+    OBJECT_CHECK(Exynos4210State, obj, TYPE_EXYNOS4210_SOC)
+
 void exynos4210_write_secondary(ARMCPU *cpu,
         const struct arm_boot_info *info);
 
-Exynos4210State *exynos4210_init(MemoryRegion *system_mem);
-
 /* Initialize exynos4210 IRQ subsystem stub */
 qemu_irq *exynos4210_init_irq(Exynos4210Irq *env);
 
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index f942ed2be96..e99e9cd11bd 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -178,9 +178,10 @@ static void pl330_create(uint32_t base, qemu_irq irq, int nreq)
     sysbus_connect_irq(busdev, 0, irq);
 }
 
-Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
+static void exynos4210_realize(DeviceState *socdev, Error **errp)
 {
-    Exynos4210State *s = g_new0(Exynos4210State, 1);
+    Exynos4210State *s = EXYNOS4210_SOC(socdev);
+    MemoryRegion *system_mem = get_system_memory();
     qemu_irq gate_irq[EXYNOS4210_NCPUS][EXYNOS4210_IRQ_GATE_NINPUTS];
     SysBusDevice *busdev;
     DeviceState *dev;
@@ -435,6 +436,25 @@ Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
                  qemu_irq_invert(s->irq_table[exynos4210_get_irq(36, 1)]), 32);
     pl330_create(EXYNOS4210_PL330_BASE2_ADDR,
                  qemu_irq_invert(s->irq_table[exynos4210_get_irq(34, 1)]), 1);
-
-    return s;
 }
+
+static void exynos4210_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = exynos4210_realize;
+}
+
+static const TypeInfo exynos4210_info = {
+    .name = TYPE_EXYNOS4210_SOC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Exynos4210State),
+    .class_init = exynos4210_class_init,
+};
+
+static void exynos4210_register_types(void)
+{
+    type_register_static(&exynos4210_info);
+}
+
+type_init(exynos4210_register_types)
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index fa0d7016413..71f58586c14 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -45,7 +45,7 @@ typedef enum Exynos4BoardType {
 } Exynos4BoardType;
 
 typedef struct Exynos4BoardState {
-    Exynos4210State *soc;
+    Exynos4210State soc;
     MemoryRegion dram0_mem;
     MemoryRegion dram1_mem;
 } Exynos4BoardState;
@@ -130,7 +130,10 @@ exynos4_boards_init_common(MachineState *machine,
     exynos4_boards_init_ram(s, get_system_memory(),
                             exynos4_board_ram_size[board_type]);
 
-    s->soc = exynos4210_init(get_system_memory());
+    object_initialize(&s->soc, sizeof(s->soc), TYPE_EXYNOS4210_SOC);
+    qdev_set_parent_bus(DEVICE(&s->soc), sysbus_get_default());
+    object_property_set_bool(OBJECT(&s->soc), true, "realized",
+                             &error_fatal);
 
     return s;
 }
@@ -148,7 +151,7 @@ static void smdkc210_init(MachineState *machine)
                                                       EXYNOS4_BOARD_SMDKC210);
 
     lan9215_init(SMDK_LAN9118_BASE_ADDR,
-            qemu_irq_invert(s->soc->irq_table[exynos4210_get_irq(37, 1)]));
+            qemu_irq_invert(s->soc.irq_table[exynos4210_get_irq(37, 1)]));
     arm_load_kernel(ARM_CPU(first_cpu), &exynos4_board_binfo);
 }
 
-- 
2.20.1


