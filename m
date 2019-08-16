Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26305C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 10:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19F120644
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 10:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="W3XYwavN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19F120644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyZRS-0001Ed-23
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 06:26:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hyZOn-0008BX-Ag
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 06:23:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hyZOl-0006eP-CB
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 06:23:57 -0400
Received: from mail-am5eur03on071a.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::71a]:2670
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hyZOb-0006NL-P0; Fri, 16 Aug 2019 06:23:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fu+WJ3fxOvpX6GxzI4EErHkvdjKErZ9S5cAkJy/yL/U8amuq3lOqnoNdMtWdoq2HzO6Qiw6F+Kycur7L3FE/nb82muXvtLSchInDJhd0ovvtfatJLeiXLzXEoLbkypFI+rgXbeEMnIqIov5CxLElCQY/LiGywDm5Re/NozPaN8wpoclL3wCWNPeDtXM+cij5FSVQA8TCSfRRUP9FIV7y5La5lqwO6ojPIyiwIpsg+Db7XOVzR6VkHLf1toTFMjBBm+CKl8kQ01SGh5DYfBAOEol9k1fdMq8G0zK+2YyP8eciRTjoT/kc+weVf95W1/vYcxu6lh8A24pAMnwnNn6BAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FE/dgAkZucxyxED4Si5nunV+AiK+0i/yLGsflM0ptI=;
 b=jdcIHgDNtijaethr4z5JB6/y0B9rFpP9QP5Snymo9glxsGw9rOz4RAY182k1lSbwIyy1vQf2W0y1AqWvzLEXtp/lIfa69EbF6x9kQGewI9wTodxswyyfTnu2ij5Fb8F4EPWGgs0/D4+8U9IY2j4gpu1WPcWSCMmRpZ5hMaVQxD+DCPL0viAkr7DyO4V50/pxbUEJMgyhknm3TPOdDLyVu3blzswQL0AHEY5EgKrr1qLFxzT8QPeU8m3/t9lqHYfjNQtnoLNe6ETvx6ZLeuDi5CqoGTizLqv8s7lRibbOcCppPE0YFdRv4S8p6Ci/B+kty1RWckG2swqF62CHPTtm/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FE/dgAkZucxyxED4Si5nunV+AiK+0i/yLGsflM0ptI=;
 b=W3XYwavNw324mC/cHrX8i9YEw6XhCu1MZmBFnqqhfpyAKmOct3/OAysZEHdZYDmR/q/s2nRnG2zwzWkRvGounZyH5+p9/p1B0z3d/vjrHBNDF9WkcQGqYD1tf4Xtkg2KucAtfrU5Ye6zTMvN8GqakdIoORAbkMxYq+TBBbUk6jg=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4172.eurprd08.prod.outlook.com (20.179.11.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.23; Fri, 16 Aug 2019 10:23:41 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Fri, 16 Aug 2019
 10:23:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH] nbd: Advertise multi-conn for shared read-only
 connections
