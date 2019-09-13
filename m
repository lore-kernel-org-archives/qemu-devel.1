Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B45C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF548206BB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Eu9YT5hG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF548206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8lsa-0003aq-MH
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 09:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8lrC-0002Lr-5L
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8lrA-00069y-E3
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:43:25 -0400
Received: from mail-eopbgr50105.outbound.protection.outlook.com
 ([40.107.5.105]:3079 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i8lr6-00067h-NT
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:43:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeQOuYhRfOvrq2f+bLCy/SQeLevJ740FzdLBKkBhikfCQjghMH25QFKrRXlyPvdjBYMDtCG0v0BgLVktY/4157EjR03m55baRLnZsBSldGoTwfmKkedHYk1a39X24y1/hPNGatuPHaVjDQr5awvi7wNBk/8sFI9tlMgDfK2W10pHepdeJFm9dpjNK+UwNhowOL4e7kQqpx/gtjOn780bDHCBTREtCYz/I8kZYsoueoIUzdH/XPUmKASVO/5gcx/MFtjNJeRv+IqG7WqxfCSGBGXyfrzYOWH3pTB1IamizjnPrCvDG8ikLpMbJU+sYxd0bUGHrlz312Al4VfXrRnl4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9kouXJhFRZk53sBbvWVww6MlkwD97gsgyqxXG9EhG0=;
 b=c8zXWswBZ7fcW+5tHas4JpXmiv/jPK+Xhgt2Etz/pxFYbPc0BtF7KWErbFFGK0wWc6hq3Jy2qjZxPswcvaeaqWDn8yLK4+Qx47/OCDTVm6bmS48RpAAqFkqfZqWIVPMRV6QVpj2NiNtHjHD26DF4PlxCnLheYkNFlRzGMrMI5WAtf8RMqxIateS20RKY3hUZ5d7AfvH7VshKoKcKRs6XIGNHE8UKjxUFE9yq7ZcUHhPOGzvixMFVb+z0ZuJBfl/VrU/KJEtV8w8wtGmLx4uNYCFBTWaU/6MnogGJexqyWwhiCVFg34MQ5znPp1466KoZatxZz3FYBe0+YyarEU62/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9kouXJhFRZk53sBbvWVww6MlkwD97gsgyqxXG9EhG0=;
 b=Eu9YT5hGt2I+LTjhKBdLL31NKJh9lSB4Y2IelQnNze1h7BVNhrUvqra4RMNNZCp/Sb9jTuOJVQGR2EziVVpF2RicAevOLgz9Hui4uCZuOQvl+FBlhU30lotrVdvRkzN7ZhD3N+bMsATG9QzjWLrHaPy00PZbyMxvoFRToGhqhv0=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5084.eurprd08.prod.outlook.com (10.255.4.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Fri, 13 Sep 2019 13:43:16 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.016; Fri, 13 Sep 2019
 13:43:16 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH] migration: Fix use-after-free during
 process exit
Thread-Index: AQHU7f8fBlUgEb0xiUaHV5wvX+InHKcqlmGA
Date: Fri, 13 Sep 2019 13:43:16 +0000
Message-ID: <8d153143-22ea-cb81-f33a-7356155c9fe4@virtuozzo.com>
References: <20190408113343.2370-1-yury-kotov@yandex-team.ru>
In-Reply-To: <20190408113343.2370-1-yury-kotov@yandex-team.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0313.eurprd05.prod.outlook.com
 (2603:10a6:7:93::44) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190913164313743
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36fb455f-9912-4726-1448-08d738505445
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5084; 
x-ms-traffictypediagnostic: DB8PR08MB5084:
x-microsoft-antispam-prvs: <DB8PR08MB50844925F500E36EBFAD5214C1B30@DB8PR08MB5084.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39840400004)(136003)(376002)(396003)(366004)(189003)(199004)(7736002)(99286004)(2906002)(3846002)(6116002)(52116002)(31696002)(76176011)(5660300002)(478600001)(86362001)(186003)(53936002)(446003)(31686004)(4326008)(14444005)(486006)(26005)(25786009)(6506007)(386003)(256004)(6246003)(11346002)(102836004)(2616005)(476003)(8676002)(66446008)(229853002)(66556008)(64756008)(71200400001)(66066001)(6512007)(66946007)(71190400001)(54906003)(305945005)(110136005)(316002)(36756003)(14454004)(81156014)(81166006)(8936002)(6486002)(6436002)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5084;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x0dgk5wDmHK2kSp79CF/Y+ztJ4govjtCaRuXQyOLOhpF9skUG+I0ZXTVkdT1lDw7g66y6qsyThiIdfKUanhqiUkYIjKYNIGgI8frJp5RM3UNLa/yYTKxQox51vXsq++06AS71usjxmQaYinJDbiu36s2Eim/tVZylrWd0y97kUdS2Oqd9zW8jyGSARUinmRVeMgTZ78lT/V83lhyBNA34c/rf/W+fFKX33VH8BO3tctH4vQwr7pAzNHWD1dQfYo4LEhE3o1MUBoYnXJdR/7fday/MZBliTewe7FhAsiIwopWSuHiFn01TKPoocTAJwP7xrGqQ7dEftsuLPNZ2HccuE/m1G8HJnI2h0QfuoYb+4gjbeASwBs4EnqZlQMEKThXY69Dmblt2BekZgzMRbR1fLguMCZP1G1bbhR4gUodN0g=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <15A9F3EC584D474CA9B7463A5DBE779A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fb455f-9912-4726-1448-08d738505445
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 13:43:16.0908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BfJZi7V5awtK3ThwGn6U/icHzUaQFCVlD0RQwFgIe/cqbxhSFasIxuXrD6Why351ysKlojzX81bLQMpXm9sL0SGNKWNVxDRZbKMNtm2x1WY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5084
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.105
Subject: Re: [Qemu-devel] [PATCH] migration: Fix use-after-free during
 process exit
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
Cc: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Evgeny Yakovlev <wrfsh@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkhDQoNCjA4LjA0LjIwMTkgMTQ6MzMsIFl1cnkgS290b3Ygd3JvdGU6DQo+IEl0IGZpeGVzIGhl
YXAtdXNlLWFmdGVyLWZyZWUgd2hpY2ggd2FzIGZvdW5kIGJ5IGNsYW5nJ3MgQVNBTi4NCj4gDQo+
IENvbnRyb2wgZmxvdyBvZiB0aGlzIHVzZS1hZnRlci1mcmVlOg0KPiBtYWluX3RocmVhZDoNCj4g
ICAgICAqIEdvdCBTSUdURVJNIGFuZCBjb21wbGV0ZXMgbWFpbiBsb29wDQo+ICAgICAgKiBDYWxs
cyBtaWdyYXRpb25fc2h1dGRvd24NCj4gICAgICAgIC0gbWlncmF0ZV9mZF9jYW5jZWwgKHNvLCBt
aWdyYXRpb25fdGhyZWFkIGJlZ2lucyB0byBjb21wbGV0ZSkNCj4gICAgICAgIC0gb2JqZWN0X3Vu
cmVmKE9CSkVDVChjdXJyZW50X21pZ3JhdGlvbikpOw0KPiANCj4gbWlncmF0aW9uX3RocmVhZDoN
Cj4gICAgICAqIG1pZ3JhdGlvbl9pdGVyYXRpb25fZmluaXNoIC0+IHNjaGVkdWxlIGNsZWFudXAg
YmgNCj4gICAgICAqIG9iamVjdF91bnJlZihPQkpFQ1QocykpOyAoTm93LCBjdXJyZW50X21pZ3Jh
dGlvbiBpcyBmcmVlZCkNCj4gICAgICAqIGV4aXRzDQo+IA0KPiBtYWluX3RocmVhZDoNCj4gICAg
ICAqIENhbGxzIHZtX3NodXRkb3duIC0+IGRyYWluIGJkcnZzIC0+IG1haW4gbG9vcA0KPiAgICAg
ICAgLT4gY2xlYW51cF9iaCAtPiB1c2UgYWZ0ZXIgZnJlZQ0KPiANCg0KDQpbLi5dDQoNCj4gICAN
Cj4gK3N0YXRpYyB2b2lkIG1pZ3JhdGVfZmRfY2xlYW51cF9zY2hlZHVsZShNaWdyYXRpb25TdGF0
ZSAqcykNCj4gK3sNCj4gKyAgICAvKiBSZWYgdGhlIHN0YXRlIGZvciBiaCwgYmVjYXVzZSBpdCBt
YXkgYmUgY2FsbGVkIHdoZW4NCj4gKyAgICAgKiB0aGVyZSdyZSBhbHJlYWR5IG5vIG90aGVyIHJl
ZnMgKi8NCj4gKyAgICBvYmplY3RfcmVmKE9CSkVDVChzKSk7DQo+ICsgICAgcWVtdV9iaF9zY2hl
ZHVsZShzLT5jbGVhbnVwX2JoKTsNCj4gK30NCg0Kc28geW91IHJlZiBvbiBzY2hlZHVsaW5nDQoN
Cj4gKw0KPiArc3RhdGljIHZvaWQgbWlncmF0ZV9mZF9jbGVhbnVwX2JoKHZvaWQgKm9wYXF1ZSkN
Cj4gK3sNCj4gKyAgICBNaWdyYXRpb25TdGF0ZSAqcyA9IG9wYXF1ZTsNCj4gKyAgICBtaWdyYXRl
X2ZkX2NsZWFudXAocyk7DQo+ICsgICAgb2JqZWN0X3VucmVmKE9CSkVDVChzKSk7DQo+ICt9DQoN
CmFuZCB1bnJlZiBhZnRlciBleGVjdXRpb24gb2YgYmguDQoNCmJ1dCBtaWdyYXRpb24gY29kZSBo
YXMgYWxzbyBjYWxsIHRvIHFlbXVfYmhfZGVsZXRlKHMtPmNsZWFudXBfYmgpIGZyb20NCm1pZ3Jh
dGVfZmRfY2xlYW51cCgpLCBpbiBtaWdyYXRlX2ZkX2NsZWFudXAoKSBpcyBjYWxsZWQgbm90IG9u
bHkgZnJvbQ0KbWlncmF0ZV9mZF9jbGVhbnVwX2JoLi4NCg0KSSBtZWFuLCB0aGF0IGlmIHdlIGNh
bGwgcWVtdV9iaF9kZWxldGUgYWZ0ZXIgc2NoZWR1bGluZywgd2Ugd2lsbCBub3QNCnVucmVmIG91
ciBuZXcgcmVmZXJlbmNlLg0KDQpTdGlsbCwgc2VlbXMgaXQncyBpbXBvc3NpYmxlLCBhcyBhbGwg
b3RoZXIgY2FsbHMgdG8gbWlncmF0ZV9mZF9jbGVhbnVwDQphcmUgZG9uZSBiZWZvcmUgbWlncmF0
aW9uIHRocmVhZCBjcmVhdGlvbi4NCg0KRG9uJ3Qga25vdywgc2hvdWxkIHNvbWV0aGluZyBkb25l
IGFyb3VuZCBpdCBvciBub3QsIGJ1dCBkZWNpZGVkIHRvIG1lbnRpb24gaXQuDQoNCg0KPiArDQo+
ICAgdm9pZCBtaWdyYXRlX3NldF9lcnJvcihNaWdyYXRpb25TdGF0ZSAqcywgY29uc3QgRXJyb3Ig
KmVycm9yKQ0KPiAgIHsNCj4gICAgICAgcWVtdV9tdXRleF9sb2NrKCZzLT5lcnJvcl9tdXRleCk7
DQo+IEBAIC0zMTQ0LDcgKzMxNTcsNyBAQCBzdGF0aWMgdm9pZCBtaWdyYXRpb25faXRlcmF0aW9u
X2ZpbmlzaChNaWdyYXRpb25TdGF0ZSAqcykNCj4gICAgICAgICAgIGVycm9yX3JlcG9ydCgiJXM6
IFVua25vd24gZW5kaW5nIHN0YXRlICVkIiwgX19mdW5jX18sIHMtPnN0YXRlKTsNCj4gICAgICAg
ICAgIGJyZWFrOw0KPiAgICAgICB9DQo+IC0gICAgcWVtdV9iaF9zY2hlZHVsZShzLT5jbGVhbnVw
X2JoKTsNCj4gKyAgICBtaWdyYXRlX2ZkX2NsZWFudXBfc2NoZWR1bGUocyk7DQo+ICAgICAgIHFl
bXVfbXV0ZXhfdW5sb2NrX2lvdGhyZWFkKCk7DQo+ICAgfQ0KPiAgIA0KPiBAQCAtMzI3OSw3ICsz
MjkyLDcgQEAgdm9pZCBtaWdyYXRlX2ZkX2Nvbm5lY3QoTWlncmF0aW9uU3RhdGUgKnMsIEVycm9y
ICplcnJvcl9pbikNCj4gICAgICAgYm9vbCByZXN1bWUgPSBzLT5zdGF0ZSA9PSBNSUdSQVRJT05f
U1RBVFVTX1BPU1RDT1BZX1BBVVNFRDsNCj4gICANCj4gICAgICAgcy0+ZXhwZWN0ZWRfZG93bnRp
bWUgPSBzLT5wYXJhbWV0ZXJzLmRvd250aW1lX2xpbWl0Ow0KPiAtICAgIHMtPmNsZWFudXBfYmgg
PSBxZW11X2JoX25ldyhtaWdyYXRlX2ZkX2NsZWFudXAsIHMpOw0KPiArICAgIHMtPmNsZWFudXBf
YmggPSBxZW11X2JoX25ldyhtaWdyYXRlX2ZkX2NsZWFudXBfYmgsIHMpOw0KPiAgICAgICBpZiAo
ZXJyb3JfaW4pIHsNCj4gICAgICAgICAgIG1pZ3JhdGVfZmRfZXJyb3IocywgZXJyb3JfaW4pOw0K
PiAgICAgICAgICAgbWlncmF0ZV9mZF9jbGVhbnVwKHMpOw0KPiANCg0KDQoNCg0KLS0gDQpCZXN0
IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

