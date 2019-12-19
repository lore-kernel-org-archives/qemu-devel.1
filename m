Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D65C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50C2A2064B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EoCeT0qB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C2A2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iht0z-0004Ut-Hr
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 05:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihszw-0003XB-MZ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:25:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihszu-0008Mc-Su
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:25:36 -0500
Received: from mail-eopbgr50104.outbound.protection.outlook.com
 ([40.107.5.104]:5764 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ihszu-00087g-2J; Thu, 19 Dec 2019 05:25:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0QBsIqDWjS1vFFhPVunljQPmiJjqWkRdw9Ml/aj2FmDUXSlHp2FV8Q1mQcI1ltGv71y/ZgaYO+25tWPUZ0qAWIaKydzjkWJAncrVP/83oiJH//L278cAvPwU/9Qx9Sd12VVtfXLpW/Wwzrl4OFs5MbNwuuWpApq27dFqXzbvDF6gaY40yE4CrY9J71yq5xIkQ20A7SP4TiCQ/lnXAn+2H0ukafMoRASHevpLLA9Oi7r5nAdMTJyULiwmsVh3qTeMngUZjx2kFwDouc+JC7xZiyfKurSELPwWc6p/FgXcYW7vyFXmX3CNWw+pjeOEEotuYbVHTa4Tq3+JnQbaolcHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDrIkCfLO797HM4Ojlr1Fw2quJG64sj6pNY1nWeNnQw=;
 b=cOSzUacyTRENcAPleNnjfp9F+6HvqAOiKbVI8fCBfgaNJVSYFZ4JdfuyPAXSw4s4Fae0kAaI5NmrwHlOcMeov8G2IvJI+ukfu1Wnw9z/Wm9pI42CigUYSnzxqOHfupowc/JSmjuyiPe2xhXofSFENep7LdtwSrV62fkQLm2SDhE/H+Osi1maGzQtOctm2ab9itgryvyAsvmo9ves3PxXxPKy/JHELugqa/W52siCvkqUU61ksIZGibqkv/G8MvjabJywD+Dh6bAfGq6rkgS2vEwXjKwDgbu2id4PM/9XPJmzNSUdVx51esOAY8AeDs7ERaaB7pvj9VZvWOiUGhsTRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDrIkCfLO797HM4Ojlr1Fw2quJG64sj6pNY1nWeNnQw=;
 b=EoCeT0qBq00QbdwE5edJsFSkA6V3H8kT6s4QmxKSpTjRRxYgaLAIk200gq5DgIGILQT7Pz4Xu4tsXQFq/BYhS4Jrl+5iJAalckaFAKmW2Q4H8nWidCjL7VkXDfxXMQGStZmOe2/xrASzT1AllKjK4LlDmmL+AGD8GzOgpGb2mWg=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4102.eurprd08.prod.outlook.com (20.179.2.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.14; Thu, 19 Dec 2019 10:25:31 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 10:25:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: qcow2 api not secured by mutex lock
Thread-Topic: qcow2 api not secured by mutex lock
Thread-Index: AQHVtY3ue6JcAc0xJEiq/6zDmRijnqfBO70AgAAGawA=
Date: Thu, 19 Dec 2019 10:25:30 +0000
Message-ID: <1a976490-452c-04b6-8dbb-b8122acae9f7@virtuozzo.com>
References: <1ea7f93d-8f48-d565-70e7-0d66f1b80c1e@virtuozzo.com>
 <20191219100230.GC5230@linux.fritz.box>
In-Reply-To: <20191219100230.GC5230@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P195CA0015.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::25)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191219132528543
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9366abac-9e4a-4ec0-4b47-08d7846dc634
x-ms-traffictypediagnostic: AM6PR08MB4102:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB410259912DD073E17B6EB3DBC1520@AM6PR08MB4102.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(136003)(396003)(39830400003)(189003)(199004)(2906002)(31686004)(71200400001)(36756003)(66946007)(478600001)(5660300002)(66476007)(64756008)(66556008)(6512007)(54906003)(6486002)(66446008)(2616005)(107886003)(316002)(52116002)(6916009)(6506007)(8676002)(26005)(81156014)(31696002)(4326008)(8936002)(186003)(81166006)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4102;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bx36jVB4Lk9dIzDVNBAlzVv7SnAMOr424G5Gt8NsVmn+dsbeZq9auaFUn92Qatt0ERTusmd7Lrk6ZRPBi/E5PTTXYrwe1dNZ9vSlo1tth4ZdtAfl9MP3e3epRXMyQIplgygTfZMnXnvq3jXimOwgLk1ZGNqOMfmYKtAU+Ds0E9k+Lo+ji2E5fCKgDFDh5FCJmwxu+tyQw/5TEoO7lyH8/YeexXoWPVdPLRvRs3L7Xxwfd5g4t4dUx5QScPEW0t5FUdoVK7M+zTDyn/oqI5QG5aGvGZRN85KfXVAalgN+XFUa0pxCqwBJB3OustqX7cU5Wc8ItXu5pFIN+arOkSWbsauDcvznTUdAkHj4ysvPd6DgTTUanXUGD8jQZLdncSvsm1BUP9er8KKgKDNneeBYSsz6BMnIrwtx38STZnOi74CBYJg7ItvPH0y8nxNEG2ZL
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6300D8CFF72A14390C6FE64F77AE109@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9366abac-9e4a-4ec0-4b47-08d7846dc634
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 10:25:30.9151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ikCSpFq+9RpxoaypxYnYKtRLcOdBwhqMmT7lc6jqpviMms5JTf/rP+EjIRRbT6AcAK45phBs4UtPbV6ovHisedPc0eEzr9j1MXbZvKOlrdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4102
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Received-From: 40.107.5.104
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
Cc: Denis Lunev <den@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMTIuMjAxOSAxMzowMiwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTguMTIuMjAxOSB1bSAx
MToyOCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IEhp
IQ0KPj4NCj4+IFNvbWUgdGltZSBhZ28sIHdlJ3ZlIGZhY2VkIGFuZCBmaXhlZCB0aGUgZmFjdCB0
aGF0IHFjb3cyIGJpdG1hcCBhcGkgZG9lc24ndA0KPj4gY2FsbCBxY293Ml9jb19tdXRleF9sb2Nr
LCBiZWZvcmUgYWNjZXNzaW5nIHFjb3cyIG1ldGFkYXRhLiBUaGlzIHdhcyBzb2x2ZWQgYnkNCj4+
IG1vdmluZyBxY293Ml9jb19yZW1vdmVfcGVyc2lzdGVudF9kaXJ0eV9iaXRtYXAgYW5kDQo+PiBx
Y293Ml9jb19jYW5fc3RvcmVfbmV3X2RpcnR5X2JpdG1hcCB0byBjb3JvdXRpbmUgYW5kIGNhbGwg
cWNvdzJfY29fbXV0ZXhfbG9jay4NCj4+DQo+PiBOb3cgSSBkZWNpZGVkIHRvIGxvb2sgYXQgYmln
IHBpY3R1cmUgKGl0IGlzIGF0dGFjaGVkKS4NCj4+DQo+PiBCb3hlcyBhcmUgcWNvdzIgZHJpdmVy
IGFwaSwgZ3JlZW4gYm9yZGVyIG1lYW5zIHRoYXQgZnVuY3Rpb24gY2FsbHMgcWNvdzJfY29fbXV0
ZXhfbG9jaw0KPj4gKGl0IGRvZXNuJ3QgZ3VhcmFudGVlLCB0aGF0IGV4YWN0bHkgY2hpbGQgbm9k
ZSBjYWxsIGlzIGxvY2tlZCwgYnV0IGl0IGlzIHNvbWV0aGluZykuDQo+Pg0KPj4gSW4gdGhlIHBp
Y3R1cmUgdGhlcmUgYXJlIGp1c3QgYWxsIGZ1bmN0aW9ucywgY2FsbGluZyBxY293Ml9jYWNoZV9n
ZXQvcHV0Li4gTm90IGFsbCB0aGUNCj4+IGZ1bmN0aW9ucywgdGhhdCBuZWVkcyBsb2NraW5nLCBi
dXQgYWdhaW4sIGl0IGlzIHNvbWV0aGluZy4NCj4+DQo+PiBTbywgYWNjb3JkaW5nbHkgdG8gdGhl
IHBpY3R1cmUsIGl0IHNlZW1zIHRoYXQgdGhlIGZvbGxvd2luZyBmdW5jdGlvbnMgbGFja3MgbG9j
a2luZzoNCj4+DQo+PiBxY293Ml9jb19jcmVhdGUNCj4gDQo+IFRoaXMgc2hvdWxkIGJlIGVhc3kg
dG8gZml4LiBJdCdzIGFsc28gcmVsYXRpdmVseSBoYXJtbGVzcyBiZWNhdXNlIGl0J3MNCj4gdW5s
aWtlbHkgdGhhdCB0aGUgaW1hZ2UgdGhhdCBpcyBiZWluZyBjcmVhdGVkIGlzIGFjY2Vzc2VkIGJ5
IHNvbWVvbmUNCj4gZWxzZSAodGhlIHVzZXIgd291bGQgaGF2ZSB0byBxdWVyeSB0aGUgYXV0by1n
ZW5lcmF0ZWQgbm9kZSBuYW1lIGFuZA0KPiBzdGFydCBzb21ldGhpbmcgb24gaXQgLSBhdCB3aGlj
aCBwb2ludCB0aGV5IGRlc2VydmUgd2hhdCB0aGV5IGdldCkuDQo+IA0KPj4gcWNvdzJfc25hcHNo
b3RfKg0KPj4gICAgIChidXQgaXQgaXMgYm90aCBkcmFpbmVkIGFuZCBhaW8gY29udGV4dCBsb2Nr
ZWQsIHNvIHNob3VsZCBiZSBzYWZlLCB5ZXM/KQ0KPiANCj4gSWYgeW91IGNoZWNrZWQgdGhhdCB0
aGVzZSBjb25kaXRpb25zIGFyZSB0cnVlLCBpdCBzaG91bGQgYmUgc2FmZS4NCj4gDQo+PiBxY293
Ml9yZW9wZW5fYml0bWFwc19ydw0KPj4gcWNvdzJfc3RvcmVfcGVyc2lzdGVudF9kaXJ0eV9iaXRt
YXBzDQo+IA0KPiBSZW9wZW4gZHJhaW5zIHRoZSBpbWFnZSwgc28gSSB0aGluayB0aGlzIGlzIHNh
ZmUgaW4gcHJhY3RpY2UuDQo+IA0KPiBJZiB3ZSB3YW50IHRvIGRvIHNvbWV0aGluZyBhYm91dCBp
dCBhbnl3YXkgKGUuZy4gbW92ZSBpdCB0byBhIGNvcm91dGluZQ0KPiBzbyBpdCBjYW4gdGFrZSBh
IGxvY2spIHRoZSBxdWVzdGlvbiBpcyB3aGVyZSB0byBkbyB0aGF0LiBNYXliZSBldmVuIGZvcg0K
PiAuYmRydl9yZW9wZW5fKiBpbiBnZW5lcmFsPw0KPiANCj4+IHFjb3cyX2FtZW5kX29wdGlvbnMN
Cj4gDQo+IE9ubHkgcWVtdS1pbWcgc28gZmFyLCBzbyBubyBjb25jdXJyZW5jeS4gV2UncmUgYWJv
dXQgdG8gYWRkDQo+IGJsb2NrZGV2LWFtZW5kIGluIFFNUCwgdGhvdWdoLCBzbyB0aGlzIGxvb2tz
IGxpa2Ugc29tZXRoaW5nIHRoYXQgc2hvdWxkDQo+IHRha2UgdGhlIGxvY2suDQo+IA0KPiBJbiBm
YWN0LCBpcyB0YWtpbmcgdGhlIGxvY2sgZW5vdWdoIG9yIHNob3VsZCBpdCBhY3R1YWxseSBkcmFp
biB0aGUgbm9kZSwNCj4gdG9vPw0KPiANCj4+IHFjb3cyX21ha2VfZW1wdHkNCj4gDQo+IFRoaXMg
b25lIHNob3VsZCBjZXJ0YWlubHkgZHJhaW4uIEl0IGlzIHVzZWQgbm90IG9ubHkgaW4gcWVtdS1p
bWcsIGJ1dA0KPiBhbHNvIGluIEhNUCBjb21taXQgYW5kIGFwcGFyZW50bHkgYWxzbyBpbiByZXBs
aWNhdGlvbi4NCj4gDQo+IFRoaXMgb25lIG1pZ2h0IGJlIGEgYnVnIHRoYXQgY291bGQgYmVjb21l
IHZpc2libGUgaW4gcHJhY3RpY2UuIFVubGlrZWx5DQo+IGZvciBITVAgY29tbWl0IChiZWNhdXNl
IGl0IHRha2VzIGEgd2hpbGUgYW5kIGlzIGhvbGRpbmcgdGhlIEJRTCwgc28gbm8NCj4gbmV3IGd1
ZXN0IHJlcXVlc3RzIHdpbGwgYmUgcHJvY2Vzc2VkKSwgZXhjZXB0IG1heWJlIGZvciBjYXNlcyB3
aGVyZQ0KPiB0aGVyZSBpcyBub3RoaW5nIHRvIGNvbW1pdC4NCj4gDQo+PiA9PT0NCj4+DQo+PiBD
aGVja2luZyBncmVlbiBub2RlczoNCj4+DQo+PiBxY293Ml9jb19pbnZhbGlkYXRlX2NhY2hlIGFj
dHVhbGx5IGNhbGxzIHFjb3cyX2Nsb3NlIHVubG9ja2VkLCBpdCdzDQo+PiBhbm90aGVyIHJlYXNv
biB0byBmaXggcWNvdzJfc3RvcmVfcGVyc2lzdGVudF9kaXJ0eV9iaXRtYXBzDQo+IA0KPiBNaWdo
dCBiZS4gRG8gd2Ugd2FudCBhIC5iZHJ2X2NvX2Nsb3NlPw0KPiANCj4+IHFjb3cyX3dyaXRlX3Nu
YXBzaG90cyBhY3R1YWxseSBjYWxsZWQgdW5sb2NrZWQgZnJvbQ0KPj4gcWNvdzJfY2hlY2tfZml4
X3NuYXBzaG90X3RhYmxlLi4gSXQgc2VlbXMgdW5zYWZlLg0KPiANCj4gVGhpcyBpcyBjdXJpb3Vz
LCBJJ20gbm90IHN1cmUgd2h5IHlvdSB3b3VsZCBkcm9wIHRoZSBsb2NrIHRoZXJlLiBNYXg/DQo+
IA0KPiBiZHJ2X2ZsdXNoKCkgY2FsbHMgd291bGQgaGF2ZSB0byByZXBsYWNlZCB3aXRoIHFjb3cy
X3dyaXRlX2NhY2hlcygpIHRvDQo+IGF2b2lkIGEgZGVhZGxvY2ssIGJ1dCBvdGhlcndpc2UgSSBk
b24ndCBzZWUgd2h5IHdlIHdvdWxkIHdhbnQgdG8gZHJvcA0KPiB0aGUgbG9jay4NCj4gDQo+IE9m
IGNvdXJzZSwgdGhpcyBzaG91bGQgb25seSBiZSBjYWxsZWQgZnJvbSBxZW11LWltZyBjaGVjaywg
c28gaW4NCj4gcHJhY3RpY2UgaXQncyBwcm9iYWJseSBub3QgYSBidWcuDQo+IA0KDQpUaGFua3Mg
Zm9yIGFuYWx5c2lzISBJJ2xsIGNvbnRpbnVlIHRoaW5raW5nIG9uIHRoaXMgYW5kIGNvbWUgd2l0
aCBwYXRjaGVzDQoob3IgbmV3IHF1ZXN0aW9ucykuDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpW
bGFkaW1pcg0K

