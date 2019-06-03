Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E9DC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225B6274F4
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUWApCI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225B6274F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38462 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqiX-0001gO-Af
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:25:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUW-0007X2-Fx
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUT-0004dZ-VE
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:24 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqUQ-00047I-8t
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:20 -0400
Received: by mail-wr1-x442.google.com with SMTP id r18so3896357wrm.10
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:subject:date:message-id:in-reply-to:references;
	bh=bJ2qIHf63bhhWnV7Wbzv5gU351b7CRfeRe9/gqKuOzs=;
	b=YUWApCI4H/tD5toWS94OuyOmu/tuU1nO/Y3hOr0AKpTWxykyg2C4MzyJMnrw0B0bYc
	xW/XMK0IHtl0FO7qU7LFl9ZKK1cnXcug5LcOjDak9DlV40dERzROmqLuciXlyqIcIn5N
	ryYIm8ImXl/mmIAoAl/3tqwcJ7erjGZXttozJXCLRKOrrMUtH4hZhcDUPvU6YQM7NyV/
	c7dFi6hu+2MRBqGWBUc/w4mGLcJsabGMgH6pqASacSUMltYdJ59rWzG+Wau4rpaKy1fD
	XF9zLstZkeZtyRu2xt1m+6ochiBHxqVuBq/djA9F0fbINtUHj5F47MUMCxHyZ441cnmP
	GgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:subject:date:message-id
	:in-reply-to:references;
	bh=bJ2qIHf63bhhWnV7Wbzv5gU351b7CRfeRe9/gqKuOzs=;
	b=YePUzXmLLdJG65ezQrn3VSrhuN0Agt/xpBc4Wc4gZHf+hseBGT1b/+EpaK3yIpaNfx
	Qp3X//3b4WEQDQpyNxKBSD0XdCAlAkK7rVH4b0yFOaEcFobtE+6E95DOup9C6W9nEZ/S
	jBvo+uL2FoNWg7gE4Oy30WZE1gajN+SasFXQgV4WIn7WMV7P3ufoHbuNwPOy0xVicxMN
	F/7Vkdu92rkak6ns1TEETtV3g1hAS2Tsenu0Q3ZM51+jKpWQa1XGnSIL9CJ9bStZAErH
	RRGmhhUG4c9zDLb3dNnllg55uW5WdGh9k6UGaO74i1AAP4rY0bpehg4lgpEjFN5HZGBY
	iMJg==
X-Gm-Message-State: APjAAAU11bTEpa4MuqOHb1U+n8cLnCEH4qUile6ASTvBYwz5bnFJl0Y4
	9+nbxqg0+/XQbpilMYqI79t4VbDV
X-Google-Smtp-Source: APXvYqxlIZfrl4xE4sQua0yyMKlBEQlN7WGwI5pv6y5t0dtEmX52cGxMMZqA5taAgiUoY+2T3lqarA==
X-Received: by 2002:adf:fe0a:: with SMTP id n10mr3364303wrr.40.1559581862363; 
	Mon, 03 Jun 2019 10:11:02 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.11.01 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:11:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:35 +0200
Message-Id: <1559581843-3968-17-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PULL 16/24] libqos: convert I2C to qgraph
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

Create an i2c-bus interface, corresponding to the I2CAdapter struct.
Wrap IMXI2C and OMAPI2C with a QOSGraphObject, and add the get_driver
function to retrieve the I2CAdapter.

The conversion is still not complete; for simplicity, i2c_recv and
i2c_send (along with their wrappers) still take an adapter/address
pair.  Fixing that would be complicated until the tests are converted
to qgraph, so it is left for after the conversion.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include  |  2 ++
 tests/libqos/i2c-imx.c  | 20 ++++++++++++++++++++
 tests/libqos/i2c-omap.c | 40 ++++++++++++++++++++++++++++++++--------
 tests/libqos/i2c.c      |  8 ++++++++
 tests/libqos/i2c.h      | 21 +++++++++++++++++++++
 5 files changed, 83 insertions(+), 8 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 1865f6b..63f646a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -694,6 +694,8 @@ libqos-usb-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/usb.o
 qos-test-obj-y = tests/qos-test.o $(libqgraph-obj-y)
 qos-test-obj-y += $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
 qos-test-obj-y += tests/libqos/e1000e.o
+qos-test-obj-y += $(libqos-imx-obj-y)
+qos-test-obj-y += $(libqos-omap-obj-y)
 qos-test-obj-y += tests/libqos/sdhci.o
 qos-test-obj-y += tests/libqos/tpci200.o
 qos-test-obj-y += tests/libqos/virtio.o
diff --git a/tests/libqos/i2c-imx.c b/tests/libqos/i2c-imx.c
index 28289c5..86d84a7 100644
--- a/tests/libqos/i2c-imx.c
+++ b/tests/libqos/i2c-imx.c
@@ -186,10 +186,22 @@ static void imx_i2c_recv(I2CAdapter *i2c, uint8_t addr,
     g_assert((status & I2SR_IBB) == 0);
 }
 
+static void *imx_i2c_get_driver(void *obj, const char *interface)
+{
+    IMXI2C *s = obj;
+    if (!g_strcmp0(interface, "i2c-bus")) {
+        return &s->parent;
+    }
+    fprintf(stderr, "%s not present in imx-i2c\n", interface);
+    g_assert_not_reached();
+}
+
 void imx_i2c_init(IMXI2C *s, QTestState *qts, uint64_t addr)
 {
     s->addr = addr;
 
+    s->obj.get_driver = imx_i2c_get_driver;
+
     s->parent.send = imx_i2c_send;
     s->parent.recv = imx_i2c_recv;
     s->parent.qts = qts;
@@ -213,3 +225,11 @@ void imx_i2c_free(I2CAdapter *i2c)
     s = container_of(i2c, IMXI2C, parent);
     g_free(s);
 }
