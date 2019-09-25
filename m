Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8E1C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:48:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F2E21D81
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="X9xZ4k7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F2E21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD7eo-0007ar-CQ
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 09:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD7cA-000512-Dn
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD7c5-0000xQ-NW
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:45:53 -0400
Received: from mail-he1eur04on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::703]:55542
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iD7bz-0000vE-1T; Wed, 25 Sep 2019 09:45:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gp8iKryZb3H7mrfmuOfyOpx8gI8diXA4u4xx2kvbogAgk3JSDd/O/lixDoK50y5e6MAjnOCudg6qfqLreP85IzUzl4Sxkd14TZSv8eGHhv7Ww23fONT92PFVbkMGvDIm7YHEemi9Fy9ub2/OKK3+ylw/zYhCNZezJ+Qk3G6osrJ1XC+2e79SiRMnoMj9SJPMOb2CmTQe28/3+mrjAy7MV0PMLRvl6/TyWNkk6TWBF3cpj43w9744BSCGJm3m6tB/7hWJ0nk5Xjrit19OOLBvOWxw26GKtplF/SGq7NBrfle9DL//6zNKbcz7cy/iyRn/z80nGiBmB08Yk7zPUKRBrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9jCwQ/Y3mUUlAfe6Yn4N7D+foyBK+LEJt5xmP+5rlg=;
 b=SwZSK6JmPoRzoCiY+YxtUq1py35/U5VeFLGcnTxd5poAtigcTxPHM1owhkYq3IuTpeLs5b5wEyssKsf+pxZolXDIJLeWA+xNSIvAPMsiZ6mH6loMahHVjj1hmYPexj5NXlU0dumBjzkJP88fWLtCioHHisWtYxeEzHxXKAuKfRvzIWcWfGhQOIh4mgzvpsUAY474+arkipjhvSm0NSnRd8kqSeUQcXJ3mawcntPlpz6kC83GFWJNqfHifKoj+U6CacSyQ3umGXmOg67QGehsqznArS2EnHdCpqRWjslk3Vi9UhnH7H9CYNpVV0vscQXVbtlywKcLo6hCRinLY0XpzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9jCwQ/Y3mUUlAfe6Yn4N7D+foyBK+LEJt5xmP+5rlg=;
 b=X9xZ4k7FHRDZNCid6IlUvkEjL73Ej7yeYEcurbKPoOFNIj+R9YEo4VvhshygdI1qgW2GW18SuzLeipgDsVjohN/Voew4PJ09UvO/9GtVY+pXx1ucR0MoIpL98otPpPpDYqzu3dsjS4z6RsfBwbFpBlE/ODqHDf/sRHDWnR19Bxc=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5210.eurprd08.prod.outlook.com (10.255.17.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Wed, 25 Sep 2019 13:45:37 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 13:45:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 09/22] quorum: Add QuorumChild.to_be_replaced
