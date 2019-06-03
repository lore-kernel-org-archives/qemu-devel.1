Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FB6C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28672275CB
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARBcdiR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28672275CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38469 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqjP-0002dn-9P
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:26:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUV-0007Vf-5k
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUT-0004dI-VE
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:23 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqUQ-00041K-7v
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:20 -0400
Received: by mail-wr1-x444.google.com with SMTP id n4so9858167wrs.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:subject:date:message-id:in-reply-to:references;
	bh=vgPNCTWPR6hZCIfyU4XsAQRjfaEbN+8hR83G4zbsugU=;
	b=ARBcdiR+Vqg8Mr/QTvJ6DNif9W59CXbdwM7AsKmKe/77/zALmnEtgkx3NL92oV6cj2
	avU14ne22GwBsqfG7kH1fH3bZz/I/vL8l4dMMDM1hpOS1NY/5WC+mY8rq3ZhGWwsOLCg
	RttDokmUvr13HtT13vd1B5Mdysjf69GyaFYhk8PDwNxW6iwhv+U8HgjNpEkRrJEd5/3H
	OiIJixXh2TX6LoaSqplvWOf25duwdyNeS80TcQhb9E8TlC8g/zNZxQybp6eOfn42CJne
	1w/lCvInEIeCl1AxFTZBnM9DIz8Ipl0E1HmLMBTu86hfQUsxqMZFX5PUNE/zkfd6HpiA
	ZxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:subject:date:message-id
	:in-reply-to:references;
	bh=vgPNCTWPR6hZCIfyU4XsAQRjfaEbN+8hR83G4zbsugU=;
	b=IpOUQBMxiVn2NTv5PEbAf6AuNwrJL8ZDb8Q3DPyYoXFlreO1rOMU8st6TSmjiMYFLM
	5w6oUHiLmI4UQAX4DUFUg8AgYkvvDU/1uv692V5UfVs11kRpWlOs1/ALWuTcLqXSTklm
	Q62oLZxwELliJ3aQtqwRXjnx9qC3yRvioMri2DgqHX9uiaLtZhbfXtaMPDv8bgYiTJJc
	uK0dPOCPze9WdXdYxELbwr8ryck1SSGQy6nPKoB0LNigk6FRU548Fez4oxmWElwddQgx
	kJoY1OqIh4atVj2Jvmw+Bh6yKBm/4zuRKV9So8GtFlxAvf+i+5jW4hVkdcY5nNcbb/Mm
	tIzA==
X-Gm-Message-State: APjAAAVsL21oEwTeBHJqhGK7MKo3bOPCCEqLGDp/nlHq2Ot1nY9oB/rF
	QFQV3IsO8gLjKA4gmhtyUNAJ0ZHB
X-Google-Smtp-Source: APXvYqz5YXvvAhifupJE8LR96J/f/1waTbplqx6iaZBZNeNDNelYnaqS79+7ZeEZlo2Pxjjdtj1o6Q==
X-Received: by 2002:adf:f544:: with SMTP id j4mr3421411wrp.150.1559581858567; 
	Mon, 03 Jun 2019 10:10:58 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.10.56 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:10:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:31 +0200
Message-Id: <1559581843-3968-13-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL 12/24] libqos: fix omap-i2c receiving more than
 4 bytes
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

If more than 4 bytes are received, the FIFO cannot host the entire
contents of the transfer and STP will be nonzero before entering
the transfer loop.  Also, CNT will contain the number of bytes
left to be transferred instead of the total number of bytes in
the transfer.

(Reverse engineered from the omap_i2c.c source code; no available
datasheet).

This will fix ds1338-test for omap-i2c.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/libqos/i2c-omap.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tests/libqos/i2c-omap.c b/tests/libqos/i2c-omap.c
index 1ef6e7b..bb65336 100644
--- a/tests/libqos/i2c-omap.c
+++ b/tests/libqos/i2c-omap.c
@@ -105,6 +105,7 @@ static void omap_i2c_recv(I2CAdapter *i2c, uint8_t addr,
 {
     OMAPI2C *s = (OMAPI2C *)i2c;
     uint16_t data, stat;
+    uint16_t orig_len = len;
 
     omap_i2c_set_slave_addr(s, addr);
 
@@ -116,16 +117,24 @@ static void omap_i2c_recv(I2CAdapter *i2c, uint8_t addr,
            OMAP_I2C_CON_STT |
            OMAP_I2C_CON_STP;
     qtest_writew(i2c->qts, s->addr + OMAP_I2C_CON, data);
-    data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_CON);
-    g_assert((data & OMAP_I2C_CON_STP) == 0);
 
     data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_STAT);
     g_assert((data & OMAP_I2C_STAT_NACK) == 0);
 
-    data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_CNT);
-    g_assert_cmpuint(data, ==, len);
-
     while (len > 0) {
+        data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_CON);
+        if (len <= 4) {
+            g_assert((data & OMAP_I2C_CON_STP) == 0);
+
+            data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_CNT);
+            g_assert_cmpuint(data, ==, orig_len);
+        } else {
+            g_assert((data & OMAP_I2C_CON_STP) != 0);
+
+            data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_CNT);
+            g_assert_cmpuint(data, ==, len - 4);
+        }
+
         data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_STAT);
         g_assert((data & OMAP_I2C_STAT_RRDY) != 0);
         g_assert((data & OMAP_I2C_STAT_ROVR) == 0);
-- 
1.8.3.1



