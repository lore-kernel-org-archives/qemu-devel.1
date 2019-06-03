Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456ADC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0715324AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlXWP8xO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0715324AB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38354 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqcb-00054W-7O
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:19:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUT-0007Sb-TS
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUQ-0004W8-0a
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:19 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqUN-0004CC-T8
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:16 -0400
Received: by mail-wm1-x344.google.com with SMTP id 16so7593955wmg.5
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:subject:date:message-id:in-reply-to:references;
	bh=uTw9lui1K14b+YilUbfGl6zQd1d28dhhzntF+On8O/c=;
	b=UlXWP8xO2vUIdmfC2sswxQKXcuO2nlnAZqb1rUAuiNWVRijk3JVaODbH2HVLFGkT5u
	7ST4Wvra7CakODk6l8whsONibxf+0jNpZrcc4v4YTWmZrAJNGYDsmMklN6El1Jwg0ZF3
	2gm4/Wu/9gHMPRLOTkj5MRgbVr+3NaNLH7ctbBW81eiKjTtek2E9AqrbMM7hw65VjJrK
	XbvXMUWMVC09qv7S2jjo/pPV7D8wbiOl8qQwH3BFCtFGOHL+9l4mWtwdWcxqIdo1BNUQ
	vdJLTi0/lWEjYzswd+7IecNepfPut/SgZJwWJE4j4z72HT7WsoM5rCF6ThYTjkMHEoPC
	kwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:subject:date:message-id
	:in-reply-to:references;
	bh=uTw9lui1K14b+YilUbfGl6zQd1d28dhhzntF+On8O/c=;
	b=Pb1a6q4U2pWb24rWHIcw2YM1mq1mmn4G6jgmoSEyCHHANeVhGeCUU0DEytSg4Ehf6c
	LvctofAsRYwquIssqGnuG9agoX8QtM7Srba1m7CmNwgf3QHoWk8gB/KpOiKLMjIMPM7F
	Vlsb+W4l1ha1zeL0Hjo6zfKerJcH572ABZ+HJ+x+Ci0DDecpNd/KXWgWF+YGCZ6gSjkJ
	xgOwJVz8J8C2eOUZ6qIg2YPri6AtRPE1gkE+GDZub/bt5JG1duS8e0axgdeUP8ecy0ld
	xBAETP2Dih8dvxR/H7bNODyJ+MTUA8+ykw5CErHpdc1yTlkbVaC81CAyxVxwBjDBJQ70
	2gIA==
X-Gm-Message-State: APjAAAVojzJM/gK+X/V91H6EGjME7U6zoM4EFVzYDYITN6poXJ6CUqtc
	xWOs2J8XLgDHUmj2lOLYXEi4Gw04
X-Google-Smtp-Source: APXvYqzfFP0+f1jKQ+ACsZNT4iEPE0P9vmroBNDA4hT/V4Pa6aJyHJmOTtYPvuO4UQ3NTjfkIuc8og==
X-Received: by 2002:a1c:8017:: with SMTP id b23mr15024428wmd.117.1559581865678;
	Mon, 03 Jun 2019 10:11:05 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.11.04 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:11:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:38 +0200
Message-Id: <1559581843-3968-20-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PULL 19/24] tests: convert OMAP i2c tests to qgraph
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

This way, pca9952-test and tmp105-test will run for every machine
that exposes an i2c-bus.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include  |  9 +++------
 tests/libqos/i2c-omap.c | 19 -------------------
 tests/libqos/i2c.h      |  4 ----
 tests/pca9552-test.c    | 44 +++++++++++++++++++-------------------------
 tests/tmp105-test.c     | 32 ++++++++++++--------------------
 5 files changed, 34 insertions(+), 74 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 506181e..0f1ddde 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -255,8 +255,6 @@ check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 check-qtest-sparc64-y += tests/prom-env-test$(EXESUF)
 check-qtest-sparc64-y += tests/boot-serial-test$(EXESUF)
 
-check-qtest-arm-y += tests/tmp105-test$(EXESUF)
-check-qtest-arm-y += tests/pca9552-test$(EXESUF)
 check-qtest-arm-y += tests/ds1338-test$(EXESUF)
 check-qtest-arm-y += tests/microbit-test$(EXESUF)
 check-qtest-arm-y += tests/m25p80-test$(EXESUF)
@@ -686,7 +684,6 @@ libqos-spapr-obj-y += tests/libqos/pci-spapr.o
 libqos-pc-obj-y = $(libqos-obj-y) tests/libqos/pci-pc.o
 libqos-pc-obj-y += tests/libqos/malloc-pc.o tests/libqos/libqos-pc.o
 libqos-pc-obj-y += tests/libqos/ahci.o
-libqos-omap-obj-y = $(libqos-obj-y) tests/libqos/i2c-omap.o
 libqos-imx-obj-y = $(libqos-obj-y) tests/libqos/i2c-imx.o
 libqos-usb-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/usb.o
 
