Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E77C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 19:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F82021743
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 19:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gwnMJl+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F82021743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0sY6-00083M-0A
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 15:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i0sTx-0005Jr-E5
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 15:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i0sTw-00047p-9r
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 15:10:49 -0400
Received: from mail-eopbgr150098.outbound.protection.outlook.com
 ([40.107.15.98]:8779 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i0sTm-0003yC-Pc; Thu, 22 Aug 2019 15:10:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWalsorADvS7oPtmScJiQ6A/j6ujxv6L+Ru0mzfGaVbXjA7KaOCEVF+BgNu4VEGFKKGzeX5QwuiHWsVd9XFTIQPawgZkXnz+vRimAjAh0OETE/lAXqo8j9U9jXh6rej2ZknP4O/K6V8HRR7vOuKDtWOsfb+aiFyz8DvhwbdbPfKe0S7zYMlbiRX9nOvXV33a/xJFwucTFBiRSfoZQrgYsoYjYIIhCXkYPJrA9TXcU6exEm0pUGxb8JN6XeCEsslWrtmofMvRQsigJMEg2MmHeFYm8N2zgovkVb8sj4cCN9R/zDmtdvfU9fyZICM8fThCR8r7Jvnev9uyKeEsmn/a6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZTjbPOUPQz7VQXvGcPtdbQOZRlQnG/PuOt366cHQBA=;
 b=JdH0RfuNHr1e1+REk6FVkH5J7iXPYu7HLLK43XHgeReYuB4hQoxMePV/AqsPjTm/fn+HVCOgV6XmGGZ5xWClDSzjJe51qyU1G63psRdH6eqSNYzu63CjB64ZUgMnhOEiiYC8RC1egzZQ0gd0XeGd9jixkvYEoNKN3x01D8+Fn5Ellx0MTaZEXhzS2H09IAeYPxkGj+o8GaxpWPVw2fiJEr0nV0a//7kLAJtmDgzr7y49U7QDcZz3lo5W5C5asuWRz75EXRjdYU/3yoxpDk1QDQk8RXuiCskO/ob8Px5zimbUrTTyZw1ABPHuNTVrw3vToqjc9iiljg8jX+D8KPldsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZTjbPOUPQz7VQXvGcPtdbQOZRlQnG/PuOt366cHQBA=;
 b=gwnMJl+Na9ju1iFtyKZnY+WPHEfSt56/1QZtjwwXa4tTF/hMaJ23I0Wu7sLyoBgDj4FrRAqUjnuDbxl744dPjlzYhB26CXz2/zsroPodm3qYbYrf3J4unksA+XpZEdSlxyQr1Wr590luaJEDX2xXZV+QE5CdLYELr8Qm9mmBJjc=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4186.eurprd08.prod.outlook.com (20.179.12.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 19:10:33 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 19:10:33 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH] block: workaround for unaligned byte range in fallocate()
Thread-Index: AQHVWRfHsUNESZceUEiCeTknvwr0NacHhBSAgAAEQwA=
Date: Thu, 22 Aug 2019 19:10:33 +0000
Message-ID: <bfba1920-0cca-85f5-83f1-d68bb4ba37e1@virtuozzo.com>
References: <1566498661-53008-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <0b9bfdf5-911f-595e-b941-28ab1e6c4d5f@virtuozzo.com>
In-Reply-To: <0b9bfdf5-911f-595e-b941-28ab1e6c4d5f@virtuozzo.com>
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
x-tagtoolbar-keys: D20190822221030487
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bedd0c6-decd-4e76-1a1d-08d72734680e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4186; 
x-ms-traffictypediagnostic: DB8PR08MB4186:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB4186BE221B3D8A3052891EEBC1A50@DB8PR08MB4186.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:256;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(396003)(366004)(39840400004)(376002)(189003)(199004)(8936002)(6436002)(2906002)(99286004)(53936002)(81156014)(5660300002)(14444005)(81166006)(52116002)(36756003)(71200400001)(14454004)(71190400001)(2616005)(446003)(6512007)(486006)(11346002)(476003)(8676002)(478600001)(6486002)(4326008)(66946007)(64756008)(66556008)(66446008)(66476007)(31686004)(7736002)(305945005)(76176011)(256004)(6116002)(3846002)(386003)(6506007)(107886003)(229853002)(25786009)(31696002)(102836004)(26005)(2201001)(86362001)(110136005)(2501003)(6246003)(186003)(316002)(54906003)(66066001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4186;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vi8dOBS7qQuDJadDbFkN3MG4abdMUGKKym1BeVsCA2z6iuB2Nnw+j4DYjhqyB2I7xAdAK/iKSL4VORsdNLaqdgcFy6BK+cGETtmUm6IuRKOveZDD6FxpvEflc8sdXrv8A4KKBuQtfhtRXgbe/icnFwiUf0HXKSqNZZTeC/Y8KSqWJVsS2jjGXldPd+ltNepBNwaAsVQvYy6x4hCNd9bFCURvMzTandrfkf6oMOSG56ghJtN95bRJKwcv2orT0PPYbYH+vAXtb719RUwOR0+5G/ok9TX/L/NjVkt02xifoewH0CSSDhIeSIMvXHPEN1U33kjofgxmTmLFbb/CRaIMivXKmPibb9vENIdarDkda7H+nk+jiOZqCnpzX6XZjA/SZO7df70uaOMLB8HE71nf9GosqMZRc1a5ePm5buWM/B8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F25DC67A11B2940AAB12EE823AD6312@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bedd0c6-decd-4e76-1a1d-08d72734680e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 19:10:33.5363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ISc6pfUSQGNgI0JyW370M4NtxHPyM7sNI4oz9QDecAV89uHxmHeGsMNsIL4zlP0fqXk0QnmNqxXV6WEGVd60UjdR6/atjpBE+O5UsnpITyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4186
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.98
Subject: Re: [Qemu-devel] [PATCH] block: workaround for unaligned byte range
 in fallocate()
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjIuMDguMjAxOSAyMTo1NSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MjIuMDguMjAxOSAyMTozMSwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+PiBSZXZlcnQgdGhl
IGNvbW1pdCAxMThmOTk0NDJkICdibG9jay9pby5jOiBmaXggZm9yIHRoZSBhbGxvY2F0aW9uIGZh
aWx1cmUnDQo+PiBhbmQgbWFrZSBiZXR0ZXIgZXJyb3IgaGFuZGxpbmcgZm9yIHRoZSBmaWxlIHN5
c3RlbXMgdGhhdCBkbyBub3Qgc3VwcG9ydA0KPj4gZmFsbG9jYXRlKCkgZm9yIHRoZSB1bmFsaWdu
ZWQgYnl0ZSByYW5nZS4gQWxsb3cgZmFsbGluZyBiYWNrIHRvIHB3cml0ZQ0KPj4gaW4gY2FzZSBm
YWxsb2NhdGUoKSByZXR1cm5zIEVJTlZBTC4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IEtldmluIFdv
bGYgPGt3b2xmQHJlZGhhdC5jb20+DQo+PiBTdWdnZXN0ZWQtYnk6IEVyaWMgQmxha2UgPGVibGFr
ZUByZWRoYXQuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJl
eS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+IERpc2N1c3NlZCBpbiBlbWFp
bCB0aHJlYWQgd2l0aCB0aGUgbWVzc2FnZSBJRA0KPj4gPDE1NTQ0NzQyNDQtNTUzNjYxLTEtZ2l0
LXNlbmQtZW1haWwtYW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4+DQo+PiDCoCBi
bG9jay9maWxlLXBvc2l4LmMgfCA3ICsrKysrKysNCj4+IMKgIGJsb2NrL2lvLmPCoMKgwqDCoMKg
wqDCoMKgIHwgMiArLQ0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYmxvY2svZmlsZS1wb3NpeC5jIGIvYmxv
Y2svZmlsZS1wb3NpeC5jDQo+PiBpbmRleCBmYmViMDA2Li4yYzI1NGZmIDEwMDY0NA0KPj4gLS0t
IGEvYmxvY2svZmlsZS1wb3NpeC5jDQo+PiArKysgYi9ibG9jay9maWxlLXBvc2l4LmMNCj4+IEBA
IC0xNTg4LDYgKzE1ODgsMTMgQEAgc3RhdGljIGludCBqKHZvaWQgKm9wYXF1ZSkNCj4+IMKgwqDC
oMKgwqAgaWYgKHMtPmhhc193cml0ZV96ZXJvZXMpIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBp
bnQgcmV0ID0gZG9fZmFsbG9jYXRlKHMtPmZkLCBGQUxMT0NfRkxfWkVST19SQU5HRSwNCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgYWlvY2ItPmFpb19vZmZzZXQsIGFpb2NiLT5haW9fbmJ5dGVzKTsNCj4+ICvCoMKgwqDC
oMKgwqDCoCBpZiAocmV0ID09IC1FSU5WQUwpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IC8qDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogQWxsb3cgZmFsbGluZyBiYWNrIHRv
IHB3cml0ZSBmb3IgZmlsZSBzeXN0ZW1zIHRoYXQNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKiBkbyBub3Qgc3VwcG9ydCBmYWxsb2NhdGUoKSBmb3IgdW5hbGlnbmVkIGJ5dGUgcmFuZ2Uu
DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gLUVOT1RTVVA7DQo+PiArwqDCoMKgwqDCoMKgwqAgfQ0KPj4gwqDCoMKgwqDC
oMKgwqDCoMKgIGlmIChyZXQgPT0gMCB8fCByZXQgIT0gLUVOT1RTVVApIHsNCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0K
PiANCj4gSG1tIHN0b3AsIHlvdSd2ZSBkb25lIGV4YWN0bHkgd2hhdCBEZW4gd2FzIGFmcmFpZCBv
ZjoNCj4gDQo+IHRoZSBuZXh0IGxpbmUNCj4gIMKgIHMtPmhhc193cml0ZV96ZXJvZXMgPSBmYWxz
ZTsNCj4gDQo+IHdpbGwgZGlzYWJsZSB3cml0ZV96ZXJvZXMgZm9yZXZlci4NCj4gDQo+IFNvbWV0
aGluZyBsaWtlDQo+IA0KPiAtLS0gYS9ibG9jay9maWxlLXBvc2l4LmMNCj4gKysrIGIvYmxvY2sv
ZmlsZS1wb3NpeC5jDQo+IEBAIC0xNTg4LDEwICsxNTg4LDEyIEBAIHN0YXRpYyBpbnQgaGFuZGxl
X2Fpb2NiX3dyaXRlX3plcm9lcyh2b2lkICpvcGFxdWUpDQo+ICDCoMKgwqDCoCBpZiAocy0+aGFz
X3dyaXRlX3plcm9lcykgew0KPiAgwqDCoMKgwqDCoMKgwqDCoCBpbnQgcmV0ID0gZG9fZmFsbG9j
YXRlKHMtPmZkLCBGQUxMT0NfRkxfWkVST19SQU5HRSwNCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFpb2NiLT5haW9fb2Zm
c2V0LCBhaW9jYi0+YWlvX25ieXRlcyk7DQo+IC3CoMKgwqDCoMKgwqDCoCBpZiAocmV0ID09IDAg
fHwgcmV0ICE9IC1FTk9UU1VQKSB7DQo+ICvCoMKgwqDCoMKgwqDCoCBpZiAocmV0ID09IDAgfHwg
KHJldCAhPSAtRU5PVFNVUCAmJiByZXQgIT0gLUVJTlZBTCkpIHsNCj4gIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPiAgwqDCoMKgwqDCoMKgwqDCoCB9DQo+IC3CoMKgwqDC
oMKgwqDCoCBzLT5oYXNfd3JpdGVfemVyb2VzID0gZmFsc2U7DQo+ICvCoMKgwqDCoMKgwqDCoCBp
ZiAocmV0ID09IC1FTk9UU1VQKSB7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMtPmhhc193
cml0ZV96ZXJvZXMgPSBmYWxzZTsNCj4gK8KgwqDCoMKgwqDCoMKgIH0NCj4gIMKgwqDCoMKgIH0N
Cj4gIMKgI2VuZGlmDQo+IA0KPiANCj4gd2lsbCB3b3JrIGJldHRlci4gU28sIGhhbmRsZSBFTk9U
U1VQIGFzICJkaXNhYmxlIHdyaXRlX3plcm9zIGZvcmV2ZXIiLCBhbmQgRUlOVkFMIGFzDQo+ICJk
b24ndCBkaXNhYmxlLCBidXQgZmFsbGJhY2sgdG8gd3JpdGluZyB6ZXJvcyIuIEFuZCB3ZSBuZWVk
IHNhbWUgaGFuZGxpbmcgZm9yIGZvbGxvd2luZyBkb19mYWxsb2NhdGUoKSBjYWxscw0KPiB0b28g
KG90aGVyd2lzZSB0aGV5IGFnYWluIGZhaWxzIHdpdGggRUlOVkFMIHdoaWNoIHdpbGwgYnJlYWsg
dGhlIHdob2xlIHRoaW5nKS4NCj4gDQoNCk9vcHMsIHNvcnJ5LCBJIG1pc3JlYWQgeW91ciBwYXRj
aCwgaXQncyBPSy4NCg0KU3RpbGwgd2UgbWF5IHdhbnQgdG8gaGFuZGxlIG90aGVyIGRvX2ZhbGxv
Y2F0ZSgpIGNhbGxzIGluIHNhbWUgbWFubmVyLCBvciBtYXkgYmUganVzdDoNCg0KQEAgLTE1NTgs
NyArMTU1OCwxMyBAQCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBiZHJ2X2NvX2RvX3B3cml0ZV96
ZXJvZXMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQogICAgICAgICAgICAgIGFzc2VydCghYnMtPnN1
cHBvcnRlZF96ZXJvX2ZsYWdzKTsNCiAgICAgICAgICB9DQoNCi0gICAgICAgIGlmIChyZXQgPCAw
ICYmICEoZmxhZ3MgJiBCRFJWX1JFUV9OT19GQUxMQkFDSykpIHsNCisgICAgICAgIC8qDQorICAg
ICAgICAgKiBXZSBhcmUgc3VyZSB0aGF0IG91ciBhcmd1bWVudHMgbWFrZSBzZW5zZSwgc28gY29u
c2lkZXIgImludmFsaWQNCisgICAgICAgICAqIGFyZ3VtZW50IiBpbiBzYW1lIG1hbm5lciBhcyAi
bm90IHN1cHBvcnRlZCIuDQorICAgICAgICAgKi8NCisgICAgICAgIGlmICgocmV0ID09IC1FTk9U
U1VQIHx8IHJldCA9PSAtRUlOVkFMKSAmJg0KKyAgICAgICAgICAgICEoZmxhZ3MgJiBCRFJWX1JF
UV9OT19GQUxMQkFDSykpDQorICAgICAgICB7DQogICAgICAgICAgICAgIC8qIEZhbGwgYmFjayB0
byBib3VuY2UgYnVmZmVyIGlmIHdyaXRlIHplcm9lcyBpcyB1bnN1cHBvcnRlZCAqLw0KICAgICAg
ICAgICAgICBCZHJ2UmVxdWVzdEZsYWdzIHdyaXRlX2ZsYWdzID0gZmxhZ3MgJiB+QkRSVl9SRVFf
WkVST19XUklURTsNCg0KDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

