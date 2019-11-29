Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E32C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 882A42464B
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="0QGMy9UV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882A42464B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaoD6-0004iy-PJ
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 16:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1ianum-0000CT-2C
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:35:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1ianuk-0002xZ-I5
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:59 -0500
Received: from mail-eopbgr740102.outbound.protection.outlook.com
 ([40.107.74.102]:45028 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1ianuk-0002ik-C1
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVeCiU9X8hS9KTeHIX7HWUyKbwc9IKEDXedQNBlNx1lrbk1On9/fCJlC2vcRD60VuubC283dGj0mbCRfuAMdO3Fn84HMmQSoTGLm4tbqpIPZyIi0z75ISNy1pHE+AJAu5eFAGFfWHB5KroTmGsZ0JtAkIc4sVawWjBcjWFNCkoUUU6vHlMZsuxC75FA18sRVZOvIORHjX+B2rR5suz1piDtPw+bIS97erztVJJpPoSFrz2NzoiEeMSrHPpNg+B9QAF6UkzzGs4erlTnOUwFNbJ0qeG7AB1AtaAZeVvlxV+JX+/v/2Qj0msYuBm2P3KmZ72T2qWvvMuxo/wL/8kmaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HHMshSjTOzwlIP/hg+KvMk5VYFujBMZHRY4mVN4E+Y=;
 b=Rty7D8F0GMkH4T03CsIlZ92GCEtFmhuOIeuv0dZGzCTuN7EYhanIkh/SaF/aUp6417GkYMLMRLHtk63KDDcVOdfBfd7VgRdq3oOEoYHhCMtbH9ulu0YUiPhGjP3BGQYJ6lJYCYu/0v47x7LsIICI2hO0CS7+rA+UP4cVj5Q0qImap5Bkjeo4lfzTHzJwvCaOWOCKnySeIy38tfCg9/vazs+0cGXOY82Qn1v9DG3VpBCe/Z468BCmkc2/ivQ33MKbGc2NJ+PpIC66klqKqbFT3qoFn1YeNe7ctV9D1WzLQoKeqrSKHvwmoejYRufxf9CShOwqNMK/y9DiuspQNknV8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HHMshSjTOzwlIP/hg+KvMk5VYFujBMZHRY4mVN4E+Y=;
 b=0QGMy9UVyAFDhRxKloveaROKIHUYbkAQpL7rSX+VCv2xJmhNg9HUkh29z0d96CVbVRRdDPnIjNdkK6TCE4SgYXJ8mnb+NXvw1sEaTY1cPBFI3PpQHoZhCse2u8X73ltwgqonupwcgGiFwAnZo7+HcA+qDVQuJHh7MHMl5i5y/Zs=
Received: from DM6PR03MB4795.namprd03.prod.outlook.com (20.179.107.22) by
 DM6PR03MB5050.namprd03.prod.outlook.com (10.141.161.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 21:34:53 +0000
Received: from DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74]) by DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74%2]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 21:34:53 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v6 20/21] fuzz: add virtio-scsi fuzz target
Thread-Topic: [PATCH v6 20/21] fuzz: add virtio-scsi fuzz target
Thread-Index: AQHVpvzWYSADiCR/WUWdTHlADPRAXQ==
Date: Fri, 29 Nov 2019 21:34:53 +0000
Message-ID: <20191129213424.6290-21-alxndr@bu.edu>
References: <20191129213424.6290-1-alxndr@bu.edu>
In-Reply-To: <20191129213424.6290-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR1501CA0025.namprd15.prod.outlook.com
 (2603:10b6:207:17::38) To DM6PR03MB4795.namprd03.prod.outlook.com
 (2603:10b6:5:18c::22)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d451bbe5-c739-4f52-0eab-08d77513f8cd
