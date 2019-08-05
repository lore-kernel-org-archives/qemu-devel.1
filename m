Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295B0C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 03:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E558020B1F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 03:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="bIatIeY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E558020B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huTcA-0006H4-1L
	for qemu-devel@archiver.kernel.org; Sun, 04 Aug 2019 23:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59296)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1huTbf-0005pN-9P
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 23:24:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1huTbe-0003Pn-Ca
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 23:24:19 -0400
Received: from mail-eopbgr740125.outbound.protection.outlook.com
 ([40.107.74.125]:39856 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1huTbe-0003Od-7n
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 23:24:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euzihq+1YoBQugALGnUM/4EEStyxzw8Y6qv11YTVJ4Y0l+y2v+88Vx/CYIkldCEtHp5mh1d9qhM76DCR/zLaf31oRDFqI3B6dGZlnn7kvPnQf4ZRUR7dgSm7fJ0x2NGHJBSJ7u7CQ6GH9Cjtt/AE8F/coLPU9I3zht7E4bHI4K0vIz2w6n8X8+qoxGGsP+IZsrdAz7gOflrQ4kvIJckadG+Arx2pV+DQ7OEC8dqv17i8KU8Daf+O0FJnzZQ4wtdu30QcYVglERk+H9JebLBhGPapXSo34hV7N2fO6sJRwm9xDfoOj0djVn8vHkFxnev0Bl95UT3PMoeGZE2UmCwd/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ht2OP2KA+4w12PvNOFKbSBhw0ONfG4VskMw1PLkbw4g=;
 b=BABiCvUnxb9uwmNwi2tgCqhwTjwb5io6YV2hPEQPfR0hWmqRDW/JxFXignPB3ujXgHBU+a1f9T/FeIjTGzOprM2hTyy+hTVg/Uvv6LZvxIp8RfqK3voqhrcEXiR2Dmu0wp5d0cTpYv2F1dprSINcj2NZt5DryIM40kqJKNPu30wQv/tRYz0/lOM1DSkyN7IQZ0k1LPdaLclTH4rdKtbWXtLqe4UvIngtCMrbOZIa9cYEEkkKufp0CFZJmNjP0LcPe+vZXHAi4eqa127/w+TyTa+1Vcprqx7rnajhBxMf0fpUHlSW9b1BhjmyzWRi3BBgOb/yJOoM0d6vy6zKII5Vmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ht2OP2KA+4w12PvNOFKbSBhw0ONfG4VskMw1PLkbw4g=;
 b=bIatIeY6MBmCTz4Z2Fco45G9YqHWSrckiQ9LtXWtMb3ppYIsc/LZrPsn+6CZkb74cTNOMnCI1I8+FCsaYUQ/vppFFpqNrgZWhDRgugr+swO4FOUZS5RKNFtJAZBztPUA1DNGcxwDRAS9k9qo1lu8S7E/6LKftC3xqbuVhyYap/M=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2616.namprd03.prod.outlook.com (10.173.43.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.12; Mon, 5 Aug 2019 03:24:15 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 03:24:15 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH] libqos: Account for the ctrl queue in virtio-net
Thread-Index: AQHVSz1CUgha89H44UiBTNnaIEmg0Q==
Date: Mon, 5 Aug 2019 03:24:15 +0000
Message-ID: <20190805032400.8054-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:208:d4::44) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27d471de-e3d3-443f-75bd-08d7195464aa
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2616; 
x-ms-traffictypediagnostic: CY4PR03MB2616:
x-microsoft-antispam-prvs: <CY4PR03MB2616461E56CC7C9AF3826058BADA0@CY4PR03MB2616.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:343;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(189003)(199004)(478600001)(186003)(52116002)(81166006)(102836004)(99286004)(26005)(71190400001)(71200400001)(53936002)(81156014)(36756003)(14454004)(386003)(75432002)(6506007)(7736002)(5660300002)(86362001)(6116002)(6512007)(1076003)(66446008)(5640700003)(8676002)(6436002)(15650500001)(8936002)(66476007)(6486002)(66946007)(66556008)(3846002)(64756008)(256004)(486006)(786003)(50226002)(316002)(54906003)(88552002)(6916009)(2616005)(14444005)(476003)(66066001)(2351001)(305945005)(68736007)(4326008)(2906002)(25786009)(2501003)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2616;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MltfXfrr4KzyWCJTwvMS+c9o4dV5bqrBRGYcBzggMYXuEjlqmkQlyGi7jFf8znHquEBFyZh+ktCeDBoDz8wyljnj0TohUxmOWE5hCxG10oXo0aDUhLfaOOOIhmb22bFXdKAlVaa5r8GNUag7rJU6VUs3AFoufzNN3OXXf/Ftdz1pcpClIZ6aRUFul4Qey0lrtFhRk7UUsPsv04ek/COsdiSNxcwBMAaRKY3EU5vnBO+8uE2Z/i6ungaD9t+3qLfv1nPPFCph6LzuiIJC2Vtp+BkNnUU3D1V3KPUnegZaTq3Q2qIApc+ho7VMOXXetmk5u1aBU1XuPZKU6zvZUXInotxEv4AAouxRJbrPjNcZ5rp3SMgysZlCCKLvphXcmxt6gF2GDjvctbRz05vB5+ku1ZHxuQPeo0InQkR4Kr5jCAk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d471de-e3d3-443f-75bd-08d7195464aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 03:24:15.5253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2616
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.125
Subject: [Qemu-devel] [PATCH] libqos: Account for the ctrl queue in
 virtio-net
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
 "Oleinik, Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The number of queues is 2n+1, where n =3D=3D 1 when multiqueue is disabled

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---

I split this commit out of the fuzz patch-series.

 tests/libqos/virtio-net.c | 1 +
 tests/libqos/virtio-net.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/libqos/virtio-net.c b/tests/libqos/virtio-net.c
index 66405b646e..b8b5bc5dfc 100644
--- a/tests/libqos/virtio-net.c
+++ b/tests/libqos/virtio-net.c
@@ -53,6 +53,7 @@ static void virtio_net_setup(QVirtioNet *interface)
     } else {
         interface->n_queues =3D 2;
     }
+    inteface->n_queues++; /* Account for the ctrl queue */
=20
     interface->queues =3D g_new(QVirtQueue *, interface->n_queues);
     for (i =3D 0; i < interface->n_queues; i++) {
diff --git a/tests/libqos/virtio-net.h b/tests/libqos/virtio-net.h
index a5697d7326..855c67d00f 100644
--- a/tests/libqos/virtio-net.h
+++ b/tests/libqos/virtio-net.h
@@ -29,7 +29,7 @@ typedef struct QVirtioNetDevice QVirtioNetDevice;
=20
 struct QVirtioNet {
     QVirtioDevice *vdev;
-    int n_queues;
+    int n_queues; /* total number of virtqueues (rx, tx, ctrl) */
     QVirtQueue **queues;
 };
=20
--=20
2.20.1


