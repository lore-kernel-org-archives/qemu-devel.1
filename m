Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ACCC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:31:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6CB821901
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IiSA62zx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CB821901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqemO-0003Jv-Bg
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 10:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35298)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hqemB-0002rM-Lo
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hqemA-00081J-Kx
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:31:23 -0400
Received: from mail-eopbgr30138.outbound.protection.outlook.com
 ([40.107.3.138]:30582 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hqem6-0007zC-7i; Thu, 25 Jul 2019 10:31:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDR1VkoUENFUiPJRRh4bluATQreo24aY4gFjhFlX7TM7QdCLFSOmcPU1r7y/1xo7Ur2U1OuPAMczOPV+oHHAuz5md6rmQixve4FobDBrBEY+zIPAfPsZ9JCqAoRvneS1KQxC6XMfzw2xJu9mmkylf/B2KD+uitxaugGknq9+u1HyfsxCBqy36cTXPa2n0UsC++GPuIhoDM6pjT9171asuC8KRuMM5cyp82ej/blvXCcVfMYmuwmGMftsYZsjgJfgkIipk6/rFiH0RKKLLKoh/6UoW2sBRhbWkfK+HqEGkKEh/YaZ4bD/HvcKmTiDCHOo+dJH8CXQZkFSxGj7HiGGdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0FqrZ6pVCGirjYscApby3J2D4WDXiqXuPMf9UaVh+M=;
 b=Zfrtb4Fk7Gcn14a7zrDEhTnoesuTqBgV5MN+EVVjY6mBK4jLKnjpiJe6tV+WgmexUoLa22C7UqejbrAf2SPABOWz3DuM7AdWZV7HmGdxXlc8f+XzU9E9Jshc4Pd3WrtpKgdlfEQvvnxHSwwYO2dFi8Lo3BDzj+B3CdWCG87L6PbehwjXcafkZFJF+8TMO/ZcgIm7WuOIKie/oV0MhZTJEi9jBAT8ct623YSV5xZDpKhgYG/LeypqbWnCBfONV97KkWufnEeWF2+eev5G0BktziViZ6lZ9BgrHW+4RE08VUJs7KFbasOGRABeMMBidVOCfgfOUXkJ4cTSwwbsnniupw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0FqrZ6pVCGirjYscApby3J2D4WDXiqXuPMf9UaVh+M=;
 b=IiSA62zx5imuWAJ/q+7MfZ61NW7X3tTMmWPH0+eeAl+rVlYx+Vr0MUAd1M6C9uqyJfW2Yx7cXjOnVEh5M0gB62MNd4AcsbdrXGnHE/9Bxj7V0JHbYKz1bMZr753EToyYQVorsEOhZCv6G8qCDRH5YvbDNkkVGG6rDjTgv8tGwjE=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB3597.eurprd08.prod.outlook.com (20.177.61.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Thu, 25 Jul 2019 14:31:14 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7%6]) with mapi id 15.20.2115.005; Thu, 25 Jul 2019
 14:31:14 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v2] Fixes: add read-zeroes to 051.out
