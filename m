Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6A5C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:51:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA8D21D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p79WxydP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA8D21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDXv1-00020S-Cd
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 13:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgQ-0004f8-Ad
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgN-0002zx-LA
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:36:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46001)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgN-0002zc-DF; Thu, 26 Sep 2019 13:35:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id r5so3410452wrm.12;
 Thu, 26 Sep 2019 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bAz+qcNOyZaCNx3LhuxXZkyMCKP1mZgQ0B/M8VWfm+o=;
 b=p79WxydPGFEOFEGaC/qL+xtMAwPJnqCh6fQv8I/BJ71f8Q/AEWM3/ZZ8DA8lRE/rDW
 Zxka4ZmoqH2krfaVIHO1qbWBZ0gyvkVl2bSeOtMKDdDphHSYE0R/fb/LoCEdi4xHw6zo
 S/a/bXR59isz+WDISlv4PdSWwG/Eot+60dT53BpSSLLVB5mnHchKW4YZi1a5BO7wRa8l
 ZTcRpFXnSkck7U9O70YJJGNYh1/YuW109fZepciXZQ05r8OWTaYnr7xODpQJpruDoyWo
 afi4vBMeT1t9sytJl3strY+ET9Euy4kXjyGwDA7bl5sDzO5Np4H9SDGNmLZ1nm2TvUmu
 1ddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=bAz+qcNOyZaCNx3LhuxXZkyMCKP1mZgQ0B/M8VWfm+o=;
 b=OgwsqwN2kOCDgQ1PPPBw7oEm4ik7nTNPUS5RyJiZ8eIqBhsPjQYqwN09tAJNUvvAtH
 illP5LzPD9MAKlUPKEJ6tdKb7Ece9fvg5ODWW0fOavvOY43rGnEuqM8ofoAT2MT9gRwd
 7llWNyCWBKo8hnMcgngETq/wYMD70Ehg3SOsFLOS4kxVbqWk2xNS5hVozQgUR9VOE1lb
 y4TzZMEGrSj2cyq8ergDfEzXv6tyOLSY6LIuWWOk6FgCUYKni88GJhBWAJxmZmkxaDt6
 ndiiTyo5hP+DouO5JHyLBwyGpY492a7Y8DkiHaGtfCSvLrcrrOIt4xEYvF7zk5hsciDR
 NWYA==
X-Gm-Message-State: APjAAAV1ucZgUYZMwgUFInxVfqWUtLzIchtGNrMmteISRxSMfe68s2HX
 1GipUkCtetA/1PjtOJXpiGNIzRhH6Qg=
X-Google-Smtp-Source: APXvYqyZ8FcvfyM+u+uDRfrMSXwdH9xIqSpk9YPmEP4bkph5nTii1gFmCP1VPZmwQfBshaHY8KvRbA==
X-Received: by 2002:adf:de0d:: with SMTP id b13mr3824288wrm.140.1569519297891; 
 Thu, 26 Sep 2019 10:34:57 -0700 (PDT)
Received: from x1w.redhat.com (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b186sm9918980wmd.16.2019.09.26.10.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 10:34:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/19] hw/arm/bcm2835_peripherals: Add Clock/Power/Reset
 Manager blocks
Date: Thu, 26 Sep 2019 19:34:20 +0200
Message-Id: <20190926173428.10713-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926173428.10713-1-f4bug@amsat.org>
References: <20190926173428.10713-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add basic support for BCM283x CPRMAN. Provide support for reading and
writing CPRMAN registers and initialize registers with sensible default
values. During runtime retain any written values.

Basic CPRMAN support is necessary and sufficient to boot Linux on raspi2
and raspi3 systems.

Based on:
https://github.com/raspberrypi/linux/blob/rpi-5.3.y/drivers/clk/bcm/clk-bcm2835.c
https://github.com/u-boot/u-boot/blob/v2019.07/include/dt-bindings/clock/bcm2835.h
https://github.com/arisena-com/rpi_src/blob/master/apps/i2s_test/src/i2s_test.c#L273

