Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A85C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A99532075E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyP3UqNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99532075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAene-0003Lk-UL
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeWt-0001Gg-6p
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:22:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24533)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeWr-0006HR-Fm
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598383364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8qERUAxboTRUwmKdOmtOW95P1o1K/BX9a9uT0sKpV4=;
 b=WyP3UqNjHXto9G+fe1vmtTV+8YIDM0oSzyGTd+PZdIOPUqaaNhiy4rApOtFy5CRPaVxt/h
 fe0qmmCKhEF6jQphqQWte0DEAU38JTYY9FGRPZ0XM4Z/T2j1e3aJi1ZZCX0oDjYs8qP7hq
 s7R0Ms9E2CXToFX+IJukJkR29OrHXJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-BXEUAYmiMGSDAyo6MMjfng-1; Tue, 25 Aug 2020 15:22:41 -0400
X-MC-Unique: BXEUAYmiMGSDAyo6MMjfng-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0F1A85B67B;
 Tue, 25 Aug 2020 19:22:39 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A5DA1002D4D;
 Tue, 25 Aug 2020 19:22:39 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 39/74] pxa2xx: Move QOM macros to header
Date: Tue, 25 Aug 2020 15:20:35 -0400
Message-Id: <20200825192110.3528606-40-ehabkost@redhat.com>
In-Reply-To: <20200825192110.3528606-1-ehabkost@redhat.com>
References: <20200825192110.3528606-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 06:38:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make future conversion to OBJECT_DECLARE* easier.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v2 -> v3: none

Changes series v1 -> v2: new patch in series v2

Cc: Andrzej Zaborowski <balrogg@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
---
 include/hw/arm/pxa.h | 13 +++++++++++++
 hw/arm/pxa2xx.c      |  7 -------
 hw/pcmcia/pxa2xx.c   |  4 ----
 hw/sd/pxa2xx_mmci.c  |  3 ---
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/hw/arm/pxa.h b/include/hw/arm/pxa.h
index d99b6192da..09c1336071 100644
--- a/include/hw/arm/pxa.h
+++ b/include/hw/arm/pxa.h
@@ -86,7 +86,10 @@ PXA2xxLCDState *pxa2xx_lcdc_init(MemoryRegion *sysmem,
 void pxa2xx_lcd_vsync_notifier(PXA2xxLCDState *s, qemu_irq handler);
 
 /* pxa2xx_mmci.c */
+#define TYPE_PXA2XX_MMCI "pxa2xx-mmci"
 typedef struct PXA2xxMMCIState PXA2xxMMCIState;
+#define PXA2XX_MMCI(obj) OBJECT_CHECK(PXA2xxMMCIState, (obj), TYPE_PXA2XX_MMCI)
+
 PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
                 hwaddr base,
                 qemu_irq irq, qemu_irq rx_dma, qemu_irq tx_dma);
@@ -94,7 +97,11 @@ void pxa2xx_mmci_handlers(PXA2xxMMCIState *s, qemu_irq readonly,
                 qemu_irq coverswitch);
 
 /* pxa2xx_pcmcia.c */
+#define TYPE_PXA2XX_PCMCIA "pxa2xx-pcmcia"
 typedef struct PXA2xxPCMCIAState PXA2xxPCMCIAState;
+#define PXA2XX_PCMCIA(obj) \
+    OBJECT_CHECK(PXA2xxPCMCIAState, obj, TYPE_PXA2XX_PCMCIA)
+
 PXA2xxPCMCIAState *pxa2xx_pcmcia_init(MemoryRegion *sysmem,
                                       hwaddr base);
 int pxa2xx_pcmcia_attach(void *opaque, PCMCIACardState *card);
@@ -119,8 +126,14 @@ PXA2xxI2CState *pxa2xx_i2c_init(hwaddr base,
                 qemu_irq irq, uint32_t page_size);
 I2CBus *pxa2xx_i2c_bus(PXA2xxI2CState *s);
 
+#define TYPE_PXA2XX_I2C "pxa2xx_i2c"
 typedef struct PXA2xxI2SState PXA2xxI2SState;
+#define PXA2XX_I2C(obj) \
+    OBJECT_CHECK(PXA2xxI2CState, (obj), TYPE_PXA2XX_I2C)
+
+#define TYPE_PXA2XX_FIR "pxa2xx-fir"
 typedef struct PXA2xxFIrState PXA2xxFIrState;
+#define PXA2XX_FIR(obj) OBJECT_CHECK(PXA2xxFIrState, (obj), TYPE_PXA2XX_FIR)
 
 typedef struct {
     ARMCPU *cpu;
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 20fa201dd5..76975d17a4 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -1251,10 +1251,6 @@ typedef struct PXA2xxI2CSlaveState {
     PXA2xxI2CState *host;
 } PXA2xxI2CSlaveState;
 
-#define TYPE_PXA2XX_I2C "pxa2xx_i2c"
-#define PXA2XX_I2C(obj) \
-    OBJECT_CHECK(PXA2xxI2CState, (obj), TYPE_PXA2XX_I2C)
-
 struct PXA2xxI2CState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -1787,9 +1783,6 @@ static PXA2xxI2SState *pxa2xx_i2s_init(MemoryRegion *sysmem,
 }
 
 /* PXA Fast Infra-red Communications Port */
-#define TYPE_PXA2XX_FIR "pxa2xx-fir"
-#define PXA2XX_FIR(obj) OBJECT_CHECK(PXA2xxFIrState, (obj), TYPE_PXA2XX_FIR)
-
 struct PXA2xxFIrState {
     /*< private >*/
     SysBusDevice parent_obj;
diff --git a/hw/pcmcia/pxa2xx.c b/hw/pcmcia/pxa2xx.c
index 5f4bf22a90..fcca7e571b 100644
--- a/hw/pcmcia/pxa2xx.c
+++ b/hw/pcmcia/pxa2xx.c
@@ -18,10 +18,6 @@
 #include "hw/pcmcia.h"
 #include "hw/arm/pxa.h"
 
-#define TYPE_PXA2XX_PCMCIA "pxa2xx-pcmcia"
-#define PXA2XX_PCMCIA(obj) \
-    OBJECT_CHECK(PXA2xxPCMCIAState, obj, TYPE_PXA2XX_PCMCIA)
-
 struct PXA2xxPCMCIAState {
     SysBusDevice parent_obj;
 
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 04f0a98f81..3a47b380dd 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -22,9 +22,6 @@
 #include "qemu/module.h"
 #include "trace.h"
 
-#define TYPE_PXA2XX_MMCI "pxa2xx-mmci"
-#define PXA2XX_MMCI(obj) OBJECT_CHECK(PXA2xxMMCIState, (obj), TYPE_PXA2XX_MMCI)
-
 #define TYPE_PXA2XX_MMCI_BUS "pxa2xx-mmci-bus"
 #define PXA2XX_MMCI_BUS(obj) OBJECT_CHECK(SDBus, (obj), TYPE_PXA2XX_MMCI_BUS)
 
-- 
2.26.2


