Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84222C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 08:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 372F821670
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 08:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MbkvruI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372F821670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41768 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLOXG-0001jx-Ht
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 04:54:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hLOWM-0001KK-P9
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hLOWL-0007l8-GZ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:53:50 -0400
Received: from mail-eopbgr90124.outbound.protection.outlook.com
	([40.107.9.124]:50653
	helo=FRA01-MR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hLOWH-0007je-Pm; Tue, 30 Apr 2019 04:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=TG1YVNUg75CLlGH4rOSxFpBu2ln+4N1Xu2KQjI8Xud4=;
	b=MbkvruI39R0xp0/6H6MOAPryVMQlbzx3zULMbbEEIV6H60UlPpfRHYXTNT7DKb7xxiWPGFOJ6RZEDzB3nyadsog5reRuFkC661BNXzz6nzUFagm5L6OFiawO+v6VQpXIM1D0d/1mTt5jI4h0a1b0YO9GwEJwegMPltOswc53EKQ=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4891.eurprd08.prod.outlook.com (52.133.110.78) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.13; Tue, 30 Apr 2019 08:53:41 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1%3]) with mapi id 15.20.1835.018;
	Tue, 30 Apr 2019 08:53:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 01/10] tests/perf: Test qemu-img convert from raw to
	encrypted qcow2
Thread-Index: AQHU6WoBU4I5tQ5Ba0SEjmz95GnkXqZSWBcAgAI5fYA=
Date: Tue, 30 Apr 2019 08:53:41 +0000
Message-ID: <8e928f60-f2b2-6e05-bf16-5578941bfd8b@virtuozzo.com>
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
	<20190402153730.54145-2-vsementsov@virtuozzo.com>
	<fe340a80-f918-7999-fb75-4b129162bd89@redhat.com>
