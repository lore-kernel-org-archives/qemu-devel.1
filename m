Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F078C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE712086D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="W9EMIcxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE712086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv2GV-000602-8g
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 12:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45400)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hv2G0-00059k-LF
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hv2Fz-00014M-FH
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:24:16 -0400
Received: from mail-he1eur04on0727.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::727]:22139
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hv2Fw-000100-KI; Tue, 06 Aug 2019 12:24:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zx0u2q6dFlHuShGy0byLf30ksjDi3vQZf3G/YnGcPbZd8jJVvS39yM9xVNNGFMx/BLfcnVklOyEo3cB4sjc0i5+WCwY5Yd53ZZcQDYqMej31FL4pILK/esnEAPhQAXrygcSy9gHdUkQ3RJdhRFBhLrab2BwWsmVPOPC9HTHgqKGbkjEAnkPUKgHClHFKAvIXOZQ4Y4oBUmn2H2SxBbX/zccL2mPZreQGRakYHfpLGIcgbsEBe4SAqp2PPDWjtIGJrllojYTJLeaIAaQa07/JIUZjh6Y74rt2YFWRAQx2c7tz1J+I673VwCXdeZuOXLiIABukP8/qbbRRYkWcSkbWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CN+R4F0iD35tFPQi4PDUOcAiTiiCcdx9Wc773GSJVGQ=;
 b=mPBbx9D/hpOPzaHNrfp41X6at/D2It5h9FiofvyHl7nHK+2xwjl/QlxcndrBUi1FoAOPl64McOq4FTFjAwXyMbqZxmcrYHAgOLJlMSvQhG6XDe0KL/q95aKFigCTMY5POe8wGi9Vh9iYrGJyS/H8u1W9/x7azOIp4mc8BP0aGuP5ErMmgV+D3E7WN/tQdDOw+Bkvx5gKlnDQiyL+zX8tA6AypKyoRSBb7/BuqrstxO9diGQCOO/vhZDEw1Xo2pLUVwUph3L8OX0opue6QHQrxC+0YYDoQddeY4E7SS9wmpQKJreJqtRJe5ZzQe21PS7FAoeAnvs6kZrEJo5040TKwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CN+R4F0iD35tFPQi4PDUOcAiTiiCcdx9Wc773GSJVGQ=;
 b=W9EMIcxAPx0OL12oYUhrKmU71eki381jS3ekxSmRb3pBccjUZN3aCTQFi24/q2zpul+EvNbs8tQPDdQHlAJqu+NfUj4BSAMpGlb3porBj1q7ibj2YTig+1RvX4Vg7p20m+G40/ZuNNLY9ahoF0jGJPcWUL5Vux3GT9GyZzvPdYw=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB2701.eurprd08.prod.outlook.com (10.175.245.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.15; Tue, 6 Aug 2019 16:24:09 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7%6]) with mapi id 15.20.2157.011; Tue, 6 Aug 2019
 16:24:09 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 0/6] Allow Valgrind checking all QEMU processes
