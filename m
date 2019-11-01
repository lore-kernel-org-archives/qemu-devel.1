Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5507CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 09:25:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8865920656
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 09:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mAB6iQLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8865920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQTBA-0007vI-57
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 05:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iQT8H-0006uz-55
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 05:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iQT89-0002sj-SA
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 05:22:11 -0400
Received: from mail-eopbgr40138.outbound.protection.outlook.com
 ([40.107.4.138]:20030 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iQT80-0001ss-PB; Fri, 01 Nov 2019 05:21:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBjDIW0uLioEAyj2prd4Q6zdb32YxrCdHK6RyszfGHto6Z9cUnQabxbaXzMgGKzpwcdgk0gOdD0Bm97ex6/Xv0ZaWcKzHMP7vmVNl2AD2gi8PFcshp4gl9v12tK91OAsSD90zjj98t/soFg5euum8+ISOqC7ilzq8GkE5UrxwhuKp0crqRSBNKadRDn7vEZYXjiIojFT86Ehq/neHvXhvw7P+yW2viPfU41p7K8KSpoARwQ9VKJgylBx4/+hi2GtZqVpo0da5iLrtKs6s3NBWmCt8S2CyEommyWqSV3g5fXuLSrD6K2BF2Rtz8C6knNvmga0763GpOWKOeDH9ZAmjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjZ7SnadZhhmI5PPhEC2eKwGkmXMPVu+oZN5veOJ/nc=;
 b=dYl7zMCPPz1ty82DRFFCcUrFsR8FOfzlYxMuz1DSlgPrfGMsHDxgHQ6O47I74AJ2zMVOgu7ZGM8DKgMMXVCficLqREGQ0kS8yNLAE5OZmMsyAriMeVlrzQWI70MTx3BqGppHigzvAqpVyd26CbUAff/1u9A3khh4pMuGPPc8jEwXYaigK5SKF26fQR27MGHrhPqdUYeF0rqPL+1d3Dor1kSGKTi/r6Xr1QiXw4zHEqs7vorGj1Au9MA8DRExfFELFFmHNg/mwBwquX3bhVSJI5mMjpNSOy8W3C4nXid8jEM7To4YTN548UN57GARWzYhU9JYWoQ977BJ8BrKSmJhWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjZ7SnadZhhmI5PPhEC2eKwGkmXMPVu+oZN5veOJ/nc=;
 b=mAB6iQLo20cx1RpW7YQmzLa8BgUuxo5ccPmyALTtvc6VRb3ymfA78MsPYgxaFupIXKbG+q3/S9RG+i/2cIjDT3vwlNeRbP6F2ftlxx2ex00bJkcb7Lh6Qw7KKZXaQJ/KqChtYnsEy4+05rBMKBy2/w7OLhx/DaW1B+CVQImmPxk=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB4563.eurprd08.prod.outlook.com (20.178.202.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Fri, 1 Nov 2019 09:21:51 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119%6]) with mapi id 15.20.2408.019; Fri, 1 Nov 2019
 09:21:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Tuguoyi <tu.guoyi@h3c.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v4] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Topic: [PATCH v4] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Index: AdWQhrb0bffMwMc6ShSREntjykPuIgADxL+A
