Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B437C34031
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:18:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED1522465D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="ItYY5OPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1522465D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4dID-0000c6-70
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 23:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j4dBv-000506-Kj
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:12:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j4dBu-00060s-5S
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:59 -0500
Received: from mail-co1nam11on2117.outbound.protection.outlook.com
 ([40.107.220.117]:50663 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j4dBt-00060B-Tw
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmge7yjGQJmpD3iaayGGvANnvl/IoI6Tbi0CEvOk+RY3RQLlP1s9RDb34goV9y//pa4HLzvv3iQ3fdszobj9YYKIcpfsdlrS9a2F3IMV0OQ0umAsBROIM/qrSXXiD5cv972E+W5fBhzE3UzXJFVUmqvVwPHaPEUGdl44Ft2OFpYLGFKqsUwegM/q0T5SfDz5ai6iWTv8NJDYG0Dga9J8iDU2gog9nBJprp2WbwA31XZ0CKYshqKTdvGPtJuubmtKkZA4DpvXvpNORGKlHNuecLZH4OFc9kM+VIxI/t4KDF2ZuIN98vn/zBzv606/LYTkMBVNXuvb5/LNWqh51SkKcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBVzK0+86L0/L93Li5Pc3JmRp/cneMW+ZlpXHXqefcQ=;
 b=W3s0SwzUeBGaLA5yYRrGQeZinCq18M11P1u4ZICxBnQl/hNF7jGa+irxQuUWrXofgN0Q9OylFg7LCggnaj2H3/FnsfbkASK6pD0pgyyUp//8FKFG2brjzUGsgftS3TE/GrUOWqkdCosxiENYSl4LQf2P1N4Ne6RzsxXi8vDnbQ/3aqLyGK4LQ16kCnXOwRWaLRIj6hNSZeZi88hKm7J9SQeH27oCbvDaNO/6AyDIMtj1G1Ndsh0W7cx53XqbfxOzOSy8Fg8mU3/twYgbeaH3yeaAr0e79S69y6g5ZJqg+/QvAoRGaTlb+nJo03DRdv91guzJAQf+NWeEzZX7qjD9Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBVzK0+86L0/L93Li5Pc3JmRp/cneMW+ZlpXHXqefcQ=;
 b=ItYY5OPXE+UveNeR7yBDKvv2kYjJgDa0Y9M+Lo9gJauRARtd97HDXstNOrOVPo0kGnAvb9tEf+9lIdgCnbnTlRghifxc6yYnx9U464PjKmRxv5ZHRAGgGsI404ESLV+fXYEU692bLCRvQVLioXT8/q5DnULuw3teDd4kyXOklTQ=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3807.namprd03.prod.outlook.com (2603:10b6:805:6a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Thu, 20 Feb
 2020 04:11:56 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 04:11:56 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 21/22] fuzz: add virtio-scsi fuzz target
Date: Wed, 19 Feb 2020 23:11:17 -0500
Message-ID: <20200220041118.23264-22-alxndr@bu.edu>
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
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 04:11:55 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fd2af6e-cbe2-4425-8302-08d7b5bb0608
X-MS-TrafficTypeDiagnostic: SN6PR03MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB38078E76749AE4FB0657486DBA130@SN6PR03MB3807.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
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
X-Microsoft-Antispam-Message-Info: 1gDW/jwPcCbvTlIPMWTBwIDtXUapLflqO0NHo+S/7gKqjgKHBhMP5Ffb7fVBA23H+gmAS8sTKFtL8nzKknZdI5QW/iDZk+vC2M2exje+EvxKhLjmGNqm4YYCcxjfFJkBwd91SIHYv49WbIcjGa5Sc7d1L3iZSAqbbI5Vz0gcDMF6UbFYvMmqSoVxF3DfgLOp6m1hbqs3pHvaWGIOV6yj3Pv64jkRFQ8k8X1gzIg002QL7kmhVVEYKgklRXkfTnsPJBEs1XEKs95qA49kZa/izRzISzDV7/O1vBZ1fqLLAUe9h42/dTcdc7Xsx5ut5pKsxoTdT4/ScyJf8ZqVH3vu9D4gzING7GEBcB3Uy+HlJAajbzI0d2up0AYdnh0d2+QLxWBBtMMkZgn16SIv+LAkyJWsdAu4/VYwkzuJ6HSghQkSpJzrHgVehHFKhmbk6S3z
X-MS-Exchange-AntiSpam-MessageData: bBZb65ONQIjPDoCNSRgMgVMA/MEQ+HEsTkkqf6y2UvKp9qT2YQtoODs5VB1C8mf2ftUt4kAhlLTfPklcWMg3eEnY0d64Tm+zzkyQawbb95Of1YOngcWLt8q34wgmr+O2jrm1FzsqTkOZyKAwkNEbUw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd2af6e-cbe2-4425-8302-08d7b5bb0608
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 04:11:56.3386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsBQKb0WXeS2Oj5eVLhpsX2jJlZ0GsrYCm0q+8oXWg/R6VCGHQHJrgtuoqCWs9Jo
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

The virtio-scsi fuzz target sets up and fuzzes the available virtio-scsi
queues. After an element is placed on a queue, the fuzzer can select
whether to perform a kick, or continue adding elements.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/Makefile.include   |   1 +
 tests/qtest/fuzz/virtio_scsi_fuzz.c | 213 ++++++++++++++++++++++++++++
 2 files changed, 214 insertions(+)
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
index 0000000000..3b95247f12
--- /dev/null
+++ b/tests/qtest/fuzz/virtio_scsi_fuzz.c
@@ -0,0 +1,213 @@
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
+    /*
+     * Data is a sequence of random bytes. We split them up into "actions"=
,
+     * followed by data:
+     * [vqa][dddddddd][vqa][dddd][vqa][dddddddddddd] ...
+     * The length of the data is specified by the preceding vqa.length
+     */
+    typedef struct vq_action {
+        uint8_t queue;
+        uint8_t length;
+        uint8_t write;
+        uint8_t next;
+        uint8_t kick;
+    } vq_action;
+
+    /* Keep track of the free head for each queue we interact with */
+    bool vq_touched[MAX_NUM_QUEUES + 2] =3D {0};
+    uint32_t free_head[MAX_NUM_QUEUES + 2];
+
+    QGuestAllocator *t_alloc =3D fuzz_qos_alloc;
+
+    QVirtioSCSI *scsi =3D fuzz_qos_obj;
+    QVirtioDevice *dev =3D scsi->vdev;
+    QVirtQueue *q;
+    vq_action vqa;
+    while (Size >=3D sizeof(vqa)) {
+        /* Copy the action, so we can normalize length, queue and flags */
+        memcpy(&vqa, Data, sizeof(vqa));
+
+        Data +=3D sizeof(vqa);
+        Size -=3D sizeof(vqa);
+
+        vqa.queue =3D vqa.queue % queues->num_queues;
+        /* Cap length at the number of remaining bytes in data */
+        vqa.length =3D vqa.length >=3D Size ? Size : vqa.length;
+        vqa.write =3D vqa.write & 1;
+        vqa.next =3D vqa.next & 1;
+        vqa.kick =3D vqa.kick & 1;
+
+
+        q =3D queues->vq[vqa.queue];
+
+        /* Copy the data into ram, and place it on the virtqueue */
+        uint64_t req_addr =3D guest_alloc(t_alloc, vqa.length);
+        qtest_memwrite(s, req_addr, Data, vqa.length);
+        if (vq_touched[vqa.queue] =3D=3D 0) {
+            vq_touched[vqa.queue] =3D 1;
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
+    /* In the end, kick each queue we interacted with */
+    for (int i =3D 0; i < MAX_NUM_QUEUES + 2; i++) {
+        if (vq_touched[i]) {
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
+                .description =3D "Fuzz the virtio-scsi virtual queues, for=
king"
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
+                .description =3D "Fuzz the virtio-scsi virtual queues, for=
king"
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
2.25.0


