Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A076C433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 11:18:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFDD720679
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 11:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="c2DF7pdc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFDD720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwPOQ-0000qS-E8
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 07:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46983)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwPNm-0000Li-U1
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 07:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwPNl-0006Dy-Mg
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 07:17:58 -0400
Received: from mail-eopbgr130132.outbound.protection.outlook.com
 ([40.107.13.132]:44814 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hwPNl-0006Cg-25; Sat, 10 Aug 2019 07:17:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpBYEaudNdV0dn8sehTxX+rMEizhE1iuFND2MBNwMB4dceh15hNuN6LBbr5oCSgUI1YKd1eNY3g9ZxcyKbZbXrK9rgHMH/C6BG49hegsvXHcqisUwq4xp+fFXJrPT2jNDx+75+iI6IISIiHBBqq4lp2AFUMi2lXvAtihxnKxJA1UCWhobyxWI7tLMaP7kt9Q6Dm2A5AxAdvKkYgUrXi63XLk+7BdI9xARYaXeOMsVBV7bpGeLWQS31as6R08PdvmS6lgGXVeKOAR5p5djuhDc23eC7f03mDVyOLeeLjC73oG6ZDTCOfpoqy3J+e7ZNIhisYEI3HT8pZhpzkxg+nHeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4M0T8gskrFVJLNyquy39Aj+KrW/UHJg9WtYxZihY9c=;
 b=eMRUasU6G593Qq0JHWngGGauXHZ3dpa+nne1UVrd+/jUFYdEnfneZOrFJDvxdH2Y70s4XtkwE+iZhuLNrR8AdXqknQiGGgd15S58i/BliUqOW0t/bvL3sulz+NBPjjPP5dqxDRqm2yw5pgmHRT4tj+otwaVUbBgC8Ru4KnxK1NG037xXe7VY9BnxPWHp0J3f30jdv54XWWIKSy5o5/kY27phu00kkbd/pLDvUXwbWgBHxsaeunVR/w89mR7E5RNrpC7XQyj6wiUAk7TI9z7T9jduzC10MPlDOyppWHsJPFqkJWBSl+9494Z/7Wv9Cd+wfRmZdePN4peWnpLThPfPiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4M0T8gskrFVJLNyquy39Aj+KrW/UHJg9WtYxZihY9c=;
 b=c2DF7pdcecAAiUBzPVqojMash6Fh8CBrWtnXoOgY1+5Gy8hvny2/t5Seg+8E9b9Vhz5SExIZDT/S2dGKwd02L1qcB9nBhcSrISz7YHqKCDfeFKaQVE4QL9imeTtzerIN3E//YoUaq8q+zA3l9SmFCKw6PHqWQXJ/NsnGfB+7gB0=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3948.eurprd08.prod.outlook.com (20.179.8.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Sat, 10 Aug 2019 11:17:51 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.021; Sat, 10 Aug 2019
 11:17:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, qemu block <qemu-block@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz
 <mreitz@redhat.com>
Thread-Topic: [Qemu-devel] backup bug or question
Thread-Index: AQHVTrTrc8JESPxQGUmDMebwH05otKbzQFKAgAD8vwA=
Date: Sat, 10 Aug 2019 11:17:51 +0000
Message-ID: <0c95727d-6572-710f-6a78-e54c4f655de3@virtuozzo.com>
References: <6826e3c2-bc6e-b2a2-1bf1-3ed31079f0ee@virtuozzo.com>
 <b032aeef-07f4-2922-6ee8-3047a8c622b8@redhat.com>
In-Reply-To: <b032aeef-07f4-2922-6ee8-3047a8c622b8@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0018.eurprd07.prod.outlook.com
 (2603:10a6:7:67::28) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190810141748134
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e1c43e0-aa52-4389-fad9-08d71d8461e3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB3948; 
x-ms-traffictypediagnostic: DB8PR08MB3948:
x-microsoft-antispam-prvs: <DB8PR08MB3948F03F5EA2555B1680278AC1D10@DB8PR08MB3948.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 012570D5A0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(39840400004)(136003)(396003)(366004)(199004)(189003)(486006)(6116002)(316002)(110136005)(81166006)(81156014)(64756008)(66446008)(66556008)(66476007)(76176011)(256004)(14444005)(26005)(52116002)(3846002)(8676002)(186003)(86362001)(31696002)(386003)(6506007)(102836004)(71200400001)(71190400001)(53546011)(2616005)(11346002)(66066001)(476003)(2906002)(8936002)(66946007)(446003)(305945005)(6486002)(6436002)(14454004)(6246003)(5660300002)(53936002)(478600001)(229853002)(36756003)(25786009)(7736002)(6512007)(31686004)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3948;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 74vXuHQfGiSq6Jv2BwHEDKjkcVXSx0Akbz5oTseQEUd91hzQZJUAjf0wW0sRHk4CiNXyBgNLZfjIybbF009dTvtH7BDa+77I4e3jkhQH9jkA/DSKwdioCeJ9+Y9G+Bp1mIIbUmy4PHxqJRjh5joCL+E2WqrNPrBZHANLf9f0qHXhQVWeKbx/BHz+Qf1FKqgSxk4ISTvu/EWYtg0aHerCUyLj7YFoO+bwYmPpWWhoe/ZusBFkTb2Un/smEkh6rYPsngCQCaVrYbW4dw/PogK8fToFTZov16hnH9KTbKfURr/JRhZRM/6pQUDFUZUT/T4u7GhibixPxCmiHAek7IwRsXeDcXH444TB3k+Y7KhHMewhxULEB1b5x22+Gsjss3XZ3AiaSnYShIpIBOYC/wON3fmJfd8UL3BhiUo+QHTPolo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A27225602FC8F24BA4C24E9F60A3E05A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1c43e0-aa52-4389-fad9-08d71d8461e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2019 11:17:51.3915 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sgnM0khBUVjtB34bvQrU3THICPXUwLkaH/vmU+E+3rN2d68hriizwQthbf91mt0CtrOVlWGVGXdDN/RiTRsfIssadRNDJJzoXEjif9ITDuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3948
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.132
Subject: Re: [Qemu-devel] backup bug or question
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDguMjAxOSAyMzoxMywgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDgvOS8xOSA5
OjE4IEFNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gSGkhDQo+Pg0K
Pj4gSG1tLCBoYWNraW5nIGFyb3VuZCBiYWNrdXAgSSBoYXZlIGEgcXVlc3Rpb246DQo+Pg0KPj4g
V2hhdCBwcmV2ZW50cyBndWVzdCB3cml0ZSByZXF1ZXN0IGFmdGVyIGpvYl9zdGFydCBidXQgYmVm
b3JlIHNldHRpbmcNCj4+IHdyaXRlIG5vdGlmaWVyPw0KPj4NCj4+IGNvZGUgcGF0aDoNCj4+DQo+
PiBxbXBfZHJpdmVfYmFja3VwIG9yIHRyYW5zYWN0aW9uIHdpdGggYmFja3VwDQo+Pg0KPj4gICAg
ICBqb2Jfc3RhcnQNCj4+ICAgICAgICAgYWlvX2NvX2VudGVyKGpvYl9jb19lbnRyeSkgLyogbWF5
IG9ubHkgc2NoZWR1bGUgZXhlY3V0aW9uLCBpc24ndCBpdCA/ICovDQo+Pg0KPj4gLi4uLg0KPj4N
Cj4+IGpvYl9jb19lbnRyeQ0KPj4gICAgICBqb2JfcGF1c2VfcG9pbnQoKSAvKiBpdCBkZWZpbml0
ZWx5IHlpZWxkcywgaXNuJ3QgaXQgYmFkPyAqLw0KPj4gICAgICBqb2ItPmRyaXZlci0+cnVuKCkg
LyogYmFja3VwX3J1biAqLw0KPj4NCj4+IC0tLS0NCj4+DQo+PiBiYWNrdXBfcnVuKCkNCj4+ICAg
ICAgYmRydl9hZGRfYmVmb3JlX3dyaXRlX25vdGlmaWVyKCkNCj4+DQo+PiAuLi4NCj4+DQo+IA0K
PiBJIHRoaW5rIHlvdSdyZSByaWdodC4uLiA6KA0KPiANCj4gDQo+IFdlIGNyZWF0ZSBqb2JzIGxp
a2UgdGhpczoNCj4gDQo+IGpvYi0+cGF1c2VkICAgICAgICA9IHRydWU7DQo+IGpvYi0+cGF1c2Vf
Y291bnQgICA9IDE7DQo+IA0KPiANCj4gQW5kIHRoZW4gam9iX3N0YXJ0IGRvZXMgdGhpczoNCj4g
DQo+IGpvYi0+Y28gPSBxZW11X2Nvcm91dGluZV9jcmVhdGUoam9iX2NvX2VudHJ5LCBqb2IpOw0K
PiBqb2ItPnBhdXNlX2NvdW50LS07DQo+IGpvYi0+YnVzeSA9IHRydWU7DQo+IGpvYi0+cGF1c2Vk
ID0gZmFsc2U7DQo+IA0KPiANCj4gV2hpY2ggbWVhbnMgdGhhdCBqb2JfY29fZW50cnkgaXMgYmVp
bmcgY2FsbGVkIGJlZm9yZSB3ZSBsaWZ0IHRoZSBwYXVzZToNCj4gDQo+IGFzc2VydChqb2IgJiYg
am9iLT5kcml2ZXIgJiYgam9iLT5kcml2ZXItPnJ1bik7DQo+IGpvYl9wYXVzZV9wb2ludChqb2Ip
Ow0KPiBqb2ItPnJldCA9IGpvYi0+ZHJpdmVyLT5ydW4oam9iLCAmam9iLT5lcnIpOw0KPiANCj4g
Li4uV2hpY2ggbWVhbnMgdGhhdCB3ZSBhcmUgZGVmaW5pdGVseSB5aWVsZGluZyBpbiBqb2JfcGF1
c2VfcG9pbnQuDQo+IA0KPiBZZWFoLCB0aGF0J3MgYSByYWNlIGNvbmRpdGlvbiB3YWl0aW5nIHRv
IGhhcHBlbi4NCj4gDQo+PiBBbmQgd2hhdCBndWFyYW50ZWVzIHdlIGdpdmUgdG8gdGhlIHVzZXI/
IElzIGl0IGd1YXJhbnRlZWQgdGhhdCB3cml0ZSBub3RpZmllciBpcw0KPj4gc2V0IHdoZW4gcW1w
IGNvbW1hbmQgcmV0dXJucz8NCj4+DQo+PiBBbmQgSSBndWVzcywgaWYgd2Ugc3RhcnQgc2V2ZXJh
bCBiYWNrdXBzIGluIGEgdHJhbnNhY3Rpb24gaXQgc2hvdWxkIGJlIGd1YXJhbnRlZWQNCj4+IHRo
YXQgdGhlIHNldCBvZiBiYWNrdXBzIGlzIGNvbnNpc3RlbnQgYW5kIGNvcnJlc3BvbmQgdG8gb25l
IHBvaW50IGluIHRpbWUuLi4NCj4+DQo+IA0KPiBJIHdvdWxkIGhhdmUgaG9wZWQgdGhhdCBtYXli
ZSB0aGUgZHJhaW5fYWxsIGNvdXBsZWQgd2l0aCB0aGUgaW5kaXZpZHVhbA0KPiBqb2JzIHRha2lu
ZyBkcmFpbl9zdGFydCBhbmQgZHJhaW5fZW5kIHdvdWxkIHNhdmUgdXMsIGJ1dCBJIGd1ZXNzIHdl
DQo+IHNpbXBseSBkb24ndCBoYXZlIGEgZ3VhcmFudGVlIHRoYXQgYWxsIGJhY2t1cCBqb2JzIFdJ
TEwgaGF2ZSBpbnN0YWxsZWQNCj4gdGhlaXIgaGFuZGxlciBieSB0aGUgdGltZSB0aGUgdHJhbnNh
Y3Rpb24gZW5kcy4NCj4gDQo+IE9yLCBpZiB0aGVyZSBpcyB0aGF0IGd1YXJhbnRlZSwgSSBkb24n
dCBrbm93IHdoYXQgcHJvdmlkZXMgaXQsIHNvIEkNCj4gdGhpbmsgd2Ugc2hvdWxkbid0IGNvdW50
IG9uIGl0IGFjY2lkZW50YWxseSB3b3JraW5nIGFueW1vcmUuDQo+IA0KPiANCj4gDQo+IEkgdGhp
bmsgd2Ugc2hvdWxkIGRvIHR3byB0aGluZ3M6DQo+IA0KPiAxLiBNb3ZlIHRoZSBoYW5kbGVyIGlu
c3RhbGxhdGlvbiB0byBjcmVhdGlvbiB0aW1lLg0KPiAyLiBNb2RpZnkgYmFja3VwX2JlZm9yZV93
cml0ZV9ub3RpZnkgdG8gcmV0dXJuIHdpdGhvdXQgaW52b2tpbmcNCj4gYmFja3VwX2RvX2NvdyBp
ZiB0aGUgam9iIGlzbid0IHN0YXJ0ZWQgeWV0Lg0KPiANCg0KSG1tLCBJIGRvbid0IHNlZSwgaG93
IGl0IGhlbHBzLi4gTm8tb3Agd3JpdGUtbm90aWZpZXIgd2lsbCBub3Qgc2F2ZSBhcyBmcm9tDQpn
dWVzdCB3cml0ZSwgaXMgaXQ/DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

