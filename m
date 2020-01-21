Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_RHS_DOB autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55504C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A62622522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ecmvvBqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A62622522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itplQ-0003dC-3Y
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 04:24:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itpkl-00032H-7h
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:23:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itpki-0008FJ-Ve
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:23:19 -0500
Received: from mail-eopbgr40126.outbound.protection.outlook.com
 ([40.107.4.126]:31045 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itpkb-0008Bf-Ms; Tue, 21 Jan 2020 04:23:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBn6tJaSUa9msokx0fBRk/IxdfVC2v0rbGyLSpcMzt4qIzXAPLOerFeyWGqf6K0PThMdVdAQgKpGmmly9LinbXDI+p+Pw3TJnF8pLA07RdeALPGbbC4DxcZo7s31L5Jjeb8u2SAPfniX9Wpbo6dJcnSv7S9EDssz30DrqppajvdXprlHJYNO33LZ0dK4AaBOV/mJLiHv+3m2S8K0Xut0jXGgycdP07DpB7CxOYZOCKY17lO7/M975MqFRBDsEHa75XSrRmS9ZiwGnFOsDNh8TxtUSgQQDkiTK0VSin51tUyTwyXssqaWclhBYR9mR86QUSughZCHvK1g3ckJTt8y5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0afaW7se6RAmsH6oQLUMQNNjywKDLPaF7A8vN4BNOEQ=;
 b=MTfn93byTumyUJLE8gi8Qve7neiUGOUnXgVQqZZ3v8LLUfTuOac1WwECQWOqiYNoQTFiobtSWJEpJseEqcEaIj3wawWyM64fxtqr5OZzzU6Sdkz03sSp4KRNkbU4CwEoJfJ/jHYba57suPCBSqXEMAiNEQYvAwOf9xeR00Rki1+JZtWIlsgkZd3qTFExNX+EaLv1fQTbpapHpO7/+r7nmo/TyAm3KcKnMorw+WEBTwae4cq56iQn6rLw+L+ZYZo0dO2FYJ8LbF7KmbTiaJycxqVDu2vDIM9ZL0G+a2gnmVbVDWgiI+Agyo4UYpaq6I60B+9ys9oFsrYlOxOp6JPCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0afaW7se6RAmsH6oQLUMQNNjywKDLPaF7A8vN4BNOEQ=;
 b=ecmvvBqbKDzsDB8IlpVTMw6pbdfX80+Cz+VLuCqkfYoYCI3FHZu8lioNbhSNR0l52R6Sc/sLHKaIL5EuCiQClZJWTMeV1F3m+5t6bEnpxo10QZlZMD5zV5voGkD+ubonPrUco/2wkSxUujG6EQyln9jIJlEJ8Wjf9JaNXHAZgM4=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4327.eurprd08.prod.outlook.com (20.179.6.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Tue, 21 Jan 2020 09:23:06 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 09:23:06 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 AM4PR08CA0052.eurprd08.prod.outlook.com (2603:10a6:205:2::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Tue, 21 Jan 2020 09:23:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 2/2] iotests: add test for backup-top failure on
 permission activation
Thread-Topic: [PATCH 2/2] iotests: add test for backup-top failure on
 permission activation
Thread-Index: AQHVzIVUyOIzH3fEwkGWDPORhit+OafzzmgAgAAESICAAQrFgIAAAkQA
Date: Tue, 21 Jan 2020 09:23:06 +0000
Message-ID: <0e865df2-7d21-b18f-b73c-2948577b9dcb@virtuozzo.com>
References: <20200116155452.30972-1-vsementsov@virtuozzo.com>
 <20200116155452.30972-3-vsementsov@virtuozzo.com>
 <eedd42b6-bf4e-f6de-13a4-412d389fdb09@redhat.com>
 <ea9219cd-8cc1-8cc0-d568-a51013ba74a4@virtuozzo.com>
 <f52b6ff5-e993-d567-cbbe-1d6d158908da@redhat.com>
In-Reply-To: <f52b6ff5-e993-d567-cbbe-1d6d158908da@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR08CA0052.eurprd08.prod.outlook.com
 (2603:10a6:205:2::23) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200121122304871
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcccb081-b286-48d2-3f6d-08d79e5385dc
x-ms-traffictypediagnostic: AM6PR08MB4327:
x-microsoft-antispam-prvs: <AM6PR08MB43279D79CF70A20773225819C10D0@AM6PR08MB4327.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(366004)(136003)(346002)(376002)(199004)(189003)(53546011)(26005)(71200400001)(8936002)(186003)(52116002)(16526019)(4326008)(66946007)(66556008)(66446008)(66476007)(8676002)(64756008)(81156014)(81166006)(956004)(2616005)(5660300002)(6486002)(54906003)(316002)(86362001)(31686004)(31696002)(110136005)(2906002)(16576012)(508600001)(966005)(36756003)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4327;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hykNbCb7p3eeb2bA3/UrGkkactcVUdDJH50uqhL+sFLHCn0GHCOzO8kr0x0+tHAC14nvW3vs5W50D7q7mKO35y0yindJbh1CeIxmVV4pJlK35TRonRgGR+EQzhMWV6dby59buv4EnWvm5iHUMkzbLJ/3AMpRKF46EG2ZzvAnzVSKSGcp2sOIn+QzIVYwro+rvs6wG1Vw3dcqjCfhDKpQPEWZkivbQT6qyxeIH4I2JyD+cfbhmAfJ4PxXy2/l8HWrtF4bkR5GYdAc6YU3jxEgKJ8L/P7P7HYUzPAFchdhXIlDvod1KI1bs/cTxY6mWuLeBQCTwjhs2mUPjRJGw5LuCF0ZpLRkacCo2go2xSxtTUeIMhmr5LoKOFTConmwMKwntMOM3NCuJ3C8ycnsVoTJQ+4jn+v2k7l6Vh/HWN+wRBOv+aWp5Bpx7LTwv+n1TotegJxMHk2nylX9xanb05XsOrpVp2lAF8iEpVr79W7CeqXkUDodj5xRsjESx5aYocyZoV/gocCitbRWcJofX1UToEau28aqmjuYzo5UK6d1Rw60oH1Rh9mrkoMOxovCtLp6
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5189D4A611D114AA06525139881402E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcccb081-b286-48d2-3f6d-08d79e5385dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 09:23:06.2462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XDwOd2OGIIdvkXJ5iovyf39yNqZ+OFF1khXef2KCFa+lKt5rYs5hjPGlU6wJ4Y6x41eow1/M5Mhs727zHWgEyz6NUcKaZzOK5G6LZFbXLSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4327
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.126
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjEuMDEuMjAyMCAxMjoxNCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyMC4wMS4yMCAxODoyMCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDIwLjAxLjIwMjAgMjA6MDQs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAxNi4wMS4yMCAxNjo1NCwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gVGhpcyB0ZXN0IGNoZWNrcyB0aGF0IGJ1ZyBpcyBy
ZWFsbHkgZml4ZWQgYnkgcHJldmlvdXMgY29tbWl0Lg0KPj4+Pg0KPj4+PiBDYzogcWVtdS1zdGFi
bGVAbm9uZ251Lm9yZyAjIHY0LjIuMA0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1l
bnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+Pj4+IC0tLQ0KPj4+
PiAgICB0ZXN0cy9xZW11LWlvdGVzdHMvMjgzICAgICB8IDc1ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+Pj4+ICAgIHRlc3RzL3FlbXUtaW90ZXN0cy8yODMub3V0IHwg
IDggKysrKw0KPj4+PiAgICB0ZXN0cy9xZW11LWlvdGVzdHMvZ3JvdXAgICB8ICAxICsNCj4+Pj4g
ICAgMyBmaWxlcyBjaGFuZ2VkLCA4NCBpbnNlcnRpb25zKCspDQo+Pj4+ICAgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCB0ZXN0cy9xZW11LWlvdGVzdHMvMjgzDQo+Pj4+ICAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCB0ZXN0cy9xZW11LWlvdGVzdHMvMjgzLm91dA0KPj4+DQo+Pj4gVGhlIHRlc3QgbG9va3MgZ29v
ZCB0byBtZSwgSSBqdXN0IGhhdmUgYSBjb21tZW50IG5pdCBhbmQgYSBub3RlIG9uIHRoZQ0KPj4+
IGZhY3QgdGhhdCB0aGlzIHNob3VsZCBwcm9iYWJseSBiZSBxdWV1ZWQgb25seSBhZnRlciBUaG9t
YXPigJlzIOKAnEVuYWJsZQ0KPj4+IG1vcmUgaW90ZXN0cyBkdXJpbmcgIm1ha2UgY2hlY2stYmxv
Y2si4oCdIHNlcmllcy4NCj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3Rz
LzI4MyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yODMNCj4+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4+Pj4gaW5kZXggMDAwMDAwMDAwMC4uZjBmMjE2ZDEwOQ0KPj4+PiAtLS0gL2Rldi9udWxsDQo+
Pj4+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yODMNCj4+Pj4gQEAgLTAsMCArMSw3NSBAQA0K
Pj4+PiArIyEvdXNyL2Jpbi9lbnYgcHl0aG9uDQo+Pj4+ICsjDQo+Pj4+ICsjIFRlc3QgZm9yIGJh
Y2t1cC10b3AgZmlsdGVyIHBlcm1pc3Npb24gYWN0aXZhdGlvbiBmYWlsdXJlDQo+Pj4+ICsjDQo+
Pj4+ICsjIENvcHlyaWdodCAoYykgMjAxOSBWaXJ0dW96em8gSW50ZXJuYXRpb25hbCBHbWJILg0K
Pj4+PiArIw0KPj4+PiArIyBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiBy
ZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQ0KPj4+PiArIyBpdCB1bmRlciB0aGUgdGVybXMg
b2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQ0KPj4+PiAr
IyB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBM
aWNlbnNlLCBvcg0KPj4+PiArIyAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLg0K
Pj4+PiArIw0KPj4+PiArIyBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUg
dGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwNCj4+Pj4gKyMgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZ
OyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YNCj4+Pj4gKyMgTUVSQ0hBTlRB
QklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQ0KPj4+
PiArIyBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLg0KPj4+PiAr
Iw0KPj4+PiArIyBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZQ0KPj4+PiArIyBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbS4gIElm
IG5vdCwgc2VlIDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvPi4NCj4+Pj4gKyMNCj4+Pj4g
Kw0KPj4+PiAraW1wb3J0IGlvdGVzdHMNCj4+Pj4gKw0KPj4+PiArIyBUaGUgdGVzdCBpcyB1bnJl
bGF0ZWQgdG8gZm9ybWF0cywgcmVzdHJpY3QgaXQgdG8gcWNvdzIgdG8gYXZvaWQgZXh0cmEgcnVu
cw0KPj4+PiAraW90ZXN0cy52ZXJpZnlfaW1hZ2VfZm9ybWF0KHN1cHBvcnRlZF9mbXRzPVsncWNv
dzInXSkNCj4+Pj4gKw0KPj4+PiArc2l6ZSA9IDEwMjQgKiAxMDI0DQo+Pj4+ICsNCj4+Pj4gKyIi
Ig0KPj4+PiArT24gYWN0aXZhdGlvbiwgYmFja3VwLXRvcCBpcyBnb2luZyB0byB1bnNoYXJlIHdy
aXRlIHBlcm1pc3Npb24gb24gaXRzDQo+Pj4+ICtzb3VyY2UgY2hpbGQuIEl0IHdpbGwgYmUgaW1w
b3NzaWJsZSBmb3IgdGhlIGZvbGxvd2luZyBjb25maWd1cmF0aW9uOg0KPj4+DQo+Pj4g4oCcVGhl
IGZvbGxvd2luZyBjb25maWd1cmF0aW9uIHdpbGwgYmVjb21lIGltcG9zc2libGXigJ0/DQo+Pg0K
Pj4gSG1tLCBubywgdGhlIGNvbmZpZ3VyYXRpb24gaXMgcG9zc2libGUuIEJ1dCAiaXQiLCBpLmUu
ICJ1bnNoYXJlIHdyaXRlIHBlcm1pc3Npb24iLA0KPj4gaXMgaW1wb3NzaWJsZSB3aXRoIHN1Y2gg
Y29uZmlndXJhdGlvbi4uDQo+IA0KPiBCdXQgYmFja3VwX3RvcCBhbHdheXMgdW5zaGFyZXMgdGhl
IHdyaXRlIHBlcm1pc3Npb24gb24gdGhlIHNvdXJjZS4NCg0KWWVzLCBhbmQgSSBqdXN0IHRyeSB0
byBzYXksIHRoYXQgdGhpcyBhY3Rpb24gd2lsbCBmYWlsLiBBbmQgdGhlIHRlc3QgY2hlY2tzIHRo
YXQgaXQNCmZhaWxzIChhbmQgaXQgY3Jhc2hlcyB3aXRoIGN1cnJlbnQgbWFzdGVyIGluc3RlYWQg
b2YgZmFpbCkuDQoNCj4gDQo+Pj4gSSB0aGluayB0aGVyZSBzaG91bGQgYmUgc29tZSBub3RlIHRo
YXQgdGhpcyBpcyBleGFjdGx5IHdoYXQgd2Ugd2FudCB0bw0KPj4+IHRlc3QsIGkuZS4gd2hhdCBo
YXBwZW5zIHdoZW4gdGhpcyBpbXBvc3NpYmxlIGNvbmZpZ3VyYXRpb24gaXMgYXR0ZW1wdGVkDQo+
Pj4gYnkgc3RhcnRpbmcgYSBiYWNrdXAuICAoQW5kIG1heWJlIHdoeSB0aGlzIGlzbuKAmXQgYWxs
b3dlZDsgbmFtZWx5IGJlY2F1c2UNCj4+PiB3ZSBjb3VsZG7igJl0IGRvIENCVyBmb3Igc3VjaCB3
cml0ZSBhY2Nlc3Nlcy4pDQo+Pj4NCj4+Pj4gKw0KPj4+PiArICAgIOKUjOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUkCAgdGFyZ2V0ICDilIzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilJANCj4+Pj4gKyAgICDilIIgdGFyZ2V0IOKUgiDil4DilIDilIDilIDilIDilIDi
lIDilIAg4pSCIGJhY2t1cF90b3AgIOKUgg0KPj4+PiArICAgIOKUlOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUmCAgICAgICAgICDilJTilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilJgNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICDilIINCj4+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICDilIIgYmFja2luZw0KPj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIOKWvA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAg4pSM4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQDQo+Pj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICDilIIgICBzb3VyY2UgICAg4pSCDQo+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICDilJTilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJgNCj4+
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICDilIINCj4+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICDilIIgZmlsZQ0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
IOKWvA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQICB3cml0ZSBwZXJtICAg4pSM4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSQDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICDilIIgICAgYmFzZSAgICAg
4pSCIOKXgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgCDilIIgb3RoZXIg4pSC
DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICDilJTilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilJggICAgICAgICAgICAgICDilJTilIDilIDilIDilIDilIDilIDi
lIDilJgNCj4+Pg0KPj4+IENvb2wgVW5pY29kZSBhcnQuIDotKQ0KPj4NCj4+IEkgZm91bmQgdGhl
IGdyZWF0IHRvb2w6IGh0dHBzOi8vZG90LXRvLWFzY2lpLmdnZXJnYW5vdi5jb20vDQo+IA0KPiBU
aGFua3MhDQo+IA0KPiBNYXgNCj4gDQo+Pj4+ICsNCj4+Pj4gK1dyaXRlIHVuc2hhcmluZyB3aWxs
IGJlIHByb3BhZ2F0ZWQgdG8gdGhlICJzb3VyY2UtPmJhc2UibGluayBhbmQgd2lsbA0KPj4+PiAr
Y29uZmxpY3Qgd2l0aCBvdGhlciBub2RlIHdyaXRlIHBlcm1pc3Npb24uDQo+Pj4+ICsNCj4+Pj4g
KyhOb3RlLCB0aGF0IHdlIGNhbid0IGp1c3QgY29uc2lkZXIgc291cmNlIHRvIGJlIGRpcmVjdCBj
aGlsZCBvZiBvdGhlciwNCj4+Pj4gK2FzIGluIHRoaXMgY2FzZSB0aGlzIGxpbmsgd2lsbCBiZSBi
cm9rZW4sIHdoZW4gYmFja3VwX3RvcCBpcyBhcHBlbmRlZCkNCj4+Pj4gKyIiIg0KPj4+PiArDQo+
Pj4+ICt2bSA9IGlvdGVzdHMuVk0oKQ0KPj4+PiArdm0ubGF1bmNoKCkNCj4+Pj4gKw0KPj4+PiAr
dm0ucW1wX2xvZygnYmxvY2tkZXYtYWRkJywgKip7J25vZGUtbmFtZSc6ICd0YXJnZXQnLCAnZHJp
dmVyJzogJ251bGwtY28nfSkNCj4+Pj4gKw0KPj4+PiArdm0ucW1wX2xvZygnYmxvY2tkZXYtYWRk
JywgKip7DQo+Pj4+ICsgICAgJ25vZGUtbmFtZSc6ICdzb3VyY2UnLA0KPj4+PiArICAgICdkcml2
ZXInOiAnYmxrZGVidWcnLA0KPj4+PiArICAgICdpbWFnZSc6IHsnbm9kZS1uYW1lJzogJ2Jhc2Un
LCAnZHJpdmVyJzogJ251bGwtY28nLCAnc2l6ZSc6IHNpemV9DQo+Pj4+ICt9KQ0KPj4+PiArDQo+
Pj4+ICt2bS5xbXBfbG9nKCdibG9ja2Rldi1hZGQnLCAqKnsNCj4+Pj4gKyAgICAnbm9kZS1uYW1l
JzogJ290aGVyJywNCj4+Pj4gKyAgICAnZHJpdmVyJzogJ2Jsa2RlYnVnJywNCj4+Pj4gKyAgICAn
aW1hZ2UnOiAnYmFzZScsDQo+Pj4+ICsgICAgJ3Rha2UtY2hpbGQtcGVybXMnOiBbJ3dyaXRlJ10N
Cj4+Pj4gK30pDQo+Pj4+ICsNCj4+Pj4gK3ZtLnFtcF9sb2coJ2Jsb2NrZGV2LWJhY2t1cCcsIHN5
bmM9J2Z1bGwnLCBkZXZpY2U9J3NvdXJjZScsIHRhcmdldD0ndGFyZ2V0JykNCj4+Pj4gKw0KPj4+
PiArdm0uc2h1dGRvd24oKQ0KPj4+DQo+Pj4gWy4uLl0NCj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEv
dGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwIGIvdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwDQo+Pj4+
IGluZGV4IGNiMmI3ODllNDQuLmQ4MjdlOGM4MjEgMTAwNjQ0DQo+Pj4+IC0tLSBhL3Rlc3RzL3Fl
bXUtaW90ZXN0cy9ncm91cA0KPj4+PiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvZ3JvdXANCj4+
Pj4gQEAgLTI4OCwzICsyODgsNCBAQA0KPj4+PiAgICAyNzcgcncgcXVpY2sNCj4+Pj4gICAgMjc5
IHJ3IGJhY2tpbmcgcXVpY2sNCj4+Pj4gICAgMjgwIHJ3IG1pZ3JhdGlvbiBxdWljaw0KPj4+PiAr
MjgzIGF1dG8gcXVpY2sNCj4+Pg0KPj4+IEhtLiAgVGhpcyB3b3VsZCBiZSB0aGUgZmlyc3QgUHl0
aG9uIHRlc3QgaW4gYXV0by4NCj4+DQo+PiBNaXNzZWQgdGhhdC4gSXQncyBPSyB0byBkZWZpbmUg
aXQganVzdCAicXVpY2siIGFuZCB1cGRhdGUgbGF0ZXIuDQo+Pg0KPj4+ICAgVGhvbWFz4oCZcyBz
ZXJpZXMgaGFzDQo+Pj4gYXQgbGVhc3Qgb25lIHBhdGNoIHRoYXQgc2VlbXMgdXNlZnVsIHRvIGNv
bWUgYmVmb3JlIHdlIGRvIHRoaXMsIG5hbWVseQ0KPj4+IOKAnFNraXAgUHl0aG9uLWJhc2VkIHRl
c3RzIGlmIFFFTVUgZG9lcyBub3Qgc3VwcG9ydCB2aXJ0aW8tYmxr4oCdLiAgU28gSQ0KPj4+IHN1
cHBvc2UgaGlzIHNlcmllcyBzaG91bGQgY29tZSBiZWZvcmUgdGhpcywgdGhlbi4NCj4+Pg0KPj4+
IE1heA0KPj4+DQo+Pg0KPj4NCj4gDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGlt
aXINCg==

