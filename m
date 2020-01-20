Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7AEC33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCC72073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="e5anO+0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCC72073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itQK0-0004Cp-Vv
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 01:14:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1itQ1j-0007Ks-83
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:55:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1itQ1h-0006UK-54
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:55:07 -0500
Received: from mail-bn7nam10on2106.outbound.protection.outlook.com
 ([40.107.92.106]:1376 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1itQ1h-0006Tr-0W
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:55:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y092sJNmoxdgCWsouClObyaCoG2/Z9ZE0xnW9xetubVe4nUsWbDH/sOlf2mIOe4grVqCOANn2qKHR4bEBM6gy3h8VcRQMdbqy31ScJZxudGKAVrM3372r0QELHHJxvNHo/WzCEdy5pEjFWZMcGz5kmW28v0KvXr6SuMPo4Nik4/vmQlwb9TxToQbg30ia/LrUghiCVFOWzEpyUomxwufZ1Rz4kXoBlqSDjNglmKUvZpIlXk5FgSNEsfC+szUhTkqn7+q0nMEzcStRvN1wmXafbF+7sMyp7rk5prKgJWRpVIl0wA0w2bjEWatNyQgNCmEVivk1gH+rOMkB7k8vEY47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvNYeeaXgAhc60bU8SP/MWFwQDDsLlrZP1iRKlujo9A=;
 b=a4/UdlntJoDcFJJ0qEy5N/4xq0dvMhwOy8/x+s5cSphIyb7uJ1L6ygMlZUSE94g6XHxhrIMBy9cqd+pfJu3zci1b2IXD7ul5gzqrlWsO7tgSQi/he9fcoMh/Z++MUQ6xjLxkW0MywpcYmji2Jnqu5hj4m7lnevD0ruN6qihCKC6pZ/HmC90zh7Ex96G3fJ52R/CNbcxbRyyyDFxJUOB812KleuEe3lZIUT7tMdTFzkUFgfyRKmxArvlYJVHvl1Y8AnzPgH5hvHv9WTvQ4lsD9labSNl4vApzagSoDCdl0Zp9PzquBhFPCFRtdbPPlXgmq7IEJtzketQ1jAA+dnUh5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvNYeeaXgAhc60bU8SP/MWFwQDDsLlrZP1iRKlujo9A=;
 b=e5anO+0iKEhazDS6GENl+VG/Y/b8Dpn0TMXG9dPVdM1ZbZJgK2wBnsC89RsIOq4ClkZjEEShjJoQ9kmtBQ1kXDlgu6Hp+JpTex0dDDJBAvsOPXoj7eV9l+3jcxt+F9BpoT5HwH6+WXRBR5T+jJSmY8wFRF9+u6wJEo7Xn3TQ+I0=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4399.namprd03.prod.outlook.com (20.178.6.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 05:55:04 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 05:55:04 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR20CA0032.namprd20.prod.outlook.com (2603:10b6:208:e8::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Mon, 20 Jan 2020 05:55:02 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v7 16/20] fuzz: add configure flag --enable-fuzzing
Thread-Topic: [PATCH v7 16/20] fuzz: add configure flag --enable-fuzzing
Thread-Index: AQHVz1YogdWBjjfeR0OaAS+bGjs0Eg==
Date: Mon, 20 Jan 2020 05:55:03 +0000
Message-ID: <20200120055410.22322-22-alxndr@bu.edu>
References: <20200120055410.22322-1-alxndr@bu.edu>
In-Reply-To: <20200120055410.22322-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:208:e8::45) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a1273b8-fc3d-45c2-e5a4-08d79d6d4af9
x-ms-traffictypediagnostic: SN6PR03MB4399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB43994F5B40B605FA37D8D8ADBA320@SN6PR03MB4399.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(5660300002)(956004)(2616005)(8936002)(86362001)(6916009)(6486002)(7696005)(1076003)(52116002)(316002)(71200400001)(16526019)(186003)(786003)(478600001)(2906002)(26005)(81166006)(66946007)(66476007)(64756008)(36756003)(8676002)(75432002)(81156014)(66446008)(4326008)(66556008)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4399;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iqvuJ03dwg/6pbqNG6QUueOOZmYISa8nAUS9KXQlECexZ3NQhecJoQmyhDmc7pSGM6W5iBC+e4nShYhXsvT/C9ly7sJkgOcdERab6jGKP3f0SyMGsJY54ETcbhdtNPuX9kR2nBxEL7vCQkNkBoL42MPmhw6YZmq4usf+XNs8E3GH8Qcyw1qcXnNktNRAwu8w5cH9FH7UEeIsIb7FgkCFym0tw2AZu3E87tTJJYO4QAK7oR/wE1CU5DT9JM7+3nBO1f4uYrTr7eGMj04kuUTHN2xO968M5NZqre851WvVKuTeH4yS97wmTmtallvTPMz2FWsdG8mJUe3kGFD9zeC5ydvenLfWAJah84t65sWvFY/rYIjfoM5ycxBtGXSSMsYryZRZteE0f4Liertcsxje+noC/tNCv+u+ttsYrpWUFnDaqGJuJG8fdTs9cdR1uSE7
Content-Type: text/plain; charset="utf-8"
Content-ID: <F970F46B71F4A8418171FC5CA49887F7@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1273b8-fc3d-45c2-e5a4-08d79d6d4af9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 05:55:03.5329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZoiBYnTKXzXBE28/khl9wdN9oW+lnJAO2wIyMBiSkkKumgY3jNE/xPWMJER5SmGK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4399
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.106
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "Bulekov, 
 Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

U2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIEJ1bGVrb3YgPGFseG5kckBidS5lZHU+DQpSZXZpZXdl
ZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPg0KUmV2aWV3ZWQtYnk6
IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4NCi0tLQ0KIGNvbmZp
Z3VyZSB8IDM5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmls
ZSBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9jb25maWd1cmUgYi9j
b25maWd1cmUNCmluZGV4IDA4YzNhMWMxZjAuLjE3YWE1ZDAyZWUgMTAwNzU1DQotLS0gYS9jb25m
aWd1cmUNCisrKyBiL2NvbmZpZ3VyZQ0KQEAgLTUwNCw2ICs1MDQsNyBAQCBkZWJ1Z19tdXRleD0i
bm8iDQogbGlicG1lbT0iIg0KIGRlZmF1bHRfZGV2aWNlcz0ieWVzIg0KIHBsdWdpbnM9Im5vIg0K
K2Z1enppbmc9Im5vIg0KIA0KIHN1cHBvcnRlZF9jcHU9Im5vIg0KIHN1cHBvcnRlZF9vcz0ibm8i
DQpAQCAtNjM0LDYgKzYzNSwxNSBAQCBpbnQgbWFpbih2b2lkKSB7IHJldHVybiAwOyB9DQogRU9G
DQogfQ0KIA0KK3dyaXRlX2NfZnV6emVyX3NrZWxldG9uKCkgew0KKyAgICBjYXQgPiAkVE1QQyA8
PEVPRg0KKyNpbmNsdWRlIDxzdGRpbnQuaD4NCisjaW5jbHVkZSA8c3lzL3R5cGVzLmg+DQoraW50
IExMVk1GdXp6ZXJUZXN0T25lSW5wdXQoY29uc3QgdWludDhfdCAqRGF0YSwgc2l6ZV90IFNpemUp
Ow0KK2ludCBMTFZNRnV6emVyVGVzdE9uZUlucHV0KGNvbnN0IHVpbnQ4X3QgKkRhdGEsIHNpemVf
dCBTaXplKSB7IHJldHVybiAwOyB9DQorRU9GDQorfQ0KKw0KIGlmIGNoZWNrX2RlZmluZSBfX2xp
bnV4X18gOyB0aGVuDQogICB0YXJnZXRvcz0iTGludXgiDQogZWxpZiBjaGVja19kZWZpbmUgX1dJ
TjMyIDsgdGhlbg0KQEAgLTE1NDAsNiArMTU1MCwxMCBAQCBmb3Igb3B0IGRvDQogICA7Ow0KICAg
LS1kaXNhYmxlLWNvbnRhaW5lcnMpIHVzZV9jb250YWluZXJzPSJubyINCiAgIDs7DQorICAtLWVu
YWJsZS1mdXp6aW5nKSBmdXp6aW5nPXllcw0KKyAgOzsNCisgIC0tZGlzYWJsZS1mdXp6aW5nKSBm
dXp6aW5nPW5vDQorICA7Ow0KICAgKikNCiAgICAgICBlY2hvICJFUlJPUjogdW5rbm93biBvcHRp
b24gJG9wdCINCiAgICAgICBlY2hvICJUcnkgJyQwIC0taGVscCcgZm9yIG1vcmUgaW5mb3JtYXRp
b24iDQpAQCAtNTk5Miw2ICs2MDA2LDE1IEBAIEVPRg0KICAgZmkNCiBmaQ0KIA0KKyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIw0KKyMgY2hlY2tzIGZvciBmdXp6ZXIN
CitpZiB0ZXN0ICIkZnV6emluZyIgPSAieWVzIiA7IHRoZW4NCisgIHdyaXRlX2NfZnV6emVyX3Nr
ZWxldG9uDQorICBpZiBjb21waWxlX3Byb2cgIiRDUFVfQ0ZMQUdTIC1XZXJyb3IgLWZzYW5pdGl6
ZT1hZGRyZXNzLGZ1enplciIgIiI7IHRoZW4NCisgICAgICBoYXZlX2Z1enplcj15ZXMNCisgIGZp
DQorZmkNCisNCiAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMNCiAj
IGNoZWNrIGZvciBsaWJwbWVtDQogDQpAQCAtNjU3Niw2ICs2NTk5LDcgQEAgZWNobyAibGlicG1l
bSBzdXBwb3J0ICAgJGxpYnBtZW0iDQogZWNobyAibGlidWRldiAgICAgICAgICAgJGxpYnVkZXYi
DQogZWNobyAiZGVmYXVsdCBkZXZpY2VzICAgJGRlZmF1bHRfZGV2aWNlcyINCiBlY2hvICJwbHVn
aW4gc3VwcG9ydCAgICAkcGx1Z2lucyINCitlY2hvICJmdXp6aW5nIHN1cHBvcnQgICAkZnV6emlu
ZyINCiANCiBpZiB0ZXN0ICIkc3VwcG9ydGVkX2NwdSIgPSAibm8iOyB0aGVuDQogICAgIGVjaG8N
CkBAIC03NDAwLDYgKzc0MjQsMTYgQEAgZmkNCiBpZiB0ZXN0ICIkc2hlZXBkb2ciID0gInllcyIg
OyB0aGVuDQogICBlY2hvICJDT05GSUdfU0hFRVBET0c9eSIgPj4gJGNvbmZpZ19ob3N0X21haw0K
IGZpDQoraWYgdGVzdCAiJGZ1enppbmciID0gInllcyIgOyB0aGVuDQorICBpZiB0ZXN0ICIkaGF2
ZV9mdXp6ZXIiID0gInllcyI7IHRoZW4NCisgICAgRlVaWl9MREZMQUdTPSIgLWZzYW5pdGl6ZT1h
ZGRyZXNzLGZ1enplciINCisgICAgRlVaWl9DRkxBR1M9IiAtZnNhbml0aXplPWFkZHJlc3MsZnV6
emVyIg0KKyAgICBDRkxBR1M9IiAtZnNhbml0aXplPWFkZHJlc3MsZnV6emVyIg0KKyAgZWxzZQ0K
KyAgICBlcnJvcl9leGl0ICJZb3VyIGNvbXBpbGVyIGRvZXNuJ3Qgc3VwcG9ydCAtZnNhbml0aXpl
PWFkZHJlc3MsZnV6emVyIg0KKyAgICBleGl0IDENCisgIGZpDQorZmkNCiANCiBpZiB0ZXN0ICIk
cGx1Z2lucyIgPSAieWVzIiA7IHRoZW4NCiAgICAgZWNobyAiQ09ORklHX1BMVUdJTj15IiA+PiAk
Y29uZmlnX2hvc3RfbWFrDQpAQCAtNzUwMiw2ICs3NTM2LDExIEBAIGlmIHRlc3QgIiRsaWJ1ZGV2
IiAhPSAibm8iOyB0aGVuDQogICAgIGVjaG8gIkNPTkZJR19MSUJVREVWPXkiID4+ICRjb25maWdf
aG9zdF9tYWsNCiAgICAgZWNobyAiTElCVURFVl9MSUJTPSRsaWJ1ZGV2X2xpYnMiID4+ICRjb25m
aWdfaG9zdF9tYWsNCiBmaQ0KK2lmIHRlc3QgIiRmdXp6aW5nIiAhPSAibm8iOyB0aGVuDQorICAg
IGVjaG8gIkNPTkZJR19GVVpaPXkiID4+ICRjb25maWdfaG9zdF9tYWsNCisgICAgZWNobyAiRlVa
Wl9DRkxBR1M9JEZVWlpfQ0ZMQUdTIiA+PiAkY29uZmlnX2hvc3RfbWFrDQorICAgIGVjaG8gIkZV
WlpfTERGTEFHUz0kRlVaWl9MREZMQUdTIiA+PiAkY29uZmlnX2hvc3RfbWFrDQorZmkNCiANCiBp
ZiB0ZXN0ICIkZWRrMl9ibG9icyIgPSAieWVzIiA7IHRoZW4NCiAgIGVjaG8gIkRFQ09NUFJFU1Nf
RURLMl9CTE9CUz15IiA+PiAkY29uZmlnX2hvc3RfbWFrDQotLSANCjIuMjMuMA0KDQo=

