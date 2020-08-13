Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B1FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C76207DA
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lmcs/YX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C76207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Lli-0005Lt-Tw
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 18:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6LgK-00053t-Dy
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:26:44 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32377
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6LgH-0002qY-4O
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597357600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kiwWN8mOvmiBiIEiDOUofxiW+e4f0M4TCf5kWQUuNnk=;
 b=Lmcs/YX2fLd1quAyVj0zWxtwV93vZlL1gaX4bazV3nM+MctBBOPf4k+kJ3k+7RVBsPf53T
 vTGv7sMdsmdc7WDYzYWAZ8F/Y6RoNUO4xPE98lWZx9vdA+hDujSyGwY152tp3QUlSI9UQW
 6uPNAibvO5tlSaezYhnzTZo1znShIFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-ElB6peieNoSeykuaxS8Bww-1; Thu, 13 Aug 2020 18:26:36 -0400
X-MC-Unique: ElB6peieNoSeykuaxS8Bww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AF8E1019627
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 22:26:36 +0000 (UTC)
Received: from localhost (ovpn-117-153.rdu2.redhat.com [10.10.117.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95BD15D9D2;
 Thu, 13 Aug 2020 22:26:35 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/41] aspeed_soc: Rename memmap/irqmap enum constants
Date: Thu, 13 Aug 2020 18:25:51 -0400
Message-Id: <20200813222625.243136-8-ehabkost@redhat.com>
In-Reply-To: <20200813222625.243136-1-ehabkost@redhat.com>
References: <20200813222625.243136-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 17:30:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some of the enum constant names conflict with the QOM type check
macros.  This needs to be addressed to allow us to transform the
QOM type check macros into functions generated by
OBJECT_DECLARE_TYPE().

Rename all the constants to ASPEED_DEV_*, to avoid conflicts.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  92 +++++++--------
 hw/arm/aspeed.c             |   4 +-
 hw/arm/aspeed_ast2600.c     | 208 ++++++++++++++++----------------
 hw/arm/aspeed_soc.c         | 228 ++++++++++++++++++------------------
 4 files changed, 266 insertions(+), 266 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 914115f3ef..d46f197cbe 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -87,52 +87,52 @@ typedef struct AspeedSoCClass {
     OBJECT_GET_CLASS(AspeedSoCClass, (obj), TYPE_ASPEED_SOC)
 
 enum {
-    ASPEED_IOMEM,
-    ASPEED_UART1,
-    ASPEED_UART2,
-    ASPEED_UART3,
-    ASPEED_UART4,
-    ASPEED_UART5,
-    ASPEED_VUART,
-    ASPEED_FMC,
-    ASPEED_SPI1,
-    ASPEED_SPI2,
-    ASPEED_EHCI1,
-    ASPEED_EHCI2,
-    ASPEED_VIC,
-    ASPEED_SDMC,
-    ASPEED_SCU,
-    ASPEED_ADC,
-    ASPEED_VIDEO,
-    ASPEED_SRAM,
-    ASPEED_SDHCI,
-    ASPEED_GPIO,
-    ASPEED_GPIO_1_8V,
-    ASPEED_RTC,
-    ASPEED_TIMER1,
-    ASPEED_TIMER2,
-    ASPEED_TIMER3,
-    ASPEED_TIMER4,
-    ASPEED_TIMER5,
-    ASPEED_TIMER6,
-    ASPEED_TIMER7,
-    ASPEED_TIMER8,
-    ASPEED_WDT,
-    ASPEED_PWM,
-    ASPEED_LPC,
-    ASPEED_IBT,
-    ASPEED_I2C,
-    ASPEED_ETH1,
-    ASPEED_ETH2,
-    ASPEED_ETH3,
-    ASPEED_ETH4,
-    ASPEED_MII1,
-    ASPEED_MII2,
-    ASPEED_MII3,
-    ASPEED_MII4,
-    ASPEED_SDRAM,
-    ASPEED_XDMA,
-    ASPEED_EMMC,
+    ASPEED_DEV_IOMEM,
+    ASPEED_DEV_UART1,
+    ASPEED_DEV_UART2,
+    ASPEED_DEV_UART3,
+    ASPEED_DEV_UART4,
+    ASPEED_DEV_UART5,
+    ASPEED_DEV_VUART,
+    ASPEED_DEV_FMC,
+    ASPEED_DEV_SPI1,
+    ASPEED_DEV_SPI2,
+    ASPEED_DEV_EHCI1,
+    ASPEED_DEV_EHCI2,
+    ASPEED_DEV_VIC,
+    ASPEED_DEV_SDMC,
+    ASPEED_DEV_SCU,
+    ASPEED_DEV_ADC,
+    ASPEED_DEV_VIDEO,
+    ASPEED_DEV_SRAM,
+    ASPEED_DEV_SDHCI,
+    ASPEED_DEV_GPIO,
+    ASPEED_DEV_GPIO_1_8V,
+    ASPEED_DEV_RTC,
+    ASPEED_DEV_TIMER1,
+    ASPEED_DEV_TIMER2,
+    ASPEED_DEV_TIMER3,
+    ASPEED_DEV_TIMER4,
+    ASPEED_DEV_TIMER5,
+    ASPEED_DEV_TIMER6,
+    ASPEED_DEV_TIMER7,
+    ASPEED_DEV_TIMER8,
+    ASPEED_DEV_WDT,
+    ASPEED_DEV_PWM,
+    ASPEED_DEV_LPC,
+    ASPEED_DEV_IBT,
+    ASPEED_DEV_I2C,
+    ASPEED_DEV_ETH1,
+    ASPEED_DEV_ETH2,
+    ASPEED_DEV_ETH3,
+    ASPEED_DEV_ETH4,
+    ASPEED_DEV_MII1,
+    ASPEED_DEV_MII2,
+    ASPEED_DEV_MII3,
+    ASPEED_DEV_MII4,
+    ASPEED_DEV_SDRAM,
+    ASPEED_DEV_XDMA,
+    ASPEED_DEV_EMMC,
 };
 
 #endif /* ASPEED_SOC_H */
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index fcb1a7cd87..8109cc6d2d 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -309,7 +309,7 @@ static void aspeed_machine_init(MachineState *machine)
     qdev_realize(DEVICE(&bmc->soc), NULL, &error_abort);
 
     memory_region_add_subregion(get_system_memory(),
-                                sc->memmap[ASPEED_SDRAM],
+                                sc->memmap[ASPEED_DEV_SDRAM],
                                 &bmc->ram_container);
 
     max_ram_size = object_property_get_uint(OBJECT(&bmc->soc), "max-ram-size",
@@ -360,7 +360,7 @@ static void aspeed_machine_init(MachineState *machine)
     }
 
     aspeed_board_binfo.ram_size = ram_size;
-    aspeed_board_binfo.loader_start = sc->memmap[ASPEED_SDRAM];
+    aspeed_board_binfo.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
     aspeed_board_binfo.nb_cpus = sc->num_cpus;
 
     if (amc->i2c_init) {
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 3767f7d8d0..9d95e42143 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -24,43 +24,43 @@
 #define ASPEED_SOC_IOMEM_SIZE       0x00200000
 
 static const hwaddr aspeed_soc_ast2600_memmap[] = {
-    [ASPEED_SRAM]      = 0x10000000,
+    [ASPEED_DEV_SRAM]      = 0x10000000,
     /* 0x16000000     0x17FFFFFF : AHB BUS do LPC Bus bridge */
-    [ASPEED_IOMEM]     = 0x1E600000,
-    [ASPEED_PWM]       = 0x1E610000,
-    [ASPEED_FMC]       = 0x1E620000,
-    [ASPEED_SPI1]      = 0x1E630000,
-    [ASPEED_SPI2]      = 0x1E641000,
-    [ASPEED_EHCI1]     = 0x1E6A1000,
-    [ASPEED_EHCI2]     = 0x1E6A3000,
-    [ASPEED_MII1]      = 0x1E650000,
-    [ASPEED_MII2]      = 0x1E650008,
-    [ASPEED_MII3]      = 0x1E650010,
-    [ASPEED_MII4]      = 0x1E650018,
-    [ASPEED_ETH1]      = 0x1E660000,
-    [ASPEED_ETH3]      = 0x1E670000,
-    [ASPEED_ETH2]      = 0x1E680000,
-    [ASPEED_ETH4]      = 0x1E690000,
-    [ASPEED_VIC]       = 0x1E6C0000,
-    [ASPEED_SDMC]      = 0x1E6E0000,
-    [ASPEED_SCU]       = 0x1E6E2000,
-    [ASPEED_XDMA]      = 0x1E6E7000,
-    [ASPEED_ADC]       = 0x1E6E9000,
-    [ASPEED_VIDEO]     = 0x1E700000,
-    [ASPEED_SDHCI]     = 0x1E740000,
-    [ASPEED_EMMC]      = 0x1E750000,
-    [ASPEED_GPIO]      = 0x1E780000,
-    [ASPEED_GPIO_1_8V] = 0x1E780800,
-    [ASPEED_RTC]       = 0x1E781000,
-    [ASPEED_TIMER1]    = 0x1E782000,
-    [ASPEED_WDT]       = 0x1E785000,
-    [ASPEED_LPC]       = 0x1E789000,
-    [ASPEED_IBT]       = 0x1E789140,
-    [ASPEED_I2C]       = 0x1E78A000,
-    [ASPEED_UART1]     = 0x1E783000,
-    [ASPEED_UART5]     = 0x1E784000,
-    [ASPEED_VUART]     = 0x1E787000,
-    [ASPEED_SDRAM]     = 0x80000000,
+    [ASPEED_DEV_IOMEM]     = 0x1E600000,
+    [ASPEED_DEV_PWM]       = 0x1E610000,
+    [ASPEED_DEV_FMC]       = 0x1E620000,
+    [ASPEED_DEV_SPI1]      = 0x1E630000,
+    [ASPEED_DEV_SPI2]      = 0x1E641000,
+    [ASPEED_DEV_EHCI1]     = 0x1E6A1000,
+    [ASPEED_DEV_EHCI2]     = 0x1E6A3000,
+    [ASPEED_DEV_MII1]      = 0x1E650000,
+    [ASPEED_DEV_MII2]      = 0x1E650008,
+    [ASPEED_DEV_MII3]      = 0x1E650010,
+    [ASPEED_DEV_MII4]      = 0x1E650018,
+    [ASPEED_DEV_ETH1]      = 0x1E660000,
+    [ASPEED_DEV_ETH3]      = 0x1E670000,
+    [ASPEED_DEV_ETH2]      = 0x1E680000,
+    [ASPEED_DEV_ETH4]      = 0x1E690000,
+    [ASPEED_DEV_VIC]       = 0x1E6C0000,
+    [ASPEED_DEV_SDMC]      = 0x1E6E0000,
+    [ASPEED_DEV_SCU]       = 0x1E6E2000,
+    [ASPEED_DEV_XDMA]      = 0x1E6E7000,
+    [ASPEED_DEV_ADC]       = 0x1E6E9000,
+    [ASPEED_DEV_VIDEO]     = 0x1E700000,
+    [ASPEED_DEV_SDHCI]     = 0x1E740000,
+    [ASPEED_DEV_EMMC]      = 0x1E750000,
+    [ASPEED_DEV_GPIO]      = 0x1E780000,
+    [ASPEED_DEV_GPIO_1_8V] = 0x1E780800,
+    [ASPEED_DEV_RTC]       = 0x1E781000,
+    [ASPEED_DEV_TIMER1]    = 0x1E782000,
+    [ASPEED_DEV_WDT]       = 0x1E785000,
+    [ASPEED_DEV_LPC]       = 0x1E789000,
+    [ASPEED_DEV_IBT]       = 0x1E789140,
+    [ASPEED_DEV_I2C]       = 0x1E78A000,
+    [ASPEED_DEV_UART1]     = 0x1E783000,
+    [ASPEED_DEV_UART5]     = 0x1E784000,
+    [ASPEED_DEV_VUART]     = 0x1E787000,
+    [ASPEED_DEV_SDRAM]     = 0x80000000,
 };
 
 #define ASPEED_A7MPCORE_ADDR 0x40460000
@@ -69,41 +69,41 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
 
 /* Shared Peripheral Interrupt values below are offset by -32 from datasheet */
 static const int aspeed_soc_ast2600_irqmap[] = {
-    [ASPEED_UART1]     = 47,
-    [ASPEED_UART2]     = 48,
-    [ASPEED_UART3]     = 49,
-    [ASPEED_UART4]     = 50,
-    [ASPEED_UART5]     = 8,
-    [ASPEED_VUART]     = 8,
-    [ASPEED_FMC]       = 39,
-    [ASPEED_SDMC]      = 0,
-    [ASPEED_SCU]       = 12,
-    [ASPEED_ADC]       = 78,
-    [ASPEED_XDMA]      = 6,
-    [ASPEED_SDHCI]     = 43,
-    [ASPEED_EHCI1]     = 5,
-    [ASPEED_EHCI2]     = 9,
-    [ASPEED_EMMC]      = 15,
-    [ASPEED_GPIO]      = 40,
-    [ASPEED_GPIO_1_8V] = 11,
-    [ASPEED_RTC]       = 13,
-    [ASPEED_TIMER1]    = 16,
-    [ASPEED_TIMER2]    = 17,
-    [ASPEED_TIMER3]    = 18,
-    [ASPEED_TIMER4]    = 19,
-    [ASPEED_TIMER5]    = 20,
-    [ASPEED_TIMER6]    = 21,
-    [ASPEED_TIMER7]    = 22,
-    [ASPEED_TIMER8]    = 23,
-    [ASPEED_WDT]       = 24,
-    [ASPEED_PWM]       = 44,
-    [ASPEED_LPC]       = 35,
-    [ASPEED_IBT]       = 35,    /* LPC */
-    [ASPEED_I2C]       = 110,   /* 110 -> 125 */
-    [ASPEED_ETH1]      = 2,
-    [ASPEED_ETH2]      = 3,
-    [ASPEED_ETH3]      = 32,
-    [ASPEED_ETH4]      = 33,
+    [ASPEED_DEV_UART1]     = 47,
+    [ASPEED_DEV_UART2]     = 48,
+    [ASPEED_DEV_UART3]     = 49,
+    [ASPEED_DEV_UART4]     = 50,
+    [ASPEED_DEV_UART5]     = 8,
+    [ASPEED_DEV_VUART]     = 8,
+    [ASPEED_DEV_FMC]       = 39,
+    [ASPEED_DEV_SDMC]      = 0,
+    [ASPEED_DEV_SCU]       = 12,
+    [ASPEED_DEV_ADC]       = 78,
+    [ASPEED_DEV_XDMA]      = 6,
+    [ASPEED_DEV_SDHCI]     = 43,
+    [ASPEED_DEV_EHCI1]     = 5,
+    [ASPEED_DEV_EHCI2]     = 9,
+    [ASPEED_DEV_EMMC]      = 15,
+    [ASPEED_DEV_GPIO]      = 40,
+    [ASPEED_DEV_GPIO_1_8V] = 11,
+    [ASPEED_DEV_RTC]       = 13,
+    [ASPEED_DEV_TIMER1]    = 16,
+    [ASPEED_DEV_TIMER2]    = 17,
+    [ASPEED_DEV_TIMER3]    = 18,
+    [ASPEED_DEV_TIMER4]    = 19,
+    [ASPEED_DEV_TIMER5]    = 20,
+    [ASPEED_DEV_TIMER6]    = 21,
+    [ASPEED_DEV_TIMER7]    = 22,
+    [ASPEED_DEV_TIMER8]    = 23,
+    [ASPEED_DEV_WDT]       = 24,
+    [ASPEED_DEV_PWM]       = 44,
+    [ASPEED_DEV_LPC]       = 35,
+    [ASPEED_DEV_IBT]       = 35,    /* LPC */
+    [ASPEED_DEV_I2C]       = 110,   /* 110 -> 125 */
+    [ASPEED_DEV_ETH1]      = 2,
+    [ASPEED_DEV_ETH2]      = 3,
+    [ASPEED_DEV_ETH3]      = 32,
+    [ASPEED_DEV_ETH4]      = 33,
 
 };
 
@@ -232,11 +232,11 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     qemu_irq irq;
 
     /* IO space */
-    create_unimplemented_device("aspeed_soc.io", sc->memmap[ASPEED_IOMEM],
+    create_unimplemented_device("aspeed_soc.io", sc->memmap[ASPEED_DEV_IOMEM],
                                 ASPEED_SOC_IOMEM_SIZE);
 
     /* Video engine stub */
-    create_unimplemented_device("aspeed.video", sc->memmap[ASPEED_VIDEO],
+    create_unimplemented_device("aspeed.video", sc->memmap[ASPEED_DEV_VIDEO],
                                 0x1000);
 
     /* CPU */
@@ -295,21 +295,21 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         return;
     }
     memory_region_add_subregion(get_system_memory(),
-                                sc->memmap[ASPEED_SRAM], &s->sram);
+                                sc->memmap[ASPEED_DEV_SRAM], &s->sram);
 
     /* SCU */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_SCU]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_DEV_SCU]);
 
     /* RTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, sc->memmap[ASPEED_RTC]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, sc->memmap[ASPEED_DEV_RTC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_RTC));
+                       aspeed_soc_get_irq(s, ASPEED_DEV_RTC));
 
     /* Timer */
     object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu),
