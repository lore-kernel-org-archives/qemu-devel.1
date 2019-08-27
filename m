Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7929AC3A5A4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 14:37:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4764A206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 14:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SPK8RRJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4764A206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2cbU-0003Fa-Fv
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 10:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i2cal-0002fj-M9
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i2cak-0003Um-K2
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:37:03 -0400
Received: from mail-eopbgr50104.outbound.protection.outlook.com
 ([40.107.5.104]:42803 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i2cag-0003Tc-Je; Tue, 27 Aug 2019 10:36:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mK+CYyjD/Jqj/jYnBNCjq/A6N0Ny8gVDontBk8gHYE3inU61sTMPXYMg2NHHMVMz0WJS6MVfNoRZeKMlXPwz87B/hsszGSINDC34t0y+9JNw2mn48S593TSWB0kGV6DI3q2EcugOpNUBbQynepXSMce2CIc6vq8WI/QpElIj/D4P04fbvE2onOt6fh7N2AnnlMmbT0m64uZnC9V6tapsQqRT+qieSN6oBGFX0TTLhaPRUYqLOnypw3O2nnEBlBxI+gywbGLIcOW+EObFmX4r8bhpxCICMbHQnDTQpuVKy+ECbNaFya+00LMWqVl9euuolVYBlnoEoXsyR5zefP5oOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBblA1NMxV4qiI9PLVutHfB+eSwJP5O9rn4qisCbvaU=;
 b=FGiQar5qQQbJ6noCXozwOecwqzkjzeTGoAxFPQDxYpoiyetf8b1hO8AcSpqYpUIf74p702fXqNLpf9nAgyDO2R9ZkilTAGz+mBLOBt9Appljizmg4sLhq7VPeiuSXO74NgmwvEZD4dVIRIbNU7Xj3lKy3di1kQ+0hWzTTEp7P6hWg+2OoaBqX8DJG3XYFUH7arrXz9agaokMVTBeeK0sv5abuFnY8noNIjTvuAPTRsyFgXrx+T20BZ5qY6atw/svzJ/XQHbk2+TuuPd3txlodSNIus1yQ4miglDz7RfX1cJ0fxnyTH2MKRfhS6V85fvjCIHsD5Wm+Ya1n4KgiOFbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBblA1NMxV4qiI9PLVutHfB+eSwJP5O9rn4qisCbvaU=;
 b=SPK8RRJmKCnMtbX6gjpBTn0NLDjqh1g9ELAAl63Mx14QdN8rl2Sszd5Qz32RZM9eeOJUbHOZgg7ANypr086cg24K9zKfzxDDu9skwi+Gwq5SMvkEXnnsVx06xcAjgn0nKWK+v9m4q4hog1FmTld0Mf5YBByPPM8GJ3srq7NoMTQ=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB3599.eurprd08.prod.outlook.com (20.177.61.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 14:36:56 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7%6]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 14:36:56 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2] block: workaround for unaligned byte range in
 fallocate()
Thread-Index: AQHVXN6/9zhncFLxI0q6RGEW621xhKcPBHWAgAA0xgD//9UdAIAAAagA
Date: Tue, 27 Aug 2019 14:36:56 +0000
Message-ID: <f034a31b-fca6-81fd-ad90-73822fc02031@virtuozzo.com>
References: <1566913973-15490-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <4b240066-60b7-0f9b-9f17-d5da43b9da84@redhat.com>
 <7ad1318a-8745-54fe-d6ad-2b27262f1f78@virtuozzo.com>
 <847b50d2-446e-9f6c-96b5-adcbb5dd2485@redhat.com>
In-Reply-To: <847b50d2-446e-9f6c-96b5-adcbb5dd2485@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0012.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::22)
 To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c520fb5-da2b-4a6a-f352-08d72afc02b8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:VI1PR08MB3599; 
