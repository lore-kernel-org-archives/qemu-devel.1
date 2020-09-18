Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EB6C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:01:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A99FC221EC
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVYOtuly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99FC221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJNVf-0002vN-MP
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 17:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJNIG-0002eE-8t
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:47:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48111
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJNHw-0006Fl-0C
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600462042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u4VsQlbRFe7gSlcn7swxt6vr6RZN1WLwF/0IcfEatK8=;
 b=NVYOtulyjMzxtTnaxzt685U0b1CJeAMflmYFI/VZ2JWPbHmCsvscoy8H+Yy/wTG4gKRdrT
 pejNN04sH8dstOv4mETDbUC03TZHdO5ewffC5WpVrYs4ls28wIYhieusVBXoMxqIIgX5cW
 vmQAr5Ul3LcPi1vQBhH8D8rc2AGm1H4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-3X40T3VbNVmxBYTO-7Ufng-1; Fri, 18 Sep 2020 16:47:19 -0400
X-MC-Unique: 3X40T3VbNVmxBYTO-7Ufng-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D80B41084CB1;
 Fri, 18 Sep 2020 20:47:18 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0A0C60C07;
 Fri, 18 Sep 2020 20:47:18 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 03/17] sifive: Move QOM typedefs and add missing includes
Date: Fri, 18 Sep 2020 16:47:00 -0400
Message-Id: <20200918204714.27276-4-ehabkost@redhat.com>
In-Reply-To: <20200918204714.27276-1-ehabkost@redhat.com>
References: <20200918204714.27276-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 16:47:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some typedefs and macros are defined after the type check macros.
This makes it difficult to automatically replace their
definitions with OBJECT_DECLARE_TYPE.

Patch generated using:

 $ ./scripts/codeconverter/converter.py -i \
   --pattern=QOMStructTypedefSplit $(git grep -l '' -- '*.[ch]')

which will split "typdef struct { ... } TypedefName"
declarations.

Followed by:

 $ ./scripts/codeconverter/converter.py -i --pattern=MoveSymbols \
    $(git grep -l '' -- '*.[ch]')

which will:
- move the typedefs and #defines above the type check macros
- add missing #include "qom/object.h" lines if necessary

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200831210740.126168-9-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/intc/sifive_plic.h           | 6 ++++--
 include/hw/char/sifive_uart.h   | 6 ++++--
 include/hw/gpio/sifive_gpio.h   | 6 ++++--
 include/hw/misc/sifive_e_prci.h | 6 ++++--
 include/hw/misc/sifive_test.h   | 6 ++++--
 include/hw/misc/sifive_u_otp.h  | 6 ++++--
 include/hw/misc/sifive_u_prci.h | 6 ++++--
 7 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/hw/intc/sifive_plic.h b/hw/intc/sifive_plic.h
index ace76d0f1b..aa6ae13c3a 100644
--- a/hw/intc/sifive_plic.h
+++ b/hw/intc/sifive_plic.h
@@ -22,9 +22,11 @@
 #define HW_SIFIVE_PLIC_H
 
 #include "hw/sysbus.h"
+#include "qom/object.h"
 
 #define TYPE_SIFIVE_PLIC "riscv.sifive.plic"
 
+typedef struct SiFivePLICState SiFivePLICState;
 #define SIFIVE_PLIC(obj) \
     OBJECT_CHECK(SiFivePLICState, (obj), TYPE_SIFIVE_PLIC)
 
@@ -41,7 +43,7 @@ typedef struct PLICAddr {
     PLICMode mode;
 } PLICAddr;
 
