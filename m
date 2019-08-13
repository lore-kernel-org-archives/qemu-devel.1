Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD499C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:40:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B70920844
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SLgKF59F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B70920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxXyJ-0003g7-Rt
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 10:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41296)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxXxq-0002zj-Co
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:39:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxXxo-0003i8-NT
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:39:54 -0400
Received: from mail-vi1eur04on0712.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::712]:41957
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxXxn-0003hY-St; Tue, 13 Aug 2019 10:39:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtrkVn1tzc+r4s4Fk1fK82fX8BPfvlKorsVG67btZmDvT8hI7bTJDSogaKOmojsF7cmju4XOEfH3oCA3NT3d7gvVpXxM4mLfxDK72B4DBQdvJF+1lCeOa6Fy1VKxIgQ6abAnvoQb5s822JKP9be7jSXu6yrXA3RpZwPtpKioxYRgOVZq+0rk1pQjmXNFWNxL7VmJTDo3oepKfuk3gym2nQkAOsSq4a6A2R8Vqghtq3RkCCkMvjsUiWXz1TLV43Xj3l7OnwsMf0wIetspl+ztiE+roqBkEFHWLG6mNGGRyyDgHriG1bBA1BmQGp8v2TVhFaS2qj12OkS72jrrP+8F0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x16RebBvqEihZEGqHHLh2sqZai0FOvCeE5Ib/6TSbkE=;
 b=SvVE8pKsSG6jPkvMusbJj2JICJ2+c2J83ocrFoMvqdlboUwlmpm0i0aUieWTN0a9vJCOMGXgpRMw6J4tZpynoghWfnAFKJ6WSoT4TOv5lLrXwmb1hcV/8MnBIAZc84MMuuvM71RSm1YN0tvv/aSciXyS2Gds5qDO1kiSlqH6DmdaWwDy8gj3G53QEgbw0hPINuJncNHIgg/evSc88qkwQnPQUyIarE17k6xlP6aCSE1z54GveIarAD5y976ZvC3QmN+fc/TBKVOrMYYvaOSWmH6KoIUCL4tn53Z0o+vd0SVqhahs4uj7/QSt0Fy9AXqzTyzAbUhtqSip+X9tzsfikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x16RebBvqEihZEGqHHLh2sqZai0FOvCeE5Ib/6TSbkE=;
 b=SLgKF59F7PLJtA8UVEKhYkaVH8tJPaqh/LRO8lEwgwLs9bIPCk0R1rnoQpxZYvKGUOlNzK+fvMe+y4/w5rpKh82sb8AAaym79NpIZ5VW6vBebVskxu/dlZB6+h8svJTvizO62/pNwX7ZeZ2xAmzPY0BL37YjkJj48XPzdT5wIMc=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4185.eurprd08.prod.outlook.com (20.179.10.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.22; Tue, 13 Aug 2019 14:39:49 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 14:39:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 6/7] block/backup: teach backup_cow_with_bounce_buffer
 to copy more at once
Thread-Index: AQHVT7JML2nk8Wsax0eUZCBvWTBktKb3oMEAgAAKYwCAAAavAIAABzYAgAFqYoCAAAKCAIAABJUA
Date: Tue, 13 Aug 2019 14:39:48 +0000
Message-ID: <cf9718b9-f36d-27f3-ad49-4f6fb1e1d7b3@virtuozzo.com>
References: <20190810193155.58637-1-vsementsov@virtuozzo.com>
 <20190810193155.58637-7-vsementsov@virtuozzo.com>
 <5102eac9-125b-0719-910f-4adb240732f1@redhat.com>
 <89c87c83-276a-7663-a239-57dbd9f91a30@virtuozzo.com>
 <ecff86a8-57d1-4c8a-d4b4-95524471d249@redhat.com>
 <e3fc5e07-33c6-1fe3-2042-35bdac0a03c3@virtuozzo.com>
 <4093762b-a1bc-d6b1-8358-4f9d1ab52557@virtuozzo.com>
 <e05af208-c7cb-31e6-bfab-62a44f5281e7@redhat.com>
