Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C21AC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 17:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197E8204EA
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 17:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5FOWe+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197E8204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfSBz-0005c5-87
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 13:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfSAM-0003cm-SH; Sun, 31 May 2020 13:54:34 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfSAM-0007dB-40; Sun, 31 May 2020 13:54:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id j10so9178453wrw.8;
 Sun, 31 May 2020 10:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Dvh9ZlB2YzrPmnRo8g2PXiL+qQpysab7ZLFeTg1BN6M=;
 b=m5FOWe+F0mJ3nRIzM6rEIVG4pL/paYIdc8LcC9s2mubExfLa4bP3mScZBfKAFFlUCY
 HIqNbm/Vk8F60YK32Vz5eWU63PJnA7aRiqMKB/qFdoCCcHoWyRMkgA2E2LqMbwO2ckVj
 fTEaC20FNMY/T0tAD71jDyN01kpx80Zbu/eS5yqISplqbdq9UPpALGcov8FUJlUjd3KE
 DHKOk31OCux1I5V1zczEOUvOlx/137Jy4+Z45uKvwV5TrvH1p9KFohLM+iMpYwCwPVYw
 qUU6gpbMU2tX5oLZjKVyyupdBFhAEH6MAGTUQ7OV9snrozylipWc5p0/+xU2SeRLcd4Q
 R6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Dvh9ZlB2YzrPmnRo8g2PXiL+qQpysab7ZLFeTg1BN6M=;
 b=WozwpQOKYax+UDpJUplxUnxehVv3UZcnd3vT3kahvGWeKZ60ooqkvAq/6XhY6rX6gm
 N4Ie8y8z/zvhs9DVyu47vCviVroyE8G1nJ0fSMhj9HeMhhTifSgINiGNO76Chc8mKtJz
 3w8zTR24u71i6RZmVANbyne6Z8z1UG4h1BSoj7w7iJrwWZlwiEsb9LX42rg+vACI4cvr
 kFsxkuq+eMU1tZjKdCRBoZM/EJN9qSRGlwsDPr45wVCStIxVQy6BCLE5LsvxOt/WKQSg
 mbQk8a1hs7fZd3gbC1MvEopfpcRKVExYAPsWY7VFybrv82jK+gsCF0cifuAYBRuIQSM8
 A4Kw==
X-Gm-Message-State: AOAM532jJYtMK+eAoVqcP3YzzKGssoKND5vHy4cvacQ4L1O/p5hZjb6M
 GYil6mFqaSO91fs0Ey/knIV/IDGo
X-Google-Smtp-Source: ABdhPJz1GxV/uSud2mIcv0IYegcyrgtYn8yN7VsULEQJnNJnzS/9BP3ki2V6Kb4lwBWxdAKacleCzg==
X-Received: by 2002:a5d:6283:: with SMTP id k3mr17748351wru.422.1590947671873; 
 Sun, 31 May 2020 10:54:31 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id z7sm17862531wrt.6.2020.05.31.10.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 10:54:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] hw/sd/allwinner-sdhost: Do DMA accesses via DMA address
 space
Date: Sun, 31 May 2020 19:54:22 +0200
Message-Id: <20200531175425.10329-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531175425.10329-1-f4bug@amsat.org>
References: <20200531175425.10329-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The DMA operations should not use the CPU address space, but
the DMA address space. Add support for a DMA address space,
and replace the cpu_physical_memory API calls by equivalent
dma_memory_read/write calls.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/allwinner-sdhost.h |  4 ++++
 hw/sd/allwinner-sdhost.c         | 36 ++++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/hw/sd/allwinner-sdhost.h b/include/hw/sd/allwinner-sdhost.h
