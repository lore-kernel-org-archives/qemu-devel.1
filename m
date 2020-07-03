Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578ABC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34E820760
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gcbwqikr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34E820760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrPBs-0003yz-3q
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxK-00055r-E7
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:30 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:38709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxI-0005hD-4l
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:30 -0400
Received: by mail-wm1-x330.google.com with SMTP id f18so34754892wml.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=kzUM2VqizH8esaQXOC5IzGhh1jcxpGV+zhaMyuOh1A4=;
 b=Gcbwqikrja3epDbqpV+9oyEjl1lpXcMwfKgNAsE8MF78I6vZMdTDP+jVSwpeySoFtQ
 xLp3jwezI4wyw0QxUqc5aQTBQkbvIQG95gvqzFQxBYjYldMX59Y36ZIIgJ2KKc4QbM/3
 zomXN7VKD9aNBqa7FrJ7elf4a/Dv5plly61Rn/TjOGBLMar6sGADPklwNPLqTPsO1ocK
 r4F4sbtF7VHPWZ8DZ25cctcKMffrmqubcC96z7q0+Td295D3RWBSA6OLjsUEdtZwRWAc
 8vTtOvWiAit88yhRJDeWVj0TZH7mXfnNA2jcz9mZIVApSs/NPFyx8l6kSBWb340b6E8g
 64Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kzUM2VqizH8esaQXOC5IzGhh1jcxpGV+zhaMyuOh1A4=;
 b=WifJxp9vib/y6pn4V0qNaQbs/UhIOOsoFOoDR7o/9xJ8vpDI+kpbMwlSp+8ELdqYdM
 tAtOKNq4ywonUjRN1itlJ7lM5LOl7NvCtsobqyXeWX6BDBDyqz14ezKo+i6HJ8G6yRUL
 ynSaQhkutVqee6++on7qUz0T7TZOpgY3tc7gNlo91erhzkHaGGhizqJxYVLl4gtIVMuc
 JyAQjDdi12rIb96Kur4WR7tGNO7JAwORXWprcH1e4bRDCAF5RuFuFwaE/zaKAwR60CaU
 XzNsT8N24eZrH8EcbLijIQff8yc1aNP+1awKyC2/FdZVliJc9OHS1ElwbDIL7wHK8qC+
 WrJw==
X-Gm-Message-State: AOAM533q6qj6vtuw7bKzmkcCjE4L3fgzaReBSd8R/+69z/COx6xFvPq1
 W9MJY6gwjid207tJS6rDXb2ClAv9pxXFGA==
X-Google-Smtp-Source: ABdhPJxa+Z8b63/XzHk7FACxbUQnFMLMu+S9J3rgtaGMOGDYO9V1jqWpLsI9n/ep0TIRMFEUfx+UkA==
X-Received: by 2002:a1c:cc07:: with SMTP id h7mr37383820wmb.179.1593795266202; 
 Fri, 03 Jul 2020 09:54:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/34] hw/arm/spitz: Detabify
Date: Fri,  3 Jul 2020 17:53:48 +0100
Message-Id: <20200703165405.17672-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

The spitz board has been around a long time, and still has a fair number
of hard-coded tab characters in it. We're about to do some work on
this source file, so start out by expanding out the tabs.

This commit is a pure whitespace only change.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200628142429.17111-2-peter.maydell@linaro.org
---
 hw/arm/spitz.c | 156 ++++++++++++++++++++++++-------------------------
 1 file changed, 78 insertions(+), 78 deletions(-)

diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index fc18212e686..9eaedab79b5 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -34,25 +34,25 @@
 #include "cpu.h"
 
 #undef REG_FMT
-#define REG_FMT			"0x%02lx"
+#define REG_FMT                         "0x%02lx"
 
 /* Spitz Flash */
-#define FLASH_BASE		0x0c000000
-#define FLASH_ECCLPLB		0x00	/* Line parity 7 - 0 bit */
-#define FLASH_ECCLPUB		0x04	/* Line parity 15 - 8 bit */
-#define FLASH_ECCCP		0x08	/* Column parity 5 - 0 bit */
-#define FLASH_ECCCNTR		0x0c	/* ECC byte counter */
-#define FLASH_ECCCLRR		0x10	/* Clear ECC */
-#define FLASH_FLASHIO		0x14	/* Flash I/O */
-#define FLASH_FLASHCTL		0x18	/* Flash Control */
+#define FLASH_BASE              0x0c000000
+#define FLASH_ECCLPLB           0x00    /* Line parity 7 - 0 bit */
+#define FLASH_ECCLPUB           0x04    /* Line parity 15 - 8 bit */
+#define FLASH_ECCCP             0x08    /* Column parity 5 - 0 bit */
+#define FLASH_ECCCNTR           0x0c    /* ECC byte counter */
+#define FLASH_ECCCLRR           0x10    /* Clear ECC */
+#define FLASH_FLASHIO           0x14    /* Flash I/O */
+#define FLASH_FLASHCTL          0x18    /* Flash Control */
 
