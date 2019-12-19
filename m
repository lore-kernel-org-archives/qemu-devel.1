Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BF6C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 09:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF0F2064B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 09:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CxdQuW1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF0F2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihrhF-0007KZ-J6
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 04:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihrgB-0006nS-8s
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 04:01:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihrg9-0005h2-SC
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 04:01:06 -0500
Received: from mail-eopbgr40135.outbound.protection.outlook.com
 ([40.107.4.135]:33600 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ihrg8-0005Tg-VV; Thu, 19 Dec 2019 04:01:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GG/B9+amGuKhNSXHZrqt6im5mly+oQZJvnUuMyniYY3qBbBvzlLNi8XuMaoUXtQeaxq5aWjzyy7WKcrgMIUxsf4e+/j8fGgayBf/QxQSIAoMn9hjmrwI4dbk8ejIfXUR3nVQsEpx34mzxy3gZpFXBJ3XwTkhlxvjD4tmPlKoURGjPQc1y8XPJyhF3HjXWAoMnGFZq8l0kH185cZPnUF8V+qgX9cIUHyLza8N2lsy/5rSk/szEjyEFAYi5p3F0HH0IUj+0MdJojiYxTcRdp8VXs+1jsiVWu1c/uSelFHu4sZhkHVMZEBrSXCz2jjDIN3gUg2zMEC2alycLdVN0DQ65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAwPTaKQGUQO9gbV/npfBFnNZ3d3cQ8e4lLGiKrug0o=;
 b=i2qzOJsOKDxxCwaKKjw7tzw+IaG3cj5nPqKvV5J8zGjGgPF6O29sRBrL0pPBp0KcugzLHYlmzd7nZDy2R+OdUdKD4iKJDHOvuBdOpRyuw2F5BuE8UNRa8VMnewnQEnd2jY1QB0qOXmo8DOxzm2Cx1a7GUw240iB9lC4f/15OL/rBnq/BBrNQRPTwBOakx99FqBKixl6aSVZr9kcncefKyFj0J5tcHk6qd0WQGeoXg+a59X/ySZ1ci3SOqfMhpec4ThweDhLNSQCHPIFRfb1ykxFGQEtVMYGRj8nCApQAJGMlrvHV3XqprbjmnGHsATWybrOQcyh9VJ26vmoJnIon8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAwPTaKQGUQO9gbV/npfBFnNZ3d3cQ8e4lLGiKrug0o=;
 b=CxdQuW1fzZh7xiYgmC/SOpHgH2LjhqPlbiI4HuhlbmRlbZxPoSk8Zmubs+W2XmfWt+5NHkqtiUBkHvJ1sn9BHdy7yoczfG/KNawHO5monwC9gaDWZjCCk4njxGQJQzzSZoDyK//AWwQzSbwLLvyaenfuPUlGi9S2EJPMiQJzGVo=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4166.eurprd08.prod.outlook.com (20.179.1.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Thu, 19 Dec 2019 09:01:02 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 09:01:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 for-5.0 0/7] block-copy improvements: part I
Thread-Topic: [PATCH v2 for-5.0 0/7] block-copy improvements: part I
Thread-Index: AQHVpU23N4tIPiZFCES+LN2VFjOlDKfBSw8A
Date: Thu, 19 Dec 2019 09:01:02 +0000
Message-ID: <bbfcf774-e763-f7ed-2501-e5fba150cd5e@virtuozzo.com>
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
In-Reply-To: <20191127180840.11937-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0058.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::26) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191219120100238
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2dd95ad1-ff46-4ab8-d846-08d78461f8f5
x-ms-traffictypediagnostic: AM6PR08MB4166:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB41666370B79ED92501D91C3CC1520@AM6PR08MB4166.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(199004)(53754006)(189003)(6486002)(4744005)(498600001)(5660300002)(66446008)(66556008)(66476007)(64756008)(66946007)(6512007)(31686004)(31696002)(36756003)(186003)(86362001)(2616005)(52116002)(107886003)(8676002)(54906003)(8936002)(26005)(71200400001)(81156014)(6506007)(81166006)(6916009)(2906002)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4166;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: evi69YfGp+7J5I2bvpZgP15d7mvc8912E8UZOeNdN0r8/b3ogOow1ve5HtHc8Ba5jmiclWv5qnuBFLzatXo05nOIunDwNnp5mKjArzQ/H9aCsd3zyxQfmfbSUT2Orm5JQ6HYzaYFUD/IlMLF5zUH9Ntste2oiIfLMlUFbOraC3o7+8lrRGkfqoonkRHxRVHf+juzpJErYJW8GBNP9NSakFrBrTWYNF5DACk6O5UM7CaW984LW0iyUtVU9wufWbh+CAV0s0SD+2hhVzs8Pgxrx2poeN+MrtahgQMjNE/j8mXknRETDK2V/vuk2KwtLREJmaPY/e2UGYESJxyxRmPioZrN/jY49zPB27EuM3Hr50Vl0iSrabzsS85DyFkuuR//g1K6Nz6RK2LdkTkLCTSFbyzw6VBFxD/IsjW5qRvhIdQpULmujh6ScBLgG1vxz5Vzl2H+t8fGK/x21EGcewRf0R9WuzCuSYAMCyF7jGbZ35t4+Ilv1+PSLWFm+0LZKkJ8
Content-Type: text/plain; charset="utf-8"
Content-ID: <1977F4561BACC04CBD57B148AAF6E733@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd95ad1-ff46-4ab8-d846-08d78461f8f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 09:01:02.1349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3CD8ebu2hvaOCOWrGlloHolbXlfc4pWJDqB4m1R+lWDIhkmnk/j+TFdjAkPkV1Z3SMQqo0JbwPf+oibSA1R8FRr3UvWuM6nQR7aMz9BuCpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4166
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.135
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
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cGluZy4gU2VyaWVzIGFwcGxpZXMgb24gY3VycmVudCBtYXN0ZXINCg0KMjcuMTEuMjAxOSAyMTow
OCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4gSGkgYWxsIQ0KPiANCj4g
VGhpcyBpcyBhIGZpcnN0IHBhcnQgb2YgbXkNCj4gICAgW1JGQyAwMC8yNF0gYmFja3VwIHBlcmZv
cm1hbmNlOiBibG9ja19zdGF0dXMgKyBhc3luYw0KPiANCj4gUGF0Y2hlcyBhcmUgbW9zdGx5IHNl
cGFyYXRlIGJ5IHRoZWlyIGlkZWEsIGJ1dCBzZW5kaW5nIHRoZW0gYWxsIGluDQo+IHNlcGFyYXRl
IGlzIGluZWZmaWNpZW50Lg0KPiANCj4gVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSAoNyk6
DQo+ICAgIGJsb2NrL2Jsb2NrLWNvcHk6IHNwZWNpYWxjYXNlIGZpcnN0IGNvcHlfcmFuZ2UgcmVx
dWVzdA0KPiAgICBibG9jay9ibG9jay1jb3B5OiB1c2UgYmxvY2tfc3RhdHVzDQo+ICAgIGJsb2Nr
L2Jsb2NrLWNvcHk6IGZhY3RvciBvdXQgYmxvY2tfY29weV9maW5kX2luZmxpZ2h0X3JlcQ0KPiAg
ICBibG9jay9ibG9jay1jb3B5OiByZWZhY3RvciBpbnRlcmZhY2VzIHRvIHVzZSBieXRlcyBpbnN0
ZWFkIG9mIGVuZA0KPiAgICBibG9jay9ibG9jay1jb3B5OiByZW5hbWUgc3RhcnQgdG8gb2Zmc2V0
IGluIGludGVyZmFjZXMNCj4gICAgYmxvY2svYmxvY2stY29weTogcmVkdWNlIGludGVyc2VjdGlu
ZyByZXF1ZXN0IGxvY2sNCj4gICAgYmxvY2svYmxvY2stY29weTogaGlkZSBzdHJ1Y3R1cmUgZGVm
aW5pdGlvbnMNCj4gDQo+ICAgaW5jbHVkZS9ibG9jay9ibG9jay1jb3B5LmggfCAgNTcgKy0tLS0t
DQo+ICAgYmxvY2svYmFja3VwLXRvcC5jICAgICAgICAgfCAgIDYgKy0NCj4gICBibG9jay9iYWNr
dXAuYyAgICAgICAgICAgICB8ICAyNyArLS0NCj4gICBibG9jay9ibG9jay1jb3B5LmMgICAgICAg
ICB8IDM3OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+ICAgYmxvY2sv
dHJhY2UtZXZlbnRzICAgICAgICAgfCAgIDEgKw0KPiAgIDUgZmlsZXMgY2hhbmdlZCwgMzE2IGlu
c2VydGlvbnMoKyksIDE1NCBkZWxldGlvbnMoLSkNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K

