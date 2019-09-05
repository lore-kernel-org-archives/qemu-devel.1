Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464F2C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 14:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1D6206CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 14:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="alraJ4vt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1D6206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5t8b-0007JA-7M
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 10:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1i5t7r-0006pF-Pg
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 10:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1i5t7p-000885-TV
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 10:52:42 -0400
Received: from mail-eopbgr20134.outbound.protection.outlook.com
 ([40.107.2.134]:19614 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1i5t7p-00086G-5R; Thu, 05 Sep 2019 10:52:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUp/FoUMK1ykR3XrO6sorKlPXxqGgtMcTxnkkU7SHCi6suYkaLuuBK7Ow82NcUefd58ry73NzTtYYW4yzb1YTviZGExhFJEV+91dI+TjXLwPiv0jm1i6tqyKbG9rbhAXZ+aMlfOtyw/LXO/MfTLkKj3s9NaPt6X1bd+jKS0XdTdWK80n9/HT/CezdFrZgNaYzkXzN38/o1D+W8Frh+ME7++ra6TWZ8cjjGGxv7NqqKOddyQlj85MEfotlzyqcUoSddlSOKCuR28RexB9xrq9O6QHAPvyqLgSRGd6hHVDb5IZLrmJbeEG/19xGGeOUQBYDf9u5rXr1nZYOu/KUYiwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/iuCxWa47fmVGm6vaG4Y23dLnWnW0jsYJt0idWnF2Q=;
 b=LZnEKq2rnQFYy9jquGbHGv914y0pKznbTvdz32uX+ceWBSYkuTXc7ABHztly6ekrDZ+7OT6IdBbP3S4BazhNPm4tTAZa5VIAeSxJODHYj6gkalFa3BRwJ/O3yZiTkQKGwND4zkyof84P+xWzqX+47HR68huyl4g8Hz195xR32x+nzMU5xsCJQRMmcSqA4azlpGQS+4y6+5/QY+RbbaqawwMckVR/hzQAP4cUQqB79e7FOJ6mWyxtYGsbE9JBRxxYEybQtQt/6Grt44pra7/8F3gKYRA8ZI/FNafmjA92ijYYFzcEcIAsvaNXOK0GXR+c1Bw7pZahVezCB2zvVp71mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/iuCxWa47fmVGm6vaG4Y23dLnWnW0jsYJt0idWnF2Q=;
 b=alraJ4vttHt/IeTjBECZ6qn6Rr7I0Nir2V+4lwHtVOLoymrt/Z2mgK3xpEGzoQ/da4zDd9Ovt+kJrZDiKH1jAf9sRzXMDYdITUK03h7gOklzuz5yY6kFDnyCU783kZRxZGF4OYA7IaBDSN1kDjm1sFvRBxb7M3f+HYvF4o9Fv+4=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3425.eurprd08.prod.outlook.com (20.177.109.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Thu, 5 Sep 2019 14:52:38 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::302b:b479:1322:9d31]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::302b:b479:1322:9d31%5]) with mapi id 15.20.2241.014; Thu, 5 Sep 2019
 14:52:38 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v5 3/3] qcow2: add zstd cluster compression
Thread-Index: AQHVYzruEZDsZDoirUyQ0IuQtSHLpKcctO0AgABxzQCAAAXtgA==
Date: Thu, 5 Sep 2019 14:52:37 +0000
Message-ID: <ff1d7775-0ded-3791-2db6-51773af5b5e4@virtuozzo.com>
References: <20190904152915.30755-1-dplotnikov@virtuozzo.com>
 <20190904152915.30755-4-dplotnikov@virtuozzo.com>
 <2ff3dc82-ea8c-10a8-fb4c-8081abc3775e@redhat.com>
 <1feb49e1-bab1-ac10-3232-95d696995b96@virtuozzo.com>
 <829a32ee-0a5a-7bc6-e696-d3315ec53c13@redhat.com>
