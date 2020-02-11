Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9AEC35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C825F20659
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="PcnCR4EC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C825F20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1cRg-0007Th-1y
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j1cG6-0006jA-8E
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j1cG2-0000Au-EW
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:50 -0500
Received: from mail-eopbgr690106.outbound.protection.outlook.com
 ([40.107.69.106]:43233 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j1cG1-0008My-Tq
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DH38XZbjf6YGriv7myUGBVoeh0gVYMaxzz/SkQLhJpsZEK2xdyal3tcm1RYowecsN5aeQYCYH3rdQYC1gr3jOuyOjgpny+YtPxm2N4r976pzlluXqUCTyd/eJBmhINCsfllDx5EiwNo1upjNwLB5BkkT6lcjDplSrDksPury7M7gthAykgtUhnrwpdn74klZ0BrSUFDwd+KkEgdoYwnF5LMeDCoMl2NiMWqQ9Y+i/NqJ88mv/pfjgzAl5iwTxTYA2Yhfy474KcHSu1ffMvIIt/QX9DHz4o8d4LPj+fDMvkab/iz2ZW4d9QzREttcKpW/6Ggux0O+3LENOJS9GntaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QA+Rp2UQv3xglCx/1+vSBwPoNDPmahVOdn5xQ1oaSgA=;
 b=KxyqLnl2bvQfcavZItzcYgwJl1mtTQDIf4Nr/bmP6Ka8fvU7Nd10TQQ7OT3/IorabXu0b9sHIWXqJFDhWuZN6tZI0dyog69KbhqRJZgfZtlaGffWPARpjaaan/etsAXR6nhSpBG576ueD5OiYTG1A7ufd+iYupepK7k/UA1OmgqEJOw67DQO6nWSUxMl+Y7eBS1MtBeynYq1ZNMAJZahkTAzzMwZCLNz0l5wZ+GWwt6cvxXHIkf16tCOh6XsT76ZxXR/9yGVuLTOo6BnPvVfvthW23l8RhFWQuV/IrOdt3REJwcUGZanadDwIxa8VHZ1k/ykTXEKnUQ29RxmvC/9ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QA+Rp2UQv3xglCx/1+vSBwPoNDPmahVOdn5xQ1oaSgA=;
 b=PcnCR4ECH76oF2mtmcshCvwcyXA6mzdqHuobG3yd/1HD8ia3LzQVMeYHHAL3PnO79DWyjpF4L29WZ+Y+R/7qAjgTpJUBe5OUvB25iKmDOGpP9+FJ6geOghzDlhpJMb2brFAPPMg7W4PZ1LtgXBm8HTWOA0sXSbntInPGaXFEdaY=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4336.namprd03.prod.outlook.com (20.177.254.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Tue, 11 Feb 2020 20:35:41 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 20:35:41 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 21/23] fuzz: add virtio-net fuzz target
Date: Tue, 11 Feb 2020 15:35:08 -0500
Message-ID: <20200211203510.3534-22-alxndr@bu.edu>
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
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 20:35:40 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8b03f20-4f36-4859-1a39-08d7af31f5c9
X-MS-TrafficTypeDiagnostic: SN6PR03MB4336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB43360AADB688DDDD10F51B3BBA180@SN6PR03MB4336.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
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
X-Microsoft-Antispam-Message-Info: q2yo17DujDAZfeGMeBX8SralsVYhzk/IGR2dotmtkGTimMOmTWYoA5GEn7vtbKTraDIW9yRJuqlzInlfBA3dTOE8USB0qOfe9lrTlwwFcDlg/HellRync9UnnSefcpdfi0ti7RP40/6aKR09XS/qYkq3StPw1OGJelqjmFOcexwYUedm99wF6JU2px29p9S2WFvSmcK9+HSkCLvQCRjW8W9YdTDYjMm5xXYs91O6ao29KKLql8/nVFWQvY+Hiu+3AomWKVJN4fhlr+vhNSTJieol6InxL/Le+MaOwlWLimn6B20t0ONmJjv24VphawSYimEVWwFqpL/FZTRTDVPgA5gi0s8cCMrb7hmmiWuaWiVgsrfjqsgaTuCVGHcbB1CxC6q21dqFgkg15g/YqF6TJHyZAdMtb4lYM4CVwQolAJFRVifbz6z6yecZeCn6TwuD
X-MS-Exchange-AntiSpam-MessageData: Mv9DDSpIX3HLOm+IPVfBhAK1ywgPcrmzDvTi6KwYDy3nhn9UWecuj1wtRJifr5PjNfZbUT1kvY8wD8K1JbGNA49pMQevw1FvLQr+iDMpaz+Vc8LLCoGrkC4XXUOgqYsQe7JlSyJGsNKk6lJE0iaDBA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b03f20-4f36-4859-1a39-08d7af31f5c9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 20:35:40.9639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCwmGSXRVQMEBDtkAwNlOKbRS2CZkcc8HePpQJ+2fFuTMTuU+hltgKnbHuINoD3R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4336
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Received-From: 40.107.69.106
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


