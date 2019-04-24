Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36927C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:17:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02E2221773
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="HgOp5AyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E2221773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42373 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJIi3-0004Bg-7q
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:17:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hJIfe-0002cB-5w
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hJIYT-0006wA-2k
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:07:21 -0400
Received: from m12-14.163.com ([220.181.12.14]:54855)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hJIY5-0006i8-Kb
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=yPoN3JtMf8K84xexdR
	k3En+SE9Vh0h9Hg/YpOfcyn0s=; b=HgOp5AyRS31HS5TSSJZBzqnUpuvg2bxYlq
	FGb4XsyMgRnTTbFQPmJhWcVrIRSMTjCmmJxbnY958FWg/oGzUh5ld98EfhhzrLU+
	pVO7r2C3SW3FCxaW5LZqah9npzRtQqiV5UNr9vkYd4S2yXNYCJqtA3Pkcpd1S/oL
	9Q2IHvvL8=
Received: from localhost.localdomain (unknown [115.200.201.0])
	by smtp10 (Coremail) with SMTP id DsCowAC3Ayl0bcBcrks9CA--.5531S7;
	Wed, 24 Apr 2019 22:06:54 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com, thuth@redhat.com,
	lvivier@redhat.com, pbonzini@redhat.com
Date: Wed, 24 Apr 2019 07:06:43 -0700
Message-Id: <20190424140643.62457-6-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424140643.62457-1-liq3ea@163.com>
References: <20190424140643.62457-1-liq3ea@163.com>
X-CM-TRANSID: DsCowAC3Ayl0bcBcrks9CA--.5531S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFy7trW7Gr43KF4fXr17Awb_yoW8GF15pF
	WUu3WakrZ5JFZFqrnxGr1DWF1ftr97Jr4UJrZ0qrWjyw48Xr1DKa1Ika4Fgws8JFWkXa13
	Z3ZYqF43KF1DXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UCiihUUUUU=
X-Originating-IP: [115.200.201.0]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiTxKgbVsGO+h6qAAAsM
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.14
Subject: [Qemu-devel] [PATCH v2 5/5] tests: fw_cfg: add splash time test case
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
Message-ID: <20190424140643.uSV9P957fN2qsc0SUyvDAy6yUNIQKh9RIlmYVdN6QTo@z>

Signed-off-by: Li Qiang <liq3ea@163.com>
---
Change since v1:
Converting little endian splash time to cpu endian

 tests/fw_cfg-test.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 6c6add54db..c6a3d6bb23 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -194,6 +194,25 @@ static void test_fw_cfg_reboot_timeout(void)
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
+    splash_time = le16_to_cpu(splash_time);
+    g_assert_cmpint(splash_time, ==, 12);
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -216,6 +235,7 @@ int main(int argc, char **argv)
     qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
     qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
     qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout);
+    qtest_add_func("fw_cfg/splash_time", test_fw_cfg_splash_time);
 
     ret = g_test_run();
 
-- 
2.17.1



