Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67ABCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F5C02086D
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AouXrcFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5C02086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP5B9-0001Mj-S2
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 09:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iP4UA-0001Pl-NI
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iP4U9-0004F0-9v
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:51:02 -0400
Received: from mail-eopbgr00096.outbound.protection.outlook.com
 ([40.107.0.96]:16907 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iP4U4-0004BX-QO; Mon, 28 Oct 2019 08:50:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1nOOH698FiKL4MFVQXbjH0bJk589a3UmQwvGWx8YF20EahdtVATv2i9dA4wK/f5I6D4/L7dFQck9uuxVtQDu4pBG1k65Ot1Yz8+w6r7ILjAdNlxTLp0BrtemtrWD1tNHKWITlZ1GzJhplBSMSvxhjDiJK+jkRCh2ZebO+lw+CGUs6kPLFipSalGnLjUjNCpCN60FH1z+XDOrUFg/O9KtXbbO7GPWWU0ls+wX4+IJez/gGO1rIeOYONtwV6QF0Y38bzFhbyWquGJBneu05yAHpXrOD8zigYOl5oP2ldpPsZry7w/RBYDqhALH9QpDiCyiu8rHoT+VyLUPQ1oeLIiSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjMtQfcmoc0caO6+fMc5b5LVy7Q3Yu/kORFv39nwad0=;
 b=nrKKezWfp+8ZUGoAUOL71VHD104sSkvgG6MjULTs4S0j6ZTfLrAGkqZqF1n0AUPMyWsh7UjF2n/tMqz9zEuDSsyvpbJt20hjZ3gl4gNM3D2YVIVTJjdRQlK1XCfErts6T0/tHflCzAECgfI/GWkrkdyQzWCWGmwzyIHP44/q0Pzdjh9kahsJ3lflZYnJaN+Iq1Klcy5XbVaPf9bDGZh0yAdBXEhxBW27eVYJxibYkE0pwnvah0GM2IjET4VXIpclU+0FqLvU2jLDeTiDrbW4crvTo2aEbGWPkLXCz5WZvkjFrUYwamc2Cl9Jf7IQpWXjg+dhBOrVJFDWKLUBx5ThpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjMtQfcmoc0caO6+fMc5b5LVy7Q3Yu/kORFv39nwad0=;
 b=AouXrcFqIGzGxsnIodlTydW6WHS549ca5ft86bKi0O8FwysExC7XSU19NaIE8r92QJ6UQrVTIkCmLS58UqP4j2WTrhxx9uQovaa3b224WUB8/chCI5LT2UYmS332gbmrUQJRx53KCpg7NxkgP5OZDi7TnCo42VGcm+ziq2bkcHI=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB4402.eurprd08.prod.outlook.com (20.179.36.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Mon, 28 Oct 2019 12:50:55 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119%6]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 12:50:55 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH v2 01/26] qcow2: Add calculate_l2_meta()
Thread-Topic: [RFC PATCH v2 01/26] qcow2: Add calculate_l2_meta()
Thread-Index: AQHVjEP6mjqcfJvch0CHqxjv72eW4qdwBB+A
Date: Mon, 28 Oct 2019 12:50:54 +0000
Message-ID: <81fcd087-d4f7-173d-e6cc-53f59dbd2d45@virtuozzo.com>
References: <cover.1572125022.git.berto@igalia.com>
 <22820af5867124e4fdf3d0cb74b99f31edc1b37f.1572125022.git.berto@igalia.com>
