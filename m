Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864FBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 12:30:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3924220866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 12:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rsdDUulb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3924220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6YqT-0001Fs-Ek
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 08:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6Ypd-0000iz-UG; Fri, 14 Aug 2020 08:29:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6Ypb-0002L0-Th; Fri, 14 Aug 2020 08:29:13 -0400
Received: by mail-wm1-x344.google.com with SMTP id x5so7328470wmi.2;
 Fri, 14 Aug 2020 05:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HHF8F8C69cxwA1gHUBPBrw8zWVGJfAJ1ev6KdpDclys=;
 b=rsdDUulbEpb4wsA/IBSZMHuIr/weEFSsewpy5CcQ8QHtxmy5wq2snezbT56hdd5Y+L
 quUAFdzTsAnqVu0h/xpORUWjQ21SVtKY8MNpSyG6fL+VKnaUwMr+ZIUd2Obov8s3rL+T
 T/m7W47eKPv2ZR9dfx+GDZOPZJH9eTrk++FCFnEK2Gj5PE+0Y30r4OpXn0pipqWLISru
 3dn0nyQwYhymvc4yNN+TsXHrCV+/qmOkdWWvEg615iPXhkFLiCtvqcmvZuUhzAFSm4I3
 +ezoeHx8x0FR9w+xceWPHMpKyk9ONGPfdV7Dm79kguwdOC5NwliVast2sC8rtTXlS0DE
 T3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=HHF8F8C69cxwA1gHUBPBrw8zWVGJfAJ1ev6KdpDclys=;
 b=MG2r9pdEZfy2IMmFx60VMF4l9RetHIlRmlvRRCRQR17gG7HXTY4jEqWUY47Ft2YN6Y
 e9kXj9dzg2uI+wI8Jm0+MuT9qrlIyNPO9KjrVOPCuFe6ORO/St1H7SMCeUklhpjQ3soc
 jCApWa9cq8suF4Mk0uMWjgJNUxTcCQTpv27TH4Zr1LJ2IRnAfZktol3U+BnjLRMJHR6H
 V9P7SVUlpJhJJFFP+ctYnDMI62hJljJ1oV1gLbVucDDfReteD9G4O+I1yaMANUi+DbgS
 bZ8+nFma3L7crf/EhQpLDR2Ub1F+uAfwBxKxj7m9OJEcpyh3Lumkv37ugS9wNAugig+U
 +w2Q==
X-Gm-Message-State: AOAM532zksAnBPknuwxnIjl/JnMP0ry0rjF+8g8LC8SDX3M2rPS7ieNq
 t2xdVZuYLKHTEFH3yLntwbhxDvPWXFY=
X-Google-Smtp-Source: ABdhPJxpkqeF5VHjTIk2szAIp6vS4v6HyH3VwJiKR+25hyprVLrQ7hzUNx4zYEkUyPp9dzXQavFmeA==
X-Received: by 2002:a05:600c:2055:: with SMTP id
 p21mr2255489wmg.109.1597408149518; 
 Fri, 14 Aug 2020 05:29:09 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id j4sm14410210wmi.48.2020.08.14.05.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 05:29:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/net/allwinner-sun8i-emac: Use AddressSpace for DMA
 transfers
Date: Fri, 14 Aug 2020 14:29:07 +0200
Message-Id: <20200814122907.27732-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow the device to execute the DMA transfers in a different
AddressSpace.

The H3 SoC keeps using the system_memory address space,
but via the proper dma_memory_access() API.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Tested with:
  AVOCADO_ALLOW_LARGE_STORAGE=1 avocado run -t machine:orangepi-pc tests/acceptance/
---
 include/hw/net/allwinner-sun8i-emac.h |  6 ++++
 hw/arm/allwinner-h3.c                 |  2 ++
 hw/net/allwinner-sun8i-emac.c         | 46 +++++++++++++++++----------
 3 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/include/hw/net/allwinner-sun8i-emac.h b/include/hw/net/allwinner-sun8i-emac.h
index eda034e96b..dd1d7b96cd 100644
--- a/include/hw/net/allwinner-sun8i-emac.h
+++ b/include/hw/net/allwinner-sun8i-emac.h
@@ -49,6 +49,12 @@ typedef struct AwSun8iEmacState {
     /** Interrupt output signal to notify CPU */
     qemu_irq     irq;
 
+    /** Memory region where DMA transfers are done */
+    MemoryRegion *dma_mr;
+
+    /** Address space used internally for DMA transfers */
+    AddressSpace dma_as;
+
     /** Generic Network Interface Controller (NIC) for networking API */
     NICState     *nic;
 
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index ff92ded82c..21a5d759d1 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -363,6 +363,8 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
         qemu_check_nic_model(&nd_table[0], TYPE_AW_SUN8I_EMAC);
         qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
     }
