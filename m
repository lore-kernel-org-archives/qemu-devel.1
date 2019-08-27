Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946EDC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA0020828
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rwOtj/rI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA0020828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2als-0006Do-Cc
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 08:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i2al1-0005kl-6B
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i2al0-0004SP-3x
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:39:31 -0400
Received: from mail-eopbgr40127.outbound.protection.outlook.com
 ([40.107.4.127]:1437 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i2akx-0004Pc-G3; Tue, 27 Aug 2019 08:39:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kyv8m00H33VQVP6TGaU1ZXD66bLTCSHOLKf9sOMu5e4eiGqb4XzTkHbWe7yRXJLAfy0+5gQ5JiFVSVah82qrbmWqACPLGvML+aSoq6ofK/uLmOq1KOYsVUNkNmzI6iL0ocNkpRorvc15yZaqem4Ednj/wHCDlfWjVR7MJZumRdw/bGPQjRGgnLIEF0GNOW4TrEgF08oMOvFQ1s9Qt6a+bNTZ3O6jz1xhtrJn5oRgib/hqeLT0ZjJ39hrw1buLjQPN3sFO2+3RM2p/NYQ4OeCNNaHqnNm3A1gGB1uzSdvdCZJKPTc21Lk/6Zc2sW6v9OaFj2jj0/NT282uis3/AwpLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9OXDm0dZaUJMnJPgnT8DVgpAREqW/tYC4AOzzSN+uY=;
 b=MOOsY30pFWLmONJlOVW4n9V+3+hW4cqymE7GBL1SLg1br7kanauzRosgQtvECJsvJIYVWfDHRRdkctN5c30zYIaP3zInrH10EPABEX3cG4xiF+/CHxxo4SccQwhM0oF3sslkqHwACNWSiziM0vyzD0MrAMonYiCRotKueHjJp+iwsXZDkPKMn/LEekbjt9kw4y/P2tT3ok1zbb5/UR9+HmN8n6Q9KS0prRmLAPBtjAOY9cVW9SdoeID1NDkg3KqVbofCriiRhcUH91d8FYOHSEiyrIhiUcLZBrZaON+1aD+Vc3tQhuQsIOLuKphJT7UJEFfSHmVqEjUHtuxndHxbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9OXDm0dZaUJMnJPgnT8DVgpAREqW/tYC4AOzzSN+uY=;
 b=rwOtj/rIcidymMnkMXqrrQFThDIZN4ATgjbIV3Crmku3LuEPXwRPbodZV4pukpv3I59urrY4M/0+4/L/QWynUdjye08uh7RsCwhodkKdJmxTd4F9OkBwzagqhew9ZRBZxESbo+UO8cWUVOX5CoIBlM4NYaHopV80ocZO8p1D10k=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB4256.eurprd08.prod.outlook.com (20.179.25.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 12:39:22 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7%6]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 12:39:22 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH] block: workaround for unaligned byte range in fallocate()
