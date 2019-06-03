Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5894C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:22:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ADCB27332
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oizq4QA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADCB27332
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38409 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqfb-0007mM-Kq
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:22:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUT-0007Sg-W4
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUQ-0004WH-1z
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:20 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:35875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqUN-0003yc-S0
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:16 -0400
Received: by mail-wr1-x42d.google.com with SMTP id n4so9858080wrs.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:subject:date:message-id:in-reply-to:references;
	bh=soA4io5WAhJTcvEEt4vIULBxnysle2UEV000MhP1Je4=;
	b=oizq4QA8Zzvf0kwLN5k8CKBQTu7vi9ZsrRWo6QiS3wN2E4uWMHEsSEWeIiAUIrqCt7
	7mOoSvhabcBBq9oIQnnF8N87hRiqrvKVRA7/vIW5/WLWjNEHCM6SlgoNhMy3WH9OYF4y
	FzDHfXM9O5mSW3HfgdfNfE5HILVlg2J0znEINw2unmQNm4sETo01VUP5WMCzKYy2cOvM
	yXDxReZ/JBHtpbuevRvG+VMo3I37Db/cYA/aF2kMvxdWvlk5xegCF+JOi/UM+HAfZAuw
	vb6EzDGj0bXa4Avfuc4tEo9furGG0qX1V6bGJ94k/ZAa11QHDT/NYApnD3qcYFNByqsD
	LxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:subject:date:message-id
	:in-reply-to:references;
	bh=soA4io5WAhJTcvEEt4vIULBxnysle2UEV000MhP1Je4=;
	b=Zh140SafsJreJuUx/+V48O3jKCnQ8bswt6A5NcBi4R6gwsnK4yvEiBG1yIf2rb9eVR
	0MfB56D5Lf9pR4nu28piKiY2VSEVLXc7Apl7TAd/UoJL0EsH6uyID0n5Xhs5tDIJhRaI
	uj7rQtDCe8GbDcXqTEC1DOhjLZbMupwzqBZxQYNvfOzlwSdQAx4gQSZuUWk7vP7yXdlv
	eqNAZYay0J2XdNsoBNqxYySgv31ev0w3O3QVg0OK+XapH6ym3j+WWkpR6B3/BbsIScGB
	LheBdtn9GAJHuOIMqAnrgbfl0edL4IJO8gjV75BSfV/xrIVgx1BPgYmbMij5vlmgC7jC
	xQYQ==
X-Gm-Message-State: APjAAAUOLUxIyBdxymunIGaauyIiSP9RueoNasC5HtL6UJD3iC+wBCC5
	KS+pAyhHMKfd2CP0Pumc4TWMpoQx
X-Google-Smtp-Source: APXvYqw1xUDQD+kzpHmlD+IAb+Eq6p0nrvHbKUIS2SeP+iBLC6+L4E+RLlWBRw0u90kwrJArptFepQ==
X-Received: by 2002:adf:ea4a:: with SMTP id j10mr5322496wrn.114.1559581856838; 
	Mon, 03 Jun 2019 10:10:56 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.10.55 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:10:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:30 +0200
Message-Id: <1559581843-3968-12-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42d
Subject: [Qemu-devel] [PULL 11/24] libqos: move common i2c code to libqos
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

The functions to read/write 8-bit or 16-bit registers are the same
in tmp105 and pca9552 tests, and in fact they are a special case of
"read block"/"write block" functionality; read block in turn is used
in ds1338-test.

Move everything inside libqos-test, removing the duplication.  Account
for the small differences by adding to tmp105-test.c the "read register
after writing" behavior that is specific to it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/ds1338-test.c  |  8 +-----
 tests/libqos/i2c.c   | 47 ++++++++++++++++++++++++++++++
 tests/libqos/i2c.h   | 11 ++++++++
 tests/pca9552-test.c | 37 ++++++------------------
 tests/tmp105-test.c  | 80 ++++++++++++++--------------------------------------
 5 files changed, 88 insertions(+), 95 deletions(-)

