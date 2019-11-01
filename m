Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50342CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 13:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049CD217D9
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 13:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bEgthH3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049CD217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQWh3-0007UV-QB
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 09:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iQWg1-0006YH-9T
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 09:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iQWfz-0003MT-G9
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 09:09:16 -0400
Received: from mail-eopbgr20112.outbound.protection.outlook.com
 ([40.107.2.112]:23177 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iQWfy-0003Lc-O7; Fri, 01 Nov 2019 09:09:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8RqUkIXGmg6+QShVhgBvtwm0LTz61goYat6hUTCosMWowp0XpGDti7GSWE5Y0nOKaCS0BmvtFAeIW8qHdqFklF2mmA/6EJ0CvkcVvAeX6YCYbg3Hp52yUA+Vm0+IhY1Z9u6blCxiIo+0oUUg09XoCSW3wDE4Nff5AqwsQUnQw998DiSXmQ44mglAzAL5FH+dVz+/JRkr32EP9NblJ29tcW5qedH9qZf7PRhzQQnkf6JLxkOsRB0BBEnBKy0yZ006WM+gcdQtU5j+T59XXemG/M+q80WIWvYiu/cvrB5w+wQZDlpZpUbL7Cq2IhRr4lqYyG9ufabmBTM/TZJFjfWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0Ud0XMu4PSSK4XZri4CJ8nW8aL2iedV638gFlj6UgA=;
 b=ef3jXiiKK3QZEioflMab6kHdikm7BMvWRZv0hAY+OujRZpO74jp0e2sbu9ByMh+e+JSoVW/m9CW9o1cEvebstLcr2VqhvWvUL1SJaBIbGK8Xq7BchA4EPefSTlSla6Ma9/ezDOAvAiE/8SbHgK8//uRKEqP6FH9h0c9VPrXNgIemAg9/qxkg8Ac9BhaEPOXRswD71apug6ejhxt+XQJdSEeTg6x77VX2nXL8YdBZtFu45tKrNHe0/cFPA+gII9tDNLMbFP5z1NkDvwgLUpkgROytANKt5mXf+voKT1JWbLZNSGBLou0ynJK/9e5cM0aF4tY0PNDK7witkfU3qOEL7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0Ud0XMu4PSSK4XZri4CJ8nW8aL2iedV638gFlj6UgA=;
 b=bEgthH3A2qDf+VW+PIjJs74/0tqPveUH+6AmIBqoTsXNDMwyf7h39avtVbgYs/uFu3pNx2bBtmg6MM1m4voq423tOY9JLWSB/BvrBI0UPXpay36o66EWTw3knNgR4t6A8YVonZhTQ2Fj0Kirer/gcT23P0WIFC69sB9J/ZnmHnE=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB3764.eurprd08.prod.outlook.com (20.178.22.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Fri, 1 Nov 2019 13:09:10 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119%6]) with mapi id 15.20.2408.019; Fri, 1 Nov 2019
 13:09:10 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-4.2 0/4] qcow2: Fix data corruption on XFS
Thread-Topic: [PATCH for-4.2 0/4] qcow2: Fix data corruption on XFS
Thread-Index: AQHVkJs1nNWugfYf7EOzXc04zyxgzKd2Gq6AgAA0uAD//9oFAIAAM1yA///Ou4CAABSTgIAACcsA
Date: Fri, 1 Nov 2019 13:09:10 +0000
Message-ID: <e80f5808-a450-3019-1b1f-b718c9bae6f5@virtuozzo.com>
References: <20191101100019.9512-1-mreitz@redhat.com>
 <fbf32283-2ec5-28ae-f4c9-5bd7d4af7b3f@redhat.com>
 <783a805a-3a3a-e8c5-41ac-f6476378975e@virtuozzo.com>
 <908ffc42-8328-969d-641b-4596ec0b6b45@redhat.com>
 <fb5ae941-622f-c82d-9eb8-be3fe66e3fb6@virtuozzo.com>
 <909d8474-0e8f-b9b9-5647-b604f956900a@redhat.com>
 <c252753e-c67a-be46-1136-d0d7d9e642e7@redhat.com>
