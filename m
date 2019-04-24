Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F9BC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:20:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4231208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yYBwWvH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4231208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44158 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJKdg-0002iL-8D
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 12:20:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTn-0002De-90
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTl-00049e-0C
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:39 -0400
Received: from mail-eopbgr780088.outbound.protection.outlook.com
	([40.107.78.88]:16416
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hJKTU-0003kU-PC
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=1k3yTLfAOpQNjItVf1n8/kzU5oSESr6IFmtwKbw/m6E=;
	b=yYBwWvH/g5B/WVRqTIH44Fjof6tVLwyZfJ2WSYmOGbQtNk+tVD9/+FiqDaCR3DpREmMSpU+aQlXaewT0loyPpV/T8RCeK6MjUINarGBj4+UHhec4Xgkgu6AWjQrHxAXzfkidwSoJwwKDSdmu8ni/a5XX4pKYI2lMKSZUGV2xX2w=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
	DM6PR12MB2907.namprd12.prod.outlook.com (20.179.71.213) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.12; Wed, 24 Apr 2019 16:10:06 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43]) by
	DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43%5]) with mapi id 15.20.1813.017;
	Wed, 24 Apr 2019 16:10:06 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Thread-Topic: [RFC PATCH v1 06/10] KVM: SVM: Add KVM_SEV_RECEIVE_FINISH command
