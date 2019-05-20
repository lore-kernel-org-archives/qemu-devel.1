Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AF8C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C942171F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C942171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42332 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSq5h-0007xK-Nk
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 17:45:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSpyV-0002Ad-PG
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSpyS-00043M-FX
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:37:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18675)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hSpyS-00042o-AT
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:37:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6F07308FC4D;
	Mon, 20 May 2019 21:37:35 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-28.brq.redhat.com [10.40.204.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BC295D704;
	Mon, 20 May 2019 21:37:32 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 20 May 2019 23:37:00 +0200
Message-Id: <20190520213700.12620-8-philmd@redhat.com>
In-Reply-To: <20190520213700.12620-1-philmd@redhat.com>
References: <20190520213700.12620-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 20 May 2019 21:37:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 7/7] tests: fw_cfg: add 'splash-time' test
 case
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>, Li Qiang <liq3ea@163.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

Signed-off-by: Li Qiang <liq3ea@163.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190424140643.62457-6-liq3ea@163.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/fw_cfg-test.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 20b1eb75f4d..1d3147f8214 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -194,6 +194,25 @@ static void test_fw_cfg_reboot_timeout(void)
     qtest_quit(s);
 }
=20
+static void test_fw_cfg_splash_time(void)
+{
+    QFWCFG *fw_cfg;
+    QTestState *s;
+    uint16_t splash_time =3D 0;
+    size_t filesize;
+
+    s =3D qtest_init("-boot splash-time=3D12");
+    fw_cfg =3D pc_fw_cfg_init(s);
+
+    filesize =3D qfw_cfg_get_file(fw_cfg, "etc/boot-menu-wait",
+                                &splash_time, sizeof(splash_time));
+    g_assert_cmpint(filesize, =3D=3D, sizeof(splash_time));
+    splash_time =3D le16_to_cpu(splash_time);
+    g_assert_cmpint(splash_time, =3D=3D, 12);
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -214,6 +233,7 @@ int main(int argc, char **argv)
     qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
     qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
     qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout);
+    qtest_add_func("fw_cfg/splash_time", test_fw_cfg_splash_time);
=20
     return g_test_run();
 }
--=20
2.20.1


