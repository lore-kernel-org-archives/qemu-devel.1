Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1D2C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 09:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34ED4218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 09:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rvkTR1bz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34ED4218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihVwg-0006fY-Ag
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 04:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihVvt-00067Y-DQ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 04:47:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihVvq-0006Mm-1c
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 04:47:52 -0500
Received: from mail-eopbgr130134.outbound.protection.outlook.com
 ([40.107.13.134]:44919 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ihVvo-0006DW-J4; Wed, 18 Dec 2019 04:47:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5nwlozSsRIilPrh0myKPEDkvqgum1MJUvnNx9/iyeaWNhPZlpTdjlobCOCLETPAM3/eQkpCc9ccg30UNWyJCECrE6DgRg5TQNBZjhA4qLs+Orj6xltSjIy9OBHDSt4hpdHSZ7xpMmj2ImhKPptpYcQEe5yOqwora66WPj7cl6ezyZ5uG2p0HXSuTBhmLcNIKkecj3CssI28MFu/A2JG0cWcebYneYdoTWgwlzg3pQkUISBD6hmeTj1HTK6QCaKfPqcTb7RKV8EwaD64fkp2PTcVaL84qnGaG6nuK8wQK9MCl2sLPxe0YW83ldSAneQi5Jyk+fsTw1V8XgxASQNCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8mCMxbdaNjqK3W20/gHAAprXofbMTRkdq7Ij++zyOM=;
 b=TQT+eEsX1lyZbE0AC7gHctvyitK8JZEdr+BhbQnJlKXoJkWoqvfnGPR5znmaqidh1guckkSOIBg98f7ywN+QulYfdXv1jgWzgHsgmKB6BJkVeYpjtgGhbzas+SPlV57gMmhOqrKNgWSVIUvHNAWHobN06cY5zvcAoJ51ifwLCOtLOrCmrA7zfiKsLbHk4kowafCgkDWLxvtASNv+r4t6eZ9YMFR7n6TpX27Xjr1NiUNGWckk3eAFJtEpT//FjbyeJz1DuSulkTD4oXTkpkvcRW8F7StmKe4+booaOCSg4cLYC8yhoFdyZEJ4BoprYMq36YELUv7yZmMXSsVipulltQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8mCMxbdaNjqK3W20/gHAAprXofbMTRkdq7Ij++zyOM=;
 b=rvkTR1bzJ3OBJB5DnEKc2KmwNudvmBpZCv3M+e1IjZ5MD6UhVH9dQ/QBlneGeS9aKiI3FjYJ5XPHATmrYqB1u0C3hEObjj02zSaz/apaY87RwEEh2X5IFWqTJZRC1YV/Jgu1ysI4VlMSKdrZYKxqn//zVfjZPGqHtpNL8blj5Gs=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 18 Dec 2019 09:47:44 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 09:47:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Tuguoyi <tu.guoyi@h3c.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz
 <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH] qcow2: Move error check of local_err near its assignment
