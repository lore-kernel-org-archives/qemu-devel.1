Received: from eggs.gnu.org ([209.51.188.92]:38742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTn-0002DY-7Q
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTP-0003sU-NY
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:30 -0400
Received: from mail-eopbgr780088.outbound.protection.outlook.com
	([40.107.78.88]:16416
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hJKTM-0003kU-7K
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:13 -0400
From: "Singh, Brijesh" <brijesh.singh@amd.com>
Date: Wed, 24 Apr 2019 16:10:02 +0000
Message-ID: <20190424160942.13567-4-brijesh.singh@amd.com>
References: <20190424160942.13567-1-brijesh.singh@amd.com>
In-Reply-To: <20190424160942.13567-1-brijesh.singh@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E30D6C83E5FE74AAAFBB44FC32F4EC4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC PATCH v1 03/10] KVM: SVM: Add KVM_SEV_SEND_FINISH
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Singh, Brijesh" <brijesh.singh@amd.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>, "Lendacky,
	Thomas" <Thomas.Lendacky@amd.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

VGhlIGNvbW1hbmQgaXMgdXNlZCB0byBmaW5haWxpemUgdGhlIGVuY3J5cHRpb24gY29udGV4dCBj
cmVhdGVkIHdpdGgNCktWTV9TRVZfU0VORF9TVEFSVCBjb21tYW5kLg0KDQpDYzogVGhvbWFzIEds
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
ZW50YXRpb24vdmlydHVhbC9rdm0vYW1kLW1lbW9yeS1lbmNyeXB0aW9uLnJzdA0KaW5kZXggYTAy
MDhlMTcxNDg5Li4wMDY4MzIyNTZhZTMgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL3ZpcnR1
YWwva3ZtL2FtZC1tZW1vcnktZW5jcnlwdGlvbi5yc3QNCisrKyBiL0RvY3VtZW50YXRpb24vdmly
dHVhbC9rdm0vYW1kLW1lbW9yeS1lbmNyeXB0aW9uLnJzdA0KQEAgLTI4NSw2ICsyODUsMTQgQEAg
UmV0dXJuczogMCBvbiBzdWNjZXNzLCAtbmVnYXRpdmUgb24gZXJyb3INCiAgICAgICAgICAgICAg
ICAgX191MzIgdHJhbnNfbGVuOw0KICAgICAgICAgfTsNCiANCisxMi4gS1ZNX1NFVl9TRU5EX0ZJ
TklTSA0KKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KKw0KK0FmdGVyIGNvbXBsZXRpb24gb2Yg
dGhlIG1pZ3JhdGlvbiBmbG93LCB0aGUgS1ZNX1NFVl9TRU5EX0ZJTklTSCBjb21tYW5kIGNhbiBi
ZQ0KK2lzc3VlZCBieSB0aGUgaHlwZXJ2aXNvciB0byBkZWxldGUgdGhlIGVuY3J5cHRpb24gY29u
dGV4dC4NCisNCitSZXR1cm5zOiAwIG9uIHN1Y2Nlc3MsIC1uZWdhdGl2ZSBvbiBlcnJvcg0KKw0K
IFJlZmVyZW5jZXMNCiA9PT09PT09PT09DQogDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3N2
bS5jIGIvYXJjaC94ODYva3ZtL3N2bS5jDQppbmRleCBhMWNmZDM2ZDYxOTUuLjI2M2YzYzdkZWFl
NyAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2t2bS9zdm0uYw0KKysrIGIvYXJjaC94ODYva3ZtL3N2
bS5jDQpAQCAtNzE3Miw2ICs3MTcyLDI2IEBAIHN0YXRpYyBpbnQgc2V2X3NlbmRfdXBkYXRlX2Rh
dGEoc3RydWN0IGt2bSAqa3ZtLCBzdHJ1Y3Qga3ZtX3Nldl9jbWQgKmFyZ3ApDQogCXJldHVybiBy
ZXQ7DQogfQ0KIA0KK3N0YXRpYyBpbnQgc2V2X3NlbmRfZmluaXNoKHN0cnVjdCBrdm0gKmt2bSwg
c3RydWN0IGt2bV9zZXZfY21kICphcmdwKQ0KK3sNCisJc3RydWN0IGt2bV9zZXZfaW5mbyAqc2V2
ID0gJnRvX2t2bV9zdm0oa3ZtKS0+c2V2X2luZm87DQorCXN0cnVjdCBzZXZfZGF0YV9zZW5kX2Zp
bmlzaCAqZGF0YTsNCisJaW50IHJldDsNCisNCisJaWYgKCFzZXZfZ3Vlc3Qoa3ZtKSkNCisJCXJl
dHVybiAtRU5PVFRZOw0KKw0KKwlkYXRhID0ga3phbGxvYyhzaXplb2YoKmRhdGEpLCBHRlBfS0VS
TkVMKTsNCisJaWYgKCFkYXRhKQ0KKwkJcmV0dXJuIC1FTk9NRU07DQorDQorCWRhdGEtPmhhbmRs
ZSA9IHNldi0+aGFuZGxlOw0KKwlyZXQgPSBzZXZfaXNzdWVfY21kKGt2bSwgU0VWX0NNRF9TRU5E
X0ZJTklTSCwgZGF0YSwgJmFyZ3AtPmVycm9yKTsNCisNCisJa2ZyZWUoZGF0YSk7DQorCXJldHVy
biByZXQ7DQorfQ0KKw0KIHN0YXRpYyBpbnQgc3ZtX21lbV9lbmNfb3Aoc3RydWN0IGt2bSAqa3Zt
LCB2b2lkIF9fdXNlciAqYXJncCkNCiB7DQogCXN0cnVjdCBrdm1fc2V2X2NtZCBzZXZfY21kOw0K
QEAgLTcyMTksNiArNzIzOSw5IEBAIHN0YXRpYyBpbnQgc3ZtX21lbV9lbmNfb3Aoc3RydWN0IGt2
bSAqa3ZtLCB2b2lkIF9fdXNlciAqYXJncCkNCiAJY2FzZSBLVk1fU0VWX1NFTkRfVVBEQVRFX0RB
VEE6DQogCQlyID0gc2V2X3NlbmRfdXBkYXRlX2RhdGEoa3ZtLCAmc2V2X2NtZCk7DQogCQlicmVh
azsNCisJY2FzZSBLVk1fU0VWX1NFTkRfRklOSVNIOg0KKwkJciA9IHNldl9zZW5kX2ZpbmlzaChr
dm0sICZzZXZfY21kKTsNCisJCWJyZWFrOw0KIAlkZWZhdWx0Og0KIAkJciA9IC1FSU5WQUw7DQog
CQlnb3RvIG91dDsNCi0tIA0KMi4xNy4xDQoNCg==
