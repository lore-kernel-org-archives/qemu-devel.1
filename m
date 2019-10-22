Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66891CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 249422184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="v+1WKwcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249422184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMrKW-0004oP-61
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 06:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iMrIU-0002qE-WD
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iMrIT-00029h-Lc
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:21:50 -0400
Received: from mail-eopbgr140115.outbound.protection.outlook.com
 ([40.107.14.115]:63054 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iMrIP-000277-Eu; Tue, 22 Oct 2019 06:21:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tkm5FYgbegdPPSmPaOKHKXRY/WIuO3T7HQe2kvNKt3z9v+49Id+Yr4SspFDqBfYnlMylFdjUvZh9lyEm0Zu+D9qhcZXqth82kR2/pwIda1lX2PWOd0VwHR+ZRyAdz9LQ0ht7YNf5JjOLEprAawhchPxBKTdr7zMfLiJAndszxz5Nje1jfHLCopNvaHQzIh2lv5qc502kfJG/LCD0XJV7KG7ai6NR4CdrPt/croNvRLWSWrev98qgAegb5mSrun8x7T3kYb/A8dqn67yMKWp/3EQ+VsoPFMPg/ljDOI8smfkqH35/f+A6oCT6klWHRisbvnRgyfKdW+uRLqYy3o+VEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SDcnRGKlHZblgMakycjVDqo/sDjol3SNAwvB6lQBvg=;
 b=ZswBfyNPTEKgf5/OdY9nyfu6Sexlne+xnM1NQPubi2rl9/qt9E+o/UIgz5Hz9/MR0p4w0GWj0x0jASVNRT7fElzmILHW28K/EBfJ5KEr94uJgxFeaEhaKfHhrVMuZ+ILqWP709xtVW/vdBEuObiRaz5T3oONH4Zv2dh7aDQGoV0E1nYOO5zXp1fVleek3no0WExAkpPM5QSgX8rHL/wzNwa5eOqwOkMeOMDjGE22QMZJKvlRnBA8p6TOqYAiiXexQHCz/+/7K0SbQUPnz3L0BTI6qLlhoHQoneh2VF5+TANIxgaG42TiQuUOx7qTY0fji5qjrCOYB+g6F+1HExXlCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SDcnRGKlHZblgMakycjVDqo/sDjol3SNAwvB6lQBvg=;
 b=v+1WKwcnt8Ad4YDHN+KXSVTVSsI7CMsQ7aDPJhGZMDHsXw4DKPVmivdjRm9d0V2XR1qXMrGiDLoo+a5TVQKh89Vf+V7jPYhwWhW3LgxhHsUn6YB+Ze3hQZm67JHqq8bPptV+WCShwWTPqd/S7K576gCkSwP/LXcZXPRut+dNgBg=
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com (10.170.220.33) by
 DB6PR08MB2870.eurprd08.prod.outlook.com (10.175.232.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 22 Oct 2019 10:21:42 +0000
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b]) by DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b%4]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 10:21:41 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v5 1/4] block: support compressed write at generic layer
Thread-Topic: [PATCH v5 1/4] block: support compressed write at generic layer
Thread-Index: AQHVh4YxkyM0Azl4xEijX5NTK9vhK6dmZxIAgAAO3IA=
Date: Tue, 22 Oct 2019 10:21:41 +0000
Message-ID: <eece4ca2-7c40-cae6-b15f-beed73830fd8@virtuozzo.com>
References: <1571603828-185910-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1571603828-185910-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <408ef2ab-1f6c-2c9f-ad50-92269c20fb27@redhat.com>
In-Reply-To: <408ef2ab-1f6c-2c9f-ad50-92269c20fb27@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0376.eurprd05.prod.outlook.com
 (2603:10a6:7:94::35) To DB6PR08MB2757.eurprd08.prod.outlook.com
 (2603:10a6:6:18::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7f4c2c6-130a-4ede-156b-08d756d9a17a
x-ms-traffictypediagnostic: DB6PR08MB2870:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR08MB2870CA006ABABDDD9C8B0DEBF4680@DB6PR08MB2870.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(396003)(376002)(39840400004)(346002)(199004)(189003)(7736002)(6486002)(36756003)(64756008)(66446008)(110136005)(2201001)(66946007)(316002)(14444005)(31696002)(102836004)(229853002)(256004)(66476007)(66556008)(25786009)(305945005)(6436002)(52116002)(44832011)(2501003)(76176011)(54906003)(99286004)(31686004)(2906002)(8936002)(2616005)(11346002)(5660300002)(3846002)(4326008)(8676002)(81156014)(386003)(14454004)(6116002)(446003)(86362001)(6506007)(486006)(81166006)(107886003)(6246003)(478600001)(66066001)(71200400001)(71190400001)(26005)(53546011)(476003)(186003)(6512007)(41533002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR08MB2870;
 H:DB6PR08MB2757.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sNI4ji6xFmVovTJp1iaOhr+izd25udYrSCKFbvjxaMLvKDkuuYqlUuZz1C0g3HH6Fc2nzSzPyuF1BGFLNHQrvBfli7kgnPKaO7spJlVvE3X33Bnxxu7UHCNdqtJjO9zMQAllUQl02UijjokkZEF9iNgvsN7r+kN3hBGNQv3tG8QMEBHW0YGNRdCg8dq9RqS6nXw6hLKOzuc6JlWvecFJ646hGQtBASTga58MSha5scHhC0s36ExGw4H1D+7XSLFX/Wi5I6dNjKzagEGdaHRP1CWuOtXvredMJFsy9gDE7yCJ2G2CP+6tRo2GHIU/3qdqZeu7Ksdh3TLxhNueB8HXrvejCS3znpzGljagnhNUJrRLYM53pWlOwfliLKSiKX4119j9mY2nGEFRqPyAwHP+7I16hxPzYiK2d1DXECahtpipw2oo8f0Rty8zcVjxNlM3
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF89C88D37FA3B41B3A1658D02533753@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f4c2c6-130a-4ede-156b-08d756d9a17a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 10:21:41.4828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zkmUnQRWJKZ+VsbgnoJqYbLlSslYMktKUG6C/n/8uG3OJLFBOhw+2yHxnOSaPqJjv9m9hyZKZRbeuWC0dH/D7IqXNa49037NTw8p7/yZbgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2870
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.115
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQpPbiAyMi8xMC8yMDE5IDEyOjI4LCBNYXggUmVpdHogd3JvdGU6DQo+IE9uIDIwLjEwLjE5IDIy
OjM3LCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4+IFRvIGluZm9ybSB0aGUgYmxvY2sgbGF5
ZXIgYWJvdXQgd3JpdGluZyBhbGwgdGhlIGRhdGEgY29tcHJlc3NlZCwgd2UNCj4+IGludHJvZHVj
ZSB0aGUgJ2NvbXByZXNzJyBjb21tYW5kIGxpbmUgb3B0aW9uLiBCYXNlZCBvbiB0aGF0IG9wdGlv
biwgdGhlDQo+PiB3cml0dGVuIGRhdGEgd2lsbCBiZSBhbGlnbmVkIGJ5IHRoZSBjbHVzdGVyIHNp
emUgYXQgdGhlIGdlbmVyaWMgbGF5ZXIuDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBSb21hbiBLYWdh
biA8cmthZ2FuQHZpcnR1b3p6by5jb20+DQo+PiBTdWdnZXN0ZWQtYnk6IFZsYWRpbWlyIFNlbWVu
dHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IFNpZ25lZC1vZmYt
Ynk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0K
Pj4gUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZA
dmlydHVvenpvLmNvbT4NCj4+IC0tLQ0KPj4gICBibG9jay5jICAgICAgICAgICAgICAgICAgIHwg
MjAgKysrKysrKysrKysrKysrKysrKy0NCj4+ICAgYmxvY2svaW8uYyAgICAgICAgICAgICAgICB8
IDEzICsrKysrKysrKy0tLS0NCj4+ICAgYmxvY2svcWNvdzIuYyAgICAgICAgICAgICB8ICA0ICsr
KysNCj4+ICAgYmxvY2tkZXYuYyAgICAgICAgICAgICAgICB8ICA5ICsrKysrKysrLQ0KPj4gICBp
bmNsdWRlL2Jsb2NrL2Jsb2NrLmggICAgIHwgIDEgKw0KPj4gICBpbmNsdWRlL2Jsb2NrL2Jsb2Nr
X2ludC5oIHwgIDIgKysNCj4+ICAgcWFwaS9ibG9jay1jb3JlLmpzb24gICAgICB8ICA1ICsrKyst
DQo+PiAgIHFlbXUtb3B0aW9ucy5oeCAgICAgICAgICAgfCAgNiArKysrLS0NCj4+ICAgOCBmaWxl
cyBjaGFuZ2VkLCA1MSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4gVGhlIHBy
b2JsZW0gd2l0aCBjb21wcmVzc2lvbiBpcyB0aGF0IHRoZXJlIGFyZSBzdWNoIHRpZ2h0IGNvbnN0
cmFpbnRzIG9uDQo+IGl0IHRoYXQgaXQgY2FuIHJlYWxseSBvbmx5IHdvcmsgZm9yIHZlcnkgZGVm
aW5lZCB1c2UgY2FzZXMuICBUaG9zZQ0KPiBjb25zdHJhaW50cyBhcmU6DQo+IA0KPiAtIE9ubHkg
d3JpdGUgd2hvbGUgY2x1c3RlcnMsDQo+IC0gQ2x1c3RlcnMgY2FuIGJlIHdyaXR0ZW4gdG8gb25s
eSBvbmNlLg0KPiANCj4gVGhlIGZpcnN0IHBvaW50IGlzIGFkZHJlc3NlZCBpbiB0aGlzIHBhdGNo
IGJ5IHNldHRpbmcgcmVxdWVzdF9hbGlnbm1lbnQuDQo+ICAgQnV0IEkgZG9u4oCZdCBzZWUgaG93
IHRoZSBzZWNvbmQgb25lIGNhbiBiZSBhZGRyZXNzZWQuICBXZWxsLCBtYXliZSBieQ0KPiBhbGxv
d2luZyBpdCBpbiBhbGwgZHJpdmVycyB0aGF0IHN1cHBvcnQgY29tcHJlc3Npb24uICBCdXQgaWYg
SSBqdXN0IGxvb2sNCj4gYXQgcWNvdzIsIHRoYXQgaXNu4oCZdCBnb2luZyB0byBiZSB0cml2aWFs
OiBZb3UgbmVlZCB0byBhbGxvY2F0ZSBhDQo+IGNvbXBsZXRlbHkgbmV3IGNsdXN0ZXIgd2hlcmUg
eW91IHdyaXRlIHRoZSBkYXRhIChpbiBjYXNlIGl0IGdyb3dzKSwgYW5kDQo+IHRodXMgeW91IGxl
YXZlIGJlaGluZCBhIGhvbGUsIHdoaWNoIGtpbmQgb2YgZGVmZWF0cyB0aGUgcHVycG9zZSBvZg0K
PiBjb21wcmVzc2lvbi4NCj4gDQo+IChGb3IgZGVtb25zdHJhdGlvbjoNCj4gDQo+ICQgLi9xZW11
LWltZyBjcmVhdGUgLWYgcWNvdzIgdGVzdC5xY293MiA2NE0NCj4gRm9ybWF0dGluZyAndGVzdC5x
Y293MicsIGZtdD1xY293MiBzaXplPTY3MTA4ODY0IGNsdXN0ZXJfc2l6ZT02NTUzNg0KPiBsYXp5
X3JlZmNvdW50cz1vZmYgcmVmY291bnRfYml0cz0xNg0KPiAkIHg4Nl82NC1zb2Z0bW11L3FlbXUt
c3lzdGVtLXg4Nl82NCBcDQo+ICAgICAgLWJsb2NrZGV2ICJ7J25vZGUtbmFtZSc6ICdkcnYwJywg
J2RyaXZlcic6ICdxY293MicsDQo+ICAgICAgICAgICAgICAgICAgJ2NvbXByZXNzJzogdHJ1ZSwN
Cj4gICAgICAgICAgICAgICAgICAnZmlsZSc6IHsnZHJpdmVyJzogJ2ZpbGUnLCAnZmlsZW5hbWUn
OiAndGVzdC5xY293Mid9fSIgXA0KPiAgICAgIC1tb25pdG9yIHN0ZGlvDQo+IFFFTVUgNC4xLjUw
IG1vbml0b3IgLSB0eXBlICdoZWxwJyBmb3IgbW9yZSBpbmZvcm1hdGlvbg0KPiAocWVtdSkgcWVt
dS1pbyBkcnYwICJ3cml0ZSAtUCA0MiAwIDY0ayINCj4gd3JvdGUgNjU1MzYvNjU1MzYgYnl0ZXMg
YXQgb2Zmc2V0IDANCj4gNjQgS2lCLCAxIG9wczsgMDAuMDIgc2VjICg0LjA1NSBNaUIvc2VjIGFu
ZCA2NC44NzkzIG9wcy9zZWMpDQo+IChxZW11KSBxZW11LWlvIGRydjAgIndyaXRlIC1QIDIzIDAg
NjRrIg0KPiB3cml0ZSBmYWlsZWQ6IElucHV0L291dHB1dCBlcnJvcg0KPiANCj4gKQ0KPiANCj4g
Q29tcHJlc3Npb24gcmVhbGx5IG9ubHkgd29ya3Mgd2hlbiB5b3UgZnVsbHkgd3JpdGUgYWxsIG9m
IGFuIGltYWdlDQo+IGV4YWN0bHkgb25jZTsgaS5lLiBhcyB0aGUgcWVtdS1pbWcgY29udmVydCBv
ciBhcyBhIGJhY2t1cCB0YXJnZXQuICBGb3INCj4gYm90aCBjYXNlcyB3ZSBhbHJlYWR5IGhhdmUg
YSBjb21wcmVzc2lvbiBvcHRpb24uICBTbyBJ4oCZbSB3b25kZXJpbmcgd2hlcmUNCj4gdGhpcyBu
ZXcgb3B0aW9uIGlzIHJlYWxseSB1c2VmdWwuDQo+IA0KPiAoWW91IGRvIGFkZCBhIHRlc3QgZm9y
IHN0cmVhbSwgYnV0IEkgZG9u4oCZdCBrbm93IHdoZXRoZXIgdGhhdOKAmXMgcmVhbGx5IGENCj4g
Z29vZCBleGFtcGxlLCBzZWUgbXkgcmVzcG9uc2UgdGhlcmUuKQ0KPiANCj4gTWF4DQo+IA0KDQpU
aGFuayB5b3UgdmVyeSBtdWNoIE1heCBmb3IgeW91ciBkZXRhaWxlZCByZXNwb25zZS4NCg0KMSkg
WW91IGFyZSByaWdodCB0aGF0IGNvbXByZXNzaW9uIGlzIHVzZWQgd2l0aCB0aGUgYmFja3VwIG1v
c3RseS4gVGhlIA0Kb3B0aW9uIGZvciB0aGUgY29tcHJlc3Npb24gd2l0aCBiYWNrdXAgd291bGQg
YmUgcmVwbGFjZWQgYnkgdXNhZ2UgYXQgdGhlIA0KYmxvY2sgbGF5ZXIsIHdpdGggbm8gZHVwbGlj
YXRpb24uIEFsc28sIGl0IGNhbiBiZSB1c2VmdWwgZm9yIE5CRCBmb3IgDQppbnN0YW5jZSwNCg0K
JCAuL3FlbXUtaW1nIGNyZWF0ZSAtZiBxY293MiAtbyBzaXplPTEwRyAuL2ltYWdlLnFjb3cyDQok
IHN1ZG8gLi9xZW11LW5iZCAtYyAvZGV2L25iZDAgLi9pbWFnZS5xY293Mg0KJCBzdWRvIGRkIGlm
PS9kZXYvc2RhMSBvZj0vZGV2L25iZDAgYnM9MTBNIGNvdW50PTEwDQoxMCswIHJlY29yZHMgaW4N
CjEwKzAgcmVjb3JkcyBvdXQNCjEwNDg1NzYwMCBieXRlcyAoMTA1IE1CKSBjb3BpZWQsIDAsMDg5
MDU4MSBzLCAxLDIgR0Ivcw0KJCBzdWRvIC4vcWVtdS1uYmQgLWQgL2Rldi9uYmQwDQokIGR1IC1z
aCAuL2ltYWdlLnFjb3cyDQoxMDFNICAgIC4vaW1hZ2UucWNvdzINCg0KYW5kIHdpdGggdGhlIGNv
bXByZXNzaW9uDQoNCiQgLi9xZW11LWltZyBjcmVhdGUgLWYgcWNvdzIgLW8gc2l6ZT0xMEcgLi9p
bWFnZS5xY293Mg0KJCBzdWRvIC4vcWVtdS1uYmQgLUMgLWMgL2Rldi9uYmQwIC4vaW1hZ2UucWNv
dzINCiQgc3VkbyBkZCBpZj0vZGV2L3NkYTEgb2Y9L2Rldi9uYmQwIGJzPTEwTSBjb3VudD0xMA0K
MTArMCByZWNvcmRzIGluDQoxMCswIHJlY29yZHMgb3V0DQoxMDQ4NTc2MDAgYnl0ZXMgKDEwNSBN
QikgY29waWVkLCAwLDA3NjA0NiBzLCAxLDQgR0Ivcw0KJCBzdWRvIC4vcWVtdS1uYmQgLWQgL2Rl
di9uYmQwDQokIGR1IC1zaCAuL2ltYWdlLnFjb3cyDQo1LDNNICAgIC4vaW1hZ2UucWNvdzINCg0K
VGhlIGlkZWEgYmVoaW5kIGludHJvZHVjaW5nIHRoZSBuZXcgJ2NvbXByZXNzJyBvcHRpb24gaXMg
dG8gdXNlIHRoYXQgDQpvbmx5IG9uZSBpbnN0ZWFkIG9mIG1hbnkgb3RoZXIgb25lcyBvZiBzdWNo
IGEga2luZC4NCg0KMikgWW91IGFyZSByaWdodCBhbHNvIHRoYXQgIkNvbXByZXNzaW9uIGNhbid0
IG92ZXJ3cml0ZSBhbnl0aGluZy4uLiINCkl0IGNhbiBiZSBzZWVuIGluIHRoZSBjb21taXQgbWVz
c2FnZSANCmIwYjY4NjJlNWUxYTEzOTRlMGFiM2Q1ZGE5NGJhOGIwZGE4NjY0ZTINCg0KSSBhbSBu
b3Qgc3VyZSBpZiBkYXRhIHNob3VsZCBiZSB3cml0dGVuIGNvbXByZXNzZWQgdG8gdGhlIGFjdGl2
ZSBsYXllci4NCkkgbWFkZSB0aGUgdGVzdHMgd2l0aCB0aGUgaWRlYSBvZiBicmluZ2luZyBleGFt
cGxlcyBvZiB1c2FnZSB0aGUgDQonY29tcHJlc3MnIG9wdGlvbiBiZWNhdXNlIHBhc3NpbmcgYW4g
b3B0aW9uIGlzIGEgdHJpY2t5IHRoaW5nIGluIFFFTVUuDQpCdXQgdGhlIGlzc3VlIHRha2VzIHBs
YWNlIGFueXdheSBpZiB3ZSB3YW50IHRvIHJld3JpdGUgdG8gYWxsb2NhdGVkIA0KY2x1c3RlcnMu
DQpJIHdvdWxkIGxpa2UgdG8gaW52ZXN0aWdhdGUgdGhlIG1hdHRlciBhbmQgbWFrZSBhIHBhdGNo
IHRoYXQgcmVzb2x2ZXMgDQp0aGF0IGlzc3VlLg0KRG8geW91IGFncmVlIHdpdGggdGhhdD8NCg0K
QW5kcmV5DQotLSANCldpdGggdGhlIGJlc3QgcmVnYXJkcywNCkFuZHJleSBTaGlua2V2aWNoDQoN
Cg==

