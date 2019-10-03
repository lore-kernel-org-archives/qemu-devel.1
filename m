Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8656CC32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 14:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CCB120865
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 14:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UVH9Qp3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCB120865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG2G7-00062x-1e
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 10:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iG2Eq-000591-BP
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 10:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iG2Em-0002I6-3v
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 10:37:49 -0400
Received: from mail-db5eur03on0714.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::714]:22852
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iG2EV-00026r-Hf; Thu, 03 Oct 2019 10:37:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKskIiL76MmUO4wdpbQdVrw8g89zE+FWdoLL2HmP5Xexz8jVkSK5GEkldhVZTE8kuAHRHNPQ0D8UMD8gyhYux24uKdhV/vGng0kkGMHoco3eFTw+6GOXVnRCd83xj7WXmpiWFp6rqqUvqSKpXUwySAq+BQhUv9oDeSkxOtl9rExgrJDF2LZAR7ANXNmjAZAlV+MuQ0be1tB/VUM2HABbTk9PzlrzQGwnmA5H0M7157oKaEHsZpqMCGyRdW0Dcn/yir56SoycDySB3bMPAgR//7lz5aEoB45RoKxOhyHlOWnQ+mvsEGEy+Dxvj5vaIJRM2QKizcgsWXLyWKVBsiZgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahBHpRmTC/RWd49z0YSSKKkI1HPMx6Ch0KF0DFB/du8=;
 b=DyCij7XuPL0zHFLRESx1m1+b5O3eJA+pWCSR26Yb5mBl5OC9hfCUg0hxTOe7B+I7K/wekFXDjG2uFFsOlBAhvU+DJwXfEkX+AWctpUlJplOWRqi/C3uYk+/r7/LAfv4tnosfvsoFn23GKtTM+BXp2DninSi9WLhkeyErR1OJ5kr7kxaY2NvDDL1uoEWi9C5Qj4x3GFBvO10goDBL73Eb1N2QU+zCvFI1Kt+wm6POhIoXUk3eC01AhE3Md7ZwVYrEiL663cR6Dc8wapoE/7dMO4jjWA0FV6TAkFGWhfT5hFlgUAcvgE9qfDAqLRBC2k0Nj7oOjIRJHzUOBdyPDA82+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahBHpRmTC/RWd49z0YSSKKkI1HPMx6Ch0KF0DFB/du8=;
 b=UVH9Qp3OaQYpUOFVDM7AplnLbLbYs1qs09i/sB2jyvLSid5Wy7ZERfWXbFutm267P5JKK6PVxcLIn3zgDYrL24V8kgQ7K4EWJiWvDFn25B+YOXPZJNu5BjkUNMr9ZeuJGwJ1Ezan6DBy1502ILp5VqCoPCCfpby8tbje+SnUqf8=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5114.eurprd08.prod.outlook.com (10.255.17.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Thu, 3 Oct 2019 14:37:27 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 14:37:27 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 4/6] block: support compressed write for copy-on-read
