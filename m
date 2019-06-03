Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC5FC282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB50275F1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D81g9cSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB50275F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38329 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqZ7-0002Oh-Af
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:16:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUQ-0007LL-2I
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUN-0004SK-ST
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:17 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqUL-0004Fd-Q2
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:15 -0400
Received: by mail-wm1-x343.google.com with SMTP id f10so12032812wmb.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:subject:date:message-id:in-reply-to:references;
	bh=OCnCbQhO61/vRWDJ8AvVMz35F+DknibMXLjAc1BFL1E=;
	b=D81g9cSoyRGsISBVmg/BOqx7IMNsebeVQpAfm10fUneA3U6ZEjccJpy/yNFRqzSJuz
	55QwGzKvUipmWUr9FeYO0s1jVnwbcwNpWN0Ab3EeOM8PYKWMKD8tR+5Kt7wLbN6i5Ic9
	YL8PLL/F27rkGmUP171gMJ89Xi3jeCSv5Wqwfx0sS/DoJoxHvjVYqqCHcywelYDz4D8Z
	tH8ojA3xs0aHIbeJOjajPcfw2BQN/4NYqf9r/P2Tx1itiqYaeEtJNrvngiWtzDA0mWPT
	xjhHqK4XvWdiNDvxUGJvImgHN+eGFTn3Kci/BV1qWCa2QxL9KP7F8LRQO2bLfy2lslRv
	9fzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:subject:date:message-id
	:in-reply-to:references;
	bh=OCnCbQhO61/vRWDJ8AvVMz35F+DknibMXLjAc1BFL1E=;
	b=snPA3DRTKDabquqSQeHyuEdOIWsll8Z5j67hDADdp1orQ6zEh8OBX5jGORC3ojfAHI
	rLlTLk1lW0aAVxtpYqH9vgaW3u2D0xuWZaFiv/cVgP1saPLVwAFYGKYihzIM1TATL7FL
	VZiwnUsgQ5iIfS0quKxclCAxYmr+GQjiPFgtmUe4nxKRymhtaJsSQaUSNykTyIAp1fFa
	oOxBpttHvak+scn7FG4Gm1vbV8t6jlgZitD5hfu2DtJ5KRyvdmAEY9H7/0+KXGas1NcQ
	0cOSrqBBH4c6+73BJb9N4k6+4zMqmGUfdxpeKf8UD5vvY7trhQfQROjREg0CdL4LSB1i
	ZkQg==
X-Gm-Message-State: APjAAAWlBfXuwEfkICRyN+XBoa3bf0P1KAf+S7b6D9QRxOSYgyI7OWKd
	FnAKjsXIXm2I2fFn4/u6fH4+a/C6
X-Google-Smtp-Source: APXvYqwC7e4iB9ldoQOLWAmZva6erL6IMCtLdAIlGJ1ad4YOONh2REUuPrgX5WfaiFYlJdUbhVoSpw==
X-Received: by 2002:a1c:ab42:: with SMTP id u63mr15546580wme.130.1559581867694;
	Mon, 03 Jun 2019 10:11:07 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.11.06 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:11:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:40 +0200
Message-Id: <1559581843-3968-22-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PULL 21/24] libqos: i2c: move address into QI2CDevice
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

This removes the hardcoded I2C address from the tests.  The address
is passed via QOSGraphEdgeOptions to i2c_device_create and stored
in the QI2CDevice.

The i2c_send and i2c_recv functions, along with their wrappers,
therefore, can be changed to take a QI2CDevice rather than an
adapter/address pair.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/ds1338-test.c  |  4 ++--
 tests/libqos/i2c.c   | 51 +++++++++++++++++++++++++++++----------------------
 tests/libqos/i2c.h   | 27 +++++++++++++++------------
 tests/pca9552-test.c | 31 ++++++++++++++-----------------
 tests/tmp105-test.c  | 44 ++++++++++++++++++++++----------------------
 5 files changed, 82 insertions(+), 75 deletions(-)

