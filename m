Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B719C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26150233A1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WUnl6kFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26150233A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i59Ey-0005Kf-LY
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i59AZ-0000Wm-4N
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:48:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i59AX-0002hb-CS
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:48:26 -0400
Received: from mail-eopbgr70121.outbound.protection.outlook.com
 ([40.107.7.121]:19874 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i59AW-0002ff-Pq; Tue, 03 Sep 2019 09:48:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzXaj98ViA5rmyNo7L9G5okOq9YnIKiEnk27x+P0R9mmUHAHgy5jZQAaZN3qYc+30NAwOdpjUspZ1W3x8zK05ak/oNdp+MwYzaRin6Z5NN247xkYEAL8Qa+W8q55BGeLDnyaTOwwPLdgYyebGVd7H04p7Q7bTMDfZ3hjha8IFoJI2OJ1fs08vQiVhhjaDL0/yYbD7QpXoTK3rItJ1fNIe54PvJ8GE3h4jVceQ/8JJZmYmRp+K5v6o/cpT2JZwfhY2CCHJkjx4QkpGulodKKvh1dOoueWPS/Q1pr/CxcDxq+ZP6QUlyrwJxwBA20RiJiWMqr08joWu2gh5QGflSCFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMRSvflZGVd4gw+t4zrfNgqHIvyS8hN8jXyk4VLDxAw=;
 b=Wo4+7xwHsYP6rgyqd656RL+UUr0isKbCoY2E5TJDKbEP/flbuJufZQb2SFk7ir7Bf8tTW7JQeP9OnirSgXvyWOyln2+8vE8yju1K1voyHpkfg4IoXnW1JphnT1XEhEjV9dw56viRhbY7xsXLylzFFgLu9umpb6hhm4iTF0My0/pvhP4HxUyK4WPCm/cGkJr0guf7gSPpsMPxMgBQYp6QDuyzMa2FK3YG+he/Onb8JJfxGHqNIx82khXB8fUY/FgmeTdcU4erR4jGb9QEtzE8dPS2/dzL7P+Q28E01nzjVvmbt5DOcXYXJJo0TwpREON/fJVjbkuHnH8NkYTvH3M9eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMRSvflZGVd4gw+t4zrfNgqHIvyS8hN8jXyk4VLDxAw=;
 b=WUnl6kFrZtBdbRWdEzdmiz4o7fJseld2ps/yQ/2j1a0T4lY8eYXQMMfD5EmXtUPC5D/XzfUlq/BZYVDz7R/mJDaLy1mqV742k7JZN26/WAt2E46Oj3RGzEosJ5/gr90DvLDJ9x3BPkqf4AROIpquPJeP6Bea1TjYEfVMZ4iKSeU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5036.eurprd08.prod.outlook.com (10.255.19.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 3 Sep 2019 13:48:20 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2220.022; Tue, 3 Sep 2019
 13:48:19 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH] iotests: skip 232 when run tests as root
Thread-Index: AQHVYlzWhsGnHW/AKk6BpT+/SBkr1acZ978A
Date: Tue, 3 Sep 2019 13:48:19 +0000
Message-ID: <691c717f-1ae1-d7fd-3124-1f84671bb539@virtuozzo.com>
References: <20190903132110.380933-1-vsementsov@virtuozzo.com>
 <20190903133810.GI4582@localhost.localdomain>
In-Reply-To: <20190903133810.GI4582@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::31) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190903164816827
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fa26e68-4fc6-404d-6700-08d73075612b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5036; 
x-ms-traffictypediagnostic: DB8PR08MB5036:
x-microsoft-antispam-prvs: <DB8PR08MB50363D626D604329144E3A5FC1B90@DB8PR08MB5036.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(39840400004)(346002)(136003)(396003)(189003)(199004)(6436002)(7736002)(8676002)(81166006)(229853002)(71190400001)(6246003)(6116002)(66556008)(66446008)(305945005)(66946007)(66476007)(64756008)(8936002)(316002)(53936002)(81156014)(446003)(2906002)(86362001)(36756003)(31696002)(14454004)(11346002)(31686004)(2616005)(476003)(5660300002)(66066001)(486006)(99286004)(386003)(186003)(102836004)(6506007)(26005)(25786009)(4326008)(6486002)(478600001)(6512007)(256004)(71200400001)(3846002)(76176011)(6916009)(54906003)(14444005)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5036;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vOYV9jAwPH8FR2oqB56vdurs5npo86qZ7qEPjr4LNCKv964iwYXsvqV//1iyIddEjW7IcCLJxNNkvuS7IctWuZkklTWfIn94lTtWaE4XnYBlahupWsF9Bh5Qr/v/KwbJuXojIGqiXtX0Hq5sRzZTWGtz3dUtDbYR9Wijk0xpb1VU9I7mdqyEadqvtHYK4094lKZ9roSZeZHjvjcuQYbpV51/53GGm4IVzScl+CwS6osC3D4xpsdg3ovWZxP6QwDJfEOO7vZM4BRMJc4U3YO1sBHZZYRga0UDWs3+rvR+r47ixz9zX003C9OwYakxIhntjOSdUugAkhQUI8oAuv7r37rnBEOXOhtQHnOLiZHpZts6kIFtIZLOXM1igry1n+oSx9gaoazsww+IeffhsZkRTIPQ+oxYe6GeWM+RgXb0EwM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <86F46912175B29429D215A7A3B9E968F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa26e68-4fc6-404d-6700-08d73075612b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 13:48:19.7737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJiRdIhm6FoTo+u/STUlvbWy1vHKpyZtoYDns+1bW4BkzUqvpH3Xfoe8F/biQYWZdd8QLygXPNzGB8XkjjH0uG9NOMEKIorh9Y5ek09dTzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5036
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.121
Subject: Re: [Qemu-devel] [PATCH] iotests: skip 232 when run tests as root
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDMuMDkuMjAxOSAxNjozOCwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMDMuMDkuMjAxOSB1bSAx
NToyMSBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IGNo
bW9kIGEtdyBkb24ndCBoZWxwIHVuZGVyIHJvb3QsIHNvIHNraXAgdGhlIHRlc3QgaW4gc3VjaCBj
YXNlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkg
PHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IC0tLQ0KPj4NCj4+ICAgdGVzdHMvcWVtdS1p
b3Rlc3RzLzIzMiB8IDYgKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzIzMiBiL3Rlc3RzL3Fl
bXUtaW90ZXN0cy8yMzINCj4+IGluZGV4IDIwNjNmNzg4NzYuLmRhMzVhNjNkODUgMTAwNzU1DQo+
PiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMjMyDQo+PiArKysgYi90ZXN0cy9xZW11LWlvdGVz
dHMvMjMyDQo+PiBAQCAtNzAsNiArNzAsMTIgQEAgc2l6ZT0xMjhNDQo+PiAgIA0KPj4gICBfbWFr
ZV90ZXN0X2ltZyAkc2l6ZQ0KPj4gICANCj4+ICtjaG1vZCBhLXcgJFRFU1RfSU1HDQo+PiArKGVj
aG8gdGVzdCA+ICRURVNUX0lNRykgMj4vZGV2L251bGwgJiYgXA0KPj4gKyAgICBfbm90cnVuICJS
ZWFkb25seSBhdHRyaWJ1dGUgaXMgaWdub3JlZCwgcHJvYmFibHkgeW91IHJ1biB0aGlzIHRlc3Qg
YXMiIFwNCj4+ICsgICAgICAgICAgICAicm9vdCwgd2hpY2ggaXMgdW5zdXBwb3J0ZWQuIg0KPj4g
K2NobW9kIGErdyAkVEVTVF9JTUcNCj4+ICsNCj4+ICAgaWYgWyAtbiAiJFRFU1RfSU1HX0ZJTEUi
IF07IHRoZW4NCj4+ICAgICAgIFRFU1RfSU1HPSRURVNUX0lNR19GSUxFDQo+PiAgIGZpDQo+IA0K
PiBJIHRoaW5rIHlvdSBuZWVkIHRvIG1vdmUgdGhlIG5ldyBjaGVjayBiZWxvdyB0aGlzIHNvIHRo
YXQgJFRFU1RfSU1HX0ZJTEUNCj4gaXMgY29uc2lkZXJlZCBiZWNhdXNlIG90aGVyd2lzZSB0aGUg
dGVzdCB3aWxsIGZhaWwgZm9yIGx1a3M6DQo+IA0KPiArY2htb2Q6IGNhbm5vdCBhY2Nlc3MgJ2Ry
aXZlcj1sdWtzLGtleS1zZWNyZXQ9a2V5c2VjMCxmaWxlLmZpbGVuYW1lPS9ob21lL2t3b2xmL3Nv
dXJjZS9xZW11L3Rlc3RzL3FlbXUtaW90ZXN0cy9zY3JhdGNoL3QubHVrcyc6IE5vIHN1Y2ggZmls
ZSBvciBkaXJlY3RvcnkNCj4gK2NobW9kOiBjYW5ub3QgYWNjZXNzICdkcml2ZXI9bHVrcyxrZXkt
c2VjcmV0PWtleXNlYzAsZmlsZS5maWxlbmFtZT0vaG9tZS9rd29sZi9zb3VyY2UvcWVtdS90ZXN0
cy9xZW11LWlvdGVzdHMvc2NyYXRjaC90Lmx1a3MnOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5
DQo+IA0KDQpUaGFua3MsIHdpbGwgcmVzZW5kDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFk
aW1pcg0K

