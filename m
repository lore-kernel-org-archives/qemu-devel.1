Received: from eggs.gnu.org ([2001:4830:134:3::10]:35060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1e6voS-00043S-By
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 05:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1e6voN-0004ju-GH
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 05:47:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:19476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1e6voN-0004j1-6R
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 05:47:51 -0400
From: "Valluri, Amarnath" <amarnath.valluri@intel.com>
Date: Tue, 24 Oct 2017 09:47:46 +0000
Message-ID: <1508838503.3135.12.camel@intel.com>
References: <20171024063550.22441-1-quintela@redhat.com>
In-Reply-To: <20171024063550.22441-1-quintela@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A631952A271E94EB30975DB8D2E1BA7@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] tpm: Fix compilation with --disable-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "quintela@redhat.com" <quintela@redhat.com>
Cc: "dgilbert@redhat.com" <dgilbert@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>, "lvivier@redhat.com" <lvivier@redhat.com>

T24gVHVlLCAyMDE3LTEwLTI0IGF0IDA4OjM1ICswMjAwLCBKdWFuIFF1aW50ZWxhIHdyb3RlOg0K
PiBDb21taXQNCj4gwqDCoMKgYzM3Y2FjYWJmMjI4NWIwNzMxYjQ0YzFmNjY3NzgxZmRkNGYyYjY1
OA0KPiANCj4gYnJva2UgY29tcGlsYXRpb24gd2l0aG91dCB0cG0uwqDCoEp1c3QgYWRkIGFuICNp
ZmRlZg0KPiANCj4gQ0M6IEFtYXJuYXRoIFZhbGx1cmkgPGFtYXJuYXRoLnZhbGx1cmlAaW50ZWwu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKdWFuIFF1aW50ZWxhIDxxdWludGVsYUByZWRoYXQuY29t
Pg0KPiAtLS0NCj4gwqB0cG0uYyB8IDYgKysrKystDQo+IMKgdmwuY8KgwqB8IDIgKysNCj4gwqAy
IGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL3RwbS5jIGIvdHBtLmMNCj4gaW5kZXggNDU1MjBmNTU1ZC4uZTJmM2JlMmUwOCAx
MDA2NDQNCj4gLS0tIGEvdHBtLmMNCj4gKysrIGIvdHBtLmMNCj4gQEAgLTIyMyw4ICsyMjMsMTEg
QEAgVFBNSW5mb0xpc3QgKnFtcF9xdWVyeV90cG0oRXJyb3IgKiplcnJwKQ0KPiDCoA0KPiDCoFRw
bVR5cGVMaXN0ICpxbXBfcXVlcnlfdHBtX3R5cGVzKEVycm9yICoqZXJycCkNCj4gwqB7DQo+ICvC
oMKgwqDCoFRwbVR5cGVMaXN0ICpoZWFkID0gTlVMTDsNCj4gKw0KPiArI2lmZGVmIENPTkZJR19U
UE0NCj4gwqDCoMKgwqDCoHVuc2lnbmVkIGludCBpID0gMDsNCj4gLcKgwqDCoMKgVHBtVHlwZUxp
c3QgKmhlYWQgPSBOVUxMLCAqcHJldiA9IE5VTEwsICpjdXJfaXRlbTsNCj4gK8KgwqDCoMKgVHBt
VHlwZUxpc3QgKnByZXYgPSBOVUxMLCAqY3VyX2l0ZW07DQo+IMKgDQo+IMKgwqDCoMKgwqBmb3Ig
KGkgPSAwOyBpIDwgVFBNX1RZUEVfX01BWDsgaSsrKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoGlm
ICghdHBtX2JlX2ZpbmRfYnlfdHlwZShpKSkgew0KPiBAQCAtMjQxLDYgKzI0NCw3IEBAIFRwbVR5
cGVMaXN0ICpxbXBfcXVlcnlfdHBtX3R5cGVzKEVycm9yICoqZXJycCkNCj4gwqDCoMKgwqDCoMKg
wqDCoMKgfQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqBwcmV2ID0gY3VyX2l0ZW07DQo+IMKgwqDCoMKg
wqB9DQo+ICsjZW5kaWYNCj4gwqANCj4gwqDCoMKgwqDCoHJldHVybiBoZWFkOw0KPiDCoH0NCkkg
d291bGQgcHJlZmVyIHRvIGJyaW5nIGV2ZXJ5dGhpbmcgaW4gdHBtLmMgdW5kZXIgI2lmZGVmIENP
TkZJR19UUE0uDQphbmQgcHJvdmlkZSBkdW1teSBpbXBsZW1lbnRhdGlvbnMgb25seSBmb3IgcW1w
IGNvbW1hbmRzOg0KcW1wX3F1ZXJ5X3t0cG0sX21vZGVscyxfdHlwZXN9IGluIGRpc2FibGUtdHBt
IGNhc2UuDQoNCi0gQW1hcm5hdGg=
