Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2435C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 09:58:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B9F2173C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 09:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BD+XxjSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B9F2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38114 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbMVC-00052M-3q
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 05:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55053)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbMRX-0002BX-8o
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbMRV-0003AU-5X
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:54:51 -0400
Received: from mail-eopbgr80127.outbound.protection.outlook.com
 ([40.107.8.127]:22834 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbMRS-00038N-0j; Thu, 13 Jun 2019 05:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPj1RhFEk08d769niBJOCuD6EnnNLxs7AuO1IMl1rQE=;
 b=BD+XxjSqXm3C0Ru/+HC9s3ffrukVdEVNQQdxPPI1IjiGYSGOd86SNHyV91uvoHN7cSsWxWdC0zl3J3n4TuW2RnX+ViXV0VaP9+HAXuBTJK9BPBEz+Q2O6aFYQHfJPEjE0IFmJA+uVJ8eLFyhdwQK4XIWnMNaz56X7vFxVLWY0PY=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB4049.eurprd08.prod.outlook.com (20.178.119.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Thu, 13 Jun 2019 09:54:43 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 09:54:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2 4/7] iotests: extended timeout under Valgrind
Thread-Index: AQHVIH/VjkuNcf3xl0uqwCuCmfkKCqaZWwqA
Date: Thu, 13 Jun 2019 09:54:43 +0000
Message-ID: <4994aac8-d7a9-ce69-c45b-c63daf613685@virtuozzo.com>
References: <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560276131-683243-5-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1560276131-683243-5-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P195CA0002.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::12)
 To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190613125441370
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7a99907-bfc3-40e6-c793-08d6efe528f2
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4049; 
x-ms-traffictypediagnostic: AM0PR08MB4049:
x-microsoft-antispam-prvs: <AM0PR08MB404904D8E2AE6E6A2A67D575C1EF0@AM0PR08MB4049.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(136003)(376002)(39850400004)(396003)(199004)(189003)(110136005)(73956011)(66946007)(64756008)(2906002)(4744005)(68736007)(14454004)(3846002)(478600001)(6116002)(186003)(2501003)(386003)(54906003)(102836004)(52116002)(6506007)(99286004)(476003)(316002)(26005)(66556008)(305945005)(8936002)(66476007)(66446008)(2201001)(7736002)(81156014)(81166006)(31696002)(66066001)(8676002)(71200400001)(486006)(36756003)(53936002)(5660300002)(86362001)(2616005)(6512007)(6246003)(4326008)(11346002)(256004)(71190400001)(107886003)(25786009)(6486002)(31686004)(76176011)(446003)(6436002)(229853002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4049;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8Dg+FLi2jI/lm6TROjHHf4GOdmuDBPnz8Bwtb//FYjbSNiPIzqlnFjD/ePDpgmPv0ePOpXjOrI1Kx9ADHUIzCHF6mSGWl2h3Mj4cw3TcvLQc7yNGuTWgz+qGbCz5PKOvr2t86ueqeZka24EmXHG/RsqIK/wwDNJq+Rvrbwv9zL+5fQRYG0XIQw56/97CllhoJPKP0sEq6jOMFHV0Ny7G6bX3O35vfwvIAE4z+e78ZX8S2akBV7w+EgBIxNLJuwNtnPHtBlJMjVXCPjUviVzrcrWhdc+WSISm6fYRhPQZQB/PKg9Joh9GYlCSwyT7a05eXt4h6njDXtYNWkzx4F16WafhWqRFE7wKl0A9VSWGKLSyPzW4OibqdUU0busOJyijfNMmiipoHXtXSsXzkSkfJech7DPm8wySwKaEFZKNqNE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C1471611CFA8C42AB90B0176A2910AE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a99907-bfc3-40e6-c793-08d6efe528f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 09:54:43.6380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4049
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.127
Subject: Re: [Qemu-devel] [PATCH v2 4/7] iotests: extended timeout under
 Valgrind
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTEuMDYuMjAxOSAyMTowMiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IEFzIHRoZSBpb3Rl
c3RzIHJ1biBsb25nZXIgdW5kZXIgdGhlIFZhbGdyaW5kLCB0aGUgUUVNVV9DT01NX1RJTUVPVVQg
aXMNCj4gdG8gYmUgaW5jcmVhc2VkIGluIHRoZSB0ZXN0IGNhc2VzIDAyOCwgMTgzIGFuZCAxOTIg
d2hlbiBydW5uaW5nIHVuZGVyDQo+IHRoZSBWYWxncmluZC4NCj4gDQo+IFN1Z2dlc3RlZC1ieTog
Um9tYW4gS2FnYW4gPHJrYWdhbkB2aXJ0dW96em8uY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRy
ZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCg0KDQoNClJl
dmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1
b3p6by5jb20+DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

