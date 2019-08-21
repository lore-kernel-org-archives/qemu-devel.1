Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C13EC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA273214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="O9wLW28D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA273214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VVd-00043G-8J
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i0UZz-0004bx-Ot
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i0UZw-0001aR-Vk
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:39:26 -0400
Received: from mail-eopbgr20128.outbound.protection.outlook.com
 ([40.107.2.128]:3958 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i0UZt-0001Z6-9E; Wed, 21 Aug 2019 13:39:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ko5FBsQMIPOrCc/AQlKg7pHzw6Gnj19cDPeJoyaLQi+4KXYDxzC44j+KXTBOyeJG5QwJIQMgacQSPMDg6PsJkCg2EAVeknqsOHD5oiX/BnWU4AH6baCW9KRtSzUzEszi7KIwmRfoJFVdN+U4ixCzShAW8FSOv4OlwjxHCny1LRM8ngC7oqw4PpcX7Imyw7L8czXN3wOwN6kR+YRNSqdehftG1ZQwQtw9wtW27DDthO6CYBnoX1MKJH7A9Nk+2nGthifinPCjYpIQrVZjjq+4tQFifNZ40xRaTFlKVnOK5HHRGczXYwJPcCiy7Mb/V05jlTDw8X+IWwAA1F8Q8NACKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHDR/zz5zQEGwoQUnmCR/O5vzvHy//fB1hsOI4lIHgQ=;
 b=cw1m9QpDZxAT+4dl+XqKdNrgtd4Xuyf3tdeM/Lx+8g8v/dkJtbZl/qoRw9CN0IpBeYeE1zxFjAAx5rEosinlD6WYsrXXNcawhp4Lgar+OoNn3jSOoj4lW2DI5p3kpl6+yYS2PxLcssMZOcj/T6UpZHNSbsjAs6S62u2pykppB1PipQUFK1Ru/v9FpobAjo2K/2nQM6xEsZz9OhwHzETjj8B45qo6xR39Ma9qfYKpU7ogRLh9sGFGI6Mn0K8GfCcbKphco9yWozNko0vW4PQ5yB6B3TKnXfSlrqyKhAXn19AWmmcQpdBOZWvfzcnrAJKc1tPzMmaYWiXmOxbYanJJhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHDR/zz5zQEGwoQUnmCR/O5vzvHy//fB1hsOI4lIHgQ=;
 b=O9wLW28Dg/RtbZDPprWTElG/Y5mPOJwIcOHjOUeGaoK4ECxUwfHMwxomhCn2DMS8LdDfCHIwZvzNuMgO6yps6hyZe5KP9SQMS9u8zCW1KigVILCH63UC57RkH1KAvEDMLYcyDZP2p0Ie31atGya9XuUGS6hkmac6J+veNdBAmB0=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB5504.eurprd08.prod.outlook.com (52.133.246.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 17:39:19 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7%6]) with mapi id 15.20.2157.024; Wed, 21 Aug 2019
 17:39:19 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v3 3/8] iotests: Allow skipping test cases
Thread-Index: AQHVVs6qaGofUpyS2UWZyryXo1QhGacF4RcA
Date: Wed, 21 Aug 2019 17:39:19 +0000
Message-ID: <25006dda-cbd8-bb8e-4fbd-9a7894982d25@virtuozzo.com>
References: <20190819201851.24418-1-mreitz@redhat.com>
 <20190819201851.24418-4-mreitz@redhat.com>
In-Reply-To: <20190819201851.24418-4-mreitz@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0041.eurprd09.prod.outlook.com
 (2603:10a6:7:15::30) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b14ed4e-faa0-4ee5-679e-08d7265e7ec0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:VI1PR08MB5504; 
