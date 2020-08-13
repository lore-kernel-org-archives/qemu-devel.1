Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C39AC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 278BA20774
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cx48aoay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278BA20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Lhd-0006pY-AW
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 18:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6LgG-0004xb-Uu
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:26:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22397
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6LgE-0002qC-IK
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597357597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G9l9wBMKpcWlxSOZBE86WSdMkIAKB4VYEsEFWueYiWc=;
 b=cx48aoaybl4B+quGfOrZKq0p8v8qKGLfh63G6jelclsydI4FI0thI1/UefF5WdpcHRzMRD
 GjajhXBtpphD/9vJDTGPC4qpVtPTzMDwEN4Mfzhuk4CeiVOFOJGUvtcOmPHJTooSVeoxLq
 RTNTW6QTfKPi4rqALZ1SabFbbJiaKQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-nhFaxe8EOFuckizzJClLEA-1; Thu, 13 Aug 2020 18:26:35 -0400
X-MC-Unique: nhFaxe8EOFuckizzJClLEA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C84FF57084
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 22:26:34 +0000 (UTC)
Received: from localhost (ovpn-117-153.rdu2.redhat.com [10.10.117.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7613D610F3;
 Thu, 13 Aug 2020 22:26:34 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/41] allwinner-h3: Rename memmap enum constants
Date: Thu, 13 Aug 2020 18:25:50 -0400
Message-Id: <20200813222625.243136-7-ehabkost@redhat.com>
In-Reply-To: <20200813222625.243136-1-ehabkost@redhat.com>
References: <20200813222625.243136-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 17:30:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Rename all the constants to AW_H3_DEV_*, to avoid conflicts.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/arm/allwinner-h3.h |  62 ++++++++---------
 hw/arm/allwinner-h3.c         | 124 +++++++++++++++++-----------------
 hw/arm/orangepi.c             |   6 +-
 3 files changed, 96 insertions(+), 96 deletions(-)

diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
index 82e4e59216..626139dcb3 100644
--- a/include/hw/arm/allwinner-h3.h
+++ b/include/hw/arm/allwinner-h3.h
@@ -61,37 +61,37 @@
  * @see AwH3State
  */
 enum {
-    AW_H3_SRAM_A1,
-    AW_H3_SRAM_A2,
-    AW_H3_SRAM_C,
-    AW_H3_SYSCTRL,
-    AW_H3_MMC0,
-    AW_H3_SID,
-    AW_H3_EHCI0,
-    AW_H3_OHCI0,
-    AW_H3_EHCI1,
-    AW_H3_OHCI1,
-    AW_H3_EHCI2,
-    AW_H3_OHCI2,
-    AW_H3_EHCI3,
-    AW_H3_OHCI3,
-    AW_H3_CCU,
-    AW_H3_PIT,
-    AW_H3_UART0,
-    AW_H3_UART1,
-    AW_H3_UART2,
-    AW_H3_UART3,
-    AW_H3_EMAC,
-    AW_H3_DRAMCOM,
-    AW_H3_DRAMCTL,
-    AW_H3_DRAMPHY,
-    AW_H3_GIC_DIST,
-    AW_H3_GIC_CPU,
-    AW_H3_GIC_HYP,
-    AW_H3_GIC_VCPU,
-    AW_H3_RTC,
-    AW_H3_CPUCFG,
-    AW_H3_SDRAM
+    AW_H3_DEV_SRAM_A1,
+    AW_H3_DEV_SRAM_A2,
+    AW_H3_DEV_SRAM_C,
+    AW_H3_DEV_SYSCTRL,
+    AW_H3_DEV_MMC0,
+    AW_H3_DEV_SID,
+    AW_H3_DEV_EHCI0,
+    AW_H3_DEV_OHCI0,
+    AW_H3_DEV_EHCI1,
+    AW_H3_DEV_OHCI1,
+    AW_H3_DEV_EHCI2,
+    AW_H3_DEV_OHCI2,
+    AW_H3_DEV_EHCI3,
+    AW_H3_DEV_OHCI3,
+    AW_H3_DEV_CCU,
+    AW_H3_DEV_PIT,
+    AW_H3_DEV_UART0,
+    AW_H3_DEV_UART1,
+    AW_H3_DEV_UART2,
+    AW_H3_DEV_UART3,
+    AW_H3_DEV_EMAC,
+    AW_H3_DEV_DRAMCOM,
+    AW_H3_DEV_DRAMCTL,
+    AW_H3_DEV_DRAMPHY,
+    AW_H3_DEV_GIC_DIST,
+    AW_H3_DEV_GIC_CPU,
+    AW_H3_DEV_GIC_HYP,
+    AW_H3_DEV_GIC_VCPU,
+    AW_H3_DEV_RTC,
+    AW_H3_DEV_CPUCFG,
+    AW_H3_DEV_SDRAM
 };
 
 /** Total number of CPU cores in the H3 SoC */
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index ff92ded82c..341abe6718 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -35,37 +35,37 @@
 
 /* Memory map */
 const hwaddr allwinner_h3_memmap[] = {
-    [AW_H3_SRAM_A1]    = 0x00000000,
-    [AW_H3_SRAM_A2]    = 0x00044000,
-    [AW_H3_SRAM_C]     = 0x00010000,
-    [AW_H3_SYSCTRL]    = 0x01c00000,
-    [AW_H3_MMC0]       = 0x01c0f000,
-    [AW_H3_SID]        = 0x01c14000,
-    [AW_H3_EHCI0]      = 0x01c1a000,
-    [AW_H3_OHCI0]      = 0x01c1a400,
-    [AW_H3_EHCI1]      = 0x01c1b000,
-    [AW_H3_OHCI1]      = 0x01c1b400,
-    [AW_H3_EHCI2]      = 0x01c1c000,
-    [AW_H3_OHCI2]      = 0x01c1c400,
-    [AW_H3_EHCI3]      = 0x01c1d000,
-    [AW_H3_OHCI3]      = 0x01c1d400,
-    [AW_H3_CCU]        = 0x01c20000,
-    [AW_H3_PIT]        = 0x01c20c00,
-    [AW_H3_UART0]      = 0x01c28000,
-    [AW_H3_UART1]      = 0x01c28400,
-    [AW_H3_UART2]      = 0x01c28800,
-    [AW_H3_UART3]      = 0x01c28c00,
-    [AW_H3_EMAC]       = 0x01c30000,
-    [AW_H3_DRAMCOM]    = 0x01c62000,
-    [AW_H3_DRAMCTL]    = 0x01c63000,
-    [AW_H3_DRAMPHY]    = 0x01c65000,
-    [AW_H3_GIC_DIST]   = 0x01c81000,
-    [AW_H3_GIC_CPU]    = 0x01c82000,
-    [AW_H3_GIC_HYP]    = 0x01c84000,
-    [AW_H3_GIC_VCPU]   = 0x01c86000,
-    [AW_H3_RTC]        = 0x01f00000,
-    [AW_H3_CPUCFG]     = 0x01f01c00,
-    [AW_H3_SDRAM]      = 0x40000000
+    [AW_H3_DEV_SRAM_A1]    = 0x00000000,
+    [AW_H3_DEV_SRAM_A2]    = 0x00044000,
+    [AW_H3_DEV_SRAM_C]     = 0x00010000,
+    [AW_H3_DEV_SYSCTRL]    = 0x01c00000,
+    [AW_H3_DEV_MMC0]       = 0x01c0f000,
+    [AW_H3_DEV_SID]        = 0x01c14000,
+    [AW_H3_DEV_EHCI0]      = 0x01c1a000,
+    [AW_H3_DEV_OHCI0]      = 0x01c1a400,
+    [AW_H3_DEV_EHCI1]      = 0x01c1b000,
+    [AW_H3_DEV_OHCI1]      = 0x01c1b400,
+    [AW_H3_DEV_EHCI2]      = 0x01c1c000,
+    [AW_H3_DEV_OHCI2]      = 0x01c1c400,
+    [AW_H3_DEV_EHCI3]      = 0x01c1d000,
+    [AW_H3_DEV_OHCI3]      = 0x01c1d400,
+    [AW_H3_DEV_CCU]        = 0x01c20000,
+    [AW_H3_DEV_PIT]        = 0x01c20c00,
+    [AW_H3_DEV_UART0]      = 0x01c28000,
+    [AW_H3_DEV_UART1]      = 0x01c28400,
+    [AW_H3_DEV_UART2]      = 0x01c28800,
+    [AW_H3_DEV_UART3]      = 0x01c28c00,
+    [AW_H3_DEV_EMAC]       = 0x01c30000,
+    [AW_H3_DEV_DRAMCOM]    = 0x01c62000,
+    [AW_H3_DEV_DRAMCTL]    = 0x01c63000,
+    [AW_H3_DEV_DRAMPHY]    = 0x01c65000,
+    [AW_H3_DEV_GIC_DIST]   = 0x01c81000,
+    [AW_H3_DEV_GIC_CPU]    = 0x01c82000,
+    [AW_H3_DEV_GIC_HYP]    = 0x01c84000,
+    [AW_H3_DEV_GIC_VCPU]   = 0x01c86000,
+    [AW_H3_DEV_RTC]        = 0x01f00000,
+    [AW_H3_DEV_CPUCFG]     = 0x01f01c00,
+    [AW_H3_DEV_SDRAM]      = 0x40000000
 };
 
 /* List of unimplemented devices */
@@ -183,7 +183,7 @@ void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk)
     }
 
     rom_add_blob("allwinner-h3.bootrom", buffer, rom_size,
-                  rom_size, s->memmap[AW_H3_SRAM_A1],
+                  rom_size, s->memmap[AW_H3_DEV_SRAM_A1],
                   NULL, NULL, NULL, NULL, false);
 }
 
