Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8CFC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 18:46:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC7C20409
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 18:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NCYQGxyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC7C20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icDBf-0005FR-2e
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 13:46:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icC8R-0001ZM-RQ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:38:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icC8K-0007B2-7n
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:38:47 -0500
Received: from mail-eopbgr130101.outbound.protection.outlook.com
 ([40.107.13.101]:35395 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1icC8I-0006oG-1z; Tue, 03 Dec 2019 12:38:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F379F+D2Zh1PN6zmCRpqbKUs/NeE36dsLj9qKCK1RZ5gdCKq1Oke2j0eOcG67iELqQ7vBMQc4M9Fyp6wPqW2FC9mEQieKWK/PF+63bgy6PwdUn5RzC4kuZNUk1zQsKc/S9kgseSGe06a+JoFkKEMIMg+3np4U0nKGU7qlGHsrrR4YjRZpBuc21AzruFLgu2OLOAXN1m/1qnXRL5BIxDHDWKUbjHD6aEkhw7lqy93962AyBmY2dRpaatJRqiWZsf+r7Xt8Hs7snYyNt1up6f6aUxKKXHZl2+kMuEnXUiKBDdvlRydC3uNZBn/BUz4Hl4aV4l5R5DEwBIVvKNQwyYqGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13gMhaj/PrU5e/XbQwVsQRwQxkmW7+KtlDYSlsY57FY=;
 b=MtyrLzIEvWIFYMFot+euCXwtLsXarfw8oD63BEZe8C3roB8S9JAMtux9X1GJtfQLjRUM6K8oiszx43bQy9CsYywwNeV8CpBVR68AVAhU+/aFsFgEzGPEGU140V6Ck4Y7iXyEU08CkRNm1jiOaZFbHyjT0FTi1e/763XUF7iNZmhc340b3jnwCORvLv+zK5338UeKAqi6QTXuw0W6uEqB7DdvjhWf+f7FoTKeckGeMVAibNa49s0dAaCNr6q0Hhkv69zdnFG3cZWO7UnZvH8nXSOJ+Gkdb8xTSz0Pacuf6kP87+JSVnILSp+k5oq/9EnLUt9TA6O48RPcxq7sCY/T7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13gMhaj/PrU5e/XbQwVsQRwQxkmW7+KtlDYSlsY57FY=;
 b=NCYQGxyTTuC69SVh7Yz/e7jB3nsSiVhEBCa00NW1KAFIsDY8uMVrAEYywMtgMHmJpytIA1/t5ed48Q2J2YvO2Ua4FJTYtV7tsP3aMMlRBDNDlN/cZg27Rpywjs73mCV0I0LaFWxx6Uy2iDYknpUL21B99VSUAEhnymzwWnowr/4=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4359.eurprd08.prod.outlook.com (20.179.6.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Tue, 3 Dec 2019 17:38:33 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.003; Tue, 3 Dec 2019
 17:38:33 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "pannengyuan@huawei.com" <pannengyuan@huawei.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "sgarzare@redhat.com"
 <sgarzare@redhat.com>
Subject: Re: [PATCH V3 1/2] block/nbd: extract the common cleanup code
Thread-Topic: [PATCH V3 1/2] block/nbd: extract the common cleanup code
Thread-Index: AQHVpofDlqkXDK02dkqUyLcdRPJzHaeos+WA
Date: Tue, 3 Dec 2019 17:38:33 +0000
Message-ID: <77f53371-aa58-849a-b0e4-2d6b4e4557d4@virtuozzo.com>
References: <1575012326-51324-1-git-send-email-pannengyuan@huawei.com>
In-Reply-To: <1575012326-51324-1-git-send-email-pannengyuan@huawei.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0044.eurprd07.prod.outlook.com
 (2603:10a6:7:66::30) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191203203831495
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89ac9b1f-40bb-47b3-0d6e-08d778179e7b
x-ms-traffictypediagnostic: AM6PR08MB4359:
x-microsoft-antispam-prvs: <AM6PR08MB4359A0E927D6062F5C676AD9C1420@AM6PR08MB4359.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:390;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39840400004)(376002)(366004)(396003)(346002)(199004)(189003)(256004)(5660300002)(14444005)(14454004)(102836004)(6506007)(7416002)(386003)(305945005)(31686004)(66946007)(66476007)(66446008)(31696002)(64756008)(66556008)(7736002)(26005)(478600001)(6246003)(110136005)(186003)(4326008)(446003)(11346002)(54906003)(6436002)(99286004)(8676002)(25786009)(52116002)(316002)(2906002)(76176011)(6116002)(6512007)(2201001)(2501003)(3846002)(86362001)(8936002)(81156014)(71200400001)(6486002)(81166006)(71190400001)(229853002)(36756003)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4359;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3FqfucWtHiSwMc4eUM27K/rmaXc0I8BwAAcK1jMCTjkDggwvSWB8eEQBKw+tAB+ri0b8WdUObhw+qIhaayzsxg8Z8S1lWWGssFX2KNPheUvI+/hIB8/SlHX0Ddqjlhz0EUYdzRfHNevkGpvxXEZSXm3NsHP3pKXuBsDE0wShUyBXLzZAr2grfseWkZTCu/wi2AlZT9MqGCIrO7mdPDO7SMybWdYzKikpG7r7lu/C/aJnyb2e80rfTLWwdP6LV8YraBDuoL+xuBy7CGBDufCdQxoOfqRu92Ahw4zEPjLAZ3z6hHRYrEg1FDP1o+gy7s1PUBNfKExBLx1NgiiKxjCUf6ltUM9zJVtovJrkPCCW9mVJWjw0NRM1LAcLxbeLnXNz7MdyXHzSimtrSYGWWEyeYTWCguES5cKWwMDSSijXf+N/+4tjWg/cfsqLS+lQupLI
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0C2B97C53C6B945A8FFF39D22D96FC5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ac9b1f-40bb-47b3-0d6e-08d778179e7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 17:38:33.5869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5WhcX3Ri4DCVueYkq1Re43e9PCrSVNLjWBe2L6AipXd5nult9HreJ8rxFt5XWoB2VisZdtEiziFzxGFrTpaswWTPawXJRHAdA2v7TumboPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4359
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.101
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
Cc: "liyiting@huawei.com" <liyiting@huawei.com>,
 "kuhn.chenqun@huawei.com" <kuhn.chenqun@huawei.com>,
 "zhang.zhanghailiang@huawei.com" <zhang.zhanghailiang@huawei.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkhDQoNCkZpcnN0LCBwbGVhc2UsIHdoZW4gc2VuZGluZyBtb3JlIHRoYW4gb25lIHBhdGNoLCBj
cmVhdGUgYSBjb3Zlci1sZXR0ZXIuIEFsc28sDQpzdW1tYXJpemUgKGluIGNvdmVyIGxldHRlcikg
d2hhdCB3YXMgY2hhbmdlZCBzaW5jZSBwcmV2aW91cyB2ZXJzaW9uLg0KDQoyOS4xMS4yMDE5IDEw
OjI1LCBwYW5uZW5neXVhbkBodWF3ZWkuY29tIHdyb3RlOg0KPiBGcm9tOiBQYW5OZW5neXVhbiA8
cGFubmVuZ3l1YW5AaHVhd2VpLmNvbT4NCg0KU3RyYW5nZSBsaW5lLiBDaGVjayB5b3UgZ2l0IHBy
ZWZlcmVuY2VzLiBTdWNoIGxpbmUgYXBwZWFycyAoYW5kIG1ha2Ugc2Vuc2UpDQp3aGVuIHlvdSBh
cmUgc2VuZGluZyBwYXRjaGVzIGF1dGhvcmVkIGJ5IHNvbWVvbmUgZWxzZS4uIEJ1dCBoZXJlIGlz
IHlvdXIgbmFtZSwNCnRoZSBzYW1lIGFzIGluIGVtYWlsJ3MgRnJvbTouDQoNCj4gDQo+IFRoZSBC
RFJWTkJEU3RhdGUgY2xlYW51cCBjb2RlIGlzIGNvbW1vbiBpbiB0d28gcGxhY2VzLCBhZGQNCj4g
bmJkX2ZyZWVfYmRydnN0YXRlX3Byb3AoKSBmdW5jdGlvbiB0byBkbyB0aGVzZSBjbGVhbnVwcyAo
c3VnZ2VzdGVkIGJ5DQo+IFN0ZWZhbm8gR2FyemFyZWxsYSkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBQYW5OZW5neXVhbiA8cGFubmVuZ3l1YW5AaHVhd2VpLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFZs
YWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0K
PiAtLS0NCj4gICBibG9jay9uYmQuYyB8IDIzICsrKysrKysrKysrKystLS0tLS0tLS0tDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2Jsb2NrL25iZC5jIGIvYmxvY2svbmJkLmMNCj4gaW5kZXggMTIzOTc2MS4u
NTgwNTk3OSAxMDA2NDQNCj4gLS0tIGEvYmxvY2svbmJkLmMNCj4gKysrIGIvYmxvY2svbmJkLmMN
Cj4gQEAgLTk0LDYgKzk0LDggQEAgdHlwZWRlZiBzdHJ1Y3QgQkRSVk5CRFN0YXRlIHsNCj4gICAN
Cj4gICBzdGF0aWMgaW50IG5iZF9jbGllbnRfY29ubmVjdChCbG9ja0RyaXZlclN0YXRlICpicywg
RXJyb3IgKiplcnJwKTsNCj4gICANCj4gK3N0YXRpYyB2b2lkIG5iZF9mcmVlX2JkcnZzdGF0ZV9w
cm9wKEJEUlZOQkRTdGF0ZSAqcyk7DQo+ICsNCj4gICBzdGF0aWMgdm9pZCBuYmRfY2hhbm5lbF9l
cnJvcihCRFJWTkJEU3RhdGUgKnMsIGludCByZXQpDQo+ICAgew0KPiAgICAgICBpZiAocmV0ID09
IC1FSU8pIHsNCj4gQEAgLTE0ODYsNiArMTQ4OCwxNSBAQCBzdGF0aWMgaW50IG5iZF9jbGllbnRf
Y29ubmVjdChCbG9ja0RyaXZlclN0YXRlICpicywgRXJyb3IgKiplcnJwKQ0KPiAgICAgICB9DQo+
ICAgfQ0KPiAgIA0KPiArc3RhdGljIHZvaWQgbmJkX2ZyZWVfYmRydnN0YXRlX3Byb3AoQkRSVk5C
RFN0YXRlICpzKQ0KPiArew0KPiArICAgIG9iamVjdF91bnJlZihPQkpFQ1Qocy0+dGxzY3JlZHMp
KTsNCj4gKyAgICBxYXBpX2ZyZWVfU29ja2V0QWRkcmVzcyhzLT5zYWRkcik7DQo+ICsgICAgZ19m
cmVlKHMtPmV4cG9ydCk7DQo+ICsgICAgZ19mcmVlKHMtPnRsc2NyZWRzaWQpOw0KPiArICAgIGdf
ZnJlZShzLT54X2RpcnR5X2JpdG1hcCk7DQo+ICt9DQo+ICsNCj4gICAvKg0KPiAgICAqIFBhcnNl
IG5iZF9vcGVuIG9wdGlvbnMNCj4gICAgKi8NCj4gQEAgLTE4NTUsMTAgKzE4NjYsNyBAQCBzdGF0
aWMgaW50IG5iZF9wcm9jZXNzX29wdGlvbnMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIFFEaWN0ICpv
cHRpb25zLA0KPiAgIA0KPiAgICBlcnJvcjoNCj4gICAgICAgaWYgKHJldCA8IDApIHsNCj4gLSAg
ICAgICAgb2JqZWN0X3VucmVmKE9CSkVDVChzLT50bHNjcmVkcykpOw0KPiAtICAgICAgICBxYXBp
X2ZyZWVfU29ja2V0QWRkcmVzcyhzLT5zYWRkcik7DQo+IC0gICAgICAgIGdfZnJlZShzLT5leHBv
cnQpOw0KPiAtICAgICAgICBnX2ZyZWUocy0+dGxzY3JlZHNpZCk7DQo+ICsgICAgICAgIG5iZF9m
cmVlX2JkcnZzdGF0ZV9wcm9wKHMpOw0KPiAgICAgICB9DQo+ICAgICAgIHFlbXVfb3B0c19kZWwo
b3B0cyk7DQo+ICAgICAgIHJldHVybiByZXQ7DQo+IEBAIC0xOTM3LDEyICsxOTQ1LDcgQEAgc3Rh
dGljIHZvaWQgbmJkX2Nsb3NlKEJsb2NrRHJpdmVyU3RhdGUgKmJzKQ0KPiAgICAgICBCRFJWTkJE
U3RhdGUgKnMgPSBicy0+b3BhcXVlOw0KPiAgIA0KPiAgICAgICBuYmRfY2xpZW50X2Nsb3NlKGJz
KTsNCj4gLQ0KPiAtICAgIG9iamVjdF91bnJlZihPQkpFQ1Qocy0+dGxzY3JlZHMpKTsNCj4gLSAg
ICBxYXBpX2ZyZWVfU29ja2V0QWRkcmVzcyhzLT5zYWRkcik7DQo+IC0gICAgZ19mcmVlKHMtPmV4
cG9ydCk7DQo+IC0gICAgZ19mcmVlKHMtPnRsc2NyZWRzaWQpOw0KPiAtICAgIGdfZnJlZShzLT54
X2RpcnR5X2JpdG1hcCk7DQo+ICsgICAgbmJkX2ZyZWVfYmRydnN0YXRlX3Byb3Aocyk7DQo+ICAg
fQ0KPiAgIA0KPiAgIHN0YXRpYyBpbnQ2NF90IG5iZF9nZXRsZW5ndGgoQmxvY2tEcml2ZXJTdGF0
ZSAqYnMpDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

