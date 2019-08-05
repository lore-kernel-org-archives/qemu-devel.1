Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C072DC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D194205F4
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="rDGwwnL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D194205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huXHW-00035L-Rb
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37404)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1huX9L-0003j3-Ld
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1huX9K-00024i-4k
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:19 -0400
Received: from mail-eopbgr680126.outbound.protection.outlook.com
 ([40.107.68.126]:42366 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1huX9J-00023d-VV
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6OHDdtQi1XcyPSnmSrKX91MUqM+Lek66uHKT5Yn00HBkIdVzuJv8DhkX9PkW8e8XbEtyHyejydcEh2NEwrAb0clqh69sKftKPfKnim9ofdNwUwdfqEF1X4Iv1aDkElsSnrHYtPzf+hAVA9vGIjQvjo0dXulqucyZVDB5JXoimDnqfmgyne5k37e+AA/gviKGG28Y+uCGMDvalBOyblhHuXqzZ8LaFxp3R1o3I9leH5jbbcbovRfxwZSSptnCKYwgTNlbrK9rlJEixIHazs1ZIjgjwBAJsM5jCZ36lKGiEdEyNWKF6SsO4a9Rs3nazG/jDDYD9pV/BwQWQHuAYfLiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttLRTIgv/euOvBPkVNMmoEqfHY4YVUZuGHpW4s0f4Os=;
 b=Vu1gsM/ff9R35xC2YQf2lOD1xDo45AVBDxpIV3ZWayCZDt/froMGWWM6fYywIZCnSKRgWCUcUSlSDmtM4Zo0f22GJnECp0jJbpt+A0q+GG6vFVBc9TLAQA370OXMdW6jCYV19FiuBzsRqntaVl4kRB1IX+yXas8fIuj4DbPGS/VzUGk/VFzOS/H6JdQAyB8Vkgy1ud5OViVfi8HCw04AwDc7VU8JGuiHGmnL7gfGa5D1hwYnRHSBP/n0Loxiffvky3/s0Ddw4sBq6aW48Qhvi5ZH32nebINWhbqA9Q0QELuqXU8X2xxRu8xsDOgI4JVGvh8FrK1Wvk92Y7KBNM0O6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttLRTIgv/euOvBPkVNMmoEqfHY4YVUZuGHpW4s0f4Os=;
 b=rDGwwnL5Kqbz+QMttSM9+kGhg+CgzQIIdHk1qtbER38oL7vGAZv3OIiRZ8spuDVQQo5l/4CMrRefRPIwsX5JTQuUI78GseKLMrbt/U3l8M8NEmMo9N2sDq/dDuLmT4ikAxq49KvHhfdcMUYans1INElWtwqJBbJqN6jWXUy/4Os=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2646.namprd03.prod.outlook.com (10.173.43.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 07:11:16 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:11:16 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH v2 16/17] fuzz: Add virtio-net fuzz targets
Thread-Index: AQHVS1z5z57WA2eYQ0W72mbgaHRTUg==
Date: Mon, 5 Aug 2019 07:11:16 +0000
Message-ID: <20190805071038.32146-17-alxndr@bu.edu>
References: <20190805071038.32146-1-alxndr@bu.edu>
In-Reply-To: <20190805071038.32146-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:207:3d::45) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0236dfc3-51f7-4d70-e2bc-08d719741b8d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2646; 
x-ms-traffictypediagnostic: CY4PR03MB2646:
x-microsoft-antispam-prvs: <CY4PR03MB26465BC233A8A57B49BF43F4BADA0@CY4PR03MB2646.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(71200400001)(71190400001)(6916009)(186003)(2351001)(1076003)(76176011)(6436002)(53936002)(86362001)(5640700003)(52116002)(6512007)(26005)(5660300002)(102836004)(386003)(6506007)(2501003)(66066001)(75432002)(6486002)(66476007)(2906002)(88552002)(4326008)(8676002)(316002)(786003)(50226002)(54906003)(81166006)(14454004)(81156014)(68736007)(476003)(2616005)(11346002)(446003)(486006)(36756003)(66446008)(66946007)(256004)(64756008)(25786009)(99286004)(478600001)(6116002)(3846002)(7736002)(305945005)(66556008)(8936002)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2646;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IaAnmcMIn9cnmmnr6X0GLdnRm1aD2uRSef09nt+eK+dscoDMQieunIxGnWJ2KpnOwHYzdBC/ZxvJu/zqN6Aw8Xu7XqDMQ/niG+OP96y1EzRmmzqIEGu1eDE4TMzQphQTY20RWZij8nxqD7kdAIrFpvDdvsfhYQNAz/0sE1zDIIw4wICGXmCset5j+pCIWDFbmVNfaiXu2ba3yDVhd7LQzz0BQnAvIpbKJteUBu8ucqkljdZ2niYQLnXSy8L6S2FIBTB0PWeG6BQV/IiKEyqJV0H4AUcScYMrfecMvthg8+iNHSITxjRH2/4C193vPuLOrZc1plspkPoFebWJDPZQj/KBaypb5yTwkyKP47liPUKMNzGyvgpSLp6HEtA7U9C5JOdktxNcBAxOOgJwfsZvW/wrznBzTENXPDoyG9r0l58=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0236dfc3-51f7-4d70-e2bc-08d719741b8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:11:16.7537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2646
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.126
Subject: [Qemu-devel] [RFC PATCH v2 16/17] fuzz: Add virtio-net fuzz targets
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

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/fuzz/virtio-net-fuzz.c | 254 +++++++++++++++++++++++++++++++++++
 1 file changed, 254 insertions(+)
 create mode 100644 tests/fuzz/virtio-net-fuzz.c