-typedef struct SiFivePLICState {
+struct SiFivePLICState {
     /*< private >*/
     SysBusDevice parent_obj;
 
@@ -69,7 +71,7 @@ typedef struct SiFivePLICState {
     uint32_t context_base;
     uint32_t context_stride;
     uint32_t aperture_size;
-} SiFivePLICState;
+};
 
 DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
     uint32_t hartid_base, uint32_t num_sources,
diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.h
index 65668825a3..2bb72ac80b 100644
--- a/include/hw/char/sifive_uart.h
+++ b/include/hw/char/sifive_uart.h
@@ -22,6 +22,7 @@
 
 #include "chardev/char-fe.h"
 #include "hw/sysbus.h"
+#include "qom/object.h"
 
 enum {
     SIFIVE_UART_TXFIFO        = 0,
@@ -51,10 +52,11 @@ enum {
 
 #define TYPE_SIFIVE_UART "riscv.sifive.uart"
 
+typedef struct SiFiveUARTState SiFiveUARTState;
 #define SIFIVE_UART(obj) \
     OBJECT_CHECK(SiFiveUARTState, (obj), TYPE_SIFIVE_UART)
 
-typedef struct SiFiveUARTState {
+struct SiFiveUARTState {
     /*< private >*/
     SysBusDevice parent_obj;
 
@@ -69,7 +71,7 @@ typedef struct SiFiveUARTState {
     uint32_t txctrl;
     uint32_t rxctrl;
     uint32_t div;
-} SiFiveUARTState;
+};
 
 SiFiveUARTState *sifive_uart_create(MemoryRegion *address_space, hwaddr base,
     Chardev *chr, qemu_irq irq);
diff --git a/include/hw/gpio/sifive_gpio.h b/include/hw/gpio/sifive_gpio.h
index cf12fcfd62..af991fa44e 100644
--- a/include/hw/gpio/sifive_gpio.h
+++ b/include/hw/gpio/sifive_gpio.h
@@ -15,8 +15,10 @@
 #define SIFIVE_GPIO_H
 
 #include "hw/sysbus.h"
+#include "qom/object.h"
 
 #define TYPE_SIFIVE_GPIO "sifive_soc.gpio"
+typedef struct SIFIVEGPIOState SIFIVEGPIOState;
 #define SIFIVE_GPIO(obj) OBJECT_CHECK(SIFIVEGPIOState, (obj), TYPE_SIFIVE_GPIO)
 
 #define SIFIVE_GPIO_PINS 32
@@ -41,7 +43,7 @@
 #define SIFIVE_GPIO_REG_IOF_SEL    0x03C
 #define SIFIVE_GPIO_REG_OUT_XOR    0x040
 
-typedef struct SIFIVEGPIOState {
+struct SIFIVEGPIOState {
     SysBusDevice parent_obj;
 
     MemoryRegion mmio;
@@ -71,6 +73,6 @@ typedef struct SIFIVEGPIOState {
 
     /* config */
     uint32_t ngpio;
-} SIFIVEGPIOState;
+};
 
 #endif /* SIFIVE_GPIO_H */
diff --git a/include/hw/misc/sifive_e_prci.h b/include/hw/misc/sifive_e_prci.h
index 698b0b451c..de1e502eea 100644
--- a/include/hw/misc/sifive_e_prci.h
+++ b/include/hw/misc/sifive_e_prci.h
@@ -18,6 +18,7 @@
 
 #ifndef HW_SIFIVE_E_PRCI_H
 #define HW_SIFIVE_E_PRCI_H
+#include "qom/object.h"
 
 enum {
     SIFIVE_E_PRCI_HFROSCCFG = 0x0,
@@ -51,10 +52,11 @@ enum {
 
 #define TYPE_SIFIVE_E_PRCI      "riscv.sifive.e.prci"
 
+typedef struct SiFiveEPRCIState SiFiveEPRCIState;
 #define SIFIVE_E_PRCI(obj) \
     OBJECT_CHECK(SiFiveEPRCIState, (obj), TYPE_SIFIVE_E_PRCI)
 
-typedef struct SiFiveEPRCIState {
+struct SiFiveEPRCIState {
     /*< private >*/
     SysBusDevice parent_obj;
 
@@ -64,7 +66,7 @@ typedef struct SiFiveEPRCIState {
     uint32_t hfxosccfg;
     uint32_t pllcfg;
     uint32_t plloutdiv;
-} SiFiveEPRCIState;
+};
 
 DeviceState *sifive_e_prci_create(hwaddr addr);
 
diff --git a/include/hw/misc/sifive_test.h b/include/hw/misc/sifive_test.h
index 1ec416ac1b..dc54b7af0c 100644
--- a/include/hw/misc/sifive_test.h
+++ b/include/hw/misc/sifive_test.h
@@ -20,19 +20,21 @@
 #define HW_SIFIVE_TEST_H
 
 #include "hw/sysbus.h"
+#include "qom/object.h"
 
 #define TYPE_SIFIVE_TEST "riscv.sifive.test"
 
+typedef struct SiFiveTestState SiFiveTestState;
 #define SIFIVE_TEST(obj) \
     OBJECT_CHECK(SiFiveTestState, (obj), TYPE_SIFIVE_TEST)
 
-typedef struct SiFiveTestState {
+struct SiFiveTestState {
     /*< private >*/
     SysBusDevice parent_obj;
 
     /*< public >*/
     MemoryRegion mmio;
-} SiFiveTestState;
+};
 
 enum {
     FINISHER_FAIL = 0x3333,
diff --git a/include/hw/misc/sifive_u_otp.h b/include/hw/misc/sifive_u_otp.h
index 639297564a..4572534f50 100644
--- a/include/hw/misc/sifive_u_otp.h
+++ b/include/hw/misc/sifive_u_otp.h
@@ -18,6 +18,7 @@
 
 #ifndef HW_SIFIVE_U_OTP_H
 #define HW_SIFIVE_U_OTP_H
+#include "qom/object.h"
 
 #define SIFIVE_U_OTP_PA         0x00
 #define SIFIVE_U_OTP_PAIO       0x04
@@ -49,10 +50,11 @@
 
 #define TYPE_SIFIVE_U_OTP           "riscv.sifive.u.otp"
 
+typedef struct SiFiveUOTPState SiFiveUOTPState;
 #define SIFIVE_U_OTP(obj) \
     OBJECT_CHECK(SiFiveUOTPState, (obj), TYPE_SIFIVE_U_OTP)
 
-typedef struct SiFiveUOTPState {
+struct SiFiveUOTPState {
     /*< private >*/
     SysBusDevice parent_obj;
 
@@ -75,6 +77,6 @@ typedef struct SiFiveUOTPState {
     uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];
     /* config */
     uint32_t serial;
-} SiFiveUOTPState;
+};
 
 #endif /* HW_SIFIVE_U_OTP_H */
diff --git a/include/hw/misc/sifive_u_prci.h b/include/hw/misc/sifive_u_prci.h
index 0a531fdadc..83eab43686 100644
--- a/include/hw/misc/sifive_u_prci.h
+++ b/include/hw/misc/sifive_u_prci.h
@@ -18,6 +18,7 @@
 
 #ifndef HW_SIFIVE_U_PRCI_H
 #define HW_SIFIVE_U_PRCI_H
+#include "qom/object.h"
 
 #define SIFIVE_U_PRCI_HFXOSCCFG     0x00
 #define SIFIVE_U_PRCI_COREPLLCFG0   0x04
@@ -58,10 +59,11 @@
 
 #define TYPE_SIFIVE_U_PRCI      "riscv.sifive.u.prci"
 
+typedef struct SiFiveUPRCIState SiFiveUPRCIState;
 #define SIFIVE_U_PRCI(obj) \
     OBJECT_CHECK(SiFiveUPRCIState, (obj), TYPE_SIFIVE_U_PRCI)
 
-typedef struct SiFiveUPRCIState {
+struct SiFiveUPRCIState {
     /*< private >*/
     SysBusDevice parent_obj;
 
@@ -76,7 +78,7 @@ typedef struct SiFiveUPRCIState {
     uint32_t coreclksel;
     uint32_t devicesreset;
     uint32_t clkmuxstatus;
-} SiFiveUPRCIState;
+};
 
 /*
  * Clock indexes for use by Device Tree data and the PRCI driver.
-- 
2.26.2


