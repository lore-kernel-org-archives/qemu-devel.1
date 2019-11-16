Return-Path: <SRS0=i/12=ZI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6ABC432C3
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 16:31:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2590020857
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 16:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="D5Qk+dPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2590020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iW0zI-00047S-6N
	for qemu-devel@archiver.kernel.org; Sat, 16 Nov 2019 11:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iW0yD-0003ZQ-Tl
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 11:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iW0yC-0004DU-8B
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 11:30:45 -0500
Received: from mail-eopbgr80095.outbound.protection.outlook.com
 ([40.107.8.95]:30766 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iW0yB-0004Cv-Kr; Sat, 16 Nov 2019 11:30:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4m6GB3UXvYwNvw0FiH4mOvuAFy5tl27vxWMnewyo6/ITGPPKiAxNnx8YsJ/+kOUVgkAKLYBJY2W+xIoUXUlDHyp4hKqfxwQptI3wr/nie1xz1rwDsxTWZGs3KLo5AYNKEAE5FvtPw92u9tqHGeUnPdXkHO3rKQlBzvkRSOG7vG+TRPPS61SV0u02QL7twkUD0U0zLUn8aOgtYW77QGCYsUCTtctEA0DEIX2FFNwJJUt+tL1+MNCdpZUAQI++SE5X8IxSjzWrAe0SeyamarpOlltInVIXCOyTGJ6MtI0xskudVsa64+TnkfNOTiu21YcrWz9yg0tp+P0MzR/z/X/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be1NF2NNFgY0+Eg0c5qjrXZW0lcGnQS9hrbIl9+ynwc=;
 b=jpf6pkz3D31+CoczWr8DQKzRv4iyIPClqH8r1vGdYBRQMZnaqOYPk6Zn6ocOqqjaRCRJ8KqjqZg1Tpbhi/23SYrayPJ4v6J6OhxXZILSXWPyQali5KdLNfVXLOmMsnIUCM9T0mOdmOkTGSCN8AunZgAt8tkCVi6dOzljixsst8L/014xKalRH4q7VD3L12dkZpKeMFu7kSpFAsgAjUb8oLhbuPUgG5cTwfwVlt1KWHHhWqj56fA5wj4CgsgXEbQJv25dz2KB0ngnYCxfNpN6+bwrYuooDwDbKUlmFU0brVoanbKVtwC4OoW2OPfAfDG53BytiI9uN3iQ9w4nFeSIvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be1NF2NNFgY0+Eg0c5qjrXZW0lcGnQS9hrbIl9+ynwc=;
 b=D5Qk+dPx6Z9q+ELuPUHKQLfnI9FUkAJnVarmV9qxrE++jK+Mz4Oe/P3eAa2pPylhNNSgmA6pCQu0w6gzi6nfC04jAsC4zzymF3jFScFFFVLWcb/clMkHPjcvoCrP4bdsLaQjgxi1J3KDlP3f2ZnH2rr7+S7J7fnG7dbZU0JBHrw=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3096.eurprd08.prod.outlook.com (52.135.162.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Sat, 16 Nov 2019 16:30:39 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.029; Sat, 16 Nov 2019
 16:30:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu block <qemu-block@nongnu.org>
Subject: DROP Re: bdrv_is_allocated_above bug or feature
Thread-Topic: DROP Re: bdrv_is_allocated_above bug or feature
Thread-Index: AQHVnIi1uCzuIXWMDEes9S4IuoC4X6eN/UmA
Date: Sat, 16 Nov 2019 16:30:39 +0000
Message-ID: <7d5e62f3-206d-1e12-279a-beca9eef702a@virtuozzo.com>
References: <735cac20-6dff-db37-a0a7-92c008d947bf@virtuozzo.com>
In-Reply-To: <735cac20-6dff-db37-a0a7-92c008d947bf@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:7:67::30) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191116193037267
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b09e27b7-eb7e-4a91-666d-08d76ab25102
x-ms-traffictypediagnostic: AM6PR08MB3096:
x-microsoft-antispam-prvs: <AM6PR08MB3096DB5A56DEE04C9A97E7B0C1730@AM6PR08MB3096.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 02234DBFF6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(136003)(39840400004)(366004)(346002)(189003)(53754006)(199004)(31686004)(81156014)(81166006)(8676002)(478600001)(8936002)(66476007)(66556008)(64756008)(66446008)(6512007)(66946007)(14454004)(76176011)(2906002)(26005)(6436002)(6486002)(71190400001)(25786009)(486006)(6506007)(186003)(446003)(52116002)(476003)(2616005)(11346002)(256004)(14444005)(99286004)(316002)(31696002)(54906003)(71200400001)(86362001)(3846002)(6116002)(305945005)(102836004)(386003)(7736002)(66066001)(36756003)(5660300002)(6916009)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3096;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +TjSV6d7w3UIIUpXMJc/W5J2qMJIlmotc6TRXpCKF25AzeUZl5OUySGn3a+mfK5LInGWmibWshg06lV8iH0e/AWV3vcW0JI9bIhafmf7yj1tQBCWUo6yd18SHHuJc0VL6xtpOI4ZGJ7O1mgokpUKBCYl8MWQ19QtF6yzCWOKLOzwtLch8GsIl7OE/aXn43OL3R1r97A06EOUsVUQpT+mQw3iJrH58Ojqpi3KLRXjyrO1RmDU5G+yHtiZB42dKIDrpIOCtUdMwIT+E1jebpGFqbwTcqa/4JWbmnBHclHewzEseneTNubmdSf1raQqbKZIBmfpyScfjVHr/lzGnbO/3jnmSmaXBQmLleVawZAQP1gOgp9sLIDzP9kOwCmYDoz8x7mq33t+LUtrzT0lKptnvj+kuFttXZmaaZ4elUL7GIHyiX2kLp95SGg3CB5Ydwpe
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5697559EC1D7D5489FF87CB742A25615@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09e27b7-eb7e-4a91-666d-08d76ab25102
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2019 16:30:39.4058 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gUvm7CS01Zc0YmKWyt59MUCNaps5yqi+oGgZ5wBA8RkVvlbauyhAUPajpaWfiHjnS5nvJvpdxdXxxHggvQTZvF21C1nJ3EjxD5SptNWYjRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3096
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.95
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGxlYXNlIGRvbid0IGFuc3dlciwgSSdsbCByZXNlbmQgaXQgYXMgYSBjb3ZlciBsZXR0ZXIgZm9y
IHByb3Bvc2VkIHNlcmllcyB0byBmaXggdGhlc2UgdGhpbmdzLg0KDQoxNi4xMS4yMDE5IDE3OjE4
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPiBIaSBhbGwhDQo+IA0KPiBJ
IHdhbnRlZCB0byB1bmRlcnN0YW5kLCB3aGF0IGlzIHRoZSByZWFsIGRpZmZlcmVuY2UgYmV0d2Vl
biBiZHJ2X2Jsb2NrX3N0YXR1c19hYm92ZQ0KPiBhbmQgYmRydl9pc19hbGxvY2F0ZWRfYWJvdmUs
IElNSE8gYmRydl9pc19hbGxvY2F0ZWRfYWJvdmUgc2hvdWxkIHdvcmsgdGhyb3VnaA0KPiBiZHJ2
X2Jsb2NrX3N0YXR1c19hYm92ZS4uDQo+IA0KPiBBbmQgSSBmb3VuZCB0aGUgZGlmZmVyZW5jZTog
YmRydl9pc19hbGxvY2F0ZWRfYWJvdmUgY29uc2lkZXJzIHNwYWNlIGFmdGVyIEVPRiBhcw0KPiBV
TkFMTE9DQVRFRCBmb3IgaW50ZXJtZWRpYXRlIG5vZGVzLi4NCj4gDQo+IFVOQUxMT0NBVEVEIGlz
IG5vdCBhYm91dCBhbGxvY2F0aW9uIGF0IGZzIGxldmVsLCBidXQgYWJvdXQgc2hvdWxkIHdlIGdv
IHRvIGJhY2tpbmcgb3INCj4gbm90Li4gQW5kIGl0IHNlZW1zIGluY29ycmVjdCBmb3IgbWUsIGFz
IGluIGNhc2Ugb2Ygc2hvcnQgYmFja2luZyBmaWxlLCB3ZSdsbCByZWFkDQo+IHplcm9lcyBhZnRl
ciBFT0YsIGluc3RlYWQgb2YgZ29pbmcgZnVydGhlciBieSBiYWNraW5nIGNoYWluLg0KPiANCj4g
VGhpcyBsZWFkcyB0byB0aGUgZm9sbG93aW5nIGVmZmVjdDoNCj4gDQo+IC4vcWVtdS1pbWcgY3Jl
YXRlIC1mIHFjb3cyIGJhc2UucWNvdzIgMk0NCj4gLi9xZW11LWlvIC1jICJ3cml0ZSAtUCAweDEg
MCAyTSIgYmFzZS5xY293Mg0KPiANCj4gLi9xZW11LWltZyBjcmVhdGUgLWYgcWNvdzIgLWIgYmFz
ZS5xY293MiBtaWQucWNvdzIgMU0NCj4gLi9xZW11LWltZyBjcmVhdGUgLWYgcWNvdzIgLWIgbWlk
LnFjb3cyIHRvcC5xY293MiAyTQ0KPiANCj4gUmVnaW9uIDFNLi4yTSBpcyBzaGFkb3dlZCBieSBz
aG9ydCBtaWRkbGUgaW1hZ2UsIHNvIGd1ZXN0IHNlZXMgemVyb2VzOg0KPiAuL3FlbXUtaW8gLWMg
InJlYWQgLVAgMCAxTSAxTSIgdG9wLnFjb3cyDQo+IHJlYWQgMTA0ODU3Ni8xMDQ4NTc2IGJ5dGVz
IGF0IG9mZnNldCAxMDQ4NTc2DQo+IDEgTWlCLCAxIG9wczsgMDAuMDAgc2VjICgyMi43OTUgR2lC
L3NlYyBhbmQgMjMzNDEuNTgwNyBvcHMvc2VjKQ0KPiANCj4gQnV0IGFmdGVyIGNvbW1pdCBndWVz
dCB2aXNpYmxlIHN0YXRlIGlzIGNoYW5nZWQsIHdoaWNoIHNlZW1zIHdyb25nIGZvciBtZToNCj4g
Li9xZW11LWltZyBjb21taXQgdG9wLnFjb3cyIC1iIG1pZC5xY293Mg0KPiANCj4gLi9xZW11LWlv
IC1jICJyZWFkIC1QIDAgMU0gMU0iIG1pZC5xY293Mg0KPiBQYXR0ZXJuIHZlcmlmaWNhdGlvbiBm
YWlsZWQgYXQgb2Zmc2V0IDEwNDg1NzYsIDEwNDg1NzYgYnl0ZXMNCj4gcmVhZCAxMDQ4NTc2LzEw
NDg1NzYgYnl0ZXMgYXQgb2Zmc2V0IDEwNDg1NzYNCj4gMSBNaUIsIDEgb3BzOyAwMC4wMCBzZWMg
KDQuOTgxIEdpQi9zZWMgYW5kIDUxMDAuNDc5NCBvcHMvc2VjKQ0KPiANCj4gLi9xZW11LWlvIC1j
ICJyZWFkIC1QIDEgMU0gMU0iIG1pZC5xY293Mg0KPiByZWFkIDEwNDg1NzYvMTA0ODU3NiBieXRl
cyBhdCBvZmZzZXQgMTA0ODU3Ng0KPiAxIE1pQiwgMSBvcHM7IDAwLjAwIHNlYyAoMy4zNjUgR2lC
L3NlYyBhbmQgMzQ0Ni4xNjA2IG9wcy9zZWMpDQo+IA0KPiANCj4gSSBkb24ndCBrbm93LCBpcyBp
dCBhIHJlYWwgYnVnLCBhcyBJIGRvbid0IGtub3csIGRvIHdlIHN1cHBvcnQgYmFja2luZyBmaWxl
IGxhcmdlciB0aGFuDQo+IGl0cyBwYXJlbnQuIFN0aWxsLCBJJ20gbm90IHN1cmUgdGhhdCB0aGlz
IGJlaGF2aW9yIG9mIGJkcnZfaXNfYWxsb2NhdGVkX2Fib3ZlIGRvbid0IGxlYWQNCj4gdG8gb3Ro
ZXIgcHJvYmxlbXMuDQo+IA0KPiA9PT09PQ0KPiANCj4gSG1tLCBiZHJ2X2Jsb2NrX2FsbG9jYXRl
ZF9hYm92ZSBiZWhhdmVzIHN0cmFuZ2UgdG9vOg0KPiANCj4gd2l0aCB3YW50X3plcm89dHJ1ZSwg
aXQgbWF5IHJlcG9ydCB1bmFsbG9jYXRlZCB6ZXJvZXMgYmVjYXVzZSBvZiBzaG9ydCBiYWNraW5n
IGZpbGVzLCB3aGljaA0KPiBhcmUgYWN0dWFsbHkgImFsbG9jYXRlZCIgaW4gUE9WIG9mIGJhY2tp
bmcgY2hhaW5zLiBCdXQgSSBzZWUgdGhpcyBtYXkgaW5mbHVlbmNlIG9ubHkNCj4gcWVtdS1pbWcg
Y29tcGFyZSwgYW5kIEkgZG9uJ3Qgc2VlIGNhbiBpdCB0cmlnZ2VyIHNvbWUgYnVnLi4NCj4gDQo+
IHdpdGggd2FudF96ZXJvPWZhbHNlLCBpdCBtYXkgZG8gbm8gcHJvZ3Jlc3MgYmVjYXVzZSBvZiBz
aG9ydCBiYWNraW5nIGZpbGUuIE1vcmVvdmVyIGl0IG1heQ0KPiByZXBvcnQgRU9GIGluIHRoZSBt
aWRkbGUhISBCdXQgd2FudF96ZXJvPWZhbHNlIHVzZWQgb25seSBpbiBiZHJ2X2lzX2FsbG9jYXRl
ZCwgd2hpY2ggY29uc2lkZXJzDQo+IG9ubHl0IHRvcCBsYXllciwgc28gaXQgc2VlbXMgT0suDQo+
IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

