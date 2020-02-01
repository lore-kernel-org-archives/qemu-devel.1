Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D55C35249
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 22:47:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 959FB2064C
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 22:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959FB2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51289 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iy1Xf-00037b-Pj
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 17:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iy1X6-0002Z4-5V
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 17:46:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iy1X4-0002Ky-T7
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 17:46:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49322)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iy1X4-0002Ad-Lv
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 17:46:30 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 011MdbKM131223
 for <qemu-devel@nongnu.org>; Sat, 1 Feb 2020 17:46:22 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xw6qcq1tp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 17:46:22 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Sat, 1 Feb 2020 22:46:20 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sat, 1 Feb 2020 22:46:17 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 011MkHdP42860986
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 1 Feb 2020 22:46:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5AAB11C069;
 Sat,  1 Feb 2020 22:46:16 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A75D011C066;
 Sat,  1 Feb 2020 22:46:16 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.55.193])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sat,  1 Feb 2020 22:46:16 +0000 (GMT)
Subject: [PATCH] tests: Silent various warnings with pseries
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Sat, 01 Feb 2020 23:46:16 +0100
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20020122-0012-0000-0000-00000382DA70
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020122-0013-0000-0000-000021BF3ADD
Message-Id: <158059697130.1820292.7823434132030453110.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-01_07:2020-01-31,
 2020-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0
 priorityscore=1501 mlxscore=0 suspectscore=1 malwarescore=0 clxscore=1034
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1911200001
 definitions=main-2002010167
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some default features of the pseries machine are only available with
KVM. Warnings are printed when the pseries machine is used with another
accelerator:

qemu-system-ppc64: warning: TCG doesn't support requested feature,
cap-ccf-assist=on
qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
Interrupts(FWNMI) not supported in TCG
qemu-system-ppc64: warning: TCG doesn't support requested feature,
cap-ccf-assist=on
qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
Interrupts(FWNMI) not supported in TCG
qemu-system-ppc64: warning: TCG doesn't support requested feature,
cap-ccf-assist=on
qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
Interrupts(FWNMI) not supported in TCG

This is annoying for CI since it usually runs without KVM. We already
disable features that emit similar warnings thanks to properties of the
pseries machine, but this is open-coded in various places. Consolidate
the set of properties in a single place. Extend it to silent the above
warnings. And use it in the various tests that start pseries machines.

Signed-off-by: Greg Kurz <groug@kaod.org>
---

This patch fixes the warnings observed with David's latest pull request.

 tests/qtest/boot-serial-test.c    |    3 ++-
 tests/qtest/libqos/libqos-spapr.h |    8 ++++++++
 tests/qtest/prom-env-test.c       |    3 ++-
 tests/qtest/pxe-test.c            |    7 ++++---
 4 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index 8e8c5b0a0f0c..85a361428697 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -15,6 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/libqos-spapr.h"
 
 static const uint8_t kernel_mcf5208[] = {
     0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
@@ -112,7 +113,7 @@ static testdef_t tests[] = {
     { "ppc64", "40p", "-m 192", "Memory: 192M" },
     { "ppc64", "mac99", "", "PowerPC,970FX" },
     { "ppc64", "pseries",
-      "-machine cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken",
+      "-machine " PSERIES_DEFAULT_CAPABILITIES,
       "Open Firmware" },
     { "ppc64", "powernv8", "", "OPAL" },
     { "ppc64", "powernv9", "", "OPAL" },
diff --git a/tests/qtest/libqos/libqos-spapr.h b/tests/qtest/libqos/libqos-spapr.h
index dcb5c43ad37d..e4460d08ae6e 100644
--- a/tests/qtest/libqos/libqos-spapr.h
+++ b/tests/qtest/libqos/libqos-spapr.h
@@ -7,4 +7,12 @@ QOSState *qtest_spapr_vboot(const char *cmdline_fmt, va_list ap);
 QOSState *qtest_spapr_boot(const char *cmdline_fmt, ...);
 void qtest_spapr_shutdown(QOSState *qs);
 
+/* List of capabilities needed to silent warnings with TCG */
+#define PSERIES_DEFAULT_CAPABILITIES             \
+    "cap-cfpc=broken,"                           \
+    "cap-sbbc=broken,"                           \
+    "cap-ibs=broken,"                            \
+    "cap-ccf-assist=off,"                        \
+    "cap-fwnmi-mce=off"
+
 #endif
diff --git a/tests/qtest/prom-env-test.c b/tests/qtest/prom-env-test.c
index 9be52c766fe3..60e6ec315335 100644
--- a/tests/qtest/prom-env-test.c
+++ b/tests/qtest/prom-env-test.c
@@ -21,6 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/libqos-spapr.h"
 
 #define MAGIC   0xcafec0de
 #define ADDRESS 0x4000
@@ -54,7 +55,7 @@ static void test_machine(const void *machine)
      */
     if (strcmp(machine, "pseries") == 0) {
         extra_args = "-nodefaults"
-            " -machine cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken";
+            " -machine " PSERIES_DEFAULT_CAPABILITIES;
     }
 
     qts = qtest_initf("-M %s -accel tcg %s -prom-env 'use-nvramrc?=true' "
diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
index f68d0aadbb4d..1161a773a4a7 100644
--- a/tests/qtest/pxe-test.c
+++ b/tests/qtest/pxe-test.c
@@ -17,6 +17,7 @@
 #include "qemu-common.h"
 #include "libqtest.h"
 #include "boot-sector.h"
+#include "libqos/libqos-spapr.h"
 
 #define NETNAME "net0"
 
@@ -46,15 +47,15 @@ static testdef_t x86_tests_slow[] = {
 
 static testdef_t ppc64_tests[] = {
     { "pseries", "spapr-vlan",
-      "-machine cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken,vsmt=8" },
+      "-machine vsmt=8," PSERIES_DEFAULT_CAPABILITIES },
     { "pseries", "virtio-net-pci",
-      "-machine cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken,vsmt=8" },
+      "-machine vsmt=8," PSERIES_DEFAULT_CAPABILITIES },
     { NULL },
 };
 
 static testdef_t ppc64_tests_slow[] = {
     { "pseries", "e1000",
-      "-machine cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken,vsmt=8" },
+      "-machine vsmt=8," PSERIES_DEFAULT_CAPABILITIES },
     { NULL },
 };
 


