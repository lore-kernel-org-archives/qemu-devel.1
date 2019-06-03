Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F686C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0937273E8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hj7e8FEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0937273E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38385 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqdh-0005rH-T6
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:20:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUN-0007In-Pv
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUL-0004Oo-RS
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:15 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:52202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqUK-0004Dk-3D
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:13 -0400
Received: by mail-wm1-x332.google.com with SMTP id f10so12032738wmb.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:subject:date:message-id:in-reply-to:references;
	bh=h9pzJqBxd1kk+NLb46bmp/qSs2GUDyrQqgzMDq+2xko=;
	b=hj7e8FEFqKcjeeUtbFPHKlavoi+VdSRPx1eo1J/nNba+Qu8/fm/x5fxagN5We+fnJG
	LFxGNQkYuc+uBCf6/ygC5CdaL4luMYIZbaghVEgsIiSoPiYMQVAlS6Xm9VnzfUfCAKr/
	/9SYqLkbhuYNy6Pv6rdcZbrwiJvJw1fjJu4Rm3Fhjk7KaGaRi0adsuerJc3Zb6IbP5jQ
	d1qMoCTsazk57rxFjWs48LT8ufUvQAYjsR9pTElSPwvmg597F+4R8jRdYe01cynhzBLH
	F6I92gcGeG8FLkfg32Gc1NFBoJB/sauU+/mbu39xIPSLUzFEAuZBO+m2a4kfXM65DmTv
	xMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:subject:date:message-id
	:in-reply-to:references;
	bh=h9pzJqBxd1kk+NLb46bmp/qSs2GUDyrQqgzMDq+2xko=;
	b=SbUqemZEpIbkUudE9jSvkpTRkZpvYFpa1yjuAOxDWKCWFh8tnDngB7jS3hrlPfLHNe
	VbV5EQREmitAlRRVPKevCUXFL+XcbWrc+Gora9a2MOU0g7eCHlY6JNKyGf3DggjTalNN
	C/Ffd+iHkiq1B/wdwd1tIDcRZXTem0SdxsKa1uK29L8M3OiYNw4g15BWFBegUzwy08XC
	H8cY20d51P/vKMHqgpoE7/qt97nWzyO2cI0nKzL+gFLbYZWQsqjLhx+dbiQDbI5VMrW3
	AUb9YdkUcNRsAlFM04LtFq2VfONgn2ASS/x/TG3THzaRJT2sOmzv5L7b8GaFTVGD2orY
	2ugw==
X-Gm-Message-State: APjAAAXKPkl2A8Z28NpCg9DKonX4RCzMm1WI6hC6GesIJ7Tz99nGb2Kh
	AuyrXgnqFietLQv0VqSUNZNXTWJg
X-Google-Smtp-Source: APXvYqxffzkArju12RGf1wqQQhU3KLhy9sC8RcZGSHNDaOQrTt6BTvnoJzaXeS1AKWceb2y2pJhLhQ==
X-Received: by 2002:a05:600c:2182:: with SMTP id
	e2mr11000461wme.55.1559581866680; 
	Mon, 03 Jun 2019 10:11:06 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.11.05 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:11:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:39 +0200
Message-Id: <1559581843-3968-21-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: [Qemu-devel] [PULL 20/24] tests: convert ds1338-test to qtest
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This way, ds1338-test will run for every machine that exposes
an i2c-bus.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  9 ++++-----
 tests/ds1338-test.c    | 37 +++++++++++++------------------------
 tests/libqos/i2c-imx.c | 19 -------------------
 tests/libqos/i2c.h     |  2 --
 4 files changed, 17 insertions(+), 50 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 0f1ddde..46a36c2 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -255,7 +255,6 @@ check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 check-qtest-sparc64-y += tests/prom-env-test$(EXESUF)
 check-qtest-sparc64-y += tests/boot-serial-test$(EXESUF)
 
-check-qtest-arm-y += tests/ds1338-test$(EXESUF)
 check-qtest-arm-y += tests/microbit-test$(EXESUF)
 check-qtest-arm-y += tests/m25p80-test$(EXESUF)
 check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
@@ -676,7 +675,7 @@ libqgraph-obj-y = tests/libqos/qgraph.o
 
 libqos-obj-y = $(libqgraph-obj-y) tests/libqos/pci.o tests/libqos/fw_cfg.o
 libqos-obj-y += tests/libqos/malloc.o
-libqos-obj-y += tests/libqos/i2c.o tests/libqos/libqos.o
+libqos-obj-y += tests/libqos/libqos.o
 libqos-spapr-obj-y = $(libqos-obj-y) tests/libqos/malloc-spapr.o
 libqos-spapr-obj-y += tests/libqos/libqos-spapr.o
 libqos-spapr-obj-y += tests/libqos/rtas.o
@@ -684,14 +683,14 @@ libqos-spapr-obj-y += tests/libqos/pci-spapr.o
 libqos-pc-obj-y = $(libqos-obj-y) tests/libqos/pci-pc.o
 libqos-pc-obj-y += tests/libqos/malloc-pc.o tests/libqos/libqos-pc.o
 libqos-pc-obj-y += tests/libqos/ahci.o
-libqos-imx-obj-y = $(libqos-obj-y) tests/libqos/i2c-imx.o
 libqos-usb-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/usb.o
 
 # Devices
 qos-test-obj-y = tests/qos-test.o $(libqgraph-obj-y)
 qos-test-obj-y += $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
 qos-test-obj-y += tests/libqos/e1000e.o
