Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727FEC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 19:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AB62085A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 19:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="S4Hjv74C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AB62085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoYl5-0003Dc-CG
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 15:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43764)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hoYki-0001sl-Bi
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 15:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hoYkh-0002FC-7D
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 15:41:12 -0400
Received: from mail-eopbgr790101.outbound.protection.outlook.com
 ([40.107.79.101]:1152 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hoYkg-0001aE-Qs
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 15:41:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8A3qH+I5c3+2Sr1h55/iCQKVJTnluVclZZk6EfGG/jfPJcPRT3ul9nO1Dd0aKYpqMxSKeBKFcfdq2zAZ6dBSSzpMHjM8zmMKuBUVUaas+LHA899AK8ts65jG9DP4g7jS2ArQn/a9U1YQikHbLx5RjmyTGrusXzzPZevuHZz7wvBm3t3YT5n9oaoHjCu1/vkMKNKAFGnCoRvKf82aO81tv2kZGpn/dFiix3ZswkLI79h/z/Q4ZMiKyuo42t3XYUZuMt4YnTd48X1iqYBDRkY1CT4r1HwPTw4CI/Ej0Hg5uSC70HQA3RBpQ9PTjKSrP9w9hDyd81SBlcSGtX9HuN/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gCfJz1RTLIUJ/stkNepwKeXe/2g8xkUVOv7RKcByM0=;
 b=OE82DksVaGjlZ1jfad1qExpqEVQ6CcXV0KkLCF/hyxEOqCWsID9lwidwKsrTlx0heA8mK46anO43dVd8w//K2ecG+ZtMHgj4k5ZHR7uPdPivbLDXyoFIkQ0lxSRZ6sFQY7Yqtc/fMACEqnTrbHD7j9nAgnXSH1hqifgN2b7OGRJi9IrrjOzDKBy2hcIJhl1eG2NCKZaItskKKjEDvygMewc4auNgc+n+9/UF3x6MiQB77q+pkXemdLI7Mh6ysseF7fiyzdXA6gGbpGID7X+W4Sus2bD79AWZ0IEzIMxdJuJDl+BW5DNyWJ0QqoV3u6RFNpukXf6XzwYTxHXntKb4fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gCfJz1RTLIUJ/stkNepwKeXe/2g8xkUVOv7RKcByM0=;
 b=S4Hjv74CYvB9l2Ad0RQho4BtVwUTwRbevyR/uVTgLMeO89R0ww2DfgqMHHGdZnIc3jeNhiKwtovM23ieQdZ6E3unpx5tUWVzy8lVq7WMJ0kEiMJGAynTtDNe2aGio+w+TBo+aPHKvW4iSPW1mvrRsMyeKX8idzDLezmwjEZOBPo=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2743.namprd03.prod.outlook.com (10.173.38.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Fri, 19 Jul 2019 18:52:24 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2073.012; Fri, 19 Jul 2019
 18:52:24 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 1/2] net: assert that tx packets have nonzero size
Thread-Index: AQHVPmMaGztodEr+U0+u+pXte5FK9A==
Date: Fri, 19 Jul 2019 18:52:24 +0000
Message-ID: <20190719185158.20316-2-alxndr@bu.edu>
References: <20190719185158.20316-1-alxndr@bu.edu>
In-Reply-To: <20190719185158.20316-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR20CA0006.namprd20.prod.outlook.com
 (2603:10b6:208:e8::19) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e0d0734-3b03-40f7-115c-08d70c7a3cfc
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2743; 
x-ms-traffictypediagnostic: CY4PR03MB2743:
x-microsoft-antispam-prvs: <CY4PR03MB274384C36DC6B12C13DD1218BACB0@CY4PR03MB2743.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(199004)(189003)(8676002)(88552002)(2906002)(102836004)(99286004)(305945005)(76176011)(6506007)(7736002)(8936002)(6512007)(386003)(66556008)(81166006)(6486002)(4744005)(75432002)(5660300002)(2501003)(52116002)(71200400001)(478600001)(71190400001)(5640700003)(81156014)(66066001)(53936002)(6916009)(1076003)(25786009)(2616005)(36756003)(486006)(64756008)(6116002)(66946007)(26005)(66446008)(86362001)(3846002)(68736007)(66476007)(2351001)(6436002)(316002)(50226002)(476003)(446003)(54906003)(4326008)(186003)(786003)(11346002)(256004)(14454004)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2743;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7MmK8zxr9qbatyAwkCCz9i02Ouptj/Itiz37Ch5kR/zIjKUERAEIGVTlVkPmLRwZ0aJaFHKuGD4L3yRx/Cct161yiX4jauVrs06oCY5U5b+mIGbOALGWufFBq/vtSJ+mDzbTxTM1VY1pSJzVuSKv+kMfrL5eEwz5qz1xbjjYS8LxeZePNP3y9y1Zm5PclagKV0NyFJN5Kj6a+NQ7DkMU/FCXC2hGocL5znx099kExki9fnCLvSTENjONI1gvmTkb5ZR6hGbb2138zC2ULDdQCAL57scZd9jCTBKNuw6nxixMy8BtZyWI2Jvu2gym8ldVE3A2KnEJzeHc8X+7G9Ki9SJVoGdzd3TutHB5oc9ThlhBrwsvBQiPycry9IT8OMI6k2hg6UrJdGMz0rBmWFvKJ3GkAO8VqKFeO0IIwMBx8I8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0d0734-3b03-40f7-115c-08d70c7a3cfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 18:52:24.7269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2743
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.101
Subject: [Qemu-devel] [PATCH 1/2] net: assert that tx packets have nonzero
 size
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
 "bsd@redhat.com" <bsd@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "Oleinik, 
 Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Virtual devices should not try to send zero-sized packets. The caller
should check the size prior to calling qemu_sendv_packet_async.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 net/net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/net.c b/net/net.c
index 7d4098254f..fad20bc611 100644
--- a/net/net.c
+++ b/net/net.c
@@ -741,6 +741,9 @@ ssize_t qemu_sendv_packet_async(NetClientState *sender,
     size_t size =3D iov_size(iov, iovcnt);
     int ret;
=20
+    /* 0-sized packets are unsupported. Check size in the caller */
+    assert(size);
+
     if (size > NET_BUFSIZE) {
         return size;
     }
--=20
2.20.1


