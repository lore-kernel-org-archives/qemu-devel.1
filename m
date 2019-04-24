Received: from eggs.gnu.org ([209.51.188.92]:38826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTw-0002P5-JH
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTn-0004EB-My
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:46 -0400
Received: from mail-eopbgr780088.outbound.protection.outlook.com
	([40.107.78.88]:16416
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hJKTn-0003kU-Ds
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:39 -0400
From: "Singh, Brijesh" <brijesh.singh@amd.com>
Date: Wed, 24 Apr 2019 16:10:07 +0000
Message-ID: <20190424160942.13567-8-brijesh.singh@amd.com>
References: <20190424160942.13567-1-brijesh.singh@amd.com>
In-Reply-To: <20190424160942.13567-1-brijesh.singh@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C26546F6C64B3438A26C98CB0F1C566@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC PATCH v1 07/10] KVM: x86: Add AMD SEV specific
 Hypercall3
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

S1ZNIGh5cGVyY2FsbCBmcmFtZXdvcmsgcmVsaWVzIG9uIGFsdGVybmF0aXZlIGZyYW1ld29yayB0
byBwYXRjaCB0aGUNClZNQ0FMTCAtPiBWTU1DQUxMIG9uIEFNRCBwbGF0Zm9ybS4gSWYgYSBoeXBl
cmNhbGwgaXMgbWFkZSBiZWZvcmUNCmFwcGx5X2FsdGVybmF0aXZlKCkgaXMgY2FsbGVkIHRoZW4g
aXQgZGVmYXVsdHMgdG8gVk1DQUxMLiBUaGUgYXBwcm9hY2gNCndvcmtzIGZpbmUgb24gbm9uIFNF
ViBndWVzdC4gQSBWTUNBTEwgd291bGQgY2F1c2VzICNVRCwgYW5kIGh5cGVydmlzb3INCndpbGwg
YmUgYWJsZSB0byBkZWNvZGUgdGhlIGluc3RydWN0aW9uIGFuZCBkbyB0aGUgcmlnaHQgdGhpbmdz
LiBCdXQNCndoZW4gU0VWIGlzIGFjdGl2ZSwgZ3Vlc3QgbWVtb3J5IGlzIGVuY3J5cHRlZCB3aXRo
IGd1ZXN0IGtleSBhbmQNCmh5cGVydmlzb3Igd2lsbCBub3QgYmUgYWJsZSB0byBkZWNvZGUgdGhl
IGluc3RydWN0aW9uIGJ5dGVzLg0KDQpBZGQgU0VWIHNwZWNpZmljIGh5cGVyY2FsbDMsIGl0IHVu
Y29uZGl0aW9uYWxseSB1c2VzIFZNTUNBTEwuIFRoZSBoeXBlcmNhbGwNCndpbGwgYmUgdXNlZCBi
eSB0aGUgU0VWIGd1ZXN0IHRvIG5vdGlmeSBlbmNyeXB0ZWQgcGFnZXMgdG8gdGhlIGh5cGVydmlz
b3IuDQoNCkNjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCkNjOiBJbmdv
IE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT4NCkNjOiAiSC4gUGV0ZXIgQW52aW4iIDxocGFAenl0
b3IuY29tPg0KQ2M6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+DQpDYzogIlJh
ZGltIEtyxI1tw6HFmSIgPHJrcmNtYXJAcmVkaGF0LmNvbT4NCkNjOiBKb2VyZyBSb2VkZWwgPGpv
cm9AOGJ5dGVzLm9yZz4NCkNjOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQHN1c2UuZGU+DQpDYzogVG9t
IExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4NCkNjOiB4ODZAa2VybmVsLm9yZw0K
Q2M6IGt2bUB2Z2VyLmtlcm5lbC5vcmcNCkNjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQpTaWduZWQtb2ZmLWJ5OiBCcmlqZXNoIFNpbmdoIDxicmlqZXNoLnNpbmdoQGFtZC5jb20+DQot
LS0NCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1fcGFyYS5oIHwgMTIgKysrKysrKysrKysrDQog
MSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2luY2x1ZGUvYXNtL2t2bV9wYXJhLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1fcGFyYS5o
DQppbmRleCA1ZWQzY2YxYzM5MzQuLjk0ZTkxYzBiYzJlMCAxMDA2NDQNCi0tLSBhL2FyY2gveDg2
L2luY2x1ZGUvYXNtL2t2bV9wYXJhLmgNCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9w
YXJhLmgNCkBAIC04NCw2ICs4NCwxOCBAQCBzdGF0aWMgaW5saW5lIGxvbmcga3ZtX2h5cGVyY2Fs
bDQodW5zaWduZWQgaW50IG5yLCB1bnNpZ25lZCBsb25nIHAxLA0KIAlyZXR1cm4gcmV0Ow0KIH0N
CiANCitzdGF0aWMgaW5saW5lIGxvbmcga3ZtX3Nldl9oeXBlcmNhbGwzKHVuc2lnbmVkIGludCBu
ciwgdW5zaWduZWQgbG9uZyBwMSwNCisJCQkJICAgICAgdW5zaWduZWQgbG9uZyBwMiwgdW5zaWdu
ZWQgbG9uZyBwMykNCit7DQorCWxvbmcgcmV0Ow0KKw0KKwlhc20gdm9sYXRpbGUoInZtbWNhbGwi
DQorCQkgICAgIDogIj1hIihyZXQpDQorCQkgICAgIDogImEiKG5yKSwgImIiKHAxKSwgImMiKHAy
KSwgImQiKHAzKQ0KKwkJICAgICA6ICJtZW1vcnkiKTsNCisJcmV0dXJuIHJldDsNCit9DQorDQog
I2lmZGVmIENPTkZJR19LVk1fR1VFU1QNCiBib29sIGt2bV9wYXJhX2F2YWlsYWJsZSh2b2lkKTsN
CiB1bnNpZ25lZCBpbnQga3ZtX2FyY2hfcGFyYV9mZWF0dXJlcyh2b2lkKTsNCi0tIA0KMi4xNy4x
DQoNCg==
