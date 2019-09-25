Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B66AC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26C2321D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wJx2M1Rv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C2321D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD7CB-0007SU-ML
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 09:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD6qq-0003bB-WB
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD6qp-0005Ae-BM
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:57:00 -0400
Received: from mail-eopbgr150135.outbound.protection.outlook.com
 ([40.107.15.135]:15797 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iD6qo-0005AM-MR; Wed, 25 Sep 2019 08:56:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIFoO655rCdqIO2d4PyxuCIdDor0oAdJZCiUyRKrnbJx2CDf0wa06I2GFYw0g4TaaYLxmGHV4lC7ek2tSGNfW9RWCX/UZFJNFbUdYaQdfD6Sh8mPP1cmVUl3wrCr07oyvDIDK/7iA6QpwGKQks2X/+tOqQ+Zh5tWl0MoAQtFrmWT0snnA895SQDSqw0OJqlhXAbFI/ZOUGjhLQ+Un2c0cphHNiFOTjPuhwmDwdS0sqYu3lVEdzM+do6xDu1QYf8h3P6T/XaQsUDHF76r2ifKOnXx62ap7KtCyctWiUQbx7Xz78Gs+ld9ufkEU39xQmoI+j64BVRlFgiH+hpDP0zxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awfDsFwRMhfEOuE/DETgYhu9TrFG41sMRXRC4vB8LuQ=;
 b=BmjKpUPr8TSFQ+QOevSJQrx44whyg19vY2AezxI7cDGlz4C+HlBpNnbf49L9bvSgy6n8iG7j68mouw0teZWBOjBFDiuvrhyEgiqOZubOUe+qs8u6cDGvHXFuvWL6w4MQPsrwT4IbKoeGlOdlhIA0nKj2bs20O7ILcad8zcnvNT2U9Pt77T+KrAcQL/EzZzt1g1VXh0K+nJxli56rHlnfmTYOoBUhtPYMd5ABEO5SmmqvY7nKJ1HH28R4pMW0l84CrLuA0aUZpS5SAslahhejPUzJfKGgVHHKlcqvO1BxalojABAZqT8N9tjsqe1EYsWNVPonn8KB1uBx7lZvP9hKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awfDsFwRMhfEOuE/DETgYhu9TrFG41sMRXRC4vB8LuQ=;
 b=wJx2M1RvT0OBlZcWXtyPqGJTXDTliL6DYuDW5wcWPPf7+470ME4ZZPcljdOhXusr7kuv4izQ2Q4eP/VQRiTqEy0eWv673mFgOU7hhZikEiRrMuNTAxejBKWeKU58TN1Ahf/mq6tmViMTv9R3bheVDJDbwpgP+tDoyKjt3nyly0Y=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5497.eurprd08.prod.outlook.com (52.133.240.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 25 Sep 2019 12:56:56 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 12:56:55 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 07/22] blkverify: Implement .bdrv_recurse_can_replace()
Thread-Topic: [PATCH 07/22] blkverify: Implement .bdrv_recurse_can_replace()
Thread-Index: AQHVb8i1KdK8X/qXTUulZMXz4xb+tKc8YdaA
Date: Wed, 25 Sep 2019 12:56:55 +0000
Message-ID: <02057dd7-ce3a-a5ff-41c3-35a607ea6301@virtuozzo.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-8-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-8-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0049.eurprd04.prod.outlook.com
 (2603:10a6:3:19::17) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190925155653006
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 346a83fa-b820-44a5-e4bc-08d741b7d7d9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5497; 
x-ms-traffictypediagnostic: DB8PR08MB5497:
x-microsoft-antispam-prvs: <DB8PR08MB54977D4B43208DD48D513329C1870@DB8PR08MB5497.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(346002)(366004)(136003)(39850400004)(199004)(189003)(66946007)(66446008)(2616005)(64756008)(476003)(66556008)(66476007)(486006)(26005)(186003)(31686004)(52116002)(76176011)(99286004)(14454004)(478600001)(6436002)(6486002)(6246003)(6512007)(446003)(66066001)(11346002)(256004)(7736002)(305945005)(71200400001)(71190400001)(81156014)(8676002)(81166006)(6116002)(229853002)(4326008)(3846002)(25786009)(2501003)(110136005)(2906002)(54906003)(8936002)(5660300002)(316002)(386003)(102836004)(6506007)(36756003)(86362001)(31696002)(142923001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5497;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HxYeRI7VuEF3PZtBTeTnSug8xHxta9Amtq458rQWqQ4zAvGHwMAkTXddsFVioMX1hoJN0J7RzgLf5rhxgEE2VV/NyAARBW873Iu/QIO8oYcp5Ca02tymiLhN5Y5TrJ7Z+eUevABCnqBfUr4rzxlX2UyfhmI9bq0zvZ+fQdTKNnicB8rr1rlYEDfadLknlnPWuuU3/yZEt2Cf9NttrfY5QkpkJxXtMBpsk5/lElMDbzWhlMSmAuGIYm1fUu3k4eaWXOT0cXuLl4Z6Yw+a9mI3BqYzmYY2tCJz+C25ALfZkZfhaVEkRKd0ZQbROWGE6rvPOQLo5HGdsNyi3TTr91Z0R5u8l1w1pw0tahyELARHluXs0AFrlNgfngvs/6Gwu6C+FPv3cREY2XKm7Yujb1AM2/UukLZvPzrllEF6XsYnCPs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D54D9D424545CD4984F12F63F338B171@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346a83fa-b820-44a5-e4bc-08d741b7d7d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 12:56:55.3697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gPyWAxFTMVA0z4zMjHD4JiyaUBdAvUhEV+JFeqm0v8//uY1rkM2byDIZFQ55r4nBH9Ob8DSykD7B8ktqeUWbXGySRVoXzzovId8XP526g5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5497
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.135
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDkuMjAxOSAxODoyNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXgg
UmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBibG9jay9ibGt2ZXJpZnkuYyB8
IDE1ICsrKysrKysrKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svYmxrdmVyaWZ5LmMgYi9ibG9jay9ibGt2ZXJpZnku
Yw0KPiBpbmRleCAzMDRiMGExMzY4Li4wYWRkM2FiNDgzIDEwMDY0NA0KPiAtLS0gYS9ibG9jay9i
bGt2ZXJpZnkuYw0KPiArKysgYi9ibG9jay9ibGt2ZXJpZnkuYw0KPiBAQCAtMjgyLDYgKzI4Miwy
MCBAQCBzdGF0aWMgYm9vbCBibGt2ZXJpZnlfcmVjdXJzZV9pc19maXJzdF9ub25fZmlsdGVyKEJs
b2NrRHJpdmVyU3RhdGUgKmJzLA0KPiAgICAgICByZXR1cm4gYmRydl9yZWN1cnNlX2lzX2ZpcnN0
X25vbl9maWx0ZXIocy0+dGVzdF9maWxlLT5icywgY2FuZGlkYXRlKTsNCj4gICB9DQo+ICAgDQo+
ICtzdGF0aWMgYm9vbCBibGt2ZXJpZnlfcmVjdXJzZV9jYW5fcmVwbGFjZShCbG9ja0RyaXZlclN0
YXRlICpicywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJs
b2NrRHJpdmVyU3RhdGUgKnRvX3JlcGxhY2UpDQo+ICt7DQo+ICsgICAgQkRSVkJsa3ZlcmlmeVN0
YXRlICpzID0gYnMtPm9wYXF1ZTsNCj4gKw0KPiArICAgIC8qDQo+ICsgICAgICogYmxrdmVyaWZ5
IHF1aXRzIHRoZSB3aG9sZSBxZW11IHByb2Nlc3MgaWYgdGhlcmUgaXMgYSBtaXNtYXRjaA0KPiAr
ICAgICAqIGJldHdlZW4gYnMtPmZpbGUtPmJzIGFuZCBzLT50ZXN0X2ZpbGUtPmJzLiAgVGhlcmVm
b3JlLCB3ZSBrbm93DQo+ICsgICAgICoga25vdyB0aGF0IGJvdGggbXVzdCBtYXRjaCBicyBhbmQg
d2UgY2FuIHJlY3Vyc2UgZG93biB0byBlaXRoZXIuDQo+ICsgICAgICovDQo+ICsgICAgcmV0dXJu
IGJkcnZfcmVjdXJzZV9jYW5fcmVwbGFjZShicy0+ZmlsZS0+YnMsIHRvX3JlcGxhY2UpIHx8DQo+
ICsgICAgICAgICAgIGJkcnZfcmVjdXJzZV9jYW5fcmVwbGFjZShzLT50ZXN0X2ZpbGUtPmJzLCB0
b19yZXBsYWNlKTsNCg0KT2ssIG5vdyBJIHVuZGVyc3RhbmQsIHdoYXQgYmRydl9yZWN1cnNlX2Nh
bl9yZXBsYWNlIGFjdHVhbGx5IGRvZXM6DQoNCkl0IHNlYXJjaGVzIGZvciB0b19yZXBsYWNlIGlu
IGJzLXJvb3RlZCBzdWJ0cmVlLCBnb2luZyBvbmx5IHRocm91Z2ggZXF1YWwNCmNoaWxkcmVuLi4N
Cg0KU28sIHdlIGNhbiByZXBsYWNlIEB0b19yZXBsYWNlLCBieSBzb21ldGhpbmcgZXF1YWwgdG8g
QGJzLCBpZiBAdG9fcmVwbGFjZSBpcw0KaW4gZXF1YWwtc3VidHJlZSBvZiBAYnMuDQoNCkknbGwg
dHJ5IHRvIGV4cGxhaW4gbXkgbWlzbGVhZGluZzoNCg0KYmRydl9yZWN1cnNlX2Nhbl9yZXBsYWNl
IGRlY2xhcmF0aW9uIGxvb2tzIGxpa2UgYnMgYW5kIHRvX3JlcGxhY2UgbWF5IGJlIGFic29sdXRl
bHkNCnVucmVsYXRlZCBub2Rlcy4gU28sIHdoeSBicyBzaG91bGQgZGVjaWRlLCBjYW4gd2UgcmVw
bGFjZSB0aGUgdW5yZWxhdGVkIHRvX3JlcGxhY2UNCm5vZGUgYnkgc29tZXRoaW5nLi4NCg0KU28s
IGl0IG1heSBiZSBzaW1wbGVyIHRvIGZvbGxvdywgaWYgaXQgd2FzIGNhbGxlZCBiZHJ2X3JlY3Vy
c2VfZmlsdGVyZWRfc3VidHJlZSwgb3INCmJkcnZfcmVjdXJzZV90cmFuc3BhcmVudF9zdWJ0cmVl
Li4NCg0KU3RpbGwsIG5vdyBJIHVuZGVyc3RhbmQsIGFuZCBkb24ndCBjYXJlLiBJdCdzIGJldHRl
ciBhbnl3YXkgdGhhbiBiZHJ2X3JlY3Vyc2VfaXNfZmlyc3Rfbm9uX2ZpbHRlcg0KDQo+ICt9DQo+
ICsNCj4gICBzdGF0aWMgdm9pZCBibGt2ZXJpZnlfcmVmcmVzaF9maWxlbmFtZShCbG9ja0RyaXZl
clN0YXRlICpicykNCj4gICB7DQo+ICAgICAgIEJEUlZCbGt2ZXJpZnlTdGF0ZSAqcyA9IGJzLT5v
cGFxdWU7DQo+IEBAIC0zMjgsNiArMzQyLDcgQEAgc3RhdGljIEJsb2NrRHJpdmVyIGJkcnZfYmxr
dmVyaWZ5ID0gew0KPiAgIA0KPiAgICAgICAuaXNfZmlsdGVyICAgICAgICAgICAgICAgICAgICAg
ICAgPSB0cnVlLA0KPiAgICAgICAuYmRydl9yZWN1cnNlX2lzX2ZpcnN0X25vbl9maWx0ZXIgPSBi
bGt2ZXJpZnlfcmVjdXJzZV9pc19maXJzdF9ub25fZmlsdGVyLA0KPiArICAgIC5iZHJ2X3JlY3Vy
c2VfY2FuX3JlcGxhY2UgICAgICAgICA9IGJsa3ZlcmlmeV9yZWN1cnNlX2Nhbl9yZXBsYWNlLA0K
DQppdCB3aWxsIGJlIG5ldmVyIGNhbGxlZCwgYXMgYmRydl9yZWN1cnNlX2Nhbl9yZXBsYWNlIGhh
bmRsZXMgZmlsdGVycyBieSBpdHNlbGYuDQoNCj4gICB9Ow0KPiAgIA0KPiAgIHN0YXRpYyB2b2lk
IGJkcnZfYmxrdmVyaWZ5X2luaXQodm9pZCkNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpW
bGFkaW1pcg0K