-qos-test-obj-y += $(libqos-imx-obj-y)
+qos-test-obj-y += tests/libqos/i2c.o
+qos-test-obj-y += tests/libqos/i2c-imx.o
 qos-test-obj-y += tests/libqos/i2c-omap.o
 qos-test-obj-y += tests/libqos/sdhci.o
 qos-test-obj-y += tests/libqos/tpci200.o
@@ -720,6 +719,7 @@ qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
 
 # Tests
 qos-test-obj-y += tests/ac97-test.o
+qos-test-obj-y += tests/ds1338-test.o
 qos-test-obj-y += tests/e1000-test.o
 qos-test-obj-y += tests/e1000e-test.o
 qos-test-obj-y += tests/eepro100-test.o
@@ -771,7 +771,6 @@ tests/boot-serial-test$(EXESUF): tests/boot-serial-test.o $(libqos-obj-y)
 tests/bios-tables-test$(EXESUF): tests/bios-tables-test.o \
 	tests/boot-sector.o tests/acpi-utils.o $(libqos-obj-y)
 tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o $(libqos-obj-y)
-tests/ds1338-test$(EXESUF): tests/ds1338-test.o $(libqos-imx-obj-y)
 tests/microbit-test$(EXESUF): tests/microbit-test.o
 tests/m25p80-test$(EXESUF): tests/m25p80-test.o
 tests/i440fx-test$(EXESUF): tests/i440fx-test.o $(libqos-pc-obj-y)
diff --git a/tests/ds1338-test.c b/tests/ds1338-test.c
index bd72a15..fd8fbad 100644
--- a/tests/ds1338-test.c
+++ b/tests/ds1338-test.c
@@ -21,25 +21,23 @@
 #include "libqtest.h"
 #include "libqos/i2c.h"
 
-#define IMX25_I2C_0_BASE 0x43F80000
-
 #define DS1338_ADDR 0x68
 
-static I2CAdapter *i2c;
-static uint8_t addr;
-
 static inline uint8_t bcd2bin(uint8_t x)
 {
     return ((x) & 0x0f) + ((x) >> 4) * 10;
 }
 
-static void send_and_receive(void)
+static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
 {
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    I2CAdapter *i2c = i2cdev->bus;
+
     uint8_t resp[7];
     time_t now = time(NULL);
     struct tm *tm_ptr = gmtime(&now);
 
-    i2c_read_block(i2c, addr, 0, resp, sizeof(resp));
+    i2c_read_block(i2c, DS1338_ADDR, 0, resp, sizeof(resp));
 
     /* check retrieved time againt local time */
     g_assert_cmpuint(bcd2bin(resp[4]), == , tm_ptr->tm_mday);
@@ -47,23 +45,14 @@ static void send_and_receive(void)
     g_assert_cmpuint(2000 + bcd2bin(resp[6]), == , 1900 + tm_ptr->tm_year);
 }
 
-int main(int argc, char **argv)
+static void ds1338_register_nodes(void)
 {
-    QTestState *s = NULL;
-    int ret;
-
-    g_test_init(&argc, &argv, NULL);
-
-    s = qtest_start("-display none -machine imx25-pdk -device ds1338,address=0x68");
-    i2c = imx_i2c_create(s, IMX25_I2C_0_BASE);
-    addr = DS1338_ADDR;
-
-    qtest_add_func("/ds1338/tx-rx", send_and_receive);
-
-    ret = g_test_run();
-
-    qtest_quit(s);
-    g_free(i2c);
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "address=0x68"
+    };
 
-    return ret;
+    qos_node_create_driver("ds1338", i2c_device_create);
+    qos_node_consumes("ds1338", "i2c-bus", &opts);
+    qos_add_test("tx-rx", "ds1338", send_and_receive, NULL);
 }
+libqos_init(ds1338_register_nodes);
diff --git a/tests/libqos/i2c-imx.c b/tests/libqos/i2c-imx.c
index 86d84a7..f33ece5 100644
--- a/tests/libqos/i2c-imx.c
+++ b/tests/libqos/i2c-imx.c
@@ -207,25 +207,6 @@ void imx_i2c_init(IMXI2C *s, QTestState *qts, uint64_t addr)
     s->parent.qts = qts;
 }
 
-I2CAdapter *imx_i2c_create(QTestState *qts, uint64_t addr)
-{
-    IMXI2C *s = g_malloc0(sizeof(*s));
-
-    imx_i2c_init(s, qts, addr);
-    return &s->parent;
-}
-
-void imx_i2c_free(I2CAdapter *i2c)
-{
-    IMXI2C *s;
-
-    if (!i2c) {
-        return;
-    }
-    s = container_of(i2c, IMXI2C, parent);
-    g_free(s);
-}
-
 static void imx_i2c_register_nodes(void)
 {
     qos_node_create_driver("imx.i2c", NULL);
diff --git a/tests/libqos/i2c.h b/tests/libqos/i2c.h
index 66b0e0d..2c8cc3e 100644
--- a/tests/libqos/i2c.h
+++ b/tests/libqos/i2c.h
@@ -75,7 +75,5 @@ typedef struct IMXI2C {
 } IMXI2C;
 
 void imx_i2c_init(IMXI2C *s, QTestState *qts, uint64_t addr);
-I2CAdapter *imx_i2c_create(QTestState *qts, uint64_t addr);
-void imx_i2c_free(I2CAdapter *i2c);
 
 #endif
-- 
1.8.3.1



