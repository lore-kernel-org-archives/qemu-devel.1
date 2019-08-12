Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29E1C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:37:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABBC520679
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="m+vy6+qm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBC520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxDKY-0003GU-17
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 12:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55152)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxDK5-0002nG-0O
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxDK3-0005Pr-Fi
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:37:28 -0400
Received: from mail-eopbgr150138.outbound.protection.outlook.com
 ([40.107.15.138]:63052 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxDK2-0005P5-MW; Mon, 12 Aug 2019 12:37:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rs1er46KF1/4Ruxzj8tA951/oj2W8y4zzp7Nn+KaIevxE1jyCArqTJvizm3DiTuOUDBGm5E/+TVg6f5alivWVHzzHxasLoBbyGByr1hNjae2FQvlV5ghaOBztXfZJuXmLZe+Z+KAZMIVT+HJjaHEcORyO7ikNjWgYpMypkseokQH/E1RmqPS+gFBcc//O9cfFtFNDpeD12kg5WofeE4liB/Vn7uDnB8l8PrIsPmIQS9xPlvYT8g0QevaYxUpfoX1pWYUnTQxPtYxNpibFk5CJrFkwUbWRNypuHF4gujsfFoOIRUVYm1xmTvPgMak4XAkW3aActBDzx5B6nyeAbTKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuDe2dK/7Xb9k5SkCUbD29QdSEEulwUgj7I6+w1y1hQ=;
 b=YdW2Tc8Hu8guyLktTc80QNUBVPAzm/pDqcHIY1sjeRRd1EcMNHHC0S4FcB223WJjOWubu4V/TB8bh01lMohaz150mq9vTSzuL10m7JCgf1684pSdcEkoktN5iMZSJwJagYPrI7QwH8aqQayWNILWjzxsHKMJn1QbrzxmcuBeKJ57f5lWUWHKOrnDNj3YriDj+YWBeocTY72h6vc3kZzvXzabWPzm2ALwqodolzCEszCjuDmRDa270pi3NsMI1O4yYbyT0rGWbh+jHebxyETq36kdfZFteZsbDal+9qieYDY8W3UxBAS2EI4noCdVFXefY08++mRZutUi8NguwsJQFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuDe2dK/7Xb9k5SkCUbD29QdSEEulwUgj7I6+w1y1hQ=;
 b=m+vy6+qmPXsLtY1V6M+jDvjQoNe+NyamZlG8uxI3xBjoMXiDVt4CKaD2yZeWrkIBJfdd2xEr8//AB2F4eiRhW4nyWXMwWm/00KFXHZGKwUBbnJLAcC9ZuETGMRP0H9GrHDJzKURt8MEj+OaOFYgTnql24FL+PyTTHJb7o9PH5Ec=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4105.eurprd08.prod.outlook.com (20.179.12.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Mon, 12 Aug 2019 16:37:24 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 16:37:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 6/7] block/backup: teach backup_cow_with_bounce_buffer
 to copy more at once
Thread-Index: AQHVT7JML2nk8Wsax0eUZCBvWTBktKb3oMEAgAAKYwCAAAavAIAABzYA
Date: Mon, 12 Aug 2019 16:37:24 +0000
Message-ID: <e3fc5e07-33c6-1fe3-2042-35bdac0a03c3@virtuozzo.com>
References: <20190810193155.58637-1-vsementsov@virtuozzo.com>
 <20190810193155.58637-7-vsementsov@virtuozzo.com>
 <5102eac9-125b-0719-910f-4adb240732f1@redhat.com>
 <89c87c83-276a-7663-a239-57dbd9f91a30@virtuozzo.com>
 <ecff86a8-57d1-4c8a-d4b4-95524471d249@redhat.com>
In-Reply-To: <ecff86a8-57d1-4c8a-d4b4-95524471d249@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0045.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::34) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190812193722139
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cb3e09d-9178-4d9a-d51a-08d71f435af1
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4105; 
x-ms-traffictypediagnostic: DB8PR08MB4105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB410512DC1C992ED3AFB76596C1D30@DB8PR08MB4105.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(376002)(39840400004)(136003)(396003)(199004)(189003)(52314003)(8676002)(2501003)(71190400001)(66066001)(54906003)(2906002)(6246003)(110136005)(31686004)(25786009)(71200400001)(81166006)(99286004)(81156014)(8936002)(478600001)(229853002)(86362001)(6512007)(6436002)(53936002)(6486002)(31696002)(6116002)(3846002)(486006)(76176011)(52116002)(14454004)(102836004)(305945005)(66556008)(64756008)(66446008)(26005)(7736002)(107886003)(186003)(11346002)(2616005)(446003)(316002)(256004)(14444005)(476003)(66946007)(66476007)(386003)(6506007)(53546011)(5660300002)(36756003)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4105;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rprZGU+I6lulZtUYTL5m5OlXrQG9tFGzlHM1g/VpUALx752Sj8NmtcDCkQNI671w2MTv/Q5BX9KB4uVHiPcXwCeohAh2F5c6BrvTRRiyuyB7y606lBiRh9TZLTUJkzmclaArMbf2RXKAAy4j6iqKZcjTEEPhJhb8w7f9K2QAXj/8fa0b6RgosAu9u8Wck88klbniefAtPRBUz/vTWTkEA95J9MetIoW3B4TGkwfH3lhZttHQkNHe4nJbSECODWJgXVziFp6gNqCiTwTnJZXNkZaGqOSYIdpDDVefVo2KSVDQI9AtapdT7jojD5Q0tXXWvf/FVbRl4ZmEMzh+gq6AN7htz3JsqruW3Bm7v0ohZZe5u2oCHQZZUJIh7MzdDzBIwLkeRRJgmUoYD1akLfqTIZn4yYgOMTxJo/hmLgRx65Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63D71984F9AFD6469EE6E6892C64A185@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb3e09d-9178-4d9a-d51a-08d71f435af1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 16:37:24.7674 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLl4AZASAFaYzSyGQkcQP7vnIvkzvMieBjQFf01K+gRhGrnVjW2c8WllAkqLyX0be6JQe3ibICRt2K5IZGAkCmgAuGyeHCWnQEw3k6GWwXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4105
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.138
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

MTIuMDguMjAxOSAxOToxMSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMi4wOC4xOSAxNzo0Nywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDEyLjA4LjIwMTkgMTg6MTAs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAxMC4wOC4xOSAyMTozMSwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gYmFja3VwX2Nvd193aXRoX29mZmxvYWQgY2FuIHRy
YW5zZmVyIG1vcmUgdGhhbiBvbmUgY2x1c3Rlci4gTGV0DQo+Pj4+IGJhY2t1cF9jb3dfd2l0aF9i
b3VuY2VfYnVmZmVyIGJlaGF2ZSBzaW1pbGFybHkuIEl0IHJlZHVjZXMgdGhlIG51bWJlcg0KPj4+
PiBvZiBJTyByZXF1ZXN0cywgc2luY2UgdGhlcmUgaXMgbm8gbmVlZCB0byBjb3B5IGNsdXN0ZXIg
YnkgY2x1c3Rlci4NCj4+Pj4NCj4+Pj4gTG9naWMgYXJvdW5kIGJvdW5jZV9idWZmZXIgYWxsb2Nh
dGlvbiBjaGFuZ2VkOiB3ZSBjYW4ndCBqdXN0IGFsbG9jYXRlDQo+Pj4+IG9uZS1jbHVzdGVyLXNp
emVkIGJ1ZmZlciB0byBzaGFyZSBmb3IgYWxsIGl0ZXJhdGlvbnMuIFdlIGNhbid0IGFsc28NCj4+
Pj4gYWxsb2NhdGUgYnVmZmVyIG9mIGZ1bGwtcmVxdWVzdCBsZW5ndGggaXQgbWF5IGJlIHRvbyBs
YXJnZSwgc28NCj4+Pj4gQkFDS1VQX01BWF9CT1VOQ0VfQlVGRkVSIGlzIGludHJvZHVjZWQuIEFu
ZCBmaW5hbGx5LCBhbGxvY2F0aW9uIGxvZ2ljDQo+Pj4+IGlzIHRvIGFsbG9jYXRlIGEgYnVmZmVy
IHN1ZmZpY2llbnQgdG8gaGFuZGxlIGFsbCByZW1haW5pbmcgaXRlcmF0aW9ucw0KPj4+PiBhdCB0
aGUgcG9pbnQgd2hlcmUgd2UgbmVlZCB0aGUgYnVmZmVyIGZvciB0aGUgZmlyc3QgdGltZS4NCj4+
Pj4NCj4+Pj4gQm9udXM6IGdldCByaWQgb2YgcG9pbnRlci10by1wb2ludGVyLg0KPj4+Pg0KPj4+
PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292
QHZpcnR1b3p6by5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBibG9jay9iYWNrdXAuYyB8IDY1ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4+ICAg
IDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4+Pj4N
Cj4+Pj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2JhY2t1cC5jIGIvYmxvY2svYmFja3VwLmMNCj4+Pj4g
aW5kZXggZDQ4MmQ5MzQ1OC4uNjVmNzIxMmM4NSAxMDA2NDQNCj4+Pj4gLS0tIGEvYmxvY2svYmFj
a3VwLmMNCj4+Pj4gKysrIGIvYmxvY2svYmFja3VwLmMNCj4+Pj4gQEAgLTI3LDYgKzI3LDcgQEAN
Cj4+Pj4gICAgI2luY2x1ZGUgInFlbXUvZXJyb3ItcmVwb3J0LmgiDQo+Pj4+ICAgIA0KPj4+PiAg
ICAjZGVmaW5lIEJBQ0tVUF9DTFVTVEVSX1NJWkVfREVGQVVMVCAoMSA8PCAxNikNCj4+Pj4gKyNk
ZWZpbmUgQkFDS1VQX01BWF9CT1VOQ0VfQlVGRkVSICg2NCAqIDEwMjQgKiAxMDI0KQ0KPj4+PiAg
ICANCj4+Pj4gICAgdHlwZWRlZiBzdHJ1Y3QgQ293UmVxdWVzdCB7DQo+Pj4+ICAgICAgICBpbnQ2
NF90IHN0YXJ0X2J5dGU7DQo+Pj4+IEBAIC05OCw0NCArOTksNTUgQEAgc3RhdGljIHZvaWQgY293
X3JlcXVlc3RfZW5kKENvd1JlcXVlc3QgKnJlcSkNCj4+Pj4gICAgICAgIHFlbXVfY29fcXVldWVf
cmVzdGFydF9hbGwoJnJlcS0+d2FpdF9xdWV1ZSk7DQo+Pj4+ICAgIH0NCj4+Pj4gICAgDQo+Pj4+
IC0vKiBDb3B5IHJhbmdlIHRvIHRhcmdldCB3aXRoIGEgYm91bmNlIGJ1ZmZlciBhbmQgcmV0dXJu
IHRoZSBieXRlcyBjb3BpZWQuIElmDQo+Pj4+IC0gKiBlcnJvciBvY2N1cnJlZCwgcmV0dXJuIGEg
bmVnYXRpdmUgZXJyb3IgbnVtYmVyICovDQo+Pj4+ICsvKg0KPj4+PiArICogQ29weSByYW5nZSB0
byB0YXJnZXQgd2l0aCBhIGJvdW5jZSBidWZmZXIgYW5kIHJldHVybiB0aGUgYnl0ZXMgY29waWVk
LiBJZg0KPj4+PiArICogZXJyb3Igb2NjdXJyZWQsIHJldHVybiBhIG5lZ2F0aXZlIGVycm9yIG51
bWJlcg0KPj4+PiArICoNCj4+Pj4gKyAqIEBib3VuY2VfYnVmZmVyIGlzIGFzc3VtZWQgdG8gZW5v
dWdoIHRvIHN0b3JlDQo+Pj4NCj4+PiBzL3RvL3RvIGJlLw0KPj4+DQo+Pj4+ICsgKiBNSU4oQkFD
S1VQX01BWF9CT1VOQ0VfQlVGRkVSLCBAZW5kIC0gQHN0YXJ0KSBieXRlcw0KPj4+PiArICovDQo+
Pj4+ICAgIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIGJhY2t1cF9jb3dfd2l0aF9ib3VuY2VfYnVm
ZmVyKEJhY2t1cEJsb2NrSm9iICpqb2IsDQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludDY0X3Qgc3RhcnQsDQo+Pj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludDY0
X3QgZW5kLA0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBib29sIGlzX3dyaXRlX25vdGlmaWVyLA0KPj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sICplcnJvcl9p
c19yZWFkLA0KPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdm9pZCAqKmJvdW5jZV9idWZmZXIpDQo+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpib3VuY2VfYnVmZmVy
KQ0KPj4+PiAgICB7DQo+Pj4+ICAgICAgICBpbnQgcmV0Ow0KPj4+PiAgICAgICAgQmxvY2tCYWNr
ZW5kICpibGsgPSBqb2ItPmNvbW1vbi5ibGs7DQo+Pj4+IC0gICAgaW50IG5ieXRlczsNCj4+Pj4g
KyAgICBpbnQgbmJ5dGVzLCByZW1haW5pbmdfYnl0ZXM7DQo+Pj4+ICAgICAgICBpbnQgcmVhZF9m
bGFncyA9IGlzX3dyaXRlX25vdGlmaWVyID8gQkRSVl9SRVFfTk9fU0VSSUFMSVNJTkcgOiAwOw0K
Pj4+PiAgICANCj4+Pj4gICAgICAgIGFzc2VydChRRU1VX0lTX0FMSUdORUQoc3RhcnQsIGpvYi0+
Y2x1c3Rlcl9zaXplKSk7DQo+Pj4+IC0gICAgYmRydl9yZXNldF9kaXJ0eV9iaXRtYXAoam9iLT5j
b3B5X2JpdG1hcCwgc3RhcnQsIGpvYi0+Y2x1c3Rlcl9zaXplKTsNCj4+Pj4gLSAgICBuYnl0ZXMg
PSBNSU4oam9iLT5jbHVzdGVyX3NpemUsIGpvYi0+bGVuIC0gc3RhcnQpOw0KPj4+PiAtICAgIGlm
ICghKmJvdW5jZV9idWZmZXIpIHsNCj4+Pj4gLSAgICAgICAgKmJvdW5jZV9idWZmZXIgPSBibGtf
YmxvY2thbGlnbihibGssIGpvYi0+Y2x1c3Rlcl9zaXplKTsNCj4+Pj4gLSAgICB9DQo+Pj4+ICsg
ICAgYmRydl9yZXNldF9kaXJ0eV9iaXRtYXAoam9iLT5jb3B5X2JpdG1hcCwgc3RhcnQsIGVuZCAt
IHN0YXJ0KTsNCj4+Pj4gKyAgICBuYnl0ZXMgPSBNSU4oZW5kIC0gc3RhcnQsIGpvYi0+bGVuIC0g
c3RhcnQpOw0KPj4+PiAgICANCj4+Pj4gLSAgICByZXQgPSBibGtfY29fcHJlYWQoYmxrLCBzdGFy
dCwgbmJ5dGVzLCAqYm91bmNlX2J1ZmZlciwgcmVhZF9mbGFncyk7DQo+Pj4+IC0gICAgaWYgKHJl
dCA8IDApIHsNCj4+Pj4gLSAgICAgICAgdHJhY2VfYmFja3VwX2RvX2Nvd19yZWFkX2ZhaWwoam9i
LCBzdGFydCwgcmV0KTsNCj4+Pj4gLSAgICAgICAgaWYgKGVycm9yX2lzX3JlYWQpIHsNCj4+Pj4g
LSAgICAgICAgICAgICplcnJvcl9pc19yZWFkID0gdHJ1ZTsNCj4+Pj4gKw0KPj4+PiArICAgIHJl
bWFpbmluZ19ieXRlcyA9IG5ieXRlczsNCj4+Pj4gKyAgICB3aGlsZSAocmVtYWluaW5nX2J5dGVz
KSB7DQo+Pj4+ICsgICAgICAgIGludCBjaHVuayA9IE1JTihCQUNLVVBfTUFYX0JPVU5DRV9CVUZG
RVIsIHJlbWFpbmluZ19ieXRlcyk7DQo+Pj4+ICsNCj4+Pj4gKyAgICAgICAgcmV0ID0gYmxrX2Nv
X3ByZWFkKGJsaywgc3RhcnQsIGNodW5rLCBib3VuY2VfYnVmZmVyLCByZWFkX2ZsYWdzKTsNCj4+
Pj4gKyAgICAgICAgaWYgKHJldCA8IDApIHsNCj4+Pj4gKyAgICAgICAgICAgIHRyYWNlX2JhY2t1
cF9kb19jb3dfcmVhZF9mYWlsKGpvYiwgc3RhcnQsIHJldCk7DQo+Pj4+ICsgICAgICAgICAgICBp
ZiAoZXJyb3JfaXNfcmVhZCkgew0KPj4+PiArICAgICAgICAgICAgICAgICplcnJvcl9pc19yZWFk
ID0gdHJ1ZTsNCj4+Pj4gKyAgICAgICAgICAgIH0NCj4+Pj4gKyAgICAgICAgICAgIGdvdG8gZmFp
bDsNCj4+Pj4gICAgICAgICAgICB9DQo+Pj4+IC0gICAgICAgIGdvdG8gZmFpbDsNCj4+Pj4gLSAg
ICB9DQo+Pj4+ICAgIA0KPj4+PiAtICAgIHJldCA9IGJsa19jb19wd3JpdGUoam9iLT50YXJnZXQs
IHN0YXJ0LCBuYnl0ZXMsICpib3VuY2VfYnVmZmVyLA0KPj4+PiAtICAgICAgICAgICAgICAgICAg
ICAgICAgam9iLT53cml0ZV9mbGFncyk7DQo+Pj4+IC0gICAgaWYgKHJldCA8IDApIHsNCj4+Pj4g
LSAgICAgICAgdHJhY2VfYmFja3VwX2RvX2Nvd193cml0ZV9mYWlsKGpvYiwgc3RhcnQsIHJldCk7
DQo+Pj4+IC0gICAgICAgIGlmIChlcnJvcl9pc19yZWFkKSB7DQo+Pj4+IC0gICAgICAgICAgICAq
ZXJyb3JfaXNfcmVhZCA9IGZhbHNlOw0KPj4+PiArICAgICAgICByZXQgPSBibGtfY29fcHdyaXRl
KGpvYi0+dGFyZ2V0LCBzdGFydCwgY2h1bmssIGJvdW5jZV9idWZmZXIsDQo+Pj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgam9iLT53cml0ZV9mbGFncyk7DQo+Pj4+ICsgICAgICAgIGlm
IChyZXQgPCAwKSB7DQo+Pj4+ICsgICAgICAgICAgICB0cmFjZV9iYWNrdXBfZG9fY293X3dyaXRl
X2ZhaWwoam9iLCBzdGFydCwgcmV0KTsNCj4+Pj4gKyAgICAgICAgICAgIGlmIChlcnJvcl9pc19y
ZWFkKSB7DQo+Pj4+ICsgICAgICAgICAgICAgICAgKmVycm9yX2lzX3JlYWQgPSBmYWxzZTsNCj4+
Pj4gKyAgICAgICAgICAgIH0NCj4+Pj4gKyAgICAgICAgICAgIGdvdG8gZmFpbDsNCj4+Pj4gICAg
ICAgICAgICB9DQo+Pj4+IC0gICAgICAgIGdvdG8gZmFpbDsNCj4+Pj4gKw0KPj4+PiArICAgICAg
ICBzdGFydCArPSBjaHVuazsNCj4+Pj4gKyAgICAgICAgcmVtYWluaW5nX2J5dGVzIC09IGNodW5r
Ow0KPj4+PiAgICAgICAgfQ0KPj4+PiAgICANCj4+Pj4gICAgICAgIHJldHVybiBuYnl0ZXM7DQo+
Pj4+IEBAIC0zMDEsOSArMzEzLDE0IEBAIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIGJhY2t1cF9k
b19jb3coQmFja3VwQmxvY2tKb2IgKmpvYiwNCj4+Pj4gICAgICAgICAgICAgICAgfQ0KPj4+PiAg
ICAgICAgICAgIH0NCj4+Pj4gICAgICAgICAgICBpZiAoIWpvYi0+dXNlX2NvcHlfcmFuZ2UpIHsN
Cj4+Pj4gKyAgICAgICAgICAgIGlmICghYm91bmNlX2J1ZmZlcikgew0KPj4+PiArICAgICAgICAg
ICAgICAgIHNpemVfdCBsZW4gPSBNSU4oQkFDS1VQX01BWF9CT1VOQ0VfQlVGRkVSLA0KPj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUFYKGRpcnR5X2VuZCAtIHN0YXJ0LCBl
bmQgLSBkaXJ0eV9lbmQpKTsNCj4+Pj4gKyAgICAgICAgICAgICAgICBib3VuY2VfYnVmZmVyID0g
YmxrX3RyeV9ibG9ja2FsaWduKGpvYi0+Y29tbW9uLmJsaywgbGVuKTsNCj4+Pj4gKyAgICAgICAg
ICAgIH0NCj4+Pg0KPj4+IElmIHlvdSB1c2UgX3RyeV8sIHlvdSBzaG91bGQgcHJvYmFibHkgYWxz
byBjaGVjayB3aGV0aGVyIGl0IHN1Y2NlZWRlZC4NCj4+DQo+PiBPb3BzLCB5b3UgYXJlIHJpZ2h0
LCBvZiBjb3Vyc2UuDQo+Pg0KPj4+DQo+Pj4gQW55d2F5LCBJIHdvbmRlciB3aGV0aGVyIGl04oCZ
ZCBiZSBiZXR0ZXIgdG8ganVzdCBhbGxvY2F0ZSB0aGlzIGJ1ZmZlcg0KPj4+IG9uY2UgcGVyIGpv
YiAodGhlIGZpcnN0IHRpbWUgd2UgZ2V0IGhlcmUsIHByb2JhYmx5KSB0byBiZSBvZiBzaXplDQo+
Pj4gQkFDS1VQX01BWF9CT1VOQ0VfQlVGRkVSIGFuZCBwdXQgaXQgaW50byBCYWNrdXBCbG9ja0pv
Yi4gIChBbmQgbWF5YmUgYWRkDQo+Pj4gYSBidWYtc2l6ZSBwYXJhbWV0ZXIgc2ltaWxhciB0byB3
aGF0IHRoZSBtaXJyb3Igam9icyBoYXZlLikNCj4+Pg0KPj4NCj4+IE9uY2UgcGVyIGpvYiB3aWxs
IG5vdCB3b3JrLCBhcyB3ZSBtYXkgaGF2ZSBzZXZlcmFsIGd1ZXN0IHdyaXRlcyBpbiBwYXJhbGxl
bCBhbmQgdGhlcmVmb3JlDQo+PiBzZXZlcmFsIHBhcmFsbGVsIGNvcHktYmVmb3JlLXdyaXRlIG9w
ZXJhdGlvbnMuDQo+IA0KPiBIbS4gIEnigJltIG5vdCBxdWl0ZSBoYXBweSB3aXRoIHRoYXQgYmVj
YXVzZSBpZiB0aGUgZ3Vlc3QganVzdCBpc3N1ZXMgbWFueQ0KPiBsYXJnZSBkaXNjYXJkcyBpbiBw
YXJhbGxlbCwgdGhpcyBtZWFucyB0aGF0IHFlbXUgd2lsbCBhbGxvY2F0ZSBhIGxhcmdlDQo+IGFt
b3VudCBvZiBtZW1vcnkuDQo+IA0KPiBJdCB3b3VsZCBiZSBuaWNlIGlmIHRoZXJlIHdhcyBhIHNp
bXBsZSB3YXkgdG8ga2VlcCB0cmFjayBvZiB0aGUgdG90YWwNCj4gbWVtb3J5IHVzYWdlIGFuZCBs
ZXQgcmVxdWVzdHMgeWllbGQgaWYgdGhleSB3b3VsZCBleGNlZWQgaXQuDQoNCkFncmVlLCBpdCBz
aG91bGQgYmUgZml4ZWQgYW55d2F5Lg0KDQo+IA0KPj4gT3IgaWYgeW91IG1lYW4gd3JpdGluZyBh
biBhbGxvY2F0b3IgYmFzZWQNCj4+IG9uIG9uY2UtYWxsb2NhdGVkIGJ1ZmZlciBsaWtlIGluIG1p
cnJvciwgSSByZWFsbHkgZGlzbGlrZSB0aGlzIGlkZWEsIGFzIHdlIGFscmVhZHkgaGF2ZQ0KPj4g
YWxsb2NhdG9yOiBtZW1hbGlnbi9tYWxsb2MvZnJlZSBhbmQgaXQgd29ya3Mgd2VsbCwgbm8gcmVh
c29uIHRvIGludmVudCBhIG5ldyBvbmUgYW5kDQo+PiBoYXJkY29kZSBpdCBpbnRvIGJsb2NrIGxh
eWVyIChsb29rIGF0IG15IGFuc3dlciB0byBFcmljIG9uIHYyIG9mIHRoaXMgcGF0Y2ggZm9yIG1v
cmUgaW5mbykuDQo+IA0KPiBXZWxsLCBhdCBsZWFzdCBpdOKAmWQgYmUgc29tZXRoaW5nIHdlIGNh
biBkZWxheSB1bnRpbCBibG9ja2Rldi1jb3B5DQo+IGFycml2ZXMoVE0pLg0KPiANCj4gTWF4DQo+
IA0KPj4gT3IsIGlmIHlvdSBtZWFuIG9ubHkgYmFja3VwX2xvb3AgZ2VuZXJhdGVkIGNvcHktcmVx
dWVzdHMsIHllcyB3ZSBtYXkga2VlcCBvbmx5IG9uZSBidWZmZXIgZm9yIHRoZW0sDQo+PiBidXQ6
DQo+PiAxLiBpdCBpcyBub3QgaG93IGl0IHdvcmtzIG5vdywgc28gbXkgcGF0Y2ggaXMgbm90IGEg
ZGVncmFkYXRpb24gaW4gdGhpcyBjYXNlDQo+PiAyLiBJJ20gZ29pbmcgdG8gcGFyYWxsZWxpemUg
YmFja3VwIGxvb3AgdG9vLCBsaWtlIG15IHNlcmllcyAicWNvdzI6IGFzeW5jIGhhbmRsaW5nIG9m
IGZyYWdtZW50ZWQgaW8iLA0KPj4gICAgICB3aGljaCB3aWxsIG5lZWQgc2V2ZXJhbCBhbGxvY2F0
ZWQgYnVmZmVycyBhbnl3YXkuDQo+Pg0KPj4+DQo+Pj4+ICAgICAgICAgICAgICAgIHJldCA9IGJh
Y2t1cF9jb3dfd2l0aF9ib3VuY2VfYnVmZmVyKGpvYiwgc3RhcnQsIGRpcnR5X2VuZCwNCj4+Pj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaXNfd3Jp
dGVfbm90aWZpZXIsDQo+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBlcnJvcl9pc19yZWFkLCAmYm91bmNlX2J1ZmZlcik7DQo+Pj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlcnJvcl9pc19yZWFkLCBi
b3VuY2VfYnVmZmVyKTsNCj4+Pj4gICAgICAgICAgICB9DQo+Pj4+ICAgICAgICAgICAgaWYgKHJl
dCA8IDApIHsNCj4+Pj4gICAgICAgICAgICAgICAgYnJlYWs7DQo+Pj4+DQo+Pj4NCj4+Pg0KPj4N
Cj4+DQo+IA0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

