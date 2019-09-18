Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81ABC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:43:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F56F218AE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="2/g8zcsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F56F218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAjbQ-0006lV-JM
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAjEi-0000Zm-PW
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAjEh-0002i2-25
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:48 -0400
Received: from mail-eopbgr700099.outbound.protection.outlook.com
 ([40.107.70.99]:57953 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAjEg-0002fm-RS
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oR1sVxy8t701HxUHbGmda8HRk0nBF6O3nj5dhe2yNPt4KjjpaFCJEw2PCQBtFfeciDcrb/MgwCSz/L5043fjyVfFZb7eD3xU/kRaWetmxYmIAP3P9py4BlLEi4zg6T83tD/6kSESMexPbAW1H7HzmeVlOZzg8g/Anunz44XNCKkXJmyuF7xXKmfyP+Y8CFdHdhswEUxiTVvVC/TQlmXj6C2BjpMf/LU9KNOyIjgUckE30LWMypzCctZoWq5oe5Yz4dx4x8W1PGcEI3d2kay/2V932WTfU+m4mMP5kLsrFqoPUrGEECOCfn9KMyCZ5oO7qJP9Manz1rxLGsinUcgjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81e6ejmRqzYfhpK9hF3JafBxA8nvMvSc9hbwmPnDi9A=;
 b=FMSjlAvXCBpX+65vyLZnzEHB6qvKfLmBYw59irqIEMrUU4gci/8kOJ+DsiORs3Epa9huxTebYcYTqlnWxIj4ZHxGY5xdEGdEpF7t85w1iK+VGSbzHpvaaEYvoiX3iryn/KsLv7zpZHZ7fkLvdSIgZoApSapUzjMm37c1tRvfvedS9+6lIpbyvn0bSImAkGJP63aYDONdrVlvvno1zlG69TR5n3f4uaHj6OJVkCy1rIQa7wcDrMBEVravsMTF4xMPtKQWieK52TxcDJhXOnzJcdUVhufXOfNGW0I7VKiMGtVuvuIim3aTIpAy1+i1f0788mx2FsVCBFLLbN2BaFjvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81e6ejmRqzYfhpK9hF3JafBxA8nvMvSc9hbwmPnDi9A=;
 b=2/g8zcsC54QGHn0EgTZQzOvoG3R2FarbIO2jvN/kCal9OfLjyO4lY1Po0ptzBQp5ttnfaBAZAaumZ4pWQsetPVOjSNF5j8r51LZjMIzQi/wK52mV86WclRymDPpkFdLmhHqiCU+5H3BPYrcymFSkmprkq6bfTbVrev2IJ823ew4=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3016.namprd03.prod.outlook.com (10.175.117.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 23:19:45 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 23:19:44 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 17/22] fuzz: add support for fork-based fuzzing.
Thread-Index: AQHVbneO8lKIXFBEJ0KI61E+89ePjQ==
Date: Wed, 18 Sep 2019 23:19:44 +0000
Message-ID: <20190918231846.22538-18-alxndr@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
In-Reply-To: <20190918231846.22538-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ab2e414-c393-417c-7df1-08d73c8eb0a5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB3016; 
x-ms-traffictypediagnostic: CY4PR03MB3016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB3016757E73F618A5444BDDABBA8E0@CY4PR03MB3016.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(66066001)(86362001)(52116002)(478600001)(2616005)(7736002)(71190400001)(8676002)(36756003)(71200400001)(14454004)(54906003)(316002)(786003)(6486002)(81156014)(75432002)(256004)(6436002)(305945005)(6916009)(6512007)(5640700003)(386003)(486006)(26005)(11346002)(186003)(102836004)(99286004)(76176011)(66946007)(446003)(476003)(66476007)(66556008)(64756008)(66446008)(6506007)(5660300002)(4326008)(2501003)(2351001)(6116002)(81166006)(50226002)(25786009)(1076003)(2906002)(88552002)(8936002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3016;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vRLpUpo2fFhwAmf5jY8ltfIEgw6Fn57qEOTwNEGzX6MLwnFw/tbyT4aL79/UpOkz2Zbrit9r2NB1aBqbhIeqD5cFheEX7RfC5/OhSD30IeW7TfWZU/HFchpXfiqWfEJ8aWoVpQGHiVcNwJS7Y53whXrAl5g/lbPt/6BwnBaO2Fx/LtREyo6JCazKQXnkxf5OmqIAN0wj2WWt6YzmHEH1fPOKNJiLfR3fz6K/0YqlKpmztwRg8iEcamxxeY/HMVA/W3owwZUXIRYUrI28D18f09JTh2SCPM5LCPKfYyEmv0YAOdjrlZ4/0yAExlCghnxBf7Nk+nNfwjTk4svELPuxFv6q3A20n9PIF/8kD3i3Dx+hZVXETv5JakPDV9ZjuhD6UsBVNaQCpDiK7p2ijWJ9rC3Hele2Aol1/cQywSfL+vw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab2e414-c393-417c-7df1-08d73c8eb0a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 23:19:44.4132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GwWLjh3RikBZCe7vKJcF/E00tSsfzGTQJsyoFvhpNb3XPjOAD5zIAyglwidQIWcW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3016
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.99
Subject: [Qemu-devel] [PATCH v3 17/22] fuzz: add support for fork-based
 fuzzing.
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
instrumentation and there seems to be no simple way to re-map them as
shared memory. As a workaround, we use a linker script modification to
place all of the bitmaps together and add some markers around them which
we can observe from our code. Then, we map shared memory and copy the
bimaps to the SHM (in the child) and out of the SHM(in the parent) after
each fuzzing run. Ram blocks are marked as DONTFORK in exec.c, which
breaks this approach. For now, avoid this with an #ifdef.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 exec.c                      |  2 ++
 tests/fuzz/Makefile.include |  3 +++
 tests/fuzz/fork_fuzz.c      | 27 ++++++++++++++++++++++
 tests/fuzz/fork_fuzz.h      | 12 ++++++++++
 tests/fuzz/fork_fuzz.ld     | 46 +++++++++++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+)
 create mode 100644 tests/fuzz/fork_fuzz.c
 create mode 100644 tests/fuzz/fork_fuzz.h
 create mode 100644 tests/fuzz/fork_fuzz.ld

diff --git a/exec.c b/exec.c
index 235d6bc883..d3838f4ea4 100644
--- a/exec.c
+++ b/exec.c
@@ -2295,7 +2295,9 @@ static void ram_block_add(RAMBlock *new_block, Error =
**errp, bool shared)
         qemu_ram_setup_dump(new_block->host, new_block->max_length);
         qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUG=
EPAGE);
         /* MADV_DONTFORK is also needed by KVM in absence of synchronous M=
MU */
+#ifndef CONFIG_FUZZ /* This conflicts with fork-based fuzzing */
         qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_DON=
