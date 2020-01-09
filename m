Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BE0C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBEE2067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="r8XI083F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBEE2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipZMV-0005hH-0X
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 10:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ipZLN-0004ly-Vt
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:03:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ipZLI-0001fb-NB
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:03:29 -0500
Received: from mail-am6eur05on2090.outbound.protection.outlook.com
 ([40.107.22.90]:44481 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ipZLI-0001ZL-0c; Thu, 09 Jan 2020 10:03:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rq5AUUOSDdezyOUdR6C9EhZTM3NkRuRewK5ylf/HiSQTyQ5jAo7Ym6NHnmH0JWFwhT9l/ZRDNOvFKg/p4+k8MUhFIuCSpo36AvUrk4baBVYd2dcQeMaJ+9Azhwsi3QL1CvZqrFO++cSeQm0+S7aXl16Gxxexz/4DGaYwoDfwKwz+pGK4FDyS/lHPj+jx3bRm8Bx2lCg1BwNxbeBGSAk8lCioI/OtF3k0O6TVTCDoeVA7ZI/oypj3Q315cGMHYtNX7O2DCIbPsDFP8zZ23bvHUU0mERmFdA/0nYfauW1F6I6Ugkj8LpE4f06z2tR+WiC09MCn6lx7ew+/0ZAvx1dxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thzAt3uOLQ9axT9vT2G8uVNEqVV0XF3ctFifJCAHFx8=;
 b=drPJTUJm7w2eLOvo9I7og7+9gD8xzQNjvwaFdXNufAwy5VxvAxiPrKM49nw6SY8fQoDbBza4bKgBzGdXGO1szuB1Zqm7hDFm80hAwMmAtJU9nceh92raDmg5B6khZ9jlby7REIcJiac+MTzV69Za3AhA1y2b5R8gttYvBwdZBAJg0PuCJ2Y4TgetLbyACzZCg7GXHih5yi5wZFGwSuPoZcHYESoVzZnEGBteHyd4GkRV7X5DKaY6dLMnLJ9ZrNeqAzenixzNOFGQUvznBPdeW9zwm2MT32RoI9wzj35VgUwjZsUodEtT2JN8/Ys2T/i8/zj2EpormZZgwUshXxD/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thzAt3uOLQ9axT9vT2G8uVNEqVV0XF3ctFifJCAHFx8=;
 b=r8XI083FxHqpN/d7ILozYC9Enx1MtJsbahjKd5nNQ7TAOH+9mdZZtIPawW7MTLBuFV8z2dVqN/0Woxe2Ijcldtom/I6VwZ/X/wVCw0GhdFwyiVr8cV4NbLAeRh618WBIVka+FMw93d+JSwRkIGKF3+wPY0PSlbmR8ginkOn5wZg=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4899.eurprd08.prod.outlook.com (10.255.99.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 9 Jan 2020 15:03:21 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2623.008; Thu, 9 Jan 2020
 15:03:21 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P192CA0003.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Thu, 9 Jan 2020 15:03:21 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Subject: Re: Pre-Christmas meeting notes
Thread-Topic: Pre-Christmas meeting notes
Thread-Index: AQHVxLUvo16uJApLX0WzCyYpfkIZo6ficnCA
Date: Thu, 9 Jan 2020 15:03:21 +0000
Message-ID: <23ba22f5-2990-3821-cfb9-7d448c65240a@virtuozzo.com>
References: <eee7656f-8de1-9d44-7de2-db1b5ed68148@redhat.com>
In-Reply-To: <eee7656f-8de1-9d44-7de2-db1b5ed68148@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0003.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::13)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200109180319683
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3eab13b9-bab4-44fa-e0b4-08d795151153
x-ms-traffictypediagnostic: AM6PR08MB4899:
x-microsoft-antispam-prvs: <AM6PR08MB4899209E6AC55A3E48596E9BC1390@AM6PR08MB4899.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39850400004)(199004)(189003)(36756003)(86362001)(31696002)(4326008)(4744005)(6486002)(2906002)(81156014)(66556008)(31686004)(66946007)(5660300002)(16526019)(186003)(81166006)(8676002)(66476007)(66446008)(64756008)(8936002)(54906003)(110136005)(52116002)(3480700007)(316002)(71200400001)(16576012)(26005)(2616005)(478600001)(956004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4899;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NNDJh+U1eG+eS/GdjSXEbxP4/GmgJRV2uFAvVJkYAPGsCdvRTznZ0yVaUbZ18pUXkyP+7LLf0EwF28sMv2WAcwK1vIHpBNGa88yzGA/Hg7we8Tk+3Ann0FrtKzcOUrRpkiBrZjYHUstEs373FY+SRPoH8H6DyAZnaW2gHvrRyMXQ6H6LHLzT8m3vpjr5xmmzu0XjY/2o6QE1oNa2PwObPPvy6AMbpS3YR9neyYnZVJCp5VwDEzTL75KCtRJ2AqDaI8mnidTV4iDiJeVkZJ3u4A6Qa/H+57mh7X78QdqL7M+GMxP3s/m8+aJArsJXSEJZe/DtOHrC9t5ypzZffx6e+y5A2KaoxkYsSWKEcLgaKg0V6Z1kzNPjSM9MhKzDg2NVdpBqEBJLyw1reJd6/BVsJqe3/8db2g9MwG4Dl0aFSu3cwyiNiYJJq3AnFjQtZBUl
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <723F1040AB807741BF66D2CED0A8F252@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eab13b9-bab4-44fa-e0b4-08d795151153
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 15:03:21.5295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ktcIEZPuhb1H4yf+Z7RqLCBZXS4g3JzAcK6XoYJZ4UCbsGTz+gvCaF9L60tEGAja0aUXEH1hR0KezmoBrii9t44PVujcP/k5r6axwawSQdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4899
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.22.90
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
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMDEuMjAyMCAyMDoxNSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBNaXNjDQo+IC0tLS0NCj4gDQo+
IFRoZSBXaWtp4oCZcyBUT0RPIGxpc3QgaXMgaG9ycmlibHkgb3V0ZGF0ZWQuICBXaGF0IHNob3Vs
ZCB3ZSBkbyBhYm91dA0KPiBpdD8gIE1heWJlIGFyY2hpdmUgaXQgYW5kIHN0YXJ0IGEgbmV3IG9u
ZT8gIChNb3N0IG9mIHRoZSB0aGluZ3Mgb24gdGhlDQo+IGN1cnJlbnQgbGlzdCBhcmUgZWl0aGVy
IGRvbmUgb3Igd2UgZG9u4oCZdCB3YW50IHRvIGRvIGFueW1vcmUuKQ0KDQoNCk1heSBiZSwgY3Jl
YXRlIGJsb2NrL1RPRE8udHh0IGluc3RlYWQ/IEl0IHdvdWxkIGJlIHNpbXBsZXIgdG8gbWFuYWdl
IGZpbGUNCmluIGdpdCB0aGFuIHdpa2kgcGFnZS4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZs
YWRpbWlyDQo=

