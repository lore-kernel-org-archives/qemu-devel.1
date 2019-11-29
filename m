Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E765C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:45:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 534372464A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="lM8xpEPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534372464A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iao4Y-0003YE-07
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 16:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1ianum-0000CU-20
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:35:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1ianuk-0002wo-7f
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:59 -0500
Received: from mail-eopbgr740102.outbound.protection.outlook.com
 ([40.107.74.102]:45028 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1ianuj-0002ik-1h
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8wD1A/9XW1dr2KNPONTea9bLudGjz+pkeUQRPjvNKuJqsCTWpb/NXGCC8ilFMSHIN4EKaGEM4xwsnFlH6GnwINV3aA34QbeOXq0RZVqf6nmoB7ey7hzRWxLv/RSvUK954yLWbgtm3DHul7vuzPq2dOkDBLQhJJjLUAuTKGHORUrvgph2OnrjRRw7XpE3tCIR/xbHJo9obR+mBbF5cWa5bRh6yVmdt/BG1Z0zy5YYlRC07u4vqqFrp9p1CleEgte0yt1OjWujMoLCVxLl4m1PN+3Zu84FXxc4ZHd2iRfqNoXaKZRSS00TsB9j1+N+sml+8k0qUoR9r/dWjt80FEUag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ou1Rnx/c9eOylZCEhFY5W9rSDhwNjjVOMiT2qVp5NJA=;
 b=hJAMfE6tpoqkEcJGmmEBna3qI1n91j0yBaWLn7UhNGH7FVkShR/HtYJY8dK3KxrAlK6nU2pC5lVEevbveB5y2J9khqXBPQFHw9rIbhC2s190vVR4wXW7drEzQWOCBmdu4O7yFJkBuQpTIu2GZ877QW1iu6yi/QM6OEGekMU5hLsfoqoRzvpNwRpk97+2XviL8rSrxnP6eR7s3h2XGO0UM/V5TGGt9f0cdbVjB5TOGo7D3x/mXNw2Lzfg+JBuvfgPgFIfwYS2i7PCh6KC6846BrjdY/4VHYId1BzBrdRARtWzfPlnJaYsHx8bXo4/8zRTqHlGNNPFDnWwP1cB/NuDxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ou1Rnx/c9eOylZCEhFY5W9rSDhwNjjVOMiT2qVp5NJA=;
 b=lM8xpEPpgywK8tiR1Zl4NhUqv75TIh3YJoo2eEkdmKfHP6PeHUcwlhX00VcA/+7WtjBp8wOogxAhW9sa5jjz6CPRaSb1naQaKIhim2na+NojfhVxTiurkiRQrCVpanfe3NvxmDrOJmJggukFnk5EisT9C4U3PuQbElichgQDJ24=
Received: from DM6PR03MB4795.namprd03.prod.outlook.com (20.179.107.22) by
 DM6PR03MB5050.namprd03.prod.outlook.com (10.141.161.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 21:34:51 +0000
Received: from DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74]) by DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74%2]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 21:34:51 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v6 16/21] fuzz: add support for fork-based fuzzing.
Thread-Topic: [PATCH v6 16/21] fuzz: add support for fork-based fuzzing.
Thread-Index: AQHVpvzUuwY+/AN4t0yiP78HFSLlpQ==
Date: Fri, 29 Nov 2019 21:34:50 +0000
Message-ID: <20191129213424.6290-17-alxndr@bu.edu>
References: <20191129213424.6290-1-alxndr@bu.edu>
In-Reply-To: <20191129213424.6290-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR1501CA0025.namprd15.prod.outlook.com
 (2603:10b6:207:17::38) To DM6PR03MB4795.namprd03.prod.outlook.com
 (2603:10b6:5:18c::22)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c05e0c1a-d21e-446a-52c0-08d77513f704
