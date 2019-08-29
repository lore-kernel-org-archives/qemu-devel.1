Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5227AC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1116022CED
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KllQxmke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1116022CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Mhs-0000Eb-8Z
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 11:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i3Mgx-0007vo-6T
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i3Mgu-0007FQ-P6
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:50:30 -0400
Received: from mail-eopbgr60109.outbound.protection.outlook.com
 ([40.107.6.109]:62019 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i3Mgu-0007BD-28
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:50:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IasxFKfdQDO/zdEkZSRp0HaSKnPSNXTGknpA8G0UePmHNwCNTnuuP4bhwrveFGOHE60APnB8vJ5rzgkSRy3R6bqonqEsG+yWyWVbX6hf88Oy0q6P+QUQ4GEkSiWSqNr8cVZG4SLGrfHZDyNyBtC4dIteHuqBpwNObgUpFrxKF38hOwlXOQn84Z3EqMVCa9eCt/SN8slSflyYwHsBvvGslRwn+eBQTiAM0iV6barpPIZFPbG0l90y6WoARR30nABIFYN+nKPgIA/HTwEWbjvnF5XZolm9vKW+l9TSKMN5cgBK7Fj062NR895IT2QyOECuuHmKV3XFfDA1gKxmTyb3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P83ClSpCDNb0oRTzMX9750vxsPVUaCpUUzeYwyeUark=;
 b=njCEoQymYyQpj0ZTR26RNxkBVRl4AttCrUpSS8m8LEDqf0SawtKcO7WKxNL3nQyvWr2Oce6rqCUIu31NsX8VFKoRaN0w7NPrVuJgnSht3bRIv6NdQ62YYAp21CMSz0DzpjJWJccespHznvmPDI9s0NO78BE5d8DRztHl9bE1mLkoeo/S5p0TeW0/ZxNf6unwzBmTnpF5WqN0JEd+k6F95hE89Wx1JtLjSUs944/mWOJtRcsXnbCn0tjDuYlb5cmwCb9fLvuJTwdGcyhgi0ORQWhZG8UKIUPRptaxc/CZNDIxXUnFU4rQxkdnty7jmCxwmR8PmJHWZZmFL78AzCVzAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P83ClSpCDNb0oRTzMX9750vxsPVUaCpUUzeYwyeUark=;
 b=KllQxmkeNL1BJEkR+FNpuru/x1zxQKzwNw7hJ9e935y7pmWl5XPESgnxK+/PtZ8LT5O8kHZLVWLGHFuRPqo+4Ei8TduIlSgez+iJ8eoATvlmHDcjAAoXPGRBVi4LXup6qg9gq6Huzl8aKfV8gAZTx68lIYhyH55JZdhs3kCruto=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB4528.eurprd08.prod.outlook.com (20.179.26.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Thu, 29 Aug 2019 15:50:24 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7%6]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 15:50:24 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Thread-Topic: [Qemu-devel] [PATCH] Fix: fp-test uninitialized member
 floatX::exp
Thread-Index: AQHVRr9xspCki27n+kGlF3NZYO6Lkab5QwaA///S3QCAC4DUgIAKvLeAgAMiAIA=
Date: Thu, 29 Aug 2019 15:50:24 +0000
Message-ID: <3db8a007-f61c-c2ec-0217-3d9f49438857@virtuozzo.com>
References: <1564481593-776647-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <573f907d-5016-60c1-c727-c5444a418e1b@virtuozzo.com>
 <8736i5ntlp.fsf@linaro.org>
 <af72d680-f169-bdba-3b6e-d2da6b820aea@virtuozzo.com>
 <87mufu61l2.fsf@linaro.org>
In-Reply-To: <87mufu61l2.fsf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0008.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::18)
 To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a169fe61-1860-46b4-24c2-08d72c989ac9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB4528; 
