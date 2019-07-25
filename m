Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C16C76186
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB2E22AED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="LNmxO85o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB2E22AED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqUPa-00015f-IL
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 23:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40308)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hqUMM-0004eW-U5
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hqUML-0001t0-F5
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:24:02 -0400
Received: from mail-eopbgr780120.outbound.protection.outlook.com
 ([40.107.78.120]:46306 helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hqUML-0001sD-6I
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:24:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9m/1Xi6taRAkWJApnqMB9Kzsonl2bQB9c0OxrBT5bMCkXZQxRo+hZ9Lv25Ad22MXBzQ3zDL2+C9O76VAmVLnXZkfaJn+TRjNII828e2khn0GqfCKeP+exv7UpFc7b+JipydR35sZSZpU9DtrvQ86z1xOPb/U5kSyh/GB+jfJ2BoZU0c31wOsmDTw+PFXLV9JFeEkobHYANJD90c0MOuS+HFmTtYpXiEE/UcFdb8z4kcqfkm9hGl4QbCFhp4131LnaRUE4MTyh7pimGbbW35IGEEiPtfqj3x+3KzoflkA5KnNzUZp8HzK2449VaLf5zoGkBZI+BZETIkVl0ab9QKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SWXcHWVfKdcmb4IWwTCBQT4CkyklLLX4omf0ABGBD8=;
 b=MMmlhkZUnokhhca5vP+kWa8Dprpah0YNwAtVHGoMkIbCE1WDuP1+4ljkYzK/BfKiO4o0GzVn1z/zdg7Z3K5TyOCdG3s7eZlGhCaN9MmbSKIuQX9a2hXt0r8SKdF8VfhkKRf07F9tv1/rbQHpoj+M+EDfyPKAqxKpMx9Y73lhbfQOmmHATfuC0T09M57215jGwSp8Xb0IWY5Mvxgo9izcwwMasf6nIwYeAUdPVw1mk972XuNHNUQFMMBcWem7PsHZ246DGuGZv1d72kruSmYzBoqCLQtkfllyFhbe4+AgELaiWw+9Qx5qZOcbeUnSKkTWi4Gpv6s/U456I2Fg9teTFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SWXcHWVfKdcmb4IWwTCBQT4CkyklLLX4omf0ABGBD8=;
 b=LNmxO85owpfpCHRMsWpCZS7CnSjC9VFQ5Pq4cCe4WpkjQPGQU72RGM8oT3+bJqpOox4r+51WSJDNQSr77RZVWFxYsQThMJRR04GJce9YZfnshg6zJBmVF1f1ZPbc9dW74pD/X0y6ncXM1O0CmvF2UOG0fMVmsByWYSBUraoWy00=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2534.namprd03.prod.outlook.com (10.168.165.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 03:24:00 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 03:24:00 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC 18/19] fuzz: Add virtio-net tx and ctrl fuzz targets
Thread-Index: AQHVQphm7/AFCMvx8kuoRvQC6K9ySA==
Date: Thu, 25 Jul 2019 03:24:00 +0000
Message-ID: <20190725032321.12721-19-alxndr@bu.edu>
References: <20190725032321.12721-1-alxndr@bu.edu>
In-Reply-To: <20190725032321.12721-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:207:3d::16) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3225a18c-4acd-4bee-f14b-08d710af88f5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2534; 
x-ms-traffictypediagnostic: CY4PR03MB2534:
x-microsoft-antispam-prvs: <CY4PR03MB25345995CD60AC1312E7C1ADBAC10@CY4PR03MB2534.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:56;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(189003)(199004)(446003)(2501003)(186003)(86362001)(2906002)(26005)(2616005)(3846002)(6512007)(6116002)(256004)(476003)(53936002)(4326008)(11346002)(76176011)(81156014)(102836004)(75432002)(6916009)(52116002)(88552002)(386003)(81166006)(6506007)(2351001)(14454004)(25786009)(478600001)(36756003)(8936002)(316002)(486006)(66476007)(54906003)(71190400001)(1076003)(66066001)(5640700003)(50226002)(99286004)(6486002)(305945005)(5660300002)(64756008)(7736002)(786003)(8676002)(66446008)(66556008)(66946007)(68736007)(6436002)(71200400001)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2534;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7qtWVgvCJ7+s8l6GFClrQzBH1tLr4GUeElR54AJDX4Ybizk6A4LpuTtGJ/wCDuKoCYggXA6DeBnEGeggRShl/RxLjSD2hIbNCjR7uge/2C6rG4vK9SZRF4VraOdxWqWuvBU21XkR9UE0jqzMpwSBFKreU//Qx5j16IAAgr73h6xJJUSSNlXrwhYZiENRgkNDyC3AjM/G2cRdf+Gx6Zx8k+fFLAyYVmdQmu0DyTeVlUMDOn2x5RD6VX8TMNRmEkTkNZfDBGjcRig+zm1iAy3qeUnmbhPPno7HALOs9VUwiUvoGpA8pwSO6tpKMXPJqKb40fsQ70H8gSDp7KS8Vh+dGZje/zlnw2V94pxSBUrYD/gyK4f6KQ8jmegKocwofI/0Wasiga+0xv1HI4ed7DKCm9oQpFMLEJw0wo4uAVYTpNo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3225a18c-4acd-4bee-f14b-08d710af88f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 03:24:00.1074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2534
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.120
Subject: [Qemu-devel] [RFC 18/19] fuzz: Add virtio-net tx and ctrl fuzz
 targets
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
 "bsd@redhat.com" <bsd@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "Oleinik, 
 Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These virtio-net fuzz targets use libqos abstractions to virtio-net