x-ms-traffictypediagnostic: DM6PR03MB5050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB505043972D127501A75C5483BA460@DM6PR03MB5050.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(81156014)(81166006)(66066001)(6436002)(3846002)(8936002)(66946007)(6116002)(1076003)(66446008)(64756008)(66476007)(14444005)(256004)(66556008)(316002)(786003)(8676002)(6512007)(102836004)(6486002)(478600001)(71190400001)(71200400001)(2351001)(86362001)(6506007)(14454004)(2501003)(75432002)(386003)(5640700003)(2906002)(6916009)(7736002)(2616005)(25786009)(26005)(52116002)(88552002)(99286004)(5660300002)(76176011)(186003)(446003)(11346002)(305945005)(50226002)(36756003)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR03MB5050;
 H:DM6PR03MB4795.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bwPpHOZLQ3SfPri//xedtzfy7qMll2huJWnRTEpR8yNTmeBaWWN1VaMVpR9IHWhyJe95mKQ/X5GB/w1Gi5/l/KutsCNJiUWJ5uPd9m7+vTBg10wJhazEe98m96EJfd8ibQcvkBqjbvs3YhVABF1vyxlsP/esXsJH5qW0N3wizsafrum2zbS82ET2yzNmYq1b6JFvDlRyKctuCN5of8IU9oufTstZ0z+hcGC0goDH/dtymeHWn9aWHqNLzCOlrrZnAgfYmN4VNvBCb1PLgoYqIdztwQNy2NiWVul+JUx+9IFf316aSAF53LMLJP7kp4a6ONJccuLezPOPUd1/b+lZa5qt69lYmTjocAAivg/X80Yr9gYDes5F0g5JCh1RSOZabE2dzOvgT3dXCEHACQRPsREK7lxhqpbf7M3CzMpyug6fG3uvl9qURhOnsRGzTw2B
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c05e0c1a-d21e-446a-52c0-08d77513f704
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 21:34:50.7857 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDPIQ1YsT8GRysSFQ0bUb3hUx3ORJMcTI6mq4lTbimgMJlYp443DsaSRpY2sa4Ym
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.102
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "Oleinik, 
 Alexander" <alxndr@bu.edu>
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
---
 exec.c                      | 12 ++++++--
 tests/fuzz/Makefile.include |  3 ++
 tests/fuzz/fork_fuzz.c      | 55 +++++++++++++++++++++++++++++++++++++
 tests/fuzz/fork_fuzz.h      | 23 ++++++++++++++++
 tests/fuzz/fork_fuzz.ld     | 37 +++++++++++++++++++++++++
 tests/fuzz/fuzz.c           |  2 +-
 6 files changed, 129 insertions(+), 3 deletions(-)
 create mode 100644 tests/fuzz/fork_fuzz.c
 create mode 100644 tests/fuzz/fork_fuzz.h
 create mode 100644 tests/fuzz/fork_fuzz.ld

diff --git a/exec.c b/exec.c
index ffdb518535..e04d97404b 100644
--- a/exec.c
+++ b/exec.c
@@ -35,6 +35,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
+#include "sysemu/qtest.h"
 #include "qemu/timer.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
@@ -2268,8 +2269,15 @@ static void ram_block_add(RAMBlock *new_block, Error=
 **errp, bool shared)
     if (new_block->host) {
         qemu_ram_setup_dump(new_block->host, new_block->max_length);
         qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUG=
EPAGE);
-        /* MADV_DONTFORK is also needed by KVM in absence of synchronous M=
MU */
-        qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_DON=
TFORK);
+        /*
+         * MADV_DONTFORK is also needed by KVM in absence of synchronous M=
MU
+         * Configure it unless the machine is a qtest server, in which cas=
e it
+         * may be forked, for fuzzing purposes
+         */
+        if (!qtest_enabled()) {
+            qemu_madvise(new_block->host, new_block->max_length,
+                         QEMU_MADV_DONTFORK);
+        }
         ram_block_notify_add(new_block->host, new_block->max_length);
     }
 }
diff --git a/tests/fuzz/Makefile.include b/tests/fuzz/Makefile.include
index b415b056b0..687dacce04 100644
--- a/tests/fuzz/Makefile.include
+++ b/tests/fuzz/Makefile.include
@@ -2,3 +2,6 @@ QEMU_PROG_FUZZ=3Dqemu-fuzz-$(TARGET_NAME)$(EXESUF)
 fuzz-obj-y =3D $(libqos-obj-y)
 fuzz-obj-y +=3D tests/libqtest.o
 fuzz-obj-y +=3D tests/fuzz/fuzz.o
+fuzz-obj-y +=3D tests/fuzz/fork_fuzz.o
+
+FUZZ_LDFLAGS +=3D -Xlinker -T$(SRC_PATH)/tests/fuzz/fork_fuzz.ld
diff --git a/tests/fuzz/fork_fuzz.c b/tests/fuzz/fork_fuzz.c
new file mode 100644
index 0000000000..2bd0851903
--- /dev/null
+++ b/tests/fuzz/fork_fuzz.c
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
diff --git a/tests/fuzz/fork_fuzz.h b/tests/fuzz/fork_fuzz.h
new file mode 100644
index 0000000000..9ecb8b58ef
--- /dev/null
+++ b/tests/fuzz/fork_fuzz.h
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
diff --git a/tests/fuzz/fork_fuzz.ld b/tests/fuzz/fork_fuzz.ld
new file mode 100644
index 0000000000..b23a59f194
--- /dev/null
+++ b/tests/fuzz/fork_fuzz.ld
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
diff --git a/tests/fuzz/fuzz.c b/tests/fuzz/fuzz.c
index f4abaa3484..1ed98f26a2 100644
--- a/tests/fuzz/fuzz.c
+++ b/tests/fuzz/fuzz.c
@@ -51,7 +51,7 @@ void flush_events(QTestState *s)
 static QTestState *qtest_setup(void)
 {
     qtest_server_set_send_handler(&qtest_client_inproc_recv, &fuzz_qts);
-    return qtest_inproc_init(&fuzz_qts, false fuzz_arch,
+    return qtest_inproc_init(&fuzz_qts, false, fuzz_arch,
             &qtest_server_inproc_recv);
 }
=20
--=20
2.23.0


