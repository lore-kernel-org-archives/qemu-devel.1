Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CD4C0650F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 07:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 221462054F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 07:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qu0Cb5x7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221462054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxnWU-00043A-OT
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 03:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rashmica.g@gmail.com>) id 1hxnUq-0002cd-8F
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 03:15:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rashmica.g@gmail.com>) id 1hxnUo-0008H9-Df
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 03:15:00 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:45996)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rashmica.g@gmail.com>)
 id 1hxnUk-0008FF-Iq; Wed, 14 Aug 2019 03:14:54 -0400
Received: by mail-pf1-x429.google.com with SMTP id w26so7776284pfq.12;
 Wed, 14 Aug 2019 00:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Bh8eQxpNoZiUduDL0UBmb8W5cisNmXKeS0bOTxdUx+U=;
 b=Qu0Cb5x7Cbrp7+7ojrRlJi/sbUppt0bQJLi476lT5zZ24igglsWm0+icYtD/FILooq
 5YVY8C6/MjMYlMpnSau4YXIDhBFkY/MFUrDNvrS1a/nZ1wXPzQ8haOcm8jQkSoIvqtKl
 rZaded8O6EHsM74SjbmmdEO9+jpZU5v3t1DBdpqI0+ufrh/nBCxe8dms8mu3W/aTYmSE
 fUrVlPcYkA2sZgx1W5Pw12D4mHFiHZztc7Jn95BPJ26HfORg0qGMFfohvXJttj+0tjsn
 RH63z90IbCfqizv6stNAMWBiTZfowzeszMLIRhRbkZsHAqWPR8fhs8/Ybcq0uN3GammJ
 xnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Bh8eQxpNoZiUduDL0UBmb8W5cisNmXKeS0bOTxdUx+U=;
 b=leweG6C8tBwBKvYQI++BbjZwE4Au9kTjrRkn4hN1XsUKETMYvdfzqKg9pypdhoWGqV
 MmadCpRKPPdK5xbK4PSNNBe6e+Ob4pSKjleyCaMQK9qKMk3oXFMqVrJqkcAKwmh/8jRv
 v4H03lizMMXP+puiqBT27Q1A9pUe5tknSWJSJCx1NnVg+UAOzA765b0BRUNjaMAIkev4
 5luFoAPibCKCrFWs3kKc30nW9cBAsGnpj7tQM70GAjEYXXiYCBLXk10e3IpN1e6TOKRm
 cBsCnBhn5+521e93Aydgr1UoMConAv2+X22DpVsg81Lb81BJ64n7FF6ZuBsWg3spXmdc
 K5TQ==
X-Gm-Message-State: APjAAAWgLajZFU2IkRJfWhO0PRTcFue4sO76ruALqVqaFdlHKVjvuD+I
 y7mNWI3UZRewumE8bymRqpU=
X-Google-Smtp-Source: APXvYqwBThxNIMtEgbr09hdQqAAadyakOcNSfATpY0ssNndT5tNxbydo9oezmcG+mXt81cBY4NV3JA==
X-Received: by 2002:a63:3046:: with SMTP id w67mr38644809pgw.37.1565766893359; 
 Wed, 14 Aug 2019 00:14:53 -0700 (PDT)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id j187sm20086474pfg.178.2019.08.14.00.14.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 14 Aug 2019 00:14:52 -0700 (PDT)
From: Rashmica Gupta <rashmica.g@gmail.com>
To: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Date: Wed, 14 Aug 2019 17:14:33 +1000
Message-Id: <20190814071433.22243-4-rashmica.g@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814071433.22243-1-rashmica.g@gmail.com>
References: <20190814071433.22243-1-rashmica.g@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::429
Subject: [Qemu-devel] [PATCH v4 3/3] hw/gpio: Add in AST2600 specific
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
 hw/gpio/aspeed_gpio.c | 188 ++++++++++++++++++++++++++++++++++++++++--
 slirp                 |   2 +-
 2 files changed, 184 insertions(+), 6 deletions(-)

diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index bd5af81336..f781fbb6dc 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -167,6 +167,49 @@
 #define GPIO_3_6V_MEM_SIZE         0x1F0
 #define GPIO_3_6V_REG_ARRAY_SIZE   (GPIO_3_6V_MEM_SIZE >> 2)
 
+/* AST2600 only - 1.8V gpios */
+/*
+ * The AST2600 has same 3.6V gpios as the AST2400 (memory offsets 0x0-0x198)
+ * and addtional 1.8V gpios (memory offsets 0x800-0x9D4). We create one
+ * GPIOState for the 3.6V gpios mapped at 0x0 and another GPIOState for the
+ * 1.8V gpios mapped at 0x800.
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
+
 static int aspeed_evaluate_irq(GPIOSets *regs, int gpio_prev_high, int gpio)
 {
     uint32_t falling_edge = 0, rising_edge = 0;
@@ -465,6 +508,39 @@ static const AspeedGPIOReg aspeed_3_6v_gpios[GPIO_3_6V_REG_ARRAY_SIZE] = {
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
@@ -660,9 +736,12 @@ static void aspeed_gpio_get_pin(Object *obj, Visitor *v, const char *name,
     int set_idx, group_idx = 0;
 
     if (sscanf(name, "gpio%2[A-Z]%1d", group, &pin) != 2) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: error reading %s\n",
+        /* 1.8V gpio */
+        if (sscanf(name, "gpio%3s%1d", group, &pin) != 2) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: error reading %s\n",
                       __func__, name);
