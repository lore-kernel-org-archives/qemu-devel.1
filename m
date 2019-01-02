Received: from eggs.gnu.org ([208.118.235.92]:45336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1geV02-0004Bw-Ng
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 20:07:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1geUzw-00074e-G9
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 20:07:10 -0500
From: "Kang, Luwei" <luwei.kang@intel.com>
Date: Wed, 2 Jan 2019 01:06:53 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E172CA6BD9@SHSMSX101.ccr.corp.intel.com>
References: <20181221124410.11920-1-pbonzini@redhat.com>
	<82D7661F83C1A047AF7DC287873BF1E172C97D77@SHSMSX101.ccr.corp.intel.com>
	<ed344ef0-c519-1c71-c0ad-fb523a5dc516@redhat.com>
In-Reply-To: <ed344ef0-c519-1c71-c0ad-fb523a5dc516@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] i386: mark the 'INTEL_PT' CPUID bit as
 unmigratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>

PiBPbiAyNS8xMi8xOCAwOToyMywgS2FuZywgTHV3ZWkgd3JvdGU6DQo+ID4+IEZyb206IFFlbXUt
ZGV2ZWwNCj4gPj4gW21haWx0bzpxZW11LWRldmVsLWJvdW5jZXMrbHV3ZWkua2FuZz1pbnRlbC5j
b21Abm9uZ251Lm9yZ10gT24gQmVoYWxmDQo+ID4+IE9mIFBhb2xvIEJvbnppbmkNCj4gPj4gU2Vu
dDogRnJpZGF5LCBEZWNlbWJlciAyMSwgMjAxOCA4OjQ0IFBNDQo+ID4+IFRvOiBxZW11LWRldmVs
QG5vbmdudS5vcmcNCj4gPj4gQ2M6IGVoYWJrb3N0QHJlZGhhdC5jb207IHFlbXUtc3RhYmxlQG5v
bmdudS5vcmcNCj4gPj4gU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gaTM4NjogbWFyayB0
aGUgJ0lOVEVMX1BUJyBDUFVJRCBiaXQgYXMNCj4gPj4gdW5taWdyYXRhYmxlDQo+ID4+DQo+ID4+
IE1hcnNoYWxpbmcgb2YgcHJvY2Vzc29yIHRyYWNpbmcgTVNScyBpcyBub3QgeWV0IGltcGxlbWVu
dGVkIGluIFFFTVUsIG1hcmsgdGhlIGZlYXR1cmUgYXMgdW5taWdyYXRhYmxlLg0KPiA+DQo+ID4g
SGkgUGFvbG8sDQo+ID4gICAgIEkgdGhpbmsgSW50ZWwgUFQgaGFzIHN1cHBvcnRlZCBsaXZlIG1p
Z3JhdGlvbi4gSSBkb24ndCB1bmRlcnN0YW5kIHdoYXQgeW91IG1lYW4uDQo+ID4NCj4gPiAgICAg
Y29tbWl0IGI3NzE0NmU5YTEyOWJjZGI2MGVkYzIzNjM5MjExNjc5YWU4NDZhOTINCj4gPiAgICAg
QXV0aG9yOiBDaGFvIFBlbmcgPGNoYW8ucC5wZW5nQGxpbnV4LmludGVsLmNvbT4NCj4gPiAgICAg
RGF0ZTogICBNb24gTWFyIDUgMDA6NDg6MzYgMjAxOCArMDgwMA0KPiA+ICAgICBpMzg2OiBBZGQg
c3VwcG9ydCB0byBnZXQvc2V0L21pZ3JhdGUgSW50ZWwgUHJvY2Vzc29yIFRyYWNlIGZlYXR1cmUN
Cj4gDQo+IEluZGVlZC4gIEkgaGFkIGZvcmdvdHRlbiB0aGlzIHBhdGNoIGJlY2F1c2UgaXQgd2Fz
IGNvbW1pdHRlZCBzbyBsb25nIGJlZm9yZSB0aGUga2VybmVsIHBhcnRzICh3aGljaCByZWFsbHkg
c2hvdWxkIG5vdCBoYXBwZW4sIGJ1dCBFZHVhcmRvDQo+IGFuZCBJIG1pc2NvbW11bmljYXRlZCBv
biBpdCkuICBDYW4geW91IGNoZWNrIHRoYXQgaXQgc3RpbGwgd29ya3M/DQoNClllcywgaXQgaXMg
aW5kZWVkIHNvIGxvbmcuIEkgd2lsbCBjaGVjayBpZiBpdCBzdGlsbCB3b3Jrcy4NCg0KVGhhbmtz
LA0KTHV3ZWkgS2FuZw0K
