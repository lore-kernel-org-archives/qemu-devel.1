Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FE3C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 14:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB4221D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 14:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MGNwyX+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB4221D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDUzK-0000vW-Ep
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 10:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDUyD-0000Mx-7Y
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDUyA-0008Dj-82
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:42:11 -0400
Received: from mail-eopbgr10118.outbound.protection.outlook.com
 ([40.107.1.118]:21230 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDUy9-0008Cv-G0; Thu, 26 Sep 2019 10:42:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOhxcQ4stF/MoZfHbid+3B4k5/Alt7dX5bAJp3OEqNKIhq8iDXMTe0VexnGTbZ1T2VZrWf6nXMXMnK+L44Bm2wEezVCvaC4x/DnbMe7FloVkQCFKLJHtDAlP5d6aZYfGZKhIwuz6ZIv/cRGJ2IC+jqPUpIuUXkFxVBL2OWTNJUbApJaoMvWd9AicypsNbkrVbqSUTrceRs+zMfW60PjD0TeZS+jQ/W4gjRYjGn2H23AmtCeU5FiO5NYD8qa89Zl2vvjFo5y2m1O4awmctl0Oc04GKMBGOhguaPxitEip7i0SB0U9/wD0N9R06RFF6liQZ7Fy0XNLSXCMD0umJuXVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8jRnmJ1lBK/Cp7D85yUh0enh5q7w1MwM/PYXEFdqRU=;
 b=MC4nZkOTOLv74slRgZXEXs487FmVw8ND3Wg1ii3mjJfPXFEMdJOlwSNkgkKZ1ztlg1JCoqTEx0osSUBV6UfK51QQ0epjUipoRNa5lMZdYry5iDctd7scm3dr3b4N719b0nWT5z4ZBBJhh4pQ3ZEDlmis03MyH4YmkQjBnVSVKrtazX9KMQONDz8wcXMGgukUj+aEVwRtpLuYT+f80Wv6Dr2aogfSb4EuOvZoMfJNmt8Ruh3IeQpAECfZIglI0LYAIM14/PV2zWDpWgfXxbKkLGVD4e4tB1bXBBFglNp4Ko9n5OV3bGM3UaXO/qzzWoyid4n+qVwGKv8njACQKuOHRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8jRnmJ1lBK/Cp7D85yUh0enh5q7w1MwM/PYXEFdqRU=;
 b=MGNwyX+YaD9VCLewoOYgX1Tt/olWmIFjYUQmSJXgSb3JfWKx1RILMP1NUmEKzgqLizkaPcALaDHU9Mbf0pYZgti9cxYPZmpiLJWbBccLtYiIRbwgjM6PCuFuSo25nyKmx1/fy5s9DoIaoLtAg/YxKXBcVk9urmzL6KpHSAoaxQQ=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5162.eurprd08.prod.outlook.com (10.255.19.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Thu, 26 Sep 2019 14:42:06 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Thu, 26 Sep 2019
 14:42:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 21/22] iotests: Check that @replaces can replace filters
Thread-Topic: [PATCH 21/22] iotests: Check that @replaces can replace filters
Thread-Index: AQHVb8t30SgM4heSgUm0nrWrCUNAxKc+EYkA
Date: Thu, 26 Sep 2019 14:42:06 +0000
Message-ID: <fb14d633-3e55-facc-f8af-91ea9475fb59@virtuozzo.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-22-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-22-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0011.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::21) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190926174203979
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7727b73d-6868-463f-bcda-08d7428fb3c5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5162; 
x-ms-traffictypediagnostic: DB8PR08MB5162:
x-microsoft-antispam-prvs: <DB8PR08MB5162A1B09F4163F11C2839C5C1860@DB8PR08MB5162.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(366004)(376002)(39850400004)(396003)(189003)(199004)(478600001)(6116002)(11346002)(446003)(476003)(2616005)(71190400001)(71200400001)(186003)(3846002)(256004)(486006)(102836004)(26005)(99286004)(2501003)(6512007)(8936002)(66066001)(36756003)(6506007)(52116002)(229853002)(66476007)(66946007)(31686004)(66446008)(76176011)(64756008)(66556008)(25786009)(6246003)(81166006)(81156014)(2906002)(6486002)(8676002)(4326008)(386003)(86362001)(305945005)(5660300002)(6436002)(31696002)(110136005)(14454004)(54906003)(7736002)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5162;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +gnReQycuR9S/DeWjJWBkLCKNO/ngDS4RZUhi6MBO5fBGRq6IdoVbXiNkw5VTz1oACHj702YKqLJBz3UElp1RIdnOXpAfQ1Z8QLx6KvbJerNyXijKdnqnScPQAr21yS+l9yOd/fRS3hNODGJ8Gt4ltqLkGGVDoh7WBVg4o2FVkTdQ1eddnrrSe1kQADxRgGcZsPN2vB9ciiCE5vEMZtfPOpYFwWr2ZlTDtaSbIzNp27zT6JeocJjQIfLNRX5OMfW4+wz5fEXnzUMxLChsuVhnATFVuKSrI+JS7SR1LvJ+rwFNx9H7OWf+6gl03dgRmh9yyZV9crsaqOKxp4CzgwyGl9OuWnTorsU4UBtFiUSmNlVCUM0hEFOpDXikQG2p+0FATU34CUsyUKc+YFVrGbGOmbE4IlROQG3rXmf+JjZn7E=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F41C0BBB842E4438CEC2482DEDC0E93@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7727b73d-6868-463f-bcda-08d7428fb3c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 14:42:06.1532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z3TERO+sTilZDGVBzEXInrrUPCRvPIkP/wvREFeWRw1jBrOyWX94YENOHNf4PZnRX1RW7WmvKxeCqExeOjqIgqIkOegvZ8bSoUp/g3+NJMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5162
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.118
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

MjAuMDkuMjAxOSAxODoyOCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXgg
UmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPiAtLS0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMv
MDQxICAgICB8IDQ1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAg
dGVzdHMvcWVtdS1pb3Rlc3RzLzA0MS5vdXQgfCAgNCArKy0tDQo+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCA0NyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rl
c3RzL3FlbXUtaW90ZXN0cy8wNDEgYi90ZXN0cy9xZW11LWlvdGVzdHMvMDQxDQo+IGluZGV4IDE0
OGRjNDdjZTQuLmU0Y2M4MjlmZTIgMTAwNzU1DQo+IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8w
NDENCj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzA0MQ0KPiBAQCAtMTIyMCw2ICsxMjIwLDUx
IEBAIGNsYXNzIFRlc3RPcnBoYW5lZFNvdXJjZShpb3Rlc3RzLlFNUFRlc3RDYXNlKToNCj4gICAg
ICAgICAgIHNlbGYuYXNzZXJ0RmFsc2UoJ21pcnJvci1maWx0ZXInIGluIG5vZGVzLA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAnTWlycm9yIGZpbHRlciBub2RlIGRpZCBub3QgZGlzYXBw
ZWFyJykNCj4gICANCj4gKyMgVGVzdCBjYXNlcyBmb3IgQHJlcGxhY2VzIHRoYXQgZG8gbm90IG5l
Y2Vzc2FyaWx5IGludm9sdmUgUXVvcnVtDQo+ICtjbGFzcyBUZXN0UmVwbGFjZXMoaW90ZXN0cy5R
TVBUZXN0Q2FzZSk6DQo+ICsgICAgIyBFYWNoIG9mIHRoZXNlIHRlc3QgY2FzZXMgbmVlZHMgdGhl
aXIgb3duIGJsb2NrIGdyYXBoLCBzbyBkbyBub3QNCj4gKyAgICAjIGNyZWF0ZSBhbnkgbm9kZXMg
aGVyZQ0KPiArICAgIGRlZiBzZXRVcChzZWxmKToNCj4gKyAgICAgICAgc2VsZi52bSA9IGlvdGVz
dHMuVk0oKQ0KPiArICAgICAgICBzZWxmLnZtLmxhdW5jaCgpDQo+ICsNCj4gKyAgICBkZWYgdGVh
ckRvd24oc2VsZik6DQo+ICsgICAgICAgIHNlbGYudm0uc2h1dGRvd24oKQ0KPiArICAgICAgICBm
b3IgaW1nIGluICh0ZXN0X2ltZywgdGFyZ2V0X2ltZyk6DQo+ICsgICAgICAgICAgICB0cnk6DQo+
ICsgICAgICAgICAgICAgICAgb3MucmVtb3ZlKGltZykNCj4gKyAgICAgICAgICAgIGV4Y2VwdCBP
U0Vycm9yOg0KPiArICAgICAgICAgICAgICAgIHBhc3MNCg0KZGVhZCBjb2RlLCBidXQgbWF5IGJl
IHVzZWQgaW4gZnV0dXJlIHBhdGNoLi4NCg0KPiArDQo+ICsgICAgJycnDQo+ICsgICAgQ2hlY2sg
dGhhdCB3ZSBjYW4gcmVwbGFjZSBmaWx0ZXIgbm9kZXMuDQo+ICsgICAgJycnDQo+ICsgICAgZGVm
IHRlc3RfcmVwbGFjZV9maWx0ZXIoc2VsZik6DQo+ICsgICAgICAgIHJlc3VsdCA9IHNlbGYudm0u
cW1wKCdibG9ja2Rldi1hZGQnLCAqKnsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICdkcml2ZXInOiAnY29weS1vbi1yZWFkJywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICdub2RlLW5hbWUnOiAnZmlsdGVyMCcsDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAnZmlsZSc6IHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAnZHJpdmVyJzogJ2NvcHktb24tcmVhZCcsDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgJ25vZGUtbmFtZSc6ICdmaWx0ZXIxJywNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAnZmlsZSc6IHsNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJ2RyaXZlcic6ICdudWxsLWNvJw0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfSkNCj4gKyAgICAg
ICAgc2VsZi5hc3NlcnRfcW1wKHJlc3VsdCwgJ3JldHVybicsIHt9KQ0KPiArDQo+ICsgICAgICAg
IHJlc3VsdCA9IHNlbGYudm0ucW1wKCdibG9ja2Rldi1hZGQnLA0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBub2RlX25hbWU9J3RhcmdldCcsIGRyaXZlcj0nbnVsbC1jbycpDQo+ICsg
ICAgICAgIHNlbGYuYXNzZXJ0X3FtcChyZXN1bHQsICdyZXR1cm4nLCB7fSkNCj4gKw0KPiArICAg
ICAgICByZXN1bHQgPSBzZWxmLnZtLnFtcCgnYmxvY2tkZXYtbWlycm9yJywgam9iX2lkPSdtaXJy
b3InLCBkZXZpY2U9J2ZpbHRlcjAnLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0
YXJnZXQ9J3RhcmdldCcsIHN5bmM9J2Z1bGwnLCByZXBsYWNlcz0nZmlsdGVyMScpDQo+ICsgICAg
ICAgIHNlbGYuYXNzZXJ0X3FtcChyZXN1bHQsICdyZXR1cm4nLCB7fSkNCj4gKw0KPiArICAgICAg
ICBzZWxmLmNvbXBsZXRlX2FuZF93YWl0KCdtaXJyb3InKQ0KPiArDQo+ICsgICAgICAgIHNlbGYu
dm0uYXNzZXJ0X2Jsb2NrX3BhdGgoJ2ZpbHRlcjAvZmlsZScsICd0YXJnZXQnKQ0KPiArDQo+ICAg
aWYgX19uYW1lX18gPT0gJ19fbWFpbl9fJzoNCj4gICAgICAgaW90ZXN0cy5tYWluKHN1cHBvcnRl
ZF9mbXRzPVsncWNvdzInLCAncWVkJ10sDQo+ICAgICAgICAgICAgICAgICAgICBzdXBwb3J0ZWRf
cHJvdG9jb2xzPVsnZmlsZSddKQ0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzA0
MS5vdXQgYi90ZXN0cy9xZW11LWlvdGVzdHMvMDQxLm91dA0KPiBpbmRleCBmZmM3NzliNGQxLi44
NzdiNzZmZDMxIDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMDQxLm91dA0KPiAr
KysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMDQxLm91dA0KPiBAQCAtMSw1ICsxLDUgQEANCj4gLS4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLg0KPiArLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLg0KPiAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gLVJhbiA5MyB0ZXN0cw0K
PiArUmFuIDk0IHRlc3RzDQo+ICAgDQo+ICAgT0sNCj4gDQoNClJldmlld2VkLWJ5OiBWbGFkaW1p
ciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCi0tIA0K
QmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

