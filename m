Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F979C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 12:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B5F02087D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 12:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOkGzPxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5F02087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ZFy-0007wM-HE
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 08:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6ZFD-0007Ld-Hx; Fri, 14 Aug 2020 08:55:39 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53193)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6ZFB-0005ha-Vm; Fri, 14 Aug 2020 08:55:39 -0400
Received: by mail-wm1-x343.google.com with SMTP id x5so7391546wmi.2;
 Fri, 14 Aug 2020 05:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=drA4MKZeTEkxQZdpt6aMuhasPyyZSu+/CHLdXIl6ncE=;
 b=XOkGzPxvW4BRG4+tsHIoUL6I9GVeaCaB/Fj27M/Vv1Sf5Zt8FArylFDwuVi6NKamXG
 vZ9NAgmNzqRMHiprA9cZfuydXwrey3XqmcYaMUAOQJzbLa2GIYYoyxlh17SyWetE3z3q
 rVwANaoH4CA/dsvqD3Z6BmLBmj6KObzviB/4VG1OSAkApuRAnhFo1X4JZumKa0xp1d91
 8B3cLqkHFt3FyE/+ERDEDmm+TRSSK1GLlfuRelLMH2kFRkvXcwcmo9pPXHEMbmnRMiyl
 Mnf7S7tXs6wxebd1OqY2kfaxLU8doHFTqch1hywWPocDdaMALWYrX1bGuB1hoWEvrlZi
 aakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=drA4MKZeTEkxQZdpt6aMuhasPyyZSu+/CHLdXIl6ncE=;
 b=QYPVKtd5fDmv+fl3D+aj6KJXFJrxfAMXUNXvtETcrF+67dVej9mFTuysUuLyknDiZd
 ImkNV7NFvSVBfGbfQkfEpbeLuFsrIvVwRjJqI7WChqLusZSel+768et4rjevZdjQhvc+
 9QFmIItwKPJ0ZjYPwZ1NmK3KHpQ4w2qB1dDYdF295cI56fEjPQIhUCFG/dwS9evG0LnA
 8369I5deCA01SQM+neCqMwZ/IyWsmu4l10b/i3zIkoC9G7Wb3G8sk9bvp7R9oWCIDRu3
 yk0/C0WP61eV7Yt8mxFSjKY7g+yvR0ODuVa/NXIQWP+twYjeWJ1Ec2l0zCZCVg8vaPcF
 7W4A==
X-Gm-Message-State: AOAM5307WehhBti23ENugjoY9zwXgN838Davl2egCU+GpeEs7shj+tF/
 5EirD/WI5CSy+HLHeRLMIE1VS9VwGqk=
X-Google-Smtp-Source: ABdhPJxRiVDIJwLURYwd8QJF3f4pRMTh1J+FTFi2etNRxHvulvSr1zdVQ0SRedj3MWdiiN1YORY24w==
X-Received: by 2002:a1c:96d7:: with SMTP id y206mr2410779wmd.9.1597409735604; 
 Fri, 14 Aug 2020 05:55:35 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id v16sm14593469wmj.14.2020.08.14.05.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 05:55:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/arm/musicpal: Use AddressSpace for DMA transfers
Date: Fri, 14 Aug 2020 14:55:33 +0200
Message-Id: <20200814125533.4047-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow the device to execute the DMA transfers in a different
AddressSpace.

We keep using the system_memory address space, but via the
proper dma_memory_access() API.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/musicpal.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index c3b9780f35..f2f4fc0264 100644
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
2.21.3


