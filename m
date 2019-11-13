Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E44C43215
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D542206EE
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="La4vl5bf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D542206EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV1dk-0000F3-SA
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 18:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iV1TW-00088b-KM
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iV1TV-0007p8-F9
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:58 -0500
Received: from mail-dm3nam03on0714.outbound.protection.outlook.com
 ([2a01:111:f400:fe49::714]:27886
 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iV1TV-0007jr-7s
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFVvkkWSBGWdGYywaikz757QN9/HRihkL7l6RfrT0kaimIT99r7XrCmBS7le5XztAvHv9qK5z30AKay1vbyjU7Pq4f2iD2Ak7ZnyYdwwglQVc6IwYGX7n82O90OvZEm8oCK/4uWZNL4xeKK3vlieXUaMGXEribdhoD/PFjkp+7YfTvp5MsfDE29lOTFEsHH3KoBcQdcIAmi5PxDD5iADnlp2vxGSkODhyBc9U+fhMy5xwunLh9e1o4husWEikFNW6ZIlabMQOvOCNHXqAyDmzvneM6DaUSFhuEqTNjdlh4L2CUZKuFYSpC1pN3+sBGpc1zQlbxEgjGLr6V4/PVsCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QdF0cjhnQS6yxUWYh5umpb68xo/20DpTsVMuC/kao0=;
 b=jCmQRV1Q71TYIg9jIpVXboRGjHO5jguKsfMefR5zk07colY6CJ7ZkL29FHov7kcl7bss1/B6BUAuMSxL0QPIkX1Y5iM+K2cbDjHIAd8ZQ+raQcL31AaPT92ufH2WWUS9Jge5DS3upz1IESSBkZY9Jc5Lr4N3wfGJPm2BBtRFu2WRPLICvScXCk/tJ5rTs3wLsy8HIg0OlkMnvuHFKTpx6RBxJprAGKnKJUJgxGrK4XaiMcm92FQ1n78wste4q2V5TChJOUaldekVhGYh6N1kwV7zfWryuGUoF2BYOzd5fuAaoXzFMTr1MB1AdJ0jyZPHJ5vkQftZLXx6OT9VyHTQQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QdF0cjhnQS6yxUWYh5umpb68xo/20DpTsVMuC/kao0=;
 b=La4vl5bfnr036l4vxVzghTK0gW4tk2Pgrqw/aQIpFUhiW0s4nPySjH++j/cP+TPDCM1PiSID1gw/xEWVHaFtBqqoIlD9egiBC018mZv6o+UQOu54kdB9YxvsR51lltVOmdL1DokXrntCXDHDQNSoUJlq2qv/iklgXW5qlFcJktQ=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5024.namprd03.prod.outlook.com (52.132.169.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 22:50:53 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 22:50:53 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v5 19/20] fuzz: add virtio-net fuzz target
Thread-Topic: [PATCH v5 19/20] fuzz: add virtio-net fuzz target
Thread-Index: AQHVmnTN3T8hiamlfUmcUem5tq/K1w==
Date: Wed, 13 Nov 2019 22:50:53 +0000
Message-ID: <20191113225030.17023-20-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 56ad39a3-8faf-43a8-1f0c-08d7688bf03e
x-ms-traffictypediagnostic: MN2PR03MB5024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB502411C92EED73E2DD54A40DBA760@MN2PR03MB5024.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:389;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(1496009)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(2501003)(88552002)(75432002)(54906003)(446003)(7736002)(99286004)(11346002)(6436002)(6486002)(5640700003)(476003)(305945005)(256004)(786003)(2906002)(2351001)(316002)(14454004)(6116002)(86362001)(2616005)(6512007)(6916009)(486006)(3846002)(71200400001)(71190400001)(4326008)(1076003)(36756003)(386003)(8676002)(478600001)(66066001)(76176011)(81166006)(186003)(66946007)(5660300002)(6506007)(81156014)(64756008)(52116002)(26005)(102836004)(50226002)(25786009)(8936002)(66476007)(66556008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5024;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Zhqdvo8xvz1lqh0H//ifnn+FVOUkk6S7X0mYjDLZpqCaom7kkP0qE+4E2HAYFNGScRMWfZ8wf4YKJImltuGIFIAF2HYQoriUXTznKbGV74z8ZIMHXR9GFLN3RKSbQ3A++Z7rWxlLSyoUdwX5BJPaVI7D/Y/pck//550hdQ1GJyGzRCoV3hcFiqOPLpRB22PztieekhdCId1dG8c6gDCpbFoD1S7uqHpJ0kTSYQ0nzS3rYES1Y9WcM+9Y/f/pgs7R2OrHXPNPg+p/iyI76DkP5UBytSGHX/URmYkEG5oIlu3J/A5XpOnIH+okr7+z2oemYDLeeF8aJAzcPwMizDctN/WCOHoW+wtHwO/CoyljOZcIMD29HmBHbSluKAHGgU+hGyOuU0zA+L0Nnsuq2cpxMJSnf2AjWMy4Qaqv6HHf35fquBtl5fg4ruWszFR0dyy
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ad39a3-8faf-43a8-1f0c-08d7688bf03e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 22:50:53.8409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WDGFyYYNUuvalpWDcmNDvOj2UnkRg/q+Upl94LTpO0Vz/rypfk/uSarRlS81UDMI
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
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The virtio-net fuzz target feeds inputs to all three virtio-net
virtqueues, and uses forking to avoid leaking state between fuzz runs.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/fuzz/Makefile.include  |   1 +
 tests/fuzz/virtio_net_fuzz.c | 100 +++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 tests/fuzz/virtio_net_fuzz.c

diff --git a/tests/fuzz/Makefile.include b/tests/fuzz/Makefile.include
index 37d6821bee..f1d9b46b1c 100644
--- a/tests/fuzz/Makefile.include
+++ b/tests/fuzz/Makefile.include
@@ -6,5 +6,6 @@ fuzz-obj-y +=3D tests/fuzz/fork_fuzz.o
 fuzz-obj-y +=3D tests/fuzz/qos_fuzz.o
=20
 fuzz-obj-y +=3D tests/fuzz/i440fx_fuzz.o
+fuzz-obj-y +=3D tests/fuzz/virtio_net_fuzz.o
=20
 FUZZ_LDFLAGS +=3D -Xlinker -T$(SRC_PATH)/tests/fuzz/fork_fuzz.ld
diff --git a/tests/fuzz/virtio_net_fuzz.c b/tests/fuzz/virtio_net_fuzz.c
new file mode 100644
index 0000000000..cd7d086442
--- /dev/null
+++ b/tests/fuzz/virtio_net_fuzz.c
@@ -0,0 +1,100 @@
+/*
+ * virtio-net Fuzzing Target
+ *
+ * Copyright Red Hat Inc., 2019
+ *
+ * Authors:
+ *  Alexander Bulekov   <alxndr@bu.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "fuzz.h"
+#include "fork_fuzz.h"
+#include "qos_fuzz.h"
+#include "tests/libqtest.h"
+#include "tests/libqos/virtio-net.h"
+
+
+static void virtio_net_fuzz_multi(QTestState *s,
+        const unsigned char *Data, size_t Size)
+{
+    typedef struct vq_action {
+        uint8_t queue;
+        uint8_t length;
+        uint8_t write;
+        uint8_t next;
+    } vq_action;
+
+    uint32_t free_head =3D 0;
+
+    QGuestAllocator *t_alloc =3D fuzz_qos_alloc;
+
+    QVirtioNet *net_if =3D fuzz_qos_obj;
+    QVirtioDevice *dev =3D net_if->vdev;
+    QVirtQueue *q;
+    vq_action vqa;
+    while (Size >=3D sizeof(vqa)) {
+        memcpy(&vqa, Data, sizeof(vqa));
+        Data +=3D sizeof(vqa);
+        Size -=3D sizeof(vqa);
+
+        q =3D net_if->queues[vqa.queue % 3];
+
+        vqa.length =3D vqa.length >=3D Size ? Size :  vqa.length;
+
+        uint64_t req_addr =3D guest_alloc(t_alloc, vqa.length);
+        qtest_memwrite(s, req_addr, Data, vqa.length);
+        free_head =3D qvirtqueue_add(s, q, req_addr, vqa.length,
+                vqa.write, vqa.next);
+        qvirtqueue_add(s, q, req_addr, vqa.length, vqa.write , vqa.next);
+        qvirtqueue_kick(s, dev, q, free_head);
+        Data +=3D vqa.length;
+        Size -=3D vqa.length;
+    }
+}
+
+static int *sv;
+
+static void *virtio_net_test_setup_socket(GString *cmd_line, void *arg)
+{
+    if (!sv) {
+        sv =3D g_new(int, 2);
+        int ret =3D socketpair(PF_UNIX, SOCK_STREAM, 0, sv);
+        fcntl(sv[0], F_SETFL, O_NONBLOCK);
+        g_assert_cmpint(ret, !=3D, -1);
+    }
+    g_string_append_printf(cmd_line, " -netdev socket,fd=3D%d,id=3Dhs0 ", =
sv[1]);
+    return arg;
+}
+
+static void virtio_net_fork_fuzz(QTestState *s,
+        const unsigned char *Data, size_t Size)
+{
+    if (fork() =3D=3D 0) {
+        virtio_net_fuzz_multi(s, Data, Size);
+        flush_events(s);
+        _Exit(0);
+    } else {
+        wait(NULL);
+    }
+}
+
+static void register_virtio_net_fuzz_targets(void)
+{
+    fuzz_add_qos_target(&(FuzzTarget){
+                .name =3D "virtio-net-fork-fuzz",
+                .description =3D "Fuzz the virtio-net virtual queues, fork=
ing"
+                                "for each fuzz run",
+                .pre_vm_init =3D &counter_shm_init,
+                .pre_fuzz =3D &qos_init_path,
+                .fuzz =3D virtio_net_fork_fuzz,},
+                "virtio-net",
+                &(QOSGraphTestOptions){.before =3D virtio_net_test_setup_s=
ocket}
+                );
+}
+
+fuzz_target_init(register_virtio_net_fuzz_targets);
--=20
2.23.0


