Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A753C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518FD20644
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="diiaTHc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518FD20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxYo5-0008N1-Eg
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 11:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50136)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxYn7-00071p-T4
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:32:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxYmy-0000FM-SO
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:32:48 -0400
Received: from mail-eopbgr50103.outbound.protection.outlook.com
 ([40.107.5.103]:13796 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxYmq-00004q-TE; Tue, 13 Aug 2019 11:32:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzBFe6b97cOGzTK+osa5ME5XD8lGrqByF6FdJ5xt4ZINj3vsMDOBWsVXltsud5S2V0QY5W8R7Msdpfg4A5mMraLx3uF/jSQTfdYqAnR/vLc/v4NxXa4oftlFlvRd/vqQrSq3PGNFCYOxx2D9Nsmnp21vJv1RMRh729oIIWPm5Ok7SFi6z5A2zoZtYqWlyjbQN3leCGIOW6CaIf32AXO6et2wHorZ0/UVPnlj5FS/xuOlTHsd7NovBKiniDARk2Nz1svs7mv/w+LsmqKIlUckIf56muKt2o4eRqh4J1h1KH3NsQibPqMKLkPtiL2eU8NDOaz9UXz+oorh6yOZCEaQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tw6Ylgk2k6bcKDz6hSsXLI3YKqDe4yL66AG/lc4NMh8=;
 b=J9XMGHQAbZmXAaP5/Cbgy2HY8/exYk0ZMM6GthPi4QOUgFxBJFlInBP9xVv1QL6IGgQv7p3cH40VFtpDGis4Uhn0YyTj+MGgIReg7GlGZDXmTNLX3S2XKSLJOgts/n4VY/682nMBWdWP1cWDSfyLbqfkRYBm7adA7GQjfXjVsX4AVrlpdc95b1cEKNNSlNsV8fKprlEAOd0CrkXNdD4o5xtns+82Q/t9FyPWznF38UmNfUTF+i24OWqj3l7ybHBIvisonZ1gbyvKphLWakyAIR6DzqtKrYuwf9qk7s4zHTnw0VumpXv/f3eY3upGnJNsS9bD2iEnQiApBFidA909aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tw6Ylgk2k6bcKDz6hSsXLI3YKqDe4yL66AG/lc4NMh8=;
 b=diiaTHc1AK5IBoouaX1OBk47Ucexb4KgSeKIqRId31x1mmVs/SbT3WVZVZPHSXFn4x8K9dloel/9sxzj411i66/nLJ+gmm/EYDhupbYmdmjz+9llNbmobVXTTnRgJW+YC/PCjQGxyoFW8PX4c90lVPk5hV8m7brHCBeTvgP9ZZI=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4011.eurprd08.prod.outlook.com (20.179.8.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.23; Tue, 13 Aug 2019 15:32:31 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 15:32:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 6/7] block/backup: teach backup_cow_with_bounce_buffer
 to copy more at once
Thread-Index: AQHVT7JML2nk8Wsax0eUZCBvWTBktKb3oMEAgAAKYwCAAAavAIAABzYAgAFqYoCAAAKCAIAANuAA///SwQCAAADLAIAAAHaAgAAIboA=
Date: Tue, 13 Aug 2019 15:32:31 +0000
Message-ID: <cab80946-e12b-b47b-c825-12aef7cee615@virtuozzo.com>
References: <20190810193155.58637-1-vsementsov@virtuozzo.com>
 <20190810193155.58637-7-vsementsov@virtuozzo.com>
 <5102eac9-125b-0719-910f-4adb240732f1@redhat.com>
 <89c87c83-276a-7663-a239-57dbd9f91a30@virtuozzo.com>
 <ecff86a8-57d1-4c8a-d4b4-95524471d249@redhat.com>
 <e3fc5e07-33c6-1fe3-2042-35bdac0a03c3@virtuozzo.com>
 <4093762b-a1bc-d6b1-8358-4f9d1ab52557@virtuozzo.com>
 <e05af208-c7cb-31e6-bfab-62a44f5281e7@redhat.com>
 <cf9718b9-f36d-27f3-ad49-4f6fb1e1d7b3@virtuozzo.com>
 <9b7a3060-4880-9ef4-89f2-e8327ce655b8@redhat.com>
 <9479f6b6-3cfe-8594-d8fc-9a66c8f799c1@virtuozzo.com>
 <f331ace9-de9f-e5d9-a569-5f50059a522c@redhat.com>
In-Reply-To: <f331ace9-de9f-e5d9-a569-5f50059a522c@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0017.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::27)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190813183229436
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 000acf23-df60-4444-5509-08d72003750e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4011; 
x-ms-traffictypediagnostic: DB8PR08MB4011:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB40114C46D21D54BE9E0BA195C1D20@DB8PR08MB4011.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(346002)(376002)(366004)(136003)(396003)(39850400004)(52314003)(199004)(189003)(256004)(14454004)(86362001)(5660300002)(3846002)(31696002)(2906002)(6116002)(31686004)(110136005)(316002)(99286004)(66066001)(14444005)(81156014)(8676002)(81166006)(478600001)(71190400001)(71200400001)(2501003)(7736002)(8936002)(305945005)(107886003)(2616005)(446003)(53936002)(66946007)(486006)(4326008)(76176011)(66476007)(6436002)(6512007)(36756003)(11346002)(54906003)(26005)(53546011)(66556008)(64756008)(6486002)(6506007)(386003)(476003)(52116002)(6246003)(66446008)(25786009)(229853002)(102836004)(186003)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4011;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fFSpAsYcnRnK7shTzYDebc/a4VfKfSXOjwxPcy7UHdk21cd1mGT8syZ3jVdN90+Z/s2jfoyfhMMtcX8hVwXQv5qRAgUuat/5BZBK/83fNa884Bil1uLEqksjZwrxdDcVS+Ls/RbWWEvu0sktjhF91vc+JixcRof3APemTTTp6kIHs/lL9mvPgyjLYrrEJ9XdQoF6UR773LymW42xZcr2wf79/lTT0BRz093hR2/AT3rexbqHKCab0tT38aYYoN2V07RKNU4YqYzigGn7J1ucYRZkTqbitGHJhPo1QAAk2hminmAbgWkaBNeXMeTC0KqtKgRBRlR7c0siA2cTxiAv8MhUJg3O+aknCt+otKH8QxTIj1JK0i1ImcD4WHFI0YWQUfaJ70aLw692McU9qYScqcOiavz42yt+K6Ui9CpyM3g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E9A1E039D65654892377584C9B53BF9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 000acf23-df60-4444-5509-08d72003750e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 15:32:31.8179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MVesTSAn8NImaK7msbigqyVHClKrc60jJnPfrD9BgrMhZ8Uz/1urX+jeCKrifAQA4NI92gPI69OLxaSTKMAz5WtHOSqrXPXr58wXhS7uKqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4011
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.103
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

MTMuMDguMjAxOSAxODowMiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMy4wOC4xOSAxNzowMCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDEzLjA4LjIwMTkgMTc6NTcs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAxMy4wOC4xOSAxNjozOSwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMTMuMDguMjAxOSAxNzoyMywgTWF4IFJlaXR6IHdy
b3RlOg0KPj4+Pj4gT24gMTMuMDguMTkgMTY6MTQsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgd3JvdGU6DQo+Pj4+Pj4gMTIuMDguMjAxOSAxOTozNywgVmxhZGltaXIgU2VtZW50c292LU9n
aWV2c2tpeSB3cm90ZToNCj4+Pj4+Pj4gMTIuMDguMjAxOSAxOToxMSwgTWF4IFJlaXR6IHdyb3Rl
Og0KPj4+Pj4+Pj4gT24gMTIuMDguMTkgMTc6NDcsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgd3JvdGU6DQo+Pj4+Pj4+Pj4gMTIuMDguMjAxOSAxODoxMCwgTWF4IFJlaXR6IHdyb3RlOg0K
Pj4+Pj4+Pj4+PiBPbiAxMC4wOC4xOSAyMTozMSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tp
eSB3cm90ZToNCj4+Pj4+Pj4+Pj4+IGJhY2t1cF9jb3dfd2l0aF9vZmZsb2FkIGNhbiB0cmFuc2Zl
ciBtb3JlIHRoYW4gb25lIGNsdXN0ZXIuIExldA0KPj4+Pj4+Pj4+Pj4gYmFja3VwX2Nvd193aXRo
X2JvdW5jZV9idWZmZXIgYmVoYXZlIHNpbWlsYXJseS4gSXQgcmVkdWNlcyB0aGUgbnVtYmVyDQo+
Pj4+Pj4+Pj4+PiBvZiBJTyByZXF1ZXN0cywgc2luY2UgdGhlcmUgaXMgbm8gbmVlZCB0byBjb3B5
IGNsdXN0ZXIgYnkgY2x1c3Rlci4NCj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+PiBMb2dpYyBhcm91
bmQgYm91bmNlX2J1ZmZlciBhbGxvY2F0aW9uIGNoYW5nZWQ6IHdlIGNhbid0IGp1c3QgYWxsb2Nh
dGUNCj4+Pj4+Pj4+Pj4+IG9uZS1jbHVzdGVyLXNpemVkIGJ1ZmZlciB0byBzaGFyZSBmb3IgYWxs
IGl0ZXJhdGlvbnMuIFdlIGNhbid0IGFsc28NCj4+Pj4+Pj4+Pj4+IGFsbG9jYXRlIGJ1ZmZlciBv
ZiBmdWxsLXJlcXVlc3QgbGVuZ3RoIGl0IG1heSBiZSB0b28gbGFyZ2UsIHNvDQo+Pj4+Pj4+Pj4+
PiBCQUNLVVBfTUFYX0JPVU5DRV9CVUZGRVIgaXMgaW50cm9kdWNlZC4gQW5kIGZpbmFsbHksIGFs
bG9jYXRpb24gbG9naWMNCj4+Pj4+Pj4+Pj4+IGlzIHRvIGFsbG9jYXRlIGEgYnVmZmVyIHN1ZmZp
Y2llbnQgdG8gaGFuZGxlIGFsbCByZW1haW5pbmcgaXRlcmF0aW9ucw0KPj4+Pj4+Pj4+Pj4gYXQg
dGhlIHBvaW50IHdoZXJlIHdlIG5lZWQgdGhlIGJ1ZmZlciBmb3IgdGhlIGZpcnN0IHRpbWUuDQo+
Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+Pj4gQm9udXM6IGdldCByaWQgb2YgcG9pbnRlci10by1wb2lu
dGVyLg0KPj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+Pj4+Pj4+Pj4+
IC0tLQ0KPj4+Pj4+Pj4+Pj4gICAgwqDCoCBibG9jay9iYWNrdXAuYyB8IDY1ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4+Pj4+Pj4+PiAgICDC
oMKgIDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4+
Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvYmxvY2svYmFja3VwLmMgYi9ibG9j
ay9iYWNrdXAuYw0KPj4+Pj4+Pj4+Pj4gaW5kZXggZDQ4MmQ5MzQ1OC4uNjVmNzIxMmM4NSAxMDA2
NDQNCj4+Pj4+Pj4+Pj4+IC0tLSBhL2Jsb2NrL2JhY2t1cC5jDQo+Pj4+Pj4+Pj4+PiArKysgYi9i
bG9jay9iYWNrdXAuYw0KPj4+Pj4+Pj4+Pj4gQEAgLTI3LDYgKzI3LDcgQEANCj4+Pj4+Pj4+Pj4+
ICAgIMKgwqAgI2luY2x1ZGUgInFlbXUvZXJyb3ItcmVwb3J0LmgiDQo+Pj4+Pj4+Pj4+PiAgICDC
oMKgICNkZWZpbmUgQkFDS1VQX0NMVVNURVJfU0laRV9ERUZBVUxUICgxIDw8IDE2KQ0KPj4+Pj4+
Pj4+Pj4gKyNkZWZpbmUgQkFDS1VQX01BWF9CT1VOQ0VfQlVGRkVSICg2NCAqIDEwMjQgKiAxMDI0
KQ0KPj4+Pj4+Pj4+Pj4gICAgwqDCoCB0eXBlZGVmIHN0cnVjdCBDb3dSZXF1ZXN0IHsNCj4+Pj4+
Pj4+Pj4+ICAgIMKgwqDCoMKgwqDCoCBpbnQ2NF90IHN0YXJ0X2J5dGU7DQo+Pj4+Pj4+Pj4+PiBA
QCAtOTgsNDQgKzk5LDU1IEBAIHN0YXRpYyB2b2lkIGNvd19yZXF1ZXN0X2VuZChDb3dSZXF1ZXN0
ICpyZXEpDQo+Pj4+Pj4+Pj4+PiAgICDCoMKgwqDCoMKgwqAgcWVtdV9jb19xdWV1ZV9yZXN0YXJ0
X2FsbCgmcmVxLT53YWl0X3F1ZXVlKTsNCj4+Pj4+Pj4+Pj4+ICAgIMKgwqAgfQ0KPj4+Pj4+Pj4+
Pj4gLS8qIENvcHkgcmFuZ2UgdG8gdGFyZ2V0IHdpdGggYSBib3VuY2UgYnVmZmVyIGFuZCByZXR1
cm4gdGhlIGJ5dGVzIGNvcGllZC4gSWYNCj4+Pj4+Pj4+Pj4+IC0gKiBlcnJvciBvY2N1cnJlZCwg
cmV0dXJuIGEgbmVnYXRpdmUgZXJyb3IgbnVtYmVyICovDQo+Pj4+Pj4+Pj4+PiArLyoNCj4+Pj4+
Pj4+Pj4+ICsgKiBDb3B5IHJhbmdlIHRvIHRhcmdldCB3aXRoIGEgYm91bmNlIGJ1ZmZlciBhbmQg
cmV0dXJuIHRoZSBieXRlcyBjb3BpZWQuIElmDQo+Pj4+Pj4+Pj4+PiArICogZXJyb3Igb2NjdXJy
ZWQsIHJldHVybiBhIG5lZ2F0aXZlIGVycm9yIG51bWJlcg0KPj4+Pj4+Pj4+Pj4gKyAqDQo+Pj4+
Pj4+Pj4+PiArICogQGJvdW5jZV9idWZmZXIgaXMgYXNzdW1lZCB0byBlbm91Z2ggdG8gc3RvcmUN
Cj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4gcy90by90byBiZS8NCj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+
Pj4+ICsgKiBNSU4oQkFDS1VQX01BWF9CT1VOQ0VfQlVGRkVSLCBAZW5kIC0gQHN0YXJ0KSBieXRl
cw0KPj4+Pj4+Pj4+Pj4gKyAqLw0KPj4+Pj4+Pj4+Pj4gICAgwqDCoCBzdGF0aWMgaW50IGNvcm91
dGluZV9mbiBiYWNrdXBfY293X3dpdGhfYm91bmNlX2J1ZmZlcihCYWNrdXBCbG9ja0pvYiAqam9i
LA0KPj4+Pj4+Pj4+Pj4gICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpbnQ2NF90IHN0YXJ0LA0KPj4+Pj4+Pj4+Pj4gICAgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQ2NF90IGVu
ZCwNCj4+Pj4+Pj4+Pj4+ICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYm9vbCBpc193cml0ZV9ub3RpZmllciwNCj4+Pj4+Pj4+Pj4+ICAg
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Ym9vbCAqZXJyb3JfaXNfcmVhZCwNCj4+Pj4+Pj4+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZvaWQgKipib3VuY2VfYnVmZmVyKQ0KPj4+Pj4+
Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dm9pZCAqYm91bmNlX2J1ZmZlcikNCj4+Pj4+Pj4+Pj4+ICAgIMKgwqAgew0KPj4+Pj4+Pj4+Pj4g
ICAgwqDCoMKgwqDCoMKgIGludCByZXQ7DQo+Pj4+Pj4+Pj4+PiAgICDCoMKgwqDCoMKgwqAgQmxv
Y2tCYWNrZW5kICpibGsgPSBqb2ItPmNvbW1vbi5ibGs7DQo+Pj4+Pj4+Pj4+PiAtwqDCoMKgIGlu
dCBuYnl0ZXM7DQo+Pj4+Pj4+Pj4+PiArwqDCoMKgIGludCBuYnl0ZXMsIHJlbWFpbmluZ19ieXRl
czsNCj4+Pj4+Pj4+Pj4+ICAgIMKgwqDCoMKgwqDCoCBpbnQgcmVhZF9mbGFncyA9IGlzX3dyaXRl
X25vdGlmaWVyID8gQkRSVl9SRVFfTk9fU0VSSUFMSVNJTkcgOiAwOw0KPj4+Pj4+Pj4+Pj4gICAg
wqDCoMKgwqDCoMKgIGFzc2VydChRRU1VX0lTX0FMSUdORUQoc3RhcnQsIGpvYi0+Y2x1c3Rlcl9z
aXplKSk7DQo+Pj4+Pj4+Pj4+PiAtwqDCoMKgIGJkcnZfcmVzZXRfZGlydHlfYml0bWFwKGpvYi0+
Y29weV9iaXRtYXAsIHN0YXJ0LCBqb2ItPmNsdXN0ZXJfc2l6ZSk7DQo+Pj4+Pj4+Pj4+PiAtwqDC
oMKgIG5ieXRlcyA9IE1JTihqb2ItPmNsdXN0ZXJfc2l6ZSwgam9iLT5sZW4gLSBzdGFydCk7DQo+
Pj4+Pj4+Pj4+PiAtwqDCoMKgIGlmICghKmJvdW5jZV9idWZmZXIpIHsNCj4+Pj4+Pj4+Pj4+IC3C
oMKgwqDCoMKgwqDCoCAqYm91bmNlX2J1ZmZlciA9IGJsa19ibG9ja2FsaWduKGJsaywgam9iLT5j
bHVzdGVyX3NpemUpOw0KPj4+Pj4+Pj4+Pj4gLcKgwqDCoCB9DQo+Pj4+Pj4+Pj4+PiArwqDCoMKg
IGJkcnZfcmVzZXRfZGlydHlfYml0bWFwKGpvYi0+Y29weV9iaXRtYXAsIHN0YXJ0LCBlbmQgLSBz
dGFydCk7DQo+Pj4+Pj4+Pj4+PiArwqDCoMKgIG5ieXRlcyA9IE1JTihlbmQgLSBzdGFydCwgam9i
LT5sZW4gLSBzdGFydCk7DQo+Pj4+Pj4+Pj4+PiAtwqDCoMKgIHJldCA9IGJsa19jb19wcmVhZChi
bGssIHN0YXJ0LCBuYnl0ZXMsICpib3VuY2VfYnVmZmVyLCByZWFkX2ZsYWdzKTsNCj4+Pj4+Pj4+
Pj4+IC3CoMKgwqAgaWYgKHJldCA8IDApIHsNCj4+Pj4+Pj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCB0
cmFjZV9iYWNrdXBfZG9fY293X3JlYWRfZmFpbChqb2IsIHN0YXJ0LCByZXQpOw0KPj4+Pj4+Pj4+
Pj4gLcKgwqDCoMKgwqDCoMKgIGlmIChlcnJvcl9pc19yZWFkKSB7DQo+Pj4+Pj4+Pj4+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqZXJyb3JfaXNfcmVhZCA9IHRydWU7DQo+Pj4+Pj4+Pj4+PiAr
DQo+Pj4+Pj4+Pj4+PiArwqDCoMKgIHJlbWFpbmluZ19ieXRlcyA9IG5ieXRlczsNCj4+Pj4+Pj4+
Pj4+ICvCoMKgwqAgd2hpbGUgKHJlbWFpbmluZ19ieXRlcykgew0KPj4+Pj4+Pj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIGludCBjaHVuayA9IE1JTihCQUNLVVBfTUFYX0JPVU5DRV9CVUZGRVIsIHJlbWFp
bmluZ19ieXRlcyk7DQo+Pj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAg
cmV0ID0gYmxrX2NvX3ByZWFkKGJsaywgc3RhcnQsIGNodW5rLCBib3VuY2VfYnVmZmVyLCByZWFk
X2ZsYWdzKTsNCj4+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAocmV0IDwgMCkgew0KPj4+
Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHJhY2VfYmFja3VwX2RvX2Nvd19yZWFk
X2ZhaWwoam9iLCBzdGFydCwgcmV0KTsNCj4+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlmIChlcnJvcl9pc19yZWFkKSB7DQo+Pj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICplcnJvcl9pc19yZWFkID0gdHJ1ZTsNCj4+Pj4+Pj4+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIH0NCj4+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdv
dG8gZmFpbDsNCj4+Pj4+Pj4+Pj4+ICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+Pj4+Pj4+
Pj4+IC3CoMKgwqDCoMKgwqDCoCBnb3RvIGZhaWw7DQo+Pj4+Pj4+Pj4+PiAtwqDCoMKgIH0NCj4+
Pj4+Pj4+Pj4+IC3CoMKgwqAgcmV0ID0gYmxrX2NvX3B3cml0ZShqb2ItPnRhcmdldCwgc3RhcnQs
IG5ieXRlcywgKmJvdW5jZV9idWZmZXIsDQo+Pj4+Pj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBqb2ItPndyaXRlX2ZsYWdzKTsNCj4+Pj4+Pj4+
Pj4+IC3CoMKgwqAgaWYgKHJldCA8IDApIHsNCj4+Pj4+Pj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCB0
cmFjZV9iYWNrdXBfZG9fY293X3dyaXRlX2ZhaWwoam9iLCBzdGFydCwgcmV0KTsNCj4+Pj4+Pj4+
Pj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAoZXJyb3JfaXNfcmVhZCkgew0KPj4+Pj4+Pj4+Pj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKmVycm9yX2lzX3JlYWQgPSBmYWxzZTsNCj4+Pj4+Pj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoCByZXQgPSBibGtfY29fcHdyaXRlKGpvYi0+dGFyZ2V0LCBzdGFydCwg
Y2h1bmssIGJvdW5jZV9idWZmZXIsDQo+Pj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGpvYi0+d3JpdGVfZmxhZ3MpOw0KPj4+
Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChyZXQgPCAwKSB7DQo+Pj4+Pj4+Pj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB0cmFjZV9iYWNrdXBfZG9fY293X3dyaXRlX2ZhaWwoam9iLCBz
dGFydCwgcmV0KTsNCj4+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChlcnJv
cl9pc19yZWFkKSB7DQo+Pj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICplcnJvcl9pc19yZWFkID0gZmFsc2U7DQo+Pj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB9DQo+Pj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGZhaWw7DQo+
Pj4+Pj4+Pj4+PiAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+Pj4+Pj4+Pj4+PiAtwqDCoMKg
wqDCoMKgwqAgZ290byBmYWlsOw0KPj4+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+Pj4gK8KgwqDCoMKg
wqDCoMKgIHN0YXJ0ICs9IGNodW5rOw0KPj4+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJlbWFp
bmluZ19ieXRlcyAtPSBjaHVuazsNCj4+Pj4+Pj4+Pj4+ICAgIMKgwqDCoMKgwqDCoCB9DQo+Pj4+
Pj4+Pj4+PiAgICDCoMKgwqDCoMKgwqAgcmV0dXJuIG5ieXRlczsNCj4+Pj4+Pj4+Pj4+IEBAIC0z
MDEsOSArMzEzLDE0IEBAIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIGJhY2t1cF9kb19jb3coQmFj
a3VwQmxvY2tKb2IgKmpvYiwNCj4+Pj4+Pj4+Pj4+ICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfQ0KPj4+Pj4+Pj4+Pj4gICAgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4+Pj4+Pj4+
Pj4gICAgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFqb2ItPnVzZV9jb3B5X3JhbmdlKSB7DQo+
Pj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWJvdW5jZV9idWZmZXIpIHsN
Cj4+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZV90IGxlbiA9
IE1JTihCQUNLVVBfTUFYX0JPVU5DRV9CVUZGRVIsDQo+Pj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBNQVgo
ZGlydHlfZW5kIC0gc3RhcnQsIGVuZCAtIGRpcnR5X2VuZCkpOw0KPj4+Pj4+Pj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBib3VuY2VfYnVmZmVyID0gYmxrX3RyeV9ibG9ja2Fs
aWduKGpvYi0+Y29tbW9uLmJsaywgbGVuKTsNCj4+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIH0NCj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4gSWYgeW91IHVzZSBfdHJ5XywgeW91IHNo
b3VsZCBwcm9iYWJseSBhbHNvIGNoZWNrIHdoZXRoZXIgaXQgc3VjY2VlZGVkLg0KPj4+Pj4+Pj4+
DQo+Pj4+Pj4+Pj4gT29wcywgeW91IGFyZSByaWdodCwgb2YgY291cnNlLg0KPj4+Pj4+Pj4+DQo+
Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+IEFueXdheSwgSSB3b25kZXIgd2hldGhlciBpdOKAmWQgYmUg
YmV0dGVyIHRvIGp1c3QgYWxsb2NhdGUgdGhpcyBidWZmZXINCj4+Pj4+Pj4+Pj4gb25jZSBwZXIg
am9iICh0aGUgZmlyc3QgdGltZSB3ZSBnZXQgaGVyZSwgcHJvYmFibHkpIHRvIGJlIG9mIHNpemUN
Cj4+Pj4+Pj4+Pj4gQkFDS1VQX01BWF9CT1VOQ0VfQlVGRkVSIGFuZCBwdXQgaXQgaW50byBCYWNr
dXBCbG9ja0pvYi7CoCAoQW5kIG1heWJlIGFkZA0KPj4+Pj4+Pj4+PiBhIGJ1Zi1zaXplIHBhcmFt
ZXRlciBzaW1pbGFyIHRvIHdoYXQgdGhlIG1pcnJvciBqb2JzIGhhdmUuKQ0KPj4+Pj4+Pj4+Pg0K
Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gT25jZSBwZXIgam9iIHdpbGwgbm90IHdvcmssIGFzIHdlIG1h
eSBoYXZlIHNldmVyYWwgZ3Vlc3Qgd3JpdGVzIGluIHBhcmFsbGVsIGFuZCB0aGVyZWZvcmUNCj4+
Pj4+Pj4+PiBzZXZlcmFsIHBhcmFsbGVsIGNvcHktYmVmb3JlLXdyaXRlIG9wZXJhdGlvbnMuDQo+
Pj4+Pj4+Pg0KPj4+Pj4+Pj4gSG0uwqAgSeKAmW0gbm90IHF1aXRlIGhhcHB5IHdpdGggdGhhdCBi
ZWNhdXNlIGlmIHRoZSBndWVzdCBqdXN0IGlzc3VlcyBtYW55DQo+Pj4+Pj4+PiBsYXJnZSBkaXNj
YXJkcyBpbiBwYXJhbGxlbCwgdGhpcyBtZWFucyB0aGF0IHFlbXUgd2lsbCBhbGxvY2F0ZSBhIGxh
cmdlDQo+Pj4+Pj4+PiBhbW91bnQgb2YgbWVtb3J5Lg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IEl0IHdv
dWxkIGJlIG5pY2UgaWYgdGhlcmUgd2FzIGEgc2ltcGxlIHdheSB0byBrZWVwIHRyYWNrIG9mIHRo
ZSB0b3RhbA0KPj4+Pj4+Pj4gbWVtb3J5IHVzYWdlIGFuZCBsZXQgcmVxdWVzdHMgeWllbGQgaWYg
dGhleSB3b3VsZCBleGNlZWQgaXQuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IEFncmVlLCBpdCBzaG91bGQg
YmUgZml4ZWQgYW55d2F5Lg0KPj4+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBCdXQgc3Rp
bGwuLg0KPj4+Pj4+DQo+Pj4+Pj4gU3luY2hyb25vdXMgbWlycm9yIGFsbG9jYXRlcyBmdWxsLXJl
cXVlc3QgYnVmZmVycyBvbiBndWVzdCB3cml0ZS4gSXMgaXQgY29ycmVjdD8NCj4+Pj4+Pg0KPj4+
Pj4+IElmIHdlIGFzc3VtZSB0aGF0IGl0IGlzIGNvcnJlY3QgdG8gZG91YmxlIG1lbW9yeSB1c2Fn
ZSBvZiBndWVzdCBvcGVyYXRpb25zLCB0aGFuIGZvciBiYWNrdXANCj4+Pj4+PiB0aGUgcHJvYmxl
bSBpcyBvbmx5IGluIHdyaXRlX3plcm8gYW5kIGRpc2NhcmQgd2hlcmUgZ3Vlc3QtYXNzdW1lZCBt
ZW1vcnkgdXNhZ2Ugc2hvdWxkIGJlIHplcm8uDQo+Pj4+Pg0KPj4+Pj4gV2VsbCwgYnV0IHRoYXQg
aXMgdGhlIHByb2JsZW0uICBJIGRpZG7igJl0IHNheSBhbnl0aGluZyBpbiB2MiwgYmVjYXVzZSBJ
DQo+Pj4+PiBvbmx5IHRob3VnaHQgb2Ygbm9ybWFsIHdyaXRlcyBhbmQgSSBmb3VuZCBpdCBmaW5l
IHRvIGRvdWJsZSB0aGUgbWVtb3J5DQo+Pj4+PiB1c2FnZSB0aGVyZSAoYSBndWVzdCB3b27igJl0
IGlzc3VlIGh1Z2Ugd3JpdGUgcmVxdWVzdHMgaW4gcGFyYWxsZWwpLiAgQnV0DQo+Pj4+PiBkaXNj
YXJkL3dyaXRlLXplcm9lcyBhcmUgYSBkaWZmZXJlbnQgbWF0dGVyLg0KPj4+Pj4NCj4+Pj4+PiBB
bmQgaWYgd2Ugc2hvdWxkIGRpc3Rpbmd1aXNoIHdyaXRlcyBmcm9tIHdyaXRlX3plcm9lcyBhbmQg
ZGlzY2FyZCwgaXQncyBiZXR0ZXIgdG8gcG9zdHBvbmUgdGhpcw0KPj4+Pj4+IGltcHJvdmVtZW50
IHRvIGJlIGFmdGVyIGJhY2t1cC10b3AgZmlsdGVyIG1lcmdlZC4NCj4+Pj4+DQo+Pj4+PiBCdXQg
ZG8geW91IG5lZWQgdG8gZGlzdGluZ3Vpc2ggaXQ/ICBXaHkgbm90IGp1c3Qga2VlcCB0cmFjayBv
ZiBtZW1vcnkNCj4+Pj4+IHVzYWdlIGFuZCBwdXQgdGhlIGN1cnJlbnQgSS9PIGNvcm91dGluZSB0
byBzbGVlcCBpbiBhIENvUXVldWUgb3INCj4+Pj4+IHNvbWV0aGluZywgYW5kIHdha2UgdGhhdCB1
cCBhdCB0aGUgZW5kIG9mIGJhY2t1cF9kb19jb3coKT8NCj4+Pj4+DQo+Pj4+DQo+Pj4+IDEuIEJl
Y2F1c2UgaWYgd2UgX2Nhbl8gYWxsb3cgZG91Ymxpbmcgb2YgbWVtb3J5LCBpdCdzIG1vcmUgZWZm
ZWN0aXZlIHRvIG5vdCByZXN0cmljdCBhbGxvY2F0aW9ucyBvbg0KPj4+PiBndWVzdCB3cml0ZXMu
IEl0J3MganVzdCBzZWVtcyB0byBiZSBtb3JlIGVmZmVjdGl2ZSB0ZWNobmlxdWUuDQo+Pj4NCj4+
PiBCdXQgdGhlIHByb2JsZW0gd2l0aCBiYWNrdXAgYW5kIHplcm8gd3JpdGVzL2Rpc2NhcmRzIGlz
IHRoYXQgdGhlIG1lbW9yeQ0KPj4+IGlzIG5vdCBkb3VibGVkLiAgVGhlIHJlcXVlc3QgZG9lc27i
gJl0IG5lZWQgYW55IG1lbW9yeSwgYnV0IHRoZSBDQlcNCj4+PiBvcGVyYXRpb24gZG9lcywgYW5k
IG1heWJlIGxvdHMgb2YgaXQuDQo+Pj4NCj4+PiBTbyB0aGUgZ3Vlc3QgbWF5IGlzc3VlIG1hbnkg
emVybyB3cml0ZXMvZGlzY2FyZHMgaW4gcGFyYWxsZWwgYW5kIHRodXMNCj4+PiBleGhhdXN0IG1l
bW9yeSBvbiB0aGUgaG9zdC4NCj4+DQo+PiBTbyB0aGlzIGlzIHRoZSByZWFzb24gdG8gc2VwYXJh
dGUgd3JpdGVzIGZyb20gd3JpdGUtemVyb3MvZGlzY3JhZHMuIFNvIGF0IGxlYXN0IHdyaXRlIHdp
bGwgYmUgaGFwcHkuIEFuZCBJDQo+PiB0aGluayB0aGF0IHdyaXRlIGlzIG1vcmUgb2Z0ZW4gcmVx
dWVzdCB0aGFuIHdyaXRlLXplcm8vZGlzY2FyZA0KPiANCj4gQnV0IHRoYXQgbWFrZXMgaXQgY29t
cGxpY2F0ZWQgZm9yIG5vIHByYWN0aWNhbCBnYWluIHdoYXRzb2V2ZXIuDQo+IA0KPj4+DQo+Pj4+
IDIuIEFueXdheSwgSSdkIGFsbG93IHNvbWUgYWx3YXlzLWF2YWlsYWJsZSBzaXplIHRvIGFsbG9j
YXRlIC0gbGV0IGl0IGJlIG9uZSBjbHVzdGVyLCB3aGljaCB3aWxsIGNvcnJlc3BvbmQNCj4+Pj4g
dG8gY3VycmVudCBiZWhhdmlvciBhbmQgcHJldmVudCBndWVzdCBpbyBoYW5nIGluIHdvcnN0IGNh
c2UuDQo+Pj4NCj4+PiBUaGUgZ3Vlc3Qgd291bGQgb25seSBoYW5nIGlmIGl0IHdlIGhhdmUgdG8g
Y29weSBtb3JlIHRoYW4gZS5nLiA2NCBNQiBhdA0KPj4+IGEgdGltZS4gIEF0IHdoaWNoIHBvaW50
IEkgdGhpbmsgaXTigJlzIG5vdCB1bnJlYXNvbmFibGUgdG8gc2VxdWVudGlhbGl6ZQ0KPj4+IHJl
cXVlc3RzLg0KPiANCj4gQmVjYXVzZSBvZiB0aGlzLiAgSG93IGlzIGl0IGJhZCB0byBzdGFydCBz
ZXF1ZW50aWFsaXppbmcgd3JpdGVzIHdoZW4gdGhlDQo+IGRhdGEgZXhjZWVkcyA2NCBNQj8NCj4g
DQoNClNvIHlvdSB3YW50IHRvdGFsIG1lbW9yeSBsaW1pdCBvZiA2NCBNQj8gKHdpdGggcG9zc2li
bGUgcGFyYW1ldGVyIGxpa2UgaW4gbWlycm9yKQ0KDQpBbmQgYWxsb2NhdGlvbiBhbGdvcml0aG0g
dG8gY29weSBjb3VudCBieXRlczoNCg0KaWYgZnJlZV9tZW0gPj0gY291bnQ6IGFsbG9jYXRlIGNv
dW50IGJ5dGVzDQplbHNlIGlmIGZyZWVfbWVtID49IGNsdXN0ZXI6IGFsbG9jYXRlIGNsdXN0ZXIg
YW5kIGNvcHkgaW4gYSBsb29wDQplbHNlIHdhaXQgaW4gY28tcXVldWUgdW50aWwgc29tZSBtZW1v
cnkgYXZhaWxhYmxlIGFuZCByZXRyeQ0KDQpJcyBpdCBPSyBmb3IgeW91Pw0KDQoNCi0tIA0KQmVz
dCByZWdhcmRzLA0KVmxhZGltaXINCg==

