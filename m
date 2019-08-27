Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713DCC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 13:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A0F2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 13:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qXiyb80t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A0F2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2buK-0001Bc-6s
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 09:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i2btC-0000eF-35
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i2btB-0004Qp-7C
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:52:02 -0400
Received: from mail-eopbgr00096.outbound.protection.outlook.com
 ([40.107.0.96]:42661 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i2bt5-00047a-Rv; Tue, 27 Aug 2019 09:51:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8W48vdje1totcyeLm6BJEBu4OgCGlOk78sHciYhtLClx6RV+iAsju15Ttbgh5E2kk7nJNbCZZskU3QRK30AW/5CFDHx6ja9qGu8JnN2GUs29gj7J9a2pbxv+KjQwwv3FkVp3Drr7aMT9vSvAaEB+Ax9A0Eg0xt//w+uqWyHOcXPIxzNLN6HRP1f/yMKwvncMmpCKpt4nl2W/AWDC+QRImtxvu8jEjw17zEBfQJPScNa2BIIbjbd2gu8bKCfg+ziyHCb9dyZPbvk9oQsDNAH0nu6DuFQblIbum2+aZ89FDEtWnISxC5Kvc6oQSB6BlSGEclHuemnQqBlqHgB1YTD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rNiLQuGFqFIeUhyZ8bjbWRxbweVk43c2Sjj5ns268k=;
 b=JTg2U5xkq2QF7cX6qifkcvj2m3+iBP7wzTKK4Ev/qfZ2vThSwXNhAXObRuIUYzjViQtqOQ77kspSPNrLwlRpHYAJXBNWGL5hIdmhT4pdEZ9m7jV24QkxCjHxoTr34oTVABCuJDE5VFCkGETJbw5W1iT6JSSF8IfSSqisSJbFQtH9vtn6uBCY+9VNUCnisGABRXhw1eZLiKnbHQ/Zk6P57wYue9HPqqLYYLSH2HDJHCcC3vU9OwDRmA8CZ0S85PE0cZrE04EmWNB0SebyqsS6qMOmsh0VCUasTKMrQVTUKuAZLf8HuqVoFw6lyQ3/xdXzQODUoxwrgC+phOmtzzpQuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rNiLQuGFqFIeUhyZ8bjbWRxbweVk43c2Sjj5ns268k=;
 b=qXiyb80tzZPA8KZBN2sDg2ozHXFhEh0vAfEdAl0e3fNiaWNuSbs3iI1xufEj8zUfFlpWNCk38ekkKQQSrjx5Hrb/d3274Vgq1yieo5RCWWLJznmwq1+f69icXRUckzY5+IDDHg67bArRrAaUg48T6OSr80B+d17Mh+gZ6SjwppU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5499.eurprd08.prod.outlook.com (10.255.185.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Tue, 27 Aug 2019 13:51:52 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 13:51:52 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 1/2] nbd: Use g_autofree in a few places
Thread-Index: AQHVWqFSSlyQxR7qhUmTw5Bcg87k7acPB+KA
Date: Tue, 27 Aug 2019 13:51:52 +0000
Message-ID: <06cd3ce7-f906-3f50-9729-961bbe7da6b4@virtuozzo.com>
References: <20190824172813.29720-1-eblake@redhat.com>
 <20190824172813.29720-2-eblake@redhat.com>
In-Reply-To: <20190824172813.29720-2-eblake@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0055.eurprd09.prod.outlook.com
 (2603:10a6:7:15::44) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190827165149771
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a616d6d3-b275-4c8c-f350-08d72af5b6f4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5499; 
x-ms-traffictypediagnostic: DB8PR08MB5499:
x-microsoft-antispam-prvs: <DB8PR08MB54996891E4F62CFC3E7F5FB3C1A00@DB8PR08MB5499.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(396003)(39840400004)(136003)(376002)(199004)(189003)(53936002)(54906003)(110136005)(76176011)(52116002)(86362001)(14454004)(36756003)(6506007)(6436002)(4326008)(6512007)(25786009)(316002)(66946007)(64756008)(6116002)(3846002)(66476007)(66446008)(66556008)(99286004)(478600001)(305945005)(2906002)(6246003)(2616005)(71190400001)(102836004)(229853002)(26005)(476003)(186003)(486006)(7736002)(4744005)(11346002)(256004)(81156014)(31686004)(6486002)(5660300002)(2501003)(81166006)(386003)(8936002)(8676002)(31696002)(71200400001)(446003)(66066001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5499;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GocDZyCSLsa0KMb54TvzOvxWXwqxbBRUWWkRm5eQ6jR/3IGkoKBeRzEqvuLoTV90gVLXz6mr6eznwYUXs6KDuaUezgQE/QzaUD/En0ISOTpyB37fX1eLf7EtWGpGcy3YIJ5NF2xWR/N1tx1h3pncqC+EYCS/9boltEf/zGVxDwGFYljhQmGcxJVO7NJqQp5HQwTZ6TdFB1A35KJ5hWn+qbH1q1oWFyl4dn7slwBNQu8xS9U7jrbtUGSzwuq43Aon2W8wB/WEqel+nzqluxgg2YLAbJ6HkMLcxZHUQMeKM4abOkP5Gd5G+66rGsbOum8TTuAF4SXeNJ4GlRYsLb5DmVY1VF7R9HsoVrVtfU0jynePbTfac5PrZcnSArr/R1eIgdnhkg5SlTvT7Aoh+/qkYNA3P631CiBoSfB2dKDafKc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <41F8858D5703EE47BA6EEB16630BA249@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a616d6d3-b275-4c8c-f350-08d72af5b6f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 13:51:52.2736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ArHlYZiUiMPXaPzWfDR9yIl0yPbtFH+oioI8gKgxMWa5jZkNg8YhZwbfA1bG5pWTDcXHkSedZsjQ34LhO0R3nN1IAGSW5bQXfwlcJcXqMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5499
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.96
Subject: Re: [Qemu-devel] [PATCH v2 1/2] nbd: Use g_autofree in a few places
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

MjQuMDguMjAxOSAyMDoyOCwgRXJpYyBCbGFrZSB3cm90ZToNCj4gVGhhbmtzIHRvIG91ciByZWNl
bnQgbW92ZSB0byB1c2UgZ2xpYidzIGdfYXV0b2ZyZWUsIEkgY2FuIGpvaW4gdGhlDQo+IGJhbmR3
YWdvbi4gIEdldHRpbmcgcmlkIG9mIGdvdG9zIGlzIGZ1biA7KQ0KPiANCj4gVGhlcmUgYXJlIHBy
b2JhYmx5IG1vcmUgcGxhY2VzIHdoZXJlIHdlIGNvdWxkIHJlZ2lzdGVyIGNsZWFudXANCj4gZnVu
Y3Rpb25zIGFuZCBnZXQgcmlkIG9mIG1vcmUgZ290b3M7IHRoaXMgcGF0Y2gganVzdCBmb2N1c2Vz
IG9uIHRoZQ0KPiBsYWJlbHMgdGhhdCBleGlzdGVkIG1lcmVseSB0byBjYWxsIGdfZnJlZS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPg0KDQpSZXZp
ZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96
em8uY29tPg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

