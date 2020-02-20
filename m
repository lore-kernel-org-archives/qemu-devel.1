Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5AFC34031
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08DF8206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="OZr0XDz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DF8206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4dOe-0000ic-8v
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 23:25:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j4dBv-0004yp-5a
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:12:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j4dBt-00060f-KK
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:59 -0500
Received: from mail-co1nam11on2117.outbound.protection.outlook.com
 ([40.107.220.117]:50663 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j4dBt-00060B-A9
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILS6a5y8suGsVa75M4YB7J7SoakmuRALIw3rUE8X8YiFxKkxgCaEJ11wxes0erWS/IzPmKr7CB3ShAkTI0u2PRQzYsTRFnUXyixPYXhb9c4DZhtQjfQmzSPI9xFYlG3YdCLjTn9ytMazMutATGoNIwGIE5rCjKG/1gRB/DeKnDrXh9MEPl3VjkLN6q215fHNLaDvqKTHAhXHHWs1i5JreLXXi6B3NjD0nmeFRRNNfl52eHI+qV4IlZZbYelPfe/2WgHarWlXBo5GTbsL9qyf5JBPvefC3217AAeIZ4n7MVx19IQLV3/p6IWYy1iZMp9AvXZ/lUwAamWUwAqdZlmPLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QA+Rp2UQv3xglCx/1+vSBwPoNDPmahVOdn5xQ1oaSgA=;
 b=daQ3+6ysNHrPH8FATI+paP5N60O344RhxaZI/nR76WYK+R3RQgV+tFV3V1P2k5UeJH7F2yornQqlu7y5o2Nc3u/32jdoB8l29zzPw27dk5s68uVgFC0wnYHVq9Lr36UF1gFaOxm0ca55wKEZkS/J+Jow5hJZDseR1xmRhVpqDusRMJNHnyP6yiHx6Gzvj3nC+QpQU4aKGwrYkArLwF0p6oekOKXK5NwPoEvwk8LwWue01h9iFtCnNGe/MQgaHA+oBFmPjHohiMwZbE+aqt9AJNl7IvwQljL7ZEI+nP1PfxCZx0JHPfNgTSQkByYHCwog61B5xDbb726wyk6m9SrdEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QA+Rp2UQv3xglCx/1+vSBwPoNDPmahVOdn5xQ1oaSgA=;
 b=OZr0XDz899UhWFZwe4Cj9CVVbeTAW80FvJ7FoLMY8v/ciud5KHELJgSfCVHyLZk2sP1TCzIyHEOZPlU5c7tI0zbxJJPLzPbLnGPEwYbz5yaKo1aPTkgOdaRvLC4QXGQFHtXhBp0TqjAbeNjPPyOWsK2ryuSSvA5MtasraOhzeJ4=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3807.namprd03.prod.outlook.com (2603:10b6:805:6a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Thu, 20 Feb
 2020 04:11:55 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 04:11:55 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 20/22] fuzz: add virtio-net fuzz target
Date: Wed, 19 Feb 2020 23:11:16 -0500
Message-ID: <20200220041118.23264-21-alxndr@bu.edu>
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
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 04:11:54 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d03964a2-c6f1-4225-a61c-08d7b5bb057e
X-MS-TrafficTypeDiagnostic: SN6PR03MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB380750FF6468E753566CEF09BA130@SN6PR03MB3807.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
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
X-Microsoft-Antispam-Message-Info: C7jRdl61D6wGbIzhY1vDZluXi7a7fFrVftnl0TxgxYYYfPqrxYgaiScwpfEXdgqSe9GXSnbEBohGTNxItLvV7IiqPeXEb7f/0gyBp4MEIJcEauQswsSMac25J+PBhEgFtaDYbTr0tO0Qv4zrdh3L7BfSHu66K5QERHyyb5wJwZt29zwiGvxRBvWyedVwcP5lonuS7IYIXugTGLiwXU07ZHQ4UWbyYkOG2sXaXz8c+a523TpBQsugY7GdUowUbzxyXkYJ9XOUTIHPWBK9J39aFGatnLO18FsQMsaBxyqoRvMISmU1U3RwXk35BDy2zJCpyY3LW6odGTd5oDUpTgXjBaXOZ5nWOxSyv1uKEAJswSy9a4u/pkcxKmFOP0+of/pG0umt0Xq/e3pF+QnONbSrxNBmutjjdlk2mDcd2lT0f7vgdt99ZZ1iqonsnp2NF7P6
X-MS-Exchange-AntiSpam-MessageData: YKIDrEDlaom2VQX9GIBNEIG+Q7189Z28eeL0EJwMnIxCwH7LAAKe1PEEm9aaMcsLaBO3kj10uKy87bpsmsrWtbuhKdQuBFvl1VJStU3saC6IDlcNhys0e5zjNCQsuFHGMtOCPtPjFTVP2ygp4xBHDg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d03964a2-c6f1-4225-a61c-08d7b5bb057e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 04:11:55.4041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikemPgA5HIkAeoU7vEvxLgv6UQYZFbx5A4lZtjJkEfRdYLe8ZySqphnhz+MLQpu3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3807
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.117
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

The virtio-net fuzz target feeds inputs to all three virtio-net
virtqueues, and uses forking to avoid leaking state between fuzz runs.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qtest/fuzz/Makefile.include  |   1 +
 tests/qtest/fuzz/virtio_net_fuzz.c | 198 +++++++++++++++++++++++++++++
 2 files changed, 199 insertions(+)
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
index 0000000000..d08a47e278
--- /dev/null
+++ b/tests/qtest/fuzz/virtio_net_fuzz.c
@@ -0,0 +1,198 @@
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
+#include "standard-headers/linux/virtio_config.h"
+#include "tests/qtest/libqtest.h"
+#include "tests/qtest/libqos/virtio-net.h"
+#include "fuzz.h"
+#include "fork_fuzz.h"
+#include "qos_fuzz.h"
+
+
+#define QVIRTIO_NET_TIMEOUT_US (30 * 1000 * 1000)
+#define QVIRTIO_RX_VQ 0
+#define QVIRTIO_TX_VQ 1
+#define QVIRTIO_CTRL_VQ 2
+
+static int sockfds[2];
+static bool sockfds_initialized;
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
+
+        /*
+         * Only attempt to write incoming packets, when using the socket
+         * backend. Otherwise, always place the input on a virtqueue.
+         */
+        if (vqa.rx && sockfds_initialized) {
+            write(sockfds[0], Data, vqa.length);
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
+        /* Run the main loop */
+        qtest_clock_step(s, 100);
+        flush_events(s);
+
+        /* Wait on used descriptors */
+        if (check_used && !vqa.rx) {
+            gint64 start_time =3D g_get_monotonic_time();
+            /*
+             * normally, we could just use qvirtio_wait_used_elem, but sin=
ce we
+             * must manually run the main-loop for all the bhs to run, we =
use
+             * this hack with flush_events(), to run the main_loop
+             */
+            while (!vqa.rx && q !=3D net_if->queues[QVIRTIO_RX_VQ]) {
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
+                        <=3D QVIRTIO_NET_TIMEOUT_US);
+
+                /* Run the main loop */
+                qtest_clock_step(s, 100);
+                flush_events(s);
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
+    int ret =3D socketpair(PF_UNIX, SOCK_STREAM, 0, sockfds);
+    g_assert_cmpint(ret, !=3D, -1);
+    fcntl(sockfds[0], F_SETFL, O_NONBLOCK);
+    sockfds_initialized =3D true;
+    g_string_append_printf(cmd_line, " -netdev socket,fd=3D%d,id=3Dhs0 ",
+                           sockfds[1]);
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
2.25.0