x-ms-traffictypediagnostic: VI1PR08MB4528:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB45287C6675B335F316F88E0BF4A20@VI1PR08MB4528.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(6436002)(81166006)(14454004)(8936002)(66574012)(81156014)(53936002)(102836004)(186003)(71200400001)(8676002)(4326008)(54906003)(6116002)(229853002)(99286004)(36756003)(3846002)(31696002)(107886003)(25786009)(31686004)(386003)(86362001)(53546011)(26005)(6506007)(66446008)(2616005)(6246003)(2906002)(14444005)(316002)(64756008)(6916009)(305945005)(446003)(76176011)(476003)(66066001)(486006)(71190400001)(44832011)(52116002)(256004)(6512007)(5660300002)(478600001)(7736002)(11346002)(19627235002)(6486002)(66946007)(66556008)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4528;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0oAZ37Y6pnMFNJtD9dJVOxlU/jPJX8kPUwVTYDIxudtwAp+1gEebZSlYzkaHqVVW9rlEZrB0YgrOiAjBoRmmAWCgCYeJT5uEzybK/iQs5cD4fz8Dy+M0/tbtcffo7Jb1uHnNX93g0u+xVYtibvwEliVvfaxXhTORkI2VO7tYrXe6vmTZuTIOp+w8lM/7C7EZL/k0AI2WmcM12DiwzmPF4o6o6MKFShOf2xQlBD079xsTKyugxvYu82YWVqLsgfyVXXdaYUgui5pNKrF8AoLRffvonXXA4whTjagb/4DewDN2V5zk28YYzbmHSTnV0MBW9Yw0xpEHRqX273DR4JOl4OVb0OirkorYm47kZNy89Bmfl5VLIflUy0WbY+F05kAcaHpYjGWwHkcDWTe2F52fVwozW4GqcgxzW62qPpEz+Eo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36C3E8CBEDDD854A8826EAA96036D0E4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a169fe61-1860-46b4-24c2-08d72c989ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 15:50:24.1628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ehAjM3hbuYuDm514ozSBDf3xYfgPT2M7MUU6S8hxb+ZpYcekwnbNSWzraNQrWyPC4OIGOzI72B2q6T1wbCqsJZSc60u3HppTpNCjtJhxcTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4528
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.109
Subject: Re: [Qemu-devel] [PATCH] Fix: fp-test uninitialized member
 floatX::exp
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
Cc: Denis Lunev <den@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "jhauser@eecs.berkeley.edu" <jhauser@eecs.berkeley.edu>,
 "cota@braap.org" <cota@braap.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI3LzA4LzIwMTkgMTg6NTksIEFsZXggQmVubsOpZSB3cm90ZToNCj4gDQo+IEFuZHJl
eSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPiB3cml0ZXM6DQo+
IA0KPj4gT24gMTMvMDgvMjAxOSAxNToyMSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPj4+DQo+Pj4g
QW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+IHdyaXRl
czoNCj4+Pg0KPj4+PiBQSU5HSU5HLi4uDQo+Pj4NCj4+PiBTb3JyeSBhYm91dCB0aGUgZGVsYXku
IEkgZGlkIGF0dGVtcHQgc2VlIGlmIHRoZSBleGlzdGluZyBjb2RlIHRocmV3IHVwDQo+Pj4gYW55
IGVycm9ycyB3aGVuIGJ1aWx0IHdpdGggY2xhbmcncyB1bmRlZmluZWQgc2FuaXRpemVyLiBJIHRo
aW5rIHRoaXMgaXMNCj4+PiBiZWNhdXNlIHhQdHItPmV4cCB3aWxsIG9ubHkgZ2V0IHJlYWQgaWYg
bm9uZSBvZiB0aGUgeFB0ci0+aXNGT08gcmV0dXJucw0KPj4+IGZhbHNlLiBJbiBhbGwgdGhvc2Ug
Y2FzZXMgeFB0ci0+ZXhwIGlzIHNldC4NCj4+Pg0KPj4+IFdoYXQgcG9pbnRlZCB5b3UgdG93YXJk
cyB0aGlzIG1pc3NpbmcgaW5pdGlhbGlzYXRpb25zPw0KPj4+DQo+Pg0KPj4gSSBhbSBzb3JyeSBh
Ym91dCBtaXNzaW5nIHRoZSBtZXNzYWdlLiBJdCBhcHBlYXJlZCBpbiBvdGhlciBlbWFpbCB0aHJl
YWQNCj4+IHdoZXJlIEkgZGlkbid0IGV4cGVjdC4gU28sIEkgbWlzc2VkIHRoZSByZXNwb25zZS4N
Cj4+IFdoZW4gSSByYW4gdGhlIGZwLXRlc3RzIHVuZGVyIHRoZSBWYWxncmluZCwgSSBnb3QgbG90
cyBvZiByZXBvcnRzIGFib3V0DQo+PiB1c2luZyB1bmluaXRpYWxpemVkIG1lbW9yeS4gVGhleSBh
bGwgZGlzYXBwZWFyZWQgYWZ0ZXIgYXBwbHlpbmcgdGhpcw0KPj4gcGF0Y2guIEkgY29uY2x1ZGVk
IHRoYXQgdGhlcmUgYXJlIHBhdGhzIHRoYXQgdXNlIHhQdHItPmV4cCB1bmluaXRpYWxpemVkLg0K
Pj4NCj4+ICQgL3Vzci9iaW4vdmFsZ3JpbmQgLS1sZWFrLWNoZWNrPW5vIC0tdHJhY2UtY2hpbGRy
ZW49eWVzDQo+PiAtLWtlZXAtc3RhY2t0cmFjZXM9YWxsb2MtYW5kLWZyZWUgLS10cmFjay1vcmln
aW5zPXllcw0KPj4gLS1sb2ctZmlsZT1teXFlbXUtJXAubG9nIG1ha2UgY2hlY2stc29mdGZsb2F0
DQo+IA0KPiBJdCB3b3VsZCBiZSB1c2VmdWwgdG8ga25vdyB3aGF0IHRlc3RzIGFyZSBiZWluZyBy
dW4gKFY9MSB3aWxsIHNob3cgeW91KS4NCj4gSSBjYW4ndCByZXBsaWNhdGUgdGhlIGZhaWx1cmUg
d2l0aDoNCj4gDQo+ICAgIHZhbGdyaW5kIC0tbGVhay1jaGVjaz1ubyAtLXRyYWNlLWNoaWxkcmVu
PXllcyAtLWtlZXAtc3RhY2t0cmFjZXM9YWxsb2MtYW5kLWZyZWUgLS10cmFjay1vcmlnaW5zPXll
cyAuL2ZwLXRlc3QgLXMgLWwgMiAtciBhbGwgIGYxNl90b19mMzIgZjE2X3RvX2Y2NCBmMTZfdG9f
ZjEyOCBmMzJfdG9fZjE2IGYzMl90b19mNjQNCj4gDQoNClRoZXkgYXJlDQoNCi4vZnAtdGVzdCAt
cyAtbCAxIC1yIGFsbCBmMTZfcm91bmRUb0ludCBmMzJfcm91bmRUb0ludCBmNjRfcm91bmRUb0lu
dCANCmYxMjhfcm91bmRUb0ludA0KDQouL2ZwLXRlc3QgLXMgLWwgMSAtciBhbGwgZjE2X2VxIGYz
Ml9lcSBmNjRfZXEgZXh0RjgwX2VxIGYxMjhfZXENCg0KLi9mcC10ZXN0IC1zIC1sIDEgLXIgYWxs
IGYxNl9lcV9zaWduYWxpbmcgZjMyX2VxX3NpZ25hbGluZyANCmY2NF9lcV9zaWduYWxpbmcgZXh0
RjgwX2VxX3NpZ25hbGluZyBmMTI4X2VxX3NpZ25hbGluZw0KDQouL2ZwLXRlc3QgLXMgLWwgMSAt
ciBhbGwgZjE2X2FkZCBmMzJfYWRkIGY2NF9hZGQgZXh0RjgwX2FkZCBmMTI4X2FkZA0KDQouL2Zw
LXRlc3QgLXMgLWwgMSAtciBhbGwgZjE2X3N1YiBmMzJfc3ViIGY2NF9zdWIgZXh0RjgwX3N1YiBm
MTI4X3N1Yg0KDQpBbmRyZXkNCg0KPj4NCj4+ID09NzIwMjY4PT0gQ29uZGl0aW9uYWwganVtcCBv
ciBtb3ZlIGRlcGVuZHMgb24gdW5pbml0aWFsaXNlZCB2YWx1ZShzKQ0KPj4gPT03MjAyNjg9PSAg
ICBhdCAweDExMkM3MjogZmxvYXRYUm91bmRUb0ludCAoc2xvd2Zsb2F0LmM6MTM3MSkNCj4+ID09
NzIwMjY4PT0gICAgYnkgMHgxMTU5MjA6IHNsb3dfZjE2X3JvdW5kVG9JbnQgKHNsb3dmbG9hdC5j
OjI0MDgpDQo+PiA9PTcyMDI2OD09ICAgIGJ5IDB4MTMzQTg3OiB0ZXN0X2F6X2YxNl9yeCAodGVz
dF9hel9mMTZfcnguYzo3MykNCj4+ID09NzIwMjY4PT0gICAgYnkgMHgxMEU2MzU6IGRvX3Rlc3Rm
bG9hdCAoZnAtdGVzdC5jOjMwNCkNCj4+ID09NzIwMjY4PT0gICAgYnkgMHgxMEZEMDI6IHJ1bl90
ZXN0IChmcC10ZXN0LmM6MTAwMykNCj4+ID09NzIwMjY4PT0gICAgYnkgMHgxMEZEQTQ6IG1haW4g
KGZwLXRlc3QuYzoxMDE3KQ0KPj4gPT03MjAyNjg9PSAgVW5pbml0aWFsaXNlZCB2YWx1ZSB3YXMg
Y3JlYXRlZCBieSBhIHN0YWNrIGFsbG9jYXRpb24NCj4+ID09NzIwMjY4PT0gICAgYXQgMHgxMTU4
RDM6IHNsb3dfZjE2X3JvdW5kVG9JbnQgKHNsb3dmbG9hdC5jOjI0MDQpDQo+Pg0KPj4gPT03MjAz
MTE9PSBDb25kaXRpb25hbCBqdW1wIG9yIG1vdmUgZGVwZW5kcyBvbiB1bmluaXRpYWxpc2VkIHZh
bHVlKHMpDQo+PiA9PTcyMDMxMT09ICAgIGF0IDB4MTEyRTU0OiBmbG9hdFhBZGQgKHNsb3dmbG9h
dC5jOjE0MTEpDQo+PiA9PTcyMDMxMT09ICAgIGJ5IDB4MTE1QTJEOiBzbG93X2YxNl9zdWIgKHNs
b3dmbG9hdC5jOjI0MzEpDQo+PiA9PTcyMDMxMT09ICAgIGJ5IDB4MTMzQ0VDOiB0ZXN0X2Fiel9m
MTYgKHRlc3RfYWJ6X2YxNi5jOjcwKQ0KPj4gPT03MjAzMTE9PSAgICBieSAweDEwRTZENTogZG9f
dGVzdGZsb2F0IChmcC10ZXN0LmM6MzI2KQ0KPj4gPT03MjAzMTE9PSAgICBieSAweDEwRkQwMjog
cnVuX3Rlc3QgKGZwLXRlc3QuYzoxMDAzKQ0KPj4gPT03MjAzMTE9PSAgICBieSAweDEwRkRBNDog
bWFpbiAoZnAtdGVzdC5jOjEwMTcpDQo+PiA9PTcyMDMxMT09ICBVbmluaXRpYWxpc2VkIHZhbHVl
IHdhcyBjcmVhdGVkIGJ5IGEgc3RhY2sgYWxsb2NhdGlvbg0KPj4gPT03MjAzMTE9PSAgICBhdCAw
eDExNTlDMDogc2xvd19mMTZfc3ViIChzbG93ZmxvYXQuYzoyNDI1KQ0KPj4NCj4+ID09NzIwMjcz
PT0gQ29uZGl0aW9uYWwganVtcCBvciBtb3ZlIGRlcGVuZHMgb24gdW5pbml0aWFsaXNlZCB2YWx1
ZShzKQ0KPj4gPT03MjAyNzM9PSAgICBhdCAweDExM0Q1NDogZmxvYXRYRXEgKHNsb3dmbG9hdC5j
OjE2NjEpDQo+PiA9PTcyMDI3Mz09ICAgIGJ5IDB4MTE1RUFEOiBzbG93X2YxNl9lcV9zaWduYWxp
bmcgKHNsb3dmbG9hdC5jOjI1MzgpDQo+PiA9PTcyMDI3Mz09ICAgIGJ5IDB4MTM0MUQzOiB0ZXN0
X2FiX2YxNl96X2Jvb2wgKHRlc3RfYWJfZjE2X3pfYm9vbC5jOjcxKQ0KPj4gPT03MjAyNzM9PSAg
ICBieSAweDEwRTdERTogZG9fdGVzdGZsb2F0IChmcC10ZXN0LmM6MzU4KQ0KPj4gPT03MjAyNzM9
PSAgICBieSAweDEwRkQwMjogcnVuX3Rlc3QgKGZwLXRlc3QuYzoxMDAzKQ0KPj4gPT03MjAyNzM9
PSAgICBieSAweDEwRkRBNDogbWFpbiAoZnAtdGVzdC5jOjEwMTcpDQo+PiA9PTcyMDI3Mz09ICBV
bmluaXRpYWxpc2VkIHZhbHVlIHdhcyBjcmVhdGVkIGJ5IGEgc3RhY2sgYWxsb2NhdGlvbg0KPj4g
PT03MjAyNzM9PSAgICBhdCAweDExNUUzODogc2xvd19mMTZfZXFfc2lnbmFsaW5nIChzbG93Zmxv
YXQuYzoyNTMwKQ0KPj4NCj4+IEV2ZW4gaWYgVmFsZ3JpbmQgaXMgd3JvbmcsIHRoZSBwdXJwb3Nl
IG9mIHRoZSBwYXRjaCBpcyB0byByZWR1Y2UgdGhlDQo+PiBudW1iZXIgb2YgZXJyb3IgcmVwb3J0
cyBmcm9tIHRoZSBWYWxncmluZCB0byBsb2NhdGUgb3RoZXIgbWVtb3J5IHNlcmlvdXMNCj4+IGlz
c3VlcywgaWYgYW55Lg0KPj4NCj4+IEFuZHJleQ0KPj4NCj4+Pj4NCj4+Pj4gT24gMzAvMDcvMjAx
OSAxMzoxMywgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+Pj4+PiBOb3QgYWxsIHRoZSBwYXRo
cyBpbiB0aGUgZnVuY3Rpb25zLCBzdWNoIGFzIGYxNlRvRmxvYXRYKCksIGluaXRpYWxpemUNCj4+
Pj4+IHRoZSBtZW1iZXIgJ2V4cCcgb2YgdGhlIHN0cnVjdHVyZSBmbG9hdFguDQo+Pj4+Pg0KPj4+
Pj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZp
cnR1b3p6by5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+ICAgICBzb3VyY2Uvc2xvd2Zsb2F0LmMgfCA0
ICsrKysNCj4+Pj4+ICAgICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+Pj4+Pg0K
Pj4+Pj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2ZwL2JlcmtlbGV5LXRlc3RmbG9hdC0zL3NvdXJjZS9z
bG93ZmxvYXQuYyBiL3Rlc3RzL2ZwL2JlcmtlbGV5LXRlc3RmbG9hdC0zL3NvdXJjZS9zbG93Zmxv
YXQuYw0KPj4+Pj4gaW5kZXggNGU4NDY1Ni4uNmUwZjBhNiAxMDA2NDQNCj4+Pj4+IC0tLSBhL3Rl
c3RzL2ZwL2JlcmtlbGV5LXRlc3RmbG9hdC0zL3NvdXJjZS9zbG93ZmxvYXQuYw0KPj4+Pj4gKysr
IGIvdGVzdHMvZnAvYmVya2VsZXktdGVzdGZsb2F0LTMvc291cmNlL3Nsb3dmbG9hdC5jDQo+Pj4+
PiBAQCAtNjIzLDYgKzYyMyw3IEBAIHN0YXRpYyB2b2lkIGYxNlRvRmxvYXRYKCBmbG9hdDE2X3Qg
YSwgc3RydWN0IGZsb2F0WCAqeFB0ciApDQo+Pj4+PiAgICAgICAgIHhQdHItPmlzSW5mID0gZmFs
c2U7DQo+Pj4+PiAgICAgICAgIHhQdHItPmlzWmVybyA9IGZhbHNlOw0KPj4+Pj4gICAgICAgICB4
UHRyLT5zaWduID0gKCh1aUEgJiAweDgwMDApICE9IDApOw0KPj4+Pj4gKyAgICB4UHRyLT5leHAg
PSAwOw0KPj4+Pj4gICAgICAgICBleHAgPSB1aUE+PjEwICYgMHgxRjsNCj4+Pj4+ICAgICAgICAg
c2lnNjQgPSB1aUEgJiAweDAzRkY7DQo+Pj4+PiAgICAgICAgIHNpZzY0IDw8PSA0NTsNCj4+Pj4+
IEBAIC03NTksNiArNzYwLDcgQEAgc3RhdGljIHZvaWQgZjMyVG9GbG9hdFgoIGZsb2F0MzJfdCBh
LCBzdHJ1Y3QgZmxvYXRYICp4UHRyICkNCj4+Pj4+ICAgICAgICAgeFB0ci0+aXNJbmYgPSBmYWxz
ZTsNCj4+Pj4+ICAgICAgICAgeFB0ci0+aXNaZXJvID0gZmFsc2U7DQo+Pj4+PiAgICAgICAgIHhQ
dHItPnNpZ24gPSAoKHVpQSAmIDB4ODAwMDAwMDApICE9IDApOw0KPj4+Pj4gKyAgICB4UHRyLT5l
eHAgPSAwOw0KPj4+Pj4gICAgICAgICBleHAgPSB1aUE+PjIzICYgMHhGRjsNCj4+Pj4+ICAgICAg
ICAgc2lnNjQgPSB1aUEgJiAweDAwN0ZGRkZGOw0KPj4+Pj4gICAgICAgICBzaWc2NCA8PD0gMzI7
DQo+Pj4+PiBAQCAtODk1LDYgKzg5Nyw3IEBAIHN0YXRpYyB2b2lkIGY2NFRvRmxvYXRYKCBmbG9h
dDY0X3QgYSwgc3RydWN0IGZsb2F0WCAqeFB0ciApDQo+Pj4+PiAgICAgICAgIHhQdHItPmlzSW5m
ID0gZmFsc2U7DQo+Pj4+PiAgICAgICAgIHhQdHItPmlzWmVybyA9IGZhbHNlOw0KPj4+Pj4gICAg
ICAgICB4UHRyLT5zaWduID0gKCh1aUEgJiBVSU5UNjRfQyggMHg4MDAwMDAwMDAwMDAwMDAwICkp
ICE9IDApOw0KPj4+Pj4gKyAgICB4UHRyLT5leHAgPSAwOw0KPj4+Pj4gICAgICAgICBleHAgPSB1
aUE+PjUyICYgMHg3RkY7DQo+Pj4+PiAgICAgICAgIHNpZzY0ID0gdWlBICYgVUlOVDY0X0MoIDB4
MDAwRkZGRkZGRkZGRkZGRiApOw0KPj4+Pj4gICAgICAgICBpZiAoIGV4cCA9PSAweDdGRiApIHsN
Cj4+Pj4+IEBAIC0xMjIwLDYgKzEyMjMsNyBAQCBzdGF0aWMgdm9pZCBmMTI4TVRvRmxvYXRYKCBj
b25zdCBmbG9hdDEyOF90ICphUHRyLCBzdHJ1Y3QgZmxvYXRYICp4UHRyICkNCj4+Pj4+ICAgICAg
ICAgeFB0ci0+aXNaZXJvID0gZmFsc2U7DQo+Pj4+PiAgICAgICAgIHVpQTY0ID0gdWlBUHRyLT52
NjQ7DQo+Pj4+PiAgICAgICAgIHhQdHItPnNpZ24gPSAoKHVpQTY0ICYgVUlOVDY0X0MoIDB4ODAw
MDAwMDAwMDAwMDAwMCApKSAhPSAwKTsNCj4+Pj4+ICsgICAgeFB0ci0+ZXhwID0gMDsNCj4+Pj4+
ICAgICAgICAgZXhwID0gdWlBNjQ+PjQ4ICYgMHg3RkZGOw0KPj4+Pj4gICAgICAgICBzaWcudjY0
ID0gdWlBNjQgJiBVSU5UNjRfQyggMHgwMDAwRkZGRkZGRkZGRkZGICk7DQo+Pj4+PiAgICAgICAg
IHNpZy52MCAgPSB1aUFQdHItPnYwOw0KPj4+Pj4NCj4+Pg0KPj4+DQo+Pj4gLS0NCj4+PiBBbGV4
IEJlbm7DqWUNCj4+Pg0KPiANCj4gDQo+IC0tDQo+IEFsZXggQmVubsOpZQ0KPiANCg0KLS0gDQpX
aXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmljaA0KDQo=

