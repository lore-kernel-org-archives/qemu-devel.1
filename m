Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046E4C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:41:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C501E2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="0YmlEgVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C501E2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwg64-00036v-VU
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 00:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iwfzh-000881-7v
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iwfzf-000288-W6
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:29 -0500
Received: from mail-mw2nam10on2098.outbound.protection.outlook.com
 ([40.107.94.98]:3168 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iwfzf-0001yv-OW
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBg//WvoQEPnius3XNO4CJxMRKHvi5o/DPMbSW4+bq8/hiEyH38S99+RafnWUaK3kQeDB9oFPafEAkVuLR9qne/VFSjKM1u6FBstGU4JWtA/uARVMIh92Dv1uVqpegagfF3nrn2kqYEKMqmhHDIoyrrOI3ctc0Zv6YB1SgrgU3czrwanGNgYAHgdNFG9xuEaP5uF4CituS6lpUcdIVBVcN48r1YN7nwHrAq34fVhkX86DUFBOxEziCW7rpknRXk2CsAejaIXpbQqMmdS9JbYuOKK5UVhMh5I/ZQXyh0RSs3m5M59Os8EfZnaRSLsJzPPuG2XSSzetNN0MGueEqiHXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdgitjO3CD4rrBrg9NYpC6FVCpKwKLa+E7Nsm2IjMDs=;
 b=a/ZKDqsaVcaaf9NwWvikp/HCC7zrQP5Q58OY5BYnZECI4HMiPwZ0SrCNm+HUgu73sXEZz36hB9yDocDeM+vo4VgNlKjrnFoT93/D2ZbHJ6Te22HmOndUei9cVci4/epmDoAqJSk9ImuU/12XrqgOWIr8blNKsWpOw2LmzDAgK3duUqWbNu3UO1tM+x+LCfeSkl1Z3qdw+WAkJB4nozcaKR+VGfIeJY/3r5ri7bugRJ+ZPmX1NZLyAj+k10suow3HY47TlqEINTrlTW3tBvo+lXZGVUy4yKOPgMJ6GiLNN5ct6p84PlfXF+1xULmVoCABCRcGxvKoqs3/docZPvlfUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdgitjO3CD4rrBrg9NYpC6FVCpKwKLa+E7Nsm2IjMDs=;
 b=0YmlEgVo+TA7moVB10xmR6O7KYazT0J7gn6AZNYcBlqCY/CLo/+EWujE4FRffgc7lFGK9Nw8l/we6TURawz4gIjwuc9Fm2QEd5EchXAw3/qbaLhdxyDdgnLO+cfsLnxualYEUIR3uFv1c6NIdIMOoD35fn8Y3OB1TJHj6KCZX30=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4206.namprd03.prod.outlook.com (52.135.110.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Wed, 29 Jan 2020 05:34:25 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 05:34:25 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:c0::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.19 via Frontend Transport; Wed, 29 Jan 2020 05:34:25 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v8 17/21] fuzz: add configure flag --enable-fuzzing
Thread-Topic: [PATCH v8 17/21] fuzz: add configure flag --enable-fuzzing
Thread-Index: AQHV1mXEx5xFFQZc/UWNMl5HfXJgfg==
Date: Wed, 29 Jan 2020 05:34:25 +0000
Message-ID: <20200129053357.27454-18-alxndr@bu.edu>
References: <20200129053357.27454-1-alxndr@bu.edu>
In-Reply-To: <20200129053357.27454-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:c0::42) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc06401a-83fc-4dfb-d392-08d7a47ce713
x-ms-traffictypediagnostic: SN6PR03MB4206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB42060010BB9D0B2549980BADBA050@SN6PR03MB4206.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(189003)(199004)(478600001)(75432002)(36756003)(316002)(6916009)(2906002)(786003)(4326008)(54906003)(26005)(186003)(956004)(2616005)(6486002)(7696005)(52116002)(16526019)(1076003)(5660300002)(71200400001)(86362001)(66446008)(66556008)(66946007)(66476007)(8936002)(81156014)(81166006)(64756008)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4206;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UVOMCpziddxryThzqGOAqVQ+4SVHzGgIDeAlOraew0oHW2PB/hDt+NrssQoOSf9+K05pQSJp1NxlIo6CUrYvzEYjm4F3HuJRlMmXk1Xkz7WjSpH1wftc3VD4MHUgeR9HdXn6k7B8q4ODEwLwkI6VDip5mOvbV19fN4qVb6sogsx4ULl9Hq+vRnsJGvJs3a4G6oD36/RGp8FRbvgHTzZq5mHC0BfMlRSD3+yd0U8CWD2BnLcFkv2X88lKu+VieIQPI1/4dcnJBzBQssDWGl3t0UIgCy8J15bSv/BIdFUH855XfYrPI+AsG1zjJTLT4/vkBwZeXYvoUJHxXoXf9Gx3nD012mwPp4GKwN5lLU3NyCchdcBzlS00U0Hy2cdpgNsEj3W1URyT1eGhh5AZSshArumOJNU1nsX8IOmx7b9fa4b3N4ecKS0c8afExDMrteYv
x-ms-exchange-antispam-messagedata: Gjn0aRhI9+f+T2f1kAPPTA2zAKk7k+sFdwlw6MrUHC3La3L7LOOT4JAoaISeLCbweZo6ubfgGpP+KcXHyyI0QSbjvmkWfnpYgiWA/cG/bsvGbd7kji0Jv5zJwspL/hoDQxJoNL3lb5kneE4zp2oHdg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0D07BB270B7EF4F93DAEB01B7676F27@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: bc06401a-83fc-4dfb-d392-08d7a47ce713
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 05:34:25.7539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PJkq9pbLjgxFXutcm8WhecyyxTM2n4NTl8WVq/e98Zy1YPMroKSvlgma8TILZNGE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4206
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.98
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
b25maWd1cmUNCmluZGV4IDA4YzNhMWMxZjAuLjFhMWU1N2ViNjEgMTAwNzU1DQotLS0gYS9jb25m
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
emVyIg0KKyAgICBDRkxBR1M9IiAtZnNhbml0aXplPWFkZHJlc3MsZnV6emVyLW5vLWxpbmsiDQor
ICBlbHNlDQorICAgIGVycm9yX2V4aXQgIllvdXIgY29tcGlsZXIgZG9lc24ndCBzdXBwb3J0IC1m
c2FuaXRpemU9YWRkcmVzcyxmdXp6ZXIiDQorICAgIGV4aXQgMQ0KKyAgZmkNCitmaQ0KIA0KIGlm
IHRlc3QgIiRwbHVnaW5zIiA9ICJ5ZXMiIDsgdGhlbg0KICAgICBlY2hvICJDT05GSUdfUExVR0lO
PXkiID4+ICRjb25maWdfaG9zdF9tYWsNCkBAIC03NTAyLDYgKzc1MzYsMTEgQEAgaWYgdGVzdCAi
JGxpYnVkZXYiICE9ICJubyI7IHRoZW4NCiAgICAgZWNobyAiQ09ORklHX0xJQlVERVY9eSIgPj4g
JGNvbmZpZ19ob3N0X21haw0KICAgICBlY2hvICJMSUJVREVWX0xJQlM9JGxpYnVkZXZfbGlicyIg
Pj4gJGNvbmZpZ19ob3N0X21haw0KIGZpDQoraWYgdGVzdCAiJGZ1enppbmciICE9ICJubyI7IHRo
ZW4NCisgICAgZWNobyAiQ09ORklHX0ZVWlo9eSIgPj4gJGNvbmZpZ19ob3N0X21haw0KKyAgICBl
Y2hvICJGVVpaX0NGTEFHUz0kRlVaWl9DRkxBR1MiID4+ICRjb25maWdfaG9zdF9tYWsNCisgICAg
ZWNobyAiRlVaWl9MREZMQUdTPSRGVVpaX0xERkxBR1MiID4+ICRjb25maWdfaG9zdF9tYWsNCitm
aQ0KIA0KIGlmIHRlc3QgIiRlZGsyX2Jsb2JzIiA9ICJ5ZXMiIDsgdGhlbg0KICAgZWNobyAiREVD
T01QUkVTU19FREsyX0JMT0JTPXkiID4+ICRjb25maWdfaG9zdF9tYWsNCi0tIA0KMi4yMy4wDQoN
Cg==