@@ -318,16 +318,16 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->timerctrl), 0,
-                    sc->memmap[ASPEED_TIMER1]);
+                    sc->memmap[ASPEED_DEV_TIMER1]);
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
-        qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_TIMER1 + i);
+        qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
     }
 
     /* UART - attach an 8250 to the IO space as our UART5 */
     if (serial_hd(0)) {
-        qemu_irq uart5 = aspeed_soc_get_irq(s, ASPEED_UART5);
-        serial_mm_init(get_system_memory(), sc->memmap[ASPEED_UART5], 2,
+        qemu_irq uart5 = aspeed_soc_get_irq(s, ASPEED_DEV_UART5);
+        serial_mm_init(get_system_memory(), sc->memmap[ASPEED_DEV_UART5], 2,
                        uart5, 38400, serial_hd(0), DEVICE_LITTLE_ENDIAN);
     }
 
@@ -337,10 +337,10 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_I2C]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_DEV_I2C]);
     for (i = 0; i < ASPEED_I2C_GET_CLASS(&s->i2c)->num_busses; i++) {
         qemu_irq irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                        sc->irqmap[ASPEED_I2C] + i);
+                                        sc->irqmap[ASPEED_DEV_I2C] + i);
         /*
          * The AST2600 SoC has one IRQ per I2C bus. Skip the common
          * IRQ (AST2400 and AST2500) and connect all bussses.
@@ -352,17 +352,17 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(s->dram_mr),
                              &error_abort);
     if (!object_property_set_int(OBJECT(&s->fmc), "sdram-base",
-                                 sc->memmap[ASPEED_SDRAM], errp)) {
+                                 sc->memmap[ASPEED_DEV_SDRAM], errp)) {
         return;
     }
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 0, sc->memmap[ASPEED_FMC]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 0, sc->memmap[ASPEED_DEV_FMC]);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 1,
                     s->fmc.ctrl->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_FMC));
+                       aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
 
     /* SPI */
     for (i = 0; i < sc->spis_num; i++) {
@@ -373,7 +373,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0,
-                        sc->memmap[ASPEED_SPI1 + i]);
+                        sc->memmap[ASPEED_DEV_SPI1 + i]);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 1,
                         s->spi[i].ctrl->flash_window_base);
     }
