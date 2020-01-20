Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0FEC33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C953E20684
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gyMw6fh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C953E20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itT6V-0003L6-0b
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 04:12:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itT5W-0002ct-VG
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:11:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itT5S-0002i5-Jv
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:11:14 -0500
Received: from mail-eopbgr150137.outbound.protection.outlook.com
 ([40.107.15.137]:13664 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itT5J-0002fW-JM; Mon, 20 Jan 2020 04:11:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LI4AppTeJVV8kVhIPIPAmPu2cXx0+cn47om5Eg6iH2kt8p1D+BLRfO3Xqqant3mIBRxDWmv53PN6o2EtdCS01A9VR0GercKoLyH+2dxZhbTCptfznLb/Q4mEIq0FrOieF/iCyGDIwYvvUdOepRWVH6GafodMpayY+NUH5oDaKvNhgTooEzqnuQXdkLZsUDma6r9dGj141AURu789yscS+Ww617d7Q7EEPsgJoP64UlIy/61N4aalAYg77I2QyY757RTeqM5j+S7NkFfpisQF3gBmoW19/YAG1Px2+gttH1/6VbkyHlX/lpEpk66W7YDi9WIPDBNNYSGCw2yeaS6p6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh/Yp2B0YMcAcEoWoExO5neper65RzO017nQGwb5qlk=;
 b=K/3MrtinMXvFZCVvvMh7C5gK7zmQRGWDyJUyMJ6MS9ile2NB+P2MzCX4Y5Mgs0k28AZpANmABkA1s544e64TgIxuIb+L1ZDyjHPkYnsmHCBD1NJ6mOpM81cpazOq0fZKxgm8aImvIJ9AROknZS9Ug0Dwk/mtnBuc+4lV9jXIjRe2GV4L72ECJwHtMgQJCK0ChpHXFcNIYutoeBsAuDQChTquodMhXNgAYiVTHVhRdTNh2nqxe+5S661Es8brtrs5y2mbF1Ldc+rF2lVTnUyT5KUiRGiOVfe70Vgh4vsmFmyHf/bHzgLbvHeQUGJILDklgvsmmW1NB1fx3IbCBZmO8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh/Yp2B0YMcAcEoWoExO5neper65RzO017nQGwb5qlk=;
 b=gyMw6fh6cKLUTSgrHvDcKQCnvMVgr2kfO7Qwv5SE0ltjLKRnwpYCi4P3vPjdG6Hf2EqtJDT2t6WRiWeMXTSkKRpZX9tcXqZeQpY+Ty+N4q93CFUvh9RM+c99LnPb/iWnrxfXTjP/ZDbjphFEW/SUf6Cgf/wJ4k9NR2LdhDWMOzI=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3527.eurprd08.prod.outlook.com (20.177.112.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.25; Mon, 20 Jan 2020 09:11:00 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 09:11:00 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR07CA0010.eurprd07.prod.outlook.com (2603:10a6:7:67::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.12 via Frontend Transport; Mon, 20 Jan 2020 09:10:59 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: ping Re: [PATCH for-5.0 v2 0/3] benchmark util
Thread-Topic: ping Re: [PATCH for-5.0 v2 0/3] benchmark util
Thread-Index: AQHVpHEG5YfDz7UI8UOBrTTRR2csGafzmiqA
Date: Mon, 20 Jan 2020 09:10:59 +0000
Message-ID: <e1efd3d2-b623-292b-67a9-e3cdd479f104@virtuozzo.com>
References: <20191126154848.193407-1-vsementsov@virtuozzo.com>
In-Reply-To: <20191126154848.193407-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0010.eurprd07.prod.outlook.com
 (2603:10a6:7:67::20) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200120121057670
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07432fc7-2980-4725-1f28-08d79d88aa8b
x-ms-traffictypediagnostic: AM6PR08MB3527:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB35271707C93DBFEDC633F5B9C1320@AM6PR08MB3527.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(136003)(366004)(346002)(376002)(396003)(199004)(189003)(66446008)(66556008)(66476007)(64756008)(956004)(66946007)(2906002)(54906003)(6486002)(186003)(71200400001)(16526019)(26005)(86362001)(31696002)(52116002)(2616005)(8936002)(478600001)(8676002)(81156014)(81166006)(4326008)(31686004)(5660300002)(16576012)(36756003)(110136005)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3527;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ofVihttcc54kEJ/RMZwFU5xn61rikoNrFqbeBvzDYpd/HU1uBJ8V+UymS8IyhLPDd3yJfoCc4oVQSLqaYt7eQYu3K16TY4qogvYoEHgOqbw0KqbsOliLHrxTjPEadfBuz6ndgn9BUdLqv9GdJ7wDIBx8seiu+z4REJ1PH/sWNCoRUG5H2EfhiIzqOKmc+BJ85oyLUtlfwVtisSQ9mEQG5RJ3ENSyDP0XFG1dWymI6afXFHbL7cO5O87u9JK5s2VgkYUeEjKmt+axm6kRc6N5gVnj6po4XC5+t2ijndt9WXJMhaB10LuZpbVPUeVEvFy3pURxB0pkAs0co0ZUTwcntVPKbAH54YEbDrUmcbOgJf1MbnwCxSJP8GJpJkh4kuvCPJPtglBh8xxAYmHoCoRiAGMnFDKdpy7HZ9xq2z+lvYAHxNAbvuEJyYF0wYQ/AvKf
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCFCD1BECA3D7647B2566952B6704A62@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07432fc7-2980-4725-1f28-08d79d88aa8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 09:11:00.0050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v3Z4eKli0loEj03/jPRjxhudsWa+bcnfpEPYWVM8h9XRoOiI/RCR+/aEyV0+8LCBVxz7zVl/46HYNyGof3ME1aoYwwu5+/1z701R32ovDAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3527
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.137
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
 "stefanha@gmail.com" <stefanha@gmail.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "crosa@redhat.com" <crosa@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cGluZw0KDQoyNi4xMS4yMDE5IDE4OjQ4LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiBIaSBhbGwhDQo+IA0KPiBIZXJlIGlzIHNpbXBsZSBiZW5jaG1hcmtpbmcgdXRpbGl0
eSwgdG8gZ2VuZXJhdGUgcGVyZm9ybWFuY2UNCj4gY29tcGFyaXNvbiB0YWJsZXMsIGxpa2UgdGhl
IGZvbGxvd2luZzoNCj4gDQo+IC0tLS0tLS0tLS0gIC0tLS0tLS0tLS0tLS0gIC0tLS0tLS0tLS0t
LS0gIC0tLS0tLS0tLS0tLS0NCj4gICAgICAgICAgICAgIGJhY2t1cC0xICAgICAgIGJhY2t1cC0y
ICAgICAgIG1pcnJvcg0KPiBzc2QgLT4gc3NkICAwLjQzICstIDAuMDAgICA0LjQ4ICstIDAuMDYg
ICA0LjM4ICstIDAuMDINCj4gc3NkIC0+IGhkZCAgMTAuNjAgKy0gMC4wOCAgMTAuNjkgKy0gMC4x
OCAgMTAuNTcgKy0gMC4wNQ0KPiBzc2QgLT4gbmJkICAzMy44MSArLSAwLjM3ICAxMC42NyArLSAw
LjE3ICAxMC4wNyArLSAwLjA3DQo+IC0tLS0tLS0tLS0gIC0tLS0tLS0tLS0tLS0gIC0tLS0tLS0t
LS0tLS0gIC0tLS0tLS0tLS0tLS0NCj4gDQo+IFRoaXMgaXMgYSB2MiwgYXMgdjEgd2FzIGluc2lk
ZQ0KPiAgICJbUkZDIDAwLzI0XSBiYWNrdXAgcGVyZm9ybWFuY2U6IGJsb2NrX3N0YXR1cyArIGFz
eW5jIg0KPiANCj4gSSdsbCB1c2UgdGhpcyBiZW5jaG1hcmsgaW4gb3RoZXIgc2VyaWVzLCBob3Bl
IHNvbWVvbmUNCj4gd2lsbCBsaWtlIGl0Lg0KPiANCj4gVmxhZGltaXIgU2VtZW50c292LU9naWV2
c2tpeSAoMyk6DQo+ICAgIHB5dGhvbjogYWRkIHNpbXBsZWJlbmNoLnB5DQo+ICAgIHB5dGhvbjog
YWRkIHFlbXUvYmVuY2hfYmxvY2tfam9iLnB5DQo+ICAgIHB5dGhvbjogYWRkIGV4YW1wbGUgdXNh
Z2Ugb2Ygc2ltcGxlYmVuY2gNCj4gDQo+ICAgcHl0aG9uL2JlbmNoLWV4YW1wbGUucHkgICAgICAg
IHwgIDgwICsrKysrKysrKysrKysrKysrKysrKw0KPiAgIHB5dGhvbi9xZW11L2JlbmNoX2Jsb2Nr
X2pvYi5weSB8IDExNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIHB5dGhvbi9z
aW1wbGViZW5jaC5weSAgICAgICAgICB8IDEyOCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gICAzIGZpbGVzIGNoYW5nZWQsIDMyMyBpbnNlcnRpb25zKCspDQo+ICAgY3JlYXRl
IG1vZGUgMTAwNjQ0IHB5dGhvbi9iZW5jaC1leGFtcGxlLnB5DQo+ICAgY3JlYXRlIG1vZGUgMTAw
NzU1IHB5dGhvbi9xZW11L2JlbmNoX2Jsb2NrX2pvYi5weQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCBweXRob24vc2ltcGxlYmVuY2gucHkNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFk
aW1pcg0K

