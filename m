Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04EAC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 919FD23EEE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfmLulX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919FD23EEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38494 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqlJ-0004Tg-Pc
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:28:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUQ-0007LI-2J
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUO-0004St-2c
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:17 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqUN-00045w-Ps
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:15 -0400
Received: by mail-wm1-x341.google.com with SMTP id d17so4290234wmb.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:subject:date:message-id:in-reply-to:references;
	bh=uoQaRMWdBdep+YNnKReegUQC2lBBqvjSH/ITdZEowUI=;
	b=bfmLulX6w/jMAYEgy1HkHwFmlvV3tN3sK8ng3erwovapyAkLK5ofVAV1cAjvFsLkb1
	stTKR1LLllzeEhPdnbZ1bIxPrnVaNVk68V3o546vL7cBf2PE9PXrzRiWAfYAXtCnpmcz
	VA1ornolXIiUjZFsTbSsO40qM58Tuc70mjBtxDXiqipbfLBkVfJblBwIbpgoHBMmQY1u
	44DPJH5QX3VCnCshMPtfxyPclAfaRrdxpgP7l0TuPkXGzgI/GIvBWZbXLv5/Go7uVyng
	5ILbd6Bng79M4xsj26WTHFmFJbnESwJ7Zt0g0K8xQDupyKBS4nAGbb4ewf9KdkzlyGMA
	bkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:subject:date:message-id
	:in-reply-to:references;
	bh=uoQaRMWdBdep+YNnKReegUQC2lBBqvjSH/ITdZEowUI=;
	b=BBo+ELsxyoLERKJ2SkL47MJbv+6Q979VFMCRFSa2fxPFkBarBK/i5NblNQZ6R6584p
	a6Ius/iGgsMS/PFlWa1dBhXg4p0rCMz7cZHTQoxBmjesiB3qH0t8hUUt7hVvYeGnRASu
	DvkLYfxMyJ/YSmat9f8F4PBUQ/jqztBdjRQh9oOCtIHAdNJ/W9ukL1A4si48AXSD82UV
	AYW6wAq1a6iLsHNM5SFsfJ36Gb1fqUtyq+KINB6ZVfBv88x6TWfJCaJua6bzeD7wWHTX
	KNB3zChR+RB0GUtMYKJrFWw9QxYL3tNHAah2/7fhM7kzmjUI1HXKJg/WCkDMSwwez/f/
	iGoQ==
X-Gm-Message-State: APjAAAWnnb4F9yIsaqFBbMatF33zl51i5RujzT1Xi9o80Dg69CrvTT30
	gAwSDEmySuPyi9itO+cHs4qj7PVC
X-Google-Smtp-Source: APXvYqzyAKonLVWMKV2uDNSlbYewUd+j2k/H2HEUb0YkWqLxIjIMmWJmZ2IFlVQmO6C6sUgDqpoY8A==
X-Received: by 2002:a1c:6c04:: with SMTP id h4mr14601664wmc.135.1559581861355; 
	Mon, 03 Jun 2019 10:11:01 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.11.00 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:11:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:34 +0200
Message-Id: <1559581843-3968-16-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PULL 15/24] libqos: split I2CAdapter initialization
 and allocation
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

Provide *_init functions that populate an I2CAdapter struct without
allocating one, and make the existing *_create functions wrap them.

Because in the new setup *_create might return a pointer inside the
IMXI2C or OMAPI2C struct, create companion *_free functions to go
back to the outer pointer.

All this is temporary until allocation will be handled entirely by
qgraph.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/libqos/i2c-imx.c  | 37 ++++++++++++++++++++++---------------
 tests/libqos/i2c-omap.c | 32 +++++++++++++++++++++-----------
 tests/libqos/i2c.h      | 20 ++++++++++++++++++--
 tests/pca9552-test.c    |  2 +-
 tests/tmp105-test.c     |  2 +-
 5 files changed, 63 insertions(+), 30 deletions(-)

