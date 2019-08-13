Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7E8C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 490F920840
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WMyn1rd7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490F920840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWSQ-0007Go-KE
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 09:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55741)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxWQ3-0002ss-Ct
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxWPw-0001S1-5M
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:00:54 -0400
Received: from mail-eopbgr140095.outbound.protection.outlook.com
 ([40.107.14.95]:34832 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxWPv-0001RM-9i; Tue, 13 Aug 2019 09:00:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYR317jrbIpjwUb1l2ZLBU6kIb2lDGD6vxsFYLVE9pHxD9ix/U29ERqAHSaX7r7l/OJ+n2TaOjeNzjOBMfJSRBMjvFCMszu2Q8ehpQKp0pU7GwIxy4CEVmSoPLQYjDZpD3n5mde1ZjhgO1cg8dE1VrIFvqbbg06nqgNSrSyFRux2aG8RRwBKNOGtUUVLME82rKRYn6kowYyjn9CYF+xdu4j2mWy7E51q5HoIIxax8hfhB1GkzA4015bfkw5awGW1oko4tjOZ2d1F5lS/NmMWfCs+pMT8Quwhq1HItLRZGP3sCTFof9OW49lr8KZcwKenDzEkCTZEuFjKeyY9nain4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wbJL4+JX15EYg+xMVR0rkFq01V3bp31sRCwvpxX8mw=;
 b=XIYd/oz8ZQyh/j0+/WP3yfW4TavKQoE5evf6UnhbMwdJ0vvPy5qBuaI3ANMZClqvAhAF1WMeR1kxbSbjT1HM0PEmKdMsAIEjPtfUUqbo0HQ7RK8P6lTKI6+/Vjp17o4bqqbdfGW7MFqOZ0x8scq5qLb0wq/DJ9ZYvQZifXD383RBewFC4cTMIEUgb9KLzSKtJjSjzZ0ylzA2VDneAr4Hqz9dawaO0c7vcjZV8lr4F8QTfxJ9l2e7xalQXr5Pw1QIqJKwPv63B+iPlkuxtA3fgsc1UwTzMCXhti0vU48RXcVVI2BwNmcsAt8ewGbCxJ5DUMMUhpg3wDb1D733EXIC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wbJL4+JX15EYg+xMVR0rkFq01V3bp31sRCwvpxX8mw=;
 b=WMyn1rd7Tsho7WPBrWGzOhedIHmtat70xSIMBtJ3HAH6VwhH0AyWPVt2EDUZcc5CCsZJih5/0RyxxCNHNNrOmssn8rSw9hnAuJQ4280W/d1fXHe5ld6dYrCyUbbfmgnGHDJ4czcB+Ytu8HScmrYbx9PSyxMnfk8DJG1Dgw4fN+U=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5001.eurprd08.prod.outlook.com (10.255.16.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Tue, 13 Aug 2019 13:00:44 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 13:00:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH 0/2] deal with BDRV_BLOCK_RAW
Thread-Index: AQHVUTlscGMEUismPEagfLbq4nW+tab36tGAgAABHQCAANb8gIAABheAgAAIyICAAE6FgP//2BGAgAATZoA=
Date: Tue, 13 Aug 2019 13:00:44 +0000
Message-ID: <ec8e53f4-92bf-17d4-7dd0-0f0f9dd12f96@virtuozzo.com>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <35b23140-25d5-627e-7a86-4b50fbc5be52@redhat.com>
 <e53a0399-f051-52bd-49e8-4ac4dbf2596f@redhat.com>
 <3d5fcc5b-cdb0-f028-1ea2-af85850db20e@virtuozzo.com>
 <15cf7372-826a-0684-d6ad-90deea36959e@virtuozzo.com>
 <43fb7754-6f94-00f6-6172-70cbb53e787c@virtuozzo.com>
 <94ccf129-cc7e-2778-7688-fd718f8df249@virtuozzo.com>
 <20190813115115.GG4663@localhost.localdomain>
In-Reply-To: <20190813115115.GG4663@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0053.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::42)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190813160041415
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b144d6c0-d703-4ce9-314a-08d71fee405b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5001; 
x-ms-traffictypediagnostic: DB8PR08MB5001:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5001DD37D450518D63D53FBFC1D20@DB8PR08MB5001.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(346002)(396003)(366004)(376002)(189003)(52314003)(53754006)(199004)(66946007)(66556008)(81156014)(478600001)(6246003)(107886003)(64756008)(31696002)(7736002)(81166006)(86362001)(305945005)(66476007)(14454004)(66446008)(8676002)(966005)(14444005)(256004)(36756003)(3846002)(2906002)(71190400001)(71200400001)(31686004)(6116002)(4326008)(6306002)(25786009)(6916009)(476003)(99286004)(76176011)(53936002)(2616005)(316002)(6486002)(229853002)(486006)(26005)(5660300002)(11346002)(52116002)(6436002)(446003)(66066001)(53546011)(386003)(6506007)(102836004)(186003)(8936002)(54906003)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5001;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ld84SIGjoS6/FTij50jFvDN/Bz/HI8j4fCSxzEYaMbRLAsVuJnFn4oWzXQu17tLOxNF2WIO0yuufBdXkUcT6qOmKMXqefctvfAbiLgxL6sTKlB5aqlfwZ9BcUlZvWijMFNni/iTYSFZmPW7tq3QLGcu9LIAVrWQvYgWs/hjRMbr8mEnqYc3+7B2JHGmRoW4htf3hF9RZVtwzLIiDoapJpZLu0Q3swQUsHoawvTjpvdj7QHDwUU7jXpjkABrT0DhyFzlxrb06JREMjDbY/5kWUvs06C+U5txq+3JxKgdlJ/ClxwDFFIemVS65TYxERVtq0xL12kqQrLt1emtNygqASFcE0gmQJzXs3xFnADo0WOmJB6RrqMRvUwnEJg9WPSHPlQd/VSAk91XJ8Ox8kmaeJnDBQ0Dguj1cp5hs59k5l0U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F1E49FF726BC74FAF65AD041FB01916@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b144d6c0-d703-4ce9-314a-08d71fee405b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 13:00:44.0972 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j34HxqjOeuZ0lHQcZnKXnz/HOOkRLdMZekkcnfOyTLX8x5aNe7IvjUNVUzoCtqWd/qRwTe538cueLYbHTHfF8dpC9/aNGY4apNUZQcdL8m8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5001
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.95
Subject: Re: [Qemu-devel] [PATCH 0/2] deal with BDRV_BLOCK_RAW
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDguMjAxOSAxNDo1MSwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTMuMDguMjAxOSB1bSAx
MzoxNCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDEz
LjA4LjIwMTkgMTI6MzMsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4g
MTMuMDguMjAxOSAxMjowMSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+
Pj4gMTMuMDguMjAxOSAxMTozOSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToN
Cj4+Pj4+IDEyLjA4LjIwMTkgMjI6NTAsIE1heCBSZWl0eiB3cm90ZToNCj4+Pj4+PiBPbiAxMi4w
OC4xOSAyMTo0NiwgTWF4IFJlaXR6IHdyb3RlOg0KPj4+Pj4+PiBPbiAxMi4wOC4xOSAyMDoxMSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4+Pj4+IEhpIGFsbCENCj4+
Pj4+Pj4+DQo+Pj4+Pj4+PiBJJ20gbm90IHN1cmUsIGlzIGl0IGEgYnVnIG9yIGEgZmVhdHVyZSwg
YnV0IHVzaW5nIHFjb3cyIHVuZGVyIHJhdyBpcw0KPj4+Pj4+Pj4gYnJva2VuLiBJdCBzaG91bGQg
YmUgZWl0aGVyIGZpeGVkIGxpa2UgSSBwcm9wb3NlIChieSBNYXgncyBzdWdnZXN0aW9uKQ0KPj4+
Pj4+Pj4gb3Igc29tZWhvdyBmb3JiaWRkZW4gKGp1c3QgZm9yYmlkIGJhY2tpbmctZmlsZSBzdXBw
b3J0aW5nIG5vZGUgdG8gYmUNCj4+Pj4+Pj4+IGZpbGUgY2hpbGQgb2YgcmF3LWZvcm1hdCBub2Rl
KS4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gSSBhZ3JlZSwgSSB0aGluayBvbmx5IGZpbHRlcnMgc2hvdWxk
IHJldHVybiBCRFJWX0JMT0NLX1JBVy4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gKEFuZCBub3QgZXZlbiB0
aGVtLCB0aGV5IHNob3VsZCBqdXN0IGJlIGhhbmRsZWQgdHJhbnNwYXJlbnRseSBieQ0KPj4+Pj4+
PiBiZHJ2X2NvX2Jsb2NrX3N0YXR1cygpLsKgIEJ1dCB0aGF04oCZcyBzb21ldGhpbmcgZm9yIGxh
dGVyLikNCj4+Pj4+Pj4NCj4+Pj4+Pj4+IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgKDIp
Og0KPj4+Pj4+Pj4gIMKgwqAgYmxvY2svcmF3LWZvcm1hdDogc3dpdGNoIHRvIEJEUlZfQkxPQ0tf
REFUQSB3aXRoIEJEUlZfQkxPQ0tfUkVDVVJTRQ0KPj4+Pj4+Pj4gIMKgwqAgaW90ZXN0czogdGVz
dCBtaXJyb3JpbmcgcWNvdzIgdW5kZXIgcmF3IGZvcm1hdA0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+ICDC
oCBibG9jay9yYXctZm9ybWF0LmPCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICstDQo+Pj4+Pj4+PiAg
wqAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI2M8KgwqDCoMKgIHwgNDYgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4+Pj4+Pj4+ICDCoCB0ZXN0cy9xZW11LWlvdGVzdHMvMjYz
Lm91dCB8IDEyICsrKysrKysrKysNCj4+Pj4+Pj4+ICDCoCB0ZXN0cy9xZW11LWlvdGVzdHMvZ3Jv
dXDCoMKgIHzCoCAxICsNCj4+Pj4+Pj4+ICDCoCA0IGZpbGVzIGNoYW5nZWQsIDYwIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pj4+Pj4+ICDCoCBjcmVhdGUgbW9kZSAxMDA3NTUgdGVz
dHMvcWVtdS1pb3Rlc3RzLzI2Mw0KPj4+Pj4+Pj4gIMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0
cy9xZW11LWlvdGVzdHMvMjYzLm91dA0KPj4+Pj4+Pg0KPj4+Pj4+PiBUaGFua3MsIGFwcGxpZWQg
dG8gbXkgYmxvY2stbmV4dCBicmFuY2g6DQo+Pj4+Pj4+DQo+Pj4+Pj4+IGh0dHBzOi8vZ2l0Lnhh
bmNsaWMubW9lL1hhbkNsaWMvcWVtdS9jb21taXRzL2JyYW5jaC9ibG9jay1uZXh0DQo+Pj4+Pj4N
Cj4+Pj4+PiBPb3BzLCBtYXliZSBub3QuwqAgMjIxIG5lZWRzIHRvIGJlIGFkanVzdGVkLg0KPj4+
Pj4+DQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IEhtbSB5ZXMsIEkgZm9yZ2V0IHRvIHJ1biB0ZXN0cy4u
IEFyZWFzIHdoaWNoIHdlcmUgemVybyBiZWNvbWVzIGRhdGF8emVybywgaXQNCj4+Pj4+IGRvbid0
IGxvb2sgZ29vZC4NCj4+Pj4+DQo+Pj4+PiBTbywgaXQncyBub3QgcXVpdGUgcmlnaHQgdG8gcmVw
b3J0IERBVEEgfCBSRUNVUlNFLCB3ZSBhY3R1YWxseSBzaG91bGQgcmVwb3J0DQo+Pj4+PiBEQVRB
X09SX1pFUk8gfCBSRUNVUlNFLCB3aGljaCBpcyBhY3R1YWxseSBBTExPQ0FURUQgfCBSRUNVUlNF
LCBhcyBvdGhlcndpc2UNCj4+Pj4+IERBVEEgd2lsbCBiZSBzZXQgaW4gZmluYWwgcmVzdWx0IChn
ZW5lcmljIGxheWVyIG11c3Qgbm90IGRyb3AgaXQsIG9idmlvdXNseSkuDQo+Pj4+Pg0KPj4+Pj4g
QUxMT0NBVEVEIG5ldmVyIHJldHVybmVkIGJ5IGRyaXZlcnMgYnV0IHNlZW1zIGl0IHNob3VsZCBi
ZS4gSSdsbCB0aGluayBhIGJpdCBhbmQNCj4+Pj4+IHJlc2VuZCBzb21ldGhpbmcgbmV3Lg0KPj4+
Pj4NCj4+Pj4+DQo+Pj4+DQo+Pj4+DQo+Pj4+IEhtbW0uLiBTbywgd2UgaGF2ZSByYXcgbm9kZSwg
YW5kIGFzc3VtZSBiYWNraW5nIGNoYWluIHVuZGVyIGl0LiB3aG8gc2hvdWxkIGxvb3AgdGhyb3Vn
aCBpdCwNCj4+Pj4gZ2VuZXJpYyBjb2RlIG9yIHJhdyBkcml2ZXI/DQo+Pj4+DQo+Pj4+IE5vdyBp
dCBhbGwgbG9va3MgbGlrZSBnZW5lcmljIGNvZGUgaXMgcmVzcG9uc2libGUgZm9yIGxvb3Bpbmcg
dGhyb3VnaCBmaWx0ZXJlZCBjaGFpbiAoYmFja2luZyBmaWxlcw0KPj4+PiBhbmQgZmlsdGVycykg
YW5kIGRyaXZlciBpcyByZXNwb25zaWJsZSBmb3IgYWxsIGl0J3MgY2hpbGRyZW4gZXhjZXB0IGZv
ciBmaWx0ZXJlZCBjaGlsZC4NCj4+Pj4NCj4+Pj4gT3IsIGRyaXZlciBtYXkgcmV0dXJuIHNvbWV0
aGluZyB0aGF0IHNheXMgdG8gZ2VuZXJpYyBjaGlsZCB0byBoYW5kbGUgdGhlIHdob2xlIGJhY2tp
bmcgY2hhaW4gb2YgcmV0dXJuZWQNCj4+Pj4gZmlsZSBhdCBvbmNlLCBhcyBpdCdzIGFub3RoZXIg
YmFja2luZyBjaGFpbi4gQW5kIHNlZW1zIGV2ZW4gUkVDVVJTRSBkb24ndCB3b3JrIGNvcnJlY3Rs
eSBhcyBpdCBkb2Vzbid0IGhhbmRsZQ0KPj4+PiB0aGUgYmFja2luZyBjaGFpbiBpbiB0aGlzIHJl
Y3Vyc2lvbi4gV2h5IGl0IHdvcmtzIGJldHRlciB0aGFuIFJBVyAtIGp1c3QgYmVjYXVzZSB3ZSBy
ZXR1cm4gaXQgdG9nZXRoZXINCj4+Pj4gd2l0aCBEQVRBIGZsYWdzIGFuZCB0aGlzIERBVEEgZmxh
ZyBpcyBrZXB0IGFueXdheSwgaW5kZXBlbmRlbnRseSBvZiBmaW5kaW5nIHplcm9zIG9yIG5vdC4N
Cj4+Pj4NCj4+Pj4NCj4+Pg0KPj4+DQo+Pj4gSG1tLCBzbywgaXMgaXQgY29ycmVjdCB0aGF0IHdl
IHJldHVybiBEQVRBIHwgUkVDVVJTRSwgaWYgd2UgYXJlIG5vdCByZWFsbHkgc3VyZSB0aGF0IGl0
IGlzIGRhdGE/DQo+Pj4NCj4+PiBJZiB3ZSBzZWUgYXQNCj4+Pg0KPj4+ICAgwqAqIEJEUlZfQkxP
Q0tfREFUQTogYWxsb2NhdGlvbiBmb3IgZGF0YSBhdCBvZmZzZXQgaXMgdGllZCB0byB0aGlzIGxh
eWVyDQo+Pj4NCj4+PiBzZWVtcyBsaWtlIHdlIHNob3VsZCByZXBvcnQgREFUQSBvbmx5IGlmIHRo
ZXJlIGlzIGFsbG9jYXRpb24uLg0KPj4+DQo+Pj4gICDCoCogREFUQSBaRVJPIE9GRlNFVF9WQUxJ
RA0KPj4+ICAgwqAqwqAgdMKgwqDCoCB0wqDCoMKgwqDCoMKgwqAgdMKgwqDCoMKgwqDCoCBzZWN0
b3JzIHJlYWQgYXMgemVybywgcmV0dXJuZWQgZmlsZSBpcyB6ZXJvIGF0IG9mZnNldA0KPj4+ICAg
wqAqwqAgdMKgwqDCoCBmwqDCoMKgwqDCoMKgwqAgdMKgwqDCoMKgwqDCoCBzZWN0b3JzIHJlYWQg
YXMgdmFsaWQgZnJvbSBmaWxlIGF0IG9mZnNldA0KPj4+ICAgwqAqwqAgZsKgwqDCoCB0wqDCoMKg
wqDCoMKgwqAgdMKgwqDCoMKgwqDCoCBzZWN0b3JzIHByZWFsbG9jYXRlZCwgcmVhZCBhcyB6ZXJv
LCByZXR1cm5lZCBmaWxlIG5vdA0KPj4+DQo+Pj4gc28sIFpFUk8gYWxvbmUgZG9lc24ndCBndWFy
YW50ZWUgdGhhdCB3ZSBtYXkgc2FmZWx5IHJlYWQ/DQo+Pj4NCj4+PiBTbywgZm9yIHFjb3cyIG1l
dGFkYXRhLXByZWFsbG9jYXRlZCBpbWFnZXMsIHdoYXQgYWJvdXQgemVyby1pbml0PyBXZSByZXBv
cnQgREFUQSwgYW5kIHByb2JhYmx5IGdldCBaRVJPIGZyb20NCj4+PiBmaWxlIGFuZCBoYXZlIGZp
bmFsbHkgREFZQSB8IFpFUk8gd2hpY2ggZ3VhcmFudGVlcyB0aGF0IHJlYWQgd2lsbCByZXR1cm4g
emVyb3MsIGJ1dCBpcyBpdCB0cnVlPw0KPj4+DQo+Pj4gRmluYWxseSwgd2hhdCAiREFUQSIgbWVh
bj8gVGhhdCBzcGFjZSBpcyBhbGxvY2F0ZWQgYW5kIG9jY3VwaWVzIGRpc2sgc3BhY2U/IE9yIGl0
IG9ubHnCoCBtZWFucyBvbmx5IEFMTE9DQVRFRCBpLmUuDQo+Pj4gInJlYWQgZnJvbSB0aGlzIGxh
eWVyLCBub3QgZnJvbSBiYWNraW5nIiBvdGhlcndpc2UsIGFuZCBhZGRzIGFkZGl0aW9uYWwgbWVh
bmluZyB0byBaRVJPIHdoZW4gdXNlZCB0b2dldGhlciwgdGhhdA0KPj4+IHJlYWQgd2lsbCByZXR1
cm4gemVyb3MgZm9yIHN1cmU/DQo+IA0KPiBJIHRoaW5rIERBVEEgbWVhbnMgdGhhdCB0aGUgZGF0
YSBmb3IgdGhpcyBibG9jayBpcyBwcm92aWRlZCBieSAqZmlsZS4gSQ0KPiB3b3VsZG4ndCBuZWNl
c3NhcmlseSB1bmRlcnN0YW5kIGl0IHRvIG1lYW4gdGhhdCB0aGUgZGF0YSBhY3R1YWxseSB0YWtl
cw0KPiB1cCBwaHlzaWNhbCBkaXNrIHNwYWNlIHRoZXJlLg0KPiANCj4+IENvbnRpbnVlIHNlbGYt
ZGlzY3Vzc2lvbi4NCj4+DQo+PiBDb25zaWRlciBjbG9zZXIgdGhlIGZvbGxvd2luZyBjYXNlOg0K
Pj4gICA+ICAgKiBEQVRBIFpFUk8gT0ZGU0VUX1ZBTElEDQo+PiAgID4gICAqICBmICAgIHQgICAg
ICAgIHQgICAgICAgc2VjdG9ycyBwcmVhbGxvY2F0ZWQsIHJlYWQgYXMgemVybywgcmV0dXJuZWQg
ZmlsZSBub3QNCj4+DQo+PiBJdCBhY3R1YWxseSBtZWFucyB0aGF0IHdlIG11c3Qgbm90IHJlYWQs
IGFzIHJlYWQgd2lsbCByZXR1cm4gd3JvbmcNCj4+IGRhdGEsIHdoZW4gY2x1c3RlcnMgYXJlIGFj
dHVhbGx5IHplcm8gZm9yIGd1ZXN0Lg0KPiANCj4gSXQgbWVhbnMgdGhhdCB5b3UgbmVlZCB0byBy
ZWFkIGZyb20gYnMgaXRzZWxmIHRvIGdldCB0aGUgY29ycmVjdCBkYXRhDQo+ICh3aGljaCB3aWxs
IGJlIHplcm8pLiBFdmVuIHRob3VnaCBPRkZTRVRfVkFMSUQgaXMgc2V0LCByZWFkaW5nIGZyb20N
Cj4gKmZpbGUgKHR5cGljYWxseSBicy0+ZmlsZS0+YnMpIGF0IHRoZSByZXR1cm5lZCBvZmZzZXQg
bWlnaHQgbm90IGdpdmUgdGhlDQo+IHJpZ2h0IHJlc3VsdC4NCj4gDQo+PiBJdCdzIE9LLCB3aGVu
IGZvciBleC4gcWNvdzIgcmV0dXJucyB0aGlzIGNvbWJpbmF0aW9uIGFuZCBsaW5rIHRvIGl0cw0K
Pj4gZmlsZSBjaGlsZDogaXQgbWVhbnMgdGhhdCBpZiB5b3UgcmVhZCBmcm9tIHFjb3cyIG5vZGUs
IHlvdSdsbCBzZWUNCj4+IGNvcnJlY3QgemVyb3MsIGFzIHFjb3cyIGhhcyBzcGVjaWFsIG1ldGFk
YXRhIHdoaWNoIHNob3dzIHRoYXQgdGhlc2UNCj4+IGNsdXN0ZXJzIGFyZSB6ZXJvLiBCdXQgaWYg
eW91IHJlYWQgZnJvbSBmaWxlIGRpcmVjdGx5IGF0IHJldHVybmVkDQo+PiBvZmZzZXQgeW91J2xs
IHNlZSBnYXJiYWdlLCBzbyBkb24ndCBkbyBpdC4NCj4gDQo+IENvcnJlY3QuDQo+IA0KPj4gQnV0
IHdoYXQgaWYgc29tZSBub2RlIHJldHVybnMgdGhpcyBjb21iaW5hdGlvbiB3aXRoIGZpbGUgPT0g
aXRzZWxmPyBJdA0KPj4gYWN0dWFsbHkgbWVhbnMgdGhhdCB5b3UgbXVzdCBub3QgcmVhZCwgYnV0
IHlvdSBzaG91bGQgY2FsbA0KPj4gYmxvY2stc3RhdHVzIHRvIHVuZGVyc3RhbmQgdGhhdCB0aGVy
ZSBhcmUgemVyb3MuIFNvLCBpZiBzb21lIGZvcm1hdA0KPj4gY2FuIHJldHVybiB0aGlzIGNvbWJp
bmF0aW9uIHdpdGggZmlsZSA9PSBpdHNlbGYgaXQgbWVhbnMgdGhhdCB5b3UgbXVzdA0KPj4gbm90
IHJlYWQgaXQgZGlyZWN0bHksIGJ1dCBvbmx5IGFmdGVyIGNoZWNraW5nIGJsb2NrIHN0YXR1cy4N
Cj4gDQo+IFRoaXMgZG9lc24ndCBtYWtlIHNlbnNlIHRvIG1lLiBSZWFkaW5nIGZyb20gYSBub2Rl
IGlzIGFsd2F5cyBjb3JyZWN0Lg0KPiANCj4gQnV0IHlvdSdyZSByaWdodCB0aGF0IERBVEEgc2Vl
bXMgdG8gbWVhbiBzb21ldGhpbmcgc2xpZ2h0bHkgZGlmZmVyZW50IGF0DQo+IHRoZSBwcm90b2Nv
bCBsZXZlbCBiZWNhdXNlICpmaWxlIGNhbm5vdCBoYXZlIGEgbWVhbmluZ2Z1bCB2YWx1ZSBmb3Ig
dGhlDQo+IGxvd2VyIGxheWVyIHRoZXJlLiBJbiB0aGlzIGNhc2UsIERBVEEgc3RpbGwgc2VlbXMg
dG8gbWVhbiB0aGF0IHRoZSBkYXRhDQo+IGlzIGZldGNoZWQgZnJvbSB0aGUgbG93ZXIgbGF5ZXIg
KGkuZS4gdGhlIGJsb2NrIGRldmljZSBvbiB3aGljaCB0aGUgZmlsZQ0KPiBzeXN0ZW0gcmVzaWRl
cykuIEZvciBob2xlcywgdGhpcyBpcyBub3QgdGhlIGNhc2UuDQo+IA0KPj4gQW5kIGZpbGUtcG9z
aXggaXMgZXhhbXBsZSBvZiBzdWNoIGRyaXZlci4gQnV0IGZpbGUtcG9zaXggaG9sZXMgYXJlIGd1
YXJhbnRlZWQgdG8gcmVhZCBhcyB6ZXJvLCBzbyB3ZSBjYW4gcmVwb3J0IERBVEEgfCBaRVJPLg0K
Pj4gQnV0IHRoaXMgd2lsbCBicmVhayB1c2VyIGV4cGlyaWVuY2Ugd2hpY2ggYXNzdW1lcyB0aGF0
IERBVEEgbWVhbnMgb2NjdXBhdGlvbiBvZiByZWFsIGRpc2sgc3BhY2UuDQo+IA0KPiBXaXRoIHRo
ZSBhYm92ZSBleHBsYW5hdGlvbiwgREFUQSBzaG91bGRuJ3QgYmUgc2V0IGZvciBob2xlcy4NCj4g
DQo+IEJ1dCBpdCdzIHN0aWxsIGtpbmQgb2YgaW5jb25zaXN0ZW50IGJlY2F1c2UgT0ZGU0VUX1ZB
TElEIGFuZCB0aGUgb2Zmc2V0DQo+IHJlZmVyIHRvIGJzIGl0c2VsZiBhbmQgbm90IHRvIHRoZSBs
b3dlciBsYXllci4NCj4gDQo+PiAuLi4NCj4+IG1lIGdvIGFuZCByZS1yZWFkIHdoYXQgd2UndmUg
ZG9jdW1lbnRlZCBpbiBOQkQgcHJvdG9jb2wgYWJvdXQgYmxvY2sgc3RldXMuLi4NCj4+DQo+PiAi
REFUQSIgdHVybnMgaW50byBOQkRfU1RBVEVfSE9MRSwgd2hpY2ggZm9ybWFsbHkgbWVhbnMgbm90
aGluZywgYW5kIGp1c3Qgbm90ZXMgdGhhdCBwcm9iYWJseSB0aGVyZSBpcyBubyBkaXNrIHNwYWNl
IG9jY3VwYXRpb24NCj4+IGZvciB0aGlzIHJlZ2lvbi4uIFNvIGl0J3MgYWJvdXQgZGlzayBzcGFj
ZSBhbGxvY2F0aW9uIGFuZCBub3RoaW5nIGFib3V0IGNvcnJlY3RuZXNzIG9mIHJlYWQuDQo+PiBh
bmQgTkJEX1NUQVRFX1pFUk8gZ3VhcmFudGVlcyB0aGF0IHJlZ2lvbiByZWFkIGFzIGFsbCB6ZXJv
ZXMuDQo+Pg0KPj4gTG9vayBhdCBjb2RlIGluIG5iZC9zZXJ2ZXIuYy4uIEFoYSwgaXQgY2FsbHMg
YmxvY2tfc3RhdHVzX2Fib3ZlIGFuZCB0dXJucyAhQUxMT0NBVEVEIGludG8gSE9MRS4gV2hpY2gg
bWVhbnMgdGhhdCBpdCB3aWxsIG5ldmVyDQo+PiByZXR1cm4gSE9MRSBmb3IgZmlsZS1wb3NpeC4u
DQo+IA0KPiBIbS4uLiBUaGlzIGlzIGEgbWVzcy4gOi0pDQo+IA0KDQoNCkknbSBhZnJhaWQgdGhl
IHRoZXNlIGFsbCBhcmUgY29uc2VxdWVuY2VzIG9mIHJlYWxseSBkaWZmZXJlbnQgdXNhZ2VzIG9m
IEJMT0NLX1NUQVRVUzoNCg0KMS4gRm9yIGJhY2tpbmctY2hhaW4gYXdhcmUgYmxvY2stam9icywg
dG8gd29yayB3aXRoIG92ZXJsYXlzLiBTbyBiYWNraW5nIGNoaWxkcmVuIGFyZSBkaWZmZXJlbnQg
ZnJvbSB0aGUgb3RoZXJzLA0KYXMgdGhleSBhcmUgcHJlc2VudGluZyBvdmVybGF5cywgd2hpY2gg
bWF5IGJlIHVzZWQgaW4gc2VwYXJhdGUsIGFuZCBvdGhlciBjaGlsZHJlbiBhcmUgbm90IG92ZXJs
YXlzIGFuZCAibW9yZSBvd25lZCIgYnkgdGhlaXIgcGFyZW50cw0KDQoyLiBUbyB1bmRlcnN0YW5k
IHdoZXJlIGFyZSB6ZXJvZXMgYW5kIGltcHJvdmUgcGVyZm9ybWFuY2Ugb2YgY29weWluZyBsb29w
cyAobm90IGNvcHlpbmcgemVyb2VzLCBub3Qgc2VuZGluZyB6ZXJvZXMgdGhyb3VnaCB0aGUgd2ly
ZSwNCiAgdXNlIGVmZmVjdGl2ZSB3cml0ZV96ZXJvZXMpDQoNCjMuIFRvIHNob3cgZmlsZS1tYXBw
aW5nIChxZW11LWltZyBtYXApDQoNCjQuIE1pcnJvciB1c2UgaXQgdG8gZG8gRElTQ0FSRCBpZiAi
VU5BTExPQ0FURUQiLCBidXQgc2VlbXMgd3JvbmcgZm9yIG1lIG5vdy4uIEZvciB3aGljaCBkcml2
ZXIgYmRydl9ibG9ja19zdGF0dXNfYWJvdmUoc291cmNlLCBOVUxMLC4uLikNCndpbGwgcmV0dXJu
IFVOQUxMT0NBVEVEPyBTZWVtcyBuZWl0aGVyIGZpbGUtcG9zaXggbm9yIHFjb3cyLg0KDQphbnl0
aGluZyBlbHNlPw0KDQpNYXkgYmUgd2Ugc2hvdWxkIHNwbGl0IHRoZXNlIHVzZSBjYXNlcyBpbnN0
ZWFkIG9mIHRyeWluZyB0byBjb21iaW5lIHRoZW0gdXNpbmcgYSBsb3Qgb2YgcmV0dXJuZWQgZmxh
Z3MgYW5kIHBhcmFtZXRlcnM/DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