-        return;
+            return;
+        }
     }
     set_idx = get_set_idx(s, group, &group_idx);
     if (set_idx == -1) {
@@ -685,9 +764,12 @@ static void aspeed_gpio_set_pin(Object *obj, Visitor *v, const char *name,
 
     visit_type_bool(v, name, &level, &local_err);
     if (sscanf(name, "gpio%2[A-Z]%1d", group, &pin) != 2) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: error reading %s\n",
+        /* 1.8V gpio */
+        if (sscanf(name, "gpio%3s%1d", group, &pin) != 2) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: error reading %s\n",
                       __func__, name);
-        return;
+            return;
+        }
     }
     set_idx = get_set_idx(s, group, &group_idx);
     if (set_idx == -1) {
@@ -719,6 +801,21 @@ static const GPIOSetProperties ast2500_set_props[] = {
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
@@ -733,6 +830,20 @@ static const AspeedGPIOController aspeed_gpio_ast2500_controller = {
     .gap            = 220,
 };
 
+static const AspeedGPIOController aspeed_gpio_ast2600_3_6v_controller = {
+    .props          = ast2600_3_6v_set_props,
+    .nr_gpio_pins   = 208,
+    .nr_gpio_sets   = 7,
+    .mem_size       = GPIO_3_6V_MEM_SIZE,
+};
+
+static const AspeedGPIOController aspeed_gpio_ast2600_1_8v_controller = {
+    .props          = ast2600_1_8v_set_props,
+    .nr_gpio_pins   = 36,
+    .nr_gpio_sets   = 2,
+    .mem_size       = GPIO_1_8V_MEM_SIZE,
+};
+
 static const MemoryRegionOps aspeed_gpio_ops = {
     .read       = aspeed_gpio_read,
     .write      = aspeed_gpio_write,
@@ -768,7 +879,6 @@ static void aspeed_gpio_realize(DeviceState *dev, Error **errp)
             TYPE_ASPEED_GPIO, GPIO_3_6V_MEM_SIZE);
     s->lookup = aspeed_3_6v_gpios;
 
-
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
@@ -794,6 +904,57 @@ static void aspeed_gpio_init(Object *obj)
     }
 }
 
+static void aspeed_2600_gpio_realize(DeviceState *dev, Error **errp)
+{
+    AspeedGPIOState *s = ASPEED_GPIO(dev);
+    AspeedGPIOState *s_1_8, *s_3_6;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    AspeedGPIOClass *agc, *agc2;
+    int pin;
+    void *obj;
+
+    /* Create and setup the 1.8V gpio state/class */
+    obj = object_new(TYPE_ASPEED_GPIO "-ast2600");
+    s_1_8 = ASPEED_GPIO(obj);
+    object_property_add_child(OBJECT(dev), TYPE_ASPEED_GPIO "-ast2600-1.8v",
+                              obj, errp);
+    if (error_abort) {
+        error_propagate(errp, error_abort);
+    }
+    agc = ASPEED_GPIO_GET_CLASS(s_1_8);
+    agc->ctrl = (void *)&aspeed_gpio_ast2600_1_8v_controller;
+    aspeed_gpio_init(obj);
+
+    /* Create and setup the 3.6V gpio state/class */
+    obj = object_new(TYPE_ASPEED_GPIO "-ast2600");
+    s_3_6 = ASPEED_GPIO(obj);
+    object_property_add_child(OBJECT(dev), TYPE_ASPEED_GPIO "-ast2600-3.6v",
+                              obj, errp);
+    if (error_abort) {
+        error_propagate(errp, error_abort);
+    }
+    agc2 = ASPEED_GPIO_GET_CLASS(s_3_6);
+    agc2->ctrl = (void *)&aspeed_gpio_ast2600_3_6v_controller;
+    aspeed_gpio_init(obj);
+
+    for (pin = 0; pin < agc->ctrl->nr_gpio_pins; pin++) {
+        sysbus_init_irq(sbd, &s->gpios[pin]);
+    }
+
+    memory_region_init_io(&s_3_6->iomem, OBJECT(s_3_6), &aspeed_gpio_ops, s_3_6,
+            TYPE_ASPEED_GPIO, GPIO_3_6V_MEM_SIZE + GPIO_1_8V_MEM_SIZE);
+    s_3_6->lookup = aspeed_3_6v_gpios;
+
+    memory_region_init_io(&s_1_8->iomem, OBJECT(s_1_8), &aspeed_gpio_ops, s_1_8,
+            TYPE_ASPEED_GPIO, GPIO_1_8V_MEM_SIZE);
+    memory_region_add_subregion(&s_3_6->iomem, GPIO_1_8V_REG_OFFSET,
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
@@ -830,6 +991,16 @@ static const VMStateDescription vmstate_aspeed_gpio = {
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
@@ -866,11 +1037,18 @@ static const TypeInfo aspeed_gpio_ast2500_info = {
     .class_data     = (void *)&aspeed_gpio_ast2500_controller,
 };
 
+static const TypeInfo aspeed_gpio_ast2600_info = {
+    .name           = TYPE_ASPEED_GPIO "-ast2600",
+    .parent         = TYPE_ASPEED_GPIO,
+    .class_init     = aspeed_gpio_ast2600_class_init,
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
diff --git a/slirp b/slirp
index f0da672620..126c04acba 160000
--- a/slirp
+++ b/slirp
@@ -1 +1 @@
-Subproject commit f0da6726207b740f6101028b2992f918477a4b08
+Subproject commit 126c04acbabd7ad32c2b018fe10dfac2a3bc1210
-- 
2.20.1