Thread-Topic: [PATCH 09/22] quorum: Add QuorumChild.to_be_replaced
Thread-Index: AQHVb8qhsxRzhPv/+UedyHZu4dzd2ac8b26A
Date: Wed, 25 Sep 2019 13:45:37 +0000
Message-ID: <c5ae76f5-9b41-a00b-ef92-d419e334f660@virtuozzo.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-10-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-10-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0377.eurprd05.prod.outlook.com
 (2603:10a6:7:94::36) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190925164535562
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f4e99d3-fba0-4785-b14e-08d741bea5a5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5210; 
x-ms-traffictypediagnostic: DB8PR08MB5210:
x-microsoft-antispam-prvs: <DB8PR08MB5210FDB04651DEF5C2CF4C54C1870@DB8PR08MB5210.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:250;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(366004)(396003)(39850400004)(136003)(189003)(199004)(102836004)(256004)(31696002)(31686004)(386003)(14444005)(7736002)(86362001)(110136005)(305945005)(54906003)(6116002)(14454004)(81166006)(6246003)(2906002)(76176011)(5660300002)(6506007)(478600001)(316002)(99286004)(2501003)(8676002)(81156014)(6436002)(52116002)(8936002)(229853002)(476003)(71200400001)(446003)(66476007)(66556008)(66446008)(66946007)(3846002)(66066001)(6486002)(25786009)(36756003)(186003)(11346002)(6512007)(64756008)(71190400001)(2616005)(4326008)(486006)(26005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5210;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ch6XN0Si9lWIE9krvy0hRH6toeOHnJsz4Krc1bNGywvxUEPFj8uVGNH6Yl0kcvJjQlLybydLeM3jNvYObo3STiV3+Jy97QyKzBNnyejYVz18DF82mVhlNh+YlOlCXOTpl7+Nr0G0wqpXe/9RQ5BhQqZTE0o9+kLfvsFDttk6cCG2TAToPeFWy1Qjaa1aord/QWTij7ciJsKvOwVub89Eb41sBgxXBtyH4fKyhP0/KYoLsNY8aTWkDqteH788jPad1/OmbkKGjuD5epVSCyjgfekHUYz62bNb7goUHRzQtFNDrZ+p/v9cKcIpiEi6vHAtmJfk67TuctG4wn8jU6dxw8I88pFflkpKiHLhvDgMwwi9Bs1VNZ0xFd3Nhv1elngR2jdx25DB0+fjc8FdK/2JZpXQr1XTkKE5ezhOIabEln4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <915BA97CA8A67D4BBF98958167FF53F7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4e99d3-fba0-4785-b14e-08d741bea5a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 13:45:37.6576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DR4ujldv+1MxgaTwFeRYe06AyjjxacuiFoF2xtadeGi+/pItc+l/DvlAibVfk0kAEWvi6tMuJOl/BNmX69DCYkXUnRJwIaOHPF3a5Iv7VdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5210
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0d::703
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

MjAuMDkuMjAxOSAxODoyNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBXZSB3aWxsIG5lZWQgdGhpcyB0
byB2ZXJpZnkgdGhhdCBRdW9ydW0gY2FuIGxldCBvbmUgb2YgaXRzIGNoaWxkcmVuIGJlDQo+IHJl
cGxhY2VkIHdpdGhvdXQgYnJlYWtpbmcgYW55dGhpbmcgZWxzZS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIGJsb2NrL3F1b3J1
bS5jIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMjMg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL3F1b3J1bS5jIGIvYmxvY2sv
cXVvcnVtLmMNCj4gaW5kZXggY2YyMTcxY2M3NC4uMjA3MDU0YTY0ZSAxMDA2NDQNCj4gLS0tIGEv
YmxvY2svcXVvcnVtLmMNCj4gKysrIGIvYmxvY2svcXVvcnVtLmMNCj4gQEAgLTY3LDYgKzY3LDEz
IEBAIHR5cGVkZWYgc3RydWN0IFF1b3J1bVZvdGVzIHsNCj4gICANCj4gICB0eXBlZGVmIHN0cnVj
dCBRdW9ydW1DaGlsZCB7DQo+ICAgICAgIEJkcnZDaGlsZCAqY2hpbGQ7DQo+ICsNCj4gKyAgICAv
Kg0KPiArICAgICAqIElmIHNldCwgY2hlY2sgd2hldGhlciB0aGlzIG5vZGUgY2FuIGJlIHJlcGxh
Y2VkIHdpdGhvdXQgYW55DQo+ICsgICAgICogb3RoZXIgcGFyZW50IG5vdGljaW5nOiBVbnNoYXJl
IENPTlNJU1RFTlRfUkVBRCwgYW5kIHRha2UgdGhlDQo+ICsgICAgICogV1JJVEUgcGVybWlzc2lv
bi4NCj4gKyAgICAgKi8NCj4gKyAgICBib29sIHRvX2JlX3JlcGxhY2VkOw0KPiAgIH0gUXVvcnVt
Q2hpbGQ7DQo+ICAgDQo+ICAgLyogdGhlIGZvbGxvd2luZyBzdHJ1Y3R1cmUgaG9sZHMgdGhlIHN0
YXRlIG9mIG9uZSBxdW9ydW0gaW5zdGFuY2UgKi8NCj4gQEAgLTExMjgsNiArMTEzNSwxNiBAQCBz
dGF0aWMgdm9pZCBxdW9ydW1fY2hpbGRfcGVybShCbG9ja0RyaXZlclN0YXRlICpicywgQmRydkNo
aWxkICpjLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IHBlcm0s
IHVpbnQ2NF90IHNoYXJlZCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50
NjRfdCAqbnBlcm0sIHVpbnQ2NF90ICpuc2hhcmVkKQ0KPiAgIHsNCj4gKyAgICBCRFJWUXVvcnVt
U3RhdGUgKnMgPSBicy0+b3BhcXVlOw0KPiArICAgIGludCBpOw0KPiArDQo+ICsgICAgZm9yIChp
ID0gMDsgaSA8IHMtPm51bV9jaGlsZHJlbjsgaSsrKSB7DQo+ICsgICAgICAgIGlmIChzLT5jaGls
ZHJlbltpXS5jaGlsZCA9PSBjKSB7DQo+ICsgICAgICAgICAgICBicmVhazsNCj4gKyAgICAgICAg
fQ0KPiArICAgIH0NCj4gKyAgICBhc3NlcnQoIWMgfHwgaSA8IHMtPm51bV9jaGlsZHJlbik7DQoN
CnNlZW1zLCB0aGUgbG9vcCBpcyB1c2VsZXNzIGlmIGMgPT0gTlVMTC4NCg0KPiArDQo+ICAgICAg
ICpucGVybSA9IHBlcm0gJiBERUZBVUxUX1BFUk1fUEFTU1RIUk9VR0g7DQo+ICAgDQo+ICAgICAg
IC8qDQo+IEBAIC0xMTM3LDYgKzExNTQsMTIgQEAgc3RhdGljIHZvaWQgcXVvcnVtX2NoaWxkX3Bl
cm0oQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIEJkcnZDaGlsZCAqYywNCj4gICAgICAgKm5zaGFyZWQg
PSAoc2hhcmVkICYgKEJMS19QRVJNX0NPTlNJU1RFTlRfUkVBRCB8DQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBCTEtfUEVSTV9XUklURV9VTkNIQU5HRUQpKQ0KPiAgICAgICAgICAgICAg
ICB8IERFRkFVTFRfUEVSTV9VTkNIQU5HRUQ7DQo+ICsNCj4gKyAgICBpZiAoYyAmJiBzLT5jaGls
ZHJlbltpXS50b19iZV9yZXBsYWNlZCkgew0KPiArICAgICAgICAvKiBQcmVwYXJlIGZvciBzdWRk
ZW4gZGF0YSBjaGFuZ2VzICovDQo+ICsgICAgICAgICpucGVybSB8PSBCTEtfUEVSTV9XUklURTsN
Cj4gKyAgICAgICAgKm5zaGFyZWQgJj0gfkJMS19QRVJNX0NPTlNJU1RFTlRfUkVBRDsNCj4gKyAg
ICB9DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyBjb25zdCBjaGFyICpjb25zdCBxdW9ydW1fc3Ry
b25nX3J1bnRpbWVfb3B0c1tdID0gew0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRp
bWlyDQo=

