Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04596C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:27:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E9022BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="v91fjWFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E9022BEB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqUPa-00015I-Lt
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 23:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40248)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hqUMH-0004JH-MT
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hqUMG-0001rB-M2
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:57 -0400
Received: from mail-co1nam04on070e.outbound.protection.outlook.com
 ([2a01:111:f400:fe4d::70e]:20866
 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hqUMG-0001qN-GM
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Agc3kd8Lw3ByoHO9wGDpId9tMTHrX21ZGBUwH1xku6u7Es8srBG2PGgtVC1sUymSOfZRej394XCMR1frvQ50KJb7RGXEfVOf0h2b4IROwImDu0HVIQE7gEsKAJO7f2NqJgrnniZe1z8/QX9ZAKsH+vtBVuSMyr4m1cgThffNKa64WRJlWpf5Jf3Tx+3uNt1q/bCqAl+B0CGmnykg5IU/5dk6HfJUClt3jWTVgeA+PSrhlVGL+terpHIm8//8yHt6yHnQjcWsQE89cQ1HYj5EG0zOVJBMJGVSyRUQhoVF9B6BpJmTQnf/asF2h86XWxtx1FI//RwmwFQVkTuMUltvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWcusC/C5GQ8HxbvHbkDa+zRpmoqoc3ymyMHSAiD9R4=;
 b=ePlfg9Ubp20VP/7HZrXpOio1qzvyMR/K4rNs15Ide2MvAt0V//cpXIepcX2NGXrShiEk+TSEdkxqTXbNSzbgvkGo/HJxh4NogmW52ZuVi0xjBNFcK1unOSAJdjg+TKnLJ/KgrvcLQ41qiRs9/ua4XTeiJJxpsrmKgWpDjrzMBBo7LEwzvpYkwyOo7Rh6a02ykS+7o4psuKEMYP9I/264ngfI1e22yQF4fOLrfC86P6JYAL7MvwzKDmnAgCAHkvWuaIu7ZyONlM6VtHIhxGrynd1bfhqnu/NKdSuZrFxUSl0wrDR++PKyC70a249Nz3VhoESXf+4eCuP0ex5DTINNuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWcusC/C5GQ8HxbvHbkDa+zRpmoqoc3ymyMHSAiD9R4=;
 b=v91fjWFnGiyO2aDkDohBack6QAj6rUqh6IvIwUowLpInMw5UkCgsWC0aAdaK6Rb1/STpB/tPDBWcIjnLVEIeGYk7PN0pU5mq02QCCd3nJG4H7Lbm1qXRMjCrK87rUkz8hpRkguNFbnXBSKWNTBdb8//CnjiNzrFwSZIFgJvzbEo=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2726.namprd03.prod.outlook.com (10.173.40.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 03:23:55 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 03:23:55 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC 13/19] fuzz: add ctrl vq support to virtio-net in libqos
Thread-Index: AQHVQphjneGWyeR1FUC3cWSGwtJT0Q==
Date: Thu, 25 Jul 2019 03:23:55 +0000
Message-ID: <20190725032321.12721-14-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 6b462ad1-ec55-4f92-f389-08d710af863a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2726; 
x-ms-traffictypediagnostic: CY4PR03MB2726:
x-microsoft-antispam-prvs: <CY4PR03MB27268DC9A811D9C9AEDCCF9ABAC10@CY4PR03MB2726.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(50226002)(3846002)(53936002)(6512007)(14454004)(66066001)(5660300002)(6116002)(25786009)(4744005)(68736007)(316002)(99286004)(54906003)(1076003)(2351001)(2501003)(2616005)(75432002)(7736002)(76176011)(52116002)(305945005)(14444005)(6436002)(71200400001)(6506007)(26005)(6916009)(478600001)(8936002)(5640700003)(786003)(86362001)(4326008)(256004)(88552002)(71190400001)(386003)(2906002)(476003)(66946007)(446003)(11346002)(8676002)(81156014)(81166006)(66476007)(66446008)(36756003)(6486002)(66556008)(64756008)(486006)(186003)(102836004)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2726;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WQRyIlHQNorX9Wc2q9lN/DEq7NZgzuFSODFA3g7eHGkJ6U5zdViKoCZUJCE9jDJstbMjIJwdKxavWqUd3dznM9jP0W3j2P7a4NeuRIqdYXacGxeT9jsYIWhqQ8zKF0D3di/5mdKrZstSKK4HEHmh7Fh7APCiRZA7QmANk8MpG4vi5S7haouQDR9QSLpXwRtRBbW6NO3+O0dnYPKLaMr1O0NRtcR0FZ4lucMuJLE5aF3rLlGtS0/2FP6HjVxLMLTs9vqHLc8qisltMjssy45gM0qJZM3BTd+VxRogL+bMBfX/iOhR5k07YHj5mRtXx0YkhXS7pDMJiqiMPbLuY4TcKAjfkpUARPFo9LJfGAN/ZYoK5RzPV40ycRJF8KIUWUqxq92lxgmmgGAxjdqKTROeT04wD/WvYEvIG7HRBTIUTYw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b462ad1-ec55-4f92-f389-08d710af863a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 03:23:55.6054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2726
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe4d::70e
Subject: [Qemu-devel] [RFC 13/19] fuzz: add ctrl vq support to virtio-net in
 libqos
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
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/libqos/virtio-net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/libqos/virtio-net.c b/tests/libqos/virtio-net.c
index 66405b646e..247a0a17a8 100644
--- a/tests/libqos/virtio-net.c
+++ b/tests/libqos/virtio-net.c
@@ -51,7 +51,7 @@ static void virtio_net_setup(QVirtioNet *interface)
     if (features & (1u << VIRTIO_NET_F_MQ)) {
         interface->n_queues =3D qvirtio_config_readw(vdev, 8) * 2;
     } else {
-        interface->n_queues =3D 2;
+        interface->n_queues =3D 3;
     }
=20
     interface->queues =3D g_new(QVirtQueue *, interface->n_queues);
--=20
2.20.1