diff --git a/tests/ds1338-test.c b/tests/ds1338-test.c
index fd8fbad..f6ade9a 100644
--- a/tests/ds1338-test.c
+++ b/tests/ds1338-test.c
@@ -31,13 +31,12 @@ static inline uint8_t bcd2bin(uint8_t x)
 static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
 {
     QI2CDevice *i2cdev = (QI2CDevice *)obj;
-    I2CAdapter *i2c = i2cdev->bus;
 
     uint8_t resp[7];
     time_t now = time(NULL);
     struct tm *tm_ptr = gmtime(&now);
 
-    i2c_read_block(i2c, DS1338_ADDR, 0, resp, sizeof(resp));
+    i2c_read_block(i2cdev, 0, resp, sizeof(resp));
 
     /* check retrieved time againt local time */
     g_assert_cmpuint(bcd2bin(resp[4]), == , tm_ptr->tm_mday);
@@ -50,6 +49,7 @@ static void ds1338_register_nodes(void)
     QOSGraphEdgeOptions opts = {
         .extra_device_opts = "address=0x68"
     };
+    add_qi2c_address(&opts, &(QI2CAddress) { DS1338_ADDR });
 
     qos_node_create_driver("ds1338", i2c_device_create);
     qos_node_consumes("ds1338", "i2c-bus", &opts);
diff --git a/tests/libqos/i2c.c b/tests/libqos/i2c.c
index 8117d13..156114e 100644
--- a/tests/libqos/i2c.c
+++ b/tests/libqos/i2c.c
@@ -10,63 +10,59 @@
 #include "libqos/i2c.h"
 #include "libqtest.h"
 
-void i2c_send(I2CAdapter *i2c, uint8_t addr,
-              const uint8_t *buf, uint16_t len)
+void i2c_send(QI2CDevice *i2cdev, const uint8_t *buf, uint16_t len)
 {
-    i2c->send(i2c, addr, buf, len);
+    i2cdev->bus->send(i2cdev->bus, i2cdev->addr, buf, len);
 }
 
-void i2c_recv(I2CAdapter *i2c, uint8_t addr,
-              uint8_t *buf, uint16_t len)
+void i2c_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t len)
 {
-    i2c->recv(i2c, addr, buf, len);
+    i2cdev->bus->recv(i2cdev->bus, i2cdev->addr, buf, len);
 }
 
-void i2c_read_block(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
-                       uint8_t *buf, uint16_t len)
+void i2c_read_block(QI2CDevice *i2cdev, uint8_t reg,
+                    uint8_t *buf, uint16_t len)
 {
-    i2c_send(i2c, addr, &reg, 1);
-    i2c_recv(i2c, addr, buf, len);
+    i2c_send(i2cdev, &reg, 1);
+    i2c_recv(i2cdev, buf, len);
 }
 
-void i2c_write_block(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
+void i2c_write_block(QI2CDevice *i2cdev, uint8_t reg,
                      const uint8_t *buf, uint16_t len)
 {
     uint8_t *cmd = g_malloc(len + 1);
     cmd[0] = reg;
     memcpy(&cmd[1], buf, len);
-    i2c_send(i2c, addr, cmd, len + 1);
+    i2c_send(i2cdev, cmd, len + 1);
     g_free(cmd);
 }
 
-uint8_t i2c_get8(I2CAdapter *i2c, uint8_t addr, uint8_t reg)
+uint8_t i2c_get8(QI2CDevice *i2cdev, uint8_t reg)
 {
     uint8_t resp[1];
-    i2c_read_block(i2c, addr, reg, resp, sizeof(resp));
+    i2c_read_block(i2cdev, reg, resp, sizeof(resp));
     return resp[0];
 }
 
-uint16_t i2c_get16(I2CAdapter *i2c, uint8_t addr, uint8_t reg)
+uint16_t i2c_get16(QI2CDevice *i2cdev, uint8_t reg)
 {
     uint8_t resp[2];
-    i2c_read_block(i2c, addr, reg, resp, sizeof(resp));
+    i2c_read_block(i2cdev, reg, resp, sizeof(resp));
     return (resp[0] << 8) | resp[1];
 }
 
-void i2c_set8(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
-              uint8_t value)
+void i2c_set8(QI2CDevice *i2cdev, uint8_t reg, uint8_t value)
 {
-    i2c_write_block(i2c, addr, reg, &value, 1);
+    i2c_write_block(i2cdev, reg, &value, 1);
 }
 
-void i2c_set16(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
-               uint16_t value)
+void i2c_set16(QI2CDevice *i2cdev, uint8_t reg, uint16_t value)
 {
     uint8_t data[2];
 
     data[0] = value >> 8;
     data[1] = value & 255;
-    i2c_write_block(i2c, addr, reg, data, sizeof(data));
+    i2c_write_block(i2cdev, reg, data, sizeof(data));
 }
 
 void *i2c_device_create(void *i2c_bus, QGuestAllocator *alloc, void *addr)
@@ -74,5 +70,16 @@ void *i2c_device_create(void *i2c_bus, QGuestAllocator *alloc, void *addr)
     QI2CDevice *i2cdev = g_new0(QI2CDevice, 1);
 
     i2cdev->bus = i2c_bus;
+    if (addr) {
+        i2cdev->addr = ((QI2CAddress *)addr)->addr;
+    }
     return &i2cdev->obj;
 }