+
+static void imx_i2c_register_nodes(void)
+{
+    qos_node_create_driver("imx.i2c", NULL);
+    qos_node_produces("imx.i2c", "i2c-bus");
+}
+
+libqos_init(imx_i2c_register_nodes);
diff --git a/tests/libqos/i2c-omap.c b/tests/libqos/i2c-omap.c
index c7cbb9e..f949564 100644
--- a/tests/libqos/i2c-omap.c
+++ b/tests/libqos/i2c-omap.c
@@ -155,20 +155,36 @@ static void omap_i2c_recv(I2CAdapter *i2c, uint8_t addr,
     g_assert((data & OMAP_I2C_CON_STP) == 0);
 }
 
-void omap_i2c_init(OMAPI2C *s, QTestState *qts, uint64_t addr)
+static void *omap_i2c_get_driver(void *obj, const char *interface)
+{
+    OMAPI2C *s = obj;
+    if (!g_strcmp0(interface, "i2c-bus")) {
+        return &s->parent;
+    }
+    fprintf(stderr, "%s not present in omap_i2c\n", interface);
+    g_assert_not_reached();
+}
+
+static void omap_i2c_start_hw(QOSGraphObject *object)
 {
-    I2CAdapter *i2c = (I2CAdapter *)s;
+    OMAPI2C *s = (OMAPI2C *) object;
     uint16_t data;
 
+    /* verify the mmio address by looking for a known signature */
+    data = qtest_readw(s->parent.qts, s->addr + OMAP_I2C_REV);
+    g_assert_cmphex(data, ==, 0x34);
+}
+
+void omap_i2c_init(OMAPI2C *s, QTestState *qts, uint64_t addr)
+{
     s->addr = addr;
 
-    i2c->send = omap_i2c_send;
-    i2c->recv = omap_i2c_recv;
-    i2c->qts = qts;
+    s->obj.get_driver = omap_i2c_get_driver;
+    s->obj.start_hw = omap_i2c_start_hw;
 
-    /* verify the mmio address by looking for a known signature */
-    data = qtest_readw(qts, addr + OMAP_I2C_REV);
-    g_assert_cmphex(data, ==, 0x34);
+    s->parent.send = omap_i2c_send;
+    s->parent.recv = omap_i2c_recv;
+    s->parent.qts = qts;
 }
 
 I2CAdapter *omap_i2c_create(QTestState *qts, uint64_t addr)
@@ -189,3 +205,11 @@ void omap_i2c_free(I2CAdapter *i2c)
     s = container_of(i2c, OMAPI2C, parent);
     g_free(s);
 }
+
+static void omap_i2c_register_nodes(void)
+{
+    qos_node_create_driver("omap_i2c", NULL);
+    qos_node_produces("omap_i2c", "i2c-bus");
+}
+
+libqos_init(omap_i2c_register_nodes);
diff --git a/tests/libqos/i2c.c b/tests/libqos/i2c.c
index daf9a96..8117d13 100644
--- a/tests/libqos/i2c.c
+++ b/tests/libqos/i2c.c
@@ -68,3 +68,11 @@ void i2c_set16(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
     data[1] = value & 255;
     i2c_write_block(i2c, addr, reg, data, sizeof(data));
 }
+
+void *i2c_device_create(void *i2c_bus, QGuestAllocator *alloc, void *addr)
+{
+    QI2CDevice *i2cdev = g_new0(QI2CDevice, 1);
+
+    i2cdev->bus = i2c_bus;
+    return &i2cdev->obj;
+}
diff --git a/tests/libqos/i2c.h b/tests/libqos/i2c.h
index 877d2ab..0107cfc 100644
--- a/tests/libqos/i2c.h
+++ b/tests/libqos/i2c.h
@@ -10,6 +10,7 @@
 #define LIBQOS_I2C_H
 
 #include "libqtest.h"
+#include "libqos/qgraph.h"
 
 typedef struct I2CAdapter I2CAdapter;
 struct I2CAdapter {
@@ -21,8 +22,26 @@ struct I2CAdapter {
     QTestState *qts;
 };
 
+typedef struct QI2CDevice QI2CDevice;
+struct QI2CDevice {
+    /*
+     * For now, all devices are simple enough that there is no need for
+     * them to define their own constructor and get_driver functions.
+     * Therefore, QOSGraphObject is included directly in QI2CDevice;
+     * the tests expect to get a QI2CDevice rather than doing something
+     * like obj->get_driver("i2c-device").
+     *
+     * In fact there is no i2c-device interface even, because there are
+     * no generic I2C tests).
+     */
+    QOSGraphObject obj;
+    I2CAdapter *bus;
+};
+
 #define OMAP2_I2C_1_BASE 0x48070000
 
+void *i2c_device_create(void *i2c_bus, QGuestAllocator *alloc, void *addr);
+
 void i2c_send(I2CAdapter *i2c, uint8_t addr,
               const uint8_t *buf, uint16_t len);
 void i2c_recv(I2CAdapter *i2c, uint8_t addr,
@@ -41,6 +60,7 @@ void i2c_set16(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
 
 /* i2c-omap.c */
 typedef struct OMAPI2C {
+    QOSGraphObject obj;
     I2CAdapter parent;
 
     uint64_t addr;
@@ -52,6 +72,7 @@ void omap_i2c_free(I2CAdapter *i2c);
 
 /* i2c-imx.c */
 typedef struct IMXI2C {
+    QOSGraphObject obj;
     I2CAdapter parent;
 
     uint64_t addr;
-- 
1.8.3.1



