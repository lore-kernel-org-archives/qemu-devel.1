Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E66C76191
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 03:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66B12080A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 03:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="BFqjYZjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66B12080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnEIG-000605-Hs
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 23:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53534)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hnEI5-0005an-4w
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 23:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hnEI2-0005xJ-76
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 23:38:09 -0400
Received: from mail-eopbgr710124.outbound.protection.outlook.com
 ([40.107.71.124]:56288 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hnEI1-0005ss-PX
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 23:38:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyRC6FQt4CGl/uskI/kCrNqBZQgVcj9YvBJJpI8JvPGZukEn1Rr/+PyUmoaFW2g3NJ23Y1f11S8eF+UGKyW7oMl6dTkI/xiR0StMeT0fqUnLNpgodiKr0PT2u6Ujr9QsKXEjDnaos7jLGscuDo0r3058j/E0rzstTAHU91nNUY5RXnn6VtNs8wvBe7GNeXOxGFFG0kHQKA3MFbNy4ZE/N2QhY4AGz/jV7Bg273oxOLQEm9peRiXz/bJoZFusNFwroEKB7kaP7axBY09nt3FKEFsQZfq+fveMwoE/hiAxG7EBrI5des8WyT+KK75GHwq0d8Am/pk/vnXzxCGNBIx9qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDv7V9H/vIYvBguK42QlNDjoL2PDYZaa1q/VAzrVOIw=;
 b=U/vB89TP+uOmSLq9glRQ8carseObKYanqXWlrbzKclA8VD5iFmqEfOnyqohwhDP6ESUrchEVjd9T8g9LucozB+8amABsRQkC40thdV8uXABqc0ol7u0yvWCcFz6diGDBabta3CsHfVJqHjk5DiFXipKdzEv4T3S5mNz3WvYE57kqJq5JR2DrPfowiOWMD904pZEdRCFWDuMPFwulhjcdgu/3vPe4GiPuVuh18+/8lK2KCK2TBekCrSPAphpwrbpytrLc2GaYUBlbul85ztoOvparVuSs2W/ZM+2sCbl0BQ0Jz9uFQu33Gv49S6nCAX/697b1LVE4LgasK663e35wlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector1-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDv7V9H/vIYvBguK42QlNDjoL2PDYZaa1q/VAzrVOIw=;
 b=BFqjYZjti7I33k/yTigVCjBIrT/ZY+VUnmBHwYgH3IQhUtxjnvhFb+yk3DVwOw901DDp+ZOZ1wC4lsdmioycnvNV3ndmFFULr2FRPRXww1d3/VvFc+twGy3s1o8cYsAWxSK8XOb/dce2NrJutZTN4tCyRKTrqBgSADwbiA2s8Ko=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2775.namprd03.prod.outlook.com (10.173.39.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Tue, 16 Jul 2019 03:38:00 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019
 03:38:00 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 0/1] Add check for header length in virtio-net-tx
Thread-Index: AQHVO4fdu4nw1gRFdE6dP+OPrW6gnA==
Date: Tue, 16 Jul 2019 03:38:00 +0000
Message-ID: <20190716033719.2866-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0144.namprd02.prod.outlook.com
 (2603:10b6:208:35::49) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5eff2c9f-13c3-451a-c547-08d7099effdb
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2775; 
x-ms-traffictypediagnostic: CY4PR03MB2775:
x-microsoft-antispam-prvs: <CY4PR03MB27757785E15784F982180B29BACE0@CY4PR03MB2775.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(199004)(189003)(71200400001)(4744005)(71190400001)(2906002)(88552002)(50226002)(14454004)(36756003)(52116002)(66556008)(68736007)(25786009)(66476007)(6506007)(66446008)(64756008)(8936002)(6916009)(81156014)(81166006)(478600001)(99286004)(53936002)(75432002)(1076003)(6486002)(305945005)(66066001)(5660300002)(54906003)(316002)(26005)(5640700003)(486006)(6512007)(7736002)(386003)(3846002)(86362001)(786003)(6116002)(2501003)(8676002)(66946007)(256004)(6436002)(4326008)(14444005)(102836004)(186003)(2351001)(476003)(2616005)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2775;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jEwYZA66H2jqYg0rOFysp/u9kMFDZimqp7Ule7p+qadV+Q3UmmIoOqTY32Q3cQx31rhaatAVGluV4p5pRahbY+99RMO9uH/EYy2M4E9ogiDbmv8/nHjeUyeua0Jd9/AU6YsvL19SOx6OBD6WoRryNT/2sawGJqm0YGSt32pYbKrPlRXBH0bl0ic09nj2qtCg6/uIQuCfxmUB+UkjrB8aTmsL6zRVapcsBY7T5XW+gsV6KwXr5obkOhHGuqxWYWxjyF1Au9/EcuFqDSS02/Lyw6wzbL3Y8M98jgquusefu9RkjVMbIed4kHGNVWJkDrSV2/QjTO5CS9ejeiRgU8nPljyEtMOB/W2/6jcnroBdhDxVKf1oZJWDiUFSeN6G990XofCdO5pj88fArQYckns5DKQT2aEdGBuCsFSvFyZFe4k=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eff2c9f-13c3-451a-c547-08d7099effdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 03:38:00.1658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2775
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.124
Subject: [Qemu-devel] [PATCH 0/1] Add check for header length in
 virtio-net-tx
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
Cc: "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Oleinik,
 Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While fuzzing the virtio-net tx vq, I ran into an assertion failure due
to iov_copy offsets larger than the total iov size. Though there is
a check to cover this, it does not execute when !n->has_vnet_hdr. This
patch tries to fix this.=20

The call stack for the assertion failure:

#8 in __assert_fail (libc.so.6+0x300f1)
#9 in iov_copy iov.c:266:5
#10 in virtio_net_flush_tx virtio-net.c:2073:23
#11 in virtio_net_tx_bh virtio-net.c:2197:11
#12 in aio_bh_poll async.c:118:13
#13 in aio_dispatch aio-posix.c:460:5
#14 in aio_ctx_dispatch async.c:261:5
#15 in g_main_context_dispatch (libglib-2.0.so.0+0x4df2d)
#16 in glib_pollfds_poll main-loop.c:213:9
#17 in os_host_main_loop_wait main-loop.c:236
#18 in main_loop_wait main-loop.c:512
#19 in virtio_net_tx_fuzz virtio-net-fuzz.c:160:3

Thanks
-Alex

Alexander Oleinik (1):
  virtio-net: check guest header length is valid

 hw/net/virtio-net.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--=20
2.20.1