Thread-Index: AQHVQuClRUlAQMQd/U+a+m99v+bsk6bbY7oAgAABuoA=
Date: Thu, 25 Jul 2019 14:31:14 +0000
Message-ID: <fea5fe11-d32b-a16b-1ee1-5198e25486d8@virtuozzo.com>
References: <1564056050-505695-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <20190725142500.GD8294@linux.fritz.box>
In-Reply-To: <20190725142500.GD8294@linux.fritz.box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0012.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::22) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 300a27d9-f802-4f8c-45b6-08d7110cbf17
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3597; 
x-ms-traffictypediagnostic: VI1PR08MB3597:
x-microsoft-antispam-prvs: <VI1PR08MB3597F3DC7F4C42639887656DF4C10@VI1PR08MB3597.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(346002)(39850400004)(366004)(376002)(189003)(199004)(7736002)(446003)(36756003)(476003)(11346002)(256004)(2906002)(486006)(2616005)(4744005)(68736007)(44832011)(6436002)(14454004)(54906003)(71200400001)(305945005)(6486002)(52116002)(3846002)(6116002)(99286004)(31686004)(76176011)(186003)(71190400001)(81156014)(102836004)(26005)(53936002)(66556008)(4326008)(6916009)(66476007)(86362001)(6246003)(53546011)(8936002)(6512007)(25786009)(229853002)(5660300002)(8676002)(6506007)(386003)(31696002)(478600001)(81166006)(66946007)(66446008)(66066001)(316002)(64756008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3597;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6k4NXm7GrP5ppKQCDQ7teFNwoSBRyZMBgZoXjZq0X5WCAq58jbnQzhwloRfwa7bzvzpCpcaXuLG6BuyFEGuS7FZ0345xMZxjcMiG6iZD4DFDFlinB8OURJuNpM2LxZNlJfomUbT8NMj8qDzBZ+g/5PSZ0VppV2PWz9cx6MRYaIAB5k5vsS+KKj6okzwIUL9l2yclBSjacIvbCmTz3szmVN2YKv6DIc116Ekyg6oVtohHcZyrRYXl9HHD4ouNxK+2q3D9zEsxJPQRclu0DqU2MzgYaCWNvNPQxX4N+LYCU+ggXzo+w0xMCBdPz+z9wUVHywkDzkhbkFTMYzUC2ZOyZwsrTfVqMQ3QpVtbtY4H1ZLTHDwImvgjSwSczWvIKR99ExnhaWYNYorHP1HYc0iQ0iEuHF52KJhXuqpG0lz8Upo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49AA498CF05719478FCD217F0AA03461@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300a27d9-f802-4f8c-45b6-08d7110cbf17
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 14:31:14.1456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3597
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.138
Subject: Re: [Qemu-devel] [PATCH v2] Fixes: add read-zeroes to 051.out
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI1LzA3LzIwMTkgMTc6MjUsIEtldmluIFdvbGYgd3JvdGU6DQo+IEFtIDI1LjA3LjIw
MTkgdW0gMTQ6MDAgaGF0IEFuZHJleSBTaGlua2V2aWNoIGdlc2NocmllYmVuOg0KPj4gVGhlIHBh
dGNoICJpb3Rlc3RzOiBTZXQgcmVhZC16ZXJvZXMgb24gaW4gbnVsbCBibG9jayBkcml2ZXIgZm9y
IFZhbGdyaW5kIg0KPj4gd2l0aCB0aGUgY29tbWl0IElEIGE2ODYyNDE4ZmVjNDA3MiBuZWVkcyB0
aGUgY2hhbmdlIGluIDA1MS5vdXQgd2hlbg0KPj4gY29tcGFyZWQgYWdhaW5zdCBvbiB0aGUgczM5
MCBzeXN0ZW0uDQo+Pg0KPj4gUmVwb3J0ZWQtYnk6IENocmlzdGlhbiBCb3JudHJhZWdlciA8Ym9y
bnRyYWVnZXJAZGUuaWJtLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTaGlua2V2aWNo
IDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0KPj4gVGVzdGVkLWJ5OiBDaHJpc3Rp
YW4gQm9ybnRyYWVnZXIgPGJvcm50cmFlZ2VyQGRlLmlibS5jb20+DQo+PiBSZXZpZXdlZC1ieTog
Sm9obiBTbm93IDxqc25vd0ByZWRoYXQuY29tPg0KPiANCj4gVGhhbmtzLCBhcHBsaWVkIHRvIHRo
ZSBibG9jayBicmFuY2guDQo+IA0KPiBLZXZpbg0KPiANCg0KVGhhbmsgeW91IGFsbC4NCg0KQW5k
cmV5DQotLSANCldpdGggdGhlIGJlc3QgcmVnYXJkcywNCkFuZHJleSBTaGlua2V2aWNoDQo=

