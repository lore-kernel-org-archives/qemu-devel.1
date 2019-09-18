Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F97AC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A61D218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bRfnlUD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A61D218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAcz8-0006hA-81
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 12:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAc1x-0007iq-HE
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAc1v-0005PP-SZ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:38:09 -0400
Received: from mail-eopbgr70094.outbound.protection.outlook.com
 ([40.107.7.94]:54594 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAc1v-0005K8-02; Wed, 18 Sep 2019 11:38:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiubPYsc87KkzTeRIy2pjc5QqH+Nh50n7prbRW3TtXi+Okk0MAGZzQX58SyHFGvBsGrJCWKmwIPa+w01nY+G2DtqOOlsydd8ddOKkGIu4B+R49t2SQ05a0+JEe4jqnYXDhfrYR6gnVQqWzOy2oEFB161rEnCNtpzCe0e/pgdrrn29yEvnDLufc8nXWGgKbUdAdqsNyDY1hfPIb30KJS/F5tNSP0BRaeOhe0lLYTYwTRb47YwZU0aA2cKm/EjRziTNmNYYpkgfCnrF4xdcB2vTapj6j2Ekxc0X+5/QCcADdjuXX43FvGccphI27CRv1jizhfVESCkJW4F1Ds8qPEwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZSsMsFoZD3JI6zIEuODB42CwTC3I5qs0C4BU9uArbo=;
 b=KMSrGSRhaLWTrJSM5z57pN1ICjaP9DdPZVATsrfhXg+Fa9Idy4QAhMuqGciTPQj6olZBbmF5ZERwsoZciTjyFbA1N/doTXnOcKBrIFkAcW5V78ZDspqi3tTYZRZbI7wNSgUQ4I2RPvKF+I2YnWKGg9ihKOLzRN3FSeZRGYNCgfNUnL8IjGjarjSCrKPp3XsK0miGdZunl7OZdh8PEYqrOTfDFgV283zQPzBM/h0bshI1LcZzpZpXbYIq/LugJ6yUqZhd24E9yQlRoEy9jFvtSllHmS+muY2EbAyM3TE7pgi2PVyL6fEYJjdV1pi0kaM88Wk6Q0shMk6jqkIAczVk2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZSsMsFoZD3JI6zIEuODB42CwTC3I5qs0C4BU9uArbo=;
 b=bRfnlUD2tSeBWp/KELkOJFBhNyGv/tR0x/HbtS2yWIigTL47TxNhkf7q9JRhm7SF0xyXtdk8xxnLm7LWMoSYcU7pqrOF072gpm3ZLwCR63Gux1n8KehnfW1qwAIGIXJUTs2kF0bzhh+wc0AGcQeK+iG+7Be6LQdyrB1xDQA/3IQ=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4188.eurprd08.prod.outlook.com (20.179.12.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Wed, 18 Sep 2019 15:38:04 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 15:38:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 0/4] mirror: Do not dereference invalid
 pointers
Thread-Index: AQHVaXSydpdz13QulUauILjn06n58qcxmzMA
Date: Wed, 18 Sep 2019 15:38:04 +0000
Message-ID: <0af49571-c3a1-2887-8873-bfa94bb42cb4@virtuozzo.com>
References: <20190912135632.13925-1-mreitz@redhat.com>
In-Reply-To: <20190912135632.13925-1-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0206.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::30) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190918183802234
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3efabf2-bebb-45b2-0a27-08d73c4e3242
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4188; 
x-ms-traffictypediagnostic: DB8PR08MB4188:
x-microsoft-antispam-prvs: <DB8PR08MB418884FFE7773E4FDDC5B362C18E0@DB8PR08MB4188.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(366004)(396003)(39850400004)(136003)(189003)(199004)(6436002)(316002)(8676002)(31686004)(486006)(6116002)(476003)(256004)(14444005)(7736002)(81166006)(305945005)(3846002)(81156014)(99286004)(2906002)(229853002)(6512007)(6486002)(5660300002)(8936002)(478600001)(66066001)(102836004)(4326008)(54906003)(76176011)(31696002)(6246003)(186003)(2501003)(71190400001)(71200400001)(2616005)(66476007)(66556008)(66446008)(110136005)(446003)(386003)(6506007)(36756003)(25786009)(86362001)(26005)(52116002)(11346002)(66946007)(64756008)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4188;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qFAvLLfT0LSnM2QvDMlXFKsR9e5p5y0VJ/udClg/99UX6+vpmu3CpP4dMjFwD0Qh0mDc/CPfTsP9ch7VKXZ04IAwgBfp1bh9ZuBHMG4gVIIkectyQCbboX9/WgFoFK9f2JRgdpkfZlG9RRDTxGgsWBstsgFhHPcJMxRIaaWBSK1h274mXh31ECIED2xpNIGPDhEeEZc9J5hG3uqYbtpCSueiKoDLVH7X2Nxa9LWx6572N7IoBXBVCajUR+bf1Kwn5cza1JJNS8O1LdOFdL7cMyfbqvIVAkq+SPOwaYfDYLQR8UZy7lezBGuP814+bXQal3cKh9cx6QmfmfLZmwGWV83kdVN0MMZoQp8CLrG4uRNQkgbKYB0UOKaJSZc3OdMlsxjQkqPBuxkmxq0JqWi9XV0Pgrp8STUGIzdIxxlU8UQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <412C76ED8FA5D040BA2B72CC903FBDFD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3efabf2-bebb-45b2-0a27-08d73c4e3242
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 15:38:04.5749 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vcc1x1KLB35ffhU3sVu5VsFCplHAqMk9wmPxrbWZESZJ0w597/JS49wlDxYd86WNkxZeo8e0l/1cwGsvqigP3An6FfiVMKUXGmrqETRl0As=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4188
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.94
Subject: Re: [Qemu-devel] [PATCH 0/4] mirror: Do not dereference invalid
 pointers
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTIuMDkuMjAxOSAxNjo1NiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBIaSwNCj4gDQo+IFRoZSBmaXgg
KHBhdGNoIDEpIGlzIHByZXR0eSBzdHJhaWdodGZvcndhcmQ7IHBhdGNoIDIgKHdoaWNoIEkgbmVl
ZCBmb3INCj4gdGhlIHRlc3QpIG1heSBub3QgYmUuDQo+IA0KPiBUaGUgYmlnZ2VzdCBwcm9ibGVt
IHdpdGggcGF0Y2ggMiBpcyB0aGF0IHlvdSBjYW4gdXNlIGl0IHRvIHVuY292ZXIgd2hlcmUNCj4g
b3VyIHBlcm1pc3Npb24gaGFuZGxpbmcgaXMgYnJva2VuLiAgRm9yIGV4YW1wbGUsIGRldmlzaW5n
IHRoZSB0ZXN0IGNhc2UNCj4gKHBhdGNoIDQpIHdhcyB2ZXJ5IGRpZmZpY3VsdCBiZWNhdXNlIEkg
a2VwdCBydW5uaW5nIGludG8gdGhlDQo+ICZlcnJvcl9hYm9ydCB0aGF0IG1pcnJvcl9leGl0X2Nv
bW1vbigpIHBhc3NlcyB3aGVuIGRyb3BwaW5nIHRoZQ0KPiBtaXJyb3JfdG9wX2JzLg0KPiANCj4g
VGhlIHByb2JsZW0gaXMgdGhhdCBtaXJyb3JfdG9wX2JzIGRvZXMgbm90IHRha2UgdGhlIHNhbWUg
cGVybWlzc2lvbnMNCj4gdGhhdCBpdHMgcGFyZW50IHRha2VzLiAgRXJnbyB1c2luZyAmZXJyb3Jf
YWJvcnQgd2hlbiBkcm9wcGluZyBpdCBpcw0KPiB3cm9uZzogVGhlIHBhcmVudCBtYXkgcmVxdWly
ZSBtb3JlIHBlcm1pc3Npb25zIHRoYXQgbWlycm9yX3RvcF9icyBkaWQsDQo+IGFuZCBzbyBkcm9w
cGluZyBtaXJyb3JfdG9wX2JzIG1heSBmYWlsLg0KPiANCj4gTm93IHdoYXTigJlzIHJlYWxseSBi
YWQgaXMgdGhhdCB0aGlzIGNhbm5vdCBiZSBmaXhlZCB3aXRoIG91ciBjdXJyZW50DQo+IHBlcm1p
c3Npb24gc3lzdGVtLiAgbWlycm9yX3RvcF9icyB3YXMgaW50cm9kdWNlZCBwcmVjaXNlbHkgc28g
aXQgZG9lcw0KPiBub3QgdGFrZSBDT05TSVNURU5UX1JFQUQsIGJ1dCBjYW4gc3RpbGwgYWxsb3cg
cGFyZW50cyB0byB0YWtlIGl0IChmb3INCj4gYWN0aXZlIGNvbW1pdHMpLiAgQnV0IHdoYXQgaWYg
dGhlcmUgaXMgYWN0dWFsbHkgc29tZXRoaW5nIGJlc2lkZXMgdGhlDQo+IG1pcnJvciBqb2IgdGhh
dCB1bnNoYXJlcyBDT05TSVNURU5UX1JFQUQ/DQo+IA0KPiANCj4gSW1hZ2luZSB0aGlzOg0KPiAN
Cj4gICAgICAgIG1pcnJvciB0YXJnZXQgQkIgICAgICAgbWlycm9yIHNvdXJjZSBCQg0KPiAgICAg
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICB8DQo+ICAgICAgICAgICAgICAgICAgICB2ICAg
ICAgICAgICAgIHYNCj4gbWlycm9yX3RvcF9icyAtPiB0b3AgLT4gbWlkIC0+IGJhc2UNCj4gICAg
ICAgICAgICAgICAgICAgIF4NCj4gICAgICAgICAgICAgICAgICAgIHwNCj4gICAgICAgICAgICAg
ICBvdGhlcl9wYXJlbnQNCj4gDQo+IFRoZSBzb3VyY2UgQkIgdW5zaGFyZXMgQ09OU0lTVEVOVF9S
RUFEIG9uIHRoZSBiYXNlLiAgbWlycm9yX3RvcF9icw0KPiBlbnN1cmVzIHRoYXQgaXRzIHBhcmVu
dHMgY2FuIHJlYWQgZnJvbSB0b3AgZXZlbiB0aG91Z2ggdG9wIGl0c2VsZiBjYW5ub3QNCj4gYWxs
b3cgQ09OU0lTVEVOVF9SRUFEIHRvIGJlIHRha2VuLiAgU28gZmFyIHNvIGdvb2QuDQo+IA0KPiBC
dXQgd2hhdCBpZiBvdGhlcl9wYXJlbnQgYWxzbyB1bnNoYXJlcyBDT05TSVNURU5UX1JFQUQ/ICBU
aGVuLA0KPiBtaXJyb3JfdG9wX2JzIGhhcyBubyBidXNpbmVzcyBhbGxvd2luZyBpdHMgcGFyZW50
cyB0byB0YWtlIGl0Lg0KPiANCj4gTm8gaWRlYSBob3cgdG8gZml4IHRoYXQuICAoSSBzdXBwb3Nl
IG1pcnJvcl90b3BfYnMgd291bGQgbmVlZCBzb21lIHdheQ0KPiB0byB2ZXJpZnkgdGhhdCB0aGVy
ZSBpcyBubyBvdGhlciBwYXJ0eSB0aGF0IGhhcyB1bnNoYXJlZCBDT05TSVNURU5UX1JFQUQNCj4g
YnV0IGl0cyBhc3NvY2lhdGVkIHNvdXJjZSBCQi4NCg0KTWF5IGJlIHdlIG5lZWQgZ3JvdXBlZCBw
ZXJtaXNzaW9ucz8NCg0KU29tZSB3YXkgdG8gZGVmaW5lIGdyb3VwIG9mIGNoaWxkcmVuLCB3aGlj
aCBtYXkgdW5zaGFyZSByZWFkIHBlcm1pc3Npb24NCmZvciBvdGhlciBjaGlsZHJlbiAob3V0IG9m
IHRoZSBncm91cCksIGJ1dCBzdGlsbCBjaGlsZHJlbiBpbiBncm91cCBtYXkNCmhhdmUgcmVhZCBw
ZXJtaXNzaW9uPw0KDQpCdXQgaXQgZG9uJ3Qgd29yayBoZXJlIGFzIHdlIGFyZSBzYXlpbmcgYWJv
dXQgY2hpbGRyZW4gb24gZGlmZmVyZW50DQpub2Rlcy4uIEFuZCBwcm9wYWdhdGVkIHRocm91Z2gg
YmFja2luZyBjaGFpbiBwZXJtaXNzaW9ucy4uDQoNCg0KPiAgSW4gdGhlIGZ1dHVyZSwgd2Ugd2Fu
dCB0aGUgc291cmNlIEJCIHRvDQo+IGdvIGF3YXkgYW5kIGluc3RlYWQgaGF2ZSB0aGUgc291cmNl
IGJlIGFuIGltbWVkaWF0ZSBCZHJ2Q2hpbGQgb2YNCj4gbWlycm9yX3RvcF9icy4gIE1heWJlIHdl
IGNhbiB0aGVuIGJ1aWxkIHNvbWV0aGluZyBpbnRvIHRoZSBibG9jayBsYXllcg0KPiBzbyB0aGF0
IGEgbm9kZSBjYW4gb25seSByZXN0b3JlIENPTlNJU1RFTlRfUkVBRCB3aGVuIGl0IHdhcyB0aGF0
IG5vZGUNCj4gdGhhdCBicm9rZSBpdD8pDQo+IA0KPiANCj4gQW55d2F5LiAgWW91IGNhbiBzZWUg
c29tZXRoaW5nIGFyaXNpbmcgZnJvbSB0aGlzIHByb2JsZW0gc2ltcGx5IGJ5DQo+IHVuc2hhcmlu
ZyBDT05TSVNURU5UX1JFQUQgb24gdGhlIHRhcmdldCBub2RlLiAgKEp1c3QgZHJvcCB0aGUgc3Jj
LXBlcm0NCj4gbm9kZSBmcm9tIHRoZSB0ZXN0IEkgYWRkIGluIHBhdGNoIDQuKSAgUmVwbGFjaW5n
IHRoZSBzb3VyY2Ugd2l0aCB0aGUNCj4gdGFyZ2V0IHdpbGwgdGhlbiB3b3JrIGZpbmUgKGJlY2F1
c2UgbWlycm9yX3RvcF9icyBkb2VzbuKAmXQgY2FyZSBhYm91dA0KPiBDT05TSVNURU5UX1JFQUQg
YmVpbmcgcmVtb3ZlZCksIGJ1dCB0aGVuIHlvdSBjYW5ub3QgZHJvcCBtaXJyb3JfdG9wX2JzIOKA
kw0KPiBiZWNhdXNlIGl0cyBwYXJlbnQgZG9lcyB3YW50IENPTlNJU1RFTlRfUkVBRC4gIFRodXMs
IHRoZSAmZXJyb3JfYWJvcnQNCj4gYWJvcnRzLg0KPiANCj4gDQo+IFdoaWxlIHRoaXMgaXMgYSBt
b3JlIHNwZWNpYWwgY2FzZSwgSSBoYXZlIG5vIGlkZWEgaG93IHRvIGZpeCB0aGlzIG9uZQ0KPiBl
aXRoZXIuDQo+IA0KPiANCj4gU29vLi4uICBUaGlzIHNlcmllcyBqdXN0IGZpeGVzIG9uZSB0aGlu
ZywgYW5kIGxlYXZlcyBhbm90aGVyIHVuZml4ZWQNCj4gYmVjYXVzZSBJIGhhdmUgbm8gaWRlYSBo
b3cgdG8gZml4IGl0LiAgV29yc2UsIGl0IGFkZHMgcGFyYW1ldGVycyB0bw0KPiBibGtkZWJ1ZyB0
byBhY3R1YWxseSBzZWUgdGhlIHByb2JsZW0uICBEbyB3ZSB3YW50IHRvIGxldCBibGtkZWJ1ZyBi
ZQ0KPiBhYmxlIHRvIGNyYXNoIHFlbXUgKGJlY2F1c2Ugb2YgYSBidWcgaW4gcWVtdSk/DQo+IA0K
DQpibGtkZWJ1ZyBpcyBmb3IgZGVidWdnaW5nIGFuZCBub3QgdXNlZCBieSBlbmQgdXNlcnMgbGlr
ZSBsaWJ2aXJ0LCB5ZXM/DQoNCj4gDQo+IE1heCBSZWl0eiAoNCk6DQo+ICAgIG1pcnJvcjogRG8g
bm90IGRlcmVmZXJlbmNlIGludmFsaWQgcG9pbnRlcnMNCj4gICAgYmxrZGVidWc6IEFsbG93IHRh
a2luZy91bnNoYXJpbmcgcGVybWlzc2lvbnMNCj4gICAgaW90ZXN0czogQWRkIEBlcnJvciB0byB3
YWl0X3VudGlsX2NvbXBsZXRlZA0KPiAgICBpb3Rlc3RzOiBBZGQgdGVzdCBmb3IgZmFpbGluZyBt
aXJyb3IgY29tcGxldGUNCj4gDQo+ICAgcWFwaS9ibG9jay1jb3JlLmpzb24gICAgICAgICAgfCAg
MjkgKysrKysrKysrLQ0KPiAgIGJsb2NrL2Jsa2RlYnVnLmMgICAgICAgICAgICAgIHwgMTA2ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gICBibG9jay9taXJyb3IuYyAgICAg
ICAgICAgICAgICB8ICAxMyArKystLQ0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8wNDEgICAgICAg
IHwgIDQ0ICsrKysrKysrKysrKysrDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzA0MS5vdXQgICAg
fCAgIDQgKy0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weSB8ICAxOCArKysrLS0N
Cj4gICA2IGZpbGVzIGNoYW5nZWQsIDIwMCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkN
Cj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

