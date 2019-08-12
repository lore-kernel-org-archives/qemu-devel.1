Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D303C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 17:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABC820684
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 17:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LydIfwAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABC820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxDix-0001u1-Vi
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 13:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58633)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxDiK-00017Z-Ru
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 13:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxDiJ-0008D8-Gz
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 13:02:32 -0400
Received: from mail-eopbgr80117.outbound.protection.outlook.com
 ([40.107.8.117]:59719 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxDiJ-0008C4-1F; Mon, 12 Aug 2019 13:02:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cF7Bjl6rfYWCn5cUulRhnjTRukhPIEwyYS47Tdp8lSVdIu7RoeRyZNxrD/pus156gUhBfx7Dc+3YcmEVUiBNhihA6qmVuGN7jFfWUVr+0f+hKlnN9+1M1RwzUhb2SE1BkVUmGmqYPZeZ6VlnBcDec0JxbiP93w6Rp6lfD9+vWYqT4LGD4OinyKeQs/53keqYK6PiQteMDSyeAiBsldq3RB05cwQDvASdZwwVVeOC+HhLNYxqn4nJZYJX6S3cqvdx0EGsLBKyVef94fPGM45r9AsbeBhI0dR2ny4tqPnn/W6kt7OeRAJg/G0iI5v3rqahC4Y8wy1FHi/G61noZP86iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWwO8u/bK7yyt5jiYXg/7WkwMG0tAAR2rZC6y/iDTlE=;
 b=TC4hhOjZTZb5wbcjIHKJDWmaV+Lx95YFHFT96k7e1sckleadrvIGgPW6L3xbmSx1rAcysY19AM5nQw3T5pU0i/OUbmzh6o3aRAfsbVy2bY+BzjLoN5utr3A2chrLNlUbN5bitzigbz7Wvqdk7QisKy9e4TMNqoSSL8NRNhyfHIfubpMnazU2aWX8078U7V4MDi8CLgjBQUzyIcD0XOoqaNH/XhIQ3TyTJWS1WmlqwStbxw3e8qNiME3iYBCLA0Lf8stsgctymP50D4xuTVUgOuMoBxTgCWQ9K53v3B+1I8WQ8bv0Yc1dnVFhmQycC1PyhmPc6xV6hJ2bC+WIUod+2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWwO8u/bK7yyt5jiYXg/7WkwMG0tAAR2rZC6y/iDTlE=;
 b=LydIfwAaSQORL8bqeSznQ9RDHGqQu7qcipKplfbG1XCEgOVYrBIY3y35BNmo9+E53g0gkgB+v8F8SDSsXNsxiwjGpxoy61RxJb7k7KwTBRzUrKFT10gu3VjuvhWhekW8mVHhl3XU7kKfhkYBRtgMmL/SSJ5NuK3+hqtKHEzP6tk=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5500.eurprd08.prod.outlook.com (52.133.243.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Mon, 12 Aug 2019 17:02:28 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 17:02:28 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: backup bug or question
Thread-Index: AQHVTrTrc8JESPxQGUmDMebwH05otKb3hPMAgAAuUICAAAsiAIAAA56A
Date: Mon, 12 Aug 2019 17:02:28 +0000
Message-ID: <9baebb38-7e0b-f629-e6e9-b1455672ad70@virtuozzo.com>
References: <6826e3c2-bc6e-b2a2-1bf1-3ed31079f0ee@virtuozzo.com>
 <20190812132352.GA6400@localhost.localdomain>
 <1b4f5b7c-ca3c-365d-f4ec-d3009b0bde59@virtuozzo.com>
 <20190812164928.GC6400@localhost.localdomain>
In-Reply-To: <20190812164928.GC6400@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0009.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::22)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190812200225710
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 435e4662-5e92-42b5-058d-08d71f46db06
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5500; 
x-ms-traffictypediagnostic: DB8PR08MB5500:
x-microsoft-antispam-prvs: <DB8PR08MB5500877FFBE12595FD0C1E4CC1D30@DB8PR08MB5500.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(39840400004)(376002)(346002)(396003)(199004)(189003)(52314003)(476003)(2616005)(229853002)(486006)(66476007)(66556008)(256004)(6436002)(14444005)(6916009)(66066001)(5660300002)(6486002)(14454004)(36756003)(54906003)(8936002)(446003)(64756008)(11346002)(66446008)(478600001)(316002)(71190400001)(71200400001)(76176011)(52116002)(99286004)(31686004)(6246003)(2906002)(3846002)(53936002)(4326008)(3480700005)(386003)(6512007)(86362001)(6506007)(81156014)(8676002)(81166006)(102836004)(25786009)(7736002)(66946007)(6116002)(305945005)(186003)(26005)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5500;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XDXaecqSsSfF9mtfgh+TNz7wPZGQQYdWOC3n5xwfiL08OuAzbIEVjHRTiIkyZ4gFsuPbF3M9p28mOphR9ooFRNZT1KL59leBSgZqeZnRHwEZzabA+X8gF9FRITvr3PmTM0pP+5kZLn6bxrH+Khqw5KN3ndhrwEpOSXYCcPrApEW2nqkq5aDGO2QeNHdUrd4bS81vDAC4FB+wYtegmKlphrvGjFfHVhIojoLsWUbTpdhagqcUcdObuNz2JSvQKQSVq99alO8ZTaBrLRoe9nK62P9FFz8TOg7/CZhrPhdvBIB5C9sz0n8HHXYUZAV2gwFEcetQlyVPT0cP6xMHt1tKyz1uQOCUUsfCrjRH5FK6gHJ4V037Jr/9adnG3yjB0gpzqGSnF41l3rYw/wo8RMysFlpcjb8Hd0kB0DSIrfhVO2Y=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6CF2110A3A54240BA6EB751A3B44E7F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435e4662-5e92-42b5-058d-08d71f46db06
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 17:02:28.0822 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f+lCH9NxTyH93+wHBDeZiQrEN49f5OI4xipkN6OelR53JlLNPqdd16LOE0ku38W4496/OSoQF+TIF4VeSI2ZJw3SwgA2u82P99HO9uJ5S1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5500
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.117
Subject: Re: [Qemu-devel] backup bug or question
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTIuMDguMjAxOSAxOTo0OSwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTIuMDguMjAxOSB1bSAx
ODowOSBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDEy
LjA4LjIwMTkgMTY6MjMsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4gQW0gMDkuMDguMjAxOSB1bSAx
NToxOCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+Pj4g
SGkhDQo+Pj4+DQo+Pj4+IEhtbSwgaGFja2luZyBhcm91bmQgYmFja3VwIEkgaGF2ZSBhIHF1ZXN0
aW9uOg0KPj4+Pg0KPj4+PiBXaGF0IHByZXZlbnRzIGd1ZXN0IHdyaXRlIHJlcXVlc3QgYWZ0ZXIg
am9iX3N0YXJ0IGJ1dCBiZWZvcmUgc2V0dGluZw0KPj4+PiB3cml0ZSBub3RpZmllcj8NCj4+Pj4N
Cj4+Pj4gY29kZSBwYXRoOg0KPj4+Pg0KPj4+PiBxbXBfZHJpdmVfYmFja3VwIG9yIHRyYW5zYWN0
aW9uIHdpdGggYmFja3VwDQo+Pj4+DQo+Pj4+ICAgICAgIGpvYl9zdGFydA0KPj4+PiAgICAgICAg
ICBhaW9fY29fZW50ZXIoam9iX2NvX2VudHJ5KSAvKiBtYXkgb25seSBzY2hlZHVsZSBleGVjdXRp
b24sIGlzbid0IGl0ID8gKi8NCj4+Pj4NCj4+Pj4gLi4uLg0KPj4+Pg0KPj4+PiBqb2JfY29fZW50
cnkNCj4+Pj4gICAgICAgam9iX3BhdXNlX3BvaW50KCkgLyogaXQgZGVmaW5pdGVseSB5aWVsZHMs
IGlzbid0IGl0IGJhZD8gKi8NCj4+Pj4gICAgICAgam9iLT5kcml2ZXItPnJ1bigpIC8qIGJhY2t1
cF9ydW4gKi8NCj4+Pj4NCj4+Pj4gLS0tLQ0KPj4+Pg0KPj4+PiBiYWNrdXBfcnVuKCkNCj4+Pj4g
ICAgICAgYmRydl9hZGRfYmVmb3JlX3dyaXRlX25vdGlmaWVyKCkNCj4+Pj4NCj4+Pj4gLi4uDQo+
Pj4+DQo+Pj4+IEFuZCB3aGF0IGd1YXJhbnRlZXMgd2UgZ2l2ZSB0byB0aGUgdXNlcj8gSXMgaXQg
Z3VhcmFudGVlZCB0aGF0IHdyaXRlIG5vdGlmaWVyIGlzDQo+Pj4+IHNldCB3aGVuIHFtcCBjb21t
YW5kIHJldHVybnM/DQo+Pj4+DQo+Pj4+IEFuZCBJIGd1ZXNzLCBpZiB3ZSBzdGFydCBzZXZlcmFs
IGJhY2t1cHMgaW4gYSB0cmFuc2FjdGlvbiBpdCBzaG91bGQgYmUgZ3VhcmFudGVlZA0KPj4+PiB0
aGF0IHRoZSBzZXQgb2YgYmFja3VwcyBpcyBjb25zaXN0ZW50IGFuZCBjb3JyZXNwb25kIHRvIG9u
ZSBwb2ludCBpbiB0aW1lLi4uDQo+Pj4NCj4+PiBEbyB0aGUgcGF0Y2hlcyB0byBzd2l0Y2ggYmFj
a3VwIHRvIGEgZmlsdGVyIG5vZGUgc29sdmUgdGhpcw0KPj4+IGF1dG9tYXRpY2FsbHkgYmVjYXVz
ZSB0aGF0IG5vZGUgd291bGQgYmUgaW5zZXJ0ZWQgaW4NCj4+PiBiYWNrdXBfam9iX2NyZWF0ZSgp
Pw0KPj4+DQo+Pg0KPj4gSG1tLCBncmVhdCwgbG9va3MgbGlrZSB0aGV5IHNob3VsZC4gQXQgbGVh
c3QgaXQgbW92ZXMgc2NvcGUgb2YgdGhlDQo+PiBwcm9ibGVtIHRvIGRvX2RyaXZlX2JhY2t1cCBh
bmQgZG9fYmxvY2tkZXZfYmFja3VwIGZ1bmN0aW9ucy4uDQo+Pg0KPj4gQW0gSSByaWdodCB0aGF0
IGFpb19jb250ZXh0X2FjcXVpcmUvYWlvX2NvbnRleHRfcmVsZWFzZSBndWFyYW50ZWVzIG5vDQo+
PiBuZXcgcmVxdWVzdCBjcmVhdGVkIGR1cmluZyB0aGUgc2VjdGlvbj8gT3Igc2hvdWxkIHdlIGFk
ZA0KPj4gZHJhaW5lZF9iZWdpbi9kcmFpbmVkX2VuZCBwYWlyLCBvciBhdCBsZWFzdCBkcmFpbigp
IGF0IHN0YXJ0IG9mDQo+PiBxbXBfYmxvY2tkZXZfYmFja3VwIGFuZCBxbXBfZHJpdmVfYmFja3Vw
Pw0KPiANCj4gSG9sZGluZyB0aGUgQWlvQ29udGV4dCBsb2NrIHNob3VsZCBiZSBlbm91Z2ggZm9y
IHRoaXMuDQo+IA0KPiBCdXQgbm90ZSB0aGF0IGl0IGRvZXNuJ3QgbWFrZSBhIGRpZmZlcmVuY2Ug
aWYgbmV3IHJlcXVlc3RzIGFyZSBhY3R1YWxseQ0KPiBpbmNvbWluZy4gVGhlIHRpbWluZyBvZiB0
aGUgUU1QIGNvbW1hbmQgdG8gc3RhcnQgYSBiYWNrdXAgam9iIHZlcnN1cyB0aGUNCj4gdGltaW5n
IG9mIGd1ZXN0IHJlcXVlc3RzIGlzIGVzc2VudGlhbGx5IHJhbmRvbS4gUUVNVSBkb2Vzbid0IGtu
b3cgd2hhdA0KPiBndWVzdCByZXF1ZXN0cyB5b3UgbWVhbiB0byBiZSBpbmNsdWRlZCBpbiB0aGUg
YmFja3VwIGFuZCB3aGljaCB5b3UgZG9uJ3QNCj4gdW5sZXNzIHlvdSBzdG9wIHNlbmRpbmcgbmV3
IHJlcXVlc3RzIHdlbGwgYWhlYWQgb2YgdGltZS4NCj4gDQo+IElmIHlvdSBzZW5kIGEgUU1QIHJl
cXVlc3QgdG8gc3RhcnQgYSBiYWNrdXAsIHRoZSBiYWNrdXAgd2lsbCBiZQ0KPiBjb25zaXN0ZW50
IGZvciBzb21lIGFyYml0cmFyeSBwb2ludCBpbiB0aW1lIGJldHdlZW4gdGhlIHRpbWUgdGhhdCB5
b3UNCj4gc2VudCB0aGUgUU1QIHJlcXVlc3QgYW5kIHRoZSB0aW1lIHRoYXQgeW91IHJlY2VpdmVk
IHRoZSByZXBseSB0byBpdC4NCj4gDQo+IERyYWluaW5nIGluIHRoZSBRTVAgY29tbWFuZCBoYW5k
bGVyIHdvdWxkbid0IGNoYW5nZSBhbnkgb2YgdGhpcywgYmVjYXVzZQ0KPiBldmVuIHRoZSBkcmFp
biBzZWN0aW9uIHN0YXJ0cyBhdCBzb21lIGFyYml0cmFyeSBwb2ludCBpbiB0aW1lLg0KDQpIbW0g
YW5kIGl0IGRvbid0IGd1YXJhbnRlZSBldmVuIHRoYXQgcmVxdWVzdHMgc3RhcnRlZCBiZWZvcmUg
cW1wIGNvbW1hbmQgYXJlDQp0YWtlbiBpbnRvIGJhY2t1cCwgYXMgdGhleSBtYXkgYmUgc3RhcnRl
ZCBpbiBndWVzdCBwb2ludCBvZiB2aWV3LCBidXQgbm90IHlldA0KaW4gUUVNVS4uDQoNCj4gDQo+
PiBBc3N1bWUgc2NlbmFyaW8gbGlrZSB0aGUgdGhpcywNCj4+DQo+PiAxLiBmc2ZyZWV6ZQ0KPj4g
Mi4gcW1wIGJhY2t1cA0KPj4gMy4gZnN0aGF3DQo+Pg0KPj4gdG8gbWFrZSBzdXJlIHRoYXQgYmFj
a3VwIHN0YXJ0aW5nIHBvaW50IGlzIGNvbnNpc3RlbnQuIFNvIGluIG91ciBxbXAgY29tbWFuZCB3
ZSBzaG91bGQ6DQo+PiAxLiBjb21wbGV0ZSBhbGwgY3VycmVudCByZXF1ZXN0cyB0byBtYWtlIGRy
aXZlcyBjb3JyZXNwb25kaW5nIHRvIGZzZnJlZXplIHBvaW50DQo+PiAyLiBpbml0aWFsaXplIHdy
aXRlLW5vdGlmaWVycyBvciBmaWx0ZXIgYmVmb3JlIGFueSBuZXcgZ3Vlc3QgcmVxdWVzdCwgaS5l
LiBiZWZvcmUgZnN0aGF3LA0KPj4gaS5lLiBiZWZvcmUgcW1wIGNvbW1hbmQgcmV0dXJuLg0KPiAN
Cj4gSWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSwgZnNmcmVlemUgb25seSByZXR1cm5zIHN1Y2Nl
c3MgYWZ0ZXIgaXQgaGFzDQo+IG1hZGUgc3VyZSB0aGF0IHRoZSBndWVzdCBoYXMgcXVpZXNjZWQg
dGhlIGRldmljZS4gU28gYXQgYW55IHBvaW50DQo+IGJldHdlZW4gcmVjZWl2aW5nIHRoZSBzdWNj
ZXNzZnVsIHJldHVybiBvZiB0aGUgZnNmcmVlemUgYW5kIGNhbGxpbmcNCj4gZnN0aGF3LCB0aGUg
c3RhdGUgc2hvdWxkIGJlIGNvbnNpc3RlbnQuDQo+IA0KPj4gVHJhbnNhY3Rpb25zIHNob3VsZCBi
ZSBPSywgYXMgdGhleSB1c2UgZHJhaW5lZF9iZWdpbi9kcmFpbmVkX2VuZA0KPj4gcGFpcnMsIGFu
ZCBhZGRpdGlvbmFsIGFpb19jb250ZXh0X2FjcXVpcmUvYWlvX2NvbnRleHRfcmVsZWFzZSBwYWly
cy4NCj4gDQo+IEhlcmUsIGRyYWluaW5nIGlzIGFjdHVhbGx5IGltcG9ydGFudCBiZWNhdXNlIHlv
dSBkb24ndCBzeW5jaHJvbmlzZQ0KPiBhZ2FpbnN0IHNvbWV0aGluZyBleHRlcm5hbCB0aGF0IHlv
dSBkb24ndCBjb250cm9sIGFueXdheSwgYnV0IHlvdSBqdXN0DQo+IG1ha2Ugc3VyZSB0aGF0IHlv
dSBzdGFydCB0aGUgYmFja3VwIG9mIGFsbCBkaXNrcyBhdCB0aGUgc2FtZSBwb2ludCBpbg0KPiB0
aW1lICh3aGljaCBpcyBzdGlsbCBhbiBhcmJpdHJhcnkgcG9pbnQgYmV0d2VlbiB0aGUgdGltZSB0
aGF0IHlvdSBzZW5kDQo+IHRoZSB0cmFuc2FjdGlvbiBRTVAgY29tbWFuZCBhbmQgdGhlIHRpbWUg
dGhhdCB5b3UgcmVjZWl2ZSBzdWNjZXNzKSwgZXZlbg0KPiBpZiBubyBmc2ZyZWV6ZS9mc3RoYXcg
d2FzIHVzZWQuDQo+IA0KPiBLZXZpbg0KPiANCg0KT0ssIHRoYW5rcyBmb3IgZXhwbGFuYXRpb24h
DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

