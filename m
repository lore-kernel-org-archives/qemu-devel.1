Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAE9C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 12:40:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD9A20709
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 12:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cudVa6Wj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD9A20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijN14-0006uj-Or
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 07:40:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ijN0L-0006Mk-2X
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 07:40:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ijN0J-0008Ru-Mu
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 07:40:08 -0500
Received: from mail-eopbgr30137.outbound.protection.outlook.com
 ([40.107.3.137]:49479 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ijN0J-0008OH-6T; Mon, 23 Dec 2019 07:40:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRlxu643fUSSmvNtsgRytBP7jLOYnSV3SV0Gt0N5h5WclSEpisZfRlH4VzHHu+Ky2TunLu06xH7RSBWjRZas6vezuXbUzy89BQB4nNmAb/Mjmmz2Z/nQ7udVr+H+y7OZiBg+KOXZneFkhLLDzJ+RBhGxHnGcO3DavG51whVW+RPoGn0NegCPr987Zg/FCpHGlw6RLONQcXQ++0TPlUdhmgIdTOy2D37NeYM2Wd/hRtWgIaIOSNngFfNMkuDsJKxvrvfZZPRf4/p+q83IKAM2XleXkKoq7MidPZEGEwxyEQvjYOnnyubvSQcU8bMhGjUHXGS0cQU/WzIw4fhZ8u92KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DExO67fy7MObtkGR7i4Cur0nuOzKGvygh7dXK66g/ec=;
 b=KRte3/VlsUy+VRE3zwOusEz44puGmgXcZg7QUW94ZOzAnjegPgZdyhgZv3WqzT2qGputNpM/oQONVjzMLmnFqCrIFGJIUPNIGFym+rbjLUFGYyM95IyQkE+58394qjyqdKSESaMb0qWWuNbt7yMaxPVvJfkK4ZMDI5OJjZnHG0pQZ0bawqePa8sJJfKFExJcyBWfaVViJBbHhOHuDMlLsxqU9CICSGaHGdiBAM+EodkHQ5xq/pXF8GWk9dTLkqG4KVn8lhmBQZ2w0I5BMeRUNKwZD3avLVvRmSaGR9bP7d3QRlzybn7kxK2S4RB5BKroCeTPxkTKAYjeWkjL0DqJfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DExO67fy7MObtkGR7i4Cur0nuOzKGvygh7dXK66g/ec=;
 b=cudVa6WjCIa3gh1U9Q9aTV25/9bM0DK0zi+/achUDhhzztBJwsAIFc39fXHEUbBQLhBYKxZCaZlgWd/1OTfcEry2Dv5EPKGOiXHiF+/uAbmPr7gbToTSSchQYCMFYtjg0HLgD2s2gGPlBqyZu+8O/pOaP8QsL2MxmO4YbPbXyYQ=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3941.eurprd08.prod.outlook.com (20.179.2.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.17; Mon, 23 Dec 2019 12:40:00 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 12:40:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eiichi Tsukata <devel@etsukata.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] block/backup: fix memory leak in bdrv_backup_top_append()
Thread-Topic: [PATCH] block/backup: fix memory leak in bdrv_backup_top_append()
Thread-Index: AQHVuXBW/irhOCcf2k6MjWJlBJqVWKfHqUoA
Date: Mon, 23 Dec 2019 12:40:00 +0000
Message-ID: <221aa3d1-9e64-7fc4-e04b-dc6366978c18@virtuozzo.com>
References: <20191223090632.30653-1-devel@etsukata.com>
In-Reply-To: <20191223090632.30653-1-devel@etsukata.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0066.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::34) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191223153958537
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 947420fe-ed1a-4ac4-ad58-08d787a539cb
x-ms-traffictypediagnostic: AM6PR08MB3941:
x-microsoft-antispam-prvs: <AM6PR08MB3941387F644E65B705693218C12E0@AM6PR08MB3941.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0260457E99
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(136003)(396003)(376002)(366004)(346002)(189003)(199004)(66476007)(478600001)(6512007)(64756008)(66556008)(31686004)(66946007)(66446008)(71200400001)(36756003)(8676002)(6486002)(5660300002)(2906002)(86362001)(6506007)(26005)(31696002)(2616005)(316002)(186003)(52116002)(110136005)(81156014)(8936002)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3941;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PRivmUSHtknpWcJ9Dq5xjo0H4m0Tu6gya5TxMobUpQjdvCUSmrUgwg/GPWuYEm0sPSUMXrW1FSE7i+CtJCdWtMQKg+mLLy0Qw+l+h/l3CGrAolQ+6oCsuM5JFkxMdWFxR3orqt5V4QTAW2YS/6ys/p6JnoAXzEVsLeesTZxkpRhrviown0HQ8HVKEBfCeMJbxdxYDHwbmhdKwkdL5qvJ53Aky6+mhREMNhTtA9zdvIKVgyl5OcIMqM5ax1dEmk0JPb1r3BCT2UxAo3ig0Q8NnGSJhEvG/5W3kRWgvE6AbZI7/E/F82jepHQUNczx4SBwDQm+7+0Ib9fLof2SJcFbXip9O9n9WZpamtNbgpRkeQtCz8SzAA59gQE16TBXgi1d+wmeG8tqeY3i6IFYSPSrPr06Qw3g5o64775KZvojbGb19z5Owt8xRizoUKV3z0pQ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9E7AF84D0758A47A5AB5952534F6D96@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947420fe-ed1a-4ac4-ad58-08d787a539cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2019 12:40:00.6436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rtImNykbUj+8vT9V2gCUsf47H3p+6Lk/32JAeDimKudD2QDTJIXzr3y1JW/9Vg1zJjRy8UBKVXZGVDrrsBeuKIr7651Koa0AoTOYbD6V8zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3941
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.137
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