Thread-Index: AQHU+rguSwzIIWi8mUmY4fmqgtGvcg==
Date: Wed, 24 Apr 2019 16:10:06 +0000
Message-ID: <20190424160942.13567-7-brijesh.singh@amd.com>
References: <20190424160942.13567-1-brijesh.singh@amd.com>
In-Reply-To: <20190424160942.13567-1-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0601CA0019.namprd06.prod.outlook.com
	(2603:10b6:803:2f::29) To DM6PR12MB2682.namprd12.prod.outlook.com
	(2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21039f8e-e4b2-4d53-7dbd-08d6c8cf50f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB2907; 
x-ms-traffictypediagnostic: DM6PR12MB2907:
x-microsoft-antispam-prvs: <DM6PR12MB29070143935C3AE657C23D48E53C0@DM6PR12MB2907.namprd12.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(39860400002)(136003)(366004)(396003)(376002)(346002)(189003)(199004)(1730700003)(99286004)(2501003)(73956011)(478600001)(11346002)(6506007)(76176011)(14454004)(6116002)(52116002)(386003)(476003)(25786009)(66946007)(486006)(4326008)(71200400001)(66446008)(66556008)(3846002)(66476007)(64756008)(1076003)(66574012)(71190400001)(446003)(186003)(2616005)(5660300002)(2351001)(102836004)(97736004)(26005)(14444005)(86362001)(6512007)(8676002)(66066001)(8936002)(68736007)(2906002)(50226002)(256004)(81156014)(305945005)(36756003)(316002)(6436002)(54906003)(7736002)(5640700003)(81166006)(53936002)(6916009)(6486002)(7416002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2907;
	H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xk2Z7mLFE1GgetoreQhp8F4NVUCgAGNwJFg7290qPKNhwCGDzqvcG0vNERfncz8gTUYHFa5XXpjWqVpqymmJ1oB37r+sdN69bzFJvE4UEEq1e/I6j/xq6VwQpbHCCKj0qoavMzmtsNmD+EeYRYKGklo2S6AWocXSwY1oat8HFMZJ3Bc4GGeFOMyBS+ugqmxYOEM0Vfl6ICEjV+s4OATGShUfaemn3dwY5Nn1oTAFhFHViBgith2CwbRjWYVMrCU1K/BKu5hMEaT/zqkUK8rkggxAE1AnBJqpzaGh4rCa2AOJnzYaiko9PWML9DsbfK5uXgH9lvBsp8u24PPIxEuobA3NuQEFZNBE9zmbK4BBZQg7HEyCxjOIdJ3CVjoyJHtgn/XdHy8hx+dpg8d1H42urLHu30Vm+gdv9Q2CvtqIaX4=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <5ADB5861ED3C1840A806F4A75F5166A6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21039f8e-e4b2-4d53-7dbd-08d6c8cf50f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 16:10:06.4449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2907
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.88
Subject: [Qemu-devel] [RFC PATCH v1 06/10] KVM: SVM: Add
 KVM_SEV_RECEIVE_FINISH command
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
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Singh,
	Brijesh" <brijesh.singh@amd.com>,
	=?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
	Joerg Roedel <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424161006.7MlY8LBD2FIbId2C_gTn3TzaXAEft7r2GFPD0VtgzQM@z>

VGhlIGNvbW1hbmQgZmluYWxpemUgdGhlIGd1ZXN0IHJlY2VpdmluZyBwcm9jZXNzIGFuZCBtYWtl
IHRoZSBTRVYgZ3Vlc3QNCnJlYWR5IGZvciB0aGUgZXhlY3V0aW9uLg0KDQpDYzogVGhvbWFzIEds
ZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQpDYzogSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhh
dC5jb20+DQpDYzogIkguIFBldGVyIEFudmluIiA8aHBhQHp5dG9yLmNvbT4NCkNjOiBQYW9sbyBC
b256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KQ2M6ICJSYWRpbSBLcsSNbcOhxZkiIDxya3Jj
bWFyQHJlZGhhdC5jb20+DQpDYzogSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRlcy5vcmc+DQpDYzog
Qm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPg0KQ2M6IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxl
bmRhY2t5QGFtZC5jb20+DQpDYzogeDg2QGtlcm5lbC5vcmcNCkNjOiBrdm1Admdlci5rZXJuZWwu
b3JnDQpDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KU2lnbmVkLW9mZi1ieTogQnJp
amVzaCBTaW5naCA8YnJpamVzaC5zaW5naEBhbWQuY29tPg0KLS0tDQogLi4uL3ZpcnR1YWwva3Zt
L2FtZC1tZW1vcnktZW5jcnlwdGlvbi5yc3QgICAgIHwgIDggKysrKysrKw0KIGFyY2gveDg2L2t2
bS9zdm0uYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDIzICsrKysrKysrKysrKysrKysr
KysNCiAyIGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vdmlydHVhbC9rdm0vYW1kLW1lbW9yeS1lbmNyeXB0aW9uLnJzdCBiL0RvY3Vt
ZW50YXRpb24vdmlydHVhbC9rdm0vYW1kLW1lbW9yeS1lbmNyeXB0aW9uLnJzdA0KaW5kZXggYjlj
M2RjMDJmMzQ0Li43MmM0NWY5M2FiZDcgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL3ZpcnR1
YWwva3ZtL2FtZC1tZW1vcnktZW5jcnlwdGlvbi5yc3QNCisrKyBiL0RvY3VtZW50YXRpb24vdmly
dHVhbC9rdm0vYW1kLW1lbW9yeS1lbmNyeXB0aW9uLnJzdA0KQEAgLTM0Niw2ICszNDYsMTQgQEAg
UmV0dXJuczogMCBvbiBzdWNjZXNzLCAtbmVnYXRpdmUgb24gZXJyb3INCiAgICAgICAgICAgICAg
ICAgX191MzIgdHJhbnNfbGVuOw0KICAgICAgICAgfTsNCiANCisxNS4gS1ZNX1NFVl9SRUNFSVZF
X0ZJTklTSA0KKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KKw0KK0FmdGVyIGNvbXBsZXRpb24g
b2YgdGhlIG1pZ3JhdGlvbiBmbG93LCB0aGUgS1ZNX1NFVl9SRUNFSVZFX0ZJTklTSCBjb21tYW5k
IGNhbiBiZQ0KK2lzc3VlZCBieSB0aGUgaHlwZXJ2aXNvciB0byBtYWtlIHRoZSBndWVzdCByZWFk
eSBmb3IgdGhlIGV4ZWN1dGlvbi4NCisNCitSZXR1cm5zOiAwIG9uIHN1Y2Nlc3MsIC1uZWdhdGl2
ZSBvbiBlcnJvcg0KKw0KIFJlZmVyZW5jZXMNCiA9PT09PT09PT09DQogDQpkaWZmIC0tZ2l0IGEv
YXJjaC94ODYva3ZtL3N2bS5jIGIvYXJjaC94ODYva3ZtL3N2bS5jDQppbmRleCBjODFjYWMwOWM1
YWYuLjc0YjU3YWI3NDJhZCAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2t2bS9zdm0uYw0KKysrIGIv
YXJjaC94ODYva3ZtL3N2bS5jDQpAQCAtNzM1MCw2ICs3MzUwLDI2IEBAIHN0YXRpYyBpbnQgc2V2
X3JlY2VpdmVfdXBkYXRlX2RhdGEoc3RydWN0IGt2bSAqa3ZtLCBzdHJ1Y3Qga3ZtX3Nldl9jbWQg
KmFyZ3ApDQogCXJldHVybiByZXQ7DQogfQ0KIA0KK3N0YXRpYyBpbnQgc2V2X3JlY2VpdmVfZmlu
aXNoKHN0cnVjdCBrdm0gKmt2bSwgc3RydWN0IGt2bV9zZXZfY21kICphcmdwKQ0KK3sNCisJc3Ry
dWN0IGt2bV9zZXZfaW5mbyAqc2V2ID0gJnRvX2t2bV9zdm0oa3ZtKS0+c2V2X2luZm87DQorCXN0
cnVjdCBzZXZfZGF0YV9yZWNlaXZlX2ZpbmlzaCAqZGF0YTsNCisJaW50IHJldDsNCisNCisJaWYg
KCFzZXZfZ3Vlc3Qoa3ZtKSkNCisJCXJldHVybiAtRU5PVFRZOw0KKw0KKwlkYXRhID0ga3phbGxv
YyhzaXplb2YoKmRhdGEpLCBHRlBfS0VSTkVMKTsNCisJaWYgKCFkYXRhKQ0KKwkJcmV0dXJuIC1F
Tk9NRU07DQorDQorCWRhdGEtPmhhbmRsZSA9IHNldi0+aGFuZGxlOw0KKwlyZXQgPSBzZXZfaXNz
dWVfY21kKGt2bSwgU0VWX0NNRF9SRUNFSVZFX0ZJTklTSCwgZGF0YSwgJmFyZ3AtPmVycm9yKTsN
CisNCisJa2ZyZWUoZGF0YSk7DQorCXJldHVybiByZXQ7DQorfQ0KKw0KIHN0YXRpYyBpbnQgc3Zt
X21lbV9lbmNfb3Aoc3RydWN0IGt2bSAqa3ZtLCB2b2lkIF9fdXNlciAqYXJncCkNCiB7DQogCXN0
cnVjdCBrdm1fc2V2X2NtZCBzZXZfY21kOw0KQEAgLTc0MDYsNiArNzQyNiw5IEBAIHN0YXRpYyBp
bnQgc3ZtX21lbV9lbmNfb3Aoc3RydWN0IGt2bSAqa3ZtLCB2b2lkIF9fdXNlciAqYXJncCkNCiAJ
Y2FzZSBLVk1fU0VWX1JFQ0VJVkVfVVBEQVRFX0RBVEE6DQogCQlyID0gc2V2X3JlY2VpdmVfdXBk
YXRlX2RhdGEoa3ZtLCAmc2V2X2NtZCk7DQogCQlicmVhazsNCisJY2FzZSBLVk1fU0VWX1JFQ0VJ
VkVfRklOSVNIOg0KKwkJciA9IHNldl9yZWNlaXZlX2ZpbmlzaChrdm0sICZzZXZfY21kKTsNCisJ
CWJyZWFrOw0KIAlkZWZhdWx0Og0KIAkJciA9IC1FSU5WQUw7DQogCQlnb3RvIG91dDsNCi0tIA0K
Mi4xNy4xDQoNCg==

