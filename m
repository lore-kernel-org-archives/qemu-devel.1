Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E88C38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB0B206F5
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTKTgX8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB0B206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXtCV-0001at-CV
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 17:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt57-0007WI-1G
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:53 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:36240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt55-00016w-D9
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:51 -0400
Received: by mail-ed1-x543.google.com with SMTP id b91so1984992edf.3
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 14:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mmHaPOER59FIZy5I04bKapXn8WezFDdBC08nDY63Daw=;
 b=aTKTgX8uydWqTwDfZ1S7QC+Viz74HDPSWAhviukCF7EIBQoWiuJ9wrAju1LZaHXY+P
 sXBYs+PUTK55dWNv1jZsPhAHDTI8UZVutX2wVJBpYSfhX1+Vjdwu+7/I/I90b9P03bk8
 yw1DtZo7WBX3xIiyjyBJ5V9jaoD5UzBCjaT+WuaFgPMbjcUAAgPxBBL3R2cRl1KZ7Yns
 0qBLoEN8L3GAuc8u3vdsgFeyjdK9s2JZKb7yVqpmS5lG5og1RKxCLQCitEAhYWe6Gii6
 CblRirU3MqoYqgDCbdLvyb7PC0tw5GF2d1jWO9eUydcOa0rPyhe1HfW/kVgKi+22ffUm
 rt9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mmHaPOER59FIZy5I04bKapXn8WezFDdBC08nDY63Daw=;
 b=cX2gBavKQnc7rCt7UOw0ftNOyaWv0QmMJ4CVxaAjPbnO+9/bUvLwv4+72QarVGweFc
 Gs/bWr4XGbqKm4mcfTAjoRlgmgE+GcToBun9AR7dH64Q758+7zX9uDE40RNqgYafs2tq
 S4S+oKnk+2Ea1SqLsPXpOsH/2ZN7hGmHRPLQLEl6nSpCDy1LG+T3D5/dk84ZXTJylH++
 2dhJvSbLXmWVHNwHHWBPJ9+gZ1D4nLMRHltA1zKZEaFysiRQ+MtDpPUD2oaLv8N72oVR
 CB9AW3VhaMiLpLnGgci0kDkdyUFm22AZv9yBlg9pD6yP8Ogr80Uf3xxx9zFkjnCLA6zK
 jrCQ==
X-Gm-Message-State: AOAM53152yTGYyyGggHkO+IdA5WvkQvYZESa9UbFaQBt6jbWUemwT82a
 j2UqHoOyhD1fQOUt0aaxioKJuuEot2w=
X-Google-Smtp-Source: ABdhPJzj2Cgl5x65+MPo3TFEj/K9OFbF8B+Z+SQUf1uo1la3eBMBqL0lKll6HgHV7GYU3T5daaUeTw==
X-Received: by 2002:a50:fd15:: with SMTP id i21mr50855eds.104.1589144509247;
 Sun, 10 May 2020 14:01:49 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id d15sm921152ejr.50.2020.05.10.14.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 14:01:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/12] hw/pci-host/bonito: Map the different PCI ranges more
 detailled
Date: Sun, 10 May 2020 23:01:25 +0200
Message-Id: <20200510210128.18343-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200510210128.18343-1-f4bug@amsat.org>
References: <20200510210128.18343-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Better describe the Bonito64 MEM HI/LO and I/O PCI ranges,
add more PCI regions as unimplemented.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/bonito.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 9761780f44..90a6c52a38 100644
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
@@ -606,13 +607,25 @@ static void bonito_pcihost_realize(DeviceState *dev, Error **errp)
     PCIHostState *phb = PCI_HOST_BRIDGE(dev);
     BonitoState *bs = BONITO_PCI_HOST_BRIDGE(dev);
 
-    memory_region_init(&bs->pci_mem, OBJECT(dev), "pci.mem", BONITO_PCILO_SIZE);
+    memory_region_init(&bs->pci_mem, OBJECT(dev), "pci.mem", BONITO_PCIHI_SIZE);
     phb->bus = pci_register_root_bus(DEVICE(dev), "pci",
                                      pci_bonito_set_irq, pci_bonito_map_irq,
                                      dev, &bs->pci_mem, get_system_io(),
                                      0x28, 32, TYPE_PCI_BUS);
-    memory_region_add_subregion(get_system_memory(), BONITO_PCILO_BASE,
-                                &bs->pci_mem);
+
+    MemoryRegion *pcimem_lo_alias = g_new(MemoryRegion, 3);
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
+    create_unimplemented_device("pci.io", 0x1fd00000, 1 * MiB);
 }
 
 static void bonito_realize(PCIDevice *dev, Error **errp)
@@ -620,6 +633,7 @@ static void bonito_realize(PCIDevice *dev, Error **errp)
     PCIBonitoState *s = PCI_BONITO(dev);
     SysBusDevice *sysbus = SYS_BUS_DEVICE(s->pcihost);
     PCIHostState *phb = PCI_HOST_BRIDGE(s->pcihost);
+    BonitoState *bs = BONITO_PCI_HOST_BRIDGE(s->pcihost);
 
     /*
      * Bonito North Bridge, built on FPGA,
@@ -652,6 +666,7 @@ static void bonito_realize(PCIDevice *dev, Error **errp)
     sysbus_init_mmio(sysbus, &s->iomem_ldma);
     sysbus_mmio_map(sysbus, 3, 0x1fe00200);
 
+    /* PCI copier */
     memory_region_init_io(&s->iomem_cop, OBJECT(s), &bonito_cop_ops, s,
                           "cop", 0x100);
     sysbus_init_mmio(sysbus, &s->iomem_cop);
@@ -669,6 +684,13 @@ static void bonito_realize(PCIDevice *dev, Error **errp)
     sysbus_init_mmio(sysbus, &s->bonito_localio);
     sysbus_mmio_map(sysbus, 6, BONITO_DEV_BASE);
 
+    MemoryRegion *pcimem_alias = g_new(MemoryRegion, 1);
+    memory_region_init_alias(pcimem_alias, NULL, "pci.mem.alias",
+                             &bs->pci_mem, 0, BONITO_PCIHI_SIZE);
+    memory_region_add_subregion(get_system_memory(),
+                                0x20000000ul, pcimem_alias);
+    create_unimplemented_device("PCI_2", 0x80000000ul, 2 * GiB); /* pci_hi */
+
     /* set the default value of north bridge pci config */
     pci_set_word(dev->config + PCI_COMMAND, 0x0000);
     pci_set_word(dev->config + PCI_STATUS, 0x0000);
-- 
2.21.3


