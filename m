Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D325DC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 09:00:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B4D2206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 09:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="D2kTIuiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4D2206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56069 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE95t-0001YX-NJ
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 05:00:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hE958-0001Ds-IY
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hE957-00047N-7A
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:59:46 -0400
Received: from mail-am5eur02on070b.outbound.protection.outlook.com
	([2a01:111:f400:fe07::70b]:64729
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hE954-00045R-8V; Wed, 10 Apr 2019 04:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=1DW0UCNQWkW2w5w/LkG+I16dVs5zspCRu4KPFY+r87w=;
	b=D2kTIuiBEEm3VW0AetZ5Go1xBtd2A7yteqxsIXI9w3AZ4u/2Z7/VB89UL7kHKInd5tx4V8Fmqlha0SAE7xdRnRjsj1s5gc/ZFWWufhbBXAWfx9yhnW5K5+zcEx3PqcoDlS4Jf0Sn2V0eppr2mtrH4z5y32FDl8Gwvo7KX3KsITk=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3483.eurprd08.prod.outlook.com (20.176.238.156) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.16; Wed, 10 Apr 2019 08:59:37 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1771.021;
	Wed, 10 Apr 2019 08:59:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH 2/2] iotests: new test 253 check qemu-img convert force
	read
Thread-Index: AQHU7uRwAYGOssbE4kGZ0wklYGLvQaY1GaeA
Date: Wed, 10 Apr 2019 08:59:37 +0000
Message-ID: <eed87958-a12e-25ab-45f7-c533390c3dc9@virtuozzo.com>
References: <1554821792-968307-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554821792-968307-3-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1554821792-968307-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0344.eurprd05.prod.outlook.com
	(2603:10a6:7:92::39) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190410115935097
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 525bb0d4-6c0a-4e4c-acb4-08d6bd92dbe0
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3483; 
x-ms-traffictypediagnostic: DB7PR08MB3483:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB7PR08MB34831EE575F15E10C245A68EC12E0@DB7PR08MB3483.eurprd08.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(376002)(346002)(396003)(136003)(366004)(199004)(189003)(31696002)(86362001)(25786009)(71200400001)(6306002)(53936002)(71190400001)(8676002)(446003)(107886003)(2201001)(6512007)(68736007)(36756003)(5660300002)(26005)(81156014)(76176011)(81166006)(6246003)(102836004)(386003)(6506007)(106356001)(105586002)(186003)(478600001)(6116002)(52116002)(229853002)(110136005)(14454004)(54906003)(99286004)(2501003)(3846002)(66066001)(476003)(11346002)(97736004)(486006)(2616005)(31686004)(8936002)(2906002)(6486002)(316002)(7736002)(6436002)(4326008)(256004)(14444005)(305945005)(2004002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3483;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C/tz6OCKNM5NHEQ1x7rAdOVpeGnx7wSeS8xxGohKb/g4a5gsbjpecYQ7wjg8zltAcGeDW5fvGuk1J8yzL8PkNwvnC9KR0DGyL4sGjfqc6Ik2iezWmNHkZwg/c0EZo5ja6fDgLvHlDH9dF7WOsw3wkOhuv/e7ezyO91mHlSuFNDZg6z5N4n2GGWDAKBiXALjWdcpjDBayVwyRiXujVymiu7OrnQL8mwzdUf+aY2D7NADCr//kh9s0JKnNclO3z6n+99GxZKJk0Od0TwddMdgZZE5RfsnXbjIwMlaw+FKlki2nRRRGeq1QJGdjMVh/dRLyntJbu8GGkLuAXk2wRAgg9DadP1qw4mTn+PrkJsgxUjhSbt913iuai1XEki4QVHTgVeFWsMF4GJNRd8LTGZ5zc1QsaP7puGf1qIeq/c/v6l4=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <40AC2A6562D5534AA1B9E40BD581CA2F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525bb0d4-6c0a-4e4c-acb4-08d6bd92dbe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 08:59:37.4865 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3483
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe07::70b
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: new test 253 check qemu-img
 convert force read
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410085937.kXf_1Alw5z9FcCQNRqLjmK6JRN00v7xS-aBhGxqIzs0@z>

MDkuMDQuMjAxOSAxNzo1NiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IEEgbmV3IHRlc3Qg
Zm9yIHRoZSBwYXRjaCAncWVtdS1pbWcgY29udmVydDogaWdub3JlIHJlYWQgZXJyb3JzJw0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZp
cnR1b3p6by5jb20+DQo+IC0tLQ0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8yNTMgICAgIHwgNjkg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIHRlc3Rz
L3FlbXUtaW90ZXN0cy8yNTMub3V0IHwgIDQgKysrDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzL2dy
b3VwICAgfCAgMSArDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA3NCBpbnNlcnRpb25zKCspDQo+ICAg
Y3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL3FlbXUtaW90ZXN0cy8yNTMNCj4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgdGVzdHMvcWVtdS1pb3Rlc3RzLzI1My5vdXQNCj4gDQo+IGRpZmYgLS1naXQgYS90
ZXN0cy9xZW11LWlvdGVzdHMvMjUzIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI1Mw0KPiBuZXcgZmls
ZSBtb2RlIDEwMDc1NQ0KPiBpbmRleCAwMDAwMDAwLi42NzFhM2M0DQo+IC0tLSAvZGV2L251bGwN
Cj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI1Mw0KPiBAQCAtMCwwICsxLDY5IEBADQo+ICsj
IS91c3IvYmluL2VudiBweXRob24NCj4gKyMNCj4gKyMgVGVzdCBvZiB0aGUgJ3FlbXUtaW1nIGNv
bnZlcnQnIGZvciBhIGRhbWFnZWQgaW1hZ2UuDQo+ICsjDQo+ICsjIENvcHlyaWdodCAoYykgMjAx
OSBWaXJ0dW96em8gSW50ZXJuYXRpb25hbCBHbWJIDQo+ICsjDQo+ICsjIFRoaXMgcHJvZ3JhbSBp
cyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5DQo+
ICsjIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2Ug
YXMgcHVibGlzaGVkIGJ5DQo+ICsjIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhl
ciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yDQo+ICsjIChhdCB5b3VyIG9wdGlvbikgYW55
IGxhdGVyIHZlcnNpb24uDQo+ICsjDQo+ICsjIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBp
biB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLA0KPiArIyBidXQgV0lUSE9VVCBBTlkg
V0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZg0KPiArIyBNRVJD
SEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhl
DQo+ICsjIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuDQo+ICsj
DQo+ICsjIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlDQo+ICsjIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtLiAgSWYgbm90LCBz
ZWUgPGh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+Lg0KPiArIw0KPiArDQo+ICtpbXBvcnQg
aW90ZXN0cw0KPiAraW1wb3J0IG9zDQo+ICtmcm9tIGlvdGVzdHMgaW1wb3J0IHFlbXVfaW1nX2Ny
ZWF0ZSwgcWVtdV9pbywgcWVtdV9pbWdfcGlwZSwgXA0KPiArICAgIGZpbGVfcGF0aCwgbG9nDQo+
ICsNCj4gK2lvdGVzdHMudmVyaWZ5X2ltYWdlX2Zvcm1hdChzdXBwb3J0ZWRfZm10cz1bJ3Fjb3cy
J10pDQo+ICsNCj4gK2Rpc2sgPSBmaWxlX3BhdGgoJ2Rpc2snKQ0KPiArY2h1bmsgPSAyNTYgKiAx
MDI0DQo+ICtiYWRfc2VjdG9yID0gNzY4DQo+ICtibGtkZWJ1Z19maWxlID0gb3MucGF0aC5qb2lu
KGlvdGVzdHMudGVzdF9kaXIsICdibGtkZWJ1Zy5jb25mJykNCj4gKw0KPiArDQo+ICtkZWYgY3Jl
YXRlX2Jsa2RlYnVnX2ZpbGUoKToNCj4gKyAgICBmaWxlID0gb3BlbihibGtkZWJ1Z19maWxlLCAn
dycpDQo+ICsgICAgZmlsZS53cml0ZSgnJycNCj4gK1tpbmplY3QtZXJyb3JdDQo+ICtldmVudCA9
ICJyZWFkX2FpbyINCj4gK2Vycm5vID0gIjUiDQo+ICtvbmNlID0ib2ZmIg0KPiArc2VjdG9yID0g
IiVkIg0KPiArJycnICUgKGJhZF9zZWN0b3IpKQ0KPiArICAgIGZpbGUuY2xvc2UoKQ0KPiArDQo+
ICsNCj4gK2RlZiB3cml0ZV90b19kaXNrKG9mZnNldCwgc2l6ZSk6DQo+ICsgICAgd3JpdGUgPSAn
d3JpdGUgLVAgNyB7fSB7fScuZm9ybWF0KG9mZnNldCwgc2l6ZSkNCj4gKyAgICBxZW11X2lvKCct
YycsIHdyaXRlLCBkaXNrKQ0KPiArDQo+ICsNCj4gK3FlbXVfaW1nX2NyZWF0ZSgnLWYnLCBpb3Rl
c3RzLmltZ2ZtdCwgZGlzaywgJzFNJykNCj4gKw0KPiArZm9yIG51bSBpbiByYW5nZSgxLCA0KToN
Cj4gKyAgICB3cml0ZV90b19kaXNrKChudW0tMSkgKiBjaHVuaywgY2h1bmspDQo+ICsNCj4gK2Ny
ZWF0ZV9ibGtkZWJ1Z19maWxlKCkNCj4gK2Rpc2tfY29udmVydGVkID0gZGlzayArICdfY29udmVy
dGVkJw0KPiArbG9nKHFlbXVfaW1nX3BpcGUoJ2NvbnZlcnQnLCAnLU8nLCBpb3Rlc3RzLmltZ2Zt
dCwgJ2Jsa2RlYnVnOiVzOiVzJw0KPiArICAgICAgICAgICAgICAgICAgJSAoYmxrZGVidWdfZmls
ZSwgZGlzayksIGRpc2tfY29udmVydGVkKSkNCj4gK2xvZyhxZW11X2ltZ19waXBlKCdjb252ZXJ0
JywgJy1PJywgaW90ZXN0cy5pbWdmbXQsICctUicsICdibGtkZWJ1ZzolczolcycNCj4gKyAgICAg
ICAgICAgICAgICAgICUgKGJsa2RlYnVnX2ZpbGUsIGRpc2spLCBkaXNrX2NvbnZlcnRlZCkpDQo+
ICsNCj4gKyMgVE9ETzogd2l0aCBhIGNsYXNzLCBzZWxmLmFzc2VydE5vdEVxdWFsKA0KPiArIyAg
ICAgICBxZW11X2lvKCctZicsIGlvdGVzdHMuaW1nZm10LCAnLXJVJywgJy1jJywgJ21hcCcsIGRp
c2spLA0KPiArIyAgICAgICBxZW11X2lvKCctZicsIGlvdGVzdHMuaW1nZm10LCAnLXJVJywgJy1j
JywgJ21hcCcsIGRpc2tfY29udmVydGVkKSwNCj4gKyMgICAgICAgICAgICAgICAnaW1hZ2UgZmls
ZSBtYXAgbWF0Y2hlcyB0aGUgY29waWVkIGZpbGUgYWZ0ZXIgY29udmVyc2lvbicpDQoNCllvdSBt
YXkgdXNlIGp1c3QgYXNzZXJ0LiBCdXQgbWFwcyB3aWxsIG5vdCBiZSBkaWZmZXJlbnQuIEkgdGhp
bmsgYmV0dGVyIGlzIHRvDQpjaGVjayByZXN1bHRpbmcgaW1hZ2UgYnkgcWVtdS1pbyByZWFkIC1Q
Lg0KDQo+ICsNCj4gK29zLnJlbW92ZShkaXNrX2NvbnZlcnRlZCkNCj4gK29zLnJlbW92ZShibGtk
ZWJ1Z19maWxlKQ0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzI1My5vdXQgYi90
ZXN0cy9xZW11LWlvdGVzdHMvMjUzLm91dA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRl
eCAwMDAwMDAwLi5iOTcyNTQxDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvdGVzdHMvcWVtdS1p
b3Rlc3RzLzI1My5vdXQNCj4gQEAgLTAsMCArMSw0IEBADQo+ICtxZW11LWltZzogZXJyb3Igd2hp
bGUgcmVhZGluZyBzZWN0b3IgMDogSW5wdXQvb3V0cHV0IGVycm9yDQo+ICsNCj4gK3FlbXUtaW1n
OiBmYWlsZWQgdG8gcmVhZCA3ODY0MzIgYnl0ZXMgYXQgb2Zmc2V0IDA6IElucHV0L291dHB1dCBl
cnJvcg0KPiArDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvZ3JvdXAgYi90ZXN0
cy9xZW11LWlvdGVzdHMvZ3JvdXANCj4gaW5kZXggYmFlNzcxOC4uNGNkMmZlOCAxMDA2NDQNCj4g
LS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwDQo+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0
cy9ncm91cA0KPiBAQCAtMjQ4LDMgKzI0OCw0IEBADQo+ICAgMjQ2IHJ3IGF1dG8gcXVpY2sNCj4g
ICAyNDcgcncgYXV0byBxdWljaw0KPiAgIDI0OCBydyBhdXRvIHF1aWNrDQo+ICsyNTMgcncgYXV0
byBxdWljaw0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

