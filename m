Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0421C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 09:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F542465E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 09:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AyItsMeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F542465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiELT-0007jI-Gc
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 04:13:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iiEKl-00076M-H5
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 04:12:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iiEKk-0006C2-C0
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 04:12:31 -0500
Received: from mail-eopbgr20094.outbound.protection.outlook.com
 ([40.107.2.94]:43451 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iiEKg-0005k9-Fg; Fri, 20 Dec 2019 04:12:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMj4EdigZFsuC8fgRJdWlspU8YdS+Xcg+O1wVRraUPCHnCQ6XIr18v8Xv+ohLFK4st8nLJTrjjwQVNRodweJg48N3TQTZx9qpIkHvxJ71VsFq261Lh0RWSwWdS50kG5poxrF2mX1ymd5RY7b6KTql0/Ov+OhW5bkf92gujdZAeKfiBSZGruTYJqiuqUDy/hiLu1P8xCDWUfDqSa/zFchTlyXCznvjzN+XOEwuXlI6wpT5S3V1bN3vDMiGqNrk98cnLAVJyZL8fEr/2uAJs5kO8u7FibGcwYLQYsnRPe+eVbyA6df6QwX0OkR4HI/s2vPNP+YW3/PSmeTtb1MVqXuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWx+UM3X8zWQTzoyEhEJ93VpAEeheHzWrrjFqD0JS6c=;
 b=PxecoQDQaBlhKV0sL6p11UDuJrs0NraOtxK01ekkMcz4S7tbTzuTtoyGI+IboKkGd48TPmrCxfG6lFGOagDZqyKTEMhyuZnrX4+9cwMhWM4+Bn+2Szs7hulP753hvOFzPm7/W8ixISOQHfXtYsRNEMkeEiJHfVSJlYgHEnLjcBfypYr8KZuUgaUbxkmiT7JNXatZfkkdq/r4GjkxNXuwIk6LWVX3t6tK6OOPBwaLtAy+KR+YXq9LFmtPfugJo/ix7UTNVLlnNR9QuR0P2Cub3bKCh6nfWzp8jgHqaCz9FqOR/Z5hFOSru4WsFk0yE/HB2JwjTUrBlspomuqgzRPkNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWx+UM3X8zWQTzoyEhEJ93VpAEeheHzWrrjFqD0JS6c=;
 b=AyItsMeT9vkBUqSkSh9UjQ/CGmjzaU3X2yVxd1DJiDuSH27PaWTUyR8zJJ4Y1osrK3uUjQFaESfK3lodghVQyxqYA0rGSkmzfcJ0CvTy9bzNqCtP5WmELgxqzuLKKn/REkGWJqqGB58OykINIpzJFetKbuGHr9tiaccgnmYFLRY=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4086.eurprd08.prod.outlook.com (20.179.1.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Fri, 20 Dec 2019 09:12:23 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2559.016; Fri, 20 Dec 2019
 09:12:23 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH] backup-top: Begin drain earlier
Thread-Topic: [PATCH] backup-top: Begin drain earlier
Thread-Index: AQHVtpnf1X2/vWCkEUa33h2Tie782KfCvfYA
Date: Fri, 20 Dec 2019 09:12:23 +0000
Message-ID: <aef9dd55-2cc8-565b-c666-e95f75dcf7c9@virtuozzo.com>
References: <20191219182638.104621-1-mreitz@redhat.com>
In-Reply-To: <20191219182638.104621-1-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0178.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::26) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191220121220610
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7c8efaf-07f2-4ce1-23e1-08d7852cb93f
x-ms-traffictypediagnostic: AM6PR08MB4086:
x-microsoft-antispam-prvs: <AM6PR08MB408606E4D18A80770CC4915FC12D0@AM6PR08MB4086.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(39850400004)(366004)(346002)(376002)(199004)(189003)(71200400001)(6486002)(2906002)(5660300002)(186003)(66476007)(26005)(66946007)(6512007)(6506007)(110136005)(66446008)(64756008)(52116002)(66556008)(4326008)(31686004)(36756003)(86362001)(81166006)(8676002)(81156014)(316002)(54906003)(8936002)(31696002)(2616005)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4086;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 24p9ooY+BlGNDpUfc+deUrZORPgWdKI/gkHe3P+/sZ0M4eZKljrSAIH5Jdrm/gIDl+vpvFO/2xHAbsir6zYmo2HI92ovdJHbQlO+MYAX99VJPkEX237B8h9O5HVFl1Ii33rwb3dxy9kjtWT4soScXvKH18NJt2oT6txywKc+KT7xH9GFsQU4i/98K6UP4NWhw2DJ4N62tVOnwrkc1CihHS+dEq23kSpoQ7A29GgWpwv1WRlYAnbEBmtrWajni/8PnfsJmIRMDslamWXygBqRoqMQ2KF+V0wZ3kW42J0WdXwF4G/Ab6TGe9YAsmY8is+YV7yrU5vsi5M48uZ+cSIdi4N1wdvYau0Q7dFGU9admd8FLe5+d/+unNK0AP23u2Ev1F2LVkY+RURpBPBC7unGVCn94YVS539S0mLXCz6nM8lT8i2rvVDSd9g7c+n9rbAQ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A02A3D1F5E2E94894A1ECD47C02287C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c8efaf-07f2-4ce1-23e1-08d7852cb93f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 09:12:23.1001 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a8nNq6j8j8HWHKFLLZYNua27I8k8pEUxGH+vDle4bGhe3GDKt2uPM8502N3+EOnL0Kh5snRRv0O95rC590o11xxLrr1G5T1QOGvjZvW9GxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4086
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.94
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMTIuMjAxOSAyMToyNiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBXaGVuIGRyb3BwaW5nIGJhY2t1
cC10b3AsIHdlIG5lZWQgdG8gZHJhaW4gdGhlIG5vZGUgYmVmb3JlIGZyZWVpbmcgdGhlDQo+IEJs
b2NrQ29weVN0YXRlLiAgT3RoZXJ3aXNlLCByZXF1ZXN0cyBtYXkgc3RpbGwgYmUgaW4gZmxpZ2h0
IGFuZCB0aGVuIHRoZQ0KPiBhc3NlcnRpb24gaW4gc2hyZXNfZGVzdHJveSgpIHdpbGwgZmFpbC4N
Cj4gDQo+IChUaGlzIGJlY29tZXMgdmlzaWJsZSBpbiBpbnRlcm1pdHRlbnQgZmFpbHVyZSBvZiAw
NTYuKQ0KPiANCj4gQ2M6IHFlbXUtc3RhYmxlQG5vbmdudS5vcmcNCj4gU2lnbmVkLW9mZi1ieTog
TWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCg0KR29vZCBjYXRjaA0KDQpSZXZpZXdlZC1i
eTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29t
Pg0KDQo+IC0tLQ0KPiAgIGJsb2NrL2JhY2t1cC10b3AuYyB8IDQgKystLQ0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYmxvY2svYmFja3VwLXRvcC5jIGIvYmxvY2svYmFja3VwLXRvcC5jDQo+IGluZGV4IDdjZGIx
ZjhlYmEuLjgxOGQzZjI2YjQgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL2JhY2t1cC10b3AuYw0KPiAr
KysgYi9ibG9jay9iYWNrdXAtdG9wLmMNCj4gQEAgLTI1NywxMiArMjU3LDEyIEBAIHZvaWQgYmRy
dl9iYWNrdXBfdG9wX2Ryb3AoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQo+ICAgICAgIEJEUlZCYWNr
dXBUb3BTdGF0ZSAqcyA9IGJzLT5vcGFxdWU7DQo+ICAgICAgIEFpb0NvbnRleHQgKmFpb19jb250
ZXh0ID0gYmRydl9nZXRfYWlvX2NvbnRleHQoYnMpOw0KPiAgIA0KPiAtICAgIGJsb2NrX2NvcHlf
c3RhdGVfZnJlZShzLT5iY3MpOw0KPiAtDQo+ICAgICAgIGFpb19jb250ZXh0X2FjcXVpcmUoYWlv
X2NvbnRleHQpOw0KPiAgIA0KPiAgICAgICBiZHJ2X2RyYWluZWRfYmVnaW4oYnMpOw0KPiAgIA0K
PiArICAgIGJsb2NrX2NvcHlfc3RhdGVfZnJlZShzLT5iY3MpOw0KPiArDQo+ICAgICAgIHMtPmFj
dGl2ZSA9IGZhbHNlOw0KPiAgICAgICBiZHJ2X2NoaWxkX3JlZnJlc2hfcGVybXMoYnMsIGJzLT5i
YWNraW5nLCAmZXJyb3JfYWJvcnQpOw0KPiAgICAgICBiZHJ2X3JlcGxhY2Vfbm9kZShicywgYmFj
a2luZ19icyhicyksICZlcnJvcl9hYm9ydCk7DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0K
VmxhZGltaXINCg==

