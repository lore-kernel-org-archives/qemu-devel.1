Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F28C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 13:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D89CA222BE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 13:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="A6ZV9/Ha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89CA222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDTaD-0003Um-0D
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 09:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDTZ7-0002x7-AS
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 09:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDTZ5-0006NQ-BE
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 09:12:12 -0400
Received: from mail-eopbgr60133.outbound.protection.outlook.com
 ([40.107.6.133]:16705 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDTZ5-0006L9-5q; Thu, 26 Sep 2019 09:12:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5EVr/zT0OSSM/aplhgH9K4KmXxpqIu4vuE4RXVnxiwbx8xO4HPYTQoNYnBvlaa2f83XbGCMsZ0NDs/n6/k/9zlFryOb5aRRaSEo8C0rC/N/GMN4nZ1Tm3kwnWi0VGQv4qgUxGATahYRPJJeEMEkHEzmg4lIv+UDwqFyPR/96ET0IYf4+ZiDVP4jZK9Qa01/L1kD9F5JT2rU4Ol5MTN9beaLCG6xh2aYAR8yKFUVKMfwG0JWHDfWzOJTgoLOyIqIwsxEUWlUyoYhyM6Nr75E75W8JfHtl/6HMkyNeQnrhhC8yRM/sDJkGbYMz1kp3iqcmziMbvK3Zq9BF/bvjzYYgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=524SsJx7uobtNsWcsVTuPlcOBagtRGRN54T3x3Bq0Nk=;
 b=T6MnqOtDWb7ZqZUZ6sM5C2DZkECRg48HIKd4VjWeuwGUwC9+1645p7k56I/22GGWK8rg7px3dWXctdtDSfTuvlIHHod65kceyP8FpzjFALN7yu44PmCu6fb+NHaKx0jiV2yga74FfqruE0hucn7RCfdHmt45yobyIj7Or9HvsiNk1LKfmoIo5g46tpPRHYSldoyJUINiIedEDx0YbMi1aWU0MvVpdqKLxPF8DiNV7fSqaLjbkhclTd/8BkK9spTZL+oeJHYJS7m5beFQgNgD94+yXebeEis+b9tlYzHc5EUfsKw7gotWkr3rI94tWRNjl3Q0X09X7rB8DpkQeKj3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=524SsJx7uobtNsWcsVTuPlcOBagtRGRN54T3x3Bq0Nk=;
 b=A6ZV9/HaB/9nP9SQu1teKCZ4nW/n2ynfGJ302+/WrSkrjmdHu1f3FJh3UZ70Mmm1l4CYsYEJtF8na5oxSVB9VGWy+rbFFvsUL1SON0/cO4vtvVDXTeUDmthlOtWLh9gz8J+AY9tK9YgcLyi9nayuv5c4MdXaeNDuIHcs0a3tVAw=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3945.eurprd08.prod.outlook.com (20.179.8.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 26 Sep 2019 13:11:55 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Thu, 26 Sep 2019
 13:11:55 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 16/22] iotests: Use complete_and_wait() in 155
Thread-Topic: [PATCH 16/22] iotests: Use complete_and_wait() in 155
Thread-Index: AQHVb82pky6TSxjYVUCjxbmTCCB4yqc9+FKA
Date: Thu, 26 Sep 2019 13:11:54 +0000
Message-ID: <ae7d50ee-170b-94da-349d-2fbdbc3a357d@virtuozzo.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-17-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-17-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0048.eurprd08.prod.outlook.com (10.170.248.147) To
 DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190926161153014
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 107955d6-5304-44b3-4a43-08d742831a5e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB3945; 
x-ms-traffictypediagnostic: DB8PR08MB3945:
x-microsoft-antispam-prvs: <DB8PR08MB3945847F41F54F002239CE6CC1860@DB8PR08MB3945.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39850400004)(396003)(366004)(136003)(376002)(199004)(189003)(11346002)(52116002)(476003)(76176011)(486006)(7736002)(478600001)(3846002)(6246003)(446003)(2616005)(6506007)(386003)(81156014)(81166006)(8936002)(6512007)(36756003)(99286004)(186003)(26005)(305945005)(102836004)(8676002)(25786009)(110136005)(54906003)(6116002)(316002)(5660300002)(2906002)(64756008)(66556008)(229853002)(31696002)(71200400001)(66446008)(66946007)(66476007)(14454004)(66066001)(6436002)(4326008)(71190400001)(2501003)(31686004)(86362001)(256004)(6486002)(558084003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3945;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NrJiCh//4uONfZIFoKugvYHuKS0yyOThq5QtcQV/w6uhT0lOL4VLAAfoq6TdlAtqLBZLfH/uRr+EACDCQ5kpOxpKIZMzLbMuABL0PRS2eqJVSVre7cNWkJFfZQc13q799epzkox9VllhV9HTAAMRgxxNhSEWMqFWapTLXdtkmszwDaGFBsJl5nNWdlr1A0Axd0LaKM2lpnqBvNOFjcUTUsHHg+VX7UipHPbbeOChEEldHIUVv1YEgD5i+2PKEVp9dn2TtmDyigxR5m2qOapmHcHYCK2iFGMbY9sPjKA1o8srB6ty8pw2MBQKSrtlsQ38vBXb7Nxfp7WLhraUhuP8avVx/k3iZAlFltr1FBz8a5U4kOKJzCBj89CJvgcD/8HPBSYwipMORH51zzlvuB5Og7IvAEh3DN5EKs7/qFW6gUM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FEDB71D84C58042BB5E78225985AD44@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107955d6-5304-44b3-4a43-08d742831a5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 13:11:54.8802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y0j67QFFV4SU4vjXSl7/9ZQPGAgiLOXgozR3KZQAJux6MgmmdBgjb9l4cdQhSX/OQwOyzuIOFa4ki9hHOy9DGgWtoC2j+/OVliG7HgrAkzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3945
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.133
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

MjAuMDkuMjAxOSAxODoyNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBUaGlzIHdheSwgd2UgZ2V0IHRv
IHNlZSBlcnJvcnMgZHVyaW5nIHRoZSBjb21wbGV0aW9uIHBoYXNlLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTWF4IFJlaXR6PG1yZWl0ekByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogVmxhZGlt
aXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQotLSAN
CkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

