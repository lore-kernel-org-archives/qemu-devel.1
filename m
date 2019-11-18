Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CB3C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 06:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8FDD2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 06:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PePEmBFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FDD2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWaNy-0007ki-0K
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 01:19:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iWaMX-00071W-GM
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 01:18:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iWaMW-0005zE-0b
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 01:18:13 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35027)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iWaMS-0005u0-7k; Mon, 18 Nov 2019 01:18:08 -0500
Received: by mail-pg1-x542.google.com with SMTP id k32so3408275pgl.2;
 Sun, 17 Nov 2019 22:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JykI96YRsis8dgCEg/shW1vRhmHTLEtMbhdBgs5yPxU=;
 b=PePEmBFJ9ddf4opsptO/b+fwxkwxeQx887M9wvI3czpv8q+BQ9ytHFT/k4IqazdzCr
 pU387EzF0vxctAuhN3c+M/6TN/hc58v7YfNbeKhD1cYG6FzzC8GbDTkwtkPnwKTO1sWj
 L2j8cgO7G8HPkEgZHA8QzZwZdK4X+QJKkOBrFGUdf4vhN9s791p15gpqJty401ufZsnz
 9wa0w5sbMwfADwPPDK1whap688Zs7nh9D8lAwFti0pIOWnU1bH/V4S86/djDxnmfUpHn
 p1GM3Pf05ci4V+IeQtQemQUa96MZ1Il99I15u4h5Tbn1fM0n9APUqMdgcvuQefeJC/tP
 oPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=JykI96YRsis8dgCEg/shW1vRhmHTLEtMbhdBgs5yPxU=;
 b=RicD7fpBKIDyQ7rdsnULBmQU7FNllJDiD3bZ/TuJ49EUqqsiTZLlL0mtm+7nyK2TeD
 yNkc8W7jorg7nQYS/PmALeZpLT2WTzdCKVTb0c6RiHKKRQXPjAjmQJUrlIyeZsZ3Kkaz
 k3l6JMORU0E6u9J5eHF+SAjT20e1d5e4fvLvLh34aKFZnQGtsaI9tdTl5J5ksg4Rpkmd
 yHFyDU4CLZZEsO4E+nGL1GR6qyKIcAcGZ4IlXb9PBCjNQRQa7VK3h+VABn5mc6G9Kqi/
 IzyDx1crNqISDE81hNdZxO3CavqNd0C5xczD8FyazkIk5njX0l4IrT30xcxLDeMq+oID
 MF+g==
X-Gm-Message-State: APjAAAX6IybGn2xGs5VedOuD/omhCB9vv8sCazdLCvcT6is3aajKWXT6
 93HhZ9bdhG5YABtXn2O4liU=
X-Google-Smtp-Source: APXvYqzKVrqppKp0vLUeWakdH558Eh9BqolQiKsIJmg2NuAUxLexjownvSXj8pJzcr+bO19NtFgUdQ==
X-Received: by 2002:a63:7218:: with SMTP id n24mr19354968pgc.100.1574057885950; 
 Sun, 17 Nov 2019 22:18:05 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
 by smtp.gmail.com with ESMTPSA id u7sm16602843pjx.19.2019.11.17.22.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2019 22:18:05 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH] misc/pca9552: Add qom set and get
Date: Mon, 18 Nov 2019 16:47:57 +1030
Message-Id: <20191118061757.52550-1-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Rashmica Gupta <rashmica.g@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Following the pattern of the work recently done with the ASPEED GPIO
model, this adds support for inspecting and modifying the PCA9552 LEDs
from the monitor.

 (qemu) qom-set  /machine/unattached/device[17] led0 on
 (qemu) qom-get  /machine/unattached/device[17] led0
 "on"

 (qemu) qom-set  /machine/unattached/device[17] led0 off
 (qemu) qom-get  /machine/unattached/device[17] led0
 "off"

 (qemu) qom-set  /machine/unattached/device[17] led0 pwm0
 (qemu) qom-get  /machine/unattached/device[17] led0
 "pwm0"

 (qemu) qom-set  /machine/unattached/device[17] led0 pwm1
 (qemu) qom-get  /machine/unattached/device[17] led0
 "pwm1"

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
The qom device in mainline qemu is a different path. Using the monitor
examine `info qom-tree /machine/unattached/` to discover it.

This can be tested with a Witherspoon image.

$ wget https://openpower.xyz/job/openbmc-build/distro=ubuntu,label=builder,target=witherspoon/lastSuccessfulBuild/artifact/deploy/images/witherspoon/obmc-phosphor-image-witherspoon.ubi.mtd

$ qemu-system-arm -M witherspoon-bmc -serial pty -monitor pty -nographic \
 -drive file=obmc-phosphor-image-witherspoon.ubi.mtd,format=raw,if=mtd
char device redirected to /dev/pts/5 (label compat_monitor0)
char device redirected to /dev/pts/10 (label serial0)

$ screen /dev/pts/5
QEMU 4.1.91 monitor - type 'help' for more information
(qemu) qom-get  /machine/unattached/device[17] led0
"off"