+
+void add_qi2c_address(QOSGraphEdgeOptions *opts, QI2CAddress *addr)
+{
+    g_assert(addr);
+
+    opts->arg = addr;
+    opts->size_arg = sizeof(QI2CAddress);
+}
diff --git a/tests/libqos/i2c.h b/tests/libqos/i2c.h
index 2c8cc3e..945b65b 100644
--- a/tests/libqos/i2c.h
+++ b/tests/libqos/i2c.h
@@ -22,6 +22,11 @@ struct I2CAdapter {
     QTestState *qts;
 };
 
+typedef struct QI2CAddress QI2CAddress;
+struct QI2CAddress {
+    uint8_t addr;
+};
+
 typedef struct QI2CDevice QI2CDevice;
 struct QI2CDevice {
     /*
@@ -36,25 +41,23 @@ struct QI2CDevice {
      */
     QOSGraphObject obj;
     I2CAdapter *bus;
+    uint8_t addr;
 };
 
 void *i2c_device_create(void *i2c_bus, QGuestAllocator *alloc, void *addr);
+void add_qi2c_address(QOSGraphEdgeOptions *opts, QI2CAddress *addr);
 
-void i2c_send(I2CAdapter *i2c, uint8_t addr,
-              const uint8_t *buf, uint16_t len);
-void i2c_recv(I2CAdapter *i2c, uint8_t addr,
-              uint8_t *buf, uint16_t len);
+void i2c_send(QI2CDevice *dev, const uint8_t *buf, uint16_t len);
+void i2c_recv(QI2CDevice *dev, uint8_t *buf, uint16_t len);
 