@@ -384,16 +384,16 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
-                        sc->memmap[ASPEED_EHCI1 + i]);
+                        sc->memmap[ASPEED_DEV_EHCI1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
-                           aspeed_soc_get_irq(s, ASPEED_EHCI1 + i));
+                           aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
     }
 
     /* SDMC - SDRAM Memory Controller */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, sc->memmap[ASPEED_SDMC]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, sc->memmap[ASPEED_DEV_SDMC]);
 
     /* Watch dog */
     for (i = 0; i < sc->wdts_num; i++) {
@@ -405,7 +405,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
-                        sc->memmap[ASPEED_WDT] + i * awc->offset);
+                        sc->memmap[ASPEED_DEV_WDT] + i * awc->offset);
     }
 
     /* Net */
@@ -416,9 +416,9 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
-                        sc->memmap[ASPEED_ETH1 + i]);
+                        sc->memmap[ASPEED_DEV_ETH1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
-                           aspeed_soc_get_irq(s, ASPEED_ETH1 + i));
+                           aspeed_soc_get_irq(s, ASPEED_DEV_ETH1 + i));
 
         object_property_set_link(OBJECT(&s->mii[i]), "nic",
                                  OBJECT(&s->ftgmac100[i]), &error_abort);
@@ -427,7 +427,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         }
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->mii[i]), 0,
-                        sc->memmap[ASPEED_MII1 + i]);
+                        sc->memmap[ASPEED_DEV_MII1 + i]);
     }
 
     /* XDMA */
