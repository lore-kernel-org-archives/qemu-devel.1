Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3F4C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:48:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6669320679
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="R/RY2XFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6669320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxCYt-0002E8-5j
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 11:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47700)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxCXy-0001iG-Na
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxCXx-0003O4-0S
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:47:46 -0400
Received: from mail-eopbgr30103.outbound.protection.outlook.com
 ([40.107.3.103]:7521 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxCXw-0003NP-Aj; Mon, 12 Aug 2019 11:47:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9T0sIt5QsUMz5dvacB2MT4gyB3XJq2azA8QLnnQMYhWjtFD7P0nDHy3aSO0egj8vIzw8NUli1ZS/nrrhQPja0L6vZThH1xEA5UZnwhj4vdPwM0BZ7fmaKgpeQ6XJt7KCbvEkH2OvWV2dqNBCtbDyCJVFV0C0VotjmEabAEEZKLA0tFW5D+XmWMVIMz5Gio4i/LObRMcTa53528PFYoYWWZ2HcPA8YLZA7ZNBTJoT+QQ7WgponKN1mqe8v5DYppiaXhNrnB6vsYERWjpFR/AAi21pbOcR2kQ6hsZyAeh+aJgWkpGdelD7Ki3cbIb9QEbxdTlGiZz0Vh4rMjREr8OTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2VMfMgTo9/6hWaxzwF2q7miaynK3si6D1t9+HA2/Js=;
 b=eBNSRo52TzNexTbqDNCG7ZYWFuft9MwdWHQnwxfqWTYlgx7E0z86JBH0fmujVwdp825sU6LZfFPdBsVjippssa8EtI/3tNbdd5OeI1ZV91WtUM3PyCPQC086H6sCpIEKhBN2xr+TRFSG0KkZvgf558bcFYJmr4/w/TZz/5sR0PxinHqvOF6W2KhDrDptfW1HAkw+Of3C3NjgJlJV8ww/Msyhtz4KtVbLnbbejQUOMO1cP9O4s7/bky3EAdqnmhfqe9Q19W5oiQ4iBT6M1o3OuWb02zwHYImoBLk/TbcWdOfAk1dbBeIItLQ6N193CnApmCyrbzf8e0SLKJDao2hRQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2VMfMgTo9/6hWaxzwF2q7miaynK3si6D1t9+HA2/Js=;
 b=R/RY2XFeeQshUgHYLgk9ZY9UrXGeAHg5MS0oUm4r0mjIVBZEvGHsdelA7jpff/lQCojp+Vh7ihjkZXegsSviHzAYtLI1OnULSrImneoYEmQoKlXhTYN6yBxAjv+ETZ5cbaH505Q6VKCqyYv5XvzHxELYlBJsH1tN6G2xmrYXDjk=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5499.eurprd08.prod.outlook.com (10.255.185.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Mon, 12 Aug 2019 15:47:41 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 15:47:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 6/7] block/backup: teach backup_cow_with_bounce_buffer
 to copy more at once
Thread-Index: AQHVT7JML2nk8Wsax0eUZCBvWTBktKb3oMEAgAAKYwA=
Date: Mon, 12 Aug 2019 15:47:41 +0000
Message-ID: <89c87c83-276a-7663-a239-57dbd9f91a30@virtuozzo.com>
References: <20190810193155.58637-1-vsementsov@virtuozzo.com>
 <20190810193155.58637-7-vsementsov@virtuozzo.com>
 <5102eac9-125b-0719-910f-4adb240732f1@redhat.com>
In-Reply-To: <5102eac9-125b-0719-910f-4adb240732f1@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0054.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::22) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190812184738705
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc3f8e89-5550-4ba1-aa16-08d71f3c68b1
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5499; 
x-ms-traffictypediagnostic: DB8PR08MB5499:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB54995353F8AD76F802456E60C1D30@DB8PR08MB5499.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(39840400004)(366004)(396003)(376002)(189003)(52314003)(199004)(14444005)(54906003)(4326008)(71200400001)(256004)(110136005)(316002)(71190400001)(8676002)(102836004)(386003)(6246003)(86362001)(53546011)(52116002)(6506007)(76176011)(26005)(229853002)(6436002)(14454004)(6512007)(6486002)(107886003)(31696002)(186003)(99286004)(478600001)(53936002)(476003)(486006)(5660300002)(11346002)(446003)(66446008)(64756008)(66556008)(66476007)(36756003)(2906002)(2616005)(31686004)(305945005)(66066001)(25786009)(6116002)(3846002)(66946007)(2501003)(8936002)(7736002)(81156014)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5499;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dvKsE1kKpjhE8A/dmNhatxv7xPi+NCdJukBUiL/S8Agf70LxhwGLYCkCELa34tc2V9JOwFFEpFPhph9Io5rKUz9F2dWNAtDsXdnsJ5TK7LMLSEmILWq6wfEZ4h9CHkWd1P/AkLWZ+Vpf7iydxzoQWtEdN34vF82IAxExic3U2M2m+chxuy80+KGkRhvTYIbUGy/ZWUp/LBYer+EULCF7I66bq+O4TbTlBIfFlgglG+pJiV/ztiYuQDxIc1TiBTSiMXrx3/qRxddo4H+DdOhp08zXdCUlbPqNrCRHL+OdsWE8o1pTvSruVF3Gvm3KxcVS65J77p7gfvZPhce00zxNPqEqQbXudR/2HCkemgezB8OEdI7C4vWNruYwKjMLxF0NpW6Z70p2OJjg6G1PFF28TQqnvJkWReSUtDddBoiMz20=
Content-Type: text/plain; charset="utf-8"
Content-ID: <318D1B3914B9414BB681EA861A2C2E00@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3f8e89-5550-4ba1-aa16-08d71f3c68b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 15:47:41.1997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kEwZjc0VdomUsKmk6mE3NjyEhYw0cPC/QQjC6+GlMEYZBxErpOrB0PgeqguzvTEJyYfBdrbPguzoR84WAG8b50xypQwE9/3nzkO1MEUII6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5499
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.103
Subject: Re: [Qemu-devel] [PATCH v3 6/7] block/backup: teach
 backup_cow_with_bounce_buffer to copy more at once
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTIuMDguMjAxOSAxODoxMCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMC4wOC4xOSAyMTozMSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IGJhY2t1cF9jb3dfd2l0aF9v
ZmZsb2FkIGNhbiB0cmFuc2ZlciBtb3JlIHRoYW4gb25lIGNsdXN0ZXIuIExldA0KPj4gYmFja3Vw
X2Nvd193aXRoX2JvdW5jZV9idWZmZXIgYmVoYXZlIHNpbWlsYXJseS4gSXQgcmVkdWNlcyB0aGUg
bnVtYmVyDQo+PiBvZiBJTyByZXF1ZXN0cywgc2luY2UgdGhlcmUgaXMgbm8gbmVlZCB0byBjb3B5
IGNsdXN0ZXIgYnkgY2x1c3Rlci4NCj4+DQo+PiBMb2dpYyBhcm91bmQgYm91bmNlX2J1ZmZlciBh
bGxvY2F0aW9uIGNoYW5nZWQ6IHdlIGNhbid0IGp1c3QgYWxsb2NhdGUNCj4+IG9uZS1jbHVzdGVy
LXNpemVkIGJ1ZmZlciB0byBzaGFyZSBmb3IgYWxsIGl0ZXJhdGlvbnMuIFdlIGNhbid0IGFsc28N
Cj4+IGFsbG9jYXRlIGJ1ZmZlciBvZiBmdWxsLXJlcXVlc3QgbGVuZ3RoIGl0IG1heSBiZSB0b28g
bGFyZ2UsIHNvDQo+PiBCQUNLVVBfTUFYX0JPVU5DRV9CVUZGRVIgaXMgaW50cm9kdWNlZC4gQW5k
IGZpbmFsbHksIGFsbG9jYXRpb24gbG9naWMNCj4+IGlzIHRvIGFsbG9jYXRlIGEgYnVmZmVyIHN1
ZmZpY2llbnQgdG8gaGFuZGxlIGFsbCByZW1haW5pbmcgaXRlcmF0aW9ucw0KPj4gYXQgdGhlIHBv
aW50IHdoZXJlIHdlIG5lZWQgdGhlIGJ1ZmZlciBmb3IgdGhlIGZpcnN0IHRpbWUuDQo+Pg0KPj4g
Qm9udXM6IGdldCByaWQgb2YgcG9pbnRlci10by1wb2ludGVyLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNv
bT4NCj4+IC0tLQ0KPj4gICBibG9jay9iYWNrdXAuYyB8IDY1ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0MSBp
bnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYmxvY2sv
YmFja3VwLmMgYi9ibG9jay9iYWNrdXAuYw0KPj4gaW5kZXggZDQ4MmQ5MzQ1OC4uNjVmNzIxMmM4
NSAxMDA2NDQNCj4+IC0tLSBhL2Jsb2NrL2JhY2t1cC5jDQo+PiArKysgYi9ibG9jay9iYWNrdXAu
Yw0KPj4gQEAgLTI3LDYgKzI3LDcgQEANCj4+ICAgI2luY2x1ZGUgInFlbXUvZXJyb3ItcmVwb3J0
LmgiDQo+PiAgIA0KPj4gICAjZGVmaW5lIEJBQ0tVUF9DTFVTVEVSX1NJWkVfREVGQVVMVCAoMSA8
PCAxNikNCj4+ICsjZGVmaW5lIEJBQ0tVUF9NQVhfQk9VTkNFX0JVRkZFUiAoNjQgKiAxMDI0ICog
MTAyNCkNCj4+ICAgDQo+PiAgIHR5cGVkZWYgc3RydWN0IENvd1JlcXVlc3Qgew0KPj4gICAgICAg
aW50NjRfdCBzdGFydF9ieXRlOw0KPj4gQEAgLTk4LDQ0ICs5OSw1NSBAQCBzdGF0aWMgdm9pZCBj
b3dfcmVxdWVzdF9lbmQoQ293UmVxdWVzdCAqcmVxKQ0KPj4gICAgICAgcWVtdV9jb19xdWV1ZV9y
ZXN0YXJ0X2FsbCgmcmVxLT53YWl0X3F1ZXVlKTsNCj4+ICAgfQ0KPj4gICANCj4+IC0vKiBDb3B5
IHJhbmdlIHRvIHRhcmdldCB3aXRoIGEgYm91bmNlIGJ1ZmZlciBhbmQgcmV0dXJuIHRoZSBieXRl
cyBjb3BpZWQuIElmDQo+PiAtICogZXJyb3Igb2NjdXJyZWQsIHJldHVybiBhIG5lZ2F0aXZlIGVy
cm9yIG51bWJlciAqLw0KPj4gKy8qDQo+PiArICogQ29weSByYW5nZSB0byB0YXJnZXQgd2l0aCBh
IGJvdW5jZSBidWZmZXIgYW5kIHJldHVybiB0aGUgYnl0ZXMgY29waWVkLiBJZg0KPj4gKyAqIGVy
cm9yIG9jY3VycmVkLCByZXR1cm4gYSBuZWdhdGl2ZSBlcnJvciBudW1iZXINCj4+ICsgKg0KPj4g
KyAqIEBib3VuY2VfYnVmZmVyIGlzIGFzc3VtZWQgdG8gZW5vdWdoIHRvIHN0b3JlDQo+IA0KPiBz
L3RvL3RvIGJlLw0KPiANCj4+ICsgKiBNSU4oQkFDS1VQX01BWF9CT1VOQ0VfQlVGRkVSLCBAZW5k
IC0gQHN0YXJ0KSBieXRlcw0KPj4gKyAqLw0KPj4gICBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBi
YWNrdXBfY293X3dpdGhfYm91bmNlX2J1ZmZlcihCYWNrdXBCbG9ja0pvYiAqam9iLA0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQ2
NF90IHN0YXJ0LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBpbnQ2NF90IGVuZCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBpc193cml0ZV9ub3RpZmllciwNCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Ym9vbCAqZXJyb3JfaXNfcmVhZCwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB2b2lkICoqYm91bmNlX2J1ZmZlcikNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpib3Vu
Y2VfYnVmZmVyKQ0KPj4gICB7DQo+PiAgICAgICBpbnQgcmV0Ow0KPj4gICAgICAgQmxvY2tCYWNr
ZW5kICpibGsgPSBqb2ItPmNvbW1vbi5ibGs7DQo+PiAtICAgIGludCBuYnl0ZXM7DQo+PiArICAg
IGludCBuYnl0ZXMsIHJlbWFpbmluZ19ieXRlczsNCj4+ICAgICAgIGludCByZWFkX2ZsYWdzID0g
aXNfd3JpdGVfbm90aWZpZXIgPyBCRFJWX1JFUV9OT19TRVJJQUxJU0lORyA6IDA7DQo+PiAgIA0K
Pj4gICAgICAgYXNzZXJ0KFFFTVVfSVNfQUxJR05FRChzdGFydCwgam9iLT5jbHVzdGVyX3NpemUp
KTsNCj4+IC0gICAgYmRydl9yZXNldF9kaXJ0eV9iaXRtYXAoam9iLT5jb3B5X2JpdG1hcCwgc3Rh
cnQsIGpvYi0+Y2x1c3Rlcl9zaXplKTsNCj4+IC0gICAgbmJ5dGVzID0gTUlOKGpvYi0+Y2x1c3Rl
cl9zaXplLCBqb2ItPmxlbiAtIHN0YXJ0KTsNCj4+IC0gICAgaWYgKCEqYm91bmNlX2J1ZmZlcikg
ew0KPj4gLSAgICAgICAgKmJvdW5jZV9idWZmZXIgPSBibGtfYmxvY2thbGlnbihibGssIGpvYi0+
Y2x1c3Rlcl9zaXplKTsNCj4+IC0gICAgfQ0KPj4gKyAgICBiZHJ2X3Jlc2V0X2RpcnR5X2JpdG1h
cChqb2ItPmNvcHlfYml0bWFwLCBzdGFydCwgZW5kIC0gc3RhcnQpOw0KPj4gKyAgICBuYnl0ZXMg
PSBNSU4oZW5kIC0gc3RhcnQsIGpvYi0+bGVuIC0gc3RhcnQpOw0KPj4gICANCj4+IC0gICAgcmV0
ID0gYmxrX2NvX3ByZWFkKGJsaywgc3RhcnQsIG5ieXRlcywgKmJvdW5jZV9idWZmZXIsIHJlYWRf
ZmxhZ3MpOw0KPj4gLSAgICBpZiAocmV0IDwgMCkgew0KPj4gLSAgICAgICAgdHJhY2VfYmFja3Vw
X2RvX2Nvd19yZWFkX2ZhaWwoam9iLCBzdGFydCwgcmV0KTsNCj4+IC0gICAgICAgIGlmIChlcnJv
cl9pc19yZWFkKSB7DQo+PiAtICAgICAgICAgICAgKmVycm9yX2lzX3JlYWQgPSB0cnVlOw0KPj4g
Kw0KPj4gKyAgICByZW1haW5pbmdfYnl0ZXMgPSBuYnl0ZXM7DQo+PiArICAgIHdoaWxlIChyZW1h
aW5pbmdfYnl0ZXMpIHsNCj4+ICsgICAgICAgIGludCBjaHVuayA9IE1JTihCQUNLVVBfTUFYX0JP
VU5DRV9CVUZGRVIsIHJlbWFpbmluZ19ieXRlcyk7DQo+PiArDQo+PiArICAgICAgICByZXQgPSBi
bGtfY29fcHJlYWQoYmxrLCBzdGFydCwgY2h1bmssIGJvdW5jZV9idWZmZXIsIHJlYWRfZmxhZ3Mp
Ow0KPj4gKyAgICAgICAgaWYgKHJldCA8IDApIHsNCj4+ICsgICAgICAgICAgICB0cmFjZV9iYWNr
dXBfZG9fY293X3JlYWRfZmFpbChqb2IsIHN0YXJ0LCByZXQpOw0KPj4gKyAgICAgICAgICAgIGlm
IChlcnJvcl9pc19yZWFkKSB7DQo+PiArICAgICAgICAgICAgICAgICplcnJvcl9pc19yZWFkID0g
dHJ1ZTsNCj4+ICsgICAgICAgICAgICB9DQo+PiArICAgICAgICAgICAgZ290byBmYWlsOw0KPj4g
ICAgICAgICAgIH0NCj4+IC0gICAgICAgIGdvdG8gZmFpbDsNCj4+IC0gICAgfQ0KPj4gICANCj4+
IC0gICAgcmV0ID0gYmxrX2NvX3B3cml0ZShqb2ItPnRhcmdldCwgc3RhcnQsIG5ieXRlcywgKmJv
dW5jZV9idWZmZXIsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgam9iLT53cml0ZV9mbGFn
cyk7DQo+PiAtICAgIGlmIChyZXQgPCAwKSB7DQo+PiAtICAgICAgICB0cmFjZV9iYWNrdXBfZG9f
Y293X3dyaXRlX2ZhaWwoam9iLCBzdGFydCwgcmV0KTsNCj4+IC0gICAgICAgIGlmIChlcnJvcl9p
c19yZWFkKSB7DQo+PiAtICAgICAgICAgICAgKmVycm9yX2lzX3JlYWQgPSBmYWxzZTsNCj4+ICsg
ICAgICAgIHJldCA9IGJsa19jb19wd3JpdGUoam9iLT50YXJnZXQsIHN0YXJ0LCBjaHVuaywgYm91
bmNlX2J1ZmZlciwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgam9iLT53cml0ZV9m
bGFncyk7DQo+PiArICAgICAgICBpZiAocmV0IDwgMCkgew0KPj4gKyAgICAgICAgICAgIHRyYWNl
X2JhY2t1cF9kb19jb3dfd3JpdGVfZmFpbChqb2IsIHN0YXJ0LCByZXQpOw0KPj4gKyAgICAgICAg
ICAgIGlmIChlcnJvcl9pc19yZWFkKSB7DQo+PiArICAgICAgICAgICAgICAgICplcnJvcl9pc19y
ZWFkID0gZmFsc2U7DQo+PiArICAgICAgICAgICAgfQ0KPj4gKyAgICAgICAgICAgIGdvdG8gZmFp
bDsNCj4+ICAgICAgICAgICB9DQo+PiAtICAgICAgICBnb3RvIGZhaWw7DQo+PiArDQo+PiArICAg
ICAgICBzdGFydCArPSBjaHVuazsNCj4+ICsgICAgICAgIHJlbWFpbmluZ19ieXRlcyAtPSBjaHVu
azsNCj4+ICAgICAgIH0NCj4+ICAgDQo+PiAgICAgICByZXR1cm4gbmJ5dGVzOw0KPj4gQEAgLTMw
MSw5ICszMTMsMTQgQEAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4gYmFja3VwX2RvX2NvdyhCYWNr
dXBCbG9ja0pvYiAqam9iLA0KPj4gICAgICAgICAgICAgICB9DQo+PiAgICAgICAgICAgfQ0KPj4g
ICAgICAgICAgIGlmICgham9iLT51c2VfY29weV9yYW5nZSkgew0KPj4gKyAgICAgICAgICAgIGlm
ICghYm91bmNlX2J1ZmZlcikgew0KPj4gKyAgICAgICAgICAgICAgICBzaXplX3QgbGVuID0gTUlO
KEJBQ0tVUF9NQVhfQk9VTkNFX0JVRkZFUiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBNQVgoZGlydHlfZW5kIC0gc3RhcnQsIGVuZCAtIGRpcnR5X2VuZCkpOw0KPj4gKyAg
ICAgICAgICAgICAgICBib3VuY2VfYnVmZmVyID0gYmxrX3RyeV9ibG9ja2FsaWduKGpvYi0+Y29t
bW9uLmJsaywgbGVuKTsNCj4+ICsgICAgICAgICAgICB9DQo+IA0KPiBJZiB5b3UgdXNlIF90cnlf
LCB5b3Ugc2hvdWxkIHByb2JhYmx5IGFsc28gY2hlY2sgd2hldGhlciBpdCBzdWNjZWVkZWQuDQoN
Ck9vcHMsIHlvdSBhcmUgcmlnaHQsIG9mIGNvdXJzZS4NCg0KPiANCj4gQW55d2F5LCBJIHdvbmRl
ciB3aGV0aGVyIGl04oCZZCBiZSBiZXR0ZXIgdG8ganVzdCBhbGxvY2F0ZSB0aGlzIGJ1ZmZlcg0K
PiBvbmNlIHBlciBqb2IgKHRoZSBmaXJzdCB0aW1lIHdlIGdldCBoZXJlLCBwcm9iYWJseSkgdG8g
YmUgb2Ygc2l6ZQ0KPiBCQUNLVVBfTUFYX0JPVU5DRV9CVUZGRVIgYW5kIHB1dCBpdCBpbnRvIEJh
Y2t1cEJsb2NrSm9iLiAgKEFuZCBtYXliZSBhZGQNCj4gYSBidWYtc2l6ZSBwYXJhbWV0ZXIgc2lt
aWxhciB0byB3aGF0IHRoZSBtaXJyb3Igam9icyBoYXZlLikNCj4gDQoNCk9uY2UgcGVyIGpvYiB3
aWxsIG5vdCB3b3JrLCBhcyB3ZSBtYXkgaGF2ZSBzZXZlcmFsIGd1ZXN0IHdyaXRlcyBpbiBwYXJh
bGxlbCBhbmQgdGhlcmVmb3JlDQpzZXZlcmFsIHBhcmFsbGVsIGNvcHktYmVmb3JlLXdyaXRlIG9w
ZXJhdGlvbnMuIE9yIGlmIHlvdSBtZWFuIHdyaXRpbmcgYW4gYWxsb2NhdG9yIGJhc2VkDQpvbiBv
bmNlLWFsbG9jYXRlZCBidWZmZXIgbGlrZSBpbiBtaXJyb3IsIEkgcmVhbGx5IGRpc2xpa2UgdGhp
cyBpZGVhLCBhcyB3ZSBhbHJlYWR5IGhhdmUNCmFsbG9jYXRvcjogbWVtYWxpZ24vbWFsbG9jL2Zy
ZWUgYW5kIGl0IHdvcmtzIHdlbGwsIG5vIHJlYXNvbiB0byBpbnZlbnQgYSBuZXcgb25lIGFuZA0K
aGFyZGNvZGUgaXQgaW50byBibG9jayBsYXllciAobG9vayBhdCBteSBhbnN3ZXIgdG8gRXJpYyBv
biB2MiBvZiB0aGlzIHBhdGNoIGZvciBtb3JlIGluZm8pLg0KDQpPciwgaWYgeW91IG1lYW4gb25s
eSBiYWNrdXBfbG9vcCBnZW5lcmF0ZWQgY29weS1yZXF1ZXN0cywgeWVzIHdlIG1heSBrZWVwIG9u
bHkgb25lIGJ1ZmZlciBmb3IgdGhlbSwNCmJ1dDoNCjEuIGl0IGlzIG5vdCBob3cgaXQgd29ya3Mg
bm93LCBzbyBteSBwYXRjaCBpcyBub3QgYSBkZWdyYWRhdGlvbiBpbiB0aGlzIGNhc2UNCjIuIEkn
bSBnb2luZyB0byBwYXJhbGxlbGl6ZSBiYWNrdXAgbG9vcCB0b28sIGxpa2UgbXkgc2VyaWVzICJx
Y293MjogYXN5bmMgaGFuZGxpbmcgb2YgZnJhZ21lbnRlZCBpbyIsDQogICAgd2hpY2ggd2lsbCBu
ZWVkIHNldmVyYWwgYWxsb2NhdGVkIGJ1ZmZlcnMgYW55d2F5Lg0KDQo+IA0KPj4gICAgICAgICAg
ICAgICByZXQgPSBiYWNrdXBfY293X3dpdGhfYm91bmNlX2J1ZmZlcihqb2IsIHN0YXJ0LCBkaXJ0
eV9lbmQsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGlzX3dyaXRlX25vdGlmaWVyLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGVycm9yX2lzX3JlYWQsICZib3VuY2VfYnVmZmVyKTsNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlcnJvcl9pc19y
ZWFkLCBib3VuY2VfYnVmZmVyKTsNCj4+ICAgICAgICAgICB9DQo+PiAgICAgICAgICAgaWYgKHJl
dCA8IDApIHsNCj4+ICAgICAgICAgICAgICAgYnJlYWs7DQo+Pg0KPiANCj4gDQoNCg0KLS0gDQpC
ZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

