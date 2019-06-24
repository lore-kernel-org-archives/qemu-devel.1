Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CCBC4646C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9AB220674
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CO6zLsdQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9AB220674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55106 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfXYJ-0000ge-3y
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34179)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSP-0004C3-O9
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSO-0005P2-6g
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:29:01 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35469)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSN-0005Le-Tj
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:29:00 -0400
Received: by mail-wm1-x344.google.com with SMTP id c6so891944wml.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 15:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rT3WvtpigTN3xO4aUvjlhGu30zqDl1BA3eirdCSenGY=;
 b=CO6zLsdQmYkw/tpmJ7ZdO1Nni8NIkxXbjZGZYfilr2ULrHk8LveGwlyYo2qx+pz7lq
 KLPbpO0UudAjz8NuiD+ZKllK0LCHioqqopIavypky0k7UB+tyAwITlhdn+WZjW/r7Jn3
 Es7N9S7p+ATy2bR/cbhfREGgai03TY8XkSVEixkAd/4+pJlK78TQCiMeyTJug5BmOkY/
 0duahjtOA/dNOphAyZIra7O9aBPmLwLxuN/j716KzUVIuUGUsE13fmKFyuM+ODvZIdeZ
 wxGzVokWYHbeRcSvWoGq+7CxW2YVI7+GagjaWsGeKnKo5/8r6PPEkPJue/UDr/WPcH1G
 mIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rT3WvtpigTN3xO4aUvjlhGu30zqDl1BA3eirdCSenGY=;
 b=Y6b4eFtgT5Ibi7JlfvroARR/eYqKKnU/G+EeBAZkJK7rCGlrlRHbcZ1wUn3kP3wiLu
 XVb+FGjuLT5BS2pJOVZSy6Ii+baJP5YEgKE9Z2gXCmiriToY/2MI5LKpccICIq1UQy37
 Ddmaq2+143xn4Z3ShmA5GjMn1KbbWugatdUZ/toRiJjShOqahrqBZuSSNFO9dn+oI6Yd
 4Ubb1AE2ca0/L6bao5rLgJG8Fjr6IRtLJDaIeV79ksR0OAgZqEf6v1l+PPdeDMxDM5qq
 i2a+/83fs8GKn2+C8RsSpakcuJFFbvNSM6aU6hlWP+7NJM3jZ/p8tURxqoV51TQVvcL7
 SPHg==
X-Gm-Message-State: APjAAAWblHizphsRcbh9NxhT4YvvNkfbNTzla/Kx6jWvPRvBoPVxK0cC
 WhxbkLrsFcVj1RbNB1sHbQY0OT1G
X-Google-Smtp-Source: APXvYqw3EwM8fMiInZQV7ll8rHWM61Hjlqs3BlBBIZ/7Lmsk4FpnR4dMsgb0K46PIERkNBUHv/HX/g==
X-Received: by 2002:a1c:c2d5:: with SMTP id
 s204mr17776629wmf.174.1561415336828; 
 Mon, 24 Jun 2019 15:28:56 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id l1sm646781wmg.13.2019.06.24.15.28.55
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 15:28:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 00:28:42 +0200
Message-Id: <20190624222844.26584-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190624222844.26584-1-f4bug@amsat.org>
References: <20190624222844.26584-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH 08/10] hw/mips/gt64xxx_pci: Add a
 'cpu_big_endian' qdev property
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This device does not have to be TARGET-dependent.
Add a 'cpu_big_endian' property which sets the byte-swapping
options if required.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
I might change my mind and name it 'little_endian' to be closer
to the datasheet.
---
 include/hw/mips/mips.h |  2 +-
 hw/mips/gt64xxx_pci.c  | 29 +++++++++++++----------------
 hw/mips/mips_malta.c   |  2 +-
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/include/hw/mips/mips.h b/include/hw/mips/mips.h
index 2f6774d540..6ec41d33f1 100644
--- a/include/hw/mips/mips.h
+++ b/include/hw/mips/mips.h
@@ -9,7 +9,7 @@
 #include "hw/irq.h"
 
 /* gt64xxx.c */
-PCIBus *gt64120_register(qemu_irq *pic);
+PCIBus *gt64120_create(qemu_irq *pic, bool target_is_bigendian);
 
 /* bonito.c */
 PCIBus *bonito_init(qemu_irq *pic);
diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index 2fa313f498..5209038ee5 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -240,6 +240,7 @@ typedef struct GT64120State {
     PCI_MAPPING_ENTRY(ISD);
     MemoryRegion pci0_mem;
     AddressSpace pci0_mem_as;
+    bool cpu_big_endian;
 } GT64120State;
 
 /* Adjust range to avoid touching space which isn't mappable via PCI */
@@ -1028,15 +1029,12 @@ static void gt64120_pci_set_irq(void *opaque, int irq_num, int level)
 static void gt64120_reset(DeviceState *dev)
 {
     GT64120State *s = GT64120_PCI_HOST_BRIDGE(dev);
+    const uint32_t pci_cmd = s->cpu_big_endian ? 0x00000000 : 0x00010001;
 
     /* FIXME: Malta specific hw assumptions ahead */
 
     /* CPU Configuration */
-#ifdef TARGET_WORDS_BIGENDIAN
-    s->regs[GT_CPU]           = 0x00000000;
-#else
-    s->regs[GT_CPU]           = 0x00001000;
-#endif
+    s->regs[GT_CPU]           = !s->cpu_big_endian << 12;
     s->regs[GT_MULTI]         = 0x00000003;
 
     /* CPU Address decode */
@@ -1143,11 +1141,7 @@ static void gt64120_reset(DeviceState *dev)
     s->regs[GT_TC_CONTROL]    = 0x00000000;
 
     /* PCI Internal */
-#ifdef TARGET_WORDS_BIGENDIAN
-    s->regs[GT_PCI0_CMD]      = 0x00000000;
-#else
-    s->regs[GT_PCI0_CMD]      = 0x00010001;
-#endif
+    s->regs[GT_PCI0_CMD]      = pci_cmd;
     s->regs[GT_PCI0_TOR]      = 0x0000070f;
     s->regs[GT_PCI0_BS_SCS10] = 0x00fff000;
     s->regs[GT_PCI0_BS_SCS32] = 0x00fff000;
@@ -1164,11 +1158,7 @@ static void gt64120_reset(DeviceState *dev)
     s->regs[GT_PCI0_SSCS10_BAR] = 0x00000000;
     s->regs[GT_PCI0_SSCS32_BAR] = 0x01000000;
     s->regs[GT_PCI0_SCS3BT_BAR] = 0x1f000000;
-#ifdef TARGET_WORDS_BIGENDIAN
-    s->regs[GT_PCI1_CMD]      = 0x00000000;
-#else
-    s->regs[GT_PCI1_CMD]      = 0x00010001;
-#endif
+    s->regs[GT_PCI1_CMD]      = pci_cmd;
     s->regs[GT_PCI1_TOR]      = 0x0000070f;
     s->regs[GT_PCI1_BS_SCS10] = 0x00fff000;
     s->regs[GT_PCI1_BS_SCS32] = 0x00fff000;
@@ -1193,13 +1183,14 @@ static void gt64120_reset(DeviceState *dev)
     gt64120_pci_mapping(s);
 }
 
-PCIBus *gt64120_register(qemu_irq *pic)
+PCIBus *gt64120_create(qemu_irq *pic, bool target_is_bigendian)
 {
     GT64120State *d;
     PCIHostState *phb;
     DeviceState *dev;
 
     dev = qdev_create(NULL, TYPE_GT64120_PCI_HOST_BRIDGE);
+    qdev_prop_set_bit(dev, "cpu_big_endian", target_is_bigendian);
     d = GT64120_PCI_HOST_BRIDGE(dev);
     phb = PCI_HOST_BRIDGE(dev);
     memory_region_init(&d->pci0_mem, OBJECT(dev), "pci0-mem", 4 * GiB);
@@ -1262,6 +1253,11 @@ static const TypeInfo gt64120_pci_info = {
     },
 };
 
+static Property gt64120_properties[] = {
+    DEFINE_PROP_BOOL("cpu_big_endian", GT64120State, cpu_big_endian, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void gt64120_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1269,6 +1265,7 @@ static void gt64120_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->reset = gt64120_reset;
     dc->vmsd = &vmstate_gt64120;
+    dc->props = gt64120_properties;
 }
 
 static const TypeInfo gt64120_info = {
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 51db5212be..97f8ffbf1b 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1375,7 +1375,7 @@ void mips_malta_init(MachineState *machine)
     isa_irq = qemu_irq_proxy(&s->i8259, 16);
 
     /* Northbridge */
-    pci_bus = gt64120_register(isa_irq);
+    pci_bus = gt64120_create(isa_irq, be);
 
     /* Southbridge */
     ide_drive_get(hd, ARRAY_SIZE(hd));
-- 
2.19.1


