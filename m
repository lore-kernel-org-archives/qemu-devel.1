Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4305DC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BAB920650
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KaGpkPhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BAB920650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9nA2-0006uB-8z
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 05:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9n94-0006Hb-PA
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9n93-0004GN-Kj
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:18:06 -0400
Received: from mail-eopbgr40090.outbound.protection.outlook.com
 ([40.107.4.90]:56482 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i9n8x-0004DU-GS; Mon, 16 Sep 2019 05:18:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuuX2MU2J0ng+WbTgU7EjbN+2qZXhG0kqa9o4xV1UsgwhQHk+rkOiYTtcI0XeD+axxj+D08irUas1XrVYYXLJZdawhSOz5FKKj46expFERx8UqjFMxwu+LZ7qNnnGRUuAhBdXWQ/Q5rg7uhQqmlwcH1hW0mK1MZQZkFtQYq35EtJLeI18Zht+xFJhnLyJlCg0qYDBB6UVc+WbKXnsXnx9ZHOFGBzBbEDUsEA1wdzBMaiNgfAGsZczfAk9EF5baaeJf/YWSkrpwebmB3ImTkkbrUfavm3hij1fq+XXGu4KcLFc7dTSA5AcmBj1WdPN1MPL1fCNc6jf+VR9HdT64thng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fP8MciSyylP8zW8ESHgOeP7pQiwNlsIqzGfSQkbi/Y=;
 b=DX19unV+hOrmtzDPKcfs1boe4ci+++CiBtEMFfUUDK+MyUIXJZF8WAgbtZGfvF8e56htu6s5EGcosLkh4xvhlvfDsKnSadr7HHTd6Cq8OTQxVKdNkQfJZq9S77cnVmKwh2GiFL1s4DNkCpTrkxFcLGo1DnLw3XJXl3kmt0N4LXJoqwO983ysCNyULzPs7yYrbSkcukP+4LXrsV1dH1dGo3j9aU018cG8uZ8Ii9BwfCSyKq75Lll4P3I3+7wEka2GZhFz7qKiWhw1PA8e7y865eA1dDH3l7R1AVieje+QW4diehyS2rRbJY2ccNBs9yQzycor+iC67VYrIjgFNTeJwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fP8MciSyylP8zW8ESHgOeP7pQiwNlsIqzGfSQkbi/Y=;
 b=KaGpkPhh6o+zngFYLy1uFx8PZ0vTc6iUg65eImZVfBlSZVBxJD8f+dH2/LdsVpGGFkvqPTc5HCqeRcI8uDfOOqve9Uk9QCA6cJ7Ycd7Msr1jZrFeg7Jtq48zF9NJEQC/+/kmu00/XdKzuPAoTjTm5xGw1gm90wIn5hICMpJFPSk=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4569.eurprd08.prod.outlook.com (20.179.12.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Mon, 16 Sep 2019 09:17:57 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 09:17:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v7 2/3] block/qcow2: refactor encryption code
Thread-Index: AQHVbAVY5nM82tZTb0eyHl7RsYB/YqcuBzMA
Date: Mon, 16 Sep 2019 09:17:56 +0000
Message-ID: <5ef46766-5f5b-1d22-560c-d1fe4462d4b4@virtuozzo.com>
References: <20190915203655.21638-1-mlevitsk@redhat.com>
 <20190915203655.21638-3-mlevitsk@redhat.com>
In-Reply-To: <20190915203655.21638-3-mlevitsk@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P195CA0019.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::29)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190916121754733
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8cc1229-c1e5-4aec-2c92-08d73a86c307
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4569; 
x-ms-traffictypediagnostic: DB8PR08MB4569:
x-microsoft-antispam-prvs: <DB8PR08MB4569CB93D7FACA5F1137920CC18C0@DB8PR08MB4569.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(366004)(136003)(396003)(39840400004)(199004)(189003)(52116002)(102836004)(4326008)(186003)(446003)(25786009)(6436002)(6486002)(71200400001)(71190400001)(14454004)(256004)(76176011)(11346002)(31696002)(2906002)(478600001)(5660300002)(7736002)(6116002)(54906003)(486006)(305945005)(2616005)(110136005)(99286004)(26005)(3846002)(476003)(86362001)(386003)(6506007)(64756008)(66556008)(66476007)(8936002)(66446008)(316002)(66946007)(8676002)(6512007)(81166006)(31686004)(81156014)(229853002)(6246003)(53936002)(66066001)(2501003)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4569;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xIpc10eoAPs3aQwb4JQyqHMc7Ndt4FNupTVcY4YEHon73tjgz7RHuqxd5qyZRmRUWVMpdCA3hU4xS/FzFebH12miW2QORDMw47roSMJeye0TpQ2o3e8RCVqq5jjK9yMsSDC2XnYHh9tnlQ8lIyfLacvHvX400eDS3rGpvj+HR2RtD2kXGqovu/FFbIy6RZIzkiJVMPwTlQ7u8PRu3Y0LkHiIBeEMVqYs/xDRDUWRujiy+s3P89Hr+y0NjdOCjpcIYNZQL2tRfurz57vIUwez36Ec+PvNp19NTap18U8e2TNoRm2HBG/XeTMoj5ZBdxRM712tMS+v5GViF5HJKNWsJivL4QUiTjBwWxn5k8qgOf9ozP/FeQp63kCOrXMHD3YduEJ994M439jIJjZKtc/uRNCEPEBjRgi+WIEF3pbRvbU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF9C991A5BE3DE459D4F64DBAD37BEA0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cc1229-c1e5-4aec-2c92-08d73a86c307
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 09:17:56.9211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uu79B9vgSrgfMHy37/QIz7vowpfuemF5c22U0RieemONgZnnGme7nVhcr4jqbDgyC42onmRb6BfBhI1gXs4Hb0PVoeYtR9F85XfesDusFPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4569
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.90
Subject: Re: [Qemu-devel] [PATCH v7 2/3] block/qcow2: refactor encryption
 code
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTUuMDkuMjAxOSAyMzozNiwgTWF4aW0gTGV2aXRza3kgd3JvdGU6DQo+ICogQ2hhbmdlIHRoZSBx
Y293Ml9jb197ZW5jcnlwdHxkZWNyeXB0fSB0byBqdXN0IHJlY2VpdmUgZnVsbCBob3N0IGFuZA0K
PiAgICBndWVzdCBvZmZzZXRzIGFuZCB1c2UgdGhpcyBmdW5jdGlvbiBkaXJlY3RseSBpbnN0ZWFk
IG9mIGNhbGxpbmcNCj4gICAgZG9fcGVyZm9ybV9jb3dfZW5jcnlwdCAod2hpY2ggaXMgcmVtb3Zl
ZCBieSB0aGF0IHBhdGNoKS4NCj4gDQo+ICogQWRqdXN0IHFjb3cyX2NvX2VuY2RlYyB0byB0YWtl
IGZ1bGwgaG9zdCBhbmQgZ3Vlc3Qgb2Zmc2V0cyBhcyB3ZWxsLg0KPiANCj4gKiBEb2N1bWVudCB0
aGUgcWNvdzJfY29fe2VuY3J5cHR8ZGVjcnlwdH0gYXJndW1lbnRzDQo+ICAgIHRvIHByZXZlbnQg
dGhlIGJ1ZyBmaXhlZCBpbiBmb3JtZXIgY29tbWl0IGZyb20gaG9wZWZ1bGx5DQo+ICAgIGhhcHBl
bmluZyBhZ2Fpbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heGltIExldml0c2t5IDxtbGV2aXRz
a0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBibG9jay9xY293Mi1jbHVzdGVyLmMgfCA0MSArKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgYmxvY2svcWNvdzItdGhyZWFkcy5jIHwgNjMg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiAgIGJsb2NrL3Fj
b3cyLmMgICAgICAgICB8ICA1ICsrLS0NCj4gICBibG9jay9xY293Mi5oICAgICAgICAgfCAgOCAr
KystLS0NCj4gICA0IGZpbGVzIGNoYW5nZWQsIDcwIGluc2VydGlvbnMoKyksIDQ3IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL3Fjb3cyLWNsdXN0ZXIuYyBiL2Jsb2NrL3Fj
b3cyLWNsdXN0ZXIuYw0KPiBpbmRleCBiZmViMDI0MWQ3Li5hMmQ0OTA5MDI0IDEwMDY0NA0KPiAt
LS0gYS9ibG9jay9xY293Mi1jbHVzdGVyLmMNCj4gKysrIGIvYmxvY2svcWNvdzItY2x1c3Rlci5j
DQoNClsuLl0NCg0KPiAgIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIGRvX3BlcmZvcm1fY293X3dy
aXRlKEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IGNsdXN0ZXJfb2Zmc2V0LA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIG9mZnNldF9pbl9j
bHVzdGVyLA0KPiBAQCAtODkxLDExICs4NjksMjAgQEAgc3RhdGljIGludCBwZXJmb3JtX2NvdyhC
bG9ja0RyaXZlclN0YXRlICpicywgUUNvd0wyTWV0YSAqbSkNCj4gICANCj4gICAgICAgLyogRW5j
cnlwdCB0aGUgZGF0YSBpZiBuZWNlc3NhcnkgYmVmb3JlIHdyaXRpbmcgaXQgKi8NCj4gICAgICAg
aWYgKGJzLT5lbmNyeXB0ZWQpIHsNCj4gLSAgICAgICAgaWYgKCFkb19wZXJmb3JtX2Nvd19lbmNy
eXB0KGJzLCBtLT5vZmZzZXQsIG0tPmFsbG9jX29mZnNldCwNCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHN0YXJ0LT5vZmZzZXQsIHN0YXJ0X2J1ZmZlciwNCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXJ0LT5uYl9ieXRlcykgfHwNCj4gLSAg
ICAgICAgICAgICFkb19wZXJmb3JtX2Nvd19lbmNyeXB0KGJzLCBtLT5vZmZzZXQsIG0tPmFsbG9j
X29mZnNldCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVuZC0+b2Zm
c2V0LCBlbmRfYnVmZmVyLCBlbmQtPm5iX2J5dGVzKSkgew0KPiArICAgICAgICByZXQgPSBxY293
Ml9jb19lbmNyeXB0KGJzLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG0tPmFs
bG9jX29mZnNldCArIHN0YXJ0LT5vZmZzZXQsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgbS0+b2Zmc2V0ICsgc3RhcnQtPm9mZnNldCwNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdGFydF9idWZmZXIsIHN0YXJ0LT5uYl9ieXRlcyk7DQo+ICsgICAgICAgIGlm
IChyZXQgPCAwKSB7DQo+ICsgICAgICAgICAgICByZXQgPSAtRUlPOw0KPiArICAgICAgICAgICAg
Z290byBmYWlsOw0KDQpKdXN0IGdvIHRvIGZhaWwgSSB0aGluaywgZG9uJ3QgcmVhc3NpZ24gcmV0
IHZhcmlhYmxlLg0KDQo+ICsgICAgICAgIH0NCj4gKw0KPiArICAgICAgICByZXQgPSBxY293Ml9j
b19lbmNyeXB0KGJzLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG0tPmFsbG9j
X29mZnNldCArIGVuZC0+b2Zmc2V0LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IG0tPm9mZnNldCArIGVuZC0+b2Zmc2V0LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGVuZF9idWZmZXIsIGVuZC0+bmJfYnl0ZXMpOw0KPiArICAgICAgICBpZiAocmV0IDwgMCkg
ew0KPiAgICAgICAgICAgICAgIHJldCA9IC1FSU87DQoNCmFuZCBoZXJlLg0KDQp3aXRoIHRoZXNl
IHR3byBwbGFjZXMgZml4ZWQ6DQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2
c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQooSSB0aGluaywgdGhlc2Ugc2ltcGxl
IGNoYW5nZXMgbWF5IGJlIGFwcGxpZWQgd2hpbGUgcXVldWluZywgc28geW91IGRvbid0DQpuZWVk
IHRvIHJlc2VuZCwgaWYgdGhlcmUgbm8gb3RoZXIgcmVhc29ucykNCg0KDQoNCg0KLS0gDQpCZXN0
IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

