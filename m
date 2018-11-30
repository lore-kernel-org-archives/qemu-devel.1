Received: from eggs.gnu.org ([2001:4830:134:3::10]:44953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gSjAH-00043p-77
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:49:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gSjAG-0004W8-1H
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:49:04 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 30 Nov 2018 13:48:55 +0000
Message-ID: <73cb2885-3a40-6d2b-24fa-c528decdbc9b@virtuozzo.com>
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
	<20181129101801.6421-3-vsementsov@virtuozzo.com>
	<2f4c1bec-b5ca-e97f-88f9-75f3d2cb210c@redhat.com>
	<e9e07da0-0cd8-9820-642a-ab4fe227afc8@virtuozzo.com>
	<abcad6d9-2d40-15b4-9bce-964f6a3141a0@redhat.com>
In-Reply-To: <abcad6d9-2d40-15b4-9bce-964f6a3141a0@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C776D891BC89CF4A9635DC43BD38817C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: simple mirror test with
 kvm on 1G image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>

MzAuMTEuMjAxOCAxNjoxMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAzMC4xMS4xOCAxNDowNiwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDMwLjExLjIwMTggMTU6MzAs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAyOS4xMS4xOCAxMToxOCwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gVGhpcyB0ZXN0IGlzIGJyb2tlbiB3aXRob3V0IHBy
ZXZpb3VzIGNvbW1pdCBmaXhpbmcgZGVhZC1sb2NrIGluIG1pcnJvci4NCj4+Pj4NCj4+Pj4gU2ln
bmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeTx2c2VtZW50c292QHZpcnR1
b3p6by5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICB0ZXN0cy9xZW11LWlvdGVzdHMvMjM1ICAgICB8
IDU5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+ICAgIHRlc3Rz
L3FlbXUtaW90ZXN0cy8yMzUub3V0IHwgIDEgKw0KPj4+PiAgICB0ZXN0cy9xZW11LWlvdGVzdHMv
Z3JvdXAgICB8ICAxICsNCj4+Pj4gICAgMyBmaWxlcyBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCsp
DQo+Pj4+ICAgIGNyZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0cy9xZW11LWlvdGVzdHMvMjM1DQo+Pj4+
ICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xZW11LWlvdGVzdHMvMjM1Lm91dA0KPj4+IEkn
bGwgZ2V0IHRvIHRoZSBmaXJzdCBwYXRjaCBpbiBhIHNlY29uZCwgYnV0IGZpcnN0IGEgc3VnZ2Vz
dGlvbiBmb3IgdGhpcw0KPj4+IHBhdGNoOiBJIHRoaW5rIGl0J3Mgbm90IHNvIGdvb2QgdG8gdXNl
IDIgR0Igb2Ygc3BhY2UgZm9yIGEgdGVzdCAoMSBHQg0KPj4+IGZvciB0aGUgc291cmNlLCAxIEdC
IGZvciB0aGUgdGFyZ2V0KS4gIFNvIEkgdHJpZWQgbXkgbHVjayBhbmQgZm91bmQgdGhhdA0KPj4+
IHRoZSB0ZXN0IHdvcmtzLCB0b28sIGlmIHlvdSBqdXN0IHVzZSBwcmVhbGxvY2F0aW9uPW1ldGFk
YXRhIGZvciB0aGUNCj4+PiBzb3VyY2UgKGluc3RlYWQgb2YgYWN0dWFsbHkgd3JpdGluZyBkYXRh
KSBhbmQgYmxvY2tkZXYtbWlycm9yJ2luZyB0aGUNCj4+PiBkYXRhIHRvIGEgdGhyb3R0bGVkIG51
bGwtY28gZGV2aWNlLg0KPj4NCj4+IEhtbSwgc28gcGFyc2luZyBtZXRhZGF0YSBpcyBlbm91Z2gg
Zm9yIHFjb3cyIHRvIHlpZWxkIG9uIHdyaXRlLCB5ZXM/DQo+IA0KPiBBcHBhcmVudGx5IHNvLiAg
SWYgeW91IGNhbiBjb25maXJtIHRoYXQgYXBwbHlpbmcgdGhvc2UgY2hhbmdlcyB0byB0aGUNCj4g
dGVzdCBzdGlsbCBtYWtlIGl0IHdvcmsgKGkuZS4sIGZhaWwgYmVmb3JlIHBhdGNoIDEsIHBhc3Mg
YWZ0ZXJ3YXJkcyksDQo+IHRoZW4gSSB0aGluayBpdCBpcyBqdXN0IGFzIGdvb2QuDQoNCk9rLCBJ
J3ZlIGNoZWNrZWQgdGhhdCB5b3VyIGNoYW5nZXMgd29ya3MgZm9yIG1lLg0KDQpobSwgYnV0IHdl
IHdyaXRlIHRvIG51bGwsIHNvLCB5aWVsZCBvbiB3cml0ZSBjb21lcyBmcm9tIHRocm90dGxpbmcs
IGhvd2V2ZXIsDQp3aXRob3V0IHByZWFsbG9jYXRpb249bWV0YWRhdGEsIGl0IGRvbid0IHdvcmsu
LiwgZG8geW91IGtub3csIHdoeSB3ZSBuZWVkDQpwcmVhbGxvY2F0aW9uIHRvIHJlcHJvZHVjZT8N
Cg0KDQo+IA0KPiBbLi4uXQ0KPiANCj4+IGFueXdheSwgaXQncyBnb29kIHRoaW5nIHRvIGF2b2lk
IDJHIGFsbG9jYXRpb24gaW4gdGVzdCwgSSBhZ3JlZS4NCj4gDQo+IEFuZCBpZiBmb3Igc29tZSBy
ZWFzb24gdGhlIHRlc3QgbmVlZHMgdG8ga2VlcCBkb2luZyB0aGF0LCBJJ2QgcHJvcG9zZQ0KPiBh
ZGRpbmcgc29tZSBuZXcgdGVzdCBncm91cCBmb3IgdGVzdHMgdGhhdCBkbyB1c2Ugc3VjaCBhIGxh
cmdlIGFtb3VudCBvZg0KPiBkaXNrIHNwYWNlIHNvIGl0IGNhbiBiZSBleGNsdWRlZCBpZiBwZW9w
bGUgZG9uJ3Qgd2FudCB0aGF0IHRvIGhhcHBlbi4NCj4gDQo+IE1heA0KPiANCg0KDQotLSANCkJl
c3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
