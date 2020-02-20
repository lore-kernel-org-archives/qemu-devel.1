Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAF6C34031
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:18:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4903D2465D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="loG11b++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4903D2465D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4dI9-0000WH-GY
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 23:18:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j4dBp-0004it-Km
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j4dBo-0005ym-8p
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:53 -0500
Received: from mail-co1nam11on2136.outbound.protection.outlook.com
 ([40.107.220.136]:38881 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j4dBo-0005yE-1M
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nv+xxriYYwLFsE0vPctSzxC1XaZILi/gSyuflYyYrR4GXzG+M63gtHakK+PqG7H2wMRQCYmqrPhZtw8dyxOEJ6+5vE/qyh5emur8P5UPDHEJGdCmRqRYwSf+VZyC6cWPI+F/OCrQAAUiYy7YVWDtyP0ogtxsZyn/EwLLP0yiBzdV+x6xiT2GSgC1R7Y6A6KUmdnpifStt3hVzZo5puESEgefI0asKaXppoMUyEnqYpXgRV/pqGCF/YDoJjuxNdxkWR7c+15qlb+967C1PIXVP4UepFyC9CNcv502t7pvE1q86eMzcLW+Hc6FRDHrNGdmpwE6ZifsOjfoKjGMUV+iGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mei/PwbkBSQufSePufMMwe+jUEtXu7nmimV/wjXZnVo=;
 b=WilPD05UeH/cNxeM6XGx0Z30DkkRAt4te2dQVf9z008p2lPIsDsrxX5LStTq3KZ33NwP8Up06fe27+ZvMDgFVmOKP+igJb/nk/frU0ZDwgWMpPiCu/TQ/qTJJEEMJYltcUQGyRZWLbkSLN7g/nTMkeJNiFwZ9flb5jpPUpya/bfbOyk4CB+v7t+GPZqkZoE42x5r49p4qc+3yu5gVsBOuTQZPXoEq5KPMeD560O75H0LQfQN6FdB6k1IDgmRfKHFWgwGXdzhSwk3j9MfTaKeHEFBkc1PvMXOtKG56SJZUNBMbJCjQKqZxcWwPLCWIUFjlRnuPniH584JkD9jmWnCkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mei/PwbkBSQufSePufMMwe+jUEtXu7nmimV/wjXZnVo=;
 b=loG11b++BZXum6FjrBNP2vO0tb9J0L1N7JDBAe+XH/zJ7b/29UprmZqvqbfQWovxsAsnvpqsqvPcHU0qt42db1KDGzIsJZ970n+Dq9hsBJj3TZS8z+K4WatCdlTHgDHEc9LY+gRI08RleJLMSiBGEkzf2idyMEx2Ry4iYcSbgTA=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3807.namprd03.prod.outlook.com (2603:10b6:805:6a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Thu, 20 Feb
 2020 04:11:51 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 04:11:51 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 15/22] fuzz: support for fork-based fuzzing.
Date: Wed, 19 Feb 2020 23:11:11 -0500
Message-ID: <20200220041118.23264-16-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220041118.23264-1-alxndr@bu.edu>
References: <20200220041118.23264-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0048.prod.exchangelabs.com
 (2603:10b6:208:25::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR0102CA0048.prod.exchangelabs.com (2603:10b6:208:25::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 04:11:50 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f9835a9-ac58-4346-91ae-08d7b5bb02d5
X-MS-TrafficTypeDiagnostic: SN6PR03MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3807B70BB8A6CC5824144E16BA130@SN6PR03MB3807.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(36756003)(86362001)(81166006)(75432002)(8676002)(2616005)(478600001)(81156014)(8936002)(66476007)(5660300002)(6916009)(66556008)(66946007)(54906003)(956004)(316002)(786003)(6486002)(6666004)(7696005)(16526019)(186003)(26005)(4326008)(1076003)(2906002)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3807;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XaNnWtAiEy/FygM5/dJZw7yu3T0T+MTkd/bfDb8X2a46SRqkUEaCYQyhV8xDdMGEceRag0gnXYE2luONqJ2r15NHfD+ZU8F+8QJ9t0hw1GeFB2aFiMmDwn82pgOeymke0griPG0YxO7UC7sCpxQGKd8R0ga0kBPtszv4I/DyCe75aOKlk2N6SV8mVIh1F24kXXSfmu45cy5cV+Ll/MOLYcYNJ1P/qzsrX+FxCKMZELlx1UGx+NimOfX2/b9rSwTqi3C1khddjMYnYvizQaOJ+BqS4+BHVUSBsHgeKmD6pjRz9TIJoxj646JTc2q74uRdHLjSGTcd4gC7bJPL1Z2LOtMbBZT3nGy6WnCKQBSZ6b1+Q9EEjYkaF84YLWhnYgzpZsFcnwmKiT/C3G4EibWpaG6xfbwNkyx3dVISPEhkFUqB0Yk/NdazJGkX3ug9tvoF
X-MS-Exchange-AntiSpam-MessageData: c62w1J0FlraQ7nFAQ5RiTjPEuK9ZhNPq3oWgMYI/HjIXLBBajCxVNoA18CUAVCq/uirfG9X4oPz0/d4Gsl9QaPNWv6lEGlVD4MbDLWF5znHFOmGJKk3PlvjamD2WI6+45WUa6GMh+IKV37ccJcphbA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9835a9-ac58-4346-91ae-08d7b5bb02d5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 04:11:50.9605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7LDwtSHd98E5ZzB9JGY3RdltKem+1UG2IpqGtVI7NVI/KV38KXDzaxsE4dpI+Ns
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3807
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.136
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