+    object_property_set_link(OBJECT(&s->emac), "dma-memory",
+                             OBJECT(get_system_memory()), &error_fatal);
     sysbus_realize(SYS_BUS_DEVICE(&s->emac), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->emac), 0, s->memmap[AW_H3_EMAC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->emac), 0,
diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
index 28637ff4c1..38d328587e 100644
--- a/hw/net/allwinner-sun8i-emac.c
+++ b/hw/net/allwinner-sun8i-emac.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
@@ -29,6 +30,7 @@
 #include "net/checksum.h"
 #include "qemu/module.h"
 #include "exec/cpu-common.h"
+#include "sysemu/dma.h"
 #include "hw/net/allwinner-sun8i-emac.h"
 
 /* EMAC register offsets */
@@ -337,12 +339,13 @@ static void allwinner_sun8i_emac_update_irq(AwSun8iEmacState *s)
     qemu_set_irq(s->irq, (s->int_sta & s->int_en) != 0);
 }
 
-static uint32_t allwinner_sun8i_emac_next_desc(FrameDescriptor *desc,
+static uint32_t allwinner_sun8i_emac_next_desc(AwSun8iEmacState *s,
+                                               FrameDescriptor *desc,
                                                size_t min_size)
 {
     uint32_t paddr = desc->next;
 
-    cpu_physical_memory_read(paddr, desc, sizeof(*desc));
+    dma_memory_read(&s->dma_as, paddr, desc, sizeof(*desc));
 
     if ((desc->status & DESC_STATUS_CTL) &&
         (desc->status2 & DESC_STATUS2_BUF_SIZE_MASK) >= min_size) {
@@ -352,7 +355,8 @@ static uint32_t allwinner_sun8i_emac_next_desc(FrameDescriptor *desc,
     }
 }
 
-static uint32_t allwinner_sun8i_emac_get_desc(FrameDescriptor *desc,
+static uint32_t allwinner_sun8i_emac_get_desc(AwSun8iEmacState *s,
+                                              FrameDescriptor *desc,
                                               uint32_t start_addr,
                                               size_t min_size)
 {
@@ -360,7 +364,7 @@ static uint32_t allwinner_sun8i_emac_get_desc(FrameDescriptor *desc,
 
     /* Note that the list is a cycle. Last entry points back to the head. */
     while (desc_addr != 0) {
-        cpu_physical_memory_read(desc_addr, desc, sizeof(*desc));
+        dma_memory_read(&s->dma_as, desc_addr, desc, sizeof(*desc));
 
         if ((desc->status & DESC_STATUS_CTL) &&
             (desc->status2 & DESC_STATUS2_BUF_SIZE_MASK) >= min_size) {
@@ -379,20 +383,21 @@ static uint32_t allwinner_sun8i_emac_rx_desc(AwSun8iEmacState *s,
                                              FrameDescriptor *desc,
                                              size_t min_size)
 {
-    return allwinner_sun8i_emac_get_desc(desc, s->rx_desc_curr, min_size);
+    return allwinner_sun8i_emac_get_desc(s, desc, s->rx_desc_curr, min_size);
 }
 
 static uint32_t allwinner_sun8i_emac_tx_desc(AwSun8iEmacState *s,
                                              FrameDescriptor *desc,
                                              size_t min_size)
 {
-    return allwinner_sun8i_emac_get_desc(desc, s->tx_desc_head, min_size);
+    return allwinner_sun8i_emac_get_desc(s, desc, s->tx_desc_head, min_size);
 }
 
-static void allwinner_sun8i_emac_flush_desc(FrameDescriptor *desc,
+static void allwinner_sun8i_emac_flush_desc(AwSun8iEmacState *s,
+                                            FrameDescriptor *desc,
                                             uint32_t phys_addr)
 {
-    cpu_physical_memory_write(phys_addr, desc, sizeof(*desc));
+    dma_memory_write(&s->dma_as, phys_addr, desc, sizeof(*desc));
 }
 
 static bool allwinner_sun8i_emac_can_receive(NetClientState *nc)
@@ -450,8 +455,8 @@ static ssize_t allwinner_sun8i_emac_receive(NetClientState *nc,
                             << RX_DESC_STATUS_FRM_LEN_SHIFT;
         }
 
-        cpu_physical_memory_write(desc.addr, buf, desc_bytes);
-        allwinner_sun8i_emac_flush_desc(&desc, s->rx_desc_curr);
+        dma_memory_write(&s->dma_as, desc.addr, buf, desc_bytes);
+        allwinner_sun8i_emac_flush_desc(s, &desc, s->rx_desc_curr);
         trace_allwinner_sun8i_emac_receive(s->rx_desc_curr, desc.addr,
                                            desc_bytes);
 
@@ -465,7 +470,7 @@ static ssize_t allwinner_sun8i_emac_receive(NetClientState *nc,
         bytes_left -= desc_bytes;
 
         /* Move to the next descriptor */
-        s->rx_desc_curr = allwinner_sun8i_emac_next_desc(&desc, 64);
+        s->rx_desc_curr = allwinner_sun8i_emac_next_desc(s, &desc, 64);
         if (!s->rx_desc_curr) {
             /* Not enough buffer space available */
             s->int_sta |= INT_STA_RX_BUF_UA;
@@ -501,10 +506,10 @@ static void allwinner_sun8i_emac_transmit(AwSun8iEmacState *s)
             desc.status |= TX_DESC_STATUS_LENGTH_ERR;
             break;
         }
-        cpu_physical_memory_read(desc.addr, packet_buf + packet_bytes, bytes);
+        dma_memory_read(&s->dma_as, desc.addr, packet_buf + packet_bytes, bytes);
         packet_bytes += bytes;
         desc.status &= ~DESC_STATUS_CTL;
-        allwinner_sun8i_emac_flush_desc(&desc, s->tx_desc_curr);
+        allwinner_sun8i_emac_flush_desc(s, &desc, s->tx_desc_curr);
 
         /* After the last descriptor, send the packet */
         if (desc.status2 & TX_DESC_STATUS2_LAST_DESC) {
@@ -519,7 +524,7 @@ static void allwinner_sun8i_emac_transmit(AwSun8iEmacState *s)
             packet_bytes = 0;
             transmitted++;
         }
-        s->tx_desc_curr = allwinner_sun8i_emac_next_desc(&desc, 0);
+        s->tx_desc_curr = allwinner_sun8i_emac_next_desc(s, &desc, 0);
     }
 
     /* Raise transmit completed interrupt */
@@ -623,7 +628,7 @@ static uint64_t allwinner_sun8i_emac_read(void *opaque, hwaddr offset,
         break;
     case REG_TX_CUR_BUF:        /* Transmit Current Buffer */
         if (s->tx_desc_curr != 0) {
-            cpu_physical_memory_read(s->tx_desc_curr, &desc, sizeof(desc));
+            dma_memory_read(&s->dma_as, s->tx_desc_curr, &desc, sizeof(desc));
             value = desc.addr;
         } else {
             value = 0;
@@ -636,7 +641,7 @@ static uint64_t allwinner_sun8i_emac_read(void *opaque, hwaddr offset,
         break;
     case REG_RX_CUR_BUF:        /* Receive Current Buffer */
         if (s->rx_desc_curr != 0) {
-            cpu_physical_memory_read(s->rx_desc_curr, &desc, sizeof(desc));
+            dma_memory_read(&s->dma_as, s->rx_desc_curr, &desc, sizeof(desc));
             value = desc.addr;
         } else {
             value = 0;
@@ -790,6 +795,13 @@ static void allwinner_sun8i_emac_realize(DeviceState *dev, Error **errp)
 {
     AwSun8iEmacState *s = AW_SUN8I_EMAC(dev);
 
+    if (!s->dma_mr) {
+        error_setg(errp, TYPE_AW_SUN8I_EMAC " 'dma-memory' link not set");
+        return;
+    }
+
+    address_space_init(&s->dma_as, s->dma_mr, "emac-dma");
+
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_allwinner_sun8i_emac_info, &s->conf,
                            object_get_typename(OBJECT(dev)), dev->id, s);
@@ -799,6 +811,8 @@ static void allwinner_sun8i_emac_realize(DeviceState *dev, Error **errp)
 static Property allwinner_sun8i_emac_properties[] = {
     DEFINE_NIC_PROPERTIES(AwSun8iEmacState, conf),
     DEFINE_PROP_UINT8("phy-addr", AwSun8iEmacState, mii_phy_addr, 0),
+    DEFINE_PROP_LINK("dma-memory", AwSun8iEmacState, dma_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.21.3


