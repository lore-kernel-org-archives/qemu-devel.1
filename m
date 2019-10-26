Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87619CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 17:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E4382084C
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 17:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="f0HO4bsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4382084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOPRc-0000PH-0i
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 13:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iOPGk-0003v6-53
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 12:50:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iOPGi-0003oK-Eo
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 12:50:25 -0400
Received: from mail-ve1eur01on070a.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::70a]:16386
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iOPGh-0003nE-FY; Sat, 26 Oct 2019 12:50:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUpHZeiL+WyY106x+oCpIUs2UINqS4TILX3aY3n+HMjWM+A4O6OzQwuXC7+cd6AIsPzG318xSXEvXfHuHaHFo5ioRPf4T5BJc1JmBqrP1voTnpzRf7MJPoR6dfJYUyz5iunyg+tutZ8D9qLBY19L8rN2IdCn0Sv17HVlQVguGRq38OPOrKKUPyItaIt77BnIqU3JhM6yULmubuvS+Jml8azrcNIpkArPpd2xuxoSMdfOrZDhx2Oi41L92GTfdMcg3SmiZ+sNGcQBCzXs0OLuFikJWNpfqOkAhNZ217jLcYLDZ8lElsNStRuGkBcnkYEvlVHYRTdXQlxRVMUCCZQW4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5Sqie27XO2znpV+fwFrpZohnuQ1Am+I0RnElSM9CCM=;
 b=c7fN8Gytk1qgA4LlGNvFZmg+FCMHUiOiqFoH/VMoUKpOOmHSApfg7BnZd0HXXtWWemYahk1OSKGHN3mLewMiWZhkcN6KlrC3Aqp8ciSahPEX+kdZefciAD2iH5s7yN2ok2mZlUQYwKtvNmaveRBpwXZutytEF9U0jZzTGfIQbS65uF+KNCOXrskdl4YG7BlRWxFkkXVxuR5U67q+I79FVZ9k81mySaIJpQEVLPz0h1pKVEICNriqhijI1LVZEdcdZv8aitCu1EVQxkJ0yShPNI1EGlb88RQRsCyw73dEuTYmG9tNHrdkqv0kNaS7dpl3k66WqLTB4hADXAsj7wHmGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5Sqie27XO2znpV+fwFrpZohnuQ1Am+I0RnElSM9CCM=;
 b=f0HO4bsdLHg2q6whkgHZGLUyknchewoz1OntifJW3Ps3f7/gjpqobChTAx4U9ou61FFInJz2OUdz3nU4Lg1xEFB5EnvCuIZs8I7KbocXgErZr9uJkpaMkslYd1wrxX8B1Y4rzWDXgbW/P/YEy0Laj3Kk0QyPlbyP6kHo9bUx/x4=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB3681.eurprd08.prod.outlook.com (20.178.21.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Sat, 26 Oct 2019 16:50:19 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::dc12:c5b5:bd8e:f402]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::dc12:c5b5:bd8e:f402%4]) with mapi id 15.20.2387.025; Sat, 26 Oct 2019
 16:50:19 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Tuguoyi <tu.guoyi@h3c.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Topic: [PATCH] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Index: AdWL3hfRDHnwa5Z/SpmfNSa9xKBzHAAP1oSA
