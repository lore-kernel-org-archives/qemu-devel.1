Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74652C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 09:00:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FCE421743
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 09:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="srVrc0mz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCE421743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5ncn-0008Bp-8o
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 05:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i5nc2-0007jj-5L
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i5nc1-0004i2-1d
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:59:30 -0400
Received: from mail-eopbgr60137.outbound.protection.outlook.com
 ([40.107.6.137]:35201 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i5nc0-0004hJ-Sb; Thu, 05 Sep 2019 04:59:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hK2IGXmVMMRcQZcXz54fus07v6EmI/w7izO61UoNv1JNwzDxF9vsZppmWvi9+R0ZTFL988CoL0CKENNlJKZ0n5KUlre/YkFy8Ozdc+tuLgTmicfdPmYQgZN9GZrUamcVrvkgJZvGU/+CokHqINNbpRJDkPKu7c1uotvJa1SG4WPer4lOzgcgKs3Zw5FxhFOmfs5GCGBcK8RgBtFmD8cC1UoWSKwv9ax7Viv0fBSgOawNUlW2QzuysMtzP8Td6nMzaXz2+R3sV3qnGnSzo4TKqTQgGmtYGZ4kKztEzY/2uSKh/mhs9XWJtzeYphsFv2F/qm6yGKqBSujlJ6W5lcxtwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh5LnD1D0WI8FxwEPaPvnOtKQI1BngfGltI44n7PL98=;
 b=QwLZjRXg7B1NMPTO1cMhI8yUYyywsq13p1zZyMJeQvYQK2yRoXW0AE6dQpQK3WCAhbkLF6drXVp6raXxhSdmIsCXsexjLz9hHxu/KUhQ91H733n5N1R+2Y/u6e2u33Zk9DuxlXC8XT0HNnmEzPbV/dQxn7qu/5cjAN6jGGiybOe5Gmg1mXV0Qv2aBnY9ePkepJtDZL8pY175E+HGDa2yLLRyvtkVlqoFegA7VCs6Sj6ZNQXoFIlmW23z71/paXIuankMgB8iieBs35nMwIghY061EUKh9mrBMHq5S91/g5LYR4csO33cU2kS17u+Z+krH2Zhl9VwkzFIe2twgTYnTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh5LnD1D0WI8FxwEPaPvnOtKQI1BngfGltI44n7PL98=;
 b=srVrc0mzMMmQXlvJOMQGhf6K+gLfOo/5fd0hVWrlATAK5urHNxazqJIUj37e8Gphuqw/txkA6pwgQBe9RNKTcArTrmrMnxdq0CdlojaX0W20Q4W/uEYTBKGGYte0Rjs8tmxg0KE4Gc3QLv2UJvIjhxP1m0iv4Vs58tFUhP82i1E=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5051.eurprd08.prod.outlook.com (20.179.15.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.13; Thu, 5 Sep 2019 08:59:23 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2220.022; Thu, 5 Sep 2019
 08:59:23 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v8 0/3] NBD reconnect
Thread-Index: AQHVWEDPFxKikbYstE2FStjWksvijacc3+WA
Date: Thu, 5 Sep 2019 08:59:23 +0000
Message-ID: <6f0c00cb-f288-aa8a-0c50-7316e7168f95@virtuozzo.com>
References: <20190821165215.61406-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190821165215.61406-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0199.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::23) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190905115919875
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 102cf2b7-d90c-457d-99ae-08d731df58c1
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5051; 
x-ms-traffictypediagnostic: DB8PR08MB5051:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB505153B66D7B1ECC26F57673C1BB0@DB8PR08MB5051.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(396003)(346002)(39850400004)(136003)(189003)(53754006)(199004)(86362001)(3846002)(6116002)(305945005)(6486002)(71190400001)(2351001)(71200400001)(7736002)(4326008)(31686004)(6436002)(5640700003)(54906003)(6916009)(6512007)(2501003)(53936002)(316002)(8676002)(81156014)(81166006)(8936002)(476003)(229853002)(6246003)(66066001)(25786009)(11346002)(26005)(446003)(2616005)(256004)(99286004)(107886003)(102836004)(36756003)(478600001)(66446008)(66946007)(386003)(6506007)(31696002)(5660300002)(66556008)(64756008)(14444005)(14454004)(5024004)(52116002)(76176011)(486006)(66476007)(186003)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5051;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:3; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VOzgOcs0oq29+kA5s2VC70hGO1BeVBAum3BqxAtkhSQPAzsClYvYO9xoqiq5K721nU49O+MQ3S+m0j1lQGNA5zzInypBQmWNB9G0Btj9/D0muUwzcdfZuP1U0GV9svd50lWsn01Slg7mccvNEK4PIB53CWXBpoJeZb6kEHjmCvfjG5qYTPcZEQYPbDyNwtuo/4TB/RqLR+LFwNhhLBMYXj8Da0ooUBrLMOB4pcSTbQ9T8lAE7SB/Nf4vJrmdsb6PiyM+Vn2yw9/IW5S0qSlZZ3scCVE+s0maTCAiWDfpFmsR+0H2Qtd67npKOrKMoCjgne3QwYYezRcB/IYMZQOrlmzSU7mTptHga/L6gdwm03l9ZBWL3fvgOp/70i0TxvNFhxVXk9Zq05ayGivLtlOYqdK3CX9l1sFG77JLVTMCOKw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A847A210B7EB84B855E452ADA7F8575@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 102cf2b7-d90c-457d-99ae-08d731df58c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 08:59:23.5687 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IRABVD+C2x4F/zlvVFB0Pi3SilzTQhiFAdxikftJFUYX1XfvdR79NlGGwH4Cn+hllUEny275iE1KkYxFTeAhK3tQm5jHB+SybFAkZwM/Doo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5051
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.137
Subject: Re: [Qemu-devel] [PATCH v8 0/3] NBD reconnect
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
 "sheepdog@lists.wpkg.org" <sheepdog@lists.wpkg.org>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "namei.unix@gmail.com" <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cGluZw0KDQoyMS4wOC4yMDE5IDE5OjUyLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiBIaSBhbGwhDQo+IEhlcmUgaXMgTkJEIHJlY29ubmVjdC4gUHJldmlvdXNseSwgaWYg
