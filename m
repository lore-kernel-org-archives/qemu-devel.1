Received: from eggs.gnu.org ([2001:4830:134:3::10]:42439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Manish.Jaggi@cavium.com>) id 1gLbec-0002Yi-DJ
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 17:23:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Manish.Jaggi@cavium.com>) id 1gLbah-00067r-Fy
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 17:18:59 -0500
Received: from mail-eopbgr680081.outbound.protection.outlook.com
	([40.107.68.81]:60960
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Manish.Jaggi@cavium.com>)
	id 1gLbah-00062x-68
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 17:18:55 -0500
From: Manish Jaggi <mjaggi@caviumnetworks.com>
Date: Sat, 10 Nov 2018 22:18:47 +0000
Message-ID: <4bbb4e76-b714-eafe-f95b-aca1a258e9fe@caviumnetworks.com>
References: <1540290099-146109-1-git-send-email-mjaggi@caviumnetworks.com>
In-Reply-To: <1540290099-146109-1-git-send-email-mjaggi@caviumnetworks.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F68F58C3B2C67048AE1B1BEA85F7EBB5@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC] [PATCH] kvm: arm: Introduce error code
 KVM_EINVARIANT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jaggi, Manish" <Manish.Jaggi@cavium.com>, "quintela@redhat.com" <quintela@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, "Nowicki, Tomasz" <Tomasz.Nowicki@cavium.com>, Christoffer Dall <christoffer.dall@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>