@@ -435,42 +435,42 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->xdma), 0,
-                    sc->memmap[ASPEED_XDMA]);
+                    sc->memmap[ASPEED_DEV_XDMA]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
-                       aspeed_soc_get_irq(s, ASPEED_XDMA));
+                       aspeed_soc_get_irq(s, ASPEED_DEV_XDMA));
 
     /* GPIO */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, sc->memmap[ASPEED_GPIO]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, sc->memmap[ASPEED_DEV_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
-                       aspeed_soc_get_irq(s, ASPEED_GPIO));
+                       aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio_1_8v), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio_1_8v), 0,
-                    sc->memmap[ASPEED_GPIO_1_8V]);
+                    sc->memmap[ASPEED_DEV_GPIO_1_8V]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio_1_8v), 0,
-                       aspeed_soc_get_irq(s, ASPEED_GPIO_1_8V));
+                       aspeed_soc_get_irq(s, ASPEED_DEV_GPIO_1_8V));
 
     /* SDHCI */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci), 0,
-                    sc->memmap[ASPEED_SDHCI]);
+                    sc->memmap[ASPEED_DEV_SDHCI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
-                       aspeed_soc_get_irq(s, ASPEED_SDHCI));
+                       aspeed_soc_get_irq(s, ASPEED_DEV_SDHCI));
 
     /* eMMC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->emmc), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->emmc), 0, sc->memmap[ASPEED_EMMC]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->emmc), 0, sc->memmap[ASPEED_DEV_EMMC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->emmc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_EMMC));
+                       aspeed_soc_get_irq(s, ASPEED_DEV_EMMC));
 }
 
 static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index a1a8684216..35be126db6 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -27,97 +27,97 @@
 #define ASPEED_SOC_IOMEM_SIZE       0x00200000
 
 static const hwaddr aspeed_soc_ast2400_memmap[] = {
-    [ASPEED_IOMEM]  = 0x1E600000,
-    [ASPEED_FMC]    = 0x1E620000,
-    [ASPEED_SPI1]   = 0x1E630000,
-    [ASPEED_EHCI1]  = 0x1E6A1000,
-    [ASPEED_VIC]    = 0x1E6C0000,
-    [ASPEED_SDMC]   = 0x1E6E0000,
-    [ASPEED_SCU]    = 0x1E6E2000,
-    [ASPEED_XDMA]   = 0x1E6E7000,
-    [ASPEED_VIDEO]  = 0x1E700000,
-    [ASPEED_ADC]    = 0x1E6E9000,
-    [ASPEED_SRAM]   = 0x1E720000,
-    [ASPEED_SDHCI]  = 0x1E740000,
-    [ASPEED_GPIO]   = 0x1E780000,
-    [ASPEED_RTC]    = 0x1E781000,
-    [ASPEED_TIMER1] = 0x1E782000,
-    [ASPEED_WDT]    = 0x1E785000,
-    [ASPEED_PWM]    = 0x1E786000,
-    [ASPEED_LPC]    = 0x1E789000,
-    [ASPEED_IBT]    = 0x1E789140,
-    [ASPEED_I2C]    = 0x1E78A000,
-    [ASPEED_ETH1]   = 0x1E660000,
-    [ASPEED_ETH2]   = 0x1E680000,
-    [ASPEED_UART1]  = 0x1E783000,
-    [ASPEED_UART5]  = 0x1E784000,
-    [ASPEED_VUART]  = 0x1E787000,
-    [ASPEED_SDRAM]  = 0x40000000,
+    [ASPEED_DEV_IOMEM]  = 0x1E600000,
+    [ASPEED_DEV_FMC]    = 0x1E620000,
+    [ASPEED_DEV_SPI1]   = 0x1E630000,
+    [ASPEED_DEV_EHCI1]  = 0x1E6A1000,
+    [ASPEED_DEV_VIC]    = 0x1E6C0000,
+    [ASPEED_DEV_SDMC]   = 0x1E6E0000,
+    [ASPEED_DEV_SCU]    = 0x1E6E2000,
+    [ASPEED_DEV_XDMA]   = 0x1E6E7000,
+    [ASPEED_DEV_VIDEO]  = 0x1E700000,
+    [ASPEED_DEV_ADC]    = 0x1E6E9000,
+    [ASPEED_DEV_SRAM]   = 0x1E720000,
+    [ASPEED_DEV_SDHCI]  = 0x1E740000,
+    [ASPEED_DEV_GPIO]   = 0x1E780000,
+    [ASPEED_DEV_RTC]    = 0x1E781000,
+    [ASPEED_DEV_TIMER1] = 0x1E782000,
+    [ASPEED_DEV_WDT]    = 0x1E785000,
+    [ASPEED_DEV_PWM]    = 0x1E786000,
+    [ASPEED_DEV_LPC]    = 0x1E789000,
+    [ASPEED_DEV_IBT]    = 0x1E789140,
+    [ASPEED_DEV_I2C]    = 0x1E78A000,
+    [ASPEED_DEV_ETH1]   = 0x1E660000,
+    [ASPEED_DEV_ETH2]   = 0x1E680000,
+    [ASPEED_DEV_UART1]  = 0x1E783000,
+    [ASPEED_DEV_UART5]  = 0x1E784000,
+    [ASPEED_DEV_VUART]  = 0x1E787000,
+    [ASPEED_DEV_SDRAM]  = 0x40000000,
 };
 
 static const hwaddr aspeed_soc_ast2500_memmap[] = {
-    [ASPEED_IOMEM]  = 0x1E600000,
-    [ASPEED_FMC]    = 0x1E620000,
-    [ASPEED_SPI1]   = 0x1E630000,
-    [ASPEED_SPI2]   = 0x1E631000,
-    [ASPEED_EHCI1]  = 0x1E6A1000,
-    [ASPEED_EHCI2]  = 0x1E6A3000,
-    [ASPEED_VIC]    = 0x1E6C0000,
-    [ASPEED_SDMC]   = 0x1E6E0000,
-    [ASPEED_SCU]    = 0x1E6E2000,
-    [ASPEED_XDMA]   = 0x1E6E7000,
-    [ASPEED_ADC]    = 0x1E6E9000,
-    [ASPEED_VIDEO]  = 0x1E700000,
-    [ASPEED_SRAM]   = 0x1E720000,
-    [ASPEED_SDHCI]  = 0x1E740000,
-    [ASPEED_GPIO]   = 0x1E780000,
-    [ASPEED_RTC]    = 0x1E781000,
-    [ASPEED_TIMER1] = 0x1E782000,
-    [ASPEED_WDT]    = 0x1E785000,
-    [ASPEED_PWM]    = 0x1E786000,
-    [ASPEED_LPC]    = 0x1E789000,
-    [ASPEED_IBT]    = 0x1E789140,
-    [ASPEED_I2C]    = 0x1E78A000,
-    [ASPEED_ETH1]   = 0x1E660000,
-    [ASPEED_ETH2]   = 0x1E680000,
-    [ASPEED_UART1]  = 0x1E783000,
-    [ASPEED_UART5]  = 0x1E784000,
-    [ASPEED_VUART]  = 0x1E787000,
-    [ASPEED_SDRAM]  = 0x80000000,
+    [ASPEED_DEV_IOMEM]  = 0x1E600000,
+    [ASPEED_DEV_FMC]    = 0x1E620000,
+    [ASPEED_DEV_SPI1]   = 0x1E630000,
+    [ASPEED_DEV_SPI2]   = 0x1E631000,
+    [ASPEED_DEV_EHCI1]  = 0x1E6A1000,
+    [ASPEED_DEV_EHCI2]  = 0x1E6A3000,
+    [ASPEED_DEV_VIC]    = 0x1E6C0000,
+    [ASPEED_DEV_SDMC]   = 0x1E6E0000,
+    [ASPEED_DEV_SCU]    = 0x1E6E2000,
+    [ASPEED_DEV_XDMA]   = 0x1E6E7000,
+    [ASPEED_DEV_ADC]    = 0x1E6E9000,
+    [ASPEED_DEV_VIDEO]  = 0x1E700000,
+    [ASPEED_DEV_SRAM]   = 0x1E720000,
+    [ASPEED_DEV_SDHCI]  = 0x1E740000,
+    [ASPEED_DEV_GPIO]   = 0x1E780000,
+    [ASPEED_DEV_RTC]    = 0x1E781000,
+    [ASPEED_DEV_TIMER1] = 0x1E782000,
+    [ASPEED_DEV_WDT]    = 0x1E785000,
+    [ASPEED_DEV_PWM]    = 0x1E786000,
+    [ASPEED_DEV_LPC]    = 0x1E789000,
+    [ASPEED_DEV_IBT]    = 0x1E789140,
+    [ASPEED_DEV_I2C]    = 0x1E78A000,
+    [ASPEED_DEV_ETH1]   = 0x1E660000,
+    [ASPEED_DEV_ETH2]   = 0x1E680000,
+    [ASPEED_DEV_UART1]  = 0x1E783000,
+    [ASPEED_DEV_UART5]  = 0x1E784000,
+    [ASPEED_DEV_VUART]  = 0x1E787000,
+    [ASPEED_DEV_SDRAM]  = 0x80000000,
 };
 
 static const int aspeed_soc_ast2400_irqmap[] = {
-    [ASPEED_UART1]  = 9,
-    [ASPEED_UART2]  = 32,
-    [ASPEED_UART3]  = 33,
-    [ASPEED_UART4]  = 34,
-    [ASPEED_UART5]  = 10,
-    [ASPEED_VUART]  = 8,
-    [ASPEED_FMC]    = 19,
-    [ASPEED_EHCI1]  = 5,
-    [ASPEED_EHCI2]  = 13,
-    [ASPEED_SDMC]   = 0,
-    [ASPEED_SCU]    = 21,
-    [ASPEED_ADC]    = 31,
-    [ASPEED_GPIO]   = 20,
-    [ASPEED_RTC]    = 22,
-    [ASPEED_TIMER1] = 16,
-    [ASPEED_TIMER2] = 17,
-    [ASPEED_TIMER3] = 18,
-    [ASPEED_TIMER4] = 35,
-    [ASPEED_TIMER5] = 36,
-    [ASPEED_TIMER6] = 37,
-    [ASPEED_TIMER7] = 38,
-    [ASPEED_TIMER8] = 39,
-    [ASPEED_WDT]    = 27,
-    [ASPEED_PWM]    = 28,
-    [ASPEED_LPC]    = 8,
-    [ASPEED_IBT]    = 8, /* LPC */
-    [ASPEED_I2C]    = 12,
-    [ASPEED_ETH1]   = 2,
-    [ASPEED_ETH2]   = 3,
-    [ASPEED_XDMA]   = 6,
-    [ASPEED_SDHCI]  = 26,
+    [ASPEED_DEV_UART1]  = 9,
+    [ASPEED_DEV_UART2]  = 32,
+    [ASPEED_DEV_UART3]  = 33,
+    [ASPEED_DEV_UART4]  = 34,
+    [ASPEED_DEV_UART5]  = 10,
+    [ASPEED_DEV_VUART]  = 8,
+    [ASPEED_DEV_FMC]    = 19,
+    [ASPEED_DEV_EHCI1]  = 5,
+    [ASPEED_DEV_EHCI2]  = 13,
+    [ASPEED_DEV_SDMC]   = 0,
+    [ASPEED_DEV_SCU]    = 21,
+    [ASPEED_DEV_ADC]    = 31,
+    [ASPEED_DEV_GPIO]   = 20,
+    [ASPEED_DEV_RTC]    = 22,
+    [ASPEED_DEV_TIMER1] = 16,
+    [ASPEED_DEV_TIMER2] = 17,
+    [ASPEED_DEV_TIMER3] = 18,
+    [ASPEED_DEV_TIMER4] = 35,
+    [ASPEED_DEV_TIMER5] = 36,
+    [ASPEED_DEV_TIMER6] = 37,
+    [ASPEED_DEV_TIMER7] = 38,
+    [ASPEED_DEV_TIMER8] = 39,
+    [ASPEED_DEV_WDT]    = 27,
+    [ASPEED_DEV_PWM]    = 28,
+    [ASPEED_DEV_LPC]    = 8,
+    [ASPEED_DEV_IBT]    = 8, /* LPC */
+    [ASPEED_DEV_I2C]    = 12,
+    [ASPEED_DEV_ETH1]   = 2,
+    [ASPEED_DEV_ETH2]   = 3,
+    [ASPEED_DEV_XDMA]   = 6,
+    [ASPEED_DEV_SDHCI]  = 26,
 };
 
 #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