Thread-Topic: [PATCH] qcow2: Move error check of local_err near its assignment
Thread-Index: AdW1Sk9pyaSaCMAlRUyLwKs8KWho0gAPeEGA
Date: Wed, 18 Dec 2019 09:47:44 +0000
Message-ID: <016172ff-08e5-056a-09d8-cd48cb0c3172@virtuozzo.com>
References: <c9d3fc7246ec4c1f9a6cde9ed3c3ae57@h3c.com>
In-Reply-To: <c9d3fc7246ec4c1f9a6cde9ed3c3ae57@h3c.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0027.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::13) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191218124741464
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c4bdf21-0e61-4604-5f28-08d7839f551e
x-ms-traffictypediagnostic: AM6PR08MB5048:
x-microsoft-antispam-prvs: <AM6PR08MB504868DA940E8C5599257BEEC1530@AM6PR08MB5048.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:81;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(136003)(376002)(39850400004)(396003)(199004)(189003)(31696002)(5660300002)(316002)(8936002)(2616005)(4326008)(36756003)(110136005)(86362001)(4744005)(71200400001)(2906002)(66476007)(186003)(26005)(64756008)(478600001)(31686004)(66446008)(66556008)(81156014)(8676002)(52116002)(81166006)(6506007)(6486002)(6512007)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5048;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xr8KcSgmn+GF3ZZKXajcNgvU6Jyl9nOcJ/EM4GbF8aH5pcvacORxzT1qvDuTF0fVcdZi8C+EdScEnUnRBtaCe5ARe/JKp+fliGuczZv1FmrTBwKZvViEVuZAgc/kNNoagbGFmCvJus7siP4td4C78Zn2M49/x2rukglhffjD5oCsiv70KvH/Zs4b2mZ90mKHYtNZSgYBfQPHGyEIxEjUweibXDWA+4UoTUC7NtSn1kVx6rcRUoue/xmjEboDx/5sE0fNyBVlaAK+9U5Qsr9T+puCh4ORYCMEo6veGmOEi6uoACxA5G7D41+eWj7pi3DO5T6LwnF4/W7c4dQDMrAY4ie65Hh49xe7oW9Y5qJ1tg7ThNlDpKb2k/EcFTqJ0erbmaYj0wF8H/EKbqHmE+AnDpts73ZKDMerF2KLWZZ5SqB7kuXD/1GjkInE38tQraxw
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <20FEC947F2D22A4FA0FEADEA15A75395@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4bdf21-0e61-4604-5f28-08d7839f551e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 09:47:44.9086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8IhoZetlCpe7f5Uzgg0y7gNZtUgdyvfJropA2lROWPjMJYtLGZdwcrII5tH4AZhjWOGlhSrjbpQHYArEs6FE1Ab0WjqZ5l1MxcsXSIut1sY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5048
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.134
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTguMTIuMjAxOSA1OjI2LCBUdWd1b3lpIHdyb3RlOg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3Vv
eWkgVHUgPHR1Lmd1b3lpQGgzYy5jb20+DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRz
b3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCj4gLS0tDQo+ICAgYmxv
Y2svcWNvdzIuYyB8IDEwICsrKysrLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL3Fjb3cyLmMg
Yi9ibG9jay9xY293Mi5jDQo+IGluZGV4IDdjMTg3MjEuLmNlM2RiMjkgMTAwNjQ0DQo+IC0tLSBh
L2Jsb2NrL3Fjb3cyLmMNCj4gKysrIGIvYmxvY2svcWNvdzIuYw0KPiBAQCAtMTcwNSwxNCArMTcw
NSwxNCBAQCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBxY293Ml9kb19vcGVuKEJsb2NrRHJpdmVy
U3RhdGUgKmJzLCBRRGljdCAqb3B0aW9ucywNCj4gICAgICAgaWYgKCEoYmRydl9nZXRfZmxhZ3Mo
YnMpICYgQkRSVl9PX0lOQUNUSVZFKSkgew0KPiAgICAgICAgICAgLyogSXQncyBjYXNlIDEsIDIg
b3IgMy4yLiBPciAzLjEgd2hpY2ggaXMgQlVHIGluIG1hbmFnZW1lbnQgbGF5ZXIuICovDQo+ICAg
ICAgICAgICBib29sIGhlYWRlcl91cGRhdGVkID0gcWNvdzJfbG9hZF9kaXJ0eV9iaXRtYXBzKGJz
LCAmbG9jYWxfZXJyKTsNCj4gKyAgICAgICAgaWYgKGxvY2FsX2VyciAhPSBOVUxMKSB7DQo+ICsg
ICAgICAgICAgICBlcnJvcl9wcm9wYWdhdGUoZXJycCwgbG9jYWxfZXJyKTsNCj4gKyAgICAgICAg
ICAgIHJldCA9IC1FSU5WQUw7DQo+ICsgICAgICAgICAgICBnb3RvIGZhaWw7DQo+ICsgICAgICAg
IH0NCj4gICANCj4gICAgICAgICAgIHVwZGF0ZV9oZWFkZXIgPSB1cGRhdGVfaGVhZGVyICYmICFo
ZWFkZXJfdXBkYXRlZDsNCj4gICAgICAgfQ0KPiAtICAgIGlmIChsb2NhbF9lcnIgIT0gTlVMTCkg
ew0KPiAtICAgICAgICBlcnJvcl9wcm9wYWdhdGUoZXJycCwgbG9jYWxfZXJyKTsNCj4gLSAgICAg
ICAgcmV0ID0gLUVJTlZBTDsNCj4gLSAgICAgICAgZ290byBmYWlsOw0KPiAtICAgIH0NCj4gICAN
Cj4gICAgICAgaWYgKHVwZGF0ZV9oZWFkZXIpIHsNCj4gICAgICAgICAgIHJldCA9IHFjb3cyX3Vw
ZGF0ZV9oZWFkZXIoYnMpOw0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

