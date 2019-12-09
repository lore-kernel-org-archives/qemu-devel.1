Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B45DC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 17:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8F6207FF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 17:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="q3UPeR9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8F6207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieMfa-0006YF-2G
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 12:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ieMeo-0005xf-1W
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:17:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ieMem-0002db-Mx
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:17:13 -0500
Received: from mail-eopbgr70100.outbound.protection.outlook.com
 ([40.107.7.100]:31041 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ieMeh-0002QT-TX; Mon, 09 Dec 2019 12:17:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5e+4d22IJujC7xFolmbrj7fL4o0tznBx0ScTpzcRC/xngQjXSbGO4dIcgGOjK7QxTaD/q1SznXldSLf6h28SP9nhBYzC7Bse8sTSSnIeEC/GGc+iAevn1VzTAgr85uRcCEzI4d3R6spjIvsLEs6vJZxccz1vaQ8Lq0Qd+9yseqUnbyA8uU6DssBYKF9DrOt35hCenrOQURFN5vTM677YR34mc2LQzZ47w5+t07c5KkESaKEQdMLpMBZZeMahzjKfYLKrLG/V/8LMQagBYSH8QjgojKv2m0kmbCzfnua5pIdXnUVBPu7FYojGHy6pUSuvrSmpdLkVyUSdPlU8NJdeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLq8/FLdrUKwP5cVstZzueUUURdRXPc6iqqtwCrNspY=;
 b=l0hLfqx54ofKJc59/0mJtJyh/79H2lcLgzhDdia4xth9wFjai4oz1dmNjneyZ56lVk1HdBiCFA4p4ZIMHDeqeJ7spiQaNwyhutGxs+iPr0axeRR5HWf6ALJdNzWKuwpKt/peM97ry+x4u+AskFQb6jgSD+IyqFLFGz1bq8afnuXSBqwUoacTry04/8NSl4l3V8oAs4dmYWY6t/hnZFoB/Lw2KEAdBJCLocOpBLR0N13vCL6/nIb52f/d2Fh6ars5Q19irglE9yGIpHKzIHtozD2XJdtZl66Z88cI8FKgEMBAVooA+UjPZ91bj2V3CUrsDA8/nbtLM1h/auxJ5Mt9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLq8/FLdrUKwP5cVstZzueUUURdRXPc6iqqtwCrNspY=;
 b=q3UPeR9V4Md01j9fEOMLP8YnH85aqIv0tIqXB7hQyBR0/vNIKBh3g7N1qMjiOe7o8gl084c8t8dlEaysUvlCSO1yqiLuGqi7A8uMQFRy2qDM2LBPIKYHnwTi2H4L7bfGfCNI3I/ctaj9ZwyDMsPkKY5SNC+dgRjEYO3GIBnxtls=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5285.eurprd08.prod.outlook.com (20.179.0.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Mon, 9 Dec 2019 17:17:04 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 17:17:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2] migration/dirty-bitmaps: change bitmap enumeration
 method
Thread-Topic: [PATCH v2] migration/dirty-bitmaps: change bitmap enumeration
 method
Thread-Index: AQHVCpJiO5csnRf0D0OxXxQO3Uu316eu9JAAgAQ/U4CAAAEEgIAAHuSA
Date: Mon, 9 Dec 2019 17:17:03 +0000
Message-ID: <44c32a7a-daf4-41ec-66d8-4f79288c01e0@virtuozzo.com>
References: <20190514201926.10407-1-jsnow@redhat.com>
 <aab4e1c7-37eb-5b3e-26d2-fca33ba87662@virtuozzo.com>
 <d164961f-4da7-3678-2f56-5486cee3d07d@redhat.com>
 <748a473b-07c6-73b1-ab91-40886fb55cd5@redhat.com>
In-Reply-To: <748a473b-07c6-73b1-ab91-40886fb55cd5@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0164.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::12) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191209201701881
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27aa0c21-a73c-4d41-9ada-08d77ccb9c24
x-ms-traffictypediagnostic: AM6PR08MB5285:
x-microsoft-antispam-prvs: <AM6PR08MB528570B05B101F16C19BAB96C1580@AM6PR08MB5285.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(396003)(346002)(366004)(136003)(376002)(52314003)(199004)(189003)(6486002)(66446008)(229853002)(64756008)(66946007)(66476007)(66556008)(71200400001)(71190400001)(2906002)(6512007)(186003)(26005)(53546011)(110136005)(6506007)(36756003)(52116002)(316002)(305945005)(86362001)(2616005)(8936002)(31686004)(478600001)(5660300002)(31696002)(81166006)(966005)(81156014)(8676002)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5285;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3nm+DmeKJ21ak8qyPT6w8KtrhHq5ADPya4bWsy5oz1TakAO6VDzPViIcpFlit8uWQHKUaLNsTLMZWRXulDypZ1tLrwdZC+z9y+YHSZZjYCW2l4DkyX71w2C0B5c0ICHKXM/5t9ib7YnEkrtUd6Jfnc8UbOEbmYGwZLVjuTikKqp3TCSpYPddJHikGuyC2A30J/3lZNbjhzlLWBdoPFytMkIfXRrJHMbLHPv88LP5fL2vQXCSIFGij+c6jo/dUnV45Xfg+rbFZjjaE5LT/Cj2DJhI8OsSoFOdrmZfBVH54A8CD1X7GGGrDg6U/oSSdiAoqgqD2WQzn+lu1kx0R1ed+GLkirKblbTmmUybrAqM2/LU3U1ltOGnpj4D/XrftdP9jESF3hw/ulMXx7fOxX3E3ejGP2wSdDLaalBWhNfgaR/FB9uhqGPQIohN/YiKLrwiyhJk8qJ+r/0x7XN8fFedQWZ7RYF0U+ffmX7Y+ageZFTAiybMAYza73EcBcuCPVsbb8EksxJyT9npDj0zoRjOJvNCKEvqRh1/ouMIV/CmrI+7m9asqlVdEPcygma70pZr
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC575B4FBC15C848ABCA6B8D514CD5BD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27aa0c21-a73c-4d41-9ada-08d77ccb9c24
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 17:17:03.8593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZW4F0KiLSlcNDv293+BIsbSU5Cwgzj7KqmNUzkBJnSLah4aBOrFMbHvGVqXRHRcmN/Rq7kFSYA3lBN9ddnvN9nky3biZZ9hC82TzBmqM38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5285
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.100
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMTIuMjAxOSAxODoyNiwgSm9obiBTbm93IHdyb3RlOg0KPiAob2ZmIGxpc3QpDQo+IA0KPiBP
biAxMi85LzE5IDEwOjIyIEFNLCBKb2huIFNub3cgd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDEyLzYv
MTkgNTozMSBQTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+PiAxNC4w
NS4yMDE5IDIzOjE5LCBKb2huIFNub3cgd3JvdGU6DQo+Pj4+IFNoaWZ0IGZyb20gbG9va2luZyBh
dCBldmVyeSByb290IEJEUyB0byAqZXZlcnkqIEJEUy4gVGhpcyB3aWxsIG1pZ3JhdGUNCj4+Pj4g
Yml0bWFwcyB0aGF0IGFyZSBhdHRhY2hlZCB0byBibG9ja2RldiBjcmVhdGVkIG5vZGVzIGluc3Rl
YWQgb2YganVzdCBvbmVzDQo+Pj4+IGF0dGFjaGVkIHRvIGVtdWxhdGVkIHN0b3JhZ2UgZGV2aWNl
cy4NCj4+Pj4NCj4+Pj4gTm90ZSB0aGF0IHRoaXMgd2lsbCBub3QgbWlncmF0ZSBhbm9ueW1vdXMg
b3IgaW50ZXJuYWwtdXNlIGJpdG1hcHMsIGFzDQo+Pj4+IHRob3NlIGFyZSBkZWZpbmVkIGFzIGhh
dmluZyBubyBuYW1lLg0KPj4+Pg0KPj4+PiBUaGlzIHdpbGwgYWxzbyBmaXggdGhlIENvdmVyaXR5
IGlzc3VlcyBQZXRlciBNYXlkZWxsIGhhcyBiZWVuIGFza2luZw0KPj4+PiBhYm91dCBmb3IgdGhl
IHBhc3Qgc2V2ZXJhbCByZWxlYXNlcywgYXMgd2VsbCBhcyBmaXhpbmcgYSByZWFsIGJ1Zy4NCj4+
Pj4NCj4+Pj4gUmVwb3J0ZWQtYnk6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJv
Lm9yZz4NCj4+Pj4gUmVwb3J0ZWQtYnk6IENvdmVyaXR5IPCfmIUNCj4+Pg0KPj4+IFdoYXQgd2Fz
IHRoZSBjb3Zlcml0eSBudW1iZXIgKEkgZG9uJ3QgYmVsaWV2ZSB0aGF0IGl0IHdhcyBzbWlsZTop
Pw0KPj4+DQo+Pg0KPj4gICAgICBSZXBvcnRlZC1ieTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5
ZGVsbEBsaW5hcm8ub3JnPg0KPj4gICAgICBSZXBvcnRlZC1ieTogQ292ZXJpdHkg8J+YhQ0KPj4g
ICAgICBSZXBvcnRlZC1ieTogYWlodWEgbGlhbmcgPGFsaWFuZ0ByZWRoYXQuY29tPg0KPj4gICAg
ICBSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2
aXJ0dW96em8uY29tPg0KPj4gICAgICBTaWduZWQtb2ZmLWJ5OiBKb2huIFNub3cgPGpzbm93QHJl
ZGhhdC5jb20+DQo+PiAgICAgIE1lc3NhZ2UtaWQ6IDIwMTkwNTE0MjAxOTI2LjEwNDA3LTEtanNu
b3dAcmVkaGF0LmNvbQ0KPj4gICAgICBGaXhlczogaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29t
L3Nob3dfYnVnLmNnaT9pZD0xNjUyNDkwDQo+PiAgICAgIEZpeGVzOiBDb3Zlcml0eSBDSUQgMTM5
MDYyNQ0KDQpBaCwgbWlzc2VkIGl0LCBzb3JyeS4NCg0KPj4gICAgICBDQzogU3RlZmFuIEhham5v
Y3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPg0KPj4gICAgICBTaWduZWQtb2ZmLWJ5OiBKb2huIFNu
b3cgPGpzbm93QHJlZGhhdC5jb20+DQo+Pg0KPj4NCj4+PiBEbyBzb21lb25lIGtub3csIHRoYXQg
dGhpcyBwYXRjaCBmaXhlcyB2ZXJ5LXZlcnktdmVyeSB0ZXJyaWJsZSBidWc/DQo+Pj4NCj4+PiBC
ZWZvcmUgdGhpcyBwYXRjaCwgaGVyZSB3ZXJlIGJkcnZfbmV4dC1iYXNlZCBsb29wLCB3aXRoIGV4
aXN0cyBmcm9tIGl0LA0KPj4+IGJ1dCBub3QgdXNpbmcgYmRydl9uZXh0X2NsZWFudXAoKS4gVGhp
cyBsZWFkcyB0byBsZWFrZWQgKGluY3JlbWVudGVkKSByZWZjbnQgb2YNCj4+PiBiZHMgb24gYW55
IGZhaWx1cmUgZHVyaW5nIHRoaXMgbG9vcCENCj4+Pg0KPj4+IE5vdyB3ZSBmYWNlZCB0aGlzIGJ1
ZywgaW4gUmhlbC1iYXNlZCBRZW11LCBzbyBJIHN0cm9uZ2x5IHJlY29tbWVuZCB0byBmaXggaXQg
aW4gUmhlbC4NCj4+DQo+PiBPSywgdGhpcyB3YXMgZml4ZWQgZm9yIDQuMSwgYW5kIHdhcyBpbnRy
b2R1Y2VkIGluIGIzNWViZGYwNzZkIGZvcg0KPj4gMi4xMi4wLCBzbyBhbGwgdmVyc2lvbnMgYmV0
d2VlbiBoYXZlIHRoZSBwcm9ibGVtLg0KPj4NCj4gDQo+IEFzIGZhciBhcyBJIGtub3csIHdlIGRv
bid0ICJzdXBwb3J0IiBpbmNyZW1lbnRhbCBiYWNrdXAgZm9yIFJIRUwgYmFzZWQNCj4gcGFja2Fn
ZXMsIGJlY2F1c2Ugd2Ugb25seSBzdXBwb3J0IHdoYXQgeW91IGNhbiBkbyBkaXJlY3RseSB0aHJv
dWdoDQo+IGxpYnZpcnQuIEFuZCBzaW5jZSBSSEVMIGxpYnZpcnQgZG9lc24ndCBoYXZlIGluY3Jl
bWVudGFsIGJhY2t1cCwgLi4uDQo+IA0KPiBJIGNhbiB0cnkgdG8gZml4IGl0IGFueXdheSwgdGhv
dWdoLCBpZiBpdCBtYWtlcyB5b3VyIGxpZmUgZWFzaWVyIGVzcGVjaWFsbHkuDQoNCk5vLCBhY3R1
YWxseSwgaXQncyBubyByZWFsIGRpZmZlcmVuY2UsIG5vdyB3ZSBmaXhlZCBpdCBpbiBvdXIgYnJh
bmNoLg0KU28sIGl0J3MgdXAgdG8geW91Lg0KDQo+IA0KPiBXaGljaCB2ZXJzaW9uKHMpIGFyZSB5
b3UgdXNpbmc/DQoNCjIuMTIuMC0zMw0KDQo+IEknbGwgdHJ5IHRvIHRhcmdldCBhIGZpeCBmb3Ig
dGhhdA0KPiB2ZXJzaW9uLCBidXQgaXQgd2lsbCBsaWtlbHkgYmUgYSBzcGVjaWFsIGZpeCB0aGF0
IGp1c3QgZml4ZXMgdGhlIGxlYWsNCj4gd2l0aG91dCBjaGFuZ2luZyB0aGUgZW51bWVyYXRpb24g
bWV0aG9kLCB0byBrZWVwIG1pZ3JhdGlvbiBBQkkNCj4gY29uc2lzdGVudCB3aXRoIHdoYXQgd2Ug
ZXhwZWN0IGZyb20gdGhlIGRpZmZlcmVudCB2ZXJzaW9ucy4NCj4gDQo+IC0tanMNCj4gDQoNCg0K
LS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