Date: Sat, 26 Oct 2019 16:50:19 +0000
Message-ID: <a4897ac0-3caf-2a8e-e55e-5866cadf9d24@virtuozzo.com>
References: <9845459389d245fcaca2c017c27be8bc@h3c.com>
In-Reply-To: <9845459389d245fcaca2c017c27be8bc@h3c.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0160.eurprd05.prod.outlook.com
 (2603:10a6:7:28::47) To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191026195017294
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 919254ce-4232-4dd1-ed73-08d75a3495b3
x-ms-traffictypediagnostic: AM0PR08MB3681:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR08MB3681BB47DBF0103CB655547AC1640@AM0PR08MB3681.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0202D21D2F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(346002)(376002)(136003)(39840400004)(52314003)(189003)(199004)(2501003)(2616005)(86362001)(76176011)(476003)(14454004)(386003)(66066001)(6116002)(3846002)(11346002)(36756003)(14444005)(5660300002)(256004)(486006)(110136005)(31686004)(71190400001)(71200400001)(6306002)(446003)(25786009)(4326008)(81166006)(81156014)(8676002)(6506007)(478600001)(66946007)(66476007)(64756008)(66446008)(966005)(5024004)(26005)(6246003)(6486002)(7416002)(54906003)(66556008)(305945005)(7736002)(52116002)(2906002)(2201001)(186003)(99286004)(6436002)(102836004)(316002)(31696002)(8936002)(229853002)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3681;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8RAU68W0Ff4AudEpHIPn/1ybC3L9/os5UAzsr93zx9pIYCvUv7TX3glflZ0MglMI2Etn2FVOj8tyiGdaAWtR3Jm75wO/LbBOowWHSUgtWafsJa6oHSE4rdNdj+yyKlekceoWIwX8xabGXhwLJAGaTES5q7pWXzfQp4OhOXFHS+75sXBAmxwkPBdECH52PS2xOXc5fVctCZCtLohcy38s09GEcg4rV61v2XYwsjylBJP1hsdXCH2qEflUizqzRl7xvFXI3h0J2MvBaCsBlrzzr7567yT4BthxYBYKuuCC0B70D0uEr5DmXPIvk6LmD0lNPmKHPTvqd42t51ZYY4UiZb8Gyvd+E7XRYL+JjaieLYhfVD/eSjGFPpxsOEAOQKsR3pIpfPYzhTnFBWCwvm1j5F2it0weJs/wn2p6cl2jS7Q5EU9E0WKfzbArUCaCKUwX5znLgy43KoLf31Z/F9rGgjTMqNM3TT4/O8jsUil4x04=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <09FF92EB250482488E802C2ACBA760A0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919254ce-4232-4dd1-ed73-08d75a3495b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2019 16:50:19.4659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: laWh06p81gf4SxsURr6Z3V9YT372WtoROwRmf6U0jH/oKK86WaD0ZX+2aVTXwb4rwBhgSCq1a1JfDSZpGZ0009r5lPY45q9OPOV8qWSrKMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3681
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::70a
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
 Wangyongqing <w_yongqing@h3c.com>, Changlimin <changlimin@h3c.com>,
 Gaoliang <liang_gao@h3c.com>, Wangyong <wang.yongD@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjYuMTAuMjAxOSAxMjoxOSwgVHVndW95aSB3cm90ZToNCj4gSW4gY2hlY2tfY29uc3RyYWludHNf
