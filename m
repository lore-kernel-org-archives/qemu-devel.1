Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD26EC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B07214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EywKZJ8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B07214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAAA6-0000Ow-Oz
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 05:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAA8x-00087x-Kz
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAA8w-00068G-Cp
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:51:31 -0400
Received: from mail-he1eur04on070b.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::70b]:6109
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAA8s-00065B-7X; Tue, 17 Sep 2019 05:51:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibnqhHJtFwOWodqBZGgFdGmszotw13eG4CdpkprqtFsNaE4NCjBdC+9jT1yzZYNXj8P0OKo5vqt5HsXo3Cna5ZIolcV9hAr7ZO5/qD6Jog5UVvnXi9bob5GSeN9R0AJyc5jS5nB3jc/TicwWhRtBWRVZv3i8IAEX5uf2wW0T9Hf6NtzTn36R8bHDadph/QYKaPGIQXdbIQrabxvAj3qkOoWwnQQQQbBh2rGRq35ZMQeD3CSSYhyu7ynT133Hct2pHTQtrW/Pk1YZwZlailiuO3XtNEb3Ye3+dTg75f+bgcxxpcdb0X/moPpD+BCNhH9naeARW7x5HaUTOeBwYeAcPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkC4ls75ZvEAbGr2Fl3sXL56lBOBfKpfkKx632ANW1s=;
 b=ThG6DMh7FstiaCFj5b0Pl33g/VzDLZ0OmUevKSzatBidrSim6SZLsAavJCFaDLUBDz1pHNyuTSAUS1GHlu0mpdRCTDetdqHy1DfA7Ozg+0igGPWJiWeFvPQfRQgw/plZQ7pdadFT3L2j0qIrEhiXmyHVGjCibwf9LGTmIKZG0RLCyAfwut4FZnQ7+yfka2haNuVCSBbWbBxzbQlxXP9RRAYjhat0lS80tAGzfo7w3n6RZVJtRSosuHn7tl7TVVfcujBV9EwkRdVXQJXJxWdz9Acettc5IYcUDJoDeBrMyJBi8LosHdfZ7jJll2yebysz9uqRHiRFWcF4+MXtIDx8fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkC4ls75ZvEAbGr2Fl3sXL56lBOBfKpfkKx632ANW1s=;
 b=EywKZJ8sRxDh04jucXDJqAuY/nXr/UJJacxxOeaXkKgVtPsMOCg193LieaZVgf1fGdIAUbwpbC2pS7eAR6UQPObags0VGZSQ0qWkDJ+YQgjhXWIr/tgEObcEnzy6UzqrWUR24Y1J8sTTYc6MnC/hfJKSQXpJbewgb1o6EKtBbRg=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5273.eurprd08.prod.outlook.com (10.255.18.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Tue, 17 Sep 2019 09:51:22 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 09:51:22 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v4 3/4] iotests: specify protocol support
 via initialization info
Thread-Index: AQHVaP+zEUax+QuUe0O+HzJCcobH5qcvqOoA
Date: Tue, 17 Sep 2019 09:51:22 +0000
Message-ID: <3c734fc6-3c8d-b752-b6fa-4ed55c719d87@virtuozzo.com>
References: <20190912001633.11372-1-jsnow@redhat.com>
 <20190912001633.11372-4-jsnow@redhat.com>
