Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0714FC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B53C62073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="UIMu8aXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53C62073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itQEJ-0004Pr-OC
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 01:08:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1itQ1s-0007VY-CJ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:55:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1itQ1q-0006ZH-7Q
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:55:16 -0500
Received: from mail-bn7nam10on2102.outbound.protection.outlook.com
 ([40.107.92.102]:54912 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1itQ1o-0006Y0-MF
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:55:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6SJq79RC+HKomv3YkCLbpTdjqhcrhjMJaBxr/MaFmuJz9KNDVrDvYGu0QWNHYnDr0vswRUee8ehKp5uqqaL5vMg6VV1XL5dRumjZPErSA66qeuAiW5QCluq0xt+stdt2PxO3seTzKmwnxR7dspgGC2lXDPS+SacmLw+K1UmFQCG2Wt+SF81RxomwfV0ATDDCRdxd6uRlPhFNmu4VxEAqx9uzUAZtWoyO2GLieNMRVVuG3IVC/UgKYNkEpjoM71vUBsfv1EU/JWxvubnTdh+WQUnjNmMU5oClfxP9or9joTZIdeQWnqZgJJkCucQjBRoUkr8zDef40QIN7lTCPmS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1iW1YSnhR2Q4tcvdA9noTP2UB1kdSEfm0N7alL1p/I=;
 b=km7li5FuDyQSQel99cJx3vQ7c3tdsBJS82QMJHbouDptImuqTCTZAbtoWPWwqdiag6Bo6XUNgyvzH/O1lO6704nYB2cDa/DhczhzHk6r8Axy09aHQCBDKsjfEt6c/GXPUfovvrS+Te3rIBfX1mbedXoWeC8o2kUxUGdwFKNSIYCK4pM3gxolmpsKd1cUuXuO0D7mhxy8jjT9vsAlV/SaSxhrWWBl+P/NUHyjt8kW/nMV0CWDUpqVGbZ6ceBanZKkXsXI9V4wh4XtQEMCPbad84TSK33Y4p3Ip5vpWmOdX6cKdWCT7+e+45B0l2EU8hAIMmbeQQR2eF/BUV1hryJO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1iW1YSnhR2Q4tcvdA9noTP2UB1kdSEfm0N7alL1p/I=;
 b=UIMu8aXLblbvnEA7iHIW4nzk3pjSCA/5kh6yXQen/8z3WrlZjHDSgdxASOXqGgXGiKW3hHMWJYjgAeb28KbdePq3fJun5haRL+vgAeF08MlWPAObt0HszWNzmgeH9qLVFG3RbruzghrbdrwLAhrhZY2HI7HMIjt6UMg8FLpi3uo=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4399.namprd03.prod.outlook.com (20.178.6.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 05:55:11 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 05:55:10 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR20CA0032.namprd20.prod.outlook.com (2603:10b6:208:e8::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Mon, 20 Jan 2020 05:55:09 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v7 19/20] fuzz: add virtio-scsi fuzz target
Thread-Topic: [PATCH v7 19/20] fuzz: add virtio-scsi fuzz target
Thread-Index: AQHVz1YscpBbXOe9vEqX83WYFJAEcg==
Date: Mon, 20 Jan 2020 05:55:10 +0000
Message-ID: <20200120055410.22322-28-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 66307ed5-4fae-43c3-231d-08d79d6d4f3c
x-ms-traffictypediagnostic: SN6PR03MB4399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB439965237747138BAAF585DABA320@SN6PR03MB4399.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:317;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(5660300002)(956004)(2616005)(8936002)(86362001)(6916009)(6486002)(7696005)(1076003)(52116002)(316002)(71200400001)(16526019)(186003)(786003)(478600001)(2906002)(6666004)(26005)(81166006)(66946007)(66476007)(64756008)(36756003)(8676002)(75432002)(81156014)(66446008)(4326008)(66556008)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4399;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bFUFQnnSzkDO3FRLHlCH6386iuMRMUVILQKjkAKWwtKfwjmdYNg2pDuSsM2oroAOGGyezT1Z1NNRBn82BYcwyN46B+RSYd/Z7+B1qQmegX+FsFi9InJWRq2ZDb/ZGq2CuHKUICnm+kSBxE7Pgdf+E/KBEPbpaXm2OUdluqp6uTfKyEw6MH97iR5iOaCj8k1ERxNGgqD15+jb2+1rRSHXh2M7lCXBVB4BCxXjV2aJcrecanVG3hzpJKEDyADJqzDHx/sAJUjDMuxTR8hCJg4uE0gRr6m2SXlU3zvaKG6ZD9fiip7o3h0iQg4Ggn8M5HY2AqBtmpzF9GmtOpGCVy8hjRFqcyZy2d8acjomEx1Zc+o6WQJUSF3K8NF/mMWBDFJO/+ON8MZYNGe7cLwVbFrGIYohnEpt4ZpQqfikct5telFJwbrGqZ4pbZat1swso0S4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 66307ed5-4fae-43c3-231d-08d79d6d4f3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 05:55:10.5700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5MBI8/E5BIsv/fklkQRlHsE6xLk62HdQU64/HIPTvzHKMLtHrGbkDnZkIPUQiN7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4399
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.102
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

The virtio-scsi fuzz target sets up and fuzzes the available virtio-scsi
queues. After an element is placed on a queue, the fuzzer can select
whether to perform a kick, or continue adding elements.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qtest/fuzz/Makefile.include   |   1 +
 tests/qtest/fuzz/virtio_scsi_fuzz.c | 200 ++++++++++++++++++++++++++++
 2 files changed, 201 insertions(+)
 create mode 100644 tests/qtest/fuzz/virtio_scsi_fuzz.c

diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.=
include
index 77385777ef..cde3e9636c 100644
--- a/tests/qtest/fuzz/Makefile.include
+++ b/tests/qtest/fuzz/Makefile.include
@@ -9,6 +9,7 @@ fuzz-obj-y +=3D tests/qtest/fuzz/qos_fuzz.o
 # Targets
 fuzz-obj-y +=3D tests/qtest/fuzz/i440fx_fuzz.o
 fuzz-obj-y +=3D tests/qtest/fuzz/virtio_net_fuzz.o
+fuzz-obj-y +=3D tests/qtest/fuzz/virtio_scsi_fuzz.o
=20
 FUZZ_CFLAGS +=3D -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
=20
diff --git a/tests/qtest/fuzz/virtio_scsi_fuzz.c b/tests/qtest/fuzz/virtio_=
scsi_fuzz.c
new file mode 100644
index 0000000000..ee7ca5448c
--- /dev/null
+++ b/tests/qtest/fuzz/virtio_scsi_fuzz.c
@@ -0,0 +1,200 @@
+/*
+ * virtio-serial Fuzzing Target
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
+#include "libqos/virtio-scsi.h"
+#include "libqos/virtio.h"
+#include "libqos/virtio-pci.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_pci.h"
+#include "standard-headers/linux/virtio_scsi.h"
+#include "fuzz.h"
+#include "fork_fuzz.h"
+#include "qos_fuzz.h"
+
+#define PCI_SLOT                0x02
+#define PCI_FN                  0x00
+#define QVIRTIO_SCSI_TIMEOUT_US (1 * 1000 * 1000)
+
+#define MAX_NUM_QUEUES 64
+
+/* Based on tests/virtio-scsi-test.c */
+typedef struct {
+    int num_queues;
+    QVirtQueue *vq[MAX_NUM_QUEUES + 2];
+} QVirtioSCSIQueues;
+
+static QVirtioSCSIQueues *qvirtio_scsi_init(QVirtioDevice *dev, uint64_t m=
ask)
+{
+    QVirtioSCSIQueues *vs;
+    uint64_t feat;
+    int i;
+
+    vs =3D g_new0(QVirtioSCSIQueues, 1);
+
+    feat =3D qvirtio_get_features(dev);
+    if (mask) {
+        feat &=3D ~QVIRTIO_F_BAD_FEATURE | mask;
+    } else {
+        feat &=3D ~(QVIRTIO_F_BAD_FEATURE | (1ull << VIRTIO_RING_F_EVENT_I=
DX));
+    }
+    qvirtio_set_features(dev, feat);
+
+    vs->num_queues =3D qvirtio_config_readl(dev, 0);
+
+    for (i =3D 0; i < vs->num_queues + 2; i++) {
+        vs->vq[i] =3D qvirtqueue_setup(dev, fuzz_qos_alloc, i);
+    }
+
+    qvirtio_set_driver_ok(dev);
+
+    return vs;
+}
+
+static void virtio_scsi_fuzz(QTestState *s, QVirtioSCSIQueues* queues,
+        const unsigned char *Data, size_t Size)
+{
+    typedef struct vq_action {
+        uint8_t queue;
+        uint8_t length;
+        uint8_t write;
+        uint8_t next;
+        uint8_t kick;
+    } vq_action;
+
+    uint32_t free_head[MAX_NUM_QUEUES + 2] =3D {0};
+    QGuestAllocator *t_alloc =3D fuzz_qos_alloc;
+
+    QVirtioSCSI *scsi =3D fuzz_qos_obj;
+    QVirtioDevice *dev =3D scsi->vdev;
+    QVirtQueue *q;
+    vq_action vqa;
+    while (Size >=3D sizeof(vqa)) {
+        memcpy(&vqa, Data, sizeof(vqa));
+
+        Data +=3D sizeof(vqa);
+        Size -=3D sizeof(vqa);
+
+        vqa.queue =3D vqa.queue % queues->num_queues;
+        vqa.length =3D vqa.length >=3D Size ? Size : vqa.length;
+        vqa.write =3D vqa.write & 1;
+        vqa.next =3D vqa.next & 1;
+        vqa.kick =3D vqa.kick & 1;
+
+
+        q =3D queues->vq[vqa.queue];
+
+        uint64_t req_addr =3D guest_alloc(t_alloc, vqa.length);
+        qtest_memwrite(s, req_addr, Data, vqa.length);
+        if (free_head[vqa.queue] =3D=3D 0) {
+            free_head[vqa.queue] =3D qvirtqueue_add(s, q, req_addr, vqa.le=
ngth,
+                    vqa.write, vqa.next);
+        } else {
+            qvirtqueue_add(s, q, req_addr, vqa.length, vqa.write , vqa.nex=
t);
+        }
+
+        if (vqa.kick) {
+            qvirtqueue_kick(s, dev, q, free_head[vqa.queue]);
+            free_head[vqa.queue] =3D 0;
+        }
+        Data +=3D vqa.length;
+        Size -=3D vqa.length;
+    }
+    for (int i =3D 0; i < MAX_NUM_QUEUES + 2; i++) {
+        if (free_head[i]) {
+            qvirtqueue_kick(s, dev, queues->vq[i], free_head[i]);
+        }
+    }
+}
+
+static void virtio_scsi_fork_fuzz(QTestState *s,
+        const unsigned char *Data, size_t Size)
+{
+    QVirtioSCSI *scsi =3D fuzz_qos_obj;
+    static QVirtioSCSIQueues *queues;
+    if (!queues) {
+        queues =3D qvirtio_scsi_init(scsi->vdev, 0);
+    }
+    if (fork() =3D=3D 0) {
+        virtio_scsi_fuzz(s, queues, Data, Size);
+        flush_events(s);
+        _Exit(0);
+    } else {
+        wait(NULL);
+    }
+}
+
+static void virtio_scsi_with_flag_fuzz(QTestState *s,
+        const unsigned char *Data, size_t Size)
+{
+    QVirtioSCSI *scsi =3D fuzz_qos_obj;
+    static QVirtioSCSIQueues *queues;
+
+    if (fork() =3D=3D 0) {
+        if (Size >=3D sizeof(uint64_t)) {
+            queues =3D qvirtio_scsi_init(scsi->vdev, *(uint64_t *)Data);
+            virtio_scsi_fuzz(s, queues,
+                             Data + sizeof(uint64_t), Size - sizeof(uint64=
_t));
+            flush_events(s);
+        }
+        _Exit(0);
+    } else {
+        wait(NULL);
+    }
+}
+
+static void virtio_scsi_pre_fuzz(QTestState *s)
+{
+    qos_init_path(s);
+    counter_shm_init();
+}
+
+static void *virtio_scsi_test_setup(GString *cmd_line, void *arg)
+{
+    g_string_append(cmd_line,
+                    " -drive file=3Dblkdebug::null-co://,"
+                    "file.image.read-zeroes=3Don,"
+                    "if=3Dnone,id=3Ddr1,format=3Draw,file.align=3D4k "
+                    "-device scsi-hd,drive=3Ddr1,lun=3D0,scsi-id=3D1");
+    return arg;
+}
+
+
+static void register_virtio_scsi_fuzz_targets(void)
+{
+    fuzz_add_qos_target(&(FuzzTarget){
+                .name =3D "virtio-scsi-fuzz",
+                .description =3D "Fuzz the virtio-net virtual queues, fork=
ing"
+                                "for each fuzz run",
+                .pre_vm_init =3D &counter_shm_init,
+                .pre_fuzz =3D &virtio_scsi_pre_fuzz,
+                .fuzz =3D virtio_scsi_fork_fuzz,},
+                "virtio-scsi",
+                &(QOSGraphTestOptions){.before =3D virtio_scsi_test_setup}
+                );
+
+    fuzz_add_qos_target(&(FuzzTarget){
+                .name =3D "virtio-scsi-flags-fuzz",
+                .description =3D "Fuzz the virtio-net virtual queues, fork=
ing"
+                "for each fuzz run (also fuzzes the virtio flags)",
+                .pre_vm_init =3D &counter_shm_init,
+                .pre_fuzz =3D &virtio_scsi_pre_fuzz,
+                .fuzz =3D virtio_scsi_with_flag_fuzz,},
+                "virtio-scsi",
+                &(QOSGraphTestOptions){.before =3D virtio_scsi_test_setup}
+                );
+}
+
+fuzz_target_init(register_virtio_scsi_fuzz_targets);
--=20
2.23.0