@@ -262,10 +262,10 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
     qdev_prop_set_bit(DEVICE(&s->gic), "has-virtualization-extensions", true);
     sysbus_realize(SYS_BUS_DEVICE(&s->gic), &error_fatal);
 
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 0, s->memmap[AW_H3_GIC_DIST]);
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 1, s->memmap[AW_H3_GIC_CPU]);
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 2, s->memmap[AW_H3_GIC_HYP]);
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 3, s->memmap[AW_H3_GIC_VCPU]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 0, s->memmap[AW_H3_DEV_GIC_DIST]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 1, s->memmap[AW_H3_DEV_GIC_CPU]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 2, s->memmap[AW_H3_DEV_GIC_HYP]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 3, s->memmap[AW_H3_DEV_GIC_VCPU]);
 
     /*
      * Wire the outputs from each CPU's generic timer and the GICv3
@@ -312,7 +312,7 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
 
     /* Timer */
     sysbus_realize(SYS_BUS_DEVICE(&s->timer), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->timer), 0, s->memmap[AW_H3_PIT]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->timer), 0, s->memmap[AW_H3_DEV_PIT]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer), 0,
                        qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_TIMER0));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer), 1,
@@ -325,32 +325,32 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
                             32 * KiB, &error_abort);
     memory_region_init_ram(&s->sram_c, OBJECT(dev), "sram C",
                             44 * KiB, &error_abort);