@@ -221,11 +221,11 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     Error *err = NULL;
 
     /* IO space */
-    create_unimplemented_device("aspeed_soc.io", sc->memmap[ASPEED_IOMEM],
+    create_unimplemented_device("aspeed_soc.io", sc->memmap[ASPEED_DEV_IOMEM],
                                 ASPEED_SOC_IOMEM_SIZE);
 
     /* Video engine stub */
-    create_unimplemented_device("aspeed.video", sc->memmap[ASPEED_VIDEO],
+    create_unimplemented_device("aspeed.video", sc->memmap[ASPEED_DEV_VIDEO],
                                 0x1000);
 
     /* CPU */
@@ -243,19 +243,19 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
     memory_region_add_subregion(get_system_memory(),
-                                sc->memmap[ASPEED_SRAM], &s->sram);
+                                sc->memmap[ASPEED_DEV_SRAM], &s->sram);
 
     /* SCU */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_SCU]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_DEV_SCU]);
 
     /* VIC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->vic), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->vic), 0, sc->memmap[ASPEED_VIC]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->vic), 0, sc->memmap[ASPEED_DEV_VIC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->vic), 0,
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_IRQ));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->vic), 1,
@@ -265,9 +265,9 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, sc->memmap[ASPEED_RTC]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, sc->memmap[ASPEED_DEV_RTC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_RTC));
+                       aspeed_soc_get_irq(s, ASPEED_DEV_RTC));
 
     /* Timer */
     object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu),
