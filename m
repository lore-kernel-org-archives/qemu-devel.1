Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8527BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52F882068D
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miqQjbCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F882068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZlH-00065e-BB
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhV-0006Mt-31
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:33:01 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:33143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhU-0005om-0g
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:33:00 -0400
Received: by mail-ed1-x542.google.com with SMTP id e10so17663977edq.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 06:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZjWj0dUmFcXqSOvS5eV4ZH48B9zS/5L5K/OAOs2OdMM=;
 b=miqQjbCOXsFwvwKODOXKEMFRdT9ZqZWH8xCRlMQZHfoJEbZCpfdxcvQLUUO9bFnRWW
 W2MAYmEGQEkWpwLSToi9URAwZGHFRrGJgXNpovC9qYeJZzM1Esy72lguuBP9M/jyLc/6
 nI1AuUtMf3k2Tkwc5FviK0gVJuXUSzYNP8BdmCnjublauaqwSnxi/uic36vB8lgKqemr
 ORRa/6K6UH4z3JL/cvxL4sR1T6CaGrqElrKvIdthJAcCMQ51Qw09Fa2PKOYhU9+PpAeS
 TjDX46xHkgX3OtRmmPwg8U+Oo6adIh/l0v9rNVIRFaaEE1MKNv8VoBdG16cWWmZh8MJq
 52bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ZjWj0dUmFcXqSOvS5eV4ZH48B9zS/5L5K/OAOs2OdMM=;
 b=MPVPgH01QZRwX9C+yFQpdZks0mHDjF+dtnWFgRNgWH688tVn/QT5Swqy86vjBnCjHM
 chY6nTaVUN+W56C3wUtILQ6EG6aEZ4W/GAII1pvItIA5LK9zPW37K7Ol7kksE4cwlG6h
 DlTWlIL6BuXHgETeUVDK33PdDBy4j196Vmk2/VWhWSqBGkGmDm76ud8wmQByd6W5Mj4E
 q5CwGjYeXluvOUBdfRbxy+/WV4/9nxq7wMEHxuGpDYrxhySceelbyu3dYPIXLezSevqM
 esTMNzFPUBFlBhTSjQcQkmLHsn50t/lPRBHVpUJiJHfBresY+yz9Bu4CmIdAnhqfgDbd
 5tfA==
X-Gm-Message-State: AOAM530Zs3Srxb81/pgVCbPWLLtMSLeTjzQrj9DUz4hI03QYpmsN+GRe
 QwsSSQ/D9LTd4sa54UiHKqdZsAyU80Y=
X-Google-Smtp-Source: ABdhPJy+QzkJ3L07bCS9TKLkT8JyNSsqPfDai0Swx+md90g3+7A3sUKqNYSLjXYEhxeZ4LyCQqy/9A==
X-Received: by 2002:a05:6402:2032:: with SMTP id
 ay18mr19601948edb.281.1590499978445; 
 Tue, 26 May 2020 06:32:58 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id n25sm1623084edo.56.2020.05.26.06.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 06:32:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/14] hw/pci-host/bonito: Map the different PCI ranges more
 detailed
Date: Tue, 26 May 2020 15:32:39 +0200
Message-Id: <20200526133247.13066-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526133247.13066-1-f4bug@amsat.org>
References: <20200526133247.13066-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, libvir-list@redhat.com,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Better describe the Bonito64 MEM HI/LO and I/O PCI ranges,
add more PCI regions as unimplemented.

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-id: <20200526104726.11273-7-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/bonito.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index f09bb1c6a8..52015cc2a7 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -39,6 +39,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "hw/pci/pci.h"
 #include "hw/irq.h"
@@ -82,7 +83,7 @@
 #define BONITO_PCILO1_BASE      0x14000000
 #define BONITO_PCILO2_BASE      0x18000000
 #define BONITO_PCIHI_BASE       0x20000000
