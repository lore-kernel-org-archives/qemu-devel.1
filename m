Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2526C433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 16:57:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8858A2086A
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 16:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hRA2zNP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8858A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwUgT-0006gc-Ib
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 12:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54633)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwUg2-0006Cb-6Z
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 12:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwUg1-0002b4-6U
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 12:57:10 -0400
Received: from mail-eopbgr40134.outbound.protection.outlook.com
 ([40.107.4.134]:24963 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hwUg1-0002aT-1R; Sat, 10 Aug 2019 12:57:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYxVJVUk1zQvELjC2UY80kyVfhrS/UPki83r6kcxXrQ3RAFuog4j8WeeRI2rqp2y7YRmulYezMEgN+eaFTmvSDTmAeDlbhSx0T+EU65x2YI33Hn1T1n5ocCjZ8Ac0zlu2Y8WQEMXYFIBV/gB3hR1+FrbQsN0Y72CIOzF+UtOsZ56FMD2OdS681npape4tYaiJhu5Tu9G2BD6MR0zwc5iKobycTkiPZtvXWW6vzDYzoVG8ljUP/UEHsfmGuXSbia6HPW+wSMMB4X8DiCVEb3PuOKy3t/TkzqstKXMY+4nPcz/lRnPBmq1SgmMCMvHAMciWR/yCw5Sw4AdkqErDbgOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bey999XhrDag1hOGyuiHd5dJUDap3mPXXQDH7D+EQnk=;
 b=bkdYlgORvLZvIPNhn10sxvJtoyoSe2Eb7UQuhnrU1FszN/LCeXXKuzy3zY3bSXzfEUWJt5rl3YH4M/EJ3wT1/AJZkfGZ1fvfdrvLFuHrG0/Mkxh4FOuYDD5/gf6JGJDaHzxM+Tt/c2o+QGvthzYl0yKwPEyFEqvyxmshPGR2w5+CXhY93A8w3D16bYwhgk5lAToEyvQGYcohNJ8rApmv6vPihR5MHZwTFNMwqqLhsaqesRKNJPzPEhpN9KXwJTJFhMmewCB/nLagjb5ICGMOzODRibWlNGG7B5LdscEDN8s8XtmnZ1RPZYKfjc0zipob6FTr+q3nZbKt7crOnpKqgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bey999XhrDag1hOGyuiHd5dJUDap3mPXXQDH7D+EQnk=;
 b=hRA2zNP2c6C/970It3wH42VlL3U09NnIwkW8m70A5G9qGvfn0E44YDMpwNdByDd+1hHiTFqtPkhcmrP+CmbYg/wb94ReApjqRUwHDUF132FMOqzJVdgMVBTk01u8l4wh6K8Y2gg7PhsWJOFVyWE3naopqBhmrT/S3qBcVeDy2zI=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5516.eurprd08.prod.outlook.com (10.255.185.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Sat, 10 Aug 2019 16:57:06 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Sat, 10 Aug 2019
 16:57:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 24/42] block: Use child access functions for QAPI
 queries
Thread-Index: AQHVTs2dfzWHjj0hA0iYFm1zZcVCbqb0m6oA
Date: Sat, 10 Aug 2019 16:57:06 +0000
Message-ID: <8e0db688-0e9d-1f8b-e503-82b584470f8d@virtuozzo.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-25-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-25-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::36) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190810195704088
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c89e6b8-58a6-4bc7-ee96-08d71db3c67c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5516; 
x-ms-traffictypediagnostic: DB8PR08MB5516:
x-microsoft-antispam-prvs: <DB8PR08MB55168D5F92162D9C6EC2543BC1D10@DB8PR08MB5516.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 012570D5A0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(39840400004)(376002)(396003)(366004)(199004)(189003)(66066001)(81166006)(2906002)(81156014)(7736002)(256004)(6486002)(71190400001)(71200400001)(6116002)(3846002)(486006)(8676002)(76176011)(31696002)(53936002)(64756008)(66446008)(66556008)(66476007)(66946007)(52116002)(14454004)(6246003)(478600001)(86362001)(25786009)(36756003)(2501003)(31686004)(8936002)(102836004)(5660300002)(386003)(54906003)(110136005)(4326008)(6506007)(186003)(2616005)(446003)(11346002)(305945005)(476003)(229853002)(6512007)(99286004)(6436002)(316002)(26005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5516;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6rJEaKzaEBLONdaDXqXwrMazvWLIfBnAstwlY7fAtvEgghSBLpiaynEBDmEQU9u3wh9NZX3OfKlGbMexKLbKdUYDfUefv0ws8qYs2FWBVJ2WCK+oxsoDb8UfJeLx6tno1q+p9mpMCXLheEhp2mpD4u2+6h0QkqU7HVGjjAu57NGverJcyZA1VD3txF0qpTnh9l44LIjaY9yDz8uP8ZQYSX0oc0KrbjJsKiZUjve4nByq8PMbH2R8WnO7y6uo4TJDUtFU49R4eElGtwrCQE0XydKoHM4Sh4R+SJbeYItrAXMK7W/B1cs5FYQYmIFQsf6159FUN1emm1kDwJMTXozN00EYOYLDHhAmtLh4cdlnr+Zzno82rNheJh1aDsE/SDRQo/T7wzzz5tLvCKzQsCopYr+WyHKay2iRQxivc1AaL1o=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1106A6546949F7448EE927E740DFF983@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c89e6b8-58a6-4bc7-ee96-08d71db3c67c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2019 16:57:06.4453 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V8SDtDUtCdxSg3vta+zzcijURVVYfWFvOkjxL1ymRiRuSsfrnBwbIPiflnhfgPw6021O8sNy4OqtvWPcbb3dIIpbWl7/WyeniGPhRMyPjFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5516
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.134
Subject: Re: [Qemu-devel] [PATCH v6 24/42] block: Use child access functions
 for QAPI queries
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDguMjAxOSAxOToxMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBxdWVyeS1ibG9jaywgcXVlcnkt
bmFtZWQtYmxvY2stbm9kZXMsIGFuZCBxdWVyeS1ibG9ja3N0YXRzIG5vdyByZXR1cm4NCj4gYW55
IGZpbHRlcmVkIGNoaWxkIHVuZGVyICJiYWNraW5nIiwgbm90IGp1c3QgYnMtPmJhY2tpbmcgb3Ig
Q09XDQo+IGNoaWxkcmVuLiAgVGhpcyBpcyBzbyB0aGF0IGZpbHRlcnMgZG8gbm90IGludGVycnVw
dCB0aGUgcmVwb3J0ZWQgYmFja2luZw0KPiBjaGFpbi4gIFRoaXMgY2hhbmdlcyB0aGUgb3V0cHV0
IGZvciBpb3Rlc3QgMTg0LCBhcyB0aGUgdGhyb3R0bGVkIG5vZGUNCj4gbm93IGFwcGVhcnMgYXMg
YSBiYWNraW5nIGNoaWxkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVpdHpA
cmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgYmxvY2svcWFwaS5jICAgICAgICAgICAgICAgfCAzOSAr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiAgIHRlc3RzL3FlbXUtaW90
ZXN0cy8xODQub3V0IHwgIDcgKysrKysrLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0
aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svcWFwaS5j
IGIvYmxvY2svcWFwaS5jDQo+IGluZGV4IDlhMTg1Y2JhNDguLjRmNTlhYzFjMGYgMTAwNjQ0DQo+
IC0tLSBhL2Jsb2NrL3FhcGkuYw0KPiArKysgYi9ibG9jay9xYXBpLmMNCg0KWy4uXQ0KDQo+IEBA
IC0zNTQsOSArMzU3LDkgQEAgc3RhdGljIHZvaWQgYmRydl9xdWVyeV9pbmZvKEJsb2NrQmFja2Vu
ZCAqYmxrLCBCbG9ja0luZm8gKipwX2luZm8sDQo+ICAgICAgIEJsb2NrRHJpdmVyU3RhdGUgKmJz
ID0gYmxrX2JzKGJsayk7DQo+ICAgICAgIGNoYXIgKnFkZXY7DQo+ICAgDQo+IC0gICAgLyogU2tp
cCBhdXRvbWF0aWNhbGx5IGluc2VydGVkIG5vZGVzIHRoYXQgdGhlIHVzZXIgaXNuJ3QgYXdhcmUg
b2YgKi8NCj4gLSAgICB3aGlsZSAoYnMgJiYgYnMtPmRydiAmJiBicy0+aW1wbGljaXQpIHsNCj4g
LSAgICAgICAgYnMgPSBiYWNraW5nX2JzKGJzKTsNCj4gKyAgICBpZiAoYnMpIHsNCj4gKyAgICAg
ICAgLyogU2tpcCBhdXRvbWF0aWNhbGx5IGluc2VydGVkIG5vZGVzIHRoYXQgdGhlIHVzZXIgaXNu
J3QgYXdhcmUgb2YgKi8NCj4gKyAgICAgICAgYnMgPSBiZHJ2X3NraXBfaW1wbGljaXRfZmlsdGVy
cyhicyk7DQo+ICAgICAgIH0NCg0KYmRydl9za2lwX2ltcGxpY2l0X2ZpbHRlcnMgc3VwcG9ydHMg
TlVMTCwgc28gaXQgbWF5IGJlIHdyaXR0ZW4gd2l0aG91dCAiaWYiDQoNCkFueXdheToNClJldmll
d2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6
by5jb20+DQoNClsuLl0NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