@@ -276,16 +276,16 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->timerctrl), 0,
-                    sc->memmap[ASPEED_TIMER1]);
+                    sc->memmap[ASPEED_DEV_TIMER1]);
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
-        qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_TIMER1 + i);
+        qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
     }
 
     /* UART - attach an 8250 to the IO space as our UART5 */
     if (serial_hd(0)) {
-        qemu_irq uart5 = aspeed_soc_get_irq(s, ASPEED_UART5);
-        serial_mm_init(get_system_memory(), sc->memmap[ASPEED_UART5], 2,
+        qemu_irq uart5 = aspeed_soc_get_irq(s, ASPEED_DEV_UART5);
+        serial_mm_init(get_system_memory(), sc->memmap[ASPEED_DEV_UART5], 2,
                        uart5, 38400, serial_hd(0), DEVICE_LITTLE_ENDIAN);
     }
 
@@ -295,25 +295,25 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_I2C]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_DEV_I2C]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c), 0,
-                       aspeed_soc_get_irq(s, ASPEED_I2C));
+                       aspeed_soc_get_irq(s, ASPEED_DEV_I2C));
 
     /* FMC, The number of CS is set at the board level */
     object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(s->dram_mr),
                              &error_abort);
     if (!object_property_set_int(OBJECT(&s->fmc), "sdram-base",
-                                 sc->memmap[ASPEED_SDRAM], errp)) {
+                                 sc->memmap[ASPEED_DEV_SDRAM], errp)) {
         return;
     }
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 0, sc->memmap[ASPEED_FMC]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 0, sc->memmap[ASPEED_DEV_FMC]);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 1,
                     s->fmc.ctrl->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_FMC));