In-Reply-To: <20190912001633.11372-4-jsnow@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0143.eurprd06.prod.outlook.com
 (2603:10a6:7:16::30) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190917125120022
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13d17f78-ce47-4aad-b380-08d73b549878
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5273; 
x-ms-traffictypediagnostic: DB8PR08MB5273:
x-microsoft-antispam-prvs: <DB8PR08MB527319272CC39510DD306FFBC18F0@DB8PR08MB5273.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(366004)(396003)(376002)(39850400004)(199004)(189003)(6436002)(6486002)(316002)(99286004)(31686004)(446003)(5660300002)(305945005)(7736002)(31696002)(6512007)(86362001)(6246003)(11346002)(36756003)(486006)(256004)(4326008)(476003)(26005)(14444005)(110136005)(54906003)(2616005)(102836004)(3846002)(6116002)(386003)(6506007)(76176011)(52116002)(229853002)(14454004)(478600001)(186003)(66556008)(66476007)(66946007)(66446008)(66066001)(64756008)(2501003)(81166006)(71200400001)(81156014)(2906002)(71190400001)(8936002)(8676002)(25786009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5273;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CBYNbE3B1hQ2Bag687O9/oWa/W+LJZYtGdbUD+ZDvuHY39jEGB/CLNXgvptjMyf1MJ+HCx0vVVESa0CRB63c1MgtlpUxdCbPkb5fgatM5tRQj3YkidY2fYSQONI6eMCq7rAco81jMOu6zsIiWCmYiAtqpAxRYuBddNAgQrqdIS0BrR6MTOa66nFAuKKZl4bevetjcC6XdJykwBl6FArEN9gJ4XL70vMlcuoxABCeZYWn8TFSIK8VhPo6uVy8DIfyRXXUO/G+LEYNIFGxKG0ykApH1mA+PYVEm5Nii1OJ2gM2NyRRIOPo1bsrCECx5BAnFSLUwqemZzDI0e+NzIrJy6Dz6P2QdcEtN3xoSZF+DZLo2YIOcvnY76j+Tpb2XCtBOJSB7saAm43Kxad7XYwU9g2RSx7hB4plWlRzh8fHax8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7E248C4AFC5404996C52D032E5795F2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d17f78-ce47-4aad-b380-08d73b549878
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 09:51:22.0665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FxuZJV2qEEoZ9U/1c8SaDP4hHkYlAwRhO45E+ACEKAJhHiX3/lQwDcUlNYvBIrAl1zTV5ZEJwdQfnVxJTTg+wulBhW38ZApcKZEe/pFs/Fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5273
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0d::70b
Subject: Re: [Qemu-devel] [PATCH v4 3/4] iotests: specify protocol support
 via initialization info
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTIuMDkuMjAxOSAzOjE2LCBKb2huIFNub3cgd3JvdGU6DQo+IFN3aXRjaCBmcm9tIHZlcmlmeV9w
cm90b2NvbHMgdG8gYW55IG9uZSBvZjoNCj4gaW90ZXN0cy5tYWluLCBpb3Rlc3RzLnNjcmlwdF9t
YWluLCBpb3Rlc3RzLnNjcmlwdF9pbml0aWFsaXplLg0KDQpBY3R1YWxseSwgb25seSBzY3JpcHRf
aW5pdGlhbGl6ZSB1c2VkIGluIHRoZSBwYXRjaC4NCkFsc28sIEkgdGhpbmsgaXQgYWxsIG1heSBi
ZSBzYWZlbHkgbWVyZ2VkIHRvIDAxDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvaG4gU25vdyA8
anNub3dAcmVkaGF0LmNvbT4NCg0KU3RpbGwsDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQo+IC0tLQ0KPiAgIHRl
c3RzL3FlbXUtaW90ZXN0cy8yMDcgfCA0ICsrLS0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjEw
IHwgNCArKy0tDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzIxMSB8IDQgKystLQ0KPiAgIHRlc3Rz
L3FlbXUtaW90ZXN0cy8yMTIgfCA0ICsrLS0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjEzIHwg
NCArKy0tDQo+ICAgNSBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvMjA3IGIvdGVzdHMv
cWVtdS1pb3Rlc3RzLzIwNw0KPiBpbmRleCBhYjllM2I2NzQ3Li4zNWQ5OGYyNzM2IDEwMDc1NQ0K
PiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMjA3DQo+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0
cy8yMDcNCj4gQEAgLTI0LDggKzI0LDggQEAgaW1wb3J0IGlvdGVzdHMNCj4gICBpbXBvcnQgc3Vi
cHJvY2Vzcw0KPiAgIGltcG9ydCByZQ0KPiAgIA0KPiAtaW90ZXN0cy5zY3JpcHRfaW5pdGlhbGl6
ZShzdXBwb3J0ZWRfZm10cz1bJ3JhdyddKQ0KPiAtaW90ZXN0cy52ZXJpZnlfcHJvdG9jb2woc3Vw
cG9ydGVkPVsnc3NoJ10pDQo+ICtpb3Rlc3RzLnNjcmlwdF9pbml0aWFsaXplKHN1cHBvcnRlZF9m
bXRzPVsncmF3J10sDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIHN1cHBvcnRlZF9wcm90
b2NvbHM9Wydzc2gnXSkNCj4gICANCj4gICBkZWYgZmlsdGVyX2hhc2gocW1zZyk6DQo+ICAgICAg
IGRlZiBfZmlsdGVyKGtleSwgdmFsdWUpOg0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rl
c3RzLzIxMCBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yMTANCj4gaW5kZXggNWE3MDEzY2QzNC4uZDlm
ZTc4MGMwNyAxMDA3NTUNCj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzIxMA0KPiArKysgYi90
ZXN0cy9xZW11LWlvdGVzdHMvMjEwDQo+IEBAIC0yMyw4ICsyMyw4IEBADQo+ICAgaW1wb3J0IGlv
dGVzdHMNCj4gICBmcm9tIGlvdGVzdHMgaW1wb3J0IGltZ2ZtdA0KPiAgIA0KPiAtaW90ZXN0cy5z
Y3JpcHRfaW5pdGlhbGl6ZShzdXBwb3J0ZWRfZm10cz1bJ2x1a3MnXSkNCj4gLWlvdGVzdHMudmVy
aWZ5X3Byb3RvY29sKHN1cHBvcnRlZD1bJ2ZpbGUnXSkNCj4gK2lvdGVzdHMuc2NyaXB0X2luaXRp
YWxpemUoc3VwcG9ydGVkX2ZtdHM9WydsdWtzJ10sDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgIHN1cHBvcnRlZF9wcm90b2NvbHM9WydmaWxlJ10pDQo+ICAgDQo+ICAgZGVmIGJsb2NrZGV2
X2NyZWF0ZSh2bSwgb3B0aW9ucyk6DQo+ICAgICAgIHJlc3VsdCA9IHZtLnFtcF9sb2coJ2Jsb2Nr
ZGV2LWNyZWF0ZScsIGpvYl9pZD0nam9iMCcsIG9wdGlvbnM9b3B0aW9ucywNCj4gZGlmZiAtLWdp
dCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8yMTEgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjExDQo+IGlu
ZGV4IDRkNmFhYzQ5N2YuLjE1NWZhYzRlODcgMTAwNzU1DQo+IC0tLSBhL3Rlc3RzL3FlbXUtaW90
ZXN0cy8yMTENCj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzIxMQ0KPiBAQCAtMjMsOCArMjMs
OCBAQA0KPiAgIGltcG9ydCBpb3Rlc3RzDQo+ICAgZnJvbSBpb3Rlc3RzIGltcG9ydCBpbWdmbXQN
Cj4gICANCj4gLWlvdGVzdHMuc2NyaXB0X2luaXRpYWxpemUoc3VwcG9ydGVkX2ZtdHM9Wyd2ZGkn
XSkNCj4gLWlvdGVzdHMudmVyaWZ5X3Byb3RvY29sKHN1cHBvcnRlZD1bJ2ZpbGUnXSkNCj4gK2lv
dGVzdHMuc2NyaXB0X2luaXRpYWxpemUoc3VwcG9ydGVkX2ZtdHM9Wyd2ZGknXSwNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3VwcG9ydGVkX3Byb3RvY29scz1bJ2ZpbGUnXSkNCj4gICAN
Cj4gICBkZWYgYmxvY2tkZXZfY3JlYXRlKHZtLCBvcHRpb25zKToNCj4gICAgICAgcmVzdWx0ID0g
dm0ucW1wX2xvZygnYmxvY2tkZXYtY3JlYXRlJywgam9iX2lkPSdqb2IwJywgb3B0aW9ucz1vcHRp
b25zLA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzIxMiBiL3Rlc3RzL3FlbXUt
aW90ZXN0cy8yMTINCj4gaW5kZXggZWMzNWJjZWIxMS4uNjdlNWExZGJiNSAxMDA3NTUNCj4gLS0t
IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzIxMg0KPiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjEy
DQo+IEBAIC0yMyw4ICsyMyw4IEBADQo+ICAgaW1wb3J0IGlvdGVzdHMNCj4gICBmcm9tIGlvdGVz
dHMgaW1wb3J0IGltZ2ZtdA0KPiAgIA0KPiAtaW90ZXN0cy5zY3JpcHRfaW5pdGlhbGl6ZShzdXBw
b3J0ZWRfZm10cz1bJ3BhcmFsbGVscyddKQ0KPiAtaW90ZXN0cy52ZXJpZnlfcHJvdG9jb2woc3Vw
cG9ydGVkPVsnZmlsZSddKQ0KPiAraW90ZXN0cy5zY3JpcHRfaW5pdGlhbGl6ZShzdXBwb3J0ZWRf
Zm10cz1bJ3BhcmFsbGVscyddLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICBzdXBwb3J0
ZWRfcHJvdG9jb2xzPVsnZmlsZSddKQ0KPiAgIA0KPiAgIGRlZiBibG9ja2Rldl9jcmVhdGUodm0s
IG9wdGlvbnMpOg0KPiAgICAgICByZXN1bHQgPSB2bS5xbXBfbG9nKCdibG9ja2Rldi1jcmVhdGUn
LCBqb2JfaWQ9J2pvYjAnLCBvcHRpb25zPW9wdGlvbnMsDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9x
ZW11LWlvdGVzdHMvMjEzIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzIxMw0KPiBpbmRleCAzZDJjMDI0
Mzc1Li4yM2YzODdhYjYzIDEwMDc1NQ0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMjEzDQo+
ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yMTMNCj4gQEAgLTIzLDggKzIzLDggQEANCj4gICBp
bXBvcnQgaW90ZXN0cw0KPiAgIGZyb20gaW90ZXN0cyBpbXBvcnQgaW1nZm10DQo+ICAgDQo+IC1p
b3Rlc3RzLnNjcmlwdF9pbml0aWFsaXplKHN1cHBvcnRlZF9mbXRzPVsndmhkeCddKQ0KPiAtaW90
ZXN0cy52ZXJpZnlfcHJvdG9jb2woc3VwcG9ydGVkPVsnZmlsZSddKQ0KPiAraW90ZXN0cy5zY3Jp
cHRfaW5pdGlhbGl6ZShzdXBwb3J0ZWRfZm10cz1bJ3ZoZHgnXSwNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3VwcG9ydGVkX3Byb3RvY29scz1bJ2ZpbGUnXSkNCj4gICANCj4gICBkZWYg
YmxvY2tkZXZfY3JlYXRlKHZtLCBvcHRpb25zKToNCj4gICAgICAgcmVzdWx0ID0gdm0ucW1wX2xv
ZygnYmxvY2tkZXYtY3JlYXRlJywgam9iX2lkPSdqb2IwJywgb3B0aW9ucz1vcHRpb25zLA0KPiAN
Cg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

