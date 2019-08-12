Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C510C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:00:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E95CA208C2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ND3QQyCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95CA208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxBoU-0005js-9B
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 11:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39212)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxBnk-0004hj-GS
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxBnj-0001Vj-It
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:00:00 -0400
Received: from mail-eopbgr00111.outbound.protection.outlook.com
 ([40.107.0.111]:12208 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxBnj-0001VF-BI; Mon, 12 Aug 2019 10:59:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaOO1iXNhRZJ5t59vWEnleUMgzFCve//dFTxL1rOPdsRNbmSewXr8q08SXgjTHgMOoL8rdu4+RD2+bUxQB13C+DgI+Llyr+6ZDYdQ94PNdOu+/kpxpYXNBgVXvdVC+7aTF5D/mtUnyFOmmpZhhD6A4ii1fMovOB1q102jL+tcgmBGVtZ8/i4wGpQQZmNsg/TCQZik/L+uqyKTW9qiXszD+Ma60IW8k0rXkPGWnXAM23MMvBjkBYhxzsrrTN7RNvQ+7gsHH2x4w7IsWLv/BSEGN4deWSHYNcnV66YmFOG//3O/TbvOw5BH7KkfASuGpsiupcve4xw4VitsdK5GBcgdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4CQl0c0QcDHzhQv9s+aKy55Q3o8xsseEBV/aJ/LVbw=;
 b=A+XJcQ4QZ1x1EpoXkcLupm7l7DC2oux2YGiiKB7PxtOEVMEv3Sz9hFJT4FhwojVk5+QWDG9Q52QGVJS8hFGIJBwfH1iP70mh9ehiUc2GlW0fiZMllWTyd/JIDUX0Zsv2FUJiGwrJPQeUgvxlTiKnzQU82APcxASOUselM8ObYvaBSV1hgC0IWrezK2Ua2OVVnk55ItnI3Y58Ri7lst1MQ1xHwSuqgrxmSPL3auZlvbHMFFOzkSuH489HDu+9qtiwleucdMeKAmjv4aJPqdW5pjlkh5bB4IGOpACNhuolpieQWDdud+56bcLdgkQrk77bApG5+soGYQyiIBpU5m88gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4CQl0c0QcDHzhQv9s+aKy55Q3o8xsseEBV/aJ/LVbw=;
 b=ND3QQyCUGaok9pWFOBoacdQP6afpROSS84GSMT8vjCpBZL3PmBCAcGkxrp7NNnJMQgYr8L12FI2BDaBnM63NaAloS6yARypR0R65Icrsr5SapYFRkKfxLV8lO8ExMtVBkZZ+XCohViSZ8yVNPjj72jWcb0anE4Gxokc/kdMSu2I=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5067.eurprd08.prod.outlook.com (10.255.19.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Mon, 12 Aug 2019 14:59:56 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 14:59:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 2/3] vmdk: Make block_status recurse for flat extents
Thread-Index: AQHVQwFfQc9enZtMpEa///lccFWY3qb3ty6A
Date: Mon, 12 Aug 2019 14:59:56 +0000
Message-ID: <f8b4cd1c-5fb0-6ab1-e4db-43affdf1ff66@virtuozzo.com>
References: <20190725155512.9827-1-mreitz@redhat.com>
 <20190725155512.9827-3-mreitz@redhat.com>
In-Reply-To: <20190725155512.9827-3-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0047.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::15) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190812175953925
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b66b1f8-1790-42d1-c214-08d71f35bd0b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5067; 
x-ms-traffictypediagnostic: DB8PR08MB5067:
x-microsoft-antispam-prvs: <DB8PR08MB506738008B695C0E505190CEC1D30@DB8PR08MB5067.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(39840400004)(346002)(396003)(136003)(189003)(199004)(66476007)(66556008)(81166006)(53936002)(64756008)(6246003)(478600001)(7736002)(31696002)(81156014)(14454004)(36756003)(66946007)(86362001)(305945005)(66446008)(8676002)(256004)(6116002)(3846002)(2906002)(71190400001)(71200400001)(4326008)(31686004)(66066001)(99286004)(25786009)(476003)(76176011)(2616005)(316002)(229853002)(486006)(6486002)(26005)(5660300002)(11346002)(52116002)(2501003)(6436002)(446003)(110136005)(6506007)(386003)(186003)(102836004)(54906003)(8936002)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5067;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uvokjShSy2Jy9FMC2BAvvDhTyaY4CWCK1V1HHIiviR6Fg7QGV63obS4PWOmX2PWafSDJaZhbRa90ljwLjMg9IRe3BBg5/yw3n6Q9MYNkYY4BKOfYek3UMgXkEcnA/UNqqcLEWY/sQ7GJkAsmkTz4/kSDwPYowhopFd2B4ZnX9OhOvJnA2CjXzHpbPfBIFWJYcI3ilaJPDAelXHR562dVNCP3jxG2M9e8ksVZFVXCRUx9gLfuffRjeP1UgZXwC9eDjLEk9QXvc0vmBdIF8BRWu8sJwoWmuCAADG/ReAonG5ucLpJFmT77wjA9r/1CoOXZLvJo7xTMrRT7fbcn8phZVRFcB+ekapN9OcAbA0mDghoU+dTp5hDOTFC6lCLgHqAKQeqjTQltLBfhMOG2UH3soCV4UG9o1Hg63+Hzxgotr9I=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <61141BB902EEFF47B3E4A780CFF1AB9C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b66b1f8-1790-42d1-c214-08d71f35bd0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:59:56.2827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6+DWjRQ3vMDrhDJ6fefTNbdFVVgd0Clh1wJA+gYK2IhePV1CCZt5KDm+k+8ZgIQ+Nm1JTObpckJGUZE2yyJa6qpBflE48ThQ1tkj43KGvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5067
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.111
Subject: Re: [Qemu-devel] [PATCH 2/3] vmdk: Make block_status recurse for
 flat extents
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

