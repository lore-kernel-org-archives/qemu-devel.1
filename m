Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5897CC33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277612077C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LV2D+vNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277612077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itSaf-00056o-8T
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 03:39:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itSZp-0004Wt-OJ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:38:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itSZl-0004gu-0Q
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:38:28 -0500
Received: from mail-eopbgr140091.outbound.protection.outlook.com
 ([40.107.14.91]:62696 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itSZk-0004fD-B4; Mon, 20 Jan 2020 03:38:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KF0T3Ludibe1OvfRbOJKEHUdVcujK4gOiROMV1RprLNgLmP3jYvcNHXE9lgMPK4/CvGMfHkSgGAUZuswv948mzBVcZ6BL3IzI476bAfANcQuC8aguZnVB8yqZsSBkcOz6Z+4CY7VVjMOns8SPzQLZ9CEyfWxscTOyPpjoSml/yAVdhnbdirTBPYVMRhLbrAChf9TmsZRc0/ImIOFvxJHtbapQN9dEcuLIPXYFadPM5aXs3cQNIC/R+a2o/019h1loZqyXPsXfXclTkMj8NevrXHZtuGzWpmbuZYKWJod5RBdLzBqhxlsklSmoVbqsqHjGaHP6qfdo3nzYTn2ssNgRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=varKcLEDHAIEBAJPBevhJEauekIxG2TzXEYwcu5Ijbw=;
 b=F2G8/6ve3Wuzg/bO6/Qq81qwLOlxFBamjX4pf0eZbcDMbCqIAZVvNMoKdty+T21yiYsDrVMRReia/S1wB3N0x3LKuUp4plHOD+0ZN5e7l99T6pMtY3In77AG9ZfxgeZYXzkN4EbMIZZI+AlUrRLel8nf0wplKGYwvkiHgvImhJA6Gib4SHgCaQLnsiqH6LzLSior12yR9HWX5E/U5J41aEuB5mOxZsorFfrre25H46YfwEEJbTpmSm3BIYv2UJ2Db8IChTVzI7S2TfAnCT23X05MX9gQG8MwMzAS3358aZapdIKI42zHGOBDJ51VX4dc3gXTnxFaCxhT6qtXMvQTWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=varKcLEDHAIEBAJPBevhJEauekIxG2TzXEYwcu5Ijbw=;
 b=LV2D+vNFxDxANZouQEue2rjSzDhl1vetV5zK7ejEYwTzcAaW8sES2CfccREK6/oygkRZWZQli2/oVbMmaGrvDHi8Pe0CdqCf1hUOUDaDcBLVD8yP2Hifps5GVNuD9cbS+sMcLoiBe9rKw/4Dh+wEXSkF9enhQm/5Y70bPAPve+I=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3815.eurprd08.prod.outlook.com (20.178.90.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Mon, 20 Jan 2020 08:38:19 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 08:38:19 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR02CA0099.eurprd02.prod.outlook.com (2603:10a6:7:29::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Mon, 20 Jan 2020 08:38:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "pannengyuan@huawei.com" <pannengyuan@huawei.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Subject: Re: [PATCH] backup-top: fix a memory leak in bdrv_backup_top_append()
Thread-Topic: [PATCH] backup-top: fix a memory leak in bdrv_backup_top_append()
Thread-Index: AQHVz2Y6yqM6PNKLO0qyVKqVA4uxw6fzOx4A
Date: Mon, 20 Jan 2020 08:38:19 +0000
Message-ID: <74dad363-83df-9cc0-2b3f-58ed2f23f730@virtuozzo.com>
References: <20200120074725.22948-1-pannengyuan@huawei.com>
In-Reply-To: <20200120074725.22948-1-pannengyuan@huawei.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0099.eurprd02.prod.outlook.com
 (2603:10a6:7:29::28) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200120113816203
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fe31d9e-6bf9-43c6-5dc8-08d79d8419b4
x-ms-traffictypediagnostic: AM6PR08MB3815:
x-microsoft-antispam-prvs: <AM6PR08MB3815F54ED09C678DDC588F89C1320@AM6PR08MB3815.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(366004)(136003)(39840400004)(396003)(189003)(199004)(2616005)(956004)(2906002)(478600001)(4326008)(31686004)(186003)(36756003)(8676002)(16526019)(966005)(54906003)(81156014)(81166006)(16576012)(110136005)(52116002)(71200400001)(26005)(316002)(5660300002)(8936002)(66476007)(64756008)(66556008)(66446008)(66946007)(86362001)(6486002)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3815;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M6C8hsqJD5vU19vdJg764aqxVPJpsJ1bT2eb4L6URAJvPl8asDI9DxaYn/0OXzauVD/tS0R9FQ+v/Pmkcav1i+v3qiZdOdnBZpy6/b1bkoqxsdAQ63as8UalsYemQv4JbYvKKEK1keGtmU0lGrjFnNW6y0XPDEHunGa5cZk8lQ65OEJO8tCOD8+5sm1lhs9MW+cDG5Gk5o7SUepLUWoV1nXberLy1wFcQ+L8vYXh6F+Nh+3q7GaXRJrlE+GyAfq485A+DvCvP3yCyPezWreQRo5LS6+tubmT12vsGW1N8jUbPwg8Qs+ZDqKPFEljH3DnNr1VDnJyyXn9/MjX02XWKPeE7D+t5KEEOzN6WJz2kHMGZnsyHIshEHDwnSaUkdC/XFG0bHlEW9WHrRIXJWzRa9J2oKPt1vFbKiqAOd7gnmbteF7tdsRc+9H5R3mimDQahFm14G9MXa2J6fv6HWQJLj/XweEnm8YLwtl+Z6VPC9jzdjWyTQwj9Oh2GRzBrImflD3shZZijBSH5xe149dmAg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D2713844FA836428F953611C6805B70@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe31d9e-6bf9-43c6-5dc8-08d79d8419b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 08:38:19.0378 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PgxREPkBXiK1NypIdl3sQ0DThQDQP1/yM7SdCdpBHh4/7qL+pzxnBEgim7j+Cr/6y4bvLgvm68u24uq7AY0Cgze4aVSeiIk1Lu5q0H6c5M8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3815
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.91
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "zhang.zhanghailiang@huawei.com" <zhang.zhanghailiang@huawei.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGFuIQ0KDQpCZXR0ZXIgaXMgdG8gZHJvcCBleHRyYSBhbGxvY2F0aW9uLiBDb3JyZWN0IHBh
dGNoIGFscmVhZHkgcG9zdGVkIGhlcmU6DQpodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9o
dG1sL3FlbXUtZGV2ZWwvMjAxOS0xMi9tc2cwNTA2Ny5odG1sDQoNCjIwLjAxLjIwMjAgMTA6NDcs
IHBhbm5lbmd5dWFuQGh1YXdlaS5jb20gd3JvdGU6DQo+IEZyb206IFBhbiBOZW5neXVhbiA8cGFu
bmVuZ3l1YW5AaHVhd2VpLmNvbT4NCj4gDQo+IHRvcC0+b3BhcXVlIGlzIGFsZWFyZHkgbWFsbG9j
ZWQgaW4gYmRydl9uZXdfb3Blbl9kcml2ZXIoKSwgYW5kIHRoZW4gY2hhbmdlDQo+IHRoZSBwb2lu
dGVyIGJ1dCB3aXRob3V0IGZyZWVpbmcgaXQuIEl0IHdpbGwgY2F1c2UgYSBtZW1vcnkgbGVhaywg
dGhlIGxlYWsNCj4gc3RhY2sgaXMgYXMgZm9sbG93Og0KPiANCj4gRGlyZWN0IGxlYWsgb2YgMjQg
Ynl0ZShzKSBpbiAxIG9iamVjdChzKSBhbGxvY2F0ZWQgZnJvbToNCj4gICAgIzAgMHg3ZmY2Zjdi
ZTQ5NzAgKC9saWI2NC9saWJhc2FuLnNvLjUrMHhlZjk3MCkgID8/Oj8NCj4gICAgIzEgMHg3ZmY2
ZjcyMzg0OWQgKC9saWI2NC9saWJnbGliLTIuMC5zby4wKzB4NTI0OWQpICA/Pzo/DQo+ICAgICMy
IDB4NTY0YzBkNDRjYWFlICguL3g4Nl82NC1zb2Z0bW11L3FlbXUtc3lzdGVtLXg4Nl82NCsweDNi
NDBhYWUpICAvbW50L3NkYi9xZW11L2Jsb2NrLmM6MTI4OQ0KPiAgICAjMyAweDU2NGMwZDQ0ZGJh
ZiAoLi94ODZfNjQtc29mdG1tdS9xZW11LXN5c3RlbS14ODZfNjQrMHgzYjQxYmFmKSAgL21udC9z
ZGIvcWVtdS9ibG9jay5jOjEzNTkNCj4gICAgIzQgMHg1NjRjMGQ3MTYxOGYgKC4veDg2XzY0LXNv
ZnRtbXUvcWVtdS1zeXN0ZW0teDg2XzY0KzB4M2UwYTE4ZikgIC9tbnQvc2RiL3FlbXUvYmxvY2sv
YmFja3VwLXRvcC5jOjE5MA0KPiAgICAjNSAweDU2NGMwZDcwMDFiZSAoLi94ODZfNjQtc29mdG1t
dS9xZW11LXN5c3RlbS14ODZfNjQrMHgzZGY0MWJlKSAgL21udC9zZGIvcWVtdS9ibG9jay9iYWNr
dXAuYzo0MzkNCj4gICAgIzYgMHg1NjRjMGM4ZWJlZjggKC4veDg2XzY0LXNvZnRtbXUvcWVtdS1z
eXN0ZW0teDg2XzY0KzB4MmZkZmVmOCkgIC9tbnQvc2RiL3FlbXUvYmxvY2tkZXYuYzozNTgwDQo+
ICAgICM3IDB4NTY0YzBjOGVkMGNiICguL3g4Nl82NC1zb2Z0bW11L3FlbXUtc3lzdGVtLXg4Nl82
NCsweDJmZTEwY2IpICAvbW50L3NkYi9xZW11L2Jsb2NrZGV2LmM6MzY5MA0KPiAgICAjOCAweDU2
NGMwYzhlZDE3NyAoLi94ODZfNjQtc29mdG1tdS9xZW11LXN5c3RlbS14ODZfNjQrMHgyZmUxMTc3
KSAgL21udC9zZGIvcWVtdS9ibG9ja2Rldi5jOjM3MDQNCj4gICAgIzkgMHg1NjRjMGQzMTYzODgg
KC4veDg2XzY0LXNvZnRtbXUvcWVtdS1zeXN0ZW0teDg2XzY0KzB4M2EwYTM4OCkgIC9tbnQvc2Ri
L3FlbXUvYnVpbGQvcWFwaS9xYXBpLWNvbW1hbmRzLWJsb2NrLWNvcmUuYzo0MzkNCj4gICAgIzEw
IDB4NTY0YzBkN2ZmN2ZhICguL3g4Nl82NC1zb2Z0bW11L3FlbXUtc3lzdGVtLXg4Nl82NCsweDNl
ZjM3ZmEpICAvbW50L3NkYi9xZW11L3FhcGkvcW1wLWRpc3BhdGNoLmM6MTMyDQo+ICAgICMxMSAw
eDU2NGMwZDdmZmNiOCAoLi94ODZfNjQtc29mdG1tdS9xZW11LXN5c3RlbS14ODZfNjQrMHgzZWYz
Y2I4KSAgL21udC9zZGIvcWVtdS9xYXBpL3FtcC1kaXNwYXRjaC5jOjE3NSAoZGlzY3JpbWluYXRv
ciA0KQ0KPiAgICAjMTIgMHg1NjRjMGQyNzA0ZWYgKC4veDg2XzY0LXNvZnRtbXUvcWVtdS1zeXN0
ZW0teDg2XzY0KzB4Mzk2NDRlZikgIC9tbnQvc2RiL3FlbXUvbW9uaXRvci9xbXAuYzoxNDUNCj4g
ICAgIzEzIDB4NTY0YzBkMjcxMmRlICguL3g4Nl82NC1zb2Z0bW11L3FlbXUtc3lzdGVtLXg4Nl82
NCsweDM5NjUyZGUpICAvbW50L3NkYi9xZW11L21vbml0b3IvcW1wLmM6MjM0IChkaXNjcmltaW5h
dG9yIDQpDQo+IA0KPiBSZXBvcnRlZC1ieTogRXVsZXIgUm9ib3QgPGV1bGVyLnJvYm90QGh1YXdl
aS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFBhbiBOZW5neXVhbiA8cGFubmVuZ3l1YW5AaHVhd2Vp
LmNvbT4NCj4gLS0tDQo+ICAgYmxvY2svYmFja3VwLXRvcC5jIHwgMSArDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svYmFja3VwLXRv
cC5jIGIvYmxvY2svYmFja3VwLXRvcC5jDQo+IGluZGV4IDgxOGQzZjI2YjQuLmQ1NjVmMDU1MjAg
MTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL2JhY2t1cC10b3AuYw0KPiArKysgYi9ibG9jay9iYWNrdXAt
dG9wLmMNCj4gQEAgLTE5Niw2ICsxOTYsNyBAQCBCbG9ja0RyaXZlclN0YXRlICpiZHJ2X2JhY2t1
cF90b3BfYXBwZW5kKEJsb2NrRHJpdmVyU3RhdGUgKnNvdXJjZSwNCj4gICAgICAgfQ0KPiAgIA0K
PiAgICAgICB0b3AtPnRvdGFsX3NlY3RvcnMgPSBzb3VyY2UtPnRvdGFsX3NlY3RvcnM7DQo+ICsg
ICAgZ19mcmVlKHRvcC0+b3BhcXVlKTsNCj4gICAgICAgdG9wLT5vcGFxdWUgPSBzdGF0ZSA9IGdf
bmV3MChCRFJWQmFja3VwVG9wU3RhdGUsIDEpOw0KPiAgIA0KPiAgICAgICBiZHJ2X3JlZih0YXJn
ZXQpOw0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