-    memory_region_add_subregion(get_system_memory(), s->memmap[AW_H3_SRAM_A1],
+    memory_region_add_subregion(get_system_memory(), s->memmap[AW_H3_DEV_SRAM_A1],
                                 &s->sram_a1);
-    memory_region_add_subregion(get_system_memory(), s->memmap[AW_H3_SRAM_A2],
+    memory_region_add_subregion(get_system_memory(), s->memmap[AW_H3_DEV_SRAM_A2],
                                 &s->sram_a2);
-    memory_region_add_subregion(get_system_memory(), s->memmap[AW_H3_SRAM_C],
+    memory_region_add_subregion(get_system_memory(), s->memmap[AW_H3_DEV_SRAM_C],
                                 &s->sram_c);
 
     /* Clock Control Unit */
     sysbus_realize(SYS_BUS_DEVICE(&s->ccu), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_H3_CCU]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_H3_DEV_CCU]);
 
     /* System Control */
     sysbus_realize(SYS_BUS_DEVICE(&s->sysctrl), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysctrl), 0, s->memmap[AW_H3_SYSCTRL]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysctrl), 0, s->memmap[AW_H3_DEV_SYSCTRL]);
 
     /* CPU Configuration */
     sysbus_realize(SYS_BUS_DEVICE(&s->cpucfg), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->cpucfg), 0, s->memmap[AW_H3_CPUCFG]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->cpucfg), 0, s->memmap[AW_H3_DEV_CPUCFG]);
 
     /* Security Identifier */
     sysbus_realize(SYS_BUS_DEVICE(&s->sid), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0, s->memmap[AW_H3_SID]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0, s->memmap[AW_H3_DEV_SID]);
 
     /* SD/MMC */
     sysbus_realize(SYS_BUS_DEVICE(&s->mmc0), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->mmc0), 0, s->memmap[AW_H3_MMC0]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->mmc0), 0, s->memmap[AW_H3_DEV_MMC0]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->mmc0), 0,
                        qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_MMC0));
 
