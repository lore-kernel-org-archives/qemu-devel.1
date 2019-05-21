Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8DEC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 07:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 592C3216B7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 07:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Uzh2nY4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592C3216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48395 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSzYu-0003L6-GE
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 03:51:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hSzXw-0002vC-Gl
	for qemu-devel@nongnu.org; Tue, 21 May 2019 03:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hSzXv-0004b1-Dy
	for qemu-devel@nongnu.org; Tue, 21 May 2019 03:50:52 -0400
Received: from mail-eopbgr140095.outbound.protection.outlook.com
	([40.107.14.95]:5378
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hSzXs-0004ZH-Fb; Tue, 21 May 2019 03:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=WX8a0xOHWUq7Omag+tpeNn5cyC5WAkEF1ChdlGmGJ8A=;
	b=Uzh2nY4Lj9TwerZqNu9Oz+ICmxheCtMTfFLUalqgoHuEUL32BVRmQWawNuqpuNDDzlx/us0KAnIiLlYxNdUDkQvsLDPzJr7SmLy/7aFzOY7jVMJWTUrskTouRVHusyB6MWuIuffFGUB/RXHJWXQ6ZGSifYZQwaAg1lcfVQTAazc=
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com (10.255.96.78) by
	AM6PR08MB4487.eurprd08.prod.outlook.com (20.179.18.20) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.16; Tue, 21 May 2019 07:50:43 +0000
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1]) by
	AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1%6]) with mapi id 15.20.1878.024;
	Tue, 21 May 2019 07:50:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: ping Re: [PATCH v2 for 4.1 0/2] avoid lseek on block_status
