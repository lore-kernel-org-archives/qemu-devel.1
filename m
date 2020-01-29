Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A62FC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC3B2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="SmoLJT+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC3B2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwg9I-0000NN-5I
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 00:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iwfzf-00084l-UL
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iwfze-00026j-Bk
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:27 -0500
Received: from mail-mw2nam10on2098.outbound.protection.outlook.com
 ([40.107.94.98]:3168 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iwfze-0001yv-3t
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKNeH410jf4uRc6vndFwy8AieRC13z8Xe1v/QmnNdHMeeicDjVaQKKv4npmQscaCKqBpQZID3LgGd3iZWGNagDLkiGXSXVe6ug4q4mTzRPqXQfkUaThJzKE9Vp0kBRZBzJlxmc9J0ejNLnuG5al1OCXv5O5Lpa5LjLdSD/Urpc48i3aKNJ/jtXHAlItU4wgnd1qWtmfIcnrN2B0BQL4ExnYI0LNLwXfaLrkZN6ORYhevpVm5JjlJvoEnyXVC3DfQdNGOtnxRfZvyqt05xbwj3NrV9a1tnyKI0Bw6ox+PFdsgLnK6uC/bXxlGVEakUAN7Z4IyaV35MM3G0GYC6F53Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fryQK8xhDZQ/FTsWZyYBSV50LhpNP2y8Q2iAmhkAd6c=;
 b=EFEpUBGaaFLXDFcVte/YVtoXh7VktyhuGtXcLTpAdMwQDlyzaCOP+JjSps1f62jq5PvhAaQF3XZkZ+x6xu0Szb0UKV/+7W6dEYzT935hA6Qaec4ve4yrSjyn/01a+G+3jwVDHiqT08UQT/DDGe9a/zKwAfRXnYH1G+5xePDu/XH59BIhC49KkhWph/IEZGWZgbYMlV8wTSEC9i667u3RxoAFiaKJ4IdVLH96d8d8zSyZ7riAYA+ZVlmpe6XSVhzLg11OIudvORSp+92qRZS7wXOBzXKxVF2L+udMf/sEkKbcN2mEiYDBuCKgjFtZSy6pnS1cd/Yx5w4n9yVnpt4Y7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fryQK8xhDZQ/FTsWZyYBSV50LhpNP2y8Q2iAmhkAd6c=;
 b=SmoLJT+Kkr6KzxvU53IcFIn7DRDEJrS55ktmMVTFLRCTT7U///0C69ePMBNaxmpkmwFvXeV0vo/FCv/H5PqfmzdVyfmHXcX8lfHrzrFJYPtaZt+06mPwt1u+JrX68+HSkZtrFpA2NOj5K5wRZJEwEh5s9t3mnsdSkrVXo7drmxw=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4206.namprd03.prod.outlook.com (52.135.110.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Wed, 29 Jan 2020 05:34:24 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 05:34:23 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:c0::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.19 via Frontend Transport; Wed, 29 Jan 2020 05:34:22 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v8 14/21] fuzz: support for fork-based fuzzing.
Thread-Topic: [PATCH v8 14/21] fuzz: support for fork-based fuzzing.
Thread-Index: AQHV1mXDd1vceBEg1kmqCqFjFe6Frw==
Date: Wed, 29 Jan 2020 05:34:23 +0000
Message-ID: <20200129053357.27454-15-alxndr@bu.edu>
References: <20200129053357.27454-1-alxndr@bu.edu>
In-Reply-To: <20200129053357.27454-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:c0::42) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11eabc45-3b99-43a5-c569-08d7a47ce587
x-ms-traffictypediagnostic: SN6PR03MB4206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB42067FF67FA3F58A420CCD95BA050@SN6PR03MB4206.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(189003)(199004)(478600001)(75432002)(36756003)(316002)(6916009)(2906002)(786003)(4326008)(54906003)(26005)(186003)(956004)(2616005)(6486002)(7696005)(52116002)(16526019)(1076003)(5660300002)(71200400001)(86362001)(66446008)(66556008)(66946007)(66476007)(8936002)(81156014)(81166006)(64756008)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4206;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XzWJkF89YFR0OgKxIZ6X3OBJ4AbM74nzfy47iU3YDSjuD3G2HuVIeUE81uhuQ+A+dnwRhYd737FHMXZlzpgsCvjIUSo5teASfWIVGPAcL92z0hLilnklwCuka27HP5W4RWFJiarRz5WLLPwm35YmrkJszURNDqx2znuNwbWrBNJ9XlTTqLGE9qsTGq9z8olOzY8a717RlFr3+ytj1dsAmIkTWf5DxOriAANFPXKtDdYWZaxp2tpQ0CsZsFJJrv4b8OvD4p4FJQmzioOwhpWkIt4kaORWIUWno2P1pJwmcnFQ6Xx3FeY5nykiCm4olY7A54Mf+tIqP0rG/1O7fSNiacd4Hu09kSpkaao9jGj4OMdzyScwUe27LWAgzSsh701Q3e1gpYwwbK+8YA0PIw0geRp/cmZeCJGts/8pZtQc8hllZwq1Y3naV+RoIRLwTwRS
x-ms-exchange-antispam-messagedata: Z+ldivwk6CxqkUS49Ddtl056BZx2KnJguw9DPWu+Va4PdaB7hUpysX47oxk5IuN0Yteu6a16e/LhthKoB/LjrCduJr6dNuS3jAzMU96egNC2sDWwvdc+0Hpm41b+P/6e0ueBCC5q/GLQoTbi1TEcZA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 11eabc45-3b99-43a5-c569-08d7a47ce587
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 05:34:23.1813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MkXivMPSks6TBg5zIEijsDD+4rPgcWSJ6eNmWAkInzbViL5VdTjRlrFq0oNENsib
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4206
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.98
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
 "Bulekov, Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

