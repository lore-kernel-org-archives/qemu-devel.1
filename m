Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7F5C3524C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E9D20658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nTWvCc6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E9D20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyVDg-00014k-7A
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:28:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUy4-0003ka-JT
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUy3-0003bF-1W
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:12:20 -0500
Received: from ozlabs.org ([203.11.71.1]:33999)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iyUy1-0003V1-Hx; Mon, 03 Feb 2020 01:12:18 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489yBv4Lnqz9sTD; Mon,  3 Feb 2020 17:11:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580710295;
 bh=oqZJddFUnwsLfIFIVQRKiSeYF6bqaQRx08wy+81lhP8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nTWvCc6OwXdiy8Pu7lTzmyRgB8pvY3P4SZk9II608Qb9tkqlHSVIUK8lTLasRmxGT
 FCGX95gyo0NPtsnKNRlfOX4IZkbYIQXwCXx5ex6YwZ8ej6GAU4+4e730X3HOMlu6I1
 9Tz2jT5FbZkWpKtUCFSUWSswxrTS8h6AYb8ql2l4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 35/35] tests: Silence various warnings with pseries
Date: Mon,  3 Feb 2020 17:11:23 +1100
Message-Id: <20200203061123.59150-36-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203061123.59150-1-david@gibson.dropbear.id.au>
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 groug@kaod.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Some default features of the pseries machine are only available with
KVM. Warnings are printed when the pseries machine is used with another
accelerator:

qemu-system-ppc64: warning: TCG doesn't support requested feature,
cap-ccf-assist=3Don
qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
Interrupts(FWNMI) not supported in TCG
qemu-system-ppc64: warning: TCG doesn't support requested feature,
cap-ccf-assist=3Don
qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
Interrupts(FWNMI) not supported in TCG
qemu-system-ppc64: warning: TCG doesn't support requested feature,
cap-ccf-assist=3Don
qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
Interrupts(FWNMI) not supported in TCG

This is annoying for CI since it usually runs without KVM. We already
disable features that emit similar warnings thanks to properties of
the pseries machine, but this is open-coded in various
places. Consolidate the set of properties in a single place. Extend it
to silence the above warnings. And use it in the various tests that
start pseries machines.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <158059697130.1820292.7823434132030453110.stgit@bahia.lan>
Reviewed-by: Thomas Huth <thuth@redhat.com>
[dwg: Correct minor grammatical error]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 tests/qtest/boot-serial-test.c    | 3 ++-
 tests/qtest/libqos/libqos-spapr.h | 8 ++++++++
 tests/qtest/prom-env-test.c       | 3 ++-
 tests/qtest/pxe-test.c            | 7 ++++---
 4 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-tes=
t.c
index 8e8c5b0a0f..85a3614286 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -15,6 +15,7 @@
=20
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/libqos-spapr.h"
=20
 static const uint8_t kernel_mcf5208[] =3D {
     0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
@@ -112,7 +113,7 @@ static testdef_t tests[] =3D {
     { "ppc64", "40p", "-m 192", "Memory: 192M" },
     { "ppc64", "mac99", "", "PowerPC,970FX" },
     { "ppc64", "pseries",
-      "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken",
+      "-machine " PSERIES_DEFAULT_CAPABILITIES,
       "Open Firmware" },
     { "ppc64", "powernv8", "", "OPAL" },
     { "ppc64", "powernv9", "", "OPAL" },
diff --git a/tests/qtest/libqos/libqos-spapr.h b/tests/qtest/libqos/libqo=
s-spapr.h
index dcb5c43ad3..d9c4c22343 100644
--- a/tests/qtest/libqos/libqos-spapr.h
+++ b/tests/qtest/libqos/libqos-spapr.h
@@ -7,4 +7,12 @@ QOSState *qtest_spapr_vboot(const char *cmdline_fmt, va_=
list ap);
 QOSState *qtest_spapr_boot(const char *cmdline_fmt, ...);
 void qtest_spapr_shutdown(QOSState *qs);
=20
+/* List of capabilities needed to silence warnings with TCG */
+#define PSERIES_DEFAULT_CAPABILITIES             \
+    "cap-cfpc=3Dbroken,"                           \
+    "cap-sbbc=3Dbroken,"                           \
+    "cap-ibs=3Dbroken,"                            \
+    "cap-ccf-assist=3Doff,"                        \
+    "cap-fwnmi-mce=3Doff"
+
 #endif
diff --git a/tests/qtest/prom-env-test.c b/tests/qtest/prom-env-test.c
index 9be52c766f..60e6ec3153 100644
--- a/tests/qtest/prom-env-test.c
+++ b/tests/qtest/prom-env-test.c
@@ -21,6 +21,7 @@
=20
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/libqos-spapr.h"
=20
 #define MAGIC   0xcafec0de
 #define ADDRESS 0x4000
@@ -54,7 +55,7 @@ static void test_machine(const void *machine)
      */
     if (strcmp(machine, "pseries") =3D=3D 0) {
         extra_args =3D "-nodefaults"
-            " -machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbro=
ken";
+            " -machine " PSERIES_DEFAULT_CAPABILITIES;
     }
=20
     qts =3D qtest_initf("-M %s -accel tcg %s -prom-env 'use-nvramrc?=3Dt=
rue' "
diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
index f68d0aadbb..1161a773a4 100644
--- a/tests/qtest/pxe-test.c
+++ b/tests/qtest/pxe-test.c
@@ -17,6 +17,7 @@
 #include "qemu-common.h"
 #include "libqtest.h"
 #include "boot-sector.h"
+#include "libqos/libqos-spapr.h"
=20
 #define NETNAME "net0"
=20
@@ -46,15 +47,15 @@ static testdef_t x86_tests_slow[] =3D {
=20
 static testdef_t ppc64_tests[] =3D {
     { "pseries", "spapr-vlan",
-      "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken,vsm=
t=3D8" },
+      "-machine vsmt=3D8," PSERIES_DEFAULT_CAPABILITIES },
     { "pseries", "virtio-net-pci",
-      "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken,vsm=
t=3D8" },
+      "-machine vsmt=3D8," PSERIES_DEFAULT_CAPABILITIES },
     { NULL },
 };
=20
 static testdef_t ppc64_tests_slow[] =3D {
     { "pseries", "e1000",
-      "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken,vsm=
t=3D8" },
+      "-machine vsmt=3D8," PSERIES_DEFAULT_CAPABILITIES },
     { NULL },
 };
=20
--=20
2.24.1


