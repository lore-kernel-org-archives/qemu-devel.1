Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FF5CA9EAD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 18:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF5C218BA
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 18:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WIpnMX/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF5C218BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMFsP-0007OA-3n
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 14:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iMFre-0006ue-3o
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 14:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iMFrd-0006xx-42
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 14:23:38 -0400
Received: from mail-eopbgr60135.outbound.protection.outlook.com
 ([40.107.6.135]:31759 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iMFrZ-0006vY-F3; Sun, 20 Oct 2019 14:23:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyrGYgiskop/vq+NjbfgILdvR/GmKwoN9ky82ihct+vc1PV8LcHIeGoZNnooEkRNUjC+82Xan4N8c3ssCWGKW8DFPL9k4wjxtIcuWTh2jBzIqpZEOqSWWh+BGFqsrofEhzqTGcSF4g6nQDTRt6IeKMJHGo5su6a+oLj5tmAzcTZuLfm/oJZfqCrI+jsYyVnNDDPVcI2/ILyXqK+qT8tuTYvmMfb0EC8etz1Vnb091y4P9PHImaVQ/lwjIxco6coz/xxnKjPmgNv3gw8Ntjte1d5eXPgqEH/qL7fkqoMAMszi8DxwyPG8HPQy3n282Zaeuaw2jUTAHB6y44qlLQ6onw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeKC4MvA6y6Nb32cHQGz0PV2EKtB8cS1RwQWuHu8tkg=;
 b=VTgJpczIcUEX57kFMS93PeoLeXB4NReAtiXlLnTZ71V2mgRxteZbGRfLmkwxNt62W8se+KYvJPhF0wZjtFguhq3pSAHqnVd8fF6NXtkjBRXOdQ+qZ369wBE+14TLf+j7sPlMcZE8Jj3TKzJIvtmHH/ItCWe7L17QCoBZO63cNkf9nSCcrJJvz5u0mWKZjt21cdGV9xt5w8J2o5+p/1xmEfiV91HrcI8iceK2NVwm76IqtL+FSQlpK0QC2DgoQqEkz0jIEfkGASrjsHsOFFxguRIpxsBfIfKkkatNYzP0vxqJXvwF7Ncb168ABRdrZNzgLfZHza21tu7yURbTaEsGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeKC4MvA6y6Nb32cHQGz0PV2EKtB8cS1RwQWuHu8tkg=;
 b=WIpnMX/fT47jr6LflGb/bNekFY969nQRd8eeFsc+cPl7p9CoCsC8y0dVA55g65VYSt9YCBpyfOTdrIOY66JQ1tTHNUJqZzWbOBJ2LEcPG5nTG0rtQKnRleYD856jGl0MqVRNhJyOFObaOOuMnCbmLM3AfKuvVaKeYaiaotRLgIY=
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com (10.170.220.33) by
 DB6PR08MB2936.eurprd08.prod.outlook.com (10.175.235.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Sun, 20 Oct 2019 18:23:29 +0000
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b]) by DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b%4]) with mapi id 15.20.2367.021; Sun, 20 Oct 2019
 18:23:28 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 3/4] tests/qemu-iotests: add case to write compressed
 data of multiple clusters
Thread-Topic: [PATCH v4 3/4] tests/qemu-iotests: add case to write compressed
 data of multiple clusters
Thread-Index: AQHVhD7YVM+4B+JXqkKgQCwHJhQxUKdfFSkAgATJRYA=
Date: Sun, 20 Oct 2019 18:23:28 +0000
Message-ID: <0dd21cbc-601c-358e-3dc2-c7871731246a@virtuozzo.com>
References: <1571243333-882302-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1571243333-882302-4-git-send-email-andrey.shinkevich@virtuozzo.com>
 <2385abe2-cfd0-4d13-ce6a-bde10a884381@virtuozzo.com>