virtqueues.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/fuzz/virtio-net-fuzz.c | 226 +++++++++++++++++++++++++++++++++++
 1 file changed, 226 insertions(+)
 create mode 100644 tests/fuzz/virtio-net-fuzz.c

diff --git a/tests/fuzz/virtio-net-fuzz.c b/tests/fuzz/virtio-net-fuzz.c
new file mode 100644
index 0000000000..4b6c788498
--- /dev/null
+++ b/tests/fuzz/virtio-net-fuzz.c
@@ -0,0 +1,226 @@
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
+
+#include "fuzz.h"
+#include "qos_fuzz.h"
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
+    int reqi =3D0;
+    uint32_t free_head;
+
+    QGuestAllocator *t_alloc =3D qos_alloc;
+
+    QVirtioNet *net_if =3D qos_obj;
+    QVirtioDevice *dev =3D net_if->vdev;
+    QVirtQueue *q;
+    vq_action vqa;
+    int iters=3D0;
+    while(true) {
+        if(Size < sizeof(vqa)) {
+            break;
+        }
+        vqa =3D *((vq_action*)Data);
+        Data +=3D sizeof(vqa);
+        Size -=3D sizeof(vqa);
+
+        q =3D net_if->queues[2];
+
+        vqa.length =3D vqa.length >=3D Size ? Size :  vqa.length;
+
+        req_addr[reqi] =3D guest_alloc(t_alloc, vqa.length);
+        memwrite(req_addr[reqi], Data, vqa.length);
+        if(iters =3D=3D 0)
+            free_head =3D qvirtqueue_add(q, req_addr[reqi], vqa.length, vq=
a.write , vqa.next) ;
+        else
+            qvirtqueue_add(q, req_addr[reqi], vqa.length, vqa.write , vqa.=
next) ;
+        iters++;
+        reqi++;
+        if(iters=3D=3D10)
+            break;
+        Data +=3D vqa.length;
+        Size -=3D vqa.length;
+    }
+    if(iters){
+        qvirtqueue_kick(dev, q, free_head);
+        qtest_clock_step_next(s);
+        main_loop_wait(false);
+        for(int i =3D0; i<reqi; i++)
+            guest_free(t_alloc, req_addr[i]);
+    }
+    qtest_clear_rxbuf(s);
+    qos_object_queue_destroy(qos_obj);
+}
+
+static void virtio_net_ctrl_fuzz_multi(const unsigned char *Data, size_t S=
ize)
+{
+    uint64_t req_addr[10];
+    int reqi =3D0;
+    uint32_t free_head;
+
+    QGuestAllocator *t_alloc =3D qos_alloc;
+
+    QVirtioNet *net_if =3D qos_obj;
+    QVirtioDevice *dev =3D net_if->vdev;
+    QVirtQueue *q;
+    vq_action vqa;
+    int iters=3D0;
+    while(Size >=3D sizeof(vqa)) {
+        vqa =3D *((vq_action*)Data);
+        Data +=3D sizeof(vqa);
+        Size -=3D sizeof(vqa);
+        if(vqa.kick && free_head)
+        {
+            qvirtqueue_kick(dev, q, free_head);
+            qtest_clock_step_next(s);
+            main_loop_wait(false);
+            for(int i =3D0; i<reqi; i++)
+                guest_free(t_alloc, req_addr[i]);
+            reqi =3D 0;
+        }
+        else {
+            q =3D net_if->queues[2];
+
+            vqa.length =3D vqa.length >=3D Size ? Size :  vqa.length;
+
+            req_addr[reqi] =3D guest_alloc(t_alloc, vqa.length);
+            memwrite(req_addr[reqi], Data, vqa.length);
+            if(iters =3D=3D 0)
+                free_head =3D qvirtqueue_add(q, req_addr[reqi], vqa.length=
, vqa.write , vqa.next) ;
+            else
+                qvirtqueue_add(q, req_addr[reqi], vqa.length, vqa.write , =
vqa.next) ;
+            iters++;
+            reqi++;
+            if(iters=3D=3D10)
+                break;
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
+    int reqi =3D0;
+    uint32_t free_head;
+
+    QGuestAllocator *t_alloc =3D qos_alloc;
+
+    QVirtioNet *net_if =3D qos_obj;
+    QVirtioDevice *dev =3D net_if->vdev;
+    QVirtQueue *q;
+    vq_action vqa;
+    int iters=3D0;
+    while(true) {
+        if(Size < sizeof(vqa)) {
+            break;
+        }
+        vqa =3D *((vq_action*)Data);
+        Data +=3D sizeof(vqa);
+        Size -=3D sizeof(vqa);
+
+        q =3D net_if->queues[1];
+
+        vqa.length =3D vqa.length >=3D Size ? Size :  vqa.length;
+
+        req_addr[reqi] =3D guest_alloc(t_alloc, vqa.length);
+        memwrite(req_addr[reqi], Data, vqa.length);
+        if(iters =3D=3D 0)
+            free_head =3D qvirtqueue_add(q, req_addr[reqi], vqa.length, vq=
a.write , vqa.next) ;
+        else
+            qvirtqueue_add(q, req_addr[reqi], vqa.length, vqa.write , vqa.=
next) ;
+        iters++;
+        reqi++;
+        if(iters=3D=3D10)
+            break;
+        Data +=3D vqa.length;
+        Size -=3D vqa.length;
+    }
+    if(iters){
+        qvirtqueue_kick(dev, q, free_head);
+        qtest_clock_step_next(s);
+        main_loop_wait(false);
+        for(int i =3D0; i<reqi; i++)
+            guest_free(t_alloc, req_addr[i]);
+    }
+    qtest_clear_rxbuf(s);
+    qos_object_queue_destroy(qos_obj);
+}
+
+static void *virtio_net_test_setup_socket(GString *cmd_line, void *arg)
+{
+    if(!sv){
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
+static void fuzz_fork(const unsigned char *Data, size_t Size){
+    if (fork() =3D=3D 0) {
+        virtio_net_ctrl_fuzz(Data, Size);
+        counter_shm_store();
+        _Exit(0);
+    }=20
+    else {
+        wait(NULL);
+        counter_shm_load();
+    }
+}
+
+static void fork_pre_main(void) {
+    qos_setup();
+    counter_shm_init();
+}
+
+static void register_virtio_net_fuzz_targets(void)
+{
+    QOSGraphTestOptions opts =3D {
+        .before =3D virtio_net_test_setup_socket,
+    };
+    fuzz_add_qos_target("virtio-net-ctrl-fuzz", "virtio-net ctrl virtqueue=
 fuzzer",
+            "virtio-net", &opts, &qos_setup, NULL, NULL, &reboot,
+            &qos_init_path, &virtio_net_ctrl_fuzz, NULL);
+
+    fuzz_add_qos_target("virtio-net-ctrl-multi-fuzz", "virtio-net ctrl vir=
tqueue \
+            fuzzer with multiple kicks",
+            "virtio-net", &opts, &qos_setup, NULL, NULL, &reboot,
+            &qos_init_path, &virtio_net_ctrl_fuzz_multi, NULL);
+
+    fuzz_add_qos_target("virtio-net-tx-fuzz", "virtio-net tx virtqueue fuz=
zer",
+            "virtio-net", &opts, &qos_setup, NULL, NULL, &reboot,
+            &qos_init_path, &virtio_net_tx_fuzz, NULL);
+
+    // TODO: This doesn't work. Possibly due to threading..
+    fuzz_add_qos_target("virtio-net-fork", "virtio-net tx virtqueue",
+            "virtio-net", &opts, &fork_pre_main, &qos_init_path, NULL, NUL=
L,
+            NULL, &fuzz_fork, NULL);
+}
+
+fuzz_target_init(register_virtio_net_fuzz_targets);
--=20
2.20.1


