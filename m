Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298C5C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 08:02:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D98EC2077C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 08:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTIEHpyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98EC2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyXBb-0000BQ-5D
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 04:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rashmica.g@gmail.com>) id 1hyWkC-0007GA-6i
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rashmica.g@gmail.com>) id 1hyWkA-0000cL-Kq
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:33:52 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39309)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rashmica.g@gmail.com>)
 id 1hyWk6-0000WC-Ky; Fri, 16 Aug 2019 03:33:46 -0400
Received: by mail-pg1-x542.google.com with SMTP id u17so2519250pgi.6;
 Fri, 16 Aug 2019 00:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YqZpHm5NeehX+S2H/qilEl8bdvwxq3GaiopzNC2K4vA=;
 b=XTIEHpyTY9ImSiXc5kfUbxdb7ZLN3uU+zvWctEz3deJZzkLt8ocF48gAozo9jSKr5Y
 6obRCpBPzckmf5PHvLuHXIviVmy/FeudxuxDQ3mkFiDFSgUiMY5T4E10LWP1VJDJrkYC
 Cza0owTMWq3buuV32ekcV5SFst/fi+Bp+H3rwujMraa+anZPkA2HBMdLCykefJJr0ise
 Uzx/MZ2gjw1R6JgEvzY9LR20ymZNn3P0mb4P4ghcf3ijGYgqCKpWRYRjjwQ9+nQ+46Jc
 66nD2+4h4kX8w9rRBJ8SjCF1nDyIjH4MSlkM/UZFrmp/lzfml76n9y8Al4FvZNbWxGUL
 KabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YqZpHm5NeehX+S2H/qilEl8bdvwxq3GaiopzNC2K4vA=;
 b=b6JD5G8yZVtK88z5PH4NLasvgx3aoyrMoLA+lZYVzmIwPlpkNBgoovjGOUnWi1nw+D
 t9p1Z5SIRSmD9ki3heTnSv2VFC4U31WAcKP7uQrNdKiX4N7Y6/a8eR15s5QTe6XO67sC
 8zKCOXQd2IFmPI6psKWKSYMaE9luGDD/cbuwUCBg9z9xbT3rpWyYBWBA3uSqfVb7+8EL
 R1A3kK5U8HI8oqUm+idaibwlBDSpy61J2G0k/ZL5ZNra009/wU2LX1bzF9QCxG9EQmTz
 XqOYRj80Q/7cWsye/38M9DgvjqE6kEBx7U2S66hdcYTSF8VXTQxfJdLfdr75B5Fshcrn
 IXZg==
X-Gm-Message-State: APjAAAUNDJORFl0oZju7nyQkDpdW/VHNen2hwkdjHdIevhK/aBKgkGrw
 +xjSLIgQ8BhS96F/GJatuKE=
X-Google-Smtp-Source: APXvYqxdKvPsbtZj0J01FalUDccP1I2mwIZjZw0kpVUHQjIYWTXin0fZMDumnXsER2ztAVUP+tzSbw==
X-Received: by 2002:a62:fb18:: with SMTP id x24mr9195953pfm.231.1565940825637; 
 Fri, 16 Aug 2019 00:33:45 -0700 (PDT)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id w129sm5638589pfd.89.2019.08.16.00.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 00:33:45 -0700 (PDT)
From: Rashmica Gupta <rashmica.g@gmail.com>
To: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Date: Fri, 16 Aug 2019 17:32:29 +1000
Message-Id: <20190816073229.22787-4-rashmica.g@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816073229.22787-1-rashmica.g@gmail.com>
References: <20190816073229.22787-1-rashmica.g@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v5 3/3] hw/gpio: Add in AST2600 specific
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
---
 hw/gpio/aspeed_gpio.c | 142 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 137 insertions(+), 5 deletions(-)

diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index d6a4c0c757..a3306a8f32 100644
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
@@ -461,6 +503,39 @@ static const AspeedGPIOReg aspeed_3_6v_gpios[GPIO_3_6V_REG_ARRAY_SIZE] = {
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
@@ -659,8 +734,11 @@ static void aspeed_gpio_get_pin(Object *obj, Visitor *v, const char *name,
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
@@ -683,8 +761,11 @@ static void aspeed_gpio_set_pin(Object *obj, Visitor *v, const char *name,
 
     visit_type_bool(v, name, &level, &local_err);
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
@@ -716,6 +797,21 @@ static const GPIOSetProperties ast2500_set_props[] = {
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
@@ -748,7 +844,7 @@ static void aspeed_gpio_realize(DeviceState *dev, Error **errp)
     }
 
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_gpio_ops, s,
-            TYPE_ASPEED_GPIO, GPIO_3_6V_MEM_SIZE);
+            TYPE_ASPEED_GPIO, GPIO_MAX_MEM_SIZE);
 
     sysbus_init_mmio(sbd, &s->iomem);
 }
@@ -841,6 +937,26 @@ static void aspeed_gpio_2500_class_init(ObjectClass *klass, void *data)
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
@@ -864,11 +980,27 @@ static const TypeInfo aspeed_gpio_ast2500_info = {
     .instance_init  = aspeed_gpio_init,
 };
 
+static const TypeInfo aspeed_gpio_ast2600_3_6v_info = {
+    .name           = TYPE_ASPEED_GPIO "0-ast2600",
+    .parent         = TYPE_ASPEED_GPIO,
+    .class_init     = aspeed_gpio_ast2600_3_6v_class_init,
+    .instance_init  = aspeed_gpio_init,
+};
+
+static const TypeInfo aspeed_gpio_ast2600_1_8v_info = {
+    .name           = TYPE_ASPEED_GPIO "1-ast2600",
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