fork() is a simple way to ensure that state does not leak in between
fuzzing runs. Unfortunately, the fuzzer mutation engine relies on
bitmaps which contain coverage information for each fuzzing run, and
these bitmaps should be copied from the child to the parent(where the
mutation occurs). These bitmaps are created through compile-time
instrumentation and they are not shared with fork()-ed processes, by
default. To address this, we create a shared memory region, adjust its
size and map it _over_ the counter region. Furthermore, libfuzzer
doesn't generally expose the globals that specify the location of the
counters/coverage bitmap. As a workaround, we rely on a custom linker
script which forces all of the bitmaps we care about to be placed in a
contiguous region, which is easy to locate and mmap over.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qtest/fuzz/Makefile.include |  5 +++
 tests/qtest/fuzz/fork_fuzz.c      | 55 +++++++++++++++++++++++++++++++
 tests/qtest/fuzz/fork_fuzz.h      | 23 +++++++++++++
 tests/qtest/fuzz/fork_fuzz.ld     | 37 +++++++++++++++++++++
 4 files changed, 120 insertions(+)
 create mode 100644 tests/qtest/fuzz/fork_fuzz.c
 create mode 100644 tests/qtest/fuzz/fork_fuzz.h
 create mode 100644 tests/qtest/fuzz/fork_fuzz.ld

diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.=
include
index 8632bb89f4..a90915d56d 100644
--- a/tests/qtest/fuzz/Makefile.include
+++ b/tests/qtest/fuzz/Makefile.include
@@ -2,5 +2,10 @@ QEMU_PROG_FUZZ=3Dqemu-fuzz-$(TARGET_NAME)$(EXESUF)
=20
 fuzz-obj-y +=3D tests/qtest/libqtest.o
 fuzz-obj-y +=3D tests/qtest/fuzz/fuzz.o # Fuzzer skeleton
+fuzz-obj-y +=3D tests/qtest/fuzz/fork_fuzz.o
=20
 FUZZ_CFLAGS +=3D -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
+
+# Linker Script to force coverage-counters into known regions which we can=
 mark