-void i2c_read_block(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
+void i2c_read_block(QI2CDevice *dev, uint8_t reg,
                     uint8_t *buf, uint16_t len);
-void i2c_write_block(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
+void i2c_write_block(QI2CDevice *dev, uint8_t reg,
                      const uint8_t *buf, uint16_t len);
-uint8_t i2c_get8(I2CAdapter *i2c, uint8_t addr, uint8_t reg);
-uint16_t i2c_get16(I2CAdapter *i2c, uint8_t addr, uint8_t reg);
-void i2c_set8(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
-              uint8_t value);
-void i2c_set16(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
-               uint16_t value);
+uint8_t i2c_get8(QI2CDevice *dev, uint8_t reg);
+uint16_t i2c_get16(QI2CDevice *dev, uint8_t reg);
+void i2c_set8(QI2CDevice *dev, uint8_t reg, uint8_t value);
+void i2c_set16(QI2CDevice *dev, uint8_t reg, uint16_t value);
 
 /* i2c-omap.c */
 typedef struct OMAPI2C {
diff --git a/tests/pca9552-test.c b/tests/pca9552-test.c
index 0598d0b..4b800d3 100644
--- a/tests/pca9552-test.c
+++ b/tests/pca9552-test.c
@@ -19,65 +19,61 @@
 
 static void pca9552_init(QI2CDevice *i2cdev)
 {
-    I2CAdapter *i2c = i2cdev->bus;
-
     /* Switch on LEDs 0 and 12 */
-    i2c_set8(i2c, PCA9552_TEST_ADDR, PCA9552_LS0, 0x54);
-    i2c_set8(i2c, PCA9552_TEST_ADDR, PCA9552_LS3, 0x54);
+    i2c_set8(i2cdev, PCA9552_LS0, 0x54);
+    i2c_set8(i2cdev, PCA9552_LS3, 0x54);
 }
 
 static void receive_autoinc(void *obj, void *data, QGuestAllocator *alloc)
 {
     QI2CDevice *i2cdev = (QI2CDevice *)obj;
-    I2CAdapter *i2c = i2cdev->bus;
     uint8_t resp;
     uint8_t reg = PCA9552_LS0 | PCA9552_AUTOINC;
 
     pca9552_init(i2cdev);
 
-    i2c_send(i2c, PCA9552_TEST_ADDR, &reg, 1);
+    i2c_send(i2cdev, &reg, 1);
 
     /* PCA9552_LS0 */
-    i2c_recv(i2c, PCA9552_TEST_ADDR, &resp, 1);
+    i2c_recv(i2cdev, &resp, 1);
     g_assert_cmphex(resp, ==, 0x54);
 
     /* PCA9552_LS1 */
-    i2c_recv(i2c, PCA9552_TEST_ADDR, &resp, 1);
+    i2c_recv(i2cdev, &resp, 1);
     g_assert_cmphex(resp, ==, 0x55);
 
     /* PCA9552_LS2 */
-    i2c_recv(i2c, PCA9552_TEST_ADDR, &resp, 1);
+    i2c_recv(i2cdev, &resp, 1);
     g_assert_cmphex(resp, ==, 0x55);
 
     /* PCA9552_LS3 */
-    i2c_recv(i2c, PCA9552_TEST_ADDR, &resp, 1);
+    i2c_recv(i2cdev, &resp, 1);
     g_assert_cmphex(resp, ==, 0x54);
 }
 
 static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
 {
     QI2CDevice *i2cdev = (QI2CDevice *)obj;
-    I2CAdapter *i2c = i2cdev->bus;
     uint8_t value;
 
-    value = i2c_get8(i2c, PCA9552_TEST_ADDR, PCA9552_LS0);
+    value = i2c_get8(i2cdev, PCA9552_LS0);
     g_assert_cmphex(value, ==, 0x55);
 
-    value = i2c_get8(i2c, PCA9552_TEST_ADDR, PCA9552_INPUT0);
+    value = i2c_get8(i2cdev, PCA9552_INPUT0);
     g_assert_cmphex(value, ==, 0x0);
 
     pca9552_init(i2cdev);
 
-    value = i2c_get8(i2c, PCA9552_TEST_ADDR, PCA9552_LS0);
+    value = i2c_get8(i2cdev, PCA9552_LS0);
     g_assert_cmphex(value, ==, 0x54);
 
-    value = i2c_get8(i2c, PCA9552_TEST_ADDR, PCA9552_INPUT0);
+    value = i2c_get8(i2cdev, PCA9552_INPUT0);
     g_assert_cmphex(value, ==, 0x01);
 
-    value = i2c_get8(i2c, PCA9552_TEST_ADDR, PCA9552_LS3);
+    value = i2c_get8(i2cdev, PCA9552_LS3);
     g_assert_cmphex(value, ==, 0x54);
 
-    value = i2c_get8(i2c, PCA9552_TEST_ADDR, PCA9552_INPUT1);
+    value = i2c_get8(i2cdev, PCA9552_INPUT1);
     g_assert_cmphex(value, ==, 0x10);
 }
 
@@ -86,6 +82,7 @@ static void pca9552_register_nodes(void)
     QOSGraphEdgeOptions opts = {
         .extra_device_opts = "address=0x60"
     };
+    add_qi2c_address(&opts, &(QI2CAddress) { 0x60 });
 
     qos_node_create_driver("pca9552", i2c_device_create);
     qos_node_consumes("pca9552", "i2c-bus", &opts);
diff --git a/tests/tmp105-test.c b/tests/tmp105-test.c
index 40318763..f599309 100644
--- a/tests/tmp105-test.c
+++ b/tests/tmp105-test.c
@@ -46,19 +46,18 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
 {
     uint16_t value;
     QI2CDevice *i2cdev = (QI2CDevice *)obj;
-    I2CAdapter *i2c = i2cdev->bus;
 
     value = qmp_tmp105_get_temperature(TMP105_TEST_ID);
     g_assert_cmpuint(value, ==, 0);
 
-    value = i2c_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_TEMPERATURE);
+    value = i2c_get16(i2cdev, TMP105_REG_TEMPERATURE);
     g_assert_cmphex(value, ==, 0);
 
     qmp_tmp105_set_temperature(TMP105_TEST_ID, 20000);
     value = qmp_tmp105_get_temperature(TMP105_TEST_ID);
     g_assert_cmpuint(value, ==, 20000);
 
-    value = i2c_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_TEMPERATURE);
+    value = i2c_get16(i2cdev, TMP105_REG_TEMPERATURE);
     g_assert_cmphex(value, ==, 0x1400);
 
     qmp_tmp105_set_temperature(TMP105_TEST_ID, 20938); /* 20 + 15/16 */
@@ -67,27 +66,27 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmpuint(value, <, 20938 + TMP105_PRECISION/2);
 
     /* Set config */
-    i2c_set8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG, 0x60);
-    value = i2c_get8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG);
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, 0x60);
+    value = i2c_get8(i2cdev, TMP105_REG_CONFIG);
     g_assert_cmphex(value, ==, 0x60);
 