Thread-Index: AQHVU5pRbfX2Dmnn90+3JIt/UilW+Kb9kiKA
Date: Fri, 16 Aug 2019 10:23:41 +0000
Message-ID: <104559cd-a1dc-2b2c-8992-689cbdd0f827@virtuozzo.com>
References: <20190815185024.7010-1-eblake@redhat.com>
In-Reply-To: <20190815185024.7010-1-eblake@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0017.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::27) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190816132339534
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31a870ce-0d89-445d-8ad6-08d72233cf59
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4172; 
x-ms-traffictypediagnostic: DB8PR08MB4172:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB417223884A7BF20066E62012C1AF0@DB8PR08MB4172.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39850400004)(199004)(189003)(6512007)(5660300002)(14454004)(3846002)(36756003)(6486002)(64756008)(66446008)(66946007)(966005)(53936002)(2906002)(6116002)(66556008)(66476007)(6306002)(81156014)(478600001)(31686004)(8676002)(229853002)(6436002)(2616005)(52116002)(6506007)(4326008)(102836004)(76176011)(256004)(71190400001)(476003)(71200400001)(7736002)(81166006)(11346002)(386003)(446003)(316002)(6246003)(31696002)(25786009)(54906003)(486006)(26005)(86362001)(110136005)(66066001)(8936002)(305945005)(186003)(2501003)(99286004)(14444005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4172;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: biNyRHf5QyQe57rSrVf/lkCkgp9LQExDJDVCNPA8d3DxPfjV4U9BvNsMEKvddT1/d98GhOH8EyoznIMOSFVNowtio3urml7RvcbfCNvDtiPtumB74XOsHBgRYT/oPjlaIi1x4XIswQOj8rc5BYdYPVGhOP0OgbhORmk0+nWPza8i6f92hL8BipDc+d/YwGbab8lCo8WFYD4gotnYVNdiR1tdcKmI36ZKJmdhgElkzLikNnxDPSCTU1TbhC2INMGdoERvVoPewGGbgYqYgYajKH5Hyo2AbLrO/rKD7kP9J/6emp0V1+RKZyD0+g/dm1Co+BiIycn8GH3JLjXKttIXnaLZMOYGuXSiF7OyTUWIHweRT/HAKVYWWynJawRjipRsrd73dLhS1/oTeUBQqzU/Q1x6qo+132wJb3Vx3GjG5Vc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <42BA2BAC0EF5E447BD90E9302A21281B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a870ce-0d89-445d-8ad6-08d72233cf59
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 10:23:41.6004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ykIG239nr5FrNKuIoCWI9/PQ7oBH7cBw7JtE2584WTIGlreExvHkd4ZH64pPOM1x/pkroUyt/AA00SIOveCHeOIj+kJjYUdehOvMIXWGNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4172
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe08::71a
Subject: Re: [Qemu-devel] [PATCH] nbd: Advertise multi-conn for shared
 read-only connections
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
Cc: Kevin Wolf <kwolf@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTUuMDguMjAxOSAyMTo1MCwgRXJpYyBCbGFrZSB3cm90ZToNCj4gVGhlIE5CRCBzcGVjaWZpY2F0
aW9uIGRlZmluZXMgTkJEX0ZMQUdfQ0FOX01VTFRJX0NPTk4sIHdoaWNoIGNhbiBiZQ0KPiBhZHZl
cnRpc2VkIHdoZW4gdGhlIHNlcnZlciBwcm9taXNlcyBjYWNoZSBjb25zaXN0ZW5jeSBiZXR3ZWVu
DQo+IHNpbXVsdGFuZW91cyBjbGllbnRzIChiYXNpY2FsbHksIHJ1bGVzIHRoYXQgZGV0ZXJtaW5l
IHdoYXQgRlVBIGFuZA0KPiBmbHVzaCBmcm9tIG9uZSBjbGllbnQgYXJlIGFibGUgdG8gZ3VhcmFu
dGVlIGZvciByZWFkcyBmcm9tIGFub3RoZXINCj4gY2xpZW50KS4gIFdoZW4gd2UgZG9uJ3QgcGVy
bWl0IHNpbXVsdGFuZW91cyBjbGllbnRzIChzdWNoIGFzIHFlbXUtbmJkDQo+IHdpdGhvdXQgLWUp
LCB0aGUgYml0IG1ha2VzIG5vIHNlbnNlOyBhbmQgZm9yIHdyaXRhYmxlIGltYWdlcywgd2UNCj4g
cHJvYmFibHkgaGF2ZSBhIGxvdCBtb3JlIHdvcmsgYmVmb3JlIHdlIGNhbiBkZWNsYXJlIHRoYXQg
YWN0aW9ucyBmcm9tDQo+IG9uZSBjbGllbnQgYXJlIGNhY2hlLWNvbnNpc3RlbnQgd2l0aCBhY3Rp
b25zIGZyb20gYW5vdGhlci4gIEJ1dCBmb3INCj4gcmVhZC1vbmx5IGltYWdlcywgd2hlcmUgZmx1
c2ggaXNuJ3QgY2hhbmdpbmcgYW55IGRhdGEsIHdlIG1pZ2h0IGFzDQo+IHdlbGwgYWR2ZXJ0aXNl
IG11bHRpLWNvbm4gc3VwcG9ydC4gIFdoYXQncyBtb3JlLCBhZHZlcnRpc2VtZW50IG9mIHRoZQ0K
PiBiaXQgbWFrZXMgaXQgZWFzaWVyIGZvciBjbGllbnRzIHRvIGRldGVybWluZSBpZiAncWVtdS1u
YmQgLWUnIHdhcyBpbg0KPiB1c2UsIHdoZXJlIGEgc2Vjb25kIGNvbm5lY3Rpb24gd2lsbCBzdWNj
ZWVkIHJhdGhlciB0aGFuIGhhbmcgdW50aWwgdGhlDQo+IGZpcnN0IGNsaWVudCBnb2VzIGF3YXku
DQo+IA0KPiBUaGlzIHBhdGNoIGFmZmVjdHMgcWVtdSBhcyBzZXJ2ZXIgaW4gYWR2ZXJ0aXNpbmcg
dGhlIGJpdC4gIFdlIG1heSB3YW50DQo+IHRvIGNvbnNpZGVyIHBhdGNoZXMgdG8gcWVtdSBhcyBj
bGllbnQgdG8gYXR0ZW1wdCBwYXJhbGxlbCBjb25uZWN0aW9ucw0KPiBmb3IgaGlnaGVyIHRocm91
Z2hwdXQgYnkgc3ByZWFkaW5nIHRoZSBsb2FkIG92ZXIgdGhvc2UgY29ubmVjdGlvbnMNCj4gd2hl
biBhIHNlcnZlciBhZHZlcnRpc2VzIG11bHRpLWNvbm4sIGJ1dCBmb3Igbm93IHN0aWNraW5nIHRv
IG9uZQ0KPiBjb25uZWN0aW9uIHBlciBuYmQ6Ly8gQkRTIGlzIG9rYXkuDQo+IA0KPiBTZWUgYWxz
bzogaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tLzE3MDgzMDANCj4gU2lnbmVkLW9mZi1ieTog
RXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIGRvY3MvaW50ZXJvcC9u
YmQudHh0IHwgMSArDQo+ICAgaW5jbHVkZS9ibG9jay9uYmQuaCAgfCAyICstDQo+ICAgYmxvY2tk
ZXYtbmJkLmMgICAgICAgfCAyICstDQo+ICAgbmJkL3NlcnZlci5jICAgICAgICAgfCA0ICsrKy0N
Cj4gICBxZW11LW5iZC5jICAgICAgICAgICB8IDIgKy0NCj4gICA1IGZpbGVzIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kb2NzL2lu
dGVyb3AvbmJkLnR4dCBiL2RvY3MvaW50ZXJvcC9uYmQudHh0DQo+IGluZGV4IGZjNjQ0NzNlMDJi
Mi4uNmRmZWM3ZjQ3NjQ3IDEwMDY0NA0KPiAtLS0gYS9kb2NzL2ludGVyb3AvbmJkLnR4dA0KPiAr
KysgYi9kb2NzL2ludGVyb3AvbmJkLnR4dA0KPiBAQCAtNTMsMyArNTMsNCBAQCB0aGUgb3BlcmF0
aW9uIG9mIHRoYXQgZmVhdHVyZS4NCj4gICAqIDIuMTI6IE5CRF9DTURfQkxPQ0tfU1RBVFVTIGZv
ciAiYmFzZTphbGxvY2F0aW9uIg0KPiAgICogMy4wOiBOQkRfT1BUX1NUQVJUVExTIHdpdGggVExT
IFByZS1TaGFyZWQgS2V5cyAoUFNLKSwNCj4gICBOQkRfQ01EX0JMT0NLX1NUQVRVUyBmb3IgInFl
bXU6ZGlydHktYml0bWFwOiIsIE5CRF9DTURfQ0FDSEUNCj4gKyogNC4yOiBOQkRfRkxBR19DQU5f
TVVMVElfQ09OTiBmb3Igc2hhcmFibGUgcmVhZC1vbmx5IGV4cG9ydHMNCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvYmxvY2svbmJkLmggYi9pbmNsdWRlL2Jsb2NrL25iZC5oDQo+IGluZGV4IDdiMzZk
NjcyZjA0Ni4uOTkxZmQ1MmE1MTM0IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2Jsb2NrL25iZC5o
DQo+ICsrKyBiL2luY2x1ZGUvYmxvY2svbmJkLmgNCj4gQEAgLTMyNiw3ICszMjYsNyBAQCB0eXBl
ZGVmIHN0cnVjdCBOQkRDbGllbnQgTkJEQ2xpZW50Ow0KPiANCj4gICBOQkRFeHBvcnQgKm5iZF9l
eHBvcnRfbmV3KEJsb2NrRHJpdmVyU3RhdGUgKmJzLCB1aW50NjRfdCBkZXZfb2Zmc2V0LA0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3Qgc2l6ZSwgY29uc3QgY2hhciAqbmFt
ZSwgY29uc3QgY2hhciAqZGVzYywNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qg
Y2hhciAqYml0bWFwLCB1aW50MTZfdCBuYmRmbGFncywNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgY29uc3QgY2hhciAqYml0bWFwLCB1aW50MTZfdCBuYmRmbGFncywgYm9vbCBzaGFyZWQs
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICgqY2xvc2UpKE5CREV4cG9ydCAq
KSwgYm9vbCB3cml0ZXRocm91Z2gsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCbG9j
a0JhY2tlbmQgKm9uX2VqZWN0X2JsaywgRXJyb3IgKiplcnJwKTsNCj4gICB2b2lkIG5iZF9leHBv
cnRfY2xvc2UoTkJERXhwb3J0ICpleHApOw0KPiBkaWZmIC0tZ2l0IGEvYmxvY2tkZXYtbmJkLmMg
Yi9ibG9ja2Rldi1uYmQuYw0KPiBpbmRleCA2NmVlYmFiMzE4NzUuLmU1ZDIyODc3MTI5MiAxMDA2
NDQNCj4gLS0tIGEvYmxvY2tkZXYtbmJkLmMNCj4gKysrIGIvYmxvY2tkZXYtbmJkLmMNCj4gQEAg
LTE4OSw3ICsxODksNyBAQCB2b2lkIHFtcF9uYmRfc2VydmVyX2FkZChjb25zdCBjaGFyICpkZXZp
Y2UsIGJvb2wgaGFzX25hbWUsIGNvbnN0IGNoYXIgKm5hbWUsDQo+ICAgICAgIH0NCj4gDQo+ICAg
ICAgIGV4cCA9IG5iZF9leHBvcnRfbmV3KGJzLCAwLCBsZW4sIG5hbWUsIE5VTEwsIGJpdG1hcCwN
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgICB3cml0YWJsZSA/IDAgOiBOQkRfRkxBR19SRUFE
X09OTFksDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgd3JpdGFibGUgPyAwIDogTkJEX0ZM
QUdfUkVBRF9PTkxZLCB0cnVlLA0KDQpzL3RydWUvIXdyaXRhYmxlID8NCg0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBOVUxMLCBmYWxzZSwgb25fZWplY3RfYmxrLCBlcnJwKTsNCj4gICAg
ICAgaWYgKCFleHApIHsNCj4gICAgICAgICAgIHJldHVybjsNCj4gZGlmZiAtLWdpdCBhL25iZC9z
ZXJ2ZXIuYyBiL25iZC9zZXJ2ZXIuYw0KPiBpbmRleCBhMmNmMDg1Zjc2MzUuLmE2MDJkODUwNzBm
ZiAxMDA2NDQNCj4gLS0tIGEvbmJkL3NlcnZlci5jDQo+ICsrKyBiL25iZC9zZXJ2ZXIuYw0KPiBA
QCAtMTQ2MCw3ICsxNDYwLDcgQEAgc3RhdGljIHZvaWQgbmJkX2VqZWN0X25vdGlmaWVyKE5vdGlm
aWVyICpuLCB2b2lkICpkYXRhKQ0KPiANCj4gICBOQkRFeHBvcnQgKm5iZF9leHBvcnRfbmV3KEJs
b2NrRHJpdmVyU3RhdGUgKmJzLCB1aW50NjRfdCBkZXZfb2Zmc2V0LA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDY0X3Qgc2l6ZSwgY29uc3QgY2hhciAqbmFtZSwgY29uc3QgY2hh
ciAqZGVzYywNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqYml0bWFw
LCB1aW50MTZfdCBuYmRmbGFncywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qg
Y2hhciAqYml0bWFwLCB1aW50MTZfdCBuYmRmbGFncywgYm9vbCBzaGFyZWQsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB2b2lkICgqY2xvc2UpKE5CREV4cG9ydCAqKSwgYm9vbCB3cml0
ZXRocm91Z2gsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCbG9ja0JhY2tlbmQgKm9u
X2VqZWN0X2JsaywgRXJyb3IgKiplcnJwKQ0KPiAgIHsNCj4gQEAgLTE0ODYsNiArMTQ4Niw4IEBA
IE5CREV4cG9ydCAqbmJkX2V4cG9ydF9uZXcoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIHVpbnQ2NF90
IGRldl9vZmZzZXQsDQo+ICAgICAgIHBlcm0gPSBCTEtfUEVSTV9DT05TSVNURU5UX1JFQUQ7DQo+
ICAgICAgIGlmICgobmJkZmxhZ3MgJiBOQkRfRkxBR19SRUFEX09OTFkpID09IDApIHsNCj4gICAg
ICAgICAgIHBlcm0gfD0gQkxLX1BFUk1fV1JJVEU7DQo+ICsgICAgfSBlbHNlIGlmIChzaGFyZWQp
IHsNCj4gKyAgICAgICAgbmJkZmxhZ3MgfD0gTkJEX0ZMQUdfQ0FOX01VTFRJX0NPTk47DQo+ICAg
ICAgIH0NCj4gICAgICAgYmxrID0gYmxrX25ldyhiZHJ2X2dldF9haW9fY29udGV4dChicyksIHBl
cm0sDQo+ICAgICAgICAgICAgICAgICAgICAgQkxLX1BFUk1fQ09OU0lTVEVOVF9SRUFEIHwgQkxL
X1BFUk1fV1JJVEVfVU5DSEFOR0VEIHwNCj4gZGlmZiAtLWdpdCBhL3FlbXUtbmJkLmMgYi9xZW11
LW5iZC5jDQo+IGluZGV4IDA0OTY0NTQ5MWRhYi4uNTVmNWNlYWY1YzkyIDEwMDY0NA0KPiAtLS0g
YS9xZW11LW5iZC5jDQo+ICsrKyBiL3FlbXUtbmJkLmMNCj4gQEAgLTExNzMsNyArMTE3Myw3IEBA
IGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikNCj4gICAgICAgfQ0KPiANCj4gICAgICAg
ZXhwb3J0ID0gbmJkX2V4cG9ydF9uZXcoYnMsIGRldl9vZmZzZXQsIGZkX3NpemUsIGV4cG9ydF9u
YW1lLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgIGV4cG9ydF9kZXNjcmlwdGlvbiwg
Yml0bWFwLCBuYmRmbGFncywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBleHBvcnRf
ZGVzY3JpcHRpb24sIGJpdG1hcCwgbmJkZmxhZ3MsIHNoYXJlZCA+IDEsDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG5iZF9leHBvcnRfY2xvc2VkLCB3cml0ZXRocm91Z2gsIE5VTEws
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZlcnJvcl9mYXRhbCk7DQo+IA0KDQoN
Ci0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

