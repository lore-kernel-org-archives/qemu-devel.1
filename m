Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5EAC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41A02071E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="4CpzbM/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41A02071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwgAW-0001v8-RV
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 00:45:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iwfzk-0008Fr-3S
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iwfzi-0002AD-Hi
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:32 -0500
Received: from mail-mw2nam10on2107.outbound.protection.outlook.com
 ([40.107.94.107]:63936 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iwfzi-00029U-7b
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQHiX9TqBnduZ5te/BzCs+M8YG+wckgxQGOqghqJs5b0pcnxuiXPECguByqb0q1d1qrynR61gQGvbFY3e5dYImAC+XWSwVwoK4NRYjikWtqqgju1xhfGRQnb9TtUZlL9OLqgttH1wuIR5Wy+vD6SZ0FDyiR3Js9vl03/5BldYXOmT1gbnR3wSO7SGqgrhxmqPPVS/2Ryd4ElmvJnv4tzvEdujBDauwobLYOtANtOkT/2x9bD+K8JOIVK6Jy/e5Nk9imE6P0FhurBLd6jGcSduGDMDZmTWbk23reXvvJOg/On6RrUn+uJYxxX8zVLYvjvJnQ1IuUtqlYDesaJQMrZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1iW1YSnhR2Q4tcvdA9noTP2UB1kdSEfm0N7alL1p/I=;
 b=UOzYhb0U8r+AebbU/Mk97pCELwkgBk/BGk7lnjvN58+nyLpW8RZucGqVcKNTTxsriTzjKpK/OqtARdQ1qVDMeGZFY7yqdEl3vTR3Y+kL0ncBteoIuYcbFhqDqtiivANTF/tD3RCvKhK0zAd/VKztJrCAW2T/lFX325HtWxQK64SlW7u6P3UvugW0w5svDsKFdzCxUuOrFJBAv3bB+yY89kEnU7C/59ha2GFNl4xeJ74TN8CAxcvg7yYejjPztESATy6Mxchs2oFuU25sADu1eXUAjfg2mBCNzgiY8QyTFH5hBc6GD19FzNLjTd4X//77dT4TNU9uxCKGoq88GWP1Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1iW1YSnhR2Q4tcvdA9noTP2UB1kdSEfm0N7alL1p/I=;
 b=4CpzbM/Hk5s8RvirGJbPNV7gOlUUPC9MgEmvomVxr+t7lzOXn5/aStZioEENsukuQEKJbdVM8pvJ8yo3HeplTwtpQJGWUytkqf9ZrRB9Byd9nwFtMd83I4WcXkX7f8d/Scb/Y4d2TLHWLmuOjmQtQVZaMCmXj9mqFosARfQfAdw=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4206.namprd03.prod.outlook.com (52.135.110.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Wed, 29 Jan 2020 05:34:28 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 05:34:28 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:c0::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.19 via Frontend Transport; Wed, 29 Jan 2020 05:34:27 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v8 20/21] fuzz: add virtio-scsi fuzz target
Thread-Topic: [PATCH v8 20/21] fuzz: add virtio-scsi fuzz target
Thread-Index: AQHV1mXGb2aeHS7iCkaEe9UXqqpLRA==
Date: Wed, 29 Jan 2020 05:34:28 +0000
Message-ID: <20200129053357.27454-21-alxndr@bu.edu>
References: <20200129053357.27454-1-alxndr@bu.edu>
In-Reply-To: <20200129053357.27454-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:c0::42) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a250c5d-3934-45ed-dd37-08d7a47ce8a1
x-ms-traffictypediagnostic: SN6PR03MB4206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB42067A4B57EB60D4169F6F80BA050@SN6PR03MB4206.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:317;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(189003)(199004)(478600001)(75432002)(36756003)(316002)(6916009)(2906002)(786003)(4326008)(54906003)(26005)(186003)(956004)(2616005)(6486002)(7696005)(52116002)(16526019)(1076003)(5660300002)(71200400001)(86362001)(66446008)(66556008)(66946007)(66476007)(8936002)(81156014)(81166006)(64756008)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4206;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mSQfpgVSj93crOAmse1Q2RLpBniV2NJOzSWo98I7OuX/fI35r4GjTP9hzsc10X2/1lwIiFGs3Vj7CqrdPuA1q7pMB5wz8cSwdbuTS4gInluPOpH3zqJzQzyZVE+Ct+xKBSGz2/OHu56Uc9+I6THpixdM7IfWbZs2KY8NiDkVzzU5aGftjXcumt9kJS2/dsdIvjSQkCGtcm6b+1druXEcsRHAiFe7FTZUbEosFy4in5/q9uYbNrl/PouAc4QlGJWta7PUT+N6Pav1RA8BkXM0DS1SW9eGO2Z39YNJQ/Sdx5wuv0mGPQoZuLvfYlx168y1l07gy9S+P1iIIizJEgGQX7QenaG3Jn9JiwcsVbCgQnvuH9W3l03DHke46dzFKo+WqyO2em0NKyd7n8WuF6oJzkzUtYwNlkxzGUbgpbVyLAwPrrQSqal+zMQ2lXylmJ22
x-ms-exchange-antispam-messagedata: foigrq4bzwxJieuuQ0GpNv7z+cPh5DJ+RQ01F/8Wx5jxJUL93YgittdvaWlMwf4/FNul2yZsZfpwJ0CWR2eKA7G906DlqHbjkQ4VZlyx3NvguuAYqy9zEUmlumufm9rJ5BCjQ37Bw0FcvjbNsEbSPw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a250c5d-3934-45ed-dd37-08d7a47ce8a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 05:34:28.4435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GTWIzTm5e9ovL6zHloFkX2/+Zc4c8F2pRJl8T9HpV0CLdUNDPnL54J4437gTSncN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4206
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.107
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


