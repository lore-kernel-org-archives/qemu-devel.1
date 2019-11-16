Return-Path: <SRS0=i/12=ZI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8785EC432C3
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 09:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527B620723
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 09:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="q0vEjpyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527B620723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVubD-0000qb-Hq
	for qemu-devel@archiver.kernel.org; Sat, 16 Nov 2019 04:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVuaQ-0000O3-3m
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 04:41:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVuaO-0001ep-6H
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 04:41:45 -0500
Received: from mail-eopbgr70128.outbound.protection.outlook.com
 ([40.107.7.128]:1845 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVuaN-0001Zu-VD; Sat, 16 Nov 2019 04:41:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G701vfdKomLmzn//wwOjT6nf5QLKTmMqj5Xgh+6OTL/ALRdChva3VSi5exl5dI11u2ZtJ+xwoevaFrAQahWh6923VaP/eV1kPD3qsFHW35gCRb4sMO6RDdvCQlZ/p0dySA2nMnf3QZhfphVx0UJbi1za6zpxzi5jYSHm3SLSlNqKaN4fxlTPMXl2SqmgflMClik+Rn+VNGoUMREyAkxhU+LmYvyvFn59QfUitzMiBo6tVZH0G7gBM+SXYwcXz2Od64z7hDT/KyQM7o/e9R9KSGTua2BbD0k5bKA5/xXG7Xg4TS0FoFJnXzfaF0mXyndskp4rjKqGiZ/nO9dOhuIC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdZeYt0qoug7zdGfZoEEzfdRKmqogSv+CjOrsz3cxIQ=;
 b=MyKZp5nnb2asYk6biGSio1GD9bbKmfWxqJI0nWBnRwe2LwxbgwJ7ytsWP9pIbBkch6cmWE86gzjU971GIp07TpByH4c1wfZb1JXcOtSUbjAznPGIDlNcOwvqCtTbKtaCpWwOYKUmTt9oY7vR+r67kHlt3yJ33ucJocPb5J1uPGXFp3o49oJZuiV3fd5evpK6q16F8KaeaweLFTiv0W6f+3CQrPJsKgmG0+o5MErHaDiEXOoDFdzfUVfgqOjyigPxlmN/tzOzCeeRMcP7CKnsTs2LWIgjLdytqC6uWuPJGV76F2WLNBNNExf+1r4BN2m+CU/gAKI1SY32OQvj8M8ExQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdZeYt0qoug7zdGfZoEEzfdRKmqogSv+CjOrsz3cxIQ=;
 b=q0vEjpyfb7jIHcgAoA4DNl92PdhOzeRBNX2dgYKvrXuB88IiZIfpsSZh8YZNZqOuDKfo35jZwliaBRFsnBdVxrBKc18sEjlfLtSqevc+QcEqfSDzTpHQ0f1yGtlrSZI9//lWPPM2YuHa3E2LAbeoeJ2LUzvHm9g8g1alP7SkzUQ=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3702.eurprd08.prod.outlook.com (20.178.91.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Sat, 16 Nov 2019 09:41:40 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.029; Sat, 16 Nov 2019
 09:41:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 2/2] iotests: add 269 to check maximum of bitmaps in
 qcow2
Thread-Topic: [PATCH v2 2/2] iotests: add 269 to check maximum of bitmaps in
 qcow2
Thread-Index: AQHVgoW58e4TWXzHz0Wfj9uBdN7ACqdrZsOAgCJYRoA=
Date: Sat, 16 Nov 2019 09:41:39 +0000
Message-ID: <7eba6b5d-529d-c7ac-edfc-547361ef0123@virtuozzo.com>
References: <20191014115126.15360-1-vsementsov@virtuozzo.com>
 <20191014115126.15360-3-vsementsov@virtuozzo.com>
 <7c9e6d62-fc5e-204e-778d-0320833e9b00@redhat.com>
