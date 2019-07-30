Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368AAC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 05:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31C5206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 05:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOjecBzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31C5206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsKym-00053D-3l
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 01:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49414)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rashmica.g@gmail.com>) id 1hsKwy-0002Sf-Vm
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 01:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rashmica.g@gmail.com>) id 1hsKwx-0002rm-70
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 01:45:28 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:33911)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rashmica.g@gmail.com>)
 id 1hsKws-0002n1-Qq; Tue, 30 Jul 2019 01:45:23 -0400
Received: by mail-pf1-x433.google.com with SMTP id b13so29224989pfo.1;
 Mon, 29 Jul 2019 22:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XverFlvYxr3IsQy473xjSLe3NWmMvpOpPl7CUCDD0kQ=;
 b=dOjecBzFse8eT6cD2GueEbUeZKh+lamaLYsmyhT5PdH7o7osls59Mdm6jCkb01lCey
 Tatb0u8E7qiNH7XOcBDt2HVB2H10F27Nze06IQMr5+iEUIX1EiW33K7veWHshOUaatX0
 C984PUujVWqvvMUkxWvaaXq5LtaMoRBqrE3kkgvQbW63TuR1P5EkYle08uYPHukY5+lL
 LNb6NggwwjaEfjiONmW1hCmXNZ3jNDNotvujsqiFYpZK7LuHaXjFPAFPyIsl0DS/epbp
 aaVqtB8xo4pSFW2ZMlcWfOLTPzNcGP+XezIznoN5+YUB7jrdLJ9S+vWerPb6NAddJUo0
 xx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XverFlvYxr3IsQy473xjSLe3NWmMvpOpPl7CUCDD0kQ=;
 b=GCyxKMvqZD3gjTN+FPUj8685MuDt+8aU6t3diGupr3WrYuyaArLZJsLPVJJptY3CG3
 YDnb2DrO6RhXr7+TZafQ718QIGUM59JByMvr7BEEenArpryjhzWW7H2YyjeJoVb277gZ
 HvMU0gUqjVy+N6+Lj6O44czOL5OG6HY8QjxE+aSMSEsUgGtgSbc/XRp2bOim5MbJPLVL
 okHjn33XP3RzOLbRaTASPRa/kNfqZHb0YVW+NlCa3pZt6U0F2yDm4N0f7N3RAOQ6Hv2I
 nrs0ukJc3VOsQuyZhqAoe3PVUU/oD94UmSAK68i9otZUbIonR6rlXivP47C13eL9DQeO
 +G5w==
X-Gm-Message-State: APjAAAXV522BHR7yarhcJAXUvzuEItTo5E7nC8OaIy17GUdB4x8qMKFE
 pmKVKhxQzwfI+8yL/k+eKPo=
X-Google-Smtp-Source: APXvYqx8l43NlEgXYIH0lWNCaAih0jjDDK/8O6GX7yjmn/G2XoMtaBzitY3BCijqH9f64y6N/wbApg==
X-Received: by 2002:a63:101b:: with SMTP id
 f27mr103476655pgl.291.1564465521784; 
 Mon, 29 Jul 2019 22:45:21 -0700 (PDT)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id 81sm99171221pfx.111.2019.07.29.22.45.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 22:45:21 -0700 (PDT)
From: Rashmica Gupta <rashmica.g@gmail.com>
To: peter.maydell@linaro.org
Date: Tue, 30 Jul 2019 15:45:01 +1000
Message-Id: <20190730054501.32727-4-rashmica.g@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190730054501.32727-1-rashmica.g@gmail.com>
References: <20190730054501.32727-1-rashmica.g@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::433
Subject: [Qemu-devel] [PATCH v3 3/3] hw/gpio: Add in AST2600 specific
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
Cc: andrew@aj.id.au, qemu-devel@nongnu.org, qemu-arm@nongnu.org, joel@jms.id.au,
 Rashmica Gupta <rashmica.g@gmail.com>, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The AST2600 has the same sets of 3.6v gpios as the AST2400 plus an
