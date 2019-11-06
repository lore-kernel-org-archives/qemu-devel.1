Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147A8C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3232178F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vCkJvB1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3232178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSO32-0006y8-KR
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 11:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iSNzy-0004nu-7J
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:17:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iSNzv-0003jR-5V
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:17:33 -0500
Received: from mail-eopbgr50094.outbound.protection.outlook.com
 ([40.107.5.94]:55073 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iSNzs-0003ge-GE; Wed, 06 Nov 2019 11:17:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdP8netBcjnMcmLnRdHhNczK4rkgbn4LEz5EOAg1EmJfAG7UzgPuMyKxmvXis7U4pXvL9BNNfAHxSIKxNDwIJrokq+qhWHsH56ARspjY3F9oC22kjy3K0kIm6+y6T9NzFlBwpUV8WLkmua0bS2MyM50+hhzLUGk4wW/YKxyKRKlvEZtVsVWOc1F3rcVZX9SQ+8/qBHMTJyC4Qwqb7/zWA8SXjSqK3pbv3A8aqSRynIZabFtNzDSj9WrGMRI+4qzsWtRkPErekWgAfTI1wgiIkCuwWdt38tqZxO3+guvHv3NMUM2iPMrVklLcx4kjIPXtDhrDH/WR8q0dqymJYilr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diUbzEcG0zv8AoHLgaZcKaSCqrmDYTwsjqyZoovfF2g=;
 b=BqytjBnitGBZBGw9aJ730tLummRAQIXSV52FJmPkxlkUFUNNg//UzTNpoSu9bpNoWbNRRDmnnODetbIDVLGxhFoJzqgr/vSIxqEePlVH0WTQ/kYcycr0NuXMe575yt0fTLumIJTqIm92j+oXn6nMrYXWuNsbFiq/bkBhleao1nCn7tIsK/VHjKRd4BS1xeXfA3P1eArSxHQ6XF+VSq+1X10Z4Ny/ndbuRL4tDoT4I1vPDYXA9cDQSglt13bpMq9AYO1dOc2p4R9fUnJCGeOn2oJt/iH0L4B9PSyQErIbN8X8udiY5xi3l2Zoqx3v4EP/vnV0k9XiGlIp7XNFhLgBag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diUbzEcG0zv8AoHLgaZcKaSCqrmDYTwsjqyZoovfF2g=;
 b=vCkJvB1nlQ+nmrzIjlqlN3HRndmPNlyofTRDVZ6xNdfrwZepph0S5BhkKQpmu3Lp9zsVsdlwyT4GkgNhR/OmwI9NoK7AUm5FmwN4ai7IMPkr7H6v3QMnIe35qd0q9BiKIV8wro43kF3coOdVvre2IXF/Xh48lArYEMViuB72Whk=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB4385.eurprd08.prod.outlook.com (20.179.36.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 16:17:24 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::41f0:981:fd75:9946]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::41f0:981:fd75:9946%3]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 16:17:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v8 1/3] docs: improve qcow2 spec about extending image
 header
Thread-Topic: [PATCH v8 1/3] docs: improve qcow2 spec about extending image
 header
Thread-Index: AQHVhZkjTzzfnHiFj0qSiLP9bR+k/adgbZKAgAAKKwCAHfhnAA==
Date: Wed, 6 Nov 2019 16:17:24 +0000
Message-ID: <5ec43c58-248b-1a3b-7de5-a1c5c78731e1@virtuozzo.com>
References: <20191018094758.7124-1-vsementsov@virtuozzo.com>
 <20191018094758.7124-2-vsementsov@virtuozzo.com>
 <71ad0b78-65da-9a39-4c12-f78449cdca9c@redhat.com>
 <ba5ae50c-9406-5095-89ae-6a10893e452e@virtuozzo.com>
