Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B74C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 05:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B78B120873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 05:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78B120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45506 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM4V3-0001lm-Lw
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 01:43:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hM4TT-0000kw-VY
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hM4TR-0003Jd-5C
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:41:39 -0400
Received: from mail-hk2apc01olkn0805.outbound.protection.outlook.com
	([2a01:111:f400:febc::805]:22687
	helo=APC01-HK2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistair@alistair23.me>)
	id 1hM4TD-0002vl-90
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:41:29 -0400
Received: from SG2APC01FT014.eop-APC01.prod.protection.outlook.com
	(10.152.250.51) by SG2APC01HT121.eop-APC01.prod.protection.outlook.com
	(10.152.251.206) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1835.13;
	Thu, 2 May 2019 05:40:34 +0000
Received: from PSXP216MB0277.KORP216.PROD.OUTLOOK.COM (10.152.250.58) by
	SG2APC01FT014.mail.protection.outlook.com (10.152.250.188) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.13 via Frontend Transport; Thu, 2 May 2019 05:40:34 +0000
Received: from PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
	([fe80::d5cf:d2af:3aea:e2a3]) by PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
	([fe80::d5cf:d2af:3aea:e2a3%3]) with mapi id 15.20.1856.008;
	Thu, 2 May 2019 05:40:34 +0000
From: Alistair Francis <alistair@alistair23.me>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v1 0/5]  Add the STM32F405 and Netduino Plus 2 machine
Thread-Index: AQHVAKmP1wzVv6HtkUGCn4ebIHsq8Q==
Date: Thu, 2 May 2019 05:40:34 +0000
Message-ID:
 <PSXP216MB02777FF1122DB78DEC580ACEDD340@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0036.namprd04.prod.outlook.com
	(2603:10b6:a03:40::49) To PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
	(2603:1096:300:a::18)
x-incomingtopheadermarker: OriginalChecksum:281F37AF3AB090D567B66DE789D84308973A90C99ABCBCE0F8E2C6A4BE49A5D6;
	UpperCasedChecksum:71C59ACA2B4EF137ED833927CBD3378AAFCFFC6D32C064C8CFFF4E7A5E5EEC4F;
	SizeAsReceived:7437; Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-tmn: [sCjrnCgKUyCH3NQHRsdFS588KTHOVcQF2LHJsYUhWnjMEmTynGoNK0Bh2Es/VzN8]
x-microsoft-original-message-id: <cover.1556774049.git.alistair@alistair23.me>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
	SRVR:SG2APC01HT121; 
x-ms-traffictypediagnostic: SG2APC01HT121:
x-microsoft-antispam-message-info: RH3iBgxysQfXQbkWkYnCHi1CI3iePW9hbU73b7sGJ2NKDn+1zX+nkwjt9jz6+rEMHt4tttFNEVtHCqIE3+CV5vS1cbaJli7yVUQgwq/ALZVKyqKqX5TD09TSJporyB48rQ4NE0D9WgpjjKC6Q9YR5P/ZsQpcXEXvB5Xg38wU7ma3JH+LJ1p4KDaBnrj7a0TR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d31494a7-9d8d-4ac3-9c8e-08d6cec0b1c4
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 05:40:34.7132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT121
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:febc::805
Subject: [Qemu-devel] [PATCH v1 0/5] Add the STM32F405 and Netduino Plus 2
 machine
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
Cc: "alistair23@gmail.com" <alistair23@gmail.com>,
	"peter.maydell@linaro.org" <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502054034.nLW-68WgEOaq3oNf8PNgugHKeLetkjvFxm9cbcjtknE@z>

