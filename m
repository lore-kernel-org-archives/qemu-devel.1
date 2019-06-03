Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25149C28CC6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF49E26539
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3TfGzAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF49E26539
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38496 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqm1-00057l-46
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:29:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUW-0007X3-Kk
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUU-0004eZ-6H
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:24 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqUT-00043E-UO
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:22 -0400
Received: by mail-wm1-x342.google.com with SMTP id g135so8825733wme.4
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:subject:date:message-id:in-reply-to:references;
	bh=hDt9uPR7rzEo7ud7l9pi841FaWW9ftZDCffNNeB3xZo=;
	b=E3TfGzAj9MQcvKRYGTKKhQR/MCbZjR9Cl3BXMU8vZSlv5CmhmDhU1rSRd2BJte/plv
	9twTo3giQF94g9yae201BoIH8XikmwS9m8bTkspcRsn/79v5mdHr/USZIpb9j2dw97p3
	aNYDoQhKcTlNTX4sNuDuej5v2qWznWNT0nZZe01wX/nujLmpGov6lhrEChamxwqRVUpH
	RUcUpT+qI3VPtcXwPhmn17Ifl30AnTspDTg1XTlNux9ZrXJE+tGOali8SPWNdJl37Bg5
	gjl4ZGPLaaxKNATn5Wn3/cA6ZkJn3j8ZDZSVcAoAmuc1/vWZ0n7cFDlgwMg2IgBJjU2a
	Pz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:subject:date:message-id
	:in-reply-to:references;
	bh=hDt9uPR7rzEo7ud7l9pi841FaWW9ftZDCffNNeB3xZo=;
	b=OSTEP/MG7f/m2hgtsoMpw1jRgR+Q00Pv8srVgRNjh4/uKZ9et8wyqLwPphnC7Jkfsc
	yHr8Bpo8nThAcgnQKx73vDeQtzMHwwuzV0QLFJJFa+g6xZMK0rf01We/abCGPdOQTlNK
	XL91dWePrw9sa0EIHbbuCJJLNHM4an1BBk79OKfgiJe6hLXWHUvTdwedLIC7uCNKG8Ro
	K+VvuiI+uTZ6NPZQRU/NqfIiKSiSaCAnkjp1a3H7/zgeRwKUN8gSbjfV1y6AmmfEvVuy
	ZTaiW6YWkxeZowk0hVoKIa+vMDy3miHV3vFV23+S4ZQXXd7zDf2vtHMiQLLnbhmK5U5X
	151A==
X-Gm-Message-State: APjAAAXCBcjg+NQZiQJKlQEFAGl2kNzNO6Ek76xo9GTuueZp1jTb76so
	kpo/skfA8z2bltQFDIEbHT3VUNKN
X-Google-Smtp-Source: APXvYqxZi8LSLprypd4JzO8At29JdMqFoifjOjn+VIj4SVvByWBn6DRo7T924C8qklRMepfrZm+n7w==
X-Received: by 2002:a1c:b3c3:: with SMTP id c186mr15433654wmf.93.1559581859524;
	Mon, 03 Jun 2019 10:10:59 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.10.58 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:10:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:32 +0200
Message-Id: <1559581843-3968-14-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PULL 13/24] pca9552-test: do not rely on state across
 tests
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

receive_autoinc is relying on the LED state that is set by
send_and_receive.  Stop doing that, because qgraph resets the
machine between tests.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/pca9552-test.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tests/pca9552-test.c b/tests/pca9552-test.c
index 06359b7..89b4445 100644
--- a/tests/pca9552-test.c
+++ b/tests/pca9552-test.c
@@ -18,11 +18,20 @@
 
 static I2CAdapter *i2c;
 
+static void pca9552_init(I2CAdapter *i2c)
+{
+    /* Switch on LEDs 0 and 12 */
+    i2c_set8(i2c, PCA9552_TEST_ADDR, PCA9552_LS0, 0x54);
+    i2c_set8(i2c, PCA9552_TEST_ADDR, PCA9552_LS3, 0x54);
+}
+
 static void receive_autoinc(void)
 {
     uint8_t resp;
     uint8_t reg = PCA9552_LS0 | PCA9552_AUTOINC;
 
+    pca9552_init(i2cdev);
+
     i2c_send(i2c, PCA9552_TEST_ADDR, &reg, 1);
 
     /* PCA9552_LS0 */
@@ -52,16 +61,14 @@ static void send_and_receive(void)
     value = i2c_get8(i2c, PCA9552_TEST_ADDR, PCA9552_INPUT0);
     g_assert_cmphex(value, ==, 0x0);
 
-    /* Switch on LED 0 */
-    i2c_set8(i2c, PCA9552_TEST_ADDR, PCA9552_LS0, 0x54);
+    pca9552_init(i2cdev);
+
     value = i2c_get8(i2c, PCA9552_TEST_ADDR, PCA9552_LS0);
     g_assert_cmphex(value, ==, 0x54);
 
     value = i2c_get8(i2c, PCA9552_TEST_ADDR, PCA9552_INPUT0);
     g_assert_cmphex(value, ==, 0x01);
 
-    /* Switch on LED 12 */
-    i2c_set8(i2c, PCA9552_TEST_ADDR, PCA9552_LS3, 0x54);
     value = i2c_get8(i2c, PCA9552_TEST_ADDR, PCA9552_LS3);
     g_assert_cmphex(value, ==, 0x54);
 
-- 
1.8.3.1



