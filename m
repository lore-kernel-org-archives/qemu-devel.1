Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42867C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 05:45:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E5E20873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 05:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E5E20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45539 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM4XH-0003xy-98
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 01:45:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hM4Tr-000122-CE
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hM4To-0003XT-OV
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:42:03 -0400
Received: from mail-oln040092255038.outbound.protection.outlook.com
	([40.92.255.38]:37395
	helo=APC01-HK2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistair@alistair23.me>)
	id 1hM4Tb-0003Cg-AN
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:41:53 -0400
Received: from SG2APC01FT014.eop-APC01.prod.protection.outlook.com
	(10.152.250.60) by SG2APC01HT230.eop-APC01.prod.protection.outlook.com
	(10.152.251.72) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1835.13;
	Thu, 2 May 2019 05:41:16 +0000
Received: from PSXP216MB0277.KORP216.PROD.OUTLOOK.COM (10.152.250.58) by
	SG2APC01FT014.mail.protection.outlook.com (10.152.250.188) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.13 via Frontend Transport; Thu, 2 May 2019 05:41:16 +0000
Received: from PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
	([fe80::d5cf:d2af:3aea:e2a3]) by PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
	([fe80::d5cf:d2af:3aea:e2a3%3]) with mapi id 15.20.1856.008;
	Thu, 2 May 2019 05:41:16 +0000
From: Alistair Francis <alistair@alistair23.me>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v1 3/5] armv7m: Allow entry information to be returned
Thread-Index: AQHVAKmpZV7EfrTQRkqcxlN4TMjQbg==
Date: Thu, 2 May 2019 05:41:16 +0000
Message-ID:
 <PSXP216MB0277D89E74F59BE18F609C9ADD340@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
References: <cover.1556774049.git.alistair@alistair23.me>
In-Reply-To: <cover.1556774049.git.alistair@alistair23.me>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0015.namprd04.prod.outlook.com
	(2603:10b6:a03:40::28) To PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
	(2603:1096:300:a::18)
x-incomingtopheadermarker: OriginalChecksum:0E3EDBA31D9DA3C9C484BFEC29499842C07D0EB0CA70E54E9968C1643EBC6FA3;
	UpperCasedChecksum:892ADBE9B603AE89800E8D60C0D67D730222E2D8431D32B5AA0CB80A3CE2CC35;
	SizeAsReceived:7594; Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-tmn: [NVmdks3Pa3kmE7KMtZ6WpuW2k7GBl8mm4jUL1tzx2Kqoo1TxV/dRUSWPt8jw3I10]
x-microsoft-original-message-id: <6d0c88d91c7bc977baece4c28b1bfca1889b7523.1556774049.git.alistair@alistair23.me>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
	SRVR:SG2APC01HT230; 
x-ms-traffictypediagnostic: SG2APC01HT230:
x-microsoft-antispam-message-info: CrZOK3PmrEkeU1Sr0Fe7LvltlV9XXFWwZD7AuRICEj8NaJti3VDkqXHSp64Vcc7nYze2zOZ2rbLm9jT0oev6EdUYDLgDv4yFXLkneaJiNF26x5Kz8wrbo6p/9e43fJaFIwx1c3wskqKicdJ0EEhNCDxaG/ZGB0saVpeSkDVpy5PsCq1jv/qE3qFcRVswxB0V
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 091bf875-ca8e-43c8-ce07-08d6cec0cb60
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 05:41:16.6530 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT230
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.92.255.38
Subject: [Qemu-devel] [PATCH v1 3/5] armv7m: Allow entry information to be
 returned
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
Message-ID: <20190502054116.kSg1v_mSDaXgVVv-mhedVddln8YPBBOeVhIKpv_4oO0@z>