@@ -695,7 +692,7 @@ qos-test-obj-y = tests/qos-test.o $(libqgraph-obj-y)
 qos-test-obj-y += $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
 qos-test-obj-y += tests/libqos/e1000e.o
 qos-test-obj-y += $(libqos-imx-obj-y)
-qos-test-obj-y += $(libqos-omap-obj-y)
+qos-test-obj-y += tests/libqos/i2c-omap.o
 qos-test-obj-y += tests/libqos/sdhci.o
 qos-test-obj-y += tests/libqos/tpci200.o
 qos-test-obj-y += tests/libqos/virtio.o
@@ -731,10 +728,12 @@ qos-test-obj-y += tests/ipoctal232-test.o
 qos-test-obj-y += tests/megasas-test.o
 qos-test-obj-y += tests/ne2000-test.o
 qos-test-obj-y += tests/nvme-test.o
+qos-test-obj-y += tests/pca9552-test.o
 qos-test-obj-y += tests/pci-test.o
 qos-test-obj-y += tests/pcnet-test.o
 qos-test-obj-y += tests/sdhci-test.o
 qos-test-obj-y += tests/spapr-phb-test.o
+qos-test-obj-y += tests/tmp105-test.o
 qos-test-obj-y += tests/usb-hcd-ohci-test.o $(libqos-usb-obj-y)
 qos-test-obj-$(CONFIG_VHOST_NET_USER) += tests/vhost-user-test.o $(chardev-obj-y) $(test-io-obj-y)
 qos-test-obj-y += tests/virtio-test.o
@@ -772,8 +771,6 @@ tests/boot-serial-test$(EXESUF): tests/boot-serial-test.o $(libqos-obj-y)
 tests/bios-tables-test$(EXESUF): tests/bios-tables-test.o \
 	tests/boot-sector.o tests/acpi-utils.o $(libqos-obj-y)
 tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o $(libqos-obj-y)
-tests/tmp105-test$(EXESUF): tests/tmp105-test.o $(libqos-omap-obj-y)
-tests/pca9552-test$(EXESUF): tests/pca9552-test.o $(libqos-omap-obj-y)
 tests/ds1338-test$(EXESUF): tests/ds1338-test.o $(libqos-imx-obj-y)
 tests/microbit-test$(EXESUF): tests/microbit-test.o
 tests/m25p80-test$(EXESUF): tests/m25p80-test.o
diff --git a/tests/libqos/i2c-omap.c b/tests/libqos/i2c-omap.c
index f949564..9ae8214 100644
--- a/tests/libqos/i2c-omap.c
+++ b/tests/libqos/i2c-omap.c
@@ -187,25 +187,6 @@ void omap_i2c_init(OMAPI2C *s, QTestState *qts, uint64_t addr)
     s->parent.qts = qts;
 }
 