In-Reply-To: <ba5ae50c-9406-5095-89ae-6a10893e452e@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0058.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::29) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191106191722601
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e048c72-9500-4238-c282-08d762d4cf21
x-ms-traffictypediagnostic: AM0PR08MB4385:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB43858D4E79EE5CD8E96CE511C1790@AM0PR08MB4385.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(346002)(376002)(366004)(136003)(396003)(199004)(189003)(486006)(102836004)(305945005)(3846002)(8936002)(71190400001)(66446008)(64756008)(66476007)(66556008)(6486002)(31686004)(86362001)(8676002)(6116002)(31696002)(229853002)(99286004)(54906003)(2501003)(316002)(256004)(110136005)(66066001)(6506007)(53546011)(386003)(26005)(52116002)(478600001)(7736002)(66946007)(71200400001)(81156014)(81166006)(76176011)(11346002)(25786009)(2616005)(36756003)(476003)(5660300002)(4326008)(2906002)(6512007)(6246003)(186003)(6436002)(107886003)(446003)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4385;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fuIwP+u8rLm6p+qfUxlWpbrxgUXAz3DR2v77HDr3j9WMzhbhmbYAmx8UTLXWOWrH6Fcp0t0uBQV4wcNxxUJ3jYLQHTpY89QaejjtGb1pn2aYWxGgpRzDeIZN8YDffhAfZADnIWrPyfgtlSFevso27GPCun34M2yRACghgqnP9IDDNaW1lJDghH8CGqlh9U+0Rawz8ZnlVQrKJ8GeC61rM0JFuMZG/G4i5GvdC+jG7wXrsrbQNl9nd1NAYAtcdvmjGlDCumcCn+0iDAppba/lsLsfWOg+nimFrFiHhWI1RCQzHel+fkWGhFUqPKKMhMV2TNe9Rm/yaqj56851jIp9Q0zh74wwB9Q9tzhP7hV/R/2hdzfIvatlXh3/LFtqtQgnqPl3l/DjywdYe7Lt4I51zP5UbvwUEQk9GnFZG/KKGr8ZvMnuHrcDzeGOvqRrcotz
Content-Type: text/plain; charset="utf-8"
Content-ID: <692648D49B48254B84057AFA0C580B43@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e048c72-9500-4238-c282-08d762d4cf21
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 16:17:24.5688 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sNNOITtMwKWNyV2AtdKCYW8dit4bi0dNUikZfCWFP+0AFPogXSHtUiiO20l2CwFvGKAFHYvn/+zqsX46waQOqOkwnqnaVX3Ai/Hc3Q/IApw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4385
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.94
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTguMTAuMjAxOSAxNzozNiwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MTguMTAuMjAxOSAxNzowMCwgRXJpYyBCbGFrZSB3cm90ZToNCj4+IE9uIDEwLzE4LzE5IDQ6NDcg
QU0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gTWFrZSBpdCBtb3Jl
IG9idmlvdXMgaG93IHRvIGFkZCBuZXcgZmllbGRzIHRvIHRoZSB2ZXJzaW9uIDMgaGVhZGVyIGFu
ZA0KPj4+IGhvdyB0byBpbnRlcnByZXQgdGhlbS4NCj4+Pg0KPj4+IFRoZSBzcGVjaWZpY2F0aW9u
IGlzIGFkanVzdGVkIHNvIGZvciBuZXcgZGVmaW5lZCBvcHRpb25hbCBmaWVsZHM6DQo+Pg0KPj4g
VGhlIHNwZWNpZmljYXRpb24gaXMgYWRqdXN0ZWQgdG8gbWFrZSBpdCBjbGVhciB0aGF0IGZ1dHVy
ZSBmaWVsZHMgYXJlIG9wdGlvbmFsOg0KPj4NCj4+Pg0KPj4+IDEuIFNvZnR3YXJlIG1heSBzdXBw
b3J0IHNvbWUgb2YgdGhlc2Ugb3B0aW9uYWwgZmllbGRzIGFuZCBpZ25vcmUgdGhlDQo+Pj4gwqDC
oMKgIG90aGVycywgd2hpY2ggbWVhbnMgdGhhdCBmZWF0dXJlcyBtYXkgYmUgYmFja3BvcnRlZCB0
byBkb3duc3RyZWFtDQo+Pj4gwqDCoMKgIFFlbXUgaW5kZXBlbmRlbnRseS4NCj4+PiAzLiBJZiBA
aGVhZGVyX2xlbmd0aCBpcyBoaWdoZXIgdGhhbiB0aGUgaGlnaGVzdCBmaWVsZCBlbmQgdGhhdCBz
b2Z0d2FyZQ0KPj4+IMKgwqDCoCBrbm93cywgaXQgc2hvdWxkIGFzc3VtZSB0aGF0IHRvcG1vc3Qg
dW5rbm93biBhZGRpdGlvbmFsIGZpZWxkcyBhcmUNCj4+PiDCoMKgwqAgY29ycmVjdCwgYW5kIGtl
ZXAgYWRkaXRpb25hbCB1bmtub3duIGZpZWxkcyBhcyBpcyBvbiByZXdyaXRpbmcgdGhlDQo+Pj4g
wqDCoMKgIGltYWdlLg0KPj4+IDMuIElmIHdlIHdhbnQgdG8gYWRkIGluY29tcGF0aWJsZSBmaWVs
ZCAob3IgYSBmaWVsZCwgZm9yIHdoaWNoIHNvbWUgaXRzDQo+Pj4gwqDCoMKgIHZhbHVlcyB3b3Vs
ZCBiZSBpbmNvbXBhdGlibGUpLCBpdCBtdXN0IGJlIGFjY29tcGFuaWVkIGJ5DQo+Pj4gwqDCoMKg
IGluY29tcGF0aWJsZSBmZWF0dXJlIGJpdC4NCj4+Pg0KPj4+IEFsc28gdGhlIGNvbmNlcHQgb2Yg
ImRlZmF1bHQgaXMgemVybyIgaXMgY2xhcmlmaWVkLCBhcyBpdCdzIHN0cmFuZ2UgdG8NCj4+PiBz
YXkgdGhhdCB0aGUgdmFsdWUgb2YgdGhlIGZpZWxkIGlzIGFzc3VtZWQgdG8gYmUgemVybyBmb3Ig
dGhlIHNvZnR3YXJlDQo+Pj4gdmVyc2lvbiB3aGljaCBkb24ndCBrbm93IGFib3V0IHRoZSBmaWVs
ZCBhdCBhbGwgYW5kIGRvbid0IGtub3cgaG93IHRvDQo+Pj4gdHJlYXQgaXQgYmUgaXQgemVybyBv
ciBub3QuDQo+Pj4NCj4+DQo+PiBJJ2QgYWxzbyBtZW50aW9uIHRoYXQgd2Ugd2FudCB0byBlbmZv
cmNlIDgtYnl0ZSBhbGlnbm1lbnQgaW4gdGhpcyBjb3ZlciBsZXR0ZXIuDQo+Pg0KPj4+IFNpZ25l
ZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVv
enpvLmNvbT4NCj4+PiAtLS0NCj4+PiDCoCBkb2NzL2ludGVyb3AvcWNvdzIudHh0IHwgMjYgKysr
KysrKysrKysrKysrKysrKysrKystLS0NCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kb2NzL2ludGVy
b3AvcWNvdzIudHh0IGIvZG9jcy9pbnRlcm9wL3Fjb3cyLnR4dA0KPj4+IGluZGV4IGFmNTcxMWU1
MzMuLjQ3MDlmM2JiMzAgMTAwNjQ0DQo+Pj4gLS0tIGEvZG9jcy9pbnRlcm9wL3Fjb3cyLnR4dA0K
Pj4+ICsrKyBiL2RvY3MvaW50ZXJvcC9xY293Mi50eHQNCj4+PiBAQCAtNzksOSArNzksOSBAQCBU
aGUgZmlyc3QgY2x1c3RlciBvZiBhIHFjb3cyIGltYWdlIGNvbnRhaW5zIHRoZSBmaWxlIGhlYWRl
cjoNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0
IGludG8gdGhlIGltYWdlIGZpbGUgYXQgd2hpY2ggdGhlIHNuYXBzaG90IHRhYmxlDQo+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXJ0cy4gTXVzdCBiZSBh
bGlnbmVkIHRvIGEgY2x1c3RlciBib3VuZGFyeS4NCj4+PiAtSWYgdGhlIHZlcnNpb24gaXMgMyBv
ciBoaWdoZXIsIHRoZSBoZWFkZXIgaGFzIHRoZSBmb2xsb3dpbmcgYWRkaXRpb25hbCBmaWVsZHMu
DQo+Pj4gLUZvciB2ZXJzaW9uIDIsIHRoZSB2YWx1ZXMgYXJlIGFzc3VtZWQgdG8gYmUgemVybywg
dW5sZXNzIHNwZWNpZmllZCBvdGhlcndpc2UNCj4+PiAtaW4gdGhlIGRlc2NyaXB0aW9uIG9mIGEg
ZmllbGQuDQo+Pj4gK0ZvciB2ZXJzaW9uIDIsIGhlYWRlciBpcyBhbHdheXMgNzIgYnl0ZXMgbGVu
Z3RoIGFuZCBmaW5pc2hlcyBoZXJlLg0KPj4+ICtGb3IgdmVyc2lvbiAzIG9yIGhpZ2hlciB0aGUg
aGVhZGVyIGxlbmd0aCBpcyBhdCBsZWFzdCAxMDQgYnl0ZXMgYW5kIGhhcyBhdA0KPj4+ICtsZWFz
dCBuZXh0IGZpdmUgZmllbGRzLCB1cCB0byB0aGUgQGhlYWRlcl9sZW5ndGggZmllbGQuDQo+Pg0K
Pj4gRm9yIHZlcnNpb24gMiwgdGhlIGhlYWRlciBpcyBleGFjdGx5IDcyIGJ5dGVzIGluIGxlbmd0
aCwgYW5kIGZpbmlzaGVzIGhlcmUuDQo+PiBGb3IgdmVyc2lvbiAzIG9yIGhpZ2hlciwgdGhlIGhl
YWRlciBsZW5ndGggaXMgYXQgbGVhc3QgMTA0IGJ5dGVzLCBpbmNsdWRpbmcgdGhlIG5leHQgZmll
bGRzIHRocm91Z2ggaGVhZGVyX2xlbmd0aC4NCj4+DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAg
NzIgLcKgIDc5OsKgIGluY29tcGF0aWJsZV9mZWF0dXJlcw0KPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCaXRtYXNrIG9mIGluY29tcGF0aWJsZSBmZWF0dXJl
cy4gQW4gaW1wbGVtZW50YXRpb24gbXVzdA0KPj4+IEBAIC0xNjQsNiArMTY0LDI2IEBAIGluIHRo
ZSBkZXNjcmlwdGlvbiBvZiBhIGZpZWxkLg0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAxMDAgLSAx
MDM6wqAgaGVhZGVyX2xlbmd0aA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBMZW5ndGggb2YgdGhlIGhlYWRlciBzdHJ1Y3R1cmUgaW4gYnl0ZXMuIEZvciB2
ZXJzaW9uIDINCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aW1hZ2VzLCB0aGUgbGVuZ3RoIGlzIGFsd2F5cyBhc3N1bWVkIHRvIGJlIDcyIGJ5dGVzLg0KPj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBGb3IgdmVyc2lvbiAzIGl0
J3MgYXQgbGVhc3QgMTA0IGJ5dGVzLg0KPj4NCj4+IEknZCBhbHNvIGFkZCBhIHNlbnRlbmNlIHRo
YXQgdGhpcyBmaWVsZCBtdXN0IGJlIGEgbXVsdGlwbGUgb2YgOC4NCj4+DQo+Pj4gKw0KPj4+ICtB
ZGRpdGlvbmFsIGZpZWxkcyAodmVyc2lvbiAzIGFuZCBoaWdoZXIpDQo+Pj4gKw0KPj4+ICtUaGUg
Zm9sbG93aW5nIGZpZWxkcyBvZiB0aGUgaGVhZGVyIGFyZSBvcHRpb25hbDogaWYgc29mdHdhcmUg
ZG9lc24ndCBrbm93IGhvdw0KPj4+ICt0byBpbnRlcnByZXQgdGhlIGZpZWxkLCBpdCBtYXkgYmUg
c2FmZWx5IGlnbm9yZWQsIG90aGVyIHRoYW4gcHJlc2VydmluZyB0aGUNCj4+PiArZmllbGQgdW5j
aGFuZ2VkIHdoZW4gcmV3cml0aW5nIHRoZSBpbWFnZSBoZWFkZXIuDQo+Pg0KPj4gTWF5YmU6DQo+
Pg0KPj4gaWYgc29mdHdhcmUgZG9lc24ndCBrbm93IGhvdyB0byBpbnRlcnByZXQgdGhlIGZpZWxk
LCBpdCBtYXkgYmUgc2FmZWx5IGlnbm9yZWQgdW5sZXNzIGEgY29ycmVzcG9uZGluZyBpbmNvbXBh
dGlibGUgZmVhdHVyZSBmbGFnIGJpdCBpcyBzZXQ7IGhvd2V2ZXIsIHRoZSBmaWVsZCBzaG91bGQg
YmUgcHJlc2VydmVkIHVuY2hhbmdlZCB3aGVuIHJld3JpdGluZyB0aGUgaW1hZ2UgaGVhZGVyLg0K
Pj4NCj4+PiArDQo+Pj4gK0ZvciBhbGwgYWRkaXRpb25hbCBmaWVsZHMgemVybyB2YWx1ZSBlcXVh
bHMgdG8gYWJzZW5jZSBvZiBmaWVsZCAoYWJzZW5jZSBpcw0KPj4+ICt3aGVuIGZpZWxkLm9mZnNl
dCArIGZpZWxkLnNpemUgPiBAaGVhZGVyX2xlbmd0aCkuIFRoaXMgaW1wbGllcw0KPj4+ICt0aGF0
IGlmIHNvZnR3YXJlIHdhbnQncyB0byBzZXQgZmllbGRzIHVwIHRvIHNvbWUgZmllbGQgbm90IGFs
aWduZWQgdG8gbXVsdGlwbHkNCj4+PiArb2YgOCBpdCBtdXN0IGFsaWduIGhlYWRlciB1cCBieSB6
ZXJvZXMuIEFuZCBvbiB0aGUgb3RoZXIgaGFuZCwgaWYgc29mdHdhcmUNCj4+PiArbmVlZCBzb21l
IG9wdGlvbmFsIGZpZWxkIHdoaWNoIGlzIGFic2VudCBpdCBzaG91bGQgYXNzdW1lIHRoYXQgaXQn
cyB2YWx1ZSBpcw0KPj4+ICt6ZXJvLg0KPj4NCj4+IE1heWJlOg0KPj4NCj4+IEVhY2ggb3B0aW9u
YWwgZmllbGQgdGhhdCBkb2VzIG5vdCBoYXZlIGEgY29ycmVzcG9uZGluZyBpbmNvbXBhdGlibGUg
ZmVhdHVyZSBiaXQgbXVzdCBzdXBwb3J0IHRoZSB2YWx1ZSAwIHRoYXQgZ2l2ZXMgdGhlIHNhbWUg
ZGVmYXVsdCBiZWhhdmlvciBhcyB3aGVuIHRoZSBvcHRpb25hbCBmaWVsZCBpcyBvbWl0dGVkLg0K
PiANCj4gSG1tbS4gVGhhdCBkb2Vzbid0IHdvcmssIGFzICJjb3JyZXNwb25kaW5nIiBpcyBzb21l
dGhpbmcgbm90IGFjdHVhbGx5IGRlZmluZWQuIENvbnNpZGVyIG91ciB6c3RkIGV4dGVuc2lvbi4N
Cj4gDQo+IEl0IGhhcyBjb3JyZXNwb25kaW5nIGluY29tcGF0aWJsZSBiaXQsIHRoZXJlZm9yZSwg
dGhpcyBzZW50ZW5jZSBkb2Vzbid0IGFwcGx5IHRvIGl0LiBCdXQgc3RpbGwsIGlmIGluY29tcGF0
aWJsZSBiaXQgaXMgdW5zZXQgd2UgY2FuIGhhdmUgdGhpcyBmaWVsZC4gQW5kIGl0J3MgemVybyB2
YWx1ZSBtdXN0IGNvcnJlc3BvbmQNCj4gdG8gdGhlIGFic2VuY2Ugb2YgdGhlIGZpZWxkLg0KPiAN
Cj4gU28sIGFkZGl0aW9uYWwgZmllbGQgbWF5IHVzZSBpbmNvbWFwdGlibGUgYml0IG9ubHkgZm9y
IHN1YnNldCBvZiBpdHMgdmFsdWVzLg0KPiANCj4gQnV0LCBJIHNlZSwgdGhhdCB5b3Ugd2FudCB0
byBhbGxvdyAwIHZhbHVlIHRvIG5vdCBtYXRjaCBmaWVsZC1hYnNlbmNlIGlmIGluY29tcGF0aWJs
ZSBiaXQgaXMgc2V0Pw0KPiANCj4gU28sIG1heSBiZQ0KPiANCj4gQWRkaXRpb25hbCBmaWVsZHMg
aGFzIHRoZSBmb2xsb3dpbmcgY29tcGF0aWJsZSBiZWhhdmlvciBieSBkZWZhdWx0Og0KPiANCj4g
MS4gSWYgc29mdHdhcmUgZG9lc24ndCBrbm93IGhvdyB0byBpbnRlcnByZXQgdGhlIGZpZWxkLCBp
dCBtYXkgYmUgc2FmZWx5IGlnbm9yZWQsIG90aGVyIHRoYW4gcHJlc2VydmluZyB0aGUgZmllbGQg
dW5jaGFuZ2VkIHdoZW4gcmV3cml0aW5nIHRoZSBpbWFnZSBoZWFkZXIuDQo+IDIuIFplcm9lZCBh
ZGRpdGlvbmFsIGZpZWxkIGdpdmVzIHRoZSBzYW1lIGJlaGF2aW9yIGFzIHdoZW4gdGhpcyBmaWVs
ZCBpcyBvbWl0dGVkLg0KPiANCj4gVGhpcyBkZWZhdWx0IGJlaGF2aW9yIG1heSBiZSBhbHRlcmVk
IHdpdGggaGVscCBvZiBpbmNvbXBhdGlibGUgZmVhdHVyZSBiaXRzLiBTbywgaWYsIGZvciBleGFt
cGxlLCBhZGRpdGlvbmFsIGZpZWxkIGhhcyBjb3JyZXNwb25kaW5nIGluY29tcGF0aWJsZSBmZWF0
dXJlIGJpdCwgYW5kIGl0IGlzIHNldCwgd2UgYXJlIHN1cmUgdGhhdCBzb2Z0d2FyZSB3aGljaCBv
cGVucyB0aGUgaW1hZ2Uga25vd3MgaG93IHRvIGludGVycHJldCB0aGUgZmllbGQsIHNvLA0KPiAx
LiBUaGUgZmllbGQgZGVmaW5pdGVseSB3aWxsIG5vdCBiZSBpZ25vcmVkIHdoZW4gY29ycmVzcG9u
ZGluZyBpbmNvbXBhdGlibGUgYml0IGlzIHNldC4NCj4gMi4gVGhlIGZpZWxkIG1heSBkZWZpbmUg
YW55IG1lYW5pbmcgaXQgd2FudHMgZm9yIHplcm8gdmFsdWUgZm9yIHRoZSBjYXNlIHdoZW4gY29y
cmVzcG9uZGluZyBpbmNvbXBhdGlibGUgYml0IGlzIHNldC4NCj4gDQo+Pg0KPj4+ICsNCj4+PiAr
SXQncyBhbGxvd2VkIGZvciB0aGUgaGVhZGVyIGVuZCB0byBjdXQgc29tZSBmaWVsZCBpbiB0aGUg
bWlkZGxlIChpbiB0aGlzIGNhc2UNCj4+PiArdGhlIGZpZWxkIGlzIGNvbnNpZGVyZWQgYXMgYWJz
ZW50KSwgYnV0IGluIHRoaXMgY2FzZSB0aGUgcGFydCBvZiB0aGUgZmllbGQNCj4+PiArd2hpY2gg
aXMgY292ZXJlZCBieSBAaGVhZGVyX2xlbmd0aCBtdXN0IGJlIHplcm9lZC4NCj4+PiArDQo+Pj4g
K8KgwqDCoMKgwqDCoMKgIDwgLi4uIE5vIGFkZGl0aW9uYWwgZmllbGRzIGluIHRoZSBoZWFkZXIg
Y3VycmVudGx5IC4uLiA+DQo+Pg0KPj4gRG8gd2UgZXZlbiBzdGlsbCBuZWVkIHRoaXMgaWYgd2Ug
cmVxdWlyZSA4LWJ5dGUgYWxpZ25tZW50P8KgIFdlJ2QgbmV2ZXIgYmUgYWJsZSB0byBjdXQgYSBz
aW5nbGUgZmllbGQgaW4gdGhlIG1pZGRsZQ0KPiANCj4gaG1tLCBmb3IgZXhhbXBsZToNCj4gMTA1
OiBjb21wcmVzc2lvbiBieXRlDQo+IDEwNi0xMTM6IHNvbWUgb3RoZXIgOC1ieXRlcyBmaWVsZCwg
dW5hbGluZ2VkDQo+IDExMy0xMTk6IHBhZGRpbmcgdG8gbXVsdGlwbHkgb2YgOA0KPiANCj4gLSBi
YWQgZXhhbXBsZSwgZm9yIHN1cmUuIEJ1dCB0byBwcmV2ZW50IGl0LCB3ZSBzaG91bGQgYWxzbyBk
ZWZpbmUgc29tZSBmaWVsZCBhbGlnbm1lbnQgcmVxdWlyZW1lbnRzLi4NCj4gDQo+IA0KPj4gLCBi
dXQgSSBzdXBwb3NlIHlvdSBhcmUgd29ycmllZCBhYm91dCBjdXR0aW5nIGEgMi1maWVsZCAxNi1i
eXRlIGFkZGl0aW9uIHRpZWQgdG8gYSBzaW5nbGUgZmVhdHVyZSBpbiB0aGUgbWlkZGxlLg0KPiAN
Cj4gYW5kIHRoaXMgdG9vLg0KPiANCj4+IMKgIEJ1dCB0aGF0J3Mgbm90IGdvaW5nIHRvIGhhcHBl
biBpbiBwcmFjdGljZS4NCj4gDQo+IHdoeSBub3Q/DQo+IA0KPiA0IGJ5dGVzOiBmZWF0dXJlIDEN
Cj4gDQo+IDQgYnl0ZXM6IGZlYXR1cmUgMg0KPiA4IGJ5dGVzOiBmZWF0dXJlIDINCj4gDQo+IHNv
LCBsYXN0IDEyIGJ5dGVzIG1heSBiZSBjb25zaWRlcmVkIGFzIG9uZSBmaWVsZC4uIEFuZCBzb2Z0
d2FyZSB3aGljaCBkb24ndCBrbm93IGFib3V0IGZlYXR1cmUyLCB3aWxsIHBhZCBoZWFkZXIgdG8g
dGhlIG1pZGRsZSBvZiBmZWF0dXJlMg0KPiANCj4+IFRoZSBvbmx5IHRpbWUgdGhlIGhlYWRlciB3
aWxsIGJlIGxvbmdlciB0aGFuIDEwNCBieXRlcyBpcyBpZiBhdCBsZWFzdCBvbmUgZG9jdW1lbnRl
ZCBvcHRpb25hbCBmZWF0dXJlIGhhcyBiZWVuIGltcGxlbWVudGVkL2JhY2twb3J0ZWQsIGFuZCB0
aGF0IGZlYXR1cmUgd2lsbCBiZSBpbXBsZW1lbnRlZCBpbiBpdHMgZW50aXJldHkuwqAgSWYgeW91
IGJhY2twb3J0IGEgbGF0ZXIgZmVhdHVyZSBidXQgbm90IHRoZSBlYXJsaWVyLCB5b3UncmUgc3Rp
bGwgZ29pbmcgdG8gc2V0IGhlYWRlcl9sZW5ndGggdG8gdGhlIGJvdW5kYXJ5IG9mIHRoZSBmZWF0
dXJlIHRoYXQgeW91IEFSRSBiYWNrcG9ydGluZy4NCj4gDQo+IFRoYXQncyB0cnVlLCBvZiBjb3Vy
c2UuDQo+IA0KPj4gwqAgVGh1cywgSSBhcmd1ZSB0aGF0IGJsaW5kbHkgc2V0dGluZyBoZWFkZXJf
bGVuZ3RoIHRvIDEyMCBwcmlvciB0byB0aGUgc3RhbmRhcmQgZXZlciBkZWZpbmluZyBvcHRpb25h
bCBmaWVsZChzKSBhdCAxMTItMTIwIGlzIHByZW1hdHVyZSwgYW5kIHRoYXQgaWYgd2UgZXZlciBh
ZGQgYSBmZWF0dXJlIHJlcXVpcmluZyBieXRlcyAxMTItMTI4IGZvciBhIG5ldyBmZWF0dXJlLCB5
b3Ugd2lsbCBuZXZlciBzZWUgYSB2YWxpZCBxY293MiBmaWxlIHdpdGggYSBoZWFkZXIgbGVuZ3Ro
IG9mIDEyMC4NCj4gDQo+IGNvbnNpZGVyIG15IGV4YW1wbGUgYWJvdmUuDQo+IA0KPiANCj4gDQoN
CkVyaWMgd2hhdCBkbyB5b3UgdGhpbms/DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXIN
Cg==

