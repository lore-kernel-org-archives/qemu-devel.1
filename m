Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3111C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9245A21479
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aR8KjM/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9245A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi3hJ-0005nc-ME
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:18:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44108)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hi3Cx-0000aG-0t
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hi3Cg-0000kT-4B
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:47:14 -0400
Received: from mail-eopbgr10139.outbound.protection.outlook.com
 ([40.107.1.139]:6561 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hi3CX-0000cw-Jo; Mon, 01 Jul 2019 16:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEDW2gP2W/4ImBNX8ushA/+pD3DB+pQd2NEUu64nScw=;
 b=aR8KjM/B142Rz1L4WFFatmLVbKK768pxBWNEtxoF+RbpQ5IF5PwceOEcTJW8sRIBtn2z+Qck/LvrSLZlbfihlZV23p4CKBT5UCdTzbicpet3BRkFJ/9VNqXOPLQIpx5CLU6xReytUdjKNHZXtgcTlt+GSiPXfkai7uCZbNuDNzQ=
Received: from DB7PR08MB3258.eurprd08.prod.outlook.com (52.134.111.155) by
 DB7PR08MB3834.eurprd08.prod.outlook.com (20.178.45.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 1 Jul 2019 16:44:27 +0000
Received: from DB7PR08MB3258.eurprd08.prod.outlook.com
 ([fe80::5d2:b836:e08a:f5cf]) by DB7PR08MB3258.eurprd08.prod.outlook.com
 ([fe80::5d2:b836:e08a:f5cf%3]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 16:44:27 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 5/5] iotests: Add new case to 030
Thread-Index: AQHVLThZ/Fpjf9CyCECqEjLxhHO8GKa1/gkA
Date: Mon, 1 Jul 2019 16:44:27 +0000
Message-ID: <476e4885-322f-d244-5342-bd414383de0a@virtuozzo.com>
References: <20190627223255.3789-1-mreitz@redhat.com>
 <20190627223255.3789-6-mreitz@redhat.com>
In-Reply-To: <20190627223255.3789-6-mreitz@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0046.eurprd07.prod.outlook.com
 (2603:10a6:7:66::32) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:20::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e20aaf6-559f-47e7-fb24-08d6fe436174
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB7PR08MB3834; 
x-ms-traffictypediagnostic: DB7PR08MB3834:
x-microsoft-antispam-prvs: <DB7PR08MB3834DE25DB9A10DE381C818BF4F90@DB7PR08MB3834.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(39850400004)(396003)(346002)(136003)(199004)(189003)(53936002)(31686004)(14454004)(73956011)(66946007)(186003)(14444005)(256004)(81166006)(6506007)(53546011)(8676002)(68736007)(52116002)(26005)(486006)(476003)(2616005)(11346002)(446003)(25786009)(66446008)(66066001)(2906002)(81156014)(66556008)(64756008)(478600001)(386003)(6486002)(229853002)(4326008)(6512007)(6436002)(66476007)(71200400001)(99286004)(86362001)(44832011)(305945005)(31696002)(7736002)(2501003)(6116002)(5660300002)(3846002)(76176011)(36756003)(6246003)(110136005)(54906003)(316002)(8936002)(102836004)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3834;
 H:DB7PR08MB3258.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UkzlcpqgNkonsv9sIhmtNvi4x82cCBn7s4o7QgsTKFoc08NXsBON7gpa9Likk64jg81GHZjA5UJentSfQhRWPWfZ14Y79QCkVmrUUVzl+j2eaihEe6T+TQK8oDMABG0vSLKjhonyO5xRYcGGe3yaNISOTzgA3nTK2824r7qV5eZVvxhghpALrRSqm0VeS4OrE0gXRZir/0Q06Lmo1a/W+7GFIhEabLZJtkmeXHsUgftjAEj/p7mRXNvVsfO0oAfNCF27psJ2Oaf8KknagiC1ZB81dJXkrw0dVIt/AJsta61OQhN5qQ9u7QBqU9dQ5R6KT7tjqiWskT47+LxSuo2rSvshj4KiJV3kiHmZMpeXcddrkNBSwU19OaXZUCIZthqWF73dfwb0tXudonYwTNpBfHGQhn5NqBontXevfxu3VkE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7952C28724D685498655DC59FE3B9A33@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e20aaf6-559f-47e7-fb24-08d6fe436174
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 16:44:27.2823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3834
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.139
Subject: Re: [Qemu-devel] [PATCH 5/5] iotests: Add new case to 030
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI4LzA2LzIwMTkgMDE6MzIsIE1heCBSZWl0eiB3cm90ZToNCj4gV2UgcmVjZW50bHkg
cmVtb3ZlZCB0aGUgZGVwZW5kZW5jeSBvZiB0aGUgc3RyZWFtIGpvYiBvbiBpdHMgYmFzZSBub2Rl
Lg0KPiBUaGF0IG1ha2VzIGl0IE9LIHRvIHVzZSBhIGNvbW1pdCBmaWx0ZXIgbm9kZSB0aGVyZS4g
IFRlc3QgdGhhdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhh
dC5jb20+DQo+IC0tLQ0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8wMzAgICAgIHwgMjUgKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8wMzAub3V0IHwgIDQg
KystLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvMDMwIGIvdGVzdHMvcWVt
dS1pb3Rlc3RzLzAzMA0KPiBpbmRleCAxMGZlMWRlODlkLi5hMDM5NzA3MmJjIDEwMDc1NQ0KPiAt
LS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMDMwDQo+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8w
MzANCj4gQEAgLTM2Myw2ICszNjMsMzEgQEAgY2xhc3MgVGVzdFBhcmFsbGVsT3BzKGlvdGVzdHMu
UU1QVGVzdENhc2UpOg0KPiAgICAgICAgICAgc2VsZi53YWl0X3VudGlsX2NvbXBsZXRlZCgpDQo+
ICAgICAgICAgICBzZWxmLmFzc2VydF9ub19hY3RpdmVfYmxvY2tfam9icygpDQo+ICAgDQo+ICsg
ICAgIyBJbiB0aGlzIGNhc2UgdGhlIGJhc2Ugbm9kZSBvZiB0aGUgc3RyZWFtIGpvYiBpcyB0aGUg
Y29tbWl0IGpvYidzDQo+ICsgICAgIyBmaWx0ZXIgbm9kZS4gIHN0cmVhbSBkb2VzIG5vdCBoYXZl
IGEgcmVhbCBkZXBlbmRlbmN5IG9uIGl0cyBiYXNlDQo+ICsgICAgIyBub2RlLCBzbyBldmVuIHRo
b3VnaCBjb21taXQgcmVtb3ZlcyBpdCB3aGVuIGl0IGlzIGRvbmUsIHRoZXJlIGlzDQo+ICsgICAg
IyBubyBjb25mbGljdC4NCj4gKyAgICBkZWYgdGVzdF9vdmVybGFwcGluZ181KHNlbGYpOg0KPiAr
ICAgICAgICBzZWxmLmFzc2VydF9ub19hY3RpdmVfYmxvY2tfam9icygpDQo+ICsNCj4gKyAgICAg
ICAgIyBDb21taXQgZnJvbSBub2RlMiBpbnRvIG5vZGUwDQo+ICsgICAgICAgIHJlc3VsdCA9IHNl
bGYudm0ucW1wKCdibG9jay1jb21taXQnLCBkZXZpY2U9J2RyaXZlMCcsDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHRvcF9ub2RlPSdub2RlMicsIGJhc2Vfbm9kZT0nbm9kZTAnLA0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmaWx0ZXJfbm9kZV9uYW1lPSdjb21taXQt
ZmlsdGVyJywgc3BlZWQ9MTAyNCoxMDI0KQ0KPiArICAgICAgICBzZWxmLmFzc2VydF9xbXAocmVz
dWx0LCAncmV0dXJuJywge30pDQo+ICsNCj4gKyAgICAgICAgIyBTdHJlYW0gZnJvbSBub2RlMiBp
bnRvIG5vZGU0DQo+ICsgICAgICAgIHJlc3VsdCA9IHNlbGYudm0ucW1wKCdibG9jay1zdHJlYW0n
LCBkZXZpY2U9J25vZGU0JywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYmFzZV9u
b2RlPSdjb21taXQtZmlsdGVyJywgam9iX2lkPSdub2RlNCcpDQo+ICsgICAgICAgIHNlbGYuYXNz
ZXJ0X3FtcChyZXN1bHQsICdyZXR1cm4nLCB7fSkNCj4gKw0KPiArICAgICAgICByZXN1bHQgPSBz
ZWxmLnZtLnFtcCgnYmxvY2stam9iLXNldC1zcGVlZCcsIGRldmljZT0nZHJpdmUwJywgc3BlZWQ9
MCkNCj4gKyAgICAgICAgc2VsZi5hc3NlcnRfcW1wKHJlc3VsdCwgJ3JldHVybicsIHt9KQ0KPiAr
DQo+ICsgICAgICAgIHNlbGYudm0ucnVuX2pvYihqb2I9J2RyaXZlMCcsIGF1dG9fZGlzbWlzcz1U
cnVlLCB1c2VfbG9nPUZhbHNlKQ0KPiArICAgICAgICBzZWxmLnZtLnJ1bl9qb2Ioam9iPSdub2Rl
NCcsIGF1dG9fZGlzbWlzcz1UcnVlLCB1c2VfbG9nPUZhbHNlKQ0KPiArICAgICAgICBzZWxmLmFz
c2VydF9ub19hY3RpdmVfYmxvY2tfam9icygpDQo+ICsNCj4gICAgICAgIyBUZXN0IGEgYmxvY2st
c3RyZWFtIGFuZCBhIGJsb2NrLWNvbW1pdCBqb2IgaW4gcGFyYWxsZWwNCj4gICAgICAgIyBIZXJl
IHRoZSBzdHJlYW0gam9iIGlzIHN1cHBvc2VkIHRvIGZpbmlzaCBxdWlja2x5IGluIG9yZGVyIHRv
IHJlcHJvZHVjZQ0KPiAgICAgICAjIHRoZSBzY2VuYXJpbyB0aGF0IHRyaWdnZXJzIHRoZSBidWcg
Zml4ZWQgaW4gM2Q1ZDMxOWUxMjIxIGFuZCAxYTYzYTkwNzUwNw0KPiBkaWZmIC0tZ2l0IGEvdGVz
dHMvcWVtdS1pb3Rlc3RzLzAzMC5vdXQgYi90ZXN0cy9xZW11LWlvdGVzdHMvMDMwLm91dA0KPiBp
bmRleCA0ZmQxYzJkY2QyLi41ZWI1MDhkZTA3IDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9xZW11LWlv
dGVzdHMvMDMwLm91dA0KPiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMDMwLm91dA0KPiBAQCAt
MSw1ICsxLDUgQEANCj4gLS4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4NCj4gKy4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uDQo+ICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAtUmFuIDI1IHRlc3RzDQo+ICtS
YW4gMjYgdGVzdHMNCj4gICANCj4gICBPSw0KPiANCg0KVGVzdGVkLWJ5OiBBbmRyZXkgU2hpbmtl
dmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCi0tIA0KV2l0aCB0aGUgYmVz
dCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==

