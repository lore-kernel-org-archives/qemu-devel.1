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
From: "Singh, Brijesh" <brijesh.singh@amd.com>
Date: Wed, 24 Apr 2019 16:10:06 +0000
Message-ID: <20190424160942.13567-7-brijesh.singh@amd.com>
References: <20190424160942.13567-1-brijesh.singh@amd.com>
In-Reply-To: <20190424160942.13567-1-brijesh.singh@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5ADB5861ED3C1840A806F4A75F5166A6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC PATCH v1 06/10] KVM: SVM: Add
 KVM_SEV_RECEIVE_FINISH command
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
