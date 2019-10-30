Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E0ECA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 15:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A2320874
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 15:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="fkfB29I0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A2320874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPpfk-0006kh-I7
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 11:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iPpIa-0005ED-Mh
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iPpIZ-0007b8-AP
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:12 -0400
Received: from mail-eopbgr690101.outbound.protection.outlook.com
 ([40.107.69.101]:31361 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iPpIZ-0007LI-2S
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYkqUazOdJvSlFE5zdfWk8NnZNbtfMwMNBKM+SiisGyPIaiUGFC8Yi5pvBrW0hW085wv64gDgGsZmAdIv/EZIxcVBMWr/hTp6afMczldoFEV+yNjIyae0DKXvJssuWLaLNb6d10zKTqlTzWe7tTPycPfyFZbvHOInR06AhdlBkVPfJ7kr0RcI3l7azHS0Ve7qS+s4gYBKfk+c7WdzVZ0V9YNl7ZQBfTpHA09VJlSnscJ/w9kKCYkQajjIstpCVmrMaXV2z7RWpF8Ym12DUxgcFHgtEPMtJ30Q14b5Wn0t5lTpr51N2dS/Rlcd60qFnsiScCtqfMFEmP5bQUemCmAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOAMPPdrRQbGjSlUjPItffV6O2I9QkC8bplzLpjAKw4=;
 b=lWnTE5tfnkfpkoULYzA1VhLomz+oYBxndASObwb5mP7139wDoi8lpntjsASjT/Wy4wfV+qhDCDgN+Q7+v1145hdFz8vA/aYTT093JvD41nf4DQTLxMMq5FLsJnoPDdpTl4GY6iomp0hyPORx32PQ08P8ZqpMwblfXXY9+3S+UoXKupdIqoW+iszgZ+Z6pgQrFvIhM/4sC019zqoXdB1O0sKV9XGEqo+Vz7FAsDa1wumTeiJ3tSPMgukwo8AN8WJ5dHY62/qOH7dZFTth8IWB7wkpEuX5RbtKfvFb6W2MygtYSYVZL/viAH1Ma+z789brnWaAAfInDVkedxd/i+f6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOAMPPdrRQbGjSlUjPItffV6O2I9QkC8bplzLpjAKw4=;
 b=fkfB29I0nYD6oL8x9OCnpX3XFSDMUDqu+zaASTMI+thi5c3yuilGVtYRGgvexKduYUqTcnLkP7fdWD5Dw1u3r8UAz1aeoQ90wb9x+F0yj8rggzRC9tNz3uowQNFs5JJ3dbOm5CGvXgH5aar6sBt3oVTm4vUmEDhDYeiZowYMvsg=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB4959.namprd03.prod.outlook.com (52.132.168.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Wed, 30 Oct 2019 14:50:04 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 14:50:04 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v4 19/20] fuzz: add virtio-net fuzz target
Thread-Topic: [PATCH v4 19/20] fuzz: add virtio-net fuzz target
Thread-Index: AQHVjzFQK2GnRCGfJUGvHuDknq5Dsg==
Date: Wed, 30 Oct 2019 14:50:03 +0000
Message-ID: <20191030144926.11873-20-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 77e0003b-1c3e-4bb1-b437-08d75d487287
x-ms-traffictypediagnostic: MN2PR03MB4959:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB4959034A25314F56F212245ABA600@MN2PR03MB4959.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:281;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(102836004)(386003)(6506007)(66946007)(66446008)(64756008)(66476007)(2616005)(186003)(2351001)(446003)(26005)(36756003)(66556008)(3846002)(6116002)(2501003)(14454004)(11346002)(66066001)(256004)(4326008)(6916009)(305945005)(1076003)(6486002)(486006)(5660300002)(71190400001)(50226002)(71200400001)(476003)(86362001)(88552002)(7736002)(52116002)(76176011)(2906002)(478600001)(99286004)(786003)(316002)(8676002)(81166006)(5640700003)(81156014)(25786009)(6436002)(75432002)(8936002)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB4959;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z0OFBYJ8ML9ye6TO6oFhUqPXoZkYuqwO80Thre5WpwIvKVc5+j0D9eXVf7LJgQMazoy4b3oDFl/f6RvOJ7J5oFOx0L5gBDIXlj4pT+aeU8e6ZKzhMmy0hUqR5A6RD2duA9HnFVt40mElbAYwvYOrR165vMrAmKRPF5Tn278bSo1+uYfJ7Gesrs/ujWa6tcQ00ufNXlMVLSyYJNO9QTK5IJ9sz78FwFjfnOqi83H6nm3So0542ohU9FwJsZ4kD7xHHGMFPiV4VFz8NNE5qqtdDziEUzmMcMGwAUNvmjA2ReCsa2nR8wL9J6DgTei6K2R89TEfTo6QZy/SH9JmjNIATtkTcnzLfEm413pp1DuJqgdzRYmyjWGEPy2eaoCrd7BXr+P01u1pJJTKHmCLnccSZmCTYv8iGfVoGxWSxInknN28BKIphePeGhXwJFIo3/Hc
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e0003b-1c3e-4bb1-b437-08d75d487287
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 14:50:03.8767 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4omgZEY+NVmb7Tx7LTGkbkc4yN+PPy84BpKamt4xvV92/TFmrjUPF55IMkz4C7m
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
Cc: "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Oleinik <alxndr@bu.edu>

The virtio-net fuzz target feeds inputs to all three virtio-net
virtqueues, and uses forking to avoid leaking state between fuzz runs.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/fuzz/Makefile.include  |   1 +
 tests/fuzz/virtio_net_fuzz.c | 123 +++++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)
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
index 0000000000..0543cfd32a
--- /dev/null
+++ b/tests/fuzz/virtio_net_fuzz.c
@@ -0,0 +1,123 @@
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
+        bool kick;
+    } vq_action;
+
+    uint64_t req_addr[10];
+    int reqi =3D 0;
+    uint32_t free_head =3D 0;
+
+    QGuestAllocator *t_alloc =3D fuzz_qos_alloc;
+
+    QVirtioNet *net_if =3D fuzz_qos_obj;
+    QVirtioDevice *dev =3D net_if->vdev;
+    QVirtQueue *q;
+    vq_action vqa;
+    int iters =3D 0;
+    while (true) {
+        if (Size < sizeof(vqa)) {
+            break;
+        }
+        memcpy(&vqa, Data, sizeof(vqa));
+        vqa =3D *((vq_action *)Data);
+        Data +=3D sizeof(vqa);
+        Size -=3D sizeof(vqa);
+
+        q =3D net_if->queues[vqa.queue % 3];
+
+        vqa.length =3D vqa.length >=3D Size ? Size :  vqa.length;
+
+        req_addr[reqi] =3D guest_alloc(t_alloc, vqa.length);
+        qtest_memwrite(s, req_addr[reqi], Data, vqa.length);
+        if (iters =3D=3D 0) {
+            free_head =3D qvirtqueue_add(s, q, req_addr[reqi], vqa.length,
+                    vqa.write, vqa.next);
+        } else {
+            qvirtqueue_add(s, q,
+                    req_addr[reqi], vqa.length, vqa.write , vqa.next);
+        }
+        iters++;
+        reqi++;
+        if (iters =3D=3D 10) {
+            break;
+        }
+        Data +=3D vqa.length;
+        Size -=3D vqa.length;
+    }
+    if (iters) {
+        qvirtqueue_kick(s, dev, q, free_head);
+        qtest_clock_step_next(s);
+        for (int i =3D 0; i < reqi; i++) {
+            guest_free(t_alloc, req_addr[i]);
+        }
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


