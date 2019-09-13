Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9074DC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 16:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5671E206BB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 16:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="icaxGucc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5671E206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8ouI-0002re-6e
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 12:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8otI-0002Gp-QC
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 12:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8otH-0005tb-Kh
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 12:57:48 -0400
Received: from mail-eopbgr50107.outbound.protection.outlook.com
 ([40.107.5.107]:57987 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i8otA-0005dk-1n; Fri, 13 Sep 2019 12:57:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jewu96Wt7akZTIZrVL2ZlVldSl1rEGMpF0xZGl9GU1mmnt6cwrsk1bivfZh4j4134Yy3sZi5ZV2l05/dBkLQsa+a0w5Pz6jzsdmHItQsEGrvvXT7sT65giscrwW2g2zjyqjFW6D+X3mcPP38+heBPkIUUYF7RG+Ae6vKTj4psjb4IcQlg039/H66UbfK8zIQQ695pTf2dsvULFjGFODYUMSV9il5SqCN5nH8ZVS/AXNIRV2NwnvTjojbPJcRmtbZPrQi5Yo6LwZDPuIqqNiVJE2BjUsTFA00PScZYEr5cpbTg17p389/eVAfb6JZKtxvOeF7c38ulRcsUoSFMUmDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PraSCW444x9N/MxYZUlkzTFTAJ1eiOYsckNeMxGPP2Q=;
 b=SQZ2lRfdB81DboQrqE3weuVbUO0ASZwiwzFawCGgxkDb07FxYVhDwLbLMvpx41+wiQ4CcYrynovuw9O36wQRGsutGMaXyS3Ja1HfNVCYJvHw/bb+rsoZazMA3F2mpfG6DwA+XjfoU3BlU1wPextfZ6C8t4FDsQxnOcgq037L8XGLu72N2/P2sMcK0uC2vqk1QytDL57iUrAks+hX/g0gTeMqBU35VGyrJmbfs/Z8OBz7d3c03R5x5YZ/UzWfvtwUFtKE0vATI3jaYXybOUxpWCwRcB88pEJfbgXPhm+7oHiz4DLidbX7bjXbwzT74YRapZv8P7XBGxQ8m4yIr5eEmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PraSCW444x9N/MxYZUlkzTFTAJ1eiOYsckNeMxGPP2Q=;
 b=icaxGucc765eiv31qh9SkXqgspVzAHmJb8/scy9X+an9okG+m0A84o7z1wyHr170D0OUEjRS9vPV7TXfSrnqQBQacZR0iK3CsSH14Z6mRsOuRXjqcGsFB2iu84iKpyek44nvzJayIUKlGcWuuO7A2G/W4uq2DqydoCkWVcOTFeo=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5099.eurprd08.prod.outlook.com (10.255.18.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Fri, 13 Sep 2019 16:57:37 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.016; Fri, 13 Sep 2019
 16:57:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v5 3/3] qemu-iotests: Add test for bz #1745922
Thread-Index: AQHVakfqnOwubWUfBUOuND6B0BQjeacpy7CAgAADd4CAAAT2AA==
Date: Fri, 13 Sep 2019 16:57:37 +0000
Message-ID: <eee0c9f0-afbe-5ca0-173d-39d496816dfa@virtuozzo.com>
References: <20190913152818.17843-1-mlevitsk@redhat.com>
 <20190913152818.17843-4-mlevitsk@redhat.com>
 <5645f290-b34e-6b51-00cf-b7c4b4a0927a@virtuozzo.com>
 <46eebf1924837b97ee28eeb1f43d199b80b4bacd.camel@redhat.com>
In-Reply-To: <46eebf1924837b97ee28eeb1f43d199b80b4bacd.camel@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0271.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::23) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190913195734235
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 292666c5-cfdc-45dd-5450-08d7386b7b06
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5099; 
x-ms-traffictypediagnostic: DB8PR08MB5099:
x-microsoft-antispam-prvs: <DB8PR08MB50991205BA30E1481EC813B9C1B30@DB8PR08MB5099.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(366004)(346002)(39850400004)(136003)(189003)(199004)(81156014)(8936002)(478600001)(229853002)(6486002)(25786009)(6436002)(53936002)(3846002)(6116002)(476003)(6512007)(256004)(4326008)(5660300002)(86362001)(71190400001)(71200400001)(305945005)(7736002)(14454004)(54906003)(110136005)(11346002)(446003)(6506007)(102836004)(386003)(52116002)(31696002)(186003)(99286004)(6246003)(26005)(76176011)(486006)(66066001)(2906002)(36756003)(316002)(2616005)(2501003)(31686004)(66446008)(64756008)(66556008)(66476007)(8676002)(66946007)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5099;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sSdZDmypFkl52f/UlmS2Ssz6e9Z8czKKkfc7xlEuzA0UwWa6LUANEfpMRevYjmy2pGKKDDU4gAOBeNUC4E+CpGlAOP7nXM/ahfMHQRDiWS6YMWp9rfXsF9GafBWZFGHqIzolb6SiqFfCtABbnlM7odzKirgYUFgZuGdmm53ZexLSTCB2m99zXW2GW/vXlcyqJ8fbZP8m4efqgsINviP90VAtGWHsfbo6KvwqBWH41ovbZ5+pnrvEqibDYXtgH2M+vf02WjLyXdiF61RwtA1c8CNmPnV/z2A4KJHt+iuLi1IAYsnv7CjwGFINhefIVc86FniOXEVW+XWU522cmB4FGboLRGqM0eFaqFdbYBVCuCo+PUVO4EGVRhWDJ1v9tz2kmaGMOxWAGtWP8m3k9fN64JBOKYHXXA34vz6pNYrryak=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <38876496548EB3498397D04F2D7195EC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292666c5-cfdc-45dd-5450-08d7386b7b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 16:57:37.3843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hs2xZF5D6l5wYkSWms+7o1R1q31tXeVop30pDgwGNxDe57dk/X8W5jCVHR+bLwikMSpYNAMmtsJGwLe4n3l8mhqfFC9G6Rslr4aRyhjVyTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5099
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.107
Subject: Re: [Qemu-devel] [PATCH v5 3/3] qemu-iotests: Add test for bz
 #1745922
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