In-Reply-To: <c252753e-c67a-be46-1136-d0d7d9e642e7@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::26) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191101160908001
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34dc2c9c-41d4-4678-b3a7-08d75eccaf2a
x-ms-traffictypediagnostic: AM0PR08MB3764:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB37646724166274406EDB8170C1620@AM0PR08MB3764.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(346002)(376002)(396003)(136003)(366004)(52314003)(189003)(199004)(446003)(2906002)(2616005)(6246003)(6436002)(4326008)(107886003)(6512007)(6306002)(81156014)(81166006)(8676002)(54906003)(8936002)(110136005)(7736002)(2501003)(31686004)(478600001)(6486002)(305945005)(66066001)(229853002)(25786009)(14454004)(76176011)(66946007)(66476007)(256004)(66556008)(53546011)(386003)(6506007)(99286004)(6116002)(3846002)(14444005)(31696002)(316002)(66446008)(64756008)(52116002)(86362001)(102836004)(26005)(186003)(476003)(5660300002)(36756003)(486006)(71200400001)(11346002)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3764;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5B1APE+mG6flJuH933ZLC5fqicBcblKVEFmaxCjinqx2Sag80Cv9tW1daGof/TGK7VodP7qIO5EkGw/ErXYY/SWoEQGbeESUaDEhu9ZaQ06J+0ufSVjkv/qxOK3pm99FzjYZjPYZwK5XgWnwOVVPB1OUDddLxQQX1MIZT7bMkmt8fOQ3ytTAaPqU2Sm82jLTzrhtwwH4zAfjVYsxAO6Jkx/OMSibMg6u7w5OfaXq79GfUpVKRNO4sveP61di0TyIRq6iYNQbRAPr4m9yk+ol0rtjwcKORQHSp1dEuEYKT/IkmF1wm1Gmc40tNTLv5yA3XXM2i1ElgYm8WMp+Buq8gulekECf3XpTufJeI4yF9rj1CTWN3zn0wHv0zEfK5YDZCWiQ91osHYevvUiihMc1TAFrCcfGvnOVRsDbowYOg9VZDfoZcCo+1B/Cs+fZO3hnzOEHIOkdjH/K/bk9ISM3VVmLY4oVWFYp4BQaesn+HFg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80EFEFF6526FCA4FBFA223592973AD81@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dc2c9c-41d4-4678-b3a7-08d75eccaf2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 13:09:10.3763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QM9bcbmHzbGJdWGiM+ZCb6MMEwCY/ref0OwjGIH8IXeArShIYt79H/BvlPeL2AjSe3fWdIb3vyM9qCvi6XpjHLSd/8PuD4QQOCRz8lQgT8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3764
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.112
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTEuMjAxOSAxNTozNCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwMS4xMS4xOSAxMjoyMCwg
TWF4IFJlaXR6IHdyb3RlOg0KPj4gT24gMDEuMTEuMTkgMTI6MTYsIFZsYWRpbWlyIFNlbWVudHNv
di1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gMDEuMTEuMjAxOSAxNDoxMiwgTWF4IFJlaXR6IHdyb3Rl
Og0KPj4+PiBPbiAwMS4xMS4xOSAxMToyOCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3
cm90ZToNCj4+Pj4+IDAxLjExLjIwMTkgMTM6MjAsIE1heCBSZWl0eiB3cm90ZToNCj4+Pj4+PiBP
biAwMS4xMS4xOSAxMTowMCwgTWF4IFJlaXR6IHdyb3RlOg0KPj4+Pj4+PiBIaSwNCj4+Pj4+Pj4N
Cj4+Pj4+Pj4gVGhpcyBzZXJpZXMgYnVpbGRzIG9uIHRoZSBwcmV2aW91cyBSRkMuICBUaGUgd29y
a2Fyb3VuZCBpcyBub3cgYXBwbGllZA0KPj4+Pj4+PiB1bmNvbmRpdGlvbmFsbHkgb2YgQUlPIG1v
ZGUgYW5kIGZpbGVzeXN0ZW0gYmVjYXVzZSB3ZSBkb27igJl0IGtub3cgdGhvc2UNCj4+Pj4+Pj4g
dGhpbmdzIGZvciByZW1vdGUgZmlsZXN5c3RlbXMuICBGdXJ0aGVybW9yZSwgYmRydl9jb19nZXRf
c2VsZl9yZXF1ZXN0KCkNCj4+Pj4+Pj4gaGFzIGJlZW4gbW92ZWQgdG8gYmxvY2svaW8uYy4NCj4+
Pj4+Pj4NCj4+Pj4+Pj4gQXBwbHlpbmcgdGhlIHdvcmthcm91bmQgdW5jb25kaXRpb25hbGx5IGlz
IGZpbmUgZnJvbSBhIHBlcmZvcm1hbmNlDQo+Pj4+Pj4+IHN0YW5kcG9pbnQsIGJlY2F1c2UgaXQg
c2hvdWxkIGFjdHVhbGx5IGJlIGRlYWQgY29kZSwgdGhhbmtzIHRvIHBhdGNoIDENCj4+Pj4+Pj4g
KHRoZSBlbGVwaGFudCBpbiB0aGUgcm9vbSkuICBBcyBmYXIgYXMgSSBrbm93LCB0aGVyZSBpcyBu
byBvdGhlciBibG9jaw0KPj4+Pj4+PiBkcml2ZXIgYnV0IHFjb3cyIGluIGhhbmRsZV9hbGxvY19z
cGFjZSgpIHRoYXQgd291bGQgc3VibWl0IHplcm8gd3JpdGVzDQo+Pj4+Pj4+IGFzIHBhcnQgb2Yg
bm9ybWFsIEkvTyBzbyBpdCBjYW4gb2NjdXIgY29uY3VycmVudGx5IHRvIG90aGVyIHdyaXRlDQo+
Pj4+Pj4+IHJlcXVlc3RzLiAgSXQgc3RpbGwgbWFrZXMgc2Vuc2UgdG8gdGFrZSB0aGUgd29ya2Fy
b3VuZCBmb3IgZmlsZS1wb3NpeA0KPj4+Pj4+PiBiZWNhdXNlIHdlIGNhbuKAmXQgcmVhbGx5IHBy
ZXZlbnQgdGhhdCBhbnkgb3RoZXIgYmxvY2sgZHJpdmVyIHdpbGwgc3VibWl0DQo+Pj4+Pj4+IHpl
cm8gd3JpdGVzIGFzIHBhcnQgb2Ygbm9ybWFsIEkvTyBpbiB0aGUgZnV0dXJlLg0KPj4+Pj4+Pg0K
Pj4+Pj4+PiBBbnl3YXksIGxldOKAmXMgZ2V0IHRvIHRoZSBlbGVwaGFudC4NCj4+Pj4+Pj4NCj4+
Pj4+Pj4gICAgRnJvbSBpbnB1dCBieSBYRlMgZGV2ZWxvcGVycw0KPj4+Pj4+PiAoaHR0cHM6Ly9i
dWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0xNzY1NTQ3I2M3KSBpdCBzZWVtcyBj
bGVhcg0KPj4+Pj4+PiB0aGF0IGM4YmIyM2NiZGJlIGNhdXNlcyBmdW5kYW1lbnRhbCBwZXJmb3Jt
YW5jZSBwcm9ibGVtcyBvbiBYRlMgd2l0aA0KPj4+Pj4+PiBhaW89bmF0aXZlIHRoYXQgY2Fubm90
IGJlIGZpeGVkLiAgSW4gb3RoZXIgY2FzZXMsIGM4YmIyM2NiZGJlIGltcHJvdmVzDQo+Pj4+Pj4+
IHBlcmZvcm1hbmNlIG9yIHdlIHdvdWxkbuKAmXQgaGF2ZSBpdC4NCj4+Pj4+Pj4NCj4+Pj4+Pj4g
SW4gZ2VuZXJhbCwgYXZvaWRpbmcgcGVyZm9ybWFuY2UgcmVncmVzc2lvbnMgaXMgbW9yZSBpbXBv
cnRhbnQgdGhhbg0KPj4+Pj4+PiBpbXByb3ZpbmcgcGVyZm9ybWFuY2UsIHVubGVzcyB0aGUgcmVn
cmVzc2lvbnMgYXJlIGp1c3QgYSBtaW5vciBjb3JuZXINCj4+Pj4+Pj4gY2FzZSBvciBpbnNpZ25p
ZmljYW50IHdoZW4gY29tcGFyZWQgdG8gdGhlIGltcHJvdmVtZW50LiAgVGhlIFhGUw0KPj4+Pj4+
PiByZWdyZXNzaW9uIGlzIG5vIG1pbm9yIGNvcm5lciBjYXNlLCBhbmQgaXQgaXNu4oCZdCBpbnNp
Z25pZmljYW50LiAgTGF1cmVudA0KPj4+Pj4+PiBWaXZpZXIgaGFzIGZvdW5kIHBlcmZvcm1hbmNl
IHRvIGRlY3JlYXNlIGJ5IGFzIG11Y2ggYXMgODggJSAob24gcHBjNjRsZSwNCj4+Pj4+Pj4gZmlv
IGluIGEgZ3Vlc3Qgd2l0aCA0ayBibG9ja3MsIGlvZGVwdGg9ODogMTY2MiBrQi9zIGZyb20gMTMu
OSBNQi9zKS4NCj4+Pj4+Pg0KPj4+Pj4+IEFoLCBjcmFwLg0KPj4+Pj4+DQo+Pj4+Pj4gSSB3YW50
ZWQgdG8gc2VuZCB0aGlzIHNlcmllcyBhcyBlYXJseSB0b2RheSBhcyBwb3NzaWJsZSB0byBnZXQg
YXMgbXVjaA0KPj4+Pj4+IGZlZWRiYWNrIGFzIHBvc3NpYmxlLCBzbyBJ4oCZdmUgb25seSBzdGFy
dGVkIGRvaW5nIGJlbmNobWFya3Mgbm93Lg0KPj4+Pj4+DQo+Pj4+Pj4gVGhlIG9idmlvdXMNCj4+
Pj4+Pg0KPj4+Pj4+ICQgcWVtdS1pbWcgYmVuY2ggLXQgbm9uZSAtbiAtdyAtUyA2NTUzNiB0ZXN0
LnFjb3cyDQo+Pj4+Pj4NCj4+Pj4+PiBvbiBYRlMgdGFrZXMgbGlrZSA2IHNlY29uZHMgb24gbWFz
dGVyLCBhbmQgbGlrZSA1MCB0byA4MCBzZWNvbmRzIHdpdGgNCj4+Pj4+PiBjOGJiMjNjYmRiZSBy
ZXZlcnRlZC4gIFNvIG5vdyBvbiB0byBndWVzdCB0ZXN0cy4uLg0KPj4+Pj4NCj4+Pj4+IEFoYSwg
dGhhdCdzIHZlcnkgaW50ZXJlc3RpbmcpIFdoYXQgYWJvdXQgYWlvLW5hdGl2ZSB3aGljaCBzaG91
bGQgYmUgc2xvd2VkIGRvd24/DQo+Pj4+PiBDb3VsZCBpdCBiZSB0ZXN0ZWQgbGlrZSB0aGlzPw0K
Pj4+Pg0KPj4+PiBUaGF0IGlzIGFpbz1uYXRpdmUgKC1uKS4NCj4+Pj4NCj4+Pj4gQnV0IHNvIGZh
ciBJIGRvbuKAmXQgc2VlIGFueSBzaWduaWZpY2FudCBkaWZmZXJlbmNlIGluIGd1ZXN0IHRlc3Rz
IChpLmUuLA0KPj4+PiBmaW8gLS1ydz13cml0ZSAtLWJzPTRrIC0taW9kZXB0aD04IC0tcnVudGlt
ZT0xbSAtLWRpcmVjdD0xDQo+Pj4+IC0taW9lbmdpbmU9bGliYWlvIC0tdGhyZWFkIC0tbnVtam9i
cz0xNiAtLXNpemU9MkcgLS10aW1lX2Jhc2VkKSwgbmVpdGhlcg0KPj4+PiB3aXRoIDY0IGtCIG5v
ciB3aXRoIDIgTUIgY2x1c3RlcnMuICAoQnV0IG9ubHkgb24gWEZTLCBJ4oCZbGwgaGF2ZSB0byBz
ZWUNCj4+Pj4gYWJvdXQgZXh0NCBzdGlsbC4pDQo+Pj4NCj4+PiBobW0sIHRoaXMgcG9zc2libHkg
bW9zdGx5IHRlc3RzIHdyaXRlcyB0byBhbHJlYWR5IGFsbG9jYXRlZCBjbHVzdGVycy4gSGFzIGZp
bw0KPj4+IGFuIG9wdGlvbiB0byBiZWhhdmUgbGlrZSBxZW11LWltZyBiZW5jaCB3aXRoIC1TIDY1
NTM2LCBpLmUuIHdyaXRlIG9uY2UgaW50bw0KPj4+IGVhY2ggY2x1c3Rlcj8NCj4+DQo+PiBNYXli
ZSwgYnV0IGlzIHRoYXQgYSByZWFsaXN0aWMgZGVwaWN0aW9uIG9mIHdoZXRoZXIgdGhpcyBjaGFu
Z2UgaXMgd29ydGgNCj4+IGl0PyAgVGhhdCBpcyB3aHkgSeKAmW0gZG9pbmcgdGhlIGd1ZXN0IHRl
c3QsIHRvIHNlZSB3aGV0aGVyIGl0IGFjdHVhbGx5DQo+PiBoYXMgbXVjaCBpbXBhY3Qgb24gdGhl
IGd1ZXN0Lg0KPiANCj4gSeKAmXZlIGNoYW5nZWQgdGhlIGFib3ZlIGZpbyBpbnZvY2F0aW9uIHRv
IHVzZSAtLXJ3PXJhbmR3cml0ZSBhbmQgYWRkZWQNCj4gLS1mYWxsb2NhdGU9bm9uZS4gIFRoZSBw
ZXJmb3JtYW5jZSB3ZW50IGRvd24sIGJ1dCBpdCB3ZW50IGRvd24gYm90aCB3aXRoDQo+IGFuZCB3
aXRob3V0IGM4YmIyM2NiZGJlLg0KPiANCj4gU28gb24gbXkgWEZTIHN5c3RlbSAoWEZTIG9uIGx1
a3Mgb24gU1NEKSwgSSBzZWU6DQo+IC0gd2l0aCBjOGJiMjNjYmRiZTogMjYuMCAtIDI3LjkgTUIv
cw0KPiAtIHdpdGhvdXQgYzhiYjIzY2JkYmU6IDI1LjYgLSAyNyBNQi9zDQo+IA0KPiBPbiBteSBl
eHQ0IHN5c3RlbSAobmF0aXZlIG9uIFNTRCksIEkgc2VlOg0KPiAtIHdpdGg6IDM5LjQgLSA0MS41
IE1CL3MNCj4gLSB3aXRob3V0OiAzOS40IC0gNDIuMCBNQi9zDQo+IA0KPiBTbyBiYXNpY2FsbHkg
bm8gZGlmZmVyZW5jZSBmb3IgWEZTLCBhbmQgcmVhbGx5IG5vIGRpZmZlcmVuY2UgZm9yIGV4dDQu
DQo+IChJIHJhbiB0aGVzZSB0ZXN0cyB3aXRoIDIgTUIgY2x1c3RlcnMuKQ0KPiANCg0KSG1tLiBJ
IGRvbid0IGtub3cuIEZvciBtZSBpdCBzZWVtcyBvYnZpb3VzIHRoYXQgemVyb2luZyAyTSBjbHVz
dGVyIGlzIHNsb3csIGFuZCB0aGlzDQppcyBwcm92ZWQgYnkgc2ltcGxlIHRlc3RzIHdpdGggcWVt
dS1pbWcgYmVuY2gsIHRoYXQgZmFsbG9jYXRlIGlzIGZhc3RlciB0aGFuIHplcm9pbmcNCm1vc3Qg
b2YgdGhlIGNsdXN0ZXIuDQoNClNvLCBpZiBzb21lIGd1ZXN0IHRlc3QgZG9lc24ndCBzaG93IHRo
ZSBkaWZmZXJlbmNlLCB0aGlzIG1lYW5zIHRoYXQgInNtYWxsIHdyaXRlIGludG8NCm5ldyBjbHVz
dGVyIiBpcyBlZmZlY3RpdmVseSByYXJlIGNhc2UgaW4gdGhpcyB0ZXN0Li4gQW5kIHRoaXMgZG9l
c24ndCBwcm92ZSB0aGF0IGl0J3MNCmFsd2F5cyByYXJlIGFuZCBpbnNpZ25pZmljYW50Lg0KDQpJ
IGRvbid0IHN1cmUgdGhhdCB3ZSBoYXZlIGEgcmVhbC13b3JsZCBleGFtcGxlIHRoYXQgcHJvdmVz
IG5lY2Vzc2l0eSBvZiB0aGlzIG9wdGltaXphdGlvbiwNCm9yIHdhcyB0aGVyZSBzb21lIG9yaWdp
bmFsIGJ1ZyBhYm91dCBsb3ctcGVyZm9ybWFuY2Ugd2hpY2ggd2FzIGZpeGVkIGJ5IHRoaXMgb3B0
aW1pemF0aW9uLi4NCkRlbiwgQW50b24sIGRvIHdlIGhhdmUgc29tZXRoaW5nIGFib3V0IGl0Pw0K
DQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