-    value = i2c_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_TEMPERATURE);
+    value = i2c_get16(i2cdev, TMP105_REG_TEMPERATURE);
     g_assert_cmphex(value, ==, 0x14f0);
 
     /* Set precision to 9, 10, 11 bits.  */
-    i2c_set8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG, 0x00);
-    g_assert_cmphex(i2c_get8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG), ==, 0x00);
-    value = i2c_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_TEMPERATURE);
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, 0x00);
+    g_assert_cmphex(i2c_get8(i2cdev, TMP105_REG_CONFIG), ==, 0x00);
+    value = i2c_get16(i2cdev, TMP105_REG_TEMPERATURE);
     g_assert_cmphex(value, ==, 0x1480);
 
-    i2c_set8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG, 0x20);
-    g_assert_cmphex(i2c_get8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG), ==, 0x20);
-    value = i2c_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_TEMPERATURE);
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, 0x20);
+    g_assert_cmphex(i2c_get8(i2cdev, TMP105_REG_CONFIG), ==, 0x20);
+    value = i2c_get16(i2cdev, TMP105_REG_TEMPERATURE);
     g_assert_cmphex(value, ==, 0x14c0);
 
-    i2c_set8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG, 0x40);
-    g_assert_cmphex(i2c_get8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG), ==, 0x40);
-    value = i2c_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_TEMPERATURE);
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, 0x40);
+    g_assert_cmphex(i2c_get8(i2cdev, TMP105_REG_CONFIG), ==, 0x40);
+    value = i2c_get16(i2cdev, TMP105_REG_TEMPERATURE);
     g_assert_cmphex(value, ==, 0x14e0);
 
     /* stored precision remains the same */
@@ -95,15 +94,15 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmpuint(value, >=, 20938 - TMP105_PRECISION/2);
     g_assert_cmpuint(value, <, 20938 + TMP105_PRECISION/2);
 
-    i2c_set8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG, 0x60);
-    g_assert_cmphex(i2c_get8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG), ==, 0x60);
-    value = i2c_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_TEMPERATURE);
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, 0x60);
+    g_assert_cmphex(i2c_get8(i2cdev, TMP105_REG_CONFIG), ==, 0x60);
+    value = i2c_get16(i2cdev, TMP105_REG_TEMPERATURE);
     g_assert_cmphex(value, ==, 0x14f0);
 
-    i2c_set16(i2c, TMP105_TEST_ADDR, TMP105_REG_T_LOW, 0x1234);
-    g_assert_cmphex(i2c_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_T_LOW), ==, 0x1234);
-    i2c_set16(i2c, TMP105_TEST_ADDR, TMP105_REG_T_HIGH, 0x4231);
-    g_assert_cmphex(i2c_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_T_HIGH), ==, 0x4231);
+    i2c_set16(i2cdev, TMP105_REG_T_LOW, 0x1234);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_T_LOW), ==, 0x1234);
+    i2c_set16(i2cdev, TMP105_REG_T_HIGH, 0x4231);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_T_HIGH), ==, 0x4231);
 }
 
 static void tmp105_register_nodes(void)
@@ -111,6 +110,7 @@ static void tmp105_register_nodes(void)
     QOSGraphEdgeOptions opts = {
         .extra_device_opts = "id=" TMP105_TEST_ID ",address=0x49"
     };
+    add_qi2c_address(&opts, &(QI2CAddress) { 0x49 });
 
     qos_node_create_driver("tmp105", i2c_device_create);
     qos_node_consumes("tmp105", "i2c-bus", &opts);
-- 
1.8.3.1