DQpOb3cgdGhhdCB0aGUgQXJtLU00IENQVSBoYXMgYmVlbiBhZGRlZCB0byBRRU1VIHdlIGNhbiBh
ZGQgdGhlIE5ldGR1aW5vDQpQbHVzIDIgbWFjaGluZS4gVGhpcyBpcyB2ZXJ5IHNpbWlsYXIgdG8g
dGhlIFNUTTMyRjIwNSBhbmQgTmV0ZHVpbm8gMiBTb0MNCmFuZCBtYWNoaW5lLg0KDQp2MjoNCiAt
IFJlb3JkZXIgcGF0Y2hzZXQNCiAtIFJldHVybiB0aGUga2VybmVsIGVudHJ5IHBvaW50IGluc3Rl
YWQgb2YgdXNpbmcgYSBwb2ludGVyDQogLSBBZGRyZXNzIFBldGVyJ3MgY29tbWVudHMNCg0KDQpB
bGlzdGFpciBGcmFuY2lzICg1KToNCiAgaHcvbWlzYzogQWRkIHRoZSBTVE0zMkY0eHggU3lzY29u
ZmlnIGRldmljZQ0KICBody9taXNjOiBBZGQgdGhlIFNUTTMyRjR4eCBFWFRJIGRldmljZQ0KICBh
cm12N206IEFsbG93IGVudHJ5IGluZm9ybWF0aW9uIHRvIGJlIHJldHVybmVkDQogIGh3L2FybTog
QWRkIHRoZSBTVE0zMkY0eHggU29DDQogIGh3L2FybTogQWRkIHRoZSBOZXRkdWlubyBQbHVzIDIN
Cg0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTQgKysNCiBkZWZhdWx0
LWNvbmZpZ3MvYXJtLXNvZnRtbXUubWFrICAgIHwgICA0ICsNCiBody9hcm0vS2NvbmZpZyAgICAg
ICAgICAgICAgICAgICAgIHwgICA2ICsNCiBody9hcm0vTWFrZWZpbGUub2JqcyAgICAgICAgICAg
ICAgIHwgICAyICsNCiBody9hcm0vYXJtdjdtLmMgICAgICAgICAgICAgICAgICAgIHwgICA0ICst
DQogaHcvYXJtL25ldGR1aW5vcGx1czIuYyAgICAgICAgICAgICB8ICA3NyArKysrKysrKw0KIGh3
L2FybS9zdG0zMmY0MDVfc29jLmMgICAgICAgICAgICAgfCAzMDYgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCiBody9taXNjL0tjb25maWcgICAgICAgICAgICAgICAgICAgIHwgICA2ICsN
CiBody9taXNjL01ha2VmaWxlLm9ianMgICAgICAgICAgICAgIHwgICAyICsNCiBody9taXNjL3N0
bTMyZjR4eF9leHRpLmMgICAgICAgICAgIHwgMTg3ICsrKysrKysrKysrKysrKysrKw0KIGh3L21p
c2Mvc3RtMzJmNHh4X3N5c2NmZy5jICAgICAgICAgfCAxNjggKysrKysrKysrKysrKysrKw0KIGh3
L21pc2MvdHJhY2UtZXZlbnRzICAgICAgICAgICAgICAgfCAgMTEgKysNCiBpbmNsdWRlL2h3L2Fy
bS9hcm0uaCAgICAgICAgICAgICAgIHwgICA0ICstDQogaW5jbHVkZS9ody9hcm0vc3RtMzJmNDA1
X3NvYy5oICAgICB8ICA3NCArKysrKysrDQogaW5jbHVkZS9ody9taXNjL3N0bTMyZjR4eF9leHRp
LmggICB8ICA2MCArKysrKysNCiBpbmNsdWRlL2h3L21pc2Mvc3RtMzJmNHh4X3N5c2NmZy5oIHwg
IDYxICsrKysrKw0KIDE2IGZpbGVzIGNoYW5nZWQsIDk4NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9hcm0vbmV0ZHVpbm9wbHVzMi5jDQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IGh3L2FybS9zdG0zMmY0MDVfc29jLmMNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgaHcvbWlzYy9zdG0zMmY0eHhfZXh0aS5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L21pc2Mv
c3RtMzJmNHh4X3N5c2NmZy5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvYXJtL3N0
bTMyZjQwNV9zb2MuaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L21pc2Mvc3RtMzJm
NHh4X2V4dGkuaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L21pc2Mvc3RtMzJmNHh4
X3N5c2NmZy5oDQoNCi0tIA0KMi4yMS4wDQoNCg==

