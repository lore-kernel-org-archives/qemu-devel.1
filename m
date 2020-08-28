Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD11FC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:27:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B001208D5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ATjuZSOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B001208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBafA-0000bg-R4
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacS-0003q6-1H
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:24 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacQ-0004Ds-3c
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:23 -0400
Received: by mail-wm1-x343.google.com with SMTP id o21so291707wmc.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=uGylmRAg4VQOVP0AwnOVZdxzfdcXzINOmGxwtw6sPGQ=;
 b=ATjuZSOQGyJHTmTDn60SmHtv9cjlUlSkb69f+/NldsE207zQnRBK2+h6y/zf+xaOaW
 jEXlaB/YV3gVuu52DZlH/stMoVtuxSyKY9tBbdGLIAeAdjRcWIMEwU+2HZSLtUupPdN6
 xeF8t8lWDHbmKjOeR2IalUFGolFJXpWIRq2u+GC2rCGCNZafO6XL2hLRD9zDemq491Ut
 u5ykNSn2+Pgxi939vV+pB7AN2Hjv59noYWEY3/IOdFiT/+LOzmBMXh6bBoyXfX8xoT3h
 vCd1LGn5PLumpVHl/DOsKvelK6Hd8StFV7bokZH8v8QLiHntVQLKmI1eNiK5j1KfM0cO
 qUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uGylmRAg4VQOVP0AwnOVZdxzfdcXzINOmGxwtw6sPGQ=;
 b=Hzab1amUiKxxrBq80mpBuPbuFXqqEZoknjWekwcwUGK4wwWip/uLERNXXGROPOTky5
 dJ4B7DxrDv/kHZpMw3E6HnbzaE8Qx1PvwGTPX280P/TcM4G2NLwNOAgog3wGH6IVT88S
 yHtiXStVftjnfDSMvrgXGDv0nd0BGQT61oTrDmPZgn85br+jbPZqZR227Us/C3ikxwP2
 ZAUeREki5zOw81UBcv6JaimlsZHNDz7FWBgaBPbpt+ZcKdJCt7thKPZd8wXtgsq3pDM0
 OvWN1cvGYk6miN1LMEv7PsIwfM9D87xr2y0tbtm5hQM4rPr/bVBLD3JsJj8eypP5tLow
 /G7A==
X-Gm-Message-State: AOAM5331KP7MXTiD232u26jM1v+cnG91vi8cgEbTp9aGYQjxyB+7ZtKO
 5hSrjq5fIUSamtVAC6XBDmIRn6bQdM/zYSoA
X-Google-Smtp-Source: ABdhPJzOSac2rnKyUtqkChozY7ujZj743M2Oie7cRJx/zE77hTve+6K5bec2fNiY/mk2QWGdoXmN/A==
X-Received: by 2002:a1c:32c3:: with SMTP id y186mr694982wmy.15.1598606660450; 
 Fri, 28 Aug 2020 02:24:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/35] hw/arm/musicpal: Use AddressSpace for DMA transfers
Date: Fri, 28 Aug 2020 10:23:43 +0100
Message-Id: <20200828092413.22206-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Allow the device to execute the DMA transfers in a different
AddressSpace.

We keep using the system_memory address space, but via the
proper dma_memory_access() API.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200814125533.4047-1-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/musicpal.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index c3b9780f352..f2f4fc02649 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -30,6 +30,7 @@
 #include "hw/audio/wm8750.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/runstate.h"
+#include "sysemu/dma.h"
 #include "exec/address-spaces.h"
 #include "ui/pixel_ops.h"
 #include "qemu/cutils.h"