In-Reply-To: <e05af208-c7cb-31e6-bfab-62a44f5281e7@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0133.eurprd05.prod.outlook.com
 (2603:10a6:7:28::20) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190813173946197
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b7fc088-7d57-4c82-9b5e-08d71ffc17ca
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4185; 
x-ms-traffictypediagnostic: DB8PR08MB4185:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB4185C31B0F1398B919F99840C1D20@DB8PR08MB4185.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39840400004)(136003)(366004)(396003)(376002)(52314003)(199004)(189003)(8676002)(6512007)(66066001)(81166006)(8936002)(110136005)(52116002)(186003)(54906003)(478600001)(316002)(6436002)(7736002)(71190400001)(66556008)(66476007)(64756008)(3846002)(36756003)(31686004)(66946007)(2906002)(5660300002)(6486002)(81156014)(14454004)(229853002)(6116002)(71200400001)(66446008)(2501003)(486006)(6246003)(446003)(86362001)(99286004)(2616005)(107886003)(11346002)(14444005)(26005)(256004)(31696002)(4326008)(102836004)(53546011)(6506007)(386003)(25786009)(53936002)(476003)(305945005)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4185;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AhvWtTiAHz/t/jNqLZwha5gh6813FmCd5cyNNKJ5oQynjgR5QVbUMJapCMz49L/3EzarOQggphfFapJyrrvwsJQ7a8qa5moWZwpwy1/8qFDNWeBfm371FU0OAQ+FlPQxx8qVQM1WYBeSGyBUJw1mD0pmycmbefmhGLSjTwLHzCygiqkgJbgvkJU4aiXO098dSbapMcmWa1LLpi2RZGzuHm9DuhSkgfW+lzsBZBkN9yIndxPQqS0Z4eJNU6+HuGUAWK9wfrXSwi0phNKowrgHdouU9QqViVGgdBaWkhxTOYsBOKbKwbMf1M/qkhVdrn4XJsnFvLz2aV69dhbZajnxKXB6YMc6lhka0jB7Yxf9WvoRPPy0tXcwLqPPdQKzchZvoK8/T4OR+fRm1n57iqDsrot6h2T9efhtQWX0GJDaILU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFCDDCB880A1A142BB1B4F748BF2CA88@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7fc088-7d57-4c82-9b5e-08d71ffc17ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 14:39:48.8368 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZtwID+J1zE+zvbs7pCuo+9ncmMM3GP0QHQZ+jliMUgUspqnmcsCp8/T1+W5LVpZy1xd0lnE07sI5bEgYmhL1Yx4AtPjmGUtWLOGn4q+cdG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4185
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::712
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

MTMuMDguMjAxOSAxNzoyMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMy4wOC4xOSAxNjoxNCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDEyLjA4LjIwMTkgMTk6Mzcs
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gMTIuMDguMjAxOSAxOTox
MSwgTWF4IFJlaXR6IHdyb3RlOg0KPj4+PiBPbiAxMi4wOC4xOSAxNzo0NywgVmxhZGltaXIgU2Vt
ZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4+IDEyLjA4LjIwMTkgMTg6MTAsIE1heCBSZWl0
eiB3cm90ZToNCj4+Pj4+PiBPbiAxMC4wOC4xOSAyMTozMSwgVmxhZGltaXIgU2VtZW50c292LU9n
aWV2c2tpeSB3cm90ZToNCj4+Pj4+Pj4gYmFja3VwX2Nvd193aXRoX29mZmxvYWQgY2FuIHRyYW5z
ZmVyIG1vcmUgdGhhbiBvbmUgY2x1c3Rlci4gTGV0DQo+Pj4+Pj4+IGJhY2t1cF9jb3dfd2l0aF9i
b3VuY2VfYnVmZmVyIGJlaGF2ZSBzaW1pbGFybHkuIEl0IHJlZHVjZXMgdGhlIG51bWJlcg0KPj4+
Pj4+PiBvZiBJTyByZXF1ZXN0cywgc2luY2UgdGhlcmUgaXMgbm8gbmVlZCB0byBjb3B5IGNsdXN0
ZXIgYnkgY2x1c3Rlci4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gTG9naWMgYXJvdW5kIGJvdW5jZV9idWZm
ZXIgYWxsb2NhdGlvbiBjaGFuZ2VkOiB3ZSBjYW4ndCBqdXN0IGFsbG9jYXRlDQo+Pj4+Pj4+IG9u
ZS1jbHVzdGVyLXNpemVkIGJ1ZmZlciB0byBzaGFyZSBmb3IgYWxsIGl0ZXJhdGlvbnMuIFdlIGNh
bid0IGFsc28NCj4+Pj4+Pj4gYWxsb2NhdGUgYnVmZmVyIG9mIGZ1bGwtcmVxdWVzdCBsZW5ndGgg
aXQgbWF5IGJlIHRvbyBsYXJnZSwgc28NCj4+Pj4+Pj4gQkFDS1VQX01BWF9CT1VOQ0VfQlVGRkVS
IGlzIGludHJvZHVjZWQuIEFuZCBmaW5hbGx5LCBhbGxvY2F0aW9uIGxvZ2ljDQo+Pj4+Pj4+IGlz
IHRvIGFsbG9jYXRlIGEgYnVmZmVyIHN1ZmZpY2llbnQgdG8gaGFuZGxlIGFsbCByZW1haW5pbmcg
aXRlcmF0aW9ucw0KPj4+Pj4+PiBhdCB0aGUgcG9pbnQgd2hlcmUgd2UgbmVlZCB0aGUgYnVmZmVy
IGZvciB0aGUgZmlyc3QgdGltZS4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gQm9udXM6IGdldCByaWQgb2Yg
cG9pbnRlci10by1wb2ludGVyLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBWbGFk
aW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+Pj4+
Pj4+IC0tLQ0KPj4+Pj4+PiAgwqDCoCBibG9jay9iYWNrdXAuYyB8IDY1ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4+Pj4+ICDCoMKgIDEgZmls
ZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4+Pj4+Pj4NCj4+
Pj4+Pj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2JhY2t1cC5jIGIvYmxvY2svYmFja3VwLmMNCj4+Pj4+
Pj4gaW5kZXggZDQ4MmQ5MzQ1OC4uNjVmNzIxMmM4NSAxMDA2NDQNCj4+Pj4+Pj4gLS0tIGEvYmxv
Y2svYmFja3VwLmMNCj4+Pj4+Pj4gKysrIGIvYmxvY2svYmFja3VwLmMNCj4+Pj4+Pj4gQEAgLTI3
LDYgKzI3LDcgQEANCj4+Pj4+Pj4gIMKgwqAgI2luY2x1ZGUgInFlbXUvZXJyb3ItcmVwb3J0Lmgi
DQo+Pj4+Pj4+ICDCoMKgICNkZWZpbmUgQkFDS1VQX0NMVVNURVJfU0laRV9ERUZBVUxUICgxIDw8
IDE2KQ0KPj4+Pj4+PiArI2RlZmluZSBCQUNLVVBfTUFYX0JPVU5DRV9CVUZGRVIgKDY0ICogMTAy
NCAqIDEwMjQpDQo+Pj4+Pj4+ICDCoMKgIHR5cGVkZWYgc3RydWN0IENvd1JlcXVlc3Qgew0KPj4+
Pj4+PiAgwqDCoMKgwqDCoMKgIGludDY0X3Qgc3RhcnRfYnl0ZTsNCj4+Pj4+Pj4gQEAgLTk4LDQ0
ICs5OSw1NSBAQCBzdGF0aWMgdm9pZCBjb3dfcmVxdWVzdF9lbmQoQ293UmVxdWVzdCAqcmVxKQ0K
Pj4+Pj4+PiAgwqDCoMKgwqDCoMKgIHFlbXVfY29fcXVldWVfcmVzdGFydF9hbGwoJnJlcS0+d2Fp
dF9xdWV1ZSk7DQo+Pj4+Pj4+ICDCoMKgIH0NCj4+Pj4+Pj4gLS8qIENvcHkgcmFuZ2UgdG8gdGFy
Z2V0IHdpdGggYSBib3VuY2UgYnVmZmVyIGFuZCByZXR1cm4gdGhlIGJ5dGVzIGNvcGllZC4gSWYN
Cj4+Pj4+Pj4gLSAqIGVycm9yIG9jY3VycmVkLCByZXR1cm4gYSBuZWdhdGl2ZSBlcnJvciBudW1i
ZXIgKi8NCj4+Pj4+Pj4gKy8qDQo+Pj4+Pj4+ICsgKiBDb3B5IHJhbmdlIHRvIHRhcmdldCB3aXRo
IGEgYm91bmNlIGJ1ZmZlciBhbmQgcmV0dXJuIHRoZSBieXRlcyBjb3BpZWQuIElmDQo+Pj4+Pj4+
ICsgKiBlcnJvciBvY2N1cnJlZCwgcmV0dXJuIGEgbmVnYXRpdmUgZXJyb3IgbnVtYmVyDQo+Pj4+
Pj4+ICsgKg0KPj4+Pj4+PiArICogQGJvdW5jZV9idWZmZXIgaXMgYXNzdW1lZCB0byBlbm91Z2gg
dG8gc3RvcmUNCj4+Pj4+Pg0KPj4+Pj4+IHMvdG8vdG8gYmUvDQo+Pj4+Pj4NCj4+Pj4+Pj4gKyAq
IE1JTihCQUNLVVBfTUFYX0JPVU5DRV9CVUZGRVIsIEBlbmQgLSBAc3RhcnQpIGJ5dGVzDQo+Pj4+
Pj4+ICsgKi8NCj4+Pj4+Pj4gIMKgwqAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4gYmFja3VwX2Nv
d193aXRoX2JvdW5jZV9idWZmZXIoQmFja3VwQmxvY2tKb2IgKmpvYiwNCj4+Pj4+Pj4gIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50NjRf
dCBzdGFydCwNCj4+Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaW50NjRfdCBlbmQsDQo+Pj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJvb2wgaXNfd3JpdGVfbm90
aWZpZXIsDQo+Pj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGJvb2wgKmVycm9yX2lzX3JlYWQsDQo+Pj4+Pj4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZvaWQgKipib3VuY2VfYnVm
ZmVyKQ0KPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB2b2lkICpib3VuY2VfYnVmZmVyKQ0KPj4+Pj4+PiAgwqDCoCB7DQo+Pj4+Pj4+ICDC
oMKgwqDCoMKgwqAgaW50IHJldDsNCj4+Pj4+Pj4gIMKgwqDCoMKgwqDCoCBCbG9ja0JhY2tlbmQg
KmJsayA9IGpvYi0+Y29tbW9uLmJsazsNCj4+Pj4+Pj4gLcKgwqDCoCBpbnQgbmJ5dGVzOw0KPj4+
Pj4+PiArwqDCoMKgIGludCBuYnl0ZXMsIHJlbWFpbmluZ19ieXRlczsNCj4+Pj4+Pj4gIMKgwqDC
oMKgwqDCoCBpbnQgcmVhZF9mbGFncyA9IGlzX3dyaXRlX25vdGlmaWVyID8gQkRSVl9SRVFfTk9f
U0VSSUFMSVNJTkcgOiAwOw0KPj4+Pj4+PiAgwqDCoMKgwqDCoMKgIGFzc2VydChRRU1VX0lTX0FM
SUdORUQoc3RhcnQsIGpvYi0+Y2x1c3Rlcl9zaXplKSk7DQo+Pj4+Pj4+IC3CoMKgwqAgYmRydl9y
ZXNldF9kaXJ0eV9iaXRtYXAoam9iLT5jb3B5X2JpdG1hcCwgc3RhcnQsIGpvYi0+Y2x1c3Rlcl9z
aXplKTsNCj4+Pj4+Pj4gLcKgwqDCoCBuYnl0ZXMgPSBNSU4oam9iLT5jbHVzdGVyX3NpemUsIGpv
Yi0+bGVuIC0gc3RhcnQpOw0KPj4+Pj4+PiAtwqDCoMKgIGlmICghKmJvdW5jZV9idWZmZXIpIHsN
Cj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgICpib3VuY2VfYnVmZmVyID0gYmxrX2Jsb2NrYWxpZ24o
YmxrLCBqb2ItPmNsdXN0ZXJfc2l6ZSk7DQo+Pj4+Pj4+IC3CoMKgwqAgfQ0KPj4+Pj4+PiArwqDC
oMKgIGJkcnZfcmVzZXRfZGlydHlfYml0bWFwKGpvYi0+Y29weV9iaXRtYXAsIHN0YXJ0LCBlbmQg
LSBzdGFydCk7DQo+Pj4+Pj4+ICvCoMKgwqAgbmJ5dGVzID0gTUlOKGVuZCAtIHN0YXJ0LCBqb2It
PmxlbiAtIHN0YXJ0KTsNCj4+Pj4+Pj4gLcKgwqDCoCByZXQgPSBibGtfY29fcHJlYWQoYmxrLCBz
dGFydCwgbmJ5dGVzLCAqYm91bmNlX2J1ZmZlciwgcmVhZF9mbGFncyk7DQo+Pj4+Pj4+IC3CoMKg
wqAgaWYgKHJldCA8IDApIHsNCj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHRyYWNlX2JhY2t1cF9k
b19jb3dfcmVhZF9mYWlsKGpvYiwgc3RhcnQsIHJldCk7DQo+Pj4+Pj4+IC3CoMKgwqDCoMKgwqDC
oCBpZiAoZXJyb3JfaXNfcmVhZCkgew0KPj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAq
ZXJyb3JfaXNfcmVhZCA9IHRydWU7DQo+Pj4+Pj4+ICsNCj4+Pj4+Pj4gK8KgwqDCoCByZW1haW5p
bmdfYnl0ZXMgPSBuYnl0ZXM7DQo+Pj4+Pj4+ICvCoMKgwqAgd2hpbGUgKHJlbWFpbmluZ19ieXRl
cykgew0KPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgaW50IGNodW5rID0gTUlOKEJBQ0tVUF9NQVhf
Qk9VTkNFX0JVRkZFUiwgcmVtYWluaW5nX2J5dGVzKTsNCj4+Pj4+Pj4gKw0KPj4+Pj4+PiArwqDC
oMKgwqDCoMKgwqAgcmV0ID0gYmxrX2NvX3ByZWFkKGJsaywgc3RhcnQsIGNodW5rLCBib3VuY2Vf
YnVmZmVyLCByZWFkX2ZsYWdzKTsNCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChyZXQgPCAw
KSB7DQo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRyYWNlX2JhY2t1cF9kb19jb3df
cmVhZF9mYWlsKGpvYiwgc3RhcnQsIHJldCk7DQo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlmIChlcnJvcl9pc19yZWFkKSB7DQo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKmVycm9yX2lzX3JlYWQgPSB0cnVlOw0KPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB9DQo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZmFpbDsNCj4+
Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGdv
dG8gZmFpbDsNCj4+Pj4+Pj4gLcKgwqDCoCB9DQo+Pj4+Pj4+IC3CoMKgwqAgcmV0ID0gYmxrX2Nv
X3B3cml0ZShqb2ItPnRhcmdldCwgc3RhcnQsIG5ieXRlcywgKmJvdW5jZV9idWZmZXIsDQo+Pj4+
Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGpvYi0+
d3JpdGVfZmxhZ3MpOw0KPj4+Pj4+PiAtwqDCoMKgIGlmIChyZXQgPCAwKSB7DQo+Pj4+Pj4+IC3C
oMKgwqDCoMKgwqDCoCB0cmFjZV9iYWNrdXBfZG9fY293X3dyaXRlX2ZhaWwoam9iLCBzdGFydCwg
cmV0KTsNCj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGlmIChlcnJvcl9pc19yZWFkKSB7DQo+Pj4+
Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgICplcnJvcl9pc19yZWFkID0gZmFsc2U7DQo+Pj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXQgPSBibGtfY29fcHdyaXRlKGpvYi0+dGFyZ2V0LCBzdGFy
dCwgY2h1bmssIGJvdW5jZV9idWZmZXIsDQo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgam9iLT53cml0ZV9mbGFncyk7DQo+Pj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAocmV0IDwgMCkgew0KPj4+Pj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB0cmFjZV9iYWNrdXBfZG9fY293X3dyaXRlX2ZhaWwoam9iLCBzdGFydCwgcmV0
KTsNCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGVycm9yX2lzX3JlYWQpIHsN
Cj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqZXJyb3JfaXNfcmVhZCA9
IGZhbHNlOw0KPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+Pj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZmFpbDsNCj4+Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDC
oMKgIH0NCj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGdvdG8gZmFpbDsNCj4+Pj4+Pj4gKw0KPj4+
Pj4+PiArwqDCoMKgwqDCoMKgwqAgc3RhcnQgKz0gY2h1bms7DQo+Pj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoCByZW1haW5pbmdfYnl0ZXMgLT0gY2h1bms7DQo+Pj4+Pj4+ICDCoMKgwqDCoMKgwqAgfQ0K
Pj4+Pj4+PiAgwqDCoMKgwqDCoMKgIHJldHVybiBuYnl0ZXM7DQo+Pj4+Pj4+IEBAIC0zMDEsOSAr
MzEzLDE0IEBAIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIGJhY2t1cF9kb19jb3coQmFja3VwQmxv
Y2tKb2IgKmpvYiwNCj4+Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4+
Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4+Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKCFqb2ItPnVzZV9jb3B5X3JhbmdlKSB7DQo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlmICghYm91bmNlX2J1ZmZlcikgew0KPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHNpemVfdCBsZW4gPSBNSU4oQkFDS1VQX01BWF9CT1VOQ0VfQlVGRkVSLA0K
Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBNQVgoZGlydHlfZW5kIC0gc3RhcnQsIGVuZCAtIGRpcnR5X2VuZCkp
Ow0KPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJvdW5jZV9idWZmZXIg
PSBibGtfdHJ5X2Jsb2NrYWxpZ24oam9iLT5jb21tb24uYmxrLCBsZW4pOw0KPj4+Pj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+Pj4+Pj4NCj4+Pj4+PiBJZiB5b3UgdXNlIF90cnlfLCB5
b3Ugc2hvdWxkIHByb2JhYmx5IGFsc28gY2hlY2sgd2hldGhlciBpdCBzdWNjZWVkZWQuDQo+Pj4+
Pg0KPj4+Pj4gT29wcywgeW91IGFyZSByaWdodCwgb2YgY291cnNlLg0KPj4+Pj4NCj4+Pj4+Pg0K
Pj4+Pj4+IEFueXdheSwgSSB3b25kZXIgd2hldGhlciBpdOKAmWQgYmUgYmV0dGVyIHRvIGp1c3Qg
YWxsb2NhdGUgdGhpcyBidWZmZXINCj4+Pj4+PiBvbmNlIHBlciBqb2IgKHRoZSBmaXJzdCB0aW1l
IHdlIGdldCBoZXJlLCBwcm9iYWJseSkgdG8gYmUgb2Ygc2l6ZQ0KPj4+Pj4+IEJBQ0tVUF9NQVhf
Qk9VTkNFX0JVRkZFUiBhbmQgcHV0IGl0IGludG8gQmFja3VwQmxvY2tKb2IuwqAgKEFuZCBtYXli
ZSBhZGQNCj4+Pj4+PiBhIGJ1Zi1zaXplIHBhcmFtZXRlciBzaW1pbGFyIHRvIHdoYXQgdGhlIG1p
cnJvciBqb2JzIGhhdmUuKQ0KPj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gT25jZSBwZXIgam9iIHdpbGwg
bm90IHdvcmssIGFzIHdlIG1heSBoYXZlIHNldmVyYWwgZ3Vlc3Qgd3JpdGVzIGluIHBhcmFsbGVs
IGFuZCB0aGVyZWZvcmUNCj4+Pj4+IHNldmVyYWwgcGFyYWxsZWwgY29weS1iZWZvcmUtd3JpdGUg
b3BlcmF0aW9ucy4NCj4+Pj4NCj4+Pj4gSG0uwqAgSeKAmW0gbm90IHF1aXRlIGhhcHB5IHdpdGgg
dGhhdCBiZWNhdXNlIGlmIHRoZSBndWVzdCBqdXN0IGlzc3VlcyBtYW55DQo+Pj4+IGxhcmdlIGRp
c2NhcmRzIGluIHBhcmFsbGVsLCB0aGlzIG1lYW5zIHRoYXQgcWVtdSB3aWxsIGFsbG9jYXRlIGEg
bGFyZ2UNCj4+Pj4gYW1vdW50IG9mIG1lbW9yeS4NCj4+Pj4NCj4+Pj4gSXQgd291bGQgYmUgbmlj
ZSBpZiB0aGVyZSB3YXMgYSBzaW1wbGUgd2F5IHRvIGtlZXAgdHJhY2sgb2YgdGhlIHRvdGFsDQo+
Pj4+IG1lbW9yeSB1c2FnZSBhbmQgbGV0IHJlcXVlc3RzIHlpZWxkIGlmIHRoZXkgd291bGQgZXhj
ZWVkIGl0Lg0KPj4+DQo+Pj4gQWdyZWUsIGl0IHNob3VsZCBiZSBmaXhlZCBhbnl3YXkuDQo+Pj4N
Cj4+DQo+Pg0KPj4gQnV0IHN0aWxsLi4NCj4+DQo+PiBTeW5jaHJvbm91cyBtaXJyb3IgYWxsb2Nh
dGVzIGZ1bGwtcmVxdWVzdCBidWZmZXJzIG9uIGd1ZXN0IHdyaXRlLiBJcyBpdCBjb3JyZWN0Pw0K
Pj4NCj4+IElmIHdlIGFzc3VtZSB0aGF0IGl0IGlzIGNvcnJlY3QgdG8gZG91YmxlIG1lbW9yeSB1
c2FnZSBvZiBndWVzdCBvcGVyYXRpb25zLCB0aGFuIGZvciBiYWNrdXANCj4+IHRoZSBwcm9ibGVt
IGlzIG9ubHkgaW4gd3JpdGVfemVybyBhbmQgZGlzY2FyZCB3aGVyZSBndWVzdC1hc3N1bWVkIG1l
bW9yeSB1c2FnZSBzaG91bGQgYmUgemVyby4NCj4gDQo+IFdlbGwsIGJ1dCB0aGF0IGlzIHRoZSBw
cm9ibGVtLiAgSSBkaWRu4oCZdCBzYXkgYW55dGhpbmcgaW4gdjIsIGJlY2F1c2UgSQ0KPiBvbmx5
IHRob3VnaHQgb2Ygbm9ybWFsIHdyaXRlcyBhbmQgSSBmb3VuZCBpdCBmaW5lIHRvIGRvdWJsZSB0
aGUgbWVtb3J5DQo+IHVzYWdlIHRoZXJlIChhIGd1ZXN0IHdvbuKAmXQgaXNzdWUgaHVnZSB3cml0
ZSByZXF1ZXN0cyBpbiBwYXJhbGxlbCkuICBCdXQNCj4gZGlzY2FyZC93cml0ZS16ZXJvZXMgYXJl
IGEgZGlmZmVyZW50IG1hdHRlci4NCj4gDQo+PiBBbmQgaWYgd2Ugc2hvdWxkIGRpc3Rpbmd1aXNo
IHdyaXRlcyBmcm9tIHdyaXRlX3plcm9lcyBhbmQgZGlzY2FyZCwgaXQncyBiZXR0ZXIgdG8gcG9z
dHBvbmUgdGhpcw0KPj4gaW1wcm92ZW1lbnQgdG8gYmUgYWZ0ZXIgYmFja3VwLXRvcCBmaWx0ZXIg
bWVyZ2VkLg0KPiANCj4gQnV0IGRvIHlvdSBuZWVkIHRvIGRpc3Rpbmd1aXNoIGl0PyAgV2h5IG5v
dCBqdXN0IGtlZXAgdHJhY2sgb2YgbWVtb3J5DQo+IHVzYWdlIGFuZCBwdXQgdGhlIGN1cnJlbnQg
SS9PIGNvcm91dGluZSB0byBzbGVlcCBpbiBhIENvUXVldWUgb3INCj4gc29tZXRoaW5nLCBhbmQg
d2FrZSB0aGF0IHVwIGF0IHRoZSBlbmQgb2YgYmFja3VwX2RvX2NvdygpPw0KPiANCg0KMS4gQmVj
YXVzZSBpZiB3ZSBfY2FuXyBhbGxvdyBkb3VibGluZyBvZiBtZW1vcnksIGl0J3MgbW9yZSBlZmZl
Y3RpdmUgdG8gbm90IHJlc3RyaWN0IGFsbG9jYXRpb25zIG9uDQpndWVzdCB3cml0ZXMuIEl0J3Mg
anVzdCBzZWVtcyB0byBiZSBtb3JlIGVmZmVjdGl2ZSB0ZWNobmlxdWUuDQoNCjIuIEFueXdheSwg
SSdkIGFsbG93IHNvbWUgYWx3YXlzLWF2YWlsYWJsZSBzaXplIHRvIGFsbG9jYXRlIC0gbGV0IGl0
IGJlIG9uZSBjbHVzdGVyLCB3aGljaCB3aWxsIGNvcnJlc3BvbmQNCnRvIGN1cnJlbnQgYmVoYXZp
b3IgYW5kIHByZXZlbnQgZ3Vlc3QgaW8gaGFuZyBpbiB3b3JzdCBjYXNlLiBTbyBJIG1lYW4sIGlm
IHdlIGhhdmUgZW5vdWdoIG1lbW9yeSBhbGxvdw0KaW5kaXZpZHVhbCBDQlcgb3BlcmF0aW9uIHRv
IGFsbG9jYXRlIHRoZSB3aG9sZSBidWZmZXIsIGFuZCBpZiB3ZSBoYXZlIG5vIGV4dHJhIG1lbW9y
eSBhbGxvdyB0byBhbGxvY2F0ZSBvbmUNCmNsdXN0ZXIuDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0K
VmxhZGltaXINCg==