In-Reply-To: <7c9e6d62-fc5e-204e-778d-0320833e9b00@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0019.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::29)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191116124137907
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd9b2cc4-576f-4b53-ea0b-08d76a792e5c
x-ms-traffictypediagnostic: AM6PR08MB3702:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB3702F0F980FC3BFB863537F0C1730@AM6PR08MB3702.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02234DBFF6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(396003)(346002)(366004)(376002)(136003)(199004)(189003)(316002)(110136005)(53546011)(76176011)(386003)(5660300002)(66446008)(52116002)(99286004)(478600001)(25786009)(6506007)(102836004)(66946007)(476003)(11346002)(446003)(486006)(66476007)(86362001)(31686004)(64756008)(66556008)(2501003)(54906003)(186003)(14454004)(6116002)(6246003)(8676002)(31696002)(26005)(2616005)(8936002)(4326008)(107886003)(3846002)(81156014)(2906002)(71190400001)(256004)(6512007)(229853002)(36756003)(6436002)(6486002)(71200400001)(66066001)(81166006)(7736002)(305945005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3702;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VPQGVSCAdrEQr4sBpr2ESmVxDRJ95D+O2EkBTr/UjnVswf4FnPrGwmWZKkn4aHR1rkvgquMWWScvTQP4ta9QCSEQZx4Yhws/cF9r4FgYAKcKYM6s1HgUfrbYXZ3UmEmAX1oTaOqyxOqCjDx3JaL2LTVg3UkbXqe4t/6SIeUc2xiXUo/UFvA2Qfc7AgWe+OcNlHtMTnFdVJugL8/g2+wt0vaSEErMAzt0cC6fqAlPIW+H7OmqyVfjuGESjrW0LPjZmKtz0l3CWNxgScbXoxogdWjdo0K11sGnH125ivXQ6XQhNDJAYq+wyi+pSnj6PO9yE7PUmuFj1HV44/EncFCrfMx6M4q2iAiBWXiu3enMoiD2Ah8hIMsuzjs2CTuGlbIr5IZB1jreXCRCIYsChyjxsxQ+TWrm/qLsOHjd27iRJ/xCjaM7kV7l/9a/PBm4p6O/
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA6C2AED04D572418B77E5D0D86C0107@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9b2cc4-576f-4b53-ea0b-08d76a792e5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2019 09:41:39.9451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6yrBsmGtGwSIrwsc9iEozjSta3IQl7wRWu5ZhH0mJFJZ+QjSKIgEAR3C8kwdD6dgWXi3aa3i2M2XWs1/NG2XKxoED6LVJZUMMH8k/M3u6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3702
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.128
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
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjUuMTAuMjAxOSAxNjoxMiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxNC4xMC4xOSAxMzo1MSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IENoZWNrIHRoYXQgaXQncyBp
bXBvc3NpYmxlIHRvIGNyZWF0ZSBtb3JlIHBlcnNpc3RlbnQgYml0bWFwcyB0aGFuIHFjb3cyDQo+
PiBzdXBwb3J0cy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dp
ZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+ICAgdGVzdHMvcWVt
dS1pb3Rlc3RzLzI2OSAgICAgfCA0NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjY5Lm91dCB8ICAzICsrKw0KPj4gICB0ZXN0
cy9xZW11LWlvdGVzdHMvZ3JvdXAgICB8ICAxICsNCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCA1MSBp
bnNlcnRpb25zKCspDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0cy9xZW11LWlvdGVzdHMv
MjY5DQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xZW11LWlvdGVzdHMvMjY5Lm91dA0K
PiANCj4gSXMgdGhlcmUgbm8gd2F5IHRvIG1ha2UgdGhpcyB0ZXN0IGFueSBmYXN0ZXIsIGUuZy4g
YnkgY3JlYXRpbmcgbGlrZQ0KPiA2NTUzNCBiaXRtYXBzIHdpdGggZGQgYW5kIGEgYmluYXJ5IGJs
b2I/ICAoU2ltaWxhcmx5IHRvIHdoYXQgSSBkbyBpbg0KPiDigJxpb3Rlc3RzOiBUZXN0IHFjb3cy
J3Mgc25hcHNob3QgdGFibGUgaGFuZGxpbmfigJ0pDQoNClNlZW1zLCB0aGF0J3Mgbm90IHNpbXBs
ZS4uIEVhY2ggYml0bWFwIHNob3VsZCBoYXZlIHBlcnNvbmFsIG5hbWUgYW5kDQpiaXRtYXAgdGFi
bGUuLg0KDQpMZXQncyBtZXJnZSBvbmx5IHBhdGNoIDAxIGFuZCBmb3JnZXQgYWJvdXQgdGhpcyBv
bmUuDQoNCj4gDQo+IFRoaXMgaXMgc3VjaCBhbiBlZGdlIGNhc2UsIGJ1dCBydW5uaW5nIHRoZSB0
ZXN0IHRvb2sgMzo0NiBtaW4gYmVmb3JlDQo+IHBhdGNoIDEgKHdoaWNoIEkgYWxyZWFkeSBmaW5k
IG11Y2ggdG9vIGxvbmcpLCBhbmQgODoxMyBtaW4gYWZ0ZXJ3YXJkcw0KPiAob24gbXkgbWFjaGlu
ZSkuDQo+IA0KPiAoVG8gYmUgaG9uZXN0LCBpZiB3ZSB0YWtlIHRoaXMgdGVzdCBhcy1pcywgSeKA
mW0gcHJvYmFibHkganVzdCBuZXZlciBnb2luZw0KPiB0byBydW4gaXQuKQ0KPiANCj4gTWF4DQo+
IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