addtional two sets of 1.8V gpios.

Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
---
 hw/gpio/aspeed_gpio.c         | 186 +++++++++++++++++++++++++++++++++-
 include/hw/gpio/aspeed_gpio.h |   2 +-
 2 files changed, 184 insertions(+), 4 deletions(-)

diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index 4f1546a900..a94b5f2780 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -16,6 +16,7 @@
 #define GPIOS_PER_REG 32
 #define GPIOS_PER_SET GPIOS_PER_REG
 #define GPIO_3_6V_REG_ARRAY_SIZE  (0x1f0 >> 2)
+#define GPIO_1_8V_REG_ARRAY_SIZE  ((0x9d8 - 0x800) >> 2)
 #define GPIO_PIN_GAP_SIZE 4
 #define GPIOS_PER_GROUP 8
 #define GPIO_GROUP_SHIFT 3
@@ -145,6 +146,7 @@
 #define GPIO_YZAAAB_DEBOUNCE_1     (0x190 >> 2)
 #define GPIO_YZAAAB_DEBOUNCE_2     (0x194 >> 2)
 #define GPIO_YZAAAB_INPUT_MASK     (0x198 >> 2)
+/* AST2500 only */
 #define GPIO_AC_COMMAND_SRC_0      (0x1A0 >> 2)
 #define GPIO_AC_COMMAND_SRC_1      (0x1A4 >> 2)
 #define GPIO_AC_INT_ENABLE         (0x1A8 >> 2)
@@ -163,6 +165,47 @@
 #define GPIO_AC_DATA_VALUE         (0x1E8 >> 2)
 #define GPIO_AC_DIRECTION          (0x1EC >> 2)
 