Thread-Index: AQHVPk9Lhke4f+HMAkaliwaZTYueBKbuah0A
Date: Tue, 6 Aug 2019 16:24:08 +0000
Message-ID: <635c7365-3c05-c8ff-c5a3-061c7be1badd@virtuozzo.com>
References: <1563553816-148827-1-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1563553816-148827-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0256.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::32) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5439d2d5-98b8-4b96-93d2-08d71a8a8213
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB2701; 
x-ms-traffictypediagnostic: VI1PR08MB2701:
x-microsoft-antispam-prvs: <VI1PR08MB2701CB217B47A7E0141881F2F4D50@VI1PR08MB2701.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(366004)(376002)(396003)(39850400004)(189003)(199004)(66476007)(229853002)(66946007)(64756008)(6116002)(2501003)(86362001)(6506007)(66556008)(76176011)(31686004)(2906002)(14454004)(66446008)(305945005)(81166006)(81156014)(8676002)(3846002)(386003)(36756003)(53546011)(8936002)(7736002)(6436002)(99286004)(186003)(110136005)(54906003)(316002)(44832011)(4326008)(486006)(476003)(2616005)(25786009)(53936002)(31696002)(68736007)(11346002)(446003)(6246003)(6512007)(5660300002)(102836004)(26005)(478600001)(52116002)(66066001)(107886003)(6486002)(71200400001)(256004)(14444005)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB2701;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ayt5Dp+5+lE4wMFN8leyYt+qapwR3fZyRlr3ev9IBkzNNqB6d9AzXFnMt5FDj40jAZDc06S/f8362R0mFZeQklnEOfENlO3/SoDdCqH53r9Mlej4njLkwKjybhHpdVtie1/4e0tlLHkNLLa1ai6tY5WJztyixG6nzoZ+CSBa/1bZebSdANz9iX8Pf4/rhvhwZpp/dU/R1lnZPGvjkdx7UnJbBXsbc49siohhnVQqgwJipkYERIJwg+XCoatAsJ6icQceP9dbJz0xFVQiMZiE5o4xh4+GUXInRw9AdFDHMDcXzTvvVWfNozE2meCQRLSuIUzK5Q40cpHVLg8Pyux0hD9/04mKLXgOf+72uT0fJoAhn+xybksOJMlD1TZ1tDFQ+34fTuYadx1x8RArY4PZuhhanTv3Byq97djSag6XfGg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03430DA6A483F148AACADDEDBD6AE63A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5439d2d5-98b8-4b96-93d2-08d71a8a8213
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 16:24:08.8253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KAWJ6/JbN8iaGHyk5xi6ZKYueILFcAqNLfAldgMpm/YeITl+iu19YmGDFT2U6le6jYBhWuKHuJFdduB5CZSKWF9JZOzBCi2M9scurvyonPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2701
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0d::727
Subject: Re: [Qemu-devel] [PATCH v5 0/6] Allow Valgrind checking all QEMU
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UElOR0lORy4uLg0KDQpPbiAxOS8wNy8yMDE5IDE5OjMwLCBBbmRyZXkgU2hpbmtldmljaCB3cm90
ZToNCj4gSW4gdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gb2YgdGhlIFFFTVUgYmFzaCBpb3Rl
c3RzLCBvbmx5IHFlbXUtaW8NCj4gcHJvY2Vzc2VzIG1heSBiZSBydW4gdW5kZXIgdGhlIFZhbGdy
aW5kLCB3aGljaCBpcyBhIHVzZWZ1bCB0b29sIGZvcg0KPiBmaW5kaW5nIG1lbW9yeSB1c2FnZSBp
c3N1ZXMuIExldCdzIGFsbG93IHRoZSBjb21tb24ucmMgYmFzaCBzY3JpcHQNCj4gcnVuaW5nIGFs
bCB0aGUgUUVNVSBwcm9jZXNzZXMsIHN1Y2ggYXMgcWVtdS1rdm0sIHFlbXUtaW1nLCBxZW11LW5k
Yg0KPiBhbmQgcWVtdS12eGhzLCB1bmRlciB0aGUgVmFsZ3JpbmQgdG9vbC4NCj4gDQo+IHY1Og0K
PiAgICAwMTogVGhlIHBhdGNoICJibG9jay9uYmQ6IE5CRFJlcGx5IGlzIHVzZWQgYmVpbmcgdW5p
bml0aWFsaXplZCIgd2FzIGRldGFjaGVkDQo+ICAgICAgICBhbmQgdGFrZW4gaW50byBhY2NvdW50
IGluIHRoZSBwYXRjaCAibmJkOiBJbml0aWFsaXplIHJlcGx5IG9uIGZhaWx1cmUiDQo+ICAgICAg
ICBieSBFcmljIEJsYWtlLg0KPiANCj4gdjQ6DQo+ICAgIDAxOiBUaGUgcGF0Y2ggImlvdGVzdHM6
IFNldCByZWFkLXplcm9lcyBvbiBpbiBudWxsIGJsb2NrIGRyaXZlciBmb3IgVmFsZ3JpbmQiDQo+
ICAgICAgICB3YXMgZXh0ZW5kZWQgd2l0aCBuZXcgY2FzZXMgYW5kIGlzc3VlZCBhcyBhIHNlcGFy
YXRlIHNlcmllcy4NCj4gICAgMDI6IFRoZSBuZXcgcGF0Y2ggImJsb2NrL25iZDogTkJEUmVwbHkg
aXMgdXNlZCBiZWluZyB1bmluaXRpYWxpemVkIiB3YXMNCj4gICAgICAgIGFkZGVkIHRvIHJlc29s
dmUgdGhlIGZhaWx1cmUgb2YgdGhlIGlvdGVzdCAwODMgcnVuIHVuZGVyIFZhbGdyaW5kLg0KPiAN
Cj4gdjM6DQo+ICAgIDAxOiBUaGUgbmV3IGZ1bmN0aW9uIF9jYXNlbm90cnVuKCkgd2FzIGFkZGVk
IHRvIHRoZSBjb21tb24ucmMgYmFzaA0KPiAgICAgICAgc2NyaXB0IHRvIG5vdGlmeSB0aGUgdXNl
ciBvZiB0ZXN0IGNhc2VzIGRyb3BwZWQgZm9yIHNvbWUgcmVhc29uLg0KPiAgICAgICAgU3VnZ2Vz
dGVkIGJ5IEtldmluLg0KPiAgICAgICAgUGFydGljdWxhcmx5LCB0aGUgbm90aWZpY2F0aW9uIGFi
b3V0IHRoZSBub25leGlzdGVudCBUTVBESVIgaW4NCj4gICAgICAgIHRoZSB0ZXN0IDA1MSB3YXMg
YWRkZWQgKG5vdGljZWQgYnkgVmxhZGltaXIpLg0KPiAgICAwMjogVGhlIHRpbWVvdXQgaW4gc29t
ZSB0ZXN0IGNhc2VzIHdhcyBleHRlbmRlZCBmb3IgVmFsZ3JpbmQgYmVjYXVzZQ0KPiAgICAgICAg
aXQgZGlmZmVycyB3aGVuIHJ1bm5pbmcgb24gdGhlIHJhbWRpc2suDQo+ICAgIDAzOiBEdWUgdG8g
dGhlIGNvbW1vbi5uYmQgc2NyaXB0IGhhcyBiZWVuIGNoYW5nZWQgd2l0aCB0aGUgY29tbWl0DQo+
ICAgICAgICBiMjhmNTgyYywgdGhlIHBhdGNoICJpb3Rlc3RzOiBhbWVuZCBRRU1VIE5CRCBwcm9j
ZXNzIHN5bmNocm9uaXphdGlvbiINCj4gICAgICAgIGlzIGFjdHVhbCBubyBtb3JlLiBOb3RlIHRo
YXQgUUVNVV9OQkQgaXMgbGF1bmNoZWQgaW4gdGhlIGJhc2ggbmVzdGVkDQo+ICAgICAgICBzaGVs
bCBpbiB0aGUgX3FlbXVfbmJkX3dyYXBwZXIoKSBhcyBpdCB3YXMgYmVmb3JlIGluIGNvbW1vbi5y
Yy4NCj4gICAgMDQ6IFRoZSBwYXRjaCAiaW90ZXN0czogbmV3IGZpbGUgdG8gc3VwcHJlc3MgVmFs
Z3JpbmQgZXJyb3JzIiB3YXMgZHJvcHBlZA0KPiAgICAgICAgZHVlIHRvIG15IHN1cGVyZmljaWFs
IHVuZGVyc3RhbmRpbmcgb2YgdGhlIHdvcmsgb2YgdGhlIGZ1bmN0aW9uDQo+ICAgICAgICBibGtf
cHJlYWRfdW50aHJvdHRsZWQoKS4gU3BlY2lhbCB0aGFua3MgdG8gS2V2aW4gd2hvIHNoZWQgdGhl
IGxpZ2h0DQo+ICAgICAgICBvbiB0aGUgbnVsbCBibG9jayBkcml2ZXIgaW52b2x2ZWQuIE5vdywg
dGhlIHBhcmFtZXRlciAncmVhZC16ZXJvZXM9b24nDQo+ICAgICAgICBpcyBwYXNzZWQgdG8gdGhl
IG51bGwgYmxvY2sgZHJpdmVyIHRvIGluaXRpYWxpemUgdGhlIGJ1ZmZlciBpbiB0aGUNCj4gICAg
ICAgIGZ1bmN0aW9uIGd1ZXNzX2Rpc2tfbGNocygpIHRoYXQgdGhlIFZhbGdyaW5kIHdhcyBjb21w
bGFpbmluZyB0by4NCj4gDQo+IHYyOg0KPiAgICAwMTogVGhlIHBhdGNoIDIvNyBvZiB2MSB3YXMg
bWVyZ2VkIGludG8gdGhlIHBhdGNoIDEvNywgc3VnZ2VzdGVkIGJ5IERhbmllbC4NCj4gICAgMDI6
IEFub3RoZXIgcGF0Y2ggNy83IHdhcyBhZGRlZCB0byBpbnRyb2R1Y2UgdGhlIFZhbGdyaW5kIGVy
cm9yIHN1cHByZXNzaW9uDQo+ICAgICAgICBmaWxlIGludG8gdGhlIFFFTVUgcHJvamVjdC4NCj4g
ICAgRGlzY3Vzc2VkIGluIHRoZSBlbWFpbCB0aHJlYWQgd2l0aCB0aGUgbWVzc2FnZSBJRDoNCj4g
ICAgPDE1NjAyNzYxMzEtNjgzMjQzLTEtZ2l0LXNlbmQtZW1haWwtYW5kcmV5LnNoaW5rZXZpY2hA
dmlydHVvenpvLmNvbT4NCj4gDQo+IEFuZHJleSBTaGlua2V2aWNoICg2KToNCj4gICAgaW90ZXN0
czogYWxsb3cgVmFsZ3JpbmQgY2hlY2tpbmcgYWxsIFFFTVUgcHJvY2Vzc2VzDQo+ICAgIGlvdGVz
dHM6IGV4Y2x1ZGUga2lsbGVkIHByb2Nlc3NlcyBmcm9tIHJ1bm5pbmcgdW5kZXIgIFZhbGdyaW5k
DQo+ICAgIGlvdGVzdHM6IEFkZCBjYXNlbm90cnVuIHJlcG9ydCB0byBiYXNoIHRlc3RzDQo+ICAg
IGlvdGVzdHM6IFZhbGdyaW5kIGZhaWxzIHdpdGggbm9uZXhpc3RlbnQgZGlyZWN0b3J5DQo+ICAg
IGlvdGVzdHM6IGV4dGVuZGVkIHRpbWVvdXQgdW5kZXIgVmFsZ3JpbmQNCj4gICAgaW90ZXN0czog
ZXh0ZW5kIHNsZWVwaW5nIHRpbWUgdW5kZXIgVmFsZ3JpbmQNCj4gDQo+ICAgdGVzdHMvcWVtdS1p
b3Rlc3RzLzAyOCAgICAgICB8ICA2ICsrKy0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMDM5ICAg
ICAgIHwgIDUgKysrDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzAzOS5vdXQgICB8IDMwICsrKy0t
LS0tLS0tLS0tLS0tDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzA1MSAgICAgICB8ICA0ICsrKw0K
PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8wNjEgICAgICAgfCAgMiArKw0KPiAgIHRlc3RzL3FlbXUt
aW90ZXN0cy8wNjEub3V0ICAgfCAxMiArKy0tLS0tDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzEz
NyAgICAgICB8ICAxICsNCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMTM3Lm91dCAgIHwgIDYgKy0t
LQ0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8xODMgICAgICAgfCAgOSArKysrKy0NCj4gICB0ZXN0
cy9xZW11LWlvdGVzdHMvMTkyICAgICAgIHwgIDYgKysrLQ0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0
cy8yNDcgICAgICAgfCAgNiArKystDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzL2NvbW1vbi5yYyB8
IDc2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ICAgMTIg
ZmlsZXMgY2hhbmdlZCwgMTAxIGluc2VydGlvbnMoKyksIDYyIGRlbGV0aW9ucygtKQ0KPiANCg0K
LS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K