-#define BONITO_PCIHI_SIZE       0x20000000
+#define BONITO_PCIHI_SIZE       0x60000000
 #define BONITO_PCIHI_TOP        (BONITO_PCIHI_BASE + BONITO_PCIHI_SIZE - 1)
 #define BONITO_PCIIO_BASE       0x1fd00000
 #define BONITO_PCIIO_BASE_VA    0xbfd00000
@@ -605,14 +606,26 @@ static void bonito_pcihost_realize(DeviceState *dev, Error **errp)
 {
     PCIHostState *phb = PCI_HOST_BRIDGE(dev);
     BonitoState *bs = BONITO_PCI_HOST_BRIDGE(dev);
+    MemoryRegion *pcimem_lo_alias = g_new(MemoryRegion, 3);
 
-    memory_region_init(&bs->pci_mem, OBJECT(dev), "pci.mem", BONITO_PCILO_SIZE);
+    memory_region_init(&bs->pci_mem, OBJECT(dev), "pci.mem", BONITO_PCIHI_SIZE);
     phb->bus = pci_register_root_bus(dev, "pci",
                                      pci_bonito_set_irq, pci_bonito_map_irq,
                                      dev, &bs->pci_mem, get_system_io(),
                                      0x28, 32, TYPE_PCI_BUS);
-    memory_region_add_subregion(get_system_memory(), BONITO_PCILO_BASE,
-                                &bs->pci_mem);
+
+    for (size_t i = 0; i < 3; i++) {
+        char *name = g_strdup_printf("pci.lomem%zu", i);
+
+        memory_region_init_alias(&pcimem_lo_alias[i], NULL, name,
+                                 &bs->pci_mem, i * 64 * MiB, 64 * MiB);
+        memory_region_add_subregion(get_system_memory(),
+                                    BONITO_PCILO_BASE + i * 64 * MiB,
+                                    &pcimem_lo_alias[i]);
+        g_free(name);
+    }
+
+    create_unimplemented_device("pci.io", BONITO_PCIIO_BASE, 1 * MiB);
 }
 
 static void bonito_realize(PCIDevice *dev, Error **errp)
@@ -620,6 +633,8 @@ static void bonito_realize(PCIDevice *dev, Error **errp)
     PCIBonitoState *s = PCI_BONITO(dev);
     SysBusDevice *sysbus = SYS_BUS_DEVICE(s->pcihost);
     PCIHostState *phb = PCI_HOST_BRIDGE(s->pcihost);
+    BonitoState *bs = BONITO_PCI_HOST_BRIDGE(s->pcihost);
+    MemoryRegion *pcimem_alias = g_new(MemoryRegion, 1);
 
     /*
      * Bonito North Bridge, built on FPGA,
@@ -652,6 +667,7 @@ static void bonito_realize(PCIDevice *dev, Error **errp)
     sysbus_init_mmio(sysbus, &s->iomem_ldma);
     sysbus_mmio_map(sysbus, 3, 0x1fe00200);
 
+    /* PCI copier */
     memory_region_init_io(&s->iomem_cop, OBJECT(s), &bonito_cop_ops, s,
                           "cop", 0x100);
     sysbus_init_mmio(sysbus, &s->iomem_cop);
@@ -669,6 +685,14 @@ static void bonito_realize(PCIDevice *dev, Error **errp)
     sysbus_init_mmio(sysbus, &s->bonito_localio);
     sysbus_mmio_map(sysbus, 6, BONITO_DEV_BASE);
 
+    memory_region_init_alias(pcimem_alias, NULL, "pci.mem.alias",
+                             &bs->pci_mem, 0, BONITO_PCIHI_SIZE);
+    memory_region_add_subregion(get_system_memory(),
+                                BONITO_PCIHI_BASE, pcimem_alias);
+    create_unimplemented_device("PCI_2",
+                                (hwaddr)BONITO_PCIHI_BASE + BONITO_PCIHI_SIZE,
+                                2 * GiB);
+
     /* set the default value of north bridge pci config */
     pci_set_word(dev->config + PCI_COMMAND, 0x0000);
     pci_set_word(dev->config + PCI_STATUS, 0x0000);
-- 
2.21.3