Co-developed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2835_peripherals.c         |  20 +-
 hw/misc/Makefile.objs                |   1 +
 hw/misc/bcm2835_cprman.c             | 383 +++++++++++++++++++++++++++
 hw/misc/trace-events                 |   8 +
 include/hw/arm/bcm2835_peripherals.h |   4 +-
 include/hw/misc/bcm2835_cprman.h     |  32 +++
 6 files changed, 444 insertions(+), 4 deletions(-)
 create mode 100644 hw/misc/bcm2835_cprman.c
 create mode 100644 include/hw/misc/bcm2835_cprman.h

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 965f4c1f3d..c887969795 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -62,6 +62,11 @@ static void bcm2835_peripherals_init(Object *obj)
     sysbus_init_child_obj(obj, "systimer", &s->systmr, sizeof(s->systmr),
                           TYPE_BCM2835_SYSTIMER);
 
+    /* Clock / Power / Reset */
+    object_initialize(&s->cprman, sizeof(s->cprman), TYPE_BCM2835_CPRMAN);
+    object_property_add_child(obj, "cprman", OBJECT(&s->cprman), NULL);
+    qdev_set_parent_bus(DEVICE(&s->cprman), sysbus_get_default());
+
     /* UART0 */
     sysbus_init_child_obj(obj, "uart0", &s->uart0, sizeof(s->uart0),
                           TYPE_PL011);
@@ -191,6 +196,19 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_ARM_IRQ,
                                INTERRUPT_ARM_TIMER));
 
+    /* Clock / Power / Reset */
+    object_property_set_bool(OBJECT(&s->cprman), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    memory_region_add_subregion(&s->peri_mr, CPRMAN_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cprman), 0));
+    memory_region_add_subregion(&s->peri_mr, CM_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cprman), 1));
+    memory_region_add_subregion(&s->peri_mr, A2W_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cprman), 2));
+
     /* UART0 */
     qdev_prop_set_chr(DEVICE(&s->uart0), "chardev", serial_hd(0));
     object_property_set_bool(OBJECT(&s->uart0), true, "realized", &err);
@@ -372,8 +390,6 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     }
 
     create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, 0x40);
-    create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x1000);
-    create_unimp(s, &s->a2w, "bcm2835-a2w", A2W_OFFSET, 0x1000);
     create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
     create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
     create_unimp(s, &s->spi[0], "bcm2835-spi0", SPI0_OFFSET, 0x20);
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index c89f3816a5..64e717e6b3 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -53,6 +53,7 @@ common-obj-$(CONFIG_OMAP) += omap_tap.o
 common-obj-$(CONFIG_RASPI) += bcm2835_mbox.o
 common-obj-$(CONFIG_RASPI) += bcm2835_property.o
 common-obj-$(CONFIG_RASPI) += bcm2835_rng.o
+common-obj-$(CONFIG_RASPI) += bcm2835_cprman.o
 common-obj-$(CONFIG_RASPI) += bcm2835_thermal.o
 common-obj-$(CONFIG_SLAVIO) += slavio_misc.o
 common-obj-$(CONFIG_ZYNQ) += zynq_slcr.o
diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
new file mode 100644
index 0000000000..6c3b5b6837
--- /dev/null
+++ b/hw/misc/bcm2835_cprman.c
@@ -0,0 +1,383 @@
+/*
+ * BCM2835 Clock/Power/Reset Manager subsystem (poor man's version)
+ *
+ * Copyright (C) 2018 Guenter Roeck <linux@roeck-us.net>
+ * Copyright (C) 2018 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "sysemu/runstate.h"
+#include "hw/registerfields.h"
+#include "hw/misc/bcm2835_cprman.h"
+#include "trace.h"
+
+#define CPRMAN_PASSWD 'Z'
+
+FIELD(CPRMAN, PASSWD,   24, 8)
+
+REG32(PM_RSTC,          0x1c)
+REG32(PM_RSTS,          0x20)
+REG32(PM_WDOG,          0x24)
+
+static const char *pm_name(hwaddr addr)
+{
+    addr &= ~3;
+    switch (addr) {
+    case A_PM_RSTC: return "RST_CLR";
+    case A_PM_RSTS: return "RST_SET";
+    case A_PM_WDOG: return "WDG";
+    default:
+        return "UNKN";
+    }
+}
+
+static uint64_t bcm2835_cprman_pm_read(void *opaque, hwaddr addr,
+                                    unsigned size)
+{
+    uint32_t res = 0;
+
+    trace_bcm2835_cprman_read(size << 3, addr, "PM", pm_name(addr), "", res);
+
+    return res;
+}
+
+static void bcm2835_cprman_pm_write(void *opaque, hwaddr addr,
+                                    uint64_t value, unsigned size)
+{
+    const char *name;
+
+    if (FIELD_EX32(value, CPRMAN, PASSWD) != CPRMAN_PASSWD) {
+        qemu_log_mask(LOG_GUEST_ERROR, "[CPRMAN]: password key error w%02d"
+                                       " *0x%04"HWADDR_PRIx" = 0x%"PRIx64"\n",
+                      size << 3, addr, value);
+        return;
+    }
+    value &= ~R_CPRMAN_PASSWD_MASK;
+
+    name = pm_name(addr);
+    trace_bcm2835_cprman_write_pm(addr, name, value);
+    if (addr == A_PM_RSTC && value & 0x20) { /* TODO remove 0x20 magic */
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+    }
+}
+
+static const MemoryRegionOps bcm2835_cprman_pm_ops = {
+    .read = bcm2835_cprman_pm_read,
+    .write = bcm2835_cprman_pm_write,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 4,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+REG32(CM_CTL,               0)
+FIELD(CM_CTL, SRC,       0, 4)
+FIELD(CM_CTL, ENABLE,    4, 1)
+FIELD(CM_CTL, KILL,      5, 1)
+FIELD(CM_CTL, GATE,      6, 1)
+FIELD(CM_CTL, BUSY,      7, 1)
+FIELD(CM_CTL, BUSYD,     8, 1)
+FIELD(CM_CTL, FRAC,      9, 1)
+
+REG32(CM_DIV,               4)
+FIELD(CM_DIV, FRAC,      0, 12)
+FIELD(CM_DIV, INTEGER,  12, 12)
+
+REG32(CM_OSCCOUNT,      0x100)
+REG32(CM_LOCK,          0x114)
+REG32(CM_EVENT,         0x118)
+REG32(CM_PLLB,          0x170)
+
+/* Bits used by R_CM_CTL_SRC_MASK */
+enum cprman_clock_source {
+    SRC_GND = 0,
+    SRC_OSC = 1,
+    SRC_TEST_DBG0 = 2,
+    SRC_TEST_DBG1 = 3,
+    SRC_PLLA = 4,
+    SRC_PLLC_CORE0 = 5,
+    SRC_PLLD = 6,
+    SRC_PLLH_AUX = 7,
+    SRC_PLLC_CORE1 = 8,
+    SRC_PLLC_CORE2 = 9
+};
+
+static const char *src_name(int src)
+{
+    static const char *src_names[16] = {
+        [SRC_GND] = "GND",
+        [SRC_OSC] = "OSC",
+        [SRC_PLLA] = "PLLA",
+        [SRC_PLLC_CORE0] = "PLLC_CORE0",
+        [SRC_PLLD] = "PLLD",
+        [SRC_PLLH_AUX] = "PLLH_AUX",
+        [SRC_PLLC_CORE1] = "PLLC_CORE1",
+        [SRC_PLLC_CORE2] = "PLLC_CORE2",
+    };
+    return src_names[src] ? src_names[src] : "UNKN";
+}
+
+static const char *ctldiv_names[0x200 / 4] = {
+    [0] = "GENERIC",
+    [1] = "VPU",
+    [2] = "SYS",
+    [3] = "PERIA",
+    [4] = "PERII",
+    [5] = "H264",
+    [6] = "ISP",
+    [7] = "V3D",
+    [8] = "CAM0",
+    [9] = "CAM1",
+    [10] = "CCP2",
+    [11] = "DSI0E",
+    [12] = "DSI0P",
+    [13] = "DPI",
+    [14] = "GP0",
+    [15] = "GP1",
+    [16] = "GP2",
+    [17] = "HSM",
+    [18] = "OTP",
+    [19] = "PCM",
+    [20] = "PWM",
+    [21] = "SLIM",
+    [22] = "SMI",
+    [24] = "TCNT",
+    [25] = "TEC",
+    [26] = "TD0",
+    [27] = "TD1",
+    [28] = "TSENS",
+    [29] = "TIMER",
+    [30] = "UART",
+    [31] = "VEC",
+    [43] = "DSI1E",
+    [44] = "DSI1P",
+    [45] = "DFT",
+    [50] = "PULSE",
+    [53] = "SDC",
+    [54] = "ARM",
+    [55] = "AVEO",
+    [56] = "EMMC",
+};
+
+static const char *cm_name(hwaddr addr)
+{
+    int idx;
+
+    addr &= ~3;
+    switch (addr) {
+    case A_CM_OSCCOUNT: return "OSCCOUNT";
+    case 0x104 ... 0x110:
+    case A_CM_PLLB: return "PLLx";
+    case A_CM_LOCK: return "LOCK";
+    case A_CM_EVENT: return "EVENT";
+    default:
+        idx = addr / 8;
+        return ctldiv_names[idx] ? ctldiv_names[idx] : "UNKN";
+    }
+}
+
+static uint32_t scale(uint32_t value)
+{
+    return (1000ull * value) >> 10;
+}
+
+/*
+ * Available information suggests that CPRMAN registers have default
+ * values which are not overwritten by ROMMON (u-boot). The hardware
+ * default values are unknown at this time.
+ * The default values selected here are necessary and sufficient
+ * to boot Linux directly (on raspi2 and raspi3). The selected
+ * values enable all clocks and set clock rates to match their
+ * parent rates.
+ */
+static uint64_t bcm2835_cprman_cm_read(void *opaque, hwaddr addr,
+                                       unsigned size)
+{
+    uint32_t res = 0;
+
+    if (addr == A_CM_LOCK) {
+        res = 0b11111 << 8; /* all locked! */
+    } else {
+        switch (addr & 0xf) {
+        case A_CM_CTL:
+            res = SRC_OSC | R_CM_CTL_ENABLE_MASK;
+            break;
+        case A_CM_DIV:
+            res = FIELD_DP32(0, CM_DIV, INTEGER, 1);
+            break;
+        default:
+            qemu_log_mask(LOG_UNIMP, "%s: bad offset 0x%" HWADDR_PRIx "\n",
+                          __func__, addr);
+        }
+    }
+    trace_bcm2835_cprman_read(size << 3, addr, "CM", cm_name(addr), "", res);
+
+    return res;
+}
+
+static void bcm2835_cprman_cm_write(void *opaque, hwaddr addr,
+                                    uint64_t value, unsigned size)
+{
+    const char *name;
+
+    if (FIELD_EX32(value, CPRMAN, PASSWD) != CPRMAN_PASSWD) {
+        qemu_log_mask(LOG_GUEST_ERROR, "[CPRMAN]: password key error w%02d"
+                                       " *0x%04"HWADDR_PRIx" = 0x%"PRIx64"\n",
+                      size << 3, addr, value);
+        return;
+    }
+    value &= ~R_CPRMAN_PASSWD_MASK;
+
+    name = cm_name(addr);
+    switch (addr) {
+    case A_CM_OSCCOUNT:
+    case 0x104 ... 0x110:
+    case A_CM_PLLB:
+    case A_CM_LOCK:
+    case A_CM_EVENT:
+        trace_bcm2835_cprman_write_cm_generic(name, value);
+        break;
+    default:
+        switch (addr & 0xf) {
+        case A_CM_CTL:
+            trace_bcm2835_cprman_write_cm_ctl(name, src_name(value & 0xf),
+                                FIELD_EX32(value, CM_CTL, ENABLE));
+            break;
+        case A_CM_DIV:
+            trace_bcm2835_cprman_write_cm_div(name,
+                                FIELD_EX32(value, CM_DIV, INTEGER),
+                                scale(FIELD_EX32(value, CM_DIV, FRAC)));
+        }
+    }
+}
+
+static const MemoryRegionOps bcm2835_cprman_cm_ops = {
+    .read = bcm2835_cprman_cm_read,
+    .write = bcm2835_cprman_cm_write,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 4,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+REG32(A2W_PLL_CTRL, 0x00)
+FIELD(A2W_PLL_CTRL, NDIV,                   0, 12)
+FIELD(A2W_PLL_CTRL, PDIV,                   12, 3)
+FIELD(A2W_PLL_CTRL, POWER_DOWN,             16, 1)
+FIELD(A2W_PLL_CTRL, POWER_RESET_DISABLE,    17, 1)
+
+REG32(A2W_PLL_ANA0, 0x10)
+
+FIELD(A2W_PLL_FRAC, DIV,                    0, 20)
+
+FIELD(A2W_PLL_CHAN, DIV,                    0, 8)
+FIELD(A2W_PLL_CHAN, DISABLE,                8, 1)
+
+static const char *a2w_name(hwaddr addr)
+{
+    if (addr >= 0x300) {
+        return "CHANx";
+    }
+    if (addr >= 0x200) {
+        return "FRACx";
+    }
+    switch (addr & 0x1f) {
+    case A_A2W_PLL_CTRL:
+        return "CTRL";
+    case A_A2W_PLL_ANA0:
+        return "ANA0";
+    default:
+        return "UNKN";
+    }
+}
+
+static const char *pll_name(int idx)
+{
+    static const char *pll_names[8] = {
+        [0] = "PLLA",
+        [1] = "PLLC",
+        [2] = "PLLD",
+        [3] = "PLLH",
+        [7] = "PLLB",
+    };
+    return pll_names[idx] ? pll_names[idx] : "UNKN";
+}
+
+static uint64_t bcm2835_cprman_a2w_read(void *opaque, hwaddr addr,
+                                        unsigned size)
+{
+    uint32_t res = 0;
+
+    if (addr < 0x200) {
+        /* Power */
+        switch (addr & 0x1f) {
+        case A_A2W_PLL_CTRL:
+            res = R_A2W_PLL_CTRL_POWER_DOWN_MASK; /* On */
+            break;
+        case A_A2W_PLL_ANA0:
+            break;
+        }
+    } else {
+        /* addr < 0x300 is FREQ, else CHANNEL */
+        qemu_log_mask(LOG_UNIMP, "%s: bad offset 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+    }
+    trace_bcm2835_cprman_read(size << 3, addr, "A2W", a2w_name(addr),
+                              pll_name((addr >> 5) & 7), res);
+
+    return res;
+}
+
+static void bcm2835_cprman_a2w_write(void *opaque, hwaddr addr,
+                                     uint64_t value, unsigned size)
+{
+    if (FIELD_EX32(value, CPRMAN, PASSWD) != CPRMAN_PASSWD) {
+        qemu_log_mask(LOG_GUEST_ERROR, "[CPRMAN]: password key error w%02d"
+                                       " *0x%04"HWADDR_PRIx" = 0x%"PRIx64"\n",
+                      size << 3, addr, value);
+        return;
+    }
+    value &= ~R_CPRMAN_PASSWD_MASK;
+
+    trace_bcm2835_cprman_write_a2w(addr, a2w_name(addr),
+                                   pll_name((addr >> 5) & 7), value);
+}
+
+static const MemoryRegionOps bcm2835_cprman_a2w_ops = {
+    .read = bcm2835_cprman_a2w_read,
+    .write = bcm2835_cprman_a2w_write,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 4,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void bcm2835_cprman_init(Object *obj)
+{
+    BCM2835CprmanState *s = BCM2835_CPRMAN(obj);
+
+    memory_region_init_io(&s->iomem.pm, obj, &bcm2835_cprman_pm_ops, s,
+                          TYPE_BCM2835_CPRMAN "-pm", 0x1000);
+    memory_region_init_io(&s->iomem.cm, obj, &bcm2835_cprman_cm_ops, s,
+                          TYPE_BCM2835_CPRMAN "-cm", 0x1000);
+    memory_region_init_io(&s->iomem.a2w, obj, &bcm2835_cprman_a2w_ops, s,
+                          TYPE_BCM2835_CPRMAN "-a2w", 0x1000);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem.pm);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem.cm);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem.a2w);
+}
+
+static TypeInfo bcm2835_cprman_info = {
+    .name          = TYPE_BCM2835_CPRMAN,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2835CprmanState),
+    .instance_init = bcm2835_cprman_init,
+};
+
+static void bcm2835_cprman_register_types(void)
+{
+    type_register_static(&bcm2835_cprman_info);
+}
+
+type_init(bcm2835_cprman_register_types)
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 1deb1d08c1..30d33e2e1d 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -149,3 +149,11 @@ bcm2835_mbox_write(unsigned int size, uint64_t addr, uint64_t value) "mbox write
 bcm2835_mbox_read(unsigned int size, uint64_t addr, uint64_t value) "mbox read sz:%u addr:0x%"PRIx64" data:0x%"PRIx64
 bcm2835_mbox_irq(unsigned level) "mbox irq:ARM level:%u"
 bcm2835_mbox_property(uint32_t tag, uint32_t bufsize, size_t resplen) "mbox property tag:0x%08x in_sz:%u out_sz:%zu"
+
+# bcm2835_cprman.c
+bcm2835_cprman_read(unsigned size, uint64_t offset, const char *reg_type, const char *reg_name1, const char *reg_name2, uint32_t value) "cprman: rd%u @0x%03" PRIx64 " %s %s.%s val:0x%x"
+bcm2835_cprman_write_pm(uint64_t offset, const char *reg_name, uint32_t value) "pm: wr @0x%03" PRIx64 " %s val:0x%x"
+bcm2835_cprman_write_cm_generic(const char *reg_name, uint32_t val) "cprman: wr %s 0x%08x"
+bcm2835_cprman_write_cm_div(const char *reg_name, uint32_t v0, uint32_t v1) "cprman: wr %s.DIV float:%u.%u"
+bcm2835_cprman_write_cm_ctl(const char *reg_name, const char *src, uint32_t ena) "cprman: wr %s.CTL src:%s enabled:%u"
+bcm2835_cprman_write_a2w(uint64_t offset, const char *reg_name, const char *pll_name, uint32_t value) "a2w: wr @0x%03" PRIx64 " %s.%s val:0x%x"
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 5b9fc89453..b4360ca1a8 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -19,6 +19,7 @@
 #include "hw/intc/bcm2835_ic.h"
 #include "hw/misc/bcm2835_property.h"
 #include "hw/misc/bcm2835_rng.h"
+#include "hw/misc/bcm2835_cprman.h"
 #include "hw/misc/bcm2835_mbox.h"
 #include "hw/misc/bcm2835_thermal.h"
 #include "hw/sd/sdhci.h"
@@ -42,8 +43,7 @@ typedef struct BCM2835PeripheralState {
 
     BCM2835SysTimerState systmr;
     UnimplementedDeviceState armtmr;
-    UnimplementedDeviceState cprman;
-    UnimplementedDeviceState a2w;
+    BCM2835CprmanState cprman;
     PL011State uart0;
     BCM2835AuxState aux;
     BCM2835FBState fb;
diff --git a/include/hw/misc/bcm2835_cprman.h b/include/hw/misc/bcm2835_cprman.h
new file mode 100644
index 0000000000..4dd2c8323b
--- /dev/null
+++ b/include/hw/misc/bcm2835_cprman.h
@@ -0,0 +1,32 @@
+/*
+ * BCM2835 Clock/Power/Reset Manager subsystem (poor man's version)
+ *
+ * Copyright (C) 2018 Guenter Roeck <linux@roeck-us.net>
+ * Copyright (C) 2018 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef BCM2835_CPRMAN_H
+#define BCM2835_CPRMAN_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_BCM2835_CPRMAN "bcm2835-cprman"
+#define BCM2835_CPRMAN(obj) \
+        OBJECT_CHECK(BCM2835CprmanState, (obj), TYPE_BCM2835_CPRMAN)
+
+typedef struct {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    struct {
+        MemoryRegion pm;
+        MemoryRegion cm;
+        MemoryRegion a2w;
+    } iomem;
+} BCM2835CprmanState;
+
+#endif
-- 
2.20.1