$ screen /dev/pts/19
root@witherspoon:~# cd /sys/class/gpio/
root@witherspoon:/sys/class/gpio# echo 248 > export
root@witherspoon:/sys/class/gpio# cat gpio248/value
0

(qemu) qom-set  /machine/unattached/device[17] led0 on

root@witherspoon:/sys/class/gpio# echo out > gpio248/direction
root@witherspoon:/sys/class/gpio# cat gpio248/value
1

(qemu) qom-get  /machine/unattached/device[17] led0
"on"

(qemu) qom-set  /machine/unattached/device[17] led0 off
(qemu) qom-get  /machine/unattached/device[17] led0
"off"

root@witherspoon:/sys/class/gpio# cat gpio248/value
0

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/misc/pca9552.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index 73be28d9369c..0362aac8c862 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -15,12 +15,16 @@
 #include "hw/misc/pca9552.h"
 #include "hw/misc/pca9552_regs.h"
 #include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
 
 #define PCA9552_LED_ON   0x0
 #define PCA9552_LED_OFF  0x1
 #define PCA9552_LED_PWM0 0x2
 #define PCA9552_LED_PWM1 0x3
 
+static const char *led_state[] = {"on", "off", "pwm0", "pwm1"};
+
 static uint8_t pca9552_pin_get_config(PCA9552State *s, int pin)
 {
     uint8_t reg   = PCA9552_LS0 + (pin / 4);
@@ -169,6 +173,84 @@ static int pca9552_event(I2CSlave *i2c, enum i2c_event event)
     return 0;
 }
 
+static void pca9552_get_led(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    PCA9552State *s = PCA9552(obj);
+    int led, rc, reg;
+    char *str;
+    uint8_t state;
+
+    rc = sscanf(name, "led%2d", &led);
+    if (rc != 1) {
+        error_setg(errp, "%s: error reading %s", __func__, name);
+        return;
+    }
+    if (led < 0 || led > s->nr_leds) {
+        error_setg(errp, "%s invalid led %s", __func__, name);
+        return;
+    }
+    /*
+     * Get the LSx register as the qom interface should expose the device
+     * state, not the modeled 'input line' behaviour which would come from
+     * reading the INPUTx reg
+     */
+    reg = PCA9552_LS0 + led / 4;
+    state = (pca9552_read(s, reg) >> (led % 8)) & 0x3;
+    str = g_strdup(led_state[state]);
+    visit_type_str(v, name, &str, errp);
+}
+
+/*
+ * Return an LED selector register value based on an existing one, with
+ * the appropriate 2-bit state value set for the given LED number (0-3).
+ */
+static inline uint8_t pca955x_ledsel(uint8_t oldval, int led_num, int state)
+{
+        return (oldval & (~(0x3 << (led_num << 1)))) |
+                ((state & 0x3) << (led_num << 1));
+}
+
+static void pca9552_set_led(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    PCA9552State *s = PCA9552(obj);
+    Error *local_err = NULL;
+    int led, rc, reg, val;
+    uint8_t state;
+    char *state_str;
+
+    visit_type_str(v, name, &state_str, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    rc = sscanf(name, "led%2d", &led);
+    if (rc != 1) {
+        error_setg(errp, "%s: error reading %s", __func__, name);
+        return;
+    }
+    if (led < 0 || led > s->nr_leds) {
+        error_setg(errp, "%s invalid led %s", __func__, name);
+        return;
+    }
+
+    for (state = 0; state < ARRAY_SIZE(led_state); state++) {
+        if (!strcmp(state_str, led_state[state])) {
+            break;
+        }
+    }
+    if (state >= ARRAY_SIZE(led_state)) {
+        error_setg(errp, "%s invalid led state %s", __func__, state_str);
+        return;
+    }
+
+    reg = PCA9552_LS0 + led / 4;
+    val = pca9552_read(s, reg);
+    val = pca955x_ledsel(val, led % 4, state);
+    pca9552_write(s, reg, val);
+}
+
 static const VMStateDescription pca9552_vmstate = {
     .name = "PCA9552",
     .version_id = 0,
@@ -204,6 +286,7 @@ static void pca9552_reset(DeviceState *dev)
 static void pca9552_initfn(Object *obj)
 {
     PCA9552State *s = PCA9552(obj);
+    int led;
 
     /* If support for the other PCA955X devices are implemented, these
      * constant values might be part of class structure describing the
@@ -211,6 +294,14 @@ static void pca9552_initfn(Object *obj)
      */
     s->max_reg = PCA9552_LS3;
     s->nr_leds = 16;
+
+    for (led = 0; led < s->nr_leds; led++) {
+        char *name;
+
+        name = g_strdup_printf("led%d", led);
+        object_property_add(obj, name, "bool", pca9552_get_led, pca9552_set_led,
+                            NULL, NULL, NULL);
+    }
 }
 
 static void pca9552_class_init(ObjectClass *klass, void *data)
-- 
2.24.0


