Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603F5CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 14:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 261FF20659
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 14:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LDboAx82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261FF20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP5xL-0008If-9e
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 10:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iP5UP-0007pV-V7
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 09:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iP5UO-0001XE-OI
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 09:55:21 -0400
Received: from mail-eopbgr20113.outbound.protection.outlook.com
 ([40.107.2.113]:54449 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iP5UI-0001QV-FD; Mon, 28 Oct 2019 09:55:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5p5F3B2/yIQvwxavmcRRaraXLMFUkRlV8cNY+/sB8+B+IbR7l0/xbJDkSFfDONvmz/CM2UAZ5wHppTjoHNHk8BirofqERTcJMXOd6qC0xW6SUdhGq2NwHuPh5cW/rNNKA8oSCk4zta2le3NjiIkMFMusoiXp9JXBSHHfMEPNxpB3j3YEJDehL8Utn8VIOySyEZZgVfEP6PlaGA6nUxRyhDNPdgoIMH4Kzrt/hQJdfkS1JHqjtknBTDEhSIiJNesydf4DQDOmWzrRjUS9Nc7ULy6aegIIcMQtf1qJGOoJ2mW6G28NUeBAggPtB8U3gAwxEg89FEvViRsdq/jfeJeig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJ5aqpF1zbZT6eiI2n+ZyM1MG4frWZf9sdSsEfokSD0=;
 b=GiO5Djg4aHh1unFmapQKCM5DwiSh/v/vCRvr/AJ0eSD4WvgfEoDJaNf14hG8SqsDzo6YR549FrmNVP47zqgIbzGqdKm4p+OYZvdvjcphMJy+LpRh93S1zGAQ+4vunQf7Ne5BTV/6xe2CWaGy65KElN0tHGATUJgKMiNrn8cz8pNY998/ZZKUk/pu5GiWnOjAFQ+/cncaWcxDxSKe/XtMs7gvRd0+QAHzx1wUV9/ZZqasxZrVc97+d5tjvTy++gipOrbMhxxQkKPJAXyDAs/kcUvKFVKJCcqwFPXyvHawPmfUHq0UGhw1SVoIbsHXof8+O70ASOQw4NKnJnyKkNKvTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJ5aqpF1zbZT6eiI2n+ZyM1MG4frWZf9sdSsEfokSD0=;
 b=LDboAx82Dt1VjtJN17NWRIkOU4GnAOXh74qEb22CTbhek60YGdthflp5eupkDohaY8/IkHMB3jG+v74K3vB21mcoNWrMRTbfy3uEWq9mGv+mjSRkAGOSaL6dtKDiIJZVgQeIAyO4KQ4utIetnHEK0AnoLRc6TLiQHssxyE/XDRs=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB5235.eurprd08.prod.outlook.com (10.255.31.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Mon, 28 Oct 2019 13:55:11 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119%6]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 13:55:11 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH v2 02/26] qcow2: Split cluster_needs_cow() out of
 count_cow_clusters()
Thread-Topic: [RFC PATCH v2 02/26] qcow2: Split cluster_needs_cow() out of
 count_cow_clusters()
Thread-Index: AQHVjEP8ZqeQQjBQpUmKMJrUTwTVDKdwFhaA
Date: Mon, 28 Oct 2019 13:55:11 +0000
Message-ID: <53dc1ffa-36b7-b35d-0439-351b4b211657@virtuozzo.com>
References: <cover.1572125022.git.berto@igalia.com>
 <574b670e016379e8b4230b52d9b46c1d97d9486b.1572125022.git.berto@igalia.com>