Thread-Index: AQHVWRfHNK+M7DbBZ0mb34AZ6lO4bKcHqa4AgAdNBoA=
Date: Tue, 27 Aug 2019 12:39:21 +0000
Message-ID: <8a642371-bbd7-26bd-f54b-576ce49c05d2@virtuozzo.com>
References: <1566498661-53008-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <218c5855-a8dc-df50-23cb-ebd1a1cd259c@redhat.com>
In-Reply-To: <218c5855-a8dc-df50-23cb-ebd1a1cd259c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0051.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::22) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af73f28b-7aed-414a-fac3-08d72aeb95ee
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB4256; 
x-ms-traffictypediagnostic: VI1PR08MB4256:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB42560402E2F80AB3395F1507F4A00@VI1PR08MB4256.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(376002)(39840400004)(396003)(366004)(199004)(189003)(71190400001)(53936002)(478600001)(6436002)(66066001)(71200400001)(31686004)(86362001)(81156014)(81166006)(8676002)(5660300002)(6512007)(66946007)(6116002)(66556008)(66446008)(6486002)(8936002)(36756003)(3846002)(6506007)(186003)(64756008)(52116002)(2501003)(31696002)(7736002)(2906002)(386003)(66476007)(107886003)(486006)(2201001)(6246003)(2616005)(25786009)(26005)(110136005)(476003)(102836004)(14444005)(14454004)(11346002)(4326008)(99286004)(229853002)(54906003)(305945005)(256004)(316002)(76176011)(446003)(44832011)(53546011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4256;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hi+dMzzQQ9gz+BRCKuQzWsKuOnoTrkb+ZVD4zuwJjpGt1LUqMHm9iXbc7ywaVeEE8KiTVIsn14jX4Brn6bQHCW0WM+GOLeEpNF3rl+okcWkBwJRi1yKO/Ydt6FFNAF3cLhk5i8IemAZlfe5lQqUONHQZon2mXIpplwsE0XrHS9un498CiVE0OcZT8bAlhA1E/yh27tgotO7Ya/5T7LZxwYfCTsvEwHb0LOUQNmCNINitvPZEn0wgLx6Ka29q77IHOQMOzgsl6KamfIr4u28q/yRSRx3ut6DWum/wi4uKiaALaLmCy/DUZ9sTsp2A/YwmSS/6awMqTOliXoef2siSdQmD0ksdmpwaSdcTfjyJWYP8WzCGAX4XazoumvjElwbgRBUBzh9IRsmJ5BfMj+FdFCr4fqleCGcVv8gO6/C6pgg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10C8FEFCC264824CBB350492E66DD3DB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af73f28b-7aed-414a-fac3-08d72aeb95ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 12:39:22.3589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VFw9o3e+1k5QFAaUZJOK98TushONfqOh80nbfbM/awigEP/c7nKyFZfoON88d0USfUSs2lrvVeiiQxezX+eRiGuY4pHpM8TkuX3vizvJN3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4256
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.127
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDIzLzA4LzIwMTkgMDA6MDksIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDgvMjIvMTkg
MTozMSBQTSwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+PiBSZXZlcnQgdGhlIGNvbW1pdCAx
MThmOTk0NDJkICdibG9jay9pby5jOiBmaXggZm9yIHRoZSBhbGxvY2F0aW9uIGZhaWx1cmUnDQo+
PiBhbmQgbWFrZSBiZXR0ZXIgZXJyb3IgaGFuZGxpbmcgZm9yIHRoZSBmaWxlIHN5c3RlbXMgdGhh
dCBkbyBub3Qgc3VwcG9ydA0KPiANCj4gcy9tYWtlL3VzZS8NCj4gDQo+PiBmYWxsb2NhdGUoKSBm
b3IgdGhlIHVuYWxpZ25lZCBieXRlIHJhbmdlLiBBbGxvdyBmYWxsaW5nIGJhY2sgdG8gcHdyaXRl
DQo+IA0KPiBzL3RoZS9hbi8NCj4gDQo+PiBpbiBjYXNlIGZhbGxvY2F0ZSgpIHJldHVybnMgRUlO
VkFMLg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogS2V2aW4gV29sZiA8a3dvbGZAcmVkaGF0LmNvbT4N
Cj4+IFN1Z2dlc3RlZC1ieTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBBbmRyZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpv
LmNvbT4NCj4+IC0tLQ0KPj4gRGlzY3Vzc2VkIGluIGVtYWlsIHRocmVhZCB3aXRoIHRoZSBtZXNz
YWdlIElEDQo+PiA8MTU1NDQ3NDI0NC01NTM2NjEtMS1naXQtc2VuZC1lbWFpbC1hbmRyZXkuc2hp
bmtldmljaEB2aXJ0dW96em8uY29tPg0KPj4NCj4+ICAgYmxvY2svZmlsZS1wb3NpeC5jIHwgNyAr
KysrKysrDQo+PiAgIGJsb2NrL2lvLmMgICAgICAgICB8IDIgKy0NCj4+ICAgMiBmaWxlcyBjaGFu
Z2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
YmxvY2svZmlsZS1wb3NpeC5jIGIvYmxvY2svZmlsZS1wb3NpeC5jDQo+PiBpbmRleCBmYmViMDA2
Li4yYzI1NGZmIDEwMDY0NA0KPj4gLS0tIGEvYmxvY2svZmlsZS1wb3NpeC5jDQo+PiArKysgYi9i
bG9jay9maWxlLXBvc2l4LmMNCj4+IEBAIC0xNTg4LDYgKzE1ODgsMTMgQEAgc3RhdGljIGludCBo
YW5kbGVfYWlvY2Jfd3JpdGVfemVyb2VzKHZvaWQgKm9wYXF1ZSkNCj4+ICAgICAgIGlmIChzLT5o
YXNfd3JpdGVfemVyb2VzKSB7DQo+PiAgICAgICAgICAgaW50IHJldCA9IGRvX2ZhbGxvY2F0ZShz
LT5mZCwgRkFMTE9DX0ZMX1pFUk9fUkFOR0UsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBhaW9jYi0+YWlvX29mZnNldCwgYWlvY2ItPmFpb19uYnl0ZXMpOw0KPj4gKyAgICAg
ICAgaWYgKHJldCA9PSAtRUlOVkFMKSB7DQo+PiArICAgICAgICAgICAgLyoNCj4+ICsgICAgICAg
ICAgICAgKiBBbGxvdyBmYWxsaW5nIGJhY2sgdG8gcHdyaXRlIGZvciBmaWxlIHN5c3RlbXMgdGhh
dA0KPj4gKyAgICAgICAgICAgICAqIGRvIG5vdCBzdXBwb3J0IGZhbGxvY2F0ZSgpIGZvciB1bmFs
aWduZWQgYnl0ZSByYW5nZS4NCj4gDQo+IHMvZm9yL2ZvciBhbi8NCj4gDQo+PiArICAgICAgICAg
ICAgICovDQo+PiArICAgICAgICAgICAgcmV0dXJuIC1FTk9UU1VQOw0KPj4gKyAgICAgICAgfQ0K
Pj4gICAgICAgICAgIGlmIChyZXQgPT0gMCB8fCByZXQgIT0gLUVOT1RTVVApIHsNCj4+ICAgICAg
ICAgICAgICAgcmV0dXJuIHJldDsNCj4+ICAgICAgICAgICB9DQo+PiBkaWZmIC0tZ2l0IGEvYmxv
Y2svaW8uYyBiL2Jsb2NrL2lvLmMNCj4+IGluZGV4IDU2YmJmMTkuLjU4ZjA4Y2QgMTAwNjQ0DQo+
PiAtLS0gYS9ibG9jay9pby5jDQo+PiArKysgYi9ibG9jay9pby5jDQo+PiBAQCAtMTU1OCw3ICsx
NTU4LDcgQEAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4gYmRydl9jb19kb19wd3JpdGVfemVyb2Vz
KEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPj4gICAgICAgICAgICAgICBhc3NlcnQoIWJzLT5zdXBw
b3J0ZWRfemVyb19mbGFncyk7DQo+PiAgICAgICAgICAgfQ0KPj4gICANCj4+IC0gICAgICAgIGlm
IChyZXQgPCAwICYmICEoZmxhZ3MgJiBCRFJWX1JFUV9OT19GQUxMQkFDSykpIHsNCj4+ICsgICAg
ICAgIGlmIChyZXQgPT0gLUVOT1RTVVAgJiYgIShmbGFncyAmIEJEUlZfUkVRX05PX0ZBTExCQUNL
KSkgew0KPj4gICAgICAgICAgICAgICAvKiBGYWxsIGJhY2sgdG8gYm91bmNlIGJ1ZmZlciBpZiB3
cml0ZSB6ZXJvZXMgaXMgdW5zdXBwb3J0ZWQgKi8NCj4+ICAgICAgICAgICAgICAgQmRydlJlcXVl
c3RGbGFncyB3cml0ZV9mbGFncyA9IGZsYWdzICYgfkJEUlZfUkVRX1pFUk9fV1JJVEU7DQo+PiAg
IA0KPj4NCj4gDQo+IFJldmlld2VkLWJ5OiBFcmljIEJsYWtlIDxlYmxha2VAcmVkaGF0LmNvbT4N
Cj4gDQpFcmljLA0KSWYgeW91IGFyZSBnb29kIHRvIHRha2UgdGhpcyBwYXRjaCB0byB5b3VyIGJy
YW5jaCB3aXRoIHlvdXIgY29ycmVjdGlvbnMsIA0KcGxlYXNlIGxldCB1cyBrbm93LiBPdGhlcndp
c2UsIEkgd2lsbCBzZW5kIHRoZSB2MiB3aXRoIHlvdXIgY29ycmVjdGlvbnMuDQotLSANCldpdGgg
dGhlIGJlc3QgcmVnYXJkcywNCkFuZHJleSBTaGlua2V2aWNoDQo=

