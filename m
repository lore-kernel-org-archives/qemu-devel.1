Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF921C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 23:16:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A992086A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 23:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A992086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGAKu-0000QP-PI
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 19:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iGA0o-0004BE-Vg
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 18:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iGA0n-0008TN-Im
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 18:55:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45248)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iGA0k-0008QZ-1N
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 18:55:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5EFBFC057F23;
 Thu,  3 Oct 2019 22:55:42 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC4AD600C4;
 Thu,  3 Oct 2019 22:55:37 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] tests/fw_cfg: Run the tests on big-endian targets
Date: Fri,  4 Oct 2019 00:54:37 +0200
Message-Id: <20191003225437.16651-8-philmd@redhat.com>
In-Reply-To: <20191003225437.16651-1-philmd@redhat.com>
References: <20191003225437.16651-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 03 Oct 2019 22:55:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have been restricting our fw_cfg tests to the PC machine,
which is a little-endian architecture.
The fw_cfg device is also used on the SPARC and PowerPC
architectures, which can run in big-endian configuration.

Since we want to be sure our device does not regress
regardless the endianess used, enable this test one
these targets.

The NUMA selector is X86 specific, restrict it to this arch.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/Makefile.include |  2 ++
 tests/fw_cfg-test.c    | 18 +++++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3543451ed3..322bdb36ff 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -242,6 +242,7 @@ check-qtest-ppc64-$(CONFIG_VGA) +=3D tests/display-vg=
a-test$(EXESUF)
 check-qtest-ppc64-y +=3D tests/numa-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) +=3D tests/ivshmem-test$(EXES=
UF)
 check-qtest-ppc64-y +=3D tests/cpu-plug-test$(EXESUF)
+check-qtest-ppc64-y +=3D tests/fw_cfg-test$(EXESUF)
=20
 check-qtest-sh4-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXESUF)
=20
@@ -250,6 +251,7 @@ check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) =3D tests/end=
ianness-test$(EXESUF)
 check-qtest-sparc-y +=3D tests/prom-env-test$(EXESUF)
 check-qtest-sparc-y +=3D tests/m48t59-test$(EXESUF)
 check-qtest-sparc-y +=3D tests/boot-serial-test$(EXESUF)
+check-qtest-sparc-y +=3D tests/fw_cfg-test$(EXESUF)
=20
 check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXE=
SUF)
 check-qtest-sparc64-y +=3D tests/prom-env-test$(EXESUF)
diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 12dbaf4e67..39bbc9647e 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -209,13 +209,22 @@ static void test_fw_cfg_splash_time(const void *opa=
que)
=20
 int main(int argc, char **argv)
 {
+    const char *arch =3D qtest_get_arch();
     QTestCtx *ctx =3D g_new(QTestCtx, 1);
     int ret;
=20
     g_test_init(&argc, &argv, NULL);
=20
-    ctx->machine_name =3D "pc";
-    ctx->fw_cfg =3D pc_fw_cfg_init();
+    if (g_str_equal(arch, "i386") || g_str_equal(arch, "x86_64")) {
+        ctx->machine_name =3D "pc";
+        ctx->fw_cfg =3D pc_fw_cfg_init();
+    } else if (g_str_equal(arch, "sparc")) {
+        ctx->machine_name =3D "SS-5";
+        ctx->fw_cfg =3D mm_fw_cfg_init(0xd00000510ULL);
+    } else if (g_str_equal(arch, "ppc64")) {
+        ctx->machine_name =3D "mac99";
+        ctx->fw_cfg =3D mm_fw_cfg_init(0xf0000510);
+    }
=20
     qtest_add_data_func("fw_cfg/signature", ctx, test_fw_cfg_signature);
     qtest_add_data_func("fw_cfg/id", ctx, test_fw_cfg_id);
@@ -230,12 +239,15 @@ int main(int argc, char **argv)
     qtest_add_func("fw_cfg/boot_device", test_fw_cfg_boot_device);
 #endif
     qtest_add_data_func("fw_cfg/max_cpus", ctx, test_fw_cfg_max_cpus);
-    qtest_add_data_func("fw_cfg/numa", ctx, test_fw_cfg_numa);
     qtest_add_data_func("fw_cfg/boot_menu", ctx, test_fw_cfg_boot_menu);
     qtest_add_data_func("fw_cfg/reboot_timeout", ctx,
                         test_fw_cfg_reboot_timeout);
     qtest_add_data_func("fw_cfg/splash_time", ctx, test_fw_cfg_splash_ti=
me);
=20
+    if (g_str_equal(arch, "i386") || g_str_equal(arch, "x86_64")) {
+        qtest_add_data_func("fw_cfg/numa", ctx, test_fw_cfg_numa);
+    }
+
     ret =3D g_test_run();
=20
     g_free(ctx->fw_cfg);
--=20
2.20.1


