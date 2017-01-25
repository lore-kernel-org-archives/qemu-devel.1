Received: from eggs.gnu.org ([2001:4830:134:3::10]:57899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=1917c8cdb=Paul.Durrant@citrix.com>)
	id 1cWSD6-0003kM-67
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:22:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=1917c8cdb=Paul.Durrant@citrix.com>)
	id 1cWSD2-0002QU-Ai
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:22:20 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:15214
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=1917c8cdb=Paul.Durrant@citrix.com>)
	id 1cWSD1-0002Pi-Tv
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:22:16 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 25 Jan 2017 18:21:59 +0000
Message-ID: <wcjxhmvd59ytc41igo0k68g2.1485368517410@email.android.com>
Content-Language: en-GB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH v2 2/3] xen-platform: add support for
 unplugging NVMe disks...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, xen-devel <xen-devel@lists.xenproject.org>, Anthony Perard <anthony.perard@citrix.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "olaf@aepfle.de" <olaf@aepfle.de>

T24gMjUgSmFudWFyeSAyMDE3LCBhdCAxNzo1NCwgU3RlZmFubyBTdGFiZWxsaW5pIDxzc3RhYmVs
bGluaUBrZXJuZWwub3JnPiB3cm90ZToNCg0KPg0KPg0KPk9uIFdlZCwgMjUgSmFuIDIwMTcsIFBh
dWwgRHVycmFudCB3cm90ZToNCj4+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+ID4g
RnJvbTogU3RlZmFubyBTdGFiZWxsaW5pIFttYWlsdG86c3N0YWJlbGxpbmlAa2VybmVsLm9yZ10N
Cj4+ID4gU2VudDogMjQgSmFudWFyeSAyMDE3IDIzOjQ5DQo+PiA+IFRvOiBQYXVsIER1cnJhbnQg
PFBhdWwuRHVycmFudEBjaXRyaXguY29tPg0KPj4gPiBDYzogcWVtdS1kZXZlbEBub25nbnUub3Jn
OyB4ZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmc7IFN0ZWZhbm8NCj4+ID4gU3RhYmVsbGlu
aSA8c3N0YWJlbGxpbmlAa2VybmVsLm9yZz47IEFudGhvbnkgUGVyYXJkDQo+PiA+IDxhbnRob255
LnBlcmFyZEBjaXRyaXguY29tPjsgTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT47
IFBhb2xvDQo+PiA+IEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+OyBSaWNoYXJkIEhlbmRl
cnNvbiA8cnRoQHR3aWRkbGUubmV0PjsNCj4+ID4gRWR1YXJkbyBIYWJrb3N0IDxlaGFia29zdEBy
ZWRoYXQuY29tPjsgb2xhZkBhZXBmbGUuZGUNCj4+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAy
LzNdIHhlbi1wbGF0Zm9ybTogYWRkIHN1cHBvcnQgZm9yIHVucGx1Z2dpbmcgTlZNZQ0KPj4gPiBk
aXNrcy4uLg0KPj4gPg0KPj4gPiBPbiBUdWUsIDI0IEphbiAyMDE3LCBQYXVsIER1cnJhbnQgd3Jv
dGU6DQo+PiA+ID4gLi4ubm90IGp1c3QgSURFIGFuZCBTQ1NJLg0KPj4gPiA+DQo+PiA+ID4gVGhp
cyBwYXRjaCBhbGxvd3MgdGhlIFhlbiB0b29sLXN0YWNrIHRvIGZ1bGx5IHN1cHBvcnQgb2YgTlZN
ZSBhcyBhbg0KPj4gPiA+IGVtdWxhdGVkIGRpc2sgdHlwZS4NCj4+ID4gPg0KPj4gPiA+IFNpZ25l
ZC1vZmYtYnk6IFBhdWwgRHVycmFudCA8cGF1bC5kdXJyYW50QGNpdHJpeC5jb20+DQo+PiA+DQo+
PiA+IFBsZWFzZSB1cGRhdGUgZG9jcy9taXNjL2h2bS1lbXVsYXRlZC11bnBsdWcubWFya2Rvd24g
aW4gdGhlIFhlbg0KPj4gPiByZXBvc2l0b3J5IGZpcnN0LiBJdCBtaWdodCBiZSBhbHNvIHdvcnRo
IGNsYXJpZnlpbmcgdGhhdCBgMWAgYWN0dWFsbHkNCj4+ID4gbWVhbnMgYWxsIGRpc2tzLCBub3Qg
anVzdCBJREUgZGlza3MuIFRoZW4sIHBsZWFzZSBhZGQgYSByZWZlcmVuY2UgdG8NCj4+ID4gdGhh
dCBjb21taXQgaW4gdGhlIGRlc2NyaXB0aW9uIG9mIHRoaXMgcGF0Y2guDQo+PiA+DQo+Pg0KPj4g
UGF0Y2ggcG9zdGVkIHRvIHJlbW92ZSAnSURFJyBmcm9tIHRoZSBkb2N1bWVudGF0aW9uIGZvciB2
YWx1ZSAnMScuIEF3YWl0aW5nIGFjay4NCj5Eb25lLg0KPldoZW4geW91IHJlcG9zdCB0aGlzIHBh
dGNoLCBjb3VsZCB5b3UgYWxzbyBhZGQgdG8gdGhlIGRlc2NyaXB0aW9uIGENCj5yZWZlcmVuY2Ug
dG8gdGhlIGNvbW1pdCB0aGF0IGVuYWJsZXMgTlZNZSBpbiBRRU1VIHdpdGggWGVuPyBJIGd1ZXNz
IGl0DQo+aXMgYSBsaWJ4bCBjb21taXQ/DQoNCkkgdGhpbmsgdGhlcmUgaXMgYSBjaGlja2VuIGFu
ZCBlZ2cgaXNzdWUgaGVyZS4gV2VpIHdhbnRlZCB0byBlbnN1cmUgdGhhdCBRRU1VIGlzIGFibGUg
dG8gdW5wbHVnIE5WTWUgZHJpdmVzIGJlZm9yZSBhY2NlcHRpbmcgbXkgcGF0Y2ggdG8gbGlieGwu
DQoNCiAgUGF1bA0KDQo+PiA+ID4gLS0tDQo+PiA+ID4gQ2M6IFN0ZWZhbm8gU3RhYmVsbGluaSA8
c3N0YWJlbGxpbmlAa2VybmVsLm9yZz4NCj4+ID4gPiBDYzogQW50aG9ueSBQZXJhcmQgPGFudGhv
bnkucGVyYXJkQGNpdHJpeC5jb20+DQo+PiA+ID4gQ2M6ICJNaWNoYWVsIFMuIFRzaXJraW4iIDxt
c3RAcmVkaGF0LmNvbT4NCj4+ID4gPiBDYzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0
LmNvbT4NCj4+ID4gPiBDYzogUmljaGFyZCBIZW5kZXJzb24gPHJ0aEB0d2lkZGxlLm5ldD4NCj4+
ID4gPiBDYzogRWR1YXJkbyBIYWJrb3N0IDxlaGFia29zdEByZWRoYXQuY29tPg0KPj4gPiA+IC0t
LQ0KPj4gPiA+ICBody9pMzg2L3hlbi94ZW5fcGxhdGZvcm0uYyB8IDEgKw0KPj4gPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4+ID4gPg0KPj4gPiA+IGRpZmYgLS1naXQgYS9o
dy9pMzg2L3hlbi94ZW5fcGxhdGZvcm0uYyBiL2h3L2kzODYveGVuL3hlbl9wbGF0Zm9ybS5jDQo+
PiA+ID4gaW5kZXggZjUwOTE1Zi4uN2Q0MWViYiAxMDA2NDQNCj4+ID4gPiAtLS0gYS9ody9pMzg2
L3hlbi94ZW5fcGxhdGZvcm0uYw0KPj4gPiA+ICsrKyBiL2h3L2kzODYveGVuL3hlbl9wbGF0Zm9y
bS5jDQo+PiA+ID4gQEAgLTEyMCw2ICsxMjAsNyBAQCBzdGF0aWMgdm9pZCB1bnBsdWdfZGlza3Mo
UENJQnVzICpiLCBQQ0lEZXZpY2UgKmQsDQo+PiA+IHZvaWQgKm8pDQo+PiA+ID4gICAgICAgICAg
YnJlYWs7DQo+PiA+ID4NCj4+ID4gPiAgICAgIGNhc2UgUENJX0NMQVNTX1NUT1JBR0VfU0NTSToN
Cj4+ID4gPiArICAgIGNhc2UgUENJX0NMQVNTX1NUT1JBR0VfRVhQUkVTUzoNCj4+ID4gPiAgICAg
ICAgICBvYmplY3RfdW5wYXJlbnQoT0JKRUNUKGQpKTsNCj4+ID4gPiAgICAgICAgICBicmVhazsN
Cj4+ID4gPg0KPj4gPiA+IC0tDQo+PiA+ID4gMi4xLjQNCj4+ID4gPg0KPj4NCj4NCg==