MTMuMDkuMjAxOSAxOTozOSwgTWF4aW0gTGV2aXRza3kgd3JvdGU6DQo+IE9uIEZyaSwgMjAxOS0w
OS0xMyBhdCAxNjoyNyArMDAwMCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToN
Cj4+IDEzLjA5LjIwMTkgMTg6MjgsIE1heGltIExldml0c2t5IHdyb3RlOg0KPj4+IFNpZ25lZC1v
ZmYtYnk6IE1heGltIExldml0c2t5IDxtbGV2aXRza0ByZWRoYXQuY29tPg0KPj4+IC0tLQ0KPj4+
ICAgIHRlc3RzL3FlbXUtaW90ZXN0cy8yNjMgICAgIHwgOTEgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4+PiAgICB0ZXN0cy9xZW11LWlvdGVzdHMvMjYzLm91dCB8IDQw
ICsrKysrKysrKysrKysrKysrDQo+Pj4gICAgdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwICAgfCAg
MiArDQo+Pj4gICAgMyBmaWxlcyBjaGFuZ2VkLCAxMzMgaW5zZXJ0aW9ucygrKQ0KPj4+ICAgIGNy
ZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0cy9xZW11LWlvdGVzdHMvMjYzDQo+Pj4gICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IHRlc3RzL3FlbXUtaW90ZXN0cy8yNjMub3V0DQo+Pj4NCj4+PiBkaWZmIC0tZ2l0
IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzI2MyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNjMNCj4+PiBu
ZXcgZmlsZSBtb2RlIDEwMDc1NQ0KPj4+IGluZGV4IDAwMDAwMDAwMDAuLmQyYzAzMGZhZTkNCj4+
PiAtLS0gL2Rldi9udWxsDQo+Pj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI2Mw0KPj4NCj4+
IFsuLl0NCj4+DQo+Pj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwDQo+Pj4gKysrIGIv
dGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwDQo+Pj4gQEAgLTI3NCw1ICsyNzQsNyBAQA0KPj4+ICAg
IDI1NyBydw0KPj4+ICAgIDI1OCBydyBxdWljaw0KPj4+ICAgIDI2MiBydyBxdWljayBtaWdyYXRp
b24NCj4+PiArMjYzIHJ3IHF1aWNrDQo+Pj4gICAgMjY1IHJ3IGF1dG8gcXVpY2sNCj4+PiAgICAy
NjYgcncgcXVpY2sNCj4+PiArPj4+Pj4+PiBwYXRjaGVkDQo+Pj4NCj4+DQo+PiBsYXN0IGxpbmUg
aXMgYSBtaXN0YWtlLg0KPiBMYXN0IG1pbnV0ZSBtZXJnZSBtaXN0YWtlIDotKA0KPiANCj4+DQo+
PiBhbHNvLCB0ZXN0IGZhaWxlZCBmb3IgbWU6DQo+Pg0KPj4gMjYzICAgICAgZmFpbCAgICAgICBb
MTk6MjE6MzVdIFsxOToyMTozNV0gICAgICAgICAgICAgICAgICAgIG91dHB1dCBtaXNtYXRjaCAo
c2VlIDI2My5vdXQuYmFkKQ0KPj4gLS0tIC93b3JrL3NyYy9xZW11L21heGltLWx1a3MvdGVzdHMv
cWVtdS1pb3Rlc3RzLzI2My5vdXQgICAgICAgIDIwMTktMDktMTMgMTk6MTE6NDUuNDY0NzI3NDI3
ICswMzAwDQo+PiArKysgL3dvcmsvc3JjL3FlbXUvbWF4aW0tbHVrcy90ZXN0cy9xZW11LWlvdGVz
dHMvMjYzLm91dC5iYWQgICAgMjAxOS0wOS0xMyAxOToyMTozNS41MzUzODEyNTMgKzAzMDANCj4+
IEBAIC0yLDYgKzIsNyBAQA0KPj4NCj4+ICAgIHRlc3RpbmcgTFVLUyBxY293MiBlbmNyeXB0aW9u
DQo+Pg0KPj4gK3FlbXUtaW1nOiBURVNUX0RJUi90LklNR0ZNVDogTm8gY3J5cHRvIGxpYnJhcnkg
c3VwcG9ydGluZyBQQktERiBpbiB0aGlzIGJ1aWxkOiBGdW5jdGlvbiBub3QgaW1wbGVtZW50ZWQN
Cj4+ICAgIEZvcm1hdHRpbmcgJ1RFU1RfRElSL3QuSU1HRk1UJywgZm10PUlNR0ZNVCBzaXplPTEw
NDg1NzYgZW5jcnlwdC5mb3JtYXQ9bHVrcyBlbmNyeXB0LmtleS1zZWNyZXQ9c2VjMCBlbmNyeXB0
Lml0ZXItdGltZT0xMA0KPj4gICAgPT0gcmVhZGluZyB0aGUgd2hvbGUgaW1hZ2UgPT0NCj4+ICAg
IHJlYWQgMTA0ODU3Ni8xMDQ4NTc2IGJ5dGVzIGF0IG9mZnNldCAwDQo+PiBGYWlsdXJlczogMjYz
DQo+PiBGYWlsZWQgMSBvZiAxIHRlc3RzDQo+Pg0KPj4NCj4+IGFuZCBpZiByZWNvbmZpZ3VyZSB3
aXRoDQo+PiAgICAtLWVuYWJsZS1nbnV0bHMgLS1lbmFibGUtZ2NyeXB0IC0tZW5hYmxlLXZob3N0
LWNyeXB0byAtLWVuYWJsZS1jcnlwdG8tYWZhbGcNCj4+IChkb24ndCBrbm93IHdoaWNoIG9uZSBp
cyBhY3R1YWxseSBuZWVkZWQpDQo+PiBpdCB3b3Jrcy4uDQo+Pg0KPj4gc28sIHdlIGF0IGxlYXN0
IHNob3VsZCBza2lwIHRoZSB0ZXN0IGlmIGl0J3MgdW5zdXBwb3J0ZWQNCj4gRG9uJ3Qga25vdy4g
SSBiYXNlZCB0aGlzIHRlc3Qgb24gMTg4IGFuZCBpdCBhbHNvIGRvZXNuJ3QgaGF2ZSBhbnl0aGlu
ZyBzcGVjaWFsIGFib3V0IHRoaXMuDQo+IEl0cyBub3QgaW4gYXV0byBncm91cCB0aG91Z2guDQo+
IEkgZ3Vlc3Mgd2UgbmVlZCB0byBhc2sgRGFuaWVsIGFib3V0IHRoaXMuDQo+IA0KPiANCg0KSG1t
LCB0aGUgcHJvYmxlbSB3YXMgbm90IGluICJjb25maWd1cmUiIGFyZ3VtZW50cywgc2VlbXMgbmVl
ZGVkIHRoaW5nIGlzIGVuYWJsZWQgYnkgZGVmYXVsdCwgYnV0IGFjdHVhbGx5DQphbGwgd29ya3Mg
Zm9yIG1lIGFmdGVyIGluc3RhbGxpbmcgZ251dGxzLWRldmVsDQoNCmFuZCB3aXRob3V0IGl0IDE4
OCBkb24ndCB3b3JrIHdpdGhvdXQgaXQgKG9yIHNvbWUgaXRzIGRlcGVuZGVuY2llcykgdG9vLiBT
byBpdCdzICJub3QgYSByZWdyZXNzaW9uIg0KYW5kIEknZG9udCBjYXJlOg0KDQpUZXN0ZWQtYnk6
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4N
CiAgIFtkb24ndCBmb3JnZXQgdG8gZHJvcCAiPj4+Pj4+PiBwYXRjaGVkIl0NCg0KYW5kIEkgYWxz
byBjaGVja2VkIHRoYXQgdGVzdCBmYWlscyBpZiBwb3NpdGlvbiBpdCBiZWZvcmUgcGF0Y2ggMDEs
IHNvIGl0J3MgdHJ1ZSBidWctY2F0Y2hlci4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1p
cg0K

