Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3322CC35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0393920659
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="vIi1W49F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0393920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1cUF-0001TB-7x
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j1cG1-0006aq-MY
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j1cFz-0008Rw-10
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:45 -0500
Received: from mail-dm6nam12on2092.outbound.protection.outlook.com
 ([40.107.243.92]:50848 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j1cFy-0008HE-FW
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbnPKOn+u8dZPIOmzQhwfAht73wr48/zptmbr5ZzmFMxvz8har5BdVLvd+BICV6FbFd4nMHVlobN1GbCDLKMpB8ZM0zGybrfHyprUl0O0IDWiuYREKS7qAxUd2Po3kQRI+WCXKYJRE4cQgXvlHMJMehxRi0V9QjX0RQpKa+FNbXgVS9TaInJvziLIjcNwf/4t254xrekLMIs5QJFMS2HryQuZM3/0ebfbsHVmoL88AnJPhXmemYnIySb03L7pAit5Di4ovMKv2iZR3kNd2km1MI3BixJ7l/WjFKf1evpifux34BrXwIY6+cKa+wgV9/Qw83VoOygAvVBwtGowCRUNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mei/PwbkBSQufSePufMMwe+jUEtXu7nmimV/wjXZnVo=;
 b=iesjFLCaSmXGgDEdMQ8wf+sMyOe5ly69eUXmTaIpS1cJyrxcGDk8EKR4/w+CroPSrorAhFOkWUtm8L9nbbpqGRcB9liymHPKA05u9GXkb0d/OcMpqgARI2JrZCv2/Xn8r2Je/U8IhYU2rHfvU11g8ZidUYbor/75fZ5bKf/OWXUe405DevGZkHSX6K0QqqaWCUEWa4j45m4uXQJSDUxVwC8/wgcKxBQBWp40U7RrziJQRMg8E6qMBnOLdSAB14iTCXBPTgPPiGnfKr5JIw2EAV7Zm2LLuMUgRrDsOMe/1yGPZiLEIKcXZkj1r87KmfufbQMjH8KhmrBuYIcbA1GiQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mei/PwbkBSQufSePufMMwe+jUEtXu7nmimV/wjXZnVo=;
 b=vIi1W49FmNt1kjHOovo0Mkc6jpxEnpqaM0ZeqFmLIrXw/UsM+zK3Z2Bgi0KGyiRMdnK6+FtEgDq7lBHm9DTw/Vaz87kW3KxbWVoqTjTfCSmsemUobhD3HSPbNa9ua26BV+1gcOihVUfo/PgwXL68J0Y2xxfhSWIKdCL4K9+4y5Q=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4336.namprd03.prod.outlook.com (20.177.254.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Tue, 11 Feb 2020 20:35:36 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 20:35:36 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 16/23] fuzz: support for fork-based fuzzing.
Date: Tue, 11 Feb 2020 15:35:03 -0500
Message-ID: <20200211203510.3534-17-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211203510.3534-1-alxndr@bu.edu>
References: <20200211203510.3534-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0124.namprd02.prod.outlook.com (2603:10b6:208:35::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 20:35:35 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80cc46aa-8b9f-4dc7-b788-08d7af31f30f
X-MS-TrafficTypeDiagnostic: SN6PR03MB4336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4336556D39E98EAEB6FDD3B4BA180@SN6PR03MB4336.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(199004)(189003)(16526019)(6666004)(1076003)(5660300002)(86362001)(316002)(186003)(786003)(66556008)(54906003)(6916009)(66476007)(6486002)(66946007)(8936002)(478600001)(4326008)(7696005)(52116002)(36756003)(75432002)(2616005)(2906002)(956004)(8676002)(26005)(81166006)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4336;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0M6X/53u6VQpURwkVQg18fv7E2n5+XDiV/Fog38OfFzsQsKjwghiS+oMWBq8c5Sy5mv7rgCZl8HYTK+WlWRgDXWqdKAlUy9VKJ24EpSgTG2ITzBhejJdk4qrv47U8kErmMqD5x2Z0JQq7vrOu3s7EPXPdPpTNOWn0y5Ov2oIK6brY9L4bVg7XHS6vG6c/TMXaulTQm0UueKkm2g734xYi3HaLgOyL43QGqhLE+2Z3weRFzbvzRO9vIOiOJqPjLL2/RkL2DqiPo75vEuD9mnvyjZzU/P8SAjSl03w67of8uIU5k+ixrWAN/XPB0VFBs3nun7HyEK2u6NikpocGsqKx8MyHL0xVxAnkdjTSgmLEFREEqNMJrUE8QAT4QJwAP+dZkM0NjEyVq8jRfN2WVQgDmpeg1eLcSG4nTdHh/VU8PZbz+rIPvgskfa3ySaUkp5
X-MS-Exchange-AntiSpam-MessageData: VPv/+DiLakM6h1ErBSQzXj2ZNxLsX5fOPa0wNAAGF/J1nddq06VTKIA2D86QoCAbyK/vTcgijWW/e4rsuyf6V0U+HHiSlF5YwRnO+TxLPJpB+VPUcRVbt88ebXGU/cSZR/mBucuNilJIMmg36LoXRw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cc46aa-8b9f-4dc7-b788-08d7af31f30f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 20:35:36.4125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xeBhgcXy1KTn2oy1obTPAgXxBqr7sG1zUYAwgVcZxxwmlQDUUDD5tV/FtgzM1KVo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4336
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.243.92
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
 darren.kenny@oracle.com, Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com
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
2.25.0