x-ms-traffictypediagnostic: VI1PR08MB5504:
x-microsoft-antispam-prvs: <VI1PR08MB5504EFBF338F3F2E681D1F71F4AA0@VI1PR08MB5504.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(366004)(346002)(136003)(376002)(199004)(189003)(6116002)(66946007)(66476007)(3846002)(4326008)(44832011)(186003)(66556008)(110136005)(2906002)(54906003)(66446008)(53936002)(25786009)(316002)(446003)(11346002)(6246003)(26005)(486006)(64756008)(14454004)(2616005)(6486002)(52116002)(86362001)(6436002)(256004)(229853002)(5660300002)(7736002)(6512007)(81166006)(8936002)(81156014)(8676002)(476003)(305945005)(478600001)(31686004)(31696002)(386003)(71200400001)(71190400001)(102836004)(76176011)(53546011)(66066001)(36756003)(6506007)(2501003)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB5504;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K8BWQ5ibG0YDnKvkveAo5YjK3EtHYgiyxH2qK4pAAOXW/i95cVi9XRCtyH+PpSNMwVTuI0elaoKMwi3W2X/G7SPz2ZuSxK9nUfoEW+BbdqbgncrVPo+GlV3GCHLwqp60e+rjJtfP1ygAN377kPmpQEMH3kPZCXLpIdzCeozsQRd8w3G8Ubx+ONjRY/rQH2vAtZKVZQZ3H1U5Ld+7dKmD3CgHxuRCCr72DFuEh/KCR80FhLIa2yYvzngc6wqQJrlsa0REUSqHlg2R40CQRbMUUFxyQoZXBAtT3eEW4JlSmTnr/FC6Sj1OJ4z2hjr7fqjo0YhEf2j0s4T0+Vq9XZ4YFsWVNwozCJszIWspfvanjVcW/IajiECSezK3CwJrhl9odvb8nriwKZF9vH29s2nIr5fqZ6dyirGyXBHyXrZCOAg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EC278CF4D511947AAB55570F3C5BAB8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b14ed4e-faa0-4ee5-679e-08d7265e7ec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 17:39:19.2603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pKgo/C6G1LelIDguWW948VXgMiJsXuCaTQsD+yx/LqhnK6eFkajuzBAWjxMz8/LYaA0iMY5+41IKLHoFTd3WcSbTU9ULyQtE0Xttphpbg7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5504
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.128
Subject: Re: [Qemu-devel] [PATCH v3 3/8] iotests: Allow skipping test cases
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE5LzA4LzIwMTkgMjM6MTgsIE1heCBSZWl0eiB3cm90ZToNCj4gY2FzZV9ub3RydW4o
KSBkb2VzIG5vdCBhY3R1YWxseSBza2lwIHRoZSBjdXJyZW50IHRlc3QgY2FzZS4gIEl0IGp1c3QN
Cj4gYWRkcyBhICJub3RydW4iIG5vdGUgYW5kIHRoZW4gcmV0dXJucyB0byB0aGUgY2FsbGVyLCB3
aG8gbWFudWFsbHkgaGFzIHRvDQo+IHNraXAgdGhlIHRlc3QuICBHZW5lcmFsbHksIHNraXBwaW5n
IGEgdGVzdCBjYXNlIGlzIGFzIHNpbXBsZSBhcw0KPiByZXR1cm5pbmcgZnJvbSB0aGUgY3VycmVu
dCBmdW5jdGlvbiwgYnV0IG5vdCBhbHdheXM6IEZvciBleGFtcGxlLCB0aGlzDQo+IG1vZGVsIGRv
ZXMgbm90IGFsbG93IHNraXBwaW5nIHRlc3RzIGFscmVhZHkgaW4gdGhlIHNldFVwKCkgZnVuY3Rp
b24uDQo+IA0KPiBUaHVzLCBhZGQgYSBRTVBUZXN0Q2FzZS5jYXNlX3NraXAoKSBmdW5jdGlvbiB0
aGF0IGludm9rZXMgY2FzZV9ub3RydW4oKQ0KPiBhbmQgdGhlbiBzZWxmLnNraXBUZXN0KCkuICBU
byBtYWtlIHRoaXMgd29yaywgd2UgbmVlZCB0byBmaWx0ZXIgdGhlDQo+IGluZm9ybWF0aW9uIG9u
IGhvdyBtYW55IHRlc3QgY2FzZXMgd2VyZSBza2lwcGVkIGZyb20gdGhlIHVuaXR0ZXN0DQo+IG91
dHB1dC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+
DQo+IC0tLQ0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy9pb3Rlc3RzLnB5IHwgMjEgKysrKysrKysr
KysrKysrKysrLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMu
cHkgYi90ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weQ0KPiBpbmRleCA4NDQzOGU4MzdjLi4y
ZjUzYmFmNjMzIDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weQ0K
PiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weQ0KPiBAQCAtODAyLDYgKzgwMiwx
MSBAQCBjbGFzcyBRTVBUZXN0Q2FzZSh1bml0dGVzdC5UZXN0Q2FzZSk6DQo+ICAgICAgICAgICAg
ICAgcmV0dXJuIHNlbGYucGF1c2Vfd2FpdChqb2JfaWQpDQo+ICAgICAgICAgICByZXR1cm4gcmVz
dWx0DQo+ICAgDQo+ICsgICAgZGVmIGNhc2Vfc2tpcChzZWxmLCByZWFzb24pOg0KPiArICAgICAg
ICAnJydTa2lwIHRoaXMgdGVzdCBjYXNlJycnDQo+ICsgICAgICAgIGNhc2Vfbm90cnVuKHJlYXNv
bikNCj4gKyAgICAgICAgc2VsZi5za2lwVGVzdChyZWFzb24pDQo+ICsNCj4gICANCj4gICBkZWYg
bm90cnVuKHJlYXNvbik6DQo+ICAgICAgICcnJ1NraXAgdGhpcyB0ZXN0IHN1aXRlJycnDQo+IEBA
IC04MTMsNyArODE4LDEwIEBAIGRlZiBub3RydW4ocmVhc29uKToNCj4gICAgICAgc3lzLmV4aXQo
MCkNCj4gICANCj4gICBkZWYgY2FzZV9ub3RydW4ocmVhc29uKToNCj4gLSAgICAnJydTa2lwIHRo
aXMgdGVzdCBjYXNlJycnDQo+ICsgICAgJycnTWFyayB0aGlzIHRlc3QgY2FzZSBhcyBub3QgaGF2
aW5nIGJlZW4gcnVuLCBidXQgZG8gbm90IGFjdHVhbGx5DQo+ICsgICAgc2tpcCBpdDsgdGhhdCBp
cyBsZWZ0IHRvIHRoZSBjYWxsZXIuICBTZWUgUU1QVGVzdENhc2UuY2FzZV9za2lwKCkNCg0KVGhl
IGNsYXVzZSAiZG8gbm90IGFjdHVhbGx5IHNraXAgaXQiIHNvdW5kcyBsaWtlIGEgcHJlc2NyaXB0
aW9uLiBJIHdvdWxkIA0KbGlrZSB0aGUgY29tbWVudCB0byBiZSBjbGVhcmVyIGZvciBhIHJlYWRl
ciB0aGF0IHRoZSBtZXRob2QgaXMgYSANCm5vdGlmaWVyIG9ubHkuDQoNCkFuZHJleQ0KDQo+ICsg
ICAgZm9yIGEgdmFyaWFudCB0aGF0IGFjdHVhbGx5IHNraXBzIHRoZSBjdXJyZW50IHRlc3QgY2Fz
ZS4nJycNCj4gKw0KPiAgICAgICAjIEVhY2ggdGVzdCBpbiBxZW11LWlvdGVzdHMgaGFzIGEgbnVt
YmVyICgic2VxIikNCj4gICAgICAgc2VxID0gb3MucGF0aC5iYXNlbmFtZShzeXMuYXJndlswXSkN
Cj4gICANCj4gQEAgLTkwNCw4ICs5MTIsMTUgQEAgZGVmIGV4ZWN1dGVfdW5pdHRlc3Qob3V0cHV0
LCB2ZXJib3NpdHksIGRlYnVnKToNCj4gICAgICAgICAgIHVuaXR0ZXN0Lm1haW4odGVzdFJ1bm5l
cj1ydW5uZXIpDQo+ICAgICAgIGZpbmFsbHk6DQo+ICAgICAgICAgICBpZiBub3QgZGVidWc6DQo+
IC0gICAgICAgICAgICBzeXMuc3RkZXJyLndyaXRlKHJlLnN1YihyJ1JhbiAoXGQrKSB0ZXN0cz8g
aW4gW1xkLl0rcycsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByJ1Jh
biBcMSB0ZXN0cycsIG91dHB1dC5nZXR2YWx1ZSgpKSkNCj4gKyAgICAgICAgICAgIG91dCA9IG91
dHB1dC5nZXR2YWx1ZSgpDQo+ICsgICAgICAgICAgICBvdXQgPSByZS5zdWIocidSYW4gKFxkKykg
dGVzdHM/IGluIFtcZC5dK3MnLCByJ1JhbiBcMSB0ZXN0cycsIG91dCkNCj4gKw0KPiArICAgICAg
ICAgICAgIyBIaWRlIHNraXBwZWQgdGVzdHMgZnJvbSB0aGUgcmVmZXJlbmNlIG91dHB1dA0KPiAr
ICAgICAgICAgICAgb3V0ID0gcmUuc3ViKHInT0sgXChza2lwcGVkPVxkK1wpJywgJ09LJywgb3V0
KQ0KPiArICAgICAgICAgICAgb3V0X2ZpcnN0X2xpbmUsIG91dF9yZXN0ID0gb3V0LnNwbGl0KCdc
bicsIDEpDQo+ICsgICAgICAgICAgICBvdXQgPSBvdXRfZmlyc3RfbGluZS5yZXBsYWNlKCdzJywg
Jy4nKSArICdcbicgKyBvdXRfcmVzdA0KPiArDQo+ICsgICAgICAgICAgICBzeXMuc3RkZXJyLndy
aXRlKG91dCkNCj4gICANCj4gICBkZWYgZXhlY3V0ZV90ZXN0KHRlc3RfZnVuY3Rpb249Tm9uZSwN
Cj4gICAgICAgICAgICAgICAgICAgIHN1cHBvcnRlZF9mbXRzPVtdLCBzdXBwb3J0ZWRfb3Nlcz1b
J2xpbnV4J10sDQo+IA0KDQpSZXZpZXdlZC1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5z
aGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQotLSANCldpdGggdGhlIGJlc3QgcmVnYXJkcywNCkFu
ZHJleSBTaGlua2V2aWNoDQo=

