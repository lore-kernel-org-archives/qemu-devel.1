Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCFFC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3EC82464B
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="kWMZPSNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EC82464B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaoFg-0006wm-SH
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 16:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1ianun-0000ET-Nu
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:35:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1ianuk-0002xf-JL
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:35:00 -0500
Received: from mail-eopbgr790122.outbound.protection.outlook.com
 ([40.107.79.122]:35989 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1ianuk-0002ny-CH
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFz85wiMtza5aoXkIH4VY2Pz5rjqzK1BpUaghXO/XSKiMs03XgjHMR2uQ1tcdICSo7m74u1XN6k9PoN4pwKjOvweA4zVwuZWHyn9x01wD4298EKStWFL7I7fDR041s2Qz4U1qkA7bfwX46UFbEsHSe0gH+BcZH24+wXkbAkNHy5d6VChmStikD/t+QDsjsKj6eimDfljiIEiOA4e8dv5h0XIeiFtHCjhPxGYxkW52ZssnSlvzJqgudQ5jIk9EI6pdDd/hpZVJGsLCby83axf9zclpzQbkXzYSOhWIjJJb/LlisgRWVjTLebdCH9dG8rQWzKYD58SXhk2eGq7JigEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JtPnujldEuTmS3BKihCfIMpOAXlqlnMJM3AmKLw/3A=;
 b=Q3Bm7/SMQjXZcETNcFeBUu4YzeJanai3sR0rvJIIx/E3gSVlHMJhwpxH0OqR3rFX5wkNRv80VYrUuc74VISLG7SlLKiO5iJOMdXzFejgxn2Z1d0z/oE+reKWbs8ZfIKWZmeSJjrn0FGslaxEcgqTO5GTIv5FQgUEqW2MWbwiuQZ60HXhcHFmqrmfabPpACDHUe9YMdeAQ/FmT3Q8gCTvSGlmpCJjtq57pDOx+btS7Wr7jsCiXZZ8cp5GnxecZYKDSx9QXKSCBSLfEgrXaAoIE9GvImvd75Rj350DeDis4K4pYsSPpIM7B83J2j7c1HSWlf9cGdj82dz2L1jixzRdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JtPnujldEuTmS3BKihCfIMpOAXlqlnMJM3AmKLw/3A=;
 b=kWMZPSNd2c4YqPlRerxKVwgiFfVPUMQ6WjzxD50CrBRUfVhPXbA5TF/b4BHpkynWU89CnQ1pMu9jdVXzuQF190Fb0wIRJqugf5TS3TV3/kJeC1y5x/MV0JuZkM4lD1gTCqzUJBJaOLXhcVxI/+AVgqET7M4m2RJiP2dcjSUHo/M=
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
Subject: [PATCH v6 19/21] fuzz: add virtio-net fuzz target
Thread-Topic: [PATCH v6 19/21] fuzz: add virtio-net fuzz target
Thread-Index: AQHVpvzW/QZ/3r6zEUyEzo53K9zodw==
Date: Fri, 29 Nov 2019 21:34:52 +0000
Message-ID: <20191129213424.6290-20-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 0a35104f-0620-44e2-dd94-08d77513f868
x-ms-traffictypediagnostic: DM6PR03MB5050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB50504B67412EBC8251F5D361BA460@DM6PR03MB5050.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:389;
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
x-microsoft-antispam-message-info: h0j9VAy4oxEz7MQtxY7NctguyC51G0+96r9fNyCOtD+PCuyva3Jkqozq0QeJrhuwMPf+OkWei886Qqs6w9CQ7adhFX4UFb3/14+SBWSQkPg4jPoEplRFX91QFabRBeSpbwMD1SWRU9a/azrslsT/Svnc1epHMGDGvrgLqQHMORVVAAgvSIii8TqVvAW0doXPsf6LlHbk2mpxPD+z2J9LEzXNrzCln+QGeiK0wLncDkNE04GSoMUZDxwTRmwB6lDHJ/KprgwxoEnPcojsMTD3ro+Q1GyyMCDFJ29K6ZrKcurChT9HR+/B8Y4Dg0Rmjn0/O3UZYjtzdyngvccQnbhI20y1bDcs/Z0TwazlQvQcsp87uh/jL9CcLJs1OZM4TcxQtX2gcAvGscYnhZ8JgAOtRCkNeVW1UaK2H3qyQF4fhJbwbN2cI0qEpmAyHa7GQldE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a35104f-0620-44e2-dd94-08d77513f868
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 21:34:52.9874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IyGM7MvXyJ36sZL5oMwOIW8G+XpVBqQrskZd+bqZzvMZUfzivR7lx1BSNoX/w+FY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.122
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

The virtio-net fuzz target feeds inputs to all three virtio-net
virtqueues, and uses forking to avoid leaking state between fuzz runs.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/fuzz/Makefile.include  |   1 +
 tests/fuzz/virtio_net_fuzz.c | 105 +++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
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
index 0000000000..f8efe3d7fd
--- /dev/null
+++ b/tests/fuzz/virtio_net_fuzz.c
@@ -0,0 +1,105 @@
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
+        uint64_t req_addr =3D guest_alloc(t_alloc, vqa.length);
+        qtest_memwrite(s, req_addr, Data, vqa.length);
+        free_head =3D qvirtqueue_add(s, q, req_addr, vqa.length,
+                vqa.write, vqa.next);
+        qvirtqueue_add(s, q, req_addr, vqa.length, vqa.write , vqa.next);
+        qvirtqueue_kick(s, dev, q, free_head);
+        Data +=3D vqa.length;
+        Size -=3D vqa.length;
+    }
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
+static void virtio_net_pre_fuzz(QTestState *s)
+{
+    qos_init_path(s);
+    counter_shm_init();
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
+static void register_virtio_net_fuzz_targets(void)
+{
+    fuzz_add_qos_target(&(FuzzTarget){
+                .name =3D "virtio-net-fuzz",
+                .description =3D "Fuzz the virtio-net virtual queues, fork=
ing"
+                               "for each fuzz run",
+                .pre_fuzz =3D &virtio_net_pre_fuzz,
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