-#define FLASHCTL_CE0		(1 << 0)
-#define FLASHCTL_CLE		(1 << 1)
-#define FLASHCTL_ALE		(1 << 2)
-#define FLASHCTL_WP		(1 << 3)
-#define FLASHCTL_CE1		(1 << 4)
-#define FLASHCTL_RYBY		(1 << 5)
-#define FLASHCTL_NCE		(FLASHCTL_CE0 | FLASHCTL_CE1)
+#define FLASHCTL_CE0            (1 << 0)
+#define FLASHCTL_CLE            (1 << 1)
+#define FLASHCTL_ALE            (1 << 2)
+#define FLASHCTL_WP             (1 << 3)
+#define FLASHCTL_CE1            (1 << 4)
+#define FLASHCTL_RYBY           (1 << 5)
+#define FLASHCTL_NCE            (FLASHCTL_CE0 | FLASHCTL_CE1)
 
 #define TYPE_SL_NAND "sl-nand"
 #define SL_NAND(obj) OBJECT_CHECK(SLNANDState, (obj), TYPE_SL_NAND)
@@ -74,12 +74,12 @@ static uint64_t sl_read(void *opaque, hwaddr addr, unsigned size)
     int ryby;
 
     switch (addr) {
-#define BSHR(byte, from, to)	((s->ecc.lp[byte] >> (from - to)) & (1 << to))
+#define BSHR(byte, from, to)    ((s->ecc.lp[byte] >> (from - to)) & (1 << to))
     case FLASH_ECCLPLB:
         return BSHR(0, 4, 0) | BSHR(0, 5, 2) | BSHR(0, 6, 4) | BSHR(0, 7, 6) |
                 BSHR(1, 4, 1) | BSHR(1, 5, 3) | BSHR(1, 6, 5) | BSHR(1, 7, 7);
 
-#define BSHL(byte, from, to)	((s->ecc.lp[byte] << (to - from)) & (1 << to))
+#define BSHL(byte, from, to)    ((s->ecc.lp[byte] << (to - from)) & (1 << to))
     case FLASH_ECCLPUB:
         return BSHL(0, 0, 0) | BSHL(0, 1, 2) | BSHL(0, 2, 4) | BSHL(0, 3, 6) |
                 BSHL(1, 0, 1) | BSHL(1, 1, 3) | BSHL(1, 2, 5) | BSHL(1, 3, 7);
@@ -191,8 +191,8 @@ static void sl_nand_realize(DeviceState *dev, Error **errp)
 
 /* Spitz Keyboard */
 
-#define SPITZ_KEY_STROBE_NUM	11
-#define SPITZ_KEY_SENSE_NUM	7
+#define SPITZ_KEY_STROBE_NUM    11
+#define SPITZ_KEY_SENSE_NUM     7
 
 static const int spitz_gpio_key_sense[SPITZ_KEY_SENSE_NUM] = {
     12, 17, 91, 34, 36, 38, 39
@@ -214,11 +214,11 @@ static int spitz_keymap[SPITZ_KEY_SENSE_NUM + 1][SPITZ_KEY_STROBE_NUM] = {
     { 0x52, 0x43, 0x01, 0x47, 0x49,  -1 ,  -1 ,  -1 ,  -1 ,  -1 ,  -1  },
 };
 
-#define SPITZ_GPIO_AK_INT	13	/* Remote control */
-#define SPITZ_GPIO_SYNC		16	/* Sync button */
-#define SPITZ_GPIO_ON_KEY	95	/* Power button */
-#define SPITZ_GPIO_SWA		97	/* Lid */
-#define SPITZ_GPIO_SWB		96	/* Tablet mode */
+#define SPITZ_GPIO_AK_INT       13      /* Remote control */
+#define SPITZ_GPIO_SYNC                 16      /* Sync button */
+#define SPITZ_GPIO_ON_KEY       95      /* Power button */
+#define SPITZ_GPIO_SWA          97      /* Lid */
+#define SPITZ_GPIO_SWB          96      /* Tablet mode */
 
 /* The special buttons are mapped to unused keys */
 static const int spitz_gpiomap[5] = {
@@ -300,7 +300,7 @@ static void spitz_keyboard_keydown(SpitzKeyboardState *s, int keycode)
 #define SPITZ_MOD_CTRL    (1 << 8)
 #define SPITZ_MOD_FN      (1 << 9)
 
-#define QUEUE_KEY(c)	s->fifo[(s->fifopos + s->fifolen ++) & 0xf] = c
+#define QUEUE_KEY(c)    s->fifo[(s->fifopos + s->fifolen ++) & 0xf] = c
 
 static void spitz_keyboard_handler(void *opaque, int keycode)
 {
@@ -308,25 +308,25 @@ static void spitz_keyboard_handler(void *opaque, int keycode)
     uint16_t code;
     int mapcode;
     switch (keycode) {
-    case 0x2a:	/* Left Shift */
+    case 0x2a:  /* Left Shift */
         s->modifiers |= 1;
         break;
     case 0xaa:
         s->modifiers &= ~1;
         break;
-    case 0x36:	/* Right Shift */
+    case 0x36:  /* Right Shift */
         s->modifiers |= 2;
         break;
     case 0xb6:
         s->modifiers &= ~2;
         break;
-    case 0x1d:	/* Control */
+    case 0x1d:  /* Control */
         s->modifiers |= 4;
         break;
     case 0x9d:
         s->modifiers &= ~4;
         break;
-    case 0x38:	/* Alt */
+    case 0x38:  /* Alt */
         s->modifiers |= 8;
         break;
     case 0xb8:
@@ -536,14 +536,14 @@ static void spitz_keyboard_realize(DeviceState *dev, Error **errp)
 
 /* LCD backlight controller */
 
-#define LCDTG_RESCTL	0x00
-#define LCDTG_PHACTRL	0x01
-#define LCDTG_DUTYCTRL	0x02
-#define LCDTG_POWERREG0	0x03
-#define LCDTG_POWERREG1	0x04
-#define LCDTG_GPOR3	0x05
-#define LCDTG_PICTRL	0x06
-#define LCDTG_POLCTRL	0x07
+#define LCDTG_RESCTL    0x00
+#define LCDTG_PHACTRL   0x01
+#define LCDTG_DUTYCTRL  0x02
+#define LCDTG_POWERREG0         0x03
+#define LCDTG_POWERREG1         0x04
+#define LCDTG_GPOR3     0x05
+#define LCDTG_PICTRL    0x06
+#define LCDTG_POLCTRL   0x07
 
 typedef struct {
     SSISlave ssidev;
@@ -623,12 +623,12 @@ static void spitz_lcdtg_realize(SSISlave *dev, Error **errp)
 
 /* SSP devices */
 
-#define CORGI_SSP_PORT		2
+#define CORGI_SSP_PORT          2
 
-#define SPITZ_GPIO_LCDCON_CS	53
-#define SPITZ_GPIO_ADS7846_CS	14
-#define SPITZ_GPIO_MAX1111_CS	20
-#define SPITZ_GPIO_TP_INT	11
+#define SPITZ_GPIO_LCDCON_CS    53
+#define SPITZ_GPIO_ADS7846_CS   14
+#define SPITZ_GPIO_MAX1111_CS   20
+#define SPITZ_GPIO_TP_INT       11
 
 static DeviceState *max1111;
 
@@ -659,13 +659,13 @@ static void corgi_ssp_gpio_cs(void *opaque, int line, int level)
     s->enable[line] = !level;
 }
 
-#define MAX1111_BATT_VOLT	1
-#define MAX1111_BATT_TEMP	2
-#define MAX1111_ACIN_VOLT	3
+#define MAX1111_BATT_VOLT       1
+#define MAX1111_BATT_TEMP       2
+#define MAX1111_ACIN_VOLT       3
 
-#define SPITZ_BATTERY_TEMP	0xe0	/* About 2.9V */
-#define SPITZ_BATTERY_VOLT	0xd0	/* About 4.0V */
-#define SPITZ_CHARGEON_ACIN	0x80	/* About 5.0V */
+#define SPITZ_BATTERY_TEMP      0xe0    /* About 2.9V */
+#define SPITZ_BATTERY_VOLT      0xd0    /* About 4.0V */
+#define SPITZ_CHARGEON_ACIN     0x80    /* About 5.0V */
 
 static void spitz_adc_temp_on(void *opaque, int line, int level)
 {
@@ -735,11 +735,11 @@ static void spitz_microdrive_attach(PXA2xxState *cpu, int slot)
 
 /* Wm8750 and Max7310 on I2C */
 
-#define AKITA_MAX_ADDR	0x18
-#define SPITZ_WM_ADDRL	0x1b
-#define SPITZ_WM_ADDRH	0x1a
+#define AKITA_MAX_ADDR  0x18
+#define SPITZ_WM_ADDRL  0x1b
+#define SPITZ_WM_ADDRH  0x1a
 
-#define SPITZ_GPIO_WM	5
+#define SPITZ_GPIO_WM   5
 
 static void spitz_wm8750_addr(void *opaque, int line, int level)
 {
@@ -806,20 +806,20 @@ static void spitz_out_switch(void *opaque, int line, int level)
     }
 }
 
-#define SPITZ_SCP_LED_GREEN		1
-#define SPITZ_SCP_JK_B			2
-#define SPITZ_SCP_CHRG_ON		3
-#define SPITZ_SCP_MUTE_L		4
-#define SPITZ_SCP_MUTE_R		5
-#define SPITZ_SCP_CF_POWER		6
-#define SPITZ_SCP_LED_ORANGE		7
-#define SPITZ_SCP_JK_A			8
-#define SPITZ_SCP_ADC_TEMP_ON		9
-#define SPITZ_SCP2_IR_ON		1
-#define SPITZ_SCP2_AKIN_PULLUP		2
-#define SPITZ_SCP2_BACKLIGHT_CONT	7
-#define SPITZ_SCP2_BACKLIGHT_ON		8
-#define SPITZ_SCP2_MIC_BIAS		9
+#define SPITZ_SCP_LED_GREEN             1
+#define SPITZ_SCP_JK_B                  2
+#define SPITZ_SCP_CHRG_ON               3
+#define SPITZ_SCP_MUTE_L                4
+#define SPITZ_SCP_MUTE_R                5
+#define SPITZ_SCP_CF_POWER              6
+#define SPITZ_SCP_LED_ORANGE            7
+#define SPITZ_SCP_JK_A                  8
+#define SPITZ_SCP_ADC_TEMP_ON           9
+#define SPITZ_SCP2_IR_ON                1
+#define SPITZ_SCP2_AKIN_PULLUP          2
+#define SPITZ_SCP2_BACKLIGHT_CONT       7
+#define SPITZ_SCP2_BACKLIGHT_ON                 8
+#define SPITZ_SCP2_MIC_BIAS             9
 
 static void spitz_scoop_gpio_setup(PXA2xxState *cpu,
                 DeviceState *scp0, DeviceState *scp1)
@@ -839,15 +839,15 @@ static void spitz_scoop_gpio_setup(PXA2xxState *cpu,
     qdev_connect_gpio_out(scp0, SPITZ_SCP_ADC_TEMP_ON, outsignals[6]);
 }
 
-#define SPITZ_GPIO_HSYNC		22
-#define SPITZ_GPIO_SD_DETECT		9
-#define SPITZ_GPIO_SD_WP		81
-#define SPITZ_GPIO_ON_RESET		89
-#define SPITZ_GPIO_BAT_COVER		90
-#define SPITZ_GPIO_CF1_IRQ		105
-#define SPITZ_GPIO_CF1_CD		94
-#define SPITZ_GPIO_CF2_IRQ		106
-#define SPITZ_GPIO_CF2_CD		93
+#define SPITZ_GPIO_HSYNC                22
+#define SPITZ_GPIO_SD_DETECT            9
+#define SPITZ_GPIO_SD_WP                81
+#define SPITZ_GPIO_ON_RESET             89
+#define SPITZ_GPIO_BAT_COVER            90
+#define SPITZ_GPIO_CF1_IRQ              105
+#define SPITZ_GPIO_CF1_CD               94
+#define SPITZ_GPIO_CF2_IRQ              106
+#define SPITZ_GPIO_CF2_CD               93
 
 static int spitz_hsync;
 
@@ -907,8 +907,8 @@ static void spitz_gpio_setup(PXA2xxState *cpu, int slots)
 /* Board init.  */
 enum spitz_model_e { spitz, akita, borzoi, terrier };
 
-#define SPITZ_RAM	0x04000000
-#define SPITZ_ROM	0x00800000
+#define SPITZ_RAM       0x04000000
+#define SPITZ_ROM       0x00800000
 
 static struct arm_boot_info spitz_binfo = {
     .loader_start = PXA2XX_SDRAM_BASE,
-- 
2.20.1


