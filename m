Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4682C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 09:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9841A20815
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 09:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="V2n8nJgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9841A20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33748 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQpx2-0007Ok-Lx
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 05:11:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hQpvN-0006DP-T0
	for qemu-devel@nongnu.org; Wed, 15 May 2019 05:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hQppJ-0002o0-6B
	for qemu-devel@nongnu.org; Wed, 15 May 2019 05:03:54 -0400
Received: from mail-eopbgr30125.outbound.protection.outlook.com
	([40.107.3.125]:33822
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hQppE-00026x-JA; Wed, 15 May 2019 05:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=p0yQYzm53Bi4Xozsg493LTXgJtkN61Cjx9PxKuQbsWY=;
	b=V2n8nJgUSGcSwRgWt7kGWdaadupN4C+P7rpaUHPzdvwIndq7TYvsAoaGxOtE29vveE/36UuZ5Nu1tsdrzH+g6cHpw83DejszP+Dw407NgAlvMRh5kIC2El1UNBsYoKDfKobiIPrMczcrYG2qXqPz5QO6vwLozTC/jHkFjNQmh0k=
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com (10.255.96.78) by
	AM6PR08MB4053.eurprd08.prod.outlook.com (20.179.1.143) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1878.22; Wed, 15 May 2019 09:03:07 +0000
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1]) by
	AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1%6]) with mapi id 15.20.1878.024;
	Wed, 15 May 2019 09:03:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: ping Re: [PATCH v6 0/7] NBD reconnect
Thread-Index: AQHU8IvOCpyInqV0y0qAbRG9faO+L6ZsGOoA
Date: Wed, 15 May 2019 09:03:07 +0000
Message-ID: <424835e8-aee2-c148-77af-01b2fa229146@virtuozzo.com>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190411172709.205032-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0297.eurprd05.prod.outlook.com
	(2603:10a6:7:93::28) To AM6PR08MB4675.eurprd08.prod.outlook.com
	(2603:10a6:20b:c2::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190515120304759
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a038d8ac-ebb7-4f92-359f-08d6d9142564
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB4053; 
x-ms-traffictypediagnostic: AM6PR08MB4053:
x-microsoft-antispam-prvs: <AM6PR08MB405360B8CC24A774C2BA418DC1090@AM6PR08MB4053.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(396003)(376002)(366004)(346002)(136003)(189003)(199004)(68736007)(6116002)(81166006)(81156014)(8676002)(3846002)(305945005)(7736002)(8936002)(478600001)(6512007)(6486002)(71190400001)(316002)(71200400001)(6436002)(53936002)(4326008)(31696002)(25786009)(86362001)(107886003)(2906002)(2501003)(2616005)(486006)(11346002)(446003)(476003)(52116002)(386003)(6506007)(186003)(76176011)(66556008)(66446008)(64756008)(73956011)(66476007)(102836004)(110136005)(66946007)(54906003)(26005)(66066001)(31686004)(99286004)(14454004)(14444005)(5024004)(5660300002)(256004)(36756003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4053;
	H:AM6PR08MB4675.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dXQf0Y3GqRj48+pvweXyzRzSX2onjXW84pdRVQINyx3K/2jBg/q9YG+BhvK6lzMdh6fBQXIofSs9x6yc/8iVi8WW7yyhEg64cWJYzwrl9lK+yTKdHDN5tXIN6V5Vy6qN1MUR997LMftVQK9NtjQgOYD03kKPYt88pHGkAguRQoKJwWF9VBoGUrzYbvRyxPPC4XtmyiLFl5x75ZnllfABYaamoARk+IswKdNIHGBFj9Xd5OYJDg6kTY2uXLSsDopsmzLcgtJnjLt0x7T8aJ/A7SyMg7vHngBuRunCU74YOqKg+b8cx7wiIjL+g7YnOl619UlaBeuZeRow/OlxlheObo1LNnOLwjCERkAEWRsHXRE+cYVpOWkI2PvqDVviXFOgi9h10QOtZ4EabnbnRnu4MmiyE5cVyDzGH+eBUgTP0ds=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6570533AE881AB498749C93A1A6E76F6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a038d8ac-ebb7-4f92-359f-08d6d9142564
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 09:03:07.2679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4053
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.125
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

