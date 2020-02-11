Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2387C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936C720659
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="xWXac8zu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936C720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1cOL-00037o-Nk
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j1cG5-0006h4-Dz
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j1cG3-0000CA-0y
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:49 -0500
Received: from mail-eopbgr690106.outbound.protection.outlook.com
 ([40.107.69.106]:43233 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j1cG2-0008My-Kh
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0anvHXq6DzvvqbuaDxVAnH93eHuDpyEdGANsZtx2/d4RjTNCBK9XEXilH8cFl9A1FCv8eDD19mFMyQFutUO+IOaSUzkNsjeuuTD/P6sr+5eZhkjom8rhCEq5ynqYbIvRXxx4PX2tWuRR/QcHk5sZLOJa3T17GJNOJYSt+KC9IxSKXaDE2SoB7sBQFJ8Ohmfa7cvjqFz2+WqeKhNfUDFUcPUDBYWoWfiPyARNqx92Qg45mXruAF8ZMT44XsETakWKv+hOS07BLyVR9xyf4AgoxQbfs1wdaUFAaWnDhvGcTxbLzKsRLJKJ0toAykgsJdIkZ35/TXrUezdGRDkc+KR1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddlKpmlc/zroxP8ZEkJhzM9kUHBOrpcqv7oiDaX+4pk=;
 b=elyXydzMI9PariduEflgMdK4YG28Ms3Qf+1R6h1OpJRs7XUG8+6KDxMkAkyNumYUZQroOURa7uSKBxjMabqEjXDyr5Ixhlq/3r1GaPtkkJL+5ZxxA+3rp6sYZXJ13jZxnGnLZPCraBqkQmp5WdxqMozpBIp4XwmGcCSjmKqRukW+Lh3G3QJ+493mcbb1fSR9D5kL4ZdaMc8RQRL6dX/VOi67IDAZn1vfPwWa+VtbnfHY8ysh/F5uCbtsiWeWT2z8Cc6nRcYAdPpWevJk2408PGo5SsRl7NfNGNA3E+RzTyXU2ga4iGpna3Iuig2AUMnyACU7aCo3DxPLe6XI93GJPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddlKpmlc/zroxP8ZEkJhzM9kUHBOrpcqv7oiDaX+4pk=;
 b=xWXac8zuymJlwf6CESsxh2ks/BdDLU9tL3jHj+bMUY74lL2pPQhGwH8esYbzk9ItDHiBm9pkBY7eXT+KEP71D2b0PM0MwDdHuQY6AQp/iSZgZdDTHwBaeUuYfEphXPxV6DNoEroTZUD85FE84TVfrySyAZG1bXXEvVXE/lH7v0M=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4336.namprd03.prod.outlook.com (20.177.254.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Tue, 11 Feb 2020 20:35:42 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 20:35:42 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 22/23] fuzz: add virtio-scsi fuzz target
Date: Tue, 11 Feb 2020 15:35:09 -0500
Message-ID: <20200211203510.3534-23-alxndr@bu.edu>
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
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 20:35:41 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32059603-f459-4575-820f-08d7af31f649
X-MS-TrafficTypeDiagnostic: SN6PR03MB4336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4336F18368102602AEA15414BA180@SN6PR03MB4336.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
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
X-Microsoft-Antispam-Message-Info: onvT2J+QV0zfIN2x6oEz557vECrYioKYmOpSGpShFb4srDhmCGUHw4jXswIo/ZHiyo9r7jE+YTeyz1ogWfGrO3ZPdoB5gpt49e5bNMn/03xDZfBiZUMKixOC9kqwZD4UWkCh7I9FkueGM8FASnesFh7az5ZP7oZAi0+pw7aufDXML6LCXNzT7Rdwwuy+Ris+E4fBAs9MHAnCM1E3Zhh+UysoVD/IFpmZ9uZCyK2D74Rppp9wAIH+GuW63JAWzZPb0aTl54B0sZhcT2ES8s8sNAplEbY78OssaMr/vTOMtyZ8uW5+Wjvij3Hka4t06oGBJArLsXQFGRCjtPkJM4m87EBx7R6RXa6NFMg++UQAH7DevX1RzOvBUx4TtmqaYjFhmgQFagtYm0eUQRtTxN4YgMPZQNZev4yIdSviPYMKYmdpK30rWrMvw3cY7JcXSzSI
X-MS-Exchange-AntiSpam-MessageData: wwXg0/PdShRoFiUhryYe4G3GFgG2CEogSO9lPfwYAFvzQd6ATgVeLq3B4nAtX+hyyEiVNi4Tox3TavXuKPUDHqQOHTctwyU0Twj7OT7omMSkl7r8FkiEsNMeWxxO4LPM44OZTc+Ge/tZNHHuQ1Rxmg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 32059603-f459-4575-820f-08d7af31f649
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 20:35:41.7984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wmvQbsevWcZolxK8wDfgGnybyKFfbdksy8biIZhQDe2A8vppHPGSgcPjiG7peO6
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

The virtio-scsi fuzz target sets up and fuzzes the available virtio-scsi
queues. After an element is placed on a queue, the fuzzer can select
whether to perform a kick, or continue adding elements.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/Makefile.include   |   1 +
 tests/qtest/fuzz/virtio_scsi_fuzz.c | 214 ++++++++++++++++++++++++++++
 2 files changed, 215 insertions(+)
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
index 0000000000..f62f512a26
--- /dev/null
+++ b/tests/qtest/fuzz/virtio_scsi_fuzz.c
@@ -0,0 +1,214 @@
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
2.25.0


