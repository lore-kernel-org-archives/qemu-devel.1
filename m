Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F6CC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE26321773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE26321773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51334 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT2R4-0001Jg-Tc
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:55:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hT2PC-0008UF-EV
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:54:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hT2PB-0004db-D4
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:54:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hT2PB-0004ci-5a
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:54:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 82B08C0524FB;
	Tue, 21 May 2019 10:54:00 +0000 (UTC)
Received: from thuth.com (ovpn-116-22.ams2.redhat.com [10.36.116.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 988B46085B;
	Tue, 21 May 2019 10:53:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:53:35 +0200
Message-Id: <20190521105344.11637-5-thuth@redhat.com>
In-Reply-To: <20190521105344.11637-1-thuth@redhat.com>
References: <20190521105344.11637-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Tue, 21 May 2019 10:54:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/13] tests/q35-test: Make test independent of
 global_qtest
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
Cc: kwolf@redhat.com, lvivier@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use a local QTestState variable, so that we can finally get rid
of the undesired global_qtest variable in this file, too.

Message-Id: <20190515174328.16361-3-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/q35-test.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/tests/q35-test.c b/tests/q35-test.c
index 34b34bc2b9..a68183d513 100644
--- a/tests/q35-test.c
+++ b/tests/q35-test.c
@@ -84,10 +84,11 @@ static void test_smram_lock(void)
     QPCIBus *pcibus;
     QPCIDevice *pcidev;
     QDict *response;
+    QTestState *qts;
=20
-    qtest_start("-M q35");
+    qts =3D qtest_init("-M q35");
=20
-    pcibus =3D qpci_new_pc(global_qtest, NULL);
+    pcibus =3D qpci_new_pc(qts, NULL);
     g_assert(pcibus !=3D NULL);
=20
     pcidev =3D qpci_device_find(pcibus, 0);
@@ -106,7 +107,7 @@ static void test_smram_lock(void)
     g_assert(smram_test_bit(pcidev, MCH_HOST_BRIDGE_SMRAM_D_OPEN) =3D=3D=
 false);
=20
     /* reset */
-    response =3D qmp("{'execute': 'system_reset', 'arguments': {} }");
+    response =3D qtest_qmp(qts, "{'execute': 'system_reset', 'arguments'=
: {} }");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     qobject_unref(response);
@@ -120,33 +121,29 @@ static void test_smram_lock(void)
     g_free(pcidev);
     qpci_free_pc(pcibus);
=20
-    qtest_end();
+    qtest_quit(qts);
 }
=20
 static void test_tseg_size(const void *data)
 {
     const TsegSizeArgs *args =3D data;
-    char *cmdline;
     QPCIBus *pcibus;
     QPCIDevice *pcidev;
     uint8_t smram_val;
     uint8_t esmramc_val;
     uint32_t ram_offs;
+    QTestState *qts;
=20
     if (args->esmramc_tseg_sz =3D=3D MCH_HOST_BRIDGE_ESMRAMC_TSEG_SZ_MAS=
K) {
-        cmdline =3D g_strdup_printf("-M q35 -m %uM "
-                                  "-global mch.extended-tseg-mbytes=3D%u=
",
-                                  TSEG_SIZE_TEST_GUEST_RAM_MBYTES,
-                                  args->extended_tseg_mbytes);
+        qts =3D qtest_initf("-M q35 -m %uM -global mch.extended-tseg-mby=
tes=3D%u",
+                          TSEG_SIZE_TEST_GUEST_RAM_MBYTES,
+                          args->extended_tseg_mbytes);
     } else {
-        cmdline =3D g_strdup_printf("-M q35 -m %uM",
-                                  TSEG_SIZE_TEST_GUEST_RAM_MBYTES);
+        qts =3D qtest_initf("-M q35 -m %uM", TSEG_SIZE_TEST_GUEST_RAM_MB=
YTES);
     }
-    qtest_start(cmdline);
-    g_free(cmdline);
=20
     /* locate the DRAM controller */
-    pcibus =3D qpci_new_pc(global_qtest, NULL);
+    pcibus =3D qpci_new_pc(qts, NULL);
     g_assert(pcibus !=3D NULL);
     pcidev =3D qpci_device_find(pcibus, 0);
     g_assert(pcidev !=3D NULL);
@@ -175,18 +172,18 @@ static void test_tseg_size(const void *data)
      */
     ram_offs =3D (TSEG_SIZE_TEST_GUEST_RAM_MBYTES - args->expected_tseg_=
mbytes) *
                1024 * 1024 - 1;
-    g_assert_cmpint(readb(ram_offs), =3D=3D, 0);
-    writeb(ram_offs, 1);
-    g_assert_cmpint(readb(ram_offs), =3D=3D, 1);
+    g_assert_cmpint(qtest_readb(qts, ram_offs), =3D=3D, 0);
+    qtest_writeb(qts, ram_offs, 1);
+    g_assert_cmpint(qtest_readb(qts, ram_offs), =3D=3D, 1);
=20
     ram_offs++;
-    g_assert_cmpint(readb(ram_offs), =3D=3D, 0xff);
-    writeb(ram_offs, 1);
-    g_assert_cmpint(readb(ram_offs), =3D=3D, 0xff);
+    g_assert_cmpint(qtest_readb(qts, ram_offs), =3D=3D, 0xff);
+    qtest_writeb(qts, ram_offs, 1);
+    g_assert_cmpint(qtest_readb(qts, ram_offs), =3D=3D, 0xff);
=20
     g_free(pcidev);
     qpci_free_pc(pcibus);
-    qtest_end();
+    qtest_quit(qts);
 }
=20
 int main(int argc, char **argv)
--=20
2.21.0