Thread-Index: AQHU7ifR38W67XMkcUq/V5mfMlS/raZ1d3UA
Date: Tue, 21 May 2019 07:50:43 +0000
Message-ID: <f72915e7-8734-6230-0f89-8ac0e943b45b@virtuozzo.com>
References: <20190408162617.258535-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190408162617.258535-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0011.EURP189.PROD.OUTLOOK.COM
	(2603:10a6:3:8b::21) To AM6PR08MB4675.eurprd08.prod.outlook.com
	(2603:10a6:20b:c2::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190521105040389
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8c82310-9eb6-440d-2d1a-08d6ddc10640
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB4487; 
x-ms-traffictypediagnostic: AM6PR08MB4487:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR08MB4487527AB445DAB59C827257C1070@AM6PR08MB4487.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(366004)(39850400004)(346002)(396003)(376002)(199004)(189003)(66946007)(71200400001)(71190400001)(966005)(76176011)(52116002)(73956011)(99286004)(102836004)(36756003)(7736002)(66556008)(478600001)(68736007)(6486002)(256004)(6506007)(386003)(66446008)(64756008)(66476007)(31686004)(305945005)(54906003)(8676002)(31696002)(81166006)(5660300002)(110136005)(81156014)(2616005)(53936002)(476003)(11346002)(107886003)(86362001)(4326008)(446003)(8936002)(6116002)(3846002)(486006)(316002)(6436002)(2906002)(2501003)(6512007)(14454004)(66066001)(6306002)(25786009)(186003)(26005);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4487;
	H:AM6PR08MB4675.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gqFZMSOSqFDBr9Fxl9nSeDbp3JH/ZaZyvv5S6EOuc5OFrYgdnHc/ZYX2nWbkgn3nn5EOQfLLrFj/UrlMZSp23jTOAHsKDkuNKHvzrV4e4YWSyNxxjLvnYbZyK+JyOV+hJaHX2GFc51bWhytTMl9qy6szFVaTvggNbUBlhqP6k8dJzhuoeiFP1l1AqBUwBnUc55TKGHpTIFYN3RtcXdrKfneOxQYVo5qNkZ6xB16VPWmrCZM/6YOg9mp5cOr8WZkz25f3DjvK3JZnnLGN3rtyUK9+lVXMvPW8QxNt41IhMIZFKKVo/VWAwnDK4n8ZrXFIWhe0nauy+rzc4KiUxCIbwfL133L81foJzJLEHNL7PodEk9ou1E2PlO+2dxg6iPztSi2rc5H1A0TFrLDjkMhvWTscmAK0BQ8URQ+QuBD3uDk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6170AB56AFB85D4B9AA5D93F7E5CE2F5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c82310-9eb6-440d-2d1a-08d6ddc10640
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 07:50:43.6611 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4487
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.95
Subject: [Qemu-devel] ping Re: [PATCH v2 for 4.1 0/2] avoid lseek on
 block_status
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
	Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cGluZw0KDQowOC4wNC4yMDE5IDE5OjI2LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiBIaSENCj4gDQo+IEl0J3MgYSBjb250aW51YXRpb24gZm9yDQo+ICJbUEFUQ0hdIHFj
b3cyOiBhdm9pZCBsc2VlayBvbiBibG9ja19zdGF0dXMgaWYgcG9zc2libGUiDQo+IGh0dHBzOi8v
bGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE5LTAxL21zZzA2NTk4Lmh0
bWwNCj4gDQo+IHBlcmZvcm1hbmNlIHJlc3VsdHMgZm9yIGJsb2NrLXN0YXR1cyBvbiB0bXBmcyBb
dGVzdHMgb3JpZ2luYWxseSBieSBLZXZpbiwNCj4gbm93IHRoZXkgYXJlIGluIDAxXToNCj4gDQo+
IC4vdGVzdHMvcGVyZi9ibG9jay9xY293Mi9jb252ZXJ0LWJsb2Nrc3RhdHVzIC9yYW1kaXNrL3gN
Cj4gDQo+IGFmdGVyIDAxOg0KPiANCj4gcGxhaW46IDgxLjc3DQo+IGZvcndhcmQ6IDgyLjYxDQo+
IHByZWFsbG9jOiAwLjAxDQo+IA0KPiBhZnRlciAwMjoNCj4gDQo+IHBsYWluOiAwLjEyDQo+IGZv
cndhcmQ6IDAuMTINCj4gcHJlYWxsb2M6IDAuMDENCj4gDQo+IHYyOg0KPiAgIDAxOiBuZXcNCj4g
ICAwMjogW21vc3RseSBieSBLZXZpbidzIGNvbW1lbnRzXQ0KPiAgICAgICAtIHJld3JpdHRlbiB0
byBnbyB0aHJvdWdoIG5ldyBmbGFnIEJEUlZfQkxPQ0tfUkVDVVJTRQ0KPiAgICAgICAtIG5ldmVy
IHJldHJ5IGRldGVjdGlvbiBpZiBmYWlsZWQgZm9yIGZpcnN0IHRpbWUNCj4gICAgICAgLSByZXdy
aXRlIGRldGVjdGlvbiB0byBkbyBsZXNzIGl0ZXJhdGlvbnMgYW5kIHRvIGJlIG1vcmUgc2ltcGxl
DQo+IA0KPiAgICAgICBpb3Rlc3RzIDEwMiBiZWhhdmlvciBjaGFuZ2VkIFthbmQgbm90IHN1cmUg
YWJvdXQgb3RoZXIgdHdvIG9uZXMNCj4gICAgICAgaW4gY29tcGFyaXNvbiB3aXRoIHYxLCBidXQg
aXQgc2VlbXMgaXQgZG9lc24ndCBtYXR0ZXJdDQo+IA0KPiAgICAgICBhbHNvLCBwYXRjaCBzdWJq
ZWN0IGNoYW5nZWQsIGFzIG5vdyBpdCdzIGEgZ2VuZXJpYyBjaGFuZ2UgZm9yDQo+ICAgICAgIGJs
b2NrIGxheWVyDQo+IA0KPiANCj4gVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSAoMik6DQo+
ICAgIHRlc3RzL3BlcmY6IFRlc3QgbHNlZWsgaW5mbHVlbmNlIG9uIHFjb3cyIGJsb2NrLXN0YXR1
cw0KPiAgICBibG9jazogYXZvaWQgcmVjdXJzaXZlIGJsb2NrX3N0YXR1cyBjYWxsIGlmIHBvc3Np
YmxlDQo+IA0KPiAgIGJsb2NrL3Fjb3cyLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICA0ICsrDQo+ICAgaW5jbHVkZS9ibG9jay9ibG9jay5oICAgICAgICAgICAgICAgICAgICAgIHwg
IDggKystDQo+ICAgYmxvY2svaW8uYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDkgKystDQo+ICAgYmxvY2svcWNvdzItcmVmY291bnQuYyAgICAgICAgICAgICAgICAgICAgIHwg
MzIgKysrKysrKysrKw0KPiAgIGJsb2NrL3Fjb3cyLmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8IDExICsrKysNCj4gICB0ZXN0cy9wZXJmL2Jsb2NrL3Fjb3cyL2NvbnZlcnQtYmxvY2tz
dGF0dXMgfCA3MSArKysrKysrKysrKysrKysrKysrKysrDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3Rz
LzEwMiAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMv
MTAyLm91dCAgICAgICAgICAgICAgICAgfCAgMyArLQ0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8x
NDEub3V0ICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzE0
NC5vdXQgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gICAxMCBmaWxlcyBjaGFuZ2VkLCAxMzgg
aW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gICBjcmVhdGUgbW9kZSAxMDA3NTUgdGVz
dHMvcGVyZi9ibG9jay9xY293Mi9jb252ZXJ0LWJsb2Nrc3RhdHVzDQo+IA0KDQoNCi0tIA0KQmVz
dCByZWdhcmRzLA0KVmxhZGltaXINCg==