diff --git a/tests/libqos/i2c-imx.c b/tests/libqos/i2c-imx.c
index 0945f2e..28289c5 100644
--- a/tests/libqos/i2c-imx.c
+++ b/tests/libqos/i2c-imx.c
@@ -30,13 +30,6 @@ enum IMXI2CDirection {
     IMX_I2C_WRITE,
 };
 
-typedef struct IMXI2C {
-    I2CAdapter parent;
-
-    uint64_t addr;
-} IMXI2C;
-
-
 static void imx_i2c_set_slave_addr(IMXI2C *s, uint8_t addr,
                                    enum IMXI2CDirection direction)
 {
@@ -47,7 +40,7 @@ static void imx_i2c_set_slave_addr(IMXI2C *s, uint8_t addr,
 static void imx_i2c_send(I2CAdapter *i2c, uint8_t addr,
                          const uint8_t *buf, uint16_t len)
 {
-    IMXI2C *s = (IMXI2C *)i2c;
+    IMXI2C *s = container_of(i2c, IMXI2C, parent);
     uint8_t data;
     uint8_t status;
     uint16_t size = 0;
@@ -107,7 +100,7 @@ static void imx_i2c_send(I2CAdapter *i2c, uint8_t addr,
 static void imx_i2c_recv(I2CAdapter *i2c, uint8_t addr,
                          uint8_t *buf, uint16_t len)
 {
-    IMXI2C *s = (IMXI2C *)i2c;
+    IMXI2C *s = container_of(i2c, IMXI2C, parent);
     uint8_t data;
     uint8_t status;
     uint16_t size = 0;
@@ -193,16 +186,30 @@ static void imx_i2c_recv(I2CAdapter *i2c, uint8_t addr,
     g_assert((status & I2SR_IBB) == 0);
 }
 
+void imx_i2c_init(IMXI2C *s, QTestState *qts, uint64_t addr)
+{
+    s->addr = addr;
+
+    s->parent.send = imx_i2c_send;
+    s->parent.recv = imx_i2c_recv;
+    s->parent.qts = qts;
+}
+
 I2CAdapter *imx_i2c_create(QTestState *qts, uint64_t addr)
 {
     IMXI2C *s = g_malloc0(sizeof(*s));
-    I2CAdapter *i2c = (I2CAdapter *)s;
 
-    s->addr = addr;
+    imx_i2c_init(s, qts, addr);
+    return &s->parent;
+}
 
-    i2c->send = imx_i2c_send;
-    i2c->recv = imx_i2c_recv;
-    i2c->qts = qts;
+void imx_i2c_free(I2CAdapter *i2c)
+{
+    IMXI2C *s;
 
-    return i2c;
+    if (!i2c) {
+        return;
+    }
+    s = container_of(i2c, IMXI2C, parent);
+    g_free(s);
 }
diff --git a/tests/libqos/i2c-omap.c b/tests/libqos/i2c-omap.c
index bb65336..c7cbb9e 100644
--- a/tests/libqos/i2c-omap.c
+++ b/tests/libqos/i2c-omap.c
@@ -40,12 +40,6 @@ enum OMAPI2CCONBits {
     OMAP_I2C_CON_I2C_EN = 1 << 15,
 };
 
-typedef struct OMAPI2C {
-    I2CAdapter parent;
-
-    uint64_t addr;
-} OMAPI2C;
-
 
 static void omap_i2c_set_slave_addr(OMAPI2C *s, uint8_t addr)
 {
@@ -59,7 +53,7 @@ static void omap_i2c_set_slave_addr(OMAPI2C *s, uint8_t addr)
 static void omap_i2c_send(I2CAdapter *i2c, uint8_t addr,
                           const uint8_t *buf, uint16_t len)
 {
-    OMAPI2C *s = (OMAPI2C *)i2c;
+    OMAPI2C *s = container_of(i2c, OMAPI2C, parent);
     uint16_t data;
 
     omap_i2c_set_slave_addr(s, addr);
@@ -103,7 +97,7 @@ static void omap_i2c_send(I2CAdapter *i2c, uint8_t addr,
 static void omap_i2c_recv(I2CAdapter *i2c, uint8_t addr,
                           uint8_t *buf, uint16_t len)
 {
-    OMAPI2C *s = (OMAPI2C *)i2c;
+    OMAPI2C *s = container_of(i2c, OMAPI2C, parent);
     uint16_t data, stat;
     uint16_t orig_len = len;
 
@@ -161,9 +155,8 @@ static void omap_i2c_recv(I2CAdapter *i2c, uint8_t addr,
     g_assert((data & OMAP_I2C_CON_STP) == 0);
 }
 
-I2CAdapter *omap_i2c_create(QTestState *qts, uint64_t addr)
+void omap_i2c_init(OMAPI2C *s, QTestState *qts, uint64_t addr)
 {
-    OMAPI2C *s = g_malloc0(sizeof(*s));
     I2CAdapter *i2c = (I2CAdapter *)s;
     uint16_t data;
 
@@ -176,6 +169,23 @@ I2CAdapter *omap_i2c_create(QTestState *qts, uint64_t addr)
     /* verify the mmio address by looking for a known signature */
     data = qtest_readw(qts, addr + OMAP_I2C_REV);
     g_assert_cmphex(data, ==, 0x34);
+}
+
+I2CAdapter *omap_i2c_create(QTestState *qts, uint64_t addr)
+{
+    OMAPI2C *s = g_malloc0(sizeof(*s));
+
+    omap_i2c_init(s, qts, addr);
+    return &s->parent;
+}
 
-    return i2c;
+void omap_i2c_free(I2CAdapter *i2c)
+{
+    OMAPI2C *s;
+
+    if (!i2c) {
+        return;
+    }
+    s = container_of(i2c, OMAPI2C, parent);
+    g_free(s);
 }
diff --git a/tests/libqos/i2c.h b/tests/libqos/i2c.h
index a462114..877d2ab 100644
--- a/tests/libqos/i2c.h
+++ b/tests/libqos/i2c.h
@@ -39,10 +39,26 @@ void i2c_set8(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
 void i2c_set16(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
                uint16_t value);
 
-/* libi2c-omap.c */
+/* i2c-omap.c */
+typedef struct OMAPI2C {
+    I2CAdapter parent;
+
+    uint64_t addr;
+} OMAPI2C;
+
+void omap_i2c_init(OMAPI2C *s, QTestState *qts, uint64_t addr);
 I2CAdapter *omap_i2c_create(QTestState *qts, uint64_t addr);
+void omap_i2c_free(I2CAdapter *i2c);
+
+/* i2c-imx.c */
+typedef struct IMXI2C {
+    I2CAdapter parent;
+
+    uint64_t addr;
+} IMXI2C;
 
-/* libi2c-imx.c */
+void imx_i2c_init(IMXI2C *s, QTestState *qts, uint64_t addr);
 I2CAdapter *imx_i2c_create(QTestState *qts, uint64_t addr);
+void imx_i2c_free(I2CAdapter *i2c);
 
 #endif
diff --git a/tests/pca9552-test.c b/tests/pca9552-test.c
index 89b4445..f950932 100644
--- a/tests/pca9552-test.c
+++ b/tests/pca9552-test.c
@@ -96,7 +96,7 @@ int main(int argc, char **argv)
     if (s) {
         qtest_quit(s);
     }
-    g_free(i2c);
+    omap_i2c_free(i2c);
 
     return ret;
 }
diff --git a/tests/tmp105-test.c b/tests/tmp105-test.c
index c86d257..25ea05f 100644
--- a/tests/tmp105-test.c
+++ b/tests/tmp105-test.c
@@ -122,7 +122,7 @@ int main(int argc, char **argv)
     ret = g_test_run();
 
     qtest_quit(s);
-    g_free(i2c);
+    omap_i2c_free(i2c);
 
     return ret;
 }
-- 
1.8.3.1



