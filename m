Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA661C10F14
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 21:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91CD420869
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 21:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTTEVYHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CD420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42663 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF3PN-0001ga-N3
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 17:08:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hF3NV-0000Pn-AG
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hF3NU-00055c-98
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:06:29 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>)
	id 1hF3NU-00054y-24; Fri, 12 Apr 2019 17:06:28 -0400
Received: by mail-wm1-x344.google.com with SMTP id o25so12812095wmf.5;
	Fri, 12 Apr 2019 14:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=6+mdXw7JctYNLM3sl7L6uUTdMFAgSpVg+rVKzE53wOA=;
	b=QTTEVYHft49WivpWajDFoSS8bZrfwsMO453RjMggyFu24SSCS78K+3QHVgyh3SUwCS
	qMewFt6BKSJ/04oS2ZheTL+zxANNRL+mRL9raoQKMIBL21MNSwG1mkhQtlnP+Ce+NI5P
	sUecgivTM8xEPwrSYT3FGZqrFq1ISLF344t6nQHfkQdl1/v5LZ3jWQsJOqQfvfV4s9Lw
	AhLW6FBrLcPrX+J4/g6AuYsKGXQHZxFO5ryWkrZWIMS+DWOIcg2Fk4DUiGsLH8xGBcV5
	X6x+Fer4N4OdD5RrficqDSUNxflwQw2ziHeLcayRZh9FACpzhYF1/CCa/NAHCZ9s2s8w
	vJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=6+mdXw7JctYNLM3sl7L6uUTdMFAgSpVg+rVKzE53wOA=;
	b=SbO9ryZH39cSKViRN5KVZr3WSI6tVfdqGTMAvSU9HgiT8/Lm5Eqr4ftPoU+5kUVIQj
	v20d7AaoG5YgTiFG5XVdug5eCsvwLRCOcLT1iEEIIunAxZRYCZ9US51SZ6DDClzmHhl+
	xqWhyl0NePULXyBCM2Wrz5tn/VxW4JiUUwMZ9sPLWMDVNzyNHFwGNwdr3zG5pVRMFgMF
	WKaNLXo/tyKOwjqiOj98Y8jX/imFn/2EtAtvKk8kZjPL8yf1sXhI/bHvbHNQ+hCAII6S
	uxr6KxiAL30QdbwjkxihVdWHXQMOJFIlcvTGP+DQajk/kek/OBRHwy+Mr6HejgzgGKMZ
	sUkQ==
X-Gm-Message-State: APjAAAW2cw4nVo5200mFuTOW1WdbSR4VkhCwp+R8kzISiIes+yveD3eU
	8WbM5QmbQtvQjg5jvsY3A0Eza2Jv
X-Google-Smtp-Source: APXvYqw99v1w2bL7j/IKthdkL2UHxqRxfnNJbuYFDQj7yxALU35WCzjlZPxvWfDRAbHGeqIbvaneXQ==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr13058312wml.110.1555103186567; 
	Fri, 12 Apr 2019 14:06:26 -0700 (PDT)
Received: from localhost (x4d0c5397.dyn.telefonica.de. [77.12.83.151])
	by smtp.gmail.com with ESMTPSA id
	v16sm81657168wro.48.2019.04.12.14.06.25
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 14:06:25 -0700 (PDT)
From: Artyom Tarasenko <atar4qemu@gmail.com>
To: qemu-devel@nongnu.org,
	hpoussin@reactos.org
Date: Fri, 12 Apr 2019 23:06:15 +0200
Message-Id: <1555103178-21894-2-git-send-email-atar4qemu@gmail.com>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH 1/4] lsi53c895a: hide 53c895a registers in
 53c810
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
	qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412210615.-bEBWt2oxcANd9kaGW7wInjO9mkiq2Uo3vsOaYraXUI@z>

AIX/PReP does access to the aliased IO registers of 53810.
Implement aliasing to make the AIX driver work.

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 hw/scsi/lsi53c895a.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index da7239d..08841e0 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2266,11 +2266,13 @@ static const struct SCSIBusInfo lsi_scsi_info = {
     .cancel = lsi_request_cancelled
 };
 
-static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
+static void lsi_scsi_realize_8xx(PCIDevice *dev, Error **errp, uint16_t type)
 {
     LSIState *s = LSI53C895A(dev);
     DeviceState *d = DEVICE(dev);
     uint8_t *pci_conf;
+    uint64_t mmio_size;
+    MemoryRegion *mr;
 
     pci_conf = dev->config;
 
@@ -2279,13 +2281,21 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
     /* Interrupt pin A */
     pci_conf[PCI_INTERRUPT_PIN] = 0x01;
 
-    memory_region_init_io(&s->mmio_io, OBJECT(s), &lsi_mmio_ops, s,
-                          "lsi-mmio", 0x400);
     memory_region_init_io(&s->ram_io, OBJECT(s), &lsi_ram_ops, s,
                           "lsi-ram", 0x2000);
     memory_region_init_io(&s->io_io, OBJECT(s), &lsi_io_ops, s,
                           "lsi-io", 256);
-
+    if (type == PCI_DEVICE_ID_LSI_53C895A) {
+        mmio_size = 0x400;
+    } else {
+        mr = g_new(MemoryRegion, 1);
+        memory_region_init_alias(mr, OBJECT(d), "lsi-io-alias", &s->io_io,
+                                 0, 0x80);
+        memory_region_add_subregion_overlap(&s->io_io, 0x80, mr, -1);
+        mmio_size = 0x80;
+    }
+    memory_region_init_io(&s->mmio_io, OBJECT(s), &lsi_mmio_ops, s,
+                          "lsi-mmio", mmio_size);
     address_space_init(&s->pci_io_as, pci_address_space_io(dev), "lsi-pci-io");
     qdev_init_gpio_out(d, &s->ext_irq, 1);
 
@@ -2297,6 +2307,16 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
     scsi_bus_new(&s->bus, sizeof(s->bus), d, &lsi_scsi_info, NULL);
 }
 
+static void lsi_scsi_realize_895A(PCIDevice *dev, Error **errp)
+{
+    lsi_scsi_realize_8xx(dev, errp, PCI_DEVICE_ID_LSI_53C895A);
+}
+
+static void lsi_scsi_realize_810(PCIDevice *dev, Error **errp)
+{
+    lsi_scsi_realize_8xx(dev, errp, PCI_DEVICE_ID_LSI_53C810);
+}
+
 static void lsi_scsi_unrealize(DeviceState *dev, Error **errp)
 {
     LSIState *s = LSI53C895A(dev);
@@ -2309,7 +2329,7 @@ static void lsi_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->realize = lsi_scsi_realize;
+    k->realize = lsi_scsi_realize_895A;
     k->vendor_id = PCI_VENDOR_ID_LSI_LOGIC;
     k->device_id = PCI_DEVICE_ID_LSI_53C895A;
     k->class_id = PCI_CLASS_STORAGE_SCSI;
@@ -2335,6 +2355,7 @@ static void lsi53c810_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
+    k->realize = lsi_scsi_realize_810;
     k->device_id = PCI_DEVICE_ID_LSI_53C810;
 }
 
-- 
2.7.2