diff --git a/tests/ds1338-test.c b/tests/ds1338-test.c
index 742dad9..88f829f 100644
--- a/tests/ds1338-test.c
+++ b/tests/ds1338-test.c
@@ -35,17 +35,11 @@ static inline uint8_t bcd2bin(uint8_t x)
 
 static void send_and_receive(void)
 {
-    uint8_t cmd[1];
     uint8_t resp[7];
     time_t now = time(NULL);
     struct tm *tm_ptr = gmtime(&now);
 
-    /* reset the index in the RTC memory */
-    cmd[0] = 0;
-    i2c_send(i2c, addr, cmd, 1);
-
-    /* retrieve the date */
-    i2c_recv(i2c, addr, resp, 7);
+    i2c_read_block(i2c, addr, 0, resp, sizeof(resp));
 
     /* check retrieved time againt local time */
     g_assert_cmpuint(bcd2bin(resp[4]), == , tm_ptr->tm_mday);
diff --git a/tests/libqos/i2c.c b/tests/libqos/i2c.c
index 23bc2a3..daf9a96 100644
--- a/tests/libqos/i2c.c
+++ b/tests/libqos/i2c.c
@@ -21,3 +21,50 @@ void i2c_recv(I2CAdapter *i2c, uint8_t addr,
 {
     i2c->recv(i2c, addr, buf, len);
 }
+
+void i2c_read_block(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
+                       uint8_t *buf, uint16_t len)
+{
+    i2c_send(i2c, addr, &reg, 1);
+    i2c_recv(i2c, addr, buf, len);
+}
+
+void i2c_write_block(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
+                     const uint8_t *buf, uint16_t len)
+{
+    uint8_t *cmd = g_malloc(len + 1);
+    cmd[0] = reg;
+    memcpy(&cmd[1], buf, len);
+    i2c_send(i2c, addr, cmd, len + 1);
+    g_free(cmd);
+}
+
+uint8_t i2c_get8(I2CAdapter *i2c, uint8_t addr, uint8_t reg)
+{
+    uint8_t resp[1];
+    i2c_read_block(i2c, addr, reg, resp, sizeof(resp));
+    return resp[0];
+}
+
+uint16_t i2c_get16(I2CAdapter *i2c, uint8_t addr, uint8_t reg)
+{
+    uint8_t resp[2];
+    i2c_read_block(i2c, addr, reg, resp, sizeof(resp));
+    return (resp[0] << 8) | resp[1];
+}
+
+void i2c_set8(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
+              uint8_t value)
+{
+    i2c_write_block(i2c, addr, reg, &value, 1);
+}
+
+void i2c_set16(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
+               uint16_t value)
+{
+    uint8_t data[2];
+
+    data[0] = value >> 8;
+    data[1] = value & 255;
+    i2c_write_block(i2c, addr, reg, data, sizeof(data));
+}
diff --git a/tests/libqos/i2c.h b/tests/libqos/i2c.h
index cc01358..a462114 100644
--- a/tests/libqos/i2c.h
+++ b/tests/libqos/i2c.h
@@ -28,6 +28,17 @@ void i2c_send(I2CAdapter *i2c, uint8_t addr,
 void i2c_recv(I2CAdapter *i2c, uint8_t addr,
               uint8_t *buf, uint16_t len);
 
+void i2c_read_block(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
+                    uint8_t *buf, uint16_t len);
+void i2c_write_block(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
+                     const uint8_t *buf, uint16_t len);
+uint8_t i2c_get8(I2CAdapter *i2c, uint8_t addr, uint8_t reg);
+uint16_t i2c_get16(I2CAdapter *i2c, uint8_t addr, uint8_t reg);
+void i2c_set8(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
+              uint8_t value);
+void i2c_set16(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
+               uint16_t value);
+
 /* libi2c-omap.c */
 I2CAdapter *omap_i2c_create(QTestState *qts, uint64_t addr);
 
diff --git a/tests/pca9552-test.c b/tests/pca9552-test.c
index 5466a67..06359b7 100644
--- a/tests/pca9552-test.c
+++ b/tests/pca9552-test.c
@@ -18,27 +18,6 @@
 
 static I2CAdapter *i2c;
 
-static uint8_t pca9552_get8(I2CAdapter *i2c, uint8_t addr, uint8_t reg)
-{
-    uint8_t resp[1];
-    i2c_send(i2c, addr, &reg, 1);
-    i2c_recv(i2c, addr, resp, 1);
-    return resp[0];
-}
-
-static void pca9552_set8(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
-                         uint8_t value)
-{
-    uint8_t cmd[2];
-    uint8_t resp[1];
-
-    cmd[0] = reg;
-    cmd[1] = value;
-    i2c_send(i2c, addr, cmd, 2);
-    i2c_recv(i2c, addr, resp, 1);
-    g_assert_cmphex(resp[0], ==, cmd[1]);
-}
-
 static void receive_autoinc(void)
 {
     uint8_t resp;
@@ -67,26 +46,26 @@ static void send_and_receive(void)
 {
     uint8_t value;
 
-    value = pca9552_get8(i2c, PCA9552_TEST_ADDR, PCA9552_LS0);
+    value = i2c_get8(i2c, PCA9552_TEST_ADDR, PCA9552_LS0);
     g_assert_cmphex(value, ==, 0x55);
 
-    value = pca9552_get8(i2c, PCA9552_TEST_ADDR, PCA9552_INPUT0);
+    value = i2c_get8(i2c, PCA9552_TEST_ADDR, PCA9552_INPUT0);
     g_assert_cmphex(value, ==, 0x0);
 
     /* Switch on LED 0 */
-    pca9552_set8(i2c, PCA9552_TEST_ADDR, PCA9552_LS0, 0x54);
-    value = pca9552_get8(i2c, PCA9552_TEST_ADDR, PCA9552_LS0);
+    i2c_set8(i2c, PCA9552_TEST_ADDR, PCA9552_LS0, 0x54);
+    value = i2c_get8(i2c, PCA9552_TEST_ADDR, PCA9552_LS0);
     g_assert_cmphex(value, ==, 0x54);
 
-    value = pca9552_get8(i2c, PCA9552_TEST_ADDR, PCA9552_INPUT0);
+    value = i2c_get8(i2c, PCA9552_TEST_ADDR, PCA9552_INPUT0);
     g_assert_cmphex(value, ==, 0x01);
 
     /* Switch on LED 12 */
-    pca9552_set8(i2c, PCA9552_TEST_ADDR, PCA9552_LS3, 0x54);
-    value = pca9552_get8(i2c, PCA9552_TEST_ADDR, PCA9552_LS3);
+    i2c_set8(i2c, PCA9552_TEST_ADDR, PCA9552_LS3, 0x54);
+    value = i2c_get8(i2c, PCA9552_TEST_ADDR, PCA9552_LS3);
     g_assert_cmphex(value, ==, 0x54);
 
-    value = pca9552_get8(i2c, PCA9552_TEST_ADDR, PCA9552_INPUT1);
+    value = i2c_get8(i2c, PCA9552_TEST_ADDR, PCA9552_INPUT1);
     g_assert_cmphex(value, ==, 0x10);
 }
 
diff --git a/tests/tmp105-test.c b/tests/tmp105-test.c
index 34cae7a..c86d257 100644
--- a/tests/tmp105-test.c
+++ b/tests/tmp105-test.c
@@ -19,50 +19,6 @@
 
 static I2CAdapter *i2c;
 
-static uint16_t tmp105_get8(I2CAdapter *i2c, uint8_t addr, uint8_t reg)
-{
-    uint8_t resp[1];
-    i2c_send(i2c, addr, &reg, 1);
-    i2c_recv(i2c, addr, resp, 1);
-    return resp[0];
-}
-
-static uint16_t tmp105_get16(I2CAdapter *i2c, uint8_t addr, uint8_t reg)
-{
-    uint8_t resp[2];
-    i2c_send(i2c, addr, &reg, 1);
-    i2c_recv(i2c, addr, resp, 2);
-    return (resp[0] << 8) | resp[1];
-}
-
-static void tmp105_set8(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
-                        uint8_t value)
-{
-    uint8_t cmd[2];
-    uint8_t resp[1];
-
-    cmd[0] = reg;
-    cmd[1] = value;
-    i2c_send(i2c, addr, cmd, 2);
-    i2c_recv(i2c, addr, resp, 1);
-    g_assert_cmphex(resp[0], ==, cmd[1]);
-}
-
-static void tmp105_set16(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
-                         uint16_t value)
-{
-    uint8_t cmd[3];
-    uint8_t resp[2];
-
-    cmd[0] = reg;
-    cmd[1] = value >> 8;
-    cmd[2] = value & 255;
-    i2c_send(i2c, addr, cmd, 3);
-    i2c_recv(i2c, addr, resp, 2);
-    g_assert_cmphex(resp[0], ==, cmd[1]);
-    g_assert_cmphex(resp[1], ==, cmd[2]);
-}
-
 static int qmp_tmp105_get_temperature(const char *id)
 {
     QDict *response;
@@ -94,14 +50,14 @@ static void send_and_receive(void)
     value = qmp_tmp105_get_temperature(TMP105_TEST_ID);
     g_assert_cmpuint(value, ==, 0);
 
-    value = tmp105_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_TEMPERATURE);
+    value = i2c_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_TEMPERATURE);
     g_assert_cmphex(value, ==, 0);
 
     qmp_tmp105_set_temperature(TMP105_TEST_ID, 20000);
     value = qmp_tmp105_get_temperature(TMP105_TEST_ID);
     g_assert_cmpuint(value, ==, 20000);
 
-    value = tmp105_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_TEMPERATURE);
+    value = i2c_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_TEMPERATURE);
     g_assert_cmphex(value, ==, 0x1400);
 
     qmp_tmp105_set_temperature(TMP105_TEST_ID, 20938); /* 20 + 15/16 */
@@ -110,24 +66,27 @@ static void send_and_receive(void)
     g_assert_cmpuint(value, <, 20938 + TMP105_PRECISION/2);
 
     /* Set config */
-    tmp105_set8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG, 0x60);
-    value = tmp105_get8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG);
+    i2c_set8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG, 0x60);
+    value = i2c_get8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG);
     g_assert_cmphex(value, ==, 0x60);
 