x-ms-traffictypediagnostic: DM6PR03MB5050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB505070EFB31CB615C3C574BEBA460@DM6PR03MB5050.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:302;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(81156014)(81166006)(66066001)(6436002)(3846002)(8936002)(66946007)(6116002)(1076003)(66446008)(64756008)(66476007)(256004)(66556008)(316002)(786003)(8676002)(6512007)(102836004)(6486002)(478600001)(71190400001)(71200400001)(2351001)(86362001)(6506007)(14454004)(2501003)(75432002)(386003)(5640700003)(2906002)(6916009)(7736002)(2616005)(25786009)(26005)(52116002)(88552002)(99286004)(5660300002)(76176011)(186003)(446003)(11346002)(305945005)(50226002)(36756003)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR03MB5050;
 H:DM6PR03MB4795.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cRe/LWqBV/zsyf9BuaXUqrW56N/F0Crp8ckcFJc1bV2J97dgS4FfublrZmP0gt45UlxT7f0OeEVeBTIo3dbYodg9splxuRbm/VpX4YrsIvXl2rBd0XsUBCeyx81RlYSmFaZd19w1opOKTb1yvdSJp9OI8/QvxAKuNu3CBUXt0gsmXxLtnQXwKkmyAcKWVoZmBkQCam5O3qocBzl82+gh+Zv/zaekOaF70ScXBfHqwaNHsspQ1LKDF+aDciikKM+jKOsi3aU0sreYWMxV+MBOwQWfaKwaAb+nGk2dPBTibNbadTRJaXNmzBreECMQ1WlZZXQO3dR8FBw35lTCqwx7avuexHysuSX2o8NyPBqk+yzY80AvgQoN+rPMFzobve4gqzpet35ZspE65NslWlnUwReKoLbhTUfJOOdY9hxkvINhP3jLpF6razVa+cOauYJH
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d451bbe5-c739-4f52-0eab-08d77513f8cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 21:34:53.6480 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hTGnVdUHtWt4bHvF8Oog39P+8CUZyNw5aQXkKEHlV566lPATtRiF/V1EuzIv6Jra
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.102
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

The virtio-scsi fuzz target sets up and fuzzes the available virtio-scsi
queues. After an element is placed on a queue, the fuzzer can select
whether to perform a kick, or continue adding elements.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/fuzz/Makefile.include   |   1 +
 tests/fuzz/virtio_scsi_fuzz.c | 200 ++++++++++++++++++++++++++++++++++
 2 files changed, 201 insertions(+)
 create mode 100644 tests/fuzz/virtio_scsi_fuzz.c

diff --git a/tests/fuzz/Makefile.include b/tests/fuzz/Makefile.include
index f1d9b46b1c..65b66fbdae 100644
--- a/tests/fuzz/Makefile.include
+++ b/tests/fuzz/Makefile.include
@@ -7,5 +7,6 @@ fuzz-obj-y +=3D tests/fuzz/qos_fuzz.o
=20
 fuzz-obj-y +=3D tests/fuzz/i440fx_fuzz.o
 fuzz-obj-y +=3D tests/fuzz/virtio_net_fuzz.o
+fuzz-obj-y +=3D tests/fuzz/virtio_scsi_fuzz.o
=20
 FUZZ_LDFLAGS +=3D -Xlinker -T$(SRC_PATH)/tests/fuzz/fork_fuzz.ld
diff --git a/tests/fuzz/virtio_scsi_fuzz.c b/tests/fuzz/virtio_scsi_fuzz.c
new file mode 100644
index 0000000000..591629f243
--- /dev/null
+++ b/tests/fuzz/virtio_scsi_fuzz.c
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
+#include "fuzz.h"
+#include "fork_fuzz.h"
+#include "qos_fuzz.h"
+#include "tests/libqtest.h"
+#include "tests/libqos/virtio-net.h"
+#include "libqos/virtio-scsi.h"
+#include "libqos/virtio.h"
+#include "libqos/virtio-pci.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_pci.h"
+#include "standard-headers/linux/virtio_scsi.h"
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


