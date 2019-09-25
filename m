Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1FAC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:20:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 979C821D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YoQe8rOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979C821D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD89M-0003JG-I1
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 10:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD85z-0000wt-1p
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD85y-0007M7-4f
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:16:42 -0400
Received: from mail-eopbgr30096.outbound.protection.outlook.com
 ([40.107.3.96]:22014 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iD85x-0007LN-UQ; Wed, 25 Sep 2019 10:16:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvIXO0oI5HmG/s2T1OevYV0CXgqsLXn3hD/8/hm2w8mM9DRrPJzzX2ITeMcfDDgFRJ9D7a8liqxX4YWWt4khK5nICp7K6U4y40JCimK3cneRYfHr3JSz+6cr2i3lold9PYemLcZUYo7g1a+iilrEY7/KHFiYqyjxd1Y6lQsfdrcWTq29z4EEYaBVqOa8DToeQ1DXlhB12XqwJvgSin6aPVr3AhbkN/9JBwTDvlMuJXUc9iyfBqMGoBd8UnGe7ga2toT8LwjQ8RGK4WG0ojPNG8DZArPbC33B/gdScdbH5KjqFPJcPHA89shPEOniJPVGDJv7KOllfci/ykh1XqnnWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqsRifYTMZ37q7HQw76zdcD7S08M3VcujIBiqhiwobs=;
 b=OIvwrR8osQ/gqT4z4+I5LGqU6YrGiggxa+2xSKw9OnvAM0a9dxBT/McsfUDjCQQCLBpplvqwIi+R/1umDd5jo0gYCo1mdh9Y476n6KxN36UlpwHGILlTS7Ze6fZzF47zrgeIlNnSDt/q5hxIJIpdgOkg1WPf7nLKyhKX4upxa5RvT6zb3lRD5wHliQuEpNAUkY7Q23Zdg0TVPL4cz+4mCqW9rL/wr2P0iL3ZG45YPi71p7678AEvAk7rnlMcWGo7Fg+rqUgvsN2BF+Qpbgm5vfxUf86nciav1e66nrkfMPusJHi5cD/8c9UUdL7+BCuaRwXFgNTzHd1MSPPg2YilsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqsRifYTMZ37q7HQw76zdcD7S08M3VcujIBiqhiwobs=;
 b=YoQe8rOwJ0V/uQr742k/mX+q81Lj8yvcjvyar10HS0Y4WSFPUzNW+qzrgzoMSDKe+zKGCk8qHVm6eql+icS/wXAhCCOPcx5m8jimFCJIW5hhad53Z/jr2u/+F7tF9us4W5cvkqP0D8yt1//SLuQBSl0MDL//sZNohBOui/Fhgjs=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4044.eurprd08.prod.outlook.com (20.179.10.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 25 Sep 2019 14:16:39 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 14:16:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 12/22] block: Remove bdrv_recurse_is_first_non_filter()
Thread-Topic: [PATCH 12/22] block: Remove bdrv_recurse_is_first_non_filter()
Thread-Index: AQHVb8tyzX1dHyv4hEiKIXX+Dtehb6c8eBiA
Date: Wed, 25 Sep 2019 14:16:39 +0000
Message-ID: <76fd85c5-9778-a7b2-eac2-1fc67d32e3ac@virtuozzo.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-13-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-13-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::21) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190925171637304
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4402af57-d988-4872-b81a-08d741c2fb9a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4044; 
x-ms-traffictypediagnostic: DB8PR08MB4044:
x-microsoft-antispam-prvs: <DB8PR08MB4044638C94CDD7CF2219B44DC1870@DB8PR08MB4044.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:480;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(136003)(366004)(376002)(396003)(346002)(199004)(189003)(4326008)(76176011)(558084003)(110136005)(99286004)(486006)(5660300002)(52116002)(386003)(6246003)(86362001)(54906003)(186003)(31696002)(26005)(66066001)(6506007)(6512007)(256004)(36756003)(316002)(102836004)(2906002)(71200400001)(71190400001)(229853002)(66446008)(305945005)(7736002)(66556008)(64756008)(446003)(6116002)(3846002)(14454004)(2501003)(478600001)(11346002)(476003)(6436002)(2616005)(81166006)(31686004)(66476007)(8936002)(81156014)(25786009)(8676002)(6486002)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4044;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GK75mN+gFhv2snuDBJjlYzEGf58SOp7V8dWkR0boUu1fOSRWhfVqUyHezAkv+M6xu9lEn6gmrncBZu2OgiV9B4tQBwsWeU6MuayyozZdw4Fi4wuq9d5B/FEp/h9CrVsQMfO6M9ASrmeOMJ4GnydAsmE0NaadtUELOuVXdavPXBYKmUFNMO+J8Rl20HAnEhkG8BO/95RKzYUdLvetHSi/2LGXrpOE2jgm9tuioOK2OfneHzdJLgVLO3vo2A/dlDHRA4hCZfZTD5r4R+jc3hJfXP+707n1P3+sjk0Sz0nTsR/zv9VKQwdNFdd9nOvLLeK/w3R2YMwbAvIRiZYAzSJeSf9YySx4kjE3uqkohBdP+6ERwqP2KAIWZXNqpRN1A8JFmEDIOP70m/kdNxHqQ/dxAz6xcQuDasecHuEy+SuUvzQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <073773355398C64091BB46F5819352D5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4402af57-d988-4872-b81a-08d741c2fb9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 14:16:39.7887 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MRn46arpkM9ZyF1NXkgeq16nJw0pYmEtkm8L+VlRUIV71f8Qig3aL9n58FPJtB3S2TQG2gjnYQU+bqOexEUi575LtkeOIT0u7i9Um30VDuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4044
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.96
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDkuMjAxOSAxODoyNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBJdCBubyBsb25nZXIgaGFzIGFu
eSB1c2Vycy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5j
b20+DQoNCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1l
bnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXIN
Cg==