TFORK);
+#endif
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
index 0000000000..26d0b4b42e
--- /dev/null
+++ b/tests/fuzz/fork_fuzz.c
@@ -0,0 +1,27 @@
+#include "qemu/osdep.h"
+#include "fork_fuzz.h"
+
+uintptr_t feature_shm;
+
+void counter_shm_init(void)
+{
+    feature_shm =3D (uintptr_t)mmap(NULL,
+            &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START,
+            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+    return;
+}
+
+void counter_shm_store(void)
+{
+    memcpy((void *)feature_shm,
+            &__FUZZ_COUNTERS_START,
+            &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START);
+}
+
+void counter_shm_load(void)
+{
+    memcpy(&__FUZZ_COUNTERS_START,
+            (void *)feature_shm,
+            &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START);
+}
+
diff --git a/tests/fuzz/fork_fuzz.h b/tests/fuzz/fork_fuzz.h
new file mode 100644
index 0000000000..b5f8b35015
--- /dev/null
+++ b/tests/fuzz/fork_fuzz.h
@@ -0,0 +1,12 @@
+#ifndef FORK_FUZZ_H
+#define FORK_FUZZ_H
+
+extern uint8_t __FUZZ_COUNTERS_START;
+extern uint8_t __FUZZ_COUNTERS_END;
+
+void counter_shm_init(void);
+void counter_shm_store(void);
+void counter_shm_load(void);
+
+#endif
+
diff --git a/tests/fuzz/fork_fuzz.ld b/tests/fuzz/fork_fuzz.ld
new file mode 100644
index 0000000000..ba0ba79570
--- /dev/null
+++ b/tests/fuzz/fork_fuzz.ld
@@ -0,0 +1,46 @@
+/* We adjust linker script modification to place all of the stuff that nee=
ds to
+ * persist across fuzzing runs into a contiguous seciton of memory. Then, =
it is
+ * easy to copy it to and from shared memory.
+ *
+ * Total Size : A5A00
+ * Sancov counters: B26F
+ * Coverage counters: 56D60
+ * TracePC Object: 43C00
+*/
+
+SECTIONS
+{
+  .data.fuzz_start : ALIGN(4K)
+  {
+        __FUZZ_COUNTERS_START =3D .;
+  }
+  .data.fuzz_ordered :
+  {
+      /* Internal Libfuzzer TracePC object which contains the ValueProfile=
Map.
+       * Not optimal that we have to copy the rest of the TracePC object.
+       * */
+      __start___sancov_cntrs =3D .;
+      *(__sancov_cntrs*)
+      __stop___sancov_cntrs =3D .;
+  }
+  .data.fuzz_unordered :
+  {
+      /* Coverage counters. They're not necessary for fuzzing, but are use=
ful
+       * for analyzing the fuzzing performance
+       * */
+      __start___llvm_prf_cnts =3D .;
+      *(*llvm_prf_cnts);
+      __stop___llvm_prf_cnts =3D .;
+
+      /* Lowest stack counter */
+      *(__sancov_lowest_stack);
+      /* Internal Libfuzzer TracePC object which contains the ValueProfile=
Map.
+       * Not optimal that we have to copy the rest of the TracePC object.
+       * */
+      *FuzzerTracePC*(.bss._ZN6fuzzer*)
+      __FUZZ_COUNTERS_END =3D .;
+  }
+}
+/* Dont overwrite the SECTIONS in the default linker script. Instead inser=
t the
+ * above into the default script */
+INSERT AFTER .data;
--=20
2.23.0


