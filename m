Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022FBC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 18:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE0BF2080F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 18:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bzif/QOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0BF2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icDNq-0002bg-S6
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 13:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icCO9-0000vb-4n
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:55:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icCLj-00063O-Cc
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:52:36 -0500
Received: from mail-eopbgr60098.outbound.protection.outlook.com
 ([40.107.6.98]:40975 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1icCLh-0005hD-HI; Tue, 03 Dec 2019 12:52:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHjjfVM1EjVOoSKegz7Y6561Yfi6OFpLe5xyr7Uh3r0b2q33q1gOxqZ3zPfLTumHuzdwD3IqD9XYhGb+npoIpc97BAy0jFxeUC4gH1Y8qpEXPLZH9WEHAJqSY00p5UJI0IFfZKgKQSy+c/I1q3Wb3XzIAxejfBuF/S5sj8G3bLXs7JYLbt3la0eTgkylS1rZ91kxCKwWEVCUspFKbUA68LfJW2r5QOOB1kt7UPOY7rXhWWengueRCPRYg/fIA9jdIQZEtFF2vhIsPZtWlluTnWW8giVYIEs5ox9oln2T3z9z0nrOTOhg9NcfxDfO0YqtVQM4gf2y+SHQ4h1SRtmY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/Yp89MLDUB8kEKQqFlJhCpYOpgxGfkbwVEg8ttlWww=;
 b=d+Bm8bP1SsQCo7BL/bxhfZnaTSxlGWHL97+Bw6BhzdLVWF3AJxhJk/AXmtMTXFp1brHkBZnpxYW1GdlQiRHXtOr9wJBegGQs6JkBDhD2/RIYMo7zimJazAuvJ2sKWsFN72iWMDpG2llEepEaGw7mVi9a533722hTvI3N21zPNZFuinXxcslcEBznf8IvkiYNsVY/KyGOl1X95QkOiBbjtPByZeSjUJqJpfCcu7+kEVaMEHpphi4dlzuzQoSteTYGYO5BGoIaCKX111iAdglFjAOGo9FXLo0e55GXVnDRaoQk9GmMWMxr5WhhVcmUmMoqP+bvjWck7YORtijDVO3X2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/Yp89MLDUB8kEKQqFlJhCpYOpgxGfkbwVEg8ttlWww=;
 b=bzif/QOdXfcaad3u0NF+JrwpXpfz7edt1vYwqM8kc1Bz9WzhcfQSS4NzEqGWAoAkmmGEeMgIa+OYMYrG8N48Z7P/ylb6AYKnhbUkZngBEd4HHRvBjHCslW1mBpSjdcK9ImSRmSNcVQWedRqOBYxsLiFrFah31YhbTqHqTs5lfcg=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3702.eurprd08.prod.outlook.com (20.178.91.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Tue, 3 Dec 2019 17:52:27 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.003; Tue, 3 Dec 2019
 17:52:27 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "pannengyuan@huawei.com" <pannengyuan@huawei.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "sgarzare@redhat.com"
 <sgarzare@redhat.com>
Subject: for 4.2 ??? Re: [PATCH V3 2/2] block/nbd: fix memory leak in
 nbd_open()
Thread-Topic: for 4.2 ??? Re: [PATCH V3 2/2] block/nbd: fix memory leak in
 nbd_open()
Thread-Index: AQHVpobWec3DVUhPTU6mf/isq8IwT6eot8mA
Date: Tue, 3 Dec 2019 17:52:27 +0000
Message-ID: <1cff97de-303b-3b27-f737-3f69759746b0@virtuozzo.com>
References: <1575012326-51324-1-git-send-email-pannengyuan@huawei.com>
 <1575012326-51324-2-git-send-email-pannengyuan@huawei.com>
In-Reply-To: <1575012326-51324-2-git-send-email-pannengyuan@huawei.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0048.eurprd07.prod.outlook.com
 (2603:10a6:7:66::34) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191203205225519
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32e44ee5-00ea-4e47-33fb-08d778198f69
x-ms-traffictypediagnostic: AM6PR08MB3702:
x-microsoft-antispam-prvs: <AM6PR08MB3702491ADC60921A1C224FFBC1420@AM6PR08MB3702.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(396003)(366004)(39840400004)(346002)(189003)(199004)(76176011)(52116002)(102836004)(4326008)(26005)(99286004)(6506007)(386003)(110136005)(316002)(54906003)(478600001)(5660300002)(66946007)(66446008)(66556008)(6512007)(64756008)(66476007)(6116002)(3846002)(6436002)(6486002)(86362001)(2201001)(256004)(2906002)(31696002)(14454004)(186003)(36756003)(2501003)(7736002)(31686004)(305945005)(7416002)(25786009)(446003)(81166006)(2616005)(71190400001)(8936002)(8676002)(81156014)(71200400001)(11346002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3702;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YK124GY84SWbuCHEHiSo5luJ6bIPrxktYPJlm5HXLaQ7blkc3rjp/70ufV1AE00ugKoRr3Qsf9iiiTfiTdBq7v7rqAboQsaXGTBPcr/Tj++4twiZjlVhZgQOf4k7/ZC+Fl4xCoQaKa9aiitMr8mAgmTYTsw9WFlwEljMm5yw+8QF0oCCb7HQS2WXoGTTanMkXpbQ+hLURLnndQ4ehooa2q2vta/zNGXNm1thMBoufi40m2UFi1UEnupCnXtyjxLVjsELghd5xE0lNx1WImO7Ob/PCdVaarwBuOr24DF/Q3SXKxb9iWrBAGYibAgc2nqceJ4o8xoBUTTmG92HPtrxNbDhpaQ+eLmakwbTjBVBLbCf3/VdhDmIggjnrz6zFO/dVLC4Rj8dKx4vh3tCyrIWLnc3zUCoVpvqSLXvACStUOOLoF8tTilLGIjqVVZa0Mkd
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4D4660761E9ED48AD0230471A39F2F7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e44ee5-00ea-4e47-33fb-08d778198f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 17:52:27.2935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Qo7V7O01oew+J3+nR5gvqnlCRprzyVhUSdznJhrtHIqDCPJO0IZTK9RCCr+Y22kvljddNHhJjjZcTw+5iR+o3QPsGxwAlQzVnEhpaJrxLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3702
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.98
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
Cc: "liyiting@huawei.com" <liyiting@huawei.com>,
 "kuhn.chenqun@huawei.com" <kuhn.chenqun@huawei.com>,
 "zhang.zhanghailiang@huawei.com" <zhang.zhanghailiang@huawei.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SXQncyBqdXN0IGEgbWVtb3J5IGxlYWssIGJ1dCBpdCdzIGEgcmVncmVzc2lvbiBpbiA0LjIuDQoN
ClNob3VsZCB3ZSB0YWtlIGl0IGludG8gNC4yPw0KDQoNCjI5LjExLjIwMTkgMTA6MjUsIHBhbm5l
bmd5dWFuQGh1YXdlaS5jb20gd3JvdGU6DQo+IEZyb206IFBhbk5lbmd5dWFuIDxwYW5uZW5neXVh
bkBodWF3ZWkuY29tPg0KPiANCj4gSW4gY3VycmVudGx5IGltcGxlbWVudGF0aW9uIHRoZXJlIHdp
bGwgYmUgYSBtZW1vcnkgbGVhayB3aGVuDQo+IG5iZF9jbGllbnRfY29ubmVjdCgpIHJldHVybnMg
ZXJyb3Igc3RhdHVzLiBIZXJlIGlzIGFuIGVhc3kgd2F5IHRvDQo+IHJlcHJvZHVjZToNCj4gDQo+
IDEuIHJ1biBxZW11LWlvdGVzdHMgYXMgZm9sbG93IGFuZCBjaGVjayB0aGUgcmVzdWx0IHdpdGgg
YXNhbjoNCj4gICAgICAuL2NoZWNrIC1yYXcgMTQzDQo+IA0KPiBGb2xsb3dpbmcgaXMgdGhlIGFz
YW4gb3V0cHV0IGJhY2t0cmFjazoNCj4gRGlyZWN0IGxlYWsgb2YgNDAgYnl0ZShzKSBpbiAxIG9i
amVjdChzKSBhbGxvY2F0ZWQgZnJvbToNCj4gICAgICAjMCAweDdmNjI5Njg4YTU2MCBpbiBjYWxs
b2MgKC91c3IvbGliNjQvbGliYXNhbi5zby4zKzB4Yzc1NjApDQo+ICAgICAgIzEgMHg3ZjYyOTVl
N2UwMTUgaW4gZ19tYWxsb2MwICAoL3Vzci9saWI2NC9saWJnbGliLTIuMC5zby4wKzB4NTAwMTUp
DQo+ICAgICAgIzIgMHg1NjI4MWRhYjQ2NDIgaW4gcW9iamVjdF9pbnB1dF9zdGFydF9zdHJ1Y3Qg
IC9tbnQvc2RiL3FlbXUtNC4yLjAtcmMwL3FhcGkvcW9iamVjdC1pbnB1dC12aXNpdG9yLmM6Mjk1
DQo+ICAgICAgIzMgMHg1NjI4MWRhYjFhMDQgaW4gdmlzaXRfc3RhcnRfc3RydWN0ICAvbW50L3Nk
Yi9xZW11LTQuMi4wLXJjMC9xYXBpL3FhcGktdmlzaXQtY29yZS5jOjQ5DQo+ICAgICAgIzQgMHg1
NjI4MWRhZDE4MjcgaW4gdmlzaXRfdHlwZV9Tb2NrZXRBZGRyZXNzICBxYXBpL3FhcGktdmlzaXQt
c29ja2V0cy5jOjM4Ng0KPiAgICAgICM1IDB4NTYyODFkYTgwNjJmIGluIG5iZF9jb25maWcgICAv
bW50L3NkYi9xZW11LTQuMi4wLXJjMC9ibG9jay9uYmQuYzoxNzE2DQo+ICAgICAgIzYgMHg1NjI4
MWRhODA2MmYgaW4gbmJkX3Byb2Nlc3Nfb3B0aW9ucyAvbW50L3NkYi9xZW11LTQuMi4wLXJjMC9i
bG9jay9uYmQuYzoxODI5DQo+ICAgICAgIzcgMHg1NjI4MWRhODA2MmYgaW4gbmJkX29wZW4gL21u
dC9zZGIvcWVtdS00LjIuMC1yYzAvYmxvY2svbmJkLmM6MTg3Mw0KPiANCj4gRGlyZWN0IGxlYWsg
b2YgMTUgYnl0ZShzKSBpbiAxIG9iamVjdChzKSBhbGxvY2F0ZWQgZnJvbToNCj4gICAgICAjMCAw
eDdmNjI5Njg4YTNhMCBpbiBtYWxsb2MgKC91c3IvbGliNjQvbGliYXNhbi5zby4zKzB4YzczYTAp
DQo+ICAgICAgIzEgMHg3ZjYyOTVlN2RmYmQgaW4gZ19tYWxsb2MgKC91c3IvbGliNjQvbGliZ2xp
Yi0yLjAuc28uMCsweDRmZmJkKQ0KPiAgICAgICMyIDB4N2Y2Mjk1ZTk2YWNlIGluIGdfc3RyZHVw
ICgvdXNyL2xpYjY0L2xpYmdsaWItMi4wLnNvLjArMHg2OGFjZSkNCj4gICAgICAjMyAweDU2Mjgx
ZGE4MDRhYyBpbiBuYmRfcHJvY2Vzc19vcHRpb25zIC9tbnQvc2RiL3FlbXUtNC4yLjAtcmMwL2Js
b2NrL25iZC5jOjE4MzQNCj4gICAgICAjNCAweDU2MjgxZGE4MDRhYyBpbiBuYmRfb3BlbiAvbW50
L3NkYi9xZW11LTQuMi4wLXJjMC9ibG9jay9uYmQuYzoxODczDQo+IA0KPiBJbmRpcmVjdCBsZWFr
IG9mIDI0IGJ5dGUocykgaW4gMSBvYmplY3QocykgYWxsb2NhdGVkIGZyb206DQo+ICAgICAgIzAg
MHg3ZjYyOTY4OGEzYTAgaW4gbWFsbG9jICgvdXNyL2xpYjY0L2xpYmFzYW4uc28uMysweGM3M2Ew
KQ0KPiAgICAgICMxIDB4N2Y2Mjk1ZTdkZmJkIGluIGdfbWFsbG9jICgvdXNyL2xpYjY0L2xpYmds
aWItMi4wLnNvLjArMHg0ZmZiZCkNCj4gICAgICAjMiAweDdmNjI5NWU5NmFjZSBpbiBnX3N0cmR1
cCAoL3Vzci9saWI2NC9saWJnbGliLTIuMC5zby4wKzB4NjhhY2UpDQo+ICAgICAgIzMgMHg1NjI4
MWRhYjQxYTMgaW4gcW9iamVjdF9pbnB1dF90eXBlX3N0cl9rZXl2YWwgL21udC9zZGIvcWVtdS00
LjIuMC1yYzAvcWFwaS9xb2JqZWN0LWlucHV0LXZpc2l0b3IuYzo1MzYNCj4gICAgICAjNCAweDU2
MjgxZGFiMmVlOSBpbiB2aXNpdF90eXBlX3N0ciAvbW50L3NkYi9xZW11LTQuMi4wLXJjMC9xYXBp
L3FhcGktdmlzaXQtY29yZS5jOjI5Nw0KPiAgICAgICM1IDB4NTYyODFkYWQwZmExIGluIHZpc2l0
X3R5cGVfVW5peFNvY2tldEFkZHJlc3NfbWVtYmVycyBxYXBpL3FhcGktdmlzaXQtc29ja2V0cy5j
OjE0MQ0KPiAgICAgICM2IDB4NTYyODFkYWQxN2I2IGluIHZpc2l0X3R5cGVfU29ja2V0QWRkcmVz
c19tZW1iZXJzIHFhcGkvcWFwaS12aXNpdC1zb2NrZXRzLmM6MzY2DQo+ICAgICAgIzcgMHg1NjI4
MWRhZDE4NmEgaW4gdmlzaXRfdHlwZV9Tb2NrZXRBZGRyZXNzIHFhcGkvcWFwaS12aXNpdC1zb2Nr
ZXRzLmM6MzkzDQo+ICAgICAgIzggMHg1NjI4MWRhODA2MmYgaW4gbmJkX2NvbmZpZyAvbW50L3Nk
Yi9xZW11LTQuMi4wLXJjMC9ibG9jay9uYmQuYzoxNzE2DQo+ICAgICAgIzkgMHg1NjI4MWRhODA2
MmYgaW4gbmJkX3Byb2Nlc3Nfb3B0aW9ucyAvbW50L3NkYi9xZW11LTQuMi4wLXJjMC9ibG9jay9u
YmQuYzoxODI5DQo+ICAgICAgIzEwIDB4NTYyODFkYTgwNjJmIGluIG5iZF9vcGVuIC9tbnQvc2Ri
L3FlbXUtNC4yLjAtcmMwL2Jsb2NrL25iZC5jOjE4NzMNCj4gDQo+IFJlcG9ydGVkLWJ5OiBFdWxl
ciBSb2JvdCA8ZXVsZXIucm9ib3RAaHVhd2VpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUGFuTmVu
Z3l1YW4gPHBhbm5lbmd5dWFuQGh1YXdlaS5jb20+DQoNCk1heSBhZGQ6DQoNCkZpeGVzOiA4ZjA3
MWM5ZGI1MDZlMDNhYg0KDQooSSBmb3VuZCBpdCBqdXN0IGJ5IGdpdCBsb2cgLXAsIGNvdWxkIHlv
dSBwbGVhc2UgY2hlY2sgaXQgYnkgeW91ciByZXByb2R1Y2U/KQ0KDQpPaGgsIHRoYXQncyBteSBj
b21taXQsIEknbSBzb3JyeS4gSWYgeW91IGRpc2NvdmVyZWQgdGhpcyBjb21taXQgYnkgeW91cnNl
bGYsDQphbmQgYWRkZWQgRml4ZXM6IHRhZyBhbmQgbXlzZWxmIHRvIENDLCBJJ2QgaGF2ZSByZXZp
ZXdlZCBpdCBhIGxvdCBlYXJsaWVyLi4NCg0KPiAtLS0NCj4gQ2hhbmdlcyB2MiB0byB2MToNCj4g
LSBhZGQgYSBuZXcgZnVuY3Rpb24gdG8gZG8gdGhlIGNvbW1vbiBjbGVhbnVwcyAoc3VnZ2VzdGVk
IGJ5IFN0ZWZhbm8NCj4gICAgR2FyemFyZWxsYSkuDQo+IC0tLQ0KPiBDaGFuZ2VzIHYzIHRvIHYy
Og0KPiAtIHNwbGl0IGluIHR3byBwYXRjaGVzKHN1Z2dlc3RlZCBieSBTdGVmYW5vIEdhcnphcmVs
bGEpDQo+IC0tLQ0KPiAgIGJsb2NrL25iZC5jIHwgMSArDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svbmJkLmMgYi9ibG9jay9uYmQu
Yw0KPiBpbmRleCA1ODA1OTc5Li4wOWQ2OTI1IDEwMDY0NA0KPiAtLS0gYS9ibG9jay9uYmQuYw0K
PiArKysgYi9ibG9jay9uYmQuYw0KPiBAQCAtMTg4OSw2ICsxODg5LDcgQEAgc3RhdGljIGludCBu
YmRfb3BlbihCbG9ja0RyaXZlclN0YXRlICpicywgUURpY3QgKm9wdGlvbnMsIGludCBmbGFncywN
Cj4gICANCj4gICAgICAgcmV0ID0gbmJkX2NsaWVudF9jb25uZWN0KGJzLCBlcnJwKTsNCj4gICAg
ICAgaWYgKHJldCA8IDApIHsNCj4gKyAgICAgICAgbmJkX2ZyZWVfYmRydnN0YXRlX3Byb3Aocyk7
DQo+ICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiAgICAgICB9DQo+ICAgICAgIC8qIHN1Y2Nlc3Nm
dWxseSBjb25uZWN0ZWQgKi8NCj4gDQoNClRoYW5rcyBmb3IgZml4aW5nIQ0KDQpSZXZpZXdlZC1i
eTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29t
Pg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