Y29ubmVjdGlvbiBmYWlsZWQgYWxsIGN1cnJlbnQNCj4gYW5kIGZ1dHVyZSByZXF1ZXN0cyB3aWxs
IGZhaWwuIEFmdGVyIHRoZSBzZXJpZXMsIG5iZC1jbGllbnQgZHJpdmVyDQo+IHdpbGwgdHJ5IHRv
IHJlY29ubmVjdCB1bmxpbWl0ZWQgdGltZXMuIER1cmluZyBmaXJzdCBAcmVjb25uZWN0LWRlbGF5
DQo+IHNlY29uZHMgb2YgcmVjb25uZWN0aW5nIGFsbCByZXF1ZXN0cyB3aWxsIHdhaXQgZm9yIHRo
ZSBjb25uZWN0aW9uLA0KPiBhbmQgaWYgaXQgaXMgZXN0YWJsaXNoZWQgcmVxdWVzdHMgd2lsbCBi
ZSByZXNlbnQuIEFmdGVyDQo+IEByZWNvbm5lY3QtZGVsYXkgcGVyaW9kIGFsbCByZXF1ZXN0cyB3
aWxsIGJlIGZhaWxlZCAodW50aWwgc3VjY2Vzc2Z1bA0KPiByZWNvbm5lY3QpLg0KPiANCj4gdjg6
DQo+IHByZXBhcmF0aW9ucyBhcmUgYWxyZWFkeSBtZXJnZWQgW3RoeCB0byBFcmljXSwgb2xkIDA3
IHdpdGggU0lfKiBjb25zdGFudHMNCj4gZHJvcHBlZCBbUGV0ZXJdDQo+IDAyOiAtIHVzZSBOQU5P
U0VDT05EU19QRVJfU0VDT05EDQo+IDAzOiAtIG1vdmUgdG8gdGVzdHMvcWVtdS1pb3Rlc3RzLzI2
NA0KPiAgICAgIC0gbGltaXQgam9iIHNwZWVkLCBvdGhlcndpc2UgaXQgZmFpbHMgb24gcmFtZnMg
YXMgYmFja3VwIGZpbmlzaGVzIHRvbyBlYXJseQ0KPiANCj4gdjc6DQo+IGFsbW9zdCBhbGw6IHJl
YmFzZWQgb24gbWVyZ2VkIG5iZC5jIGFuZCBuYmQtY2xpZW50LmMgKGluY2x1ZGluZyBwYXRjaCBz
dWJqZWN0KQ0KPiAwMS0wNDogYWRkIEVyaWMncyByLWINCj4gMDQ6IHdvcmRpbmcNCj4gMDU6IG5l
dw0KPiAwNjogcmV3cml0ZSB0byByZW1vdmUgdGltZXIgZWFybGllcg0KPiAwNzogbmV3DQo+IDA4
Og0KPiAgIC0gcmViYXNlIG9uIDA1IGFuZCAwNw0KPiAgIC0gZHJvcCAiQWxsIHJpZ2h0cyByZXNl
cnZlZCINCj4gICAtIGhhbmRsZSBkcmFpbg0KPiAgIC0gaW1wcm92ZSBoYW5kbGluZyBhaW8gY29u
dGV4dCBhdHRhY2gNCj4gMDk6IG1vdmUgMjQ5IC0+IDI1Nw0KPiANCj4gVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSAoMyk6DQo+ICAgIHFlbXUtY29yb3V0aW5lLXNsZWVwOiBpbnRyb2R1Y2Ug
cWVtdV9jb19zbGVlcF93YWtlDQo+ICAgIGJsb2NrL25iZDogbmJkIHJlY29ubmVjdA0KPiAgICBp
b3Rlc3RzOiB0ZXN0IG5iZCByZWNvbm5lY3QNCj4gDQo+ICAgaW5jbHVkZS9xZW11L2Nvcm91dGlu
ZS5oICAgICAgfCAgMTcgKy0NCj4gICBibG9jay9uYmQuYyAgICAgICAgICAgICAgICAgICB8IDMz
NSArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQo+ICAgYmxvY2svbnVsbC5jICAg
ICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gICBibG9jay9zaGVlcGRvZy5jICAgICAgICAgICAg
ICB8ICAgMiArLQ0KPiAgIHRlc3RzL3Rlc3QtYmRydi1kcmFpbi5jICAgICAgIHwgICA2ICstDQo+
ICAgdGVzdHMvdGVzdC1ibG9jay1pb3RocmVhZC5jICAgfCAgIDIgKy0NCj4gICB1dGlsL3FlbXUt
Y29yb3V0aW5lLXNsZWVwLmMgICB8ICA0NyArKystLQ0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8y
NjQgICAgICAgIHwgIDY1ICsrKysrKysNCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjY0Lm91dCAg
ICB8ICAxMiArKw0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy9ncm91cCAgICAgIHwgICAxICsNCj4g
ICB0ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weSB8ICAgNCArDQo+ICAgMTEgZmlsZXMgY2hh
bmdlZCwgNDA4IGluc2VydGlvbnMoKyksIDg1IGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2Rl
IDEwMDc1NSB0ZXN0cy9xZW11LWlvdGVzdHMvMjY0DQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRl
c3RzL3FlbXUtaW90ZXN0cy8yNjQub3V0DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxh
ZGltaXINCg==

