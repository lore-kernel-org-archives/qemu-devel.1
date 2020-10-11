Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51D1C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 21:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECECC2074A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 21:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ir+4dG0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECECC2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRidE-0005RN-31
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 17:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRiXM-0007wu-1G; Sun, 11 Oct 2020 17:05:48 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:53544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRiXH-00007L-Rk; Sun, 11 Oct 2020 17:05:46 -0400
Received: by mail-wm1-x333.google.com with SMTP id f21so15429834wml.3;
 Sun, 11 Oct 2020 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J51/pM3cYp+hOFHsQxoL1E9wYAyLJA3rN458zG4A4Zc=;
 b=ir+4dG0PzzuKYwSmWri4x1bHJCkEA77UDQKMnbgSWuACwKbzYkNk5vsSKTq9DG0R4u
 KIjZGav91AXnGki2ZHCB7atsUXe38pQ28nmu/HE2VbNLAUGWSKu2fsvfs0P20v5/XwO2
 2zxUzbwzVK2v/7uooLa8VFycW1P+RtGPe3KhLZMMzARDYcpDIHgH3c7SKeEziVf7t1dO
 BCmAvMZ5Dt/4/zGSfatGbMZD/WIPmUZGKE9tK9VsYoW+W/IjpjFTnBv5CWMJvYs/mjVl
 6vFciKK/rqWwMcP7lqa2gy+TwoXm2Zn5Ap8tzJVlpuWh0ZZXPIMEzdbPytbR71TMBDcg
 1CLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=J51/pM3cYp+hOFHsQxoL1E9wYAyLJA3rN458zG4A4Zc=;
 b=KF2Xgz742p95X4eDyuJgJU9Gse54SEEAggT9jbGABJmPBULkRFipHg3seFjg6r7M2r
 nltrA315XQUnJE/aPWnq2FP78IQnthZGQ4kfuk5q+riMhx+iZfW+gTcNLBIz7fJplG2S
 EedFp/aIO9VRozu1EQmxtfEjD8Ew/M1BUYuzQYAreJkdJGjp9EX8EFuLnQbVIAUfWLIC
 MTyqGMZYBY+7jbw0p/CH0zQtrAHrbUIZ+XC2Gooj+TsMgGuQ7PNYz8+pbvjb/x1mmXNO
 JDpjwl3miLA7p1VYs/bfxqISVLiqyppaJewKpCZChITdpaK91ky32xGvaT9vUiCzu4/P
 o/pw==
X-Gm-Message-State: AOAM532ClY/0+yNoH20kbvGNAtuhN28/28Wn4m5ZMfyFCezQHiBpZ5aN
 Lo6hxiUWIxgWw4jkA9ca8tPB0tzPYgo=
X-Google-Smtp-Source: ABdhPJykvRgTF8Loo+R8HhbGqMjkRP6Hus9w0PprBkhyJfXRqlUf3cn9G3uIwBQtNgAOc6z9vIfROA==
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr7936515wmh.92.1602450336273; 
 Sun, 11 Oct 2020 14:05:36 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id y5sm14629492wrw.52.2020.10.11.14.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 14:05:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/3] hw/ssi: Rename SSI 'slave' as 'peripheral'
Date: Sun, 11 Oct 2020 23:05:13 +0200
Message-Id: <20201011210513.3253905-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201011210513.3253905-1-f4bug@amsat.org>
References: <20201011210513.3253905-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>, qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to use inclusive terminology, rename SSI 'slave' as
'peripheral', following the specification resolution:
https://www.oshwa.org/a-resolution-to-redefine-spi-signal-names/

Patch created mechanically using:

  $ sed -i s/SSISlave/SSIPeripheral/ $(git grep -l SSISlave)
  $ sed -i s/SSI_SLAVE/SSI_PERIPHERAL/ $(git grep -l SSI_SLAVE)
  $ sed -i s/ssi-slave/ssi-peripheral/ $(git grep -l ssi-slave)
  $ sed -i s/ssi_slave/ssi_peripheral/ $(git grep -l ssi_slave)
  $ sed -i s/ssi_create_slave/ssi_create_peripheral/ \
                                $(git grep -l ssi_create_slave)

Then in VMStateDescription vmstate_ssi_peripheral we restored
the "SSISlave" migration stream name (to avoid breaking migration).

Finally the following files have been manually tweaked:
 - hw/ssi/pl022.c
 - hw/ssi/xilinx_spips.c

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/max111x.h |  2 +-
 include/hw/ssi/ssi.h      | 46 ++++++++++++++++++-------------------
 hw/arm/spitz.c            | 32 +++++++++++++-------------
 hw/arm/stellaris.c        |  4 ++--
 hw/arm/tosa.c             | 12 +++++-----
 hw/arm/z2.c               | 14 ++++++------
 hw/block/m25p80.c         | 14 ++++++------
 hw/display/ads7846.c      | 12 +++++-----
 hw/display/ssd0323.c      | 12 +++++-----
 hw/misc/max111x.c         | 18 +++++++--------
 hw/sd/ssi-sd.c            | 12 +++++-----
 hw/ssi/pl022.c            |  2 +-
 hw/ssi/ssi.c              | 48 +++++++++++++++++++--------------------
 hw/ssi/xilinx_spips.c     |  7 +++---
 14 files changed, 118 insertions(+), 117 deletions(-)

