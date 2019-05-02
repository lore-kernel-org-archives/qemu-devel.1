Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C154C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 05:46:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E36DE20873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 05:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36DE20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45561 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM4Xu-0004SW-5D
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 01:46:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hM4UB-0001L1-3f
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hM4Tv-0003ca-Qc
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:42:12 -0400
Received: from mail-oln040092255033.outbound.protection.outlook.com
	([40.92.255.33]:56992
	helo=APC01-HK2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistair@alistair23.me>)
	id 1hM4Ts-0003Td-1U
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:42:05 -0400
Received: from SG2APC01FT014.eop-APC01.prod.protection.outlook.com
	(10.152.250.58) by SG2APC01HT090.eop-APC01.prod.protection.outlook.com
	(10.152.250.245) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1835.13;
	Thu, 2 May 2019 05:41:44 +0000
Received: from PSXP216MB0277.KORP216.PROD.OUTLOOK.COM (10.152.250.58) by
	SG2APC01FT014.mail.protection.outlook.com (10.152.250.188) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.13 via Frontend Transport; Thu, 2 May 2019 05:41:44 +0000
Received: from PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
	([fe80::d5cf:d2af:3aea:e2a3]) by PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
	([fe80::d5cf:d2af:3aea:e2a3%3]) with mapi id 15.20.1856.008;
	Thu, 2 May 2019 05:41:44 +0000
From: Alistair Francis <alistair@alistair23.me>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v1 5/5] hw/arm: Add the Netduino Plus 2
Thread-Index: AQHVAKm5jV4t5NLe50qeabfKk41f6Q==
Date: Thu, 2 May 2019 05:41:44 +0000
Message-ID:
 <PSXP216MB0277BAE3697B1BBFCE662671DD340@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
References: <cover.1556774049.git.alistair@alistair23.me>
In-Reply-To: <cover.1556774049.git.alistair@alistair23.me>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0031.namprd03.prod.outlook.com
	(2603:10b6:a02:a8::44) To PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
	(2603:1096:300:a::18)
x-incomingtopheadermarker: OriginalChecksum:B5FE0DB8E6BF5D8FF67EC6741E1875FBF09F56BCA576262674F98EEB40E87028;
	UpperCasedChecksum:AB41F3BF5B648C6E5A4FF682F9B46B702882CE25BEC041B21B26B6D334873A68;
	SizeAsReceived:7554; Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-tmn: [Yk+LMmfkWo1CHUt0llsFLFZeiNTxOox52z88l5YLGnXzc95MLFPeZZSaDQOlTgUk]
x-microsoft-original-message-id: <ccb941f3a7e2ac62951e4a081f372b643b01872c.1556774049.git.alistair@alistair23.me>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
	SRVR:SG2APC01HT090; 
x-ms-traffictypediagnostic: SG2APC01HT090:
x-microsoft-antispam-message-info: +dS245mS+jvMR4Hyp0pQHu2wVizjFmwZHlJTLphoF9N3BXGF3HQ/qJ0zT4ORIqdPLzeH6/W22155+t1kU8V10WsqTuY788T5A7EHKnkA3d1Ksjy7Ev4Xkx99OTG8nQW7maSgS8eUokyAae519Oc5OkYxQflBOVkQt5xZX2zhY6GYnA/8h7+fSKC1Vd+ddRur
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d06e5c2-9ca8-4a61-143e-08d6cec0dbd2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 05:41:44.1658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT090
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.92.255.33
Subject: [Qemu-devel] [PATCH v1 5/5] hw/arm: Add the Netduino Plus 2
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
Message-ID: <20190502054144.gSkqXdRbw_YTHhOasBX_xwVfACKTsGFHP3hBkknHpgs@z>

