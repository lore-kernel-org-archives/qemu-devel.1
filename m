Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA94C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 16:02:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6842F20651
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 16:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="jp9HjPVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6842F20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42822 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHsRk-0007PT-L0
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 12:02:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsPK-0005w9-73
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:00:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsPJ-0008Fy-A8
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:00:02 -0400
Received: from m12-11.163.com ([220.181.12.11]:33864)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsPI-0008F3-4s
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=w4ygKr81NYHHj0JHeC
	mMA9n1b8fxsPI3UkzRPp2GlvU=; b=jp9HjPVsY8Snt97LB1FHL2YEcDpWnOfEFi
	ta8Uwku8yYxE1EAZNef/iiRRskYYcJco6dA1TALpAoDk7l37blOHbjwnJprzqvjp
	FF59xmbFgP+dwJ5liT0NIUtgOhK4gG6tIsGsHqPgqjJGZNKdirlGBPV0tflaa3cQ
	yDOGtVuyo=
Received: from localhost.localdomain (unknown [183.159.69.175])
	by smtp7 (Coremail) with SMTP id C8CowACX_I34QbtcELxpBQ--.29437S3;
	Sat, 20 Apr 2019 23:59:55 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: jslaby@suse.cz,
	pbonzini@redhat.com
Date: Sat, 20 Apr 2019 08:59:47 -0700
Message-Id: <20190420155949.130968-2-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420155949.130968-1-liq3ea@163.com>
References: <20190420155949.130968-1-liq3ea@163.com>
X-CM-TRANSID: C8CowACX_I34QbtcELxpBQ--.29437S3
X-Coremail-Antispam: 1Uf129KBjvJXoWrZF48CF17GFyxAFW3Ar1xuFg_yoW8JF13pF
	1Uu3WYkrZ5JFZFqr13Gr1qqr1ftr97Cw18JrZxXFWjyw48Xr1DKa10ka4Fgrn8JF48Xanx
	Z3ZYqF43KF1DXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQNVkUUUUU=
X-Originating-IP: [183.159.69.175]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiKRmcbVXlqvAo4QABsj
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.11
Subject: [Qemu-devel] [PATCH v2 1/3] tests: fw_cfg: add splash time test case
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
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420155947.PnmvdkuYTYsmPe0GAGK_ulT4r0h__43G7xvz6e_lzo8@z>

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 tests/fw_cfg-test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 9f75dbb5f4..de8e81ea9d 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -192,6 +192,24 @@ static void test_fw_cfg_reboot_timeout(void)
     qtest_quit(s);
 }
 
+static void test_fw_cfg_splash_time(void)
+{
+    QFWCFG *fw_cfg;
+    QTestState *s;
+    uint16_t splash_time = 0;
+    size_t filesize;
+
+    s = qtest_init("-boot splash-time=12");
+    fw_cfg = pc_fw_cfg_init(s);
+
+    filesize = qfw_cfg_get_file(fw_cfg, "etc/boot-menu-wait",
+                     &splash_time, sizeof(splash_time));
+    g_assert_cmpint(filesize, ==, sizeof(splash_time));
+    g_assert_cmpint(splash_time, ==, 12);
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -214,6 +232,7 @@ int main(int argc, char **argv)
     qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
     qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
     qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout);
+    qtest_add_func("fw_cfg/splash_time", test_fw_cfg_splash_time);
 
     ret = g_test_run();
 
-- 
2.17.1