DQpDQ2luZyBhIGxhcmdlciBhdWRpZW5jZS4NClBsZWFzZSByZXZpZXcuDQoNCk9uIDEwLzIzLzIw
MTggMDM6NTEgUE0sIEphZ2dpLCBNYW5pc2ggd3JvdGU6DQo+IEZyb206IE1hbmlzaCBKYWdnaSA8
bWFuaXNoLmphZ2dpQGNhdml1bS5jb20+DQo+DQo+IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyBhbiBl
cnJvciBjb2RlIEtWTV9FSU5WQVJJQU5UIHdoaWNoIGlzIHJldHVybmVkDQo+IGJ5IEtWTSB3aGVu
IHVzZXJsYW5kIHRyaWVzIHRvIHNldCBhbiBpbnZhcmlhbnQgcmVnaXN0ZXIuDQo+DQo+IFRoZSBu
ZWVkIGZvciB0aGlzIGVycm9yIGNvZGUgaXMgaW4gVk0gTWlncmF0aW9uIGZvciBhcm02NC4NCj4g
QVJNNjQgc3lzdGVtcyB1c2UgbWFpbmx5IC1tYWNoaW5lIHZpcnQgLWNwdSBob3N0IGFzIHBhcmFt
ZXRlciB0byBxZW11Lg0KPiBNaWdyYXRpb24gcmVxdWlyZXMgYm90aCBTb3VyY2UgYW5kIGRlc3Rp
bmF0aW9uIG1hY2hpbmVzIHRvIGhhdmUgc2FtZQ0KPiBwaHlzaWNhbCBjcHUuIFRoZXJlIGFyZSBj
YXNlcyB3aGVyZSB0aGUgb3ZlcmFsbCBhcmNoaXRlY3R1cmUgb2YgQ1BVIGlzDQo+IHNhbWUgYnV0
IHRoZSBuZXh0IHZlcnNpb24gb2YgdGhlIGNoaXAgd2l0aCBzb21lIGJ1ZyBmaXhlcyB3aGljaCBo
YXZlIG5vDQo+IGVmZmVjdCBvbiBxZW11IG9wZXJhdGlvbi4gSW4gc3VjaCBjYXNlcyBpbnZhcmlh
bnQgcmVnaXN0ZXJzIGxpa2UgTUlEUg0KPiBoYXZlIGEgZGlmZmVyZW50IHZhbHVlLg0KPiBDdXJy
ZW50bHkgTWlncmF0aW9uIGZhaWxzIGluIHN1Y2ggY2FzZXMuDQo+DQo+IFJhdGhlciB0aGFuIHNl
bmRpbmcgYSBFSU5WQUwsIGEgc3BlY2lmYyBlcnJvciBjb2RlIHdpbGwgaGVscA0KPiB1c2VybGFu
ZCBwcm9ncmFtIHRoZSBndWVzdCBpbnZhcmlhbnQgcmVnaXN0ZXIgYnkgcXVlcnlpbmcgdGhlIG1p
Z3JhdGVkDQo+IGhvc3QgbWFjaGluZXMgaW52YXJpYW50IHJlZ2lzdGVycy4NCj4NCj4gUWVtdSB3
aWxsIGhhdmUgYSBwYXJhbWV0ZXIgLWhvc3RpbnZhcmlhbnQgYWxvbmcgd2l0aCBjaGVja2luZyBv
ZiB0aGlzDQo+IGVycm9yIGNvZGUuIFNvIGl0IGNhbiBiZSBzYWZlbHkgYXNzdW1lZCB0aGF0IHRo
ZSBmZWF0dXJlIGlzIG9wdC1pbg0KPg0KPiBDb3JyZXNwb25kaW5nIFFlbXUgcGF0Y2hzZXQgY2Fu
IGJlIGZvdW5kIGF0IDoNCj4gaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11
LWRldmVsLzIwMTgtMTAvbXNnMDUwNDguaHRtbA0KPg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYW5p
c2ggSmFnZ2kgPG1hbmlzaC5qYWdnaUBjYXZpdW0uY29tPg0KPiAtLS0NCj4gICBhcmNoL2FybTY0
L2t2bS9zeXNfcmVncy5jICAgICB8IDkgKysrKy0tLS0tDQo+ICAgaW5jbHVkZS91YXBpL2xpbnV4
L2t2bV9wYXJhLmggfCAxICsNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwg
NSBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQva3ZtL3N5c19yZWdz
LmMgYi9hcmNoL2FybTY0L2t2bS9zeXNfcmVncy5jDQo+IGluZGV4IDIyZmJiZGIuLjc4ZmZjMDIg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQva3ZtL3N5c19yZWdzLmMNCj4gKysrIGIvYXJjaC9h
cm02NC9rdm0vc3lzX3JlZ3MuYw0KPiBAQCAtMTExMSw3ICsxMTExLDcgQEAgc3RhdGljIGludCBf
X3NldF9pZF9yZWcoY29uc3Qgc3RydWN0IHN5c19yZWdfZGVzYyAqcmQsIHZvaWQgX191c2VyICp1
YWRkciwNCj4gICANCj4gICAJLyogVGhpcyBpcyB3aGF0IHdlIG1lYW4gYnkgaW52YXJpYW50OiB5
b3UgY2FuJ3QgY2hhbmdlIGl0LiAqLw0KPiAgIAlpZiAodmFsICE9IHJlYWRfaWRfcmVnKHJkLCBy
YXopKQ0KPiAtCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwkJcmV0dXJuIC1LVk1fRUlOVkFSSUFOVDsN
Cj4gICANCj4gICAJcmV0dXJuIDA7DQo+ICAgfQ0KPiBAQCAtMjI1NCw5ICsyMjU0LDggQEAgc3Rh
dGljIGludCBzZXRfaW52YXJpYW50X3N5c19yZWcodTY0IGlkLCB2b2lkIF9fdXNlciAqdWFkZHIp
DQo+ICAgCQlyZXR1cm4gZXJyOw0KPiAgIA0KPiAgIAkvKiBUaGlzIGlzIHdoYXQgd2UgbWVhbiBi
eSBpbnZhcmlhbnQ6IHlvdSBjYW4ndCBjaGFuZ2UgaXQuICovDQo+IC0JaWYgKHItPnZhbCAhPSB2
YWwpDQo+IC0JCXJldHVybiAtRUlOVkFMOw0KPiAtDQo+ICsJaWYgKHItPnZhbCAhPSB2YWwpCQ0K
PiArCQlyZXR1cm4gLUtWTV9FSU5WQVJJQU5UOw0KPiAgIAlyZXR1cm4gMDsNCj4gICB9DQo+ICAg
DQo+IEBAIC0yMzM1LDcgKzIzMzQsNyBAQCBzdGF0aWMgaW50IGRlbXV4X2MxNV9zZXQodTY0IGlk
LCB2b2lkIF9fdXNlciAqdWFkZHIpDQo+ICAgDQo+ICAgCQkvKiBUaGlzIGlzIGFsc28gaW52YXJp
YW50OiB5b3UgY2FuJ3QgY2hhbmdlIGl0LiAqLw0KPiAgIAkJaWYgKG5ld3ZhbCAhPSBnZXRfY2Nz
aWRyKHZhbCkpDQo+IC0JCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwkJCXJldHVybiAtS1ZNX0VJTlZB
UklBTlQ7DQo+ICAgCQlyZXR1cm4gMDsNCj4gICAJZGVmYXVsdDoNCj4gICAJCXJldHVybiAtRU5P
RU5UOw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L2t2bV9wYXJhLmggYi9pbmNs
dWRlL3VhcGkvbGludXgva3ZtX3BhcmEuaA0KPiBpbmRleCA2YzBjZTQ5Li40MzU4NjY5IDEwMDY0
NA0KPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgva3ZtX3BhcmEuaA0KPiArKysgYi9pbmNsdWRl
L3VhcGkvbGludXgva3ZtX3BhcmEuaA0KPiBAQCAtMTcsNiArMTcsNyBAQA0KPiAgICNkZWZpbmUg
S1ZNX0UyQklHCQlFMkJJRw0KPiAgICNkZWZpbmUgS1ZNX0VQRVJNCQlFUEVSTQ0KPiAgICNkZWZp
bmUgS1ZNX0VPUE5PVFNVUFAJCTk1DQo+ICsjZGVmaW5lIEtWTV9FSU5WQVJJQU5UICAgICAgICAg
IDk2DQo+ICAgDQo+ICAgI2RlZmluZSBLVk1fSENfVkFQSUNfUE9MTF9JUlEJCTENCj4gICAjZGVm
aW5lIEtWTV9IQ19NTVVfT1AJCQkyDQoNCg==
