Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FACC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 15:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE7CA20644
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 15:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Dh05mRyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7CA20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyHo8-0004Xc-M5
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 11:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hyHnH-0003lh-8a
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hyHnB-00008g-QR
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:36:02 -0400
Received: from mail-eopbgr00111.outbound.protection.outlook.com
 ([40.107.0.111]:64069 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hyHnB-00008P-8Z; Thu, 15 Aug 2019 11:35:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKv4TrYrhBrGnvmal2WQ2h3KBH7zv+IgjcEcMu2wnSS9cPZLUkyfEtc+Wu4+DS0ZT3ZGkU7zDiPje//6n0SmiJNsU9zMmkbV/ExhzE3LHGe+3r4pzouTYG61imAK3v5wRY3EnNo0hqkio2aC3wF/Y7DoI+aJi+LB4icCtNiRaBdIHbjSi4XkjRSLr4Uv8ckPc4dDVh8GlwDgLgyBT8blVJ+n3ohtFzaRSrse1v4uImy9uQAU7jhtYjqYAkUbQW3JRvN97oSyY8G3FMULwdqJnHrncYX2wtbBFVdQUlZXubeQUvlSx9fwIRxyZMhs4wpWQiMizVi+JrscPHe9UCwP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThxxnQUKnUmszLOp0rcz8q7QcrpOMRrrwjHS29vGV5I=;
 b=LIn2Bu80cWjgNmYyPtGkbHcvt9kheKCCoPqUe3oTs8BuPhRnYyMOp4vVjrNSbDHUHlk6yGszczIqOKKsGnM7yTMYwKpQ5X2vGDc1ztzb20UxlwcQ629XQFCl0HAF5xtzz8wvLke9lUrvFBxcHm1tF/Wrip2wwjTwk9+birvFvcFf2K4Vqwf527eV5QzkaSQ+UFsLPdHMeuS06bfRYeL0IO2MZrkoh78DnYFnELzAi+SL1LgSXuHP7iUSIO/QSjaYdrklmlYCspircZhzW66ZC5+omjbOKv6Ojy+c5uAXL+7PsWb4LZJHx2ITXt6L96aEAdzWuo5VG4abvLXdOtSpjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThxxnQUKnUmszLOp0rcz8q7QcrpOMRrrwjHS29vGV5I=;
 b=Dh05mRyf2ejkyT2QGw+thx48uLzeZ88u7aevXCfH9NjUjoi1dmQT5afkv5CNR2vWhRoYp9iFiA7d/HDeoqQz7qtxhe++JAG4PTVll61LlCJ5+1iCcbauh4bIhxxi+t7l7a63zwNFKrCrbbHevUriG6JgAoXysJwHkXiRZsLA2DI=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5387.eurprd08.prod.outlook.com (52.133.241.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Thu, 15 Aug 2019 15:35:54 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 15:35:54 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 0/4] qcow2: async handling of fragmented io
Thread-Index: AQHVU2J5fEq8y0bXA0+IlUQwrVWabKb8McuAgAAlrIA=
Date: Thu, 15 Aug 2019 15:35:54 +0000
Message-ID: <974c5f8d-fac6-9972-70db-70675a38ae57@virtuozzo.com>
References: <20190815121042.121309-1-vsementsov@virtuozzo.com>
 <86631ca8-2d5b-3e28-91a4-26aec499593f@redhat.com>
In-Reply-To: <86631ca8-2d5b-3e28-91a4-26aec499593f@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0021.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::31) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190815183551780
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c7b6cc1-5e8c-42fb-9b55-08d721964260
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5387; 
x-ms-traffictypediagnostic: DB8PR08MB5387:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB538742F8AB69B138D5E27E30C1AC0@DB8PR08MB5387.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(486006)(6436002)(31686004)(446003)(31696002)(4744005)(11346002)(2501003)(5660300002)(36756003)(316002)(186003)(229853002)(71190400001)(476003)(71200400001)(6486002)(2616005)(66066001)(26005)(8936002)(66446008)(64756008)(8676002)(102836004)(7736002)(256004)(76176011)(52116002)(81166006)(66476007)(305945005)(6506007)(54906003)(81156014)(2906002)(53936002)(25786009)(66946007)(4326008)(6246003)(6116002)(53546011)(478600001)(99286004)(110136005)(86362001)(3846002)(6512007)(14454004)(386003)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5387;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UO8DNCdSACOVpV/Pulnt2O/OZZuIc4dLIfikOnwHcFy6fxBqUElXPPKxIYbyS710RZ2z2AkSUyjNPe7HegDMANUcbHZfDvWTdAjN0DMAKYKQNbMfswG0t9M8tLj4LbV5y9YWHfbtPwYOzGSmpkVKWld6/ztzbbM1Nd0FPk7trMvSTMDT6T3Daym6I0fxRhGdsxq26lJ14VySDE35Nh6jqOkfBY8pt62iKi1Hl1QpAL6UNCP71CIZzoNI+f18fq7Sx532D8ApP+dE4mJ32qckiFZ7Bz8Ezk/wq8dCWIDpjWEOnvnn/gt4PXsFZp1zlpzJfgrGBZpQR5mRRwekm9tUcndu+cSbZl2VUUN9tN0juAl4fTNB2UwoZgA5ey0ywKx0ngRtClttTzMTv0x8IzWpTuvbsBWGGcwjJbshTI4TADI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C96400605ED8241BD23A8AA41E4472A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7b6cc1-5e8c-42fb-9b55-08d721964260
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 15:35:54.0154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mNf5W1MiRNnbB2lIAQyKG6LfFgQwItBG5Htq6S4Hyjm2YK82ng6hZZktBVmHfs1Y+XEcQrJpVHcDMpW1KM8B/LQpvMS8ElEaiZTQ2UsJHYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5387
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.111
Subject: Re: [Qemu-devel] [PATCH v3 0/4] qcow2: async handling of fragmented
 io
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTUuMDguMjAxOSAxNjoyMSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxNS4wOC4xOSAxNDoxMCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDAxOiAtIHVzZSBjb3JvdXRp
bmVfZm4gd2hlcmUgYXBwcm9wcmlhdGUgISEhISEhISEhISEhISEhISEhISEhISENCj4gDQo+IDot
KQ0KPiANCg0KDQpBaGFoYWhhLCBJJ2xsIGV4cGxhaW46DQoNCldoZW4gY29tcGFyaW5nIHYyIHZz
IHYzIGFuZCB3cml0aW5nIHRoaXMgZGlmZmVyZW5jZSBzY3JpcHQgSSBub3RpY2VkDQp0aGF0IEkg
YWRkZWQgY29yb3V0aW5lX2ZuIG1hcmtzIG9ubHkgdG8gLmggYW5kIG5vdCB0byAuYy4gU28gSSBh
ZGRlZA0Kc29tZSBvZiAiISEhIiB0byBub3QgZm9yZWdldCB0byBmaXggaXQuDQoNCg0KLS0gDQpC
ZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