In-Reply-To: <829a32ee-0a5a-7bc6-e696-d3315ec53c13@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-originating-ip: [31.180.210.224]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ded0807-83e9-4ee0-6027-08d73210b1e0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:AM0PR08MB3425; 
x-ms-traffictypediagnostic: AM0PR08MB3425:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3425907746EA1F3477F78C9DCFBB0@AM0PR08MB3425.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39840400004)(346002)(376002)(396003)(136003)(199004)(189003)(186003)(76176011)(53936002)(2201001)(99286004)(64756008)(26005)(4744005)(6512007)(86362001)(31696002)(102836004)(66556008)(66476007)(66446008)(3846002)(6116002)(7736002)(8936002)(256004)(81166006)(81156014)(8676002)(6486002)(31686004)(66946007)(36756003)(5660300002)(478600001)(71200400001)(71190400001)(53546011)(305945005)(6506007)(6246003)(6436002)(316002)(66066001)(446003)(76116006)(2616005)(4326008)(14454004)(229853002)(476003)(110136005)(54906003)(25786009)(2501003)(486006)(2906002)(11346002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3425;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LgvyKd09UTrPr0LOmkwq7vBD2pSMeh0gIs3OdcqtocRIg2AL1PtiLySBla+JPXeASH9TkDTSpiiABAwRn5H3JtOIQZgyiJaOdjrwuptCtCf54X7BwRMmw2Cg7GEdeQDi7EoTr8sceIivbK1phsl31DmqiVpOKx8LPHnIImSirA3/16BNhYA/A6W553UXlBu7tEzOF1SfSOjOItoJ57UggI+YNBs6hAntyyHrqzq2weQ1W18HxzDNmCbf0/QGXxktPmVzDKfRzqFncVd4c33PwhAjhH4/9YlZMoZMPyV6lw661pPc2DFUHkBTD7rltiO+BqfMXShT+wH2Zk0WmTwYWio8m4jRTh3+bHyh66mzExPaNOSextbYE6B9wNKKvuBjOGQZloAp+iAZF1Vt7ilVVBDhLeUy1dCdeWro9avb7o0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B74CEC9C0D19E4293F25B2443FE6EE4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ded0807-83e9-4ee0-6027-08d73210b1e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 14:52:37.9762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eiNM+OWDhqpDyJwjKX5VZnnUnu3VFmfNzaw2QxlF9reA41c1bjulhF49VZDJBbFNa/xV9FQGhLXBLJA1hCFhLhV/MChPWcycC91mmpa3N4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3425
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.134
Subject: Re: [Qemu-devel] [PATCH v5 3/3] qcow2: add zstd cluster compression
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMDUuMDkuMjAxOSAxNzozMSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gOS81LzE5IDI6NDQg
QU0sIERlbmlzIFBsb3RuaWtvdiB3cm90ZToNCj4NCj4NCj4+Pj4gKw0KPj4+PiArICAgIHNfc2l6
ZSA9IGJlMzJfdG9fY3B1KCooY29uc3QgdWludDMyX3QgKikgc3JjKTsNCj4+PiBBcyB3cml0dGVu
LCB0aGlzIGxvb2tzIGxpa2UgeW91IG1heSBiZSBkZXJlZmVyZW5jaW5nIGFuIHVuYWxpZ25lZA0K
Pj4+IHBvaW50ZXIuICBJdCBzbyBoYXBwZW5zIHRoYXQgYmUzMl90b19jcHUoKSBhcHBsaWVzICYg
dG8geW91ciAqIHRvIGdldA0KPj4+IGJhY2sgYXQgdGhlIHJhdyBwb2ludGVyLCBhbmQgdGhlbiBp
cyBjYXJlZnVsIHRvIGhhbmRsZSB1bmFsaWduZWQNCj4+PiBwb2ludGVycywgc28gaXQgd29ya3M7
IGJ1dCBpdCB3b3VsZCBsb29rIGEgbG90IG5pY2VyIGFzIG1lcmVseToNCj4+Pg0KPj4+IHNfc2l6
ZSA9IGJlMzJfdG9fY3B1KHNyYyk7DQo+PiB5ZXMsIGJ1dCBJIGNhbid0IHVzZSBiZTMyX3RvX2Nw
dSgqc3JjKSBzaW5jZSBzcmMgaXMgYSB2b2lkIHBvaW50ZXINCj4gVGhlbiB3ZSBuZWVkIHRoZSBj
b3JyZWN0IGxkKl9wIGZ1bmN0aW9uOyBzb3JyeSBmb3IgbGVhZGluZyB5b3UgZG93biB0aGUNCj4g
d3JvbmcgcGF0aC4gIExvb2tzIGxpa2UgdGhlIHJpZ2h0IG9uZSBpczoNCj4NCj4gc19zaXplID0g
bGRsX2JlX3Aoc3JjKQ0KPg0KPiAoaW5jbHVkZS9xZW11L2Jzd2FwLmggaGFzIHNvbWUgZ29vZCBj
b21tZW50cywgYnV0IHlvdSBoYXZlIHRvIGtub3cgdGhleQ0KPiBleGlzdC4uLikNCg0KTm8gcHJv
YmxlbSwgdGhhdCBoYXBwZW5zLiBCeSB0aGUgd2F5LCBJJ3ZlIGFscmVhZHkgc2VudCB0aGUgc2Vy
aWVzIHVzaW5nIA0KbGRsX2JlX3ANCg0KVGhhbmtzIQ0KDQpEZW5pcw0KDQo+DQoNCg==

