Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510A5C3A5A6
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 12:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1900023405
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 12:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XkUEppyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1900023405
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i42dM-00049O-8W
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 08:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i42bq-0003Bb-9K
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 08:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i42bp-0007qn-8R
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 08:36:02 -0400
Received: from mail-eopbgr60090.outbound.protection.outlook.com
 ([40.107.6.90]:28292 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i42bp-0007qM-3g; Sat, 31 Aug 2019 08:36:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fme+kuW6FNdr0M3RkslBaScQMuHh5RYr6X/H8jGiSiR3i/Zj/W31UakQ4MnkV4KQ6lZAiECiiz0ajetzXzJMVRCm/Ouxxjn+mzjKZtTDKejEM9bjeFybV9Ide9k6uTKOKhry6rlAYOTtt0ReIPxJR3VuMnvN245AK1bFMORjm05iIcR9j/al0Yy+YdqopN5vdG+KPnSdi8RF2BSuQzRCHBYW8LGPyQTHsFy2DGYu45UmQB54+Lz/O6qUQclg+m4P61ZztBYIQqfNUftKTi9rxF0pE1GWeXZlhp/ycrko5ysmTflgVxAB1k3E0lfOi0v3LtP8PgevLOxSHgXSOU4blA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WThGaMkvhIVJsw+WuLA1sklMKKdWZeLqInj5i+oeqGM=;
 b=BpsCueSaBHAwQJMOP7st3F6MLQ6B3Gf/9WC3jl2LVXP7kxffH21X7EctH++WHSS2L0YaEZJrSlTqhlBY8+6ytXe4Gow1qy3a3dv59KEoVFQId9LIvMkEKt0ddp+Os+MbmBuuTsD4oGTHZfo3bJncaJVdkNgRKfW9OBA2i+9dv/5cm3hNqsF2cuLRnyKC64RG4Hj4ClclHpj4+5MFmH8j8V3QxuWYnZrQJYzIKsFE7CMN1zHWpWqQUs3q3/G0wWmw/0JEA8X6Pd2KSP5UtAUtjeUtTY99Jxl04oMF72ha43UziMgk2uzUvl0FYV8tzACjtlMmhE49rBfKIqkQ8vn1IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WThGaMkvhIVJsw+WuLA1sklMKKdWZeLqInj5i+oeqGM=;
 b=XkUEppytZQBNgv+5iqOzpW75kUwSRsD4pQiR0x4TVEuAqrWw8V1aiNXL3Vs2+4gu8YJ7CTE8RE4vKcuXHd75XSDqNHOEDBPw2PBYyGSYoq6TUUOxSgSPF8fIsHd/4FC+a6XYIl0Re3ob9Hyih8S94GlAbEfpVOPwG2hbn9gMfJw=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5177.eurprd08.prod.outlook.com (10.255.16.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.19; Sat, 31 Aug 2019 12:35:59 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2220.020; Sat, 31 Aug 2019
 12:35:59 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 39/42] iotests: Add filter commit test cases
Thread-Index: AQHVTs20wdy/DNFIZ0aZW2rYA/oMs6cVU6kA
Date: Sat, 31 Aug 2019 12:35:58 +0000
Message-ID: <f3fa020d-569a-272c-bf7c-b438aff8bb45@virtuozzo.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-40-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-40-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::22) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190831153556861
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2baaf8e3-eeea-4fc2-86ca-08d72e0fc69d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5177; 
x-ms-traffictypediagnostic: DB8PR08MB5177:
x-microsoft-antispam-prvs: <DB8PR08MB5177B92BBDA7FE1E55F55E93C1BC0@DB8PR08MB5177.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:256;
x-forefront-prvs: 014617085B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(396003)(346002)(366004)(39840400004)(189003)(199004)(2501003)(4326008)(8676002)(110136005)(6486002)(7736002)(14454004)(5660300002)(31686004)(81156014)(66476007)(54906003)(6246003)(76176011)(305945005)(478600001)(31696002)(8936002)(66946007)(71200400001)(64756008)(66446008)(66556008)(99286004)(36756003)(2616005)(186003)(25786009)(486006)(52116002)(256004)(476003)(446003)(11346002)(102836004)(386003)(6506007)(2906002)(81166006)(53936002)(6512007)(86362001)(6436002)(66066001)(316002)(6116002)(3846002)(71190400001)(229853002)(26005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5177;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Xq7Yjug2nWsK8npmqXv0q4CZiDisUT90sA709QKXOXFVfCp1cGB52gi7S1bD499xGTGO8Z2kkt/ALQvbin1AlxXbcWDmVDkE5zQTg2P5oHMzFdqkv69SocVfZhaZQvvSfH+lsiI+nFg6xV4dW0HCwvP8X2h5LLdLAn6bdwrCK2WGWg3qogmp8yaoI6Kuh3KZ2euJxfjm+GyEyj+Ux/tpLvNFL/ihJIzf+A55zYuAiMcYrx3yDtagTVaplkecgaiJdnQvTeoOz1qzz9P0Gn4JDEdF0eZNMrasHN+xpNfLzEFeEQsezH2FPZJ1VFdwgZr+GlPknF+IgYXIBWRnyd8RmCgLlBo5SKuQrdJPPhiJzrf47b7OZrrD//K8/XYyOxxg9dsgHR3QNowc7yk5gRmdaSgZCQuJU57qf1ocoFRWZKc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDD6B62D21952C4DBA6FE610CF880FA7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2baaf8e3-eeea-4fc2-86ca-08d72e0fc69d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2019 12:35:58.9185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8coAqeXkwtDwL1QXkErp9/9huobLhMsi/La/YI009VQMpzADr9m+uTXWYxsxGuGq7CrXvAyHNdUuOOfpBfdco/KaEkrafBIBg9NvypO4u8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5177
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.90
Subject: Re: [Qemu-devel] [PATCH v6 39/42] iotests: Add filter commit test
 cases
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDguMjAxOSAxOToxNCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBUaGlzIHBhdGNoIGFkZHMgc29t
ZSB0ZXN0cyBvbiBob3cgY29tbWl0IGNvcGVzIHdpdGggZmlsdGVyIG5vZGVzLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgdGVz
dHMvcWVtdS1pb3Rlc3RzLzA0MCAgICAgfCAxNzcgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8wNDAub3V0IHwgICA0ICstDQo+ICAg
MiBmaWxlcyBjaGFuZ2VkLCAxNzkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvMDQwIGIvdGVzdHMvcWVtdS1pb3Rlc3Rz
LzA0MA0KPiBpbmRleCA2ZGI5YWJmOGU2Li5hMGEwZGI4ODg5IDEwMDc1NQ0KPiAtLS0gYS90ZXN0
cy9xZW11LWlvdGVzdHMvMDQwDQo+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8wNDANCj4gQEAg
LTQyOCw1ICs0MjgsMTgyIEBAIGNsYXNzIFRlc3RSZW9wZW5PdmVybGF5KEltYWdlQ29tbWl0VGVz
dENhc2UpOg0KPiAgICAgICBkZWYgdGVzdF9yZW9wZW5fb3ZlcmxheShzZWxmKToNCj4gICAgICAg
ICAgIHNlbGYucnVuX2NvbW1pdF90ZXN0KHNlbGYuaW1nMSwgc2VsZi5pbWcwKQ0KPiAgIA0KPiAr
Y2xhc3MgVGVzdENvbW1pdFdpdGhGaWx0ZXJzKGlvdGVzdHMuUU1QVGVzdENhc2UpOg0KPiArICAg
IGltZzAgPSBvcy5wYXRoLmpvaW4oaW90ZXN0cy50ZXN0X2RpciwgJzAuaW1nJykNCj4gKyAgICBp
bWcxID0gb3MucGF0aC5qb2luKGlvdGVzdHMudGVzdF9kaXIsICcxLmltZycpDQo+ICsgICAgaW1n
MiA9IG9zLnBhdGguam9pbihpb3Rlc3RzLnRlc3RfZGlyLCAnMi5pbWcnKQ0KPiArICAgIGltZzMg
PSBvcy5wYXRoLmpvaW4oaW90ZXN0cy50ZXN0X2RpciwgJzMuaW1nJykNCj4gKw0KPiArICAgIGRl
ZiBzZXRVcChzZWxmKToNCj4gKyAgICAgICAgcWVtdV9pbWcoJ2NyZWF0ZScsICctZicsIGlvdGVz
dHMuaW1nZm10LCBzZWxmLmltZzAsICc2NE0nKQ0KPiArICAgICAgICBxZW11X2ltZygnY3JlYXRl
JywgJy1mJywgaW90ZXN0cy5pbWdmbXQsIHNlbGYuaW1nMSwgJzY0TScpDQo+ICsgICAgICAgIHFl
bXVfaW1nKCdjcmVhdGUnLCAnLWYnLCBpb3Rlc3RzLmltZ2ZtdCwgc2VsZi5pbWcyLCAnNjRNJykN
Cj4gKyAgICAgICAgcWVtdV9pbWcoJ2NyZWF0ZScsICctZicsIGlvdGVzdHMuaW1nZm10LCBzZWxm
LmltZzMsICc2NE0nKQ0KPiArDQo+ICsgICAgICAgIHFlbXVfaW8oJy1mJywgaW90ZXN0cy5pbWdm
bXQsICctYycsICd3cml0ZSAtUCAxIDBNIDFNJywgc2VsZi5pbWcwKQ0KPiArICAgICAgICBxZW11
X2lvKCctZicsIGlvdGVzdHMuaW1nZm10LCAnLWMnLCAnd3JpdGUgLVAgMiAxTSAxTScsIHNlbGYu
aW1nMSkNCj4gKyAgICAgICAgcWVtdV9pbygnLWYnLCBpb3Rlc3RzLmltZ2ZtdCwgJy1jJywgJ3dy
aXRlIC1QIDMgMk0gMU0nLCBzZWxmLmltZzIpDQo+ICsgICAgICAgIHFlbXVfaW8oJy1mJywgaW90
ZXN0cy5pbWdmbXQsICctYycsICd3cml0ZSAtUCA0IDNNIDFNJywgc2VsZi5pbWczKQ0KPiArDQo+
ICsgICAgICAgICMgRGlzdHJpYnV0aW9ucyBvZiB0aGUgcGF0dGVybnMgaW4gdGhlIGZpbGVzOyB0
aGlzIGlzIGNoZWNrZWQNCj4gKyAgICAgICAgIyBieSB0ZWFyRG93bigpIGFuZCBzaG91bGQgYmUg
Y2hhbmdlZCBieSB0aGUgdGVzdCBjYXNlcyBhcyBpcw0KPiArICAgICAgICAjIG5lY2Vzc2FyeQ0K
PiArICAgICAgICBzZWxmLnBhdHRlcm5fZmlsZXMgPSBbc2VsZi5pbWcwLCBzZWxmLmltZzEsIHNl
bGYuaW1nMiwgc2VsZi5pbWczXQ0KPiArDQo+ICsgICAgICAgIHNlbGYudm0gPSBpb3Rlc3RzLlZN
KCkNCj4gKyAgICAgICAgc2VsZi52bS5sYXVuY2goKQ0KPiArICAgICAgICBzZWxmLmhhc19xdWl0
ID0gRmFsc2UNCg0KaGFzX3F1aXQgaXMgdW51c2VkIGFjdHVhbGx5LiBJdCdzIGFsd2F5cyBGYWxz
ZS4NCg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

