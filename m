Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C764C43457
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F9520714
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9M3saDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F9520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRxmL-0006g4-KS
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 09:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRxka-0004lI-3r; Mon, 12 Oct 2020 09:20:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44559)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRxkX-0005Kj-TP; Mon, 12 Oct 2020 09:20:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id t9so19157207wrq.11;
 Mon, 12 Oct 2020 06:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/fQo3DSJb6riAH6KnfckECiEhkMalNL1pPpYvWlbzCc=;
 b=W9M3saDT8FdO9DTTtZL7ScRDnDjZOrzx77XE5OY5zBI+QKqGDDz1NuoTyr5k+uFFbm
 V6un4EeWvUoigDJr8qyfBvyejr6e1h4wDIZZFQQcYakI+Hc+qPBD9COAZ9r7HK76ATRE
 rOgVJZfLN7SKYxZqAtQ6wKa1Wbdxe64qqApsYpm9rS4jDCseEOUm60QCrloD8PF8KGrE
 MPeoeWhd710PZ9VLHUZPwPdhHn0/k/dH0Jvjy/kUX6SEtesqUnlYDXgXrngiYy4OnKzo
 wnWWdPARSPJUK8fVo0C1erD/Fam3Gig+mrwxiYUlv6xXY5wmjjVxDv/G6x8GsZob3owl
 vpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/fQo3DSJb6riAH6KnfckECiEhkMalNL1pPpYvWlbzCc=;
 b=ZXa5JOHBnBPT4QCRgGP/WZYyFjkM7mUhWsgjspFEEUUJg+kMfiniTsjIVsX5rmOPNj
 eNM5iqQM1wbO/gINEN4NNY7Emc+IRHXDtTFq8KIlB4sNQl8ibf8kY2aBT5WUqs/nbjyh
 9VsWU9HUelEEUAqQq7yoXhdHFM72b1NbUVhhWENxwcUNDKKVO5CRqxPI/jag5tZKQ3VH
 GkCBZG3poaNrtnv0SD72IAe9+CJwr0vLsIGYEXjIGI19u3+C1mOO7E2caNkjxfrK/arF
 ZYduEji2Gtbao2UuONEPm5NQhTfBG6ndAC9dQMgswfuMabhFbh9Ih19LMfy+SYRcHO0k
 S51w==
X-Gm-Message-State: AOAM533y32ePvcZ+ZvE4FR4uuUzpVPzFsFFN3oDojJs/bntEevGt+Ugb
 RRIAGUo+8z7oSn9nnCDdFRmKgvg/ReM=
X-Google-Smtp-Source: ABdhPJx5PN9W1V5HEEdVHI+swOhZnNNnlgzDPccxus+wpj40WvUDzg5A0ATbiBUC7xhtSI1Xib96XQ==
X-Received: by 2002:adf:edc6:: with SMTP id v6mr4869489wro.273.1602508823892; 
 Mon, 12 Oct 2020 06:20:23 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x3sm14706164wmi.45.2020.10.12.06.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 06:20:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/5] hw: Replace magic value by PCI_NUM_PINS definition
Date: Mon, 12 Oct 2020 15:20:12 +0200
Message-Id: <20201012132017.3423954-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012132017.3423954-1-f4bug@amsat.org>
References: <20201012132017.3423954-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use self-explicit PCI_NUM_PINS definition instead of magic value.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/virt.c           | 4 ++--
 hw/mips/gt64xxx_pci.c   | 2 +-
 hw/pci-host/versatile.c | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e465a988d68..ddad9621f79 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1117,11 +1117,11 @@ static void create_pcie_irq_map(const VirtMachineState *vms,
                                 int first_irq, const char *nodename)
 {
     int devfn, pin;
-    uint32_t full_irq_map[4 * 4 * 10] = { 0 };
+    uint32_t full_irq_map[4 * PCI_NUM_PINS * 10] = { 0 };
     uint32_t *irq_map = full_irq_map;
 
     for (devfn = 0; devfn <= 0x18; devfn += 0x8) {
-        for (pin = 0; pin < 4; pin++) {
+        for (pin = 0; pin < PCI_NUM_PINS; pin++) {
             int irq_type = GIC_FDT_IRQ_TYPE_SPI;
             int irq_nr = first_irq + ((pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);
             int irq_level = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index e091bc4ed55..ff1a35755f6 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -1018,7 +1018,7 @@ static void gt64120_pci_set_irq(void *opaque, int irq_num, int level)
     if (pic_irq < 16) {
         /* The pic level is the logical OR of all the PCI irqs mapped to it. */
         pic_level = 0;
-        for (i = 0; i < 4; i++) {
+        for (i = 0; i < PCI_NUM_PINS; i++) {
             if (pic_irq == piix4_dev->config[PIIX_PIRQCA + i]) {
                 pic_level |= pci_irq_levels[i];
             }
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 3553277f941..b4951023f4e 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -75,7 +75,7 @@ enum {
 struct PCIVPBState {
     PCIHostState parent_obj;
 
-    qemu_irq irq[4];
+    qemu_irq irq[PCI_NUM_PINS];
     MemoryRegion controlregs;
     MemoryRegion mem_config;
     MemoryRegion mem_config2;
@@ -412,7 +412,7 @@ static void pci_vpb_realize(DeviceState *dev, Error **errp)
 
     object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_VERSATILE_PCI_HOST);
 
-    for (i = 0; i < 4; i++) {
+    for (i = 0; i < PCI_NUM_PINS; i++) {
         sysbus_init_irq(sbd, &s->irq[i]);
     }
 
@@ -422,7 +422,7 @@ static void pci_vpb_realize(DeviceState *dev, Error **errp)
         mapfn = pci_vpb_map_irq;
     }
 
-    pci_bus_irqs(&s->pci_bus, pci_vpb_set_irq, mapfn, s->irq, 4);
+    pci_bus_irqs(&s->pci_bus, pci_vpb_set_irq, mapfn, s->irq, PCI_NUM_PINS);
 
     /* Our memory regions are:
      * 0 : our control registers
-- 
2.26.2


