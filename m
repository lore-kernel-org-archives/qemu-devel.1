Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C45C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:02:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7998520879
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7998520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35715 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnMu-0000Hq-N8
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:02:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTnGl-0003rP-5M
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTn6N-00041K-Hv
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:45:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hTn6N-00040w-Di; Thu, 23 May 2019 08:45:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1C12859FF;
	Thu, 23 May 2019 12:45:42 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D05F268378;
	Thu, 23 May 2019 12:45:38 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 14:43:19 +0200
Message-Id: <20190523124320.28726-15-philmd@redhat.com>
In-Reply-To: <20190523124320.28726-1-philmd@redhat.com>
References: <20190523124320.28726-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Thu, 23 May 2019 12:45:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 14/15] tests: fw_cfg: add 'reboot-timeout' test
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
	"Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	Li Qiang <liq3ea@163.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

Signed-off-by: Li Qiang <liq3ea@163.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190424140643.62457-5-liq3ea@163.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/fw_cfg-test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 4597626dd7..20b1eb75f4 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -15,6 +15,7 @@
 #include "libqtest.h"
 #include "standard-headers/linux/qemu_fw_cfg.h"
 #include "libqos/fw_cfg.h"
+#include "qemu/bswap.h"
=20
 static uint64_t ram_size =3D 128 << 20;
 static uint16_t nb_cpus =3D 1;
@@ -174,6 +175,25 @@ static void test_fw_cfg_boot_menu(void)
     qtest_quit(s);
 }
=20
+static void test_fw_cfg_reboot_timeout(void)
+{
+    QFWCFG *fw_cfg;
+    QTestState *s;
+    uint32_t reboot_timeout =3D 0;
+    size_t filesize;
+
+    s =3D qtest_init("-boot reboot-timeout=3D15");
+    fw_cfg =3D pc_fw_cfg_init(s);
+
+    filesize =3D qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
+                                &reboot_timeout, sizeof(reboot_timeout))=
;
+    g_assert_cmpint(filesize, =3D=3D, sizeof(reboot_timeout));
+    reboot_timeout =3D le32_to_cpu(reboot_timeout);
+    g_assert_cmpint(reboot_timeout, =3D=3D, 15);
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -193,6 +213,7 @@ int main(int argc, char **argv)
     qtest_add_func("fw_cfg/max_cpus", test_fw_cfg_max_cpus);
     qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
     qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
+    qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout);
=20
     return g_test_run();
 }
--=20
2.20.1


