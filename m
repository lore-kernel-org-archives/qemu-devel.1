Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BFBC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:46:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628742081B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BfrpesxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628742081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8nmb-0004pf-Fb
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8nkR-0003MH-HQ
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8nkP-0004Q2-5h
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:44:35 -0400
Received: from mail-eopbgr10090.outbound.protection.outlook.com
 ([40.107.1.90]:55426 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i8nkL-0004OG-KF; Fri, 13 Sep 2019 11:44:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tl2ZuYmtLTmruBesHr2QKSwjh5NlQMW3+3giNQ5QP4k4yFWiPXzZ/OmUYCn/f6hHX15V8p3MwHxaEVdCOhVu/TKW9UVaVTECC1Jsyg42wqFIAAdGqqLP7QeqUPx79ue+lENJKSi4rI6GTWH0TZJYd5kxh+N+jk+v4jrvZFuSTcOp4a0yI0njCzM1KVslF+NJv3yP9KHl6vBv6gAgq6O6c1cH3o0jgJeaqBRR2bIdTJfmrCpCEr+4l0wfX+1/durTJI1/CLR3ei/XedoR2lO48M2KZ2vk2s9789pDRKEswyO6xcCVfZDFENKpgtR37YgHQE+6dYG8L5yNbnq2hFzmmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNmq1vQa2oZDJiuk3Q91vrV3ERaX0GEhQXa3oVlW8Pw=;
 b=JEU/bjp4+okpjJa2BreVZaK0WrLkrtVilEE76y8TgmQMV391UHt/3hQWwcUGzfzr6sDBCcVt5n3EZ/s6UEHfTbAsXA/FHOcVGOua3D2dTuiDiyFcc6CY0ETCjeAMkmm4xnVBCMBZ1O42BdHh0O9h9pGAogYSVRN41//oxOvSDqQDvV09EKiDJOWZ1abukbC9MHdIiOmBtADgoqypoYzhb8+r5mSe4gTuXqOPr1n95mTjUkHX4P0OLAY1vnPaE/s+SPccyGZgdbaS/5eEhN5vQIALUIYFnklBYfvgdU/dcrGtBCbH+A0Z7e4r3OCaRiPQKU5dnh+8Tw4+Yh9s960ypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNmq1vQa2oZDJiuk3Q91vrV3ERaX0GEhQXa3oVlW8Pw=;
 b=BfrpesxUXGg/XueVtUPy/eTwMSD9WQG22PeEGQ26xefBApoY+/nTiarwMCufcVrOeBtIg4P1IuEiXkgzWDHCZgk2Yh7eU6+FOI4QLpNzdFNlltnM3gql9Upt5EMtfyqRD40Tib0+4NBjrMEdmeX5GauGVaQs5egwavpqX2pJY/A=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5531.eurprd08.prod.outlook.com (52.133.243.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Fri, 13 Sep 2019 15:44:26 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.016; Fri, 13 Sep 2019
 15:44:26 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v11 00/14] backup-top filter driver for backup
Thread-Index: AQHVZ8HWxtObSmpobUyX4pt0f7s73acpxLgA
Date: Fri, 13 Sep 2019 15:44:26 +0000
Message-ID: <79205eda-576c-2dde-01a9-44e9a9fb74c5@virtuozzo.com>
References: <20190910102332.20560-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190910102332.20560-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0051.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::28) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190913184424236
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6a7d08a-1cd1-4c45-68d1-08d7386141fb
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5531; 
x-ms-traffictypediagnostic: DB8PR08MB5531:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB55317D323BA7304E3035F8E4C1B30@DB8PR08MB5531.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39840400004)(366004)(396003)(376002)(346002)(189003)(53754006)(199004)(6486002)(2501003)(66066001)(71190400001)(71200400001)(6436002)(476003)(36756003)(229853002)(66946007)(102836004)(66476007)(54906003)(66556008)(64756008)(66446008)(5640700003)(99286004)(53936002)(14444005)(256004)(52116002)(6246003)(107886003)(5660300002)(2351001)(31686004)(386003)(6506007)(486006)(4326008)(6512007)(2906002)(31696002)(478600001)(186003)(7736002)(2616005)(76176011)(305945005)(446003)(6916009)(25786009)(81166006)(81156014)(8936002)(8676002)(11346002)(316002)(6116002)(26005)(7416002)(3846002)(14454004)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5531;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1ftebU9TKBXrzTuBDKAEFXXvPlxRV++2NKGz61jSv9YP+wsFtkzfqIzoD8Wm+KjDJXtyk1HUXFLHsLi2SYHI2aiL+w91Me6SSUudyqNvkIXyskZz6xDTWOhyfvMKT89+lOm3FGpeaVDboc9IZDUm87+I/hNOaw6RNXCgPi2YIXPCILlP40LcoNneriAIHvXTv6NLIvkchmWmmmIKGvTPLSnfjA+V8ffOk1lf6sGKoqnLgckLkAzOT3HZN7J2vYncjfGBBTbAaawUZpNihC7Oi20ylNeI7MiadPp0AH0Q92iG0iaRNb7H6gTk3qGccbtsggTvCnvcCNIYUFB1i5H5lBx9jPp/0ThpQQJ9QCY6H8mNAD2cRbpo/YVXlGK0d2yRZPX/l4d12IZuKwDl2BiHKaLBk1+A/tqmx/GMpgKHpdo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA44B330A2511D49B75A2396D83B52A1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a7d08a-1cd1-4c45-68d1-08d7386141fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 15:44:26.7824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /rLU2VID7pEvYjk0XsKpjpKkdtkAGcvTbrwj34xWseFtD8Q7CkIxcZwvd53k2GfXm3hSozxNqu66BayG2KZD3yr25VnDI3x2nipWPJpv824=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5531
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.90
Subject: Re: [Qemu-devel] [PATCH v11 00/14] backup-top filter driver for
 backup
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
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTAuMDkuMjAxOSAxMzoyMywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
SGkgYWxsIQ0KPiANCj4gVGhlc2Ugc2VyaWVzIGludHJvZHVjZSBiYWNrdXAtdG9wIGRyaXZlci4g
SXQncyBhIGZpbHRlci1ub2RlLCB3aGljaA0KPiBkbyBjb3B5LWJlZm9yZS13cml0ZSBvcGVyYXRp
b24uIE1pcnJvciB1c2VzIGZpbHRlci1ub2RlIGZvciBoYW5kbGluZw0KPiBndWVzdCB3cml0ZXMs
IGxldCdzIG1vdmUgdG8gZmlsdGVyLW5vZGUgKGZyb20gd3JpdGUtbm90aWZpZXJzKSBmb3INCj4g
YmFja3VwIHRvby4NCj4gDQo+IHYxMTogYmFzZWQgb24gS2V2aW4ncyBibG9jayBicmFuY2gNCg0K
Tm93IGJhc2VkIG9uIG1hc3Rlcg0KDQo+IA0KPiAwMiwwMzogQWRkIE1heCdzIHItYg0KPiAwNDog
LSBpbXByb3ZlIGNvbW1lbnRzDQo+ICAgICAgLSByZWJhc2Ugb24gZHJvcHBlZCBiYWNrdXBfZHJh
aW4NCj4gICAgICAtIHMvam9iL2Jjcy8gaW4gdHJhY2UgZXZlbnRzDQo+IDA1OiBvbmUgaHVuayBk
cm9wcGVkIGR1ZSB0byByZWJhc2luZw0KPiAgICAgIG9uIGRyb3BwZWQgYmFja3VwX2RyYWluLCBz
dGlsbCwNCj4gICAgICBrZWVwIE1heCdzIHItYg0KPiAwNjogcmViYXNlZCBvbiAwNCBjaGFuZ2Vz
LCBrZWVwIE1heCdzIHItYg0KPiAwOCwxMywxNDogYWRkIE1heCdzIHItYg0KPiANCj4gQmFzZWQt
b246IGdpdDovL3JlcG8ub3IuY3ovcWVtdS9rZXZpbi5naXQgYmxvY2sNCj4gDQo+IFZsYWRpbWly
IFNlbWVudHNvdi1PZ2lldnNraXkgKDE0KToNCj4gICAgYmxvY2svYmFja3VwOiBmaXggYmFja3Vw
X2Nvd193aXRoX29mZmxvYWQgZm9yIGxhc3QgY2x1c3Rlcg0KPiAgICBibG9jay9iYWNrdXA6IHNw
bGl0IHNoYXJlYWJsZSBjb3B5aW5nIHBhcnQgZnJvbSBiYWNrdXBfZG9fY293DQo+ICAgIGJsb2Nr
L2JhY2t1cDogaW1wcm92ZSBjb21tZW50IGFib3V0IGltYWdlIGZsZWVjaW5nDQo+ICAgIGJsb2Nr
L2JhY2t1cDogaW50cm9kdWNlIEJsb2NrQ29weVN0YXRlDQo+ICAgIGJsb2NrL2JhY2t1cDogZml4
IGJsb2NrLWNvbW1lbnQgc3R5bGUNCj4gICAgYmxvY2s6IG1vdmUgYmxvY2tfY29weSBmcm9tIGJs
b2NrL2JhY2t1cC5jIHRvIHNlcGFyYXRlIGZpbGUNCj4gICAgYmxvY2s6IHRlYWNoIGJkcnZfZGVi
dWdfYnJlYWtwb2ludCBza2lwIGZpbHRlcnMgd2l0aCBiYWNraW5nDQo+ICAgIGlvdGVzdHM6IHBy
ZXBhcmUgMTI0IGFuZCAyNTcgYml0bWFwIHF1ZXJ5aW5nIGZvciBiYWNrdXAtdG9wIGZpbHRlcg0K
PiAgICBpb3Rlc3RzOiAyNTc6IGRyb3AgdW51c2VkIERyaXZlLmRldmljZSBmaWVsZA0KPiAgICBp
b3Rlc3RzOiAyNTc6IGRyb3AgZGV2aWNlX2FkZA0KPiAgICBibG9jay9pbzogcmVmYWN0b3Igd2Fp
dF9zZXJpYWxpc2luZ19yZXF1ZXN0cw0KPiAgICBibG9jazogYWRkIGxvY2svdW5sb2NrIHJhbmdl
IGZ1bmN0aW9ucw0KPiAgICBibG9jazogaW50cm9kdWNlIGJhY2t1cC10b3AgZmlsdGVyIGRyaXZl
cg0KPiAgICBibG9jay9iYWNrdXA6IHVzZSBiYWNrdXAtdG9wIGluc3RlYWQgb2Ygd3JpdGUgbm90
aWZpZXJzDQo+IA0KPiAgIHFhcGkvYmxvY2stY29yZS5qc29uICAgICAgICAgIHwgICA4ICstDQo+
ICAgYmxvY2svYmFja3VwLXRvcC5oICAgICAgICAgICAgfCAgMzcgKysNCj4gICBpbmNsdWRlL2Js
b2NrL2Jsb2NrLWNvcHkuaCAgICB8ICA4NCArKysrDQo+ICAgaW5jbHVkZS9ibG9jay9ibG9ja19p
bnQuaCAgICAgfCAgIDUgKw0KPiAgIGJsb2NrLmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDM0
ICstDQo+ICAgYmxvY2svYmFja3VwLXRvcC5jICAgICAgICAgICAgfCAyNDAgKysrKysrKysrKysr
DQo+ICAgYmxvY2svYmFja3VwLmMgICAgICAgICAgICAgICAgfCA0NDAgKysrKy0tLS0tLS0tLS0t
LS0tLS0tDQo+ICAgYmxvY2svYmxvY2stY29weS5jICAgICAgICAgICAgfCAzMzcgKysrKysrKysr
KysrKysrKw0KPiAgIGJsb2NrL2lvLmMgICAgICAgICAgICAgICAgICAgIHwgIDY4ICsrKy0NCj4g
ICBibG9jay9yZXBsaWNhdGlvbi5jICAgICAgICAgICB8ICAgMiArLQ0KPiAgIGJsb2NrZGV2LmMg
ICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gICBibG9jay9NYWtlZmlsZS5vYmpzICAgICAg
ICAgICB8ICAgMyArDQo+ICAgYmxvY2svdHJhY2UtZXZlbnRzICAgICAgICAgICAgfCAgMTQgKy0N
Cj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMDU2ICAgICAgICB8ICAgOCArLQ0KPiAgIHRlc3RzL3Fl
bXUtaW90ZXN0cy8xMjQgICAgICAgIHwgIDgzICsrLS0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMv
MjU3ICAgICAgICB8ICA5MSArKy0tLQ0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8yNTcub3V0ICAg
IHwgNzE0ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICB0ZXN0cy9xZW11
LWlvdGVzdHMvaW90ZXN0cy5weSB8ICAyNyArKw0KPiAgIDE4IGZpbGVzIGNoYW5nZWQsIDEyNzgg
aW5zZXJ0aW9ucygrKSwgOTE4IGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBi
bG9jay9iYWNrdXAtdG9wLmgNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ibG9jay9i
bG9jay1jb3B5LmgNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYmxvY2svYmFja3VwLXRvcC5jDQo+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGJsb2NrL2Jsb2NrLWNvcHkuYw0KPiANCg0KDQotLSANCkJl
c3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

