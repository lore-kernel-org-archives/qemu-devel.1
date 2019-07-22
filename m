Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A8DC76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14724218DA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="B4eFY1F0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14724218DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpYJe-0000Cc-Ty
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 09:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50000)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hpYJD-0007UU-9U
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hpYJB-0003rB-QS
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:24:55 -0400
Received: from mail-eopbgr710112.outbound.protection.outlook.com
 ([40.107.71.112]:26272 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hpYJ8-0003nE-84
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:24:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D18h4dt2ZcKZ56OJs/UUqIDevNbNnogvwqfIHJHXEd7uf6hrYVHznzzTwi89wMEtHe740l9CnfT/VRpKK60ZqnYi3UUXpuAIlrX0oyrlaFpa4DDF5yVV8VqJ3eKNgOLRZrlzKiUkB2wV8wyN3lIL54KaFWCvT3CZqhnv0MxGmBCjhHcQ40L0E7CldM9DjE4su9IWv2n5wVROH9rX8zWBHdus3nh5430FMUzSU/utRIUZbOr+QGBrHifvcqIiWFMXdf4evi49rtIyd1SdamjMu1GArX/SeCBVXZGMD4Li7El2hDu5cSrvmZsFH/GT0i6YRRRHDg7EnnvlsRuu5fwRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRN2DdwkQJTpCv9Bi8F3NBHytpwuIZ/oQN2AoiS3iu4=;
 b=i3DTZNXX1GLqttxXTsKRK+wyaZsUw4mLrXxS7fWoBQHlVWooJWNHM9TupmLkLBfK91harATn+NdyvWSyTNNR+VqislZSSmuXMjXK6WGnQHlGXTTsdbc9K0qiBEjDrZ8ltspgh/OzDAZPv2xYaFJtc9Bl7f1iwelPJLZgtK+44tkY1TdkGDatdeVI8rzcYpmidxcPwOQFGBMfxAxSycLYEdrfNmW/m1IM0Stjwook1jXkDzoDkoVJC3xp1fXqJ+1Xcm1cBCEbjBDSuU74mS/+Oc7DV+M54VCJbqJx0cP3dCqpS62PBgXeIQg/PMIbHvQojwHVVHyutEnhFRSfUqv9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRN2DdwkQJTpCv9Bi8F3NBHytpwuIZ/oQN2AoiS3iu4=;
 b=B4eFY1F0kzoZ1eTdig/ox2ogVhCDRWKqRokY7kKL3ygKj4TvzmK8i5u23FIvsPDbahGjhT8yFWcnRU/6QQz0/QlsvPjpz1pChenT31etcpA03Zs4ND87H5svBy0/ttFXEVGgB4ln/UvQ1u2QBUA/FCDNTU56HHZvIe6WBR6fWqY=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3271.namprd03.prod.outlook.com (10.171.246.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Mon, 22 Jul 2019 13:24:44 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 13:24:44 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 0/2] Avoid sending zero-size packets
Thread-Index: AQHVQJDT8pj5/aVn/UGzmSWCNCRTAw==
Date: Mon, 22 Jul 2019 13:24:44 +0000
Message-ID: <20190722132344.30798-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR01CA0030.prod.exchangelabs.com (2603:10b6:208:10c::43)
 To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa965cf6-2793-46ef-31d6-08d70ea7f5d8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB3271; 
x-ms-traffictypediagnostic: CY4PR03MB3271:
x-microsoft-antispam-prvs: <CY4PR03MB3271AB13AF2D2C5FA5275395BAC40@CY4PR03MB3271.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(189003)(199004)(86362001)(1076003)(75432002)(478600001)(6916009)(486006)(476003)(2616005)(52116002)(66066001)(26005)(2351001)(186003)(102836004)(6506007)(386003)(3846002)(6116002)(66946007)(88552002)(66476007)(66556008)(64756008)(66446008)(2906002)(5660300002)(99286004)(8936002)(6486002)(4326008)(25786009)(81156014)(81166006)(6512007)(53936002)(7736002)(6436002)(8676002)(50226002)(68736007)(5640700003)(2501003)(36756003)(54906003)(71190400001)(71200400001)(14454004)(256004)(305945005)(786003)(316002)(14444005)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3271;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PgYeNcfXcK2spMgtPAQhdcCLnQ9CmPE8Jp8HUuF5MnuQ8bShwovsy4w/ozT7Q8Rt6vYzOtoBMWZFnxPqiT5ljfd9lEap03bGBR29l0a0ySJTGdWqFfEz0mXjO3LeV0DvrJYpcboShHathd9n6MGsa3MfE7t+SRF8ElsEP4UCmIanUvbDHlIw/R+5DWH982JoHGPRypjxIXpcwJiXqBm5dL26reYURMyzKM3uGMImEypuOGN8IzS4hfw+vbwlENq5wI8B+D9NevOuncF4ymb+Gk8QPFB+zxo+vDJ75Fs/Tz27nnDsQx88BKi2MiVEvglYpvtyFZEN46pu1Y3e48ZgEFWox7FT191SYkUUVP5fpLv3zN0rzhdeWYhvhexkpoBPcqcDZLflj1n0lrHorWgAVfTzh9naFzsSgtzSC2aXL4Q=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: aa965cf6-2793-46ef-31d6-08d70ea7f5d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 13:24:44.5297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3271
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.112
Subject: [Qemu-devel] [PATCH v2 0/2] Avoid sending zero-size packets
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

v2: add details to  comment for the change to qemu_sendv_packet_async

Alexander Oleinik (2):
  net: assert that tx packets have nonzero size
  virtio-net: check that tx packet has positive size

 hw/net/virtio-net.c | 15 +++++++++------
 net/net.c           |  9 +++++++++
 2 files changed, 18 insertions(+), 6 deletions(-)

--=20
2.20.1


