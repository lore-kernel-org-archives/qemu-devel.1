Received: from eggs.gnu.org ([2001:4830:134:3::10]:50012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=863a5f629=Paul.Durrant@citrix.com>)
	id 1gS3H5-0003RF-Gk
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:05:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=863a5f629=Paul.Durrant@citrix.com>)
	id 1gS3Gp-0005gs-97
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:05:10 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 28 Nov 2018 17:04:00 +0000
Message-ID: <27154ab1d61a4749b1c6ffa9329d59aa@AMSPEX02CL03.citrite.net>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-3-paul.durrant@citrix.com>
	<20181128161917.GE4222@dhcp-200-186.str.redhat.com>
	<48596f1fe100419c8b28ed54bda0117b@AMSPEX02CL03.citrite.net>
	<f4800b8b-1443-1bbf-8bcd-92b66e8d2631@redhat.com>
In-Reply-To: <f4800b8b-1443-1bbf-8bcd-92b66e8d2631@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 02/18] xen: introduce new
 'XenBus' and 'XenDevice' object hierarchy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Eric Blake' <eblake@redhat.com>, 'Kevin Wolf' <kwolf@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Richard Henderson <rth@twiddle.net>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEJsYWtlIFttYWlsdG86
ZWJsYWtlQHJlZGhhdC5jb21dDQo+IFNlbnQ6IDI4IE5vdmVtYmVyIDIwMTggMTc6MDENCj4gVG86
IFBhdWwgRHVycmFudCA8UGF1bC5EdXJyYW50QGNpdHJpeC5jb20+OyAnS2V2aW4gV29sZicNCj4g
PGt3b2xmQHJlZGhhdC5jb20+DQo+IENjOiBTdGVmYW5vIFN0YWJlbGxpbmkgPHNzdGFiZWxsaW5p
QGtlcm5lbC5vcmc+OyBFZHVhcmRvIEhhYmtvc3QNCj4gPGVoYWJrb3N0QHJlZGhhdC5jb20+OyBx
ZW11LWJsb2NrQG5vbmdudS5vcmc7IE1pY2hhZWwgUy4gVHNpcmtpbg0KPiA8bXN0QHJlZGhhdC5j
b20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IFBhb2xvIEJvbnppbmkNCj4gPHBib256aW5pQHJl
ZGhhdC5jb20+OyBBbnRob255IFBlcmFyZCA8YW50aG9ueS5wZXJhcmRAY2l0cml4LmNvbT47IHhl
bi0NCj4gZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmc7IFJpY2hhcmQgSGVuZGVyc29uIDxydGhA
dHdpZGRsZS5uZXQ+DQo+IFN1YmplY3Q6IFJlOiBbUWVtdS1kZXZlbF0gW1FlbXUtYmxvY2tdIFtQ
QVRDSCAwMi8xOF0geGVuOiBpbnRyb2R1Y2UgbmV3DQo+ICdYZW5CdXMnIGFuZCAnWGVuRGV2aWNl
JyBvYmplY3QgaGllcmFyY2h5DQo+IA0KPiBPbiAxMS8yOC8xOCAxMDoyNiBBTSwgUGF1bCBEdXJy
YW50IHdyb3RlOg0KPiANCj4gPj4+ICsrKyBiL2h3L3hlbi94ZW4tYnVzLmMNCj4gPj4+IEBAIC0w
LDAgKzEsMTI1IEBADQo+ID4+PiArLyoNCj4gPj4+ICsgKiBDb3B5cmlnaHQgKGMpIENpdHJpeCBT
eXN0ZW1zIEluYy4NCj4gPj4+ICsgKiBBbGwgcmlnaHRzIHJlc2VydmVkLg0KPiA+Pj4gKyAqLw0K
PiA+Pg0KPiA+PiBUaGlzIGRvZXNuJ3QgbG9vayB2ZXJ5IGNvbXBhdGlibGUgd2l0aCB0aGUgR1BM
LiBJbiBmYWN0IGl0IG1pZ2h0IGV2ZW4NCj4gPj4gbWFrZSBpdCBpbGxlZ2FsIGZvciB0aGUgUUVN
VSBwcm9qZWN0IHRvIGRpc3RyaWJ1dGUgdGhpcyBjb2RlLiA6LSkNCj4gPj4NCj4gPj4gT3RoZXIg
ZmlsZXMgeW91IGFkZCB0aHJvdWdob3V0IHRoZSBzZXJpZXMgc2VlbSB0byBoYXZlIHRoZSBzYW1l
DQo+IHByb2JsZW0uDQo+ID4+DQo+ID4NCj4gPiBJIHdhcyB3b3JraW5nIG9uIHRoZSBhc3N1bXB0
aW9uIHRoYXQgYSBsYWNrIG9mIGV4cGxpY2l0IGxpY2Vuc2UgbWVhbnQNCj4gdGhhdCB0aGUgb3Zl
cmFsbCBwcm9qZWN0IGxpY2Vuc2UgYXMgZGVzY3JpYmVkIGluIGl0ZW0gMiBpbiBMSUNFTlNFLiBE
aWQgSQ0KPiBtaXNpbnRlcnByZXQgdGhhdCB0ZXh0Pw0KPiANCj4gTm8sIGJ1dCB5b3UgbWlzc2Vk
IHRoZSBmYWN0IHRoYXQgIkFsbCByaWdodHMgcmVzZXJ2ZWQiIGlzIGFuIGV4cGxpY2l0DQo+IGxp
Y2Vuc2UgKG9yIHJhdGhlciwgYW4gZXhwbGljaXQgYW50aS1saWNlbnNlIHRoYXQgc3RhdGVzIHlv
dSBhcmUgbm90DQo+IGdyYW50aW5nIHJpZ2h0cyB0aGF0IHRoZSBHUEwgd291bGQgbm9ybWFsbHkg
Z3JhbnQpLCBhbmQgYW4gaW1wbGljaXQNCj4gbGljZW5zZSBkb2VzIG5vdCBhcHBseSB3aGVuIGFu
IGV4cGxpY2l0IChhbnRpLSlsaWNlbnNlIGlzIHByZXNlbnQuDQo+IA0KPiBXaGF0J3MgbW9yZSwg
cmVseWluZyBvbiBpbXBsaWNpdCBsaWNlbnNlcyBpcyBwcm9uZSB0byBtaXNpbnRlcnByZXRhdGlv
biwNCj4gc28gZXZlbiB0aG91Z2ggdGhlIG92ZXJhbGwgcHJvamVjdCBkb2N1bWVudGF0aW9uIHRy
aWVzIHRvIGNvdmVyIHdoYXQNCj4gd2lsbCBoYXBwZW4sIGl0J3MgbXVjaCBuaWNlciBpZiB5b3Ug
RE8gdXNlIGFuIGV4cGxpY2l0IGxpY2Vuc2UgbWVudGlvbg0KPiBpbiB5b3VyIGZpbGUgc28gdGhh
dCB3ZSBkb24ndCBIQVZFIHRvIHJlbHkgb24gdGhlIGltcGxpY2l0IGxpY2Vuc2UuDQo+IA0KPiBZ
ZXMsIHRoZSBwaHJhc2UgIkFsbCByaWdodHMgcmVzZXJ2ZWQiIGV4aXN0cyBpbiBzZXZlcmFsIGV4
aXN0aW5nIGZpbGVzOg0KPiANCj4gJCBnaXQgZ3JlcCAtaWwgJ2FsbCByaWdodHMgcmVzZXJ2ZWQn
IHx3Yw0KPiAgICAgIDEzOCAgICAgMTM4ICAgIDM1NTcNCj4gDQo+IGJ1dCB3ZSBzaG91bGQgYmUg
c3RyaXZpbmcgdG8gY2xlYW4gdGhvc2UgdXAsIG5vdCBhZGRpbmcgdG8gdGhlIG1lc3MuDQoNCk9r
LiBJJ2xsIHNlbmQgYSB2MiB3aXRoIHRoZSAiQWxsIHJpZ2h0cyByZXNlcnZlZCIgcmVtb3ZlZCBm
cm9tIGFuZCBhIEdQTCBzdGF0ZW1lbnQgYWRkZWQgdG8gYWxsIHRoZSBuZXcgZmlsZXMuDQoNCiAg
UGF1bA0KDQo+IA0KPiAtLQ0KPiBFcmljIEJsYWtlLCBQcmluY2lwYWwgU29mdHdhcmUgRW5naW5l
ZXINCj4gUmVkIEhhdCwgSW5jLiAgICAgICAgICAgKzEtOTE5LTMwMS0zMjY2DQo+IFZpcnR1YWxp
emF0aW9uOiAgcWVtdS5vcmcgfCBsaWJ2aXJ0Lm9yZw0K
