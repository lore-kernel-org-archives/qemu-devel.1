Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D5DC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 12:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79DA24C0B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 12:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OewkWCgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79DA24C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51794 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY8nV-00058M-5N
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 08:44:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hY8mY-0004ee-2P
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 08:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hY8mW-0006D8-Vz
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 08:43:14 -0400
Received: from mail-eopbgr130138.outbound.protection.outlook.com
	([40.107.13.138]:64899
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hY8mT-00068q-PH; Tue, 04 Jun 2019 08:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=p0yQYzm53Bi4Xozsg493LTXgJtkN61Cjx9PxKuQbsWY=;
	b=OewkWCginKeRaR2omM6M8qhcmKb+6l8jmA3y/nEzGfflJ8FaXdI4v++7/Nt0YKN3FTz5wjst1o03EYYE93y4PrFPSZm80IptuyiaqlErDssLSBM/z4o3AFx1tWAFpXIgh4s3UpjaDe0G3hux0pSDcvu/zytFYZ/KHuDkjrvbqRw=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB3011.eurprd08.prod.outlook.com (52.134.92.160) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.22; Tue, 4 Jun 2019 12:42:51 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8]) by
	AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1965.011;
	Tue, 4 Jun 2019 12:42:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: ping Re: [PATCH v6 0/7] NBD reconnect
Thread-Index: AQHU8IvOCpyInqV0y0qAbRG9faO+L6aLxO8A
Date: Tue, 4 Jun 2019 12:42:51 +0000
Message-ID: <90495089-7d05-e127-837f-4207d802231d@virtuozzo.com>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190411172709.205032-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0135.eurprd06.prod.outlook.com
	(2603:10a6:7:16::22) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190604154248789
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdf8ad12-dde5-44c1-8189-08d6e8ea27df
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR08MB3011; 
x-ms-traffictypediagnostic: AM0PR08MB3011:
x-microsoft-antispam-prvs: <AM0PR08MB30112E22828A1C2FC725521BC1150@AM0PR08MB3011.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(366004)(136003)(346002)(39850400004)(396003)(189003)(199004)(76176011)(73956011)(86362001)(14444005)(256004)(81156014)(31686004)(305945005)(81166006)(66556008)(102836004)(66476007)(8676002)(107886003)(25786009)(71190400001)(68736007)(6506007)(386003)(5024004)(64756008)(71200400001)(186003)(36756003)(31696002)(26005)(2501003)(478600001)(66446008)(8936002)(99286004)(66946007)(316002)(446003)(14454004)(7736002)(66066001)(53936002)(6486002)(2906002)(4326008)(3846002)(476003)(6436002)(11346002)(54906003)(6116002)(2616005)(6512007)(52116002)(5660300002)(110136005)(486006);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3011;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zKNip792OIi2d0v6YJ/MWErh0uc9secYOjM9K6rbFwIaVaEJZ/RbHGxXXxuP+xx1sLgPuzec2mYt79DKrM5w/85Lg5XYpQdE+El85M/0UDx7kJbjBIx7zlVeWIaEo2WLFiOSSJZtjUbx8akqMq/XdxIBbJJwFdfIQL4JVa5cdeYpJdpcWIEjvmhvLP4TDlRWworfBEQsE9AuuHkfR1WP4VtU6aLj4RxD8aJ0e8M5zU9lue+aEtMzG0BTbtoVQegCImB4VneWsGH5+zvSLO2CIHlXBFalS9aFzxPKOCYL/295hd/LuH9t57y+cwYyPOk38xxrQOJivPSQ/ZIgQ4kfqOf7R579FNv/I3xo6cnyZjePQyEuHYT9PZUh5aS+CAn+5vhTbVAVZt7gzvpVKecp7WhokTIBt6Uok/7TRZMq2mw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DCC5167D50F084F91076FB2583AD284@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf8ad12-dde5-44c1-8189-08d6e8ea27df
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 12:42:51.1332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3011
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.138
Subject: [Qemu-devel] ping Re: [PATCH v6 0/7] NBD reconnect
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
	"armbru@redhat.com" <armbru@redhat.com>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cGluZw0KDQoxMS4wNC4yMDE5IDIwOjI3LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiBIZXJlIGlzIE5CRCByZWNvbm5lY3QuIFByZXZpb3VzbHksIGlmIGNvbm5lY3Rpb24g
