Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CEAECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:49:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CD0B20854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bmUGG7cc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD0B20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3Ww-0000uT-Ec
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qj-0005EM-66
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qh-00088I-By
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:33 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36486)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qh-00087x-4T
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:31 -0400
Received: by mail-wm1-x344.google.com with SMTP id m18so17318994wmc.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=lR7JPqBiPFTeth0ID+Afs9r8RzOrtrvYkIMiIfP7pIQ=;
 b=bmUGG7ccvtC3feXcDfDgz9nxeGRlJqdWiO/wpC+244PGrMp3pJRFzFLF7PH2Z6ZjlB
 rmHcICtbImDcepl9RoJ38BGR3ZfgUuMfkE8tiJHFEF6UDO+igo9gLuvyeggS47wcqjFU
 gBs6+ybtU2tWNi/FaUM/yX9CFra46AExPXjLiN2nW+eiESQyx1xLFT5yscgsRpNaAVei
 V89VFHV385/VthtA19L2Xs0/C8u1NpPMfQ/fuSRMyu/6+YR6KctDan2EUqKoqG9FkbIn
 TwbvP/UuwWZjubnxk6wSB4DN37b5MkVGAwguraDqwsj5PAod2bHYHHnrOJGlGFYpPTw7
 9tVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lR7JPqBiPFTeth0ID+Afs9r8RzOrtrvYkIMiIfP7pIQ=;
 b=cory6UmbQdiXZFYuXe1eiTjvNSeUGgjy+HdbIbErUcZ7TfFK2rVvrM8R5t/trvYTpi
 02fQlCEoblKvrc3Sry2/iIERkNe7+FKn/la89ct319PIXsyGlc/L1oXTqYFnY255DsmB
 cwb3MVW0R/sOnKFEW7HZD5VuZOaiQ0Ujh7PB1pTpLChIci8tsNfCudJHJ7pOcbz1U/QB
 LMzAxYCGclKWm44TqFfN6pBTbMcRljX2vE9bReLu2ObxXACy3Q2gLhB2u7AydQl/NGRj
 Gg47AfUN/d9JIJmw7oH81ffzcHzd2zQMLYqxp5D4DZQv9s5gSfFaN8DS78MqDjmDj7lv
 OwlQ==
X-Gm-Message-State: APjAAAWRfWO91k4sV7p1OxJGHrKXW6oC0OWrYsIh4aWrS13ADnqRlnVl
 5phFC9ZsxuzUQ6oY+Co5LcfNDjcrov640A==
X-Google-Smtp-Source: APXvYqz1uHenNnrnUnrZUwmLO3+k4DbszJ2BOEF5c1ritjNSe+RHqXAWgfLu+RddBFAag8BbWUiJEQ==
X-Received: by 2002:a1c:4386:: with SMTP id q128mr16485221wma.39.1571069129756; 
 Mon, 14 Oct 2019 09:05:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 53/68] hw/gpio: Add in AST2600 specific implementation
Date: Mon, 14 Oct 2019 17:03:49 +0100
Message-Id: <20191014160404.19553-54-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

From: Rashmica Gupta <rashmica.g@gmail.com>

The AST2600 has the same sets of 3.6v gpios as the AST2400 plus an
addtional two sets of 1.8V gpios.

Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Acked-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190925143248.10000-15-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/gpio/aspeed_gpio.c | 142 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 137 insertions(+), 5 deletions(-)

diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index 25fbfec3b84..196e47c2628 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -169,6 +169,48 @@
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
@@ -465,6 +507,39 @@ static const AspeedGPIOReg aspeed_3_6v_gpios[GPIO_3_6V_REG_ARRAY_SIZE] = {
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
@@ -663,8 +738,11 @@ static void aspeed_gpio_get_pin(Object *obj, Visitor *v, const char *name,
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
@@ -692,8 +770,11 @@ static void aspeed_gpio_set_pin(Object *obj, Visitor *v, const char *name,
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
@@ -726,6 +807,21 @@ static const GPIOSetProperties ast2500_set_props[] = {
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
@@ -758,7 +854,7 @@ static void aspeed_gpio_realize(DeviceState *dev, Error **errp)
     }
 
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_gpio_ops, s,
-            TYPE_ASPEED_GPIO, GPIO_3_6V_MEM_SIZE);
+            TYPE_ASPEED_GPIO, GPIO_MAX_MEM_SIZE);
 
     sysbus_init_mmio(sbd, &s->iomem);
 }
@@ -851,6 +947,26 @@ static void aspeed_gpio_2500_class_init(ObjectClass *klass, void *data)
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
@@ -874,11 +990,27 @@ static const TypeInfo aspeed_gpio_ast2500_info = {
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


