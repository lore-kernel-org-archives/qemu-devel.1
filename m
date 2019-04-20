Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6D5C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 10:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 607C120675
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 10:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="GGdm3ck+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607C120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39440 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHmtD-0002PK-Hk
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 06:06:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHmrJ-000119-4a
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHmoD-00058K-LP
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:01:22 -0400
Received: from m12-14.163.com ([220.181.12.14]:59555)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHmoC-00056X-HD
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=WutwQeyfp9GXWhkPQ9
	MxzsQDlnRQ/i/PTU1PssIvR+8=; b=GGdm3ck+IWWatnqPRDfOgoZxisKW3fZ0Ru
	19mH96zfvLOiUG64UXnVySlsfHkI8CRTD0DlUL9kVXASL09vqkoFhPuE52PkHKyP
	qUUyyv6w0N391GB1eTRIBgZtrdwEncYWWov/QJ0exl/JuG1V0seCYEM0QOEEgCn5
	MWHKNK7yk=
Received: from localhost.localdomain (unknown [183.159.69.175])
	by smtp10 (Coremail) with SMTP id DsCowACHzxnk7bpcMStGBQ--.39886S5;
	Sat, 20 Apr 2019 18:01:15 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
	philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com
Date: Sat, 20 Apr 2019 03:00:55 -0700
Message-Id: <20190420100056.116305-4-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420100056.116305-1-liq3ea@163.com>
References: <20190420100056.116305-1-liq3ea@163.com>
X-CM-TRANSID: DsCowACHzxnk7bpcMStGBQ--.39886S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7AryDuw1UCrWDuFyUGw1kAFb_yoW8JF43pr
	1jkF1qkrZ3JFW2qr13Kr1qqr13tr97Cw48ArZrXFWIyw18Gr1Dta18CasYg3WDWFWIvFs8
	Z3WvqF13KF1DJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UGksgUUUUU=
X-Originating-IP: [183.159.69.175]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBoQOcbVQHEkbMsAAAso
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.14
Subject: [Qemu-devel] [PATCH 3/4] tests: fw_cfg: add reboot_timeout test case
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
Message-ID: <20190420100055.CAph-vbP287EJv5t_7dLj-CK66G4wiBT6EdpLXvrePA@z>

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 tests/fw_cfg-test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index c22503619f..9f75dbb5f4 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -174,6 +174,24 @@ static void test_fw_cfg_boot_menu(void)
     qtest_quit(s);
 }
 
+static void test_fw_cfg_reboot_timeout(void)
+{
+    QFWCFG *fw_cfg;
+    QTestState *s;
+    uint32_t reboot_timeout = 0;
+    size_t filesize;
+
+    s = qtest_init("-boot reboot-timeout=15");
+    fw_cfg = pc_fw_cfg_init(s);
+
+    filesize = qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
+                     &reboot_timeout, sizeof(reboot_timeout));
+    g_assert_cmpint(filesize, ==, sizeof(reboot_timeout));
+    g_assert_cmpint(reboot_timeout, ==, 15);
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -195,6 +213,7 @@ int main(int argc, char **argv)
     qtest_add_func("fw_cfg/max_cpus", test_fw_cfg_max_cpus);
     qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
     qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
+    qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout);
 
     ret = g_test_run();
 
-- 
2.17.1