-I2CAdapter *omap_i2c_create(QTestState *qts, uint64_t addr)
-{
-    OMAPI2C *s = g_malloc0(sizeof(*s));
-
-    omap_i2c_init(s, qts, addr);
-    return &s->parent;
-}
-
-void omap_i2c_free(I2CAdapter *i2c)
-{
-    OMAPI2C *s;
-
-    if (!i2c) {
-        return;
-    }
-    s = container_of(i2c, OMAPI2C, parent);
-    g_free(s);
-}
-
 static void omap_i2c_register_nodes(void)
 {
     qos_node_create_driver("omap_i2c", NULL);
diff --git a/tests/libqos/i2c.h b/tests/libqos/i2c.h
index 0107cfc..66b0e0d 100644
--- a/tests/libqos/i2c.h
+++ b/tests/libqos/i2c.h
@@ -38,8 +38,6 @@ struct QI2CDevice {
     I2CAdapter *bus;
 };
 
-#define OMAP2_I2C_1_BASE 0x48070000
-
 void *i2c_device_create(void *i2c_bus, QGuestAllocator *alloc, void *addr);
 
 void i2c_send(I2CAdapter *i2c, uint8_t addr,
@@ -67,8 +65,6 @@ typedef struct OMAPI2C {
 } OMAPI2C;
 
 void omap_i2c_init(OMAPI2C *s, QTestState *qts, uint64_t addr);
-I2CAdapter *omap_i2c_create(QTestState *qts, uint64_t addr);
-void omap_i2c_free(I2CAdapter *i2c);
 
 /* i2c-imx.c */
 typedef struct IMXI2C {
diff --git a/tests/pca9552-test.c b/tests/pca9552-test.c
index f950932..0598d0b 100644
--- a/tests/pca9552-test.c
+++ b/tests/pca9552-test.c
@@ -10,23 +10,26 @@
 #include "qemu/osdep.h"
 
 #include "libqtest.h"
+#include "libqos/qgraph.h"
 #include "libqos/i2c.h"
 #include "hw/misc/pca9552_regs.h"
 
 #define PCA9552_TEST_ID   "pca9552-test"
 #define PCA9552_TEST_ADDR 0x60
 
-static I2CAdapter *i2c;
-
-static void pca9552_init(I2CAdapter *i2c)
+static void pca9552_init(QI2CDevice *i2cdev)
 {
+    I2CAdapter *i2c = i2cdev->bus;
+
     /* Switch on LEDs 0 and 12 */
     i2c_set8(i2c, PCA9552_TEST_ADDR, PCA9552_LS0, 0x54);
     i2c_set8(i2c, PCA9552_TEST_ADDR, PCA9552_LS3, 0x54);
 }
 
-static void receive_autoinc(void)
+static void receive_autoinc(void *obj, void *data, QGuestAllocator *alloc)
 {
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    I2CAdapter *i2c = i2cdev->bus;
     uint8_t resp;
     uint8_t reg = PCA9552_LS0 | PCA9552_AUTOINC;
 
@@ -51,8 +54,10 @@ static void receive_autoinc(void)
     g_assert_cmphex(resp, ==, 0x54);
 }
 
-static void send_and_receive(void)
+static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
 {
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    I2CAdapter *i2c = i2cdev->bus;
     uint8_t value;
 
     value = i2c_get8(i2c, PCA9552_TEST_ADDR, PCA9552_LS0);
@@ -76,27 +81,16 @@ static void send_and_receive(void)
     g_assert_cmphex(value, ==, 0x10);
 }
 
-int main(int argc, char **argv)
+static void pca9552_register_nodes(void)
 {
-    QTestState *s = NULL;
-    int ret;
-
-    g_test_init(&argc, &argv, NULL);
-
-    s = qtest_start("-machine n800 "
-                    "-device pca9552,bus=i2c-bus.0,id=" PCA9552_TEST_ID
-                    ",address=0x60");
-    i2c = omap_i2c_create(s, OMAP2_I2C_1_BASE);
-
-    qtest_add_func("/pca9552/tx-rx", send_and_receive);
-    qtest_add_func("/pca9552/rx-autoinc", receive_autoinc);
-
-    ret = g_test_run();
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "address=0x60"
+    };
 
-    if (s) {
-        qtest_quit(s);
-    }
-    omap_i2c_free(i2c);
+    qos_node_create_driver("pca9552", i2c_device_create);
+    qos_node_consumes("pca9552", "i2c-bus", &opts);
 
-    return ret;
+    qos_add_test("tx-rx", "pca9552", send_and_receive, NULL);
+    qos_add_test("rx-autoinc", "pca9552", receive_autoinc, NULL);
 }
+libqos_init(pca9552_register_nodes);
diff --git a/tests/tmp105-test.c b/tests/tmp105-test.c
index 25ea05f..40318763 100644
--- a/tests/tmp105-test.c
+++ b/tests/tmp105-test.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 
 #include "libqtest.h"
+#include "libqos/qgraph.h"
 #include "libqos/i2c.h"
 #include "qapi/qmp/qdict.h"
 #include "hw/misc/tmp105_regs.h"
@@ -17,8 +18,6 @@
 #define TMP105_TEST_ID   "tmp105-test"
 #define TMP105_TEST_ADDR 0x49
 
-static I2CAdapter *i2c;
-
 static int qmp_tmp105_get_temperature(const char *id)
 {
     QDict *response;
@@ -43,9 +42,11 @@ static void qmp_tmp105_set_temperature(const char *id, int value)
 }
 
 #define TMP105_PRECISION (1000/16)
-static void send_and_receive(void)
+static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
 {
     uint16_t value;
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    I2CAdapter *i2c = i2cdev->bus;
 
     value = qmp_tmp105_get_temperature(TMP105_TEST_ID);
     g_assert_cmpuint(value, ==, 0);
@@ -105,24 +106,15 @@ static void send_and_receive(void)
     g_assert_cmphex(i2c_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_T_HIGH), ==, 0x4231);
 }
 
-int main(int argc, char **argv)
+static void tmp105_register_nodes(void)
 {
-    QTestState *s = NULL;
-    int ret;
-
-    g_test_init(&argc, &argv, NULL);
-
-    s = qtest_start("-machine n800 "
-                    "-device tmp105,bus=i2c-bus.0,id=" TMP105_TEST_ID
-                    ",address=0x49");
-    i2c = omap_i2c_create(s, OMAP2_I2C_1_BASE);
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "id=" TMP105_TEST_ID ",address=0x49"
+    };
 
-    qtest_add_func("/tmp105/tx-rx", send_and_receive);
+    qos_node_create_driver("tmp105", i2c_device_create);
+    qos_node_consumes("tmp105", "i2c-bus", &opts);
 
-    ret = g_test_run();
-
-    qtest_quit(s);
-    omap_i2c_free(i2c);
-
-    return ret;
+    qos_add_test("tx-rx", "tmp105", send_and_receive, NULL);
 }
+libqos_init(tmp105_register_nodes);
-- 
1.8.3.1



