Received: from eggs.gnu.org ([209.51.188.92]:44761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1gqlVn-0002cG-Vu
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 16:10:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1gqlP5-0002x9-IK
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 16:03:45 -0500
Received: from mail-eopbgr740040.outbound.protection.outlook.com
	([40.107.74.40]:63633
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1gqlOy-0002qq-CW
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 16:03:40 -0500
From: "Singh, Brijesh" <brijesh.singh@amd.com>
Date: Mon, 4 Feb 2019 21:03:32 +0000
Message-ID: <ddae44f4-fedc-3e50-b687-e3d724e5c05d@amd.com>
References: <20190117215300.29694-1-brijesh.singh@amd.com>
	<20190117215300.29694-3-brijesh.singh@amd.com>
	<20190204105945.01451a28@w520.home>
In-Reply-To: <20190204105945.01451a28@w520.home>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDED6C4E3B2BC64EA40213F5A4A99E5C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/2] target/i386: sev: Do not pin the ram
 device memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

DQoNCk9uIDIvNC8xOSAxMTo1OSBBTSwgQWxleCBXaWxsaWFtc29uIHdyb3RlOg0KPiBPbiBUaHUs
IDE3IEphbiAyMDE5IDIxOjUzOjE2ICswMDAwDQo+ICJTaW5naCwgQnJpamVzaCIgPGJyaWplc2gu
c2luZ2hAYW1kLmNvbT4gd3JvdGU6DQo+IA0KPj4gVGhlIFJBTSBkZXZpY2UgcHJlc2VudHMgYSBt
ZW1vcnkgcmVnaW9uIHRoYXQgc2hvdWxkIGJlIGhhbmRsZWQNCj4+IGFzIGFuIElPIHJlZ2lvbiBh
bmQgc2hvdWxkIG5vdCBiZSBwaW5uZWQuDQo+Pg0KPj4gSW4gdGhlIGNhc2Ugb2YgdGhlIHZmaW8t
cGNpLCBSQU0gZGV2aWNlIHJlcHJlc2VudHMgYSBNTUlPIEJBUg0KPj4gYW5kIHRoZSBtZW1vcnkg
cmVnaW9uIGlzIG5vdCBiYWNrZWQgYnkgcGFnZXMgaGVuY2UNCj4+IEtWTV9NRU1PUllfRU5DUllQ
VF9SRUdfUkVHSU9OIGZhaWxzIHRvIGxvY2sgdGhlIG1lbW9yeSByYW5nZS4NCj4+DQo+PiBGaXhl
czogaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0xNjY3MjQ5DQo+
PiBDYzogQWxleCBXaWxsaWFtc29uIDxhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbT4NCj4+IENj
OiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTog
QnJpamVzaCBTaW5naCA8YnJpamVzaC5zaW5naEBhbWQuY29tPg0KPj4gLS0tDQo+PiAgIHRhcmdl
dC9pMzg2L3Nldi5jIHwgMTEgKysrKysrKysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGlu
c2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2kzODYvc2V2LmMgYi90YXJn
ZXQvaTM4Ni9zZXYuYw0KPj4gaW5kZXggMjBiMmQzMjVkOC4uM2U5ZDVjMDJmYSAxMDA2NDQNCj4+
IC0tLSBhL3RhcmdldC9pMzg2L3Nldi5jDQo+PiArKysgYi90YXJnZXQvaTM4Ni9zZXYuYw0KPj4g
QEAgLTEzMSw2ICsxMzEsMTcgQEAgc2V2X3JhbV9ibG9ja19hZGRlZChSQU1CbG9ja05vdGlmaWVy
ICpuLCB2b2lkICpob3N0LCBzaXplX3Qgc2l6ZSkNCj4+ICAgew0KPj4gICAgICAgaW50IHI7DQo+
PiAgICAgICBzdHJ1Y3Qga3ZtX2VuY19yZWdpb24gcmFuZ2U7DQo+PiArICAgIHJhbV9hZGRyX3Qg
b2Zmc2V0Ow0KPj4gKyAgICBNZW1vcnlSZWdpb24gKm1yOw0KPj4gKw0KPj4gKyAgICBtciA9IG1l
bW9yeV9yZWdpb25fZnJvbV9ob3N0KGhvc3QsICZvZmZzZXQpOw0KPj4gKyAgICAvKg0KPj4gKyAg
ICAgKiBUaGUgUkFNIGRldmljZSBwcmVzZW50cyBhIG1lbW9yeSByZWdpb24gdGhhdCBzaG91bGQg
YmUgdHJlYXRlZA0KPj4gKyAgICAgKiBhcyBJTyByZWdpb24gYW5kIHNob3VsZCBub3QgYmUgcGlu
bmVkLg0KPj4gKyAgICAgKi8NCj4+ICsgICAgaWYgKG1lbW9yeV9yZWdpb25faXNfcmFtX2Rldmlj
ZShtcikpIHsNCj4+ICsgICAgICAgIHJldHVybjsNCj4+ICsgICAgfQ0KPj4gICANCj4+ICAgICAg
IHJhbmdlLmFkZHIgPSAoX191NjQpKHVuc2lnbmVkIGxvbmcpaG9zdDsNCj4+ICAgICAgIHJhbmdl
LnNpemUgPSBzaXplOw0KPiANCj4gDQo+IG1lbW9yeV9yZWdpb25fZnJvbV9ob3N0KCkgY2FuIHJl
dHVybiBOVUxMLCB3aGljaCB3b3VsZCBnaXZlIHlvdSBhDQo+IHNlZ2ZhdWx0IGF0IG1lbW9yeV9y
ZWdpb25faXNfcmFtX2RldmljZSgpLCBzbyB5b3UgbWlnaHQgd2FudCB0byB0ZXN0IG1yDQo+IG9u
IGl0J3Mgb3duIGZpcnN0IGFuZCBkZWNpZGUgd2hpY2ggcGF0aCB0aGF0IHdvdWxkIHRha2UuICBU
aGFua3MsDQo+IA0KDQoNCkFoLCB0aGFua3MgZm9yIGNhdGNoaW5nIGl0LiBJIHdpbGwgZml4IGlu
IHYyLg0KDQo=
