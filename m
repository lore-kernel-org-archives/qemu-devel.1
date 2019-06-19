Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1865BC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 04:55:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD973208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 04:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD973208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35094 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdScn-0005Ym-0T
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 00:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60065)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair@alistair23.me>) id 1hdSbN-0004ca-7d
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 00:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair@alistair23.me>) id 1hdSbM-00016f-7W
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 00:53:41 -0400
Received: from mail-oln040092255082.outbound.protection.outlook.com
 ([40.92.255.82]:59136 helo=APC01-HK2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alistair@alistair23.me>)
 id 1hdSbL-00013y-SC
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 00:53:40 -0400
Received: from PU1APC01FT111.eop-APC01.prod.protection.outlook.com
 (10.152.252.59) by PU1APC01HT199.eop-APC01.prod.protection.outlook.com
 (10.152.253.174) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1987.11; Wed, 19 Jun
 2019 04:53:33 +0000
Received: from PSXP216MB0277.KORP216.PROD.OUTLOOK.COM (10.152.252.55) by
 PU1APC01FT111.mail.protection.outlook.com (10.152.252.236) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1987.11 via Frontend Transport; Wed, 19 Jun 2019 04:53:33 +0000
Received: from PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
 ([fe80::61e4:d213:4652:f57]) by PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
 ([fe80::61e4:d213:4652:f57%2]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 04:53:33 +0000
From: Alistair Francis <alistair@alistair23.me>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Thread-Topic: [PATCH v3 0/6]  Add the STM32F405 and Netduino Plus 2 machine
Thread-Index: AQHVJlryULi+pXTD3UC0F1dLGiY2lA==
Date: Wed, 19 Jun 2019 04:53:33 +0000
Message-ID: <PSXP216MB0277E6893AD0AE2B4DB95935DDE50@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::44) To PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:a::18)
x-incomingtopheadermarker: OriginalChecksum:7C02F6C38BDAF39F3460BE90B8D3964F85B1F2E663CDD247807370105EED5F28;
 UpperCasedChecksum:413CE3AB54EE21B7644FFF30D19A3F3D6B151F0F9DE56C2E7C1C892D84A2B570;
 SizeAsReceived:7428; Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-tmn: [jS54vS9lkpRNj8vrZwPdVaOcIhc4dc/7kJnVIilCEsoJf5iJrUEUBExB7Cj1m5cS]
x-microsoft-original-message-id: <cover.1560919807.git.alistair@alistair23.me>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);
 SRVR:PU1APC01HT199; 