In-Reply-To: <574b670e016379e8b4230b52d9b46c1d97d9486b.1572125022.git.berto@igalia.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0015.eurprd03.prod.outlook.com
 (2603:10a6:3:76::25) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191028165509011
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5214bef8-f341-46ec-0738-08d75bae735b
x-ms-traffictypediagnostic: AM0PR08MB5235:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB52352E344EA8B27644D82755C1660@AM0PR08MB5235.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(376002)(346002)(396003)(39840400004)(189003)(199004)(476003)(66556008)(2616005)(25786009)(446003)(66476007)(8676002)(64756008)(386003)(66946007)(26005)(54906003)(2906002)(6506007)(52116002)(76176011)(66066001)(478600001)(66446008)(81156014)(2501003)(102836004)(99286004)(186003)(8936002)(81166006)(71200400001)(31696002)(305945005)(6436002)(86362001)(7736002)(6486002)(256004)(3846002)(6512007)(71190400001)(31686004)(11346002)(5660300002)(229853002)(6246003)(4326008)(36756003)(6116002)(107886003)(316002)(486006)(110136005)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5235;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cCQ3skp016oVZdLP6/Y6pxleStP2Le04+et/jmcAH6GoQ0TZ8zZQT4CslAqb36zqCLIbTa5oTqgJ68J8fRiQHbgsDIbrr0nTAbciZxzj1mm3kOJzEXmBM46RERe5Sg2JaGRuSySmgaaYkMdEmxS7bI6C41tOBu1h0zQpAceTnQXaWm6XTdHUojzeKTDD6axksLYeLTMOushD4D2yGxKXhqGedZgrYxtOAIVYheRF0cE1wKp44oa+/OWkc7KNhxDTKM6FbQKFZWD3W/ddIHatu2Jho1z86tNkLjAywThNoeVjyhkdxENUJ8O+3UNRARvBKmM/+2bNxDhmtsqD1KKorOAMllmLWb3VqyyAo7vxZp9LKBuWEbXFyBXYZIj3nzWfZv9gM4CXWMTZ+fy4sH/gLX5mUr2ZA/st/4dPsrCb3TnVJAViED87kl0w/h0y9/1m
Content-Type: text/plain; charset="utf-8"
Content-ID: <262E3BF3291F344C8D84FEBB133303ED@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5214bef8-f341-46ec-0738-08d75bae735b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 13:55:11.5936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z1QN9hK0y709UHOgwv6gXnb+Kg3P7ffN0JCHC6fcGlMI85MwmvKVradh98sBQRRj2AzkvfxcnhUlFro/+WBPcc36+AZHiHOQ9GSu247r8mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5235
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.113
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjcuMTAuMjAxOSAwOjI1LCBBbGJlcnRvIEdhcmNpYSB3cm90ZToNCj4gV2UgYXJlIGdvaW5nIHRv
IG5lZWQgaXQgaW4gb3RoZXIgcGxhY2VzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxiZXJ0byBH
YXJjaWEgPGJlcnRvQGlnYWxpYS5jb20+DQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292
LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQo+IC0tLQ0KPiAgIGJsb2Nr
L3Fjb3cyLWNsdXN0ZXIuYyB8IDM0ICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0N
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svcWNvdzItY2x1c3Rlci5jIGIvYmxvY2svcWNvdzItY2x1
c3Rlci5jDQo+IGluZGV4IDZjMWRjZGM3ODEuLmFhMTAxMGE1MTUgMTAwNjQ0DQo+IC0tLSBhL2Js
b2NrL3Fjb3cyLWNsdXN0ZXIuYw0KPiArKysgYi9ibG9jay9xY293Mi1jbHVzdGVyLmMNCj4gQEAg
LTEwNjgsNiArMTA2OCwyNCBAQCBzdGF0aWMgdm9pZCBjYWxjdWxhdGVfbDJfbWV0YShCbG9ja0Ry
aXZlclN0YXRlICpicywgdWludDY0X3QgaG9zdF9vZmZzZXQsDQo+ICAgICAgIFFMSVNUX0lOU0VS
VF9IRUFEKCZzLT5jbHVzdGVyX2FsbG9jcywgKm0sIG5leHRfaW5fZmxpZ2h0KTsNCj4gICB9DQo+
ICAgDQo+ICsvKiBSZXR1cm5zIHRydWUgaWYgd3JpdGluZyB0byBhIGNsdXN0ZXIgcmVxdWlyZXMg
Q09XICovDQo+ICtzdGF0aWMgYm9vbCBjbHVzdGVyX25lZWRzX2NvdyhCbG9ja0RyaXZlclN0YXRl
ICpicywgdWludDY0X3QgbDJfZW50cnkpDQo+ICt7DQo+ICsgICAgc3dpdGNoIChxY293Ml9nZXRf
Y2x1c3Rlcl90eXBlKGJzLCBsMl9lbnRyeSkpIHsNCj4gKyAgICBjYXNlIFFDT1cyX0NMVVNURVJf
Tk9STUFMOg0KPiArICAgICAgICBpZiAobDJfZW50cnkgJiBRQ09XX09GTEFHX0NPUElFRCkgew0K
PiArICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiArICAgICAgICB9DQo+ICsgICAgY2FzZSBR
Q09XMl9DTFVTVEVSX1VOQUxMT0NBVEVEOg0KPiArICAgIGNhc2UgUUNPVzJfQ0xVU1RFUl9DT01Q
UkVTU0VEOg0KPiArICAgIGNhc2UgUUNPVzJfQ0xVU1RFUl9aRVJPX1BMQUlOOg0KPiArICAgIGNh
c2UgUUNPVzJfQ0xVU1RFUl9aRVJPX0FMTE9DOg0KPiArICAgICAgICByZXR1cm4gdHJ1ZTsNCj4g
KyAgICBkZWZhdWx0Og0KPiArICAgICAgICBhYm9ydCgpOw0KPiArICAgIH0NCj4gK30NCg0KTm90
IHN1cmUgaG93IG11Y2ggaXMgaXQgYmV0dGVyIHRoYW4ganVzdA0KcmV0dXJuICEocWNvdzJfZ2V0
X2NsdXN0ZXJfdHlwZShicywgbDJfZW50cnkpID09IFFDT1cyX0NMVVNURVJfTk9STUFMICYmIChs
Ml9lbnRyeSAmIFFDT1dfT0ZMQUdfQ09QSUVEKSk7DQoNCj4gKw0KPiAgIC8qDQo+ICAgICogUmV0
dXJucyB0aGUgbnVtYmVyIG9mIGNvbnRpZ3VvdXMgY2x1c3RlcnMgdGhhdCBjYW4gYmUgdXNlZCBm
b3IgYW4gYWxsb2NhdGluZw0KPiAgICAqIHdyaXRlLCBidXQgcmVxdWlyZSBDT1cgdG8gYmUgcGVy
Zm9ybWVkICh0aGlzIGluY2x1ZGVzIHlldCB1bmFsbG9jYXRlZCBzcGFjZSwNCj4gQEAgLTEwODAs
MjUgKzEwOTgsMTEgQEAgc3RhdGljIGludCBjb3VudF9jb3dfY2x1c3RlcnMoQmxvY2tEcml2ZXJT
dGF0ZSAqYnMsIGludCBuYl9jbHVzdGVycywNCj4gICANCj4gICAgICAgZm9yIChpID0gMDsgaSA8
IG5iX2NsdXN0ZXJzOyBpKyspIHsNCj4gICAgICAgICAgIHVpbnQ2NF90IGwyX2VudHJ5ID0gYmU2
NF90b19jcHUobDJfc2xpY2VbbDJfaW5kZXggKyBpXSk7DQo+IC0gICAgICAgIFFDb3cyQ2x1c3Rl
clR5cGUgY2x1c3Rlcl90eXBlID0gcWNvdzJfZ2V0X2NsdXN0ZXJfdHlwZShicywgbDJfZW50cnkp
Ow0KPiAtDQo+IC0gICAgICAgIHN3aXRjaChjbHVzdGVyX3R5cGUpIHsNCj4gLSAgICAgICAgY2Fz
ZSBRQ09XMl9DTFVTVEVSX05PUk1BTDoNCj4gLSAgICAgICAgICAgIGlmIChsMl9lbnRyeSAmIFFD
T1dfT0ZMQUdfQ09QSUVEKSB7DQo+IC0gICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+IC0gICAg
ICAgICAgICB9DQo+ICsgICAgICAgIGlmICghY2x1c3Rlcl9uZWVkc19jb3coYnMsIGwyX2VudHJ5
KSkgew0KPiAgICAgICAgICAgICAgIGJyZWFrOw0KPiAtICAgICAgICBjYXNlIFFDT1cyX0NMVVNU
RVJfVU5BTExPQ0FURUQ6DQo+IC0gICAgICAgIGNhc2UgUUNPVzJfQ0xVU1RFUl9DT01QUkVTU0VE
Og0KPiAtICAgICAgICBjYXNlIFFDT1cyX0NMVVNURVJfWkVST19QTEFJTjoNCj4gLSAgICAgICAg
Y2FzZSBRQ09XMl9DTFVTVEVSX1pFUk9fQUxMT0M6DQo+IC0gICAgICAgICAgICBicmVhazsNCj4g
LSAgICAgICAgZGVmYXVsdDoNCj4gLSAgICAgICAgICAgIGFib3J0KCk7DQo+ICAgICAgICAgICB9
DQo+ICAgICAgIH0NCj4gICANCj4gLW91dDoNCj4gICAgICAgYXNzZXJ0KGkgPD0gbmJfY2x1c3Rl
cnMpOw0KPiAgICAgICByZXR1cm4gaTsNCj4gICB9DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRz
LA0KVmxhZGltaXINCg==