U2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXJAYWxpc3RhaXIyMy5tZT4N
Ci0tLQ0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgfCAgNiArKysNCiBkZWZhdWx0
LWNvbmZpZ3MvYXJtLXNvZnRtbXUubWFrIHwgIDEgKw0KIGh3L2FybS9LY29uZmlnICAgICAgICAg
ICAgICAgICAgfCAgMyArKw0KIGh3L2FybS9NYWtlZmlsZS5vYmpzICAgICAgICAgICAgfCAgMSAr
DQogaHcvYXJtL25ldGR1aW5vcGx1czIuYyAgICAgICAgICB8IDc3ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KIDUgZmlsZXMgY2hhbmdlZCwgODggaW5zZXJ0aW9ucygrKQ0KIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBody9hcm0vbmV0ZHVpbm9wbHVzMi5jDQoNCmRpZmYgLS1naXQgYS9N
QUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQppbmRleCBjMWM5Mzc0M2JiLi5mYTU1YjU4OGNjIDEw
MDY0NA0KLS0tIGEvTUFJTlRBSU5FUlMNCisrKyBiL01BSU5UQUlORVJTDQpAQCAtODI0LDYgKzgy
NCwxMiBAQCBNOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQogUzog
TWFpbnRhaW5lZA0KIEY6IGh3L2FybS9uZXRkdWlubzIuYw0KIA0KK05ldGR1aW5vIFBsdXMgMg0K
K006IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+DQorTTogUGV0ZXIg
TWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KK1M6IE1haW50YWluZWQNCitGOiBo
dy9hcm0vbmV0ZHVpbm9wbHVzMi5jDQorDQogU21hcnRGdXNpb24yDQogTTogU3ViYmFyYXlhIFN1
bmRlZXAgPHN1bmRlZXAubGttbEBnbWFpbC5jb20+DQogTTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnPg0KZGlmZiAtLWdpdCBhL2RlZmF1bHQtY29uZmlncy9hcm0tc29m
dG1tdS5tYWsgYi9kZWZhdWx0LWNvbmZpZ3MvYXJtLXNvZnRtbXUubWFrDQppbmRleCBlMDc5ZjEw
NjI0Li4xZTJjODJmMjAxIDEwMDY0NA0KLS0tIGEvZGVmYXVsdC1jb25maWdzL2FybS1zb2Z0bW11
Lm1haw0KKysrIGIvZGVmYXVsdC1jb25maWdzL2FybS1zb2Z0bW11Lm1haw0KQEAgLTQ2LDYgKzQ2
LDcgQEAgQ09ORklHX0ExNU1QQ09SRT15DQogDQogQ09ORklHX0FSTV9WN009eQ0KIENPTkZJR19O
RVREVUlOTzI9eQ0KK0NPTkZJR19ORVREVUlOT1BMVVMyPXkNCiANCiBDT05GSUdfQVJNX0dJQz15
DQogQ09ORklHX0FSTV9USU1FUj15DQpkaWZmIC0tZ2l0IGEvaHcvYXJtL0tjb25maWcgYi9ody9h
cm0vS2NvbmZpZw0KaW5kZXggM2E5OGJjZTE1YS4uMTNmYzc3OTMwOCAxMDA2NDQNCi0tLSBhL2h3
L2FybS9LY29uZmlnDQorKysgYi9ody9hcm0vS2NvbmZpZw0KQEAgLTI2LDYgKzI2LDkgQEAgY29u
ZmlnIE1VU0lDUEFMDQogY29uZmlnIE5FVERVSU5PMg0KICAgICBib29sDQogDQorY29uZmlnIE5F
VERVSU5PUExVUzINCisgICAgYm9vbA0KKw0KIGNvbmZpZyBOU0VSSUVTDQogICAgIGJvb2wNCiAN
CmRpZmYgLS1naXQgYS9ody9hcm0vTWFrZWZpbGUub2JqcyBiL2h3L2FybS9NYWtlZmlsZS5vYmpz
DQppbmRleCAzNmMzZmY1NGMzLi4xZjIxNmY0ZDkzIDEwMDY0NA0KLS0tIGEvaHcvYXJtL01ha2Vm
aWxlLm9ianMNCisrKyBiL2h3L2FybS9NYWtlZmlsZS5vYmpzDQpAQCAtOCw2ICs4LDcgQEAgb2Jq
LSQoQ09ORklHX0lOVEVHUkFUT1IpICs9IGludGVncmF0b3JjcC5vDQogb2JqLSQoQ09ORklHX01B
SU5TVE9ORSkgKz0gbWFpbnN0b25lLm8NCiBvYmotJChDT05GSUdfTVVTSUNQQUwpICs9IG11c2lj
cGFsLm8NCiBvYmotJChDT05GSUdfTkVURFVJTk8yKSArPSBuZXRkdWlubzIubw0KK29iai0kKENP
TkZJR19ORVREVUlOT1BMVVMyKSArPSBuZXRkdWlub3BsdXMyLm8NCiBvYmotJChDT05GSUdfTlNF
UklFUykgKz0gbnNlcmllcy5vDQogb2JqLSQoQ09ORklHX09NQVApICs9IG9tYXBfc3gxLm8gcGFs
bS5vDQogb2JqLSQoQ09ORklHX1BYQTJYWCkgKz0gZ3Vtc3RpeC5vIHNwaXR6Lm8gdG9zYS5vIHoy
Lm8NCmRpZmYgLS1naXQgYS9ody9hcm0vbmV0ZHVpbm9wbHVzMi5jIGIvaHcvYXJtL25ldGR1aW5v
cGx1czIuYw0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAwMDAuLjAxN2RlMTdk
ZjQNCi0tLSAvZGV2L251bGwNCisrKyBiL2h3L2FybS9uZXRkdWlub3BsdXMyLmMNCkBAIC0wLDAg
KzEsNzcgQEANCisvKg0KKyAqIE5ldGR1aW5vIFBsdXMgMiBNYWNoaW5lIE1vZGVsDQorICoNCisg
KiBDb3B5cmlnaHQgKGMpIDIwMTQgQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXJAYWxpc3RhaXIy
My5tZT4NCisgKg0KKyAqIFBlcm1pc3Npb24gaXMgaGVyZWJ5IGdyYW50ZWQsIGZyZWUgb2YgY2hh
cmdlLCB0byBhbnkgcGVyc29uIG9idGFpbmluZyBhIGNvcHkNCisgKiBvZiB0aGlzIHNvZnR3YXJl
IGFuZCBhc3NvY2lhdGVkIGRvY3VtZW50YXRpb24gZmlsZXMgKHRoZSAiU29mdHdhcmUiKSwgdG8g
ZGVhbA0KKyAqIGluIHRoZSBTb2Z0d2FyZSB3aXRob3V0IHJlc3RyaWN0aW9uLCBpbmNsdWRpbmcg
d2l0aG91dCBsaW1pdGF0aW9uIHRoZSByaWdodHMNCisgKiB0byB1c2UsIGNvcHksIG1vZGlmeSwg
bWVyZ2UsIHB1Ymxpc2gsIGRpc3RyaWJ1dGUsIHN1YmxpY2Vuc2UsIGFuZC9vciBzZWxsDQorICog
Y29waWVzIG9mIHRoZSBTb2Z0d2FyZSwgYW5kIHRvIHBlcm1pdCBwZXJzb25zIHRvIHdob20gdGhl
IFNvZnR3YXJlIGlzDQorICogZnVybmlzaGVkIHRvIGRvIHNvLCBzdWJqZWN0IHRvIHRoZSBmb2xs
b3dpbmcgY29uZGl0aW9uczoNCisgKg0KKyAqIFRoZSBhYm92ZSBjb3B5cmlnaHQgbm90aWNlIGFu
ZCB0aGlzIHBlcm1pc3Npb24gbm90aWNlIHNoYWxsIGJlIGluY2x1ZGVkIGluDQorICogYWxsIGNv
cGllcyBvciBzdWJzdGFudGlhbCBwb3J0aW9ucyBvZiB0aGUgU29mdHdhcmUuDQorICoNCisgKiBU
SEUgU09GVFdBUkUgSVMgUFJPVklERUQgIkFTIElTIiwgV0lUSE9VVCBXQVJSQU5UWSBPRiBBTlkg
S0lORCwgRVhQUkVTUyBPUg0KKyAqIElNUExJRUQsIElOQ0xVRElORyBCVVQgTk9UIExJTUlURUQg
VE8gVEhFIFdBUlJBTlRJRVMgT0YgTUVSQ0hBTlRBQklMSVRZLA0KKyAqIEZJVE5FU1MgRk9SIEEg
UEFSVElDVUxBUiBQVVJQT1NFIEFORCBOT05JTkZSSU5HRU1FTlQuIElOIE5PIEVWRU5UIFNIQUxM
DQorICogVEhFIEFVVEhPUlMgT1IgQ09QWVJJR0hUIEhPTERFUlMgQkUgTElBQkxFIEZPUiBBTlkg
Q0xBSU0sIERBTUFHRVMgT1IgT1RIRVINCisgKiBMSUFCSUxJVFksIFdIRVRIRVIgSU4gQU4gQUNU
SU9OIE9GIENPTlRSQUNULCBUT1JUIE9SIE9USEVSV0lTRSwgQVJJU0lORyBGUk9NLA0KKyAqIE9V
VCBPRiBPUiBJTiBDT05ORUNUSU9OIFdJVEggVEhFIFNPRlRXQVJFIE9SIFRIRSBVU0UgT1IgT1RI
RVIgREVBTElOR1MgSU4NCisgKiBUSEUgU09GVFdBUkUuDQorICovDQorDQorI2luY2x1ZGUgInFl
bXUvb3NkZXAuaCINCisjaW5jbHVkZSAicWFwaS9lcnJvci5oIg0KKyNpbmNsdWRlICJody9ib2Fy
ZHMuaCINCisjaW5jbHVkZSAicWVtdS9lcnJvci1yZXBvcnQuaCINCisjaW5jbHVkZSAiaHcvYXJt
L3N0bTMyZjQwNV9zb2MuaCINCisjaW5jbHVkZSAiaHcvYXJtL2FybS5oIg0KKw0KK3R5cGVkZWYg
c3RydWN0IEFSTVY3TVJlc2V0QXJncyB7DQorICAgIEFSTUNQVSAqY3B1Ow0KKyAgICB1aW50MzJf
dCByZXNldF9zcDsNCisgICAgdWludDMyX3QgcmVzZXRfcGM7DQorfSBBUk1WN01SZXNldEFyZ3M7
DQorDQorc3RhdGljIHZvaWQgYXJtdjdtX3Jlc2V0KHZvaWQgKm9wYXF1ZSkNCit7DQorICAgIEFS
TVY3TVJlc2V0QXJncyAqYXJncyA9IG9wYXF1ZTsNCisNCisgICAgY3B1X3Jlc2V0KENQVShhcmdz
LT5jcHUpKTsNCisNCisgICAgYXJncy0+Y3B1LT5lbnYucmVnc1sxM10gPSBhcmdzLT5yZXNldF9z
cCAmIDB4RkZGRkZGRkM7DQorICAgIGFyZ3MtPmNwdS0+ZW52LnRodW1iID0gYXJncy0+cmVzZXRf
cGMgJiAxOw0KKyAgICBhcmdzLT5jcHUtPmVudi5yZWdzWzE1XSA9IGFyZ3MtPnJlc2V0X3BjICYg
fjE7DQorfQ0KKw0KK3N0YXRpYyB2b2lkIG5ldGR1aW5vcGx1czJfaW5pdChNYWNoaW5lU3RhdGUg
Km1hY2hpbmUpDQorew0KKyAgICBEZXZpY2VTdGF0ZSAqZGV2Ow0KKyAgICBBUk1WN01SZXNldEFy
Z3MgcmVzZXRfYXJnczsNCisgICAgdWludDY0X3QgZW50cnk7DQorDQorICAgIGRldiA9IHFkZXZf
Y3JlYXRlKE5VTEwsIFRZUEVfU1RNMzJGNDA1X1NPQyk7DQorICAgIHFkZXZfcHJvcF9zZXRfc3Ry
aW5nKGRldiwgImNwdS10eXBlIiwgQVJNX0NQVV9UWVBFX05BTUUoImNvcnRleC1tNCIpKTsNCisg
ICAgb2JqZWN0X3Byb3BlcnR5X3NldF9ib29sKE9CSkVDVChkZXYpLCB0cnVlLCAicmVhbGl6ZWQi
LCAmZXJyb3JfZmF0YWwpOw0KKw0KKyAgICBlbnRyeSA9IGFybXY3bV9sb2FkX2tlcm5lbChBUk1f
Q1BVKGZpcnN0X2NwdSksIG1hY2hpbmUtPmtlcm5lbF9maWxlbmFtZSwNCisgICAgICAgICAgICAg
ICAgICAgICAgIEZMQVNIX1NJWkUpOw0KKw0KKyAgICByZXNldF9hcmdzID0gKEFSTVY3TVJlc2V0
QXJncykgew0KKyAgICAgICAgLmNwdSA9IEFSTV9DUFUoZmlyc3RfY3B1KSwNCisgICAgICAgIC5y
ZXNldF9wYyA9IGVudHJ5LA0KKyAgICAgICAgLnJlc2V0X3NwID0gKFNSQU1fQkFTRV9BRERSRVNT
ICsgKFNSQU1fU0laRSAqIDIpIC8gMyksDQorICAgIH07DQorICAgIHFlbXVfcmVnaXN0ZXJfcmVz
ZXQoYXJtdjdtX3Jlc2V0LA0KKyAgICAgICAgICAgICAgICAgICAgICAgIGdfbWVtZHVwKCZyZXNl
dF9hcmdzLCBzaXplb2YocmVzZXRfYXJncykpKTsNCit9DQorDQorc3RhdGljIHZvaWQgbmV0ZHVp
bm9wbHVzMl9tYWNoaW5lX2luaXQoTWFjaGluZUNsYXNzICptYykNCit7DQorICAgIG1jLT5kZXNj
ID0gIk5ldGR1aW5vIFBsdXMgMiBNYWNoaW5lIjsNCisgICAgbWMtPmluaXQgPSBuZXRkdWlub3Bs
dXMyX2luaXQ7DQorfQ0KKw0KK0RFRklORV9NQUNISU5FKCJuZXRkdWlub3BsdXMyIiwgbmV0ZHVp
bm9wbHVzMl9tYWNoaW5lX2luaXQpDQotLSANCjIuMjEuMA0KDQo=

