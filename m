Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFB3C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 464DF22CF7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YDZH3x12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464DF22CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i56Dt-0008He-ED
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 06:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i56Ci-0007LI-SF
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i56Cf-0006b7-Od
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:38:27 -0400
Received: from mail-eopbgr70114.outbound.protection.outlook.com
 ([40.107.7.114]:34004 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i56CZ-0006W5-0t; Tue, 03 Sep 2019 06:38:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlXzoHsuvPxMbAcwnI8JWCJsDRmNDlZtRjImg0Q3UO0Fcu1EOxwFcLIhoxkUb3tS1WVMQZEfqhtXtcznWA1I5VsBeaEj/ivzvouAat5KOV/fVdsiCzBj0ojwmXB1Ka5a63vJHw7x2ioW70nUq5J06ZZz3XIDqojQKxLGPW65yhMVQpqweGwAjXWiT8e//1w83zg/lhF45NgM04Idvm7NsY3w5EhBa2WxDd1/IeMJjxkn6KSFw9gxUUOhBE0abRyaPD21Qj9Nlhi8B8cvTGUUYcfLxLjrAcKbI+ysRZRCerrH/WdD5QNp3PrrZwIRreY+I+4l/NG9bjZMVAd7FveiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E46IAix9hNWS3Rvard0C24SMyrLLIoBYpo2krydXhI=;
 b=OLCVcozQRLPmm5oW31tgUtxEPEd2jFrgQRDOzsoUApu1m8dV5yGvGQ9WbJaj9d5/u+7hY7BFmZdRW/sDFdTx5f2WFcvuVES85Z2CyppXRS8OS2V+amBsi95z0JBMmSNbl2j/fCLd23YFIM/sK1MMKtCIWIAJqQ5yITC+QRcdRK/hbXxC4dDzSgCgeOqDntcAEDco7hY5N7l4RiQMQk13jjfExWCnMxtOB9bJQ+GJITffSYvTMzFAH6AA0h/fPGplmi3kCol9HUL0R5NGOsHtav+ZpKlfUHhXhzA1u1FW/fnQBERpZlmItVlNC2dh3Xwxme8H0TX634OtUrmQY/gSIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E46IAix9hNWS3Rvard0C24SMyrLLIoBYpo2krydXhI=;
 b=YDZH3x12xa9mm4vfo5vvDVFEJsCMj14zPrNYm/HWnqAvr7R+LQYjiCtcxjo5HCw7mTsgT2oS/SJ/DFWCBMJ701e2/fiZZqS23qoXzPklFU/pE1OB/as0glmaH2ELmPk8l0WR/7Sz59pt3tyQeRCHFwfZ6UxBOIKcicHgV/6jFgE=
Received: from AM0PR08MB3027.eurprd08.prod.outlook.com (52.134.95.154) by
 AM0PR08MB3714.eurprd08.prod.outlook.com (20.178.22.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.22; Tue, 3 Sep 2019 10:38:12 +0000
Received: from AM0PR08MB3027.eurprd08.prod.outlook.com
 ([fe80::19a3:6903:45eb:bf51]) by AM0PR08MB3027.eurprd08.prod.outlook.com
 ([fe80::19a3:6903:45eb:bf51%6]) with mapi id 15.20.2220.022; Tue, 3 Sep 2019
 10:38:12 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v7 0/6] Allow Valgrind checking all QEMU processes
Thread-Index: AQHVYLvcme1P621GcUCyi7aLGgh+kacZu+yAgAAJ+AA=
Date: Tue, 3 Sep 2019 10:38:12 +0000
Message-ID: <9b414948-024c-07e6-55f2-cd0297b70d4e@virtuozzo.com>
References: <1567338786-586124-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <20190903100229.GD4582@localhost.localdomain>
In-Reply-To: <20190903100229.GD4582@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0012.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::22) To AM0PR08MB3027.eurprd08.prod.outlook.com
 (2603:10a6:208:61::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0f0850b-3ba1-461d-3d35-08d7305ad1c2
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3714; 
x-ms-traffictypediagnostic: AM0PR08MB3714:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3714C4512AE1DF386761751BF4B90@AM0PR08MB3714.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(366004)(396003)(39840400004)(136003)(189003)(199004)(2616005)(66556008)(476003)(44832011)(11346002)(446003)(52116002)(7736002)(6486002)(478600001)(316002)(4744005)(486006)(8676002)(3846002)(8936002)(6116002)(81156014)(81166006)(305945005)(36756003)(31686004)(2906002)(64756008)(6436002)(107886003)(31696002)(102836004)(6506007)(53546011)(386003)(25786009)(6512007)(256004)(6916009)(229853002)(14454004)(4326008)(53936002)(86362001)(54906003)(71190400001)(71200400001)(99286004)(66066001)(186003)(5660300002)(76176011)(6246003)(66446008)(66946007)(26005)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3714;
 H:AM0PR08MB3027.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KY+fjDeLdAnUTSv3Q42BQbMk7L/HMvU8tFQ8BvZTgIt8ldZ3Irv7XGR6qsG+Z6vfR+M8t6FuxtT2aAlBDGAk6QixrtWsFRHVTlEJhenRpK82aYFQzJ4WuP9l3krrnIFs0MdP9FEWAlXayyRV8qiLnKixL/laQXNyeWsfyjtiJi/quBx/qbfb0N2IZJdDV6Q0CA0GPfV1Pyw5ZHmuHMdau+szJrKER/mLr/mGbkuWAcTKse2ee9PmIU+5xEbG9NCRmZyMy0lrtTb0z0NTMCGxPwK/U+4NVMUtHN4DqpqmfvWXmnejkSL4pwLxfMyCk7s5DMGqy+SNPG6l2o4nG2H6vA8OX1Y/zEM9fBgrt/MC6PydEJPn6SVUQOgB1DfUdxULf0M/nALozcCYJuaYI/aeoq133qkWKRxVKMhr4hPYgbA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <668B886FA3841B44B9EC661C0D1FD15D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f0850b-3ba1-461d-3d35-08d7305ad1c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 10:38:12.1441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6XbbSFKJYkTd82yMWKZQEo3Rb8dO06C5UQgbcrScVAtBV69ourlQhcIGRt+RPz0Zt89f7AHgwykT4lQ9xdeYtcvZCvI8uGjcxteqGQfn4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3714
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.114
Subject: Re: [Qemu-devel] [PATCH v7 0/6] Allow Valgrind checking all QEMU
 processes
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDAzLzA5LzIwMTkgMTM6MDIsIEtldmluIFdvbGYgd3JvdGU6DQo+IEFtIDAxLjA5LjIw
MTkgdW0gMTM6NTMgaGF0IEFuZHJleSBTaGlua2V2aWNoIGdlc2NocmllYmVuOg0KPj4gSW4gdGhl
IGN1cnJlbnQgaW1wbGVtZW50YXRpb24gb2YgdGhlIFFFTVUgYmFzaCBpb3Rlc3RzLCBvbmx5IHFl
bXUtaW8NCj4+IHByb2Nlc3NlcyBtYXkgYmUgcnVuIHVuZGVyIHRoZSBWYWxncmluZCB3aXRoIHRo
ZSBzd2l0Y2ggJy12YWxncmluZCcuDQo+PiBMZXQncyBhbGxvdyB0aGUgY29tbW9uLnJjIGJhc2gg
c2NyaXB0IHJ1bm5pbmcgYWxsIG90aGVyIFFFTVUgcHJvY2Vzc2VzLA0KPj4gc3VjaCBhcyBxZW11
LWt2bSwgcWVtdS1pbWcsIHFlbXUtbmRiIGFuZCBxZW11LXZ4aHMsIHVuZGVyIHRoZSBWYWxncmlu
ZC4NCj4gDQo+IFRoYW5rcywgYXBwbGllZCB0byB0aGUgYmxvY2sgYnJhbmNoLg0KPiANCj4gS2V2
aW4NCj4gDQoNClRoYW5rcyBhIGxvdCwgS2V2aW4hDQoNCkFuZHJleQ0KLS0gDQpXaXRoIHRoZSBi
ZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K

