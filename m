Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C923EC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8351B206C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="T43rlHbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8351B206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAzg6-0006at-KB
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 12:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAzdW-0003qY-3q
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:50:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAzdU-0001I0-Al
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:50:29 -0400
Received: from mail-eopbgr00093.outbound.protection.outlook.com
 ([40.107.0.93]:24451 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAzdT-0001Gc-GH; Thu, 19 Sep 2019 12:50:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXEbEBI7OadbYTsP3+SyihlAtviav+ilewuWnT9C1/OB3ksIXts8P1LZ8p1XeBt9/fMEVWIRLbL2fAybPfVtQkyPPlrzHzOGhSXvw15mZZIpC8Uvn/+jG8A8y4J8/O4oK7Gsanoqx3cPvaSMiPfPpWADBfXCIzBe4vgV44VkT4QDFWmJ0mAD8Dhh8QIoACRpx/9dPMFXdBnhiso6VWLesfAne0QxJ02lWO1r98ubeTJ4Sxo31qynH1fiQgEHBcAtfPKB+jyP9hwFlLBPHxVkFbl3n2k4B/okosXtVcrPlTIYZLJU4vlbKqyTQbF+b/2A6ITuApyHisNi5K5dBaJYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxGMg9MZEmrPJbsazqohGUgLqLOq1Z/58TnevtUsv6k=;
 b=YuqRyffvR8Vjs2l8fOJEBF9VxaiDPAKcUp03HNMlWEYBqHWGmWCp9Qaqmzc8h+Gd2F35Fj42fg+IZA81SMNEGFgaNeoF/T3crzrEpUrpBH016OkGHbbFqXK8gKwI5RP2odPTG40QiAqNInJ4rSRV4viT50TtVceIIL3qq/yOg8dArlQvPyqq9a3LIsCYLdJwBofvtxoiZBtWpisGSvbw58zJfV4IZc/HenEDrL3b8TDQqnKexkZk4HDX0NhAbAoYodjpXeuAacqy3UxubgFF48VB+kBcuZJm4dyYDcSn8OjnI+fKJyeQ5YtDuoc/V7LhiFUqHVo9zMMbdL9JT79PAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxGMg9MZEmrPJbsazqohGUgLqLOq1Z/58TnevtUsv6k=;
 b=T43rlHbGHgI6dFHArFkGqvjzB/n4Ezc6O4ejNiAP/j9xkhZ1sY9wVfmi5QJihEBCkzPCNEDKgWBUFUA30xPoRzg6V1cLULjKb7jpGjk/2U1da1SWiQtbQYxGBBtC+Hr4gxLWtGOo3RjKiav5RkhbXRnDigoGw4JUCkTv5Z+IlhU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5193.eurprd08.prod.outlook.com (10.255.17.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.22; Thu, 19 Sep 2019 16:50:25 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 16:50:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [Qemu-devel] [PATCH 0/4] mirror: Do not dereference invalid
 pointers
Thread-Topic: [Qemu-devel] [PATCH 0/4] mirror: Do not dereference invalid
 pointers
Thread-Index: AQHVaXSydpdz13QulUauILjn06n58qcxmzMAgAGlGoCAAAFwAA==
Date: Thu, 19 Sep 2019 16:50:24 +0000
Message-ID: <53346693-e4ef-ee75-0438-d223d22b1c27@virtuozzo.com>
References: <20190912135632.13925-1-mreitz@redhat.com>
 <0af49571-c3a1-2887-8873-bfa94bb42cb4@virtuozzo.com>
 <00893c8e-f67b-db95-cfb9-bc1059470091@redhat.com>
In-Reply-To: <00893c8e-f67b-db95-cfb9-bc1059470091@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0007.eurprd03.prod.outlook.com
 (2603:10a6:3:76::17) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190919195022306
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd0b8c11-f311-4cec-2f0e-08d73d2177b6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5193; 
x-ms-traffictypediagnostic: DB8PR08MB5193:
x-microsoft-antispam-prvs: <DB8PR08MB519314FB2A2B304A0839B645C1890@DB8PR08MB5193.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(136003)(346002)(366004)(376002)(189003)(199004)(86362001)(99286004)(6246003)(66446008)(36756003)(486006)(64756008)(54906003)(66556008)(256004)(2501003)(14444005)(66476007)(14454004)(110136005)(316002)(31686004)(478600001)(31696002)(66946007)(8936002)(66066001)(81156014)(81166006)(7736002)(4326008)(6506007)(11346002)(52116002)(446003)(2616005)(2906002)(25786009)(305945005)(102836004)(6512007)(476003)(76176011)(71190400001)(71200400001)(53546011)(8676002)(6436002)(229853002)(386003)(6486002)(3846002)(6116002)(5660300002)(26005)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5193;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hp2Uka99O5xf8vSmR7kbhHF7KjCvt82gLgc2UFb6Hpyu/VfOAk2wrxt3XtNoi/qVfnEc3zw1Lbgl0hktrDwGFJrUkSty5r4x25Pjrw0lIAnW/2R2DdY+u7A+bi/QaoZliq2+/917gJEJs4vrWDoU+vBkX1EWKfjxgeqgAP/TCx5mPkgPr1oJ7hfoYf5LVGg7geO3P9f04OIItpNXTsjD7aBKATNliFT2xgbRvUUgN0vTbIEHAi1krRhiznOUpJPtODA4fcKjKuK1ZEXYk2ByAeQvANMJsuRH2RIXPkOyxbQfwaz8P8kFghe4NSomj/T/YC8Iw/1QjW79OGWg0Y4/xac475tpYLiU2zMDDjboNzJyPdeGr07v/9m5NGBhRfop8kpKopU5RvITrtACXrDQFQRzRrn7yaDmhfpSELik6Uw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C64A076FB55848488CCDA1CE7727AFFE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0b8c11-f311-4cec-2f0e-08d73d2177b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 16:50:24.9849 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0UnAsTw/f7bLZOpb9RwvNWUtaoj7ynC+91RxkGJXAfSYZh+IZf0qPtKFFwQjRoIMvBMnLLhcTok3Mea+N+ClMxIZgzM+jXg9Ck49rxOjZho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5193
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.93
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMDkuMjAxOSAxOTo0NSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxOC4wOS4xOSAxNzozOCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDEyLjA5LjIwMTkgMTY6NTYs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBIaSwNCj4+Pg0KPj4+IFRoZSBmaXggKHBhdGNoIDEpIGlz
IHByZXR0eSBzdHJhaWdodGZvcndhcmQ7IHBhdGNoIDIgKHdoaWNoIEkgbmVlZCBmb3INCj4+PiB0
aGUgdGVzdCkgbWF5IG5vdCBiZS4NCj4+Pg0KPj4+IFRoZSBiaWdnZXN0IHByb2JsZW0gd2l0aCBw
YXRjaCAyIGlzIHRoYXQgeW91IGNhbiB1c2UgaXQgdG8gdW5jb3ZlciB3aGVyZQ0KPj4+IG91ciBw
ZXJtaXNzaW9uIGhhbmRsaW5nIGlzIGJyb2tlbi4gIEZvciBleGFtcGxlLCBkZXZpc2luZyB0aGUg
dGVzdCBjYXNlDQo+Pj4gKHBhdGNoIDQpIHdhcyB2ZXJ5IGRpZmZpY3VsdCBiZWNhdXNlIEkga2Vw
dCBydW5uaW5nIGludG8gdGhlDQo+Pj4gJmVycm9yX2Fib3J0IHRoYXQgbWlycm9yX2V4aXRfY29t
bW9uKCkgcGFzc2VzIHdoZW4gZHJvcHBpbmcgdGhlDQo+Pj4gbWlycm9yX3RvcF9icy4NCj4+Pg0K
Pj4+IFRoZSBwcm9ibGVtIGlzIHRoYXQgbWlycm9yX3RvcF9icyBkb2VzIG5vdCB0YWtlIHRoZSBz
YW1lIHBlcm1pc3Npb25zDQo+Pj4gdGhhdCBpdHMgcGFyZW50IHRha2VzLiAgRXJnbyB1c2luZyAm
ZXJyb3JfYWJvcnQgd2hlbiBkcm9wcGluZyBpdCBpcw0KPj4+IHdyb25nOiBUaGUgcGFyZW50IG1h
eSByZXF1aXJlIG1vcmUgcGVybWlzc2lvbnMgdGhhdCBtaXJyb3JfdG9wX2JzIGRpZCwNCj4+PiBh
bmQgc28gZHJvcHBpbmcgbWlycm9yX3RvcF9icyBtYXkgZmFpbC4NCj4+Pg0KPj4+IE5vdyB3aGF0
4oCZcyByZWFsbHkgYmFkIGlzIHRoYXQgdGhpcyBjYW5ub3QgYmUgZml4ZWQgd2l0aCBvdXIgY3Vy
cmVudA0KPj4+IHBlcm1pc3Npb24gc3lzdGVtLiAgbWlycm9yX3RvcF9icyB3YXMgaW50cm9kdWNl
ZCBwcmVjaXNlbHkgc28gaXQgZG9lcw0KPj4+IG5vdCB0YWtlIENPTlNJU1RFTlRfUkVBRCwgYnV0
IGNhbiBzdGlsbCBhbGxvdyBwYXJlbnRzIHRvIHRha2UgaXQgKGZvcg0KPj4+IGFjdGl2ZSBjb21t
aXRzKS4gIEJ1dCB3aGF0IGlmIHRoZXJlIGlzIGFjdHVhbGx5IHNvbWV0aGluZyBiZXNpZGVzIHRo
ZQ0KPj4+IG1pcnJvciBqb2IgdGhhdCB1bnNoYXJlcyBDT05TSVNURU5UX1JFQUQ/DQo+Pj4NCj4+
Pg0KPj4+IEltYWdpbmUgdGhpczoNCj4+Pg0KPj4+ICAgICAgICAgbWlycm9yIHRhcmdldCBCQiAg
ICAgICBtaXJyb3Igc291cmNlIEJCDQo+Pj4gICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAg
ICAgIHwNCj4+PiAgICAgICAgICAgICAgICAgICAgIHYgICAgICAgICAgICAgdg0KPj4+IG1pcnJv
cl90b3BfYnMgLT4gdG9wIC0+IG1pZCAtPiBiYXNlDQo+Pj4gICAgICAgICAgICAgICAgICAgICBe
DQo+Pj4gICAgICAgICAgICAgICAgICAgICB8DQo+Pj4gICAgICAgICAgICAgICAgb3RoZXJfcGFy
ZW50DQo+Pj4NCj4+PiBUaGUgc291cmNlIEJCIHVuc2hhcmVzIENPTlNJU1RFTlRfUkVBRCBvbiB0
aGUgYmFzZS4gIG1pcnJvcl90b3BfYnMNCj4+PiBlbnN1cmVzIHRoYXQgaXRzIHBhcmVudHMgY2Fu
IHJlYWQgZnJvbSB0b3AgZXZlbiB0aG91Z2ggdG9wIGl0c2VsZiBjYW5ub3QNCj4+PiBhbGxvdyBD
T05TSVNURU5UX1JFQUQgdG8gYmUgdGFrZW4uICBTbyBmYXIgc28gZ29vZC4NCj4+Pg0KPj4+IEJ1
dCB3aGF0IGlmIG90aGVyX3BhcmVudCBhbHNvIHVuc2hhcmVzIENPTlNJU1RFTlRfUkVBRD8gIFRo
ZW4sDQo+Pj4gbWlycm9yX3RvcF9icyBoYXMgbm8gYnVzaW5lc3MgYWxsb3dpbmcgaXRzIHBhcmVu
dHMgdG8gdGFrZSBpdC4NCj4+Pg0KPj4+IE5vIGlkZWEgaG93IHRvIGZpeCB0aGF0LiAgKEkgc3Vw
cG9zZSBtaXJyb3JfdG9wX2JzIHdvdWxkIG5lZWQgc29tZSB3YXkNCj4+PiB0byB2ZXJpZnkgdGhh
dCB0aGVyZSBpcyBubyBvdGhlciBwYXJ0eSB0aGF0IGhhcyB1bnNoYXJlZCBDT05TSVNURU5UX1JF
QUQNCj4+PiBidXQgaXRzIGFzc29jaWF0ZWQgc291cmNlIEJCLg0KPj4NCj4+IE1heSBiZSB3ZSBu
ZWVkIGdyb3VwZWQgcGVybWlzc2lvbnM/DQo+Pg0KPj4gU29tZSB3YXkgdG8gZGVmaW5lIGdyb3Vw
IG9mIGNoaWxkcmVuLCB3aGljaCBtYXkgdW5zaGFyZSByZWFkIHBlcm1pc3Npb24NCj4+IGZvciBv
dGhlciBjaGlsZHJlbiAob3V0IG9mIHRoZSBncm91cCksIGJ1dCBzdGlsbCBjaGlsZHJlbiBpbiBn
cm91cCBtYXkNCj4+IGhhdmUgcmVhZCBwZXJtaXNzaW9uPw0KPiANCj4gSG0sIGlzIHRoYXQgZGlm
ZmVyZW50IGZyb20gbXkgaWRlYSBiZWxvdyB3aGVyZSBvbmUgb2YgbWlycm9yX3RvcCdzDQo+IGNo
aWxkcmVuIHVuc2hhcmVzIHRoZSByZWFkIHBlcm1pc3Npb24sIGFuZCBhbm90aGVyIGlzIGFsbG93
ZWQgdG8gdGFrZSBpdA0KPiBzdGlsbD8NCg0KSSBqdXN0IHRyaWVkIHRvIGltYWdpbmUgc29tZXRo
aW5nIGdlbmVyaWMNCg0KPiANCj4gKFRoZSBwcm9ibGVtIGlzIGFsd2F5cyB0aGF0IGlmIHNvbWUg
QkRTIGhhcyBhIHBhcmVudCB0aGF0IHVuc2hhcmVzIHRoaXMNCj4gcGVybWlzc2lvbiwgdGhpcyBj
b25kaXRpb24gcHJvcGFnYXRlcyB1cHdhcmRzIHRocm91Z2ggaXRzIG90aGVyIHBhcmVudHMsDQo+
IGFuZCB3ZSBuZWVkIHRvIGtlZXAgdHJhY2sgb2Ygd2hvIHVuc2hhcmVkIGl0IGluIHRoZSBmaXJz
dCBwbGFjZS4pDQo+IA0KPj4gQnV0IGl0IGRvbid0IHdvcmsgaGVyZSBhcyB3ZSBhcmUgc2F5aW5n
IGFib3V0IGNoaWxkcmVuIG9uIGRpZmZlcmVudA0KPj4gbm9kZXMuLiBBbmQgcHJvcGFnYXRlZCB0
aHJvdWdoIGJhY2tpbmcgY2hhaW4gcGVybWlzc2lvbnMuLg0KPiANCj4gWWVwLg0KPiANCj4+PiAg
IEluIHRoZSBmdXR1cmUsIHdlIHdhbnQgdGhlIHNvdXJjZSBCQiB0bw0KPj4+IGdvIGF3YXkgYW5k
IGluc3RlYWQgaGF2ZSB0aGUgc291cmNlIGJlIGFuIGltbWVkaWF0ZSBCZHJ2Q2hpbGQgb2YNCj4+
PiBtaXJyb3JfdG9wX2JzLiAgTWF5YmUgd2UgY2FuIHRoZW4gYnVpbGQgc29tZXRoaW5nIGludG8g
dGhlIGJsb2NrIGxheWVyDQo+Pj4gc28gdGhhdCBhIG5vZGUgY2FuIG9ubHkgcmVzdG9yZSBDT05T
SVNURU5UX1JFQUQgd2hlbiBpdCB3YXMgdGhhdCBub2RlDQo+Pj4gdGhhdCBicm9rZSBpdD8pDQo+
Pj4NCj4+Pg0KPj4+IEFueXdheS4gIFlvdSBjYW4gc2VlIHNvbWV0aGluZyBhcmlzaW5nIGZyb20g
dGhpcyBwcm9ibGVtIHNpbXBseSBieQ0KPj4+IHVuc2hhcmluZyBDT05TSVNURU5UX1JFQUQgb24g
dGhlIHRhcmdldCBub2RlLiAgKEp1c3QgZHJvcCB0aGUgc3JjLXBlcm0NCj4+PiBub2RlIGZyb20g
dGhlIHRlc3QgSSBhZGQgaW4gcGF0Y2ggNC4pICBSZXBsYWNpbmcgdGhlIHNvdXJjZSB3aXRoIHRo
ZQ0KPj4+IHRhcmdldCB3aWxsIHRoZW4gd29yayBmaW5lIChiZWNhdXNlIG1pcnJvcl90b3BfYnMg
ZG9lc27igJl0IGNhcmUgYWJvdXQNCj4+PiBDT05TSVNURU5UX1JFQUQgYmVpbmcgcmVtb3ZlZCks
IGJ1dCB0aGVuIHlvdSBjYW5ub3QgZHJvcCBtaXJyb3JfdG9wX2JzIOKAkw0KPj4+IGJlY2F1c2Ug
aXRzIHBhcmVudCBkb2VzIHdhbnQgQ09OU0lTVEVOVF9SRUFELiAgVGh1cywgdGhlICZlcnJvcl9h
Ym9ydA0KPj4+IGFib3J0cy4NCj4+Pg0KPj4+DQo+Pj4gV2hpbGUgdGhpcyBpcyBhIG1vcmUgc3Bl
Y2lhbCBjYXNlLCBJIGhhdmUgbm8gaWRlYSBob3cgdG8gZml4IHRoaXMgb25lDQo+Pj4gZWl0aGVy
Lg0KPj4+DQo+Pj4NCj4+PiBTb28uLi4gIFRoaXMgc2VyaWVzIGp1c3QgZml4ZXMgb25lIHRoaW5n
LCBhbmQgbGVhdmVzIGFub3RoZXIgdW5maXhlZA0KPj4+IGJlY2F1c2UgSSBoYXZlIG5vIGlkZWEg
aG93IHRvIGZpeCBpdC4gIFdvcnNlLCBpdCBhZGRzIHBhcmFtZXRlcnMgdG8NCj4+PiBibGtkZWJ1
ZyB0byBhY3R1YWxseSBzZWUgdGhlIHByb2JsZW0uICBEbyB3ZSB3YW50IHRvIGxldCBibGtkZWJ1
ZyBiZQ0KPj4+IGFibGUgdG8gY3Jhc2ggcWVtdSAoYmVjYXVzZSBvZiBhIGJ1ZyBpbiBxZW11KT8N
Cj4+Pg0KPj4NCj4+IGJsa2RlYnVnIGlzIGZvciBkZWJ1Z2dpbmcgYW5kIG5vdCB1c2VkIGJ5IGVu
ZCB1c2VycyBsaWtlIGxpYnZpcnQsIHllcz8NCj4gDQo+IENvcnJlY3QuDQo+IA0KPiANCj4+Pg0K
Pj4+IE1heCBSZWl0eiAoNCk6DQo+Pj4gICAgIG1pcnJvcjogRG8gbm90IGRlcmVmZXJlbmNlIGlu
dmFsaWQgcG9pbnRlcnMNCj4+PiAgICAgYmxrZGVidWc6IEFsbG93IHRha2luZy91bnNoYXJpbmcg
cGVybWlzc2lvbnMNCj4+PiAgICAgaW90ZXN0czogQWRkIEBlcnJvciB0byB3YWl0X3VudGlsX2Nv
bXBsZXRlZA0KPj4+ICAgICBpb3Rlc3RzOiBBZGQgdGVzdCBmb3IgZmFpbGluZyBtaXJyb3IgY29t
cGxldGUNCj4+Pg0KPj4+ICAgIHFhcGkvYmxvY2stY29yZS5qc29uICAgICAgICAgIHwgIDI5ICsr
KysrKysrKy0NCj4+PiAgICBibG9jay9ibGtkZWJ1Zy5jICAgICAgICAgICAgICB8IDEwNiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+Pj4gICAgYmxvY2svbWlycm9yLmMgICAg
ICAgICAgICAgICAgfCAgMTMgKysrLS0NCj4+PiAgICB0ZXN0cy9xZW11LWlvdGVzdHMvMDQxICAg
ICAgICB8ICA0NCArKysrKysrKysrKysrKw0KPj4+ICAgIHRlc3RzL3FlbXUtaW90ZXN0cy8wNDEu
b3V0ICAgIHwgICA0ICstDQo+Pj4gICAgdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkgfCAg
MTggKysrKy0tDQo+Pj4gICAgNiBmaWxlcyBjaGFuZ2VkLCAyMDAgaW5zZXJ0aW9ucygrKSwgMTQg
ZGVsZXRpb25zKC0pDQo+Pj4NCj4+DQo+Pg0KPiANCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K