+
+/* AST2600 only - 1.8V gpios */
+/*
+ * The AST2600 has same 3.6V gpios as the AST2400 (memory offsets 0x0-0x198)
+ * and addtional 1.8V gpios (memory offsets 0x800-0x9D4). We create one
+ * GPIOState for the 3.6V gpios mapped at 0x0 and another GPIOState for the
+ * 1.8V gpios mapped at 0x800.
+ */
+#define GPIO_1_8_REG_OFFSET          0x800
+#define GPIO_1_8_ABCD_DATA_VALUE     ((0x800 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_ABCD_DIRECTION      ((0x804 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_ABCD_INT_ENABLE     ((0x808 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_ABCD_INT_SENS_0     ((0x80C - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_ABCD_INT_SENS_1     ((0x810 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_ABCD_INT_SENS_2     ((0x814 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_ABCD_INT_STATUS     ((0x818 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_ABCD_RESET_TOLERANT ((0x81C - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_E_DATA_VALUE        ((0x820 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_E_DIRECTION         ((0x824 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_E_INT_ENABLE        ((0x828 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_E_INT_SENS_0        ((0x82C - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_E_INT_SENS_1        ((0x830 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_E_INT_SENS_2        ((0x834 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_E_INT_STATUS        ((0x838 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_E_RESET_TOLERANT    ((0x83C - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_ABCD_DEBOUNCE_1     ((0x840 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_ABCD_DEBOUNCE_2     ((0x844 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_E_DEBOUNCE_1        ((0x848 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_E_DEBOUNCE_2        ((0x84C - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_DEBOUNCE_TIME_1     ((0x850 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_DEBOUNCE_TIME_2     ((0x854 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_DEBOUNCE_TIME_3     ((0x858 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_ABCD_COMMAND_SRC_0  ((0x860 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_ABCD_COMMAND_SRC_1  ((0x864 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_E_COMMAND_SRC_0     ((0x868 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_E_COMMAND_SRC_1     ((0x86C - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_ABCD_DATA_READ      ((0x8C0 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_E_DATA_READ         ((0x8C4 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_ABCD_INPUT_MASK     ((0x9D0 - GPIO_1_8_REG_OFFSET) >> 2)
+#define GPIO_1_8_E_INPUT_MASK        ((0x9D4 - GPIO_1_8_REG_OFFSET) >> 2)
+
 static int aspeed_evaluate_irq(GPIOSets *regs, int gpio_prev_high, int gpio)
 {
     uint32_t falling_edge = 0, rising_edge = 0;
@@ -626,6 +669,39 @@ static const AspeedGPIOReg aspeed_3_6v_gpios[GPIO_3_6V_REG_ARRAY_SIZE] = {
     [GPIO_AC_INPUT_MASK] =         {7, read_input_mask, write_input_mask},
 };
 
+static const AspeedGPIOReg aspeed_1_8v_gpios[GPIO_1_8V_REG_ARRAY_SIZE] = {
+    /* 1.8V Set ABCD */
+    [GPIO_1_8_ABCD_DATA_VALUE] =     {0, read_data_value, write_data_value},
+    [GPIO_1_8_ABCD_DIRECTION] =      {0, read_direction, write_direction},
+    [GPIO_1_8_ABCD_INT_ENABLE] =     {0, read_int_enable, write_int_enable},
+    [GPIO_1_8_ABCD_INT_SENS_0] =     {0, read_int_sens_0, write_int_sens_0},
+    [GPIO_1_8_ABCD_INT_SENS_1] =     {0, read_int_sens_1, write_int_sens_1},
+    [GPIO_1_8_ABCD_INT_SENS_2] =     {0, read_int_sens_2, write_int_sens_2},
+    [GPIO_1_8_ABCD_INT_STATUS] =     {0, read_int_status, write_int_status},
+    [GPIO_1_8_ABCD_RESET_TOLERANT] = {0, read_reset_tol, write_reset_tol},
+    [GPIO_1_8_ABCD_DEBOUNCE_1] =     {0, read_debounce_1, write_debounce_1},
+    [GPIO_1_8_ABCD_DEBOUNCE_2] =     {0, read_debounce_2, write_debounce_2},
+    [GPIO_1_8_ABCD_COMMAND_SRC_0] =  {0, read_cmd_source_0, write_cmd_source_0},
+    [GPIO_1_8_ABCD_COMMAND_SRC_1] =  {0, read_cmd_source_1, write_cmd_source_1},
+    [GPIO_1_8_ABCD_DATA_READ] =      {0, read_data, NULL},
+    [GPIO_1_8_ABCD_INPUT_MASK] =     {0, read_input_mask, write_input_mask},
+    /* 1.8V Set E */
+    [GPIO_1_8_E_DATA_VALUE] =     {1, read_data_value, write_data_value},
+    [GPIO_1_8_E_DIRECTION] =      {1, read_direction, write_direction },
+    [GPIO_1_8_E_INT_ENABLE] =     {1, read_int_enable, write_int_enable},
+    [GPIO_1_8_E_INT_SENS_0] =     {1, read_int_sens_0, write_int_sens_0},
+    [GPIO_1_8_E_INT_SENS_1] =     {1, read_int_sens_1, write_int_sens_1},
+    [GPIO_1_8_E_INT_SENS_2] =     {1, read_int_sens_2, write_int_sens_2},
+    [GPIO_1_8_E_INT_STATUS] =     {1, read_int_status, write_int_status},
+    [GPIO_1_8_E_RESET_TOLERANT] = {1, read_reset_tol,   write_reset_tol},
+    [GPIO_1_8_E_DEBOUNCE_1] =     {1, read_debounce_1,  write_debounce_1},
+    [GPIO_1_8_E_DEBOUNCE_2] =     {1, read_debounce_2,  write_debounce_2},
+    [GPIO_1_8_E_COMMAND_SRC_0] =  {1, read_cmd_source_0,  write_cmd_source_0},
+    [GPIO_1_8_E_COMMAND_SRC_1] =  {1, read_cmd_source_1,  write_cmd_source_1},
+    [GPIO_1_8_E_DATA_READ] =      {1, read_data, NULL},
+    [GPIO_1_8_E_INPUT_MASK] =     {1, read_input_mask,  write_input_mask},
+};
+
 static uint64_t aspeed_gpio_read(void *opaque, hwaddr offset, uint32_t size)
 {
     AspeedGPIOState *s = ASPEED_GPIO(opaque);
@@ -708,9 +784,12 @@ static void aspeed_gpio_get_pin(Object *obj, Visitor *v, const char *name,
     int set_idx, group_idx = 0;
 
     if (sscanf(name, "gpio%2[A-Z]%1d", group, &pin) != 2) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: error reading %s\n",
+        /* 1.8V gpio */
+        if (sscanf(name, "gpio%3s%1d", group, &pin) != 2) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: error reading %s\n",
                       __func__, name);
         return;
+        }
     }
     set_idx = get_set_idx(s, group, &group_idx);
     if (set_idx == -1) {
@@ -733,9 +812,12 @@ static void aspeed_gpio_set_pin(Object *obj, Visitor *v, const char *name,
 
     visit_type_bool(v, name, &level, &local_err);
     if (sscanf(name, "gpio%2[A-Z]%1d", group, &pin) != 2) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: error reading %s\n",
+        /* 1.8V gpio */
+        if (sscanf(name, "gpio%3s%1d", group, &pin) != 2) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: error reading %s\n",
                       __func__, name);
         return;
+        }
     }
     set_idx = get_set_idx(s, group, &group_idx);
     if (set_idx == -1) {
@@ -769,6 +851,21 @@ static const GPIOSetProperties ast2500_set_props[] = {
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
 static const AspeedGPIOController aspeed_gpio_ast2400_controller = {
     .props          = ast2400_set_props,
     .nr_gpio_pins   = 216,
@@ -784,6 +881,21 @@ static const AspeedGPIOController aspeed_gpio_ast2500_controller = {
     .gap            = 220,
     .mem_size       = 0x1f0,
 };
+
+static const AspeedGPIOController aspeed_gpio_ast2600_3_6v_controller = {
+    .props          = ast2600_3_6v_set_props,
+    .nr_gpio_pins   = 208,
+    .nr_gpio_sets   = 7,
+    .mem_size       = 0x1000,
+};
+
+static const AspeedGPIOController aspeed_gpio_ast2600_1_8v_controller = {
+    .props          = ast2600_1_8v_set_props,
+    .nr_gpio_pins   = 36,
+    .nr_gpio_sets   = 2,
+    .mem_size       = 0x1d8,
+};
+
 static const MemoryRegionOps aspeed_gpio_ops = {
     .read = aspeed_gpio_read,
     .write = aspeed_gpio_write,
@@ -815,7 +927,6 @@ static void aspeed_gpio_realize(DeviceState *dev, Error **errp)
             TYPE_ASPEED_GPIO, agc->ctrl->mem_size);
     s->lookup = aspeed_3_6v_gpios;
 
-
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
@@ -841,6 +952,58 @@ static void aspeed_gpio_init(Object *obj)
     }
 }
 
+static void aspeed_2600_gpio_realize(DeviceState *dev, Error **errp)
+{
+    AspeedGPIOState *s = ASPEED_GPIO(dev);
+    AspeedGPIOState *s_1_8, *s_3_6;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    int pin;
+    void *obj;
+
+    /* Create and setup the 1.8V gpio state/class */
+    obj = object_new(TYPE_ASPEED_GPIO "-ast2600");
+    s_1_8 = ASPEED_GPIO(obj);
+    object_property_add_child(OBJECT(dev), TYPE_ASPEED_GPIO "-ast2600-1.8v",
+                              obj, &error_abort);
+    if (error_abort) {
+        error_propagate(errp, error_abort);
+    }
+    AspeedGPIOClass *agc = ASPEED_GPIO_GET_CLASS(s_1_8);
+    agc->ctrl = (void *)&aspeed_gpio_ast2600_1_8v_controller;
+    aspeed_gpio_init(obj);
+
+    /* Create and setup the 3.6V gpio state/class */
+    obj = object_new(TYPE_ASPEED_GPIO "-ast2600");
+    s_3_6 = ASPEED_GPIO(obj);
+    object_property_add_child(OBJECT(dev), TYPE_ASPEED_GPIO "-ast2600-3.6v",
+                              obj, &error_abort);
+    if (error_abort) {
+        error_propagate(errp, error_abort);
+    }
+    AspeedGPIOClass *agc2 = ASPEED_GPIO_GET_CLASS(s_3_6);
+    agc2->ctrl = (void *)&aspeed_gpio_ast2600_3_6v_controller;
+    aspeed_gpio_init(obj);
+
+
+    for (pin = 0; pin < agc->ctrl->nr_gpio_pins; pin++) {
+        sysbus_init_irq(sbd, &s->irq[pin]);
+    }
+
+    memory_region_init_io(&s_3_6->iomem, OBJECT(s_3_6), &aspeed_gpio_ops, s_3_6,
+            TYPE_ASPEED_GPIO, agc->ctrl->mem_size);
+    s_3_6->lookup = aspeed_3_6v_gpios;
+
+
+    memory_region_init_io(&s_1_8->iomem, OBJECT(s_1_8), &aspeed_gpio_ops, s_1_8,
+            TYPE_ASPEED_GPIO, agc->ctrl->mem_size);
+    memory_region_add_subregion(&s_3_6->iomem, GPIO_1_8_REG_OFFSET,
+                                &s_1_8->iomem);
+    s_1_8->lookup = aspeed_1_8v_gpios;
+
+    sysbus_init_mmio(sbd, &s_3_6->iomem);
+    sysbus_init_mmio(sbd, &s_1_8->iomem);
+}
+
 static const VMStateDescription vmstate_gpio_regs = {
     .name = TYPE_ASPEED_GPIO"/regs",
     .version_id = 1,
@@ -877,6 +1040,16 @@ static const VMStateDescription vmstate_aspeed_gpio = {
    }
 };
 
+static void aspeed_gpio_ast2600_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = aspeed_2600_gpio_realize;
+    dc->reset = aspeed_gpio_reset;
+    dc->desc = "Aspeed GPIO Controller";
+    dc->vmsd = &vmstate_aspeed_gpio;
+}
+
 static void aspeed_gpio_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -913,11 +1086,18 @@ static const TypeInfo aspeed_gpio_ast2500_info = {
     .class_data = (void *)&aspeed_gpio_ast2500_controller,
 };
 