Date: Fri, 1 Nov 2019 09:21:51 +0000
Message-ID: <8b7d3d50-4a29-a8b3-5b6c-cde4af1b1d7a@virtuozzo.com>
References: <4ba40cd1e7ee4a708b40899952e49f22@h3c.com>
In-Reply-To: <4ba40cd1e7ee4a708b40899952e49f22@h3c.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0053.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::42)
 To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191101122149560
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1742f298-6204-4826-9341-08d75eacee05
x-ms-traffictypediagnostic: AM0PR08MB4563:
x-microsoft-antispam-prvs: <AM0PR08MB4563055EFBB711BB93861BF4C1620@AM0PR08MB4563.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:49;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(366004)(376002)(396003)(39840400004)(199004)(189003)(81156014)(54906003)(110136005)(316002)(66476007)(66556008)(64756008)(66446008)(66946007)(36756003)(2501003)(6246003)(2906002)(5660300002)(6512007)(4326008)(6436002)(81166006)(2616005)(446003)(11346002)(7736002)(476003)(386003)(6506007)(71190400001)(66066001)(478600001)(305945005)(86362001)(102836004)(26005)(99286004)(6486002)(76176011)(31686004)(52116002)(486006)(2201001)(229853002)(3846002)(6116002)(256004)(186003)(25786009)(31696002)(7416002)(14454004)(71200400001)(8676002)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4563;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b8wv2ItSUz8UaYHcweuPopGIfgobU0igeMqEbbcb55ImjcMhEZMOTmTg3X6eHQ+qmCSYAP0/vY9bno7Eyl8v5FyFhJA9lxSdi+zcMYlUt/cTCAOmRVjhTE1m0uzsnyFv5HtZ1q8qasinc99uuQxWl8p1qQ6bQhXv7mRQlv5iBKHJUqmSHHn79ntPKmiYp3qgcrca3KwhVNnYXtqntF0ikyUYrjWWoxLFb960Y17pLNANGM7TOSlpGRgcHHtfD75BXGYLL4T23SOc0ljBbEQsR66O6jDt9RMmpXC0xuDUXb5gA4jNEfq46iIKdbPAsPAM+FbzCyPrN5YL9GJm8E6/e6cym2TCEO56q0XzJh79c1dYfmZVu9y2PIaweltXfoDozokDs4QI+KCDq8fPJtqYPSDOVoe0YVZvJZ1mE5gO3+TYfu81e7zXydatSrER+z9q
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DC6819F2817CF44AD59237C3EEF5821@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1742f298-6204-4826-9341-08d75eacee05
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 09:21:51.8832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ILaMopRLQPBq4Ea9wblmRSPoNvYwbnFCWBuWCYq1GGBGWcLuQ/7K4lQJS3VNOBKdwg+A9NzEXpM+ASxVdCqaIDq9dyyC7BIteeAglQmn+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4563
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.138
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
Cc: Chengchiwen <chengchiwen@h3c.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 Wangyongqing <w_yongqing@h3c.com>, Changlimin <changlimin@h3c.com>,
 Gaoliang <liang_gao@h3c.com>, Wangyong <wang.yongD@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTEuMjAxOSAxMDozNywgVHVndW95aSB3cm90ZToNCj4gVGhlcmUgYXJlIHR3byBpc3N1ZXMg
