Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43063C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 04:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ECF0208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 04:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECF0208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35098 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdSdJ-0006Jl-Cs
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 00:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60107)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair@alistair23.me>) id 1hdSbo-0004mx-Pv
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 00:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair@alistair23.me>) id 1hdSbm-0001SL-Ao
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 00:54:08 -0400
Received: from mail-oln040092254097.outbound.protection.outlook.com
 ([40.92.254.97]:6251 helo=APC01-PU1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alistair@alistair23.me>)
 id 1hdSbk-0001O1-Gg
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 00:54:06 -0400
Received: from PU1APC01FT111.eop-APC01.prod.protection.outlook.com
 (10.152.252.60) by PU1APC01HT089.eop-APC01.prod.protection.outlook.com
 (10.152.253.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1987.11; Wed, 19 Jun
 2019 04:54:00 +0000
Received: from PSXP216MB0277.KORP216.PROD.OUTLOOK.COM (10.152.252.55) by
 PU1APC01FT111.mail.protection.outlook.com (10.152.252.236) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1987.11 via Frontend Transport; Wed, 19 Jun 2019 04:54:00 +0000
Received: from PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
 ([fe80::61e4:d213:4652:f57]) by PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
 ([fe80::61e4:d213:4652:f57%2]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 04:54:00 +0000
From: Alistair Francis <alistair@alistair23.me>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Thread-Topic: [PATCH v3 2/6] target/arm: Allow setting M mode entry and sp
Thread-Index: AQHVJlsCe63soULkFEyFsLpmPqyq6w==
Date: Wed, 19 Jun 2019 04:54:00 +0000
Message-ID: <PSXP216MB0277171F4F3978296BE895F2DDE50@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
References: <cover.1560919807.git.alistair@alistair23.me>
In-Reply-To: <cover.1560919807.git.alistair@alistair23.me>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::27) To PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:a::18)
x-incomingtopheadermarker: OriginalChecksum:EAC69A564BCC459E684983C2E7078AB5D6C6A72480CB2538983766ADA1C575FC;
 UpperCasedChecksum:35F037B8E5F97E9E73DDB9116FD0B686BE0452F59BF463E1FFFFA909C30B4791;
 SizeAsReceived:7592; Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-tmn: [rwbUa17xRvQ7tmtQJZp2bT7GiHmBSaYHXgxjmcUDAAqv22gWTgwysoRkQz5vt5HQ]
x-microsoft-original-message-id: <4324151ebdcdadcb1a5a2d3f4242d248625b919e.1560919807.git.alistair@alistair23.me>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:PU1APC01HT089; 
x-ms-traffictypediagnostic: PU1APC01HT089:
x-microsoft-antispam-message-info: xME6ZfnJlfb8KF1vbwGyphP94mJsKvaq0QP564D5I3QSkuC0NhksDt2jSlSmj0mtmTK7MUdstVCYZmiXJOEXYeoh4gFDPxULHzOtBour9iDvFOcymKZHT828kcqzM/EmS/gV8luyjzGec40dHZsbot/dMxlQtSfAR1FrgyP0p4VNk6x1ieNRpDkKEFqnq+ZB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd77575-039a-432b-b3b6-08d6f47224ca
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 04:54:00.6772 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT089
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.92.254.97
Subject: [Qemu-devel] [PATCH v3 2/6] target/arm: Allow setting M mode entry
 and sp
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

