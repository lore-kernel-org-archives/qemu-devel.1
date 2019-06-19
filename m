Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40DFC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 05:02:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A472070B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 05:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A472070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35134 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdSjz-0002so-Ka
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 01:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60410)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair@alistair23.me>) id 1hdSch-00060X-36
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 00:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair@alistair23.me>) id 1hdScf-0001z7-0w
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 00:55:02 -0400
Received: from mail-oln040092253108.outbound.protection.outlook.com
 ([40.92.253.108]:35122 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alistair@alistair23.me>)
 id 1hdScb-0001ui-GT
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 00:54:59 -0400
Received: from HK2APC01FT024.eop-APC01.prod.protection.outlook.com
 (10.152.248.51) by HK2APC01HT079.eop-APC01.prod.protection.outlook.com
 (10.152.249.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1987.11; Wed, 19 Jun
 2019 04:54:41 +0000
Received: from PSXP216MB0277.KORP216.PROD.OUTLOOK.COM (10.152.248.60) by
 HK2APC01FT024.mail.protection.outlook.com (10.152.248.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11 via Frontend Transport; Wed, 19 Jun 2019 04:54:41 +0000
Received: from PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
 ([fe80::61e4:d213:4652:f57]) by PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
 ([fe80::61e4:d213:4652:f57%2]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 04:54:41 +0000
From: Alistair Francis <alistair@alistair23.me>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Thread-Topic: [PATCH v3 6/6] hw/arm: Add the Netduino Plus 2
Thread-Index: AQHVJlsaNojc9HZd7UqLeuvmaZswug==
Date: Wed, 19 Jun 2019 04:54:41 +0000
Message-ID: <PSXP216MB0277B0AF890AFD7BDCBF5A02DDE50@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
References: <cover.1560919807.git.alistair@alistair23.me>
In-Reply-To: <cover.1560919807.git.alistair@alistair23.me>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::36) To PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:a::18)
x-incomingtopheadermarker: OriginalChecksum:CFB213B78EFD88A062E82844717AE84197EBCE48F7349B217C4573FBA16205C9;
 UpperCasedChecksum:7190650757A7504C3B11E5152565F6A52BB4C903CF9B52A256732348081EF42F;
 SizeAsReceived:7555; Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-tmn: [GgKH5S64tIcXUTktiI8Es1ku+HRCrgNucPmCAXriZSaAnZ34iTUNThLSXKMC6YKl]
x-microsoft-original-message-id: <6c992fa86f5be8746fa614230bd1410ed4d1762c.1560919807.git.alistair@alistair23.me>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:HK2APC01HT079; 
x-ms-traffictypediagnostic: HK2APC01HT079:
x-microsoft-antispam-message-info: kWJMUMXLTMjhqZjcM1/qTDEbh4Nth21SQOEQNJQzd20dlQ6+jl0Kp5OOLaQv8n8R+PDx3feIYesoSsOu+LzyX7nwuO2ROhbOxGCcnd2LnsWudgSoDnTXP5Ofx3zU88u6wtTmI98pt4yE/DVrXl77+3dVis0gj+xzA91P7BuggVLmHU7Thtye4Xf9EibSP43W
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 09596558-0b99-4db5-d4f4-08d6f4723d0d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 04:54:41.3194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT079
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.92.253.108
Subject: [Qemu-devel] [PATCH v3 6/6] hw/arm: Add the Netduino Plus 2
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

U2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXJAYWxpc3RhaXIyMy5tZT4N
Ci0tLQ0KIE1BSU5UQUlORVJTICAgICAgICAgICAgfCAgNiArKysrKysNCiBody9hcm0vS2NvbmZp
ZyAgICAgICAgIHwgIDMgKysrDQogaHcvYXJtL01ha2VmaWxlLm9ianMgICB8ICAxICsNCiBody9h
cm0vbmV0ZHVpbm9wbHVzMi5jIHwgNTggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCiA0IGZpbGVzIGNoYW5nZWQsIDY4IGluc2VydGlvbnMoKykNCiBj
cmVhdGUgbW9kZSAxMDA2NDQgaHcvYXJtL25ldGR1aW5vcGx1czIuYw0KDQpkaWZmIC0tZ2l0IGEv
TUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KaW5kZXggZjkxN2YzZTY5My4uMjQzYjZiMTQ2MCAx
MDA2NDQNCi0tLSBhL01BSU5UQUlORVJTDQorKysgYi9NQUlOVEFJTkVSUw0KQEAgLTgyMCw2ICs4
MjAsMTIgQEAgTTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KIFM6
IE1haW50YWluZWQNCiBGOiBody9hcm0vbmV0ZHVpbm8yLmMNCiANCitOZXRkdWlubyBQbHVzIDIN
CitNOiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpckBhbGlzdGFpcjIzLm1lPg0KK006IFBldGVy
IE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4NCitTOiBNYWludGFpbmVkDQorRjog
aHcvYXJtL25ldGR1aW5vcGx1czIuYw0KKw0KIFNtYXJ0RnVzaW9uMg0KIE06IFN1YmJhcmF5YSBT
dW5kZWVwIDxzdW5kZWVwLmxrbWxAZ21haWwuY29tPg0KIE06IFBldGVyIE1heWRlbGwgPHBldGVy
Lm1heWRlbGxAbGluYXJvLm9yZz4NCmRpZmYgLS1naXQgYS9ody9hcm0vS2NvbmZpZyBiL2h3L2Fy
bS9LY29uZmlnDQppbmRleCA2NWEwOTIzYWZlLi40M2U2ZTBjNTg3IDEwMDY0NA0KLS0tIGEvaHcv
YXJtL0tjb25maWcNCisrKyBiL2h3L2FybS9LY29uZmlnDQpAQCAtOTksNiArOTksOSBAQCBjb25m
aWcgTkVURFVJTk9QTFVTMg0KICAgICBib29sDQogICAgIHNlbGVjdCBTVE0zMkY0MDVfU09DDQog
DQorY29uZmlnIE5FVERVSU5PUExVUzINCisgICAgYm9vbA0KKw0KIGNvbmZpZyBOU0VSSUVTDQog
ICAgIGJvb2wNCiAgICAgc2VsZWN0IE9NQVANCmRpZmYgLS1naXQgYS9ody9hcm0vTWFrZWZpbGUu
b2JqcyBiL2h3L2FybS9NYWtlZmlsZS5vYmpzDQppbmRleCA0NDM2YzJlOTNlLi43NTcyNjU0MGJj
IDEwMDY0NA0KLS0tIGEvaHcvYXJtL01ha2VmaWxlLm9ianMNCisrKyBiL2h3L2FybS9NYWtlZmls
ZS5vYmpzDQpAQCAtMTEsNiArMTEsNyBAQCBvYmotJChDT05GSUdfTUFJTlNUT05FKSArPSBtYWlu
c3RvbmUubw0KIG9iai0kKENPTkZJR19NSUNST0JJVCkgKz0gbWljcm9iaXQubw0KIG9iai0kKENP
TkZJR19NVVNJQ1BBTCkgKz0gbXVzaWNwYWwubw0KIG9iai0kKENPTkZJR19ORVREVUlOTzIpICs9
IG5ldGR1aW5vMi5vDQorb2JqLSQoQ09ORklHX05FVERVSU5PUExVUzIpICs9IG5ldGR1aW5vcGx1
czIubw0KIG9iai0kKENPTkZJR19OU0VSSUVTKSArPSBuc2VyaWVzLm8NCiBvYmotJChDT05GSUdf
U1gxKSArPSBvbWFwX3N4MS5vDQogb2JqLSQoQ09ORklHX0NIRUVUQUgpICs9IHBhbG0ubw0KZGlm
ZiAtLWdpdCBhL2h3L2FybS9uZXRkdWlub3BsdXMyLmMgYi9ody9hcm0vbmV0ZHVpbm9wbHVzMi5j
DQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMC4uNGE3NWRhODU0Mw0KLS0t
IC9kZXYvbnVsbA0KKysrIGIvaHcvYXJtL25ldGR1aW5vcGx1czIuYw0KQEAgLTAsMCArMSw1OCBA
QA0KKy8qDQorICogTmV0ZHVpbm8gUGx1cyAyIE1hY2hpbmUgTW9kZWwNCisgKg0KKyAqIENvcHly
aWdodCAoYykgMjAxNCBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpckBhbGlzdGFpcjIzLm1lPg0K
KyAqDQorICogUGVybWlzc2lvbiBpcyBoZXJlYnkgZ3JhbnRlZCwgZnJlZSBvZiBjaGFyZ2UsIHRv
IGFueSBwZXJzb24gb2J0YWluaW5nIGEgY29weQ0KKyAqIG9mIHRoaXMgc29mdHdhcmUgYW5kIGFz
c29jaWF0ZWQgZG9jdW1lbnRhdGlvbiBmaWxlcyAodGhlICJTb2Z0d2FyZSIpLCB0byBkZWFsDQor
ICogaW4gdGhlIFNvZnR3YXJlIHdpdGhvdXQgcmVzdHJpY3Rpb24sIGluY2x1ZGluZyB3aXRob3V0
IGxpbWl0YXRpb24gdGhlIHJpZ2h0cw0KKyAqIHRvIHVzZSwgY29weSwgbW9kaWZ5LCBtZXJnZSwg
cHVibGlzaCwgZGlzdHJpYnV0ZSwgc3VibGljZW5zZSwgYW5kL29yIHNlbGwNCisgKiBjb3BpZXMg
b2YgdGhlIFNvZnR3YXJlLCBhbmQgdG8gcGVybWl0IHBlcnNvbnMgdG8gd2hvbSB0aGUgU29mdHdh
cmUgaXMNCisgKiBmdXJuaXNoZWQgdG8gZG8gc28sIHN1YmplY3QgdG8gdGhlIGZvbGxvd2luZyBj
b25kaXRpb25zOg0KKyAqDQorICogVGhlIGFib3ZlIGNvcHlyaWdodCBub3RpY2UgYW5kIHRoaXMg
cGVybWlzc2lvbiBub3RpY2Ugc2hhbGwgYmUgaW5jbHVkZWQgaW4NCisgKiBhbGwgY29waWVzIG9y
IHN1YnN0YW50aWFsIHBvcnRpb25zIG9mIHRoZSBTb2Z0d2FyZS4NCisgKg0KKyAqIFRIRSBTT0ZU
V0FSRSBJUyBQUk9WSURFRCAiQVMgSVMiLCBXSVRIT1VUIFdBUlJBTlRZIE9GIEFOWSBLSU5ELCBF
WFBSRVNTIE9SDQorICogSU1QTElFRCwgSU5DTFVESU5HIEJVVCBOT1QgTElNSVRFRCBUTyBUSEUg
V0FSUkFOVElFUyBPRiBNRVJDSEFOVEFCSUxJVFksDQorICogRklUTkVTUyBGT1IgQSBQQVJUSUNV
TEFSIFBVUlBPU0UgQU5EIE5PTklORlJJTkdFTUVOVC4gSU4gTk8gRVZFTlQgU0hBTEwNCisgKiBU
SEUgQVVUSE9SUyBPUiBDT1BZUklHSFQgSE9MREVSUyBCRSBMSUFCTEUgRk9SIEFOWSBDTEFJTSwg
REFNQUdFUyBPUiBPVEhFUg0KKyAqIExJQUJJTElUWSwgV0hFVEhFUiBJTiBBTiBBQ1RJT04gT0Yg
Q09OVFJBQ1QsIFRPUlQgT1IgT1RIRVJXSVNFLCBBUklTSU5HIEZST00sDQorICogT1VUIE9GIE9S
IElOIENPTk5FQ1RJT04gV0lUSCBUSEUgU09GVFdBUkUgT1IgVEhFIFVTRSBPUiBPVEhFUiBERUFM
SU5HUyBJTg0KKyAqIFRIRSBTT0ZUV0FSRS4NCisgKi8NCisNCisjaW5jbHVkZSAicWVtdS9vc2Rl
cC5oIg0KKyNpbmNsdWRlICJxYXBpL2Vycm9yLmgiDQorI2luY2x1ZGUgImh3L2JvYXJkcy5oIg0K
KyNpbmNsdWRlICJxZW11L2Vycm9yLXJlcG9ydC5oIg0KKyNpbmNsdWRlICJody9hcm0vc3RtMzJm
NDA1X3NvYy5oIg0KKyNpbmNsdWRlICJody9hcm0vYm9vdC5oIg0KKw0KK3N0YXRpYyB2b2lkIG5l
dGR1aW5vcGx1czJfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpDQorew0KKyAgICBEZXZpY2VT
dGF0ZSAqZGV2Ow0KKyAgICB1aW50MzJfdCBrZXJuZWxfZW50cnk7DQorDQorICAgIGRldiA9IHFk
ZXZfY3JlYXRlKE5VTEwsIFRZUEVfU1RNMzJGNDA1X1NPQyk7DQorICAgIHFkZXZfcHJvcF9zZXRf
c3RyaW5nKGRldiwgImNwdS10eXBlIiwgQVJNX0NQVV9UWVBFX05BTUUoImNvcnRleC1tNCIpKTsN
CisgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9ib29sKE9CSkVDVChkZXYpLCB0cnVlLCAicmVhbGl6
ZWQiLCAmZXJyb3JfZmF0YWwpOw0KKw0KKyAgICBrZXJuZWxfZW50cnkgPSBhcm12N21fbG9hZF9r
ZXJuZWwoQVJNX0NQVShmaXJzdF9jcHUpLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgbWFjaGluZS0+a2VybmVsX2ZpbGVuYW1lLA0KKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgRkxBU0hfU0laRSk7DQorDQorICAgIG9iamVjdF9wcm9wZXJ0eV9z
ZXRfaW50KE9CSkVDVChmaXJzdF9jcHUpLCBrZXJuZWxfZW50cnksDQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICJpbml0LWVudHJ5IiwgJmVycm9yX2ZhdGFsKTsNCisgICAgb2JqZWN0X3By
b3BlcnR5X3NldF9pbnQoT0JKRUNUKGZpcnN0X2NwdSksDQorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFNSQU1fQkFTRV9BRERSRVNTICsgKFNSQU1fU0laRSAqIDIpIC8gMywNCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgImluaXQtc3AiLCAmZXJyb3JfZmF0YWwpOw0KK30NCisNCitz
dGF0aWMgdm9pZCBuZXRkdWlub3BsdXMyX21hY2hpbmVfaW5pdChNYWNoaW5lQ2xhc3MgKm1jKQ0K
K3sNCisgICAgbWMtPmRlc2MgPSAiTmV0ZHVpbm8gUGx1cyAyIE1hY2hpbmUiOw0KKyAgICBtYy0+
aW5pdCA9IG5ldGR1aW5vcGx1czJfaW5pdDsNCit9DQorDQorREVGSU5FX01BQ0hJTkUoIm5ldGR1
aW5vcGx1czIiLCBuZXRkdWlub3BsdXMyX21hY2hpbmVfaW5pdCkNCi0tIA0KMi4xMS4wDQoNCg==