+                       aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
 
     /* SPI */
     for (i = 0; i < sc->spis_num; i++) {
@@ -322,7 +322,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0,
-                        sc->memmap[ASPEED_SPI1 + i]);
+                        sc->memmap[ASPEED_DEV_SPI1 + i]);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 1,
                         s->spi[i].ctrl->flash_window_base);
     }
@@ -333,16 +333,16 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
-                        sc->memmap[ASPEED_EHCI1 + i]);
+                        sc->memmap[ASPEED_DEV_EHCI1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
-                           aspeed_soc_get_irq(s, ASPEED_EHCI1 + i));
+                           aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
     }
 
     /* SDMC - SDRAM Memory Controller */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, sc->memmap[ASPEED_SDMC]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, sc->memmap[ASPEED_DEV_SDMC]);
 
     /* Watch dog */
     for (i = 0; i < sc->wdts_num; i++) {
@@ -354,7 +354,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
-                        sc->memmap[ASPEED_WDT] + i * awc->offset);
+                        sc->memmap[ASPEED_DEV_WDT] + i * awc->offset);
     }
 
     /* Net */
@@ -365,9 +365,9 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
-                        sc->memmap[ASPEED_ETH1 + i]);
+                        sc->memmap[ASPEED_DEV_ETH1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
-                           aspeed_soc_get_irq(s, ASPEED_ETH1 + i));
+                           aspeed_soc_get_irq(s, ASPEED_DEV_ETH1 + i));
     }
 
     /* XDMA */
@@ -375,26 +375,26 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->xdma), 0,
-                    sc->memmap[ASPEED_XDMA]);
+                    sc->memmap[ASPEED_DEV_XDMA]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
-                       aspeed_soc_get_irq(s, ASPEED_XDMA));
+                       aspeed_soc_get_irq(s, ASPEED_DEV_XDMA));
 
     /* GPIO */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, sc->memmap[ASPEED_GPIO]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, sc->memmap[ASPEED_DEV_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
-                       aspeed_soc_get_irq(s, ASPEED_GPIO));
+                       aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
 
     /* SDHCI */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci), 0,
-                    sc->memmap[ASPEED_SDHCI]);
+                    sc->memmap[ASPEED_DEV_SDHCI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
-                       aspeed_soc_get_irq(s, ASPEED_SDHCI));
+                       aspeed_soc_get_irq(s, ASPEED_DEV_SDHCI));
 }
 static Property aspeed_soc_properties[] = {
     DEFINE_PROP_LINK("dram", AspeedSoCState, dram_mr, TYPE_MEMORY_REGION,
-- 
2.26.2


