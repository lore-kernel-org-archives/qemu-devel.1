Received: from eggs.gnu.org ([209.51.188.92]:60327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Thomas.Lendacky@amd.com>) id 1hK88a-0001rE-76
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Thomas.Lendacky@amd.com>) id 1hK88Y-0004WU-MD
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:12:03 -0400
Received: from mail-eopbgr730081.outbound.protection.outlook.com
	([40.107.73.81]:46880
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Thomas.Lendacky@amd.com>)
	id 1hK88V-0004VJ-KJ
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:12:00 -0400
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Date: Fri, 26 Apr 2019 21:11:54 +0000
Message-ID: <a136f78e-e9b2-0203-4b4f-84c5db8ccd55@amd.com>
References: <20190424160942.13567-1-brijesh.singh@amd.com>
	<20190424160942.13567-7-brijesh.singh@amd.com>
In-Reply-To: <20190424160942.13567-7-brijesh.singh@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <96D7A046947CF544875D79D7107826E4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH v1 06/10] KVM: SVM: Add
 KVM_SEV_RECEIVE_FINISH command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Singh, Brijesh" <brijesh.singh@amd.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

T24gNC8yNC8xOSAxMToxMCBBTSwgU2luZ2gsIEJyaWplc2ggd3JvdGU6DQo+IFRoZSBjb21tYW5k
IGZpbmFsaXplIHRoZSBndWVzdCByZWNlaXZpbmcgcHJvY2VzcyBhbmQgbWFrZSB0aGUgU0VWIGd1
ZXN0DQo+IHJlYWR5IGZvciB0aGUgZXhlY3V0aW9uLg0KPiANCj4gQ2M6IFRob21hcyBHbGVpeG5l
ciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiBDYzogSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5j
b20+DQo+IENjOiAiSC4gUGV0ZXIgQW52aW4iIDxocGFAenl0b3IuY29tPg0KPiBDYzogUGFvbG8g
Qm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gQ2M6ICJSYWRpbSBLcsSNbcOhxZkiIDxy
a3JjbWFyQHJlZGhhdC5jb20+DQo+IENjOiBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVzLm9yZz4N
Cj4gQ2M6IEJvcmlzbGF2IFBldGtvdiA8YnBAc3VzZS5kZT4NCj4gQ2M6IFRvbSBMZW5kYWNreSA8
dGhvbWFzLmxlbmRhY2t5QGFtZC5jb20+DQo+IENjOiB4ODZAa2VybmVsLm9yZw0KPiBDYzoga3Zt
QHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBT
aWduZWQtb2ZmLWJ5OiBCcmlqZXNoIFNpbmdoIDxicmlqZXNoLnNpbmdoQGFtZC5jb20+DQo+IC0t
LQ0KPiAgLi4uL3ZpcnR1YWwva3ZtL2FtZC1tZW1vcnktZW5jcnlwdGlvbi5yc3QgICAgIHwgIDgg
KysrKysrKw0KPiAgYXJjaC94ODYva3ZtL3N2bS5jICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgMjMgKysrKysrKysrKysrKysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi92aXJ0dWFsL2t2bS9hbWQt
bWVtb3J5LWVuY3J5cHRpb24ucnN0IGIvRG9jdW1lbnRhdGlvbi92aXJ0dWFsL2t2bS9hbWQtbWVt
b3J5LWVuY3J5cHRpb24ucnN0DQo+IGluZGV4IGI5YzNkYzAyZjM0NC4uNzJjNDVmOTNhYmQ3IDEw
MDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3ZpcnR1YWwva3ZtL2FtZC1tZW1vcnktZW5jcnlw
dGlvbi5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi92aXJ0dWFsL2t2bS9hbWQtbWVtb3J5LWVu
Y3J5cHRpb24ucnN0DQo+IEBAIC0zNDYsNiArMzQ2LDE0IEBAIFJldHVybnM6IDAgb24gc3VjY2Vz
cywgLW5lZ2F0aXZlIG9uIGVycm9yDQo+ICAgICAgICAgICAgICAgICAgX191MzIgdHJhbnNfbGVu
Ow0KPiAgICAgICAgICB9Ow0KPiAgDQo+ICsxNS4gS1ZNX1NFVl9SRUNFSVZFX0ZJTklTSA0KPiAr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICsNCj4gK0FmdGVyIGNvbXBsZXRpb24gb2YgdGhl
IG1pZ3JhdGlvbiBmbG93LCB0aGUgS1ZNX1NFVl9SRUNFSVZFX0ZJTklTSCBjb21tYW5kIGNhbiBi
ZQ0KPiAraXNzdWVkIGJ5IHRoZSBoeXBlcnZpc29yIHRvIG1ha2UgdGhlIGd1ZXN0IHJlYWR5IGZv
ciB0aGUgZXhlY3V0aW9uLg0KDQpmb3IgZXhlY3V0aW9uLg0KDQpUaGFua3MsDQpUb20NCg0KPiAr
DQo+ICtSZXR1cm5zOiAwIG9uIHN1Y2Nlc3MsIC1uZWdhdGl2ZSBvbiBlcnJvcg0KPiArDQo+ICBS
ZWZlcmVuY2VzDQo+ICA9PT09PT09PT09DQo+ICANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2
bS9zdm0uYyBiL2FyY2gveDg2L2t2bS9zdm0uYw0KPiBpbmRleCBjODFjYWMwOWM1YWYuLjc0YjU3
YWI3NDJhZCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva3ZtL3N2bS5jDQo+ICsrKyBiL2FyY2gv
eDg2L2t2bS9zdm0uYw0KPiBAQCAtNzM1MCw2ICs3MzUwLDI2IEBAIHN0YXRpYyBpbnQgc2V2X3Jl
Y2VpdmVfdXBkYXRlX2RhdGEoc3RydWN0IGt2bSAqa3ZtLCBzdHJ1Y3Qga3ZtX3Nldl9jbWQgKmFy
Z3ApDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGludCBzZXZfcmVjZWl2
ZV9maW5pc2goc3RydWN0IGt2bSAqa3ZtLCBzdHJ1Y3Qga3ZtX3Nldl9jbWQgKmFyZ3ApDQo+ICt7
DQo+ICsJc3RydWN0IGt2bV9zZXZfaW5mbyAqc2V2ID0gJnRvX2t2bV9zdm0oa3ZtKS0+c2V2X2lu
Zm87DQo+ICsJc3RydWN0IHNldl9kYXRhX3JlY2VpdmVfZmluaXNoICpkYXRhOw0KPiArCWludCBy
ZXQ7DQo+ICsNCj4gKwlpZiAoIXNldl9ndWVzdChrdm0pKQ0KPiArCQlyZXR1cm4gLUVOT1RUWTsN
Cj4gKw0KPiArCWRhdGEgPSBremFsbG9jKHNpemVvZigqZGF0YSksIEdGUF9LRVJORUwpOw0KPiAr
CWlmICghZGF0YSkNCj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ICsNCj4gKwlkYXRhLT5oYW5kbGUg
PSBzZXYtPmhhbmRsZTsNCj4gKwlyZXQgPSBzZXZfaXNzdWVfY21kKGt2bSwgU0VWX0NNRF9SRUNF
SVZFX0ZJTklTSCwgZGF0YSwgJmFyZ3AtPmVycm9yKTsNCj4gKw0KPiArCWtmcmVlKGRhdGEpOw0K
PiArCXJldHVybiByZXQ7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgc3ZtX21lbV9lbmNfb3Ao
c3RydWN0IGt2bSAqa3ZtLCB2b2lkIF9fdXNlciAqYXJncCkNCj4gIHsNCj4gIAlzdHJ1Y3Qga3Zt
X3Nldl9jbWQgc2V2X2NtZDsNCj4gQEAgLTc0MDYsNiArNzQyNiw5IEBAIHN0YXRpYyBpbnQgc3Zt
X21lbV9lbmNfb3Aoc3RydWN0IGt2bSAqa3ZtLCB2b2lkIF9fdXNlciAqYXJncCkNCj4gIAljYXNl
IEtWTV9TRVZfUkVDRUlWRV9VUERBVEVfREFUQToNCj4gIAkJciA9IHNldl9yZWNlaXZlX3VwZGF0
ZV9kYXRhKGt2bSwgJnNldl9jbWQpOw0KPiAgCQlicmVhazsNCj4gKwljYXNlIEtWTV9TRVZfUkVD
RUlWRV9GSU5JU0g6DQo+ICsJCXIgPSBzZXZfcmVjZWl2ZV9maW5pc2goa3ZtLCAmc2V2X2NtZCk7
DQo+ICsJCWJyZWFrOw0KPiAgCWRlZmF1bHQ6DQo+ICAJCXIgPSAtRUlOVkFMOw0KPiAgCQlnb3Rv
IG91dDsNCj4gDQo=