ZmFpbGVkIGFsbCBjdXJyZW50DQo+IGFuZCBmdXR1cmUgcmVxdWVzdHMgd2lsbCBmYWlsLiBBZnRl
ciB0aGUgc2VyaWVzLCBuYmQtY2xpZW50IGRyaXZlcg0KPiB3aWxsIHRyeSB0byByZWNvbm5lY3Qg
dW5saW1pdGVkIHRpbWVzLiBEdXJpbmcgZmlyc3QgQHJlY29ubmVjdC1kZWxheQ0KPiBzZWNvbmRz
IG9mIHJlY29ubmVjdGluZyBhbGwgcmVxdWVzdHMgd2lsbCB3YWl0IGZvciB0aGUgY29ubmVjdGlv
biwNCj4gYW5kIGlmIGl0IGlzIGVzdGFibGlzaGVkIHJlcXVlc3RzIHdpbGwgYmUgcmVzZW50LiBB
ZnRlcg0KPiBAcmVjb25uZWN0LWRlbGF5IHBlcmlvZCBhbGwgcmVxdWVzdHMgd2lsbCBiZSBmYWls
ZWQgKHVudGlsIHN1Y2Nlc3NmdWwNCj4gcmVjb25uZWN0KS4NCj4gDQo+IHY0LT52NjoNCj4gICAo
c29tZSBwcmVwYXJpbmcgcGF0Y2hlcyBmcm9tIHY0IHdhcyBtZXJnZWQgYXMgdjUpDQo+IDAxOiBu
ZXcNCj4gMDI6IG5ldw0KPiAwMzogLSBkcm9wIHVudXNlZCB0aGluZ3MNCj4gICAgICAgICAtIGZ1
dHVyZSBzdGF0ZXMNCj4gICAgICAgICAtIGZ1dHVyZSBzL2JyZWFrL2NvbnRpbnVlLw0KPiAwNDog
LSBmaXggdHlwb3MNCj4gICAgICAtIHMvMy4xLzQuMS8NCj4gICAgICAtIHNldCAwIGFzIGRlZmF1
bHQNCj4gMDU6IG5ldw0KPiAwNjogLSBuZXcgc3RhdGVzIGFuZCBzL2JyZWFrL2NvbnRpbnVlLyBt
b3ZlZCBoZXJlIGZyb20gMDMNCj4gICAgICAtIGRyb3AgTkJEQ2xpZW50U2Vzc2lvbi5yZWNlaXZp
bmcsIGFzIG5vdyBpbl9mbGlnaHQNCj4gICAgICAgIHJlcXVlc3RzIHVzZWQgaW5zdHJlYWQNCj4g
ICAgICAtIGFkZCBjb3B5cmlnaHQNCj4gICAgICAtIGdvIHRvIE5CRF9DTElFTlRfQ09OTkVDVElO
R19OT1dBSVQgaW1tZWRpYXRlbHkgaWYNCj4gICAgICAgIHJlY29ubmVjdF9kZWxheSBpcyAwIChz
bywgcmVjb25uZWN0X2RlbGF5IG1vdmVkIHRvDQo+ICAgICAgICBOQkRDbGllbnRTZXNzaW9uKQ0K
PiAgICAgIC0gb24gY2xvc2UsIGRvIHFlbXVfY29fc2xlZXBfd2FrZShjbGllbnQtPmNvbm5lY3Rp
b25fY28pLA0KPiAgICAgICAgdG8gbm90IHdhaXQgZm9yIHJlY29ubmVjdCBsb29wIGl0ZXJhdGlv
bg0KPiAgICAgIC0gaGFuZGxlIHN0YXRlIHRyYW5zaXRpb24gdG8gUVVJVCBkdXJpbmcgcmVjb25u
ZWN0IGxvb3ANCj4gICAgICAgIChhc3NlcnQobmJkX2NsaWVudF9jb25uZWN0aW5nKHMpKSB3YXMg
YmFkIGlkZWEpDQo+ICAgICAgLSBkb24ndCB0cnkgdG8gZmFpbCBvbiBwcm90b2NvbCBlcnJvcnMg
YWZ0ZXINCj4gICAgICAgIG5iZF9jbGllbnRfY29ubmVjdCwgYXMgd2UgY2FuJ3QgZGlzdGluZ3Vp
c2ggdGhlbQ0KPiAgICAgIC0gZGVjcmVtZW50IGluX2ZsaWdodCBhcm91bmQgcmVjb25uZWN0IHNs
ZWVwIHRvIG1ha2UNCj4gICAgICAgIGl0IHBvc3NpYmxlIHRvIGRyYWluIGFuZCBleGl0IGR1cmlu
ZyBpdA0KPiAgICAgICAgKHY0IHdhcyBiYXNlZCBvbiBzb21ldGhpbmcgYmVmb3JlIGluX2ZsaWdo
dCBsb2dpYw0KPiAgICAgICAgIGludHJvZHVjZWQgaW50byBuYmQtY2xpZW50KQ0KPiAgICAgIC0g
Y2hhbmdlZCBsb2dpYyBpbiBuYmRfY2xpZW50X2F0dGFjaF9haW9fY29udGV4dA0KPiAwNzogLSBy
ZWZhY3RvciwgdXNpbmcgbG9nIGFuZCBxbXBfbG9nDQo+ICAgICAgLSBkcm9wIGV4cG9ydCBuYW1l
DQo+ICAgICAgLSBkcm9wIHN0cmFuZ2UgdHJ5L2V4Y2VwdA0KPiAgICAgIC0gYWRkIHJlY29ubmVj
dC1kZWxheSBvcHRpb24gKGFzIDAgaXMgYSBkZWZhdWx0IG5vdykNCj4gDQo+IA0KPiBWbGFkaW1p
ciBTZW1lbnRzb3YtT2dpZXZza2l5ICg3KToNCj4gICAgYmxvY2svbmJkLWNsaWVudDogc3BsaXQg
Y29ubmVjdGlvbl9jbyBzdGFydCBvdXQgb2YgbmJkX2NsaWVudF9jb25uZWN0DQo+ICAgIGJsb2Nr
L25iZC1jbGllbnQ6IHVzZSBub24tYmxvY2tpbmcgaW8gY2hhbm5lbCBmb3IgbmJkIG5lZ290aWF0
aW9uDQo+ICAgIGJsb2NrL25iZC1jbGllbnQ6IG1vdmUgZnJvbSBxdWl0IHRvIHN0YXRlDQo+ICAg
IGJsb2NrL25iZDogYWRkIGNtZGxpbmUgYW5kIHFhcGkgcGFyYW1ldGVyIHJlY29ubmVjdC1kZWxh
eQ0KPiAgICBxZW11LWNvcm91dGluZS1zbGVlcDogaW50cm9kdWNlIHFlbXVfY29fc2xlZXBfd2Fr
ZQ0KPiAgICBibG9jay9uYmQtY2xpZW50OiBuYmQgcmVjb25uZWN0DQo+ICAgIGlvdGVzdHM6IHRl
c3QgbmJkIHJlY29ubmVjdA0KPiANCj4gICBxYXBpL2Jsb2NrLWNvcmUuanNvbiAgICAgICAgICB8
ICAxMiArLQ0KPiAgIGJsb2NrL25iZC1jbGllbnQuaCAgICAgICAgICAgIHwgIDE1ICstDQo+ICAg
aW5jbHVkZS9ibG9jay9uYmQuaCAgICAgICAgICAgfCAgIDMgKy0NCj4gICBpbmNsdWRlL3FlbXUv
Y29yb3V0aW5lLmggICAgICB8ICAgNiArDQo+ICAgYmxvY2svbmJkLWNsaWVudC5jICAgICAgICAg
ICAgfCA0MTYgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiAgIGJsb2NrL25i
ZC5jICAgICAgICAgICAgICAgICAgIHwgIDE2ICstDQo+ICAgbmJkL2NsaWVudC5jICAgICAgICAg
ICAgICAgICAgfCAgMTYgKy0NCj4gICBxZW11LW5iZC5jICAgICAgICAgICAgICAgICAgICB8ICAg
MiArLQ0KPiAgIHV0aWwvcWVtdS1jb3JvdXRpbmUtc2xlZXAuYyAgIHwgIDIwICstDQo+ICAgdGVz
dHMvcWVtdS1pb3Rlc3RzLzI0OSAgICAgICAgfCAgNjMgKysrKysNCj4gICB0ZXN0cy9xZW11LWlv
dGVzdHMvMjQ5Lm91dCAgICB8ICAxMCArDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwICAg
ICAgfCAgIDEgKw0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy9pb3Rlc3RzLnB5IHwgICA0ICsNCj4g
ICAxMyBmaWxlcyBjaGFuZ2VkLCA0NjggaW5zZXJ0aW9ucygrKSwgMTE2IGRlbGV0aW9ucygtKQ0K
PiAgIGNyZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0cy9xZW11LWlvdGVzdHMvMjQ5DQo+ICAgY3JlYXRl
IG1vZGUgMTAwNjQ0IHRlc3RzL3FlbXUtaW90ZXN0cy8yNDkub3V0DQo+IA0KDQoNCi0tIA0KQmVz
dCByZWdhcmRzLA0KVmxhZGltaXINCg==