aW4gSW4gY2hlY2tfY29uc3RyYWludHNfb25fYml0bWFwKCksDQo+IDEpIFRoZSBzYW5pdHkgY2hl
Y2sgb24gdGhlIGdyYW51bGFyaXR5IHdpbGwgY2F1c2UgdWludDY0X3QNCj4gaW50ZWdlciBsZWZ0
LXNoaWZ0IG92ZXJmbG93IHdoZW4gY2x1c3Rlcl9zaXplIGlzIDJNIGFuZCB0aGUNCj4gZ3JhbnVs
YXJpdHkgaXMgQklHR0VSIHRoYW4gMzJLLg0KPiAyKSBUaGUgd2F5IHRvIGNhbGN1bGF0ZSBpbWFn
ZSBzaXplIHRoYXQgdGhlIG1heGltdW0gYml0bWFwDQo+IHN1cHBvcnRlZCBjYW4gbWFwIHRvIGlz
IGEgYml0IGluY29ycmVjdC4NCj4gVGhpcyBwYXRjaCBmaXggaXQgYnkgYWRkIGEgaGVscGVyIGZ1
bmN0aW9uIHRvIGNhbGN1bGF0ZSB0aGUNCj4gbnVtYmVyIG9mIGJ5dGVzIG5lZWRlZCBieSBhIG5v
cm1hbCBiaXRtYXAgaW4gaW1hZ2UgYW5kIGNvbXBhcmUNCj4gaXQgdG8gdGhlIG1heGltdW0gYml0
bWFwIGJ5dGVzIHN1cHBvcnRlZCBieSBxZW11Lg0KPiANCj4gRml4ZXM6IDVmNzI4MjZlN2ZjNjIx
NjdjZjNhDQo+IFNpZ25lZC1vZmYtYnk6IEd1b3lpIFR1IDx0dS5ndW95aUBoM2MuY29tPg0KDQpZ
b3UgZm9yZ2V0IG15DQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8
dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQooSSBkb24ndCBzZWUgY2hhbmdlcyBleGNlcHQg
YWRkICJGaXhlczogIiB0byBjb21taXQgbXNnIGFuZCBwdXQgZ2V0X2JpdG1hcF9ieXRlc19uZWVk
ZWQNCmRlZmluaXRpb24gaGVhZGVyIGludG8gb25lIGxpbmUuKQ0KDQo+IC0tLQ0KPiAgIGJsb2Nr
L3Fjb3cyLWJpdG1hcC5jIHwgMTQgKysrKysrKysrKystLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwg
MTEgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9j
ay9xY293Mi1iaXRtYXAuYyBiL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jDQo+IGluZGV4IDk4Mjk0YTcu
LmVmOWVmNjIgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jDQo+ICsrKyBiL2Js
b2NrL3Fjb3cyLWJpdG1hcC5jDQo+IEBAIC0xNDIsNiArMTQyLDEzIEBAIHN0YXRpYyBpbnQgY2hl
Y2tfdGFibGVfZW50cnkodWludDY0X3QgZW50cnksIGludCBjbHVzdGVyX3NpemUpDQo+ICAgICAg
IHJldHVybiAwOw0KPiAgIH0NCj4gICANCj4gK3N0YXRpYyBpbnQ2NF90IGdldF9iaXRtYXBfYnl0
ZXNfbmVlZGVkKGludDY0X3QgbGVuLCB1aW50MzJfdCBncmFudWxhcml0eSkNCj4gK3sNCj4gKyAg
ICBpbnQ2NF90IG51bV9iaXRzID0gRElWX1JPVU5EX1VQKGxlbiwgZ3JhbnVsYXJpdHkpOw0KPiAr
DQo+ICsgICAgcmV0dXJuIERJVl9ST1VORF9VUChudW1fYml0cywgOCk7DQo+ICt9DQo+ICsNCj4g
ICBzdGF0aWMgaW50IGNoZWNrX2NvbnN0cmFpbnRzX29uX2JpdG1hcChCbG9ja0RyaXZlclN0YXRl
ICpicywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBj
aGFyICpuYW1lLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVp
bnQzMl90IGdyYW51bGFyaXR5LA0KPiBAQCAtMTUwLDYgKzE1Nyw3IEBAIHN0YXRpYyBpbnQgY2hl
Y2tfY29uc3RyYWludHNfb25fYml0bWFwKEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPiAgICAgICBC
RFJWUWNvdzJTdGF0ZSAqcyA9IGJzLT5vcGFxdWU7DQo+ICAgICAgIGludCBncmFudWxhcml0eV9i
aXRzID0gY3R6MzIoZ3JhbnVsYXJpdHkpOw0KPiAgICAgICBpbnQ2NF90IGxlbiA9IGJkcnZfZ2V0
bGVuZ3RoKGJzKTsNCj4gKyAgICBpbnQ2NF90IGJpdG1hcF9ieXRlczsNCj4gICANCj4gICAgICAg
YXNzZXJ0KGdyYW51bGFyaXR5ID4gMCk7DQo+ICAgICAgIGFzc2VydCgoZ3JhbnVsYXJpdHkgJiAo
Z3JhbnVsYXJpdHkgLSAxKSkgPT0gMCk7DQo+IEBAIC0xNzEsOSArMTc5LDkgQEAgc3RhdGljIGlu
dCBjaGVja19jb25zdHJhaW50c19vbl9iaXRtYXAoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICAg
ICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gICAgICAgfQ0KPiAgIA0KPiAtICAgIGlmICgobGVu
ID4gKHVpbnQ2NF90KUJNRV9NQVhfUEhZU19TSVpFIDw8IGdyYW51bGFyaXR5X2JpdHMpIHx8DQo+
IC0gICAgICAgIChsZW4gPiAodWludDY0X3QpQk1FX01BWF9UQUJMRV9TSVpFICogcy0+Y2x1c3Rl
cl9zaXplIDw8DQo+IC0gICAgICAgICAgICAgICBncmFudWxhcml0eV9iaXRzKSkNCj4gKyAgICBi
aXRtYXBfYnl0ZXMgPSBnZXRfYml0bWFwX2J5dGVzX25lZWRlZChsZW4sIGdyYW51bGFyaXR5KTsN
Cj4gKyAgICBpZiAoKGJpdG1hcF9ieXRlcyA+ICh1aW50NjRfdClCTUVfTUFYX1BIWVNfU0laRSkg
fHwNCj4gKyAgICAgICAgKGJpdG1hcF9ieXRlcyA+ICh1aW50NjRfdClCTUVfTUFYX1RBQkxFX1NJ
WkUgKiBzLT5jbHVzdGVyX3NpemUpKQ0KPiAgICAgICB7DQo+ICAgICAgICAgICBlcnJvcl9zZXRn
KGVycnAsICJUb28gbXVjaCBzcGFjZSB3aWxsIGJlIG9jY3VwaWVkIGJ5IHRoZSBiaXRtYXAuICIN
Cj4gICAgICAgICAgICAgICAgICAgICAgIlVzZSBsYXJnZXIgZ3JhbnVsYXJpdHkiKTsNCj4gDQoN
Cg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

