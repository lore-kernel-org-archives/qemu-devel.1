Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040E9C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 09:50:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1C8820867
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 09:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fD+KG5Bx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C8820867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHPfH-0005mt-Nl
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 05:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHPe7-000516-4N
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 05:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHPe5-0008H5-My
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 05:49:39 -0400
Received: from mail-eopbgr10128.outbound.protection.outlook.com
 ([40.107.1.128]:8353 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iHPe1-0008Eg-24; Mon, 07 Oct 2019 05:49:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVoqfK1/aznUDO7ShT4CwhwQTL7ip9+MsKApWWexD4v2gXsooAIi0I+iwkhbdTSKzLvjXbZv7hPXTr1bbjL9mby+eGeyB1tFSmRDtrMj6mdmjzlte1zgF79QWTAjhzPKsLYvteOQDgDq9Lx5DSloT1LBRn0Ra5Uungv8P5siPFceHR+6v970XCuK4zofzbNhz4twVB82JDGVjHyT/BJgsPr3tKEoY3nj5mAXRL2p8wBO8As6IJ8FXMCnc9HAGZLyxFfBi3HNCh2fhNF6OxpZ7ZhM5JE+tM5UWMFSvBpjOS9xib0b5sHvFQHNWZ6HgiH+W6YQ5xnwBW3v6tbKuvW/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgVoxgPxX77ll9x5i7KjSHEGM2cGDxoI5LsX+CgbMQU=;
 b=dJivdwghegFCB+fRyoZv9VijP8U7cXB6hOw9SAozj1ZUpKoKNq5Zt82P7NreAQu73wR4pqefNFl5aM2AbtTnzO0N/n13lA0MBHz8lkV0QI83/PKOrZVqU9TYGg1pYlpResGJt0qIKgALHtb4rgWfgKayA3D6UtTBIAF7cSkurAsdzxw45kiZhgS2fI8Zqwti7gOB9jBszJOcS37t6CzqgCCM71tBN8fROKTHSZzc7nyunW+UjGPoKurHYlVqUYjsIpO7UXqgXnnY7JP9yr39oT5MNUEVcqEYaG6dRPGgiC0JL+Ubyx6ArsGojKPxpbkwu0p5c4Io48Wb15C0uySWEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgVoxgPxX77ll9x5i7KjSHEGM2cGDxoI5LsX+CgbMQU=;
 b=fD+KG5BxOClt41ITXbgNKvIZ1ZwxoPlhaisJnqI4pZ+fXfOiIIIFzZeE1X53czBhYBDI4m5uBnV3cLAxA6jI9WM5Hj6vrcJKqAVNqun2rsb5V6UCrvmKdWrZBWZ/hDW5QvXlOaJACuQkyY8LN0LDD4+IjZRkfdSmo6GIpzpr5TQ=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5097.eurprd08.prod.outlook.com (10.255.4.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 09:49:28 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2327.023; Mon, 7 Oct 2019
 09:49:28 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/1] MAINTAINERS: Add Vladimir as a reviewer for bitmaps
Thread-Topic: [PATCH 1/1] MAINTAINERS: Add Vladimir as a reviewer for bitmaps
Thread-Index: AQHVe7Vg26l8oikXw0OjhlBi1YeTYadO8ZcA
Date: Mon, 7 Oct 2019 09:49:28 +0000
Message-ID: <acd6caed-9851-8e7a-5356-cec3ad39dd42@virtuozzo.com>
References: <20191005194448.16629-1-jsnow@redhat.com>
 <20191005194448.16629-2-jsnow@redhat.com>
In-Reply-To: <20191005194448.16629-2-jsnow@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0005.eurprd07.prod.outlook.com
 (2603:10a6:7:67::15) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191007124925958
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b48b55d7-74f9-4ca5-3cd0-08d74b0ba508
x-ms-traffictypediagnostic: DB8PR08MB5097:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <DB8PR08MB50970CABC29F966A15BF056FC19B0@DB8PR08MB5097.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:597;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(136003)(376002)(346002)(396003)(366004)(189003)(52314003)(199004)(2906002)(3846002)(6116002)(4326008)(66556008)(64756008)(66446008)(6246003)(2501003)(6306002)(6512007)(6486002)(6436002)(66476007)(66946007)(36756003)(31686004)(99286004)(386003)(6506007)(52116002)(76176011)(31696002)(229853002)(86362001)(25786009)(71200400001)(71190400001)(256004)(966005)(186003)(476003)(2616005)(102836004)(486006)(478600001)(26005)(14454004)(5660300002)(11346002)(446003)(7736002)(305945005)(8936002)(8676002)(316002)(110136005)(81166006)(66066001)(81156014)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5097;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vABD107IfQEmZjmmIulwO1I3JYvX9KUF5zihh/ZpEpvLXLIigZqUr1Z2t+b1Q+Qbr1LwukJEcU5l4p7yKIDWv+fltMrRthKq892t12ELGvYlGQDTbpacc0dYg1wLE4ZyXfUD7u+d3uMkB8/q+DBZegn3/CxUgaZpQ0ZCyXGPHsHIRxeogSEHD+4zaAmE0AAUaAiatzo+A9xp/Jg3bwhJRn0cyR3t5wPK1WsbxhybyeLlUoVyjeSBg5Dnioi+7ryzrsiB1Fy8GiRIfQ/urzmGIXO8xysxyypDX128gbx26Gxm5I5anyxyJXdJ9+4bdqVoWNMY6jFfPkIr5Njt621+bADQ7b5DdHHnDXFx+oYYp0zq2m3NbCt6nAkxwnIgaEUP5SmQej2diWeuoLQQFX2mOetwZwSs0Ze7atnsU/x4z9LV6tQkbAC5vq1ny+6jXdyUi4P4mP+LL5S5hpFzogRPZQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E54DE750382C514D84DD0522570FF996@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48b55d7-74f9-4ca5-3cd0-08d74b0ba508
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 09:49:28.3029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PaTfiaIR4Snnk1KwMu2ftxWg9rFc2D7LBV6h4o121SpNE3neIl9ustW9ok6ZlQkgx/W8IQ015bCj6eHVfbPoniKzv3TiHgLyPse8ShX7tiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5097
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.128
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDUuMTAuMjAxOSAyMjo0NCwgSm9obiBTbm93IHdyb3RlOg0KPiBJIGFscmVhZHkgdHJ5IHRvIG1h
a2Ugc3VyZSBhbGwgYml0bWFwcyBwYXRjaGVzIGhhdmUgYmVlbiByZXZpZXdlZCBieSBib3RoDQo+
IFJlZCBIYXQgYW5kIFZpcnR1b3p6byBhbnl3YXksIHNvIHRoaXMgZm9ybWFsaXplcyB0aGUgYXJy
YW5nZW1lbnQuDQo+IA0KPiBGYW0gbWVhbndoaWxlIGlzIG5vIGxvbmdlciBhcyBhY3RpdmUsIHNv
IEkgYW0gcmVtb3ZpbmcgaGltIGFzIGEgY28tbWFpbnRhaW5lcg0KPiBzaW1wbHkgdG8gcmVmbGVj
dCB0aGUgY3VycmVudCBwcmFjdGljZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvaG4gU25vdyA8
anNub3dAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2ll
dnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KPiAtLS0NCj4gICBNQUlOVEFJTkVS
UyB8IDMgKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5k
ZXggMjEyNjRlYWU5YzQuLjg3ZTgwYWUxMTBjIDEwMDY0NA0KPiAtLS0gYS9NQUlOVEFJTkVSUw0K
PiArKysgYi9NQUlOVEFJTkVSUw0KPiBAQCAtMTgxOCw4ICsxODE4LDggQEAgRjogcWFwaS90cmFu
c2FjdGlvbi5qc29uDQo+ICAgVDogZ2l0IGh0dHBzOi8vcmVwby5vci5jei9xZW11L2FybWJydS5n
aXQgYmxvY2stbmV4dA0KPiAgIA0KPiAgIERpcnR5IEJpdG1hcHMNCj4gLU06IEZhbSBaaGVuZyA8
ZmFtQGV1cGhvbi5uZXQ+DQo+ICAgTTogSm9obiBTbm93IDxqc25vd0ByZWRoYXQuY29tPg0KPiAr
UjogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29t
Pg0KPiAgIEw6IHFlbXUtYmxvY2tAbm9uZ251Lm9yZw0KPiAgIFM6IFN1cHBvcnRlZA0KPiAgIEY6
IHV0aWwvaGJpdG1hcC5jDQo+IEBAIC0xODI4LDcgKzE4MjgsNiBAQCBGOiBpbmNsdWRlL3FlbXUv
aGJpdG1hcC5oDQo+ICAgRjogaW5jbHVkZS9ibG9jay9kaXJ0eS1iaXRtYXAuaA0KPiAgIEY6IHRl
c3RzL3Rlc3QtaGJpdG1hcC5jDQo+ICAgRjogZG9jcy9pbnRlcm9wL2JpdG1hcHMucnN0DQo+IC1U
OiBnaXQgaHR0cHM6Ly9naXRodWIuY29tL2ZhbXovcWVtdS5naXQgYml0bWFwcw0KPiAgIFQ6IGdp
dCBodHRwczovL2dpdGh1Yi5jb20vam5zbm93L3FlbXUuZ2l0IGJpdG1hcHMNCj4gICANCj4gICBD
aGFyYWN0ZXIgZGV2aWNlIGJhY2tlbmRzDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxh
ZGltaXINCg==

