Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B064DC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AA12206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCHGeFY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA12206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Shd-0004Ta-8o
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 00:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rashmica.g@gmail.com>) id 1i2Sfu-00031z-A6
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rashmica.g@gmail.com>) id 1i2Sfs-0005DW-6U
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:01:42 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37455)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rashmica.g@gmail.com>)
 id 1i2Sfo-0005Bi-5m; Tue, 27 Aug 2019 00:01:36 -0400
Received: by mail-pf1-x441.google.com with SMTP id y9so12827601pfl.4;
 Mon, 26 Aug 2019 21:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Wx0QXMMVAe/TNPx0w41yI07oDkfJzFDrF94qeXw+obg=;
 b=hCHGeFY7MWncHH2gRt6Rg2fFn9ZrSjyTBbXxVGkJZ7YKqTJMzyWT2bQ92S5VSG9SyG
 We4Cub/P3NHdSpnsDCSzD7uATe2vDS0x6+PEBbdyESUXjJgu7N5p/72tFL7DwlUBZMn0
 58/FsaS2ghA07iscHoxS9F0LlPu5bUdPArmJ+GWDu+cVY+pLeV0tKYm+2iBML76ZTwtU
 QR5yzCeXWsU+U94N3RZBD/2/DT/hJzfR/t2FLb634s48rdAquwsMU7AiROO2bVE8K48X
 ldCh+SMsYdS88vuI5QdB4tajHepHu8kwLOqhCXfW/BVBD3PMaSXmgxkE23f4n+ihviMY
 s7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Wx0QXMMVAe/TNPx0w41yI07oDkfJzFDrF94qeXw+obg=;
 b=t8mgrR+UVbMLO53jZZ4WAMAkp8yvciZiKYgAADr9k2n5MzJYM1OobpDLfQy7OygO0p
 VV7/xkw24iafMOoVgqmFlSQI/JDPrjdFXDD+iuHtsz0yld3/43070CqUHU5t0oVY9BLF
 +Oprw62ydfBHLPxe01otGFDfsdXGxp3xD/2gD7JcVcy6uLfXWx+w22ms47CaAMF22XZH
 PLc+EYSRyu6biudLBt8+O6WXtx5QOV/yE3MHyb8/aUgsJ6Qp5qoKxO9b/XGYtbFVYNl4
 hos5fmTqoajWLMfvPmZbf6T1hELhdh+oNjSonAH3W59iwtiZO1KVusyrPwxtThiqx+ix
 mUJQ==
X-Gm-Message-State: APjAAAUtWjPSN57mlLQgJdHSMCaaBqZAxwqdQyOPbdr8yjWnoyVpyjZ8
 F58wBRgqhacoYE37w9D6ngHTUHhXaUY=
X-Google-Smtp-Source: APXvYqw9a490iYOWvSn5QzIvhN87ZCc0GKvlR/LhwMAWroBYLYgPISYktJa7j2d6Z6ghnmc1ujEEOA==
X-Received: by 2002:a17:90a:fa8f:: with SMTP id
 cu15mr23406385pjb.119.1566878495142; 
 Mon, 26 Aug 2019 21:01:35 -0700 (PDT)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id s11sm12004814pgv.13.2019.08.26.21.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 21:01:34 -0700 (PDT)
From: Rashmica Gupta <rashmica.g@gmail.com>
To: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Date: Tue, 27 Aug 2019 14:01:14 +1000
Message-Id: <20190827040114.23390-4-rashmica.g@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190827040114.23390-1-rashmica.g@gmail.com>
References: <20190827040114.23390-1-rashmica.g@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v6 3/3] hw/gpio: Add in AST2600 specific
 implementation
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
Cc: andrew@aj.id.au, qemu-devel@nongnu.org, aik@ozlabs.ru, joel@jms.id.au,
 Rashmica Gupta <rashmica.g@gmail.com>, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The AST2600 has the same sets of 3.6v gpios as the AST2400 plus an
addtional two sets of 1.8V gpios.

Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/gpio/aspeed_gpio.c | 142 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 137 insertions(+), 5 deletions(-)

diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index d9e92f0a67..dd21065d4e 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -167,6 +167,48 @@
 #define GPIO_3_6V_MEM_SIZE         0x1F0
 #define GPIO_3_6V_REG_ARRAY_SIZE   (GPIO_3_6V_MEM_SIZE >> 2)
 
+/* AST2600 only - 1.8V gpios */
+/*
+ * The AST2600 has same 3.6V gpios as the AST2400 (memory offsets 0x0-0x198)
+ * and addtional 1.8V gpios (memory offsets 0x800-0x9D4).
+ */
+#define GPIO_1_8V_REG_OFFSET          0x800
+#define GPIO_1_8V_ABCD_DATA_VALUE     ((0x800 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_ABCD_DIRECTION      ((0x804 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_ABCD_INT_ENABLE     ((0x808 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_ABCD_INT_SENS_0     ((0x80C - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_ABCD_INT_SENS_1     ((0x810 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_ABCD_INT_SENS_2     ((0x814 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_ABCD_INT_STATUS     ((0x818 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_ABCD_RESET_TOLERANT ((0x81C - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_E_DATA_VALUE        ((0x820 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_E_DIRECTION         ((0x824 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_E_INT_ENABLE        ((0x828 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_E_INT_SENS_0        ((0x82C - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_E_INT_SENS_1        ((0x830 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_E_INT_SENS_2        ((0x834 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_E_INT_STATUS        ((0x838 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_E_RESET_TOLERANT    ((0x83C - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_ABCD_DEBOUNCE_1     ((0x840 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_ABCD_DEBOUNCE_2     ((0x844 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_E_DEBOUNCE_1        ((0x848 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_E_DEBOUNCE_2        ((0x84C - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_DEBOUNCE_TIME_1     ((0x850 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_DEBOUNCE_TIME_2     ((0x854 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_DEBOUNCE_TIME_3     ((0x858 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_ABCD_COMMAND_SRC_0  ((0x860 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_ABCD_COMMAND_SRC_1  ((0x864 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_E_COMMAND_SRC_0     ((0x868 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_E_COMMAND_SRC_1     ((0x86C - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_ABCD_DATA_READ      ((0x8C0 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_E_DATA_READ         ((0x8C4 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_ABCD_INPUT_MASK     ((0x9D0 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_E_INPUT_MASK        ((0x9D4 - GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_1_8V_MEM_SIZE            0x9D8
+#define GPIO_1_8V_REG_ARRAY_SIZE      ((GPIO_1_8V_MEM_SIZE - \
+                                      GPIO_1_8V_REG_OFFSET) >> 2)
+#define GPIO_MAX_MEM_SIZE           MAX(GPIO_3_6V_MEM_SIZE, GPIO_1_8V_MEM_SIZE)
+
 static int aspeed_evaluate_irq(GPIOSets *regs, int gpio_prev_high, int gpio)
 {
     uint32_t falling_edge = 0, rising_edge = 0;
@@ -463,6 +505,39 @@ static const AspeedGPIOReg aspeed_3_6v_gpios[GPIO_3_6V_REG_ARRAY_SIZE] = {
     [GPIO_AC_INPUT_MASK] =         { 7, gpio_reg_input_mask },
 };
 
+static const AspeedGPIOReg aspeed_1_8v_gpios[GPIO_1_8V_REG_ARRAY_SIZE] = {
+    /* 1.8V Set ABCD */
+    [GPIO_1_8V_ABCD_DATA_VALUE] =     {0, gpio_reg_data_value},
+    [GPIO_1_8V_ABCD_DIRECTION] =      {0, gpio_reg_direction},
+    [GPIO_1_8V_ABCD_INT_ENABLE] =     {0, gpio_reg_int_enable},
+    [GPIO_1_8V_ABCD_INT_SENS_0] =     {0, gpio_reg_int_sens_0},
+    [GPIO_1_8V_ABCD_INT_SENS_1] =     {0, gpio_reg_int_sens_1},
+    [GPIO_1_8V_ABCD_INT_SENS_2] =     {0, gpio_reg_int_sens_2},
+    [GPIO_1_8V_ABCD_INT_STATUS] =     {0, gpio_reg_int_status},
+    [GPIO_1_8V_ABCD_RESET_TOLERANT] = {0, gpio_reg_reset_tolerant},
+    [GPIO_1_8V_ABCD_DEBOUNCE_1] =     {0, gpio_reg_debounce_1},
+    [GPIO_1_8V_ABCD_DEBOUNCE_2] =     {0, gpio_reg_debounce_2},
+    [GPIO_1_8V_ABCD_COMMAND_SRC_0] =  {0, gpio_reg_cmd_source_0},
+    [GPIO_1_8V_ABCD_COMMAND_SRC_1] =  {0, gpio_reg_cmd_source_1},
+    [GPIO_1_8V_ABCD_DATA_READ] =      {0, gpio_reg_data_read},
+    [GPIO_1_8V_ABCD_INPUT_MASK] =     {0, gpio_reg_input_mask},
+    /* 1.8V Set E */
+    [GPIO_1_8V_E_DATA_VALUE] =     {1, gpio_reg_data_value},
+    [GPIO_1_8V_E_DIRECTION] =      {1, gpio_reg_direction},
+    [GPIO_1_8V_E_INT_ENABLE] =     {1, gpio_reg_int_enable},
+    [GPIO_1_8V_E_INT_SENS_0] =     {1, gpio_reg_int_sens_0},
+    [GPIO_1_8V_E_INT_SENS_1] =     {1, gpio_reg_int_sens_1},
+    [GPIO_1_8V_E_INT_SENS_2] =     {1, gpio_reg_int_sens_2},
+    [GPIO_1_8V_E_INT_STATUS] =     {1, gpio_reg_int_status},
+    [GPIO_1_8V_E_RESET_TOLERANT] = {1, gpio_reg_reset_tolerant},
+    [GPIO_1_8V_E_DEBOUNCE_1] =     {1, gpio_reg_debounce_1},
+    [GPIO_1_8V_E_DEBOUNCE_2] =     {1, gpio_reg_debounce_2},
+    [GPIO_1_8V_E_COMMAND_SRC_0] =  {1, gpio_reg_cmd_source_0},
+    [GPIO_1_8V_E_COMMAND_SRC_1] =  {1, gpio_reg_cmd_source_1},
+    [GPIO_1_8V_E_DATA_READ] =      {1, gpio_reg_data_read},
+    [GPIO_1_8V_E_INPUT_MASK] =     {1, gpio_reg_input_mask},
+};
+
 static uint64_t aspeed_gpio_read(void *opaque, hwaddr offset, uint32_t size)
 {
     AspeedGPIOState *s = ASPEED_GPIO(opaque);
@@ -661,8 +736,11 @@ static void aspeed_gpio_get_pin(Object *obj, Visitor *v, const char *name,
     int set_idx, group_idx = 0;
 
     if (sscanf(name, "gpio%2[A-Z]%1d", group, &pin) != 2) {
-        error_setg(errp, "%s: error reading %s", __func__, name);
-        return;
+        /* 1.8V gpio */
+        if (sscanf(name, "gpio%3s%1d", group, &pin) != 2) {
+            error_setg(errp, "%s: error reading %s", __func__, name);
+            return;
+        }
     }
     set_idx = get_set_idx(s, group, &group_idx);
     if (set_idx == -1) {
@@ -690,8 +768,11 @@ static void aspeed_gpio_set_pin(Object *obj, Visitor *v, const char *name,
         return;
     }
     if (sscanf(name, "gpio%2[A-Z]%1d", group, &pin) != 2) {
-        error_setg(errp, "%s: error reading %s", __func__, name);
-        return;
+        /* 1.8V gpio */
+        if (sscanf(name, "gpio%3s%1d", group, &pin) != 2) {
+            error_setg(errp, "%s: error reading %s", __func__, name);
+            return;
+        }
     }
     set_idx = get_set_idx(s, group, &group_idx);
     if (set_idx == -1) {
@@ -724,6 +805,21 @@ static const GPIOSetProperties ast2500_set_props[] = {
     [7] = {0x000000ff,  0x000000ff,  {"AC"} },
 };
 
+static GPIOSetProperties ast2600_3_6v_set_props[] = {
+    [0] = {0xffffffff,  0xffffffff,  {"A", "B", "C", "D"} },
+    [1] = {0xffffffff,  0xffffffff,  {"E", "F", "G", "H"} },
+    [2] = {0xffffffff,  0xffffffff,  {"I", "J", "K", "L"} },
+    [3] = {0xffffffff,  0xffffffff,  {"M", "N", "O", "P"} },
+    [4] = {0xffffffff,  0xffffffff,  {"Q", "R", "S", "T"} },
+    [5] = {0xffffffff,  0x0000ffff,  {"U", "V", "W", "X"} },
+    [6] = {0xffff0000,  0x0fff0000,  {"Y", "Z", "", ""} },
+};
+
+static GPIOSetProperties ast2600_1_8v_set_props[] = {
+    [0] = {0xffffffff,  0xffffffff,  {"18A", "18B", "18C", "18D"} },
+    [1] = {0x0000000f,  0x0000000f,  {"18E"} },
+};
+
 static const MemoryRegionOps aspeed_gpio_ops = {
     .read       = aspeed_gpio_read,
     .write      = aspeed_gpio_write,
@@ -756,7 +852,7 @@ static void aspeed_gpio_realize(DeviceState *dev, Error **errp)
     }
 
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_gpio_ops, s,
-            TYPE_ASPEED_GPIO, GPIO_3_6V_MEM_SIZE);
+            TYPE_ASPEED_GPIO, GPIO_MAX_MEM_SIZE);
 
     sysbus_init_mmio(sbd, &s->iomem);
 }
@@ -849,6 +945,26 @@ static void aspeed_gpio_2500_class_init(ObjectClass *klass, void *data)
     agc->reg_table = aspeed_3_6v_gpios;
 }
 
+static void aspeed_gpio_ast2600_3_6v_class_init(ObjectClass *klass, void *data)
+{
+    AspeedGPIOClass *agc = ASPEED_GPIO_CLASS(klass);
+
+    agc->props = ast2600_3_6v_set_props;
+    agc->nr_gpio_pins = 208;
+    agc->nr_gpio_sets = 7;
+    agc->reg_table = aspeed_3_6v_gpios;
+}
+
+static void aspeed_gpio_ast2600_1_8v_class_init(ObjectClass *klass, void *data)
+{
+    AspeedGPIOClass *agc = ASPEED_GPIO_CLASS(klass);
+
+    agc->props = ast2600_1_8v_set_props;
+    agc->nr_gpio_pins = 36;
+    agc->nr_gpio_sets = 2;
+    agc->reg_table = aspeed_1_8v_gpios;
+}
+
 static const TypeInfo aspeed_gpio_info = {
     .name           = TYPE_ASPEED_GPIO,
     .parent         = TYPE_SYS_BUS_DEVICE,
@@ -872,11 +988,27 @@ static const TypeInfo aspeed_gpio_ast2500_info = {
     .instance_init  = aspeed_gpio_init,
 };
 
+static const TypeInfo aspeed_gpio_ast2600_3_6v_info = {
+    .name           = TYPE_ASPEED_GPIO "-ast2600",
+    .parent         = TYPE_ASPEED_GPIO,
+    .class_init     = aspeed_gpio_ast2600_3_6v_class_init,
+    .instance_init  = aspeed_gpio_init,
+};
+
+static const TypeInfo aspeed_gpio_ast2600_1_8v_info = {
+    .name           = TYPE_ASPEED_GPIO "-ast2600-1_8v",
+    .parent         = TYPE_ASPEED_GPIO,
+    .class_init     = aspeed_gpio_ast2600_1_8v_class_init,
+    .instance_init  = aspeed_gpio_init,
+};
+
 static void aspeed_gpio_register_types(void)
 {
     type_register_static(&aspeed_gpio_info);
     type_register_static(&aspeed_gpio_ast2400_info);
     type_register_static(&aspeed_gpio_ast2500_info);
+    type_register_static(&aspeed_gpio_ast2600_3_6v_info);
+    type_register_static(&aspeed_gpio_ast2600_1_8v_info);
 }
 
 type_init(aspeed_gpio_register_types);
-- 
2.20.1


