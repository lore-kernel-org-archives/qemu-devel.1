Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4069C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 14:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861482147A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 14:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CnELaxDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861482147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53695 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDUyP-0002gH-NQ
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 10:10:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDUxN-000299-Cj
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDUxM-0004A9-Cj
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:09:05 -0400
Received: from mail-eopbgr130124.outbound.protection.outlook.com
	([40.107.13.124]:21319
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hDUxB-00041z-Rr; Mon, 08 Apr 2019 10:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=+MhYIxmtFfCn7nwexMwlVsB/HoRnQvIANZia9GfJPlk=;
	b=CnELaxDKP30bbFxSCjTPwUOJl1Rjjp78ASGVh5neRHz9fQ2hWc4ez6WJOy7S1sv7MJ8NXzSi0d/xBKAQH2EDfiE1GHwDzkh30S9LXJECVHOxChbsEL5sRXEOHhk6BKASUcXfNUJzqIqh01yzCXOAqaKuVFuthbqqY0nEpAxPxX0=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3642.eurprd08.prod.outlook.com (20.177.120.148) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.16; Mon, 8 Apr 2019 14:08:30 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1771.021;
	Mon, 8 Apr 2019 14:08:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 3/3] block/stream: introduce a bottom node
Thread-Index: AQHU69CHWWbb6NKDUUStTYRcf+317aYyUXIA
Date: Mon, 8 Apr 2019 14:08:30 +0000
Message-ID: <2510ecea-6984-846a-4cd5-e0eba535a4c2@virtuozzo.com>
References: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554483379-682051-4-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1554483379-682051-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0033.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::22)
	To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190408170828208
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03d83019-382d-4c4d-ed38-08d6bc2badd7
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3642; 
x-ms-traffictypediagnostic: DB7PR08MB3642:
x-microsoft-antispam-prvs: <DB7PR08MB3642D52052CE91B189AD16BDC12C0@DB7PR08MB3642.eurprd08.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(39840400004)(136003)(396003)(346002)(376002)(199004)(189003)(478600001)(54906003)(5660300002)(8676002)(106356001)(305945005)(7736002)(110136005)(2501003)(14454004)(316002)(81156014)(26005)(186003)(2906002)(256004)(3846002)(71200400001)(31686004)(71190400001)(105586002)(6116002)(446003)(8936002)(386003)(76176011)(6506007)(102836004)(81166006)(486006)(476003)(36756003)(11346002)(86362001)(2616005)(229853002)(6512007)(99286004)(4326008)(6436002)(6486002)(6246003)(68736007)(53936002)(2201001)(97736004)(107886003)(66066001)(52116002)(25786009)(31696002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3642;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 14dilNlcHbnUMsuKdPRDcv4Ea2i4eTPw4Q5KLfMeK+4um4bKIUaW+2zmb2gQ/t8oMDpCqQdQiZBDaH/y5M8Sj1+0Sc1HJ/phQXMOJRKVyO/CUONEmV0S5CJS/N0/C8aSV3ETNgDcTHNmh0/oJe3crurImlJ/jEULtT3kqi14xkgcLjoU0Ayyya/WVyk0Rh01pyrMIYemuGJgnZqYW9aLyzefMJFqUD5PMfW/hED2QeurjfiH4SkcGjmn+BL/5gYIHlQ0YL9mkG5e0JPQXMUOvaJZUk/WYxM3JOrEel3w46I0sVOtigBmGa+dIPpcekM7nSnrBAN2ajogj0967GE1b7Qmz/NIWllGOWT2KJzrEh7DFijAKj5r3bN9rDxDl2mvPSwsRyIVlVDAuY1s1ytm3FqNoChcVE3ynjFzcwgDUuA=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <BE9D162515C6054582975C6CD4AB46E8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d83019-382d-4c4d-ed38-08d6bc2badd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 14:08:30.8190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3642
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.124
Subject: Re: [Qemu-devel] [PATCH v3 3/3] block/stream: introduce a bottom
 node
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
	"berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408140830.TrSfkspY_Uoq7YeV2cih4yzCGGh8E0wj3KEyhMc1HMQ@z>

MDUuMDQuMjAxOSAxOTo1NiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IFRoZSBib3R0b20g
bm9kZSBpcyB0aGUgaW50ZXJtZWRpYXRlIGJsb2NrIGRldmljZSB0aGF0IGhhcyB0aGUgYmFzZSBh
cyBpdHMNCj4gYmFja2luZyBpbWFnZS4gSXQgaXMgdXNlZCBpbnN0ZWFkIG9mIHRoZSBiYXNlIG5v
ZGUgd2hpbGUgYSBibG9jayBzdHJlYW0NCj4gam9iIGlzIHJ1bm5pbmcgdG8gYXZvaWQgZGVwZW5k
ZW5jeSBvbiB0aGUgYmFzZSB0aGF0IG1heSBjaGFuZ2UgZHVlIHRvIHRoZQ0KPiBwYXJhbGxlbCBq
b2JzLiBUaGUgY2hhbmdlIG1heSB0YWtlIHBsYWNlIGR1ZSB0byBhIGZpbHRlciBub2RlIGFzIHdl
bGwgdGhhdA0KPiBpcyBpbnNlcnRlZCBiZXR3ZWVuIHRoZSBiYXNlIGFuZCB0aGUgaW50ZXJtZWRp
YXRlIGJvdHRvbSBub2RlLiBJdCBvY2N1cnMNCj4gd2hlbiB0aGUgYmFzZSBub2RlIGlzIHRoZSB0
b3Agb25lIGZvciBhbm90aGVyIGNvbW1pdCBvciBzdHJlYW0gam9iLg0KPiBBZnRlciB0aGUgaW50
cm9kdWN0aW9uIG9mIHRoZSBib3R0b20gbm9kZSwgZG9uJ3QgZnJlZXplIGl0cyBiYWNraW5nIGNo
aWxkLA0KPiB0aGF0J3MgdGhlIGJhc2UsIGFueW1vcmUuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFZs
YWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1
b3p6by5jb20+DQo+IFJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2
c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+IC0tLQ0KPiAgIGJsb2NrL3N0cmVhbS5jICAgICAg
ICAgfCA1NiArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiAgIGJsb2NrL3RyYWNlLWV2ZW50cyAgICAgfCAgMiArLQ0KPiAgIHRlc3RzL3FlbXUtaW90
ZXN0cy8yNDUgfCAgNCArKy0tDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCsp
LCAyOSBkZWxldGlvbnMoLSkNCj4gDQoNClsuLl0NCg0KPiBAQCAtMjMyLDggKzIzMiwxMyBAQCB2
b2lkIHN0cmVhbV9zdGFydChjb25zdCBjaGFyICpqb2JfaWQsIEJsb2NrRHJpdmVyU3RhdGUgKmJz
LA0KPiAgICAgICBTdHJlYW1CbG9ja0pvYiAqczsNCj4gICAgICAgQmxvY2tEcml2ZXJTdGF0ZSAq
aXRlcjsNCj4gICAgICAgYm9vbCBic19yZWFkX29ubHk7DQo+ICsgICAgQmxvY2tEcml2ZXJTdGF0
ZSAqYm90dG9tID0gTlVMTDsNCg0KV2h5IHRvIHNldCBOVUxMPyB5b3UgY2FuIHNldCB0byBiZHJ2
X2ZpbmRfb3ZlcmxheSgpIGhlcmUuDQoNCj4gKyAgICBpbnQgYmFzaWNfZmxhZ3MgPSBCTEtfUEVS
TV9DT05TSVNURU5UX1JFQUQgfCBCTEtfUEVSTV9XUklURV9VTkNIQU5HRUQ7DQo+ICsNCj4gKyAg
ICAvKiBGaW5kIHRoZSBib3R0b20gbm9kZSB0aGF0IGhhcyB0aGUgYmFzZSBhcyBpdHMgYmFja2lu
ZyBpbWFnZSAqLw0KDQpJIGRvbid0IHRoaW5rIHdlIG5lZWQgY29tbWVudCwgYXMgaXQncyBleGFj
dGx5IHdoYXQgYmRydl9maW5kX292ZXJseSBkb2VzLg0KDQo+ICsgICAgYm90dG9tID0gYmRydl9m
aW5kX292ZXJsYXkoYnMsIGJhc2UpOw0KPiAgIA0KPiAtICAgIGlmIChiZHJ2X2ZyZWV6ZV9iYWNr
aW5nX2NoYWluKGJzLCBiYXNlLCBlcnJwKSA8IDApIHsNCj4gKyAgICBpZiAoYmRydl9mcmVlemVf
YmFja2luZ19jaGFpbihicywgYm90dG9tLCBlcnJwKSA8IDApIHsNCj4gICAgICAgICAgIHJldHVy
bjsNCj4gICAgICAgfQ0KPiAgIA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