x-ms-traffictypediagnostic: PU1APC01HT199:
x-microsoft-antispam-message-info: FskKJWouVu2MhHC6lgE8K6Uj0hzwlsHLOyGiWQBqmjfRfN71dOFtlX487zJ4LE3uwoPHF+SjmWhtt2KxSZmdvyUMBpkPNSVenvioV9J1Pqdeckh4FFPgSnmObeGs0lXOIMwTZC+5ZS9uDR80AN0IFuu0LxP4fy7/HmIfSFFrgBJhmBAWZAfT+ZfqoPrsCuUQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 116cd2f3-bd08-40a3-5894-08d6f4721487
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 04:53:33.7245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT199
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.92.255.82
Subject: [Qemu-devel] [PATCH v3 0/6] Add the STM32F405 and Netduino Plus 2
 machine
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
Cc: "alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQpOb3cgdGhhdCB0aGUgQXJtLU00IENQVSBoYXMgYmVlbiBhZGRlZCB0byBRRU1VIHdlIGNhbiBh
ZGQgdGhlIE5ldGR1aW5vDQpQbHVzIDIgbWFjaGluZS4gVGhpcyBpcyB2ZXJ5IHNpbWlsYXIgdG8g
dGhlIFNUTTMyRjIwNSBhbmQgTmV0ZHVpbm8gMiBTb0MNCmFuZCBtYWNoaW5lLg0KDQp2MzoNCiAt
IFJlbW92ZSBjdXN0b20gcmVzZXQgaGFuZGxlcg0KIC0gQWRkIGluaXQtZW50cnkgYW5kIGluaXQt
c3AgcHJvcGVydGllcw0KIC0gUmViYXNlIG9uIG1hc3RlciAoaW5jbHVkaW5nIEtjb25maWcgY2hh
bmdlcykNCnYyOg0KIC0gUmVvcmRlciBwYXRjaHNldA0KIC0gUmV0dXJuIHRoZSBrZXJuZWwgZW50
cnkgcG9pbnQgaW5zdGVhZCBvZiB1c2luZyBhIHBvaW50ZXINCiAtIEFkZHJlc3MgUGV0ZXIncyBj
b21tZW50cw0KDQoNCkFsaXN0YWlyIEZyYW5jaXMgKDYpOg0KICBhcm12N206IEFsbG93IGVudHJ5
IGluZm9ybWF0aW9uIHRvIGJlIHJldHVybmVkDQogIHRhcmdldC9hcm06IEFsbG93IHNldHRpbmcg
TSBtb2RlIGVudHJ5IGFuZCBzcA0KICBody9taXNjOiBBZGQgdGhlIFNUTTMyRjR4eCBTeXNjb25m
aWcgZGV2aWNlDQogIGh3L21pc2M6IEFkZCB0aGUgU1RNMzJGNHh4IEVYVEkgZGV2aWNlDQogIGh3
L2FybTogQWRkIHRoZSBTVE0zMkY0eHggU29DDQogIGh3L2FybTogQWRkIHRoZSBOZXRkdWlubyBQ
bHVzIDINCg0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTQgKysNCiBk
ZWZhdWx0LWNvbmZpZ3MvYXJtLXNvZnRtbXUubWFrICAgIHwgICAxICsNCiBody9hcm0vS2NvbmZp
ZyAgICAgICAgICAgICAgICAgICAgIHwgIDE2ICsrDQogaHcvYXJtL01ha2VmaWxlLm9ianMgICAg
ICAgICAgICAgICB8ICAgMiArDQogaHcvYXJtL2FybXY3bS5jICAgICAgICAgICAgICAgICAgICB8
ICAgNCArLQ0KIGh3L2FybS9uZXRkdWlub3BsdXMyLmMgICAgICAgICAgICAgfCAgNTggKysrKysr
Kw0KIGh3L2FybS9zdG0zMmY0MDVfc29jLmMgICAgICAgICAgICAgfCAzMDEgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KIGh3L21pc2MvS2NvbmZpZyAgICAgICAgICAgICAg
ICAgICAgfCAgIDYgKw0KIGh3L21pc2MvTWFrZWZpbGUub2JqcyAgICAgICAgICAgICAgfCAgIDIg
Kw0KIGh3L21pc2Mvc3RtMzJmNHh4X2V4dGkuYyAgICAgICAgICAgfCAxODcgKysrKysrKysrKysr
KysrKysrKysrKysNCiBody9taXNjL3N0bTMyZjR4eF9zeXNjZmcuYyAgICAgICAgIHwgMTY4ICsr
KysrKysrKysrKysrKysrKysrKw0KIGh3L21pc2MvdHJhY2UtZXZlbnRzICAgICAgICAgICAgICAg
fCAgMTEgKysNCiBpbmNsdWRlL2h3L2FybS9ib290LmggICAgICAgICAgICAgIHwgICA0ICstDQog
aW5jbHVkZS9ody9hcm0vc3RtMzJmNDA1X3NvYy5oICAgICB8ICA3MyArKysrKysrKysNCiBpbmNs
dWRlL2h3L21pc2Mvc3RtMzJmNHh4X2V4dGkuaCAgIHwgIDYwICsrKysrKysrDQogaW5jbHVkZS9o
dy9taXNjL3N0bTMyZjR4eF9zeXNjZmcuaCB8ICA2MSArKysrKysrKw0KIHRhcmdldC9hcm0vY3B1
LmMgICAgICAgICAgICAgICAgICAgfCAgNDcgKysrKysrDQogdGFyZ2V0L2FybS9jcHUuaCAgICAg
ICAgICAgICAgICAgICB8ICAgMyArDQogMTggZmlsZXMgY2hhbmdlZCwgMTAxNiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9hcm0vbmV0ZHVpbm9w
bHVzMi5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2FybS9zdG0zMmY0MDVfc29jLmMNCiBjcmVh
dGUgbW9kZSAxMDA2NDQgaHcvbWlzYy9zdG0zMmY0eHhfZXh0aS5jDQogY3JlYXRlIG1vZGUgMTAw
NjQ0IGh3L21pc2Mvc3RtMzJmNHh4X3N5c2NmZy5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1
ZGUvaHcvYXJtL3N0bTMyZjQwNV9zb2MuaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3
L21pc2Mvc3RtMzJmNHh4X2V4dGkuaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L21p
c2Mvc3RtMzJmNHh4X3N5c2NmZy5oDQoNCi0tIA0KMi4xMS4wDQoNCg==

