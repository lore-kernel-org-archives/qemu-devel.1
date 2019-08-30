Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AF3C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 18:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7235021721
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 18:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PU4Setc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7235021721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3lJ5-0001ob-Bd
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 14:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3lCf-0007hy-Uy
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3lCe-0005YU-FP
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:00:53 -0400
Received: from mail-eopbgr150117.outbound.protection.outlook.com
 ([40.107.15.117]:45445 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i3lCT-0005Fi-GZ; Fri, 30 Aug 2019 14:00:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUxBMt9C8xPLoaLMXT4148jlCUSGzJtDIsvPLeyT0mc+aDnD0lWlTCgAKbPfghh3HRDoUQg/MgpKJDTNVaO9M6QOCs/qp2585gTL41j328RobL6TrVJ2El64tjBj7grrsZvpZl7wP0YtUwVjUi7XndcbALpKNYsTzoW1R/DsncvwjrtEaJ1aMm+VpB9ro17y97FIYT7m1V3e+iByh/6PikyqM7rigJ9QKtQAr0Zp5HI8CkiK+te1wqnNU6xyOnPy/jrvPylALHXx53x4p+geBZcfa8oU0bJMNu02wzSIfon/f355qPgFteYOaDAv+urcp9rY40PlvoidNKP1a6QwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcRn23jzlPgZSIf5mxpOpmM+iG56cZoLYjpKotQnudY=;
 b=KZiBC8EgKfFFMcDafOfDvJ1ZfhnoANdW99OZakLdEKrZLSq+09d/L8oDXr+aGrfWzkyFns47LnWfCtEo1yfoYUxiHC9zirvBQWK4NyqtFpSPmzhUlKdl8TF6C1RodawM8VWk0Iy2M0UaKVcaBfCsbX6TtzKZd5vG+zo62XYN8q3WBl1+FSWUm52Fe/AyWEKenJmLnkItfh+ie+KeqHfQxel6JwDQeYKdKVK5corrRcmNa41h6d+4r/bbh50/d+Ihq8F3mrQ1k1wCmDp4y8eL13RXJdHHBc/wr5+nEUBcimj6i6JJzapOVWJkLNC5kPljGYNnbf4jwCAOBESe6riJUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcRn23jzlPgZSIf5mxpOpmM+iG56cZoLYjpKotQnudY=;
 b=PU4Setc0VLob48wozqH+8RMrFy5dMFYaQDbYJ3VE5OhzpicSkGAC2xYflGWR6EIP0aCkXKP31tLS0W8cdRrIbuP+4wX03Q2404kcgE0Fh2wMTFkbqYIi5i777k9PPjuBJsdxKaDvaCdTi0wdIwGHIPiKyYSvRHvw6YOyV7UmZFU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4937.eurprd08.prod.outlook.com (10.255.19.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Fri, 30 Aug 2019 18:00:38 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2199.021; Fri, 30 Aug 2019
 18:00:38 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 1/5] nbd: Improve per-export flag handling
 in server
Thread-Index: AQHVWcKKpZ1kXbNK00iz+Po90P7KVacUBh+A
Date: Fri, 30 Aug 2019 18:00:37 +0000
Message-ID: <92e9cfa2-fbaa-259d-7a04-91187cc809b6@virtuozzo.com>
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823143726.27062-1-eblake@redhat.com>
 <20190823143726.27062-2-eblake@redhat.com>
In-Reply-To: <20190823143726.27062-2-eblake@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0350.eurprd05.prod.outlook.com
 (2603:10a6:7:92::45) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190830210035302
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5954877-38d5-43d2-c67d-08d72d73f67d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4937; 
x-ms-traffictypediagnostic: DB8PR08MB4937:
x-microsoft-antispam-prvs: <DB8PR08MB49377600FE1F4058BFBFD7EBC1BD0@DB8PR08MB4937.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(396003)(366004)(376002)(346002)(189003)(199004)(256004)(6116002)(386003)(316002)(66946007)(81166006)(2501003)(66556008)(66446008)(64756008)(66476007)(14454004)(8936002)(36756003)(81156014)(66066001)(86362001)(31686004)(71190400001)(6512007)(110136005)(71200400001)(52116002)(5660300002)(6436002)(476003)(486006)(31696002)(6246003)(14444005)(76176011)(229853002)(53936002)(102836004)(99286004)(478600001)(6486002)(2906002)(446003)(11346002)(26005)(2616005)(186003)(4326008)(3846002)(305945005)(7736002)(8676002)(6506007)(54906003)(25786009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4937;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UjMdQk9nUAaos6B9OxjGsPlr9KXpW4+2aDj66bh1uKAj0o9WQZX7XOKAoaetftqAriOzRrJXAmmhi5Lpj87JA+w7L+RYqFJYXQb7MLGJ/enqoP+jFRFQeFczl+SopK9YyqFftsSCglDf2Y0jXsomh8kisqNwd7huy7KgLKJ/y0K4xz2gbmuUd8EzCDNYvD2xhi+UyUTmTz8pleOVYY4toIqTJUV/iGw7GAOX1yUEL4NjpHinyZH8dz8nVzIuorj19JVqkgbQH5VYuoYVSM3EEPHJ6Dch4kysIl23O8RBfdX79Z/3SnZZg1EyLUM/nr/R+DAGjono7VoPEuCdBKqLtiQ16zB2mHvzE79ESWFIm4MuqCQfnt2jIxc21lgx/F/gOEPjD2oisCJPGgJdT3N7V3hZBMYrAEhFHmdIUagNO4E=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <89329BF94AA0884197E9BD15A4CD520D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5954877-38d5-43d2-c67d-08d72d73f67d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 18:00:37.8733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9nQewBh61yzKE2JnFI3s5IlV5a+iT6umoMBaZw8BTuz3dYz4xRhjCPnWT02jC+QUMjRUhFwe3csA2niTS2zpdkUU6sxYQWonoO+qjLur6eQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4937
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.117
Subject: Re: [Qemu-devel] [PATCH 1/5] nbd: Improve per-export flag handling
 in server
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
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "libguestfs@redhat.com" <libguestfs@redhat.com>, "open
 list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjMuMDguMjAxOSAxNzozNywgRXJpYyBCbGFrZSB3cm90ZToNCj4gV2hlbiBjcmVhdGluZyBhIHJl
YWQtb25seSBpbWFnZSwgd2UgYXJlIHN0aWxsIGFkdmVydGlzaW5nIHN1cHBvcnQgZm9yDQo+IFRS
SU0gYW5kIFdSSVRFX1pFUk9FUyB0byB0aGUgY2xpZW50LCBldmVuIHRob3VnaCB0aGUgY2xpZW50
IHNob3VsZCBub3QNCj4gYmUgaXNzdWluZyB0aG9zZSBjb21tYW5kcy4gIEJ1dCBzZWVpbmcgdGhp
cyByZXF1aXJlcyBsb29raW5nIGFjcm9zcw0KPiBtdWx0aXBsZSBmdW5jdGlvbnM6DQo+IA0KPiBB
bGwgY2FsbGVycyB0byBuYmRfZXhwb3J0X25ldygpIHBhc3NlZCBhIHNpbmdsZSBmbGFnIGJhc2Vk
IHNvbGVseSBvbg0KPiB3aGV0aGVyIHRoZSBleHBvcnQgYWxsb3dzIHdyaXRlcy4gIExhdGVyLCB3
ZSB0aGVuIHBhc3MgYSBjb25zdGFudCBzZXQNCj4gb2YgZmxhZ3MgdG8gbmJkX25lZ290aWF0ZV9v
cHRpb25zKCkgKG5hbWVseSwgdGhlIHNldCBvZiBmbGFncyB3aGljaCB3ZQ0KPiBhbHdheXMgc3Vw
cG9ydCwgYXQgbGVhc3QgZm9yIHdyaXRhYmxlIGltYWdlcyksIHdoaWNoIGlzIHRoZW4gZnVydGhl
cg0KPiBkeW5hbWljYWxseSBtb2RpZmllZCBiYXNlZCBvbiBjbGllbnQgcmVxdWVzdHMgZm9yIHN0
cnVjdHVyZWQgb3B0aW9ucy4NCj4gRmluYWxseSwgd2hlbiBwcm9jZXNzaW5nIE5CRF9PUFRfRVhQ
T1JUX05BTUUgb3IgTkJEX09QVF9FWFBPUlRfR08gd2UNCj4gYml0d2lzZS1vciB0aGUgb3JpZ2lu
YWwgY2FsbGVyJ3MgZmxhZyB3aXRoIHRoZSBydW50aW1lIHNldCBvZiBmbGFncw0KPiB3ZSd2ZSBi
dWlsdCB1cCBvdmVyIHNldmVyYWwgZnVuY3Rpb25zLg0KPiANCj4gTGV0J3MgcmVmYWN0b3IgdGhp
bmdzIHRvIGluc3RlYWQgY29tcHV0ZSBhIGJhc2VsaW5lIG9mIGZsYWdzIGFzIHNvb24NCj4gYXMg
cG9zc2libGUsIGluIG5iZF9leHBvcnRfbmV3KCksIGFuZCBjaGFuZ2luZyB0aGUgc2lnbmF0dXJl
IGZvciB0aGUNCj4gY2FsbGVycyB0byBwYXNzIGluIGEgc2ltcGxlciBib29sIHJhdGhlciB0aGFu
IGhhdmluZyB0byBmaWd1cmUgb3V0DQo+IGZsYWdzLiAgV2UgY2FuIHRoZW4gZ2V0IHJpZCBvZiB0
aGUgJ215ZmxhZ3MnIHBhcmFtZXRlciB0byB2YXJpb3VzDQo+IGZ1bmN0aW9ucywgYW5kIGluc3Rl
YWQgcmVmZXIgdG8gY2xpZW50IGZvciBldmVyeXRoaW5nIHdlIG5lZWQgKHdlDQo+IHN0aWxsIGhh
dmUgdG8gcGVyZm9ybSBhIGJpdHdpc2UtT1IgZHVyaW5nIE5CRF9PUFRfRVhQT1JUX05BTUUgYW5k
DQo+IE5CRF9PUFRfRVhQT1JUX0dPLCBidXQgaXQncyBlYXNpZXIgdG8gc2VlIHdoYXQgaXMgYmVp
bmcgY29tcHV0ZWQpLg0KPiBUaGlzIGxldHMgdXMgcXVpdCBhZHZlcnRpc2luZyBzZW5zZWxlc3Mg
ZmxhZ3MgZm9yIHJlYWQtb25seSBpbWFnZXMsIGFzDQo+IHdlbGwgYXMgbWFraW5nIHRoZSBuZXh0
IHBhdGNoIGZvciBleHBvc2luZyBGQVNUX1pFUk8gc3VwcG9ydCBlYXNpZXIgdG8NCj4gd3JpdGUu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEJsYWtlIDxlYmxha2VAcmVkaGF0LmNvbT4NCj4g
LS0tDQo+ICAgaW5jbHVkZS9ibG9jay9uYmQuaCB8ICAyICstDQo+ICAgYmxvY2tkZXYtbmJkLmMg
ICAgICB8ICAzICstLQ0KPiAgIG5iZC9zZXJ2ZXIuYyAgICAgICAgfCA2MiArKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICBxZW11LW5iZC5jICAgICAgICAg
IHwgIDYgKystLS0NCj4gICA0IGZpbGVzIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKyksIDM0IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvYmxvY2svbmJkLmggYi9pbmNs
dWRlL2Jsb2NrL25iZC5oDQo+IGluZGV4IDk5MWZkNTJhNTEzNC4uMmM4N2I0MmRmZDQ4IDEwMDY0
NA0KPiAtLS0gYS9pbmNsdWRlL2Jsb2NrL25iZC5oDQo+ICsrKyBiL2luY2x1ZGUvYmxvY2svbmJk
LmgNCj4gQEAgLTMyNiw3ICszMjYsNyBAQCB0eXBlZGVmIHN0cnVjdCBOQkRDbGllbnQgTkJEQ2xp
ZW50Ow0KPiANCj4gICBOQkRFeHBvcnQgKm5iZF9leHBvcnRfbmV3KEJsb2NrRHJpdmVyU3RhdGUg
KmJzLCB1aW50NjRfdCBkZXZfb2Zmc2V0LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dWludDY0X3Qgc2l6ZSwgY29uc3QgY2hhciAqbmFtZSwgY29uc3QgY2hhciAqZGVzYywNCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqYml0bWFwLCB1aW50MTZfdCBuYmRm
bGFncywgYm9vbCBzaGFyZWQsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNo
YXIgKmJpdG1hcCwgYm9vbCByZWFkb25seSwgYm9vbCBzaGFyZWQsDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB2b2lkICgqY2xvc2UpKE5CREV4cG9ydCAqKSwgYm9vbCB3cml0ZXRocm91
Z2gsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCbG9ja0JhY2tlbmQgKm9uX2VqZWN0
X2JsaywgRXJyb3IgKiplcnJwKTsNCj4gICB2b2lkIG5iZF9leHBvcnRfY2xvc2UoTkJERXhwb3J0
ICpleHApOw0KPiBkaWZmIC0tZ2l0IGEvYmxvY2tkZXYtbmJkLmMgYi9ibG9ja2Rldi1uYmQuYw0K
PiBpbmRleCBlY2ZhMmVmMGFkYjUuLjFjZGZmYWI0ZmNlMSAxMDA2NDQNCj4gLS0tIGEvYmxvY2tk
ZXYtbmJkLmMNCj4gKysrIGIvYmxvY2tkZXYtbmJkLmMNCj4gQEAgLTE4Nyw4ICsxODcsNyBAQCB2
b2lkIHFtcF9uYmRfc2VydmVyX2FkZChjb25zdCBjaGFyICpkZXZpY2UsIGJvb2wgaGFzX25hbWUs
IGNvbnN0IGNoYXIgKm5hbWUsDQo+ICAgICAgICAgICB3cml0YWJsZSA9IGZhbHNlOw0KPiAgICAg
ICB9DQo+IA0KPiAtICAgIGV4cCA9IG5iZF9leHBvcnRfbmV3KGJzLCAwLCBsZW4sIG5hbWUsIE5V
TEwsIGJpdG1hcCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICB3cml0YWJsZSA/IDAgOiBO
QkRfRkxBR19SRUFEX09OTFksICF3cml0YWJsZSwNCj4gKyAgICBleHAgPSBuYmRfZXhwb3J0X25l
dyhicywgMCwgbGVuLCBuYW1lLCBOVUxMLCBiaXRtYXAsICF3cml0YWJsZSwgIXdyaXRhYmxlLA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMLCBmYWxzZSwgb25fZWplY3RfYmxrLCBl
cnJwKTsNCj4gICAgICAgaWYgKCFleHApIHsNCj4gICAgICAgICAgIHJldHVybjsNCj4gZGlmZiAt
LWdpdCBhL25iZC9zZXJ2ZXIuYyBiL25iZC9zZXJ2ZXIuYw0KPiBpbmRleCAwZmI0MWM2YzUwZWEu
LmI1NTc3ODI4YWE0NCAxMDA2NDQNCj4gLS0tIGEvbmJkL3NlcnZlci5jDQo+ICsrKyBiL25iZC9z
ZXJ2ZXIuYw0KPiBAQCAtNDIzLDE0ICs0MjMsMTQgQEAgc3RhdGljIHZvaWQgbmJkX2NoZWNrX21l
dGFfZXhwb3J0KE5CRENsaWVudCAqY2xpZW50KQ0KPiANCj4gICAvKiBTZW5kIGEgcmVwbHkgdG8g
TkJEX09QVF9FWFBPUlRfTkFNRS4NCj4gICAgKiBSZXR1cm4gLWVycm5vIG9uIGVycm9yLCAwIG9u
IHN1Y2Nlc3MuICovDQo+IC1zdGF0aWMgaW50IG5iZF9uZWdvdGlhdGVfaGFuZGxlX2V4cG9ydF9u
YW1lKE5CRENsaWVudCAqY2xpZW50LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1aW50MTZfdCBteWZsYWdzLCBib29sIG5vX3plcm9lcywNCj4gK3N0YXRp
YyBpbnQgbmJkX25lZ290aWF0ZV9oYW5kbGVfZXhwb3J0X25hbWUoTkJEQ2xpZW50ICpjbGllbnQs
IGJvb2wgbm9femVyb2VzLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPiAgIHsNCj4gICAgICAgY2hhciBuYW1lW05CRF9NQVhf
TkFNRV9TSVpFICsgMV07DQo+ICAgICAgIGNoYXIgYnVmW05CRF9SRVBMWV9FWFBPUlRfTkFNRV9T
SVpFXSA9ICIiOw0KPiAgICAgICBzaXplX3QgbGVuOw0KPiAgICAgICBpbnQgcmV0Ow0KPiArICAg
IHVpbnQxNl90IG15ZmxhZ3M7DQo+IA0KPiAgICAgICAvKiBDbGllbnQgc2VuZHM6DQo+ICAgICAg
ICAgICBbMjAgLi4gIHh4XSAgIGV4cG9ydCBuYW1lIChsZW5ndGggYnl0ZXMpDQo+IEBAIC00NTgs
MTAgKzQ1OCwxMyBAQCBzdGF0aWMgaW50IG5iZF9uZWdvdGlhdGVfaGFuZGxlX2V4cG9ydF9uYW1l
KE5CRENsaWVudCAqY2xpZW50LA0KPiAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICAgICAg
IH0NCj4gDQo+IC0gICAgdHJhY2VfbmJkX25lZ290aWF0ZV9uZXdfc3R5bGVfc2l6ZV9mbGFncyhj
bGllbnQtPmV4cC0+c2l6ZSwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNsaWVudC0+ZXhwLT5uYmRmbGFncyB8IG15ZmxhZ3MpOw0KPiArICAgIG15Zmxh
Z3MgPSBjbGllbnQtPmV4cC0+bmJkZmxhZ3M7DQo+ICsgICAgaWYgKGNsaWVudC0+c3RydWN0dXJl
ZF9yZXBseSkgew0KPiArICAgICAgICBteWZsYWdzIHw9IE5CRF9GTEFHX1NFTkRfREY7DQo+ICsg
ICAgfQ0KDQoNCndoeSB3ZSBjYW50IGRvIGp1c3QNCmNsaWVudC0+ZXhwLT5uYmRmbGFncyB8PSBO
QkRfRkxBR19TRU5EX0RGID8NCg0KT3IgZXZlbiBkbyBpdCBlYXJsaWVyLCB3aGVuIGNsaWVudC0+
c3RydWN0dXJlZF9yZXBseSBiZWNvbWVzIHRydWU/DQoNCj4gKyAgICB0cmFjZV9uYmRfbmVnb3Rp
YXRlX25ld19zdHlsZV9zaXplX2ZsYWdzKGNsaWVudC0+ZXhwLT5zaXplLCBteWZsYWdzKTsNCj4g
ICAgICAgc3RxX2JlX3AoYnVmLCBjbGllbnQtPmV4cC0+c2l6ZSk7DQo+IC0gICAgc3R3X2JlX3Ao
YnVmICsgOCwgY2xpZW50LT5leHAtPm5iZGZsYWdzIHwgbXlmbGFncyk7DQo+ICsgICAgc3R3X2Jl
X3AoYnVmICsgOCwgbXlmbGFncyk7DQo+ICAgICAgIGxlbiA9IG5vX3plcm9lcyA/IDEwIDogc2l6
ZW9mKGJ1Zik7DQo+ICAgICAgIHJldCA9IG5iZF93cml0ZShjbGllbnQtPmlvYywgYnVmLCBsZW4s
IGVycnApOw0KPiAgICAgICBpZiAocmV0IDwgMCkgew0KPiBAQCAtNTI2LDggKzUyOSw3IEBAIHN0
YXRpYyBpbnQgbmJkX3JlamVjdF9sZW5ndGgoTkJEQ2xpZW50ICpjbGllbnQsIGJvb2wgZmF0YWws
IEVycm9yICoqZXJycCkNCj4gICAvKiBIYW5kbGUgTkJEX09QVF9JTkZPIGFuZCBOQkRfT1BUX0dP
Lg0KPiAgICAqIFJldHVybiAtZXJybm8gb24gZXJyb3IsIDAgaWYgcmVhZHkgZm9yIG5leHQgb3B0
aW9uLCBhbmQgMSB0byBtb3ZlDQo+ICAgICogaW50byB0cmFuc21pc3Npb24gcGhhc2UuICAqLw0K
PiAtc3RhdGljIGludCBuYmRfbmVnb3RpYXRlX2hhbmRsZV9pbmZvKE5CRENsaWVudCAqY2xpZW50
LCB1aW50MTZfdCBteWZsYWdzLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEVycm9yICoqZXJycCkNCj4gK3N0YXRpYyBpbnQgbmJkX25lZ290aWF0ZV9oYW5kbGVfaW5m
byhOQkRDbGllbnQgKmNsaWVudCwgRXJyb3IgKiplcnJwKQ0KPiAgIHsNCj4gICAgICAgaW50IHJj
Ow0KPiAgICAgICBjaGFyIG5hbWVbTkJEX01BWF9OQU1FX1NJWkUgKyAxXTsNCg0KWy4uXQ0KDQoN
Ci0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

