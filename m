Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C272DC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 21:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 592922087C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 21:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AaspwPF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592922087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFle3-00084F-CJ
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 17:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kFlYB-0005HP-Ds
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 17:53:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48505
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kFlY9-0001Jj-Fb
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 17:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599601992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KBBQHKCaZNmcoT8GjRywod67shGKvN15dsv6PCG16Vk=;
 b=AaspwPF2SKDaKRpWsxMAPH9UbsV0aQ93VxiB/D/XgBbD4emSe2q9Dx1+Vdacaz9CbwXRsb
 c8a4sXmgdGYUliMGfHao8EfQ8tRnSYuG58VZ8p7Ojny5cYB5KBUlv4YutEoD6Y1nN3rikP
 WAcCksuj+99XFLv7R+lJrzFlfrfLScc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-jwcCXVWzOu-ZS0Axy6If1w-1; Tue, 08 Sep 2020 17:53:10 -0400
X-MC-Unique: jwcCXVWzOu-ZS0Axy6If1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D854C1091069;
 Tue,  8 Sep 2020 21:53:09 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72C5F1002D46;
 Tue,  8 Sep 2020 21:53:09 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 21/34] esp: Rename ESP_STATE to ESP
Date: Tue,  8 Sep 2020 17:52:26 -0400
Message-Id: <20200908215239.3519638-22-ehabkost@redhat.com>
In-Reply-To: <20200908215239.3519638-1-ehabkost@redhat.com>
References: <20200908215239.3519638-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 12:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the type checking macro name consistent with the TYPE_*
constant.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
Message-Id: <20200902224311.1321159-40-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/scsi/esp.h | 2 +-
 hw/dma/sparc32_dma.c  | 2 +-
 hw/m68k/q800.c        | 2 +-
 hw/mips/jazz.c        | 2 +-
 hw/scsi/esp.c         | 6 +++---
 hw/sparc/sun4m.c      | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index f281625dd5..20800dbf5b 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -67,7 +67,7 @@ struct ESPState {
 
 #define TYPE_ESP "esp"
 typedef struct SysBusESPState SysBusESPState;
-DECLARE_INSTANCE_CHECKER(SysBusESPState, ESP_STATE,
+DECLARE_INSTANCE_CHECKER(SysBusESPState, ESP,
                          TYPE_ESP)
 
 struct SysBusESPState {
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index bcd1626fbd..d20a5bc065 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -303,7 +303,7 @@ static void sparc32_espdma_device_realize(DeviceState *dev, Error **errp)
 
     d = qdev_new(TYPE_ESP);
     object_property_add_child(OBJECT(dev), "esp", OBJECT(d));
-    sysbus = ESP_STATE(d);
+    sysbus = ESP(d);
     esp = &sysbus->esp;
     esp->dma_memory_read = espdma_memory_read;
     esp->dma_memory_write = espdma_memory_write;
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 1ca482ad81..ce4b47c3e3 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -290,7 +290,7 @@ static void q800_init(MachineState *machine)
     /* SCSI */
 
     dev = qdev_new(TYPE_ESP);
-    sysbus_esp = ESP_STATE(dev);
+    sysbus_esp = ESP(dev);
     esp = &sysbus_esp->esp;
     esp->dma_memory_read = NULL;
     esp->dma_memory_write = NULL;
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 82a6e3220e..47723093b6 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -309,7 +309,7 @@ static void mips_jazz_init(MachineState *machine,
 
     /* SCSI adapter */
     dev = qdev_new(TYPE_ESP);
-    sysbus_esp = ESP_STATE(dev);
+    sysbus_esp = ESP(dev);
     esp = &sysbus_esp->esp;
     esp->dma_memory_read = rc4030_dma_read;
     esp->dma_memory_write = rc4030_dma_write;
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 405f8b7cbc..b84e0fe33e 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -929,7 +929,7 @@ static const struct SCSIBusInfo esp_scsi_info = {
 
 static void sysbus_esp_gpio_demux(void *opaque, int irq, int level)
 {
-    SysBusESPState *sysbus = ESP_STATE(opaque);
+    SysBusESPState *sysbus = ESP(opaque);
     ESPState *s = &sysbus->esp;
 
     switch (irq) {
@@ -945,7 +945,7 @@ static void sysbus_esp_gpio_demux(void *opaque, int irq, int level)
 static void sysbus_esp_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    SysBusESPState *sysbus = ESP_STATE(dev);
+    SysBusESPState *sysbus = ESP(dev);
     ESPState *s = &sysbus->esp;
 
     sysbus_init_irq(sbd, &s->irq);
@@ -967,7 +967,7 @@ static void sysbus_esp_realize(DeviceState *dev, Error **errp)
 
 static void sysbus_esp_hard_reset(DeviceState *dev)
 {
-    SysBusESPState *sysbus = ESP_STATE(dev);
+    SysBusESPState *sysbus = ESP(dev);
     esp_hard_reset(&sysbus->esp);
 }
 
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 256033b9a0..947b69d159 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -335,7 +335,7 @@ static void *sparc32_dma_init(hwaddr dma_base,
                                    OBJECT(dma), "espdma"));
     sysbus_connect_irq(SYS_BUS_DEVICE(espdma), 0, espdma_irq);
 
-    esp = ESP_STATE(object_resolve_path_component(OBJECT(espdma), "esp"));
+    esp = ESP(object_resolve_path_component(OBJECT(espdma), "esp"));
     sysbus_mmio_map(SYS_BUS_DEVICE(esp), 0, esp_base);
     scsi_bus_legacy_handle_cmdline(&esp->esp.bus);
 
-- 
2.26.2


