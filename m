Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B4BC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478012176D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sKEdnhf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478012176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iah9c-0006Gv-DK
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 09:21:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iah0p-0001Fr-3L
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:12:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iah0m-0008MR-0N
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:12:45 -0500
Received: from mail-ve1eur01on0714.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::714]:11519
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iah0i-0007zi-I6
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:12:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShTTUbprhdwm4w8gadhPrBYtR2kEhqDYtCzqg5W66TxxZl6YrJd7gfonPfgkw4KaYzv3VgYrSzGvrS0hr85QUahzuRf7jaopCbbBPF4zqKrK9fdoSxJJAHrjB/bz51TazwFipn/lvSAw/kl7onXgPrePlwzznibBsMNi1oETIUpQDnL7AJNglXm4J5ixqBy6RpCQBIFVXRgknz5P9oT01MISQZSzLcvcCy6U24TRMCGQVejDx/20ZeCJMcnJZYR8IDKmQrFQfReGpFoMZ5xcE0iIXw7gf8pkFJME83TbUOjLvdq8fxJ7swUBKh+ZjbDNtv9GApnZbqy2R73AiN7QYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXQYTBQbszQ4eNqeyWWxKP0YSA/h2J+3YN7K2pYqXWc=;
 b=SMD9Sfn3NtbcJjoFo+6W0nf8osveUcgT91GWYHY996opiSm2cUG+DBZLvTkZPCmYNdMw1eNX85CiGBpfcT0Pd1m8Ci1EQVAouaS4unS5LIGJrqDwE0yEKJzevJiNE5XJEZoCFAd2y+WY3wPG9oPikhjh4xBCOqqwDqZ9a+7vUdthRWU0QhOOvr2LvjplyY/LouM2XaLxqpURiyXKTezlRwry4m5iccw+HPkh2xEZfxvQm4eR7A6nsFBvHxH6S7SZCRmdhffPKGSbxuJL5fO5B/KHCSi1LiGXyzvfRkNuc7Oc32GenqApYiuYArYu4xoYeJPjqSijvJ3m6YsZhnIXfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXQYTBQbszQ4eNqeyWWxKP0YSA/h2J+3YN7K2pYqXWc=;
 b=sKEdnhf8zbbGnZ5VZrSmBS5i+i4tPt6i3D+gM7vLgPTlygMwiDQkMLlhtf8FDQCXT3inPPa2tEqyjR8PAaptIZvSS5TxmAhADi59KkQz4n9Oyq4EHIX3OLImZaEe0qaAQ0af6HHR7LkUkB/kCLntdydRwHt8HOtzvDpRzNR/RKw=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4600.eurprd08.prod.outlook.com (20.178.88.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Fri, 29 Nov 2019 14:12:34 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 14:12:33 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6] hw/core/loader-fit: fix freeing errp in fit_load_fdt
Thread-Topic: [PATCH v6] hw/core/loader-fit: fix freeing errp in fit_load_fdt
Thread-Index: AQHVpVDHCu/hcnUjHUWYtvuOQu9NH6eiMNjUgAA0gID//84bAA==
Date: Fri, 29 Nov 2019 14:12:33 +0000
Message-ID: <48c23c62-59ed-3da7-4803-cafd14b8fe49@virtuozzo.com>
References: <20191127183016.13852-1-vsementsov@virtuozzo.com>
 <87muceeq5l.fsf@dusky.pond.sub.org>
 <4fcd8245-790e-220d-366b-ce25743dddc8@virtuozzo.com>