x-ms-traffictypediagnostic: VI1PR08MB3599:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB35995CD4D61D6317B67B4D60F4A00@VI1PR08MB3599.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:626;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(39850400004)(376002)(346002)(396003)(199004)(189003)(6116002)(71200400001)(71190400001)(36756003)(107886003)(8936002)(6246003)(81156014)(81166006)(25786009)(26005)(31696002)(14454004)(2201001)(86362001)(256004)(14444005)(305945005)(7736002)(8676002)(478600001)(4326008)(99286004)(186003)(102836004)(54906003)(110136005)(53546011)(6506007)(52116002)(76176011)(386003)(316002)(2501003)(6486002)(229853002)(53936002)(6512007)(6436002)(2906002)(446003)(44832011)(486006)(11346002)(476003)(2616005)(66946007)(66476007)(3846002)(5660300002)(31686004)(64756008)(66446008)(66066001)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3599;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uqrxxMl0hX5eLQayXiaFa4Q++9kXlGOc29AHUo2WjzVJef47+hex5dWzLdPrUeR1oYQzC0Z5yd/eObm8vOqvL/Alh2P1LJ5SFkfa8PZ3uxVKn9yktSIqkbvMdv7qvJuBOSVdIDlB1fcjQNguFH3V27BJMY0BBUB89bk356tg++6D4uoNN0Jr8+G2KdJ9yE3eURcHziBwAx2e1mr7wt4r1Y8YEq7V95oqUnAJ6nuEbDS2TYXXLkjLXWdYpW+K2p0CejPLFDg/XDhde2dZ+miZ984OOucpDZbdo4xbxBxLpBMmmdw88pjihHAHsGi2MIKfae8N8JeecpmUZisPurlJYsgDzlO1LFNb7d4T688vZG7TbZ6tiIPVDADCrW4B+tGVbGExRwG19AZ31hfHEMoNwljrHlSBFgOtCy3UmBt++Hk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B64BFC06A39294BB9F0C5AD5872FB6D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c520fb5-da2b-4a6a-f352-08d72afc02b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 14:36:56.3534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NQhtwIGJ6j90UXZ8hPqfmzdQ3aHZ6XFc2rYoq5uBp0vnhdKUlcalZmsfqUdlOiawAabezAa3I3n8izKc9LNBpz/h2h+XFQ5lCpiSxjFjD/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3599
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.104
Subject: Re: [Qemu-devel] [PATCH v2] block: workaround for unaligned byte
 range in fallocate()
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI3LzA4LzIwMTkgMTc6MzAsIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDgvMjcvMTkg
OTowNCBBTSwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDI3LzA4LzIw
MTkgMTY6NTUsIEVyaWMgQmxha2Ugd3JvdGU6DQo+Pj4gT24gOC8yNy8xOSA4OjUyIEFNLCBBbmRy
ZXkgU2hpbmtldmljaCB3cm90ZToNCj4+Pj4gUmV2ZXJ0IHRoZSBjb21taXQgMTE4Zjk5NDQyZCAn
YmxvY2svaW8uYzogZml4IGZvciB0aGUgYWxsb2NhdGlvbiBmYWlsdXJlJw0KPj4+PiBhbmQgdXNl
IGJldHRlciBlcnJvciBoYW5kbGluZyBmb3IgZmlsZSBzeXN0ZW1zIHRoYXQgZG8gbm90IHN1cHBv
cnQNCj4+Pj4gZmFsbG9jYXRlKCkgZm9yIGFuIHVuYWxpZ25lZCBieXRlIHJhbmdlLiBBbGxvdyBm
YWxsaW5nIGJhY2sgdG8gcHdyaXRlDQo+Pj4+IGluIGNhc2UgZmFsbG9jYXRlKCkgcmV0dXJucyBF
SU5WQUwuDQo+Pj4+DQo+Pj4+IFN1Z2dlc3RlZC1ieTogS2V2aW4gV29sZiA8a3dvbGZAcmVkaGF0
LmNvbT4NCj4+Pj4gU3VnZ2VzdGVkLWJ5OiBFcmljIEJsYWtlIDxlYmxha2VAcmVkaGF0LmNvbT4N
Cj4+Pj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNo
QHZpcnR1b3p6by5jb20+DQo+Pj4+IFJldmlld2VkLWJ5OiBFcmljIEJsYWtlIDxlYmxha2VAcmVk
aGF0LmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIGJsb2NrL2ZpbGUtcG9zaXguYyB8IDcgKysrKysr
Kw0KPj4+PiAgICBibG9jay9pby5jICAgICAgICAgfCAyICstDQo+Pj4+ICAgIDIgZmlsZXMgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4NCj4+PiBRdWV1aW5nIHRo
aXMgaW4gbXkgTkJEIHRyZWUgKGFzIEkgcGVyZm9ybWVkIHRlc3Rpbmcgb24gdG9wIG9mIGl0IHdo
ZW4NCj4+PiB3b3JraW5nIG9uIE5CRCBmYXN0LXplcm8pLg0KPj4+DQo+PiBFcmljLA0KPj4gSSdt
IHNvcnJ5IGFib3V0IG1pc3NpbmcgeW91ciBtZXNzYWdlIGluIHRoZSBwcmV2aW91cyBlbWFpbCB0
aHJlYWQgLSBqdXN0DQo+PiBmZXcgbWludXRlIGRpZmZlcmVuY2UuIFBsZWFzZSBhZGQNCj4+IFJl
dmlld2VkLWJ5OiBEZW5pcyBWLiBMdW5ldiA8ZGVuQG9wZW52ei5vcmc+DQo+PiBiZWNhdXNlIEkg
dXNlZCB0aGUgc3RhbGUgY29tbWl0IElEIGZyb20gYmFzaCBoaXN0b3J5IGFuZCB0aGF0IGxpbmUN
Cj4+IGRpZG4ndCBnbyB0byB0aGUgdjIgcGF0Y2ggKCgoDQo+IA0KPiBObyBwcm9ibGVtIC0gY3Jv
c3NlZCBlbWFpbHMgaXMgbm90aGluZyBuZXcuIEknbGwgYWRkIHRoZSBSLWIuDQo+IA0KPiANClRo
YW5rcyBhIGxvdCBFcmljLg0KDQpBbmRyZXkNCi0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRzLA0K
QW5kcmV5IFNoaW5rZXZpY2gNCg==

