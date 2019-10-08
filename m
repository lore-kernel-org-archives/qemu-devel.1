Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9A7C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D96F3206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MtC9BbcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96F3206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHpxU-0002CT-2W
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 09:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHpvY-00016k-28
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:53:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHpvW-0002Kw-NL
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:53:23 -0400
Received: from mail-vi1eur04on0706.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::706]:56065
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iHpvS-0002Fg-KL; Tue, 08 Oct 2019 09:53:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWw1NIgfYch1BqqrpL4Mxq5VnSn3342sf+8WorN1M8Bz+rLbeYFkuIs7S1XzDD+gQjl7Zd8mleMk7MXfOp+gifTqD0OswffIFTJCDdQq55oXufpn87PzSlGvRK0KRYVzq0ZzeLOrtQOis2BWVYo2G4ptolrsKGd60dJAJYXkjkypdrMlMw0ij4xQjosRiv+DNofZAVj1AuolM4OlU+3t2TCqDY8N/RP5LUm6d+lIbRGFxicRlw4Mn6Wl5nKO9092Qs/Syy8w+xb85vRQPkruHTpBH6CSxhNlJJ++0d69cXA0+PFuDFxM6QI8Wkg4nur7Nu+unmVk2b0JuZwadF47ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJEklBnCIqThIXIf5xjwn6ZU0WXVJRwh6Qox1G/NiqY=;
 b=UE5ED6RY9d4OwD8YNyGk1/ZxXw2B3qUFU96dTeKThnC2+9onZA+dHgmmyzUC9+BDSbkFiECHjtiGDX6uonOt6yAa1FJxpv3DXgctHPYu8dsD/vesX1PyIELG3vnypiisW75oZYJVHsdixvWcGFyGTM1yhj44HnzKeM108NF4/TobwXEUA8nXI+6FrHnfZYVVFGylLk6IZfddAsNUoRUK4rWty/PGWXYhRtoUtwWdz+EdycUOBdv/PSHQrs2Lb8UA7ASZt+3+3YcNWpM2xzgjda+U1gohRx4g5EOlqFftGoYACQOsRhOlKjBuvbIx4dgEFiRqB0xz5ZZ4p6zhkakLkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJEklBnCIqThIXIf5xjwn6ZU0WXVJRwh6Qox1G/NiqY=;
 b=MtC9BbcIs/UcG0SDcX/IGwEbC/Gk6Dzh7mw8WdNioZlG5kKXEgVubPEsqM5t/08jX24r9hgNDyF65NrY6zFx0WHYAb1qd9mYvrfOJDhW0o/0uP5PxfH43fSM12QKuMUz22eLukSsT0bv/vw5DrHcuP4XPK/XB0Lz8mrjWDPo/cE=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4076.eurprd08.prod.outlook.com (20.179.12.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Tue, 8 Oct 2019 13:53:13 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2327.023; Tue, 8 Oct 2019
 13:53:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH] qemu-nbd: Document benefit of --pid-file
Thread-Topic: [PATCH] qemu-nbd: Document benefit of --pid-file
Thread-Index: AQHVfUg6+Pk7KfOVdEyr6uO98fDVoadQeeUAgAA2zYCAAA05AIAAAuAAgAAEFoA=
Date: Tue, 8 Oct 2019 13:53:13 +0000
Message-ID: <99240aec-6d19-cea6-5b95-6bbf5a9106e8@virtuozzo.com>
References: <20191007194840.29518-1-eblake@redhat.com>
 <20191008092448.GD1192@redhat.com>
 <04440b88-78f6-e177-924d-e16fc3c29b5c@virtuozzo.com>
 <d4b715de-6d5d-6f43-e845-86ddc01c3eac@redhat.com>
 <20191008133834.GG1192@redhat.com>