MjUuMDcuMjAxOSAxODo1NSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBGaXhlczogNjlmNDc1MDVlZTY2
YWZhYTUxMzMwNWRlMGMxODk1YTIyNGU1MmM0NQ0KPiBTaWduZWQtb2ZmLWJ5OiBNYXggUmVpdHog
PG1yZWl0ekByZWRoYXQuY29tPg0KDQpBZ2FpbiwgZG9uJ3Qga25vdyB2bWRrIGNvZGUsIGJ1dCBi
cmllZmx5IGxvb2tpbmcgYXQgaXQgKGFuZCBhdCB2bWRrIHNwZWMpIEkNCnNlZSB0aGF0ICJleHRl
bnRzIiBhcmUgZmlsZXMsIGFuZCBmbGF0IGV4dGVudCBpcyBhIHJhdyBmaWxlIHdpdGhvdXQgYW55
IHNwZWNpYWwNCmZvcm1hdC4gQW5kIGl0IGlzIGFsbG9jYXRlZCBieSBibGtfdHJ1bmNhdGUoLi4g
UFJFQUxMT0NfTU9ERV9PRkYgLi4pLCBzbyByZWFsbHkNCmxvb2tzIGxpa2UgbWV0YWRhdGEgcHJl
YWxsb2NhdGlvbi4NCg0KQW5kLCBhbnkgd2F5LCB0aGVyZSBzaG91bGQgbm90IGJlIHJlYWwgZGFt
YWdlLCBhcyBwYXRjaCBzaW1wbHkgYnJpbmdzIGJhY2sgb2xkIGJlaGF2aW9yDQpmb3Igb25lIGNh
c2UuDQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50
c292QHZpcnR1b3p6by5jb20+DQoNCj4gLS0tDQo+ICAgYmxvY2svdm1kay5jIHwgMyArKysNCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxv
Y2svdm1kay5jIGIvYmxvY2svdm1kay5jDQo+IGluZGV4IGJkMzZlY2UxMjUuLmZkNzhmZDBjY2Yg
MTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL3ZtZGsuYw0KPiArKysgYi9ibG9jay92bWRrLmMNCj4gQEAg
LTE2OTIsNiArMTY5Miw5IEBAIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIHZtZGtfY29fYmxvY2tf
c3RhdHVzKEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPiAgICAgICAgICAgaWYgKCFleHRlbnQtPmNv
bXByZXNzZWQpIHsNCj4gICAgICAgICAgICAgICByZXQgfD0gQkRSVl9CTE9DS19PRkZTRVRfVkFM
SUQ7DQo+ICAgICAgICAgICAgICAgKm1hcCA9IGNsdXN0ZXJfb2Zmc2V0ICsgaW5kZXhfaW5fY2x1
c3RlcjsNCj4gKyAgICAgICAgICAgIGlmIChleHRlbnQtPmZsYXQpIHsNCj4gKyAgICAgICAgICAg
ICAgICByZXQgfD0gQkRSVl9CTE9DS19SRUNVUlNFOw0KPiArICAgICAgICAgICAgfQ0KPiAgICAg
ICAgICAgfQ0KPiAgICAgICAgICAgKmZpbGUgPSBleHRlbnQtPmZpbGUtPmJzOw0KPiAgICAgICAg
ICAgYnJlYWs7DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

