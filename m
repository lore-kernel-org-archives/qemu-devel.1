Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDB5C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1797E208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Yy+j0SHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1797E208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47348 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQWNQ-0000LB-9e
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 08:17:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hQWGr-0003Pc-5O
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hQWGp-00024a-N5
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:11:01 -0400
Received: from mail-ve1eur01on072b.outbound.protection.outlook.com
	([2a01:111:f400:fe1f::72b]:39198
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1hQWGk-0001pj-6h; Tue, 14 May 2019 08:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ZdMZapHQp3Vidfmzw0RIi6/r8xvt8tB0Bl5ST/5EBe0=;
	b=Yy+j0SHdi8zQV+veQAfzJHSSCpjEnyGQqO1vYSEd0/ljuEub1VJhO67Pb77XI4lmQkUsKuMcbX4pjj1Pakl2N48GBYqS15rCiKA/8M14T1IJGKsHKYZg1m4kDjKfZcUgt6eUOecckUT8y4BVaQ7nvRnUVlDxvSE0TWY9TSJS4M4=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
	VI1PR08MB4480.eurprd08.prod.outlook.com (20.179.27.22) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.16; Tue, 14 May 2019 12:10:43 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::8ce8:ffb4:fe9:4900]) by VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::8ce8:ffb4:fe9:4900%3]) with mapi id 15.20.1878.024;
	Tue, 14 May 2019 12:10:43 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v7 3/9] block: add empty account cookie type