MjMuMTIuMjAxOSAxMjowNiwgRWlpY2hpIFRzdWthdGEgd3JvdGU6DQo+IGJkcnZfb3Blbl9kcml2
ZXIoKSBhbGxvY2F0ZXMgYnMtPm9wYXF1ZSBhY2NvcmRpbmcgdG8gZHJ2LT5pbnN0YW5jZV9zaXpl
Lg0KPiBUaGVyZSBpcyBubyBuZWVkIHRvIGFsbG9jYXRlIGl0IGFuZCBvdmVyd3JpdGUgb3BhcXVl
IGluDQo+IGJkcnZfYmFja3VwX3RvcF9hcHBlbmQoKS4NCj4gDQo+IFJlcHJvZHVjZXI6DQo+IA0K
PiAgICAkIFFURVNUX1FFTVVfQklOQVJZPS4veDg2XzY0LXNvZnRtbXUvcWVtdS1zeXN0ZW0teDg2
XzY0IHZhbGdyaW5kIC1xIC0tbGVhay1jaGVjaz1mdWxsIHRlc3RzL3Rlc3QtcmVwbGljYXRpb24g
LXAgL3JlcGxpY2F0aW9uL3NlY29uZGFyeS9zdGFydA0KPiAgICA9PTI5NzkyPT0gMjQgYnl0ZXMg
aW4gMSBibG9ja3MgYXJlIGRlZmluaXRlbHkgbG9zdCBpbiBsb3NzIHJlY29yZCA1MiBvZiAyMjYN
Cj4gICAgPT0yOTc5Mj09ICAgIGF0IDB4NDgzQUIxQTogY2FsbG9jICh2Z19yZXBsYWNlX21hbGxv
Yy5jOjc2MikNCj4gICAgPT0yOTc5Mj09ICAgIGJ5IDB4NEIwN0NFMDogZ19tYWxsb2MwIChpbiAv
dXNyL2xpYjY0L2xpYmdsaWItMi4wLnNvLjAuNjAwMC43KQ0KPiAgICA9PTI5NzkyPT0gICAgYnkg
MHgxMkJBQjk6IGJkcnZfb3Blbl9kcml2ZXIgKGJsb2NrLmM6MTI4OSkNCj4gICAgPT0yOTc5Mj09
ICAgIGJ5IDB4MTJCRUE5OiBiZHJ2X25ld19vcGVuX2RyaXZlciAoYmxvY2suYzoxMzU5KQ0KPiAg
ICA9PTI5NzkyPT0gICAgYnkgMHgxRDE1Q0I6IGJkcnZfYmFja3VwX3RvcF9hcHBlbmQgKGJhY2t1
cC10b3AuYzoxOTApDQo+ICAgID09Mjk3OTI9PSAgICBieSAweDFDQzExQTogYmFja3VwX2pvYl9j
cmVhdGUgKGJhY2t1cC5jOjQzOSkNCj4gICAgPT0yOTc5Mj09ICAgIGJ5IDB4MUNENTQyOiByZXBs
aWNhdGlvbl9zdGFydCAocmVwbGljYXRpb24uYzo1NDQpDQo+ICAgID09Mjk3OTI9PSAgICBieSAw
eDE0MDFCOTogcmVwbGljYXRpb25fc3RhcnRfYWxsIChyZXBsaWNhdGlvbi5jOjUyKQ0KPiAgICA9
PTI5NzkyPT0gICAgYnkgMHgxMjhCNTA6IHRlc3Rfc2Vjb25kYXJ5X3N0YXJ0ICh0ZXN0LXJlcGxp
Y2F0aW9uLmM6NDI3KQ0KPiAgICAuLi4NCj4gDQo+IEZpeGVzOiA3ZGY3ODY4Yjk2NDAgKCJibG9j
azogaW50cm9kdWNlIGJhY2t1cC10b3AgZmlsdGVyIGRyaXZlciIpDQo+IFNpZ25lZC1vZmYtYnk6
IEVpaWNoaSBUc3VrYXRhIDxkZXZlbEBldHN1a2F0YS5jb20+DQo+IC0tLQ0KPiAgIGJsb2NrL2Jh
Y2t1cC10b3AuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9jay9iYWNrdXAtdG9wLmMgYi9ibG9j
ay9iYWNrdXAtdG9wLmMNCj4gaW5kZXggN2NkYjFmOGViYS4uNjE3MjE3Mzc0ZCAxMDA2NDQNCj4g
LS0tIGEvYmxvY2svYmFja3VwLXRvcC5jDQo+ICsrKyBiL2Jsb2NrL2JhY2t1cC10b3AuYw0KPiBA
QCAtMTk2LDcgKzE5Niw3IEBAIEJsb2NrRHJpdmVyU3RhdGUgKmJkcnZfYmFja3VwX3RvcF9hcHBl
bmQoQmxvY2tEcml2ZXJTdGF0ZSAqc291cmNlLA0KPiAgICAgICB9DQo+ICAgDQo+ICAgICAgIHRv
cC0+dG90YWxfc2VjdG9ycyA9IHNvdXJjZS0+dG90YWxfc2VjdG9yczsNCj4gLSAgICB0b3AtPm9w
YXF1ZSA9IHN0YXRlID0gZ19uZXcwKEJEUlZCYWNrdXBUb3BTdGF0ZSwgMSk7DQo+ICsgICAgc3Rh
dGUgPSB0b3AtPm9wYXF1ZTsNCj4gICANCj4gICAgICAgYmRydl9yZWYodGFyZ2V0KTsNCj4gICAg
ICAgc3RhdGUtPnRhcmdldCA9IGJkcnZfYXR0YWNoX2NoaWxkKHRvcCwgdGFyZ2V0LCAidGFyZ2V0
IiwgJmNoaWxkX2ZpbGUsIGVycnApOw0KPiANCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVu
dHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KSG1tLCBpdCB3YXMg
bm90IG15IGlkZWEsIEkganVzdCBjb3BpZWQgaXQgZnJvbSBtaXJyb3IuLiBBbmQgdGhlcmUgc2hv
dWxkIGJlIHRoZSBzYW1lIGxlYWsuIGFuZA0KbWF5IGJlIGluIG90aGVyIHBsYWNlczoNCg0KIyBn
aXQgZ3JlcCAnb3BhcXVlID0uKmdfbmV3Jw0KYmxvY2svYmFja3VwLXRvcC5jOiAgICB0b3AtPm9w
YXF1ZSA9IHN0YXRlID0gZ19uZXcwKEJEUlZCYWNrdXBUb3BTdGF0ZSwgMSk7DQpibG9jay9maWxl
LXBvc2l4LmM6ICAgIHN0YXRlLT5vcGFxdWUgPSBnX25ldzAoQkRSVlJhd1Jlb3BlblN0YXRlLCAx
KTsNCmJsb2NrL2dsdXN0ZXIuYzogICAgc3RhdGUtPm9wYXF1ZSA9IGdfbmV3MChCRFJWR2x1c3Rl
clJlb3BlblN0YXRlLCAxKTsNCmJsb2NrL2lzY3NpLmM6ICAgIGJzLT5vcGFxdWUgPSBnX25ldzAo
c3RydWN0IElzY3NpTHVuLCAxKTsNCmJsb2NrL21pcnJvci5jOiAgICBic19vcGFxdWUgPSBnX25l
dzAoTWlycm9yQkRTT3BhcXVlLCAxKTsNCmJsb2NrL3Jhdy1mb3JtYXQuYzogICAgcmVvcGVuX3N0
YXRlLT5vcGFxdWUgPSBnX25ldzAoQkRSVlJhd1N0YXRlLCAxKTsNCmJsb2NrL3NoZWVwZG9nLmM6
ICAgIHJlX3MgPSBzdGF0ZS0+b3BhcXVlID0gZ19uZXcwKEJEUlZTaGVlcGRvZ1Jlb3BlblN0YXRl
LCAxKTsNCg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