+# shared
+FUZZ_LDFLAGS +=3D -Xlinker -T$(SRC_PATH)/tests/qtest/fuzz/fork_fuzz.ld
diff --git a/tests/qtest/fuzz/fork_fuzz.c b/tests/qtest/fuzz/fork_fuzz.c
new file mode 100644
index 0000000000..2bd0851903
--- /dev/null
+++ b/tests/qtest/fuzz/fork_fuzz.c
@@ -0,0 +1,55 @@
+/*
+ * Fork-based fuzzing helpers
+ *
+ * Copyright Red Hat Inc., 2019
+ *
+ * Authors:
+ *  Alexander Bulekov   <alxndr@bu.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "fork_fuzz.h"
+
+
+void counter_shm_init(void)
+{
+    char *shm_path =3D g_strdup_printf("/qemu-fuzz-cntrs.%d", getpid());
+    int fd =3D shm_open(shm_path, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
+    g_free(shm_path);
+
+    if (fd =3D=3D -1) {
+        perror("Error: ");
+        exit(1);
+    }
+    if (ftruncate(fd, &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START) =3D=
=3D -1) {
+        perror("Error: ");
+        exit(1);
+    }
+    /* Copy what's in the counter region to the shm.. */
+    void *rptr =3D mmap(NULL ,
+            &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START,
+            PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+    memcpy(rptr,
+           &__FUZZ_COUNTERS_START,
+           &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START);
+
+    munmap(rptr, &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START);
+
+    /* And map the shm over the counter region */
+    rptr =3D mmap(&__FUZZ_COUNTERS_START,
+            &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START,
+            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED, fd, 0);
+
+    close(fd);
+
+    if (!rptr) {
+        perror("Error: ");
+        exit(1);
+    }
+}
+
+
diff --git a/tests/qtest/fuzz/fork_fuzz.h b/tests/qtest/fuzz/fork_fuzz.h
new file mode 100644
index 0000000000..9ecb8b58ef
--- /dev/null
+++ b/tests/qtest/fuzz/fork_fuzz.h
@@ -0,0 +1,23 @@
+/*
+ * Fork-based fuzzing helpers
+ *
+ * Copyright Red Hat Inc., 2019
+ *
+ * Authors:
+ *  Alexander Bulekov   <alxndr@bu.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef FORK_FUZZ_H
+#define FORK_FUZZ_H
+
+extern uint8_t __FUZZ_COUNTERS_START;
+extern uint8_t __FUZZ_COUNTERS_END;
+
+void counter_shm_init(void);
+
+#endif
+
diff --git a/tests/qtest/fuzz/fork_fuzz.ld b/tests/qtest/fuzz/fork_fuzz.ld
new file mode 100644
index 0000000000..b23a59f194
--- /dev/null
+++ b/tests/qtest/fuzz/fork_fuzz.ld
@@ -0,0 +1,37 @@
+/* We adjust linker script modification to place all of the stuff that nee=
ds to
+ * persist across fuzzing runs into a contiguous seciton of memory. Then, =
it is
+ * easy to re-map the counter-related memory as shared.
+*/
+
+SECTIONS
+{
+  .data.fuzz_start : ALIGN(4K)
+  {
+      __FUZZ_COUNTERS_START =3D .;
+      __start___sancov_cntrs =3D .;
+      *(_*sancov_cntrs);
+      __stop___sancov_cntrs =3D .;
+
+      /* Lowest stack counter */
+      *(__sancov_lowest_stack);
+  }
+  .data.fuzz_ordered :
+  {
+      /* Coverage counters. They're not necessary for fuzzing, but are use=
ful
+       * for analyzing the fuzzing performance
+       */
+      __start___llvm_prf_cnts =3D .;
+      *(*llvm_prf_cnts);
+      __stop___llvm_prf_cnts =3D .;
+
+      /* Internal Libfuzzer TracePC object which contains the ValueProfile=
Map */
+      FuzzerTracePC*(.bss*);
+  }
+  .data.fuzz_end : ALIGN(4K)
+  {
+      __FUZZ_COUNTERS_END =3D .;
+  }
+}
+/* Dont overwrite the SECTIONS in the default linker script. Instead inser=
t the
+ * above into the default script */
+INSERT AFTER .data;
--=20
2.23.0