Thread-Topic: [PATCH v2 4/6] block: support compressed write for copy-on-read
Thread-Index: AQHVeSzo5Hv5JaUA30qiiTNCQUr6UadI/coA
Date: Thu, 3 Oct 2019 14:37:27 +0000
Message-ID: <aee7e0ef-a8d2-96ba-3a38-01b58da4ffe7@virtuozzo.com>
References: <1570026166-748566-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1570026166-748566-5-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1570026166-748566-5-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0232.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::32) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191003173724506
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4702bd15-e52e-424d-8115-08d7480f3679
x-ms-traffictypediagnostic: DB8PR08MB5114:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB51146E58D42766D143D0636CC19F0@DB8PR08MB5114.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39840400004)(376002)(136003)(346002)(366004)(189003)(199004)(54906003)(66066001)(2906002)(229853002)(8676002)(6436002)(476003)(486006)(6512007)(102836004)(31696002)(5660300002)(26005)(3846002)(11346002)(52116002)(446003)(2616005)(6116002)(186003)(6506007)(386003)(316002)(6486002)(66556008)(6246003)(478600001)(2201001)(66946007)(86362001)(31686004)(36756003)(71200400001)(71190400001)(66476007)(76176011)(2501003)(110136005)(64756008)(4326008)(14454004)(107886003)(66446008)(8936002)(25786009)(305945005)(7736002)(99286004)(14444005)(81156014)(81166006)(256004)(7416002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5114;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f4XEYB/97FPv12I367nRsiCW5wXYnzB+WMroaqbVqYqcb7IXnybeRP0mO1HYsYqWS6kcC5dBH1c4qMzJNgCnUJyjoEUs8z6bxv5e08twoOk/fXQ1oP4z2Y+/Otejl43xyNSerQH5VWJNMKU22RbYGIBwweHv9mGE0sRiNSmuZZJ9wGLRzcG81hwnZhFds+qtMo3wrbNJJ5Le0OrMXeP2cZ5Qk5xNBUy5zq8yddfWSnfhCeAYhcUargFC+qvfhd8FNEpJ55sxG0j5fLMPG5mq6urxN04BQDAeWSkCV4KGHq+bPFPr8vn5EoW5tNSeZFfL/roDrJ3X1YSDmVzteDqCJlIDEELlrL+1/ndxW1m0/7mAQkqvTXpLq10c6zMtK8OjmZdOsMkpWlyO8CNAFcd99JfhHhfK1tv+PKLlqx1fYGY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F09F3AFA02348446AE6F7FC83F6BB87F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4702bd15-e52e-424d-8115-08d7480f3679
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 14:37:27.3587 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mtR6HAp0Zvz7idqPHXbs9ggtzC8JXrC9LYemg5xeKUeB3cddxE0sAq+EZilAYNA4e92fB/BkvGMB42HYMyAKDs9rMLoTSmCenYTOqlXYZTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5114
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0a::714
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
 Denis Lunev <den@virtuozzo.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDIuMTAuMjAxOSAxNzoyMiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IFN1cHBvcnQgdGhl
IGRhdGEgY29tcHJlc3Npb24gZHVyaW5nIGJsb2NrLXN0cmVhbSBqb2Igb3ZlciBhIGJhY2t1cA0K
PiBiYWNraW5nIGNoYWluIGltcGxlbWVudGVkIGluIHRoZSBmb2xsb3dpbmcgcGF0Y2ggJ2Jsb2Nr
LXN0cmVhbToNCj4gYWRkIGNvbXByZXNzIG9wdGlvbicuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBB
bnRvbiBOZWZlZG92IDxhbnRvbi5uZWZlZG92QHZpcnR1b3p6by5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IERlbmlzIFYuIEx1bmV2IDxkZW5Ab3BlbnZ6Lm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogQW5k
cmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQo+IC0tLQ0K
PiAgIGJsb2NrL2lvLmMgICAgICAgICB8IDIxICsrKysrKysrKysrKysrKystLS0tLQ0KPiAgIGJs
b2NrL3RyYWNlLWV2ZW50cyB8ICAyICstDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRp
b25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2lvLmMgYi9i
bG9jay9pby5jDQo+IGluZGV4IGY4YzM1OTYuLmE3Y2QyNGYgMTAwNjQ0DQo+IC0tLSBhL2Jsb2Nr
L2lvLmMNCj4gKysrIGIvYmxvY2svaW8uYw0KPiBAQCAtMTI2NCwxMiArMTI2NCwxMyBAQCBzdGF0
aWMgaW50IGNvcm91dGluZV9mbiBiZHJ2X2NvX2RvX2NvcHlfb25fcmVhZHYoQmRydkNoaWxkICpj
aGlsZCwNCj4gICAgICAgICogYWxsb2NhdGluZyBjbHVzdGVyIGluIHRoZSBpbWFnZSBmaWxlLiAg
Tm90ZSB0aGF0IHRoaXMgdmFsdWUgbWF5IGV4Y2VlZA0KPiAgICAgICAgKiBCRFJWX1JFUVVFU1Rf
TUFYX0JZVEVTIChldmVuIHdoZW4gdGhlIG9yaWdpbmFsIHJlYWQgZGlkIG5vdCksIHdoaWNoDQo+
ICAgICAgICAqIGlzIG9uZSByZWFzb24gd2UgbG9vcCByYXRoZXIgdGhhbiBkb2luZyBpdCBhbGwg
YXQgb25jZS4NCj4gKyAgICAgKiBBbHNvLCB0aGlzIGlzIGNydWNpYWwgZm9yIGNvbXByZXNzZWQg
Y29weS1vbi1yZWFkLg0KPiAgICAgICAgKi8NCj4gICAgICAgYmRydl9yb3VuZF90b19jbHVzdGVy
cyhicywgb2Zmc2V0LCBieXRlcywgJmNsdXN0ZXJfb2Zmc2V0LCAmY2x1c3Rlcl9ieXRlcyk7DQo+
ICAgICAgIHNraXBfYnl0ZXMgPSBvZmZzZXQgLSBjbHVzdGVyX29mZnNldDsNCj4gICANCj4gICAg
ICAgdHJhY2VfYmRydl9jb19kb19jb3B5X29uX3JlYWR2KGJzLCBvZmZzZXQsIGJ5dGVzLA0KPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbHVzdGVyX29mZnNldCwgY2x1c3Rl
cl9ieXRlcyk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsdXN0ZXJf
b2Zmc2V0LCBjbHVzdGVyX2J5dGVzLCBmbGFncyk7DQo+ICAgDQo+ICAgICAgIHdoaWxlIChjbHVz
dGVyX2J5dGVzKSB7DQo+ICAgICAgICAgICBpbnQ2NF90IHBudW07DQo+IEBAIC0xMzI4LDkgKzEz
MjksMTUgQEAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4gYmRydl9jb19kb19jb3B5X29uX3JlYWR2
KEJkcnZDaGlsZCAqY2hpbGQsDQo+ICAgICAgICAgICAgICAgICAgIC8qIFRoaXMgZG9lcyBub3Qg
Y2hhbmdlIHRoZSBkYXRhIG9uIHRoZSBkaXNrLCBpdCBpcyBub3QNCj4gICAgICAgICAgICAgICAg
ICAgICogbmVjZXNzYXJ5IHRvIGZsdXNoIGV2ZW4gaW4gY2FjaGU9d3JpdGV0aHJvdWdoIG1vZGUu
DQo+ICAgICAgICAgICAgICAgICAgICAqLw0KPiAtICAgICAgICAgICAgICAgIHJldCA9IGJkcnZf
ZHJpdmVyX3B3cml0ZXYoYnMsIGNsdXN0ZXJfb2Zmc2V0LCBwbnVtLA0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmxvY2FsX3Fpb3YsIDAsDQo+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCRFJWX1JFUV9XUklURV9VTkNIQU5H
RUQpOw0KPiArICAgICAgICAgICAgICAgIGlmIChmbGFncyAmIEJEUlZfUkVRX1dSSVRFX0NPTVBS
RVNTRUQpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgcmV0ID0gYmRydl9kcml2ZXJfcHdyaXRl
dl9jb21wcmVzc2VkKGJzLCBjbHVzdGVyX29mZnNldCwNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBudW0sICZsb2NhbF9xaW92LA0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcWlvdl9vZmZzZXQpOw0KDQpxaW92X29mZnNldCBpcyB3cm9uZzogeW91IHNob3VsZCB1c2Ug
MCB0b2dldGhlciB3aXRoIGxvY2FsX3Fpb3YsIGFzIGxvY2FsX3Fpb3YgaXMgYnVmZmVyIHdpdGgN
CmRhdGEgdG8gYmUgd3JpdHRlbi4NCg0KPiArICAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+ICsg
ICAgICAgICAgICAgICAgICAgIHJldCA9IGJkcnZfZHJpdmVyX3B3cml0ZXYoYnMsIGNsdXN0ZXJf
b2Zmc2V0LCBwbnVtLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICZsb2NhbF9xaW92LCAwLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEJEUlZfUkVRX1dSSVRFX1VOQ0hBTkdFRCk7DQo+ICsgICAgICAgICAg
ICAgICAgfQ0KPiAgICAgICAgICAgICAgIH0NCj4gICANCj4gICAgICAgICAgICAgICBpZiAocmV0
IDwgMCkgew0KPiBAQCAtMTM5Niw3ICsxNDAzLDExIEBAIHN0YXRpYyBpbnQgY29yb3V0aW5lX2Zu
IGJkcnZfYWxpZ25lZF9wcmVhZHYoQmRydkNoaWxkICpjaGlsZCwNCj4gICAgICAgICogdG8gcGFz
cyB0aHJvdWdoIHRvIGRyaXZlcnMuICBGb3Igbm93LCB0aGVyZSBhcmVuJ3QgYW55DQo+ICAgICAg
ICAqIHBhc3N0aHJvdWdoIGZsYWdzLiAgKi8NCj4gICAgICAgYXNzZXJ0KCEoZmxhZ3MgJiB+KEJE
UlZfUkVRX05PX1NFUklBTElTSU5HIHwgQkRSVl9SRVFfQ09QWV9PTl9SRUFEIHwNCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgQkRSVl9SRVFfUFJFRkVUQ0gpKSk7DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIEJEUlZfUkVRX1BSRUZFVENIIHwgQkRSVl9SRVFfV1JJVEVfQ09NUFJFU1NFRCkp
KTsNCj4gKw0KPiArICAgIC8qIHdyaXRlIGNvbXByZXNzZWQgb25seSBtYWtlcyBzZW5zZSB3aXRo
IGNvcHkgb24gcmVhZCAqLw0KPiArICAgIGFzc2VydCghKGZsYWdzICYgQkRSVl9SRVFfV1JJVEVf
Q09NUFJFU1NFRCkgfHwNCj4gKyAgICAgICAgICAgKGZsYWdzICYgQkRSVl9SRVFfQ09QWV9PTl9S
RUFEKSk7DQo+ICAgDQo+ICAgICAgIC8qIEhhbmRsZSBDb3B5IG9uIFJlYWQgYW5kIGFzc29jaWF0
ZWQgc2VyaWFsaXNhdGlvbiAqLw0KPiAgICAgICBpZiAoZmxhZ3MgJiBCRFJWX1JFUV9DT1BZX09O
X1JFQUQpIHsNCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL3RyYWNlLWV2ZW50cyBiL2Jsb2NrL3RyYWNl
LWV2ZW50cw0KPiBpbmRleCAzYWEyN2U2Li5mNDQ0NTQ4IDEwMDY0NA0KPiAtLS0gYS9ibG9jay90
cmFjZS1ldmVudHMNCj4gKysrIGIvYmxvY2svdHJhY2UtZXZlbnRzDQo+IEBAIC0xNCw3ICsxNCw3
IEBAIGJsa19yb290X2RldGFjaCh2b2lkICpjaGlsZCwgdm9pZCAqYmxrLCB2b2lkICpicykgImNo
aWxkICVwIGJsayAlcCBicyAlcCINCj4gICBiZHJ2X2NvX3ByZWFkdih2b2lkICpicywgaW50NjRf
dCBvZmZzZXQsIGludDY0X3QgbmJ5dGVzLCB1bnNpZ25lZCBpbnQgZmxhZ3MpICJicyAlcCBvZmZz
ZXQgJSJQUklkNjQiIG5ieXRlcyAlIlBSSWQ2NCIgZmxhZ3MgMHgleCINCj4gICBiZHJ2X2NvX3B3
cml0ZXYodm9pZCAqYnMsIGludDY0X3Qgb2Zmc2V0LCBpbnQ2NF90IG5ieXRlcywgdW5zaWduZWQg
aW50IGZsYWdzKSAiYnMgJXAgb2Zmc2V0ICUiUFJJZDY0IiBuYnl0ZXMgJSJQUklkNjQiIGZsYWdz
IDB4JXgiDQo+ICAgYmRydl9jb19wd3JpdGVfemVyb2VzKHZvaWQgKmJzLCBpbnQ2NF90IG9mZnNl
dCwgaW50IGNvdW50LCBpbnQgZmxhZ3MpICJicyAlcCBvZmZzZXQgJSJQUklkNjQiIGNvdW50ICVk
IGZsYWdzIDB4JXgiDQo+IC1iZHJ2X2NvX2RvX2NvcHlfb25fcmVhZHYodm9pZCAqYnMsIGludDY0
X3Qgb2Zmc2V0LCB1bnNpZ25lZCBpbnQgYnl0ZXMsIGludDY0X3QgY2x1c3Rlcl9vZmZzZXQsIGlu
dDY0X3QgY2x1c3Rlcl9ieXRlcykgImJzICVwIG9mZnNldCAlIlBSSWQ2NCIgYnl0ZXMgJXUgY2x1
c3Rlcl9vZmZzZXQgJSJQUklkNjQiIGNsdXN0ZXJfYnl0ZXMgJSJQUklkNjQNCj4gK2JkcnZfY29f
ZG9fY29weV9vbl9yZWFkdih2b2lkICpicywgaW50NjRfdCBvZmZzZXQsIHVuc2lnbmVkIGludCBi
eXRlcywgaW50NjRfdCBjbHVzdGVyX29mZnNldCwgaW50NjRfdCBjbHVzdGVyX2J5dGVzLCBpbnQg
ZmxhZ3MpICJicyAlcCBvZmZzZXQgJSJQUklkNjQiIGJ5dGVzICV1IGNsdXN0ZXJfb2Zmc2V0ICUi
UFJJZDY0IiBjbHVzdGVyX2J5dGVzICUiUFJJZDY0IiBmbGFncyAweCV4Ig0KPiAgIGJkcnZfY29f
Y29weV9yYW5nZV9mcm9tKHZvaWQgKnNyYywgdWludDY0X3Qgc3JjX29mZnNldCwgdm9pZCAqZHN0
LCB1aW50NjRfdCBkc3Rfb2Zmc2V0LCB1aW50NjRfdCBieXRlcywgaW50IHJlYWRfZmxhZ3MsIGlu
dCB3cml0ZV9mbGFncykgInNyYyAlcCBvZmZzZXQgJSJQUkl1NjQiIGRzdCAlcCBvZmZzZXQgJSJQ
Ukl1NjQiIGJ5dGVzICUiUFJJdTY0IiBydyBmbGFncyAweCV4IDB4JXgiDQo+ICAgYmRydl9jb19j
b3B5X3JhbmdlX3RvKHZvaWQgKnNyYywgdWludDY0X3Qgc3JjX29mZnNldCwgdm9pZCAqZHN0LCB1
aW50NjRfdCBkc3Rfb2Zmc2V0LCB1aW50NjRfdCBieXRlcywgaW50IHJlYWRfZmxhZ3MsIGludCB3
cml0ZV9mbGFncykgInNyYyAlcCBvZmZzZXQgJSJQUkl1NjQiIGRzdCAlcCBvZmZzZXQgJSJQUkl1
NjQiIGJ5dGVzICUiUFJJdTY0IiBydyBmbGFncyAweCV4IDB4JXgiDQo+ICAgDQo+IA0KDQoNCi0t
IA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