QWxsb3cgdGhlIGtlcm5lbCdzIGVudHJ5IHBvaW50IGluZm9ybWF0aW9uIHRvIGJlIHJldHVybmVk
IHdoZW4gbG9hZGluZyBhDQprZXJuZWwuDQoNClNpZ25lZC1vZmYtYnk6IEFsaXN0YWlyIEZyYW5j
aXMgPGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+DQotLS0NCiBody9hcm0vYXJtdjdtLmMgICAgICB8
IDQgKysrLQ0KIGluY2x1ZGUvaHcvYXJtL2FybS5oIHwgNCArKystDQogMiBmaWxlcyBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9hcm0v
YXJtdjdtLmMgYi9ody9hcm0vYXJtdjdtLmMNCmluZGV4IGM0YjJhOWExZjUuLjJmMjc1NWIyMWUg
MTAwNjQ0DQotLS0gYS9ody9hcm0vYXJtdjdtLmMNCisrKyBiL2h3L2FybS9hcm12N20uYw0KQEAg
LTI4Niw3ICsyODYsNyBAQCBzdGF0aWMgdm9pZCBhcm12N21fcmVzZXQodm9pZCAqb3BhcXVlKQ0K
ICAgICBjcHVfcmVzZXQoQ1BVKGNwdSkpOw0KIH0NCiANCi12b2lkIGFybXY3bV9sb2FkX2tlcm5l
bChBUk1DUFUgKmNwdSwgY29uc3QgY2hhciAqa2VybmVsX2ZpbGVuYW1lLCBpbnQgbWVtX3NpemUp
DQordWludDY0X3QgYXJtdjdtX2xvYWRfa2VybmVsKEFSTUNQVSAqY3B1LCBjb25zdCBjaGFyICpr
ZXJuZWxfZmlsZW5hbWUsIGludCBtZW1fc2l6ZSkNCiB7DQogICAgIGludCBpbWFnZV9zaXplOw0K
ICAgICB1aW50NjRfdCBlbnRyeTsNCkBAIC0zMzMsNiArMzMzLDggQEAgdm9pZCBhcm12N21fbG9h
ZF9rZXJuZWwoQVJNQ1BVICpjcHUsIGNvbnN0IGNoYXIgKmtlcm5lbF9maWxlbmFtZSwgaW50IG1l
bV9zaXplKQ0KICAgICAgKiBib2FyZCBtdXN0IGNhbGwgdGhpcyBmdW5jdGlvbiENCiAgICAgICov
DQogICAgIHFlbXVfcmVnaXN0ZXJfcmVzZXQoYXJtdjdtX3Jlc2V0LCBjcHUpOw0KKw0KKyAgICBy
ZXR1cm4gZW50cnk7DQogfQ0KIA0KIHN0YXRpYyBQcm9wZXJ0eSBiaXRiYW5kX3Byb3BlcnRpZXNb
XSA9IHsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2FybS9hcm0uaCBiL2luY2x1ZGUvaHcvYXJt
L2FybS5oDQppbmRleCBmZmVkMzkyNTJkLi40OGQ5MTgxYjI4IDEwMDY0NA0KLS0tIGEvaW5jbHVk
ZS9ody9hcm0vYXJtLmgNCisrKyBiL2luY2x1ZGUvaHcvYXJtL2FybS5oDQpAQCAtMjksMTEgKzI5
LDEzIEBAIHR5cGVkZWYgZW51bSB7DQogICogQGtlcm5lbF9maWxlbmFtZTogZmlsZSB0byBsb2Fk
DQogICogQG1lbV9zaXplOiBtZW1fc2l6ZTogbWF4aW11bSBpbWFnZSBzaXplIHRvIGxvYWQNCiAg
Kg0KKyAqIHJldHVybnM6IGxvY2F0aW9uIG9mIHRoZSBrZXJuZWwncyBlbnRyeSBwb2ludA0KKyAq
DQogICogTG9hZCB0aGUgZ3Vlc3QgaW1hZ2UgZm9yIGFuIEFSTXY3TSBzeXN0ZW0uIFRoaXMgbXVz
dCBiZSBjYWxsZWQgYnkNCiAgKiBhbnkgQVJNdjdNIGJvYXJkLiAoVGhpcyBpcyBuZWNlc3Nhcnkg
dG8gZW5zdXJlIHRoYXQgdGhlIENQVSByZXNldHMNCiAgKiBjb3JyZWN0bHkgb24gc3lzdGVtIHJl
c2V0LCBhcyB3ZWxsIGFzIGZvciBrZXJuZWwgbG9hZGluZy4pDQogICovDQotdm9pZCBhcm12N21f
bG9hZF9rZXJuZWwoQVJNQ1BVICpjcHUsIGNvbnN0IGNoYXIgKmtlcm5lbF9maWxlbmFtZSwgaW50
IG1lbV9zaXplKTsNCit1aW50NjRfdCBhcm12N21fbG9hZF9rZXJuZWwoQVJNQ1BVICpjcHUsIGNv
bnN0IGNoYXIgKmtlcm5lbF9maWxlbmFtZSwgaW50IG1lbV9zaXplKTsNCiANCiAvKiBhcm1fYm9v
dC5jICovDQogc3RydWN0IGFybV9ib290X2luZm8gew0KLS0gDQoyLjIxLjANCg0K

