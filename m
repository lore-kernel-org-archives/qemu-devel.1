Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3620C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 12:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE8E3215EA
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 12:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oPs26WoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8E3215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3J7g-0005As-Ru
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 08:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3J61-000479-Lo
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 08:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3J5z-00015Z-9u
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 08:00:08 -0400
Received: from mail-eopbgr70123.outbound.protection.outlook.com
 ([40.107.7.123]:14659 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i3J5y-00013U-Gx; Thu, 29 Aug 2019 08:00:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTpwigMXbeoUU3v5gG0aAQSZBPgjyv6N2NQxlIp9oz/ky8S8I0CEZ2NABZ8X0BzeXpG94RJodsloeCqWqAjlkQ/ufjNulismexhQ0gsTNJEvCQiXIOX9zWB9+OcUtrqQuq04yP65CysLDITRvh2xMlb6Yuw0JctJlOyG+ygGNkmnJu5fSmZYsPryGbgCq2eSLrV4zg3JKI0fKGgLPgmwLTS6LmSoJH72t8LPSUGr62XayHOzcLesHc3HDBS2XH8xoOSHGUSuL6DcapiqX665kQw81y5Bt4Guq2dguDwwpBbsHXBSfyW0hLPtglG+NM9skjCvBpTLBjZ8t63pcVEj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tX6efzL8b1MM1JSp9g2/8xrG7maoShAgjY8pdQr2aAs=;
 b=limZCUphrzu5TmHsDJ5HU+hoA7o9hZJ2MYoDDrGJ27Os7fBVSsafMklFkLH2KkK/Jk9OyhJjHMMfRnK6fGOGWw+bLH/7XgDkEK1lXyTLkSUsstn3bkaIJuv9vxyohpR35f4kf7RsUtEXlg/5DjJYimLrzJMzcnBALUXZZu+CsMDXtPUqrUa+VOzmpMZhNgIXbPJN+e8cOv7mWqxqpwEDuhyelKSRONqI0I6JNBBCx1wsPNZRq59DsVMeSyBHIwSGEV3CFJaA7ucq8kh1HOyCy+FAW1G8l+5NQlxRX9+95mLrOfI23101FkFSgCtc72E5thT7cXiBDHYxKaYZshM5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tX6efzL8b1MM1JSp9g2/8xrG7maoShAgjY8pdQr2aAs=;
 b=oPs26WoJREJjwknqoucsIMIxhZhZgEzXxSYeB4HIDUbYmKcq9+/rI9MQ/9pI5HEfDHFskd4l61wiVAAfb8y3kWVTOahuZJf1RgVh1VtE/btjOJ3+iLOWvgvuT3X1AZ9g81VIgq6FlHWDn0zLGdPc+N69M3t3d0j64MI3epmfS1U=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5131.eurprd08.prod.outlook.com (10.255.4.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Thu, 29 Aug 2019 12:00:01 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 12:00:01 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v9 05/13] block: move block_copy from block/backup.c to
 separate file
Thread-Index: AQHVXCkyq9dXEHcWlEClY8WobU6z9KcQv5QAgAFKqAA=
Date: Thu, 29 Aug 2019 12:00:01 +0000
Message-ID: <ee0cfaa5-8b3a-2944-71e6-873a3ef8ff25@virtuozzo.com>
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-6-vsementsov@virtuozzo.com>
 <e43a3824-1b1f-98c4-b04e-fba1f4a4c188@redhat.com>
In-Reply-To: <e43a3824-1b1f-98c4-b04e-fba1f4a4c188@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0017.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::27)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190829145958928
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a93df141-720e-458f-6e3b-08d72c786be7
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5131; 
x-ms-traffictypediagnostic: DB8PR08MB5131:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB51319EE78B8B3B5953743A3EC1A20@DB8PR08MB5131.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(346002)(39850400004)(136003)(366004)(376002)(396003)(189003)(199004)(81166006)(25786009)(99286004)(8676002)(81156014)(6512007)(486006)(476003)(54906003)(2616005)(229853002)(446003)(11346002)(316002)(66946007)(7736002)(110136005)(305945005)(107886003)(53936002)(66476007)(256004)(53546011)(4326008)(64756008)(66446008)(6486002)(386003)(6506007)(2501003)(76176011)(3846002)(6116002)(5660300002)(31696002)(4744005)(36756003)(186003)(66556008)(6246003)(6436002)(7416002)(8936002)(2906002)(86362001)(71190400001)(71200400001)(102836004)(66066001)(14454004)(26005)(478600001)(52116002)(31686004)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5131;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0hjASM6Rosh7Bn0Mmx1aX77z8sRdW8MyvjdK9RwwQ2Vr0YOWS/IYpHdixYm1kBmgxsIJyMkc013Igt/EoJ1uAYaY35yPZxX2dd4U8xN18l3aAq7a6SO2VpcCjn7pBXTFpFx0CTGyntA4sZO1rChpNSGW6Xvbf1V5qo93vVp9qfobx/P913qVRQwlYIdDybY/FgKSOAZPXogLKXne7h8KGJJPH/GwUXQKIqVikZ2814FR6VrwE5fPvSs/TTR6JzMl6xllqNhVsFvBApYpPt3m3ZiETGhYDI0O86RB/4JUZ2NKnBEHXCBngChhYdkn9Zd4EXdwIxXonKWUyMjduRooExe7xmSqLwIgSSSRij/uudtzEniiVfpRsfYVmNOp03DDCSVS40EFHdpFSJ5Sul/ULoaeQ+7Owhe/Mdx/IML76RM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3A433FB2140D543A6336279F7FA7F2F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93df141-720e-458f-6e3b-08d72c786be7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 12:00:01.6011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: igGX2XNeJ+JkpEkMoBfCLPzFmv+ebfd6tIUY5J3BRFZGT5vFHSlRmdKKdnBrGMG5DTWHWpJLS7dGjeBYAL+9kTx7vKeoYwB+zWuzi0mFuyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5131
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.123
Subject: Re: [Qemu-devel] [PATCH v9 05/13] block: move block_copy from
 block/backup.c to separate file
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjguMDguMjAxOSAxOToxNiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyNi4wOC4xOSAxODoxMywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IFNwbGl0IGJsb2NrX2NvcHkg
dG8gc2VwYXJhdGUgZmlsZSwgdG8gYmUgY2xlYW5seSBzaGFyZWQgd2l0aCBiYWNrdXAtdG9wDQo+
PiBmaWx0ZXIgZHJpdmVyIGluIGZ1cnRoZXIgY29tbWl0cy4NCj4+DQo+PiBJdCdzIGEgY2xlYW4g
bW92ZW1lbnQsIHRoZSBvbmx5IGNoYW5nZSBpcyBkcm9wICJzdGF0aWMiIGZyb20gaW50ZXJmYWNl
DQo+PiBmdW5jdGlvbnMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292
LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+PiAgIGluY2x1
ZGUvYmxvY2svYmxvY2stY29weS5oIHwgIDU5ICsrKysrKysNCj4+ICAgYmxvY2svYmFja3VwLmMg
ICAgICAgICAgICAgfCAzMTMgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
Pj4gICBibG9jay9ibG9jay1jb3B5LmMgICAgICAgICB8IDMwNyArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4+ICAgYmxvY2svTWFrZWZpbGUub2JqcyAgICAgICAgfCAgIDEg
Kw0KPj4gICBibG9jay90cmFjZS1ldmVudHMgICAgICAgICB8ICAgMiArDQo+PiAgIDUgZmlsZXMg
Y2hhbmdlZCwgMzcwIGluc2VydGlvbnMoKyksIDMxMiBkZWxldGlvbnMoLSkNCj4+ICAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGluY2x1ZGUvYmxvY2svYmxvY2stY29weS5oDQo+PiAgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBibG9jay9ibG9jay1jb3B5LmMNCj4gDQo+IE1heSBjaGFuZ2UgZGVwZW5kaW5nIG9u
IGNoYW5nZXMgdG8gdGhlIHByZWNlZGluZyBwYXRjaGVzLCBidXQgRldJVw0KPiANCj4gUmV2aWV3
ZWQtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+IA0KDQpJZiB5b3UgZG9uJ3Qg
bWluZCwgSSdsbCBrZWVwIGl0IHVudGlsIHRoZSBwYXRjaCBkb2luZyBzaW1wbGUgbm9jaGFuZ2Ug
bW92ZW1lbnQuDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