diff --git a/tests/fuzz/virtio-net-fuzz.c b/tests/fuzz/virtio-net-fuzz.c
new file mode 100644
index 0000000000..dfba2e3ca7
--- /dev/null
+++ b/tests/fuzz/virtio-net-fuzz.c
@@ -0,0 +1,254 @@
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "exec/memory.h"
+#include "sysemu/sysemu.h"
+#include "qemu/main-loop.h"
+
+#include "hw/virtio/virtio-net.h"
+#include "hw/virtio/virtio.h"
+#include "tests/libqos/virtio-net.h"
+#include "fuzzer_hooks.h"
+#include "snapshotting.h"
+
+#include "fuzz.h"
+#include "qos_fuzz.h"
+
+#define MAX_INPUT_BUFFERS 10
+
+typedef struct vq_action {
+    uint8_t queue;
+    uint8_t length;
+    uint8_t write;
+    uint8_t next;
+    bool kick;
+} vq_action;
+
+static void virtio_net_ctrl_fuzz(const unsigned char *Data, size_t Size)
+{
+    uint64_t req_addr[10];
+    int reqi =3D 0;
+    uint32_t free_head;
+
+    QGuestAllocator *t_alloc =3D qos_alloc;
+
+    QVirtioNet *net_if =3D qos_obj;
+    QVirtioDevice *dev =3D net_if->vdev;
+    QVirtQueue *q;
+    vq_action vqa;
+    int iters =3D 0;
+    while (true) {
+        if (Size < sizeof(vqa)) {
+            break;
+        }
+        vqa =3D *((vq_action *)Data);
+        Data +=3D sizeof(vqa);
+        Size -=3D sizeof(vqa);
+
+        q =3D net_if->queues[2];
+
+        vqa.length =3D vqa.length >=3D Size ? Size :  vqa.length;
+
+        req_addr[reqi] =3D guest_alloc(t_alloc, vqa.length);
+        memwrite(req_addr[reqi], Data, vqa.length);
+        if (iters =3D=3D 0) {
+            free_head =3D qvirtqueue_add(q, req_addr[reqi], vqa.length,
+                    vqa.write, vqa.next);
+        } else {
+            qvirtqueue_add(q, req_addr[reqi], vqa.length, vqa.write , vqa.=
next);
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
+        qvirtqueue_kick(dev, q, free_head);
+        /* qtest_clock_step_next(s); */
+        main_loop_wait(false);
+        for (int i =3D 0; i < reqi; i++) {
+            guest_free(t_alloc, req_addr[i]);
+        }
+    }
+    qtest_clear_rxbuf(s);
+    qos_object_queue_destroy(qos_obj);
+}
+
+static void virtio_net_ctrl_fuzz_multi(const unsigned char *Data, size_t S=
ize)
+{
+    uint64_t req_addr[10];
+    int reqi =3D 0;
+    uint32_t free_head;
+
+    QGuestAllocator *t_alloc =3D qos_alloc;
+
+    QVirtioNet *net_if =3D qos_obj;
+    QVirtioDevice *dev =3D net_if->vdev;
+    QVirtQueue *q;
+    vq_action vqa;
+    int iters =3D 0;
+    while (Size >=3D sizeof(vqa)) {
+        vqa =3D *((vq_action *)Data);
+        Data +=3D sizeof(vqa);
+        Size -=3D sizeof(vqa);
+        if (vqa.kick && free_head) {
+            qvirtqueue_kick(dev, q, free_head);
+            qtest_clock_step_next(s);
+            main_loop_wait(false);
+            for (int i =3D 0; i < reqi; i++) {
+                guest_free(t_alloc, req_addr[i]);
+            }
+            reqi =3D 0;
+        } else {
+            q =3D net_if->queues[2];
+
+            vqa.length =3D vqa.length >=3D Size ? Size :  vqa.length;
+
+            req_addr[reqi] =3D guest_alloc(t_alloc, vqa.length);
+            memwrite(req_addr[reqi], Data, vqa.length);
+            if (iters =3D=3D 0) {
+                free_head =3D qvirtqueue_add(q, req_addr[reqi], vqa.length=
,
+                        vqa.write, vqa.next);
+            } else {
+                qvirtqueue_add(q, req_addr[reqi], vqa.length, vqa.write,
+                        vqa.next) ;
+            }
+            iters++;
+            reqi++;
+            if (iters =3D=3D 10) {
+                break;
+            }
+            Data +=3D vqa.length;
+            Size -=3D vqa.length;
+        }
+    }
+    qtest_clear_rxbuf(s);
+    qos_object_queue_destroy(qos_obj);
+}
+
+int *sv;
+static void virtio_net_tx_fuzz(const unsigned char *Data, size_t Size)
+{
+    uint64_t req_addr[10];
+    int reqi =3D 0;
+    uint32_t free_head;
+
+    QGuestAllocator *t_alloc =3D qos_alloc;
+
+    QVirtioNet *net_if =3D qos_obj;
+    QVirtioDevice *dev =3D net_if->vdev;
+    QVirtQueue *q;
+    vq_action vqa;
+    int iters =3D 0;
+    while (true) {
+        if (Size < sizeof(vqa)) {
+            break;
+        }
+        vqa =3D *((vq_action *)Data);
+        Data +=3D sizeof(vqa);
+        Size -=3D sizeof(vqa);
+
+        q =3D net_if->queues[1];
+
+        vqa.length =3D vqa.length >=3D Size ? Size :  vqa.length;
+
+        req_addr[reqi] =3D guest_alloc(t_alloc, vqa.length);
+        memwrite(req_addr[reqi], Data, vqa.length);
+        if (iters =3D=3D 0) {
+            free_head =3D qvirtqueue_add(q, req_addr[reqi], vqa.length,
+                    vqa.write, vqa.next);
+        } else {
+            qvirtqueue_add(q, req_addr[reqi], vqa.length, vqa.write, vqa.n=
ext);
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
+        qvirtqueue_kick(dev, q, free_head);
+        qtest_clock_step_next(s);
+        main_loop_wait(false);
+        for (int i =3D 0; i < reqi; i++) {
+            guest_free(t_alloc, req_addr[i]);
+        }
+    }
+    qtest_clear_rxbuf(s);
+    qos_object_queue_destroy(qos_obj);
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
+static void fuzz_fork(const unsigned char *Data, size_t Size)
+{
+    if (fork() =3D=3D 0) {
+        main_loop_wait(false);
+        virtio_net_ctrl_fuzz(Data, Size);
+        counter_shm_store();
+        _Exit(0);
+    } else {
+        wait(NULL);
+        counter_shm_load();
+    }
+}
+
+static void fork_pre_main(void)
+{
+    qos_setup();
+    counter_shm_init();
+}
+
+static void register_virtio_net_fuzz_targets(void)
+{
+    QOSGraphTestOptions opts =3D {
+        .before =3D virtio_net_test_setup_socket,
+    };
+    FuzzTarget fuzz_opts =3D {
+        .pre_main =3D qos_setup,
+        .pre_save_state =3D NULL,
+        .save_state =3D NULL,
+        .reset =3D &reboot,
+        .pre_fuzz =3D &qos_init_path,
+        .fuzz =3D &virtio_net_ctrl_fuzz,
+        .post_fuzz =3D NULL,
+    };
+    fuzz_add_qos_target("virtio-net-ctrl-fuzz", "virtio-net ctrl virtqueue=
 \
+            fuzzer", "virtio-net", &opts, &fuzz_opts);
+
+    fuzz_opts.fuzz =3D &virtio_net_ctrl_fuzz_multi;
+    fuzz_add_qos_target("virtio-net-ctrl-multi-fuzz", "virtio-net ctrl\
+             virtqueue  fuzzer with multiple kicks", "virtio-net", &opts,
+            &fuzz_opts);
+
+    fuzz_opts.fuzz =3D &virtio_net_tx_fuzz;
+    fuzz_add_qos_target("virtio-net-tx-fuzz", "virtio-net tx virtqueue fuz=
zer",
+            "virtio-net", &opts, &fuzz_opts);
+
+    fuzz_opts.pre_main =3D &fork_pre_main;
+    fuzz_opts.pre_save_state =3D &qos_init_path;
+    fuzz_opts.reset =3D NULL;
+    fuzz_opts.pre_fuzz =3D NULL;
+    fuzz_opts.fuzz =3D &fuzz_fork;
+    fuzz_add_qos_target("virtio-net-fork", "virtio-net tx virtqueue",
+            "virtio-net", &opts, &fuzz_opts);
+
+}
+
+fuzz_target_init(register_virtio_net_fuzz_targets);
--=20
2.20.1