index d94606a853..ae1125c026 100644
--- a/include/hw/sd/allwinner-sdhost.h
+++ b/include/hw/sd/allwinner-sdhost.h
@@ -68,6 +68,10 @@ typedef struct AwSdHostState {
     /** Maps I/O registers in physical memory */
     MemoryRegion iomem;
 
+    /** DMA physical memory */
+    MemoryRegion *dma_mr;
+    AddressSpace dma_as;
+
     /** Interrupt output signal to notify CPU */
     qemu_irq irq;
 
diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index f404e1fdb4..9a2b5fcaeb 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -21,7 +21,10 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
+#include "qapi/error.h"
 #include "sysemu/blockdev.h"
+#include "sysemu/dma.h"
+#include "hw/qdev-properties.h"
 #include "hw/irq.h"
 #include "hw/sd/allwinner-sdhost.h"
 #include "migration/vmstate.h"
@@ -306,7 +309,7 @@ static uint32_t allwinner_sdhost_process_desc(AwSdHostState *s,
     uint8_t buf[1024];
 
     /* Read descriptor */
-    cpu_physical_memory_read(desc_addr, desc, sizeof(*desc));
+    dma_memory_read(&s->dma_as, desc_addr, desc, sizeof(*desc));
     if (desc->size == 0) {
         desc->size = klass->max_desc_size;
     } else if (desc->size > klass->max_desc_size) {
@@ -331,8 +334,9 @@ static uint32_t allwinner_sdhost_process_desc(AwSdHostState *s,
 
         /* Write to SD bus */
         if (is_write) {
-            cpu_physical_memory_read((desc->addr & DESC_SIZE_MASK) + num_done,
-                                      buf, buf_bytes);
+            dma_memory_read(&s->dma_as,
+                            (desc->addr & DESC_SIZE_MASK) + num_done,
+                            buf, buf_bytes);
 
             for (uint32_t i = 0; i < buf_bytes; i++) {
                 sdbus_write_data(&s->sdbus, buf[i]);
@@ -343,15 +347,16 @@ static uint32_t allwinner_sdhost_process_desc(AwSdHostState *s,
             for (uint32_t i = 0; i < buf_bytes; i++) {
                 buf[i] = sdbus_read_data(&s->sdbus);
             }
-            cpu_physical_memory_write((desc->addr & DESC_SIZE_MASK) + num_done,
-                                       buf, buf_bytes);
+            dma_memory_write(&s->dma_as,
+                             (desc->addr & DESC_SIZE_MASK) + num_done,
+                             buf, buf_bytes);
         }
         num_done += buf_bytes;
     }
 
     /* Clear hold flag and flush descriptor */
     desc->status &= ~DESC_STATUS_HOLD;
-    cpu_physical_memory_write(desc_addr, desc, sizeof(*desc));
+    dma_memory_write(&s->dma_as, desc_addr, desc, sizeof(*desc));
 
     return num_done;
 }
@@ -742,6 +747,17 @@ static void allwinner_sdhost_init(Object *obj)
     sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
 }
 
+static void allwinner_sdhost_realize(DeviceState *dev, Error **errp)
+{
+    AwSdHostState *s = AW_SDHOST(dev);
+
+    if (!s->dma_mr) {
+        error_setg(errp, "\"dma\" property must be provided.");
+        return;
+    }
+    address_space_init(&s->dma_as, s->dma_mr, "sdhost-dma");
+}
+
 static void allwinner_sdhost_reset(DeviceState *dev)
 {
     AwSdHostState *s = AW_SDHOST(dev);
@@ -787,6 +803,12 @@ static void allwinner_sdhost_reset(DeviceState *dev)
     s->status_crc = REG_SD_CRC_STA_RST;
 }
 
+static Property allwinner_sdhost_properties[] = {
+    DEFINE_PROP_LINK("dma", AwSdHostState,
+                     dma_mr, TYPE_MEMORY_REGION, MemoryRegion *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void allwinner_sdhost_bus_class_init(ObjectClass *klass, void *data)
 {
     SDBusClass *sbc = SD_BUS_CLASS(klass);
@@ -798,7 +820,9 @@ static void allwinner_sdhost_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    device_class_set_props(dc, allwinner_sdhost_properties);
     dc->reset = allwinner_sdhost_reset;
+    dc->realize = allwinner_sdhost_realize;
     dc->vmsd = &vmstate_allwinner_sdhost;
 }
 
-- 
2.21.3