diff --git a/include/hw/misc/max111x.h b/include/hw/misc/max111x.h
index 606cf1e0a2a..beff59c815d 100644
--- a/include/hw/misc/max111x.h
+++ b/include/hw/misc/max111x.h
@@ -33,7 +33,7 @@
  *    be lowered once it has been asserted.
  */
 struct MAX111xState {
-    SSISlave parent_obj;
+    SSIPeripheral parent_obj;
 
     qemu_irq interrupt;
     /* Values of inputs at system reset (settable by QOM property) */
diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
index c15548425a3..f411858ab08 100644
--- a/include/hw/ssi/ssi.h
+++ b/include/hw/ssi/ssi.h
@@ -2,11 +2,11 @@
 
 /*
  * In principle SSI is a point-point interface.  As such the qemu
- * implementation has a single slave device on a "bus".
- * However it is fairly common for boards to have multiple slaves
+ * implementation has a single peripheral on a "bus".
+ * However it is fairly common for boards to have multiple peripherals
  * connected to a single master, and select devices with an external
  * chip select.  This is implemented in qemu by having an explicit mux device.
- * It is assumed that master and slave are both using the same transfer
+ * It is assumed that master and peripheral are both using the same transfer
  * width.
  */
 
@@ -18,9 +18,9 @@
 
 typedef enum SSICSMode SSICSMode;
 
-#define TYPE_SSI_SLAVE "ssi-slave"
-OBJECT_DECLARE_TYPE(SSISlave, SSISlaveClass,
-                    SSI_SLAVE)
+#define TYPE_SSI_PERIPHERAL "ssi-peripheral"
+OBJECT_DECLARE_TYPE(SSIPeripheral, SSIPeripheralClass,
+                    SSI_PERIPHERAL)
 
 #define SSI_GPIO_CS "ssi-gpio-cs"
 
@@ -30,21 +30,21 @@ enum SSICSMode {
     SSI_CS_HIGH,
 };
 
-/* Slave devices.  */
-struct SSISlaveClass {
+/* Peripherals.  */
+struct SSIPeripheralClass {
     DeviceClass parent_class;
 
-    void (*realize)(SSISlave *dev, Error **errp);
+    void (*realize)(SSIPeripheral *dev, Error **errp);
 
     /* if you have standard or no CS behaviour, just override transfer.
      * This is called when the device cs is active (true by default).
      */
-    uint32_t (*transfer)(SSISlave *dev, uint32_t val);
+    uint32_t (*transfer)(SSIPeripheral *dev, uint32_t val);
     /* called when the CS line changes. Optional, devices only need to implement
      * this if they have side effects associated with the cs line (beyond
      * tristating the txrx lines).
      */
-    int (*set_cs)(SSISlave *dev, bool select);
+    int (*set_cs)(SSIPeripheral *dev, bool select);
     /* define whether or not CS exists and is active low/high */
     SSICSMode cs_polarity;
 
@@ -53,30 +53,30 @@ struct SSISlaveClass {
      * cs_polarity are unused if this is overwritten. Transfer_raw will
      * always be called for the device for every txrx access to the parent bus
      */
-    uint32_t (*transfer_raw)(SSISlave *dev, uint32_t val);
+    uint32_t (*transfer_raw)(SSIPeripheral *dev, uint32_t val);
 };
 
-struct SSISlave {
+struct SSIPeripheral {
     DeviceState parent_obj;
 
     /* Chip select state */
     bool cs;
 };
 
-extern const VMStateDescription vmstate_ssi_slave;
+extern const VMStateDescription vmstate_ssi_peripheral;
 
-#define VMSTATE_SSI_SLAVE(_field, _state) {                          \
+#define VMSTATE_SSI_PERIPHERAL(_field, _state) {                     \
     .name       = (stringify(_field)),                               \
-    .size       = sizeof(SSISlave),                                  \
-    .vmsd       = &vmstate_ssi_slave,                                \
+    .size       = sizeof(SSIPeripheral),                             \
+    .vmsd       = &vmstate_ssi_peripheral,                           \
     .flags      = VMS_STRUCT,                                        \
-    .offset     = vmstate_offset_value(_state, _field, SSISlave),    \
+    .offset     = vmstate_offset_value(_state, _field, SSIPeripheral), \
 }
 
-DeviceState *ssi_create_slave(SSIBus *bus, const char *name);
+DeviceState *ssi_create_peripheral(SSIBus *bus, const char *name);
 /**
- * ssi_realize_and_unref: realize and unref an SSI slave device
- * @dev: SSI slave device to realize
+ * ssi_realize_and_unref: realize and unref an SSI peripheral
+ * @dev: SSI peripheral to realize
  * @bus: SSI bus to put it on
  * @errp: error pointer
  *
@@ -87,10 +87,10 @@ DeviceState *ssi_create_slave(SSIBus *bus, const char *name);
  * This function is useful if you have created @dev via qdev_new()
  * (which takes a reference to the device it returns to you), so that
  * you can set properties on it before realizing it. If you don't need
- * to set properties then ssi_create_slave() is probably better (as it
+ * to set properties then ssi_create_peripheral() is probably better (as it
  * does the create, init and realize in one step).
  *
- * If you are embedding the SSI slave into another QOM device and
+ * If you are embedding the SSI peripheral into another QOM device and
  * initialized it via some variant on object_initialize_child() then
  * do not use this function, because that family of functions arrange
  * for the only reference to the child device to be held by the parent
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 32bdeacfd36..f1728224b62 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -578,7 +578,7 @@ static void spitz_keyboard_realize(DeviceState *dev, Error **errp)
 OBJECT_DECLARE_SIMPLE_TYPE(SpitzLCDTG, SPITZ_LCDTG)
 
 struct SpitzLCDTG {
-    SSISlave ssidev;
+    SSIPeripheral ssidev;
     uint32_t bl_intensity;
     uint32_t bl_power;
 };
@@ -612,7 +612,7 @@ static inline void spitz_bl_power(void *opaque, int line, int level)
     spitz_bl_update(s);
 }
 
-static uint32_t spitz_lcdtg_transfer(SSISlave *dev, uint32_t value)
+static uint32_t spitz_lcdtg_transfer(SSIPeripheral *dev, uint32_t value)
 {
     SpitzLCDTG *s = SPITZ_LCDTG(dev);
     int addr;
@@ -641,7 +641,7 @@ static uint32_t spitz_lcdtg_transfer(SSISlave *dev, uint32_t value)
     return 0;
 }
 
-static void spitz_lcdtg_realize(SSISlave *ssi, Error **errp)
+static void spitz_lcdtg_realize(SSIPeripheral *ssi, Error **errp)
 {
     SpitzLCDTG *s = SPITZ_LCDTG(ssi);
     DeviceState *dev = DEVICE(s);
@@ -667,12 +667,12 @@ OBJECT_DECLARE_SIMPLE_TYPE(CorgiSSPState, CORGI_SSP)
 
 /* "Demux" the signal based on current chipselect */
 struct CorgiSSPState {
-    SSISlave ssidev;
+    SSIPeripheral ssidev;
     SSIBus *bus[3];
     uint32_t enable[3];
 };
 
-static uint32_t corgi_ssp_transfer(SSISlave *dev, uint32_t value)
+static uint32_t corgi_ssp_transfer(SSIPeripheral *dev, uint32_t value)
 {
     CorgiSSPState *s = CORGI_SSP(dev);
     int i;
@@ -700,7 +700,7 @@ static void corgi_ssp_gpio_cs(void *opaque, int line, int level)
 #define SPITZ_BATTERY_VOLT      0xd0    /* About 4.0V */
 #define SPITZ_CHARGEON_ACIN     0x80    /* About 5.0V */
 
-static void corgi_ssp_realize(SSISlave *d, Error **errp)
+static void corgi_ssp_realize(SSIPeripheral *d, Error **errp)
 {
     DeviceState *dev = DEVICE(d);
     CorgiSSPState *s = CORGI_SSP(d);
@@ -715,14 +715,14 @@ static void spitz_ssp_attach(SpitzMachineState *sms)
 {
     void *bus;
 
-    sms->mux = ssi_create_slave(sms->mpu->ssp[CORGI_SSP_PORT - 1],
-                                TYPE_CORGI_SSP);
+    sms->mux = ssi_create_peripheral(sms->mpu->ssp[CORGI_SSP_PORT - 1],
+                                     TYPE_CORGI_SSP);
 
     bus = qdev_get_child_bus(sms->mux, "ssi0");
-    sms->lcdtg = ssi_create_slave(bus, TYPE_SPITZ_LCDTG);
+    sms->lcdtg = ssi_create_peripheral(bus, TYPE_SPITZ_LCDTG);
 
     bus = qdev_get_child_bus(sms->mux, "ssi1");
-    sms->ads7846 = ssi_create_slave(bus, "ads7846");
+    sms->ads7846 = ssi_create_peripheral(bus, "ads7846");
     qdev_connect_gpio_out(sms->ads7846, 0,
                           qdev_get_gpio_in(sms->mpu->gpio, SPITZ_GPIO_TP_INT));
 
@@ -1204,7 +1204,7 @@ static const VMStateDescription vmstate_corgi_ssp_regs = {
     .version_id = 2,
     .minimum_version_id = 2,
     .fields = (VMStateField[]) {
-        VMSTATE_SSI_SLAVE(ssidev, CorgiSSPState),
+        VMSTATE_SSI_PERIPHERAL(ssidev, CorgiSSPState),
         VMSTATE_UINT32_ARRAY(enable, CorgiSSPState, 3),
         VMSTATE_END_OF_LIST(),
     }
@@ -1213,7 +1213,7 @@ static const VMStateDescription vmstate_corgi_ssp_regs = {
 static void corgi_ssp_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SSISlaveClass *k = SSI_SLAVE_CLASS(klass);
+    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
 
     k->realize = corgi_ssp_realize;
     k->transfer = corgi_ssp_transfer;
@@ -1222,7 +1222,7 @@ static void corgi_ssp_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo corgi_ssp_info = {
     .name          = TYPE_CORGI_SSP,
-    .parent        = TYPE_SSI_SLAVE,
+    .parent        = TYPE_SSI_PERIPHERAL,
     .instance_size = sizeof(CorgiSSPState),
     .class_init    = corgi_ssp_class_init,
 };
@@ -1232,7 +1232,7 @@ static const VMStateDescription vmstate_spitz_lcdtg_regs = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_SSI_SLAVE(ssidev, SpitzLCDTG),
+        VMSTATE_SSI_PERIPHERAL(ssidev, SpitzLCDTG),
         VMSTATE_UINT32(bl_intensity, SpitzLCDTG),
         VMSTATE_UINT32(bl_power, SpitzLCDTG),
         VMSTATE_END_OF_LIST(),
@@ -1242,7 +1242,7 @@ static const VMStateDescription vmstate_spitz_lcdtg_regs = {
 static void spitz_lcdtg_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SSISlaveClass *k = SSI_SLAVE_CLASS(klass);
+    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
 
     k->realize = spitz_lcdtg_realize;
     k->transfer = spitz_lcdtg_transfer;
@@ -1251,7 +1251,7 @@ static void spitz_lcdtg_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo spitz_lcdtg_info = {
     .name          = TYPE_SPITZ_LCDTG,
-    .parent        = TYPE_SSI_SLAVE,
+    .parent        = TYPE_SSI_PERIPHERAL,
     .instance_size = sizeof(SpitzLCDTG),
     .class_init    = spitz_lcdtg_class_init,
 };
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 1237f5af021..652823195b1 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1397,8 +1397,8 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
              */
             bus = qdev_get_child_bus(dev, "ssi");
 
-            sddev = ssi_create_slave(bus, "ssi-sd");
-            ssddev = ssi_create_slave(bus, "ssd0323");
+            sddev = ssi_create_peripheral(bus, "ssi-sd");
+            ssddev = ssi_create_peripheral(bus, "ssd0323");
             gpio_out[GPIO_D][0] = qemu_irq_split(
                     qdev_get_gpio_in_named(sddev, SSI_GPIO_CS, 0),
                     qdev_get_gpio_in_named(ssddev, SSI_GPIO_CS, 0));
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index c196f0d2f88..75c7adb1079 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -158,13 +158,13 @@ static void tosa_gpio_setup(PXA2xxState *cpu,
     qemu_irq_raise(qdev_get_gpio_in(cpu->gpio, TOSA_GPIO_USB_IN));
 }
 
-static uint32_t tosa_ssp_tansfer(SSISlave *dev, uint32_t value)
+static uint32_t tosa_ssp_tansfer(SSIPeripheral *dev, uint32_t value)
 {
     fprintf(stderr, "TG: %d %02x\n", value >> 5, value & 0x1f);
     return 0;
 }
 
-static void tosa_ssp_realize(SSISlave *dev, Error **errp)
+static void tosa_ssp_realize(SSIPeripheral *dev, Error **errp)
 {
     /* Nothing to do.  */
 }
@@ -235,7 +235,7 @@ static void tosa_tg_init(PXA2xxState *cpu)
 {
     I2CBus *bus = pxa2xx_i2c_bus(cpu->i2c[0]);
     i2c_slave_create_simple(bus, TYPE_TOSA_DAC, DAC_BASE);
-    ssi_create_slave(cpu->ssp[1], "tosa-ssp");
+    ssi_create_peripheral(cpu->ssp[1], "tosa-ssp");
 }
 
 
@@ -302,7 +302,7 @@ static const TypeInfo tosa_dac_info = {
 
 static void tosa_ssp_class_init(ObjectClass *klass, void *data)
 {
-    SSISlaveClass *k = SSI_SLAVE_CLASS(klass);
+    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
 
     k->realize = tosa_ssp_realize;
     k->transfer = tosa_ssp_tansfer;
@@ -310,8 +310,8 @@ static void tosa_ssp_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo tosa_ssp_info = {
     .name          = "tosa-ssp",
-    .parent        = TYPE_SSI_SLAVE,
-    .instance_size = sizeof(SSISlave),
+    .parent        = TYPE_SSI_PERIPHERAL,
+    .instance_size = sizeof(SSIPeripheral),
     .class_init    = tosa_ssp_class_init,
 };
 
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 4fc5699daef..308c4da9566 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -104,7 +104,7 @@ static struct arm_boot_info z2_binfo = {
 #define Z2_GPIO_LCD_CS      88
 
 struct ZipitLCD {
-    SSISlave ssidev;
+    SSIPeripheral ssidev;
     int32_t selected;
     int32_t enabled;
     uint8_t buf[3];
@@ -115,7 +115,7 @@ struct ZipitLCD {
 #define TYPE_ZIPIT_LCD "zipit-lcd"
 OBJECT_DECLARE_SIMPLE_TYPE(ZipitLCD, ZIPIT_LCD)
 
-static uint32_t zipit_lcd_transfer(SSISlave *dev, uint32_t value)
+static uint32_t zipit_lcd_transfer(SSIPeripheral *dev, uint32_t value)
 {
     ZipitLCD *z = ZIPIT_LCD(dev);
     uint16_t val;
@@ -155,7 +155,7 @@ static void z2_lcd_cs(void *opaque, int line, int level)
     z2_lcd->selected = !level;
 }
 
-static void zipit_lcd_realize(SSISlave *dev, Error **errp)
+static void zipit_lcd_realize(SSIPeripheral *dev, Error **errp)
 {
     ZipitLCD *z = ZIPIT_LCD(dev);
     z->selected = 0;
@@ -168,7 +168,7 @@ static VMStateDescription vmstate_zipit_lcd_state = {
     .version_id = 2,
     .minimum_version_id = 2,
     .fields = (VMStateField[]) {
-        VMSTATE_SSI_SLAVE(ssidev, ZipitLCD),
+        VMSTATE_SSI_PERIPHERAL(ssidev, ZipitLCD),
         VMSTATE_INT32(selected, ZipitLCD),
         VMSTATE_INT32(enabled, ZipitLCD),
         VMSTATE_BUFFER(buf, ZipitLCD),
@@ -181,7 +181,7 @@ static VMStateDescription vmstate_zipit_lcd_state = {
 static void zipit_lcd_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SSISlaveClass *k = SSI_SLAVE_CLASS(klass);
+    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
 
     k->realize = zipit_lcd_realize;
     k->transfer = zipit_lcd_transfer;
@@ -190,7 +190,7 @@ static void zipit_lcd_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo zipit_lcd_info = {
     .name          = TYPE_ZIPIT_LCD,
-    .parent        = TYPE_SSI_SLAVE,
+    .parent        = TYPE_SSI_PERIPHERAL,
     .instance_size = sizeof(ZipitLCD),
     .class_init    = zipit_lcd_class_init,
 };
@@ -329,7 +329,7 @@ static void z2_init(MachineState *machine)
 
     type_register_static(&zipit_lcd_info);
     type_register_static(&aer915_info);
-    z2_lcd = ssi_create_slave(mpu->ssp[1], TYPE_ZIPIT_LCD);
+    z2_lcd = ssi_create_peripheral(mpu->ssp[1], TYPE_ZIPIT_LCD);
     bus = pxa2xx_i2c_bus(mpu->i2c[0]);
     i2c_slave_create_simple(bus, TYPE_AER915, 0x55);
     wm = DEVICE(i2c_slave_create_simple(bus, TYPE_WM8750, 0x1b));
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 483925f57a9..d09a811767a 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -416,7 +416,7 @@ typedef enum {
 #define M25P80_INTERNAL_DATA_BUFFER_SZ 16
 
 struct Flash {
-    SSISlave parent_obj;
+    SSIPeripheral parent_obj;
 
     BlockBackend *blk;
 
@@ -458,7 +458,7 @@ struct Flash {
 };
 
 struct M25P80Class {
-    SSISlaveClass parent_class;
+    SSIPeripheralClass parent_class;
     FlashPartInfo *pi;
 };
 
@@ -1170,7 +1170,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
     }
 }
 
-static int m25p80_cs(SSISlave *ss, bool select)
+static int m25p80_cs(SSIPeripheral *ss, bool select)
 {
     Flash *s = M25P80(ss);
 
@@ -1190,7 +1190,7 @@ static int m25p80_cs(SSISlave *ss, bool select)
     return 0;
 }
 
-static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
+static uint32_t m25p80_transfer8(SSIPeripheral *ss, uint32_t tx)
 {
     Flash *s = M25P80(ss);
     uint32_t r = 0;
@@ -1265,7 +1265,7 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
     return r;
 }
 
-static void m25p80_realize(SSISlave *ss, Error **errp)
+static void m25p80_realize(SSIPeripheral *ss, Error **errp)
 {
     Flash *s = M25P80(ss);
     M25P80Class *mc = M25P80_GET_CLASS(s);
@@ -1386,7 +1386,7 @@ static const VMStateDescription vmstate_m25p80 = {
 static void m25p80_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SSISlaveClass *k = SSI_SLAVE_CLASS(klass);
+    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
     M25P80Class *mc = M25P80_CLASS(klass);
 
     k->realize = m25p80_realize;
@@ -1401,7 +1401,7 @@ static void m25p80_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo m25p80_info = {
     .name           = TYPE_M25P80,
-    .parent         = TYPE_SSI_SLAVE,
+    .parent         = TYPE_SSI_PERIPHERAL,
     .instance_size  = sizeof(Flash),
     .class_size     = sizeof(M25P80Class),
     .abstract       = true,
diff --git a/hw/display/ads7846.c b/hw/display/ads7846.c
index 023165b2a32..9c91a2d3d4b 100644
--- a/hw/display/ads7846.c
+++ b/hw/display/ads7846.c
@@ -19,7 +19,7 @@
 #include "qom/object.h"
 
 struct ADS7846State {
-    SSISlave ssidev;
+    SSIPeripheral ssidev;
     qemu_irq interrupt;
 
     int input[8];
@@ -63,7 +63,7 @@ static void ads7846_int_update(ADS7846State *s)
         qemu_set_irq(s->interrupt, s->pressure == 0);
 }
 
-static uint32_t ads7846_transfer(SSISlave *dev, uint32_t value)
+static uint32_t ads7846_transfer(SSIPeripheral *dev, uint32_t value)
 {
     ADS7846State *s = ADS7846(dev);
 
@@ -131,7 +131,7 @@ static const VMStateDescription vmstate_ads7846 = {
     .minimum_version_id = 1,
     .post_load = ads7856_post_load,
     .fields = (VMStateField[]) {
-        VMSTATE_SSI_SLAVE(ssidev, ADS7846State),
+        VMSTATE_SSI_PERIPHERAL(ssidev, ADS7846State),
         VMSTATE_INT32_ARRAY(input, ADS7846State, 8),
         VMSTATE_INT32(noise, ADS7846State),
         VMSTATE_INT32(cycle, ADS7846State),
@@ -140,7 +140,7 @@ static const VMStateDescription vmstate_ads7846 = {
     }
 };
 
-static void ads7846_realize(SSISlave *d, Error **errp)
+static void ads7846_realize(SSIPeripheral *d, Error **errp)
 {
     DeviceState *dev = DEVICE(d);
     ADS7846State *s = ADS7846(d);
@@ -163,7 +163,7 @@ static void ads7846_realize(SSISlave *d, Error **errp)
 
 static void ads7846_class_init(ObjectClass *klass, void *data)
 {
-    SSISlaveClass *k = SSI_SLAVE_CLASS(klass);
+    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
 
     k->realize = ads7846_realize;
     k->transfer = ads7846_transfer;
@@ -171,7 +171,7 @@ static void ads7846_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo ads7846_info = {
     .name          = TYPE_ADS7846,
-    .parent        = TYPE_SSI_SLAVE,
+    .parent        = TYPE_SSI_PERIPHERAL,
     .instance_size = sizeof(ADS7846State),
     .class_init    = ads7846_class_init,
 };
diff --git a/hw/display/ssd0323.c b/hw/display/ssd0323.c
index 17d4b32ae36..49af345759a 100644
--- a/hw/display/ssd0323.c
+++ b/hw/display/ssd0323.c
@@ -49,7 +49,7 @@ enum ssd0323_mode
 };
 
 struct ssd0323_state {
-    SSISlave ssidev;
+    SSIPeripheral ssidev;
     QemuConsole *con;
 
     uint32_t cmd_len;
@@ -71,7 +71,7 @@ struct ssd0323_state {
 OBJECT_DECLARE_SIMPLE_TYPE(ssd0323_state, SSD0323)
 
 
-static uint32_t ssd0323_transfer(SSISlave *dev, uint32_t data)
+static uint32_t ssd0323_transfer(SSIPeripheral *dev, uint32_t data)
 {
     ssd0323_state *s = SSD0323(dev);
 
@@ -338,7 +338,7 @@ static const VMStateDescription vmstate_ssd0323 = {
         VMSTATE_INT32(remap, ssd0323_state),
         VMSTATE_UINT32(mode, ssd0323_state),
         VMSTATE_BUFFER(framebuffer, ssd0323_state),
-        VMSTATE_SSI_SLAVE(ssidev, ssd0323_state),
+        VMSTATE_SSI_PERIPHERAL(ssidev, ssd0323_state),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -348,7 +348,7 @@ static const GraphicHwOps ssd0323_ops = {
     .gfx_update  = ssd0323_update_display,
 };
 
-static void ssd0323_realize(SSISlave *d, Error **errp)
+static void ssd0323_realize(SSIPeripheral *d, Error **errp)
 {
     DeviceState *dev = DEVICE(d);
     ssd0323_state *s = SSD0323(d);
@@ -364,7 +364,7 @@ static void ssd0323_realize(SSISlave *d, Error **errp)
 static void ssd0323_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SSISlaveClass *k = SSI_SLAVE_CLASS(klass);
+    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
 
     k->realize = ssd0323_realize;
     k->transfer = ssd0323_transfer;
@@ -374,7 +374,7 @@ static void ssd0323_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo ssd0323_info = {
     .name          = TYPE_SSD0323,
-    .parent        = TYPE_SSI_SLAVE,
+    .parent        = TYPE_SSI_PERIPHERAL,
     .instance_size = sizeof(ssd0323_state),
     .class_init    = ssd0323_class_init,
 };
diff --git a/hw/misc/max111x.c b/hw/misc/max111x.c
index 7e6723f3435..762617ebff0 100644
--- a/hw/misc/max111x.c
+++ b/hw/misc/max111x.c
@@ -85,7 +85,7 @@ static void max111x_write(MAX111xState *s, uint32_t value)
     qemu_irq_raise(s->interrupt);
 }
 
-static uint32_t max111x_transfer(SSISlave *dev, uint32_t value)
+static uint32_t max111x_transfer(SSIPeripheral *dev, uint32_t value)
 {
     MAX111xState *s = MAX_111X(dev);
     max111x_write(s, value);
@@ -97,7 +97,7 @@ static const VMStateDescription vmstate_max111x = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_SSI_SLAVE(parent_obj, MAX111xState),
+        VMSTATE_SSI_PERIPHERAL(parent_obj, MAX111xState),
         VMSTATE_UINT8(tb1, MAX111xState),
         VMSTATE_UINT8(rb2, MAX111xState),
         VMSTATE_UINT8(rb3, MAX111xState),
@@ -117,7 +117,7 @@ static void max111x_input_set(void *opaque, int line, int value)
     s->input[line] = value;
 }
 
-static int max111x_init(SSISlave *d, int inputs)
+static int max111x_init(SSIPeripheral *d, int inputs)
 {
     DeviceState *dev = DEVICE(d);
     MAX111xState *s = MAX_111X(dev);
@@ -130,12 +130,12 @@ static int max111x_init(SSISlave *d, int inputs)
     return 0;
 }
 
-static void max1110_realize(SSISlave *dev, Error **errp)
+static void max1110_realize(SSIPeripheral *dev, Error **errp)
 {
     max111x_init(dev, 8);
 }
 
-static void max1111_realize(SSISlave *dev, Error **errp)
+static void max1111_realize(SSIPeripheral *dev, Error **errp)
 {
     max111x_init(dev, 4);
 }
@@ -179,7 +179,7 @@ static Property max1111_properties[] = {
 
 static void max111x_class_init(ObjectClass *klass, void *data)
 {
-    SSISlaveClass *k = SSI_SLAVE_CLASS(klass);
+    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     k->transfer = max111x_transfer;
@@ -189,7 +189,7 @@ static void max111x_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo max111x_info = {
     .name          = TYPE_MAX_111X,
-    .parent        = TYPE_SSI_SLAVE,
+    .parent        = TYPE_SSI_PERIPHERAL,
     .instance_size = sizeof(MAX111xState),
     .class_init    = max111x_class_init,
     .abstract      = true,
@@ -197,7 +197,7 @@ static const TypeInfo max111x_info = {
 
 static void max1110_class_init(ObjectClass *klass, void *data)
 {
-    SSISlaveClass *k = SSI_SLAVE_CLASS(klass);
+    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     k->realize = max1110_realize;
@@ -212,7 +212,7 @@ static const TypeInfo max1110_info = {
 
 static void max1111_class_init(ObjectClass *klass, void *data)
 {
-    SSISlaveClass *k = SSI_SLAVE_CLASS(klass);
+    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     k->realize = max1111_realize;
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 14c8e04a890..9a75e0095cf 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -42,7 +42,7 @@ typedef enum {
 } ssi_sd_mode;
 
 struct ssi_sd_state {
-    SSISlave ssidev;
+    SSIPeripheral ssidev;
     uint32_t mode;
     int cmd;
     uint8_t cmdarg[4];
@@ -73,7 +73,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(ssi_sd_state, SSI_SD)
 #define SSI_SDR_ADDRESS_ERROR   0x2000
 #define SSI_SDR_PARAMETER_ERROR 0x4000
 
-static uint32_t ssi_sd_transfer(SSISlave *dev, uint32_t val)
+static uint32_t ssi_sd_transfer(SSIPeripheral *dev, uint32_t val)
 {
     ssi_sd_state *s = SSI_SD(dev);
 
@@ -235,12 +235,12 @@ static const VMStateDescription vmstate_ssi_sd = {
         VMSTATE_INT32(arglen, ssi_sd_state),
         VMSTATE_INT32(response_pos, ssi_sd_state),
         VMSTATE_INT32(stopping, ssi_sd_state),
-        VMSTATE_SSI_SLAVE(ssidev, ssi_sd_state),
+        VMSTATE_SSI_PERIPHERAL(ssidev, ssi_sd_state),
         VMSTATE_END_OF_LIST()
     }
 };
 
-static void ssi_sd_realize(SSISlave *d, Error **errp)
+static void ssi_sd_realize(SSIPeripheral *d, Error **errp)
 {
     ERRP_GUARD();
     ssi_sd_state *s = SSI_SD(d);
@@ -291,7 +291,7 @@ static void ssi_sd_reset(DeviceState *dev)
 static void ssi_sd_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SSISlaveClass *k = SSI_SLAVE_CLASS(klass);
+    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
 
     k->realize = ssi_sd_realize;
     k->transfer = ssi_sd_transfer;
@@ -304,7 +304,7 @@ static void ssi_sd_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo ssi_sd_info = {
     .name          = TYPE_SSI_SD,
-    .parent        = TYPE_SSI_SLAVE,
+    .parent        = TYPE_SSI_PERIPHERAL,
     .instance_size = sizeof(ssi_sd_state),
     .class_init    = ssi_sd_class_init,
 };
diff --git a/hw/ssi/pl022.c b/hw/ssi/pl022.c
index cade2e92a89..8954ffebb1f 100644
--- a/hw/ssi/pl022.c
+++ b/hw/ssi/pl022.c
@@ -174,7 +174,7 @@ static void pl022_write(void *opaque, hwaddr offset,
         s->cr1 = value;
         if ((s->cr1 & (PL022_CR1_MS | PL022_CR1_SSE))
                    == (PL022_CR1_MS | PL022_CR1_SSE)) {
-            BADF("SPI slave mode not implemented\n");
+            BADF("SPI peripheral mode not implemented\n");
         }
         pl022_xfer(s);
         break;
diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index 4278d0e4440..e5d7ce95237 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -34,11 +34,11 @@ static const TypeInfo ssi_bus_info = {
 
 static void ssi_cs_default(void *opaque, int n, int level)
 {
-    SSISlave *s = SSI_SLAVE(opaque);
+    SSIPeripheral *s = SSI_PERIPHERAL(opaque);
     bool cs = !!level;
     assert(n == 0);
     if (s->cs != cs) {
-        SSISlaveClass *ssc = SSI_SLAVE_GET_CLASS(s);
+        SSIPeripheralClass *ssc = SSI_PERIPHERAL_GET_CLASS(s);
         if (ssc->set_cs) {
             ssc->set_cs(s, cs);
         }
@@ -46,9 +46,9 @@ static void ssi_cs_default(void *opaque, int n, int level)
     s->cs = cs;
 }
 
-static uint32_t ssi_transfer_raw_default(SSISlave *dev, uint32_t val)
+static uint32_t ssi_transfer_raw_default(SSIPeripheral *dev, uint32_t val)
 {
-    SSISlaveClass *ssc = SSI_SLAVE_GET_CLASS(dev);
+    SSIPeripheralClass *ssc = SSI_PERIPHERAL_GET_CLASS(dev);
 
     if ((dev->cs && ssc->cs_polarity == SSI_CS_HIGH) ||
             (!dev->cs && ssc->cs_polarity == SSI_CS_LOW) ||
@@ -58,10 +58,10 @@ static uint32_t ssi_transfer_raw_default(SSISlave *dev, uint32_t val)
     return 0;
 }
 
-static void ssi_slave_realize(DeviceState *dev, Error **errp)
+static void ssi_peripheral_realize(DeviceState *dev, Error **errp)
 {
-    SSISlave *s = SSI_SLAVE(dev);
-    SSISlaveClass *ssc = SSI_SLAVE_GET_CLASS(s);
+    SSIPeripheral *s = SSI_PERIPHERAL(dev);
+    SSIPeripheralClass *ssc = SSI_PERIPHERAL_GET_CLASS(s);
 
     if (ssc->transfer_raw == ssi_transfer_raw_default &&
             ssc->cs_polarity != SSI_CS_NONE) {
@@ -71,23 +71,23 @@ static void ssi_slave_realize(DeviceState *dev, Error **errp)
     ssc->realize(s, errp);
 }
 
-static void ssi_slave_class_init(ObjectClass *klass, void *data)
+static void ssi_peripheral_class_init(ObjectClass *klass, void *data)
 {
-    SSISlaveClass *ssc = SSI_SLAVE_CLASS(klass);
+    SSIPeripheralClass *ssc = SSI_PERIPHERAL_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->realize = ssi_slave_realize;
+    dc->realize = ssi_peripheral_realize;
     dc->bus_type = TYPE_SSI_BUS;
     if (!ssc->transfer_raw) {
         ssc->transfer_raw = ssi_transfer_raw_default;
     }
 }
 
-static const TypeInfo ssi_slave_info = {
-    .name = TYPE_SSI_SLAVE,
+static const TypeInfo ssi_peripheral_info = {
+    .name = TYPE_SSI_PERIPHERAL,
     .parent = TYPE_DEVICE,
-    .class_init = ssi_slave_class_init,
-    .class_size = sizeof(SSISlaveClass),
+    .class_init = ssi_peripheral_class_init,
+    .class_size = sizeof(SSIPeripheralClass),
     .abstract = true,
 };
 
@@ -96,7 +96,7 @@ bool ssi_realize_and_unref(DeviceState *dev, SSIBus *bus, Error **errp)
     return qdev_realize_and_unref(dev, &bus->parent_obj, errp);
 }
 
-DeviceState *ssi_create_slave(SSIBus *bus, const char *name)
+DeviceState *ssi_create_peripheral(SSIBus *bus, const char *name)
 {
     DeviceState *dev = qdev_new(name);
 
@@ -115,32 +115,32 @@ uint32_t ssi_transfer(SSIBus *bus, uint32_t val)
 {
     BusState *b = BUS(bus);
     BusChild *kid;
-    SSISlaveClass *ssc;
+    SSIPeripheralClass *ssc;
     uint32_t r = 0;
 
     QTAILQ_FOREACH(kid, &b->children, sibling) {
-        SSISlave *slave = SSI_SLAVE(kid->child);
-        ssc = SSI_SLAVE_GET_CLASS(slave);
-        r |= ssc->transfer_raw(slave, val);
+        SSIPeripheral *peripheral = SSI_PERIPHERAL(kid->child);
+        ssc = SSI_PERIPHERAL_GET_CLASS(peripheral);
+        r |= ssc->transfer_raw(peripheral, val);
     }
 
     return r;
 }
 
-const VMStateDescription vmstate_ssi_slave = {
+const VMStateDescription vmstate_ssi_peripheral = {
     .name = "SSISlave",
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_BOOL(cs, SSISlave),
+        VMSTATE_BOOL(cs, SSIPeripheral),
         VMSTATE_END_OF_LIST()
     }
 };
 
-static void ssi_slave_register_types(void)
+static void ssi_peripheral_register_types(void)
 {
     type_register_static(&ssi_bus_info);
-    type_register_static(&ssi_slave_info);
+    type_register_static(&ssi_peripheral_info);
 }
 
-type_init(ssi_slave_register_types)
+type_init(ssi_peripheral_register_types)
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index b9371dbf8d7..dd8df9daf43 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -236,7 +236,8 @@ static void xilinx_spips_update_cs(XilinxSPIPS *s, int field)
         if (old_state != new_state) {
             s->cs_lines_state[i] = new_state;
             s->rx_discard = ARRAY_FIELD_EX32(s->regs, CMND, RX_DISCARD);
-            DB_PRINT_L(1, "%sselecting slave %d\n", new_state ? "" : "de", i);
+            DB_PRINT_L(1, "%sselecting peripheral %d\n",
+                       new_state ? "" : "de", i);
         }
         qemu_set_irq(s->cs_lines[i], !new_state);
     }
@@ -1154,7 +1155,7 @@ static void lqspi_load_cache(void *opaque, hwaddr addr)
     int i;
     int flash_addr = ((addr & ~(LQSPI_CACHE_SIZE - 1))
                    / num_effective_busses(s));
-    int slave = flash_addr >> LQSPI_ADDRESS_BITS;
+    int peripheral = flash_addr >> LQSPI_ADDRESS_BITS;
     int cache_entry = 0;
     uint32_t u_page_save = s->regs[R_LQSPI_STS] & ~LQSPI_CFG_U_PAGE;
 
@@ -1162,7 +1163,7 @@ static void lqspi_load_cache(void *opaque, hwaddr addr)
             addr > q->lqspi_cached_addr + LQSPI_CACHE_SIZE - 4) {
         xilinx_qspips_invalidate_mmio_ptr(q);
         s->regs[R_LQSPI_STS] &= ~LQSPI_CFG_U_PAGE;
-        s->regs[R_LQSPI_STS] |= slave ? LQSPI_CFG_U_PAGE : 0;
+        s->regs[R_LQSPI_STS] |= peripheral ? LQSPI_CFG_U_PAGE : 0;
 
         DB_PRINT_L(0, "config reg status: %08x\n", s->regs[R_LQSPI_CFG]);
 
-- 
2.26.2