@@ -364,63 +364,63 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
         qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
     }
     sysbus_realize(SYS_BUS_DEVICE(&s->emac), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->emac), 0, s->memmap[AW_H3_EMAC]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->emac), 0, s->memmap[AW_H3_DEV_EMAC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->emac), 0,
                        qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_EMAC));
 
     /* Universal Serial Bus */
-    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI0],
+    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI0],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_EHCI0));
-    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI1],
+    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI1],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_EHCI1));
-    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI2],
+    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI2],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_EHCI2));
-    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI3],
+    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI3],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_EHCI3));
 
-    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI0],
+    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI0],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_OHCI0));
-    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI1],
+    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI1],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_OHCI1));
-    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI2],
+    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI2],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_OHCI2));
-    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI3],
+    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI3],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_OHCI3));
 
     /* UART0. For future clocktree API: All UARTS are connected to APB2_CLK. */
-    serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART0], 2,
+    serial_mm_init(get_system_memory(), s->memmap[AW_H3_DEV_UART0], 2,
                    qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART0),
                    115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
     /* UART1 */
-    serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART1], 2,
+    serial_mm_init(get_system_memory(), s->memmap[AW_H3_DEV_UART1], 2,
                    qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART1),
                    115200, serial_hd(1), DEVICE_NATIVE_ENDIAN);
     /* UART2 */
-    serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART2], 2,
+    serial_mm_init(get_system_memory(), s->memmap[AW_H3_DEV_UART2], 2,
                    qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART2),
                    115200, serial_hd(2), DEVICE_NATIVE_ENDIAN);
     /* UART3 */
-    serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART3], 2,
+    serial_mm_init(get_system_memory(), s->memmap[AW_H3_DEV_UART3], 2,
                    qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART3),
                    115200, serial_hd(3), DEVICE_NATIVE_ENDIAN);
 
     /* DRAMC */
     sysbus_realize(SYS_BUS_DEVICE(&s->dramc), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 0, s->memmap[AW_H3_DRAMCOM]);
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 1, s->memmap[AW_H3_DRAMCTL]);
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 2, s->memmap[AW_H3_DRAMPHY]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 0, s->memmap[AW_H3_DEV_DRAMCOM]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 1, s->memmap[AW_H3_DEV_DRAMCTL]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 2, s->memmap[AW_H3_DEV_DRAMPHY]);
 
     /* RTC */
     sysbus_realize(SYS_BUS_DEVICE(&s->rtc), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, s->memmap[AW_H3_RTC]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, s->memmap[AW_H3_DEV_RTC]);
 
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(unimplemented); i++) {
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 1679468232..17a568a2b4 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -79,7 +79,7 @@ static void orangepi_init(MachineState *machine)
     object_property_set_int(OBJECT(&h3->emac), "phy-addr", 1, &error_abort);
 
     /* DRAMC */
-    object_property_set_uint(OBJECT(h3), "ram-addr", h3->memmap[AW_H3_SDRAM],
+    object_property_set_uint(OBJECT(h3), "ram-addr", h3->memmap[AW_H3_DEV_SDRAM],
                              &error_abort);
     object_property_set_int(OBJECT(h3), "ram-size", machine->ram_size / MiB,
                             &error_abort);
@@ -98,7 +98,7 @@ static void orangepi_init(MachineState *machine)
     qdev_realize_and_unref(carddev, bus, &error_fatal);
 
     /* SDRAM */
-    memory_region_add_subregion(get_system_memory(), h3->memmap[AW_H3_SDRAM],
+    memory_region_add_subregion(get_system_memory(), h3->memmap[AW_H3_DEV_SDRAM],
                                 machine->ram);
 
     /* Load target kernel or start using BootROM */
@@ -106,7 +106,7 @@ static void orangepi_init(MachineState *machine)
         /* Use Boot ROM to copy data from SD card to SRAM */
         allwinner_h3_bootrom_setup(h3, blk);
     }
-    orangepi_binfo.loader_start = h3->memmap[AW_H3_SDRAM];
+    orangepi_binfo.loader_start = h3->memmap[AW_H3_DEV_SDRAM];
     orangepi_binfo.ram_size = machine->ram_size;
     arm_load_kernel(ARM_CPU(first_cpu), machine, &orangepi_binfo);
 }
-- 
2.26.2


