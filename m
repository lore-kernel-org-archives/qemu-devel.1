Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF98FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:37:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F10205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSSNpvet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F10205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEzJ-0007yj-Mx
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkS-0003Tn-7t
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:09 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:38662)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkQ-0005kR-7I
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:07 -0400
Received: by mail-wr1-x42e.google.com with SMTP id e1so4370931wrt.5
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=m1cXMEf819ei0U9NxDaXvIBey1vkQdupb4YJ8Nj4HNU=;
 b=eSSNpvethVRCEgZs+uB9BPymtY73p09YTrQKlPQOMfmXOz18IyTfxTDVHg7Q2yLFHD
 oBThL9DjJMQm+qhXHGVdZ2tW8zMOJ4zVPY31X9wbC1w6lC8JjY0xsjLtg/B3vqYsE+MK
 j45riPNYUZ9LNE3d+Cz55ITZXSOs243bVIOdB7e3YyAmijrS9zJsmkLJYiXecI0uvK6L
 Apmy1pymft2wUeU3J7lc35hvjWF80HbSxYSczD4nxhrC0wN9dm4MV8pGDNPGY6LkXLEN
 lrN+yyd2ijdfFkK4gAamtUKXUUkGoZ9WDexezVW7hWJ9xAdw+9GY8odOAnJ80SXfM9dA
 N22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m1cXMEf819ei0U9NxDaXvIBey1vkQdupb4YJ8Nj4HNU=;
 b=E0/VH0kDzdQR9Pxf8Uf1Z5GqDq6QZeNYF0UBxIyuGA1XVSCX6Pst1qtBX9MwhR3D2m
 W4w3Z7WmCelsXhcxh7wIX/+natw7jme84QGuXbkU8c+XioQUYBPR0TEyK9OgQqkacWpd
 1NMrQABPEFW3KWoNxuACQUcb2C7mg+oeQ3YBwe6ZmJI3z0SVAfe0yb6kYoCJA+L2rw90
 O6t7JRNcBRjX6mO7GsdbfBB0MOiF9GuSLNmORAcPZ2fD5v1wl7teOWwzXrlWUcLQ5Vlm
 8o8zdxzaCKjsacOwmnJUlIx/KrsVagn15bGKX0C3O8X6eYm4LodEF7Eo2f9q9Rx2c56b
 /JEQ==
X-Gm-Message-State: AOAM532PCmh6CegDRPs7dXqwMI4Ox25T0PEvYcXmequidX7sjdoPAxuk
 eqkmhESW3qmTXpy2yuC9gn2uF+wSN01EKQ==
X-Google-Smtp-Source: ABdhPJwwzfCkgNFM8/IMo2RPngAGbfCnphc12XKSfT2gCQK+errDeqMqFX7Zb23O8sQIjzuNAqn/jA==
X-Received: by 2002:a5d:5189:: with SMTP id k9mr5666294wrv.3.1589466124576;
 Thu, 14 May 2020 07:22:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/45] aspeed: Add support for the sonorapass-bmc board
Date: Thu, 14 May 2020 15:21:11 +0100
Message-Id: <20200514142138.20875-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Patrick Williams <patrick@stwcx.xyz>

Sonora Pass is a 2 socket x86 motherboard designed by Facebook
and supported by OpenBMC.  Strapping configuration was obtained
from hardware and i2c configuration is based on dts found at:

https://github.com/facebook/openbmc-linux/blob/1633c87b8ba7c162095787c988979b748ba65dc8/arch/arm/boot/dts/aspeed-bmc-facebook-sonorapass.dts

Booted a test image of http://github.com/facebook/openbmc to login
prompt.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
Reviewed-by: Amithash Prasad <amithash@fb.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
[PMM: fixed block comment style nit]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 1eacb2fc172..4d57d1e4363 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -73,6 +73,21 @@ struct AspeedBoardState {
         SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              \
         SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
 
+/* Sonorapass hardware value: 0xF100D216 */
+#define SONORAPASS_BMC_HW_STRAP1 (                                      \
+        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
+        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
+        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
+        SCU_AST2500_HW_STRAP_RESERVED28 |                               \
+        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
+        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
+        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
+        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER) |                \
+        SCU_AST2500_HW_STRAP_SET_AXI_AHB_RATIO(AXI_AHB_RATIO_2_1) |     \
+        SCU_HW_STRAP_VGA_BIOS_ROM |                                     \
+        SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
+        SCU_AST2500_HW_STRAP_RESERVED1)
+
 /* Swift hardware value: 0xF11AD206 */
 #define SWIFT_BMC_HW_STRAP1 (                                           \
         AST2500_HW_STRAP1_DEFAULTS |                                    \
@@ -437,6 +452,50 @@ static void swift_bmc_i2c_init(AspeedBoardState *bmc)
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 12), "tmp105", 0x4a);
 }
 
+static void sonorapass_bmc_i2c_init(AspeedBoardState *bmc)
+{
+    AspeedSoCState *soc = &bmc->soc;
+
+    /* bus 2 : */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 2), "tmp105", 0x48);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 2), "tmp105", 0x49);
+    /* bus 2 : pca9546 @ 0x73 */
+
+    /* bus 3 : pca9548 @ 0x70 */
+
+    /* bus 4 : */
+    uint8_t *eeprom4_54 = g_malloc0(8 * 1024);
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), 0x54,
+                          eeprom4_54);
+    /* PCA9539 @ 0x76, but PCA9552 is compatible */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "pca9552", 0x76);
+    /* PCA9539 @ 0x77, but PCA9552 is compatible */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "pca9552", 0x77);
+
+    /* bus 6 : */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 6), "tmp105", 0x48);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 6), "tmp105", 0x49);
+    /* bus 6 : pca9546 @ 0x73 */
+
+    /* bus 8 : */
+    uint8_t *eeprom8_56 = g_malloc0(8 * 1024);
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), 0x56,
+                          eeprom8_56);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "pca9552", 0x60);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "pca9552", 0x61);
+    /* bus 8 : adc128d818 @ 0x1d */
+    /* bus 8 : adc128d818 @ 0x1f */
+
+    /*
+     * bus 13 : pca9548 @ 0x71
+     *      - channel 3:
+     *          - tmm421 @ 0x4c
+     *          - tmp421 @ 0x4e
+     *          - tmp421 @ 0x4f
+     */
+
+}
+
 static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
 {
     AspeedSoCState *soc = &bmc->soc;
@@ -549,6 +608,21 @@ static void aspeed_machine_romulus_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size       = 512 * MiB;
 };
 
+static void aspeed_machine_sonorapass_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "OCP SonoraPass BMC (ARM1176)";
+    amc->soc_name  = "ast2500-a1";
+    amc->hw_strap1 = SONORAPASS_BMC_HW_STRAP1;
+    amc->fmc_model = "mx66l1g45g";
+    amc->spi_model = "mx66l1g45g";
+    amc->num_cs    = 2;
+    amc->i2c_init  = sonorapass_bmc_i2c_init;
+    mc->default_ram_size       = 512 * MiB;
+};
+
 static void aspeed_machine_swift_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -628,6 +702,10 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("swift-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_swift_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("sonorapass-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_sonorapass_class_init,
     }, {
         .name          = MACHINE_TYPE_NAME("witherspoon-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
-- 
2.20.1


