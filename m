Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A31DC43466
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 08:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56D220809
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 08:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56D220809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJuby-00059p-1t
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 04:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kJuaY-0003UZ-3r; Sun, 20 Sep 2020 04:20:50 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:56542
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kJuaW-0003ud-GQ; Sun, 20 Sep 2020 04:20:49 -0400
Received: from host81-154-161-117.range81-154.btcentralplus.com
 ([81.154.161.117] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kJub0-0006Dn-U6; Sun, 20 Sep 2020 09:21:25 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: armbru@redhat.com, david@gibson.dropbear.id.au, atar4qemu@gmail.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Date: Sun, 20 Sep 2020 09:20:15 +0100
Message-Id: <20200920082018.16135-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200920082018.16135-1-mark.cave-ayland@ilande.co.uk>
References: <20200920082018.16135-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 81.154.161.117
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 3/6] sparc32-espdma: use object_initialize_child() for esp
 child object
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Store the child object directly within the sparc32-espdma object rather than
using link properties.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/dma/sparc32_dma.c           | 17 ++++++++---------
 include/hw/sparc/sparc32_dma.h |  2 +-
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 84196afb95..2cbe331959 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -290,27 +290,26 @@ static const TypeInfo sparc32_dma_device_info = {
 static void sparc32_espdma_device_init(Object *obj)
 {
     DMADeviceState *s = SPARC32_DMA_DEVICE(obj);
+    ESPDMADeviceState *es = SPARC32_ESPDMA_DEVICE(obj);
 
     memory_region_init_io(&s->iomem, OBJECT(s), &dma_mem_ops, s,
                           "espdma-mmio", DMA_SIZE);
+
+    object_initialize_child(obj, "esp", &es->esp, TYPE_ESP);
 }
 
 static void sparc32_espdma_device_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *d;
-    SysBusESPState *sysbus;
-    ESPState *esp;
-
-    d = qdev_new(TYPE_ESP);
-    object_property_add_child(OBJECT(dev), "esp", OBJECT(d));
-    sysbus = ESP(d);
-    esp = &sysbus->esp;
+    ESPDMADeviceState *es = SPARC32_ESPDMA_DEVICE(dev);
+    SysBusESPState *sysbus = ESP(&es->esp);
+    ESPState *esp = &sysbus->esp;
+
     esp->dma_memory_read = espdma_memory_read;
     esp->dma_memory_write = espdma_memory_write;
     esp->dma_opaque = SPARC32_DMA_DEVICE(dev);
     sysbus->it_shift = 2;
     esp->dma_enabled = 1;
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(d), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(sysbus), &error_fatal);
 }
 
 static void sparc32_espdma_device_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/sparc/sparc32_dma.h b/include/hw/sparc/sparc32_dma.h
index f2bfe272ba..d40eca0cc8 100644
--- a/include/hw/sparc/sparc32_dma.h
+++ b/include/hw/sparc/sparc32_dma.h
@@ -32,7 +32,7 @@ DECLARE_INSTANCE_CHECKER(ESPDMADeviceState, SPARC32_ESPDMA_DEVICE,
 struct ESPDMADeviceState {
     DMADeviceState parent_obj;
 
-    SysBusESPState *esp;
+    SysBusESPState esp;
 };
 
 #define TYPE_SPARC32_LEDMA_DEVICE "sparc32-ledma"
-- 
2.20.1