@@ -163,6 +164,8 @@ typedef struct mv88w8618_eth_state {
 
     MemoryRegion iomem;
     qemu_irq irq;
+    MemoryRegion *dma_mr;
+    AddressSpace dma_as;
     uint32_t smir;
     uint32_t icr;
     uint32_t imr;
@@ -176,19 +179,21 @@ typedef struct mv88w8618_eth_state {
     NICConf conf;
 } mv88w8618_eth_state;
 
-static void eth_rx_desc_put(uint32_t addr, mv88w8618_rx_desc *desc)
+static void eth_rx_desc_put(AddressSpace *dma_as, uint32_t addr,
+                            mv88w8618_rx_desc *desc)
 {
     cpu_to_le32s(&desc->cmdstat);
     cpu_to_le16s(&desc->bytes);
     cpu_to_le16s(&desc->buffer_size);
     cpu_to_le32s(&desc->buffer);
     cpu_to_le32s(&desc->next);
-    cpu_physical_memory_write(addr, desc, sizeof(*desc));
+    dma_memory_write(dma_as, addr, desc, sizeof(*desc));
 }
 
-static void eth_rx_desc_get(uint32_t addr, mv88w8618_rx_desc *desc)
+static void eth_rx_desc_get(AddressSpace *dma_as, uint32_t addr,
+                            mv88w8618_rx_desc *desc)
 {
-    cpu_physical_memory_read(addr, desc, sizeof(*desc));
+    dma_memory_read(dma_as, addr, desc, sizeof(*desc));
     le32_to_cpus(&desc->cmdstat);
     le16_to_cpus(&desc->bytes);
     le16_to_cpus(&desc->buffer_size);
@@ -209,9 +214,9 @@ static ssize_t eth_receive(NetClientState *nc, const uint8_t *buf, size_t size)
             continue;
         }
         do {
-            eth_rx_desc_get(desc_addr, &desc);
+            eth_rx_desc_get(&s->dma_as, desc_addr, &desc);
             if ((desc.cmdstat & MP_ETH_RX_OWN) && desc.buffer_size >= size) {
-                cpu_physical_memory_write(desc.buffer + s->vlan_header,
+                dma_memory_write(&s->dma_as, desc.buffer + s->vlan_header,
                                           buf, size);
                 desc.bytes = size + s->vlan_header;
                 desc.cmdstat &= ~MP_ETH_RX_OWN;
@@ -221,7 +226,7 @@ static ssize_t eth_receive(NetClientState *nc, const uint8_t *buf, size_t size)
                 if (s->icr & s->imr) {
                     qemu_irq_raise(s->irq);
                 }
-                eth_rx_desc_put(desc_addr, &desc);
+                eth_rx_desc_put(&s->dma_as, desc_addr, &desc);
                 return size;
             }
             desc_addr = desc.next;
@@ -230,19 +235,21 @@ static ssize_t eth_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     return size;
 }
 
-static void eth_tx_desc_put(uint32_t addr, mv88w8618_tx_desc *desc)
+static void eth_tx_desc_put(AddressSpace *dma_as, uint32_t addr,
+                            mv88w8618_tx_desc *desc)
 {
     cpu_to_le32s(&desc->cmdstat);
     cpu_to_le16s(&desc->res);
     cpu_to_le16s(&desc->bytes);
     cpu_to_le32s(&desc->buffer);
     cpu_to_le32s(&desc->next);
-    cpu_physical_memory_write(addr, desc, sizeof(*desc));
+    dma_memory_write(dma_as, addr, desc, sizeof(*desc));
 }
 
-static void eth_tx_desc_get(uint32_t addr, mv88w8618_tx_desc *desc)
+static void eth_tx_desc_get(AddressSpace *dma_as, uint32_t addr,
+                            mv88w8618_tx_desc *desc)
 {
-    cpu_physical_memory_read(addr, desc, sizeof(*desc));
+    dma_memory_read(dma_as, addr, desc, sizeof(*desc));
     le32_to_cpus(&desc->cmdstat);
     le16_to_cpus(&desc->res);
     le16_to_cpus(&desc->bytes);
@@ -259,17 +266,17 @@ static void eth_send(mv88w8618_eth_state *s, int queue_index)
     int len;
 
     do {
-        eth_tx_desc_get(desc_addr, &desc);
+        eth_tx_desc_get(&s->dma_as, desc_addr, &desc);
         next_desc = desc.next;
         if (desc.cmdstat & MP_ETH_TX_OWN) {
             len = desc.bytes;
             if (len < 2048) {
-                cpu_physical_memory_read(desc.buffer, buf, len);
+                dma_memory_read(&s->dma_as, desc.buffer, buf, len);
                 qemu_send_packet(qemu_get_queue(s->nic), buf, len);
             }
             desc.cmdstat &= ~MP_ETH_TX_OWN;
             s->icr |= 1 << (MP_ETH_IRQ_TXLO_BIT - queue_index);
-            eth_tx_desc_put(desc_addr, &desc);
+            eth_tx_desc_put(&s->dma_as, desc_addr, &desc);
         }
         desc_addr = next_desc;
     } while (desc_addr != s->tx_queue[queue_index]);
@@ -405,6 +412,12 @@ static void mv88w8618_eth_realize(DeviceState *dev, Error **errp)
 {
     mv88w8618_eth_state *s = MV88W8618_ETH(dev);
 
+    if (!s->dma_mr) {
+        error_setg(errp, TYPE_MV88W8618_ETH " 'dma-memory' link not set");
+        return;
+    }
+
+    address_space_init(&s->dma_as, s->dma_mr, "emac-dma");
     s->nic = qemu_new_nic(&net_mv88w8618_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id, s);
 }
@@ -428,6 +441,8 @@ static const VMStateDescription mv88w8618_eth_vmsd = {
 
 static Property mv88w8618_eth_properties[] = {
     DEFINE_NIC_PROPERTIES(mv88w8618_eth_state, conf),
+    DEFINE_PROP_LINK("dma-memory", mv88w8618_eth_state, dma_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1653,6 +1668,8 @@ static void musicpal_init(MachineState *machine)
     qemu_check_nic_model(&nd_table[0], "mv88w8618");
     dev = qdev_new(TYPE_MV88W8618_ETH);
     qdev_set_nic_properties(dev, &nd_table[0]);
+    object_property_set_link(OBJECT(dev), "dma-memory",
+                             OBJECT(get_system_memory()), &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, MP_ETH_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[MP_ETH_IRQ]);
-- 
2.20.1


