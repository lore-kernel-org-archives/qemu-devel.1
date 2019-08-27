Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFBEC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9D9B20828
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sUWtYCGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D9B20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2aBP-0001b2-Fw
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 08:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i2a8h-0000Pb-Uq
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 07:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i2a8g-0002VA-Nr
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 07:59:55 -0400
Received: from mail-eopbgr20096.outbound.protection.outlook.com
 ([40.107.2.96]:23360 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i2a8d-0002TS-CM; Tue, 27 Aug 2019 07:59:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEsORcTH5/MgMqHHHW/RLBxYTaY2kthCUYNu/iQsaUqlCoRYj8fHNKfke/tCiO/KOvAijnlkKSB72oTDeTJDCFrF4EZfbmUc1cWUC+ke9axBamu0SDw0Qfa+dq/TBYc7QejPhNtRiAYy+QMu11fWla3aO5ViGlc6zABKxbYm4F+WeiWRpurf75hCLQKim1wPDu5amw5v4GVjScrBr1dmY8b4AjAzOAWFXdfn6JfHFXpiXCDfySqBnrBtZKUJ0/dYPOWLL5EKi6cZl0lM8obai9zMih0kN+YT7ocTWbVhB4yxuwFlURRG1K6XihY4cVTvyPN9s8WP7hBxCOrqCJAIlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Qy/PM9W831S9wyAireKV+qh55WNkZGKKf7Z1qxUsyc=;
 b=a2O1gfDNqe1mJq5VwBU6+KpfXEZVNbustiJd5AIaCOf6tF7grcviillBulLF3dQ9lQDGDG5re7lG3we8IOueYYf5K0+0snrQTRlkTnxTAIG/8rWX3xXkcCYGjJc9EZISfGMovs5P16/2poDmpkw53WnAa7tiFLvbe19js9S1kU1NQpnJbCTXxuIAoZ49MhBcTEZnb2jOEYhUSjNQ+kD722anligHPa29cjbWv30RrIQHxQmIXNNAWiKo5ufMuB3TrY1JcXRQmy/PSvBTj98eSiePRRMUaD7miFlneqsRODXT3b+DbNJG8ErkPXpQ62lv9zpACCmYCrxOELMi0VEIIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Qy/PM9W831S9wyAireKV+qh55WNkZGKKf7Z1qxUsyc=;
 b=sUWtYCGhDAQXzVmd2wGTVLKqdusYErFtKM8pGmcIEbNW+jz9FiBkCmdx/E8adpbOCK2xcabCbNGK01aQL2vF0xcwVybmzJHfKkZAWwI2FI3KmvpedlqHxMXJvl5acyPGE6OdDFw5Ezcnx26YD2gBUGrY6s9ErPEVU6GRO2NHBF8=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4572.eurprd08.prod.outlook.com (20.179.12.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Tue, 27 Aug 2019 11:59:45 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 11:59:45 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 2/3] qcow2: rework the cluster compression routine
Thread-Index: AQHVVp7pBnm9FYfn80WzotStK2WyYacO8JWA
Date: Tue, 27 Aug 2019 11:59:45 +0000
Message-ID: <618f1a9c-ebde-8e8c-aa6d-4a25e5c05cd9@virtuozzo.com>
References: <20190819150049.28997-1-dplotnikov@virtuozzo.com>
 <20190819150049.28997-3-dplotnikov@virtuozzo.com>
In-Reply-To: <20190819150049.28997-3-dplotnikov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::17) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190827145943581
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55a7a901-a6c2-4270-88cc-08d72ae60da8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4572; 
x-ms-traffictypediagnostic: DB8PR08MB4572:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB45725BA309AA8A3359E41E72C1A00@DB8PR08MB4572.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(376002)(39840400004)(346002)(366004)(189003)(199004)(52314003)(81156014)(54906003)(6436002)(3846002)(8936002)(6512007)(81166006)(305945005)(478600001)(8676002)(53936002)(2906002)(36756003)(316002)(66066001)(7736002)(6486002)(25786009)(6246003)(110136005)(99286004)(386003)(6506007)(486006)(52116002)(2616005)(446003)(476003)(102836004)(186003)(76176011)(6116002)(26005)(256004)(86362001)(66446008)(4326008)(229853002)(11346002)(2501003)(71200400001)(66556008)(66476007)(64756008)(71190400001)(31696002)(66946007)(31686004)(14454004)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4572;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CLPh6AiWmLxMnJHC6MsqzYCvU3vo50f+Co6IEHDsKhDf4HNsjf0bkA2qMnM5hwOxzG6hdzlMlaaEIrzcrmX5VmdvWnOQmEZY9iS8v0bZUa0EEkwAcbss5tPPwcZPtF29vGQRdZOrZ1SITCXFLIiz0PGS0RGsztjTTaaGlobbXsW3LiqyWAHewG7hTRvnVE5lAlGiZXRA0XdHrFZ0o0Uwr6EAjWAQ0vMYOQsRPXzHtfFgpNTDX3iU3klYMmwNdCWZFSl+FeRLBTxo74Mkv+fUPRHGAO9aCbIz/x/zCXApn4r+LMCXifOXLyGd14Qf4I4Kw6uuo4NdtcvbydjguyxTzw6eNAtuki8isHw+0ECIzChP2NnBc8ICbYUihQ7VqsfG+264Kh9MqKBUlCxfysfCq4smDh7WHPdRH5AAK2YU6A4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD94B05B922A9B4A883E22DE70E9866C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a7a901-a6c2-4270-88cc-08d72ae60da8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 11:59:45.7729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6cJrwZBrCLwdeOOUNNGL17o5yNDdQwZYj7tOL0+bcLCK4tlLtuBKOc4TL7t2WnBqfJnLgdsQhz6e3Lm+i+jPRmrbbXNXVz6GgVCnkrmVxHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4572
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.96
Subject: Re: [Qemu-devel] [PATCH v3 2/3] qcow2: rework the cluster
 compression routine
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMDguMjAxOSAxODowMCwgRGVuaXMgUGxvdG5pa292IHdyb3RlOg0KPiBUaGUgcGF0Y2ggYWxs
b3cgdG8gcHJvY2VzcyBpbWFnZSBjb21wcmVzc2lvbiB0eXBlIGRlZmluZWQNCj4gaW4gdGhlIGlt
YWdlIGhlYWRlciBhbmQgY2hvb3NlIGFuIGFwcHJvcHJpYXRlIG1ldGhvZCBmb3INCj4gaW1hZ2Ug
Y2x1c3RlcnMgKGRlKWNvbXByZXNzaW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGVuaXMgUGxv
dG5pa292IDxkcGxvdG5pa292QHZpcnR1b3p6by5jb20+DQo+IC0tLQ0KPiAgIGJsb2NrL3Fjb3cy
LXRocmVhZHMuYyB8IDc4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svcWNvdzItdGhyZWFkcy5jIGIvYmxvY2svcWNvdzIt
dGhyZWFkcy5jDQo+IGluZGV4IDNiMWU2M2ZlNDEuLjE0YjViZDc2ZmIgMTAwNjQ0DQo+IC0tLSBh
L2Jsb2NrL3Fjb3cyLXRocmVhZHMuYw0KPiArKysgYi9ibG9jay9xY293Mi10aHJlYWRzLmMNCj4g
QEAgLTczLDggKzczLDExIEBAIHR5cGVkZWYgc3RydWN0IFFjb3cyQ29tcHJlc3NEYXRhIHsNCj4g
ICAgICAgUWNvdzJDb21wcmVzc0Z1bmMgZnVuYzsNCj4gICB9IFFjb3cyQ29tcHJlc3NEYXRhOw0K
PiAgIA0KPiArDQo+ICAgLyoNCj4gLSAqIHFjb3cyX2NvbXByZXNzKCkNCj4gKyAqIHFjb3cyX3ps
aWJfY29tcHJlc3MoKQ0KPiArICoNCj4gKyAqIENvbXByZXNzIEBzcmNfc2l6ZSBieXRlcyBvZiBk
YXRhIHVzaW5nIHpsaWIgY29tcHJlc3Npb24gbWV0aG9kDQo+ICAgICoNCj4gICAgKiBAZGVzdCAt
IGRlc3RpbmF0aW9uIGJ1ZmZlciwgQGRlc3Rfc2l6ZSBieXRlcw0KPiAgICAqIEBzcmMgLSBzb3Vy
Y2UgYnVmZmVyLCBAc3JjX3NpemUgYnl0ZXMNCj4gQEAgLTgzLDggKzg2LDggQEAgdHlwZWRlZiBz
dHJ1Y3QgUWNvdzJDb21wcmVzc0RhdGEgew0KPiAgICAqICAgICAgICAgIC1FTk9NRU0gZGVzdGlu
YXRpb24gYnVmZmVyIGlzIG5vdCBlbm91Z2ggdG8gc3RvcmUgY29tcHJlc3NlZCBkYXRhDQo+ICAg
ICogICAgICAgICAgLUVJTyAgICBvbiBhbnkgb3RoZXIgZXJyb3INCj4gICAgKi8NCj4gLXN0YXRp
YyBzc2l6ZV90IHFjb3cyX2NvbXByZXNzKHZvaWQgKmRlc3QsIHNpemVfdCBkZXN0X3NpemUsDQo+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCB2b2lkICpzcmMsIHNpemVfdCBz
cmNfc2l6ZSkNCj4gK3N0YXRpYyBzc2l6ZV90IHFjb3cyX3psaWJfY29tcHJlc3Modm9pZCAqZGVz
dCwgc2l6ZV90IGRlc3Rfc2l6ZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY29uc3Qgdm9pZCAqc3JjLCBzaXplX3Qgc3JjX3NpemUpDQo+ICAgew0KPiAgICAgICBzc2l6
ZV90IHJldDsNCj4gICAgICAgel9zdHJlYW0gc3RybTsNCj4gQEAgLTExOSwxOSArMTIyLDE5IEBA
IHN0YXRpYyBzc2l6ZV90IHFjb3cyX2NvbXByZXNzKHZvaWQgKmRlc3QsIHNpemVfdCBkZXN0X3Np
emUsDQo+ICAgfQ0KPiAgIA0KPiAgIC8qDQo+IC0gKiBxY293Ml9kZWNvbXByZXNzKCkNCj4gKyAq
IHFjb3cyX3psaWJfZGVjb21wcmVzcygpDQo+ICAgICoNCj4gICAgKiBEZWNvbXByZXNzIHNvbWUg
ZGF0YSAobm90IG1vcmUgdGhhbiBAc3JjX3NpemUgYnl0ZXMpIHRvIHByb2R1Y2UgZXhhY3RseQ0K
PiAtICogQGRlc3Rfc2l6ZSBieXRlcy4NCj4gKyAqIEBkZXN0X3NpemUgYnl0ZXMgdXNpbmcgemxp
YiBjb21wcmVzc2lvbiBtZXRob2QNCj4gICAgKg0KPiAgICAqIEBkZXN0IC0gZGVzdGluYXRpb24g
YnVmZmVyLCBAZGVzdF9zaXplIGJ5dGVzDQo+ICAgICogQHNyYyAtIHNvdXJjZSBidWZmZXIsIEBz
cmNfc2l6ZSBieXRlcw0KPiAgICAqDQo+ICAgICogUmV0dXJuczogMCBvbiBzdWNjZXNzDQo+IC0g
KiAgICAgICAgICAtMSBvbiBmYWlsDQo+ICsgKiAgICAgICAgICAtRUlPIG9uIGZhaWwNCj4gICAg
Ki8NCj4gLXN0YXRpYyBzc2l6ZV90IHFjb3cyX2RlY29tcHJlc3Modm9pZCAqZGVzdCwgc2l6ZV90
IGRlc3Rfc2l6ZSwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgdm9p
ZCAqc3JjLCBzaXplX3Qgc3JjX3NpemUpDQo+ICtzdGF0aWMgc3NpemVfdCBxY293Ml96bGliX2Rl
Y29tcHJlc3Modm9pZCAqZGVzdCwgc2l6ZV90IGRlc3Rfc2l6ZSwNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjb25zdCB2b2lkICpzcmMsIHNpemVfdCBzcmNfc2l6ZSkN
Cj4gICB7DQo+ICAgICAgIGludCByZXQgPSAwOw0KPiAgICAgICB6X3N0cmVhbSBzdHJtOw0KPiBA
QCAtMTQ0LDcgKzE0Nyw3IEBAIHN0YXRpYyBzc2l6ZV90IHFjb3cyX2RlY29tcHJlc3Modm9pZCAq
ZGVzdCwgc2l6ZV90IGRlc3Rfc2l6ZSwNCj4gICANCj4gICAgICAgcmV0ID0gaW5mbGF0ZUluaXQy
KCZzdHJtLCAtMTIpOw0KPiAgICAgICBpZiAocmV0ICE9IFpfT0spIHsNCj4gLSAgICAgICAgcmV0
dXJuIC0xOw0KPiArICAgICAgICByZXR1cm4gLUVJTzsNCj4gICAgICAgfQ0KPiAgIA0KPiAgICAg
ICByZXQgPSBpbmZsYXRlKCZzdHJtLCBaX0ZJTklTSCk7DQo+IEBAIC0xNTQsNyArMTU3LDcgQEAg
c3RhdGljIHNzaXplX3QgcWNvdzJfZGVjb21wcmVzcyh2b2lkICpkZXN0LCBzaXplX3QgZGVzdF9z
aXplLA0KPiAgICAgICAgICAgICogQHNyYyBidWZmZXIgbWF5IGJlIHByb2Nlc3NlZCBwYXJ0bHkg
KGJlY2F1c2UgaW4gcWNvdzIgd2Uga25vdyBzaXplIG9mDQo+ICAgICAgICAgICAgKiBjb21wcmVz
c2VkIGRhdGEgd2l0aCBwcmVjaXNpb24gb2Ygb25lIHNlY3RvcikNCj4gICAgICAgICAgICAqLw0K
PiAtICAgICAgICByZXQgPSAtMTsNCj4gKyAgICAgICAgcmV0ID0gLUVJTzsNCj4gICAgICAgfQ0K
PiAgIA0KPiAgICAgICBpbmZsYXRlRW5kKCZzdHJtKTsNCj4gQEAgLTE4OSwyMCArMTkyLDY3IEBA
IHFjb3cyX2NvX2RvX2NvbXByZXNzKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCB2b2lkICpkZXN0LCBz
aXplX3QgZGVzdF9zaXplLA0KPiAgICAgICByZXR1cm4gYXJnLnJldDsNCj4gICB9DQo+ICAgDQo+
ICsvKg0KPiArICogcWNvdzJfY29fY29tcHJlc3MoKQ0KPiArICoNCj4gKyAqIENvbXByZXNzIEBz
cmNfc2l6ZSBieXRlcyBvZiBkYXRhIHVzaW5nIHRoZSBjb21wcmVzc2lvbg0KPiArICogbWV0aG9k
IGRlZmluZWQgYnkgdGhlIGltYWdlIGNvbXByZXNzaW9uIHR5cGUNCj4gKyAqDQo+ICsgKiBAZGVz
dCAtIGRlc3RpbmF0aW9uIGJ1ZmZlciwgQGRlc3Rfc2l6ZSBieXRlcw0KPiArICogQHNyYyAtIHNv
dXJjZSBidWZmZXIsIEBzcmNfc2l6ZSBieXRlcw0KPiArICoNCj4gKyAqIFJldHVybnM6IDAgb24g
c3VjY2Vzcw0KPiArICogICAgICAgICAgYSBuZWdhdGl2ZSBlcnJvciBjb2RlIG9uIGZhaWwNCj4g
KyAqLw0KPiAgIHNzaXplX3QgY29yb3V0aW5lX2ZuDQo+ICAgcWNvdzJfY29fY29tcHJlc3MoQmxv
Y2tEcml2ZXJTdGF0ZSAqYnMsIHZvaWQgKmRlc3QsIHNpemVfdCBkZXN0X3NpemUsDQo+ICAgICAg
ICAgICAgICAgICAgICAgY29uc3Qgdm9pZCAqc3JjLCBzaXplX3Qgc3JjX3NpemUpDQo+ICAgew0K
PiAtICAgIHJldHVybiBxY293Ml9jb19kb19jb21wcmVzcyhicywgZGVzdCwgZGVzdF9zaXplLCBz
cmMsIHNyY19zaXplLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBxY293Ml9j
b21wcmVzcyk7DQo+ICsgICAgQkRSVlFjb3cyU3RhdGUgKnMgPSBicy0+b3BhcXVlOw0KPiArICAg
IFFjb3cyQ29tcHJlc3NGdW5jIGZuOw0KPiArDQo+ICsgICAgc3dpdGNoIChzLT5jb21wcmVzc2lv
bl90eXBlKSB7DQo+ICsgICAgY2FzZSBRQ09XMl9DT01QUkVTU0lPTl9UWVBFX1pMSUI6DQo+ICsg
ICAgICAgIGZuID0gcWNvdzJfemxpYl9jb21wcmVzczsNCj4gKyAgICAgICAgYnJlYWs7DQo+ICsN
Cj4gKyAgICBkZWZhdWx0Og0KPiArICAgICAgICByZXR1cm4gLUVOT1RTVVA7DQoNCml0IG1heSBi
ZSBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpIGluc3RlYWQsIGFzIHdlIG5ldmVyIHNldCBzdGF0ZSBm
aWVsZCB0byB1bnN1cHBvcnRlZCB2YWx1ZS4NCg0KPiArICAgIH0NCj4gKw0KPiArICAgIHJldHVy
biBxY293Ml9jb19kb19jb21wcmVzcyhicywgZGVzdCwgZGVzdF9zaXplLCBzcmMsIHNyY19zaXpl
LCBmbik7DQo+ICAgfQ0KPiAgIA0KPiArLyoNCj4gKyAqIHFjb3cyX2NvX2RlY29tcHJlc3MoKQ0K
PiArICoNCj4gKyAqIERlY29tcHJlc3Mgc29tZSBkYXRhIChub3QgbW9yZSB0aGFuIEBzcmNfc2l6
ZSBieXRlcykgdG8gcHJvZHVjZSBleGFjdGx5DQo+ICsgKiBAZGVzdF9zaXplIGJ5dGVzIHVzaW5n
IHRoZSBjb21wcmVzc2lvbiBtZXRob2QgZGVmaW5lZCBieSB0aGUgaW1hZ2UNCj4gKyAqIGNvbXBy
ZXNzaW9uIHR5cGUNCj4gKyAqDQo+ICsgKiBAZGVzdCAtIGRlc3RpbmF0aW9uIGJ1ZmZlciwgQGRl
c3Rfc2l6ZSBieXRlcw0KPiArICogQHNyYyAtIHNvdXJjZSBidWZmZXIsIEBzcmNfc2l6ZSBieXRl
cw0KPiArICoNCj4gKyAqIFJldHVybnM6IDAgb24gc3VjY2Vzcw0KPiArICogICAgICAgICAgYSBu
ZWdhdGl2ZSBlcnJvciBjb2RlIG9uIGZhaWwNCj4gKyAqLw0KPiAgIHNzaXplX3QgY29yb3V0aW5l
X2ZuDQo+ICAgcWNvdzJfY29fZGVjb21wcmVzcyhCbG9ja0RyaXZlclN0YXRlICpicywgdm9pZCAq
ZGVzdCwgc2l6ZV90IGRlc3Rfc2l6ZSwNCj4gICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHZv
aWQgKnNyYywgc2l6ZV90IHNyY19zaXplKQ0KPiAgIHsNCj4gLSAgICByZXR1cm4gcWNvdzJfY29f
ZG9fY29tcHJlc3MoYnMsIGRlc3QsIGRlc3Rfc2l6ZSwgc3JjLCBzcmNfc2l6ZSwNCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcWNvdzJfZGVjb21wcmVzcyk7DQo+ICsgICAgQkRS
VlFjb3cyU3RhdGUgKnMgPSBicy0+b3BhcXVlOw0KPiArICAgIFFjb3cyQ29tcHJlc3NGdW5jIGZu
Ow0KPiArDQo+ICsgICAgc3dpdGNoIChzLT5jb21wcmVzc2lvbl90eXBlKSB7DQo+ICsgICAgY2Fz
ZSBRQ09XMl9DT01QUkVTU0lPTl9UWVBFX1pMSUI6DQo+ICsgICAgICAgIGZuID0gcWNvdzJfemxp
Yl9kZWNvbXByZXNzOw0KPiArICAgICAgICBicmVhazsNCj4gKw0KPiArICAgIGRlZmF1bHQ6DQo+
ICsgICAgICAgIHJldHVybiAtRU5PVFNVUDsNCg0KYW5kIGhlcmUsIGFuZCBtYXkgYmUgaW4gcHJl
dmlvdXMgcGF0Y2ggKHdoZXJlIGNhbGwgc3dpdGNoIG9uIHMtPmNvbXByZXNzaW9uX3R5cGUpDQoN
CkJ1dCBhbnl3YXksIHdpdGggdGhpcyBjaGFuZ2VkIG9yIHdpdGhvdXQ6DQpSZXZpZXdlZC1ieTog
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0K
DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgcmV0dXJuIHFjb3cyX2NvX2RvX2NvbXByZXNzKGJzLCBk
ZXN0LCBkZXN0X3NpemUsIHNyYywgc3JjX3NpemUsIGZuKTsNCj4gICB9DQo+ICAgDQo+ICAgDQo+
IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