+static const TypeInfo aspeed_gpio_ast2600_info = {
+    .name =  TYPE_ASPEED_GPIO "-ast2600",
+    .parent = TYPE_ASPEED_GPIO,
+    .class_init = aspeed_gpio_ast2600_class_init,
+};
+
 static void aspeed_gpio_register_types(void)
 {
     type_register_static(&aspeed_gpio_info);
     type_register_static(&aspeed_gpio_ast2400_info);
     type_register_static(&aspeed_gpio_ast2500_info);
+    type_register_static(&aspeed_gpio_ast2600_info);
 }
 
 type_init(aspeed_gpio_register_types);
diff --git a/include/hw/gpio/aspeed_gpio.h b/include/hw/gpio/aspeed_gpio.h
index bef1d37c78..cf751c6af2 100644
--- a/include/hw/gpio/aspeed_gpio.h
+++ b/include/hw/gpio/aspeed_gpio.h
@@ -25,7 +25,7 @@
 #define ASPEED_GPIO_NR_PINS 228
 #define ASPEED_GROUPS_PER_SET 4
 #define ASPEED_GPIO_NR_DEBOUNCE_REGS 3
-#define ASPEED_CHARS_PER_GROUP_LABEL 3
+#define ASPEED_CHARS_PER_GROUP_LABEL 4
 
 typedef struct GPIOSets GPIOSets;
 typedef struct AspeedGPIOState AspeedGPIOState;
-- 
2.20.1