-    value = tmp105_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_TEMPERATURE);
+    value = i2c_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_TEMPERATURE);
     g_assert_cmphex(value, ==, 0x14f0);
 
     /* Set precision to 9, 10, 11 bits.  */
-    tmp105_set8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG, 0x00);
-    value = tmp105_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_TEMPERATURE);
+    i2c_set8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG, 0x00);
+    g_assert_cmphex(i2c_get8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG), ==, 0x00);
+    value = i2c_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_TEMPERATURE);
     g_assert_cmphex(value, ==, 0x1480);
 
-    tmp105_set8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG, 0x20);
-    value = tmp105_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_TEMPERATURE);
+    i2c_set8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG, 0x20);
+    g_assert_cmphex(i2c_get8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG), ==, 0x20);
+    value = i2c_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_TEMPERATURE);
     g_assert_cmphex(value, ==, 0x14c0);
 
-    tmp105_set8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG, 0x40);
-    value = tmp105_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_TEMPERATURE);
+    i2c_set8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG, 0x40);
+    g_assert_cmphex(i2c_get8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG), ==, 0x40);
+    value = i2c_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_TEMPERATURE);
     g_assert_cmphex(value, ==, 0x14e0);
 
     /* stored precision remains the same */
@@ -135,12 +94,15 @@ static void send_and_receive(void)
     g_assert_cmpuint(value, >=, 20938 - TMP105_PRECISION/2);
     g_assert_cmpuint(value, <, 20938 + TMP105_PRECISION/2);
 
-    tmp105_set8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG, 0x60);
-    value = tmp105_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_TEMPERATURE);
+    i2c_set8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG, 0x60);
+    g_assert_cmphex(i2c_get8(i2c, TMP105_TEST_ADDR, TMP105_REG_CONFIG), ==, 0x60);
+    value = i2c_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_TEMPERATURE);
     g_assert_cmphex(value, ==, 0x14f0);
 
-    tmp105_set16(i2c, TMP105_TEST_ADDR, TMP105_REG_T_LOW, 0x1234);
-    tmp105_set16(i2c, TMP105_TEST_ADDR, TMP105_REG_T_HIGH, 0x4231);
+    i2c_set16(i2c, TMP105_TEST_ADDR, TMP105_REG_T_LOW, 0x1234);
+    g_assert_cmphex(i2c_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_T_LOW), ==, 0x1234);
+    i2c_set16(i2c, TMP105_TEST_ADDR, TMP105_REG_T_HIGH, 0x4231);
+    g_assert_cmphex(i2c_get16(i2c, TMP105_TEST_ADDR, TMP105_REG_T_HIGH), ==, 0x4231);
 }
 
 int main(int argc, char **argv)
-- 
1.8.3.1



