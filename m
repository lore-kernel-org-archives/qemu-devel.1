Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C3EC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B9D24AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3VgkKfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B9D24AB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38352 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqcQ-0004yT-8Z
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:19:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUQ-0007LM-2Y
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUO-0004Sl-0I
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:17 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:39501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqUN-00044T-PS
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:15 -0400
Received: by mail-wr1-x431.google.com with SMTP id x4so12921292wrt.6
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:subject:date:message-id:in-reply-to:references;
	bh=7SaMpOvODHuGBK9ZU2E8tUIRm7zqRrLcE07dgiBjSQ4=;
	b=X3VgkKfKpIY7JtX5dplho2vAfvmcPqMqeSSRWWVQCtQMGuv13o6cRhx8htUBqfMR+L
	f5nzNpJz/1ogHF80AArhnEACKfmxggKT0A80Er6qkgIbb9n4P759/9KSa0tnPC/GSQWF
	xaF/kSDaJcZ5HT/MeAesJbkJxJ4bheJaDFlOEG3uEYfRK7CF4OKyV5VfbvlnbjndWcj0
	qNB9DDnXE1Bd0JwKaJylPkkDkOH3wa1t/tBMqdPsfKIqnLDSfps0BgDgMSfIGnaRfYoV
	+NaBpwiFaFilB+nRKbnO0+6Er1uy6kAwOG7UHCxZ1SICLQmHQQ8ePeZIvUdXuynABlII
	zx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:subject:date:message-id
	:in-reply-to:references;
	bh=7SaMpOvODHuGBK9ZU2E8tUIRm7zqRrLcE07dgiBjSQ4=;
	b=tYQInRg/1uY5KEzH8IGHJeVf13i+balmwkz21mATPVphMxKXFJj42kz0sWszIoRcz7
	5V4DqXGYgBH7gmXX8pWooOGcC9DO5ouk5n19x60OzPbyiOozqVG1hAi6XXQizb6dG8ko
	8LAv4Rr2sVQj2F0zTeyD0QC8Ugyo2oeZLzvpG9Fx9dKzHAAm97f+GMGIZObjXQyuXYAh
	i9hizPgcZOYWch8x1YmVTsd9eUWoXLmnNN//lrJihPn1q6zhO1fgIUaLI8vmPBx8ibWx
	7jmhoRXMsvQt94gqIyUU05hESdMgno/kjkudZWvXZjUmOjIMrXh5ux2cZMkv8JowBQLD
	2qmA==
X-Gm-Message-State: APjAAAXBO7CmSGO1mq+0EVt+J009/o5Ee/KzoXFHOUe/q7kS9l1AtNTe
	qKeLwQF3sOfZhr8VMDa+I4YfwFGB
X-Google-Smtp-Source: APXvYqxcc7WzNISrJDypuJ0688/t3ZzQb8jJFepfE134h9m/JhNvCeAkg3CNS1skIXq6QbQosU/jKA==
X-Received: by 2002:adf:f542:: with SMTP id j2mr3498147wrp.16.1559581860404;
	Mon, 03 Jun 2019 10:11:00 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.10.59 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:10:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:33 +0200
Message-Id: <1559581843-3968-15-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PULL 14/24] imx25-pdk: create ds1338 for qtest inside
 the test
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

There is no need to have a test device created by the board.
Instead, create it in the qtest so that we will be able to run
it on other boards too.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/arm/imx25_pdk.c  | 9 ---------
 tests/ds1338-test.c | 2 +-
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index eef1b18..a0423ff 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -131,15 +131,6 @@ static void imx25_pdk_init(MachineState *machine)
      */
     if (!qtest_enabled()) {
         arm_load_kernel(&s->soc.cpu, &imx25_pdk_binfo);
-    } else {
-        /*
-         * This I2C device doesn't exist on the real board.
-         * We add it here (only on qtest usage) to be able to do a bit
-         * of simple qtest. See "make check" for details.
-         */
-        i2c_create_slave((I2CBus *)qdev_get_child_bus(DEVICE(&s->soc.i2c[0]),
-                                                      "i2c-bus.0"),
-                         "ds1338", 0x68);
     }
 }
 
diff --git a/tests/ds1338-test.c b/tests/ds1338-test.c
index 88f829f..bd72a15 100644
--- a/tests/ds1338-test.c
+++ b/tests/ds1338-test.c
@@ -54,7 +54,7 @@ int main(int argc, char **argv)
 
     g_test_init(&argc, &argv, NULL);
 
-    s = qtest_start("-display none -machine imx25-pdk");
+    s = qtest_start("-display none -machine imx25-pdk -device ds1338,address=0x68");
     i2c = imx_i2c_create(s, IMX25_I2C_0_BASE);
     addr = DS1338_ADDR;
 
-- 
1.8.3.1