Thread-Index: AQHVCk4Of4uBzUzUXUyD4Gm3vKa2lA==
Date: Tue, 14 May 2019 12:10:43 +0000
Message-ID: <20190514121015.32190-4-anton.nefedov@virtuozzo.com>
References: <20190514121015.32190-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20190514121015.32190-1-anton.nefedov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0057.eurprd07.prod.outlook.com
	(2603:10a6:3:9e::25) To VI1PR08MB4078.eurprd08.prod.outlook.com
	(2603:10a6:803:e5::28)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=anton.nefedov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f81cc88-8fdc-4695-b39e-08d6d8653064
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:VI1PR08MB4480; 
x-ms-traffictypediagnostic: VI1PR08MB4480:
x-microsoft-antispam-prvs: <VI1PR08MB448051DDCC7E6D48B408D79BF8080@VI1PR08MB4480.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(366004)(136003)(396003)(376002)(39850400004)(189003)(199004)(186003)(86362001)(6116002)(486006)(15650500001)(3846002)(66066001)(4326008)(256004)(52116002)(316002)(26005)(44832011)(36756003)(6512007)(6486002)(25786009)(6506007)(14444005)(478600001)(102836004)(6916009)(386003)(2351001)(54906003)(76176011)(64756008)(66446008)(66556008)(5640700003)(7736002)(14454004)(2616005)(2906002)(73956011)(53936002)(476003)(71190400001)(446003)(71200400001)(11346002)(99286004)(107886003)(66946007)(66476007)(2501003)(305945005)(6436002)(8936002)(1076003)(81166006)(81156014)(8676002)(5660300002)(50226002)(68736007);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4480;
	H:VI1PR08MB4078.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +F3JImuiap+XXelbQufBrq8lVik+4i0yTUdqn5PN2S1V8MNDUlggK5xZ20Bo0CxeESeyOz5ooX0K3+NROuAB1juCF1WOLDTyuLho2ejmZQC5H2juqVdYFkGZxHx6z1aoG5kpgwd/j19P6ykxYzyD+oBwkSRQ9IYqcYORfftl1bstqHlcY/URxAY/XEBx+g1A7aEhr29mbQ6I0Lj7pVYvNEQs5FsyDUpp1ZXnx+9VU7saHrxdllSiTEExC7Dy2X+WOWh6UONdEd8wcYY0f3roF9nIs5n88ZmhCHXFAOjjxXTbHXy4HEW//+c4JjSNXR0obSWEDkLcNONZ9z9NiDm6LUCEmHh/kp8vgMauJXeIq80dUzR5TO+pSGTYNxMXAxH4i9Z/7aFeaTaMIw+RSDs7G+sRCHEYeAUbps9MMVuK5v4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f81cc88-8fdc-4695-b39e-08d6d8653064
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 12:10:43.7918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4480
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::72b
Subject: [Qemu-devel] [PATCH v7 3/9] block: add empty account cookie type
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	Anton Nefedov <anton.nefedov@virtuozzo.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhpcyBhZGRzIHNvbWUgcHJvdGVjdGlvbiBmcm9tIGFjY291bnRpbmcgdW5pbml0aWFsaXplZCBj
b29raWUuDQpUaGF0IGlzLCBibG9ja19hY2N0X2ZhaWxlZC9kb25lIHdpdGhvdXQgcHJldmlvdXMg
YmxvY2tfYWNjdF9zdGFydDsNCmluIHRoYXQgY2FzZSwgY29va2llIHByb2JhYmx5IGhvbGRzIHZh
bHVlcyBmcm9tIHByZXZpb3VzIG9wZXJhdGlvbi4NCg0KKE5vdGU6IGl0IG1pZ2h0IGFsc28gYmUg
dW5pbml0aWFsaXplZCBob2xkaW5nIGdhcmJhZ2UgdmFsdWUgYW5kIHRoZXJlIGlzDQogc3RpbGwg
IjwgQkxPQ0tfTUFYX0lPVFlQRSIgYXNzZXJ0aW9uIGZvciB0aGF0Lg0KIFNvIGJsb2NrX2FjY3Rf
ZmFpbGVkL2RvbmUgd2l0aG91dCBwcmV2aW91cyBibG9ja19hY2N0X3N0YXJ0IHNob3VsZCBiZSB1
c2VkDQogd2l0aCBjYXV0aW9uLikNCg0KQ3VycmVudGx5IHRoaXMgaXMgcGFydGljdWxhcmx5IHVz
ZWZ1bCBpbiBpZGUgY29kZSB3aGVyZSBpdCdzIGhhcmQgdG8NCmtlZXAgdHJhY2sgd2hldGhlciB0
aGUgcmVxdWVzdCBzdGFydGVkIGFjY291bnRpbmcgb3Igbm90LiBGb3IgZXhhbXBsZSwNCnRyaW0g
cmVxdWVzdHMgZG8gdGhlIGFjY291bnRpbmcgc2VwYXJhdGVseS4NCg0KU2lnbmVkLW9mZi1ieTog
QW50b24gTmVmZWRvdiA8YW50b24ubmVmZWRvdkB2aXJ0dW96em8uY29tPg0KLS0tDQogaW5jbHVk
ZS9ibG9jay9hY2NvdW50aW5nLmggfCAxICsNCiBibG9jay9hY2NvdW50aW5nLmMgICAgICAgICB8
IDYgKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdp
dCBhL2luY2x1ZGUvYmxvY2svYWNjb3VudGluZy5oIGIvaW5jbHVkZS9ibG9jay9hY2NvdW50aW5n
LmgNCmluZGV4IGJhOGIwNGQ1NzIuLjg3OGI0YzM1ODEgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2Js
b2NrL2FjY291bnRpbmcuaA0KKysrIGIvaW5jbHVkZS9ibG9jay9hY2NvdW50aW5nLmgNCkBAIC0z
Myw2ICszMyw3IEBAIHR5cGVkZWYgc3RydWN0IEJsb2NrQWNjdFRpbWVkU3RhdHMgQmxvY2tBY2N0
VGltZWRTdGF0czsNCiB0eXBlZGVmIHN0cnVjdCBCbG9ja0FjY3RTdGF0cyBCbG9ja0FjY3RTdGF0
czsNCiANCiBlbnVtIEJsb2NrQWNjdFR5cGUgew0KKyAgICBCTE9DS19BQ0NUX05PTkUgPSAwLA0K
ICAgICBCTE9DS19BQ0NUX1JFQUQsDQogICAgIEJMT0NLX0FDQ1RfV1JJVEUsDQogICAgIEJMT0NL
X0FDQ1RfRkxVU0gsDQpkaWZmIC0tZ2l0IGEvYmxvY2svYWNjb3VudGluZy5jIGIvYmxvY2svYWNj
b3VudGluZy5jDQppbmRleCA3MGEzZDlhNDI2Li44ZDQxYzhhODNhIDEwMDY0NA0KLS0tIGEvYmxv
Y2svYWNjb3VudGluZy5jDQorKysgYi9ibG9jay9hY2NvdW50aW5nLmMNCkBAIC0xOTUsNiArMTk1
LDEwIEBAIHN0YXRpYyB2b2lkIGJsb2NrX2FjY291bnRfb25lX2lvKEJsb2NrQWNjdFN0YXRzICpz
dGF0cywgQmxvY2tBY2N0Q29va2llICpjb29raWUsDQogDQogICAgIGFzc2VydChjb29raWUtPnR5
cGUgPCBCTE9DS19NQVhfSU9UWVBFKTsNCiANCisgICAgaWYgKGNvb2tpZS0+dHlwZSA9PSBCTE9D
S19BQ0NUX05PTkUpIHsNCisgICAgICAgIHJldHVybjsNCisgICAgfQ0KKw0KICAgICBxZW11X211
dGV4X2xvY2soJnN0YXRzLT5sb2NrKTsNCiANCiAgICAgaWYgKGZhaWxlZCkgew0KQEAgLTIxNyw2
ICsyMjEsOCBAQCBzdGF0aWMgdm9pZCBibG9ja19hY2NvdW50X29uZV9pbyhCbG9ja0FjY3RTdGF0
cyAqc3RhdHMsIEJsb2NrQWNjdENvb2tpZSAqY29va2llLA0KICAgICB9DQogDQogICAgIHFlbXVf
bXV0ZXhfdW5sb2NrKCZzdGF0cy0+bG9jayk7DQorDQorICAgIGNvb2tpZS0+dHlwZSA9IEJMT0NL
X0FDQ1RfTk9ORTsNCiB9DQogDQogdm9pZCBibG9ja19hY2N0X2RvbmUoQmxvY2tBY2N0U3RhdHMg
KnN0YXRzLCBCbG9ja0FjY3RDb29raWUgKmNvb2tpZSkNCi0tIA0KMi4xNy4xDQoNCg==

