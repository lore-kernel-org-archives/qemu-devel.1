Received: from eggs.gnu.org ([2001:4830:134:3::10]:50818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1e1pjx-0006Om-Ft
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 04:18:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1e1pjr-0003Xa-VG
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 04:18:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:63824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1e1pjr-0003XD-Lt
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 04:18:07 -0400
From: "Valluri, Amarnath" <amarnath.valluri@intel.com>
Date: Tue, 10 Oct 2017 08:18:03 +0000
Message-ID: <1507623520.4061.30.camel@intel.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-23-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-23-marcandre.lureau@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <352DBB53391ABB46BCEF9BF894ADB269@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 22/42] tpm-backend: store TPMIf interface,
 improve backend_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>

T24gVHVlLCAyMDE3LTEwLTEwIGF0IDAwOjU2ICswMjAwLCBNYXJjLUFuZHLDqSBMdXJlYXUgd3Jv
dGU6DQo+IFN0b3JlIHRoZSBUUE0gaW50ZXJmYWNlLCB0aGUgYWN0dWFsIG9iamVjdCBtYXkgYmUg
ZGlmZmVyZW50IGZyb20NCj4gVFBNU3RhdGUuIEtlZXAgYSByZWZlcmVuY2Ugb24gdGhlIGludGVy
ZmFjZSwgYW5kIGNoZWNrIHRoZSBiYWNrZW5kDQo+IHdhc24ndCBhbHJlYWR5IGluaXRpYWxpemVk
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVy
ZWF1QHJlZGhhdC5jb20+DQo+IC0tLQ0KPiDCoGluY2x1ZGUvc3lzZW11L3RwbV9iYWNrZW5kLmgg
fMKgwqA3ICsrKystLS0NCj4gwqBiYWNrZW5kcy90cG0uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHwgMTIgKysrKysrKysrLS0tDQo+IMKgaHcvdHBtL3RwbV9lbXVsYXRvci5jwqDCoMKg
wqDCoMKgwqDCoHzCoMKgNCArKy0tDQo+IMKgaHcvdHBtL3RwbV9wYXNzdGhyb3VnaC5jwqDCoMKg
wqDCoHzCoMKgNCArKy0tDQo+IMKgaHcvdHBtL3RwbV90aXMuY8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgfMKgwqAyICstDQo+IMKgNSBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAx
MSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3N5c2VtdS90cG1fYmFj
a2VuZC5oDQo+IGIvaW5jbHVkZS9zeXNlbXUvdHBtX2JhY2tlbmQuaA0KPiBpbmRleCAwM2VhNWEz
NDAwLi44ZDA4NzY1YjNjIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL3N5c2VtdS90cG1fYmFja2Vu
ZC5oDQo+ICsrKyBiL2luY2x1ZGUvc3lzZW11L3RwbV9iYWNrZW5kLmgNCj4gQEAgLTE4LDYgKzE4
LDcgQEANCj4gwqAjaW5jbHVkZSAicWFwaS10eXBlcy5oIg0KPiDCoCNpbmNsdWRlICJxZW11L29w
dGlvbi5oIg0KPiDCoCNpbmNsdWRlICJzeXNlbXUvdHBtLmgiDQo+ICsjaW5jbHVkZSAiaHcvdHBt
L3RwbV9pbnQuaCINClRoaXMgaXMgbm90IHN1cHBvc2VkIHRvIGJlIGludGVybmFsIGhlYWRlcj8N
Cg0KLSBBbWFybmF0aA0K