In-Reply-To: <20191008133834.GG1192@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0299.eurprd05.prod.outlook.com
 (2603:10a6:7:93::30) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191008165311200
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42ea1e4c-73ca-4e7f-c33e-08d74bf6dcc5
x-ms-traffictypediagnostic: DB8PR08MB4076:
x-microsoft-antispam-prvs: <DB8PR08MB40760D814ED3118231BDA1DAC19A0@DB8PR08MB4076.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(396003)(366004)(136003)(346002)(199004)(189003)(54906003)(110136005)(4326008)(2906002)(316002)(6246003)(99286004)(3846002)(31686004)(6116002)(76176011)(14454004)(5660300002)(71200400001)(71190400001)(478600001)(6512007)(8936002)(446003)(6486002)(86362001)(11346002)(386003)(7736002)(305945005)(102836004)(476003)(52116002)(25786009)(66446008)(486006)(6506007)(66946007)(53546011)(31696002)(186003)(81156014)(81166006)(36756003)(229853002)(64756008)(256004)(66476007)(66556008)(8676002)(6436002)(66066001)(26005)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4076;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jwRZ5wfR40XRdCQ8rZ+NzDCUrzTNHsBVAf+dRq4ohZCvQupK5/55Qr0I0DWZj6KiKd28RCYwZrWPQZA717z4ygb/CzK9QQdtc1hb+mPHEG479c4lVwsGXbrWguqXLy7XiqvCww0Aogcps9Lw4ykXMS5eDymTrVzVIyzs7Jj4gnEsGqPNfnDBewY8BtZ5O3vPrrS4BSOC+olzAZQqIFL7u1786mRWQMUC3kwEwWOxipsLUB6X9lD+xJafGT7h76aS6jPhdKWQ0VUlOd1xDrEkOnTOj3bXZrtN7I17eOeTboeI8vqM6LNis2+vQ4EAlLeEhiuzqzs+OcGHb2YMBjrBs4e9kZPTKtg2hXAdFeOUA/dzAl2yHzFBZ+B/JLb6EARqAaBP//BSzxYpT+SJSBt4ZrriZG+jrWsQGC3xL2++bMw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0216A21173BE7440905EC62D7ADC8F8E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ea1e4c-73ca-4e7f-c33e-08d74bf6dcc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 13:53:13.6282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: na0ptKdh9fftXRCbt9PRCkqZDPgGq90HmZPMTwWzohNPekyzvWpWLCWS0uYSowBNVZBifsNO+GJ2tASrEUpRu1VGee7wXvs96BA+1xHlnPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4076
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::706
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
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDguMTAuMjAxOSAxNjozOCwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4gT24gVHVlLCBP
Y3QgMDgsIDIwMTkgYXQgMDg6Mjg6MTZBTSAtMDUwMCwgRXJpYyBCbGFrZSB3cm90ZToNCj4+IE9u
IDEwLzgvMTkgNDo0MCBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+
PiAwOC4xMC4yMDE5IDEyOjI0LCBEYW5pZWwgUC4gQmVycmFuZ8OpIHdyb3RlOg0KPj4+PiBPbiBN
b24sIE9jdCAwNywgMjAxOSBhdCAwMjo0ODo0MFBNIC0wNTAwLCBFcmljIEJsYWtlIHdyb3RlOg0K
Pj4+Pj4gT25lIGJlbmVmaXQgb2YgLS1waWQtZmlsZSBpcyB0aGF0IGl0IGlzIGVhc2llciB0byBw
cm9iZSB0aGUgZmlsZQ0KPj4+Pj4gc3lzdGVtIHRvIHNlZSBpZiBhIHBpZCBmaWxlIGhhcyBiZWVu
IGNyZWF0ZWQgdGhhbiBpdCBpcyB0byBwcm9iZSBpZiBhDQo+Pj4+PiBzb2NrZXQgaXMgYXZhaWxh
YmxlIGZvciBjb25uZWN0aW9uLiBEb2N1bWVudCB0aGF0IHRoaXMgaXMgYW4NCj4+Pj4+IGludGVu
dGlvbmFsIGZlYXR1cmUuDQo+Pj4+DQo+Pj4+IEknbSBub3Qgc2VlaW5nIGhvdyBjaGVja2luZyB0
aGUgcGlkIGZpbGUgaXMgYmV0dGVyIHRoYW4gY2hlY2tpbmcNCj4+Pj4gdGhlIHNvY2tldCBkaXJl
Y3RseSA/IEkgdGhpbmsgaXQgaXMgcHJvYmFibHkgYWN0dWFsbHkgd29yc2UuDQo+Pj4+DQo+Pj4+
IFRoZSBtYWluIHByb2JsZW0gd2l0aCB0aGUgc29ja2V0IGlzIHRoYXQgd2hpbGUgd2UgdW5saW5r
IG9uIGNsZWFuDQo+Pj4+IHNodXRkb3duLCBpdCBtYXkgc3RpbGwgZXhpc3QgaW4gZGlzayBpZiB0
aGUgcHJvY2VzcyBoYXMgZXhpdHRlZA0KPj4+PiBhYm5vcm1hbGx5Lg0KPj4+Pg0KPj4+PiBXaXRo
IHRoZSBwaWRmaWxlIHRob3VnaCB3ZSBkb24ndCBldmVyIHVubGluayBpdCwgZXZlbiBvbiBjbGVh
bg0KPj4+PiBzaHV0ZG93biwgYXMgd2UgZG9uJ3QgdXNlIHRoZSBwaWQgZmlsZXMgZXhpc3RhbmNl
IGFzIGEgbXV0dWFsDQo+Pj4+IGV4Y2x1c2lvbiBjaGVjay4gV2UgaW5zdGVhZCBhY3F1aXJlIGZj
bnRsIGxvY2tzIG9uIGl0Lg0KPj4+Pg0KPj4+PiBJT1cgdGhlIHBpZGZpbGUgY291bGQgZXhpc3Qg
YWxyZWFkeSB3aGVuIHFlbXUtbmJkIHN0YXJ0cyB1cCBhbmQNCj4+Pj4gd2lsbCBzdGlsbCBleGlz
dCB3aGVuIGl0IHF1aXRzLg0KPj4+DQo+Pj4gR29vZCBwb2ludC4NCj4+Pg0KPj4+IEkgd2FzIGp1
c3QgYSBiaXQgY29uZnVzZWQsIGJlY2F1c2UgcGlkIGZpbGUgaXMgc29tZXRoaW5nIHVucmVsYXRl
ZCB0bw0KPj4+IHNvY2tldCwgYW5kIHdoeSB1c2Ugb25lIHRoaW5nIHRvIGNoZWNrIHRoZSBleGlz
dGVuY2Ugb2YgYW5vdGhlciwgaWYgd2UNCj4+PiBjYW4gZGlyZWN0bHkgdHJ5IHRvIGNvbm5lY3Qu
DQo+Pg0KPj4gQ29uc2lkZXIgdGhlIGNhc2Ugb2Ygd3JpdGluZyBhIHRlc3RzdWl0ZSB0aGF0IGlu
dm9sdmVzIGFuIG5iZCBjbGllbnQsIHdoZXJlDQo+PiB5b3Ugd2FudCB0byBmaXJlIHVwIHFlbXUt
bmJkIGFzIHRoZSBzZXJ2ZXIuICBDaGVja2luZyBmb3IgYSBwaWQgZmlsZSBpbg0KPj4gc2hlbGwg
aXMgZWFzeSwgYW5kIGNhbiBiZSBkb25lIHByaW9yIHRvIHRoZSBwb2ludCBvZiBzcGF3bmluZyBh
IGNsaWVudC4NCj4+IENoZWNraW5nIGZvciBhIHN1Y2Nlc3NmdWwgY29ubmVjdCBpcyBoYXJkZXIg
LSB0aGUgc2hlbGwgaXMgbm90IHRoZSBwb2ludA0KPj4gdGhhdCB3b3VsZCBhY3R1YWxseSBjb25u
ZWN0LCBzbyBjaGVja2luZyBpZiBjb25uZWN0IHdvcmtzIGludm9sdmVzIHRoZSBzaGVsbA0KPj4g
YWN0dWFsbHkgc3Bhd25pbmcgb2ZmIHRoZSBjaGlsZCBwcm9jZXNzIHRoYXQgYXR0ZW1wdHMgdGhl
IGNvbm5lY3QuICBJZiB0aGUNCj4+IGNsaWVudCBpdHNlbGYgaGFzIGEgcmV0cnkgYnVpbHRpbiwg
dGhlbiB5b3UgZG9uJ3QgbmVlZCB0byBkbyBhbnl0aGluZyBpbg0KPj4gc2hlbGwgLSBqdXN0IHNw
YXduIHRoZSBjbGllbnQgd2l0aCByZXRyeSAoYXQgd2hpY2ggcG9pbnQsIHRoZSBjbGllbnQNCj4+
IHJldHJ5aW5nIG9uIHRoZSBjb25uZWN0aW9uIGlzIHNtYXJ0ZXIgdGhhbiB0aGUgY2xpZW50IHJl
dHJ5aW5nIG9uIHRoZSBwaWQNCj4+IGZpbGUpLiAgQnV0IHBpZCBmaWxlcyBhcmUgaW1tZW5zZWx5
IHVzZWZ1bCB3aGVuIHlvdSBoYXZlIGEgY2xpZW50IHRoYXQgZG9lcw0KPj4gbm90IGhhdmUgYnVp
bHRpbiByZXRyeSwgYW5kIHdoZW4gd3JpdGluZyBhIHRlc3RpbmcgZnJhbWV3b3JrIHdoZXJlIHlv
dSB1c2UNCj4+IHNoZWxsIHRvIGxlYXJuIHdoZXRoZXIgaXQgaXMgc2FmZSB0byBzcGF3biB0aGUg
Y2xpZW50OiByYXRoZXIgdGhhbiBoYXZpbmcgdG8NCj4+IG1vZGlmeSB0aGUgY2xpZW50IG9yIHdy
aXRlIGEgc2hlbGwgbG9vcCB0aGF0IHJlc3Bhd25zIGNoaWxkIGF0dGVtcHRzLCB5b3UNCj4+IG1l
cmVseSBuZWVkIGEgc2hlbGwgbG9vcCBwcm9iaW5nIGZvciB0aGUgcGlkIGZpbGUgdG8gZXhpc3Qu
DQoNCkkndmUgYWxyZWFkeSBpbXBsZW1lbnRlZCBsb29wIG9mIGF0dGVtcHRpbmcgdG8gY29ubmVj
dCBpbiBteSBzZXJpZXMgKHBhdGNoIDQvMykuDQpJdCdzIGEgYml0IG1vcmUgZGlmZmljdWx0IHRv
IGltcGxlbWVudCwgYnV0IGl0J3MgZG9uZS4gQW5kIGl0J3MgYSBiaXQgYmV0dGVyLA0KYXMgaXQg
dGVzdCBleGFjdGx5IHdoYXQgd2Ugd2FudCB0byB0ZXN0LiBDYW4gd2UgcHJvY2VlZCB3aXRoIGl0
Pw0KDQo+IA0KPiBXZSBzaG91bGRuJ3QgbmVlZCB0b2RvIGFueSBvZiB0aG9zZSB0cmlja3MgSUlV
Qy4gIFRoZSAtLWZvcmsgYXJndW1lbnQgaXMNCj4gc3VwcG9zZWQgdG8gb25seSBsZXQgdGhlIHBh
cmVudCBwcm9jZXNzIGV4aXQgb25jZSB0aGUgc2VydmVyIGlzIHJ1bm5pbmcuDQo+IA0KPiBJT1cs
IGlmIHlvdSBydW4gcWVtdS1uYmQgLS1mb3JrLCBpbiB0aGUgZm9yZWdyb3VuZCwgdGhlbiB3aGVu
IGV4ZWN1dGlvbg0KPiBjb250aW51ZXMgdGhlIHNvY2tldHMgc2hvdWxkIGJlIHByZXNlbnQgJiBh
Y2NlcHRpbmcgY29ubmVjdGlvbnMuIE5vIG5lZWQNCj4gdG8gY2hlY2sgZm9yIGV4aXN0YW5jZSBv
ZiBhbnkgZmlsZXMgb3IgY2hlY2sgY29ubmVjdGluZywgZXRjLg0KPiANCj4gDQo+IEV4Y2VwdCB0
aGF0IEFGQUlDVCwgLS1mb3JrIGlzbid0IGFjdHVhbGx5IGltcGxlbWVudGVkIHdpdGggdGhpcyBz
ZW1hbnRpY3MNCj4gaW4gcWVtdS1uYmQuIEl0IGxvb2tzIGxpa2Ugd2Ugb25seSBsaXN0ZW4gb24g
dGhlIHNvY2tldHMgYWZ0ZXIgdGhlIHBhcmVudA0KPiBoYXMgYWxyZWFkeSBleGl0ZWQgOi0oIENh
biB3ZSBmaXggdGhhdCB0byBzeW5jaHJvbml6ZSB3cnQgc29ja2V0IGxpc3RlbmVycyA/DQo+IA0K
PiBSZWdhcmRzLA0KPiBEYW5pZWwNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1p
cg0K