In-Reply-To: <fe340a80-f918-7999-fb75-4b129162bd89@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0075.eurprd07.prod.outlook.com
	(2603:10a6:3:64::19) To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190430115339139
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 654c5399-14a5-4d7e-2e8f-08d6cd4957ec
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4891; 
x-ms-traffictypediagnostic: PR2PR08MB4891:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <PR2PR08MB48914E6C4CD2FFD46189B947C13A0@PR2PR08MB4891.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(136003)(366004)(346002)(39840400004)(376002)(189003)(199004)(51914003)(64756008)(68736007)(97736004)(86362001)(66476007)(4326008)(102836004)(2501003)(7736002)(186003)(99286004)(36756003)(26005)(25786009)(66066001)(3846002)(2201001)(66446008)(66946007)(76176011)(6116002)(229853002)(73956011)(71200400001)(71190400001)(31696002)(6486002)(8676002)(81166006)(256004)(81156014)(66556008)(6306002)(2906002)(316002)(6512007)(6436002)(14454004)(8936002)(6506007)(386003)(5660300002)(53936002)(2616005)(305945005)(446003)(53546011)(11346002)(476003)(6246003)(52116002)(54906003)(31686004)(478600001)(486006)(110136005)(2004002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4891;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tUSDLVuvHHgZLJ4uihTHPXC18sx5/KhqkHdsU4emyX+Azh67NoBQlfMjO2A/aVGUcpHzA7ZE6q7zJ7NsQMC0HNn4SlKmsgC0QDbj2PXA2akeUJFN4lYAwCIp3faRa9KWqgnKMkfx4gsuPojis0fYuGVjizS0doP3V89rDL3P4ZJKC3R6alRE6z1OvavWnxjGKnj4ek1oyV1647BJh/gQ0WBXuTwlsUu5vH4Bi3yTtCQS7aupltmBlBpQfoEC6bD/z/VVODorpjXwZI/Jz7yyd6CZbXNSOE6EOCfP7E5/xgcgur9xfNEh5FMYClwHJNXhUKAYQjow9P6gewPfQ2E4qJrv6/nlJ19D2rnS1Pa7VzQQ21vuqlYWKWmIU9mIFxS4QWv1utKGHiWn8sCEQduNPglfTKFzNpBC1hXlzNGUsg4=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <E7BFF8061BD00942A3BC910F2401377C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 654c5399-14a5-4d7e-2e8f-08d6cd4957ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 08:53:41.3358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4891
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.9.124
Subject: Re: [Qemu-devel] [PATCH v5 01/10] tests/perf: Test qemu-img convert
 from raw to encrypted qcow2
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430085341.IeKQNMZxYJge7LhfbYMTjbw4xjDBG2N66t33-PmsIQc@z>

MjkuMDQuMjAxOSAxOjU1LCBNYXggUmVpdHogd3JvdGU6DQo+IE9uIDAyLjA0LjE5IDE3OjM3LCBW
bGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gU2lnbmVkLW9mZi1ieTogVmxh
ZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4g
LS0tDQo+PiAgIHRlc3RzL3BlcmYvYmxvY2svcWNvdzIvY29udmVydC10by1lbmNyeXB0ZWQgfCA0
OCArKysrKysrKysrKysrKysrKysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDQ4IGluc2VydGlv
bnMoKykNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL3BlcmYvYmxvY2svcWNvdzIvY29u
dmVydC10by1lbmNyeXB0ZWQNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHRlc3QgY2FzZSwgYnV0IEkg
ZG9u4oCZdCBrbm93IHdoZXRoZXIgdGhpcyBpcyB0aGUgcmlnaHQgd2F5DQo+IHRvIGluY2x1ZGUg
aXQuDQo+IA0KPiBBIGNvbmNyZXRlIHByb2JsZW0gaXMgdGhhdCBpdCBkb2VzbuKAmXQgd29yayB3
aXRoIG91dC1vZi10cmVlIGJ1aWxkcyAoSQ0KPiBvbmx5IGRvIG91dC1vZi10cmVlIGJ1aWxkcyku
ICBJIHdvbmRlciB3aGV0aGVyIGl0IHdvdWxkIGJlIHBvc3NpYmxlIGFuZA0KPiBtYWtlIHNlbnNl
IChJIGhhdmUgbm8gaWRlYSkgdG8gYWRkIGEgc3ViZGlyZWN0b3J5ICJwZXJmIiB0byB0aGUgaW90
ZXN0cw0KPiBhbmQgcmV1c2UgaXRzIGluZnJhc3RydWN0dXJlPyAgVGhvc2UgdGVzdHMgd291bGRu
4oCZdCBydW4gYnkgZGVmYXVsdC4NCj4gDQoNCkhvbmVzdGx5LCBJIGRvbid0IHJlYWxseSBsaWtl
IGV4aXN0aW5nIGlvdGVzdHMgaW5mcmFzdHJ1Y3R1cmUsIGJvdW5kIHRvIGNoZWNrDQpzY3JpcHQs
IHdoaWNoIEkgZG9uJ3QgbGlrZSB0b28gKGFuZCBhbnkgb3RoZXIgbGFyZ2Ugc2NyaXB0IGluIGJh
c2gsIHNvcnJ5IDooLi4NCg0KV2hhdCBkbyB5b3UgbWVhbj8gWW91IGhhdmUgZW52IHZhcmlhYmxl
cyBRRU1VX0lNRywgZXRjLCBhbmQgd2FudCB0aGVtIHRvIGJlDQphY2NlcHRlZCBieSBzY3JpcHQ/
DQoNCkknZCBwcmVmZXIgdG8gY29tbWl0IHNvbWV0aGluZyBzaW1wbGUgYW5kIHNlcGFyYXRlLCB0
byBiZSBhYmxlIHRvIGJ1aWxkIHVwDQppbmZyYXN0cnVjdHVyZSBhcm91bmQgaXQgZ3JhZHVhbGx5
Li4gRmluYWxseSwgSSB3YW50IGEgc2ltcGxlIHdheSB0byBydW4NCmEgc2V0IG9mIHBlcmYgdGVz
dHMgb24gYSBzZXQgb2YgZ2l0IGNvbW1pdHMgYW5kIGdldCBhbiBodG1sIGFuZCBhc2NpaQ0KdGFi
bGVzIG9mIHBlcmZvcm1hbmNlIGNvbXBhcmlzb24gYmV0d2VlbiB0aGVzZSBjb21taXRzLg0KDQo+
IA0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3BlcmYvYmxvY2svcWNvdzIvY29udmVydC10by1lbmNy
eXB0ZWQgYi90ZXN0cy9wZXJmL2Jsb2NrL3Fjb3cyL2NvbnZlcnQtdG8tZW5jcnlwdGVkDQo+PiBu
ZXcgZmlsZSBtb2RlIDEwMDc1NQ0KPj4gaW5kZXggMDAwMDAwMDAwMC4uN2E2YjdiMWNhYg0KPj4g
LS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvdGVzdHMvcGVyZi9ibG9jay9xY293Mi9jb252ZXJ0LXRv
LWVuY3J5cHRlZA0KPj4gQEAgLTAsMCArMSw0OCBAQA0KPj4gKyMhL2Jpbi9iYXNoDQo+PiArIw0K
Pj4gKyMgVGVzdCBxZW11LWltZyBjb252ZXJ0IGZyb20gcmF3IHRvIGVuY3J5cHRlZCBxY293Mg0K
Pj4gKyMNCj4+ICsjIENvcHlyaWdodCAoYykgMjAxOSBWaXJ0dW96em8gSW50ZXJuYXRpb25hbCBH
bWJILiBBbGwgcmlnaHRzIHJlc2VydmVkLg0KPj4gKyMNCj4+ICsjIFRoaXMgcHJvZ3JhbSBpcyBm
cmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5DQo+PiAr
IyBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFz
IHB1Ymxpc2hlZCBieQ0KPj4gKyMgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVy
IHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3INCj4+ICsjIChhdCB5b3VyIG9wdGlvbikgYW55
IGxhdGVyIHZlcnNpb24uDQo+PiArIw0KPj4gKyMgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVk
IGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsDQo+PiArIyBidXQgV0lUSE9VVCBB
TlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZg0KPj4gKyMg
TUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2Vl
IHRoZQ0KPj4gKyMgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4N
Cj4+ICsjDQo+PiArIyBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZQ0KPj4gKyMgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW0uICBJ
ZiBub3QsIHNlZSA8aHR0cDovL3d3dy5nbnUub3JnL2xpY2Vuc2VzLz4uDQo+PiArIw0KPj4gKw0K
Pj4gK2lmIFsgIiQjIiAtbHQgMiBdOyB0aGVuDQo+PiArICAgIGVjaG8gIlVzYWdlOiAkMCBTT1VS
Q0VfRklMRSBERVNUSU5BVElPTl9GSUxFIFthZGRpdGlvbmFsIHFlbXUtaW1nIGNvbnZlcnQgcGFy
YW1ldGVyc10iDQo+PiArICAgIGV4aXQgMQ0KPj4gK2ZpDQo+PiArDQo+PiArUk9PVF9ESVI9IiQo
IGNkICIkKCBkaXJuYW1lICIke0JBU0hfU09VUkNFWzBdfSIgKS8uLi8uLi8uLi8uLiIgPi9kZXYv
bnVsbCAyPiYxICYmIHB3ZCApIg0KPj4gK1FFTVVfSU1HPSIkUk9PVF9ESVIvcWVtdS1pbWciDQo+
PiArUUVNVV9JTz0iJFJPT1RfRElSL3FlbXUtaW8iDQo+PiArDQo+PiArc2l6ZT0xRw0KPj4gKw0K
Pj4gK3NyYz0iJDEiDQo+PiArc2hpZnQNCj4+ICsNCj4+ICtkc3Q9IiQxIg0KPj4gK3NoaWZ0DQo+
PiArDQo+PiArKA0KPj4gKyMgY3JlYXRlIHNvdXJjZQ0KPj4gKyRRRU1VX0lNRyBjcmVhdGUgLWYg
cmF3ICIkc3JjIiAkc2l6ZQ0KPj4gKyRRRU1VX0lPIC1mIHJhdyAtYyAid3JpdGUgLVAgMHhhIDAg
JHNpemUiICIkc3JjIg0KPj4gKw0KPj4gKyMgY3JlYXRlIHRhcmdldA0KPj4gKyRRRU1VX0lNRyBj
cmVhdGUgLWYgcWNvdzIgLS1vYmplY3Qgc2VjcmV0LGlkPXNlYzAsZGF0YT10ZXN0IC1vIGVuY3J5
cHQuZm9ybWF0PWx1a3MsZW5jcnlwdC5rZXktc2VjcmV0PXNlYzAgIiRkc3QiICRzaXplDQo+PiAr
KSA+IC9kZXYvbnVsbA0KPj4gKw0KPj4gKyMgdGVzdCB3aXRoIGFkZGl0aW9uYWwgcGFyYW1ldGVy
cyBsZWZ0IGluICRADQo+PiArL3Vzci9iaW4vdGltZSAtZiAlZSAkUUVNVV9JTUcgY29udmVydCAi
JEAiIC1mIHJhdyAtLW9iamVjdCBzZWNyZXQsaWQ9c2VjMCxkYXRhPXRlc3QgLS10YXJnZXQtaW1h
Z2Utb3B0cyAtbiAiJHNyYyIgImRyaXZlcj1xY293MixmaWxlLmZpbGVuYW1lPSRkc3QsZW5jcnlw
dC5rZXktc2VjcmV0PXNlYzAiDQo+Pg0KPiANCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpW
bGFkaW1pcg0K

