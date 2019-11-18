Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF3BC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 10:28:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F385D2071B
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 10:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="h2xY0/8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F385D2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWeGH-0008BQ-1l
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 05:28:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iWeFD-0007dF-0N
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:26:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iWeFB-00043n-Of
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:26:54 -0500
Received: from mail-eopbgr30115.outbound.protection.outlook.com
 ([40.107.3.115]:10753 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iWeF6-00041R-UW; Mon, 18 Nov 2019 05:26:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvtfkDbrm506SqrqLT5lLodqYFb6nb2atpkOMC+MfgjF92dbU+UOhvM8erh6ZW6kFn3LphWH/5NKs2QRc9r2MrRGHGiw4EE8MAULqPUH00qEnwHgphk/AIHRklN5yDQcjBPrUDPeste2FKIzvnn5n9UPMxWlmpG3zDontuKbW4WVV7OQ84xvk5RcM3hgDKOMMHz8tHmmo3ke6DNby55EUeUKWuRL2/vKVkUHPrhdE9opG2crc7KQyDZwTG/h4jKlFgAVvXF6K5xrSRNAGc2zO7JWVlag7+LQXeh2QS+CNYo6z1dnT1cetlY3gG7yYAI2BFaPgNodeYiAdo4Hzc1EjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zNVumjqpXypWKF2dDmH4sPCAtqUhZ+4yV7VJ8cZo7k=;
 b=mjGnGZga+4ZVjGdlkkFd5aAoHxkgwnDsLNThcNELXmiDEPnyFkTOZlpAMckfpE3dr+dBBe86vkcQnAKwxrTaG9soCar9DEDi4Urcufjv9/J8upxT8JmY7IIKCtOr6jTeg1OtQPMkSjcq0tlXD10jNrGgzRumF2HIuiE7uoV0K9sS3EDzT3pzc8Pm2uWgv2SqyaFB8eKiCqcawUyMDamo9qjbQFVaBWq4VV1hgHygz0efmhzFpkE6Jdgw5gobaRKQdvhbXHgcZuG6avDk/xCTkbi/mN0YasidfjcMlHYbSeayCjk5Q6MAEzXECzC3J8tNUjj+0pdSIIL0g04ln9+gGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zNVumjqpXypWKF2dDmH4sPCAtqUhZ+4yV7VJ8cZo7k=;
 b=h2xY0/8PbkeX0OleJuPAX28ezLor8Jw4AOoEVB8r96gr5kShe6AvIaG+8rkCF/ElCrKYg+WNrfDlxeU6dxO6wbsgKRbXANmBkdOhqP15F+V4eag4FY54ZSHY86hng/+27trSZVhMN67eGjzHdeFFdwYGi61lu2FlKNj8Piu5tDk=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4676.eurprd08.prod.outlook.com (10.255.99.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Mon, 18 Nov 2019 10:26:45 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 10:26:45 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v8 3/3] tests/qemu-iotests: add case to write compressed
 data of multiple clusters
Thread-Topic: [PATCH v8 3/3] tests/qemu-iotests: add case to write compressed
 data of multiple clusters
Thread-Index: AQHVndPpAcY2KMoGc0yJ555J90BV9aeQubCA
Date: Mon, 18 Nov 2019 10:26:45 +0000
Message-ID: <d15be06e-65fe-ff4f-e36d-c6c5f949137a@virtuozzo.com>
References: <1574056144-625164-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1574056144-625164-4-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1574056144-625164-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0088.eurprd02.prod.outlook.com
 (2603:10a6:7:29::17) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191118132643036
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45d3f93d-a8b4-47a4-da59-08d76c11cf9b
x-ms-traffictypediagnostic: AM6PR08MB4676:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB467652CDF4A2DF321FE9375BC14D0@AM6PR08MB4676.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(396003)(39840400004)(366004)(376002)(189003)(199004)(66556008)(6246003)(64756008)(102836004)(66446008)(256004)(7736002)(305945005)(107886003)(2501003)(86362001)(8676002)(5660300002)(110136005)(71200400001)(6486002)(99286004)(54906003)(8936002)(2906002)(446003)(316002)(2201001)(81166006)(76176011)(52116002)(11346002)(81156014)(66476007)(66946007)(6512007)(386003)(6506007)(31686004)(4326008)(26005)(486006)(6436002)(476003)(14454004)(36756003)(25786009)(71190400001)(478600001)(229853002)(186003)(31696002)(6116002)(2616005)(3846002)(66066001)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4676;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M9hEGCCBlqBe158LL3/OFpHwKi6+mo8/p2PFcfDwcDT+gvmZ3RAlg+c5HDbMKQDMTUi6pnzLViH63FlxB6CCiqO1Snq1Eo2GvYvB6EZAby6cRNlTG0Xbo0lzehOVjToUHlPqUima1vI3p8g+zyZIB+vESrEkZMBlDRVC0ynLOpEbQb/XZRpxkSxvllbk/TKgP0TIGGDTTtk8lGS7uSEjghOo4msUv9TQvW7538QUSJaZkO34dVbjZ82617JfJHrBxyp+koNbwav8FmFTCnG90fV3p4UuZlpVkQEJJSIeT4FPZH4N4g4btHvdZ2hC3zT/Z5Jxs5MytEvRbLT0GiuuhZlv35foY/TTfel5MZ0a26LnotKECCGZbENK+5kzirWnnMq8umJXJnClhkJk2BrR0yXjJyuRoLhLcK50AIjC+6yD7Nfpr8Cq5lMmYebbpAf7
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFB465211BCE60449968C69E006C1359@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d3f93d-a8b4-47a4-da59-08d76c11cf9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 10:26:45.1584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WxGpYy5kXj7DYGKaVutXegQt1pM1IsHO+aH/1Y3PgyIDwuRLSi6dLg3vWmAjTeYuVN6BGFS5IhhpWgKkqLmkejD6G2IhugW0hERxy7yEXXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4676
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.115
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
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTguMTEuMjAxOSA4OjQ5LCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4gQWRkIHRoZSBjYXNl
IHRvIHRoZSBpb3Rlc3QgIzIxNCB0aGF0IGNoZWNrcyBwb3NzaWJpbGl0eSBvZiB3cml0aW5nDQo+
IGNvbXByZXNzZWQgZGF0YSBvZiBtb3JlIHRoYW4gb25lIGNsdXN0ZXIgc2l6ZS4gVGhlIHRlc3Qg
Y2FzZSBpbnZvbHZlcw0KPiB0aGUgY29tcHJlc3MgZmlsdGVyIGRyaXZlciBzaG93aW5nIGEgc2Ft
cGxlIHVzYWdlIG9mIHRoYXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgU2hpbmtldmlj
aCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4gLS0tDQo+ICAgdGVzdHMvcWVt
dS1pb3Rlc3RzLzIxNCAgICAgfCA0MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzIxNC5vdXQgfCAxNCArKysrKysrKysr
KysrKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNTcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8yMTQgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjE0DQo+
IGluZGV4IDIxZWM4YTIuLjUwMTIxMTIgMTAwNzU1DQo+IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0
cy8yMTQNCj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzIxNA0KPiBAQCAtODksNiArODksNDkg
QEAgX2NoZWNrX3Rlc3RfaW1nIC1yIGFsbA0KPiAgICRRRU1VX0lPIC1jICJyZWFkICAtUCAweDEx
ICAwIDRNIiAiJFRFU1RfSU1HIiAyPiYxIHwgX2ZpbHRlcl9xZW11X2lvIHwgX2ZpbHRlcl90ZXN0
ZGlyDQo+ICAgJFFFTVVfSU8gLWMgInJlYWQgIC1QIDB4MjIgNE0gNE0iICIkVEVTVF9JTUciIDI+
JjEgfCBfZmlsdGVyX3FlbXVfaW8gfCBfZmlsdGVyX3Rlc3RkaXINCj4gICANCj4gK2VjaG8NCj4g
K2VjaG8gIj09PSBXcml0ZSBjb21wcmVzc2VkIGRhdGEgb2YgbXVsdGlwbGUgY2x1c3RlcnMgPT09
Ig0KPiArZWNobw0KPiArY2x1c3Rlcl9zaXplPTB4MTAwMDANCj4gK19tYWtlX3Rlc3RfaW1nIDJN
IC1vIGNsdXN0ZXJfc2l6ZT0kY2x1c3Rlcl9zaXplDQo+ICsNCj4gK2VjaG8gIldyaXRlIHVuY29t
cHJlc3NlZCBkYXRhOiINCj4gK2xldCBkYXRhX3NpemU9IjggKiAkY2x1c3Rlcl9zaXplIg0KPiAr
JFFFTVVfSU8gLWMgIndyaXRlIC1QIDB4YWEgMCAkZGF0YV9zaXplIiAiJFRFU1RfSU1HIiBcDQo+
ICsgICAgICAgICAyPiYxIHwgX2ZpbHRlcl9xZW11X2lvIHwgX2ZpbHRlcl90ZXN0ZGlyDQo+ICtz
aXplQT0kKCRRRU1VX0lNRyBpbmZvIC0tb3V0cHV0PWpzb24gIiRURVNUX0lNRyIgfA0KPiArICAg
ICAgICBzZWQgLW4gJy8iYWN0dWFsLXNpemUiOi8gcy9bXjAtOV0vL2dwJykNCj4gKw0KPiArX21h
a2VfdGVzdF9pbWcgMk0gLW8gY2x1c3Rlcl9zaXplPSRjbHVzdGVyX3NpemUNCj4gK2VjaG8gIldy
aXRlIGNvbXByZXNzZWQgZGF0YToiDQo+ICtsZXQgZGF0YV9zaXplPSIzICogJGNsdXN0ZXJfc2l6
ZSArICgkY2x1c3Rlcl9zaXplIC8gMikiDQo+ICsjIFNldCBjb21wcmVzcyBvbi4gVGhhdCB3aWxs
IGFsaWduIHRoZSB3cml0dGVuIGRhdGENCj4gKyMgYnkgdGhlIGNsdXN0ZXIgc2l6ZSBhbmQgd2ls
bCB3cml0ZSB0aGVtIGNvbXByZXNzZWQuDQo+ICtRRU1VX0lPX09QVElPTlM9JFFFTVVfSU9fT1BU
SU9OU19OT19GTVQgXA0KPiArJFFFTVVfSU8gLWMgIndyaXRlIC1QIDB4YmIgMCAkZGF0YV9zaXpl
IiAtLWltYWdlLW9wdHMgXA0KPiArICAgICAgICAgImRyaXZlcj1jb21wcmVzcyxmaWxlLmRyaXZl
cj0kSU1HRk1ULGZpbGUuZmlsZS5kcml2ZXI9ZmlsZSxmaWxlLmZpbGUuZmlsZW5hbWU9JFRFU1Rf
SU1HIiBcDQo+ICsgICAgICAgICAyPiYxIHwgX2ZpbHRlcl9xZW11X2lvIHwgX2ZpbHRlcl90ZXN0
ZGlyDQo+ICsNCj4gK2xldCBvZmZzZXQ9IjQgKiAkY2x1c3Rlcl9zaXplIg0KDQpDb3VsZCB5b3Ug
bWFrZSBpdA0KbGV0IG9mZnNldD0iNCAqICRjbHVzdGVyX3NpemUgKyAoJGNsdXN0ZXJfc2l6ZSAv
IDQpIg0KDQpUbyBjaGVjayBib3RoIHVuYWxpZ25lZCBoZWFkIGFuZCB0YWlsPw0KSXQgc2hvdWxk
IG5vdCBjaGFuZ2UgdGhlIG91dHB1dC4NCg0KV2l0aCBvciB3aXRob3V0IHRoaXM6DQpSZXZpZXdl
ZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8u
Y29tPg0KDQpQUzogb2doLCBiYXNoIGlzIGNyYXp5LCBhcml0aG1ldGljIGluIHN0cmluZyBvX08N
Cg0KPiArUUVNVV9JT19PUFRJT05TPSRRRU1VX0lPX09QVElPTlNfTk9fRk1UIFwNCj4gKyRRRU1V
X0lPIC1jICJ3cml0ZSAtUCAweGNjICRvZmZzZXQgJGRhdGFfc2l6ZSIgImpzb246e1wNCj4gKyAg
ICAnZHJpdmVyJzogJ2NvbXByZXNzJywNCj4gKyAgICAnZmlsZSc6IHsnZHJpdmVyJzogJyRJTUdG
TVQnLA0KPiArICAgICAgICAgICAgICdmaWxlJzogeydkcml2ZXInOiAnZmlsZScsDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgJ2ZpbGVuYW1lJzogJyRURVNUX0lNRyd9fX0iIHwgXA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICBfZmlsdGVyX3FlbXVfaW8gfCBfZmlsdGVyX3Rlc3RkaXIN
Cj4gKw0KPiArc2l6ZUI9JCgkUUVNVV9JTUcgaW5mbyAtLW91dHB1dD1qc29uICIkVEVTVF9JTUci
IHwNCj4gKyAgICAgICAgc2VkIC1uICcvImFjdHVhbC1zaXplIjovIHMvW14wLTldLy9ncCcpDQo+
ICsNCj4gK2lmIFsgJHNpemVBIC1sZSAkc2l6ZUIgXQ0KPiArdGhlbg0KPiArICAgIGVjaG8gIkNv
bXByZXNzaW9uIEVSUk9SIg0KPiArZmkNCj4gKw0KPiArJFFFTVVfSU1HIGNoZWNrIC0tb3V0cHV0
PWpzb24gIiRURVNUX0lNRyIgfA0KPiArICAgICAgICAgIHNlZCAtbiAncy8sJC8vOyAvImNvbXBy
ZXNzZWQtY2x1c3RlcnMiOi8gcy9eICovL3AnDQo+ICsNCj4gICAjIHN1Y2Nlc3MsIGFsbCBkb25l
DQo+ICAgZWNobyAnKioqIGRvbmUnDQo+ICAgcm0gLWYgJHNlcS5mdWxsDQo+IGRpZmYgLS1naXQg
YS90ZXN0cy9xZW11LWlvdGVzdHMvMjE0Lm91dCBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yMTQub3V0
DQo+IGluZGV4IDBmY2Q4ZGMuLjRhMmVjMzMgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3FlbXUtaW90
ZXN0cy8yMTQub3V0DQo+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yMTQub3V0DQo+IEBAIC0z
Miw0ICszMiwxOCBAQCByZWFkIDQxOTQzMDQvNDE5NDMwNCBieXRlcyBhdCBvZmZzZXQgMA0KPiAg
IDQgTWlCLCBYIG9wczsgWFg6WFg6WFguWCAoWFhYIFlZWS9zZWMgYW5kIFhYWCBvcHMvc2VjKQ0K
PiAgIHJlYWQgNDE5NDMwNC80MTk0MzA0IGJ5dGVzIGF0IG9mZnNldCA0MTk0MzA0DQo+ICAgNCBN
aUIsIFggb3BzOyBYWDpYWDpYWC5YIChYWFggWVlZL3NlYyBhbmQgWFhYIG9wcy9zZWMpDQo+ICsN
Cj4gKz09PSBXcml0ZSBjb21wcmVzc2VkIGRhdGEgb2YgbXVsdGlwbGUgY2x1c3RlcnMgPT09DQo+
ICsNCj4gK0Zvcm1hdHRpbmcgJ1RFU1RfRElSL3QuSU1HRk1UJywgZm10PUlNR0ZNVCBzaXplPTIw
OTcxNTINCj4gK1dyaXRlIHVuY29tcHJlc3NlZCBkYXRhOg0KPiArd3JvdGUgNTI0Mjg4LzUyNDI4
OCBieXRlcyBhdCBvZmZzZXQgMA0KPiArNTEyIEtpQiwgWCBvcHM7IFhYOlhYOlhYLlggKFhYWCBZ
WVkvc2VjIGFuZCBYWFggb3BzL3NlYykNCj4gK0Zvcm1hdHRpbmcgJ1RFU1RfRElSL3QuSU1HRk1U
JywgZm10PUlNR0ZNVCBzaXplPTIwOTcxNTINCj4gK1dyaXRlIGNvbXByZXNzZWQgZGF0YToNCj4g
K3dyb3RlIDIyOTM3Ni8yMjkzNzYgYnl0ZXMgYXQgb2Zmc2V0IDANCj4gKzIyNCBLaUIsIFggb3Bz
OyBYWDpYWDpYWC5YIChYWFggWVlZL3NlYyBhbmQgWFhYIG9wcy9zZWMpDQo+ICt3cm90ZSAyMjkz
NzYvMjI5Mzc2IGJ5dGVzIGF0IG9mZnNldCAyNjIxNDQNCj4gKzIyNCBLaUIsIFggb3BzOyBYWDpY
WDpYWC5YIChYWFggWVlZL3NlYyBhbmQgWFhYIG9wcy9zZWMpDQo+ICsiY29tcHJlc3NlZC1jbHVz
dGVycyI6IDgNCj4gICAqKiogZG9uZQ0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRp
bWlyDQo=

