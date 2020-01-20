Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515C5C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:13:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A01F2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="EevIPBX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A01F2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itQJd-0003ax-1l
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 01:13:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1itQ1q-0007Tx-LX
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:55:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1itQ1l-0006Ww-Td
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:55:14 -0500
Received: from mail-bn7nam10on2137.outbound.protection.outlook.com
 ([40.107.92.137]:7744 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1itQ1l-0006Wd-O6
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:55:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJMarrCqvyI5uH94AJrL2+vMj/bXMrZzcY5TvrrLm+S+z9Jmg5GOdOJiFGEZyL32BUv7O/QgF4XwxA3pDWbqL0Va3IFSPazCC2TGZhHe/dEg5Sedm0F4wKSMHz2Vr0dmqmTUrGSMJ7yvoGIktkmDiVCSqwcyjx4rhpk9qtUPunIF+UeA6D/TL7mZk4AEOIwpy06O9Gv86JHDhopnXgp7wkwhR1QWdFGBnaqWv9Yb7nd6PjJXCqivUQC/vLgjZCB2dGVLZFsLnCq7Pzh8FVCyx1fjOb7jadSZL3qZidrEHhUVQWXXjew9u6frlY76RkBpX+CFOJcsHqlr0JiunqDVzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9nZbM1cHG8+T2w6lWAIJ8R9dKsYeRQJZHQu6VGGuXI=;
 b=CYeQXP7W0mIvwGUtXC7iHnu4b6KLCtqUeeP5pV58J0q8911lLIjJTtJy+QBQUkCD6cP5I/iew3FFiwUAGJASMc+4zXvPasSv1UTKxV4zdMTryBqJgSTaZ+KNTmRoTOQMKLm4IL/VmoAmOW5eHyC/I0GhZj0hF7DLEMGtZ/PSxaSI1is7ydDVZ+1pRC1edOGXTHE+k1uBYmI4yWsYQmIla3URDz4xs7TZ4oNUbG41WIGUfv4ibbg43FJNDEzWOtFKZZSgX8ZLVd+6i+Ui3cz3bIuu1Ew+LWjntmGR0dLpZMGXTSu6FRgu498Hv8Ftivll5UBEzynWh3JI1m2UiXqB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9nZbM1cHG8+T2w6lWAIJ8R9dKsYeRQJZHQu6VGGuXI=;
 b=EevIPBX8Xp5cE5QO81X6WeowKSzvIscjZJIeT2VcUSp3awOqq2ckeB1qtKV984gtoacRm21MPWMqCYvMo1CiF7HckrJFmV16ExVKf50V7S/IIiu9fKNxSFyZwCUVq7vWQn/SP/6TNH17/E6/jpJBYj4I498NZ6IOOFIBfUj8BSM=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4399.namprd03.prod.outlook.com (20.178.6.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 05:55:08 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 05:55:08 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR20CA0032.namprd20.prod.outlook.com (2603:10b6:208:e8::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Mon, 20 Jan 2020 05:55:08 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v7 18/20] fuzz: add virtio-net fuzz target
Thread-Topic: [PATCH v7 18/20] fuzz: add virtio-net fuzz target
Thread-Index: AQHVz1YrCuOUdpnUh0q1DYVR7GBu5w==
Date: Mon, 20 Jan 2020 05:55:08 +0000
Message-ID: <20200120055410.22322-26-alxndr@bu.edu>
References: <20200120055410.22322-1-alxndr@bu.edu>
In-Reply-To: <20200120055410.22322-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:208:e8::45) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26a23474-76e1-4b37-dcfa-08d79d6d4e43
x-ms-traffictypediagnostic: SN6PR03MB4399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB43990D440026819E06C6F5B5BA320@SN6PR03MB4399.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(5660300002)(956004)(2616005)(8936002)(86362001)(6916009)(6486002)(7696005)(1076003)(52116002)(316002)(71200400001)(16526019)(186003)(786003)(478600001)(2906002)(26005)(81166006)(66946007)(66476007)(64756008)(36756003)(8676002)(75432002)(81156014)(66446008)(4326008)(66556008)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4399;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ko1rOK1uRYLWpk8vrmFkCcQZWuJcsjija0MbBI6MjXe58ue62c4Mi2RPIYyd3FdcZGdUNYucHxfF1u33Wq17v2d+uHO/9iu2+hwDS5rT8WwNkcLW5Pc5U/x4fd5ZuRYYQhXd/17Z+DExCCCk4QMstOtcK/wDxFX/8DJyWevQSVqj3TpmiYAzD7wn/pW0aK8OY4TNdF65H6RpPpc2b2ZNHNky8txT+j6JmtPR1Ns60qGfwWD3Sqmuj3+S65ZbsZ40R3VrL14o/V5PgZiEOJjxQVm8mE3H/NlqSRm922UhsjbW7OX2RVmDlp10D2ohScdnDV/zcLbebJGY5X7/il0pipOJlv7ajXSzffIhB2n3pjr7Ru+mehS6lqhuNiX6g4e6yIMFrX3qinX4JBank2DLMh3UPyerNZ5SzV2z3R9Wa5fmjPG7+fr5+VS1m4nzo1zd
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a23474-76e1-4b37-dcfa-08d79d6d4e43
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 05:55:08.7700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GpyoylSEj0QeHzKHUqsmOYa+jgKEswFMyulDt4TfdBDqMS23tCueQQLx1r4bYUls
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4399
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.137
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

The virtio-net fuzz target feeds inputs to all three virtio-net
virtqueues, and uses forking to avoid leaking state between fuzz runs.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/Makefile.include  |   1 +
 tests/qtest/fuzz/virtio_net_fuzz.c | 190 +++++++++++++++++++++++++++++
 2 files changed, 191 insertions(+)
 create mode 100644 tests/qtest/fuzz/virtio_net_fuzz.c

diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.=
include
index 38b8cdd9f1..77385777ef 100644
--- a/tests/qtest/fuzz/Makefile.include
+++ b/tests/qtest/fuzz/Makefile.include
@@ -8,6 +8,7 @@ fuzz-obj-y +=3D tests/qtest/fuzz/qos_fuzz.o
=20
 # Targets
 fuzz-obj-y +=3D tests/qtest/fuzz/i440fx_fuzz.o
+fuzz-obj-y +=3D tests/qtest/fuzz/virtio_net_fuzz.o
=20
 FUZZ_CFLAGS +=3D -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
=20
diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c b/tests/qtest/fuzz/virtio_n=
et_fuzz.c
new file mode 100644
index 0000000000..3b1b79fd93
--- /dev/null
+++ b/tests/qtest/fuzz/virtio_net_fuzz.c
@@ -0,0 +1,190 @@
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
+#include "tests/qtest/libqtest.h"
+#include "tests/qtest/libqos/virtio-net.h"
+#include "fuzz.h"
+#include "fork_fuzz.h"
+#include "qos_fuzz.h"
+
+#define QVIRTIO_NET_TIMEOUT_US (30 * 1000 * 1000)
+#define QVIRTIO_RX_VQ 0
+#define QVIRTIO_TX_VQ 1
+#define QVIRTIO_CTRL_VQ 2
+
+#define VIRTIO_CONFIG_S_NEEDS_RESET 0x40
+
+static int *sv;
+
+static void virtio_net_fuzz_multi(QTestState *s,
+        const unsigned char *Data, size_t Size, bool check_used)
+{
+    typedef struct vq_action {
+        uint8_t queue;
+        uint8_t length;
+        uint8_t write;
+        uint8_t next;
+        uint8_t rx;
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
+        if (vqa.rx && sv) {
+            write(sv[0], Data, vqa.length);
+        } else {
+            vqa.rx =3D 0;
+            uint64_t req_addr =3D guest_alloc(t_alloc, vqa.length);
+            /*
+             * If checking used ring, ensure that the fuzzer doesn't trigg=
er
+             * trivial asserion failure on zero-zied buffer
+             */
+            qtest_memwrite(s, req_addr, Data, vqa.length);
+
+
+            free_head =3D qvirtqueue_add(s, q, req_addr, vqa.length,
+                    vqa.write, vqa.next);
+            qvirtqueue_add(s, q, req_addr, vqa.length, vqa.write , vqa.nex=
t);
+            qvirtqueue_kick(s, dev, q, free_head);
+        }
+
+        /*
+         * normally, we could just use qvirtio_wait_used_elem, but since w=
e
+         * must manually run the main-loop for all the bhs to run, we use
+         * this hack with flush_events(), to run the main_loop
+         */
+        gint64 start_time =3D g_get_monotonic_time();
+        for (;;) {
+            /* Run the main loop */
+            qtest_clock_step(s, 100);
+            flush_events(s);
+            /* Poll the used vring only if we added to the TX or CTRL vq *=
/
+            if (check_used && !vqa.rx && q !=3D net_if->queues[QVIRTIO_RX_=
VQ]) {
+                uint32_t got_desc_idx;
+                /* Input led to a virtio_error */
+                if (dev->bus->get_status(dev) & VIRTIO_CONFIG_S_NEEDS_RESE=
T) {
+                    break;
+                }
+                if (dev->bus->get_queue_isr_status(dev, q) &&
+                        qvirtqueue_get_buf(s, q, &got_desc_idx, NULL)) {
+                    g_assert_cmpint(got_desc_idx, =3D=3D, free_head);
+                    break;
+                }
+                g_assert(g_get_monotonic_time() - start_time
+                         <=3D QVIRTIO_NET_TIMEOUT_US);
+            } else {
+                break;
+            }
+        }
+        Data +=3D vqa.length;
+        Size -=3D vqa.length;
+    }
+}
+
+static void virtio_net_fork_fuzz(QTestState *s,
+        const unsigned char *Data, size_t Size)
+{
+    if (fork() =3D=3D 0) {
+        virtio_net_fuzz_multi(s, Data, Size, false);
+        flush_events(s);
+        _Exit(0);
+    } else {
+        wait(NULL);
+    }
+}
+
+static void virtio_net_fork_fuzz_check_used(QTestState *s,
+        const unsigned char *Data, size_t Size)
+{
+    if (fork() =3D=3D 0) {
+        virtio_net_fuzz_multi(s, Data, Size, true);
+        flush_events(s);
+        _Exit(0);
+    } else {
+        wait(NULL);
+    }
+}
+
+static void virtio_net_pre_fuzz(QTestState *s)
+{
+    qos_init_path(s);
+    counter_shm_init();
+}
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
+static void *virtio_net_test_setup_user(GString *cmd_line, void *arg)
+{
+    g_string_append_printf(cmd_line, " -netdev user,id=3Dhs0 ");
+    return arg;
+}
+
+static void register_virtio_net_fuzz_targets(void)
+{
+    fuzz_add_qos_target(&(FuzzTarget){
+            .name =3D "virtio-net-socket",
+            .description =3D "Fuzz the virtio-net virtual queues. Fuzz inc=
oming "
+            "traffic using the socket backend",
+            .pre_fuzz =3D &virtio_net_pre_fuzz,
+            .fuzz =3D virtio_net_fork_fuzz,},
+            "virtio-net",
+            &(QOSGraphTestOptions){.before =3D virtio_net_test_setup_socke=
t}
+            );
+
+    fuzz_add_qos_target(&(FuzzTarget){
+            .name =3D "virtio-net-socket-check-used",
+            .description =3D "Fuzz the virtio-net virtual queues. Wait for=
 the "
+            "descriptors to be used. Timeout may indicate improperly handl=
ed "
+            "input",
+            .pre_fuzz =3D &virtio_net_pre_fuzz,
+            .fuzz =3D virtio_net_fork_fuzz_check_used,},
+            "virtio-net",
+            &(QOSGraphTestOptions){.before =3D virtio_net_test_setup_socke=
t}
+            );
+    fuzz_add_qos_target(&(FuzzTarget){
+            .name =3D "virtio-net-slirp",
+            .description =3D "Fuzz the virtio-net virtual queues with the =
slirp "
+            " backend. Warning: May result in network traffic emitted from=
 the "
+            " process. Run in an isolated network environment.",
+            .pre_fuzz =3D &virtio_net_pre_fuzz,
+            .fuzz =3D virtio_net_fork_fuzz,},
+            "virtio-net",
+            &(QOSGraphTestOptions){.before =3D virtio_net_test_setup_user}
+            );
+}
+
+fuzz_target_init(register_virtio_net_fuzz_targets);
--=20
2.23.0