In-Reply-To: <2385abe2-cfd0-4d13-ce6a-bde10a884381@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0004.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::14) To DB6PR08MB2757.eurprd08.prod.outlook.com
 (2603:10a6:6:18::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08662049-60ad-41fe-7c23-08d7558a9a79
x-ms-traffictypediagnostic: DB6PR08MB2936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR08MB2936E4D7B40313B3BDC0030FF46E0@DB6PR08MB2936.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:288;
x-forefront-prvs: 0196A226D1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(376002)(136003)(346002)(366004)(396003)(189003)(199004)(8936002)(31696002)(486006)(54906003)(86362001)(25786009)(256004)(6512007)(305945005)(31686004)(7736002)(186003)(478600001)(110136005)(11346002)(476003)(2616005)(102836004)(5660300002)(2906002)(6506007)(386003)(44832011)(316002)(66066001)(26005)(446003)(71200400001)(71190400001)(6486002)(81156014)(81166006)(8676002)(3846002)(66556008)(66476007)(229853002)(6116002)(14454004)(6436002)(2201001)(36756003)(107886003)(66946007)(52116002)(76176011)(4326008)(2501003)(66446008)(64756008)(6246003)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR08MB2936;
 H:DB6PR08MB2757.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QKe2SANqHhvsr22zoiId6P8ONGCrNrOb+wjx36xy6VRSxPvP3JyN52Y6uS/9FtDrUPvySFJWIq3WOkwnKbo6DEeB9ymt6/1pwLPwQKC6/aGbWUxz6JsAEufgr6qXYShPHbvboNv7srbr9/sttVfUqiEFatxE+doz8lWpAvzYqPLwokC2lksoIPI3PpVbo6gxodEY5iu52y+v2c+bNO+iiFMDIk9FXxNfKPMoWNjXd4rgGCqv2IUDEh/qoZMX2MR8kGGUW100ugarZB5Wg5k/Pi50/xJpHNPaM8rPxvw/zDuA566aBUP/mmH6xZxUYclMOgB+Dbq3x4bWQlr1q1+SnQ0V7gUQpP37tftt6NTToIwNPDbwL7leqy07u8z26A7p0hhJroS8eQqYZ2yOUHJM6QvyYdrurRoPmRzUx2MmqEg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81573A7E80B55A41937FDD7F58513AE1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08662049-60ad-41fe-7c23-08d7558a9a79
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2019 18:23:28.4213 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vDJ4JjzatBp/V0aDgr/27BzRvHnyoJIPNhfqkMck/uup/6HLvQOTNliGr0BTH8ITIQIJ4OqH7ngUMIOfhtu/GdovhD8dCcUie904aiY9dhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2936
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.135
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
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pj4gKyMgU2V0IGNvbXByZXNzPW9uLiBUaGF0IHdpbGwgYWxpZ24gdGhlIHdyaXR0ZW4gZGF0YQ0K
Pj4gKyMgYnkgdGhlIGNsdXN0ZXIgc2l6ZSBhbmQgd2lsbCB3cml0ZSB0aGVtIGNvbXByZXNzZWQu
DQo+PiArUUVNVV9JT19PUFRJT05TPSRRRU1VX0lPX09QVElPTlNfTk9fRk1UIFwNCj4+ICskUUVN
VV9JTyAtYyAid3JpdGUgLVAgMHhiYiAwICRkYXRhX3NpemUiIC0taW1hZ2Utb3B0cyBcDQo+PiAr
ICAgICAgICAgZHJpdmVyPSRJTUdGTVQsY29tcHJlc3M9b24sZmlsZS5maWxlbmFtZT0kVEVTVF9J
TUcgXA0KPj4gKyAgICAgICAgIDI+JjEgfCBfZmlsdGVyX3FlbXVfaW8gfCBfZmlsdGVyX3Rlc3Rk
aXINCj4+ICsNCj4+ICtsZXQgb2Zmc2V0PSI0ICogJGNsdXN0ZXJfc2l6ZSINCj4+ICtRRU1VX0lP
X09QVElPTlM9JFFFTVVfSU9fT1BUSU9OU19OT19GTVQgXA0KPj4gKyRRRU1VX0lPIC1jICJ3cml0
ZSAtUCAweGNjICRvZmZzZXQgJGRhdGFfc2l6ZSIgImpzb246e1wNCj4+ICsgICAgJ2RyaXZlcic6
ICckSU1HRk1UJywNCj4+ICsgICAgJ2ZpbGUnOiB7DQo+PiArICAgICAgICAnZHJpdmVyJzogJ2Zp
bGUnLA0KPj4gKyAgICAgICAgJ2ZpbGVuYW1lJzogJyRURVNUX0lNRycNCj4+ICsgICAgfSwNCj4+
ICsgICAgJ2NvbXByZXNzJzogdHJ1ZQ0KPj4gK30iIHwgX2ZpbHRlcl9xZW11X2lvIHwgX2ZpbHRl
cl90ZXN0ZGlyDQo+PiArDQo+IA0KPiBJdCB3b3VsZCBiZSBnb29kIHRvIGFkZCBjYXNlIHdpdGgg
dW5hbGlnbmVkIG9mZnNldCBhcyB3ZWxsLiBBbmQsIG1heWJlLCINCj4gY2hlY2sgdGhhdCB3ZSBk
b24ndCByZXdyaXRlIGV4aXN0aW5nIGRhdGEgaW4gcGFydGlhbCBjbHVzdGVycyB3aGVuIHdyaXRp
bmcNCj4gdW5hbGlnbmVkIGNvbXByZXNzZWQgZGF0YSBvdmVyIGl0Lg0KPiANCg0KVGhlIEkvTyBl
cnJvciBpcyByYWlzZWQgaW4gdGhhdCBjYXNlIChzZWUgDQpxY293Ml9hbGxvY19jb21wcmVzc2Vk
X2NsdXN0ZXJfb2Zmc2V0KCkpOg0KIkNvbXByZXNzaW9uIGNhbid0IG92ZXJ3cml0ZSBhbnl0aGlu
Zy4gRmFpbCBpZiB0aGUgY2x1c3RlciB3YXMgYWxyZWFkeSANCmFsbG9jYXRlZC4iDQoNCiMwICBx
Y293Ml9hbGxvY19jb21wcmVzc2VkX2NsdXN0ZXJfb2Zmc2V0IChicz0weDU2NDY2OTE0MzM5MCwg
DQpvZmZzZXQ9MzkzMjE2LCBjb21wcmVzc2VkX3NpemU9NzksIGhvc3Rfb2Zmc2V0PTB4N2Y0NTI4
OWQ5ZjAwKSBhdCANCmJsb2NrL3Fjb3cyLWNsdXN0ZXIuYzo3NjcNCiMxICAweDAwMDA1NjQ2Njcw
M2RhN2YgaW4gcWNvdzJfY29fcHdyaXRldl9jb21wcmVzc2VkX3Rhc2sgDQooYnM9MHg1NjQ2Njkx
NDMzOTAsIG9mZnNldD0zOTMyMTYsIGJ5dGVzPTY1NTM2LCBxaW92PTB4N2Y0NTI4ZGRkZWMwLCAN
CnFpb3Zfb2Zmc2V0PTE5NjYwOCkgYXQgYmxvY2svcWNvdzIuYzo0MTk4DQojMiAgMHgwMDAwNTY0
NjY3MDNkYzBjIGluIHFjb3cyX2NvX3B3cml0ZXZfY29tcHJlc3NlZF90YXNrX2VudHJ5IA0KKHRh
c2s9MHg1NjQ2NjkxNTJhYzApIGF0IGJsb2NrL3Fjb3cyLmM6NDIzMA0KIzMgIDB4MDAwMDU2NDY2
NzBhNjlkMCBpbiBhaW9fdGFza19jbyAob3BhcXVlPTB4NTY0NjY5MTUyYWMwKSBhdCANCmJsb2Nr
L2Fpb190YXNrLmM6NDUNCiM0ICAweDAwMDA1NjQ2NjcxNDdhODcgaW4gY29yb3V0aW5lX3RyYW1w
b2xpbmUgKGkwPTE3NjI5OTQ5NzYsIGkxPTIyMDg2KSANCmF0IHV0aWwvY29yb3V0aW5lLXVjb250
ZXh0LmM6MTE1DQoNCkFuZHJleQ0KLS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkg
U2hpbmtldmljaA0K