In-Reply-To: <22820af5867124e4fdf3d0cb74b99f31edc1b37f.1572125022.git.berto@igalia.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0010.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::20) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191028155051723
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5b48856-6c0b-4587-510d-08d75ba5787b
x-ms-traffictypediagnostic: AM0PR08MB4402:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB44029EE41F08B3A9BB5E1351C1660@AM0PR08MB4402.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(346002)(366004)(39840400004)(396003)(189003)(199004)(7736002)(31696002)(66946007)(6486002)(478600001)(2906002)(305945005)(86362001)(6512007)(52116002)(2501003)(229853002)(76176011)(54906003)(110136005)(4326008)(14454004)(3846002)(66476007)(81156014)(99286004)(316002)(5660300002)(66066001)(6436002)(8676002)(486006)(36756003)(11346002)(256004)(14444005)(66556008)(81166006)(386003)(6506007)(2616005)(6116002)(66446008)(64756008)(25786009)(8936002)(6246003)(102836004)(107886003)(31686004)(446003)(71200400001)(71190400001)(26005)(186003)(476003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4402;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F8Fd1PSXYDaaGdiNTznu5vRBlh+15rHACmAaNtbfDjTrWDTWRqum/ntAAE/wCCZ8o6G5CLKyxILtdQeBLCj6Wznu/h52/RIpZPWefy3YgYdCcKronIjznadheO+3cchBinKVn+Mze2ZnpjvhIXxh3H2PVJdkm5bIFcSAJeX/qM71aGio1Rav9vXLl3djTMW6YYwCWuAfLFECDXrC9fJ76Nu4g4/Eb0sXjknTxkGHPOFP+H8ZP3q99aIIPLf7vSxjUFcxNCMUmQ5Zyt4e79oLN9wSerfdg06pS+YrHJ79cAGyd9jjzLBwGwwJ0wRpwhc3oxrt1jKpAUenoHzp9anOhkmtGRxPhXn6OLVewxOO12H8JdMH/xl986mPr9iwNbjhX0HiJxmLbZopeU9jOYQ1fZvxS5LZLmo6DvLL0uSC+2K6p1wLV24gKQGgLxN83Smr
Content-Type: text/plain; charset="utf-8"
Content-ID: <8896C3F86BC17145A83A6B1E7AC89815@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b48856-6c0b-4587-510d-08d75ba5787b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 12:50:54.8731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U5grZwtHptQjQM353TBq8NG8mYg2OWaqXkafrELVCr2DBBX885KPsqBl8nKa8SOVkjkgt1r/4cR6reJi4IEGBJushg05FbQ1VwlQbknz82w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4402
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.96
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
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjcuMTAuMjAxOSAwOjI1LCBBbGJlcnRvIEdhcmNpYSB3cm90ZToNCj4gaGFuZGxlX2FsbG9jKCkg
Y3JlYXRlcyBhIFFDb3dMMk1ldGEgc3RydWN0dXJlIGluIG9yZGVyIHRvIHVwZGF0ZSB0aGUNCj4g
aW1hZ2UgbWV0YWRhdGEgYW5kIHBlcmZvcm0gdGhlIG5lY2Vzc2FyeSBjb3B5LW9uLXdyaXRlIG9w
ZXJhdGlvbnMuDQo+IA0KPiBUaGlzIHBhdGNoIG1vdmVzIHRoYXQgY29kZSB0byBhIHNlcGFyYXRl
IGZ1bmN0aW9uIHNvIGl0IGNhbiBiZSB1c2VkDQo+IGZyb20gb3RoZXIgcGxhY2VzLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQWxiZXJ0byBHYXJjaWEgPGJlcnRvQGlnYWxpYS5jb20+DQo+IC0tLQ0K
PiAgIGJsb2NrL3Fjb3cyLWNsdXN0ZXIuYyB8IDc2ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwg
MjQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svcWNvdzItY2x1c3Rlci5j
IGIvYmxvY2svcWNvdzItY2x1c3Rlci5jDQo+IGluZGV4IDg5ODJiN2I3NjIuLjZjMWRjZGM3ODEg
MTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL3Fjb3cyLWNsdXN0ZXIuYw0KPiArKysgYi9ibG9jay9xY293
Mi1jbHVzdGVyLmMNCj4gQEAgLTEwMTksNiArMTAxOSw1NSBAQCB2b2lkIHFjb3cyX2FsbG9jX2Ns
dXN0ZXJfYWJvcnQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIFFDb3dMMk1ldGEgKm0pDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgUUNPVzJfRElTQ0FSRF9ORVZFUik7DQo+ICAgfQ0KPiAgIA0K
PiArLyoNCj4gKyAqIEZvciBhIGdpdmVuIHdyaXRlIHJlcXVlc3QsIGNyZWF0ZSBhIG5ldyBRQ293
TDJNZXRhIHN0cnVjdHVyZSBhbmQNCj4gKyAqIGFkZCBpdCB0byBAbS4NCj4gKyAqDQo+ICsgKiBA
aG9zdF9vZmZzZXQgcG9pbnRzIHRvIHRoZSBiZWdpbm5pbmcgb2YgdGhlIGZpcnN0IGNsdXN0ZXIu
DQo+ICsgKg0KPiArICogQGd1ZXN0X29mZnNldCBhbmQgQGJ5dGVzIGluZGljYXRlIHRoZSBvZmZz
ZXQgYW5kIGxlbmd0aCBvZiB0aGUNCj4gKyAqIHJlcXVlc3QuDQo+ICsgKg0KPiArICogSWYgQGtl
ZXBfb2xkIGlzIHRydWUgaXQgbWVhbnMgdGhhdCB0aGUgY2x1c3RlcnMgd2VyZSBhbHJlYWR5DQo+
ICsgKiBhbGxvY2F0ZWQgYW5kIHdpbGwgYmUgb3ZlcndyaXR0ZW4uIElmIGZhbHNlIHRoZW4gdGhl
IGNsdXN0ZXJzIGFyZQ0KPiArICogbmV3IGFuZCB3ZSBoYXZlIHRvIGRlY3JlYXNlIHRoZSByZWZl
cmVuY2UgY291bnQgb2YgdGhlIG9sZCBvbmVzLg0KPiArICovDQo+ICtzdGF0aWMgdm9pZCBjYWxj
dWxhdGVfbDJfbWV0YShCbG9ja0RyaXZlclN0YXRlICpicywgdWludDY0X3QgaG9zdF9vZmZzZXQs
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCBndWVzdF9vZmZzZXQs
IHVpbnQ2NF90IGJ5dGVzLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUUNvd0wy
TWV0YSAqKm0sIGJvb2wga2VlcF9vbGQpDQo+ICt7DQo+ICsgICAgQkRSVlFjb3cyU3RhdGUgKnMg
PSBicy0+b3BhcXVlOw0KPiArICAgIHVuc2lnbmVkIGNvd19zdGFydF9mcm9tID0gMDsNCj4gKyAg
ICB1bnNpZ25lZCBjb3dfc3RhcnRfdG8gPSBvZmZzZXRfaW50b19jbHVzdGVyKHMsIGd1ZXN0X29m
ZnNldCk7DQo+ICsgICAgdW5zaWduZWQgY293X2VuZF9mcm9tID0gY293X3N0YXJ0X3RvICsgYnl0
ZXM7DQo+ICsgICAgdW5zaWduZWQgY293X2VuZF90byA9IFJPVU5EX1VQKGNvd19lbmRfZnJvbSwg
cy0+Y2x1c3Rlcl9zaXplKTsNCg0KTmV3IGNvZGUgaXMgZWFzaWVyIHRvIHJlYWQhDQoNCkludGVy
ZXN0aW5nLCBzZWVtcyBRRU1VX0FMSUdOX1VQIGlzIG1vcmUgcG9wdWxhci4uIEJ1dCBjb21tZW50
IGFib3ZlIFJPVU5EX1VQDQptYWtlcyBzZW5zZSBpbiB1c2luZyBpdCBoZXJlLi4NCg0KPiArICAg
IHVuc2lnbmVkIG5iX2NsdXN0ZXJzID0gc2l6ZV90b19jbHVzdGVycyhzLCBjb3dfZW5kX2Zyb20p
Ow0KPiArICAgIFFDb3dMMk1ldGEgKm9sZF9tID0gKm07DQo+ICsNCj4gKyAgICAqbSA9IGdfbWFs
bG9jMChzaXplb2YoKiptKSk7DQo+ICsgICAgKiptID0gKFFDb3dMMk1ldGEpIHsNCj4gKyAgICAg
ICAgLm5leHQgICAgICAgICAgID0gb2xkX20sDQo+ICsNCj4gKyAgICAgICAgLmFsbG9jX29mZnNl
dCAgID0gaG9zdF9vZmZzZXQsDQo+ICsgICAgICAgIC5vZmZzZXQgICAgICAgICA9IHN0YXJ0X29m
X2NsdXN0ZXIocywgZ3Vlc3Rfb2Zmc2V0KSwNCj4gKyAgICAgICAgLm5iX2NsdXN0ZXJzICAgID0g
bmJfY2x1c3RlcnMsDQo+ICsNCj4gKyAgICAgICAgLmtlZXBfb2xkX2NsdXN0ZXJzID0ga2VlcF9v
bGQsDQo+ICsNCj4gKyAgICAgICAgLmNvd19zdGFydCA9IHsNCj4gKyAgICAgICAgICAgIC5vZmZz
ZXQgICAgID0gY293X3N0YXJ0X2Zyb20sDQo+ICsgICAgICAgICAgICAubmJfYnl0ZXMgICA9IGNv
d19zdGFydF90byAtIGNvd19zdGFydF9mcm9tLA0KPiArICAgICAgICB9LA0KPiArICAgICAgICAu
Y293X2VuZCA9IHsNCj4gKyAgICAgICAgICAgIC5vZmZzZXQgICAgID0gY293X2VuZF9mcm9tLA0K
PiArICAgICAgICAgICAgLm5iX2J5dGVzICAgPSBjb3dfZW5kX3RvIC0gY293X2VuZF9mcm9tLA0K
PiArICAgICAgICB9LA0KPiArICAgIH07DQo+ICsNCj4gKyAgICBxZW11X2NvX3F1ZXVlX2luaXQo
JigqbSktPmRlcGVuZGVudF9yZXF1ZXN0cyk7DQo+ICsgICAgUUxJU1RfSU5TRVJUX0hFQUQoJnMt
PmNsdXN0ZXJfYWxsb2NzLCAqbSwgbmV4dF9pbl9mbGlnaHQpOw0KPiArfQ0KPiArDQo+ICAgLyoN
Cj4gICAgKiBSZXR1cm5zIHRoZSBudW1iZXIgb2YgY29udGlndW91cyBjbHVzdGVycyB0aGF0IGNh
biBiZSB1c2VkIGZvciBhbiBhbGxvY2F0aW5nDQo+ICAgICogd3JpdGUsIGJ1dCByZXF1aXJlIENP
VyB0byBiZSBwZXJmb3JtZWQgKHRoaXMgaW5jbHVkZXMgeWV0IHVuYWxsb2NhdGVkIHNwYWNlLA0K
PiBAQCAtMTQxNywzNSArMTQ2NiwxNCBAQCBzdGF0aWMgaW50IGhhbmRsZV9hbGxvYyhCbG9ja0Ry
aXZlclN0YXRlICpicywgdWludDY0X3QgZ3Vlc3Rfb2Zmc2V0LA0KPiAgICAgICB1aW50NjRfdCBy
ZXF1ZXN0ZWRfYnl0ZXMgPSAqYnl0ZXMgKyBvZmZzZXRfaW50b19jbHVzdGVyKHMsIGd1ZXN0X29m
ZnNldCk7DQo+ICAgICAgIGludCBhdmFpbF9ieXRlcyA9IG5iX2NsdXN0ZXJzIDw8IHMtPmNsdXN0
ZXJfYml0czsNCj4gICAgICAgaW50IG5iX2J5dGVzID0gTUlOKHJlcXVlc3RlZF9ieXRlcywgYXZh
aWxfYnl0ZXMpOw0KPiAtICAgIFFDb3dMMk1ldGEgKm9sZF9tID0gKm07DQo+IC0NCj4gLSAgICAq
bSA9IGdfbWFsbG9jMChzaXplb2YoKiptKSk7DQo+IC0NCj4gLSAgICAqKm0gPSAoUUNvd0wyTWV0
YSkgew0KPiAtICAgICAgICAubmV4dCAgICAgICAgICAgPSBvbGRfbSwNCj4gLQ0KPiAtICAgICAg
ICAuYWxsb2Nfb2Zmc2V0ICAgPSBhbGxvY19jbHVzdGVyX29mZnNldCwNCj4gLSAgICAgICAgLm9m
ZnNldCAgICAgICAgID0gc3RhcnRfb2ZfY2x1c3RlcihzLCBndWVzdF9vZmZzZXQpLA0KPiAtICAg
ICAgICAubmJfY2x1c3RlcnMgICAgPSBuYl9jbHVzdGVycywNCj4gLQ0KPiAtICAgICAgICAua2Vl
cF9vbGRfY2x1c3RlcnMgID0ga2VlcF9vbGRfY2x1c3RlcnMsDQo+IC0NCj4gLSAgICAgICAgLmNv
d19zdGFydCA9IHsNCj4gLSAgICAgICAgICAgIC5vZmZzZXQgICAgID0gMCwNCj4gLSAgICAgICAg
ICAgIC5uYl9ieXRlcyAgID0gb2Zmc2V0X2ludG9fY2x1c3RlcihzLCBndWVzdF9vZmZzZXQpLA0K
PiAtICAgICAgICB9LA0KPiAtICAgICAgICAuY293X2VuZCA9IHsNCj4gLSAgICAgICAgICAgIC5v
ZmZzZXQgICAgID0gbmJfYnl0ZXMsDQoNCmhtbSB0aGlzIGxvZ2ljIGlzIGNoYW5nZWQuLiBhZnRl
ciB0aGUgcGF0Y2gsIGl0IHdvdWxkIGJlIG5vdCBuYl9ieXRlcywgYnV0DQoNCm9mZnNldF9pbnRv
X2NsdXN0ZXIocywgZ3Vlc3Rfb2Zmc2V0KSArIE1JTigqYnl0ZXMsIG5iX2J5dGVzIC0gb2Zmc2V0
X2ludG9fY2x1c3RlcihzLCBndWVzdF9vZmZzZXQpKQ0KDQo+IC0gICAgICAgICAgICAubmJfYnl0
ZXMgICA9IGF2YWlsX2J5dGVzIC0gbmJfYnl0ZXMsDQo+IC0gICAgICAgIH0sDQo+IC0gICAgfTsN
Cj4gLSAgICBxZW11X2NvX3F1ZXVlX2luaXQoJigqbSktPmRlcGVuZGVudF9yZXF1ZXN0cyk7DQo+
IC0gICAgUUxJU1RfSU5TRVJUX0hFQUQoJnMtPmNsdXN0ZXJfYWxsb2NzLCAqbSwgbmV4dF9pbl9m
bGlnaHQpOw0KPiAgIA0KPiAgICAgICAqaG9zdF9vZmZzZXQgPSBhbGxvY19jbHVzdGVyX29mZnNl
dCArIG9mZnNldF9pbnRvX2NsdXN0ZXIocywgZ3Vlc3Rfb2Zmc2V0KTsNCj4gICAgICAgKmJ5dGVz
ID0gTUlOKCpieXRlcywgbmJfYnl0ZXMgLSBvZmZzZXRfaW50b19jbHVzdGVyKHMsIGd1ZXN0X29m
ZnNldCkpOw0KPiAgICAgICBhc3NlcnQoKmJ5dGVzICE9IDApOw0KPiAgIA0KPiArICAgIGNhbGN1
bGF0ZV9sMl9tZXRhKGJzLCBhbGxvY19jbHVzdGVyX29mZnNldCwgZ3Vlc3Rfb2Zmc2V0LCAqYnl0
ZXMsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgbSwga2VlcF9vbGRfY2x1c3RlcnMpOw0KPiAr
DQo+ICAgICAgIHJldHVybiAxOw0KPiAgIA0KPiAgIGZhaWw6DQo+IA0KDQoNCi0tIA0KQmVzdCBy
ZWdhcmRzLA0KVmxhZGltaXINCg==

