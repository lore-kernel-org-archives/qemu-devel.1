Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22838CA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 15:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA28520874
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 15:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="YwL5qJId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA28520874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPpau-0002pV-0G
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 11:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iPpIW-000570-12
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iPpIT-0007OV-Vi
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:07 -0400
Received: from mail-eopbgr690101.outbound.protection.outlook.com
 ([40.107.69.101]:31361 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iPpIT-0007LI-CY
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hr6qXNrdZ93U1onJChglBO7j0lyb4m6T3/rjebyMlwLmmhtzBgoTwOpOfpvvaomsyYgf8y+4buczOW9+DF7rpk9Kw84hn+qRKLnHqZWbr2swcv2TrondKKTexTjGl47KNLyJPOAbmqyGb648nwE4T8CsoUhnpSl0c6vVHOknEqV9wYrZulRbd0t1mcqz06sngi83iKKCmDHm4d3xh4/Z5aItYEayoFT72CJ92QdzUTZ8aIg27KYOJJy+YLYofiQF+5bsrt8wLsNA3nhriof9QPm2Uol1x6gHD2AUcjPw+byDYpUvCxeng2ItY+G6Fjw5jNBsxD71jPFp7eVfSiG9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsBYMFD3vAUiN8ycxdIET3yF+IDjHC9rD1PQp2Z6cxA=;
 b=SeFUhjmTafd98MEJ91qGGX0owtUG39Ckkzz3VbFQ9Rsz9cLx86HhQUvKTW7mO/BQiacJtVlevnvMgwKRTC34rSy8IGO8aS4jX8tGFJBalLrloS2a9OV5aiF8oX3Dx1S75EawYCuBkuKQP7hC6JZ5T01nDEFepE1E6EYmT4zHO7+Hj0WmmkGAscRs7wXS6ALdiHpL7wJRvjom3LolXr2vpE7tkXfSapj+odspUitY9MdatUJbaST6xdx8B4uAib96gQKA8rzULdJbFzPDxhQ3qXX/2bcNnfJNvLONmQHCUuq0dEylHD0a86ImvjFPz9LLyOeyvovolbl2BxnDVRTVUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsBYMFD3vAUiN8ycxdIET3yF+IDjHC9rD1PQp2Z6cxA=;
 b=YwL5qJIdN/wiCSXc/MF4xN3gzJjWEe8YGqHxgfeQ5EDBAAAXAjs2IOXbFUT2ZlMIfIoYupaboIGSRv7+rJ08gqq6XPa+uJz8gt0IdH+srXB8FFm+LrVZT/2vggaprrnYSrWzXfYPlh/Kt8IbTzeLm+t90urJE6zK8WkmVRGymBQ=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB4959.namprd03.prod.outlook.com (52.132.168.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Wed, 30 Oct 2019 14:50:01 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 14:50:01 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v4 16/20] fuzz: add support for fork-based fuzzing.
Thread-Topic: [PATCH v4 16/20] fuzz: add support for fork-based fuzzing.
Thread-Index: AQHVjzFOh7bxt3iDm0CreiaspQc+BQ==
Date: Wed, 30 Oct 2019 14:50:01 +0000
Message-ID: <20191030144926.11873-17-alxndr@bu.edu>
References: <20191030144926.11873-1-alxndr@bu.edu>
In-Reply-To: <20191030144926.11873-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: DM5PR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:4:60::37) To MN2PR03MB4800.namprd03.prod.outlook.com
 (2603:10b6:208:101::14)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f8e5541-362e-4aee-64d4-08d75d48712b
x-ms-traffictypediagnostic: MN2PR03MB4959:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB4959E1F94C14E23436064DE7BA600@MN2PR03MB4959.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(102836004)(386003)(6506007)(66946007)(66446008)(64756008)(66476007)(2616005)(186003)(2351001)(446003)(26005)(36756003)(66556008)(3846002)(6116002)(2501003)(14454004)(11346002)(66066001)(256004)(4326008)(6916009)(305945005)(1076003)(6486002)(486006)(5660300002)(71190400001)(50226002)(71200400001)(476003)(86362001)(88552002)(7736002)(52116002)(76176011)(2906002)(478600001)(99286004)(786003)(316002)(8676002)(81166006)(5640700003)(81156014)(25786009)(6436002)(54906003)(75432002)(8936002)(6512007)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB4959;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZRh9AocM2/YDzfcc3f0cl5sN/OiPmBgzgJqIqBoaEL83B+k8hQ1VCxUmfyEkLJ4KflNAgAiX19wDs30vI/fB9gCQE+FmN+oSQJn+rOlKKDslhWva0Zi9hlPagRK8DANSn1zuvv3QvTcrFpSqRPF9wXZgqag+lhflqbWNdXjsQEnnXoIsTHmo5DnXrr/9qWywZR0YBsbiaLIMBsnALqiFucjRahfI/yX7ZTtxAIWRVD7fmP3fA9hIspqbSWgEOgL4dXgA4yi4fEtvnylVlu2IHeZeeLR0g3a5KvIs1bUlSs50CMK4gM39JqhWDnJkicCFEdPhivRfoLfYnHfQXld6/4+gjmsmKDa7rzU4zAa05qipbuKGhpH+2Lgdf6SMxL9X280HRYU84nYpRphCm82iEEUxayW5ol2VTpmWgRGbfrZa+GR7OsXzUsm/fs2c9Tdq
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8e5541-362e-4aee-64d4-08d75d48712b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 14:50:01.5861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0+ZAC7J3Z3fNlHiwfwteyHYz4YNAlbAnGshecdF5A4oT73WhO1UZhBs4AtwrGWNH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4959
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.69.101
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
Cc: "Oleinik, Alexander" <alxndr@bu.edu>, Richard Henderson <rth@twiddle.net>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Oleinik <alxndr@bu.edu>

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

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 exec.c                      | 12 +++++++--
 tests/fuzz/Makefile.include |  3 +++
 tests/fuzz/fork_fuzz.c      | 51 +++++++++++++++++++++++++++++++++++++
 tests/fuzz/fork_fuzz.h      | 23 +++++++++++++++++
 tests/fuzz/fork_fuzz.ld     | 37 +++++++++++++++++++++++++++
 5 files changed, 124 insertions(+), 2 deletions(-)
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
index 0000000000..4c4d00b034
--- /dev/null
+++ b/tests/fuzz/fork_fuzz.c
@@ -0,0 +1,51 @@
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
+uintptr_t feature_shm;
+
+void counter_shm_init(void)
+{
+    int fd =3D shm_open("/qemu-fuzz-cntrs", O_CREAT | O_RDWR, S_IRUSR | S_=
IWUSR);
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
+    if (!rptr) {
+        perror("Error: ");
+        exit(1);
+    }
+    return;
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
index 0000000000..51ba3717c4
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
+
+      /* Coverage counters. They're not necessary for fuzzing, but are use=
ful
+       * for analyzing the fuzzing performance
+       */
+      __start___llvm_prf_cnts =3D .;
+      *(*llvm_prf_cnts);
+      __stop___llvm_prf_cnts =3D .;
+  }
+  .data.fuzz_ordered :
+  {
+      /* Internal Libfuzzer TracePC object which contains the ValueProfile=
Map */
+      FuzzerTracePC*(.bss);
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