b25fYml0bWFwKCksIHRoZSBzYW5pdHkgY2hlY2sgb24gdGhlDQo+IGdyYW51bGFyaXR5IHdpbGwg
Y2F1c2UgdWludDY0X3QgaW50ZWdlciBsZWZ0LXNoaWZ0IG92ZXJmbG93DQo+IHdoZW4gY2x1c3Rl
cl9zaXplIGlzIDJNIGFuZCB0aGUgZ3JhbnVsYXJpdHkgaXMgYmlnZ2VyIHRoYW4NCj4gMzJLIHdo
aWNoIGlzIGV2ZW4gc21hbGxlciB0aGFuIHRoZSBkZWZhdWx0IHZhbHVlIGZvciBhIHFjb3cyDQo+
IGRpc2sgd2l0aCBjbHVzdGVyX3NpemUgc2V0IHRvIDY0ayBvciBiaWdnZXIuIFRoaXMgcGF0Y2gg
Zml4DQo+IHRoZSBpc3N1ZSBieSByaWdodC1zaGlmdCBAbGVuIGluc3RlYWQuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBHdW95aSBUdSA8dHUuZ3VveWlAaDNjLmNvbT4NCj4gLS0tDQo+ICAgYmxvY2sv
cWNvdzItYml0bWFwLmMgfCA0ICsrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL3Fjb3cyLWJpdG1h
cC5jIGIvYmxvY2svcWNvdzItYml0bWFwLmMNCj4gaW5kZXggOTgyOTRhNy4uMmExZDc4OSAxMDA2
NDQNCj4gLS0tIGEvYmxvY2svcWNvdzItYml0bWFwLmMNCj4gKysrIGIvYmxvY2svcWNvdzItYml0
bWFwLmMNCj4gQEAgLTE3Miw4ICsxNzIsOCBAQCBzdGF0aWMgaW50IGNoZWNrX2NvbnN0cmFpbnRz
X29uX2JpdG1hcChCbG9ja0RyaXZlclN0YXRlICpicywNCj4gICAgICAgfQ0KPiANCj4gICAgICAg
aWYgKChsZW4gPiAodWludDY0X3QpQk1FX01BWF9QSFlTX1NJWkUgPDwgZ3JhbnVsYXJpdHlfYml0
cykgfHwNCj4gLSAgICAgICAgKGxlbiA+ICh1aW50NjRfdClCTUVfTUFYX1RBQkxFX1NJWkUgKiBz
LT5jbHVzdGVyX3NpemUgPDwNCj4gLSAgICAgICAgICAgICAgIGdyYW51bGFyaXR5X2JpdHMpKQ0K
DQpIbW0uDQpCTUVfTUFYX1RBQkxFX1NJWkUgPSAweDgwMDAwMDANCg0KMHg4MDAwMDAwICogMTAy
NCAqIDEwMjQgKiAyIDw8IDE2ID0gMiAqKiA2NCwgc28gZm9yIDY0ayBncmFudWxhcml0eSBpdCBv
d2VyZmxvd3MuLg0KQnV0IGZvciAzMmsgZG9lc24ndC4gT3IgYW0gSSB3cm9uZz8NCg0KQW55d2F5
LCB0aGFua3MgZm9yIGZpeGluZyENCg0KPiArICAgICAgICAoKGxlbiA+PiBncmFudWxhcml0eV9i
aXRzKSA+ICh1aW50NjRfdClCTUVfTUFYX1RBQkxFX1NJWkUgKg0KPiArICAgICAgICAgICAgICAg
IHMtPmNsdXN0ZXJfc2l6ZSkpDQoNCkl0J3MgYSBiaXQgaW5jb3JyZWN0LCBhcyBsZW4gbWF5IGJl
IHVuYWxpZ25lZCwgd2UgbmVlZCAoKGxlbiArIGdyYW51bGFyaXR5IC0gMSkgPj4gZ3JhbnVsYXJp
dHlfYml0cykgb24gdGhlIGxlZnQsDQpvciBiZXR0ZXIgRElWX1JPVU5URF9VUChsZW4sIGdyYW51
bGFyaXR5KS4NCg0KPiAgICAgICB7DQo+ICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJUb28g
bXVjaCBzcGFjZSB3aWxsIGJlIG9jY3VwaWVkIGJ5IHRoZSBiaXRtYXAuICINCj4gICAgICAgICAg
ICAgICAgICAgICAgIlVzZSBsYXJnZXIgZ3JhbnVsYXJpdHkiKTsNCj4gLS0NCj4gMi43LjQNCj4g
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiDmnKzpgq7ku7blj4rlhbbpmYTku7blkKvmnInmlrDljY7k
uInpm4blm6LnmoTkv53lr4bkv6Hmga/vvIzku4XpmZDkuo7lj5HpgIHnu5nkuIrpnaLlnLDlnYDk
uK3liJflh7oNCj4g55qE5Liq5Lq65oiW576k57uE44CC56aB5q2i5Lu75L2V5YW25LuW5Lq65Lul
5Lu75L2V5b2i5byP5L2/55So77yI5YyF5ous5L2G5LiN6ZmQ5LqO5YWo6YOo5oiW6YOo5YiG5Zyw
5rOE6Zyy44CB5aSN5Yi244CBDQo+IOaIluaVo+WPke+8ieacrOmCruS7tuS4reeahOS/oeaBr+OA
guWmguaenOaCqOmUmeaUtuS6huacrOmCruS7tu+8jOivt+aCqOeri+WNs+eUteivneaIlumCruS7
tumAmuefpeWPkeS7tuS6uuW5tuWIoOmZpOacrA0KPiDpgq7ku7bvvIENCj4gVGhpcyBlLW1haWwg
YW5kIGl0cyBhdHRhY2htZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9t
IE5ldyBIM0MsIHdoaWNoIGlzDQo+IGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3IgZW50
aXR5IHdob3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9mIHRoZQ0KPiBpbmZv
cm1hdGlvbiBjb250YWluZWQgaGVyZWluIGluIGFueSB3YXkgKGluY2x1ZGluZywgYnV0IG5vdCBs
aW1pdGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsDQo+IGRpc2Nsb3N1cmUsIHJlcHJvZHVjdGlvbiwg
b3IgZGlzc2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZA0KPiBy
ZWNpcGllbnQocykgaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBlLW1haWwgaW4g
ZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlcg0KPiBieSBwaG9uZSBvciBlbWFpbCBpbW1l
ZGlhdGVseSBhbmQgZGVsZXRlIGl0IQ0KPiANCg0KTm90IHN1cmUgdGhhdCB0aGlzIGlzIHBvc3Np
YmxlLCBhcyBpdCdzIGF1dG9tYXRpY2FsbHkgYXZhaWxhYmxlIGhlcmU6DQpodHRwczovL2xpc3Rz
LmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAxOS0xMC9tc2cwNzMzNi5odG1sDQoN
Cg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