In-Reply-To: <4fcd8245-790e-220d-366b-ce25743dddc8@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0034.eurprd07.prod.outlook.com
 (2603:10a6:7:66::20) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129171231969
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01efece7-3cc6-40c0-bc87-08d774d62dde
x-ms-traffictypediagnostic: AM6PR08MB4600:
x-microsoft-antispam-prvs: <AM6PR08MB460048726B8C415E3F0299EDC1460@AM6PR08MB4600.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(346002)(376002)(366004)(39840400004)(189003)(199004)(256004)(14444005)(5660300002)(102836004)(478600001)(229853002)(4326008)(6486002)(25786009)(6436002)(66556008)(66476007)(66446008)(66946007)(64756008)(6506007)(31696002)(386003)(11346002)(446003)(86362001)(2616005)(186003)(6916009)(14454004)(31686004)(26005)(8936002)(54906003)(3846002)(6116002)(2906002)(99286004)(305945005)(6512007)(7736002)(52116002)(6246003)(76176011)(66066001)(316002)(36756003)(71200400001)(71190400001)(81166006)(81156014)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4600;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZBjGKbsehyFj0Ray8YP0e6Sc8kIsudOp5OgnMC0KggT5eFeWGOlPa0syzJfQht5qpD3ynxzx/zhOgdSeCNLFe2WgzmfGQTnk1ZyGkPCF79fOmzdrAShhaolvFUlZkzMBKqPKQb5yECuaS2G0OZ4hEl639g1XGeAK7/CDjM0Ol96mz27ProEftdtykhzG+KA/b35Qjmg4gUD6dPfPMgT/2zqnJ8rv22g0B6t2QfXvF3cPBIwgZTQ+RIWXam907APTA3sxfnUW+8+NlrXWKCyhkAWzMXAMfhVOR+KLIdcibUmS0/157+uR9CCnyK7VSTNbYNvIPXcRefIvwAgBe+V82ya2dO6Ser2N0HQTBkyXXWDVv0R6c/21wWN8Zgwqsv9X4YRkP2NDgxoBbU1SuKuIG058AqrLxmMkxf8SPtUjUfFPqvGiaRMqXO+oO15vFZKj
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB64EF180358994785186184B94F84B7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01efece7-3cc6-40c0-bc87-08d774d62dde
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 14:12:33.8779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WLJre2tA3sjyygRYllxwnSZLb4zOBwNxRGBL7OaM2XYbtBKaTraOzbscFFN387RROiInIVkExkEd5XX1lWGa3HEDzD+iX4LPLZcaoV9NZKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4600
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::714
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
Cc: "pburton@wavecomp.com" <pburton@wavecomp.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjkuMTEuMjAxOSAxNzoxMSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MjkuMTEuMjAxOSAxNzowMywgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+PiBWbGFkaW1pciBT
ZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+IHdyaXRlczoNCj4+
DQo+Pj4gZml0X2xvYWRfZmR0IGZvcmdldCB0byBjaGVjayB0aGF0IGVycnAgaXMgbm90IE5VTEwg
YW5kIHRvIHplcm8gaXQgYWZ0ZXINCj4+PiBmcmVlaW5nLiBGaXggaXQuDQo+Pj4NCj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1
b3p6by5jb20+DQo+Pj4gUmV2aWV3ZWQtYnk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29t
Pg0KPj4+IC0tLQ0KPj4+IMKgIGh3L2NvcmUvbG9hZGVyLWZpdC5jIHwgNSArKysrLQ0KPj4+IMKg
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pg0KPj4+
IGRpZmYgLS1naXQgYS9ody9jb3JlL2xvYWRlci1maXQuYyBiL2h3L2NvcmUvbG9hZGVyLWZpdC5j
DQo+Pj4gaW5kZXggOTUzYjE2YmM4Mi4uM2VlOWZiMmYyZSAxMDA2NDQNCj4+PiAtLS0gYS9ody9j
b3JlL2xvYWRlci1maXQuYw0KPj4+ICsrKyBiL2h3L2NvcmUvbG9hZGVyLWZpdC5jDQo+Pj4gQEAg
LTIwMCw3ICsyMDAsMTAgQEAgc3RhdGljIGludCBmaXRfbG9hZF9mZHQoY29uc3Qgc3RydWN0IGZp
dF9sb2FkZXIgKmxkciwgY29uc3Qgdm9pZCAqaXRiLA0KPj4+IMKgwqDCoMKgwqAgZXJyID0gZml0
X2ltYWdlX2FkZHIoaXRiLCBpbWdfb2ZmLCAibG9hZCIsICZsb2FkX2FkZHIsIGVycnApOw0KPj4+
IMKgwqDCoMKgwqAgaWYgKGVyciA9PSAtRU5PRU5UKSB7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
IGxvYWRfYWRkciA9IFJPVU5EX1VQKGtlcm5lbF9lbmQsIDY0ICogS2lCKSArICgxMCAqIE1pQik7
DQo+Pj4gLcKgwqDCoMKgwqDCoMKgIGVycm9yX2ZyZWUoKmVycnApOw0KPj4+ICvCoMKgwqDCoMKg
wqDCoCBpZiAoZXJycCkgew0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX2ZyZWUo
KmVycnApOw0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICplcnJwID0gTlVMTDsNCj4+PiAr
wqDCoMKgwqDCoMKgwqAgfQ0KPj4+IMKgwqDCoMKgwqAgfSBlbHNlIGlmIChlcnIpIHsNCj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgZXJyb3JfcHJlcGVuZChlcnJwLCAidW5hYmxlIHRvIHJlYWQgRkRU
IGxvYWQgYWRkcmVzcyBmcm9tIEZJVDogIik7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9
IGVycjsNCj4+DQo+PiBUaGlzIGZpeGVzIGxhdGVudCBidWdzIHdoZW4gZml0X2ltYWdlX2FkZHIo
KSBmYWlscyB3aXRoIEVOT0VOVDoNCj4+DQo+PiAqIElmIGEgY2FsbGVyIHBhc3NlcyBhIG51bGwg
QGVycnAsIHdlIGNyYXNoIGRlcmVmZXJlbmNpbmcgaXQNCj4+DQo+PiAqIEVsc2UsIHdlIHBhc3Mg
YSBkYW5nbGluZyBFcnJvciAqIHRvIHRoZSBjYWxsZXIsIGFuZCByZXR1cm4gc3VjY2Vzcy4NCj4+
IMKgwqAgSWYgYSBjYWxsZXIgZGVyZWZlcmVuY2VzIHRoZSBFcnJvciAqIHJlZ2FyZGxlc3MsIHdl
IGhhdmUgYQ0KPj4gwqDCoCB1c2UtYWZ0ZXItZnJlZS4NCj4+DQo+PiBOb3QgZml4ZWQ6DQo+Pg0K
Pj4gKiBJZiBhIGNhbGxlciBwYXNzZXMgJmVycm9yX2Fib3J0IG9yICZlcnJvcl9mYXRhbCwgd2Ug
ZGllIGluc3RlYWQgb2YNCj4+IMKgwqAgdGFraW5nIHRoZSByZWNvdmVyeSBwYXRoLg0KPiANCj4g
Tm8sIGlmIGl0IGlzIGVycm9yX2Fib3J0IG9yIGVycm9yX2ZhdGFsLCB3ZSB3aWxsIG5vdCByZWFj
aCB0aGlzIHBvaW50LCB0aGUgZXhlY3V0aW9uDQo+IGZpbmlzaGVkIGJlZm9yZSwgd2hlbiBlcnJv
ciB3YXMgc2V0Lg0KDQpBaCwgdGhhdCBpcyB3aGF0IHlvdSBtZW50aW9uLi4gSG1tLiBJcyBpdCBi
YWQ/IEF0IGxlYXN0IGNyYXNoaW5nIG9uDQplcnJvcl9hYm9ydCB3aXRob3V0IGFueSByZWNvdmVy
eSBzaG91bGQgbm90IGJlIGJhZC4uDQoNCj4gDQo+Pg0KPj4gV2UgbmVlZCB0byB1c2UgYSBsb2Nh
bF9lcnIgaGVyZS4NCj4+DQo+PiBJJ2xsIHNlYXJjaCBmb3IgdGhlIHBhdHRlcm4sIGFuZCBwb3N0
IGZpeChlcykuDQo+Pg0KPiANCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

