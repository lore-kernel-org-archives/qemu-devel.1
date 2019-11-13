Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4476C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:08:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75EFF206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="vEDGcKDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75EFF206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV1jz-0007Zl-HK
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 18:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iV1TV-00088R-5H
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iV1TT-0007nO-Hz
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:57 -0500
Received: from mail-dm3nam03on0714.outbound.protection.outlook.com
 ([2a01:111:f400:fe49::714]:27886
 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iV1TT-0007jr-1f
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=if1IIvIOi+e17z3D/9WenkcXysiJR2ZrPCg3XtV9nJHshob+DM71ThfofN0T459kPd/TggkTJ179yP55gn8CV+3ffUTibehLt3kPMrGBO+jn14eIxRqEZm0EONFKvooXJdsel16RoOCMl1+OswEZRb4PctgziSrzHK5cmQMDxFLxm/B3XXNspRPV5dEldOQ4P4zRdQa9ws890jggd2hcNpsiMg3mb5IfmdsIOKbww0ZLFxaO7/zZE+1078kBICp672ho6mfpwjQbn1AG9EAHwmxJWAeKgUe3Qkba7dnFAC6YfRfItxxUEzGAFbkqcKzEZBp8QZszCtKhq+W4LmoSYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeE3gYdawK/iAYMhRqb4sLEB7EKP2wcGJzWKRCGX7ME=;
 b=VR0vdTAKUpy4eAUekOTCba8l4lWjJeY2eT2+fNIHGSzO+RT8W+0PBzd85ZAYUMOUAQKF5m3awE8m0JJpy6MmSm/kJzlYvZMZIHb6Va60B3HOvkqyto2hjRXjemtzO8EB6FgvNA9GHQtP2X7IL2ZSelmHkKmawIRwNPUTqXQS2S/wTL+NhG4SiX3d+LnMzmT0+V97GjUmAhgX+NnJcYhe61t8P9eR+sJAMegLUWQXQOJyFtbXVxRrOPHkyqoLp2S45OV1zdNMfa9pfwN5ckzoQTCUBqmMvVGAqD/npDTftxQTlb0XiR7aDCu7XQ3z3QEU0bOYvyBKEhDX32xIm7OCaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeE3gYdawK/iAYMhRqb4sLEB7EKP2wcGJzWKRCGX7ME=;
 b=vEDGcKDXlRbrL20KVgYFchsTb57zijmRuLTrqMbK5DZl45esZvlJaWO7ZFBQAq7Tr2YQlE/18E7NnDUrmbsudCKsaiJVXscktyDy0xxtoVUooi2TY0kPLR9VbpYqf/a4/1SjxVrlwVxXqLZIRbTM5pDFALRbIbBu4d693Ad4x4Q=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5024.namprd03.prod.outlook.com (52.132.169.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 22:50:52 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 22:50:52 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v5 16/20] fuzz: add support for fork-based fuzzing.
Thread-Topic: [PATCH v5 16/20] fuzz: add support for fork-based fuzzing.
Thread-Index: AQHVmnTMisAaOKyvMkWhJTmmNH4cAw==
Date: Wed, 13 Nov 2019 22:50:52 +0000
Message-ID: <20191113225030.17023-17-alxndr@bu.edu>
References: <20191113225030.17023-1-alxndr@bu.edu>
In-Reply-To: <20191113225030.17023-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR15CA0028.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::41) To MN2PR03MB4800.namprd03.prod.outlook.com
 (2603:10b6:208:101::14)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a1ecd2d-69b0-4e22-c9f9-08d7688bef32
x-ms-traffictypediagnostic: MN2PR03MB5024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB502444AAB3D7A8C2B9BDE550BA760@MN2PR03MB5024.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(2501003)(88552002)(75432002)(54906003)(446003)(7736002)(99286004)(11346002)(6436002)(6486002)(5640700003)(476003)(305945005)(256004)(786003)(2906002)(2351001)(14444005)(316002)(14454004)(6116002)(86362001)(2616005)(6512007)(6916009)(486006)(3846002)(71200400001)(71190400001)(4326008)(1076003)(36756003)(386003)(8676002)(478600001)(66066001)(76176011)(81166006)(186003)(66946007)(5660300002)(6506007)(81156014)(64756008)(52116002)(26005)(102836004)(50226002)(25786009)(8936002)(66476007)(66556008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5024;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Whk+AmPuwF2hGdz8Czo/XsgEGHXntLcxzVn0IeXPQ0OKc92C0rYBUpA7I3NvS77Fw/sVJBeX5uPKAvIGQHHlA/6YZoDKTpbXYjh48JpX/udx6r89ZCjtSH98fI5uxc6an4Oe0nWKGcAomWKth+ruYo+gFF7BkSof7TAC+PCjmYWkWkdw7Cs5OgkxYWS453XLFMs1a74WgEIdfT1GmnLlW1Q/gLKZxlZTRiaor9/KxdOToGjAe+F5PEgKBhioic7g9vB4bVzprIRZuPtf/6xAqe5IufpA1SKgbL+yxayUgVpIa/nXXd9a7A+89MkGa0kRF9S6WITIXH3/WNRfrCrzQdLqs3ASR7Gn0uR8ZCHAqPQokAQdN4xXtPrhQ+wzRPyhy4M0SW8K5Z6fneUjFr1oq6B5gGHZ5tOpZ3sRM8PAJfVdoEk+An1OltvXTgHFMiny
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1ecd2d-69b0-4e22-c9f9-08d7688bef32
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 22:50:52.1758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GKCZcyDtFkeT3fc0fvjf1cda8sBdMuX89aW0gIOVSCZuTMf8aYsX6F06VEVTBKtJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5024
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe49::714
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
index 91c8b79656..b15207b00c 100644
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
@@ -2266,8 +2267,15 @@ static void ram_block_add(RAMBlock *new_block, Error=
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