QWRkIE0gbW9kZSBpbml0aWFsIGVudHJ5IFBDIGFuZCBTUCBwcm9wZXJ0aWVzLg0KDQpTaWduZWQt
b2ZmLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpckBhbGlzdGFpcjIzLm1lPg0KLS0tDQog
dGFyZ2V0L2FybS9jcHUuYyB8IDQ3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQogdGFyZ2V0L2FybS9jcHUuaCB8ICAzICsrKw0KIDIgZmlsZXMgY2hhbmdl
ZCwgNTAgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2FybS9jcHUuYyBiL3Rh
cmdldC9hcm0vY3B1LmMNCmluZGV4IDM3NmRiMTU0ZjAuLjFkODM5NzJhYjEgMTAwNjQ0DQotLS0g
YS90YXJnZXQvYXJtL2NwdS5jDQorKysgYi90YXJnZXQvYXJtL2NwdS5jDQpAQCAtMzAxLDYgKzMw
MSw5IEBAIHN0YXRpYyB2b2lkIGFybV9jcHVfcmVzZXQoQ1BVU3RhdGUgKnMpDQogICAgICAgICAg
ICAgICovDQogICAgICAgICAgICAgaW5pdGlhbF9tc3AgPSBsZGxfcChyb20pOw0KICAgICAgICAg
ICAgIGluaXRpYWxfcGMgPSBsZGxfcChyb20gKyA0KTsNCisgICAgICAgIH0gZWxzZSBpZiAoY3B1
LT5pbml0X3NwIHx8IGNwdS0+aW5pdF9lbnRyeSkgew0KKyAgICAgICAgICAgIGluaXRpYWxfbXNw
ID0gY3B1LT5pbml0X3NwOw0KKyAgICAgICAgICAgIGluaXRpYWxfcGMgPSBjcHUtPmluaXRfZW50
cnk7DQogICAgICAgICB9IGVsc2Ugew0KICAgICAgICAgICAgIC8qIEFkZHJlc3MgemVybyBub3Qg
Y292ZXJlZCBieSBhIFJPTSBibG9iLCBvciB0aGUgUk9NIGJsb2INCiAgICAgICAgICAgICAgKiBp
cyBpbiBub24tbW9kaWZpYWJsZSBtZW1vcnkgYW5kIHRoaXMgaXMgYSBzZWNvbmQgcmVzZXQgYWZ0
ZXINCkBAIC04MDEsNiArODA0LDM4IEBAIHN0YXRpYyB2b2lkIGFybV9zZXRfaW5pdF9zdnRvcihP
YmplY3QgKm9iaiwgVmlzaXRvciAqdiwgY29uc3QgY2hhciAqbmFtZSwNCiAgICAgdmlzaXRfdHlw
ZV91aW50MzIodiwgbmFtZSwgJmNwdS0+aW5pdF9zdnRvciwgZXJycCk7DQogfQ0KIA0KK3N0YXRp
YyB2b2lkIGFybV9nZXRfaW5pdF9zcChPYmplY3QgKm9iaiwgVmlzaXRvciAqdiwgY29uc3QgY2hh
ciAqbmFtZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqb3BhcXVlLCBFcnJv
ciAqKmVycnApDQorew0KKyAgICBBUk1DUFUgKmNwdSA9IEFSTV9DUFUob2JqKTsNCisNCisgICAg
dmlzaXRfdHlwZV91aW50MzIodiwgbmFtZSwgJmNwdS0+aW5pdF9zcCwgZXJycCk7DQorfQ0KKw0K
K3N0YXRpYyB2b2lkIGFybV9zZXRfaW5pdF9zcChPYmplY3QgKm9iaiwgVmlzaXRvciAqdiwgY29u
c3QgY2hhciAqbmFtZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqb3BhcXVl
LCBFcnJvciAqKmVycnApDQorew0KKyAgICBBUk1DUFUgKmNwdSA9IEFSTV9DUFUob2JqKTsNCisN
CisgICAgdmlzaXRfdHlwZV91aW50MzIodiwgbmFtZSwgJmNwdS0+aW5pdF9zcCwgZXJycCk7DQor
fQ0KKw0KK3N0YXRpYyB2b2lkIGFybV9nZXRfaW5pdF9lbnRyeShPYmplY3QgKm9iaiwgVmlzaXRv
ciAqdiwgY29uc3QgY2hhciAqbmFtZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9p
ZCAqb3BhcXVlLCBFcnJvciAqKmVycnApDQorew0KKyAgICBBUk1DUFUgKmNwdSA9IEFSTV9DUFUo
b2JqKTsNCisNCisgICAgdmlzaXRfdHlwZV91aW50MzIodiwgbmFtZSwgJmNwdS0+aW5pdF9lbnRy
eSwgZXJycCk7DQorfQ0KKw0KK3N0YXRpYyB2b2lkIGFybV9zZXRfaW5pdF9lbnRyeShPYmplY3Qg
Km9iaiwgVmlzaXRvciAqdiwgY29uc3QgY2hhciAqbmFtZSwNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdm9pZCAqb3BhcXVlLCBFcnJvciAqKmVycnApDQorew0KKyAgICBBUk1DUFUgKmNw
dSA9IEFSTV9DUFUob2JqKTsNCisNCisgICAgdmlzaXRfdHlwZV91aW50MzIodiwgbmFtZSwgJmNw
dS0+aW5pdF9lbnRyeSwgZXJycCk7DQorfQ0KKw0KIHZvaWQgYXJtX2NwdV9wb3N0X2luaXQoT2Jq
ZWN0ICpvYmopDQogew0KICAgICBBUk1DUFUgKmNwdSA9IEFSTV9DUFUob2JqKTsNCkBAIC05MTMs
NiArOTQ4LDE4IEBAIHZvaWQgYXJtX2NwdV9wb3N0X2luaXQoT2JqZWN0ICpvYmopDQogICAgICAg
ICBvYmplY3RfcHJvcGVydHlfYWRkKG9iaiwgImluaXQtc3Z0b3IiLCAidWludDMyIiwNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgYXJtX2dldF9pbml0X3N2dG9yLCBhcm1fc2V0X2luaXRf
c3Z0b3IsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwsIE5VTEwsICZlcnJvcl9h
Ym9ydCk7DQorICAgIH0gZWxzZSB7DQorICAgICAgICAvKg0KKyAgICAgICAgICogTSBwcm9maWxl
OiBpbml0aWFsIHZhbHVlIG9mIHRoZSBTUCBhbmQgZW50cnkuIFdlIGNhbid0IGp1c3QgdXNlDQor
ICAgICAgICAgKiBhIHNpbXBsZSBERUZJTkVfUFJPUF9VSU5UMzIgZm9yIHRoaXMgYmVjYXVzZSB3
ZSB3YW50IHRvIHBlcm1pdA0KKyAgICAgICAgICogdGhlIHByb3BlcnR5IHRvIGJlIHNldCBhZnRl
ciByZWFsaXplLg0KKyAgICAgICAgICovDQorICAgICAgICBvYmplY3RfcHJvcGVydHlfYWRkKG9i
aiwgImluaXQtc3AiLCAidWludDMyIiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXJt
X2dldF9pbml0X3NwLCBhcm1fc2V0X2luaXRfc3AsDQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIE5VTEwsIE5VTEwsICZlcnJvcl9hYm9ydCk7DQorICAgICAgICBvYmplY3RfcHJvcGVydHlf
YWRkKG9iaiwgImluaXQtZW50cnkiLCAidWludDMyIiwNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYXJtX2dldF9pbml0X2VudHJ5LCBhcm1fc2V0X2luaXRfZW50cnksDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIE5VTEwsIE5VTEwsICZlcnJvcl9hYm9ydCk7DQogICAgIH0NCiAN
CiAgICAgcWRldl9wcm9wZXJ0eV9hZGRfc3RhdGljKERFVklDRShvYmopLCAmYXJtX2NwdV9jZmdl
bmRfcHJvcGVydHksDQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2FybS9jcHUuaCBiL3RhcmdldC9hcm0v
Y3B1LmgNCmluZGV4IGY5ZGE2NzJiZTUuLjI5MGZhYzE5ZDMgMTAwNjQ0DQotLS0gYS90YXJnZXQv
YXJtL2NwdS5oDQorKysgYi90YXJnZXQvYXJtL2NwdS5oDQpAQCAtODA1LDYgKzgwNSw5IEBAIHN0
cnVjdCBBUk1DUFUgew0KICAgICAgKi8NCiAgICAgdWludDMyX3QgcHNjaV9jb25kdWl0Ow0KIA0K
KyAgICAvKiBGb3IgTSwgaW5pdGlhbCB2YWx1ZSBvZiB0aGUgZW50cnkgYW5kIFNQICovDQorICAg
IHVpbnQzMl90IGluaXRfc3AsIGluaXRfZW50cnk7DQorDQogICAgIC8qIEZvciB2OE0sIGluaXRp
YWwgdmFsdWUgb2YgdGhlIFNlY3VyZSBWVE9SICovDQogICAgIHVpbnQzMl90IGluaXRfc3Z0b3I7
DQogDQotLSANCjIuMTEuMA0KDQo=

